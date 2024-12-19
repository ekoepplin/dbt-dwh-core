with source as (
      select * from {{ source('newsapi', 'articles_it_it') }}
)
select * from source
  