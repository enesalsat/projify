########## Configuration ##########

PROJECT_NAME = projify
PROJECT_PATH = $(PWD)/$(PROJECT_NAME)
PYTHON3=$(shell poetry env info -p)/bin/python3

# GIT
DEV_BRANCH_NAME = dev

###################################

help:     ## Show this help.
	@grep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; \
		{printf "\033[36m  %-25s\033[0m %s\n", $$1, $$2}'

clear clean: ## Clean up
	@echo "Cleaning up..."
	@find . -name "__pycache__" -exec rm -rf {} +
	@clear

install: ## Install dependencies
	@echo "Installing dependencies..."
	@poetry config virtualenvs.in-project true
	@poetry install

format: ## Run format(black, isort, autoflake, djlint)
	@poetry run autoflake --in-place --remove-all-unused-imports --recursive \
		--remove-unused-variables --ignore-init-module-imports .
	@poetry run isort .
	@poetry run black .

lint: ## Run lint
	@poetry run pylint $(PROJECT_NAME)

type-check: ## Run tests (mypy)
	@poetry run mypy .

ipython: ## Run ipython in poetry env
	@poetry run ipython

update: ## Update dependencies
	@echo "Updating dependencies..."
	@poetry update

test: clear format lint test ## Run all tests(format, lint, mypy)
	@echo "All tests passed!"

env: ## Activate poetry shell
	@poetry shell

git: ## Git add, commit, push
	@read -p "Enter commit message: " message &&\
		git add . && git commit -m "$$message";
	@git push origin $(shell git branch --show-current)

merge: compile ## Merge develop to main #TODO for index update
	@git checkout main && git pull origin main &&\
		git merge $(DEV_BRANCH_NAME) && git push origin main &&\
		git checkout $(DEV_BRANCH_NAME) && git pull origin $(DEV_BRANCH_NAME)

