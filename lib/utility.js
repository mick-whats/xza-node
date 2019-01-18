const _ = require('lodash-core')
const sizeof = require('object-sizeof')
const prettyBytes = require('pretty-bytes')
const moment = require('moment-mini')

const utility = {
  sizeof: function (obj) {
    return prettyBytes(sizeof(obj))
  },
  strToNumber: function (str, returnValue = 0 / 0) {
    var num, repObj
    str = utility.toHalfString(str)
    repObj = {
      '^[△▲Δ]': '-',
      '[,、銭%％]': '',
      '[円]': '.'
    }
    str = utility.replaceAll(str, repObj)
    num = Number(
      str
        .split(',')
        .join('')
        .trim()
    )
    if (_.isNaN(num)) {
      return returnValue
    } else {
      return num
    }
  },

  replaceAll: function (str, obj) {
    var key, ret, val
    ret = str
    for (key in obj) {
      val = obj[key]
      ret = ret.replace(new RegExp(key, 'g'), val)
    }
    return ret
  },
  toHalfString: function (str) {
    return str.replace(/[０-９ａ-ｚＡ-Ｚ]/g, function (s) {
      return String.fromCharCode(s.charCodeAt(0) - 0xfee0)
    })
  },
  whiteSpaceRemover: function (str) {
    return str.replace(/[\s]/g, '')
  },
  toDateString: function (obj, format) {
    let _era
    let _eras
    let _match
    let _obj = obj
    const _format = format || 'YYYY-MM-DD'
    if (_.isString(obj)) {
      _obj = utility.whiteSpaceRemover(obj)
      _obj = utility.toHalfString(_obj)
      if ((_match = _obj.match(/(.*)[年-](\d*)[月-](\d*)日?/))) {
        let [, _year, _month, _day] = _match
        if (_month.length === 1) {
          _month = `0${_month}`
        }
        if (_day.length === 1) {
          _day = `0${_day}`
        }
        // eslint-disable-next-line no-control-regex
        if ((_eras = _year.match(/([^\x01-\x7E\uFF61-\uFF9F]{2})(\d*)/))) {
          ;[, _era, _year] = _eras
          switch (_era) {
            case '平成':
              _year = Number(_year) + 1988
              break
            case '昭和':
              _year = Number(_year) + 1925
              break
            case '大正':
              _year = Number(_year) + 1911
              break
          }
        }
        _obj = `${_year}-${_month}-${_day}`
      }
    }
    return moment(_obj).format(_format)
  },
  splitUppercase: function (str, type = 0) {
    str = utility.whiteSpaceRemover(str)
    if (type) {
      str = str.replace(/([A-Z])/g, '___$1')
      str = str.replace(/^___/g, '')
      return str.split('___')
    } else {
      str = str.replace(/([a-z0-9])([A-Z])/g, '$1___$2')
      return str.split('___')
    }
  },
  setTimeout: function (delay, fn, ...params) {
    if (typeof delay === 'function') {
      params.unshift(0)
      params.unshift(delay)
    } else {
      params.unshift(delay)
      params.unshift(fn)
    }
    return setTimeout.apply(null, params)
  },
  includesString: function (str, searchString) {
    return new RegExp(searchString, 'i').test(str)
  }
}

module.exports = utility
