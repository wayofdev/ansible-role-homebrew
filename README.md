<br>

<div align="center">
<img width="456" src="./assets/logo.gh-light-mode-only.png#gh-light-mode-only">
<img width="456" src="./assets/logo.gh-dark-mode-only.png#gh-dark-mode-only">
</div>



<br>

<br>

<div align="center">
<a href="https://actions-badge.atrox.dev/wayofdev/ansible-role-homebrew/goto"><img alt="Build Status" src="https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fwayofdev%2Fansible-role-homebrew%2Fbadge&style=flat-square"/></a>
<a href="https://galaxy.ansible.com/lotyp/homebrew"><img alt="Ansible Role" src="https://img.shields.io/ansible/role/59250?style=flat-square"/></a>
<a href="https://github.com/wayofdev/ansible-role-homebrew/tags"><img src="https://img.shields.io/github/v/tag/wayofdev/ansible-role-homebrew?sort=semver&style=flat-square" alt="Latest Version"></a>
<a href="https://galaxy.ansible.com/lotyp/homebrew">
<img alt="Ansible Quality Score" src="https://img.shields.io/ansible/quality/59250?style=flat-square"/></a>
<a href="https://galaxy.ansible.com/lotyp/homebrew">
<img alt="Ansible Role" src="https://img.shields.io/ansible/role/d/59250?style=flat-square"/></a>
<a href="LICENSE"><img src="https://img.shields.io/github/license/wayofdev/ansible-role-homebrew.svg?style=flat-square&color=blue" alt="Software License"/></a>
</div>






<br>

# Ansible Role: Homebrew

Installs [Homebrew](https://brew.sh/) on macOS or Linux, and configures taps, packages and casks. Package uses retry loops to deal with connectivity issues.

If you **like/use** this role, please consider **starring** it. Thanks!

<br>

## 📑 Requirements

None.

<br>

## 🔧 Role Variables

Available variables are listed below, along with example values (see `defaults/main.yml`). Section shows all possible variants of installing, updating and removing applications / casks and taps.

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

### → Casks: installing, updating and removing

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

## 📦 Dependencies

Installation handled by `Makefile` and it is defined in `requirements.yml`

  - [elliotweiser.osx-command-line-tools](https://galaxy.ansible.com/elliotweiser/osx-command-line-tools/)
  - [ansible.community.general](https://docs.ansible.com/ansible/latest/collections/community/general/index.html)

<br>

## 📗 Example Playbook

```yaml
---
- hosts: localhost

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

  roles:
    - elliotweiser.osx-command-line-tools
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

# or test-tag without any parameters
$ make test-tag

# run tasks that ensures brew installation on macos
$ export TASK_TAGS="brew-install"; make test-tag

# run tasks that tries to update brew
$ export TASK_TAGS="brew-update"; make test-tag

# run tasks that tries to update brew and then run taps and casks
$ export TASK_TAGS="brew-update brew-taps brew-casks"; make test-tag
```

Full list of commands can be seen in `Makefile`.

<br>

## 🧩 Compatibility

This role has been tested on these systems:

| system / container | tag      |
| :----------------- | -------- |
| macos              | monterey |
| macos              | big-sur  |
| ubuntu             | latest   |
| debian             | latest   |

<br>

## 🤝 License

[![Licence](https://img.shields.io/github/license/wayofdev/ansible-role-homebrew?style=for-the-badge&color=blue)](./LICENSE)

<br>

## 🙆🏼‍♂️ Author Information

This role was created in **2022** by [lotyp / wayofdev](https://github.com/wayofdev).

Inspired by:

* [role-homebrew-retry](https://github.com/osx-provisioner/role-homebrew-retry) by [@niall-byrne](https://github.com/niall-byrne)
* homebrew role created by [@geerlingguy](https://github.com/geerlingguy) as a part of [ansible-collection-mac](https://github.com/geerlingguy/ansible-collection-mac).
