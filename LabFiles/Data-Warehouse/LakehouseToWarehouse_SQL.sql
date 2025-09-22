
SELECT * 
INTO dim_customer
FROM workshop_lakehouse_gold.dbo.dim_customer;


SELECT * 
INTO dim_dates
FROM workshop_lakehouse_gold.dbo.dim_dates;


SELECT * 
INTO dim_promotions
FROM workshop_lakehouse_gold.dbo.dim_promotions;


SELECT * 
INTO dim_purchase
FROM workshop_lakehouse_gold.dbo.dim_purchase;


SELECT * 
INTO dim_supplier
FROM workshop_lakehouse_gold.dbo.dim_supplier;


SELECT * 
INTO fact_sale
FROM workshop_lakehouse_gold.dbo.fact_sale;
