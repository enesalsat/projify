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

test: clear format lint type-check ## Run all tests(format, lint, mypy)
	@echo "All tests passed!"

env: ## Activate poetry shell
	@poetry shell
