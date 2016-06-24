webpack = require 'webpack-stream'

uglifyConfig =
  compress:
    warnings: false
  mangle:false

module.exports =
  devtool: 'source-map'
  entry:
    'birchoutline': './lib/index.js'
  output:
    path: './min'
    library: '[name]'
    filename: '[name].js'
  module:
    loaders: [
      test: /\.json$/,
      loader: "json-loader"
    ]
  plugins: [
    new webpack.webpack.optimize.UglifyJsPlugin(uglifyConfig)
    # The below is all experiments in making the web distribution smaller.
    # Should lbe possible
    #new webpack.webpack.IgnorePlugin(/moment/)
    #new webpack.webpack.IgnorePlugin(/item-path.*/)
    #new webpack.webpack.IgnorePlugin(/date-time.*/)
    #new webpack.webpack.IgnorePlugin(/.*opml.*/)
    #new webpack.webpack.IgnorePlugin(/.*bml.*/)
    #new webpack.webpack.IgnorePlugin(/.*url.*/)
    #new webpack.webpack.ContextReplacementPlugin(/moment[\\\/]locale$/, /^\.\/(en)$/)
  ]
