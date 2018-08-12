_ = require 'lodash'
Big = require('big.js')
args2 = require 'args2'

getDiffRate = (base, target, round)->
  # (target - base) / abs(base)
  res = new Big(target).minus(base)
  _base = new Big(base).abs()
  return res.div(_base)
  
math =
  diffRate: (base, target, round) ->
    try
      round =  if round? then round else 2
      return Number(getDiffRate(base, target).times(100).round(round))
    catch e
      return NaN
  progressRate: (target, progress, round) ->
    # 1 + ((target - base) / abs(base))
    try
      return NaN if target is 0
      round =  if round? then round else 2
      _diffRate = getDiffRate(target, progress)
      return Number(new Big(1).plus(_diffRate).times(100).round(round))
    catch e
      return NaN
  addChangeInRates: (array, name, newName) ->
    unless _.isArray(array)
      return []
    unless name
      return array
    newName = if newName then newName else "changeIn_#{name}"
    ref = null
    array.map (item, index)->
      val = _.get(item, name)
      if index is 0
        ref = val
        return item
      if val?
        item[newName] = math.diffRate(ref, val)
        ref = val
        return item
      else
        item[newName] = null

module.exports = math
