
-- Use the `ref` function to select from other models

SELECT *
    FROM {{ var("source_schema") }}.products
