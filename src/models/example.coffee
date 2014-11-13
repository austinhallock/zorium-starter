class Example
  constructor: ->
    @something = null

  setSomething: (@something) -> null

  getSomething: ->
    return @something

module.exports = new Example()
