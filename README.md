bsd-node
========

Simple port of https://github.com/reformact/bsd to node.

##Usage
    BSD = require('bsd')
    config =  =
      api_id: 'bsd_gem'
      api_secret: 'secret'
      base_url: 'http://xxxx.cp.bsd.net'

    bsd = new BSD(config)
    bsd.get_signup(32).done (response) ->
      console.log response

  Methods returns promises that are resolved with done.

  ![img](http://40.media.tumblr.com/4ad1234d570b295596a9222d94e8b25b/tumblr_n79rlf4EQY1sqrcdvo1_500.jpg)

*it is a cloudy sky in bsd land, but fear not oh fellow traveller, walk with us*

Peace
