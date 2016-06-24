{ assert } = require './util'

{ assert } = require './util'

# Public: A record of a single change in an {Item}.
#
# A new mutation is created to record each attribute set, body text change,
# and child item update. Use {Outline::onDidChange} to receive this mutation
# record so you can track what changes as an outline is edited.
module.exports =
class Mutation

  ###
  Section: Constants
  ###

  # Public: ATTRIBUTE_CHANGED Mutation type constant.
  @ATTRIBUTE_CHANGED: 'attribute'

  # Public: BODY_CHANGED Mutation type constant.
  @BODY_CHANGED: 'body'

  # Public: CHILDREN_CHANGED Mutation type constant.
  @CHILDREN_CHANGED: 'children'

  ###
  Section: Attribute
  ###

  # Public: Read-only {Item} target of the mutation.
  target: null

  # Public: Read-only type of change. {Mutation.ATTRIBUTE_CHANGED},
  # {Mutation.BODY_CHANGED}, or {Mutation.CHILDREN_CHANGED}.
  type: null

  # Public: Read-only name of changed attribute in the target {Item}, or null.
  attributeName: null

  # Public: Read-only previous value of changed attribute in the target
  # {Item}, or null.
  attributeOldValue: null

  # Public: Read-only value of the body text location where the insert started
  # in the target {Item}, or null.
  insertedTextLocation: null

  # Public: Read-only value of length of the inserted body text in the target
  # {Item}, or null.
  insertedTextLength: null

  # Public: Read-only {AttributedString} of replaced body text in the target
  # {Item}, or null.
  replacedText: null

  # Public: Read-only {Array} of child {Item}s added to the target.
  addedItems: null

  # Public: Read-only {Array} of child {Item}s removed from the target.
  removedItems: null

  # Public: Read-only previous sibling {Item} of the added or removed Items,
  # or null.
  previousSibling: null

  # Public: Read-only next sibling {Item} of the added or removed Items, or
  # null.
  nextSibling: null

  @createAttributeMutation: (target, attributeName, attributeOldValue) ->
    assert(attributeName, 'Expect valid attribute name')
    mutation = new Mutation target, Mutation.ATTRIBUTE_CHANGED
    mutation.attributeName = attributeName
    mutation.attributeOldValue = attributeOldValue
    mutation

  @createBodyMutation: (target, insertedTextLocation, insertedTextLength, replacedText) ->
    assert(insertedTextLocation?, 'Expect valid insertedTextLocation')
    assert(insertedTextLength?, 'Expect valid insertedTextLength')
    mutation = new Mutation target, Mutation.BODY_CHANGED
    mutation.insertedTextLocation = insertedTextLocation
    mutation.insertedTextLength = insertedTextLength
    mutation.replacedText = replacedText
    mutation

  @createChildrenMutation: (target, addedItems, removedItems, previousSibling, nextSibling) ->
    assert(addedItems.length > 0 or removedItems.length > 0, 'Children added or removed')
    mutation = new Mutation target, Mutation.CHILDREN_CHANGED
    mutation.addedItems = addedItems or []
    mutation.removedItems = removedItems or []
    mutation.previousSibling = previousSibling
    mutation.nextSibling = nextSibling
    mutation

  constructor: (@target, @type) ->
    @flattendedAddedItems = null
    @flattenedRemovedItems = null

  copy: ->
    mutation = new Mutation @target, @type
    mutation.attributeName = @attributeName
    mutation.attributeNewValue = @attributeNewValue
    mutation.attributeOldValue = @attributeOldValue
    mutation.insertedTextLocation = @insertedTextLocation
    mutation.insertedTextLength = @insertedTextLength
    mutation.replacedText = @replacedText?.copy()
    mutation.addedItems = @addedItems
    mutation.removedItems = @removedItems
    mutation.previousSibling = @previousSibling
    mutation.nextSibling = @nextSibling
    mutation

  getFlattendedAddedItems: ->
    unless @flattendedAddedItems
      @flattendedAddedItems = []
      for each in @addedItems
        @flattendedAddedItems.push each
        if each.hasChildren
          for eachDescendant in each.descendants
            @flattendedAddedItems.push(eachDescendant)
    @flattendedAddedItems

  getFlattendedAddedItemIDs: ->
    (each.id for each in @getFlattendedAddedItems())

  getFlattendedRemovedItems: ->
    unless @flattenedRemovedItems
      @flattenedRemovedItems = []
      for each in @removedItems
        @flattenedRemovedItems.push each
        if each.hasChildren
          for eachDescendant in each.descendants
            @flattenedRemovedItems.push(eachDescendant)
    @flattenedRemovedItems

  getFlattendedRemovedItemIDs: ->
    (each.id for each in @getFlattendedRemovedItems())

  performUndoOperation: ->
    switch @type
      when Mutation.ATTRIBUTE_CHANGED
        @target.setAttribute @attributeName, @attributeOldValue

      when Mutation.BODY_CHANGED
        @target.replaceBodyRange(@insertedTextLocation, @insertedTextLength, @replacedText)

      when Mutation.CHILDREN_CHANGED
        if @addedItems.length
          @target.removeChildren @addedItems

        if @removedItems.length
          @target.insertChildrenBefore @removedItems, @nextSibling

  coalesce: (operation) ->
    return false unless operation instanceof Mutation
    return false unless @target is operation.target
    return false unless @type is operation.type
    return false unless @type is Mutation.BODY_CHANGED

    thisInsertedTextLocation = @insertedTextLocation
    thisInsertLength = @insertedTextLength
    thisInsertEnd = thisInsertedTextLocation + thisInsertLength
    thisInsertEnd = thisInsertedTextLocation + thisInsertLength

    newInsertedTextLocation = operation.insertedTextLocation
    newInsertedTextLength = operation.insertedTextLength
    newReplaceLength = operation.replacedText.length
    newReplaceEnd = newInsertedTextLocation + newReplaceLength

    singleInsertAtEnd = newInsertedTextLocation is thisInsertEnd and newInsertedTextLength is 1 and newReplaceLength is 0
    singleDeleteFromEnd = newReplaceEnd is thisInsertEnd and newInsertedTextLength is 0 and newReplaceLength is 1

    if singleInsertAtEnd
      @insertedTextLength++
      true
    else if singleDeleteFromEnd
      if newInsertedTextLocation < thisInsertedTextLocation
        @replacedText.insertText 0, operation.replacedText
        @insertedTextLocation--
      else
        @insertedTextLength--
      true
    else
      false
