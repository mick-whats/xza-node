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
  # t.is td(new Date()),'2018-05-27'
  t.is td(1527379925302),'2018-05-27' # milliseconds
  t.is td([2018, 4, 27]),'2018-05-27'
  t.is td('２０１８年５月２７日'),'2018-05-27'
  t.is td('2018年1月1日'),'2018-01-01'
  t.is td('平成３０年５月２７日'),'2018-05-27'
  t.is td('昭和３０年５月２７日'),'1955-05-27'
  t.is td('大正３年５月２７日'),'1914-05-27'
  t.is td('2018-5-27'),'2018-05-27'
  t.is td('20180527'),'2018-05-27'
  # t.is td('成３０年５月２７日'),'Invalid date'
  t.is td('2018-5-27','YYYYMMDD'),'20180527'

test 'splitUppercase(str,type)', (t)->
  sp = _.splitUppercase
  # 小文字と大文字の間で分割
  t.deepEqual sp('isJSON'), ['is','JSON']
  t.deepEqual sp('ILoveYou'), ['ILove','You']
  t.deepEqual sp('NHK News'), ['NHKNews']
  t.deepEqual sp('NextAccumulatedQ2Duration'), ['Next','Accumulated','Q2','Duration']
  # 大文字の前で分割
  t.deepEqual sp('isJSON',true), ['is','J','S','O','N']
  t.deepEqual sp('ILoveYou',true), ['I','Love','You']
  t.deepEqual sp('NHK News',true), ['N','H','K','News']
  t.deepEqual sp('NextAccumulatedQ2Duration',true), ['Next','Accumulated','Q2','Duration']

test 'deepKeys',(t)->
  obj =
    a:
      b:
        c: [1,2,3]
      d: new Date()
    e:
      f:
        g: 'h'
  _keys = _.deepKeys(obj)
  t.deepEqual _keys, [
    'a.b.c.0',
    'a.b.c.1',
    'a.b.c.2',
    'a.d',
    'e.f.g',
  ]
  obj = [
    {name: 'alice', age: 17}
    {name: 'bob', age: 32}
    {name: 'charlie', age: 25}
  ]
  _keys = _.deepKeys(obj)
  t.deepEqual _keys, [
    '0.name',
    '0.age',
    '1.name',
    '1.age',
    '2.name',
    '2.age',
  ]
test 'commonPath(pathStrings)',(t)->
  paths = [
    'a.b.c.d.e.f',
    'a.b.c.x.z',
    'a.b.c',
    'a.b.c.d.s',
  ]
  t.deepEqual _.commonPath(paths),['a','b','c']
test 'commonPath(pathArray)',(t)->
  paths = [
    ['a','b','c','d','e']
    ['a','b','c','x','z','q']
    ['a','b','c','g','r']
    ['a','b','c','s']
    ['a','b','c']
  ]
  t.deepEqual _.commonPath(paths),['a','b','c']

test 'compactObject(obj)',(t)->
  obj =
    aaa:
      bbb:
        ccc: 1
        ddd: 0
      eee:
        fff: undefined
        ggg: null
      hhh:
        iii:
          jjj: true
  t.deepEqual _.compactObject(obj), {
    aaa:
      bbb:
        ccc: 1
        ddd: 0
      hhh:
        iii:
          jjj: true
  }

test 'flattenObject(obj)',(t)->
  obj =
    aaa:
      bbb:
        ccc: 1
        ddd: 0
      eee:
        fff: undefined
        ggg: null
      hhh:
        iii:
          jjj: true
  t.deepEqual _.flattenObject(obj), {
    aaa_bbb_ccc: 1,
    aaa_bbb_ddd: 0,
    aaa_eee_fff: undefined,
    aaa_eee_ggg: null,
    aaa_hhh_iii_jjj: true,
  }
test 'flattenObject(obj, separator)',(t)->
  obj =
    aaa:
      bbb:
        ccc: 1
        ddd: 0
      eee:
        fff: undefined
        ggg: null
      hhh:
        iii:
          jjj: true
  t.deepEqual _.flattenObject(obj, '-'), {
    'aaa-bbb-ccc': 1,
    'aaa-bbb-ddd': 0,
    'aaa-eee-fff': undefined,
    'aaa-eee-ggg': null,
    'aaa-hhh-iii-jjj': true,
  }
