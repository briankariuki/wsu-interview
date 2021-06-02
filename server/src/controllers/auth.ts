import {
  BaseHttpController,
  controller,
  httpPost,
  httpGet,
} from "inversify-express-utils";
import { inject } from "inversify";
import { celebrate, Joi } from "celebrate";
import { UserService } from "../services/user";
import { FirebaseService } from "../services/firebase";
import { NAME_REGEX } from "../utils/regex";
import { UserDocument } from "../models/user";

@controller("/v1/auth")
export class AuthController extends BaseHttpController {
  @inject(UserService)
  private userService: UserService;

  @inject(FirebaseService)
  private firebase: FirebaseService;

  @httpGet(
    "/",
    celebrate({
      body: Joi.object().empty(),
      query: Joi.object().empty(),
    })
  )
  async auth(): Promise<void> {
    const {
      response,
      user: { details: id, isAuthenticated },
    } = this.httpContext;

    let user: UserDocument;

    if (await isAuthenticated()) {
      user = await this.userService.findById(id);
    } else {
      user = await this.userService.findOne({ uid: id });

      if (user._status != "active")
        throw new Error("You have been blocked from Agizo. Contact support");
    }

    response.json({ user });
  }

  @httpPost(
    "/register",
    celebrate({
      body: Joi.object({
        displayName: Joi.string().regex(NAME_REGEX).required(),
      }),
    })
  )
  async register(): Promise<void> {
    const {
      response,
      request: {
        body: { displayName },
      },
      user: { details: uid, isAuthenticated },
    } = this.httpContext;

    if (await isAuthenticated()) throw new Error("User registered. Log in");

    try {
      await this.userService.findOne({ uid });

      throw new Error("User registered. Log in");
    } catch (error) {}

    const { email, photoURL } = await this.firebase.getUser(uid);

    const user = await this.userService.create({
      uid,
      email,
      displayName,
      photoURL,
    });

    response.json({ user });
  }
}
