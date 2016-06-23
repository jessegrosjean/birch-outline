loadOutlineFixture = require './load-outline-fixture'
DateTime = require '../src/date-time'
ItemPath = require '../src/item-path'
Outline = require '../src/outline'
should = require('chai').should()

describe 'ItemPath', ->
  [outline, root, one, two, three, four, five, six] = []

  beforeEach ->
    {outline, root, one, two, three, four, five, six} = loadOutlineFixture()

  afterEach ->
    outline.destroy()
    Outline.outlines.length.should.equal(0)

  it 'should perform simple match', ->
    outline.evaluateItemPath('/one').should.eql [one]

  describe 'Unions', ->
    it 'should union paths separated by "union"', ->
      outline.evaluateItemPath('//one union //e').should.eql [one, three, five]

    it 'should union paths separated by "union" where first path ends in *', ->
      outline.evaluateItemPath('/* union //two').should.eql [one, two]

  describe 'Intersections', ->
    it 'should intersect paths separated by "intersect"', ->
      outline.evaluateItemPath('//three intersect //@t').should.eql [three]

  describe 'Exceptions', ->
    it 'should minus paths separated by "except"', ->
      outline.evaluateItemPath('//* except //@t').should.eql [one, two, five]

    it 'should minus paths separated by "except" when expect results proceed orignal results', ->
      outline.evaluateItemPath('(//three except //two)').should.eql [three]

    it 'should minus paths separated by "except" when initial results are empty', ->
      outline.evaluateItemPath('(//cantfindme except //two)').should.eql []

  describe 'Set Grouping', ->
    it 'should group path set operations with parentheses', ->
      outline.evaluateItemPath('(//one union //two union //three except //two)').should.eql [one, two, three]
      outline.evaluateItemPath('((//one union //two union //three) except //two)').should.eql [one, three]

    it 'should allow slicing after set group', ->
      outline.evaluateItemPath('(//@t)[0]').should.eql [three]
      outline.evaluateItemPath('(//@t union //e)[0]').should.eql [one]

  describe 'Locations', ->
    it 'should evaluate relative paths relative to current item', ->
      outline.evaluateItemPath('one').should.eql [one]
      outline.evaluateItemPath('one', four).should.eql []

    it 'should evaluate absoluote paths relative to current item root', ->
      outline.evaluateItemPath('/one').should.eql [one]
      outline.evaluateItemPath('/one', four).should.eql [one]

    it 'should evaluate path starting with // as absoluote', ->
      outline.evaluateItemPath('//one', four).should.eql [one]

  describe 'Axes', ->
    it 'should parse error if axis doesnt have a predicate', ->
      ItemPath.parse('/ancestor-or-self::').error.location.start.offset.should.equal(19)

    it 'should evaluate ancestor-or-self axis for ancestor-or-self::', ->
      outline.evaluateItemPath('ancestor-or-self::*', three).should.eql [root, one, two, three]

    it 'should evaluate ancestor axis for ancestor::', ->
      outline.evaluateItemPath('ancestor::*', three).should.eql [root, one, two]

    it 'should evaluate ancestor axis from multiple contexts and merge results', ->
      outline.evaluateItemPath('//one or two/ancestor::*', three).should.eql [root, one]

    it 'should evaluate descendant axis from multiple contexts and correctly merge results', ->
      outline.evaluateItemPath('/descendant::one or two/descendant::*', three).should.eql [two, three, four, five, six]

    it 'should evaluate child axis as default or child::', ->
      outline.evaluateItemPath('*', two).should.eql [three, four]
      outline.evaluateItemPath('child::*', two).should.eql [three, four]

    it 'should evaluate descendant-or-self axis for descendant-or-self::', ->
      outline.evaluateItemPath('descendant-or-self::*', two).should.eql [two, three, four]

    it 'should evaluate decendent axis for // or descendant::', ->
      outline.evaluateItemPath('/one//*').should.eql [two, three, four, five, six]
      outline.evaluateItemPath('/one/descendant::*').should.eql [two, three, four, five, six]

    it 'should evaluate decendent-or-self axis for /// or descendant-or-self::', ->
      outline.evaluateItemPath('/one///*').should.eql [one, two, three, four, five, six]
      outline.evaluateItemPath('/one/descendant-or-self::*').should.eql [one, two, three, four, five, six]

    it 'should evaluate following-sibling axis for following-sibling::', ->
      outline.evaluateItemPath('/one/two/following-sibling::*').should.eql [five]

    it 'should evaluate following axis for following::', ->
      outline.evaluateItemPath('/one/two/following::*').should.eql [three, four, five, six]

    it 'should evaluate parent axis for .. or parent::', ->
      outline.evaluateItemPath('..*', two).should.eql [one]
      outline.evaluateItemPath('parent::*', two).should.eql [one]

    it 'should evaluate preceding-sibling axis for preceding-sibling::', ->
      outline.evaluateItemPath('/one/five/preceding-sibling::*').should.eql [two]

    it 'should evaluate preceding axis for preceding::', ->
      outline.evaluateItemPath('/one/five/preceding::*').should.eql [one, two, three, four]

    it 'should evaluate self axis for self', ->
      outline.evaluateItemPath('/one/five/self::*').should.eql [five]

    it 'should support taxonomy declared type shortcut', ->
      two.setAttribute 'data-type', 'frog'
      outline.evaluateItemPath('//frog').should.eql []
      options =
        types:
          'frog': true
      outline.evaluateItemPath('//frog', null, options).should.eql [two]
      outline.evaluateItemPath('//frog two', null, options).should.eql [two]

  describe 'Predicate', ->

    describe 'Count', ->

      it 'should use count to find items with no children', ->
        outline.evaluateItemPath('//count(*) = 0').should.eql [three, four, six]

    describe 'Structure', ->

      it 'should accept a complete attribute, relation, value, slice predicate', ->
        outline.evaluateItemPath('//@text = "one"[0]').should.eql [one]

      it 'should accept a attribute, relation, value predicate', ->
        outline.evaluateItemPath('//@text = "one"').should.eql [one]

      it 'should default to case insensitive comparisons', ->
        outline.evaluateItemPath('//@text = "oNe"').should.eql [one]

      it 'should accept attribute value predicates', ->
        outline.evaluateItemPath('//@text one').should.eql [one]

      it 'should accept value predicates', ->
        outline.evaluateItemPath('//one').should.eql [one]

      it 'should default to @body if no attribute is specified', ->
        outline.evaluateItemPath('//= one').should.eql [one]

      it 'should default to contians if no relation is specified', ->
        outline.evaluateItemPath('//@t 23').should.eql [six]

      it 'should test attribute for existance of no value is specified', ->
        outline.evaluateItemPath('//@t').should.eql [three, four, six]

      it 'should allow different values types on both sides of comparision', ->
        one.setAttribute('data-m', '2')
        three.setAttribute('data-m', '')
        six.setAttribute('data-m', '23')
        outline.evaluateItemPath('//@t and (@t = @m)').should.eql [three, six]
        outline.evaluateItemPath('//@m = count(.*)').should.eql [one]

    describe 'Boolean', ->
      it 'should evaluate predicates joined with "and"', ->
        outline.evaluateItemPath('//w and o').should.eql [two]

      it 'should evaluate predicates joined with "or"', ->
        outline.evaluateItemPath('//w or i').should.eql [two, five, six]

      it 'should evaluate predicates preceeded by "not"', ->
        outline.evaluateItemPath('//not e').should.eql [two, four, six]

      it 'should accept any number of consecutive negates as a single not', ->
        outline.evaluateItemPath('/one/two').should.eql [two]
        outline.evaluateItemPath('/one/not two').should.eql [five]
        outline.evaluateItemPath('/one/not not two').should.eql [two]
        outline.evaluateItemPath('/one/not not not two').should.eql [five]

      it 'should handle and or not in the proper order', ->
        outline.evaluateItemPath('//(@text e and not @t) or @t = 23').should.eql [one, five, six]
        outline.evaluateItemPath('//e and @t or not @t').should.eql [one, two, three, five]
        outline.evaluateItemPath('//(e and @t) or not @t').should.eql [one, two, three, five]
        outline.evaluateItemPath('//e and (@t or not v)').should.eql [one, three]

      it 'should handle boolean grouping without leading axis', ->
        new ItemPath('(a and b) and c')

    describe 'Nesting', ->
      it 'should accept parenthesis around predicates', ->
        outline.evaluateItemPath('//(not @t)').should.eql [one, two, five]
        outline.evaluateItemPath('//((not @t))').should.eql [one, two, five]
        outline.evaluateItemPath('//(((not @t)) or @t = 23)').should.eql [one, two, five, six]

      it 'should accept negated groups', ->
        outline.evaluateItemPath('//not (@t or e)').should.eql [two]

    describe 'Attributes', ->

      it 'should consider attributes with values', ->
        outline.evaluateItemPath('//@t = 23').should.eql [six]

      it 'should not throw exception when value is empty', ->
        outline.evaluateItemPath('//""').should.eql [one, two, three, four, five, six]

    describe 'Relations', ->
      beforeEach ->
        three.setAttribute('t', '09')

      it 'should support =', ->
        outline.evaluateItemPath('//= one').should.eql [one]

      it 'should support !=', ->
        outline.evaluateItemPath('//@t != 23').should.eql [one, two, three, four, five]

      it 'should support <', ->
        outline.evaluateItemPath('//@t < 23').should.eql [three, four]

      it 'should support <=', ->
        outline.evaluateItemPath('//@t <= 23').should.eql [three, four, six]

      it 'should support >', ->
        outline.evaluateItemPath('//@t > 09').should.eql [six]

      it 'should support >=', ->
        outline.evaluateItemPath('//@t >= 09').should.eql [six]

      it 'should support beginswith', ->
        outline.evaluateItemPath('//beginswith o').should.eql [one]

      it 'should support contains', ->
        outline.evaluateItemPath('//contains ne').should.eql [one]

      it 'should support endswith', ->
        outline.evaluateItemPath('//endswith ne').should.eql [one]

      it 'should support matches', ->
        outline.evaluateItemPath('//matches ".*i.*"').should.eql [five, six]

      it 'should internally handle exception when matches is given a bad regex', ->
        outline.evaluateItemPath('//@text matches " @\\\\w("').should.eql []

    describe 'Optional Options', ->

      it 'should support options (AROV) formatted queries', ->
        one.bodyString = 'Being all INSENSITIVE'
        outline.evaluateItemPath('@text contains insensitive').should.eql [one]
        outline.evaluateItemPath('@text contains [s] insensitive').should.eql []
        outline.evaluateItemPath('@text contains [s] INSENSITIVE').should.eql [one]

      it 'should support AOV formatted queries', ->
        one.bodyString = 'INSENSITIVE'
        outline.evaluateItemPath('@text insensitive').should.eql([one])
        outline.evaluateItemPath('@text [s] insensitive').should.eql([])
        outline.evaluateItemPath('@text [s] INSENSITIVE').should.eql([one])

      it 'should support OV formatted queries', ->
        one.bodyString = 'INSENSITIVE'
        outline.evaluateItemPath('insensitive').should.eql([one])
        outline.evaluateItemPath('[s] insensitive').should.eql([])
        outline.evaluateItemPath('[s] INSENSITIVE').should.eql([one])

      it 'should support ROV formatted queries', ->
        one.bodyString = 'INSENSITIVE'
        outline.evaluateItemPath('= insensitive').should.eql([one])
        outline.evaluateItemPath('= [s] insensitive').should.eql([])
        outline.evaluateItemPath('= [s] INSENSITIVE').should.eql([one])

      it 'should support convert to number before compare option', ->
        one.bodyString = '1.0'
        outline.evaluateItemPath('@text = 1.0').should.eql([one])
        outline.evaluateItemPath('@text = 1').should.eql([])
        outline.evaluateItemPath('@text = [n] 1').should.eql([one])

      it 'shouldnt crash on invalid number comparisions', ->
        outline.evaluateItemPath('@text beginswith[n] 1.0').should.eql([])
        outline.evaluateItemPath('@text endswith[n] 1.0').should.eql([])
        outline.evaluateItemPath('@text contains[n] 1.0').should.eql([])
        outline.evaluateItemPath('@text matches[n] 1.0').should.eql([])

      it 'should support convert to date before compare option', ->
        one.bodyString = 'November 1, 2012'
        one.setAttribute('data-due', 'tomorrow 2pm')
        outline.evaluateItemPath('@text = November 1, 2012').should.eql([one])
        outline.evaluateItemPath('@text = November 01, 2012').should.eql([])
        outline.evaluateItemPath('@text = [d] November 01, 2012').should.eql([one])
        outline.evaluateItemPath('@due = [d] tomorrow 2pm +1s -1s').should.eql([one])
        outline.evaluateItemPath('@due = [d] today 2pm +1d +1s -1s').should.eql([one])
        outline.evaluateItemPath('@due = [d] tomorrow 2pm + 1s').should.eql([])

    describe 'Values', ->

      it 'should accept unquoted values', ->
        one.bodyString = 'find this string'
        outline.evaluateItemPath('find this string').should.eql([one])

      it 'should ignore reserved words in unquoted values unless followed by whitespace', ->
        one.bodyString = 'notandor'
        outline.evaluateItemPath('notandor').should.eql([one])

      it 'should accept ored unquoted strings', ->
        one.bodyString = 'one is here'
        two.bodyString = 'two is here'
        outline.evaluateItemPath('//one is here or two is here').should.eql([one, two])

      it 'should identify double quoted strings', ->
        outline.evaluateItemPath('"one"').should.eql([one])

      it 'should not find operator inside quoted string', ->
        one.bodyString = 'one is here'
        two.bodyString = 'two is here'
        three.bodyString = 'one is here or two is here'
        outline.evaluateItemPath('//"one is here or two is here"').should.eql([three])

      it 'should allow attribute value to start with zero', ->
        one.bodyString = '0one'
        outline.evaluateItemPath('0').should.eql([one])
        outline.evaluateItemPath('0one').should.eql([one])

      it 'should support tags and values ending with numbers', ->
        one.setAttribute('data-t1', 'v1')
        outline.evaluateItemPath('//@t1 = v1').should.eql [one]

      it 'should accept quoted unicode strings', ->
        umlat = outline.createItem('find a ü')
        outline.root.appendChildren(umlat)
        outline.evaluateItemPath('//"ü"').should.eql([umlat])

      it 'should accept unquoted unicode strings', ->
        # This test is breaking. Need to update ItemPathparser.pegjs to use "letter" with unicode
        # sequences. also should update to latest pegjs while at it. Can't remember why I commented out
        # unicode sequences... mabye because of file size... or maybe was breaking something else.
        # so be on lookout for other breask when that's reenabled.
        umlat = outline.createItem('find a ü')
        arabic = outline.createItem('find in arabic بِسْمِ ٱللّٰهِ ٱلرَّحْمـَبنِ ٱلرَّحِيمِ')
        russian = outline.createItem('find this string in russian По оживлённым берегам')
        francais = outline.createItem('find in français')
        german = outline.createItem('find in german dürfen Anführungszeichen')
        accents = outline.createItem('accept accents aàáâãäāăąȧXǎȁȃeèéêẽëēĕęėXěȅȇiìíîĩïīĭįiXǐȉȋoòóôõöŏǫȯőǒȍȏuùúûũüūŭųXűǔȕȗyỳýŷỹÿȳXXẏXXXX')
        greek = outline.createItem('find in ancient greek τὰ πάντʼ ἂν ἐξήκοι σαφῆ')
        sanskrit = outline.createItem('find in sanskrit पशुपतिरपि तान्यहानि कृच्छ्राद्')
        chinese = outline.createItem('find in chinese 其為人也孝弟 而好犯上者 鮮矣')
        tamil = outline.createItem('find in tamil ஸ்றீனிவாஸ ராமானுஜன் ஐயங்கார்')

        outline.root.appendChildren(umlat)
        outline.root.appendChildren(arabic)
        outline.root.appendChildren(russian)
        outline.root.appendChildren(francais)
        outline.root.appendChildren(german)
        outline.root.appendChildren(accents)
        outline.root.appendChildren(greek)
        outline.root.appendChildren(sanskrit)
        outline.root.appendChildren(chinese)
        outline.root.appendChildren(tamil)

        outline.evaluateItemPath('//find a ü').should.eql([umlat])
        outline.evaluateItemPath('//find in arabic بِسْمِ ٱللّٰهِ ٱلرَّحْمـَبنِ ٱلرَّحِيمِ').should.eql([arabic])
        outline.evaluateItemPath('//find this string in russian По оживлённым берегам').should.eql([russian])
        outline.evaluateItemPath('//find in français').should.eql([francais])
        outline.evaluateItemPath('//find in german dürfen Anführungszeichen').should.eql([german])
        outline.evaluateItemPath('//accept accents aàáâãäāăąȧXǎȁȃeèéêẽëēĕęėXěȅȇiìíîĩïīĭįiXǐȉȋoòóôõöŏǫȯőǒȍȏuùúûũüūŭųXűǔȕȗyỳýŷỹÿȳXXẏXXXX').should.eql([accents])
        outline.evaluateItemPath('//find in ancient greek τὰ πάντʼ ἂν ἐξήκοι σαφῆ').should.eql([greek])
        outline.evaluateItemPath('//find in sanskrit पशुपतिरपि तान्यहानि कृच्छ्राद्').should.eql([sanskrit])
        outline.evaluateItemPath('//find in chinese 其為人也孝弟 而好犯上者 鮮矣').should.eql([chinese])
        outline.evaluateItemPath('//find in tamil ஸ்றீனிவாஸ ராமானுஜன் ஐயங்கார்').should.eql([tamil])

  describe 'Slicing', ->
    it 'should slice from start', ->
      outline.evaluateItemPath('//@t[0]').should.eql([three])
      outline.evaluateItemPath('//@t[1]').should.eql([four])
      outline.evaluateItemPath('//@t[2]').should.eql([six])

    it 'should clamp slice from start', ->
      outline.evaluateItemPath('//@t[300]').should.eql([six])

    it 'should slice from end', ->
      outline.evaluateItemPath('//@t[-1]').should.eql([six])
      outline.evaluateItemPath('//@t[-2]').should.eql([four])
      outline.evaluateItemPath('//@t[-3]').should.eql([three])

    it 'should clamp slice from end', ->
      outline.evaluateItemPath('//@t[-300]').should.eql([three])

    it 'should slice range', ->
      outline.evaluateItemPath('//@t[0:1]').should.eql([three])
      outline.evaluateItemPath('//@t[0:2]').should.eql([three, four])
      outline.evaluateItemPath('//@t[0:3]').should.eql([three, four, six])
      outline.evaluateItemPath('//@t[0:300]').should.eql([three, four, six])
      outline.evaluateItemPath('//@t[0:-1]').should.eql([three, four])
      outline.evaluateItemPath('//@t[0:-2]').should.eql([three])
      outline.evaluateItemPath('//@t[0:-3]').should.eql([])
      outline.evaluateItemPath('//@t[0:]').should.eql([three, four, six])

  describe 'Path for Item', ->
    it 'should calculate the min item path that uniquly specifies a given item', ->
      two.bodyString ='not( needs quotes in nodepath'
      ItemPath.pathToItem(four).should.equal('/one/"not("/four')
      outline.evaluateItemPath(ItemPath.pathToItem(four)).should.eql([four])

    it 'should calculate the min item path using id if item has no text', ->
      four.bodyString = ''
      ItemPath.pathToItem(four).should.equal('/one/two/@id = 4')
      outline.evaluateItemPath(ItemPath.pathToItem(four)).should.eql([four])

    it 'should calculate the min item path using id if two candidate items have same text', ->
      three.bodyString = 'four'
      ItemPath.pathToItem(four).should.equal('/one/two/@id = 4')
      outline.evaluateItemPath(ItemPath.pathToItem(four)).should.eql([four])

    it 'should calculate the min item path using id if two candidate items have same text, just different case', ->
      three.bodyString = 'Four'
      ItemPath.pathToItem(four).should.equal('/one/two/@id = 4')
      outline.evaluateItemPath(ItemPath.pathToItem(four)).should.eql([four])

  describe 'Reported Error Cases', ->
    it 'should return empty array when evaluating bad node path', ->
      outline.evaluateItemPath('/////union').should.eql []

  describe 'To String', ->

    it 'should convert path object to path string', ->
      new ItemPath('/*').toString().should.equal('/*')

      new ItemPath('a union b').toString().should.equal('a union b')

      new ItemPath('a intersect b').toString().should.equal('a intersect b')
      new ItemPath('a except b').toString().should.equal('a except b')

      new ItemPath('a union b union c').toString().should.equal('a union (b union c)')
      new ItemPath('(a union b) union c').toString().should.equal('(a union b) union c')

      new ItemPath('///a').toString().should.equal('///a')
      new ItemPath('//a').toString().should.equal('a')
      new ItemPath('a//b').toString().should.equal('a//b')
      new ItemPath('a/..b').toString().should.equal('a/..b')
      new ItemPath('..b').toString().should.equal('..b')
      new ItemPath('/a/ancestor::b').toString().should.equal('/a/ancestor::b')

      new ItemPath('count(*) = 0').toString().should.equal('count(*) = 0')

      new ItemPath('@line = one').toString().should.equal('@line = one')
      new ItemPath('= one').toString().should.equal('= one')
      new ItemPath('= oNe').toString().should.equal('= oNe')
      new ItemPath('oNe').toString().should.equal('oNe')

      new ItemPath('a and b').toString().should.equal('a and b')
      new ItemPath('a or b').toString().should.equal('a or b')
      new ItemPath('not a').toString().should.equal('not a')

      new ItemPath('a and b and c').toString().should.equal('a and (b and c)')
      new ItemPath('not (a and b)').toString().should.equal('not (a and b)')

      new ItemPath('@done').toString().should.equal('@done')
      new ItemPath('@line:strong').toString().should.equal('@line:strong')

      new ItemPath('> 10').toString().should.equal('> 10')
      new ItemPath('@line matches 10').toString().should.equal('@line matches 10')

      new ItemPath('= [s] insensitive').toString().should.equal('= [s] insensitive')

      new ItemPath('/"not a"').toString().should.equal('/"not a"')
      new ItemPath('/other things').toString().should.equal('/other things')
      new ItemPath('/"quoted strings"').toString().should.equal('/quoted strings')
