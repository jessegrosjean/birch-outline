loadOutlineFixture = require './load-outline-fixture'
ItemPathQuery = require '../src/item-path-query'
Outline = require '../src/outline'
should = require('chai').should()

describe 'ItemPathQuery', ->
  [outline, root, one, two, three, four, five, six, query] = []

  beforeEach ->
    {outline, root, one, two, three, four, five, six} = loadOutlineFixture()
    query = new ItemPathQuery(outline)

  afterEach ->
    outline.destroy()

  it 'should not start query when path is set', ->
    query.itemPath = '//three'
    query.started.should.equal(false)
    query.results.should.eql([])

  it 'should not start query when path is set', ->
    query.itemPath = '//three'
    query.start()
    query.started.should.equal(true)
    query.results.should.eql([three])

  it 'should allow custom query function', ->
    query.queryFunction = ->
      [one, six]
    query.start()
    query.results.should.eql([one, six])
