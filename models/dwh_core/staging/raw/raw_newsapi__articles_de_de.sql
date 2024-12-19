with source as (
      select * from {{ source('newsapi', 'articles_de_de') }}
)
select * from source
  