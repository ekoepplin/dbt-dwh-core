-- Understanding _dlt_load_id, _dlt_id
DESCRIBE SELECT * FROM dbt.dev.base_newsapi_articles_de_de;

SELECT * FROM dbt.dev.int_newsapi_articles;


SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY url, _dlt_id
               ORDER BY published_at DESC
           ) as row_num
    FROM dbt.dev.base_newsapi_articles_us_en ORDER BY row_num DESC;