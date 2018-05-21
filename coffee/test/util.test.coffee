assert = require 'assert'
_ = require('../').lodash
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
  t.true _.strToNumber('18円32銭') is 18.32
  t.true _.strToNumber('18円00銭') is 18
  t.true _.strToNumber('18%') is 18
  t.true _.strToNumber('18％') is 18
  t.true _.strToNumber('１２３、４５６、７８９') is 123456789

test 'replaceAll(str, obj)',(t)->
  str = '3円00銭'
  t.is _.replaceAll(str,{'円': '.','銭': ''}), '3.00'
  str = 'abcabcabc'
  t.is _.replaceAll(str,{a: '!',b: '',c: '?'}), '!?!?!?'
  str = 'abcabcabc'
  t.is _.replaceAll(str,{'[a-b]': ''}), 'ccc'

test 'toHalfString(str)',(t)->
  str = 'ａｂｃ５００'
  t.is _.toHalfString(str),'abc500'
  str = 'ａｂｃ！？￥'
  t.is _.toHalfString(str),'abc！？￥'
