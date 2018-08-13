_ = require 'lodash'
moment = require 'moment'
holidays_jp = require '../holidays-jp.json'

class BusinessDay
  @isHoliday: (date, holidaysList)->
    flag = switch moment(date).format('E')
      when '6', '7'
        true
      else
        false
    if holidaysList
      if  _.includes(holidaysList, moment(date).format('YYYY-MM-DD'))
        flag = true
    return flag
  constructor: (day, @opts={}) ->
    if @opts.country?
      @holidays = switch @opts.country
        when 'jp','jpn', 'JP', 'JPN', 392
          holidays_jp
        else
          null
    else
      @holidays = null
    @format = if @opts.format? then @opts.format else 'YYYYMMDD'
    @m = if day then moment(day) else moment()
  val: ->
    @m.format(@format)
  add: (count=1) ->
    _add = ->
      loop
        @m.add(1, 'day')
        unless BusinessDay.isHoliday(@m.format('YYYYMMDD'),@holidays)
          break
      return @m.format(@format)
    res = null
    for i in [0...count]
      res = _add.call(@)
    return res
  sub: (count=1) ->
    _sub = ->
      loop
        @m.subtract(1, 'day')
        unless BusinessDay.isHoliday(@m.format('YYYYMMDD'),@holidays)
          break
      return @m.format(@format)
    res = null
    for i in [0...count]
      res = _sub.call(@)
    return res
module.exports = BusinessDay
