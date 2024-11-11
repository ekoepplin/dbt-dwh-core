all: clean lint
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
		--dialect snowflake \
		--exclude-rules L034,L016 \
		$(shell git diff --name-only origin/main --diff-filter=d | grep -E '^(models)/.*\.sql$$' | cat)

.PHONY: fix-sql
fix-sql:
	@sqlfluff fix \
		--dialect snowflake \
		--exclude-rules L034,L016 \
		--force \
		$(shell git diff --name-only origin/main --diff-filter=d | grep -E '^(models)/.*\.sql$$' | cat)
