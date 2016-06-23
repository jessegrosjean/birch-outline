# Birch Outline

[![Build Status](https://travis-ci.org/jessegrosjean/birch-outline.svg?branch=master)](https://travis-ci.org/jessegrosjean/birch-outline) [![Dependencies Status](https://david-dm.org/jessegrosjean/birch-outline.svg)](https://david-dm.org/jessegrosjean/birch-outline.svg)

Cross-platform scripting for [TaskPaper](https://www.taskpaper.com).

1. **Model:** `Outline` contains `Items` each of which has attributes and an `AttributedString` body.
2. **Runtime:** Change events, undo support, query evaluator, and relative date/time parsing.
3. **Serialization:** Read/Write .taskpaper, .opml, and .bml

Suitable for processing TaskPaper files wherever there's JavaScript. Also potentially useful when creating your own apps that need an outline model.

Please read [Getting Started](./doc/getting-started.md) to learn more.
