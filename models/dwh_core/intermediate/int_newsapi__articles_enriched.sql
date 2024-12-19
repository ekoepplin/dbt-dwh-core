WITH articles_combined AS (
    SELECT 
        source_name,
        author,
        title,
        description,
        url,
        image_url,
        published_at,
        content,
        language_code,
        _dlt_load_id,
        _dlt_id
    FROM {{ ref('stg_newsapi__articles_us_en') }}
    
    UNION ALL
    
    SELECT 
        source_name,
        author,
        title,
        description,
        url,
        image_url,
        published_at,
        content,
        language_code,
        _dlt_load_id,
        _dlt_id
    FROM {{ ref('stg_newsapi__articles_de_de') }}
    -- Add other languages here
),

enriched AS (
    SELECT 
        *,
        LENGTH(content) AS content_length,
        CASE 
            WHEN image_url IS NOT NULL THEN TRUE 
            ELSE FALSE 
        END AS has_image
    FROM articles_combined
)

SELECT * FROM enriched 