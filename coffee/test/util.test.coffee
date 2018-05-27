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

test 'whiteSpaceRemover(str)', (t)->
  t.is _.whiteSpaceRemover(' a bc a　b　c　'),'abcabc'

test 'toDateString(obj,format)', (t)->
  td = _.toDateString
  t.is td(new Date()),'2018-05-27'
  t.is td(1527379925302),'2018-05-27' # milliseconds
  t.is td([2018, 4, 27]),'2018-05-27'
  t.is td('２０１８年５月２７日'),'2018-05-27'
  t.is td('平成３０年５月２７日'),'2018-05-27'
  t.is td('昭和３０年５月２７日'),'1955-05-27'
  t.is td('大正３年５月２７日'),'1914-05-27'
  t.is td('2018-5-27'),'2018-05-27'
  t.is td('20180527'),'2018-05-27'
  t.is td('成３０年５月２７日'),'Invalid date'
  t.is td('2018-5-27','YYYYMMDD'),'20180527'
