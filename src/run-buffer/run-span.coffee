Span = require '../span-buffer/span'
_ = require 'underscore-plus'
assert = require 'assert'

# Still trying to figure this out. Isn't really an issue for TaskPaper format,
# but becomes an issue when serializaing to HTML. Question... how do you map
# string name/string value to inline HTML? Automatically embed in a span in
# that case? Maybe should make that translation immediatly... not sure! :)
validateAttributes = (attributes) ->
  for attribute, value of attributes
    assert.ok(_.isString(attribute), "Expected #{attribute} to be string")
    if value
      if _.isObject(value)
        for attribute, value of value
          assert.ok(_.isString(attribute), "Expected #{attribute} to be string")
          assert.ok(_.isString(value), "Expected #{value} to be string")
      else
        assert.ok(_.isString(value), "Expected #{value} to be string")

class RunSpan extends Span

  @attributes: null

  constructor: (text, @attributes={}) ->
    #validateAttributes(@attributes)
    super(text)

  clone: ->
    clone = super()
    clone.attributes = _.clone(@attributes)
    clone

  ###
  tagName: null
  Object.defineProperty @::, 'tagName',
    get: -> 'run'
  ###

  setAttributes: (attributes={}) ->
    @attributes = _.clone(attributes)
    #validateAttributes(@attributes)

  addAttribute: (attribute, value) ->
    @attributes[attribute] = value
    #validateAttributes(@attributes)

  addAttributes: (attributes) ->
    for k,v of attributes
      @attributes[k] = v
    #validateAttributes(@attributes)

  removeAttribute: (attribute) ->
    delete @attributes[attribute]

  mergeWithSpan: (run) ->
    if _.isEqual(@attributes, run.attributes)
      @setString(@string + run.string)
      true
    else
      false

  toString: ->
    sortedNames = for name of @attributes then name
    sortedNames.sort()
    nameValues = ("#{name}:#{JSON.stringify(@attributes[name])}" for name in sortedNames)
    super(nameValues.join('/'))

module.exports = RunSpan
