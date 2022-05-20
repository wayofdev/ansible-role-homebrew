###
### Variables
###

ANSIBLE_FORCE_COLOR = 1

# https://serverfault.com/questions/1031491/display-ansible-playbook-output-properly-formatted
# https://stackoverflow.com/questions/50009505/ansible-stdout-formatting
ANSIBLE_STDOUT_CALLBACK = unixy


### Playbook name
playbook ?= test.yml
workdir ?= ./tests
inventory ?= inventory.yml
reqs ?= requirements.yml
poetry ?= poetry run

### Lint yaml files
lint:
	$(poetry) yamllint .
	cd $(workdir) && $(poetry) ansible-lint $(playbook) -c ../.ansible-lint
	cd $(workdir) && $(poetry) ansible-playbook $(playbook) --syntax-check
.PHONY: lint

### Run tests
test:
	cd $(workdir) && $(poetry) ansible-playbook $(playbook)
.PHONY: test

### List all hostnames
ls-host:
	cd $(workdir) && $(poetry) ansible all -i $(inventory) -m shell -a "hostname;"
.PHONY: ls-host

### Check playbook syntax
check-syntax:
	cd $(workdir) && $(poetry) ansible-playbook $(playbook) -i $(inventory) --syntax-check
.PHONY: check-syntax

### Install ansible dependencies
install-deps:
	$(poetry) ansible-galaxy install -r $(reqs)
.PHONY: install-deps

install-py-deps:
	pip3 install poetry
	poetry install
.PHONY: install-py-deps

install-all-deps: install-py-deps install-deps
.PHONY: install-all-deps

### Git
hooks:
	pre-commit install
.PHONY: install-hooks
