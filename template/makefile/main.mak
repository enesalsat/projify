########## Configuration ##########

PROJECT_NAME = projify
PROJECT_PATH = $(PWD)/$(PROJECT_NAME)
PYTHON3=$(shell poetry env info -p)/bin/python3

# GIT
DEV_BRANCH_NAME = dev
INITIAL_BRANCH_NAME = main

###################################

help:     ## Show this help.
	@grep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; \
		{printf "\033[36m  %-25s\033[0m %s\n", $$1, $$2}'

clear clean: ## Clean up
	@echo "Cleaning up..."
	@find . -name "__pycache__" -exec rm -rf {} +
	@clear

git: ## Git add, commit, push
	@read -p "Enter commit message: " message &&\
		git add . && git commit -m "$$message";
	@git push origin $(shell git branch --show-current)

merge: compile ## Merge develop to main(master) #TODO for index update
	@git checkout $(INITIAL_BRANCH_NAME) && git pull origin $(INITIAL_BRANCH_NAME) &&\
		git merge $(DEV_BRANCH_NAME) && git push origin $(INITIAL_BRANCH_NAME) &&\
		git checkout $(DEV_BRANCH_NAME) && git pull origin $(DEV_BRANCH_NAME)
