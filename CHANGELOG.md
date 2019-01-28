# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).



## [2.17.1] - 2019-01-28

### Added

- 以下を追加。lodashに同名の関数があるがIEEE754の誤差に対応の為Bigjsで計算
- _.sum
- _.sumBy

## [2.16.4] - 2019-01-18

### Changed

- momentを`moment-mini`に変更
- install sizeが1.08MB -> 931KBに縮小

## [2.16.3] - 2019-01-04

### Changed

- `.npmignore`を修正、余計なfileを読み込まないようにしてfilesizeを縮小

## [2.16.2] - 2019-01-04

### Changed

- lodashを`lodash-core`からimportする方式に変更
- install sizeが1.15MB -> 1.08MBに縮小

## [2.16.1] - 2018-12-21

内部変更のみで機能的変更は無し

### Changed
- coffeescriptを廃止、jsでの開発に移行
- lodashをnpm経由から変更してlibディレクトリにmin.jsファイルを置く形式に変更
- momentをnpm経由から変更して`moment-with-locales.min.js`を設置
- install sizeが4.87MB -> 1.15MBに縮小

### Deprecated
- coffee - lib/directoryを将来的に削除予定
