<br>

<div align="center">
<img width="456" src="https://raw.githubusercontent.com/wayofdev/ansible-role-homebrew/master/assets/logo.gh-light-mode-only.png#gh-light-mode-only">
<img width="456" src="https://raw.githubusercontent.com/wayofdev/ansible-role-homebrew/master/assets/logo.gh-dark-mode-only.png#gh-dark-mode-only">
</div>



<br>

<br>

<div align="center">
<a href="https://actions-badge.atrox.dev/wayofdev/ansible-role-homebrew/goto"><img alt="Build Status" src="https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fwayofdev%2Fansible-role-homebrew%2Fbadge&style=flat-square"/></a>
<a href="https://galaxy.ansible.com/wayofdev/homebrew"><img alt="Ansible Role" src="https://img.shields.io/ansible/role/59331?style=flat-square"/></a>
<a href="https://github.com/wayofdev/ansible-role-homebrew/tags"><img src="https://img.shields.io/github/v/tag/wayofdev/ansible-role-homebrew?sort=semver&style=flat-square" alt="Latest Version"></a>
<a href="https://galaxy.ansible.com/wayofdev/homebrew"><img alt="Ansible Quality Score" src="https://img.shields.io/ansible/quality/59331?style=flat-square"/></a>
<a href="https://galaxy.ansible.com/wayofdev/homebrew"><img alt="Ansible Role" src="https://img.shields.io/ansible/role/d/59331?style=flat-square"/></a>
<a href="LICENSE"><img src="https://img.shields.io/github/license/wayofdev/ansible-role-homebrew.svg?style=flat-square&color=blue" alt="Software License"/></a>
<a href="#"><img alt="Commits since latest release" src="https://img.shields.io/github/commits-since/wayofdev/ansible-role-homebrew/latest?style=flat-square"></a>
</div>

<br>

# Ansible Role: Homebrew

