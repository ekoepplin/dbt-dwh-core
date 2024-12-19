btall: clean lint
.PHONY: all

clean:
	rm -rf target/
	rm -rf dbt_packages/
	rm -rf logs/
.PHONY: clean

lint:
	dbt debug
	dbt deps
	dbt compile
.PHONY: lint

.PHONY: lint-sql
lint-sql:
	@sqlfluff lint \
		--exclude-rules L034,L016 \
		$(shell git diff --name-only origin/main --diff-filter=d | grep -E '^(models)/.*\.sql$$' | cat)

.PHONY: fix-sql
fix-sql:
	@sqlfluff fix \
		--exclude-rules L034,L016 \
		--force \
		$(shell git diff --name-only origin/main --diff-filter=d | grep -E '^(models)/.*\.sql$$' | cat)

# GitHub Actions local testing
# [ ] TODO: Solve AWS credentials issue
.PHONY: act-list
act-list:
	act -l

# Define a variable to check if we're running locally
IS_LOCAL := $(shell if [ -f .secrets ]; then echo true; else echo false; fi)

# Create different targets for local and production runs
act-dbt-prod:
	@if [ "$(IS_LOCAL)" = "true" ]; then \
		sed 's/secrets\./env./g' .github/python-dbt-setup/action.yml > .github/python-dbt-setup/action.yml.tmp && \
		mv .github/python-dbt-setup/action.yml.tmp .github/python-dbt-setup/action.yml && \
		act -j dbt-build-prod --container-architecture linux/amd64 --secret-file .secrets; \
		git checkout .github/python-dbt-setup/action.yml; \
	else \
		act -j dbt-build-prod --container-architecture linux/amd64; \
	fi

.PHONY: act-dbt-prod-dry
act-dbt-prod-dry:
	act -j dbt-build-prod \
		--container-architecture linux/amd64 \
		--secret-file .secrets

.PHONY: act-workflow-dispatch
act-workflow-dispatch:
	act workflow_dispatch \
		--container-architecture linux/amd64 \
		-s AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
		-s AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
		-s AWS_REGION=${AWS_REGION} 
