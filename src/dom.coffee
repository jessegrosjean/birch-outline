ElementType = require 'domelementtype'
htmlparser = require 'htmlparser2'
domutils = require 'domutils'
_ = require 'underscore-plus'

###
Create
###

parseDOM = (string, options) ->
  unless options
    options =
      decodeEntities: true
      lowerCaseTags: true
      xmlMode: true

  out = null
  handler = new htmlparser.DomHandler (error, parsedDOM) ->
    if (error)
      throw error
    else
      out = parsedDOM

  parser = new htmlparser.Parser(handler, options)
  parser.write(string)
  parser.done()
  out

createElement = (tagName, attribs={}) ->
  {} =
    type: ElementType.Tag
    name: tagName.toLowerCase()
    attribs: attribs
    children: []

createTextNode = (text) ->
  {} =
    type: ElementType.Text
    data: text

cloneNode = (node) ->
  clone = Object.assign({}, node)
  if clone.children
    clone.children = []
    for each in node.children
      domutils.appendChild(clone, cloneNode(each))
  clone

###
Manipulate
###

appendChild = (parent, child) ->
  domutils.appendChild(parent, child)

insertChildBefore = (parent, child, sibling) ->
  domutils.appendChild(parent, child)

removeElement = (element) ->
  domutils.removeElement(element)

firstChild = (parent) ->
  parent.children?[0]

lastChild = (parent) ->
  if children = parent.children
    return children[children.length - 1]
  null

parents = (node) ->
  nodes = [node]
  while node = node.parent
    nodes.unshift(node)
  nodes

nextSibling = (node) ->
  node.next

previousSibling = (node) ->
  node.prev

shortestPath = (node1, node2) ->
  if node1 is node2
    [node1]
  else
    parents1 = parents(node1)
    parents2 = parents(node2)
    commonDepth = 0
    while parents1[commonDepth] is parents2[commonDepth]
      commonDepth++
    parents1.splice(0, commonDepth - 1)
    parents2.splice(0, commonDepth)
    parents1.concat(parents2)

commonAncestor = (node1, node2) ->
  if node1 is node2
    [node1]
  else
    parents1 = parents(node1)
    parents2 = parents(node2)
    while parents1[depth] is parents2[depth]
      depth++
    parents1[depth - 1]

previousNode = (node) ->
  if prev = previousSibling(node)
    lastDescendantNodeOrSelf(prev)
  else
    node.parent or null

nextNode = (node) ->
  if first = firstChild(node)
    first
  else
    next = nextSibling(node)
    if next
      next
    else
      parent = node.parent
      while parent
        next = nextSibling(parent)
        if next
          return next
        parent = parent.parent
      null

nodeNextBranch = (node) ->
  if next = nextSibling(node)
    next
  else
    p = node.parent
    while p
      if next = nextSibling(p)
        return next
      p = p.parent
    null

lastDescendantNodeOrSelf = (node) ->
  last = lastChild(node)
  each = node
  while last
    each = last
    last = lastChild(each)
  each

getElementById = (id, element, recurse) ->
  domutils.getElementById(id, element)

getElementsByTagName = (name, element, recurse, limit) ->
  domutils.getElementsByTagName(name, element, recurse, limit)

normalizeDOM = (element, skip={}) ->
  if skip[element.name]
    return
  if element.children?.length > 0
    for each in element.children.slice()
      if each.type is ElementType.Text
        removeElement(each)
      else
        normalizeDOM(each, skip)

prettyDOM = (element, skip={}, trimEmpty={}, indent='\n') ->
  if skip[element.name]
    return
  if element.children.length > 0
    childIndent = indent + '  '
    for each in element.children.slice()
      domutils.prepend(each, createTextNode(childIndent))
      prettyDOM(each, skip, trimEmpty, childIndent)
    domutils.append(lastChild(element), createTextNode(indent))

getInnerHTML = (node, options) ->
  domutils.getInnerHTML(node, options)

getOuterHTML = (node, options) ->
  domutils.getOuterHTML(node, options)

stopEventPropagation = (commandListeners) ->
  newCommandListeners = {}
  for commandName, commandListener of commandListeners
    do (commandListener) ->
      newCommandListeners[commandName] = (event) ->
        event.stopPropagation()
        commandListener.call(this, event)
  newCommandListeners

module.exports =
  parseDOM: parseDOM
  createElement: createElement
  createTextNode: createTextNode
  cloneNode: cloneNode
  appendChild: appendChild
  firstChild: firstChild
  lastChild: lastChild
  parents: parents
  shortestPath: shortestPath
  commonAncestor: commonAncestor
  previousNode: previousNode
  nextNode: nextNode
  nodeNextBranch: nodeNextBranch
  lastDescendantNodeOrSelf: lastDescendantNodeOrSelf
  getElementById: getElementById
  getElementsByTagName: getElementsByTagName
  normalizeDOM: normalizeDOM
  prettyDOM: prettyDOM
  getInnerHTML: getInnerHTML
  getOuterHTML: getOuterHTML
  stopEventPropagation: stopEventPropagation
