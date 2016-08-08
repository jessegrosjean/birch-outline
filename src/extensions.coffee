module.exports =
class Extensions

  @PRIORITY_NORMAL: 0
  @PRIORITY_FIRST: (-1)
  @PRIORITY_LAST: 1

  constructor: ->
    @extensionPointsToExtensions = new Map

  add: (extensionPoint, extension, priority=Extensions.PRIORITY_NORMAL) ->
    extensions = @extensionPointsToExtensions.get(extensionPoint)
    if not extensions
      extensions = []
      @extensionPointsToExtensions.set(extensionPoint, extensions)
    extensions.needsSort = true
    extensions.push
      extension: extension
      priority: priority

  remove: (extensionPoint, extension) ->
    result = @extensionPointsToExtensions.get(extensionPoint)?.filter

  processExtensions: (extensionPoint, callback, returnFirst) ->
    extensions = @extensionPointsToExtensions.get(extensionPoint)
    if extensions
      if extensions.needsSort
        extensions.sort (a, b) ->
          a.priority - b.priority
      for each in extensions
        result = callback(each)
        if result isnt undefined and returnFirst
          return result

