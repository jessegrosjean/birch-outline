htmlparser = require 'htmlparser2'
_ = require 'underscore-plus'
dom = require '../dom'
assert = require 'assert'
Item = require '../item'

###
Serialization
###

beginSerialization = (items, options, context) ->
  context.opml = dom.createElement('opml', version: '2.0')
  context.elementStack = []

  context.topElement = ->
    @elementStack[@elementStack.length - 1]
  context.popElement = ->
    @elementStack.pop()
  context.pushElement = (element) ->
    @elementStack.push(element)

  headElement = dom.createElement('head')
  bodyElement = dom.createElement('body')

  dom.appendChild(context.opml, headElement)
  dom.appendChild(context.opml, bodyElement)
  context.pushElement(bodyElement)

beginSerializeItem = (item, options, context) ->
  parentElement = context.topElement()
  outlineElement = dom.createElement('outline', id: item.id)
  for eachName in item.attributeNames
    unless eachName is 'id' or eachName is 'text'
      eachValue = item.getAttribute(eachName)
      unless eachName is 'indent' and eachValue is '1'
        outlineElement.attribs[eachName] = eachValue
  dom.appendChild(parentElement, outlineElement)
  context.pushElement(outlineElement)

serializeItemBody = (item, bodyAttributedString, options, context) ->
  outlineElement = context.topElement()
  outlineElement.attribs['text'] = bodyAttributedString.toInlineBMLString()

endSerializeItem = (item, options, context) ->
  context.popElement()

endSerialization = (options, context) ->
  dom.prettyDOM(context.opml, p: true)
  dom.getOuterHTML context.opml,
    decodeEntities: true
    lowerCaseTags: true
    xmlMode: true

###
Deserialization
###

deserializeItems = (opmlString, outline, options) ->
  parsedDOM = dom.parseDOM(opmlString)
  opmlElement = dom.getElementsByTagName('opml', parsedDOM, false)[0]
  unless opmlElement
    throw new Error('Could not find <opml> element.')
  headElement = dom.getElementsByTagName('head', opmlElement.children, false)[0]
  bodyElement = dom.getElementsByTagName('body', opmlElement.children, false)[0]

  if bodyElement
    dom.normalizeDOM(bodyElement)
    flatItems = []
    eachOutline = dom.firstChild(bodyElement)
    while eachOutline
      createItem(outline, eachOutline, 0, flatItems)
      eachOutline = eachOutline.next
    items = Item.buildItemHiearchy(flatItems)
    items
  else
    throw new Error('Could not find <body> element.')

createItem = (outline, outlineElement, depth, flatItems, remapIDCallback) ->
  assert.ok(outlineElement.name is 'outline', "Expected OUTLINE element but got #{outlineElement.tagName}")
  item = outline.createItem('', outlineElement.attribs['id'])
  item.bodyHTMLString = outlineElement.attribs['text'] or ''

  for each in Object.keys(outlineElement.attribs)
    unless each is 'id'
      item.setAttribute(each, outlineElement.attribs[each])

  itemIndent = item.indent or 1
  depth = depth + itemIndent
  item.indent = depth

  flatItems.push(item)

  eachOutline = dom.firstChild(outlineElement)
  while eachOutline
    createItem(outline, eachOutline, depth, flatItems, remapIDCallback)
    eachOutline = eachOutline.next

module.exports =
  beginSerialization: beginSerialization
  beginSerializeItem: beginSerializeItem
  serializeItemBody: serializeItemBody
  endSerializeItem: endSerializeItem
  endSerialization: endSerialization
  deserializeItems: deserializeItems
