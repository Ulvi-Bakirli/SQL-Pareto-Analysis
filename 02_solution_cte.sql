DECLARE target_sales_pct FLOAT64 DEFAULT 0.80;


WITH base_sales AS (
  SELECT
    CustomerID,
    (Quantity * UnitPrice) AS sales,
  FROM `pareto-491119.pareto.sales`
),
  customer_sales AS(
    SELECT
      CustomerID,
      SUM(sales) AS customer_revenue
    FROM base_sales
    GROUP BY CustomerID
  ),

  ranked AS(
    SELECT
      CustomerID,
      customer_revenue,
      row_number() over(order by customer_revenue desc) AS cum_customer,
      COUNT(*) OVER() AS total_customers,
      SUM(customer_revenue) OVER(order by customer_revenue desc 
      --rows between unbounded preceding and current row
      ) AS cum_revenue,
      sum(customer_revenue) over() AS total_revenue,
    FROM customer_sales
  ),

  with_pct as (
    select
      customerID,
      customer_revenue,
      cum_customer,
      total_customers,
      cum_revenue,
      total_revenue,
      cum_revenue / total_revenue as cum_sales_shares,
      cum_customer / total_customers as cum_pct_customers
    from ranked
  )


SELECT
  MIN(cum_customer) AS number_of_customers,
  MIN(total_customers) AS total_customers,
  MIN(cum_revenue) AS cum_revenue,
  MIN(total_revenue) AS total_revenue,
  target_sales_pct * 100 AS target_sales_pct,
  MIN(total_revenue * target_sales_pct) AS target_sales,
  MIN(cum_sales_shares) AS cum_sales_share,
  MIN(cum_pct_customers) AS cum_pct_customers
FROM with_pct
WHERE cum_sales_shares >= target_sales_pct;

