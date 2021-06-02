import { injectable, inject } from "inversify";
import { pickBy } from "lodash";
import {
  PageOptions,
  PageResult,
  Query,
  DefaultDocument,
} from "../plugins/types";
import { Entry, EntryModel, EntryDocument } from "../models/entry";
import { EntryEventEmitter } from "../events/entry";

@injectable()
export class EntryService {
  @inject(EntryEventEmitter)
  private entryEventEmitter: EntryEventEmitter;

  async create(data: {
    user: string;
    county: Entry["county"];
    subcounty: Entry["subcounty"];
    animals: Entry["animals"];
    animalsAffected: Entry["animalsAffected"];
    animalsDead: Entry["animalsDead"];
    animalSymptomps: Entry["animalSymptomps"];
    peopleAffected: Entry["peopleAffected"];
    peopleDead: Entry["peopleDead"];
    humanSymptomps: Entry["humanSymptomps"];
    exposed: Entry["exposed"];
  }): Promise<Entry> {
    const entry = await new EntryModel(pickBy(data)).save();

    this.entryEventEmitter.emit("entry-created", entry);

    await entry.populate([{ path: "user" }]).execPopulate();

    return entry;
  }

  async update(
    entryId: string,
    data: {
      county?: Entry["county"];
      subcounty?: Entry["subcounty"];
      animals?: Entry["animals"];
      animalsAffected?: Entry["animalsAffected"];
      animalsDead?: Entry["animalsDead"];
      animalSymptomps?: Entry["animalSymptomps"];
      peopleAffected?: Entry["peopleAffected"];
      peopleDead?: Entry["peopleDead"];
      humanSymptomps?: Entry["humanSymptomps"];
      exposed?: Entry["exposed"];
      _status?: DefaultDocument["_status"];
    }
  ): Promise<Entry> {
    const entry = await EntryModel.findByIdAndUpdate(
      entryId,
      { $set: pickBy(data) },
      { new: true, runValidators: true }
    );

    if (!entry) throw new Error("Entry not found");

    this.entryEventEmitter.emit("entry-updated", entry);

    await entry.populate([{ path: "user" }]).execPopulate();

    return entry;
  }

  async findById(entryId: string): Promise<EntryDocument> {
    const entry = await EntryModel.findById(entryId);

    if (!entry) throw new Error("Entry not found");

    this.entryEventEmitter.emit("entry-fetched", entry);

    await entry.populate([{ path: "user" }]).execPopulate();

    return entry;
  }

  async delete(entryId: string): Promise<Entry> {
    const entry = await EntryModel.findByIdAndUpdate(
      entryId,
      { $set: { _status: "deleted" } },
      { new: true, runValidators: true }
    );

    if (!entry) throw new Error("Entry not found");

    this.entryEventEmitter.emit("entry-deleted", entry);

    await entry.populate([{ path: "user" }]).execPopulate();

    return entry;
  }

  async page(
    query: Query,
    pageOptions: PageOptions
  ): Promise<PageResult<EntryDocument>> {
    let pageResult: PageResult<EntryDocument>;

    const { q, page, limit } = pageOptions;

    if (q) {
      const docs = await EntryModel.look(q, {
        query,
        populate: [{ path: "user" }],
        page,
        limit,
      });

      for (const doc of docs) {
        await doc.populate([{ path: "user" }]).execPopulate();
      }

      pageResult = {
        docs,
        limit: docs.length,
        total: docs.length,
        sort: q,
        page: 1,
        pages: 1,
      };
    } else {
      pageResult = await EntryModel.page(pickBy(query), pageOptions);
    }

    return pageResult;
  }
}
