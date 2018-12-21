# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).



## [2.16.1] - 2018-12-21

内部変更のみで機能的変更は無し

### Changed
- coffeescriptを廃止、jsでの開発に移行
- lodashをnpm経由から変更してlibディレクトリにmin.jsファイルを置く形式に変更
- momentをnpm経由から変更して`moment-with-locales.min.js`を設置


### Deprecated
- coffee - lib/directoryを将来的に削除予定
