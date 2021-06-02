import { Schema, model } from "mongoose";
import { PagedModel, SearchableModel, DefaultDocument } from "../plugins/types";
import { defaultPlugin } from "../plugins/default";

export type App = {
  user?: string;
  key: string;
  id: string;
  version: string;
  token?: string;
};

export type AppDocument = DefaultDocument & App;

const appSchema = new Schema(
  {
    user: {
      type: Schema.Types.ObjectId,
      ref: "User",
    },
    key: {
      type: String,
      required: true,
    },
    id: {
      type: String,
      required: true,
    },
    version: {
      type: String,
      required: true,
    },
    token: {
      type: String,
      required: true,
      unique: true,
    },
  },
  { timestamps: true }
);

appSchema.plugin(defaultPlugin);

export const AppModel = model<
  AppDocument,
  PagedModel<AppDocument> & SearchableModel<AppDocument>
>("App", appSchema);
