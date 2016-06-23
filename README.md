# Birch Outline

[![Build Status](https://travis-ci.org/jessegrosjean/birch-outline.svg?branch=master)](https://travis-ci.org/jessegrosjean/birch-outline)

Outline model layer used by [TaskPaper](https://www.taskpaper.com).

## Features:

1. Model: `Outline` has root `Item` that contains child items and has an `AttributedString` body.
2. Runtime: Change events, undo support, query language, date/time parsing.
3. Serialization: Read/Write .taskpaper, .opml, .bml

## Getting Started

Load, process, and save a TaskPaper outlines:

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
var endText = taskPaper.serialize() // Hello world @testing(456) @done
```

## Code Status

This is an extraction work in progress. I won't do semantic versioning or publish to NPM until it reaches 1.0. Some of the code is clean and well tested, some not. In particular serialization to `.opml` and `.bml` is not well tested. Let me know what works and what doesn't and we'll get this thing polished.

## Help

Any and all help is appreciated. My goal is to create a clean well tested and documented outliner model that can be used in many projects.
