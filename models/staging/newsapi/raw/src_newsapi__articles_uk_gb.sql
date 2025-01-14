with source as (
      select * from {{ source('newsapi', 'articles_uk_gb') }}
)
select * from source

