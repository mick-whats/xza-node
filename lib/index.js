var _, math, objelity, utility

_ = require('lodash-core')

objelity = require('objelity')

utility = require('./utility')

_.mixin({
  sizeof: utility.sizeof
})

_.mixin({
  strToNumber: utility.strToNumber
})

_.mixin({
  replaceAll: utility.replaceAll
})

_.mixin({
  toHalfString: utility.toHalfString
})

_.mixin({
  whiteSpaceRemover: utility.whiteSpaceRemover
})

_.mixin({
  toDateString: utility.toDateString
})

_.mixin({
  splitUppercase: utility.splitUppercase
})

_.mixin({
  setTimeout: utility.setTimeout
})

_.mixin({
  includesString: utility.includesString
})

// objelity
_.mixin({
  deepKeys: objelity.deepKeys
})

_.mixin({
  commonPath: objelity.commonPath
})

_.mixin({
  compactObject: objelity.compactObject
})

_.mixin({
  flattenObject: objelity.flattenObject
})

_.mixin({
  eachObject: objelity.eachObject
})

_.mixin({
  mapObject: objelity.mapObject
})

_.mixin({
  toText: objelity.toText
})

_.mixin({
  rejectObject: objelity.rejectObject
})

_.mixin({
  filterObject: objelity.filterObject
})

// math
math = require('./math')

_.mixin({
  diffRate: math.diffRate
})

_.mixin({
  progressRate: math.progressRate
})

_.mixin({
  addChangeInRates: math.addChangeInRates
})
// _.mixin({
//   sum: math.sum
// })
// _.mixin({
//   sumBy: math.sumBy
// })

module.exports = {
  lodash: _,
  utility: utility,
  objelity: objelity,
  math: math,
  bizday: require('bizday')
}
