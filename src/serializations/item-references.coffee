_ = require 'underscore-plus'
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
  Outline = require('../outline')
  json = JSON.parse(json)
  items = []
  expandedItemIDs = []
  items.loadOptions =
    expanded: expandedItemIDs
  sourceOutline = Outline.getOutlineForID(json.outlineID)

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
