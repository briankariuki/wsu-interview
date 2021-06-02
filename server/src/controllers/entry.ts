import {
  BaseHttpController,
  controller,
  httpPost,
  httpPut,
  httpGet,
  httpDelete,
} from "inversify-express-utils";
import { inject } from "inversify";
import { celebrate, Joi } from "celebrate";
import { EntryService } from "../services/entry";
import { Query, QueryParams } from "../plugins/types";
import { Auth0Middleware } from "../middleware/auth";

@controller("/v1/entry")
export class EntryController extends BaseHttpController {
  @inject(EntryService)
  private entryService: EntryService;

  @httpPost(
    "/",
    Auth0Middleware,
    celebrate({
      body: Joi.object({
        county: Joi.string().required(),
        subcounty: Joi.string().required(),
        animals: Joi.any(),
        animalsAffected: Joi.number().required(),
        animalsDead: Joi.number().required(),
        animalSymptopms: Joi.string().required(),
        peopleAffected: Joi.number().required(),
        peopleDead: Joi.number().required(),
        humanSymptopms: Joi.string().required(),
        exposed: Joi.any(),
      }),
    })
  )
  async create(): Promise<void> {
    const {
      request: {
        body: {
          county,
          subcounty,
          animals,
          animalsAffected,
          animalsDead,
          animalSymptomps,
          peopleAffected,
          peopleDead,
          humanSymptomps,
          exposed,
        },
      },
      user: { details: user },
    } = this.httpContext;

    const entry = await this.entryService.create({
      user,
      county,
      subcounty,
      animals,
      animalsAffected,
      animalsDead,
      animalSymptomps,
      peopleAffected,
      peopleDead,
      humanSymptomps,
      exposed,
    });

    this.httpContext.response.json({ entry });
  }

  @httpPut(
    "/",
    Auth0Middleware,
    celebrate({
      body: Joi.object({
        entryId: Joi.string().required(),
        county: Joi.string(),
        subcounty: Joi.string(),
        animals: Joi.any(),
        animalsAffected: Joi.number(),
        animalsDead: Joi.number(),
        animalSymptopms: Joi.string(),
        peopleAffected: Joi.number(),
        peopleDead: Joi.number(),
        humanSymptopms: Joi.string(),
        exposed: Joi.any(),
        _status: Joi.string(),
      }),
    })
  )
  async update(): Promise<void> {
    const {
      entryId,
      _status,
      county,
      subcounty,
      animals,
      animalsAffected,
      animalsDead,
      animalSymptomps,
      peopleAffected,
      peopleDead,
      humanSymptomps,
      exposed,
    } = this.httpContext.request.body;

    const entry = await this.entryService.update(entryId, {
      county,
      subcounty,
      animals,
      animalsAffected,
      animalsDead,
      animalSymptomps,
      peopleAffected,
      peopleDead,
      humanSymptomps,
      exposed,
      _status,
    });

    this.httpContext.response.json({ entry });
  }

  @httpGet(
    "/",
    celebrate({
      query: Joi.object({
        entryId: Joi.string(),
        q: Joi.string(),
        userId: Joi.string(),
        sort: Joi.string(),
        page: Joi.number(),
        key: Joi.string(),
        limit: Joi.number(),
        _status: Joi.string(),
      }),
    })
  )
  async retrieve(): Promise<void> {
    const { entryId } = this.httpContext.request.query as {
      entryId: string;
    };

    // const { details: activeUserId } = this.httpContext.user;

    if (entryId) {
      const entry = (await this.entryService.findById(entryId)).toObject();

      this.httpContext.response.json({ entry });

      return;
    }

    const {
      sort,
      page,
      limit,
      q,
      _status,
      userId: user,
      key,
    } = this.httpContext.request.query as unknown as QueryParams & {
      userId: string;
    };

    let query: Query = {};

    if (_status) query = { ...query, ...{ _status } };

    if (parent) {
      query = { ...query, ...{ parent } };
    } else query = { ...query, ...{ parent: { $exists: false } } };

    if (user) query = { ...query, ...{ user } };

    const entryPage = await this.entryService.page(query, {
      q,
      sort,
      page,
      limit,
      key,
      populate: [{ path: "user" }],
    });

    this.httpContext.response.json({ entryPage });
  }

  @httpDelete(
    "/",
    Auth0Middleware,
    celebrate({
      query: Joi.object({
        entryId: Joi.string(),
      }),
    })
  )
  async remove(): Promise<void> {
    const { entryId } = this.httpContext.request.query as {
      entryId: string;
    };

    const entry = await this.entryService.delete(entryId);

    this.httpContext.response.json({ entry });
  }
}
