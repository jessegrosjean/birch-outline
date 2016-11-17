Item = require '../../item'

# Tag word
tagWordStartCharsRegex = /[A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD]/
tagWordCharsRegex =  /[\-.0-9\u00B7\u0300-\u036F\u203F-\u2040]/
tagWordRegexString = "(?:#{tagWordStartCharsRegex.source}|#{tagWordCharsRegex.source})*"

# Tag value
tagValueRegex = /\(((?:\\\(|\\\)|[^()])*)\)/
tagValueRegexString = tagValueRegex.source

# Tag
tagRegexString = "(^|\\s+)@(#{tagWordRegexString})(?:#{tagValueRegexString})?(?=\\s|$)"
tagRegex = new RegExp(tagRegexString, 'g')

# Trailing Tags
trailingTagsRegex = new RegExp("(#{tagRegexString})+\\s*$", 'g')

reservedTags =
  'data-id': true
  'data-text': true
  'data-type': true

tagRange = (text, tag) ->
  result = undefined
  tag = 'data-' + tag
  parseTags text, (eachTag, eachValue, eachMatch) ->
    if tag is eachTag
      result =
        location: eachMatch.index
        length: eachMatch[0].length
  result

encodeTag = (tag, value) ->
  if value
    value = Item.objectToAttributeValueString(value)
    value = value.replace(/\)/g, '\\)')
    value = value.replace(/\(/g, '\\(')
    "@#{tag}(#{value})"
  else
    "@#{tag}"

addTag = (item, tag, value) ->
  tagString = encodeTag(tag, value)
  range = tagRange(item.bodyString, tag)
  unless range
    range =
      location: item.bodyString.length
      length: 0
  if range.location > 0 and not /\s+$/.test(item.bodyString)
    tagString = ' ' + tagString
  item.replaceBodyRange(range.location, range.length, tagString)

removeTag = (item, tag) ->
  if range = tagRange(item.bodyString, tag)
    item.replaceBodyRange(range.location, range.length, '')

parseTags = (text, callback) ->
  tags = {}
  if text.indexOf('@') isnt -1
    foundTag = false
    while match = tagRegex.exec(text)
      foundTag = true
      leadingSpace = match[1]
      tag = 'data-' + match[2]
      value = match[3] ? ''
      if not tags[tag]? and encodesAttributeName(tag)
        value = value.replace(/\\\)/g, ')')
        value = value.replace(/\\\(/g, '(')
        tags[tag] = value
        if callback
          callback(tag, value, match)
    if foundTag
      trailingMatch = text.match(trailingTagsRegex)

  {} =
    tags: tags
    trailingMatch: trailingMatch

syncTagAttributeToItemBody = (item, attributeName, value) ->
  if tagName = encodeNameForAttributeName(attributeName)
    if value?
      addTag(item, tagName, value)
    else
      removeTag(item, tagName)

encodesAttributeName = (attributeName) ->
  not reservedTags[attributeName] and (attributeName.indexOf('data-') is 0)

encodeNameForAttributeName = (attributeName) ->
  if encodesAttributeName(attributeName)
    attributeName.substr(5)
  else
    null

module.exports =
  syncTagAttributeToItemBody: syncTagAttributeToItemBody
  encodeNameForAttributeName: encodeNameForAttributeName
  encodesAttributeName: encodesAttributeName
  tagRegex: tagRegex
  tagRange: tagRange
  encodeTag: encodeTag
  parseTags: parseTags
