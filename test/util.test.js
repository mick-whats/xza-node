// Generated by CoffeeScript 2.2.4
(function() {
  var _, assert, test;

  assert = require('assert');

  _ = require('../').lodash;

  ({test} = require('ava'));

  require('../');

  test('util.sizeof', function(t) {
    var obj;
    t.is(_.sizeof(1999), '8 B');
    obj = (function() {
      var results = [];
      for (var j = 0; j <= 10000; j++){ results.push(j); }
      return results;
    }).apply(this).map(function(i) {
      return {
        name: `testName${i}`,
        value: i
      };
    });
    return t.is(_.sizeof(obj), '576 kB');
  });

  test('util.strToNumber', function(t) {
    t.true(_.strToNumber('123,456') === 123456);
    t.true(_.strToNumber('-123,456,789') === -123456789);
    t.true(_.strToNumber('△123,456,789') === -123456789);
    t.true(_.strToNumber('▲123,456,789') === -123456789);
    t.true(_.strToNumber('Δ123,456,789') === -123456789);
    t.true(Number.isNaN(_.strToNumber('▼123,456,789')));
    t.true(Number.isNaN(_.strToNumber('abc')));
    t.false(_.strToNumber('abc', false) === (0/0));
    t.true(_.strToNumber('abc', false) === false);
    t.false(_.strToNumber('abc', true) === (0/0));
    t.true(_.strToNumber('abc', true) === true);
    t.false(_.strToNumber('abc', null) === (0/0));
    t.true(_.strToNumber('abc', null) === null);
    t.true(_.strToNumber('18円32銭') === 18.32);
    t.true(_.strToNumber('18円00銭') === 18);
    t.true(_.strToNumber('18%') === 18);
    t.true(_.strToNumber('18％') === 18);
    return t.true(_.strToNumber('１２３、４５６、７８９') === 123456789);
  });

  test('replaceAll(str, obj)', function(t) {
    var str;
    str = '3円00銭';
    t.is(_.replaceAll(str, {
      '円': '.',
      '銭': ''
    }), '3.00');
    str = 'abcabcabc';
    t.is(_.replaceAll(str, {
      a: '!',
      b: '',
      c: '?'
    }), '!?!?!?');
    str = 'abcabcabc';
    return t.is(_.replaceAll(str, {
      '[a-b]': ''
    }), 'ccc');
  });

  test('toHalfString(str)', function(t) {
    var str;
    str = 'ａｂｃ５００';
    t.is(_.toHalfString(str), 'abc500');
    str = 'ａｂｃ！？￥';
    return t.is(_.toHalfString(str), 'abc！？￥');
  });

  test('whiteSpaceRemover(str)', function(t) {
    return t.is(_.whiteSpaceRemover(' a bc a　b　c　'), 'abcabc');
  });

  test('toDateString(obj,format)', function(t) {
    var td;
    td = _.toDateString;
    t.is(td(new Date()), '2018-05-27');
    t.is(td(1527379925302), '2018-05-27'); // milliseconds
    t.is(td([2018, 4, 27]), '2018-05-27');
    t.is(td('２０１８年５月２７日'), '2018-05-27');
    t.is(td('平成３０年５月２７日'), '2018-05-27');
    t.is(td('昭和３０年５月２７日'), '1955-05-27');
    t.is(td('大正３年５月２７日'), '1914-05-27');
    t.is(td('2018-5-27'), '2018-05-27');
    t.is(td('20180527'), '2018-05-27');
    t.is(td('成３０年５月２７日'), 'Invalid date');
    return t.is(td('2018-5-27', 'YYYYMMDD'), '20180527');
  });

}).call(this);
