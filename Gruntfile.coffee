path = require('path')
webpack = require 'webpack'

module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    copy:
      js:
        expand: true,
        cwd: './src'
        src: ['**/*.js']
        dest: 'lib/'

    coffee:
      options:
        bare: true
        #sourceMap: true
      glob_to_multiple:
        expand: true
        cwd: 'src'
        src: ['**/*.coffee']
        dest: 'lib'
        ext: '.js'

    coffeelint:
      options:
        no_empty_param_list:
          level: 'error'
        max_line_length:
          level: 'ignore'
        indentation:
          level: 'ignore'

      src: ['src/**/*.coffee']
      test: ['spec/**/*.coffee']
      gruntfile: ['Gruntfile.coffee']

    mochaTest:
      options:
        reporter: 'nyan'
      src: ['spec/**/*.coffee']

    exec:
      doc:
        cmd: "./node_modules/atomdoc-md/bin/atomdoc-md.js generate . -o doc -n api.md"

    webpack:
      birch:
        entry: './lib/index.js'
        output:
          path: "min/"
          filename: "birch-min.js"
        module:
          loaders: [
            { test: /\.json$/, loader: "json-loader"}
          ]
        plugins: [
          new webpack.optimize.UglifyJsPlugin()
        ]
        devtool: 'source-map'

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-shell')
  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-mocha-test')
  grunt.loadNpmTasks('grunt-webpack')
  grunt.loadNpmTasks('grunt-exec')

  grunt.registerTask 'clean', ->
    rimraf = require('rimraf')
    rimraf.sync('lib')
    rimraf.sync('min')
    rimraf.sync('doc')
  grunt.registerTask('lint', ['coffeelint'])
  grunt.registerTask('default', ['lint', 'coffee', 'copy'])
  grunt.registerTask('test', ['lint', 'mochaTest', 'coffee', 'copy'])
  grunt.registerTask('prepublish', ['clean', 'test', 'webpack', 'exec:doc'])
