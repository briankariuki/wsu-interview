import { Schema, model } from "mongoose";
import { defaultPlugin } from "../plugins/default";
import { PagedModel, SearchableModel, DefaultDocument } from "../plugins/types";

export type Role = "default" | "admin" | "support";

export type User = {
  uid: string;
  email: string;
  displayName: string;
  posts: number;
  suggestions?: string[];
};

export type UserDocument = DefaultDocument &
  User & {
    addFields(): Promise<void>;
  };

const userSchema = new Schema(
  {
    uid: {
      type: String,
      required: true,
      unique: true,
    },
    email: {
      type: String,
      required: true,
      unique: true,
      lowercase: true,
      trim: true,
      es_indexed: true,
    },
    displayName: {
      type: String,
      required: true,
      es_indexed: true,
    },

    suggestions: {
      type: [String],
      es_indexed: true,
      es_type: "completion",
    },
    role: {
      type: String,
      default: "default",
      enum: ["default", "admin", "support"],
    },
    posts: {
      type: Number,
      default: 0,
    },
  },
  { timestamps: true }
);

userSchema.plugin(defaultPlugin, { searchable: true });

async function addFields(this: any): Promise<void> {
  const doc = this as UserDocument;

  const { _id } = doc;

  //   doc.posts = await PostModel.countDocuments({ user: _id, parent: { $exists: false } });

  doc.suggestions = `${doc.displayName}`.trim().split(" ");

  await doc.save();
}

userSchema.methods.addFields = addFields;

export const UserModel = model<
  UserDocument,
  PagedModel<UserDocument> & SearchableModel<UserDocument>
>("User", userSchema);
