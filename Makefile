.PHONY: help
help: ## Displays this list of targets with descriptions
	@echo "The following commands are available:\n"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: docs
docs: ## Generate projects documentation (from "Documentation" directory)
	mkdir -p Documentation-GENERATED-temp

	docker run --rm --pull always -v "$(shell pwd)":/project -t ghcr.io/typo3-documentation/render-guides:latest --config=Documentation

.PHONY: test-docs
test-docs: ## Test the documentation rendering
	mkdir -p Documentation-GENERATED-temp

	docker run --rm --pull always -v "$(shell pwd)":/project -t ghcr.io/typo3-documentation/render-guides:latest --config=Documentation --no-progress --fail-on-log

.PHONY: generate
generate: ## Regenerate code snippets
	ddev exec .Build/bin/typo3 codesnippet:create Documentation/

.PHONY: test-lint
test-cgl: ## Regenerate code snippets
	Build/Scripts/runTests.sh -s lint

.PHONY: test-cgl
test-cgl: ## Regenerate code snippets
	Build/Scripts/runTests.sh -s cgl

.PHONY: test-yaml
test-yaml: ## Regenerate code snippets
	Build/Scripts/runTests.sh -s yamlLint

.PHONY: test
test: test-docs test-lint test-cgl test-yaml## Test the documentation rendering
