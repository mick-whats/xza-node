# xza (lodash mixin)
[![npm version](https://badge.fury.io/js/xza.svg)](https://badge.fury.io/js/xza)
[![Build Status](https://travis-ci.org/mick-whats/xza-node.svg?branch=master)](https://travis-ci.org/mick-whats/xza-node)
[![Maintainability](https://api.codeclimate.com/v1/badges/83cfe5237dbf267cf742/maintainability)](https://codeclimate.com/github/mick-whats/xza-node/maintainability)


これは簡単なコードの寄せ集めです。
読み込むだけでlodashを拡張します。

```
npm install xza --save
```

```
_ = require('xza').lodash
```

## utility

- \_.sizeof( obj )
- \_.strToNumber( str, returnValue = NaN )
- \_.replaceAll( str, obj )
- \_.toHalfString( str )
- \_.whiteSpaceRemover( str )
- \_.toDateString( obj )
- \_.splitUppercase(str,type)
- \_.toText( obj )
- \_.setTimeout( [,delay], fn , [,params...])
- \_.includesString( string, searchString)

[example](coffee/test/util.test.coffee)

## objects

- \_.deepKeys( obj )
- \_.commonPath( paths )
- \_.compactObject( obj )
- \_.flattenObject( obj, separator='\_')
- \_.eachObject( obj, fn )
- \_.mapObject( obj, fn )
- \_.rejectObject( obj, fn )
- \_.filterObject( obj, fn )

[objelity](https://github.com/mick-whats/objelity)

## math

- \_.diffRate(base, target, round)
- \_.progressRate(target, progress, round)
- \_.addChangeInRates(array, name, [..newName])

[example](coffee/test/math.test.coffee)

## bizday(Business Day)

[README.md](https://github.com/mick-whats/bizday-js/blob/master/README.md)
