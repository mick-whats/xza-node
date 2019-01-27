const _ = require('lodash-core')
const Big = require('big.js')
const getDiffRate = function (base, target, round) {
  var _base, res
  // (target - base) / abs(base)
  res = new Big(target).minus(base)
  _base = new Big(base).abs()
  return res.div(_base)
}
const math = {
  diffRate: function (base, target, round) {
    try {
      round = round != null ? round : 2
      return Number(
        getDiffRate(base, target)
          .times(100)
          .round(round)
      )
    } catch (error) {
      return 0 / 0
    }
  },
  progressRate: function (target, progress, round) {
    try {
      if (target === 0) {
        // 1 + ((target - base) / abs(base))
        return 0 / 0
      }
      round = round != null ? round : 2
      const _diffRate = getDiffRate(target, progress)
      return Number(
        new Big(1)
          .plus(_diffRate)
          .times(100)
          .round(round)
      )
    } catch (error) {
      return 0 / 0
    }
  },
  addChangeInRates: function (array, name, newName) {
    var ref
    if (!_.isArray(array)) {
      return []
    }
    if (!name) {
      return array
    }
    newName = newName || `changeIn_${name}`
    ref = null
    return array.map(function (item, index) {
      var val
      val = _.get(item, name)
      if (index === 0) {
        ref = val
        return item
      }
      if (val != null) {
        item[newName] = math.diffRate(ref, val)
        ref = val
        return item
      } else {
        return (item[newName] = null)
      }
    })
  },
  sum: arr => {
    const initialValue = Big(0)
    const reducer = (result, current, i, arr) => result.plus(current)
    const res = arr.reduce(reducer, initialValue)
    return parseFloat(res)
  },
  sumBy: (arr, key) => {
    const newArr = _.map(arr, key)
    return math.sum(newArr)
  }
}

module.exports = math
