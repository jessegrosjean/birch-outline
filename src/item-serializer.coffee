urls = require './urls'
path = require 'path'

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

  @UTIToMimeTypeMap:
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

  @getSerializationsForMimeType: (mimeType) ->
    if @UTIToMimeTypeMap[mimeType]
      mimeType = @UTIToMimeTypeMap[mimeType]
    results = (each.serialization for each in @serializations when mimeType in each.mimeTypes)
    if results.length is 0
      # Fall back to plain text serializer if nothing else is found
      results = @getSerializationsForMimeType(ItemSerializer.TEXTType)
    results

  @getMimeTypeForURI: (uri) ->
    uri ?= ''
    extension = path.extname(uri).toLowerCase().substr(1)
    for each in @serializations
      if extension in each.extensions
        return each.mimeTypes[0]

  ###
  Section: Serialize & Deserialize Items
  ###

  # Public: Serialize items into a supported format.
  #
  # - `items` {Item} {Array} to serialize.
  # - `mimeType` Supported serialization format.
  @serializeItems: (items, mimeType, options={}) ->
    mimeType ?= ItemSerializer.BMLType
    serialization = (each for each in @getSerializationsForMimeType(mimeType) when each.beginSerialization)[0]

    firstItem = items[0]
    lastItem = items[items.length - 1]
    startOffset = options.startOffset ? 0
    endOffset = options.endOffset ? lastItem.bodyString.length
    options.baseDepth ?= Number.MAX_VALUE
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
  # - `mimeType` Format to deserialize.
  #
  # Returns {Array} of {Items}.
  @deserializeItems: (itemsData, outline, mimeType, options) ->
    mimeType ?= ItemSerializer.BMLType
    (each for each in @getSerializationsForMimeType(mimeType) when each.deserializeItems)[0].deserializeItems(itemsData, outline, options)

ItemSerializer.registerSerialization
  priority: 0
  extensions: []
  mimeTypes: [ItemSerializer.ItemReferencesType]
  serialization: require('./serializations/item-references')

ItemSerializer.registerSerialization
  priority: 1
  extensions: ['bml']
  mimeTypes: [ItemSerializer.BMLType]
  serialization: require('./serializations/bml')

ItemSerializer.registerSerialization
  priority: 2
  extensions: ['opml']
  mimeTypes: [ItemSerializer.OPMLType]
  serialization: require('./serializations/opml')

ItemSerializer.registerSerialization
  priority: 3
  extensions: ['taskpaper']
  mimeTypes: [ItemSerializer.TaskPaperType]
  serialization: require('./serializations/taskpaper')

ItemSerializer.registerSerialization
  priority: 4
  extensions: []
  mimeTypes: [ItemSerializer.TEXTType]
  serialization: require('./serializations/text')

module.exports = ItemSerializer
