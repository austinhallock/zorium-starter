z = require 'zorium'

styles = require './index.styl'

module.exports = class Example
  constructor: ->
    styles.use()

  render: ->
    z 'div.one-more-example', "Hi, I'm one more example"
