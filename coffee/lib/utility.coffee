_ = require 'lodash'
sizeof = require('object-sizeof')
prettyBytes = require('pretty-bytes')
moment = require 'moment'

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
    str.replace(/[０-９ａ-ｚＡ-Ｚ]/g,(s)->
      String.fromCharCode(s.charCodeAt(0) - 0xFEE0 ))
  whiteSpaceRemover: (str)->
    str.replace(/[\s　]/g,'')
  toDateString: (obj,format)->
    _obj = obj
    _format = format or 'YYYY-MM-DD'
    if _.isString(obj)
      _obj = utility.whiteSpaceRemover(obj)
      _obj = utility.toHalfString(obj)
      if _match = _obj.match(/(.*)[年-](\d*)[月-](\d*)日?/)
        [_raw,_year,_month,_day] = _match
        if _month.length is 1
          _month = "0#{_month}"
        if _day.length is 1
          _day = "0#{_day}"
        if _eras = _year.match(/([^\x01-\x7E\uFF61-\uFF9F]{2})(\d*)/)
          [_raw,_era,_year] = _eras
          switch _era
            when '平成'
              _year = Number(_year) + 1988
            when '昭和'
              _year = Number(_year) + 1925
            when '大正'
              _year = Number(_year) + 1911
            else
        _obj = "#{_year}-#{_month}-#{_day}"
    moment(_obj).format(_format)
  splitUppercase: (str,type=0)->
    str = utility.whiteSpaceRemover(str)
    if type
      str = str.replace(/([A-Z])/g,'___$1')
      str = str.replace(/^___/g,'')
      return str.split('___')
    else
      str = str.replace(/([a-z])([A-Z])/g,'$1___$2')
      return str.split('___')

module.exports = utility
