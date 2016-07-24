tagsHelper = require './tags'
changeDelegate = require './change-delegate'
{ repeat } = require '../../util'
text = require '../text'

serializeItemBody = (item, bodyAttributedString, options, context) ->
  bodyString = bodyAttributedString.string

  if item.outline.changeDelegate isnt changeDelegate
    itemClone = item.clone()

    # Only need to do this if TaskPaper change delegate isn't alreayd keeping
    # attributes in sync with body text.
    encodedAttributes = []
    for attributeName in item.attributeNames
      if tagsHelper.encodesAttributeName(attributeName)
        tagsHelper.addTag(itemClone, attributeName, itemClone.getAttribute(attributeName))

    if encodedAttributes.length
      encodedAttributes = encodedAttributes.join(' ')
      if bodyString.length
        encodedAttributes = ' ' + encodedAttributes
      bodyString += encodedAttributes

  context.lines.push(repeat('\t', item.depth - options.baseDepth) + bodyString)

deserializeItem = (itemString, outline) ->
  item = outline.createItem()
  indent = itemString.match(/^\t*/)[0].length + 1
  body = itemString.substring(indent - 1)
  item.indent = indent
  item.bodyString = body

  if item.outline.changeDelegate isnt changeDelegate
    # Unused untested branch. Only need to do this if TaskPaper change
    # delegate isn't already keeping attributes in sync with body text. Idea
    # is to extract attributes from taskpaper body text. Not sure if it's best
    # to
    removedLength = 0
    parseTags body, (tag, value, match) ->
      item.setAttribute(tag, value)
      index = match.index - removedLength
      body = body.substring(0, index) + body.substring(index + match[0].length)
      removedLength += match[0].length

  item

deserializeItems = (itemsString, outline, options={}) ->
  text.deserializeItems(itemsString, outline, options, deserializeItem)

module.exports =
  changeDelegate: require './change-delegate'
  beginSerialization: text.beginSerialization
  beginSerializeItem: text.beginSerializeItem
  serializeItemBody: serializeItemBody
  endSerializeItem: text.endSerializeItem
  endSerialization: text.endSerialization
  emptyEncodeLastItem: text.emptyEncodeLastItem
  deserializeItems: deserializeItems
  itemPathTypes: 'project': true, 'task': true, 'note': true
