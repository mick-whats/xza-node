# xza (lodash mixin)
[![npm version](https://badge.fury.io/js/xza.svg)](https://badge.fury.io/js/xza)
[![Build Status](https://travis-ci.org/mick-whats/xza-node.svg?branch=master)](https://travis-ci.org/mick-whats/xza-node)
[![Maintainability](https://api.codeclimate.com/v1/badges/83cfe5237dbf267cf742/maintainability)](https://codeclimate.com/github/mick-whats/xza-node/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/83cfe5237dbf267cf742/test_coverage)](https://codeclimate.com/github/mick-whats/xza-node/test_coverage)


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
- \_.deepKeys( obj )
- \_.commonPath( paths )
- \_.compactObject( obj )

[example](coffee/test/util.test.coffee)
