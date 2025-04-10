
-- Use the `ref` function to select from other models

SELECT *
--from {{ ref('my_first_dbt_model') }}
    FROM {{ var("source_schema") }}.products
