_ = require 'underscore-plus'
assert = require 'assert'
Item = require '../item'

###
Serialization
###

beginSerialization = (items, options, context) ->
  coverItems = Item.getCommonAncestors(items)
  expandedItemIDsSet = new Set()
  serializedItems = []

  if expandedItemIDs = options?.expandedItemIDs
    for each in expandedItemIDs
      expandedItemIDsSet.add(each)

  outline = null
  for each in items
    outline ?= each.outline
    serializedItems.push
      id: each.id
      expanded: expandedItemIDsSet.has(each.id)
  context.json = JSON.stringify
    outlineID: outline.id
    items: serializedItems

beginSerializeItem = (item, options, context) ->

serializeItemBody = (item, bodyAttributedString, options, context) ->

endSerializeItem = (item, options, context) ->

endSerialization = (options, context) ->
  context.json

###
Deserialization
###

deserializeItems = (json, outline, options) ->
  json = JSON.parse(json)
  sourceOutline = require('../outline').getOutlineForID(json.outlineID)
  items = []
  expandedItemIDs = []
  items.loadOptions =
    expanded: expandedItemIDs

  if sourceOutline
    for each in json.items
      if item = sourceOutline.getItemForID(each.id)
        items.push(item)
        if each.expanded
          expandedItemIDs.push(each.id)

  Item.getCommonAncestors(items)

module.exports =
  beginSerialization: beginSerialization
  beginSerializeItem: beginSerializeItem
  serializeItemBody: serializeItemBody
  endSerializeItem: endSerializeItem
  endSerialization: endSerialization
  deserializeItems: deserializeItems
