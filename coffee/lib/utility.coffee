_ = require 'lodash'
sizeof = require('object-sizeof')
prettyBytes = require('pretty-bytes')
moment = require 'moment'
args2 = require 'args2'

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
      str = str.replace(/([a-z0-9])([A-Z])/g,'$1___$2')
      return str.split('___')

  deepKeys: (obj)->
    # result = []
    first = true
    _depth = []
    next = true
    while next
      if first
        _depth.push(Object.keys(obj))
        first = false
      _keys = _.last(_depth)
      _halfway = []
      next = false
      _keys.forEach (key)->
        _halfObj = _.get(obj,key)
        if _.isPlainObject(_halfObj) or _.isArray(_halfObj)
          next = true
          _arr = Object.keys(_halfObj).map (childKey)->
            return "#{key}.#{childKey}"
          _halfway.push(_arr)
        else
          _halfway.push(key)
      _depth.push(_.flatten _halfway)
    return _.last(_depth)

  commonPath: (paths)->
    pathArray = paths.map (path)->
      if _.isString(path)
        return _.toPath(path)
      return path
    result = []
    pathArray[0].some (s,columnIndex)->
      rows = pathArray.map (row)-> row[columnIndex]
      if rows.every (row)-> row is s
        result.push(s)
        return false
      else
        return true
    return result

  compactObject: (obj)->
    _paths = utility.deepKeys(obj)
    newObj = {}
    _paths.forEach (p)->
      val = _.get(obj,p)
      if _.isNil(val)
        return
      else
        _.set(newObj,p,val)
        return
    return newObj

  flattenObject: (obj, separator='_')->
    _paths = utility.deepKeys(obj)
    newObj = {}
    _paths.forEach (p)->
      val = _.get(obj,p)
      _newPath = p.replace(/\./g,separator)
      _.set(newObj,_newPath,val)
    return newObj

  mapObject: (obj, fn)->
    _paths = utility.deepKeys(obj)
    newObj = {}
    _paths.forEach (p,i)->
      val = _.get(obj,p)
      resArr = fn(val, p, i, obj)
      if _.isArray(resArr)
        if resArr.length > 1
          _.set(newObj,resArr[0],resArr[1])
        else
          _.set(newObj,p,resArr)
      else if _.isPlainObject(resArr)
        key = Object.keys(resArr)[0]
        val = resArr[key]
        _.set(newObj, key, val)
      else
        _.set(newObj,p,resArr)
    return newObj

  toText: (obj)->
    switch typeof obj
      when 'object'
        JSON.stringify(obj,null,2)
      when 'undefined'
        'undefined'
      when 'function'
        "(#{obj.toString()})()"
      else
        obj.toString()

  rejectObject: (obj, fn)->
    newObj = utility.mapObject obj, (val, p, i, obj)->
      if fn(val, p, i, obj) then null else val
    utility.compactObject(newObj)

  filterObject: (obj, fn)->
    newObj = utility.mapObject obj, (val, p, i, obj)->
      if fn(val, p, i, obj) then val else null
    utility.compactObject(newObj)

  setTimeout: ->
    [delay, fn, params] = args2.assign(arguments, ['num', 'fn'])
    params = if params? then params else []
    params.unshift delay if delay?
    params.unshift fn
    setTimeout.apply(null,params)

module.exports = utility
