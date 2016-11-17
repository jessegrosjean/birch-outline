{Emitter, CompositeDisposable} = require 'event-kit'
util = require './util'
_ = require 'underscore-plus'

# Private: A live query.
module.exports =
class ItemPathQuery

  outline: null
  outlineSubscription: null
  outlineDestroyedSubscription: null
  debouncedRun: null

  constructor: (@outline, @itemPath) ->
    @emitter = new Emitter()
    @debouncedRun = @run.bind(@)
    @outlineDestroyedSubscription = @outline.onDidDestroy => @destroy()
    @queryFunction = (outline, contextItem, itemPath, options) ->
      outline.evaluateItemPath(itemPath, contextItem, options)

  destroy: ->
    unless @destroyed
      @stop()
      @outlineDestroyedSubscription.dispose()
      @emitter.emit 'did-destroy'
      @outline = null
      @destroyed = true

  ###
  Section: Events
  ###

  # Public: Invoke the given callback when the value of {::results} changes.
  #
  # - `callback` {Function} to be called when the path changes.
  #   - `results` {Array} of matches.
  #
  # Returns a {Disposable} on which `.dispose()` can be called to unsubscribe.
  onDidChange: (callback) ->
    @emitter.on 'did-change', callback

  # Public: Invoke the given callback when the query is destroyed.
  #
  # - `callback` {Function} to be called when the query is destroyed.
  #
  # Returns a {Disposable} on which `.dispose()` can be called to unsubscribe.
  onDidDestroy: (callback) ->
    @emitter.on 'did-destroy', callback

  ###
  Section: Configuring Queries
  ###

  # Public: Read-write item path context item.
  contextItem: null
  Object.defineProperty @::, 'contextItem',
    get: ->
      @_contextItem
    set: (@_contextItem) ->
      @scheduleRun()

  # Public: Read-write Item path.
  itemPath: null
  Object.defineProperty @::, 'itemPath',
    get: ->
      @_itemPath
    set: (@_itemPath) ->
      @scheduleRun()

  # Public: Read-write item path options.
  options: null
  Object.defineProperty @::, 'options',
    get: ->
      @_options
    set: (@_options) ->
      if @_options?.debounce
        @debouncedRun = _.debounce(@run.bind(@), @_options.debounce)
      else
        @debouncedRun = @run.bind(@)
      @scheduleRun()

  queryFunction: null
  Object.defineProperty @::, 'queryFunction',
    get: ->
      @_queryFunction
    set: (@_queryFunction) ->
      @scheduleRun()

  ###
  Section: Running Queries
  ###

  # Public: Read-only is query started.
  started: false

  # Public: Start the query.
  start: ->
    return if @started
    @started = true
    @outlineSubscription = @outline.onDidEndChanges (changes) =>
      if changes.length > 0
        @scheduleRun()
    @run()

  # Public: Stop the query.
  stop: ->
    return unless @started
    @started = false
    @outlineSubscription.dispose()

  scheduleRun: ->
    if @started
      @debouncedRun()

  run: ->
    if @started
      nextResults = @queryFunction(@outline, @contextItem, @itemPath, @options)
      unless util.shallowArrayEqual(@results, nextResults)
        @results = nextResults
        @emitter.emit 'did-change', @results

  ###
  Section: Getting Query Results
  ###

  # Public: Read-only {Array} of matching {Item}s.
  results: []
