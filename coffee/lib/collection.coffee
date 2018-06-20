_ = require 'lodash'
sizeof = require('object-sizeof')
prettyBytes = require('pretty-bytes')
moment = require 'moment'
sma = require 'sma'

collection =
  addSma: (arr,range=3,key=0,newkey='sma')->
    vals = arr.map (item)->
      return item[key]
    sma = sma(vals,range)
    arr.forEach (item,i)->
      if range - 1  <= i
        item[newkey] = Number sma[i-range+1]
    return arr

  addTotal: (arr,fromKey='value',newKey='total')->
    total = 0
    arr.forEach (item)->
      total += item[fromKey]
      item[newKey] = total
    arr

  keys: [
    'totalPL'
    'totalProfit'
    'totalloss'
    'tradeLength'
    'winningPercentage'
    'winningCount'
    'losingCount'
    'maxWinningValue'
    'maxLosingValue'
    'avarageProfit'
    'avarageLoss'
  ]
module.exports = collection
