{{ config(materialized='view') }}

with bronze_orders as (

    SELECT 
        {{ dbt_utils.generate_surrogate_key(['OrderID']) }} as pk_order_key,
        OrderID as nk_order_id,
        CustomerID,
        EmployeeID,
        OrderDate,
        RequiredDate,
        ShippedDate,
        ShipVia,
        Freight,
        ShipName,
        ShipAddress,
        ShipCity,
        ShipRegion,
        ShipPostalCode,
        ShipCountry,
        OrderID,
        ProductID,
        UnitPrice,
        Quantity,
        Discount
    FROM {{ var("source_schema") }}

)

select *
from bronze_orders

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
