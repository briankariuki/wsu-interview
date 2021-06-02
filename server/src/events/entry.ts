import { EventEmitter } from "events";
import { injectable } from "inversify";
import { logger } from "../config/logger";
import { EntryDocument } from "../models/entry";
import { UserModel } from "../models/user";

type EntryEvent =
  | "entry-created"
  | "entry-updated"
  | "entry-fetched"
  | "entry-deleted";

export interface EntryEventEmitter {
  on(event: EntryEvent, listener: (entry: EntryDocument) => void): this;
  emit(event: EntryEvent, entry: EntryDocument): boolean;
}

@injectable()
export class EntryEventEmitter extends EventEmitter {
  constructor() {
    super();

    this.on("entry-created", async (entry) => {
      try {
        logger.info("entry-created %o", entry._id);
        await entry.addFields();

        await (
          await UserModel.findById(entry.populated("user") || entry.user)
        ).addFields();
      } catch (error) {
        logger.error("entry-created %o", (error as Error).message);
      }
    });

    this.on("entry-updated", async (entry) => {
      try {
        logger.info("entry-updated %o", entry._id);
        await entry.addFields();

        await (
          await UserModel.findById(entry.populated("user") || entry.user)
        ).addFields();
      } catch (error) {
        logger.error("entry-updated %o", (error as Error).message);
      }
    });

    this.on("entry-fetched", async (entry) => {
      try {
        logger.info("entry-fetched %o", entry._id);
        await entry.addFields();

        await (
          await UserModel.findById(entry.populated("user") || entry.user)
        ).addFields();
      } catch (error) {
        logger.error("entry-fetched %o", (error as Error).message);
      }
    });

    this.on("entry-deleted", async (entry) => {
      try {
        logger.info("entry-deleted %o", entry._id);

        await (
          await UserModel.findById(entry.populated("user") || entry.user)
        ).addFields();
      } catch (error) {
        logger.error("entry-deleted %o", (error as Error).message);
      }
    });
  }
}
