/* eslint-disable node/no-unsupported-features */

const _ = require('../').lodash
// eslint-disable-next-line node/no-unpublished-require
const { test } = require('ava')

require('../')

test('util.sizeof', function (t) {
  var obj
  t.is(_.sizeof(1999), '8 B')
  obj = (function () {
    var results = []
    for (var j = 0; j <= 10000; j++) {
      results.push(j)
    }
    return results
  }
    .apply(this))
    .map(function (i) {
      return {
        name: `testName${i}`,
        value: i
      }
    })
  return t.is(_.sizeof(obj), '498 kB')
})

test('util.strToNumber', function (t) {
  t.true(_.strToNumber('123,456') === 123456)
  t.true(_.strToNumber('-123,456,789') === -123456789)
  t.true(_.strToNumber('△123,456,789') === -123456789)
  t.true(_.strToNumber('▲123,456,789') === -123456789)
  t.true(_.strToNumber('Δ123,456,789') === -123456789)
  t.true(Number.isNaN(_.strToNumber('▼123,456,789')))
  t.true(Number.isNaN(_.strToNumber('abc')))
  t.false(_.strToNumber('abc', false) === 0 / 0)
  t.true(_.strToNumber('abc', false) === false)
  t.false(_.strToNumber('abc', true) === 0 / 0)
  t.true(_.strToNumber('abc', true) === true)
  t.false(_.strToNumber('abc', null) === 0 / 0)
  t.true(_.strToNumber('abc', null) === null)
  t.true(_.strToNumber('18円32銭') === 18.32)
  t.true(_.strToNumber('18円00銭') === 18)
  t.true(_.strToNumber('18%') === 18)
  t.true(_.strToNumber('18％') === 18)
  return t.true(_.strToNumber('１２３、４５６、７８９') === 123456789)
})

test('replaceAll(str, obj)', function (t) {
  var str
  str = '3円00銭'
  t.is(
    _.replaceAll(str, {
      円: '.',
      銭: ''
    }),
    '3.00'
  )
  str = 'abcabcabc'
  t.is(
    _.replaceAll(str, {
      a: '!',
      b: '',
      c: '?'
    }),
    '!?!?!?'
  )
  str = 'abcabcabc'
  return t.is(
    _.replaceAll(str, {
      '[a-b]': ''
    }),
    'ccc'
  )
})

test('toHalfString(str)', function (t) {
  var str
  str = 'ａｂｃ５００'
  t.is(_.toHalfString(str), 'abc500')
  str = 'ａｂｃ！？￥'
  return t.is(_.toHalfString(str), 'abc！？￥')
})

test('whiteSpaceRemover(str)', function (t) {
  t.is(_.whiteSpaceRemover(' a bc a　b　c　'), 'abcabc')
  return t.is(_.whiteSpaceRemover('平成30年 5月11日'), '平成30年5月11日')
})

test('toDateString(obj,format)', function (t) {
  var td
  td = _.toDateString
  // t.is td(new Date()),'2018-05-27'
  t.is(td(1527379925302), '2018-05-27') // milliseconds
  t.is(td([2018, 4, 27]), '2018-05-27')
  t.is(td('２０１８年５月２７日'), '2018-05-27')
  t.is(td('2018年1月1日'), '2018-01-01')
  t.is(td('平成30年 5月11日'), '2018-05-11')
  t.is(td('令和元年 5月11日'), '2019-05-11')
  t.is(td('令和 元年 5月12日'), '2019-05-12')
  t.is(td('令和2年 5月11日'), '2020-05-11')
  t.is(td('平成３０年５月２７日'), '2018-05-27')
  t.is(td('昭和３０年５月２７日'), '1955-05-27')
  t.is(td('大正３年５月２７日'), '1914-05-27')
  t.is(td('2018-5-27'), '2018-05-27')
  t.is(td('20180527'), '2018-05-27')
  // t.is td('成３０年５月２７日'),'Invalid date'
  return t.is(td('2018-5-27', 'YYYYMMDD'), '20180527')
})

test('splitUppercase(str,type)', function (t) {
  var sp
  sp = _.splitUppercase
  // 小文字と大文字の間で分割
  t.deepEqual(sp('isJSON'), ['is', 'JSON'])
  t.deepEqual(sp('ILoveYou'), ['ILove', 'You'])
  t.deepEqual(sp('NHK News'), ['NHKNews'])
  t.deepEqual(sp('NextAccumulatedQ2Duration'), [
    'Next',
    'Accumulated',
    'Q2',
    'Duration'
  ])
  // 大文字の前で分割
  t.deepEqual(sp('isJSON', true), ['is', 'J', 'S', 'O', 'N'])
  t.deepEqual(sp('ILoveYou', true), ['I', 'Love', 'You'])
  t.deepEqual(sp('NHK News', true), ['N', 'H', 'K', 'News'])
  return t.deepEqual(sp('NextAccumulatedQ2Duration', true), [
    'Next',
    'Accumulated',
    'Q2',
    'Duration'
  ])
})

test('setTimeout(fn)', async function (t) {
  var testFn
  testFn = function () {
    return new Promise(function (resolve, reject) {
      return _.setTimeout(function () {
        return resolve('ok')
      })
    })
  }
  return t.is(await testFn(), 'ok')
})

test('setTimeout(delay,fn)', async function (t) {
  var testFn
  testFn = function () {
    return new Promise(function (resolve, reject) {
      return _.setTimeout(
        200,
        function () {
          return resolve('ok')
        },
        'text1',
        'bool1'
      )
    })
  }
  return t.is(await testFn(), 'ok')
})

test('setTimeout(delay,fn,param1,param2)', async function (t) {
  const testFn = function () {
    return new Promise(function (resolve, reject) {
      const fn = function (param1, param2) {
        return resolve(param2)
      }
      return _.setTimeout(fn, 200, 'text1', 'text2')
    })
  }
  return t.is(await testFn(), 'text2')
})

test('includesString', function (t) {
  t.true(_.includesString('TEST', 'Test'))
  return t.false(_.includesString('TEST', 'Tests'))
})
test('sma', t => {
  const values = [1, 2, 4, 8, 16]
  const range = 3
  t.deepEqual(_.sma(values, range), [null, null, 2.33, 4.67, 9.33])
  t.deepEqual(_.sma(values, range, 3), [null, null, 2.333, 4.667, 9.333])
})
