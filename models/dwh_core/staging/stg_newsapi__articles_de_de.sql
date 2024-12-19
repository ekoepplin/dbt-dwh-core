
SELECT 
    source__name AS source_name,
    author,
    title,
    description,
    url,
    url_to_image AS image_url,
    published_at,
    content,
    'de' AS language_code,
    _dlt_load_id,
    _dlt_id 
FROM {{ ref('raw_newsapi__articles_de_de') }}

  