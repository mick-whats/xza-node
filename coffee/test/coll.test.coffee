assert = require 'assert'
_ = require('../').lodash
{test} = require 'ava'
moment = require 'moment'
require '../'

generator = ->
  d = moment('2018-01-01')
  [0..20].map (i)->
    {
      date: d.add(1,'day').format('YYYY-MM-DD')
      pl: _.floor _.random(-50000, 100000),-4
    }

items = [{'date': '2018-01-02','pl': -30000},{'date': '2018-01-03','pl': 0},{'date': '2018-01-04','pl': -50000},{'date': '2018-01-05','pl': 30000},{'date': '2018-01-06','pl': 40000},{'date': '2018-01-07','pl': -20000},{'date': '2018-01-08','pl': -30000},{'date': '2018-01-09','pl': 0},{'date': '2018-01-10','pl': 80000},{'date': '2018-01-11','pl': 60000},{'date': '2018-01-12','pl': -30000},{'date': '2018-01-13','pl': 90000},{'date': '2018-01-14','pl': 60000},{'date': '2018-01-15','pl': 40000},{'date': '2018-01-16','pl': -50000},{'date': '2018-01-17','pl': -10000},{'date': '2018-01-18','pl': 40000},{'date': '2018-01-19','pl': 90000},{'date': '2018-01-20','pl': 10000},{'date': '2018-01-21','pl': -40000},{'date': '2018-01-22','pl': -10000}]


test 'addSma(array)',(t)->

  coll = [
    {date: '2017-01-01',value: 10}
    {date: '2017-02-01',value: 20}
    {date: '2017-03-01',value: 30}
    {date: '2017-04-01',value: 50}
    {date: '2017-05-01',value: 80}
    {date: '2017-06-01',value: 60}
    {date: '2017-07-01',value: 40}
    {date: '2017-08-01',value: 70}
    {date: '2017-09-01',value: 90}
  ]
  newColl = _.addSma(coll,3,'value')
  # newColl.forEach (item)->
  #   t.log item
  #   t.is 1,2
  t.pass()

test "addTotal(arr,fromKey='value',newKey='total')",(t)->
  arr = _.addTotal(items,'pl','total')
  t.deepEqual arr[0], {
    date: '2018-01-02',
    pl: -30000,
    total: -30000,
    }
  t.deepEqual arr[5], {
    date: '2018-01-07',
    pl: -20000,
    total: -30000,
    }
  t.deepEqual arr[10], {
    date: '2018-01-12',
    pl: -30000,
    total: 50000,
    }
