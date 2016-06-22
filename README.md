# Birch Outline

Model layer for an outliner. This model is extracted from [TaskPaper](https://www.taskpaper.com), but it is intended to be generic and suitable for reuse in other outliner projects. It should run in node.js, JavaScriptCore (iOS), and on the web. I plan to create a Swift wrapper project for use on macOS and iOS.

## Features:

1. Model: `Outline` has root `Item` that contains child items and has an `AttributedString` body.
2. Runtime: Change events, undo support, query language, date/time parsing.
3. Serialization: Read/Write .taskpaper, .opml, .bml

## Code Status

This is a prerelease. I won't do semantic versioning or publish to NPM until it reaches 1.0. Some of the code is clean and well tested, some not. In particular serialization to `.opml` and `.bml` is not well tested.

## Getting Started

Load, process, and save a TaskPaper outline:

```javascript
var birch = require('birch-outline')

// Load Outline
var startText = 'Hello world @testing(123)'
var taskPaper = birch.Outline.createTaskPaperOutline(startText)

// Process Outline
var item = taskPaper.root.firstChild
item.setAttribute('data-testing', '456')
item.setAttribute('data-done', '')

// Save Outline
var endText = taskPaper.serialize()
```

## Help

Any and all help is appreciated. My goal is to create a clean well tested and documented outliner model that can be used in many projects.
