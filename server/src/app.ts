import Promise from "bluebird";
import mongoose from "mongoose";
import config from "./config/config";
import Express from "./config/express";

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

// Initialize Express

const ExpressServer = new Express();

ExpressServer.init();

ExpressServer.httpServer.listen(config.port, () => {
  console.log(`🚀  Server ready at ${config.port}`);
  console.log(
    `🚀 Server ready at http://localhost:${config.port}${ExpressServer.server.graphqlPath}`
  );
  console.log(
    `🚀 Subscriptions ready at ws://localhost:${config.port}${ExpressServer.server.subscriptionsPath}`
  );
});
