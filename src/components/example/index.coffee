z = require 'zorium'

OneMoreExample = require '../one_more_example'

styles = require './index.styl'

module.exports = class Example
  constructor: ->
    styles.use()

    @OneMoreExample = new OneMoreExample()

  render: ->
    z 'div.example',
      z 'div.example-orange-box',
        z 'h2', 'Super cool headline'
      z 'div.example-blue-box',
        z 'strong', 'Something bold'
        z 'img', src: '//cdn.wtf/d/images/logos/logo.svg'
      z 'img',
        src: '//cdn.wtf/d/images/logos/logo.svg'
        width: 100
        height: 40
      @OneMoreExample.render() # child component
