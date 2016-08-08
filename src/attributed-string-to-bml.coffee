AttributedString = require './attributed-string'
bmlTags = require './attributed-string-bml-tags'
ElementType = require 'domelementtype'
_ = require 'underscore-plus'
dom = require './dom'

AttributedString.prototype.toInlineBMLString = ->
  p = dom.createElement('p')
  @toInlineBMLInContainer(p)
  dom.getInnerHTML p,
    decodeEntities: true
    lowerCaseTags: true
    xmlMode: true

AttributedString.prototype.toInlineBMLInContainer = (container) ->
  nodeRanges = calculateInitialNodeRanges(@)
  nodeRangeStack = [
    start: 0
    end: @getLength()
    node: container
  ]
  buildFragmentFromNodeRanges(nodeRanges, nodeRangeStack)

calculateInitialNodeRanges = (attributedString) ->
  # For each attribute run create element nodes for each attribute and text node
  # for the text content. Store node along with range over which is should be
  # applied. Return sorted node ranages.
  nodeRanges = []

  if attributedString.runBuffer
    tagsToRanges = {}
    runLocation = 0
    runBuffer = 0

    for run in attributedString.getRuns()
      for attributeName, attributeValue of run.attributes
        nodeRange = tagsToRanges[attributeName]
        if not nodeRange or nodeRange.end <= runLocation

          # Create element for each attribute name in run. If is known bmlTag
          # create element directly. Otherwise create span and add the
          # attribute name/value an attribute on the span.
          if bmlTags[attributeName]
            element = dom.createElement(attributeName)
            if typeof attributeValue is 'string'
              element.attribs['value'] = attributeValue
            else if _.isObject(attributeValue)
              for attrName, attrValue of attributeValue
                element.attribs[attrName] = attrValue.toString()
          else
            element = dom.createElement('span')
            element.attribs[attributeName] = attributeValue.toString()

          nodeRange =
            node: element
            start: runLocation
            end: seekTagRangeEnd attributeName, attributeValue, runBuffer, runLocation, attributedString

          tagsToRanges[attributeName] = nodeRange
          nodeRanges.push nodeRange

      text = run.getString()
      if text isnt AttributedString.ObjectReplacementCharacter and text isnt AttributedString.LineSeparatorCharacter
        nodeRanges.push
          start: runLocation
          end: runLocation + run.getLength()
          node: dom.createTextNode(text)

      runLocation += run.getLength()
      runBuffer++

    nodeRanges.sort compareNodeRanges
  else
    string = attributedString.getString()
    nodeRanges = [{
      start: 0
      end: string.length
      node: dom.createTextNode(string)
    }]

  nodeRanges

seekTagRangeEnd = (tagName, seekTagAttributes, runBuffer, runLocation, attributedString) ->
  attributeRuns = attributedString.getRuns()
  end = attributeRuns.length
  while true
    run = attributeRuns[runBuffer++]
    runTagAttributes = run.attributes[tagName]
    equalAttributes = runTagAttributes is seekTagAttributes or _.isEqual(runTagAttributes, seekTagAttributes)
    unless equalAttributes
      return runLocation
    else if runBuffer is end
      return runLocation + run.getLength()
    runLocation += run.getLength()

compareNodeRanges = (a, b) ->
  if a.start < b.start
    -1
  else if a.start > b.start
    1
  else if a.end isnt b.end
    b.end - a.end
  else
    aNodeType = a.node.type
    bNodeType = b.node.type
    if aNodeType isnt bNodeType
      if aNodeType is ElementType.Text
        1
      else if bNodeType is ElementType.Text
        -1
      else
        aTagName = a.node.name
        bTagName = b.node.name
        if aTagName < bTagName
          -1
        else if aTagName > bTagName
          1
        else
          0
    else
      0

buildFragmentFromNodeRanges = (nodeRanges, nodeRangeStack) ->
  i = 0
  while i < nodeRanges.length
    range = nodeRanges[i++]
    parentRange = nodeRangeStack.pop()
    while nodeRangeStack.length and parentRange.end <= range.start
      parentRange = nodeRangeStack.pop()

    if range.end > parentRange.end
      # In this case each has started inside current parent tag, but
      # extends past. Must split this node range into two. Process
      # start part of split here, and insert end part in correct
      # postion (after current parent) to be processed later.
      splitStart = range
      splitEnd =
        end: splitStart.end
        start: parentRange.end
        node: dom.cloneNode(splitStart.node)
      splitStart.end = parentRange.end
      # Insert splitEnd after current parent in correct location.
      j = nodeRanges.indexOf parentRange
      while compareNodeRanges(nodeRanges[j], splitEnd) < 0
        j++
      nodeRanges.splice(j, 0, splitEnd)

    dom.appendChild(parentRange.node, range.node)
    nodeRangeStack.push parentRange
    nodeRangeStack.push range

  nodeRangeStack[0].node

module.exports = AttributedString
