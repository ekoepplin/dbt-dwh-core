SELECT 
    url,
    title,
    author,
    source__name as source_name,  -- Using the flattened column name
    published_at,  -- Using the correct column name from staging
    description,
    content,
    _dlt_load_id,
    _dlt_id
FROM {{ ref('stg_articles_us_en') }}
{% if is_incremental() %}
    WHERE _dlt_load_id > (SELECT max(_dlt_load_id) FROM {{ this }})
{% endif %} 