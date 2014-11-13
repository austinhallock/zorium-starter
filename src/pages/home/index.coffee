z = require 'zorium'

Example = require '../../components/example'
AnotherExample = require '../../components/another_example'

module.exports = class HomePage
  constructor: (params) ->
    @Example = new Example()
    @AnotherExample = new AnotherExample()

  render: =>
    z 'div',
      z 'div', @Example.render()
      z 'div', @AnotherExample.render()
