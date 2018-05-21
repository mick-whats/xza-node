_ = require 'lodash'
sizeof = require('object-sizeof')
prettyBytes = require('pretty-bytes')


utility =
  sizeof: (obj)-> prettyBytes(sizeof(obj))
  strToNumber: (str,returnValue = NaN)->
    str = utility.toHalfString(str)
    repObj =
      '^[△▲Δ]': '-'
      '[,、銭%％]': ''
      '[円]': '.'
    str = utility.replaceAll(str,repObj)
    num = Number(str.split(',').join('').trim())
    if _.isNaN(num)
      return returnValue
    else
      return num
  replaceAll: (str,obj)->
    ret = str
    for key, val of obj
      ret = ret.replace(new RegExp(key,'g'), val)
    return ret
  toHalfString: (str)->
    ret = str.replace(/[０-９ａ-ｚＡ-Ｚ]/g,(s)->
      String.fromCharCode(s.charCodeAt(0) - 0xFEE0 ))
    ret
module.exports = utility
