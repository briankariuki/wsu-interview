import { injectable } from "inversify";
import { credential, initializeApp, apps } from "firebase-admin";
import { logger } from "../config/logger";

@injectable()
export class FirebaseService {
  private admin =
    apps.length == 0
      ? initializeApp({
          credential: credential.applicationDefault(),
          databaseURL: "https://wsu-interview-default-rtdb.firebaseio.com/",
        })
      : apps[0];

  async getUid(token: string): Promise<string> {
    const decodedIdToken = await this.admin.auth().verifyIdToken(token);

    return decodedIdToken.uid;
  }

  async getUser(
    uid: string
  ): Promise<{ displayName: string; email: string; photoURL: string }> {
    const response = await this.admin.auth().getUser(uid);

    logger.info("firebase-getUser-response : %o", response);

    const { displayName, email, photoURL } = response;

    return { displayName, email, photoURL };
  }
}
