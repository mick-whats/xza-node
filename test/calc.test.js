// eslint-disable-next-line node/no-unpublished-require
const { test } = require('ava')
const calc = require('../lib/calc')
const Big = require('big.js')

test('js', function (t) {
  var a, b
  a = 17.85
  b = 2.55
  t.is(a + b, 20.400000000000002)
  t.is(parseFloat(Big(a).plus(b)), 20.4)
})
test('Big', function (t) {
  var a, b
  a = new Big(0).plus(3)
  b = Big(0).plus(3)
  t.is(parseFloat(a), parseFloat(b))
})

test('sum', function (t) {
  t.is(calc.sum([1, 2, 3, 4, 5]), 15)
})

test('sumBy', function (t) {
  var arr
  arr = [
    {
      a: 1,
      b: 2
    },
    {
      a: 2,
      b: 4
    },
    {
      a: 3,
      b: 6
    },
    {
      a: 4,
      b: 8
    },
    {
      a: 5,
      b: 10
    }
  ]
  t.is(calc.sumBy(arr, 'a'), 15)
  t.is(calc.sumBy(arr, 'b'), 30)
  t.is(
    calc.sumBy(arr, function (o) {
      return o.b
    }),
    30
  )
})

test('mean', function (t) {
  t.is(calc.mean([1, 2, 3, 4, 5]), 3)
})

test('meanBy', function (t) {
  var arr
  arr = [
    {
      a: 1,
      b: 2
    },
    {
      a: 2,
      b: 4
    },
    {
      a: 3,
      b: 6
    },
    {
      a: 4,
      b: 8
    },
    {
      a: 5,
      b: 10
    }
  ]
  t.is(calc.meanBy(arr, 'a'), 3)
  t.is(calc.meanBy(arr, 'b'), 6)
  t.is(
    calc.meanBy(arr, function (o) {
      return o.b
    }),
    6
  )
})

test('changeIn', function (t) {
  t.is(calc.changeIn(100, 90), -10)
  return t.is(calc.changeIn(200, 190), -5)
})

test('addSma', function (t) {
  var data, res
  data = [
    {
      Close: 0.1
    },
    {
      Close: 0.2
    },
    {
      Close: 0.3
    },
    {
      Close: 0.4
    },
    {
      Close: 0.5
    },
    {
      Close: 0.6
    },
    {
      Close: 0.7
    }
  ]
  res = calc.addSma(3, data)
  // 引数roundNumberを与えない場合は0になる
  t.deepEqual(res, [
    {
      Close: 0.1,
      sma3: null,
      smad3: null
    },
    {
      Close: 0.2,
      sma3: null,
      smad3: null
    },
    {
      Close: 0.3,
      sma3: 0, // 1の位でroundされて0になる
      smad3: 50 // 剥離率の計算はroundされる前に行われるので正当な値になる
    },
    {
      Close: 0.4,
      sma3: 0,
      smad3: 33.33
    },
    {
      Close: 0.5,
      sma3: 0,
      smad3: 25
    },
    {
      Close: 0.6,
      sma3: 1,
      smad3: 20
    },
    {
      Close: 0.7,
      sma3: 1,
      smad3: 16.67
    }
  ])
  res = calc.addSma(3, data, 1)
  return t.deepEqual(res, [
    {
      Close: 0.1,
      sma3: null,
      smad3: null
    },
    {
      Close: 0.2,
      sma3: null,
      smad3: null
    },
    {
      Close: 0.3,
      sma3: 0.2,
      smad3: 50
    },
    {
      Close: 0.4,
      sma3: 0.3,
      smad3: 33.33
    },
    {
      Close: 0.5,
      sma3: 0.4,
      smad3: 25
    },
    {
      Close: 0.6,
      sma3: 0.5,
      smad3: 20
    },
    {
      Close: 0.7,
      sma3: 0.6,
      smad3: 16.67
    }
  ])
})

test('addVwma', function (t) {
  var data, res
  data = [
    {
      Close: 0.1,
      Volume: 100
    },
    {
      Close: 0.2,
      Volume: 200
    },
    {
      Close: 0.3,
      Volume: 300
    },
    {
      Close: 0.4,
      Volume: 400
    },
    {
      Close: 0.5,
      Volume: 500
    },
    {
      Close: 0.6,
      Volume: 600
    },
    {
      Close: 0.7,
      Volume: 700
    }
  ]
  res = calc.addVwma(3, data)
  t.deepEqual(res, [
    {
      Close: 0.1,
      Volume: 100,
      vwma3: null,
      vwmad3: null
    },
    {
      Close: 0.2,
      Volume: 200,
      vwma3: null,
      vwmad3: null
    },
    {
      Close: 0.3,
      Volume: 300,
      vwma3: 0,
      vwmad3: 28.57
    },
    {
      Close: 0.4,
      Volume: 400,
      vwma3: 0,
      vwmad3: 24.14
    },
    {
      Close: 0.5,
      Volume: 500,
      vwma3: 0,
      vwmad3: 20
    },
    {
      Close: 0.6,
      Volume: 600,
      vwma3: 1,
      vwmad3: 16.88
    },
    {
      Close: 0.7,
      Volume: 700,
      vwma3: 1,
      vwmad3: 14.55
    }
  ])
  res = calc.addVwma(3, data, 2)
  return t.deepEqual(res, [
    {
      Close: 0.1,
      Volume: 100,
      vwma3: null,
      vwmad3: null
    },
    {
      Close: 0.2,
      Volume: 200,
      vwma3: null,
      vwmad3: null
    },
    {
      Close: 0.3,
      Volume: 300,
      vwma3: 0.23,
      vwmad3: 28.57
    },
    {
      Close: 0.4,
      Volume: 400,
      vwma3: 0.32,
      vwmad3: 24.14
    },
    {
      Close: 0.5,
      Volume: 500,
      vwma3: 0.42,
      vwmad3: 20
    },
    {
      Close: 0.6,
      Volume: 600,
      vwma3: 0.51,
      vwmad3: 16.88
    },
    {
      Close: 0.7,
      Volume: 700,
      vwma3: 0.61,
      vwmad3: 14.55
    }
  ])
})
