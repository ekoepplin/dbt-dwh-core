with source as (
    select * from {{ source('newsapi', 'articles_us_en') }}
)

select * from source 