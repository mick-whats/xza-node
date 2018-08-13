// Generated by CoffeeScript 2.3.1
(function() {
  var _, bizday, moment, test;

  _ = require('lodash');

  bizday = require('../').bizday;

  moment = require('moment');

  ({test} = require('ava'));

  test('bizday', function(t) {
    var bd;
    bd = new bizday();
    return t.is(bd.val(), moment().format('YYYYMMDD'));
  });

  test('bizday with format', function(t) {
    var bd;
    // Moment.js | Docs http://momentjs.com/docs/#/displaying/
    bd = new bizday('20180501', {
      format: 'L'
    });
    return t.is(bd.val(), '05/01/2018');
  });

  test('add()', function(t) {
    var bd;
    bd = new bizday('20180501');
    t.is(bd.val(), '20180501');
    t.is(bd.add(), '20180502');
    t.is(bd.add(), '20180503');
    t.is(bd.add(), '20180504');
    t.is(bd.add(), '20180507');
    return t.is(bd.val(), '20180507');
  });

  test('add(count)', function(t) {
    var bd;
    bd = new bizday('20180501');
    t.is(bd.val(), '20180501');
    t.is(bd.add(2), '20180503');
    t.is(bd.add(2), '20180507');
    return t.is(bd.val(), '20180507');
  });

  test('sub()', function(t) {
    var bd;
    bd = new bizday('20180501');
    t.is(bd.val(), '20180501');
    t.is(bd.sub(), '20180430');
    t.is(bd.sub(), '20180427');
    t.is(bd.sub(), '20180426');
    return t.is(bd.val(), '20180426');
  });

  test('sub()', function(t) {
    var bd;
    bd = new bizday('20180501');
    t.is(bd.val(), '20180501');
    t.is(bd.sub(2), '20180427');
    t.is(bd.sub(2), '20180425');
    t.is(bd.sub(2), '20180423');
    return t.is(bd.val(), '20180423');
  });

  test('add() with jp-holiday', function(t) {
    var bd;
    // add option key 'country' value of 'jp','jpn', 'JP', 'JPN'
    bd = new bizday('20180501', {
      country: 'jp'
    });
    t.is(bd.val(), '20180501');
    t.is(bd.add(), '20180502');
    t.is(bd.add(), '20180507');
    return t.is(bd.add(), '20180508');
  });

  test('add(count) with jp-holiday', function(t) {
    var bd;
    bd = new bizday('20180501', {
      country: 'jp'
    });
    t.is(bd.val(), '20180501');
    t.is(bd.add(2), '20180507');
    return t.is(bd.add(2), '20180509');
  });

  test('sub() with jp-holiday', function(t) {
    var bd;
    bd = new bizday('20180501', {
      country: 'JPN'
    });
    t.is(bd.val(), '20180501');
    t.is(bd.sub(), '20180427');
    t.is(bd.sub(), '20180426');
    return t.is(bd.sub(), '20180425');
  });

  test('sub(count) with jp-holiday', function(t) {
    var bd;
    bd = new bizday('20180501', {
      country: 'JPN'
    });
    t.is(bd.val(), '20180501');
    t.is(bd.sub(2), '20180426');
    t.is(bd.sub(2), '20180424');
    return t.is(bd.sub(2), '20180420');
  });

}).call(this);
