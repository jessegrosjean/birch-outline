AttributedString = require './attributed-string'
ElementType = require 'domelementtype'
htmlparser = require 'htmlparser2'
dom = require './dom'
assert = require 'assert'

InlineBMLTags =
  # Inline text semantics
  'a': true
  'abbr': true
  'b': true
  'bdi': true
  'bdo': true
  'br': true
  'cite': true
  'code': true
  'data': true
  'dfn': true
  'em': true
  'i': true
  'kbd': true
  'mark': true
  'q': true
  'rp': true
  'rt': true
  'ruby': true
  's': true
  'samp': true
  'small': true
  'span': true
  'strong': true
  'sub': true
  'sup': true
  'time': true
  'u': true
  'var': true
  'wbr': true

  # Image & multimedia
  'audio': true
  'img': true
  'video': true

  # Edits
  'del': true
  'ins': true

AttributedString.fromInlineBMLString = (inlineBMLString) ->
  result = null
  handler = new htmlparser.DomHandler (error, dom) =>
    if (error)
      console.log(error)
    else
      result = @fromInlineBML(dom)
  parser = new htmlparser.Parser handler,
    decodeEntities: true
    lowerCaseTags: true
  parser.write(inlineBMLString)
  parser.done()
  result

AttributedString.fromInlineBML = (domArray) ->
  if domArray.length is 0
    new AttributedString()
  if domArray.length == 1 and domArray[0].type is ElementType.Text
    new AttributedString(domArray[0].data)
  else
    attributedString = new AttributedString()
    for each in domArray
      addDOMNodeToAttributedString(each, attributedString)
    attributedString

AttributedString.validateInlineBML = (inlineBMLContainer) ->
  end = dom.nodeNextBranch inlineBMLContainer
  each = dom.nextNode inlineBMLContainer
  while each isnt end
    if tagName = each.name
      assert.ok(InlineBMLTags[tagName], "Unexpected tagName '#{tagName}' in 'P'")
    each = dom.nextNode each

addDOMNodeToAttributedString = (node, attributedString) ->
  type = node.type

  if type is ElementType.Text
    attributedString.appendText(new AttributedString(node.data.replace(/(\r\n|\n|\r)/gm,'')))
  else if type is ElementType.Tag
    tagStart = attributedString.getLength()
    each = dom.firstChild(node)

    if each
      while each
        addDOMNodeToAttributedString(each, attributedString)
        each = each.next
      if InlineBMLTags[node.name]
        attributedString.addAttributeInRange(node.name, node.attribs, tagStart, attributedString.getLength() - tagStart)
    else if InlineBMLTags[node.name]
      if node.name is 'br'
        lineBreak = new AttributedString(AttributedString.LineSeparatorCharacter)
        lineBreak.addAttributeInRange('br', node.attribs, 0, 1)
        attributedString.appendText(lineBreak)
      else if node.name is 'img'
        image = new AttributedString(AttributedString.ObjectReplacementCharacter)
        image.addAttributeInRange('img', node.attribs, 0, 1)
        attributedString.appendText(image)

AttributedString.inlineBMLToText = (inlineBMLContainer) ->
  if inlineBMLContainer
    end = dom.nodeNextBranch(inlineBMLContainer)
    each = dom.nextNode(inlineBMLContainer)
    text = []

    while each isnt end
      type = each.type

      if type is ElementType.Text
        text.push(each.data)
      else if type is ElementType.Tag and not dom.firstChild(each)
        tagName = each.name

        if tagName is 'br'
          text.push(AttributedString.LineSeparatorCharacter)
        else if tagName is 'img'
          text.push(AttributedString.ObjectReplacementCharacter)
      each = dom.nextNode(each)
    text.join('')
  else
    ''

module.exports = AttributedString
