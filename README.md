# NewsAPI Data Pipeline

A data pipeline project that collects, processes, and analyzes news articles from multiple languages using NewsAPI, AWS S3, AWS Athena, and MotherDuck (DuckDB).

## Prerequisites

- Python 3.11.8
- AWS Account with S3 access and Athena permissions
- MotherDuck account and token
- NewsAPI credentials

## Environment Setup

1. Install dependencies:
```bash
pipenv install
```

2. Configure environment variables:
```bash
export AWS_ACCESS_KEY_ID=your_key
export AWS_SECRET_ACCESS_KEY=your_secret
# Only relevant for local development with duckdb
export RAW_S3_PATH_INPUT_US_EN=your_s3_path
export RAW_S3_PATH_INPUT_DE_DE=your_s3_path
# Additional language paths (FR, ES, IT, RU, GB)
```

## Data Warehouse Architecture

### Primary Warehouse (AWS Athena)
- Production data warehouse using AWS Athena
- Queries data directly from S3 using Presto engine
- Cost-effective for large-scale analytics
- Configured via `dwh-athena` profile in dbt

## Project Structure

```
├── analyses/               # Jupyter notebooks for ad-hoc analysis
├── models/                 # dbt models
│   └── dwh_core/
│       ├── staging/       # Raw and staging models
│       │   ├── raw/      # Direct source mappings
│       │   └── stg_*/    # Standardized models
│       ├── intermediate/  # Business logic layer
│       └── marts/        # Analytics-ready models
├── macros/                # dbt macros
├── tests/                 # dbt tests
└── seeds/                 # Static data files
```

## Data Models

### Raw Layer (`raw_newsapi__articles_*`)
Supported languages:
- US English (us_en)
- German (de_de)
- Spanish (es_es)
- French (fr_fr)
- Italian (it_it)
- Russian (ru_ru)
- British English (uk_gb)

### Staging Layer (`stg_newsapi__articles_*`)
Standardized models with:
- Consistent column naming
- Language code assignment
- Basic field transformations
- URL and image handling

Example fields:
```sql
source_name, author, title, description, url, 
image_url, published_at, content, language_code
```

### Intermediate Layer
Key model: `int_newsapi__articles_enriched`
- Combines articles across languages
- Adds derived metrics:
  - Content length calculation
  - Image presence flags
- Prepares data for mart layer

### Marts Layer
Key model: `mart_newsapi__articles_overall`
Features:
- Multi-language article unification
- Deduplication logic
- Complete article history
- Ready for analytics consumption

## Development

1. Clean the environment:
```bash
make clean
```

2. Run linting:
```bash
make lint
make lint-sql
```

3. Run dbt:
```bash
dbt run
dbt test
```

## CI/CD

Automated GitHub Actions workflows for:
- Production builds (main branch)
- Source freshness checks
- Model testing
- SQL linting

Configuration files:
- `.github/workflows/dbt-build-prod.yml`
- `.sqlfluff` for SQL style enforcement
