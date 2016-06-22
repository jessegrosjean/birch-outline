DateTimeParser = require './date-time-parser'
moment = require 'moment'

# Public: Date and time parsing and conversion.
module.exports =
class DateTime

  # Public: Parse the given string and return associated {Date}.
  #
  # - `string` The date/time {String}.
  #
  # Returns {Date}.
  @parse: (string) ->
    try
      return DateTimeParser.parse(string, moment: moment).toDate()
    catch e
      return new Date(string)

  # Public: Format the given date/time {String} or {Date} as a minimal absolute date/time {String}.
  #
  # - `dateOrString` The date/time {String} or {Date} to format.
  #
  # Returns {String}.
  @format: (dateOrString) ->
    try
      m = DateTimeParser.parse(dateOrString, moment: moment)
    catch e
      m = moment(dateOrString)

    if m.milliseconds()
      m.format('YYYY-MM-DD HH:mm:ss:SSS')
    else if m.seconds()
      m.format('YYYY-MM-DD HH:mm:ss')
    else if m.hours() or m.minutes()
      m.format('YYYY-MM-DD HH:mm')
    else
      m.format('YYYY-MM-DD')
