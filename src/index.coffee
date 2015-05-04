_         = require 'underscore'
Requester = require './requester'

module.exports =
class BSD
  constructor: (options) ->
    @requester = new Requester(options)

  get_signup: (id) ->
    @requester.get
      service: 'signup/get_form'
      vars: ["signup_form_id=#{ id }"]

  process_signup: (id, fields) ->
    @requester.post
      service: 'signup/process_signup'
      data: signup_form: {id, signup_form_field: @xml_fields(fields)}

  xml_fields: (fields) ->
    _.map fields, (obj) ->
      obj['$t'] = obj.value
      delete obj.value
      return obj
