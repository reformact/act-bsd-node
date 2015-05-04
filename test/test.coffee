should    = require 'should'
path      = require 'path'
fs        = require 'fs'
BSD       = require '../lib'


BSD_TEST_FIELDS = [{id: 370, value: "isaktestar@lol.com"}]
BSD_TEST_SIGNUP_ID = 32
BSD_TEST_CONFIG =
  api_id: process.env.API_ID
  api_secret: process.env.API_SECRET
  base_url: process.env.BASE_URL

describe 'basic', ->

  it 'works', ->
    (-> new BSD(BSD_TEST_CONFIG)).should.not.throw()

  it 'can fetch a signup', (done) ->
    bsd = new BSD(BSD_TEST_CONFIG)
    bsd.get_signup(BSD_TEST_SIGNUP_ID).done (response) ->
      response.should.be.an.Object
      response.api[0].should.have.property 'signup_form'
      done()

  it 'breaks when no signup id is found', (done) ->
    bsd = new BSD(BSD_TEST_CONFIG)
    bsd.get_signup(null).done (response) ->
      response.should.be.an.Error
      done()

  it 'can post to signup', (done) ->
    bsd = new BSD(BSD_TEST_CONFIG)
    bsd.process_signup(BSD_TEST_SIGNUP_ID, BSD_TEST_FIELDS).done (response) ->
      response.should.not.be.an.Error
      done()
