tagsHelper = require './tags'
taskRegex = /^([\-+*])\s/
projectRegex = /:$/

parseType = (contentString) ->
  if contentString.match(taskRegex)
    'task'
  else if contentString.match(projectRegex)
    'project'
  else
    'note'

syncTypeAttributeToItemBody = (item, newType, oldType) ->
  # Remove old type syntax
  switch oldType
    when 'project'
      trailingTagsLength = tagsHelper.parseTags(item.bodyString).trailingMatch?[0].length ? 0
      item.replaceBodyRange(item.bodyString.length - (1 + trailingTagsLength), 1, '')
    when 'task'
      item.replaceBodyRange(0, 2, '')

  # Add new type syntax
  switch newType
    when 'project'
      trailingTagsLength = tagsHelper.parseTags(item.bodyString).trailingMatch?[0].length ? 0
      item.replaceBodyRange(item.bodyString.length - trailingTagsLength, 0, ':')
    when 'task'
      item.replaceBodyRange(0, 0, '- ')

module.exports =
  taskRegex: taskRegex
  projectRegex: projectRegex
  parseType: parseType
  syncTypeAttributeToItemBody: syncTypeAttributeToItemBody
