express = require 'express'
dust = require 'dustjs-linkedin'
fs = require 'fs'
request = require 'request'
url = require 'url'
_ = require 'lodash'
Promise = require 'bluebird'
useragent = require 'express-useragent'
compress = require 'compression'
log = require 'loglevel'
cookieParser = require 'cookie-parser'

config = require './src/config'

API_REQUEST_TIMEOUT = 1000 # 1 second

router = express.Router()
log.enableAll()

# Dust templates
# Don't compact whitespace, because it breaks the javascript partial
dust.optimizers.format = (ctx, node) -> node

indexTpl = dust.compile fs.readFileSync('index.dust', 'utf-8'), 'index'


distJs = if config.ENV is config.ENVS.PROD \
          then fs.readFileSync('dist/js/bundle.js', 'utf-8')
          else null
distCss = if config.ENV is config.ENVS.PROD \
          then fs.readFileSync('dist/css/bundle.css', 'utf-8')
          else null

dust.loadSource indexTpl

app = express()

app.use compress()
if config.ENV is config.ENVS.PROD
then app.use express['static'](__dirname + '/dist')
else app.use express['static'](__dirname + '/build')

# After checking static files
app.use cookieParser()
app.use useragent.express()
app.use router


# Development
unless config.ENV is config.ENVS.PROD
  # fb-flo - for live reload
  flo = require('fb-flo')
  fs = require('fs')

  flo 'build',
    port: 8888
    host: 'localhost'
    verbose: false
    glob: [
      'js/bundle.js'
      'css/bundle.css'
    ]
  , (filepath, callback) ->
    callback
      resourceURL: filepath
      contents: fs.readFileSync('build/' + filepath, 'utf-8').toString()

router.get '*', (req, res) ->
  renderHomePage()
  .then (html) ->
    res.send html
  .catch (err) ->
    log.trace err
    res.status(500).send()

# Cache rendering
renderHomePage = do ->
  page =
    inlineSource: config.ENV is config.ENVS.PROD
    webpackDevHostname: config.WEBPACK_DEV_HOSTNAME
    title: 'Free Games'
    description: 'Play mobile games on your phone for free.
                  We bring you the best mobile web games.'
    keywords: 'mobile games, phone games, free mobile games, mobile web games'
    name: 'Clay.io'
    icon256: '//cdn.wtf/d/images/icons/icon_256.png'
    icon76: '//cdn.wtf/d/images/icons/icon_76.png'
    icon120: '//cdn.wtf/d/images/icons/icon_120.png'
    icon152: '//cdn.wtf/d/images/icons/icon_152.png'
    icon440x280: '//cdn.wtf/d/images/icons/icon_440_280.png'
    iconKik: '//cdn.wtf/d/images/icons/icon_256_orange.png'
    url: 'http://clay.io/'
    canonical: 'http://clay.io'
    me: 'REPLACE_WITH_ME'
    experiments: 'REPLACE_WITH_EXPERIMENTS'
    distjs: distJs
    distcss: distCss

  rendered = Promise.promisify(dust.render, dust) 'index', page

  -> rendered

module.exports = app
