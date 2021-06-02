import { UserService } from "../services/user";
import { inject } from "inversify";
import { celebrate, Joi } from "celebrate";
import {
  httpPut,
  controller,
  BaseHttpController,
  httpGet,
  httpDelete,
} from "inversify-express-utils";
import { NAME_REGEX } from "../utils/regex";
import { Query } from "../plugins/types";
import { Auth0Middleware } from "../middleware/auth";
import { FirebaseService } from "../services/firebase";
import { Types } from "mongoose";

@controller("/v1/user")
export class UserController extends BaseHttpController {
  @inject(UserService)
  private userService: UserService;

  @inject(FirebaseService)
  private firebaseService: FirebaseService;

  @httpPut(
    "/:userId",
    Auth0Middleware,

    celebrate({
      body: Joi.object({
        displayName: Joi.string().regex(NAME_REGEX),
        _status: Joi.string(),
      }),
    })
  )
  async update(): Promise<void> {
    const {
      request: {
        body: { displayName, _status },
        params: { userId },
      },
      response,
    } = this.httpContext;

    const { uid } = await this.userService.findById(userId);

    const { email, photoURL } = await this.firebaseService.getUser(uid);

    const user = await this.userService.update(userId, {
      displayName,
      _status,
      email,
      photoURL,
    });

    response.json({ user });
  }

  @httpGet(
    "/",
    celebrate({
      query: Joi.object({
        userId: Joi.string(),
        q: Joi.string().allow(""),
        sort: Joi.string(),
        role: Joi.string(),
        _status: Joi.string(),
        page: Joi.number(),
        limit: Joi.number(),
      }),
    })
  )
  async retrieve(): Promise<void> {
    const { userId, sort, page, limit, q, role, _status } = this.httpContext
      .request.query as any;

    // const { details: activeUserId } = this.httpContext.user;

    if (userId) {
      let query: {
        $or?: ({ username: string } | { _id: string })[];
        username?: string;
      } = {};

      if (Types.ObjectId.isValid(userId))
        query = {
          ...query,
          ...{ $or: [{ username: userId }, { _id: userId }] },
        };
      else query = { ...query, ...{ username: userId } };

      const user: any = (await this.userService.findOne(query)).toObject();

      this.httpContext.response.json({ user });

      return;
    }

    let query: Query = {};

    if (role) query = { ...query, ...{ role } };

    if (_status) query = { ...query, ...{ _status } };

    const userPage = await this.userService.page(query, {
      sort,
      page,
      limit,
      q,
      populate: [],
    });

    this.httpContext.response.json({ userPage });
  }

  @httpDelete(
    "/",
    Auth0Middleware,
    celebrate({
      query: Joi.object({
        userId: Joi.string().required(),
      }),
    })
  )
  async remove(): Promise<void> {
    const { userId } = this.httpContext.request.query as any;

    const user = await this.userService.delete(userId);

    this.httpContext.response.json({ user });
  }
}
