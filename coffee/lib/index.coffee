_ = require 'lodash'
utility = require './utility'
_.mixin(sizeof: utility.sizeof)
_.mixin(strToNumber: utility.strToNumber)
_.mixin(replaceAll: utility.replaceAll)
_.mixin(toHalfString: utility.toHalfString)
_.mixin(whiteSpaceRemover: utility.whiteSpaceRemover)
_.mixin(toDateString: utility.toDateString)
_.mixin(splitUppercase: utility.splitUppercase)
_.mixin(deepKeys: utility.deepKeys)
_.mixin(commonPath: utility.commonPath)
_.mixin(compactObject: utility.compactObject)

module.exports =
  utility: utility
  lodash: _
