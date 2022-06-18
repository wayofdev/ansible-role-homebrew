# Changelog

## [1.7.1](https://github.com/wayofdev/ansible-role-homebrew/compare/v1.7.0...v1.7.1) (2022-06-18)


### Bug Fixes

* ansible idempotence failed because of analytics task ([910dfea](https://github.com/wayofdev/ansible-role-homebrew/commit/910dfea40e6065c248705ea16b0454e84eb1ea92))

## [1.7.0](https://github.com/wayofdev/ansible-role-homebrew/compare/v1.6.0...v1.7.0) (2022-06-16)


### Features

* enabling workaround for macos. see: https://github.com/ansible-collections/community.general/issues/4708 ([d87d863](https://github.com/wayofdev/ansible-role-homebrew/commit/d87d863fdb6b72867e58b98dcabfcecb51e52abe))
* removing github3.py dependency, adding github token ([#15](https://github.com/wayofdev/ansible-role-homebrew/issues/15)) ([069c08d](https://github.com/wayofdev/ansible-role-homebrew/commit/069c08d3a0a0ee235c4b28eb9998610b6baa2aeb))


### Bug Fixes

* macos still has issue with homebrew ([#13](https://github.com/wayofdev/ansible-role-homebrew/issues/13)) ([7c45c92](https://github.com/wayofdev/ansible-role-homebrew/commit/7c45c922d571a5973f46f3419dfda51dd0e5f6d0))

## [1.6.0](https://github.com/wayofdev/ansible-role-homebrew/compare/v1.5.0...v1.6.0) (2022-06-14)


### Features

* homebrew user autodetection, readme changes ([#11](https://github.com/wayofdev/ansible-role-homebrew/issues/11)) ([2e2df96](https://github.com/wayofdev/ansible-role-homebrew/commit/2e2df9645621424d120294f4da9220ec10e1b369))

## [1.5.0](https://github.com/wayofdev/ansible-role-homebrew/compare/v1.4.0...v1.5.0) (2022-06-14)


### Features

* add ubuntu support ([#8](https://github.com/wayofdev/ansible-role-homebrew/issues/8)) ([f8857bc](https://github.com/wayofdev/ansible-role-homebrew/commit/f8857bcb8781b662f2dfa90e0ebb13d0199770bf))

## [1.4.0](https://github.com/wayofdev/ansible-role-homebrew/compare/v1.3.0...v1.4.0) (2022-06-03)


### Features

* Makefile test by tag, retries for github3.py ([054288a](https://github.com/wayofdev/ansible-role-homebrew/commit/054288aaecb7a047a4f186c50bc5989404dd22c7))
* Makefile test by tag, retries for github3.py ([8a54a40](https://github.com/wayofdev/ansible-role-homebrew/commit/8a54a40f0e053ead7c4b40fb8c2957e5b613f923))
* Makefile test by tag, retries for github3.py ([9f887d6](https://github.com/wayofdev/ansible-role-homebrew/commit/9f887d64bba668b5f2c61b79cd142ed6ba3672ff))


### Bug Fixes

* fixes in meta platforms, updating deps ([f13cc57](https://github.com/wayofdev/ansible-role-homebrew/commit/f13cc57b78c8dce97b03385ac1e033752dcc6a40))
* Makefile problems in github actions ([e237c59](https://github.com/wayofdev/ansible-role-homebrew/commit/e237c596968de704bf39dcf0a7b767f92629c574))
* Makefile problems in github actions ([90dbbd0](https://github.com/wayofdev/ansible-role-homebrew/commit/90dbbd0c6e1c47ac96f04186d18b39e1c3cc21fe))
* Makefile problems in github actions ([d92aa5f](https://github.com/wayofdev/ansible-role-homebrew/commit/d92aa5f5b0a25a2d2a0102d6609b835a35f089a9))
* Makefile problems in github actions ([ec8af0f](https://github.com/wayofdev/ansible-role-homebrew/commit/ec8af0fda011672858fd55151bdde8b59fac0ec7))

## [1.3.0](https://github.com/wayofdev/ansible-role-homebrew/compare/v1.2.0...v1.3.0) (2022-06-01)


### Features

* ability to turn off analytics, code cleanup ([c296112](https://github.com/wayofdev/ansible-role-homebrew/commit/c296112461c028274f4bc8bbe96235ab03756d59))

## [1.2.0](https://github.com/wayofdev/ansible-role-homebrew/compare/v1.1.0...v1.2.0) (2022-06-01)


### Features

* new, improved Makefile ([#4](https://github.com/wayofdev/ansible-role-homebrew/issues/4)) ([a603d1b](https://github.com/wayofdev/ansible-role-homebrew/commit/a603d1baafb659faf81f6f674349f6e1aba3e5f9))


### Bug Fixes

* add retry for poetry install script ([c5f0249](https://github.com/wayofdev/ansible-role-homebrew/commit/c5f0249646b14cc1d4fe33ded4213c8babf0b8af))
* add retry for poetry install script ([bebbbd6](https://github.com/wayofdev/ansible-role-homebrew/commit/bebbbd6aa19ddf42570e4accea2941956f77a314))
* add retry for poetry install script ([e1461dd](https://github.com/wayofdev/ansible-role-homebrew/commit/e1461dd49d91f86f87992911b2f99e0fa22d472c))

## [1.1.0](https://github.com/wayofdev/ansible-role-homebrew/compare/v1.0.0...v1.1.0) (2022-05-30)


### Features

* get latest release instead of master branch ([ad9beba](https://github.com/wayofdev/ansible-role-homebrew/commit/ad9bebad1f5c497642dab8efa138769a3b03001e))
* get latest release of homebrew ([46c09ab](https://github.com/wayofdev/ansible-role-homebrew/commit/46c09abf3e6ff71512ade14972e3770ba05e067d))
* path variable in packages, readme file, makefile now correctly installs deps ([d1e4566](https://github.com/wayofdev/ansible-role-homebrew/commit/d1e45660a4d2493730829efa725fc9343456e858))
* refactoring to flat structure; uninstall does not need retries ([a837eb1](https://github.com/wayofdev/ansible-role-homebrew/commit/a837eb1969f53273c5b31833733175f011cccee4))


### Bug Fixes

* fixes in namespace ([8d70ef8](https://github.com/wayofdev/ansible-role-homebrew/commit/8d70ef848c67af0f8e75064e20a015ab240eb9ac))
* should be present instead of latest for casks, readme changes ([bc7326d](https://github.com/wayofdev/ansible-role-homebrew/commit/bc7326dc0418e7b2928220de7336b2925e545ef5))

## 1.0.0 (2022-05-22)


### Features

* adding changes ([4948e92](https://github.com/wayofdev/ansible-role-homebrew/commit/4948e921f0ba2bac64e10b400764f7fd7dc9c548))
* adding changes ([895f0fa](https://github.com/wayofdev/ansible-role-homebrew/commit/895f0fa00ba863da2e3b227536144d4e49e71a6b))
* adding changes ([6e6f20c](https://github.com/wayofdev/ansible-role-homebrew/commit/6e6f20cb4a4af1af99c88af4507fd4bbdfdb5672))
* adding role files ([2cf7a24](https://github.com/wayofdev/ansible-role-homebrew/commit/2cf7a247e93bafc49d91a03a8cd609d9c0a70194))
* changes in makefile, can now delete taps, casks, packages ([19a6214](https://github.com/wayofdev/ansible-role-homebrew/commit/19a6214f21ce0e2777ac36b74e509d9c44be08d0))
* changes in role ([7a77d27](https://github.com/wayofdev/ansible-role-homebrew/commit/7a77d2706a3a4da150ccf2dadc44a605891afd5e))
* more flexible config for apps. deeper loops ([785eab9](https://github.com/wayofdev/ansible-role-homebrew/commit/785eab91e43530c6d135b2d56289425af9ad28dd))
* working poc ([b7f52d2](https://github.com/wayofdev/ansible-role-homebrew/commit/b7f52d2820118884cb38467f9a399aee80b73dbd))


### Bug Fixes

* add global variables ([935d274](https://github.com/wayofdev/ansible-role-homebrew/commit/935d274c289eff5734d16bcc79807d9b54a5cddf))
* linting fixes ([c864653](https://github.com/wayofdev/ansible-role-homebrew/commit/c8646538a51dde2bed708f2b35aef6c6d8e15be7))
