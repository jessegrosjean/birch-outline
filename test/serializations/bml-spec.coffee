ItemSerializer = require '../../src/item-serializer'
loadOutlineFixture = require '../load-outline-fixture'
Outline = require '../../src/outline'
should = require('chai').should()

fixtureAsBMLString = '''
  <!DOCTYPE html>
  <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <meta charset="UTF-8"/>
    </head>
    <body>
      <ul id="Birch">
        <li id="1">
          <p>one</p>
          <ul>
            <li id="2">
              <p>two</p>
              <ul>
                <li id="3" data-t="">
                  <p>three</p>
                </li>
                <li id="4" data-t="">
                  <p>fo<b>u</b>r</p>
                </li>
              </ul>
            </li>
            <li id="5">
              <p>five</p>
              <ul>
                <li id="6" data-t="23" indent="2">
                  <p>six</p>
                </li>
              </ul>
            </li>
          </ul>
        </li>
      </ul>
    </body>
  </html>
'''

describe 'BML Serialization', ->
  [outline, root, one, two, three, four, five, six] = []

  beforeEach ->
    {outline, root, one, two, three, four, five, six} = loadOutlineFixture()
    six.indent = 2

  afterEach ->
    outline.destroy()

  describe 'Serialization', ->
    it 'should serialize items to BML string', ->
      ItemSerializer.serializeItems(outline.root.descendants).should.equal(fixtureAsBMLString)

    it 'should only serialize non default indents', ->
      one.setAttribute('indent', 1)
      ItemSerializer.serializeItems(outline.root.descendants).should.equal(fixtureAsBMLString)
      one.setAttribute('indent', 2)
      ItemSerializer.serializeItems(outline.root.descendants).should.not.equal(fixtureAsBMLString)

  describe 'Deserialization', ->
    it 'should load items from BML string', ->
      one = ItemSerializer.deserializeItems(fixtureAsBMLString, outline)[0]
      one.depth.should.equal(1)
      one.bodyString.should.equal('one')
      one.descendants.length.should.equal(5)
      one.lastChild.bodyString.should.equal('five')
      one.lastChild.lastChild.getAttribute('data-t').should.equal('23')
      one.lastChild.lastChild.indent.should.equal(2)
      one.lastChild.lastChild.depth.should.equal(4)

    it 'reload outline from BML string', ->
      out = new Outline()
      out.reloadSerialization(fixtureAsBMLString, type: ItemSerializer.BMLType)
      ItemSerializer.serializeItems(outline.root.descendants).should.equal(fixtureAsBMLString)

    it 'should throw exception when loading invalid html outline UL child', ->
      bmlString = '''
        <ul id="Birch">
          <div>bad</div>
        </ul>
      '''
      (-> ItemSerializer.deserializeItems(bmlString, outline)).should.throw("Expected 'LI' or 'UL', but got div")

    it 'should throw exception when loading invalid html outline LI child', ->
      bmlString = '''
        <ul id="Birch">
          <li>bad</li>
        </ul>
      '''
      (-> ItemSerializer.deserializeItems(bmlString, outline)).should.throw("Expected 'P', but got undefined")

    it 'should throw exception when loading invalid html outline P contents', ->
      bmlString = '''
        <ul id="Birch">
          <li><p>o<dog>n</dog>e</p></li>
        </ul>
      '''
      (-> ItemSerializer.deserializeItems(bmlString, outline)).should.throw("Unexpected tagName 'dog' in 'P'")
