module.exports =
  HOST: process.env.HOST or 'clay.io'
  WEBPACK_DEV_HOSTNAME: process.env.WEBPACK_DEV_HOSTNAME or 'localhost'
  MOCK: process.env.MOCK or false
  ENV: process.env.NODE_ENV or 'production'
  ENVS:
    DEV: 'development'
    PROD: 'production'
    TEST: 'test'
