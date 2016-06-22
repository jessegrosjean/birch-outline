_ = require 'underscore-plus'

class Span

  constructor: (@string='') ->
    @indexParent = null

  clone: ->
    new @constructor(@string)

  split: (location) ->
    if location is 0 or location is @getLength()
      return null

    clone = @clone()
    clone.deleteRange(0, location)
    @deleteRange(location, @getLength() - location)
    clone

  mergeWithSpan: (span) ->
    false

  ###
  Section: Characters
  ###

  getLocation: ->
    @indexParent.getLocation(this) or 0

  getLength: ->
    @string.length

  getEnd: ->
    @getLocation() + @getLength()

  getString: ->
    @string

  setString: (string='') ->
    delta = (string.length - @string.length)
    @string = string
    if delta
      each = @indexParent
      while each
        each.length += delta
        each = each.indexParent
    @

  replaceRange: (location, length, string) ->
    newString = @string.substr(0, location) + string + @string.slice(location + length)
    @setString(newString)

  deleteRange: (location, length) ->
    @replaceRange(location, length, '')

  insertString: (location, string) ->
    @replaceRange(location, 0, string)

  appendString: (string) ->
    @insertString(@getLength(), string)

  ###
  Section: Spans
  ###

  getRoot: ->
    each = @indexParent
    while each
      if each.isRoot
        return each
      each = each.indexParent
    null

  getSpanIndex: ->
    @indexParent.getSpanIndex(this)

  getSpanCount: ->
    1

  ###
  Section: Debug
  ###

  toString: (extra) ->
    if extra
      "(#{@getString()}/#{extra})"
    else
      "(#{@getString()})"

module.exports = Span
