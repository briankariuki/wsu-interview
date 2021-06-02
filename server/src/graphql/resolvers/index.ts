import GraphQLJSON from "graphql-type-json";

// import Twitter from "../../controllers/twitter";

// const instaResolver = new Instagram();
// const twitterResolver = new Twitter();

const rootResolver = {
  Query: {
    hello: () => "Hello world!",
  },

  JSON: GraphQLJSON,
};

export default rootResolver;
