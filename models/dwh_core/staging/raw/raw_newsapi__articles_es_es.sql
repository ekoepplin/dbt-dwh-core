with source as (
    select * from {{ source('newsapi', 'articles_es_es') }}
)
select * from source

  