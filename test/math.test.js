const _ = require('../').lodash
const Big = require('big.js')
const { test } = require('ava')

test('diffRate(base, target, round)', function (t) {
  t.is(_.diffRate(100, 99), -1)
  t.is(_.diffRate(203, 7), -96.55)
  t.is(_.diffRate(203, 7, 3), -96.552)
  t.is(_.diffRate(0.25, 0.51), 104)
  t.is(_.diffRate(100, 25), -75)
  t.is(_.diffRate(0, 25), 0 / 0)
  t.is(_.diffRate(10, 0), -100)
  t.is(_.diffRate(1, 9), 800)
  return t.is(_.diffRate(null, 0), 0 / 0)
})

test('progressRate(target, progress, round)', function (t) {
  // 参考: [マイナス予算の達成率の計算方法 \| freeSIM\.tokyo]
  // (https://freesim.tokyo/etc/minus-achivement/)
  t.is(_.progressRate(-50, -50), 100)
  t.is(_.progressRate(-50, -45), 110)
  t.is(_.progressRate(-50, -70), 60)
  t.is(_.progressRate(-50, 0), 200)
  t.is(_.progressRate(-50, 50), 300)
  t.is(_.progressRate(50, -50), -100)
  t.is(_.progressRate(50, -45), -90)
  t.is(_.progressRate(50, -70), -140)
  t.is(_.progressRate(50, 0), 0)
  t.is(_.progressRate(50, 50), 100)
  t.is(_.progressRate(50, 12.031454), 24.06)
  t.is(_.progressRate(50, 12.031454, 5), 24.06291)
  t.is(_.progressRate(0, -50), 0 / 0)
  return t.is(_.progressRate(null, -50), 0 / 0)
})

test('addChangeInRates(array)', function (t) {
  var arr
  arr = function () {
    return [
      {
        val: 100
      },
      {
        val: 110
      },
      {
        val: 90
      }
    ]
  }
  t.deepEqual(_.addChangeInRates(arr(), 'val'), [
    {
      val: 100
    },
    {
      changeIn_val: 10,
      val: 110
    },
    {
      changeIn_val: -18.18,
      val: 90
    }
  ])
  t.deepEqual(_.addChangeInRates(arr(), 'val', 'newVal'), [
    {
      val: 100
    },
    {
      newVal: 10,
      val: 110
    },
    {
      newVal: -18.18,
      val: 90
    }
  ])
})
test('js', t => {
  const a = 17.85
  const b = 2.55
  t.is(a + b, 20.400000000000002)
  t.is(parseFloat(Big(a).plus(b)), 20.4)
})
test('sum', t => {
  t.is(_.sum([1, 2, 3, 4, 5]), 15)
})
test('sumBy', t => {
  const arr = [
    { a: 1, b: 2 },
    { a: 2, b: 4 },
    { a: 3, b: 6 },
    { a: 4, b: 8 },
    { a: 5, b: 10 }
  ]
  t.is(_.sumBy(arr, 'a'), 15)
  t.is(_.sumBy(arr, 'b'), 30)
  t.is(_.sumBy(arr, o => o.b), 30)
})
