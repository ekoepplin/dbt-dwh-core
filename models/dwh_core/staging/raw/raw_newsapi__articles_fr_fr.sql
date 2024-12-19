with source as (
      select * from {{ source('newsapi', 'articles_fr_fr') }}
)
select * from source
  