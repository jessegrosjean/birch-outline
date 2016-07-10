ItemSerializer = require '../../src/item-serializer'
loadOutlineFixture = require '../load-outline-fixture'
Outline = require '../../src/outline'
should = require('chai').should()
Item = require '../../src/item'

fixtureAsTextString = '''
  one
  \ttwo
  \t\tthree @t
  \t\tfour @t
  \tfive
  \t\tsix @t(23)
'''

describe 'TaskPaper', ->
  [outline, root, one, two, three, four, five, six] = []

  beforeEach ->
    {outline, root, one, two, three, four, five, six} = loadOutlineFixture(ItemSerializer.TaskPaperType)

  afterEach ->
    outline.destroy()

  describe 'Serialization', ->

    it 'should serialize items to TaskPaper string', ->
      ItemSerializer.serializeItems(one.branchItems, type: ItemSerializer.TaskPaperType).should.equal(fixtureAsTextString)

    it 'should deserialize items from TaskPaper string', ->
      one.depth.should.equal(1)
      one.bodyString.should.equal('one')
      one.descendants.length.should.equal(5)
      one.firstChild.firstChild.hasAttribute('data-t').should.be.true
      one.firstChild.lastChild.hasAttribute('data-t').should.be.true
      one.lastChild.bodyString.should.equal('five')
      one.lastChild.lastChild.getAttribute('data-t').should.equal('23')

  describe 'Body text to attributes', ->

    it 'should sync project sytax to data-type="project"', ->
      one.bodyString = 'my project:'
      one.getAttribute('data-type').should.equal('project')
      one.bodyHighlightedAttributedString.toString().should.equal('(my project/content:"")(:)')

    it 'should delete content of project without crashing"', ->
      one.bodyString = 'a:'
      one.replaceBodyRange(0, 1, '')
      one.getAttribute('data-type').should.equal('project')
      one.bodyHighlightedAttributedString.toString().should.equal('(:)')

    it 'should sync task sytax to data-type="task"', ->
      one.bodyString = '- my task'
      one.getAttribute('data-type').should.equal('task')
      one.bodyHighlightedAttributedString.toString().should.equal('(-/lead:""/link:"button://toggledone")( )(my task/content:"")')

    it 'should sync note sytax to data-type="note"', ->
      one.bodyString = 'my note'
      one.getAttribute('data-type').should.equal('note')

    it 'should sync tags to data- attributes', ->
      one.bodyString = '@jesse(washere)'
      one.getAttribute('data-jesse').should.equal('washere')
      one.bodyString = '@jesse(washere) @2'
      one.getAttribute('data-jesse').should.equal('washere')
      one.getAttribute('data-2').should.equal('')
      one.attributeNames.toString().should.equal('data-2,data-jesse,data-type')
      one.bodyHighlightedAttributedString.toString().should.equal('(@jesse/link:"filter://@jesse"/tag:"data-jesse"/tagname:"data-jesse")((/tag:"data-jesse")(washere/link:"filter://@jesse = washere"/tag:"data-jesse"/tagvalue:"washere")()/tag:"data-jesse")( )(@2/link:"filter://@2"/tag:"data-2"/tagname:"data-2")')
      one.bodyString = 'no tags here'
      should.equal(one.getAttribute('data-jesse'), undefined)
      should.equal(one.getAttribute('data-2'), undefined)

    it 'should allow recognize multiple tags with values in a row', ->
      one.bodyString = 'hello @a(b) @c(d)'
      one.getAttribute('data-a').should.equal('b')
      one.getAttribute('data-c').should.equal('d')

    it 'should force escaped ()s in tag values', ->
      one.bodyString = 'hello @a(b @c(d)'
      should.equal(one.getAttribute('data-a'), undefined)
      one.getAttribute('data-c').should.equal('d')

    it 'should escaped ()s in tag values', ->
      one.bodyString = '@jesse(\\(moose\\))'
      one.getAttribute('data-jesse').should.equal('(moose)')

    it 'should encode/decode ()s when setting/getting tag values', ->
      one.setAttribute('data-jesse', '(hello)')
      one.bodyString.should.equal('one @jesse(\\(hello\\))')
      one.getAttribute('data-jesse').should.equal('(hello)')

    it 'should undo sync body text to attribute', ->
      one.bodyString = '@jesse(washere)'
      outline.undoManager.undo()
      one.bodyString.should.equal('one')
      should.equal(one.getAttribute('data-jesse'), undefined)
      outline.undoManager.redo()
      one.bodyString.should.equal('@jesse(washere)')
      one.getAttribute('data-jesse').should.equal('washere')

    it 'should undo coaleced sync body text attributes', ->
      one.replaceBodyRange(3, 0, ' ')
      one.replaceBodyRange(4, 0, '@')
      one.replaceBodyRange(5, 0, 'a')
      one.getAttribute('data-a').should.equal('')
      one.replaceBodyRange(6, 0, 'b')
      one.getAttribute('data-ab').should.equal('')
      outline.undoManager.undo()
      one.bodyString.should.equal('one')

  describe 'Attributes to body text', ->

    it 'should sync data-type="task" to task syntax', ->
      one.setAttribute('data-type', 'task')
      one.bodyString.should.equal('- one')
      one.getAttribute('data-type').should.equal('task')
      one.bodyHighlightedAttributedString.toString().should.equal('(-/lead:""/link:"button://toggledone")( )(one/content:"")')

    it 'should sync data-type="project" to project syntax', ->
      one.setAttribute('data-type', 'project')
      one.bodyString.should.equal('one:')
      one.getAttribute('data-type').should.equal('project')

    it 'should sync data-type="note" to note syntax', ->
      one.setAttribute('data-type', 'note')
      one.bodyString.should.equal('one')
      one.getAttribute('data-type').should.equal('note')

    it 'should sync between multiple data-types', ->
      one.setAttribute('data-type', 'note')
      one.bodyString.should.equal('one')
      one.setAttribute('data-type', 'project')
      one.bodyString.should.equal('one:')
      one.setAttribute('data-type', 'task')
      one.bodyString.should.equal('- one')
      one.setAttribute('data-type', 'project')
      one.bodyString.should.equal('one:')
      one.setAttribute('data-type', 'note')
      one.bodyString.should.equal('one')

    it 'should sync data- attributes to tags', ->
      one.setAttribute('data-jesse', 'washere')
      one.bodyString.should.equal('one @jesse(washere)')
      one.setAttribute('data-moose', '')
      one.bodyString.should.equal('one @jesse(washere) @moose')
      one.setAttribute('data-jesse', '')
      one.bodyString.should.equal('one @jesse @moose')
      one.removeAttribute('data-jesse', '')
      one.bodyString.should.equal('one @moose')
      one.setAttribute('data-moose', 'mouse')
      one.bodyString.should.equal('one @moose(mouse)')
      one.bodyHighlightedAttributedString.toString().should.equal('(one/content:"")( )(@moose/link:"filter://@moose"/tag:"data-moose"/tagname:"data-moose")((/tag:"data-moose")(mouse/link:"filter://@moose = mouse"/tag:"data-moose"/tagvalue:"mouse")()/tag:"data-moose")')

    it 'should sync from project with trailing tags', ->
      one.bodyString = 'one: @done'
      one.setAttribute('data-type', 'note')
      one.bodyString.should.equal('one @done')

    it 'should to from project with trailing tags', ->
      one.bodyString = 'one @done'
      one.setAttribute('data-type', 'project')
      one.bodyString.should.equal('one: @done')

    it 'should sync data- attributes to tags and change type if type changes', ->
      one.bodyString = 'one:'
      one.setAttribute('data-moose', '')
      one.getAttribute('data-type').should.equal('project')

    it 'should undo sync data- attributes to tags', ->
      one.setAttribute('data-type', 'project')
      outline.undoManager.undo()
      one.bodyString.should.equal('one')
      outline.undoManager.redo()
      one.bodyString.should.equal('one:')
      one.getAttribute('data-type').should.equal('project')

    describe 'Inline Syntax Highlighting', ->

      it 'should highlight email links', ->
        one.bodyString = 'jesse@hogbay.com'
        one.bodyHighlightedAttributedString.toString().should.equal('(jesse@hogbay.com/content:""/link:"mailto:jesse@hogbay.com")')

      it 'should highlight file links', ->
        one.bodyString = 'one ./two and /thre/four.txt'
        one.bodyHighlightedAttributedString.toString().should.equal('(one /content:"")(./two/content:""/link:"path:./two")( and /content:"")(/thre/four.txt/content:""/link:"path:/thre/four.txt")')

      it 'should highlight file links with multiple escaped spaces', ->
        one.bodyString = '/hello\\ world\\ man.txt'
        one.bodyHighlightedAttributedString.toString().should.equal('(/hello\\ world\\ man.txt/content:""/link:"path:/hello world man.txt")')

      it 'should highlight web links', ->
        one.bodyString = 'www.apple.com or ftp://apple.com mailto:jesse@hogbay.com'
        one.bodyHighlightedAttributedString.toString().should.equal('(www.apple.com/content:""/link:"http://www.apple.com")( or /content:"")(ftp://apple.com/content:""/link:"ftp://apple.com")( /content:"")(mailto:jesse@hogbay.com/content:""/link:"mailto:jesse@hogbay.com")')

