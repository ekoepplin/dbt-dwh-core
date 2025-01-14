WITH articles_us AS (
    SELECT 
        source_name,
        author,
        title,
        description,
        url,
        image_url,
        published_at,
        content,
        'us' AS source_country_code,
        _dlt_load_id,
        _dlt_id
    FROM {{ ref('stg_newsapi__articles_us_en') }}
)
SELECT * FROM articles_us 