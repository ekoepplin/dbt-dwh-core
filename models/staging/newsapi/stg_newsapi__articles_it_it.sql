SELECT 
    source__name AS source_name,
    author,
    title,
    description,
    url,
    url_to_image AS image_url,
    published_at,
    content,
    'it' AS language_code,
    _dlt_load_id,
    _dlt_id 
FROM {{ ref('src_newsapi__articles_it_it') }}
  