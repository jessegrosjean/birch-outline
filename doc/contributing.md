# Contributing

I hope birch-outline can be useful for many different outliner projects. Please check out the code and help me make it even better.

## Building

The build process is:

1. Clean the project and lint the sources
2. Run all tests `test`
3. Process and copy all scripts in `src` to `lib`
4. Bundle scripts in `lib` into `birchoutline.js` in `min`

To do a full build:

```shell
npm prepublish
```

To do a _watch_ build that automatically rebuilds when you modify a source:

```shell
npm start
```

## Debugging

You can run test in [Atom](http://atom.io) and use Chrome's debugger:

1. Open `birch-outline` in Atom
2. Choose the View > Developer > Run Package Specs menu
3. Option-Command-I to bring up debugger
4. Command-R to rerun tests

## Project Ideas

There are some ideas that I think would be neat:

1. Create a command line interface for processing TaskPaper files. For example make it easy to run an `ItemPath` queries on a file and return the results.

2. Create a webpage for displaying TaskPaper outlines. Matt Gemmell has a [great start](https://github.com/mattgemmell/TaskPaperRuby) but I think using `birch-outline` can make it easier to implement and with more features. For example the published outline could be filtered dynamically in the web page using `ItemPath` queries.
