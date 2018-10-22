assert = require 'assert'
_ = require('../').lodash
{test} = require 'ava'

test 'objelity require', (t) ->
  t.is _.deepKeys.name,'deepKeys'
  t.is _.commonPath.name, 'commonPath'
  t.is _.compactObject.name, 'compactObject'
  t.is _.flattenObject.name, 'flattenObject'
  t.is _.eachObject.name, 'eachObject'
  t.is _.mapObject.name, 'mapObject'
  t.is _.rejectObject.name, 'rejectObject'
  t.is _.filterObject.name, 'filterObject'
  t.pass()