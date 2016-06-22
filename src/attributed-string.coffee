RunBuffer = require './run-buffer'
{Emitter} = require 'event-kit'
_ = require 'underscore-plus'

# Public: A container holding both characters and associated attributes.
#
# ## Examples
#
# Enumerate attribute ranges:
#
# ```javascript
# var effectiveRange = {};
# var textLength = attributedString.length;
# var index = 0;
# while (index < textLength) {
#   console.log(attributedString.getAttributesAtIndex(index, effectiveRange));
#   index += effectiveRange.length;
# }
#```
class AttributedString

  ###
  Section: Creating
  ###

  # Public: Create a new AttributedString with the given text.
  #
  # - `text` Text content for the AttributedString.
  constructor: (text='') ->
    if text instanceof AttributedString
      @string = text.getString()
      @runBuffer = text.runBuffer?.clone()
    else
      @string = text

  # Public: Return a clone of this AttributedString. The attributes are
  # shallow copied.
  clone: (location=0, length=-1) ->
    if length is -1
      length = @getLength() - location
    if length is 0
      new AttributedString()
    else
      clone = new AttributedString(@string.substr(location, length))
      if @runBuffer
        slice = @runBuffer.sliceSpansToRange(location, length)
        insertRuns = []
        @runBuffer.iterateRuns slice.spanIndex, slice.count, (run) ->
          insertRuns.push(run.clone())
        clone._getRunIndex().replaceSpansFromLocation(0, insertRuns)
      clone

  ###
  Section: Characters
  ###

  # Public: Read-only string
  string: null

  getString: ->
    @string.toString()

  getLength: ->
    @string.length

  length: null
  Object.defineProperty @::, 'length',
    get: -> @string.length

  substring: (start, end) ->
    @string.substring(start, end)

  substr: (start, length) ->
    @string.substr(start, length)

  charAt: (position) ->
    @string.charAt(position)

  charCodeAt: (position) ->
    @string.charCodeAt(position)

  # Public: Delete characters and attributes in range.
  #
  # - `location` Range start character index.
  # - `length` Range length.
  deleteRange: (location, length) ->
    unless length
      return
    @replaceRange(location, length, '')

  # Public: Insert text into the string.
  #
  # - `location` Location to insert at.
  # - `text` text to insert.
  insertText: (location, text) ->
    unless text.length
      return
    @replaceRange(location, 0, text)

  # Public: Append text to the end of the string.
  #
  # - `text` text to insert.
  appendText: (text) ->
    @insertText(@string.length, text)

  # Public: Replace existing text range with new text.
  #
  # - `location` Replace range start character index.
  # - `length` Replace range length.
  # - `text` text to insert.
  replaceRange: (location, length, text) ->
    if length is -1
      length = @getLength() - location

    if text instanceof AttributedString
      insertString = text.string
      if @runBuffer
        textRunBuffer = text._getRunIndex()
      else
        textRunBuffer = text.runBuffer
    else
      insertString = text

    insertString = insertString.split(/\u000d(?:\u000a)?|\u000a|\u2029|\u000c|\u0085/).join('\n')

    @string = @string.substr(0, location) + insertString + @string.substr(location + length)
    @runBuffer?.replaceRange(location, length, insertString)

    if textRunBuffer and text.length
      if @runBuffer
        @setAttributesInRange({}, location, text.length)
      insertRuns = []
      textRunBuffer.iterateRuns 0, textRunBuffer.getRunCount(), (run) ->
        insertRuns.push(run.clone())
      @_getRunIndex().replaceSpansFromLocation(location, insertRuns)

  ###
  Section: Attributes
  ###

  _getRunIndex: ->
    unless runBuffer = @runBuffer
      @runBuffer = runBuffer = new RunBuffer
      @runBuffer.insertString(0, @string.toString())
    runBuffer

  getRuns: ->
    if @runBuffer
      @runBuffer.getRuns()
    else
      []

  getFirstOccuranceOfAttribute: (attribute, effectiveRange, longestEffectiveRange) ->
    for eachRun in @getRuns()
      if eachRun.attributes[attribute]?
        return @getAttributeAtIndex(attribute, eachRun.getLocation(), effectiveRange, longestEffectiveRange)
    null

  # Public: Returns an {Object} with keys for each attribute at the given
  # character index, and by reference the range over which the
  # attributes apply.
  #
  # - `index` The character index.
  # - `effectiveRange` (optional) {Object} whose `location` and `length`
  #    properties are set to effective range of the attributes.
  # - `longestEffectiveRange` (optional) {Object} whose `location` and `length`
  #    properties are set to longest effective range of the attributes.
  getAttributesAtIndex: (index, effectiveRange, longestEffectiveRange) ->
    if index >= @length
      throw new Error("Invalide character index: #{index}")
    if @runBuffer
      @runBuffer.getAttributesAtIndex(index, effectiveRange, longestEffectiveRange)
    else
      if effectiveRange
        effectiveRange.location = 0
        effectiveRange.length = @length
      if longestEffectiveRange
        longestEffectiveRange.location = 0
        longestEffectiveRange.length = @length
      {}

  # Public: Returns the value for an attribute with a given name of the
  # character at a given character index, and by reference the range over which
  # the attribute applies.
  #
  # - `attribute` Attribute {String} name.
  # - `index` The character index.
  # - `effectiveRange` (optional) {Object} whose `location` and `length`
  #    properties are set to effective range of the attribute.
  # - `longestEffectiveRange` (optional) {Object} whose `location` and `length`
  #    properties are set to longest effective range of the attribute.
  getAttributeAtIndex: (attribute, index, effectiveRange, longestEffectiveRange) ->
    if index >= @length
      throw new Error("Invalide character index: #{index}")
    if @runBuffer
      @runBuffer.getAttributeAtIndex(attribute, index, effectiveRange, longestEffectiveRange)
    else
      if effectiveRange
        effectiveRange.location = 0
        effectiveRange.length = @length
      if longestEffectiveRange
        longestEffectiveRange.location = 0
        longestEffectiveRange.length = @length
      undefined

  # Sets the attributes for the characters in the given range to the
  # given attributes. Replacing any existing attributes in the range.
  #
  # - `attributes` {Object} with keys and values for each attribute
  # - `index` Start character index.
  # - `length` Range length.
  setAttributesInRange: (attributes, index, length) ->
    @_getRunIndex().setAttributesInRange(attributes, index, length)

  # Public: Adds an attribute to the characters in the given range.
  #
  # - `attribute` The {String} attribute name.
  # - `value` The attribute value.
  # - `index` Start character index.
  # - `length` Range length.
  addAttributeInRange: (attribute, value, index, length) ->
    @_getRunIndex().addAttributeInRange(attribute, value, index, length)

  # Public: Adds attributes to the characters in the given range.
  #
  # - `attributes` {Object} with keys and values for each attribute
  # - `index` Start index.
  # - `length` Range length.
  addAttributesInRange: (attributes, index, length) ->
    @_getRunIndex().addAttributesInRange(attributes, index, length)

  # Public: Removes the attribute from the given range.
  #
  # - `attribute` The {String} attribute name
  # - `index` Start character index.
  # - `length` Range length.
  removeAttributeInRange: (attribute, index, length) ->
    if @runBuffer
      @runBuffer.removeAttributeInRange(attribute, index, length)

  ###
  Section: Extracting a Substring
  ###

  # Public: Returns an {AttributedString} object consisting of the characters
  # and attributes within a given range in the receiver.
  #
  # - `location` (optional) Range start character index. Defaults to 0.
  # - `length` (optional) Range length. Defaults to end of string.
  attributedSubstringFromRange: (location=0, length=-1) ->
    @clone(location, length)

  ###
  Section: Debug
  ###

  # Public: Returns debug string for this item.
  toString: ->
    if @runBuffer
      @runBuffer.toString()
    else if @string
      "(#{@string})"
    else
      ''

AttributedString.ObjectReplacementCharacter = '\ufffc'
AttributedString.LineSeparatorCharacter = '\u2028'

module.exports = AttributedString

require './attributed-string-from-bml'
require './attributed-string-to-bml'
