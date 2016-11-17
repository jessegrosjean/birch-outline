DateTimeParser = require './date-time-parser'
moment = require 'moment'

# Public: Date and time parsing and conversion.
module.exports =
class DateTime

  # Public: Parse the given string and return associated {Date}.
  #
  # - `string` The date/time {String}.
  #
  # Returns {Date} or null.
  @parse: (string) ->
    try
      return DateTimeParser.parse(string, moment: moment).toDate()
    catch e
      m = moment(string, moment.ISO_8601, true)
      if m.isValid()
        m.toDate()
      else
        null

  # Public: Format the given date/time {String} or {Date} as a minimal absolute date/time {String}.
  #
  # - `dateOrString` The date/time {String} or {Date} to format.
  #
  # Returns {String}.
  @format: (dateOrString, showMillisecondsIfNeeded=true, showSecondsIfNeeded=true) ->
    try
      m = DateTimeParser.parse(dateOrString, moment: moment)
    catch e
      m = moment(dateOrString, moment.ISO_8601, true)
      if not m.isValid()
        return 'invalid date'

    if m.milliseconds() and showMillisecondsIfNeeded
      m.format('YYYY-MM-DD HH:mm:ss:SSS')
    else if m.seconds() and showSecondsIfNeeded
      m.format('YYYY-MM-DD HH:mm:ss')
    else if m.hours() or m.minutes()
      m.format('YYYY-MM-DD HH:mm')
    else
      m.format('YYYY-MM-DD')
