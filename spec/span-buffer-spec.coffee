SpanBuffer = require '../src/span-buffer'
Outline = require '../src/outline'
should = require('chai').should()

describe 'SpanBuffer', ->
  [spanIndex, bufferSubscription, indexDidChangeExpects] = []

  beforeEach ->
    spanIndex = new SpanBuffer()
    bufferSubscription = spanIndex.onDidChange (e) ->
      if indexDidChangeExpects
        exp = indexDidChangeExpects.shift()
        exp(e)

  afterEach ->
    if indexDidChangeExpects
      indexDidChangeExpects.length.should.equal(0)
      indexDidChangeExpects = null
    bufferSubscription.dispose()
    spanIndex.destroy()
    Outline.outlines.length.should.equal(0)

  it 'starts empty', ->
    spanIndex.getLength().should.equal(0)
    spanIndex.getSpanCount().should.equal(0)

  it 'is clonable', ->
    spanIndex.insertSpans 0, [
      spanIndex.createSpan('a'),
      spanIndex.createSpan('b'),
      spanIndex.createSpan('c')
    ]
    spanIndex.clone().toString().should.equal('(a)(b)(c)')

  describe 'Text', ->

    it 'insert text into empty adds span if needed', ->
      spanIndex.insertString(0, 'hello world')
      spanIndex.getLength().should.equal(11)
      spanIndex.getSpanCount().should.equal(1)
      spanIndex.toString().should.equal('(hello world)')

    it 'inserts text into correct span', ->
      spanIndex.insertSpans 0, [
        spanIndex.createSpan('a'),
        spanIndex.createSpan('b')
      ]
      spanIndex.insertString(0, 'a')
      spanIndex.toString().should.equal('(aa)(b)')
      spanIndex.insertString(2, 'a')
      spanIndex.toString().should.equal('(aaa)(b)')
      spanIndex.insertString(4, 'b')
      spanIndex.toString().should.equal('(aaa)(bb)')
      spanIndex.getString().should.equal('aaabb')

    it 'removes appropriate spans when text is deleted', ->
      spanIndex.insertSpans 0, [
        spanIndex.createSpan('a'),
        spanIndex.createSpan('b'),
        spanIndex.createSpan('c')
      ]
      sp0 = spanIndex.getSpan(0)
      sp1 = spanIndex.getSpan(1)
      sp2 = spanIndex.getSpan(2)

      spanIndex.deleteRange(0, 1)
      should.equal(sp0.indexParent, null)
      spanIndex.toString().should.equal('(b)(c)')

      spanIndex.deleteRange(1, 1)
      should.equal(sp2.indexParent, null)
      spanIndex.toString().should.equal('(b)')

    it 'delete text to empty deletes last span', ->
      spanIndex.insertString(0, 'hello world')
      spanIndex.deleteRange(0, 11)
      spanIndex.getLength().should.equal(0)
      spanIndex.getSpanCount().should.equal(0)
      spanIndex.toString().should.equal('')

  describe 'Spans', ->

    it 'clones spans', ->
      spanIndex.createSpan('one').getString().should.equal('one')

    it 'inserts spans', ->
      spanIndex.insertSpans 0, [
        spanIndex.createSpan('hello'),
        spanIndex.createSpan(' '),
        spanIndex.createSpan('world')
      ]
      spanIndex.toString().should.equal('(hello)( )(world)')

    it 'removes spans', ->
      spanIndex.insertSpans 0, [
        spanIndex.createSpan('hello'),
        spanIndex.createSpan(' '),
        spanIndex.createSpan('world')
      ]
      spanIndex.removeSpans(1, 2)
      spanIndex.toString().should.equal('(hello)')

    it 'slices spans at text location ', ->
      spanIndex.insertString(0, 'onetwo')
      spanIndex.sliceSpanAtLocation(0).should.eql(span: spanIndex.getSpan(0), spanIndex: 0, spanLocation: 0, location: 0)
      spanIndex.sliceSpanAtLocation(6).should.eql(span: spanIndex.getSpan(0), spanIndex: 0, spanLocation: 0, location: 6)
      spanIndex.toString().should.equal('(onetwo)')
      spanIndex.sliceSpanAtLocation(3).should.eql(span: spanIndex.getSpan(0), spanIndex: 0, spanLocation: 0, location: 3)
      spanIndex.toString().should.equal('(one)(two)')
      spanIndex.sliceSpanAtLocation(3).should.eql(span: spanIndex.getSpan(0), spanIndex: 0, spanLocation: 0, location: 3)

    it 'slice spans to range', ->
      spanIndex.insertString(0, 'onetwo')
      spanIndex.sliceSpansToRange(0, 6).should.eql(spanIndex: 0, count: 1)
      spanIndex.sliceSpansToRange(0, 2).should.eql(spanIndex: 0, count: 1)
      spanIndex.sliceSpansToRange(4, 2).should.eql(spanIndex: 2, count: 1)

    it 'finds span over character index', ->
      spanIndex.insertSpans(0, [
        spanIndex.createSpan('one'),
        spanIndex.createSpan('two')
      ])
      spanIndex.getSpanInfoAtCharacterIndex(0).should.eql(span: spanIndex.getSpan(0), spanIndex: 0, spanLocation: 0, location: 0)
      spanIndex.getSpanInfoAtCharacterIndex(1).should.eql(span: spanIndex.getSpan(0), spanIndex: 0, spanLocation: 0, location: 1)
      spanIndex.getSpanInfoAtCharacterIndex(2).should.eql(span: spanIndex.getSpan(0), spanIndex: 0, spanLocation: 0, location: 2)
      spanIndex.getSpanInfoAtCharacterIndex(3).should.eql(span: spanIndex.getSpan(1), spanIndex: 1, spanLocation: 3, location: 0)
      spanIndex.getSpanInfoAtCharacterIndex(4).should.eql(span: spanIndex.getSpan(1), spanIndex: 1, spanLocation: 3, location: 1)
      spanIndex.getSpanInfoAtCharacterIndex(5).should.eql(span: spanIndex.getSpan(1), spanIndex: 1, spanLocation: 3, location: 2)
      (-> spanIndex.getSpanInfoAtCharacterIndex(6)).should.throw()

    it 'get choose left span at cursor index', ->
      spanIndex.insertSpans(0, [
        spanIndex.createSpan('one'),
        spanIndex.createSpan('two')
      ])
      spanIndex.getSpanInfoAtLocation(0).should.eql(span: spanIndex.getSpan(0), spanIndex: 0, spanLocation: 0, location: 0)
      spanIndex.getSpanInfoAtLocation(1).should.eql(span: spanIndex.getSpan(0), spanIndex: 0, spanLocation: 0, location: 1)
      spanIndex.getSpanInfoAtLocation(2).should.eql(span: spanIndex.getSpan(0), spanIndex: 0, spanLocation: 0, location: 2)
      spanIndex.getSpanInfoAtLocation(3).should.eql(span: spanIndex.getSpan(0), spanIndex: 0, spanLocation: 0, location: 3)
      spanIndex.getSpanInfoAtLocation(4).should.eql(span: spanIndex.getSpan(1), spanIndex: 1, spanLocation: 3, location: 1)
      spanIndex.getSpanInfoAtLocation(5).should.eql(span: spanIndex.getSpan(1), spanIndex: 1, spanLocation: 3, location: 2)
      spanIndex.getSpanInfoAtLocation(6).should.eql(span: spanIndex.getSpan(1), spanIndex: 1, spanLocation: 3, location: 3)
      (-> spanIndex.getSpanInfoAtLocation(7)).should.throw()

    it 'get choose right span at cursor index', ->
      spanIndex.insertSpans(0, [
        spanIndex.createSpan('one'),
        spanIndex.createSpan('two')
      ])
      spanIndex.getSpanInfoAtLocation(0, true).should.eql(span: spanIndex.getSpan(0), spanIndex: 0, spanLocation: 0, location: 0)
      spanIndex.getSpanInfoAtLocation(1, true).should.eql(span: spanIndex.getSpan(0), spanIndex: 0, spanLocation: 0, location: 1)
      spanIndex.getSpanInfoAtLocation(2, true).should.eql(span: spanIndex.getSpan(0), spanIndex: 0, spanLocation: 0, location: 2)
      spanIndex.getSpanInfoAtLocation(3, true).should.eql(span: spanIndex.getSpan(1), spanIndex: 1, spanLocation: 3, location: 0)
      spanIndex.getSpanInfoAtLocation(4, true).should.eql(span: spanIndex.getSpan(1), spanIndex: 1, spanLocation: 3, location: 1)
      spanIndex.getSpanInfoAtLocation(5, true).should.eql(span: spanIndex.getSpan(1), spanIndex: 1, spanLocation: 3, location: 2)
      spanIndex.getSpanInfoAtLocation(6, true).should.eql(span: spanIndex.getSpan(1), spanIndex: 1, spanLocation: 3, location: 3)
      (-> spanIndex.getSpanInfoAtLocation(7, true)).should.throw()

  describe 'Events', ->

    it 'posts change events when updating text in span', ->
      spanIndex.insertSpans 0, [
        spanIndex.createSpan('a'),
        spanIndex.createSpan('b'),
        spanIndex.createSpan('c')
      ]
      indexDidChangeExpects = [
        (e) ->
          e.location.should.equal(0)
          e.replacedLength.should.equal(1)
          e.insertedString.should.equal('moose')
      ]
      spanIndex.replaceRange(0, 1, 'moose')

    it 'posts change events when inserting spans', ->
      indexDidChangeExpects = [
        (e) ->
          e.location.should.equal(0)
          e.replacedLength.should.equal(0)
          e.insertedString.should.equal('abc')
      ]
      spanIndex.insertSpans 0, [
        spanIndex.createSpan('a'),
        spanIndex.createSpan('b'),
        spanIndex.createSpan('c')
      ]

    it 'posts change events when removing spans', ->
      spanIndex.insertSpans 0, [
        spanIndex.createSpan('a'),
        spanIndex.createSpan('b'),
        spanIndex.createSpan('c')
      ]
      indexDidChangeExpects = [
        (e) ->
          e.location.should.equal(2)
          e.replacedLength.should.equal(1)
          e.insertedString.should.equal('')
      ]
      spanIndex.removeSpans(2, 1)

    it 'posts change events when removing all', ->
      spanIndex.insertSpans 0, [
        spanIndex.createSpan('a'),
        spanIndex.createSpan('b'),
        spanIndex.createSpan('c')
      ]
      indexDidChangeExpects = [
        (e) ->
          e.location.should.equal(0)
          e.replacedLength.should.equal(3)
          e.insertedString.should.equal('')
      ]
      spanIndex.removeSpans(0, 3)

  xdescribe 'Performance', ->

    it 'should handle 10,000 spans', ->
      console.profile('Create Spans')
      console.time('Create Spans')
      spanCount = 10000
      spans = []
      for i in [0..spanCount - 1]
        spans.push(spanIndex.createSpan('hello world!'))
      console.timeEnd('Create Spans')
      console.profileEnd()

      console.profile('Batch Insert Spans')
      console.time('Batch Insert Spans')
      spanIndex.insertSpans(0, spans)
      spanIndex.getSpanCount().should.equal(spanCount)
      spanIndex.getLength().should.equal(spanCount * 'hello world!'.length)
      console.timeEnd('Batch Insert Spans')
      console.profileEnd()

      console.profile('Batch Remove Spans')
      console.time('Batch Remove Spans')
      spanIndex.removeSpans(0, spanIndex.getSpanCount())
      spanIndex.getSpanCount().should.equal(0)
      spanIndex.getLength().should.equal(0)
      console.timeEnd('Batch Remove Spans')
      console.profileEnd()

      getRandomInt = (min, max) ->
        Math.floor(Math.random() * (max - min)) + min

      console.profile('Random Insert Spans')
      console.time('Random Insert Spans')
      for each in spans
        spanIndex.insertSpans(getRandomInt(0, spanIndex.getSpanCount()), [each])
      spanIndex.getSpanCount().should.equal(spanCount)
      spanIndex.getLength().should.equal(spanCount * 'hello world!'.length)
      console.timeEnd('Random Insert Spans')
      console.profileEnd()

      console.profile('Random Insert Text')
      console.time('Random Insert Text')
      for i in [0..spanCount - 1]
        spanIndex.insertString(getRandomInt(0, spanIndex.getLength()), 'Hello')
      spanIndex.getLength().should.equal(spanCount * 'hello world!Hello'.length)
      console.timeEnd('Random Insert Text')
      console.profileEnd()

      console.profile('Random Access Spans')
      console.time('Random Access Spans')
      for i in [0..spanCount - 1]
        start = getRandomInt(0, spanIndex.getSpanCount())
        end = getRandomInt(start, Math.min(start + 100, spanIndex.getSpanCount()))
        spanIndex.getSpans(start, end - start)
      console.timeEnd('Random Access Spans')
      console.profileEnd()

      console.profile('Random Remove Spans')
      console.time('Random Remove Spans')
      for each in spans
        spanIndex.removeSpans(getRandomInt(0, spanIndex.getSpanCount()), 1)
      spanIndex.getSpanCount().should.equal(0)
      spanIndex.getLength().should.equal(0)
      console.timeEnd('Random Remove Spans')
      console.profileEnd()
