WITH articles_fr AS (
    SELECT 
        source__name AS source_name,
        author,
        title,
        description,
        url,
        url_to_image AS image_url,
        published_at,
        content,
        'fr' AS source_country_code,
        _dlt_load_id,
        _dlt_id
    FROM {{ ref('src_newsapi__articles_fr_fr') }}
)
SELECT * FROM articles_fr 