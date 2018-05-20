_ = require 'lodash'
sizeof = require('object-sizeof')
prettyBytes = require('pretty-bytes')


module.exports =
  sizeof: (obj)-> prettyBytes(sizeof(obj))
  strToNumber: (str,returnValue = NaN)->
    str = str.replace(/^[△▲Δ](.*)/,'-$1')
    num = Number(str.split(',').join('').trim())
    if _.isNaN(num)
      return returnValue
    else
      return num
