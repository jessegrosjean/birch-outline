AttributedString = require '../attributed-string'
ElementType = require 'domelementtype'
{ assert } = require '../util'
Birch = require '../birch'
Item = require '../item'
dom = require '../dom'

###
Serialization
###

beginSerialization = (items, options, context) ->
  context.html = dom.createElement('html', xmlns: 'http://www.w3.org/1999/xhtml')
  context.elementStack = []

  context.topElement = ->
    @elementStack[@elementStack.length - 1]
  context.popElement = ->
    @elementStack.pop()
  context.pushElement = (element) ->
    @elementStack.push(element)

  head = dom.createElement('head')
  dom.appendChild(context.html, head)
  expandedIDs = options?.expandedIDs

  if expandedIDs?.length
    expandedMeta = dom.createElement 'meta',
      name: 'expandedItems'
      content: expandedIDs.join(' ')
    dom.appendChild(head, expandedMeta)

  encodingMeta = dom.createElement('meta', charset: 'UTF-8')
  dom.appendChild(head, encodingMeta)

  body = dom.createElement('body')
  dom.appendChild(context.html, body)

  rootUL = dom.createElement('ul', id: Birch.RootID)
  dom.appendChild(body, rootUL)
  context.pushElement(rootUL)

beginSerializeItem = (item, options, context) ->
  parentElement = context.topElement()
  if parentElement.name is 'li'
    context.popElement()
    ulElement = dom.createElement('ul')
    dom.appendChild(parentElement, ulElement)
    parentElement = ulElement
    context.pushElement(ulElement)

  liElement = dom.createElement('li', id: item.id)
  for eachName in item.attributeNames
    eachValue = item.getAttribute(eachName)
    unless eachName is 'indent' and eachValue is '1'
      liElement.attribs[eachName] = eachValue
  dom.appendChild(parentElement, liElement)

  context.pushElement(liElement)

serializeItemBody = (item, bodyAttributedString, options, context) ->
  liElement = context.topElement()
  pElement = dom.createElement('p')
  bodyAttributedString.toInlineBMLInContainer(pElement)
  context.lastSerializedLI = liElement
  dom.appendChild(liElement, pElement)

endSerializeItem = (item, options, context) ->
  context.popElement()

endSerialization = (options, context) ->
  dom.prettyDOM(context.html, p: true)
  result = dom.getOuterHTML context.html,
    decodeEntities: true
    lowerCaseTags: true
    xmlMode: true
  '<!DOCTYPE html>\n' + result

###
Deserialization
###

deserializeItems = (bmlString, outline, options) ->
  parsedDOM = dom.parseDOM(bmlString)
  htmlElement = dom.getElementsByTagName('html', parsedDOM, false)[0]
  rootUL =
    dom.getElementById(Birch.RootID, parsedDOM) ?
    dom.getElementById('Birch.Root', parsedDOM) ?
    dom.getElementById('Birch', parsedDOM) ?
    dom.getElementById('Root', parsedDOM)

  if rootUL
    rootUL.attribs['id'] = Birch.RootID
    dom.normalizeDOM(rootUL, 'p': true)
    expandedItemIDs = {}
    flatItems = []

    eachLI = dom.firstChild(rootUL)
    while eachLI
      createItem outline, eachLI, 0, flatItems, (oldID, newID) ->
        if expandedItemIDs[oldID]
          delete expandedItemIDs[oldID]
        expandedItemIDs[newID] = true
      eachLI = eachLI.next

    items = Item.buildItemHiearchy(flatItems)
    items
  else
    throw new Error('Could not find <ul id="Birch"> element.')

createItem = (outline, liOrRootUL, depth, flatItems, remapIDCallback) ->
  tagName = liOrRootUL.name
  if tagName is 'li'
    p = dom.firstChild(liOrRootUL)
    pOrUL = dom.lastChild(liOrRootUL)
    pTagName = p?.name
    pOrULTagName = pOrUL?.name
    assert(pTagName is 'p', "Expected 'P', but got #{pTagName}")
    if pTagName is pOrULTagName
      assert(pOrUL is p, "Expect single 'P' child in 'LI'")
    else
      assert(pOrULTagName is 'ul', "Expected 'UL', but got #{pOrULTagName}")
      assert(pOrUL.prev is p, "Expected previous sibling of 'UL' to be 'P'")
    AttributedString.validateInlineBML(p)
  else if tagName is 'ul'
    assert(liOrRootUL.id is Birch.RootID)
  else
    assert(false, "Expected 'LI' or 'UL', but got #{tagName}")

  P = dom.firstChild(liOrRootUL)
  UL = dom.lastChild(liOrRootUL)
  text = AttributedString.fromInlineBML(P.children)
  item = outline.createItem(text, liOrRootUL.attribs['id'], remapIDCallback)
  flatItems.push(item)

  if liOrRootUL.attribs
    for attributeName in Object.keys(liOrRootUL.attribs)
      unless attributeName is 'id'
        item.setAttribute(attributeName, liOrRootUL.attribs[attributeName])

  itemIndent = item.indent or 1
  depth = depth + itemIndent
  item.indent = depth

  if P isnt UL
    eachLI = dom.firstChild(UL)
    while eachLI
      createItem(outline, eachLI, depth, flatItems, remapIDCallback)
      eachLI = eachLI.next
  item

module.exports =
  beginSerialization: beginSerialization
  beginSerializeItem: beginSerializeItem
  serializeItemBody: serializeItemBody
  endSerializeItem: endSerializeItem
  endSerialization: endSerialization
  deserializeItems: deserializeItems
