_ = require 'lodash'
utility = require './utility'
_.mixin(sizeof: utility.sizeof)
_.mixin(strToNumber: utility.strToNumber)
_.mixin(replaceAll: utility.replaceAll)
_.mixin(toHalfString: utility.toHalfString)

module.exports =
  utility: utility
  lodash: _
