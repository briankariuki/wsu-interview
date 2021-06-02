import cors from "cors";
import helmet from "helmet";
import morgan from "morgan";
import config from "./config";

import { Application, Request, Response, NextFunction } from "express";
import { ErrorObject, serializeError } from "serialize-error";
import { isCelebrateError } from "celebrate";

export function configExpress(app: Application): void {
  app.use(cors());
  app.use(morgan("combined"));
  app.use(
    helmet({
      contentSecurityPolicy: false,
    })
  );

  app.get("/", (req, res) => {
    res.send("Yay! Sending links");
  });
  app.get("/test", (req, res) => {
    res.send("Yay! Test succeeded. Not nginx");
  });
}

export function configExpressNotFoundError(app: Application): void {
  app.use((req, res, next) => {
    const error: DefaultError = new Error("URL not found");

    error.code = "404";
    error.status = 404;

    next(error);
  });
}

export function configExpressError(app: Application): void {
  app.use(
    (error: DefaultError, req: Request, res: Response, next: NextFunction) => {
      const { name, stack, status, code, message } = error;

      const serializedError: ErrorObject & {
        status?: number;
      } = serializeError({ name, stack, status, code, message });

      serializedError.code = serializedError.code || "500";

      delete serializedError.status;

      if (isCelebrateError(error))
        serializedError.message = error.details
          .entries()
          .next().value[1].details[0].message;

      if (config.NODE_ENV !== "development") delete serializedError.stack;

      res.status(error.status || 500).json({ error: serializedError });

      next();
    }
  );
}
