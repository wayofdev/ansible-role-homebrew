###
### Variables
###

export ANSIBLE_FORCE_COLOR = 1
export PY_COLORS = 1
export PYTHONIOENCODING = UTF-8
export LC_CTYPE = en_US.UTF-8
export LANG = en_US.UTF-8

# https://serverfault.com/questions/1031491/display-ansible-playbook-output-properly-formatted
# https://stackoverflow.com/questions/50009505/ansible-stdout-formatting
export ANSIBLE_STDOUT_CALLBACK = unixy

TASK_TAGS ?= "brew-install,brew-analytics,brew-update,brew-taps,brew-packages,brew-casks"
PLAYBOOK ?= test.yml
WORKDIR ?= ./tests
INVENTORY ?= inventory.yml
REQS ?= requirements.yml
INSTALL_POETRY ?= true
POETRY_BIN ?= poetry
POETRY_RUNNER ?= poetry run
ANSIBLE_LATER_BIN = ansible-later
MACOS_NATIVE_PY_PATH ?= /usr/bin/python3
PY_PATH ?= $(shell which python3)

# leave empty to disable
# -v - verbose;
# -vv - more details
# -vvv - enable connection debugging
DEBUG_VERBOSITY ?= -vvv

TEST_PLAYBOOK = $(POETRY_RUNNER) ansible-playbook $(PLAYBOOK) -i $(INVENTORY) $(DEBUG_VERBOSITY) --ask-become
TEST_IDEMPOTENT = $(TEST_PLAYBOOK) | tee /dev/tty | grep -q 'changed=0.*failed=0' && (echo 'Idempotence test: pass' && exit 0) || (echo 'Idempotence test: fail' && exit 1)

### Lint yaml files
lint: check-syntax
	$(POETRY_RUNNER) yamllint .
	$(POETRY_RUNNER) ansible-lint . --force-color
.PHONY: lint

### Run tests
test:
	cd $(WORKDIR) && $(TEST_PLAYBOOK)
.PHONY: test

test-idempotent:
	cd $(WORKDIR) && $(TEST_IDEMPOTENT)
.PHONY: test-idempotent

test-install: TASK_TAGS="brew-install"
test-install: test-tag

test-analytics: TASK_TAGS="brew-analytics"
test-analytics: test-tag

test-update: TASK_TAGS="brew-update"
test-update: test-tag

test-taps: TASK_TAGS="brew-taps"
test-taps: test-tag

test-packages: TASK_TAGS="brew-packages"
test-packages: test-tag

test-casks: TASK_TAGS="brew-casks"
test-casks: test-tag

test-tag:
	cd $(WORKDIR) && $(TEST_PLAYBOOK) --tags $(TASK_TAGS)
.PHONY: test-tag

m-local:
	$(POETRY_RUNNER) molecule test --scenario-name default-macos-on-localhost -- $(DEBUG_VERBOSITY) --tags $(TASK_TAGS)
.PHONY: m-local

m-remote:
	$(POETRY_RUNNER) molecule test --scenario-name default-macos-over-ssh -- $(DEBUG_VERBOSITY) --tags $(TASK_TAGS)
.PHONY: m-remote

m-linux:
	$(POETRY_RUNNER) molecule test --scenario-name default -- $(DEBUG_VERBOSITY) --tags $(TASK_TAGS)
.PHONY: m-linux

login-mac:
	$(POETRY_RUNNER) molecule login \
		--host macos-12-vm \
		--scenario-name default-macos-over-ssh
.PHONY: login-mac

login-deb:
	$(POETRY_RUNNER) molecule login \
		--host debian-based-instance \
		--scenario-name default
.PHONY: login-deb

debug-version:
	$(POETRY_RUNNER) ansible --version
.PHONY: debug-version

check:
	cd $(WORKDIR) && $(TEST_PLAYBOOK) --check
.PHONY: check

### List all hostnames
ls-host:
	cd $(WORKDIR) && $(POETRY_RUNNER) ansible all -i $(INVENTORY) -m shell -a "hostname;"
.PHONY: ls-host

### Check playbook syntax
check-syntax:
	cd $(WORKDIR) && $(TEST_PLAYBOOK) --syntax-check
.PHONY: check-syntax

later:
	$(POETRY_RUNNER) $(ANSIBLE_LATER_BIN) **/*.yml
.PHONY: later

### Install ansible dependencies
install: update-pip install-poetry install-deps
.PHONY: install

install-deps:
	$(POETRY_BIN) install
	$(POETRY_RUNNER) ansible-galaxy install -r $(REQS)
.PHONY: install-deps

install-poetry:
ifeq ($(INSTALL_POETRY),true)
	sudo sh contrib/poetry-bin/install.sh
else
	@echo "Poetry installation disabled by global variable! Exiting..."
	@exit 0
endif
.PHONY: install-poetry

update-pip:
ifeq ($(PY_PATH),$(MACOS_NATIVE_PY_PATH))
	@echo "Native macOS python binary detected at" $(MACOS_NATIVE_PY_PATH)
	sudo pip3 install --upgrade pip
else
	@echo "External python binary detected at" $(PY_PATH)
	@exit 0
endif
.PHONY: update-pip

### Git
hooks:
	$(POETRY_RUNNER) pre-commit install
	$(POETRY_RUNNER) pre-commit autoupdate
.PHONY: hooks
