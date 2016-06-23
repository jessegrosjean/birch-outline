# Contributing

My goal is to make it easy to work with TaskPaper files. My large goal is to provide a good outliner runtime that can be used in many projects. Any help or suggestions is appriciated.

## Development Process

The build process is:

1. `clean`, `lint`
2. All tests in `test` are run
3. Scripts in `src` are processed and copied to `lib`
4. Scripts in `lib` are bundles and saved into `min`

To do a full build use:

```shell
npm prepublish
```

To do a "watch" build where it automatically builds when you save a source file use:

```shell
npm start
```

The project is also setup so that if you open it in [Atom](http://atom.io) you can run the tests there where you can use Chrome's debugger. To run tests in Atom:

1. Open `birch-outline` in Atom
2. View > Developer > Run Package Specs
3. Option-Command-I to bring up debugger.
4. Command-R to rerun.

## Project Ideas

There are some ideas that I think would be neat, but that I don't have time to work on myself:

1. Create a command line interace for processing TaskPaper files. For exmaple make it easy to run an `ItemPath` queries on a file and return the results.

2. Create a webpage for displaying TaskPaper outlines. Matt Gemmell has a [great start](https://github.com/mattgemmell/TaskPaperRuby) but I think using `birch-outline` can make it easier to implement and with more features. For example the published outline could be filtered dynamically in the web page using `ItemPath` queries.
