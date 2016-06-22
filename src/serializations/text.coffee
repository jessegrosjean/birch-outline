{ repeat } = require '../util'
Item = require '../item'

# This is a lossy serialization, both item attributes and attribute runs in
# the body string are lost.

###
Serialization
###

beginSerialization = (items, options, context) ->
  context.lines = []

beginSerializeItem = (item, options, context) ->

serializeItemBody = (item, bodyAttributedString, options, context) ->
  context.lines.push(repeat('\t', item.depth - options.baseDepth) + bodyAttributedString.string)

endSerializeItem = (item, options, context) ->

emptyEncodeLastItem = (options, context) ->
  context.lines.push('')

endSerialization = (options, context) ->
  context.lines.join('\n')

###
Deserialization
###

deserializeItemBody = (item) ->

deserializeItem = (text, outline) ->
  item = outline.createItem()
  indent = text.match(/^\t*/)[0].length + 1
  body = text.substring(indent - 1)
  item.indent = indent
  item.bodyString = body
  item

_parseLinesAndNormalizeIndentation = (text) ->
  text = text.replace(/(\r\n|\n|\r)/gm,'\n')

  lines = text.split('\n')

  # Hack... don't strip off spaces in case of single line. Otherwise when you
  # copy " some text " and paste, then the leading space is always removed...
  if lines.length > 1
    # Find min length leading space sequence.
    # Replace with tags.
    # Remove any left over spaces.
    spacesPerTab = Number.MAX_VALUE
    for each in lines
      length = each.length
      count = 0
      i = 0
      while i < length
        char = each[i]
        if char is ' '
          count++
        else if char is '\t'
          if count > 0
            spacesPerTab = Math.min(spacesPerTab, count)
          count = 0
        else
          break
        i++
      if count > 0
        spacesPerTab = Math.min(spacesPerTab, count)

    if spacesPerTab isnt Number.MAX_VALUE
      text = lines.join('\n')
      leadingSpacesRegex = new RegExp('^( {' + spacesPerTab + '})+', 'gm')
      text = text.replace leadingSpacesRegex, (matchText) ->
        Array(1 + (matchText.length / spacesPerTab)).join '\t'
      text = text.replace /^\s+/gm, (matchText) ->
        index = matchText.indexOf(' ')
        if index isnt -1
          matchText.substr(0, index)
        else
          matchText
      lines = text.split('\n')

  lines

deserializeItems = (text, outline, options={}, deserializeItemCallback) ->
  deserializeItemCallback ?= deserializeItem
  lines = _parseLinesAndNormalizeIndentation(text)
  flatItems = []
  emptyLines = []
  for eachLine in lines
    eachItem = deserializeItemCallback(eachLine, outline)
    flatItems.push(eachItem)

    if /^\s*$/.test(eachLine)
      emptyLines.push(eachItem)
    else
      if emptyLines.length
        for eachEmpty in emptyLines
          eachEmpty.indent = eachItem.indent
        emptyLines = []

  if emptyLines.length
    for eachEmpty in emptyLines
      eachEmpty.indent = 1

  roots = Item.buildItemHiearchy(flatItems)
  roots

module.exports =
  beginSerialization: beginSerialization
  beginSerializeItem: beginSerializeItem
  serializeItemBody: serializeItemBody
  endSerializeItem: endSerializeItem
  endSerialization: endSerialization
  emptyEncodeLastItem: emptyEncodeLastItem
  deserializeItems: deserializeItems
