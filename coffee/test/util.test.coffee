assert = require 'assert'
_ = require 'lodash'
{test} = require 'ava'

xza = require '../'
util = xza.utility

test 'util.sizeof',(t)->
  t.is util.sizeof(1999), '8 B'
  obj = [0..10000].map (i)-> {name: "testName#{i}",value: i}
  t.is util.sizeof(obj), '576 kB'