test 'mapObject(obj, fn) with sum',(t)->
  obj =
    aaa:
      bbb:
        ccc: 1
        ddd: 2
      eee:
        fff: 3
        ggg: 4
  newObj = _.mapObject obj, (val,path,index,object)->
    return val * 2
  t.deepEqual newObj, {
    aaa:
      bbb:
        ccc: 2
        ddd: 4
      eee:
        fff: 6
        ggg: 8
  }

test 'mapObject(obj, fn) with returned array',(t)->
  obj =
    aaa:
      bbb:
        ccc: 1
        ddd: 0
      eee:
        fff: undefined
        ggg: null
  newObj = _.mapObject obj, (val,path,index,object)->
    if path.match(/aaa\.bbb/)
      newPath = path.replace('aaa.bbb','xxx')
      return [newPath, val]
    else
      return [path, val]
  t.deepEqual newObj, {
    xxx:
      ccc: 1
      ddd: 0
    aaa:
      eee:
        fff: undefined
        ggg: null
  }

test 'mapObject(obj, fn) with returned object',(t)->
  obj =
    aaa:
      bbb:
        ccc: 1
        ddd: 0
      eee:
        fff: undefined
        ggg: null
  newObj = _.mapObject obj, (val,path,index,object)->
    if path.match(/aaa\.bbb/)
      newPath = path.replace('aaa.bbb','xxx')
      return {[newPath]: val}
    else
      return {[path]: val}
  t.deepEqual newObj, {
    xxx:
      ccc: 1
      ddd: 0
    aaa:
      eee:
        fff: undefined
        ggg: null
  }

test 'toText(obj)',(t)->
  obj = {a: 1}
  _t = _.toText(obj)
  t.not _t, '{"a": 1}'
  t.regex _t, /{\s{2,}"a": 1\n}/

test 'toText(arr)',(t)->
  obj = [1,2,3]
  _t = _.toText(obj)
  t.not _t, '[1,2,3]'
  t.regex _t, /\[\n\s{2}1,\n\s{2}2,\n\s{2}3\s{1}\]/

test 'toText(fn)',(t)->
  obj = => return true
  _t = _.toText(obj)
  t.regex _t, /\(\(\)\s=>\s{\n\s{6}return true;\n\s{4}}\)\(\)/

test 'toText(str)',(t)->
  obj = 'str'
  _t = _.toText(obj)
  t.is _t, 'str'

test 'toText(num)',(t)->
  obj = 123
  _t = _.toText(obj)
  t.is _t, '123'

test 'toText(undefined)',(t)->
  obj = undefined
  _t = _.toText(obj)
  t.is _t, 'undefined'

test 'toText(null)',(t)->
  obj = null
  _t = _.toText(obj)
  t.is _t, 'null'

test 'toText(true)',(t)->
  obj = true
  _t = _.toText(obj)
  t.is _t, 'true'

test 'toText(NaN)',(t)->
  obj = NaN
  _t = _.toText(obj)
  t.is _t, 'NaN'

test 'rejectObject(obj, fn)',(t)->
  obj =
    aaa:
      bbb:
        ccc: 1
        ddd: 2
      eee:
        fff: 3
        ggg: 4
  newObj = _.rejectObject obj, (val,path,index,object)->
    return val % 2 is 0
  t.deepEqual newObj, {
    aaa:
      bbb:
        ccc: 1
      eee:
        fff: 3
  }
test 'filterObject(obj, fn)',(t)->
  obj =
    aaa:
      bbb:
        ccc: 1
        ddd: 2
      eee:
        fff: 3
        ggg: 4
  newObj = _.filterObject obj, (val,path,index,object)->
    return val % 2 is 0
  t.deepEqual newObj, {
    aaa:
      bbb:
        ddd: 2
      eee:
        ggg: 4
  }
