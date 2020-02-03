# basic test infrastructure

.PHONY: help docs
# Put it first so that "make" without argument is like "make help"
# God bless the interwebs:
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## List Makefile targets
	$(info Makefile documentation)
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

clean:
	rm -rf .pytest_cache/

neat: ## Make everything look neat
	black utils
	pylint utils

test: ## Run the tests
	pytest

wheel: ## Build Python binary wheel package for distribution
	poetry build -f wheel

source: ## Build Python source package for distribution
	poetry build -f sdist

check: neat test ## Check for both neatness and correctness (neat + clean)
