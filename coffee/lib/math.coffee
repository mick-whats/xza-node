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
module.exports = math