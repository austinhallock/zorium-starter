z = require 'zorium'

styles = require './index.styl'

module.exports = class AnotherExample
  constructor: ->
    styles.use()

  render: ->
    z 'div.another-example', "Hi, I'm another example"
