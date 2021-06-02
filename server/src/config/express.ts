import { ApolloServer } from "apollo-server-express";
import cors from "cors";
import express from "express";
import helmet from "helmet";
import * as http from "http";
import morgan from "morgan";
import schema from "../graphql/schema";

class Express {
  public express: express.Application;
  public server: ApolloServer = new ApolloServer(schema);
  public httpServer: http.Server;

  public init = (): void => {
    this.express = express();

    this.express.use(cors());
    this.express.use(morgan("combined"));
    this.express.use(
      helmet({
        contentSecurityPolicy: false,
      })
    );

    this.express.get("/", (req, res) => {
      res.send("Yay! Sending links");
    });
    this.express.get("/test", (req, res) => {
      res.send("Yay! Test succeeded. Not nginx");
    });

    this.server.applyMiddleware({ app: this.express });
    this.httpServer = http.createServer(this.express);

    this.server.installSubscriptionHandlers(this.httpServer);
  };
}

export default Express;
