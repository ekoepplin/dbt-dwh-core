WITH source AS (
    SELECT *
    FROM read_parquet('s3://newsapi-dev/newsapi_data/articles_us_en/*.parquet')
    WHERE _dlt_id IS NOT NULL
)

SELECT 
    *
FROM source
{% if is_incremental() %}
    WHERE _dlt_load_id > (SELECT max(_dlt_load_id) FROM {{ this }})
{% endif %} 