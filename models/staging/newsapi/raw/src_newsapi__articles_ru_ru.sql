with source as (
      select * from {{ source('newsapi', 'articles_ru_ru') }}
)

select * from source
  