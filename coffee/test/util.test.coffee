assert = require 'assert'
_ = require 'lodash'
{test} = require 'ava'

xza = require '../'
util = xza.utility

test 'util.sizeof',(t)->
  t.is util.sizeof(1999), '8 B'
  obj = [0..10000].map (i)-> {name: "testName#{i}",value: i}
  t.is util.sizeof(obj), '576 kB'

test 'util.strToNumber', (t)->
  {strToNumber} = xza.utility
  t.true strToNumber('123,456') is 123456
  t.true strToNumber('-123,456,789') is -123456789
  t.true strToNumber('△123,456,789') is -123456789
  t.true strToNumber('▲123,456,789') is -123456789
  t.true strToNumber('Δ123,456,789') is -123456789
  t.true Number.isNaN strToNumber('▼123,456,789')
  t.true Number.isNaN strToNumber('abc')
  t.false strToNumber('abc',false) is NaN
  t.true strToNumber('abc',false) is false
  t.false strToNumber('abc',true) is NaN
  t.true strToNumber('abc',true) is true
  t.false strToNumber('abc',null) is NaN
  t.true strToNumber('abc',null) is null
