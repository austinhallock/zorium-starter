_ = require 'lodash'
z = require 'zorium'
log = require 'clay-loglevel'
Q = require 'q'
require 'matchMedia'

config = require './config'
HomePage = require './pages/home'

###########
# LOGGING #
###########

reportError = ->
  # Remove the circular dependency within error objects
  args = _.map arguments, (arg) ->
    if arg instanceof Error
    then arg.stack
    else if arg instanceof ErrorEvent
    then arg.error.stack
    else arg

  Q z.request
    method: 'POST'
    url: config.API_PATH + '/log'
    data:
      message: args.join ' '
    background: true
  .catch (err) ->
    console?.error err

window.addEventListener 'error', reportError
window.addEventListener 'fb-flo-reload', z.redraw

if config.ENV isnt config.ENVS.PROD
  log.enableAll()
else
  log.setLevel 'error'
  log.on 'error', reportError
  log.on 'trace', reportError

###########
# ROUTING #
###########

z.route.mode = 'pathname'

route = (routes) ->
  _.transform routes, (result, Component, route) ->
    result[route] =
      controller: => @component = new Component(z.route.param)
      view: => @component.render()

z.route document.getElementById('app'), '/', route(
  '/': HomePage
)

log.info 'App Ready'
