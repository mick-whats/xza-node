_ = require 'lodash'
sizeof = require('object-sizeof')
prettyBytes = require('pretty-bytes')


module.exports =
  sizeof: (obj)-> prettyBytes(sizeof(obj))
