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


### Lint yaml files
lint:
	$(POETRY) yamllint .
	cd $(WORKDIR) && $(POETRY) ansible-lint $(PLAYBOOK) -c ../.ansible-lint
	cd $(WORKDIR) && $(POETRY) ansible-playbook $(PLAYBOOK) --syntax-check
.PHONY: lint

### Run tests
test:
	cd $(WORKDIR) && $(POETRY) ansible-playbook $(PLAYBOOK) --ask-become
.PHONY: test

test-tag:
	cd $(WORKDIR) && $(POETRY) ansible-playbook $(PLAYBOOK) --ask-become --tags $(TASK_TAGS)
.PHONY: test-tag

### List all hostnames
ls-host:
	cd $(WORKDIR) && $(POETRY) ansible all -i $(INVENTORY) -m shell -a "hostname;"
.PHONY: ls-host

### Check playbook syntax
check-syntax:
	cd $(WORKDIR) && $(POETRY) ansible-playbook $(PLAYBOOK) -i $(INVENTORY) --syntax-check
.PHONY: check-syntax

### Install ansible dependencies
install: install-poetry install-deps
.PHONY: install

install-deps:
	poetry install
	$(POETRY) ansible-galaxy install -r $(REQS)
.PHONY: install-deps

install-poetry:
	sudo pip3 install --upgrade pip
	sudo sh contrib/poetry-bin/install.sh
.PHONY: install-poetry

### Git
hooks:
	pre-commit install
.PHONY: install-hooks
