# NewsAPI Data Pipeline

A data pipeline project that collects, processes, and analyzes news articles using NewsAPI, AWS S3, and MotherDuck (DuckDB).

## Prerequisites

- Python 3.11.8
- AWS Account with S3 access
- MotherDuck account and token
- NewsAPI credentials

## Environment Setup

1. Install dependencies:
```bash
pipenv install
```

2. Configure environment variables:
```bash
export AWS_ACCESS_KEY=your_key
export AWS_SECRET_KEY=your_secret
export MOTHERDUCK_TOKEN=your_token
```

## Project Structure

```
├── analyses/               # Jupyter notebooks for ad-hoc analysis
├── models/                 # dbt models
│   └── dwh-motherduck/
│       ├── staging/       # Raw data models
│       └── marts/         # Business-level transformations
├── macros/                # dbt macros
├── tests/                 # dbt tests
└── seeds/                 # Static data files
```

## Data Models

### Staging Layer
- `stg_articles_us_en`: Raw articles data from S3 parquet files
  - Implements incremental loading
  - Includes source data validation

### Marts Layer
- `fact_articles`: Cleaned and transformed articles data
  - Contains core article attributes
  - Implements incremental processing
  - Flattens nested structures

## Development

1. Clean the environment:
```bash
make clean
```

2. Run linting:
```bash
make lint
```

3. Run dbt:
```bash
dbt run
dbt test
```
