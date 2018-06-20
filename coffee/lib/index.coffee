_ = require 'lodash'
utility = require './utility'
collection = require './collection'

_.mixin(sizeof: utility.sizeof)
_.mixin(strToNumber: utility.strToNumber)
_.mixin(replaceAll: utility.replaceAll)
_.mixin(toHalfString: utility.toHalfString)
_.mixin(whiteSpaceRemover: utility.whiteSpaceRemover)
_.mixin(toDateString: utility.toDateString)
_.mixin(splitUppercase: utility.splitUppercase)
_.mixin(deepKeys: utility.deepKeys)


_.mixin(addSma: collection.addSma)
_.mixin(addTotal: collection.addTotal)

module.exports =
  utility: utility
  collection: collection
  lodash: _
