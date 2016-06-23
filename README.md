# Birch Outline

[![Build Status](https://travis-ci.org/jessegrosjean/birch-outline.svg?branch=master)](https://travis-ci.org/jessegrosjean/birch-outline) [![Dependencies Status](https://david-dm.org/jessegrosjean/birch-outline.svg)](https://david-dm.org/jessegrosjean/birch-outline.svg)

Outline model layer used by [TaskPaper](https://www.taskpaper.com).

1. **Model:** `Outline` has root `Item` that contains child `Items`, each of which have attributes and an `AttributedString` body.
2. **Runtime:** Change events, undo support, query evaluator, and relative date/time parsing.
3. **Serialization:** Read/Write .taskpaper, .opml, and .bml

Please read [Getting Started](./doc/getting-started) to learn more.

Help and suggestions are appriciated.
