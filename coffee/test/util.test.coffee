assert = require 'assert'
_ = require 'lodash'
{test} = require 'ava'

require '../'

test 'util.sizeof',(t)->
  t.is _.sizeof(1999), '8 B'
  obj = [0..10000].map (i)-> {name: "testName#{i}",value: i}
  t.is _.sizeof(obj), '576 kB'

test 'util.strToNumber', (t)->
  t.true _.strToNumber('123,456') is 123456
  t.true _.strToNumber('-123,456,789') is -123456789
  t.true _.strToNumber('△123,456,789') is -123456789
  t.true _.strToNumber('▲123,456,789') is -123456789
  t.true _.strToNumber('Δ123,456,789') is -123456789
  t.true Number.isNaN _.strToNumber('▼123,456,789')
  t.true Number.isNaN _.strToNumber('abc')
  t.false _.strToNumber('abc',false) is NaN
  t.true _.strToNumber('abc',false) is false
  t.false _.strToNumber('abc',true) is NaN
  t.true _.strToNumber('abc',true) is true
  t.false _.strToNumber('abc',null) is NaN
  t.true _.strToNumber('abc',null) is null
