require("dotenv").config();

const config = {
  port: process.env.PORT || 8086,

  mongoURI: `mongodb+srv://user:${process.env.DB_CONNECT_PASSWORD}@cluster0.hbiaw.mongodb.net/apiData?retryWrites=true&w=majority`,
  // mongoURI: `mongodb+srv://fplstationapi:${process.env.DB_CONNECT_PASSWORD}@fplapidata.bxzo3.mongodb.net/apiData?retryWrites=true&w=majority`,

  authentication: {
    jwtSecret: process.env.JWT_SECRET || "awesomeApp",
    apiKey: process.env.API_KEY || "apiKey",
    sessionId: process.env.SESSION_ID,
    csrfToken: process.env.CSRF_TOKEN,
    userId: process.env.USER_ID,
  },
  LOG_LEVEL: process.env.LOG_LEVEL,
  NODE_ENV: process.env.NODE_ENV,
};

export default config;
