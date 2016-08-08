AttributedString = require './attributed-string'
DateTime = require './date-time'
ItemPath = require './item-path'
Mutation = require './mutation'
_ = require 'underscore-plus'
{ assert } = require './util'

# Public: A paragraph of text in an {Outline}.
#
# Items cannot be created directly. Use {Outline::createItem} to create items.
#
# Items may contain other child items to form a hierarchy. When you move an
# item its children move with it. See the "Structure" and "Mutate Structure"
# sections for associated APIs. To move an item while leaving it's children in
# place see the methods in {Outline}s "Insert & Remove Items".
#
# Items may have associated attributes. You can add your own attributes by
# using the APIs described in the "Item Attributes" section. For example you might
# add a due date using the `data-due-date` attribute.
#
# Items have an associated paragraph of body text. You can access it as plain
# text or as an immutable {AttributedString}. You can also add and remove
# attributes from ranges of body text. See "Item Body Text" for associated
# APIs. While you can add these attributes at runtime, TaskPaper won't save
# them to disk since it saved in plain text without associated text run
# attributes.
#
# ## Examples
#
# Create Items:
#
# ```javascript
# var item = outline.createItem('Hello World!');
# outline.root.appendChildren(item);
# ```
#
# Add attributes to body text:
#
# ```javascript
# var item = outline.createItem('Hello World!');
# item.addBodyAttributeInRange('B', {}, 6, 5);
# item.addBodyAttributeInRange('I', {}, 0, 11);
# ```
#
# Reading attributes from body text:
#
# ```javascript
# var effectiveRange = {};
# var textLength = item.bodyString.length;
# var index = 0;
# while (index < textLength) {
#   console.log(item.getBodyAttributesAtIndex(index, effectiveRange));
#   index += effectiveRange.length;
# }
#```
module.exports =
class Item

  constructor: (outline, text, id, remappedIDCallback) ->
    @id = outline.nextOutlineUniqueItemID(id)
    @outline = outline
    @inOutline = false
    @bodyHighlighted = null

    if text instanceof AttributedString
      @body = text
    else
      @body = new AttributedString(text)

    outline.itemDidChangeBody(this, '')

    if id isnt @id
      if remappedIDCallback and id
        remappedIDCallback(id, @id, this)

  ###
  Section: Properties
  ###

  # Public: Read-only unique {String} identifier.
  id: null

  # Public: Read-only {Outline} that this item belongs to.
  outline: null

  ###
  Section: Clone
  ###

  # Public: Clones this item.
  #
  # - `deep` (optional) defaults to true.
  #
  # Returns a duplicate {Item} with a new {::id}.
  clone: (deep, remappedIDCallback) ->
    @outline.cloneItem(this, deep, remappedIDCallback)


  ###
  Section: Structure
  ###

  # Public: Read-only true if item is contained by root of owning {Outline}.
  isInOutline: false
  Object.defineProperty @::, 'isInOutline',
    get: -> @inOutline
    set: (isInOutline) ->
      unless @inOutline is isInOutline
        if isInOutline
          @outline.idsToItems.set(@id, @)
        else
          @outline.idsToItems.delete(@id)

        @inOutline = isInOutline
        each = @firstChild
        while each
          each.isInOutline = isInOutline
          each = each.nextSibling
      @

  # Public: Read-only true if is {::outline} root {Item}.
  isOutlineRoot: null
  Object.defineProperty @::, 'isOutlineRoot',
    get: -> this is @outline.root

  localRoot: null
  Object.defineProperty @::, 'localRoot',
    get: ->
      if @isInOutline
        @outline.root
      else
        each = this
        while each.parent
          each = each.parent
        each

  # Public: Read-only depth of {Item} in outline structure. Calculated by
  # summing the {Item::indent} of this item and it's ancestors.
  depth: null
  Object.defineProperty @::, 'depth',
    get: ->
      depth = @indent
      ancestor = @parent
      while ancestor
        depth += ancestor.indent
        ancestor = ancestor.parent
      depth

  row: null
  Object.defineProperty @::, 'row',
    get: ->
      if @isOutlineRoot
        return -1
      row = 0
      each = @previousItem
      while each
        row++
        each = each.previousItem
      row

  # Public: Read-only parent {Item}.
  parent: null

  # Public: Read-only first child {Item}.
  firstChild: null

  # Public: Read-only last child {Item}.
  lastChild: null

  # Public: Read-only previous sibling {Item}.
  previousSibling: null

  # Public: Read-only next sibling {Item}.
  nextSibling: null

  # Public: Read-only previous branch {Item}.
  previousBranch: null
  Object.defineProperty @::, 'previousBranch',
    get: -> @previousSibling or @previousItem

  # Public: Read-only next branch {Item}.
  nextBranch: null
  Object.defineProperty @::, 'nextBranch',
    get: -> @lastBranchItem.nextItem

  # Public: Read-only {Array} of ancestor {Item}s.
  ancestors: null
  Object.defineProperty @::, 'ancestors',
    get: ->
      ancestors = []
      each = @parent
      while each
        ancestors.unshift(each)
        each = each.parent
      ancestors

  # Public: Read-only {Array} of descendant {Item}s.
  descendants: null
  Object.defineProperty @::, 'descendants',
    get: ->
      descendants = []
      end = @nextBranch
      each = @nextItem
      while each isnt end
        descendants.push(each)
        each = each.nextItem
      descendants

  # Public: Read-only last descendant {Item}.
  lastDescendant: null
  Object.defineProperty @::, 'lastDescendant',
    get: ->
      each = @lastChild
      while each?.lastChild
        each = each.lastChild
      each

  # Public: Read-only {Array} of this {Item} and its descendants.
  branchItems: null
  Object.defineProperty @::, 'branchItems',
    get: ->
      descendants = @descendants
      descendants.unshift(this)
      descendants

  # Public: Last {Item} in branch rooted at this item.
  lastBranchItem: null
  Object.defineProperty @::, 'lastBranchItem',
    get: -> @lastDescendant or this

  # Public: Read-only previous {Item} in the outline.
  previousItem: null
  Object.defineProperty @::, 'previousItem',
    get: ->
      previousSibling = @previousSibling
      if previousSibling
        previousSibling.lastBranchItem
      else
        parent = @parent
        if not parent or parent.isOutlineRoot
          null
        else
          parent

  Object.defineProperty @::, 'previousItemOrRoot',
    get: -> @previousItem or @parent

  # Public: Read-only next {Item} in the outline.
  nextItem: null
  Object.defineProperty @::, 'nextItem',
    get: ->
      firstChild = @firstChild
      if firstChild
        return firstChild

      nextSibling = @nextSibling
      if nextSibling
        return nextSibling

      parent = @parent
      while parent
        nextSibling = parent.nextSibling
        if nextSibling
          return nextSibling
        parent = parent.parent

      null

  # Public: Read-only has children {Boolean}.
  hasChildren: null
  Object.defineProperty @::, 'hasChildren',
    get: -> not not @firstChild

  # Public: Read-only {Array} of child {Item}s.
  children: null
  Object.defineProperty @::, 'children',
    get: ->
      children = []
      each = @firstChild
      while each
        children.push(each)
        each = each.nextSibling
      children

  # Public: Determines if this item contains the given item.
  #
  # - `item` The {Item} to check for containment.
  #
  # Returns {Boolean}.
  contains: (item) ->
    ancestor = item?.parent
    while ancestor
      if ancestor is this
        return true
      ancestor = ancestor.parent
    false

  # Public: Given an array of items determines and returns the common
  # ancestors of those items.
  #
  # - `items` {Array} of {Item}s.
  #
  # Returns a {Array} of common ancestor {Item}s.
  @getCommonAncestors: (items) ->
    commonAncestors = []
    itemIDs = {}

    for each in items
      itemIDs[each.id] = true

    for each in items
      p = each.parent
      while p and not itemIDs[p.id]
        p = p.parent
      unless p
        commonAncestors.push each

    commonAncestors

  @_insertGroup: (group, groupDepth, stack, roots) ->
    top = stack[stack.length - 1]
    while top and top.depth > groupDepth
      top = stack.pop()

    if top and top.depth is groupDepth
      parent = top.parent
    else
      stack.push(top)
      parent = top

    if parent
      for each in group
        each.indent = groupDepth - parent.depth
      parent.insertChildrenBefore(group, null, true)
    else
      for each in group
        roots.push(each)

    stack.push(group[group.length - 1])

  @buildItemHiearchy: (items, stack=[]) ->
    Item.removeItemsFromParents(items)

    roots = []

    for each in items
      if groupDepth is each.depth
        group.push(each)
      else
        if group
          @_insertGroup(group, groupDepth, stack, roots)
        groupDepth = each.depth
        group = [each]

    if group
      @_insertGroup(group, groupDepth, stack, roots)

    roots

  @flattenItemHiearchy: (items, removeFromParents=true) ->
    flattenedItems = []
    for each in items
      flattenedItems.push(each)
      if each.hasChildren
        for eachDescendant in each.descendants
          flattenedItems.push(eachDescendant)
    if removeFromParents
      each.removeFromParent() for each in flattenedItems
    flattenedItems

  # Removes items efficiently in minimal number of mutations. Assumes that
  # items are in continiguous outline order. Processes items in reverse order
  # so that children are removed first, to better maintain undo stack.
  @removeItemsFromParents: (items) ->
    siblings = []
    next = null
    for each in items by -1
      if not next or next.previousSibling is each
        siblings.unshift(each)
      else
        siblings[0].parent?.removeChildren(siblings)
        siblings = [each]
      next = each
    if siblings.length
      siblings[0].parent?.removeChildren(siblings)

  @itemsWithAncestors: (items) ->
    ancestorsAndItems = []
    addedIDs = {}
    for each in items
      index = ancestorsAndItems.length
      while each
        if addedIDs[each.id]
          continue
        else
          ancestorsAndItems.splice(index, 0, each)
          addedIDs[each.id] = true
        each = each.parent
    ancestorsAndItems

  ###
  Section: Mutate Structure
  ###

  # Public: Visual indent of {Item} relative to parent. Normally this will be
  # 1 for children with a parent as they are indented one level beyond there
  # parent. But items can be visually over-indented in which case this value
  # would be greater then 1.
  indent: null
  Object.defineProperty @::, 'indent',
    get: ->
      if indent = @getAttribute('indent')
        parseInt(indent, 10)
      else if @parent
        1
      else
        0

    set: (indent) ->
      indent = 1 if indent < 1

      if previousSibling = @previousSibling
        assert(indent <= previousSibling.indent, 'item indent must be less then or equal to previousSibling indent')

      if nextSibling = @nextSibling
        assert(indent >= nextSibling.indent, 'item indent must be greater then or equal to nextSibling indent')

      if @parent and indent is 1
        indent = null
      else if indent < 1
        indent = null

      @setAttribute('indent', indent)

  # Public: Insert the new children before the referenced sibling in this
  # item's list of children. If referenceSibling isn't defined the new children are
  # inserted at the end. This method resets the indent of children to match
  # referenceSibling's indent or to 1.
  #
  # - `children` {Item} or {Array} of {Item}s to insert.
  # - `referenceSibling` (optional) The referenced sibling {Item} to insert before.
  insertChildrenBefore: (children, referenceSibling, maintainIndentHack=false) ->
    unless Array.isArray(children)
      children = [children]

    unless children.length
      return

    isInOutline = @isInOutline
    outline = @outline

    if isInOutline
      outline.beginChanges()
      outline.undoManager.beginUndoGrouping()

    Item.removeItemsFromParents(children)

    if referenceSibling
      assert(referenceSibling.parent is @, 'referenceSibling must be child of this item')
      previousSibling = referenceSibling.previousSibling
    else
      previousSibling = @lastChild

    if isInOutline
      mutation = Mutation.createChildrenMutation this, children, [], previousSibling, referenceSibling
      outline.willChange(mutation)
      outline.recordChange mutation

    for each, i in children
      assert(each.parent isnt @, 'insert items must not already be children')
      assert(each.outline is @outline, 'children must share same outline as parent')
      each.previousSibling = children[i - 1]
      each.nextSibling = children[i + 1]
      each.parent = this

    firstChild = children[0]
    lastChild = children[children.length - 1]

    firstChild.previousSibling = previousSibling
    previousSibling?.nextSibling = firstChild
    lastChild.nextSibling = referenceSibling
    referenceSibling?.previousSibling = lastChild

    if not firstChild.previousSibling
      @firstChild = firstChild
    if not lastChild.nextSibling
      @lastChild = lastChild

    unless maintainIndentHack
      childIndent = previousSibling?.indent ? referenceSibling?.indent ? 1
      for each in children by -1
        each.indent = childIndent

    if isInOutline
      for each in children
        each.isInOutline = true
      outline.didChange(mutation)
      outline.undoManager.endUndoGrouping()
      outline.endChanges()

  # Public: Append the new children to this item's list of children.
  #
  # - `children` {Item} or {Array} of {Item}s to append.
  appendChildren: (children) ->
    @insertChildrenBefore(children, null)

  # Public: Remove the children from this item's list of children. When an
  # item is removed its the parent's {::depth} is added to the removed item's
  # {::indent}, preserving the removed items depth if needed later.
  #
  # - `children` {Item} or {Array} of child {Item}s to remove.
  removeChildren: (children) ->
    unless Array.isArray(children)
      children = [children]

    unless children.length
      return

    isInOutline = @isInOutline
    outline = @outline

    firstChild = children[0]
    lastChild = children[children.length - 1]
    previousSibling = firstChild.previousSibling
    nextSibling = lastChild.nextSibling

    if isInOutline
      mutation = Mutation.createChildrenMutation this, [], children, previousSibling, nextSibling
      outline.willChange(mutation)
      outline.beginChanges()
      outline.undoManager.beginUndoGrouping()
      outline.recordChange mutation

    previousSibling?.nextSibling = nextSibling
    nextSibling?.previousSibling = previousSibling

    if firstChild is @firstChild
      @firstChild = nextSibling
    if lastChild is @lastChild
      @lastChild = previousSibling

    depth = @depth
    for each in children
      assert(each.parent is @, 'removed items must be children of this item')
      eachIndent = each.indent
      each.isInOutline = false
      each.nextSibling = null
      each.previousSibling = null
      each.parent = null
      each.indent = eachIndent + depth

    if isInOutline
      outline.didChange(mutation)
      outline.undoManager.endUndoGrouping()
      outline.endChanges()

  # Public: Remove this item from it's parent item if it has a parent.
  removeFromParent: ->
    @parent?.removeChildren(this)

  ###
  Section: Item Attributes
  ###

  tagName: null # Not used, except for in stylesheet-spec right now.
  Object.defineProperty @::, 'tagName',
    get: -> 'item'

  ###
  Not going to support nested elements for styling, makes invalidating to hard for now.
  parentNode: null
  Object.defineProperty @::, 'parentNode',
    get: -> @parent
  ###

  # Public: Read-only key/value object of the attributes associated with this
  # {Item}.
  attributes: null

  # Public: Read-only {Array} of this {Item}'s attribute names.
  attributeNames: null
  Object.defineProperty @::, 'attributeNames',
    get: ->
      if @attributes
        Object.keys(@attributes).sort()
      else
        []

  # Public: Return {Boolean} `true` if this item has the given attribute.
  #
  # - `name` The {String} attribute name.
  hasAttribute: (name) ->
    @attributes?[name]?

  # Public: Return the value of the given attribute. If the attribute does not
  # exist will return `null`. Attribute values are always stored as {String}s.
  # Use the `class` and `array` parameters to parse the string values to other
  # types before returning.
  #
  # - `name` The {String} attribute name.
  # - `clazz` (optional) Class ({Number} or {Date}) to parse string values to objects of given class.
  # - `array` (optional) {Boolean} true if should split comma separated string value to create an array.
  #
  # Returns attribute value.
  getAttribute: (name, clazz, array) ->
    if value = @attributes?[name]
      if array and (typeof value is 'string')
        value = value.split /\s*,\s*/
        if clazz
          value = (Item.attributeValueStringToObject(each, clazz) for each in value)
      else if clazz and (typeof value is 'string')
        value = Item.attributeValueStringToObject value, clazz
    value

  # Public: Adds a new attribute or changes the value of an existing
  # attribute. `id` is reserved and an exception is thrown if you try to set
  # it. Setting an attribute to `null` or `undefined` removes the attribute.
  # Generally all item attribute names should start with `data-` to avoid
  # conflict with built in attribute names.
  #
  # Attribute values are always stored as {String}s so they will stay
  # consistent through any serialization process. For example if you set an
  # attribute to the Number `1.0` when you {::getAttribute} the value is the
  # {String} `"1.0"`. See {::getAttribute} for options to automatically
  # convert the stored {String} back to a {Number} or {Date}.
  #
  # - `name` The {String} attribute name.
  # - `value` The new attribute value.
  setAttribute: (name, value) ->
    assert(name isnt 'id', 'id is reserved attribute name')

    if value
      value = Item.objectToAttributeValueString(value)

    oldValue = @getAttribute name

    if value is oldValue
      return

    outline = @outline
    undoManager = outline.undoManager
    isInOutline = @isInOutline
    if isInOutline
      mutation = Mutation.createAttributeMutation this, name, oldValue
      outline.willChange(mutation)
      outline.beginChanges()
      outline.recordChange mutation
      undoManager.disableUndoRegistration()

    if value?
      unless @attributes
        @attributes = {}
      @attributes[name] = value
    else
      if @attributes
        delete @attributes[name]

    outline.itemDidChangeAttribute(this, name, value, oldValue)

    if isInOutline
      outline.didChange(mutation)
      outline.endChanges()
      undoManager.enableUndoRegistration()

  # Public: Removes an item attribute.
  #
  # - `name` The {String} attribute name.
  removeAttribute: (name) ->
    if @hasAttribute name
      @setAttribute name, null

  @attributeValueStringToObject: (value, clazz) ->
    switch clazz
      when Number
        parseFloat value
      when Date
        DateTime.parse(value)
      else
        value

  @objectToAttributeValueString: (object) ->
    switch typeof object
      when 'string'
        object
      when 'number'
        object.toString()
      when 'object'
        object.toString()
      else
        if object instanceof Date
          object.toISOString()
        else if Array.isArray(object)
          (Item.objectToAttributeValueString(each) for each in object).join ','
        else if object
          object.toString()
        else
          object

  ###
  Section: Item Body Text
  ###

  # Public: Body text as plain text {String}.
  bodyString: null
  Object.defineProperty @::, 'bodyString',
    get: ->
      @body.string.toString()
    set: (text='') ->
      @replaceBodyRange(0, -1, text)

  # Public: Body "content" text as plain text {String}. Excludes trailing tags
  # and leading syntax. For example used when displaying items to user's in
  # menus.
  bodyContentString: null
  Object.defineProperty @::, 'bodyContentString',
    get: ->
      range = {}
      if @bodyHighlightedAttributedString.getFirstOccuranceOfAttribute('content', null, range)?
        @bodyString.substr(range.location, range.length)
      else
        @bodyString

  bodyHTMLString: null
  Object.defineProperty @::, 'bodyHTMLString',
    get: -> @bodyAttributedString.toInlineBMLString()
    set: (html) ->
      @bodyAttributedString = AttributedString.fromInlineBMLString(html)

  # Public: Body text as immutable {AttributedString}. Do not modify this
  # AttributedString, instead use the other methods in this "Body Text"
  # section. They will both modify the string and create the appropriate
  # {Mutation} events needed to keep the outline valid.
  bodyAttributedString: null
  Object.defineProperty @::, 'bodyAttributedString',
    get: ->
      if @isOutlineRoot
        return new AttributedString
      @body
    set: (attributedText) ->
      @replaceBodyRange(0, -1, attributedText)

  # Public: Syntax highlighted body text as immutable {AttributedString}.
  # Unlike `bodyAttributedString` this string contains attributes created by
  # syntax highlighting such as tag name and value ranges.
  #
  # Do not modify this AttributedString, instead use the other methods in this
  # "Body Text" section. They will both modify the string and create the
  # appropriate {Mutation} events needed to keep the outline valid.
  bodyHighlightedAttributedString: null
  Object.defineProperty @::, 'bodyHighlightedAttributedString',
    get: ->
      @bodyHighlighted ? @body

  bodyAttributedSubstringFromRange: (location, length) ->
    @bodyAttributedString.attributedSubstringFromRange(location, length)

  # Public: Returns an {Object} with keys for each attribute at the given
  # character characterIndex, and by reference the range over which the
  # attributes apply.
  #
  # - `characterIndex` The character index.
  # - `effectiveRange` (optional) {Object} whose `location` and `length`
  #    properties are set to effective range of the attributes.
  # - `longestEffectiveRange` (optional) {Object} whose `location` and `length`
  #    properties are set to longest effective range of the attributes.
  getBodyAttributesAtIndex: (characterIndex, effectiveRange, longestEffectiveRange) ->
    @bodyAttributedString.getAttributesAtIndex(characterIndex, effectiveRange, longestEffectiveRange)

  # Public: Returns the value for an attribute with a given name of the
  # character at a given characterIndex, and by reference the range over which
  # the attribute applies.
  #
  # - `attribute` Attribute {String} name.
  # - `characterIndex` The character index.
  # - `effectiveRange` (optional) {Object} whose `location` and `length`
  #    properties are set to effective range of the attribute.
  # - `longestEffectiveRange` (optional) {Object} whose `location` and `length`
  #    properties are set to longest effective range of the attribute.
  getBodyAttributeAtIndex: (attribute, characterIndex, effectiveRange, longestEffectiveRange) ->
    @bodyAttributedString.getAttributeAtIndex(attribute, characterIndex, effectiveRange, longestEffectiveRange)

  # Sets the attributes for the characters in the given range to the
  # given attributes. Replacing any existing attributes in the range.
  #
  # - `attributes` {Object} with keys and values for each attribute
  # - `location` Start character index.
  # - `length` Range length.
  setBodyAttributesInRange: (attributes, location, length) ->
    @bodyAttributedString.setAttributesInRange(attributes, location, length)
    changedText = @bodyAttributedSubstringFromRange(location, length)
    changedText.setAttributesInRange(attributes, location, length)
    @replaceBodyRange(location, length, changedText)

  # Public: Adds an attribute to the characters in the given range.
  #
  # - `attribute` The {String} attribute name.
  # - `value` The attribute value.
  # - `location` Start character index.
  # - `length` Range length.
  addBodyAttributeInRange: (attribute, value, location, length) ->
    attributes = {}
    attributes[attribute] = value
    @addBodyAttributesInRange(attributes, location, length)

  # Public: Adds attributes to the characters in the given range.
  #
  # - `attributes` {Object} with keys and values for each attribute
  # - `location` Start index.
  # - `length` Range length.
  addBodyAttributesInRange: (attributes, location, length) ->
    for eachTagName of attributes
      assert(eachTagName is eachTagName.toLowerCase(), 'Tag Names Must be Lowercase')
    changedText = @bodyAttributedSubstringFromRange(location, length)
    changedText.addAttributesInRange(attributes, 0, length)
    @replaceBodyRange(location, length, changedText)

  # Public: Removes the attribute from the given range.
  #
  # - `attribute` The {String} attribute name
  # - `location` Start character index.
  # - `length` Range length.
  removeBodyAttributeInRange: (attribute, location, length) ->
    @removeBodyAttributesInRange([attribute], location, length)

  removeBodyAttributesInRange: (attributes, location, length) ->
    changedText = @bodyAttributedSubstringFromRange(location, length)
    for each in attributes
      changedText.removeAttributeInRange(each, 0, length)
    @replaceBodyRange(location, length, changedText)

  insertLineBreakInBody: (index) ->

  insertImageInBody: (index, image) ->

  # Public: Replace body text in the given range.
  #
  # - `location` Start character index.
  # - `length` Range length.
  # - `insertedText` {String} or {AttributedString}
  replaceBodyRange: (location, length, insertedText) ->
    if @isOutlineRoot
      return

    if insertedText instanceof AttributedString
      insertedString = insertedText.string
    else
      insertedString = insertedText

    if length is 0 and insertedString.length is 0
      return

    bodyAttributedString = @bodyAttributedString
    oldBody = bodyAttributedString.getString()
    isInOutline = @isInOutline
    outline = @outline
    undoManager = outline.undoManager

    assert(insertedString.indexOf('\n') is -1, 'Item body text cannot contain newlines')
    assert(location + length <= oldBody.length, 'Replace range end must not be greater then body text')

    if isInOutline
      replacedText = bodyAttributedString.attributedSubstringFromRange(location, length)
      if replacedText.length is 0 and insertedText.length is 0
        return
      mutation = Mutation.createBodyMutation this, location, insertedString.length, replacedText
      outline.willChange(mutation)
      outline.beginChanges()
      outline.recordChange mutation
      undoManager.disableUndoRegistration()

    bodyAttributedString.replaceRange(location, length, insertedText)
    @bodyHighlighted = null
    outline.itemDidChangeBody(this, oldBody)

    if isInOutline
      outline.didChange(mutation)
      outline.endChanges()
      undoManager.enableUndoRegistration()

  # Public: Append body text.
  #
  # - `text` {String} or {AttributedString}
  appendBody: (text) ->
    @replaceBodyRange(@bodyString.length, 0, text)

  addBodyHighlightAttributeInRange: (attribute, value, index, length) ->
    unless @bodyHighlighted
      @bodyHighlighted = @bodyAttributedString.clone()
    @bodyHighlighted.addAttributeInRange(attribute, value, index, length)

  addBodyHighlightAttributesInRange: (attributes, index, length) ->
    unless @bodyHighlighted
      @bodyHighlighted = @bodyAttributedString.clone()
    @bodyHighlighted.addAttributesInRange(attributes, index, length)

  ###
  Section: Debug
  ###

  # Extended: Returns debug string for this item and it's descendants.
  branchToString: (depthString) ->
    depthString ?= ''
    indent = @indent

    while indent
      depthString += '  '
      indent--

    results = [@toString(depthString)]
    for each in @children
      results.push(each.branchToString(depthString))
    results.join('\n')

  # Extended: Returns debug string for this item.
  toString: (depthString) ->
    (depthString or '') + '(' + @id + ') ' + @body.toString()
