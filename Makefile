###
### Variables
###

export ANSIBLE_FORCE_COLOR = 1
export ANSIBLE_JINJA2_NATIVE = true

# https://serverfault.com/questions/1031491/display-ansible-playbook-output-properly-formatted
# https://stackoverflow.com/questions/50009505/ansible-stdout-formatting
export ANSIBLE_STDOUT_CALLBACK = unixy

TASK_TAGS ?= "brew-install brew-update brew-taps brew-packages brew-casks"
PLAYBOOK ?= test.yml
WORKDIR ?= ./tests
INVENTORY ?= inventory.yml
REQS ?= requirements.yml
POETRY ?= poetry run
MACOS_NATIVE_PY_PATH ?= /usr/bin/python
PY_PATH ?= $(shell which python3)

# -v - verbose;
# -vvv - more details
# -vvv - enable connection debugging
DEBUG_VERBOSITY ?= -v

TEST_PLAYBOOK = $(POETRY) ansible-playbook $(PLAYBOOK) -i $(INVENTORY) --ask-become $(DEBUG_VERBOSITY)
TEST_IDEMPOTENT = $(TEST_PLAYBOOK) | grep -q 'changed=0.*failed=0' && (echo 'Idempotence test: pass' && exit 0) || (echo 'Idempotence test: fail' && exit 1)

### Lint yaml files
lint: check-syntax
	$(POETRY) yamllint .
	cd $(WORKDIR) && $(POETRY) ansible-lint $(PLAYBOOK) -c ../.ansible-lint
.PHONY: lint

### Run tests
test:
	cd $(WORKDIR) && $(TEST_PLAYBOOK)
.PHONY: test

test-idempotent:
	cd $(WORKDIR) && $(TEST_IDEMPOTENT)
.PHONY: test-idempotent

test-tag:
	cd $(WORKDIR) && $(TEST_PLAYBOOK) --tags $(TASK_TAGS)
.PHONY: test-tag

debug-version:
	ansible --version
.PHONY: debug-version

check:
	cd $(WORKDIR) && $(TEST_PLAYBOOK) --check
.PHONY: check

### List all hostnames
ls-host:
	cd $(WORKDIR) && $(POETRY) ansible all -i $(INVENTORY) -m shell -a "hostname;"
.PHONY: ls-host

### Check playbook syntax
check-syntax:
	cd $(WORKDIR) && $(TEST_PLAYBOOK) --syntax-check
.PHONY: check-syntax

### Install ansible dependencies
install: update-pip install-poetry install-deps
.PHONY: install

install-deps:
	poetry install
	$(POETRY) ansible-galaxy install -r $(REQS)
.PHONY: install-deps

install-poetry:
	sudo sh contrib/poetry-bin/install.sh
.PHONY: install-poetry

update-pip:
ifeq ($(PY_PATH),$(MACOS_NATIVE_PY_PATH))
	echo "Native macOS python binary detected at" $(MACOS_NATIVE_PY_PATH)
	sudo pip3 install --upgrade pip
else
	echo "External python binary detected at" $(PY_PATH)
	exit 0
endif
.PHONY: update-pip

### Git
hooks:
	pre-commit install
.PHONY: install-hooks
