_ = require 'lodash'
utility = require './utility'
_.mixin(sizeof: utility.sizeof)
_.mixin(strToNumber: utility.strToNumber)
_.mixin(replaceAll: utility.replaceAll)
_.mixin(toHalfString: utility.toHalfString)
_.mixin(whiteSpaceRemover: utility.whiteSpaceRemover)
_.mixin(toDateString: utility.toDateString)

module.exports =
  utility: utility
  lodash: _
