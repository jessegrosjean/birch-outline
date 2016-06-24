{Emitter} = require 'event-kit'
{ assert } = require './util'

module.exports =
class UndoManager

  constructor: ->
    @groupingLevel = 0
    @disabledLevel = 0
    @isRedoing = false
    @isUndoing = false
    @undoStack = []
    @redoStack = []
    @currentGroup = null
    @emitter = new Emitter()
    @removeAllActions()

  ###
  Section: Event Subscription
  ###

  onWillUndo: (callback) ->
    @emitter.on 'will-undo', callback

  onDidUndo: (callback) ->
    @emitter.on 'did-undo', callback

  onWillRedo: (callback) ->
    @emitter.on 'will-redo', callback

  onDidRedo: (callback) ->
    @emitter.on 'did-redo', callback

  onDidOpenUndoGroup: (callback) ->
    @emitter.on 'did-open-undo-group', callback

  onDidCloseUndoGroup: (callback) ->
    @emitter.on 'did-close-undo-group', callback

  ###
  Section: Undo Grouping
  ###

  beginUndoGrouping: (metadata) ->
    @groupingLevel++
    if @groupingLevel is 1
      @currentGroup = []
      @currentGroup.metadata = metadata or {}
      @emitter.emit 'did-open-undo-group', @currentGroup

  endUndoGrouping: ->
    if @groupingLevel > 0
      @groupingLevel--
      if @groupingLevel is 0
        if @currentGroup.length > 0

          if @isUndoing
            @redoStack.push(@currentGroup)
          else if @isRedoing
            @undoStack.push(@currentGroup)
          else
            @undoStack.push(@currentGroup)
            @redoStack = []

        @emitter.emit 'did-close-undo-group', @currentGroup
        @currentGroup = null

  ###
  Section: Undo Registration
  ###

  isUndoRegistrationEnabled: -> @disabledLevel is 0

  disableUndoRegistration: -> @disabledLevel++

  enableUndoRegistration: -> @disabledLevel--

  registerUndoOperation: (operation) ->
    return unless @isUndoRegistrationEnabled()

    @beginUndoGrouping()
    @currentGroup.unshift(operation)
    @endUndoGrouping()

  setActionName: (actionName) ->
    @setUndoGroupMetadata 'actionName', actionName.toLocaleString()

  setUndoGroupMetadata: (key, value) ->
    undoStack = @undoStack
    lastOrCurrentGoup = @currentGroup or undoStack[undoStack.length - 1]
    lastOrCurrentGoup?.metadata[key] = value

  ###
  Section: Undo / Redo
  ###

  canUndo: ->
    not @isUndoing and not @isRedoing and @undoStack.length > 0

  canRedo: ->
    not @isUndoing and not @isRedoing and @redoStack.length > 0

  undo: (context) ->
    assert(@groupingLevel is 0, 'Unclosed grouping')
    assert(@disabledLevel is 0, 'Unclosed disable')

    return unless @canUndo()

    @endUndoGrouping()

    @emitter.emit 'will-undo'
    @isUndoing = true
    @beginUndoGrouping(@getUndoGroupMetadata())

    @undoStack.pop().forEach (each) ->
      if each.performUndoOperation
        each.performUndoOperation(context)
      else
        each(context)

    @endUndoGrouping()
    @isUndoing = false
    @emitter.emit 'did-undo', @getRedoGroupMetadata()

  redo: (context) ->
    assert(@groupingLevel is 0, 'Unclosed grouping')
    assert(@disabledLevel is 0, 'Unclosed disable')

    return unless @canRedo()

    @emitter.emit 'will-redo'
    @isRedoing = true
    @beginUndoGrouping(@getRedoGroupMetadata())

    @redoStack.pop().forEach (each) ->
      if each.performUndoOperation
        each.performUndoOperation(context)
      else
        each(context)

    @endUndoGrouping()
    @isRedoing = false
    @emitter.emit 'did-redo', @getUndoGroupMetadata()

  getUndoGroupMetadata: ->
    @undoStack[@undoStack.length - 1]?.metadata

  getRedoGroupMetadata: ->
    @redoStack[@redoStack.length - 1]?.metadata

  removeAllActions: ->
    assert(@groupingLevel is 0, 'Unclosed grouping')
    assert(@disabledLevel is 0, 'Unclosed disable')
    @undoStack = []
    @redoStack = []
