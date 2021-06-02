import { Request } from "express";
import { injectable, inject } from "inversify";
import { RequestEventEmitter } from "../events/request";
import { UserDocument } from "../models/user";

@injectable()
export class RequestService {
  @inject(RequestEventEmitter)
  private requestEventEmitter: RequestEventEmitter;

  async create(data: { user?: UserDocument; request: Request }): Promise<void> {
    this.requestEventEmitter.emit("request-created", data);
  }
}
