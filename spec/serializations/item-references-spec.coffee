ItemSerializer = require '../../src/item-serializer'
loadOutlineFixture = require '../load-outline-fixture'
Outline = require '../../src/outline'
should = require('chai').should()

fixtureAsItemReferencesJSON = '{"outlineID":"m1eLUlEF8b","items":[{"id":"1"}]}'

describe 'Item References Serialization', ->
  [outline, root, one, two, three, four, five, six] = []

  beforeEach ->
    {outline, root, one, two, three, four, five, six} = loadOutlineFixture()

  afterEach ->
    outline.destroy()

  it 'should serialize and deserialize items', ->
    serializedReferences = ItemSerializer.serializeItems([three, five], ItemSerializer.ItemReferencesType)
    items = ItemSerializer.deserializeItems(serializedReferences, outline, ItemSerializer.ItemReferencesType)
    delete items['loadOptions']
    items.should.eql([three, five])
