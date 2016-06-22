smartLinks = require './smart-links'
typesHelper = require './types'
tagsHelper = require './tags'

# Hook to insert @one(two) into body text when item.setAttribute('one', 'two')
# is called.
processItemDidChangeAttribute = (item, attribute, value, oldValue) ->
  startBodyString = item.bodyString

  if attribute is 'data-type'
    typesHelper.syncTypeAttributeToItemBody(item, value, oldValue)
  else if tagsHelper.encodesAttributeName(attribute)
    tagsHelper.syncTagAttributeToItemBody(item, attribute, value)

  if startBodyString isnt item.bodyString
    highlightItemBody(item)

# Hook to add attribute one=two when the user types @one(two) in body text.
# Also used to update item syntax highlighting.
processItemDidChangeBody = (item, oldBody) ->
  oldTags = tagsHelper.parseTags(oldBody).tags
  newTagMatches = []
  parseResults = tagsHelper.parseTags item.bodyString, (tag, value, match) ->
    newTagMatches.push
      tag: tag
      value: value
      match: match
  newTags = parseResults.tags

  bodyString = item.bodyString
  if parseResults.trailingMatch
    contentString = bodyString.substr(0, bodyString.length - parseResults.trailingMatch[0].length)
  else
    contentString = bodyString

  type = typesHelper.parseType(contentString)
  item.setAttribute('data-type', type)

  highlightItemBody(item, type, newTags, newTagMatches, contentString)

  for tag of oldTags
    unless newTags[tag]?
      item.removeAttribute(tag)

  for tag of newTags
    if newTags[tag] isnt oldTags[tag]
      item.setAttribute(tag, newTags[tag])

highlightItemBody = (item, type, tags, tagMatches, contentString) ->
  bodyString = item.bodyString

  unless tags
    tagMatches = []
    parseResults = tagsHelper.parseTags bodyString, (tag, value, match) ->
      tagMatches.push
        tag: tag
        value: value
        match: match
    tags = parseResults.tags

    if parseResults.trailingMatch
      contentString = bodyString.substr(0, bodyString.length - parseResults.trailingMatch[0].length)
    else
      contentString = bodyString

  for each in tagMatches
    tag = each.tag
    value = each.value
    match = each.match
    leadingSpace = match[1]
    start = match.index + leadingSpace.length
    length = match[0].length - leadingSpace.length
    item.addBodyHighlightAttributeInRange('tag', tag, start, length)
    encodedTagName = tagsHelper.encodeNameForAttributeName(tag)
    attributes = tagname: tag, link: "filter://@#{encodedTagName}"
    item.addBodyHighlightAttributesInRange(attributes, start, match[2].length + 1)

    if value?.length
      attributes = tagvalue: value, link: "filter://@#{encodedTagName} = #{value}"
      item.addBodyHighlightAttributesInRange(attributes, start + 1 + match[2].length + 1, value.length)

  type ?= typesHelper.parseType(contentString)
  if type is 'task'
    item.addBodyHighlightAttributesInRange(link: 'button://toggledone', lead: '', 0, 1)
    if contentString.length > 2
      item.addBodyHighlightAttributeInRange('content', '', 2, contentString.length - 2)
  else if type is 'project'
    if contentString.length > 1
      item.addBodyHighlightAttributeInRange('content', '', 0, contentString.length - 1)
  else
    if contentString
      item.addBodyHighlightAttributeInRange('content', '', 0, contentString.length)

  smartLinks.highlightLinks(item)

module.exports =
  processItemDidChangeBody: processItemDidChangeBody
  processItemDidChangeAttribute: processItemDidChangeAttribute
