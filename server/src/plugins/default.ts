import searchPlugin from "mongoosastic";
import idValidator from "mongoose-id-validator";
import { pagePlugin } from "./page";
import { Document, Schema } from "mongoose";
import { SearchableModel, Populate, Query } from "./types";
import { historyPlugin } from "./history";
import { query } from "express";

async function look(
  this: any,
  q: string,
  options: {
    query?: Query;
    populate?: Populate[];
    page?: number;
    limit?: number;
  } = {}
): Promise<Document[]> {
  const model = this as SearchableModel<Document>;

  const { page, limit } = options;
  return model
    .find({ ...query, ...{ $text: { $search: q } } })
    .skip(((page || 1) - 1) * (limit || 10))
    .limit(limit || 10);
}

function toJson(this: any): any {
  const object = (this as Document).toObject();

  return object;
}

function plugin(schema: Schema, options: { searchable?: boolean } = {}): void {
  schema.plugin(historyPlugin);
  schema.plugin(idValidator);
  schema.plugin(pagePlugin);

  const { searchable } = options;

  if (searchable) {
    schema.plugin(searchPlugin);
    schema.statics.look = look;
  }

  schema.methods.toJSON = toJson;

  // Index all text fields to allow easy search
  schema.index({ "$**": "text" });

  schema.add({
    _status: {
      type: String,
      default: "active",
      enum: ["active", "deleted"],
    },
  });
}

export const defaultPlugin = plugin;
