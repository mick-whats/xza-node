_ = require('lodash')
bizday = require('../').bizday
moment = require 'moment'
{test} = require 'ava'


test 'bizday', (t) ->
  bd = new bizday()
  t.is bd.val(), moment().format('YYYYMMDD')

test 'bizday with format', (t) ->
  # Moment.js | Docs http://momentjs.com/docs/#/displaying/
  bd = new bizday('20180501', {format: 'L'})
  t.is bd.val(), '05/01/2018'

test 'add()', (t) ->
  bd = new bizday('20180501')
  t.is bd.val(), '20180501'
  t.is bd.add(), '20180502'
  t.is bd.add(), '20180503'
  t.is bd.add(), '20180504'
  t.is bd.add(), '20180507'
  t.is bd.val(), '20180507'

test 'add(count)', (t) ->
  bd = new bizday('20180501')
  t.is bd.val(), '20180501'
  t.is bd.add(2), '20180503'
  t.is bd.add(2), '20180507'
  t.is bd.val(), '20180507'

test 'sub()', (t) ->
  bd = new bizday('20180501')
  t.is bd.val(), '20180501'
  t.is bd.sub(), '20180430'
  t.is bd.sub(), '20180427'
  t.is bd.sub(), '20180426'
  t.is bd.val(), '20180426'

test 'sub()', (t) ->
  bd = new bizday('20180501')
  t.is bd.val(), '20180501'
  t.is bd.sub(2), '20180427'
  t.is bd.sub(2), '20180425'
  t.is bd.sub(2), '20180423'
  t.is bd.val(), '20180423'

test 'add() with jp-holiday', (t) ->
  # add option key 'country' value of 'jp','jpn', 'JP', 'JPN'
  bd = new bizday('20180501', {country: 'jp'})
  t.is bd.val(), '20180501'
  t.is bd.add(), '20180502'
  t.is bd.add(), '20180507'
  t.is bd.add(), '20180508'

test 'add(count) with jp-holiday', (t) ->
  bd = new bizday('20180501', {country: 'jp'})
  t.is bd.val(), '20180501'
  t.is bd.add(2), '20180507'
  t.is bd.add(2), '20180509'

test 'sub() with jp-holiday', (t) ->
  bd = new bizday('20180501', {country: 'JPN'})
  t.is bd.val(), '20180501'
  t.is bd.sub(), '20180427'
  t.is bd.sub(), '20180426'
  t.is bd.sub(), '20180425'

test 'sub(count) with jp-holiday', (t) ->
  bd = new bizday('20180501', {country: 'JPN'})
  t.is bd.val(), '20180501'
  t.is bd.sub(2), '20180426'
  t.is bd.sub(2), '20180424'
  t.is bd.sub(2), '20180420'
