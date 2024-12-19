WITH articles_de AS (
    SELECT 
        source_name,
        author,
        title,
        description,
        url,
        image_url,
        published_at,
        content,
        'de' AS source_country_code,
        _dlt_load_id,
        _dlt_id
    FROM {{ ref('stg_newsapi__articles_de_de') }}
)
SELECT * FROM articles_de
