deserializeItems = (pathList, outline, options) ->
  filenames = pathList.split('\n')
  items = []
  for each in filenames
    item = outline.createItem()
    item.bodyString = each.trim().replace(/[ ]/g, '\\ ')
    items.push item
  items

module.exports =
  deserializeItems: deserializeItems
