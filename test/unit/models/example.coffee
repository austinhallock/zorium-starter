should = require('clay-chai').should()

Example = require 'models/example'

describe 'ExampleModel', ->
  it 'getSomething() should return something', ->
    Example.setSomething 'something'
    Example.getSomething.should.be 'something'
