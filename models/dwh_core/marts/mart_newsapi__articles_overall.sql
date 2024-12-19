WITH articles_de AS (
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
),

articles_es AS (
    SELECT 
        source__name AS source_name,
        author,
        title,
        description,
        url,
        url_to_image AS image_url,
        published_at,
        content,
        'es' AS language_code,
        _dlt_load_id,
        _dlt_id
    FROM {{ ref('raw_newsapi__articles_es_es') }}
),

articles_fr AS (
    SELECT 
        source__name AS source_name,
        author,
        title,
        description,
        url,
        url_to_image AS image_url,
        published_at,
        content,
        'fr' AS language_code,
        _dlt_load_id,
        _dlt_id
    FROM {{ ref('raw_newsapi__articles_fr_fr') }}
),

articles_it AS (
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
    FROM {{ ref('raw_newsapi__articles_it_it') }}
),

articles_ru AS (
    SELECT 
        source__name AS source_name,
        author,
        title,
        description,
        url,
        url_to_image AS image_url,
        published_at,
        content,
        'ru' AS language_code,
        _dlt_load_id,
        _dlt_id
    FROM {{ ref('raw_newsapi__articles_ru_ru') }}
),

articles_uk AS (
    SELECT 
        source__name AS source_name,
        author,
        title,
        description,
        url,
        url_to_image AS image_url,
        published_at,
        content,
        'gb' AS language_code,
        _dlt_load_id,
        _dlt_id
    FROM {{ ref('raw_newsapi__articles_uk_gb') }}
),

articles_us AS (
    SELECT 
        source__name AS source_name,
        author,
        title,
        description,
        url,
        url_to_image AS image_url,
        published_at,
        content,
        'us' AS language_code,
        _dlt_load_id,
        _dlt_id
    FROM {{ ref('raw_newsapi__articles_us_en') }}
),

combined_articles AS (
    SELECT * FROM articles_de
    UNION ALL
    SELECT * FROM articles_es
    UNION ALL
    SELECT * FROM articles_fr
    UNION ALL
    SELECT * FROM articles_it
    UNION ALL
    SELECT * FROM articles_ru
    UNION ALL
    SELECT * FROM articles_uk
    UNION ALL
    SELECT * FROM articles_us
),

deduplicated AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY url, published_at, _dlt_id
               ORDER BY published_at DESC
           ) as row_num
    FROM combined_articles
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['url', 'published_at', '_dlt_id']) }} AS article_id,
    source_name,
    author,
    title,
    description,
    url,
    image_url,
    published_at,
    content,
    language_code,
    _dlt_load_id AS source_batch_id,
    _dlt_id AS source_record_id,
    -- Add metadata columns
    '{{ invocation_id }}' AS dbt_job_id,
    '{{ this.identifier }}' AS dbt_model_name
FROM deduplicated
WHERE row_num = 1