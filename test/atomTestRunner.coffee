fs = require 'fs'
path = require 'path'
Mocha = require 'mocha'

{allowUnsafeEval, allowUnsafeNewFunction} = require 'loophole'

module.exports = (args) ->

  # Fixes CSP eval restriction
  allowUnsafeEval ->

    mocha = new Mocha(
      ui: 'bdd'
      reporter: 'html'
    )

    applicationDelegate = args.buildDefaultApplicationDelegate()

    # Create element for mocha reporter
    element = document.createElement 'div'
    element.id = 'mocha'
    document.body.appendChild element
    document.body.style.overflow = 'scroll'

    link = document.createElement('link')
    link.setAttribute('rel', 'stylesheet')
    link.setAttribute('href', path.join(__dirname, '..', 'node_modules/mocha/mocha.css'))
    document.head.appendChild(link)

    # Build atom global
    window.atom = args.buildAtomEnvironment({
      applicationDelegate, window, document
      configDirPath: process.env.ATOM_HOME
      enablePersistence: false
    })

    for each in args.testPaths
      Mocha.utils.lookupFiles(each, ['js', 'coffee'], true).forEach(mocha.addFile.bind(mocha))

    # Run tests and return a promise
    new Promise((resolve, reject) ->
      mocha.run((failures) ->
        resolve(failures)
      )
    )
