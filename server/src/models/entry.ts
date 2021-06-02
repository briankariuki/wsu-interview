import { Schema, model } from "mongoose";
import { PagedModel, SearchableModel, DefaultDocument } from "../plugins/types";
import { defaultPlugin } from "../plugins/default";

export type Entry = {
  user: string;
  county: string;
  subcounty: string;
  animals: string[];
  animalsAffected: number;
  animalsDead: number;
  animalSymptomps: string;
  peopleAffected: number;
  peopleDead: number;
  humanSymptomps: string;
  exposed: string[];
};

export type EntryDocument = DefaultDocument &
  Entry & {
    addFields(): Promise<void>;
  };

const entrySchema = new Schema(
  {
    user: { type: Schema.Types.ObjectId, required: true, ref: "User" },
    title: {
      type: String,
    },
    county: {
      type: String,
      required: true,
    },
    subcounty: {
      type: String,
      required: true,
    },
    animals: {
      type: [String],
      required: true,
    },
    animalsAffected: {
      type: Number,
      default: 0,
    },
    animalsDead: {
      type: Number,
      default: 0,
    },
    animalSymptomps: {
      type: String,
      required: true,
    },
    peopleAffected: {
      type: Number,
      default: 0,
    },
    peopleDead: {
      type: Number,
      default: 0,
    },
    humanSymptomps: {
      type: String,
      required: true,
    },
    exposed: {
      type: [String],
      required: true,
    },
  },
  { timestamps: true }
);

entrySchema.plugin(defaultPlugin, { searchable: true });

async function addFields(): Promise<void> {
  //   const doc = this as EntryDocument;
  //   const { _id } = doc;
  //   await doc.save();
}

entrySchema.methods = { ...entrySchema.methods, ...{ addFields } };

export const EntryModel = model<
  EntryDocument,
  PagedModel<EntryDocument> & SearchableModel<EntryDocument>
>("Entry", entrySchema);
