import { EventEmitter } from "events";
import { inject, injectable } from "inversify";
import { logger } from "../config/logger";
import { UserDocument } from "../models/user";
import { Request } from "express";
import { App } from "../models/app";
import { AppService } from "../services/app";

type RequestEvent = "request-created";

export interface RequestEventEmitter {
  on(
    event: RequestEvent,
    listener: (data: { user?: UserDocument; request: Request }) => void
  ): this;
  emit(
    event: RequestEvent,
    data: { user?: UserDocument; request: Request }
  ): boolean;
}

@injectable()
export class RequestEventEmitter extends EventEmitter {
  @inject(AppService)
  appService: AppService;

  constructor() {
    super();

    this.on("request-created", async (data) => {
      try {
        logger.info("request-created");

        const { user, request } = data;

        const app: App = {
          user: user ? user._id : undefined,
          key: request.get("app-key"),
          id: request.get("app-id"),
          version: request.get("app-version"),
          token: request.get("app-token"),
        };

        await this.appService.create(app);
      } catch (error) {
        logger.error("request-created %o", (error as Error).message);
      }
    });
  }
}
