DateTimeParser = require '../src/date-time-parser'
should = require('chai').should()
moment = require 'moment'

describe 'DateTimeParser', ->
  currentMoment = null

  beforeEach ->
    currentMoment = moment()

  it 'should parse full examples', ->
    DateTimeParser.parse('1976-11-27 at 2pm +2s -1sec +2s', moment: moment).format().should.equal(moment([1976, 10, 27]).hour(14).second(3).format())
    DateTimeParser.parse('1976-11-27 2pm +2s -1sec +2s', moment: moment).format().should.equal(moment([1976, 10, 27]).hour(14).second(3).format())

  describe 'Absolute Dates', ->

    it '1976-11-27', ->
      DateTimeParser.parse('1976-11-27', moment: moment).format().should.equal(moment([1976, 10, 27]).format())

    it '1976-11', ->
      DateTimeParser.parse('1976-11', moment: moment).format().should.equal(moment([1976, 10, 1]).format())

    it '2012', ->
      DateTimeParser.parse('2012', moment: moment).format().should.equal(moment([2012]).format())

  describe 'Relative Dates', ->

    it 'today', ->
      DateTimeParser.parse('today', moment: moment).format().should.equal(moment().startOf('day').format())

    it 'yesterday', ->
      DateTimeParser.parse('yesterday', moment: moment).format().should.equal(moment().startOf('day').subtract(1, 'day').format())

    it 'tomorrow', ->
      DateTimeParser.parse('tomorrow', moment: moment).format().should.equal(moment().startOf('day').add(1, 'day').format())

    it 'last unit', ->
      DateTimeParser.parse('last year', moment: moment).format().should.equal(moment().subtract(1, 'year').startOf('year').format())
      DateTimeParser.parse('last quarter', moment: moment).format().should.equal(moment().subtract(1, 'quarter').startOf('quarter').format())
      DateTimeParser.parse('last month', moment: moment).format().should.equal(moment().subtract(1, 'month').startOf('month').format())
      DateTimeParser.parse('last week', moment: moment).format().should.equal(moment().subtract(1, 'week').startOf('week').format())
      DateTimeParser.parse('last day', moment: moment).format().should.equal(moment().subtract(1, 'day').startOf('day').format())

    it 'this unit', ->
      DateTimeParser.parse('this year', moment: moment).format().should.equal(moment().startOf('year').format())
      DateTimeParser.parse('this quarter', moment: moment).format().should.equal(moment().startOf('quarter').format())
      DateTimeParser.parse('this month', moment: moment).format().should.equal(moment().startOf('month').format())
      DateTimeParser.parse('this week', moment: moment).format().should.equal(moment().startOf('week').format())
      DateTimeParser.parse('this day', moment: moment).format().should.equal(moment().startOf('day').format())

    it 'next unit', ->
      DateTimeParser.parse('next year', moment: moment).format().should.equal(moment().add(1, 'year').startOf('year').format())
      DateTimeParser.parse('next quarter', moment: moment).format().should.equal(moment().add(1, 'quarter').startOf('quarter').format())
      DateTimeParser.parse('next month', moment: moment).format().should.equal(moment().add(1, 'month').startOf('month').format())
      DateTimeParser.parse('next Month', moment: moment).format().should.equal(moment().add(1, 'month').startOf('month').format())
      DateTimeParser.parse('next week', moment: moment).format().should.equal(moment().add(1, 'week').startOf('week').format())
      DateTimeParser.parse('next isoweek', moment: moment).format().should.equal(moment().add(1, 'isoweek').startOf('isoweek').format())
      DateTimeParser.parse('next day', moment: moment).format().should.equal(moment().add(1, 'day').startOf('day').format())

    it 'named month', ->
      DateTimeParser.parse('jul 7', moment: moment).format().should.equal(moment().startOf('year').month('july').date(7).format())
      DateTimeParser.parse('july 7', moment: moment).format().should.equal(moment().startOf('year').month('july').date(7).format())
      DateTimeParser.parse('JuLy 7', moment: moment).format().should.equal(moment().startOf('year').month('july').date(7).format())
      DateTimeParser.parse('next JuLy 7', moment: moment).format().should.equal(moment().startOf('year').month('july').date(7).add(1, 'year').format())
      DateTimeParser.parse('last JuLy 7', moment: moment).format().should.equal(moment().startOf('year').month('july').date(7).subtract(1, 'year').format())

    it 'named day', ->
      DateTimeParser.parse('monday', moment: moment).format().should.equal(moment().startOf('day').day('monday').format())
      DateTimeParser.parse('mon', moment: moment).format().should.equal(moment().startOf('day').day('monday').format())
      DateTimeParser.parse('next mon', moment: moment).format().should.equal(moment().startOf('day').day('monday').add(1, 'week').format())
      DateTimeParser.parse('last mon', moment: moment).format().should.equal(moment().startOf('day').day('monday').subtract(1, 'week').format())

  describe 'Time', ->
    it '2:15:32', ->
      DateTimeParser.parse('2:15:32', startRule:'Time', moment: moment).toISOString().should.equal('PT2H15M32S')

    it '2:15:32(am/pm)', ->
      DateTimeParser.parse('2:15:32am', startRule:'Time', moment: moment).toISOString().should.equal('PT2H15M32S')
      DateTimeParser.parse('2:15:32 PM', startRule:'Time', moment: moment).toISOString().should.equal('PT14H15M32S')

    it '2:15', ->
      DateTimeParser.parse('2:15', startRule:'Time', moment: moment).toISOString().should.equal('PT2H15M')
      DateTimeParser.parse('2:15', moment: moment).minute().should.equal(15)

    it '2(am/pm)', ->
      DateTimeParser.parse('2 Am', startRule:'Time', moment: moment).toISOString().should.equal('PT2H')
      DateTimeParser.parse('2pm', startRule:'Time', moment: moment).toISOString().should.equal('PT14H')
      DateTimeParser.parse('2 am', moment: moment).hour().should.equal(2)
      DateTimeParser.parse('2pm', moment: moment).hour().should.equal(14)

    it '2 should throw', ->
      (-> DateTimeParser.parse('2', startRule:'Time')).should.throw()

  describe 'Durations', ->

    it 'milliseconds', ->
      DateTimeParser.parse('3 milliseconds', startRule:'Duration', moment: moment).toISOString().should.equal('PT0.003S')
      DateTimeParser.parse('3 millisecond', startRule:'Duration', moment: moment).toISOString().should.equal('PT0.003S')
      DateTimeParser.parse('3 ms', startRule:'Duration', moment: moment).toISOString().should.equal('PT0.003S')
      DateTimeParser.parse('3 ms', currentMoment: currentMoment, moment: moment).unix().should.equal(currentMoment.unix())

    it 'seconds', ->
      DateTimeParser.parse('3 seconds', startRule:'Duration', moment: moment).toISOString().should.equal('PT3S')
      DateTimeParser.parse('3 second', startRule:'Duration', moment: moment).toISOString().should.equal('PT3S')
      DateTimeParser.parse('3 sec', startRule:'Duration', moment: moment).toISOString().should.equal('PT3S')
      DateTimeParser.parse('3 s', startRule:'Duration', moment: moment).toISOString().should.equal('PT3S')
      DateTimeParser.parse('3 s', currentMoment: currentMoment, moment: moment).unix().should.equal(currentMoment.unix() + 3)

    it 'minutes', ->
      DateTimeParser.parse('10 minuTes', startRule:'Duration', moment: moment).toISOString().should.equal('PT10M')
      DateTimeParser.parse('10 minuTe', startRule:'Duration', moment: moment).toISOString().should.equal('PT10M')
      DateTimeParser.parse('10 min', startRule:'Duration', moment: moment).toISOString().should.equal('PT10M')
      DateTimeParser.parse('10 m', startRule:'Duration', moment: moment).toISOString().should.equal('PT10M')
      DateTimeParser.parse('3 m', currentMoment: currentMoment, moment: moment).unix().should.equal(currentMoment.unix() + (3 * 60))

    it 'hours', ->
      DateTimeParser.parse('2 hours', startRule:'Duration', moment: moment).toISOString().should.equal('PT2H')
      DateTimeParser.parse('2 hour', startRule:'Duration', moment: moment).toISOString().should.equal('PT2H')
      DateTimeParser.parse('2h', startRule:'Duration', moment: moment).toISOString().should.equal('PT2H')
      DateTimeParser.parse('3 h', currentMoment: currentMoment, moment: moment).unix().should.equal(currentMoment.unix() + (60 * 60 * 3))

    it 'days', ->
      DateTimeParser.parse('2 days', startRule:'Duration', moment: moment).toISOString().should.equal('P2D')
      DateTimeParser.parse('2 day', startRule:'Duration', moment: moment).toISOString().should.equal('P2D')
      DateTimeParser.parse('2d', startRule:'Duration', moment: moment).toISOString().should.equal('P2D')

    it 'weeks', ->
      DateTimeParser.parse('4 weeks', startRule:'Duration', moment: moment).toISOString().should.equal('P28D')
      DateTimeParser.parse('4 week', startRule:'Duration', moment: moment).toISOString().should.equal('P28D')
      DateTimeParser.parse('4 w', startRule:'Duration', moment: moment).toISOString().should.equal('P28D')
      DateTimeParser.parse('4 w', startRule:'Duration', moment: moment).asSeconds().should.equal(2419200)
      DateTimeParser.parse('1 w', startRule:'Duration', moment: moment).asSeconds().should.equal(60 * 60 * 24 * 7)
      DateTimeParser.parse('2 w', startRule:'Duration', moment: moment).asSeconds().should.equal(60 * 60 * 24 * 7 * 2)

    it 'months', ->
      DateTimeParser.parse('4 months', startRule:'Duration', moment: moment).toISOString().should.equal('P4M')
      DateTimeParser.parse('4 month', startRule:'Duration', moment: moment).toISOString().should.equal('P4M')
      DateTimeParser.parse('4 o', startRule:'Duration', moment: moment).toISOString().should.equal('P4M')

    it 'quarters', ->
      DateTimeParser.parse('3 quarters', startRule:'Duration', moment: moment).toISOString().should.equal('P9M')
      DateTimeParser.parse('3 quarter', startRule:'Duration', moment: moment).toISOString().should.equal('P9M')
      DateTimeParser.parse('3 q', startRule:'Duration', moment: moment).toISOString().should.equal('P9M')

    it 'years', ->
      DateTimeParser.parse('3 years', startRule:'Duration', moment: moment).toISOString().should.equal('P3Y')
      DateTimeParser.parse('3 year', startRule:'Duration', moment: moment).toISOString().should.equal('P3Y')
      DateTimeParser.parse('3 y', startRule:'Duration', moment: moment).toISOString().should.equal('P3Y')

    it '+ & -', ->
      DateTimeParser.parse('- 3 years', startRule:'Duration', moment: moment).toISOString().should.equal('-P3Y')
      DateTimeParser.parse('+3years', startRule:'Duration', moment: moment).toISOString().should.equal('P3Y')

    it 'should not conflict with years', ->
      DateTimeParser.parse('2012 seconds', currentMoment: currentMoment, moment: moment).unix().should.equal(currentMoment.unix() + 2012)
      DateTimeParser.parse('2012s', currentMoment: currentMoment, moment: moment).unix().should.equal(currentMoment.unix() + 2012)
