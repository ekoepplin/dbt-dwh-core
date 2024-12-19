WITH articles_es AS (
    SELECT 
        source_name,
        author,
        title,
        description,
        url,
        image_url,
        published_at,
        content,
        'es' AS source_country_code,
        _dlt_load_id,
        _dlt_id
    FROM {{ ref('stg_newsapi__articles_es_es') }}
)
SELECT * FROM articles_es 