crypto = require 'crypto'

module.exports =
class Digester
  constructor: (@config, @obj) ->
    { @base_url, @api_id, @api_secret } = @config
    @time_of_signing = new Date().getTime()
    @url = "#{ @base_url }#{ @path() }?#{ @vars() }&api_mac=#{ @digest() }"

  path: ->
    "/page/api/#{ @obj.service }"

  vars: ->
    ["api_ver=2",
     "api_id=#{ @api_id }",
     "api_ts=#{ @time_of_signing }"]
    .concat @obj.vars or []
    .join '&'

  digest: ->
    crypto
    .createHmac 'sha1', @api_secret
    .update @signature()
    .digest 'hex'

  signature: ->
    [@api_id, @time_of_signing, @path(), @vars()].join '\n'
