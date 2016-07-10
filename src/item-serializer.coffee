_ = require 'underscore-plus'

# Public: A class for serializing and deserializing {Item}s.
class ItemSerializer

  ###
  Section: Format Constants
  ###

  # Public: Outline and item ID JSON for the pasteboard.
  @ItemReferencesType: 'application/json+item-ids'

  # Public: BML type constant.
  #
  # - HTML subset for representing outlines in HTML.
  @BMLType: 'text/bml+html'
  @BMLMimeType: @BMLType

  # Public: OPML type constant.
  #
  # - See https://en.wikipedia.org/wiki/OPML
  @OPMLType: 'text/opml+xml'
  @OPMLMimeType: @OPMLType

  # Public: TaskPaper text type constant.
  #
  # - Encode item structure with tabs.
  # - Encode item `data-*` attributes with `tag(value)` pattern.
  @TaskPaperType: 'text/taskpaper'
  @TaskPaperMimeType: @TaskPaperType

  # Public: Plain text type constant.
  #
  # - Encode item structure with tabs.
  @TEXTType: 'text/plain'
  @TEXTMimeType: @TEXTType

  @UTIToTypeMap:
    'public.plain-text': @TEXTType
    'public.utf8-plain-text': @TEXTType
    'com.hogbaysoftware.ItemReferencePboardType': @ItemReferencesType
    'com.hogbaysoftware.BirchMarkupLanguagePboardType': @BMLType

  @serializations: []

  constructor: ->
    throw new Error('This is a static class')

  @registerSerialization: (serialization) ->
    serialization.priority ?= Number.Infinity
    @serializations.push serialization
    @serializations.sort (a, b) ->
      a.priority - b.priority

  @getSerializationsForType: (type) ->
    if @UTIToTypeMap[type]
      type = @UTIToTypeMap[type]
    results = (each.serialization for each in @serializations when type in each.types)
    if results.length is 0
      # Fall back to plain text serializer if nothing else is found
      results = @getSerializationsForType(ItemSerializer.TEXTType)
    results

  @getSerializationsForExtension: (extension='') ->
    extension = extension.toLowerCase()
    results = (each.serialization for each in @serializations when extension in each.extensions)
    if results.length is 0
      # Fall back to plain text serializer if nothing else is found
      results = @getSerializationsForType(ItemSerializer.TEXTType)
    results

  ###
  Section: Serialize & Deserialize Items
  ###

  # Public: Serialize items into a supported format.
  #
  # - `items` {Item} {Array} to serialize.
  # - `options` (optional) Serialization options.
  #   * `type` (optional) {String} (default: ItemSerializer.BMLType)
  #   * `startOffset` (optional) {Number} (default: 0)
  #   * `endOffset` (optional) {Number} (default: lastItem.bodyString.length)
  #   * `expandedItems` (optional) {Item} {Array} of expanded items
  @serializeItems: (items, options={}) ->
    if _.isString(options)
      options = type: options

    firstItem = items[0]
    lastItem = items[items.length - 1]

    options.type ?= ItemSerializer.BMLType
    options.startOffset ?= 0
    options.endOffset ?= lastItem.bodyString.length
    options.baseDepth ?= Number.MAX_VALUE

    serialization = (each for each in @getSerializationsForType(options['type']) when each.beginSerialization)[0]

    startOffset = options.startOffset
    endOffset = options.endOffset
    emptyEncodeLastItem = false
    context = {}

    if items.length > 1 and endOffset is 0
      items.pop()
      lastItem = items[items.length - 1]
      endOffset = lastItem.bodyString.length
      emptyEncodeLastItem = true

    for each in items
      if each.depth < options.baseDepth
        options.baseDepth = each.depth

    serialization.beginSerialization(items, options, context)

    if items.length is 1
      serialization.beginSerializeItem(items[0], options, context)
      serialization.serializeItemBody(items[0], items[0].bodyAttributedSubstringFromRange(startOffset, endOffset - startOffset), options, context)
      serialization.endSerializeItem(items[0], options, context)
    else
      itemStack = []
      for each in items
        while itemStack[itemStack.length - 1]?.depth >= each.depth
          serialization.endSerializeItem(itemStack.pop(), options, context)

        itemStack.push(each)
        serialization.beginSerializeItem(each, options, context)
        itemBody = each.bodyAttributedString

        if each is firstItem
          itemBody = itemBody.attributedSubstringFromRange(startOffset, itemBody.length - startOffset)
        else if each is lastItem
          itemBody = itemBody.attributedSubstringFromRange(0, endOffset)
        serialization.serializeItemBody(each, itemBody, options, context)

      while itemStack.length
        serialization.endSerializeItem(itemStack.pop(), options, context)

    if emptyEncodeLastItem
      serialization.emptyEncodeLastItem?(options, context)

    serialization.endSerialization(options, context)

  # Public: Deserialize items from a supported format.
  #
  # - `itemsData` {String} to deserialize.
  # - `outline` {Outline} to use when creating deserialized items.
  # - `options` Deserialization options.
  #
  # Returns {Array} of {Items}.
  @deserializeItems: (serializedItems, outline, options={}) ->
    options['type'] ?= ItemSerializer.BMLType
    serialization = (each for each in @getSerializationsForType(options['type']) when each.deserializeItems)[0]
    serialization.deserializeItems(serializedItems, outline, options)

ItemSerializer.registerSerialization
  priority: 0
  extensions: []
  types: [ItemSerializer.ItemReferencesType]
  serialization: require('./serializations/item-references')

ItemSerializer.registerSerialization
  priority: 1
  extensions: ['bml']
  types: [ItemSerializer.BMLType]
  serialization: require('./serializations/bml')

ItemSerializer.registerSerialization
  priority: 2
  extensions: ['opml']
  types: [ItemSerializer.OPMLType]
  serialization: require('./serializations/opml')

ItemSerializer.registerSerialization
  priority: 3
  extensions: ['taskpaper']
  types: [ItemSerializer.TaskPaperType]
  serialization: require('./serializations/taskpaper')

ItemSerializer.registerSerialization
  priority: 4
  extensions: []
  types: [ItemSerializer.TEXTType]
  serialization: require('./serializations/text')

module.exports = ItemSerializer
