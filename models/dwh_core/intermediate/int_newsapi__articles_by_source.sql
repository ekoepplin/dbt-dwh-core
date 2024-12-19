WITH article_stats AS (
    SELECT 
        source_name,
        language_code,
        published_at,
        COUNT(*) AS article_count,
        AVG(content_length) AS avg_content_length,
        SUM(CASE WHEN has_image THEN 1 ELSE 0 END) AS articles_with_images
    FROM {{ ref('int_newsapi__articles_enriched') }}
    GROUP BY 1, 2, 3
)

SELECT * FROM article_stats 