import { EventEmitter } from "events";
import { injectable } from "inversify";
import { User, UserDocument } from "../models/user";
import { logger } from "../config/logger";

type UserEvent =
  | "user-created"
  | "user-deleted"
  | "user-updated"
  | "user-fetched";

export interface UserEventEmitter {
  on(event: UserEvent, listener: (user: UserDocument) => void): this;
  emit(event: UserEvent, user: User): boolean;
}

@injectable()
export class UserEventEmitter extends EventEmitter {
  constructor() {
    super();

    this.on("user-created", async (user) => {
      logger.info("user-register %o", user._id);

      try {
        await user.addFields();
      } catch (error) {
        logger.error("user-fetched %o", (error as Error).message);
      }
    });

    this.on("user-deleted", (user) => {
      logger.info("user-delete %o", user._id);
    });

    this.on("user-updated", async (user) => {
      logger.info("user-update %o", user._id);

      try {
        await user.addFields();
      } catch (error) {
        logger.error("user-updated %o", (error as Error).message);
      }
    });

    this.on("user-fetched", async (user) => {
      logger.info("user-fetched %o", user._id);

      try {
        await user.addFields();
      } catch (error) {
        logger.error("user-fetched %o", (error as Error).message);
      }
    });
  }
}
