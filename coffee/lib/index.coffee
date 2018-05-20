_ = require 'lodash'
utility = require './utility'
_.mixin(sizeof: utility.sizeof)
_.mixin(strToNumber: utility.strToNumber)

module.exports =
  utility: utility
  lodash: _
