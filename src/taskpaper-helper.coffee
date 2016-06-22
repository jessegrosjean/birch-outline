TaskPaperChangeDelegate = require './change-delegate'
ItemSerializer = require '../../item-serializer'
Outline = require '../../outline'

# Public: A utility class to easily read/write TaskPapor flavored {Outline}s.
module.exports =
class TaskPaperHelper

  ###
  Section: Read TaskPaper Outlines
  ###

  # Public: Returns an {Outline} created from the passed in {String}.
  #
  # The outline is configured to handle TaskPaper content at runtime. For
  # example when you set attributes through the {Item} API they are encoded in
  # the item body text as @tags. And when you modify the body text @tags are
  # parsed out and stored as attributes.
  #
  # - `taskPaperString` {String} to parse to create the outline.
  @openTaskPaperOutline: (taskPaperString) ->
    outline = new Outline(TaskPaperChangeDelegate)
    items = ItemSerializer.deserializeItems(taskPaperString, outline, ItemSerializer.TaskPaperType)
    outline.root.appendChildren(items)
    outline

  ###
  Section: Read TaskPaper Outlines
  ###

  # Public: Returns a {String} created from serializing the given outline to
  # TaskPaper format.
  #
  # - `outline` {Outline} to serialize.
  @serializeOutlineToTaskPaper: (outline) ->
    ItemSerializer.serializeItems(outline.root.descendants, ItemSerializer.TaskPaperType)
