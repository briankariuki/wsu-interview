import { UserService } from "../services/user";
import { UserEventEmitter } from "../events/user";
import { Container } from "inversify";
import { RequestEventEmitter } from "../events/request";
import { RequestService } from "../services/request";
import { Auth0Middleware } from "../middleware/auth";
import { AppEventEmitter } from "../events/app";
import { AppService } from "../services/app";
import { FirebaseService } from "../services/firebase";
import { EntryEventEmitter } from "../events/entry";
import { EntryService } from "../services/entry";

export function getContainer(): Container {
  const container = new Container({ skipBaseClassChecks: true });

  container.bind<Auth0Middleware>(Auth0Middleware).to(Auth0Middleware);

  container.bind<FirebaseService>(FirebaseService).to(FirebaseService);

  container.bind<AppEventEmitter>(AppEventEmitter).to(AppEventEmitter);
  container.bind<AppService>(AppService).to(AppService);

  container.bind<UserEventEmitter>(UserEventEmitter).to(UserEventEmitter);
  container.bind<UserService>(UserService).to(UserService);

  container.bind<EntryEventEmitter>(EntryEventEmitter).to(EntryEventEmitter);
  container.bind<EntryService>(EntryService).to(EntryService);

  container
    .bind<RequestEventEmitter>(RequestEventEmitter)
    .to(RequestEventEmitter);
  container.bind<RequestService>(RequestService).to(RequestService);

  return container;
}
