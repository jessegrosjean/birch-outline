SpanLeaf = require './span-leaf'

class SpanBranch

  constructor: (@children) ->
    @indexParent = null
    spanCount = 0
    length = 0
    for each in @children
      each.indexParent = this
      spanCount += each.getSpanCount()
      length += each.getLength()
    @spanCount = spanCount
    @length = length

  clone: ->
    children = []
    for each in @children
      children.push(each.clone())
    new @constructor(children)

  ###
  Section: Characters
  ###

  getLength: ->
    @length

  getString: ->
    strings = []
    for each in @children
      strings.push(each.getString())
    strings.join('')

  getLocation: (child) ->
    length = @indexParent?.getLocation(this) or 0
    if child
      for each in @children
        if each is child
          break
        length += each.getLength()
    length

  ###
  Section: Spans
  ###

  getSpanCount: ->
    @spanCount

  getSpan: (index) ->
    for each in @children
      childSpanCount = each.getSpanCount()
      if index >= childSpanCount
        index -= childSpanCount
      else
        return each.getSpan(index)

  getSpanIndex: (child) ->
    index = @indexParent?.getSpanIndex(this) or 0
    if child
      for each in @children
        if each is child
          break
        index += each.getSpanCount()
    index

  getSpanInfoAtLocation: (location, spanIndex=0, spanLocation=0) ->
    for each in @children
      childLength = each.getLength()
      if location > childLength
        location -= childLength
        spanIndex += each.getSpanCount()
        spanLocation += childLength
      else
        return each.getSpanInfoAtLocation(location, spanIndex, spanLocation)

  getSpans: (start, count) ->
    start ?= 0
    count ?= @getSpanCount() - start

    spans = []
    @iterateSpans start, count, (span) ->
      spans.push(span)
    spans

  iterateSpans: (spanIndex, count, operation) ->
    for child in @children
      childSpanCount = child.getSpanCount()
      if spanIndex < childSpanCount
        used = Math.min(count, childSpanCount - spanIndex)
        if child.iterateSpans(spanIndex, used, operation) is false
          return false
        if (count -= used) is 0
          break
        spanIndex = 0
      else
        spanIndex -= childSpanCount

  insertSpans: (spanIndex, spans) ->
    @spanCount += spans.length

    for each in spans
      @length += each.getLength()

    for child, i in @children
      childSpanCount = child.getSpanCount()
      if spanIndex <= childSpanCount
        child.insertSpans(spanIndex, spans)
        if child instanceof SpanLeaf and child.children.length > 50
          while child.children.length > 50
            spilled = child.children.splice(child.children.length - 25, 25)
            newleaf = new SpanLeaf(spilled)
            child.length -= newleaf.length
            @children.splice(i + 1, 0, newleaf)
            newleaf.indexParent = this
          @maybeSpill()
        break
      spanIndex -= childSpanCount

  removeSpans: (spanIndex, removeCount) ->
    @spanCount -= removeCount
    i = 0
    while child = @children[i]
      childSpanCount = child.getSpanCount()
      if spanIndex < childSpanCount
        childDeleteCount = Math.min(removeCount, childSpanCount - spanIndex)
        childOldCharactersCount = child.getLength()
        child.removeSpans(spanIndex, childDeleteCount)
        @length -= (childOldCharactersCount - child.getLength())
        if childSpanCount is childDeleteCount
          @children.splice(i--, 1)
          child.indexParent = null
        if (removeCount -= childDeleteCount) is 0
          break
        spanIndex = 0
      else
        spanIndex -= childSpanCount
      i++
    @maybeCollapse(removeCount)

  mergeSpans: (spanIndex, count) ->
    prev = null
    removeStart = spanIndex
    removeRanges = []
    removeRange = null
    @iterateSpans spanIndex, count, (each) ->
      if prev?.mergeWithSpan(each)
        unless removeRange
          removeRange = spanIndex: removeStart count: 0
          removeRanges.push(removeRange)
        removeRange.count++
      else
        removeRange = null
        removeStart++
    for each in removeRanges
      @removeSpans(each.spanIndex, each.count)

  ###
  Section: Tree Balance
  ###

  maybeSpill: ->
    if @children.length <= 10
      return

    current = this
    while current.children.length > 10
      spilled = current.children.splice(current.children.length - 5, 5)
      sibling = new SpanBranch(spilled)
      if current.indexParent
        current.spanCount -= sibling.spanCount
        current.length -= sibling.length
        index = current.indexParent.children.indexOf(current)
        current.indexParent.children.splice(index + 1, 0, sibling)
      else
        copy = new SpanBranch(current.children)
        copy.indexParent = current
        current.children = [copy, sibling]
        current = copy
      sibling.indexParent = current.indexParent
    current.indexParent.maybeSpill()

  maybeCollapse: (removeCount) ->
    if (@spanCount - removeCount) > 25
      return

    if @children.length > 1 or not (@children[0] instanceof SpanLeaf)
      spans = []
      @collapse(spans)
      @children = [new SpanLeaf(spans)]
      @children[0].indexParent = this

  collapse: (spans) ->
    for each in @children
      each.collapse(spans)

module.exports = SpanBranch
