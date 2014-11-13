should = require('clay-chai').should()

ExampleService = require 'services/example'

describe 'ExampleService', ->
  it 'doSomething() returns something', ->
    ExampleService.doSomething().should.be 'something'
