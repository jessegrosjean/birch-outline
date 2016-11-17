loadOutlineFixture = require './load-outline-fixture'
Outline = require '../src/outline'
Item = require '../src/item'
shortid = require '../src/shortid'
should = require('chai').should()
path = require 'path'

describe 'Outline', ->
  [outline, root, one, two, three, four, five, six] = []

  beforeEach ->
    {outline, root, one, two, three, four, five, six} = loadOutlineFixture()

  afterEach ->
    outline.destroy()
    Outline.outlines.length.should.equal(0)

  describe 'TaskPaper Outline', ->

    taskPaperOutline = null

    beforeEach ->
      taskPaperOutline = Outline.createTaskPaperOutline('one @t(1)\ntwo')

    afterEach ->
      taskPaperOutline.destroy()

    it 'should convert string to TaskPaper outline', ->
      taskPaperOutline.root.firstChild.bodyString.should.equal('one @t(1)')
      taskPaperOutline.root.firstChild.getAttribute('data-t').should.equal('1')
      taskPaperOutline.root.lastChild.bodyString.should.equal('two')

    it 'should convert outline to TaskPaper string', ->
      taskPaperOutline.serialize().should.equal('one @t(1)\ntwo')

  describe 'Metadata', ->

    it 'should get/set', ->
      should.not.exist(outline.getMetadata('key'))
      outline.setMetadata('key', 'value')
      outline.getMetadata('key').should.equal('value')
      outline.setMetadata('key', null)
      should.not.exist(outline.getMetadata('key'))

    it 'should serialize', ->
      serialized = outline.serializedMetadata
      outline.setMetadata('key', 'value')
      outline.serializedMetadata = serialized
      should.not.exist(outline.getMetadata('key'))

      outline.setMetadata('key', 'value')
      serialized = outline.serializedMetadata
      outline.serializedMetadata = serialized
      outline.getMetadata('key').should.equal('value')

  it 'should create item', ->
    item = outline.createItem('hello')
    item.isInOutline.should.not.be.ok

  it 'should get item by id', ->
    item = outline.createItem('hello')
    outline.root.appendChildren(item)
    outline.getItemForID(item.id).should.equal(item)

  it 'should get item by branch content id', ->
    id = one.branchContentID
    outline.getItemForBranchContentID(id).should.equal(one)

  it 'should not get item by branch content id when content changes', ->
    id = one.branchContentID
    one.bodyString = 'goat'
    should.not.exist(outline.getItemForBranchContentID(id))

    id = one.branchContentID
    six.removeFromParent()
    should.not.exist(outline.getItemForBranchContentID(id))

  it 'should copy item', ->
    oneCopy = outline.cloneItem(one)
    oneCopy.isInOutline.should.be.false
    oneCopy.id.should.not.equal(one.id)
    oneCopy.bodyString.should.equal('one')
    oneCopy.firstChild.bodyString.should.equal('two')
    oneCopy.firstChild.firstChild.bodyString.should.equal('three')
    oneCopy.firstChild.lastChild.bodyString.should.equal('four')
    oneCopy.lastChild.bodyString.should.equal('five')
    oneCopy.lastChild.firstChild.bodyString.should.equal('six')

  it 'should import item', ->
    outline2 = new Outline()
    oneImport = outline2.importItem(one)
    oneImport.outline.should.equal(outline2)
    oneImport.isInOutline.should.be.false
    oneImport.id.should.equal(one.id)
    oneImport.bodyString.should.equal('one')
    oneImport.firstChild.bodyString.should.equal('two')
    oneImport.firstChild.firstChild.bodyString.should.equal('three')
    oneImport.firstChild.lastChild.bodyString.should.equal('four')
    oneImport.lastChild.bodyString.should.equal('five')
    oneImport.lastChild.firstChild.bodyString.should.equal('six')

  describe 'Insert & Remove Items', ->

    it 'inserts items at indent level 1 by default', ->
      newItem = outline.createItem('new')
      outline.insertItemsBefore(newItem, two)
      newItem.depth.should.equal(1)
      newItem.previousSibling.should.equal(one)
      newItem.firstChild.should.equal(two)
      newItem.lastChild.should.equal(five)

    it 'inserts items at specified indent level', ->
      three.indent = 3
      four.indent = 2
      newItem = outline.createItem('new')
      newItem.indent = 3
      outline.insertItemsBefore(newItem, three)
      newItem.depth.should.equal(3)
      three.depth.should.equal(5)
      four.depth.should.equal(4)
      two.firstChild.should.equal(newItem)
      newItem.firstChild.should.equal(three)
      newItem.lastChild.should.equal(four)

    it 'inserts items with children', ->
      three.indent = 4
      four.indent = 3
      newItem = outline.createItem('new')
      newItemChild = outline.createItem('new child')
      newItem.appendChildren(newItemChild)
      newItem.indent = 3
      outline.insertItemsBefore(newItem, three)
      newItem.depth.should.equal(3)
      newItemChild.depth.should.equal(4)
      three.depth.should.equal(6)
      four.depth.should.equal(5)
      two.firstChild.should.equal(newItem)
      newItemChild.firstChild.should.equal(three)
      newItemChild.lastChild.should.equal(four)

    it 'remove item leaving children', ->
      outline.undoManager.beginUndoGrouping()
      outline.removeItems(two)
      outline.undoManager.endUndoGrouping()
      two.isInOutline.should.equal(false)
      three.isInOutline.should.equal(true)
      three.parent.should.equal(one)
      three.depth.should.equal(3)
      four.isInOutline.should.equal(true)
      four.parent.should.equal(one)
      four.depth.should.equal(3)
      outline.undoManager.undo()
      two.isInOutline.should.equal(true)
      two.firstChild.should.equal(three)
      two.lastChild.should.equal(four)
      outline.undoManager.redo()

    it 'should special case remove items 1', ->
      four.removeFromParent()
      root.appendChildren(six)
      outline.removeItems([one, two, three])
      six.previousItem.should.equal(five)

    it 'should special case remove items 2', ->
      each.removeFromParent() for each in outline.root.descendants
      one.indent = 1
      two.indent = 3
      three.indent = 2
      four.indent = 1
      outline.insertItemsBefore([one, two, three, four])
      outline.removeItems([one, two])
      root.firstChild.should.equal(three)

    it 'should bug case insert items', ->
      three.indent = 2
      outline.removeItems(two)
      two.indent -= 1
      outline.insertItemsBefore(two, three)
      five.isInOutline.should.be.true
      six.isInOutline.should.be.true

    it 'add items in batch in single event', ->

    it 'remove items in batch in single event', ->

  describe 'Undo', ->

    it 'should undo append child', ->
      child = outline.createItem('hello')
      one.appendChildren(child)
      outline.undoManager.undo()
      should.not.exist(child.parent)

    it 'should undo remove child', ->
      outline.undoManager.beginUndoGrouping()
      two.depth.should.equal(2)
      one.removeChildren(two)
      outline.undoManager.endUndoGrouping()
      outline.undoManager.undo()
      two.parent.should.equal(one)
      two.depth.should.equal(2)

    it 'should undo remove over indented child', ->
      three.indent = 3
      three.depth.should.equal(5)
      outline.undoManager.beginUndoGrouping()
      two.removeChildren(three)
      outline.undoManager.endUndoGrouping()
      outline.undoManager.undo()
      three.parent.should.equal(two)
      three.depth.should.equal(5)

    it 'should undo move child', ->
      outline.undoManager.beginUndoGrouping()
      six.depth.should.equal(3)
      one.appendChildren(six)
      outline.undoManager.endUndoGrouping()
      outline.undoManager.undo()
      six.parent.should.equal(five)
      six.depth.should.equal(3)

    it 'should undo set attribute', ->
      one.setAttribute('myattr', 'test')
      one.getAttribute('myattr').should.equal('test')
      outline.undoManager.undo()
      should.equal(one.getAttribute('myattr'), undefined)

    describe 'Body Text', ->
      it 'should undo set body text', ->
        one.bodyString = 'hello word'
        outline.undoManager.undo()
        one.bodyString.should.equal('one')

      it 'should undo replace body text', ->
        one.replaceBodyRange(1, 1, 'hello')
        one.bodyString.should.equal('ohelloe')
        outline.undoManager.undo()
        one.bodyString.should.equal('one')

      it 'should coalesce consecutive body text inserts', ->
        outline.changeCount.should.equal(0)
        outline.undoManager.beginUndoGrouping()
        one.replaceBodyRange(1, 0, 'a')
        outline.undoManager.endUndoGrouping()
        outline.undoManager.beginUndoGrouping()
        one.replaceBodyRange(2, 0, 'b')
        outline.undoManager.endUndoGrouping()
        one.replaceBodyRange(3, 0, 'c')
        outline.changeCount.should.equal(1)
        one.bodyString.should.equal('oabcne')
        outline.undoManager.undo()
        outline.changeCount.should.equal(0)
        one.bodyString.should.equal('one')
        outline.undoManager.redo()
        outline.changeCount.should.equal(1)
        one.bodyString.should.equal('oabcne')

      it 'should coalesce consecutive body text deletes', ->
        one.replaceBodyRange(2, 1, '')
        one.replaceBodyRange(1, 1, '')
        one.replaceBodyRange(0, 1, '')
        one.bodyString.should.equal('')
        outline.undoManager.undo()
        one.bodyString.should.equal('one')
        outline.undoManager.redo()
        one.bodyString.should.equal('')

  describe 'Performance', ->

    it 'should create/copy/remove 10,000 items', ->
      # Create, copy, past a all relatively slow compared to load
      # because of time taken to generate IDs and validate that they
      # are unique to the document. Seems there should be a better
      # solution for that part of the code.
      branch = outline.createItem('branch')

      itemCount = 10000
      console.time('Create IDs')
      items = []
      for i in [0..itemCount]
        items.push(name: shortid())
      console.timeEnd('Create IDs')

      console.profile?('Create Items')
      console.time('Create Items')
      items = []
      for i in [0..itemCount]
        each = outline.createItem('hello')
        items.push(outline.createItem('hello'))
      console.timeEnd('Create Items')
      console.profileEnd?()

      for each in items
        each.indent = Math.floor(Math.random() * 3)

      console.profile?('Build Item Hiearchy')
      console.time('Build Item Hiearchy')
      roots = Item.buildItemHiearchy(items)
      branch.appendChildren(roots)
      outline.root.appendChildren(branch)
      outline.root.descendants.length.should.equal(itemCount + 8)
      console.timeEnd('Build Item Hiearchy')
      console.profileEnd?()

      console.time('Copy Items')
      branch.clone()
      console.timeEnd('Copy Items')

      console.time('Remove Items')
      Item.removeItemsFromParents(items)
      console.timeEnd('Remove Items')

      randoms = []
      for each, i in items
        each.indent = Math.floor(Math.random() * 10)

      console.profile?('Insert Items')
      console.time('Insert Items')
      outline.insertItemsBefore(items, null)
      console.timeEnd('Insert Items')
      console.profileEnd?()

    ###
    it 'should load 100,000 items', ->
      console.profile?('Load Items')
      console.time('Load Items')
      outline2 = new Outline()
      outline2.loadSync(path.join(__dirname, '..', 'fixtures', 'big-outline.bml'))
      console.timeEnd('Load Items')
      outline2.root.descendants.length.should.equal(100007)
      console.profileEnd?()
      outline2.destroy()
    ###