Installs [Homebrew](https://brew.sh/) on macOS or Linux, and configures taps, packages and casks. Package uses retry loops to deal with connectivity issues.

If you **like/use** this role, please consider **starring** it. Thanks!

<br>

## 🗂 Table of contents

* [Requirements](#-requirements)
* [Role Variables](#-role-variables)
   * [Structure](#-structure)
   * [Tapping repositories](#-tapping-repositories)
   * [Packages: Installing, updating and removing](#-packages-installing-updating-and-removing)
   * [Casks: installing, updating and removing](#-casks-installing-updating-and-removing)
* [Example Playbook](#-example-playbook)
   * [for macOS machines](#-for-macos-machines)
   * [for Linux machines](#-for-linux-machines)
* [Development](#-development)
* [Testing](#-testing)
* [Dependencies](#-dependencies)
   * [for all](#-for-all)
   * [only macOS](#-only-macos)
   * [only Linux](#-only-linux)
* [Compatibility](#-compatibility)
* [License](#-license)
* [Author Information](#-author-information)
* [Credits and Resources](#-credits-and-resources)

<br>

## 📑 Requirements

* Up-to-date version of ansible. During maintenance/development, we stick to ansible versions and will use new features if they are available (and update `meta/main.yml` for the minimum version).
* Compatible OS. See [compatibility](#-compatibility) table.
* `jmespath` library needs to be installed on the host running the playbook (needed for the `json_query` filter).
* Role has dependencies on third-party roles on different operating systems. See `requirements.yml` and [dependencies](#-dependencies) section.

<br>

## 🔧 Role Variables

Available variables are listed below, along with example values (see `defaults/main.yml`). Additional variables are stored in `vars/main.yml`.

<br>

### → Structure

Github repository variable for Homebrew core. By default, role checks for latest release from official Homebrew repository, if you are changing `homebrew_repository` to your  fork and want to use `master` branch and turn off latest release autodetect, then set `homebrew_repository_use_master` variable to `true`

```yaml
# From which repository should we install homebrew?
homebrew_repository: https://github.com/Homebrew/brew

# Set to true if you want to use master branch instead of release auto-detect,
# or you use custom fork specified in homebrew_repository
homebrew_repository_use_master: false
```

When set to true, will update Homebrew itself and upgrade all homebrew packages:

```yaml
# Run task to upgrade all packages
homebrew_upgrade_all: false
```

Variable controls retry times and delay to wait between retries, if `homebrew install` task failed:

```yaml
# How much times to retry, if installation of package / tap / cask fails ?
# This can happen during network problems.
homebrew_retries: 32

# Delay between each retry attempt.
homebrew_delay: 3
```

Set to `true` to remove the Hombrew cache after any new software is installed or updated.

```yaml
homebrew_clear_cache: false
```

Directory where applications installed via `cask` should be installed.

```yaml
homebrew_cask_appdir: /Applications
```

If set to `true`, passes `--greedy` to brew cask outdated when checking if an installed cask has a newer version available.

```yaml
homebrew_cask_greedy_mode: false
```

Turn off homebrew analytics, which are collected by default.

```yaml
homebrew_collect_analytics: false
```

<br>

### → Tapping repositories

**Adding** (tapping) repositories

```yaml
homebrew_taps:
  - homebrew/core
  - homebrew/cask-versions
  - homebrew/cask-fonts
```

**Adding** (tapping) repositories, in more verbose way, defining urls and states:

```yaml
homebrew_taps:
  # just tap
  - name: homebrew/core

  # tap from custom repository
  - name: denji/nginx
    url: https://github.com/denji/homebrew-nginx

  # tap with defined custom state
  - name: homebrew/cask-fonts
    state: present
```

**Removing** taps:

```yaml
homebrew_taps:
  # define state: absent to delete taps
  - name: homebrew/cask-fonts
    state: absent

  - name: denji/nginx
    state: absent
```

<br>

### → Packages: Installing, updating and removing

**Adding** packages in simple way:

```yaml
homebrew_packages:
  - wget
  - curl
  - nano
```

**Adding** packages in advanced way, defining state, path, and other options:

```yaml
homebrew_packages:
  # install to custom path
  - name: wget
    state: present
    path: /opt/custom/path/bin
```

**Updating** packages:

```yaml
homebrew_packages:
  # update homebrew first and install formula wget with 'brew' in default path
  - name: wget
    state: present
    update_homebrew: true

  # update homebrew first and upgrade formula curl to latest available with 'brew' in default path
  - name: curl
    state: latest
    update_homebrew: true
```

**Removing** packages:

```yaml
homebrew_packages:
  - name: wget
    state: absent
  - name: curl
    state: absent
```

<br>

### → Casks: installing, updating and removing

> :warning: **Notice**: Casks are supported only on macOS. See [this post](https://github.com/Linuxbrew/brew/issues/742).

**Adding** casks in simple way:

```yaml
homebrew_casks:
  # Installing list of casks
  - firefox
  - google-chrome
  - alfred
  - 1password
```

**Adding** casks with advanced options:

```yaml
homebrew_casks:
  # Installing firefox cask
  - name: firefox
    state: present
```

**Removing** casks:

```yaml
homebrew_casks:
  # define state: absent to delete
  - name: firefox
    state: absent
  - name: google-chrome
    state: absent
```

<br>

## 📗 Example Playbook

### → for macOS machines

```yaml
---
- hosts: localhost
  connection: local

  vars:
    homebrew_taps:
      - homebrew/core
      - hombrew/cask
      - homebrew/cask-fonts
      - yt-dlp/taps
    homebrew_packages:
      - ssh-copy-id  # from homebrew/core
      - yt-dlp  # from yt-dlp/taps
    homebrew_casks:
      - firefox
      - google-chrome
      - font-fira-code-nerd-font  # from homebrew/cask-fonts
    homebrew_retries: 12
    homebrew_delay: 3
    homebrew_clear_cache: false
    homebrew_collect_analytics: false

  roles:
    - elliotweiser.osx-command-line-tools  # needed only on macOS machines
    - wayofdev.homebrew
```

### → for Linux machines

```yaml
---
- hosts: localhost
  connection: local

  vars:
 	  homebrew_user: linuxbrew  # FYI: can be skipped, as automatically detected, but linuxbrew user is recommended way for installing Homebrew with Linux
 	  homebrew_group: linuxbrew  # same as homebrew_user

    homebrew_taps:
      - homebrew/core
      - yt-dlp/taps
    homebrew_packages:
      - ssh-copy-id  # from homebrew/core
      - yt-dlp  # from yt-dlp/taps
    homebrew_retries: 12
    homebrew_delay: 3
    homebrew_clear_cache: false
    homebrew_collect_analytics: false

  roles:
    - geerlingguy.git  # required only on linux machines, and can be skipped if machine has git
    - wayofdev.homebrew
```

<br>

## ⚙️ Development

To install dependencies and start development you can check contents of our `Makefile`

**Install** [poetry](https://github.com/python-poetry/poetry) using [poetry-bin](https://github.com/gi0baro/poetry-bin) and all dev python dependencies:

```bash
$ make install
```

**Install** only python dependencies, assuming that you already have poetry:

```bash
$ make install-deps
```

**Install** all git hooks:

```bash
$ make hooks
```

**Lint** all role files:

```bash
$ make lint
```

<br>

## 🧪 Testing

For local testing you can use these comands to test whole role or separate tasks:

> :warning: **Notice**: By defaut all tests are ran against your local machine!

```bash
# run all tasks in role
$ make test

# run idempotency check
$ make test-idempotent

# or test-tag without any parameters
$ make test-tag

# run tasks that ensures brew installation on macos
$ export TASK_TAGS="brew-install"; make test-tag

# run tasks that tries to update brew
$ export TASK_TAGS="brew-update"; make test-tag

# run tasks that tries to update brew and then run taps and casks
$ export TASK_TAGS="brew-update brew-taps brew-casks"; make test-tag

# run by tag
$ make test-install
$ make test-analytics
$ make test-update
$ make test-taps
$ make test-packages
$ make test-casks

# run molecule tests
$ make m-test
```

Full list of commands can be seen in `Makefile`.

<br>

## 📦 Dependencies

Installation handled by `Makefile` and requirments are defined in `requirements.yml`

### → for all

  - [ansible.community.general](https://docs.ansible.com/ansible/latest/collections/community/general/index.html)

### → only macOS

  - [elliotweiser.osx-command-line-tools](https://galaxy.ansible.com/elliotweiser/osx-command-line-tools/)

### → only Linux

  - [geerlingguy.git](https://galaxy.ansible.com/geerlingguy/git)

<br>

## 🧩 Compatibility

This role has been tested on these systems:

| system / container | tag      |
| :----------------- | -------- |
| macos              | monterey |
| macos              | big-sur  |
| ubuntu             | jammy    |
| ubuntu             | focal    |
| ubuntu             | bionic   |
| debian             | bullseye |
| debian             | buster   |
| fedora             | 36       |
| fedora             | 35       |
| centos             | 8        |
| centos             | 7        |

<br>

## 🤝 License

[![Licence](https://img.shields.io/github/license/wayofdev/ansible-role-homebrew?style=for-the-badge&color=blue)](./LICENSE)

<br>

## 🙆🏼‍♂️ Author Information

This role was created in **2022** by [lotyp / wayofdev](https://github.com/wayofdev).

<br>

## 🤫 Credits and Resources

**Inspired by:**

* [role-homebrew-retry](https://github.com/osx-provisioner/role-homebrew-retry) by [@niall-byrne](https://github.com/niall-byrne)
* homebrew role created by [@geerlingguy](https://github.com/geerlingguy) as a part of [ansible-collection-mac](https://github.com/geerlingguy/ansible-collection-mac)
* official Homebrew [installer script](https://github.com/Homebrew/install/blob/master/install.sh)
