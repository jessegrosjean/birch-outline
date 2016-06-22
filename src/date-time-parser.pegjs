// To generate date-time-parser.js:
//   $ pegjs --cache  --allowed-start-rules DateTimeExpression,Time,Duration date-time-parser.pegjs

{
  //var script = document.createElement('script')
  //script.src = "https://cdn.jsdelivr.net/momentjs/2.11.1/moment.min.js";
  //document.head.appendChild(script);

  if (!options.moment) {
    options.moment = moment;
  }

  function currentMoment() {
    if (!options.currentMoment) {
      options.currentMoment = options.moment();
    }
    return options.moment(options.currentMoment);
  }
}

DateTimeExpression
  = dateTime:Date? _ time:Time? _ durations:(Duration _)* {
      if (!dateTime) {
        dateTime = currentMoment()
      }

      var result = options.moment(dateTime)

      if (time) {
        result = result.startOf('day');
        result.add(time);
      }

      durations.forEach(function(each) {
        result.add(each[0]);
      });

      return result;
    }

Date
  = AbsoluteDate
  / RelativeDate

AbsoluteDate
  = year:(Year _ !DurationUnit _ !Period _ !':') month:('-' MonthNumber)? day:('-' DayNumberOfMonth)? {
      if (month) {
        month = month[1]
      } else {
        month = 0
      }

      if (day) {
        day = day[1]
      } else {
        day = 1
      }
      return options.moment([year[0], month, day]);
    }

Year
  = year:[0-9]+ {
      return parseInt(year.join(''), 10);
    }

MonthNumber
  = month:[0-9]+ {
      return parseInt(month.join(''), 10) - 1;
    }

DayNumberOfMonth
  = day:[0-9]+ {
      return parseInt(day.join(''), 10);
    }

RelativeDate
  = 'now'i { return currentMoment(); }
  / 'yesterday'i { return currentMoment().startOf('day').subtract(1, 'day'); }
  / 'today'i { return currentMoment().startOf('day'); }
  / 'tomorrow'i { return currentMoment().startOf('day').add(1, 'day'); }
  / RelativeMonth
  / RelativeDayOfWeek
  / RelativeDuration

RelativeMonth
  = specifier:RelativeSpecifier? _ month:MonthName _ day:DayNumberOfMonth? {
      if (day == undefined) {
        day = 1;
      }

      if (!specifier || specifier == 'this') {
        return currentMoment().startOf('day').month(month).date(day)
      } else if (specifier == 'next') {
        return currentMoment().startOf('day').month(month).date(day).add(1, 'year')
      } else if (specifier == 'last') {
        return currentMoment().startOf('day').month(month).date(day).subtract(1, 'year')
      }
    }

RelativeSpecifier
  = specifier:('this'i / 'next'i / 'last'i) {
      return specifier.toLowerCase();
    }

MonthName
  = 'january'i
  / 'jan'i
  / 'february'i
  / 'feb'i
  / 'march'i
  / 'mar'i
  / 'april'i
  / 'apr'i
  / 'may'i
  / 'june'i
  / 'jun'i
  / 'july'i
  / 'jul'i
  / 'august'i
  / 'aug'i
  / 'september'i
  / 'sep'i
  / 'october'i
  / 'oct'i
  / 'november'i
  / 'nov'i
  / 'december'i
  / 'dec'i

RelativeDayOfWeek
  = specifier:RelativeSpecifier? _ day:DayOfWeek {
      if (!specifier || specifier == 'this') {
        return currentMoment().startOf('day').day(day);
      } else if (specifier == 'next') {
        return currentMoment().startOf('day').day(day).add(1, 'week');
      } else if (specifier == 'last') {
        return currentMoment().startOf('day').day(day).subtract(1, 'week');
      }
    }

RelativeDuration
  = specifier:RelativeSpecifier _ durationUnit:DurationUnit {
      if (specifier == 'this') {
        return currentMoment().startOf(durationUnit);
      } else if (specifier == 'next') {
        return currentMoment().startOf(durationUnit).add(1, durationUnit);
      } else if (specifier == 'last') {
        return currentMoment().startOf(durationUnit).subtract(1, durationUnit);
      }
    }

DayOfWeek
  = 'monday'i
  / !'mont'i 'mon'i { return 'mon'; }
  / 'tuesday'i
  / 'tue'i
  / 'wednesday'i
  / 'wed'i
  / 'thursday'i
  / 'thu'i
  / 'friday'i
  / 'fri'i
  / 'saturday'i
  / 'sat'i
  / 'sunday'i
  / 'sun'i

Time
  = _ 'at'i? _ hours:Integer _ period:Period {
      if (period == 'pm') {
        hours += 12;
      }
      return options.moment.duration({ hours: hours });
    }

  / hours:Integer minutes:(':' integer:Integer) seconds:(':' integer:Integer)? milliseconds:(':' integer:Integer)? _ period:Period? {
      if (period == 'pm') {
        hours += 12;
      }

      if (seconds) {
        seconds = seconds[1];
      } else {
        seconds = 0;
      }

      if (milliseconds) {
        milliseconds = milliseconds[1]
      } else {
        milliseconds = 0
      }

      return options.moment.duration({
        hours: hours,
        minutes: minutes[1],
        seconds: seconds,
        milliseconds: milliseconds
      });
    }

Period
  = period:('pm'i / 'am'i) {
      return period.toLowerCase();
    }

Duration
  = adjust: ('-' / '+')? _ quantity:Integer _ durationUnit:DurationUnit  {
      if (adjust == '-') {
        quantity *= -1
      }
      return options.moment.duration(quantity, durationUnit);
    }

DurationUnit
  = ('milliseconds'i / 'millisecond'i / 'ms'i) { return 'milliseconds' }
  / ('seconds'i / 'second'i / 'sec'i / !'sa'i !'su'i 's'i) { return 'seconds' }
  / ('minutes'i / 'minute'i / 'mins'i / 'min'i / !'mo'i !'ma'i 'm'i) { return 'minutes' }
  / ('hours'i / 'hour'i / 'h'i) { return 'hours' }
  / ('days'i / 'day'i / !'de'i 'd'i) { return 'days' }
  / ('weeks'i / 'week'i / !'we'i 'w'i) { return 'weeks' }
  / ('isoweeks'i / 'isoweek'i / !'isowe'i 'isow'i) { return 'isoweeks' }
  / ('months'i / 'month'i / !'oc'i 'o'i) { return 'months' }
  / ('quarters'i / 'quarter'i / 'q'i) { return 'quarters' }
  / ('years'i / 'year'i / 'y'i) { return 'years' }

Integer "integer"
  = [0-9]+ { return parseInt(text(), 10); }

_ "whitespace"
  = whitespace:whitespace* { return whitespace.join("") }

whitespace
  = [ \t\n\r]
