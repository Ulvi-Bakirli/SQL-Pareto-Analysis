DECLARE target_sales_pct FLOAT64 DEFAULT 0.80;

SELECT
  MIN(cum_customer) AS number_of_customers,
  MIN(total_customers) AS total_customers,
  MIN(cum_revenue) AS cum_revenue,
  MIN(total_revenue) AS total_revenue,
  target_sales_pct * 100 AS target_sales_pct,
  MIN(total_revenue * target_sales_pct) AS target_sales,
  MIN(cum_sales_shares) AS cum_sales_share,
  MIN(cum_pct_customers) AS cum_pct_customers
FROM
  (
    SELECT
      customerID,
      customer_revenue,
      cum_customer,
      total_customers,
      cum_revenue,
      total_revenue,
      cum_revenue / total_revenue AS cum_sales_shares,
      cum_customer / total_customers AS cum_pct_customers
    FROM
      (
        SELECT
          CustomerID,
          customer_revenue,
          row_number() OVER (ORDER BY customer_revenue DESC) AS cum_customer,
          COUNT(*) OVER () AS total_customers,
          SUM(customer_revenue)
            OVER (
              ORDER BY customer_revenue DESC
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS cum_revenue,
          sum(customer_revenue) OVER () AS total_revenue
        FROM
          (
            SELECT
              CustomerID,
              SUM(sales) AS customer_revenue
            FROM
              (
                SELECT
                  CustomerID,
                  (Quantity * UnitPrice) AS sales,
                FROM `pareto-491119.pareto.sales`
              )
            GROUP BY CustomerID
          )
      )
  )
WHERE cum_sales_shares >= target_sales_pct;
