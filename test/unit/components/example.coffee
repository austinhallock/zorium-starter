_ = require 'lodash-contrib'
should = require('clay-chai').should()

Example = require 'components/example'

domWalker = _.walk ($node) ->
  return $node.children

hasClass = ($node, className) ->
  _.contains $node.attrs.className.split(' '), className

describe 'Example', ->
  it 'renders .some-class', ->
    ExampleComponent = new Example()
    $ = ExampleComponent.render()

    $someClassDiv = domWalker.find $, ($node) ->
      return hasClass $node, 'example-some-class'

    $someClassDiv.should.exist
