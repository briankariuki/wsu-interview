import { gql } from "apollo-server";

import { ApolloServerExpressConfig } from "apollo-server-express";

import resolvers from "../resolvers/index";

const typeDefs = gql`
  scalar JSON
  type Query {
    hello: String
  }
`;
const schema: ApolloServerExpressConfig = {
  typeDefs,
  resolvers,
  introspection: true,
  context: async ({ req, connection, payload }: any) => {},
  playground: true,
};

export default schema;
