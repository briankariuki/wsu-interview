import "reflect-metadata";
import "./controllers";
import Promise from "bluebird";

import { getRouteInfo, InversifyExpressServer } from "inversify-express-utils";
import mongoose from "mongoose";
import config from "./config/config";
import {
  configExpress,
  configExpressError,
  configExpressNotFoundError,
} from "./config/express";
import { getContainer } from "./config/inversify";
import { logger } from "./config/logger";
import http from "http";
import { render } from "prettyjson";
import { AddressInfo } from "net";
import { AuthProvider } from "./providers/auth";

process.on("uncaughtException", (error: Error) => {
  logger.error("UNCAUGHT_EXCEPTION: %o", error);

  process.exit(1);
});

process.on("unhandledRejection", (reason: any, promise: Promise<any>) => {
  logger.error("UNHANDLED_REJECTION: Reason: %o", reason);
  logger.error("UNHANDLED_REJECTION: Promise: %o", promise);
});

Promise.promisifyAll(mongoose);

mongoose.connect(config.mongoURI, {
  bufferMaxEntries: 0,
  keepAlive: true,
  socketTimeoutMS: 0,
  useNewUrlParser: true,
  useUnifiedTopology: true,
  useCreateIndex: true,
});

const connection = mongoose.connection;

// Console log when connection has error
connection.on("error", () => {
  throw new Error(`unable to connect to database: ${config.mongoURI}`);
});

// Console log when connection is active
connection.once("open", () => {
  console.log("MongoDB database connection established successfully");
});

const container = getContainer();

const app = new InversifyExpressServer(
  container,
  null,
  null,
  null,
  AuthProvider
)
  .setConfig(configExpress)
  .build();

configExpressNotFoundError(app);

configExpressError(app);

logger.info("DI_LOADED");

logger.info("ROUTES_LOADED");

logger.debug(render(getRouteInfo(container)));

logger.info("APP_LOADED");

const server = http.createServer(app);

server.on("error", (error) => {
  logger.error("SERVER_ERROR: %o", error);

  throw error;
});

server.listen(config.port, () => {
  logger.info(
    "🚀  Server ready at Port: %o",
    (server.address() as AddressInfo).port
  );
});
