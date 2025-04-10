{{ config(materialized='view') }}

with bronze_order_items as (
    SELECT 
        {{ dbt_utils.generate_surrogate_key(['OrderID','ProductID']) }} as pk_order_key,
        OrderID as nk_order_id,
        {{ dbt_utils.generate_surrogate_key(['CustomerID']) }} as fk_customer_key,
        CustomerID as nk_customer_id,
        {{ dbt_utils.generate_surrogate_key(['EmployeeID']) }} as fk_employee_key,
        EmployeeID as nk_employee_id
        OrderDate as order_date,
        RequiredDate as required_date,
        ShippedDate as shipped_date,
        ShipVia as ship_via,
        Freight as freight,
        -- ShipName as ship_name,
        -- ShipAddress as ship_address,
        -- ShipCity as ship_city,
        -- ShipRegion as ship_region,
        -- ShipPostalCode as ship_postal_code,
        -- ShipCountry as ship_country,
        OrderID2 as pnk_order_id,
        ProductID as product_id,
        UnitPrice as unit_price,
        Quantity as quantity,
        Discount as discount
    FROM {{ var("source_schema") }}.orders
    WHERE OrderID IS NOT NULL
)

SELECT 
    pk_order_key,
    OrderID as nk_order_id,
    fk_customer_key,
    CustomerID as nk_customer_id,
    fk_employee_key,
    EmployeeID as nk_employee_id
    OrderDate as order_date,
    RequiredDate as required_date,
    ShippedDate as shipped_date,
    ShipVia as ship_via,
    Freight as freight,
    ProductID as product_id,
    UnitPrice as unit_price,
    Quantity as quantity,
    Discount as discount
FROM bronze_order_items
