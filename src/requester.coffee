parser   = require 'xml2json'
deferred = require 'deferred'
needle   = require 'needle'
Digester = require './digester'

module.exports =
class Requester
  constructor: (@config) ->

  # obj = service: 'get_form', vars: {signup_form_id: 1}
  get: (@obj) ->
    def = deferred()
    digester = new Digester @config, @obj
    needle.get digester.url, @response(def)
    def.promise

  post: (@obj)  ->
    def = deferred()
    digester = new Digester @config, @obj
    xml_data = @generate_xml(@obj.data)
    needle.post digester.url, xml_data, @response(def)
    def.promise

  generate_xml: (data) -> """
    <?xml version='1.0' encoding='utf-8'?>
    <api>#{ parser.toXml(data) }</api>
    """

  response: (def) -> (err, resp, body) =>
    #response can be a string w/ error
    if typeof(body) is 'string'
      err = body

    #request can also fail
    if err
      return def.resolve new Error(err)

    #error can also be in the response
    body = @parse(body)
    if err = body?.api?[0]?.error
      def.resolve new Error(JSON.stringify(err))
    else
      def.resolve body

  parse: (body) ->
    {toJson} = parser
    options = {object: yes, arrayNotation: yes, sanitize: no}

    try toJson(body, options)
    catch err then body
