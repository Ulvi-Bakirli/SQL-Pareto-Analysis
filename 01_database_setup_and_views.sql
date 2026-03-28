
DECLARE target_sales_pct FLOAT64 DEFAULT 0.80;

-- Sales = Quantity * UnitPrice
-- CustomerID, sales

CREATE OR REPLACE VIEW `pareto-491119.pareto.sales_v1`
AS
SELECT CustomerID, (Quantity * UnitPrice) AS sales
FROM
  `pareto-491119.pareto.sales`;

-- GROUP BY customers, sales for each customer in one row of data

CREATE OR REPLACE VIEW `pareto-491119.pareto.sales_v2`
AS
SELECT CustomerID, SUM(sales) AS customer_revenue
FROM `pareto-491119.pareto.sales_v1`
GROUP BY CustomerID;

-- CustomerID, customer_revenue, cum_customers, total_customers, cum_revenue, total_revenue -- View3

CREATE OR REPLACE VIEW `pareto-491119.pareto.sales_v3`
AS
SELECT
  CustomerID,
  customer_revenue,
  ROW_NUMBER() OVER (ORDER BY customer_revenue DESC) AS cum_customers,
  COUNT(*) OVER () AS total_customers,
  SUM(customer_revenue)
    OVER (
      ORDER BY customer_revenue DESC
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cum_revenue,
  SUM(customer_revenue) OVER () AS total_revenue
FROM `pareto-491119.pareto.sales_v2`;

-- CustomerID, customer_revenue, cum_customers, total_customers, cum_revenue, total_revenue
-- + cum_sales_share, cum_pct_customers -- View4

CREATE OR REPLACE VIEW `pareto-491119.pareto.sales_v4`
AS
SELECT
  CustomerID,
  customer_revenue,
  cum_customers,
  total_customers,
  cum_revenue,
  total_revenue,
  cum_revenue / total_revenue AS cum_sales_share,
  cum_customers / total_customers AS cum_pct_customers
FROM `pareto-491119.pareto.sales_v3`;


-- Running pareto analysis, view-4
SELECT
  MIN(cum_customers) AS number_of_customers,
  MIN(total_customers) AS total_customers,
  MIN(cum_revenue) AS cum_revenue,
  MIN(total_revenue) AS total_revenue,
  target_sales_pct * 100 AS target_sales_pct,
  MIN(total_revenue * target_sales_pct) AS target_sales,
  MIN(cum_sales_share) AS cum_sales_share,
  MIN(cum_pct_customers) AS cum_pct_customers
FROM `pareto-491119.pareto.sales_v4`
WHERE cum_sales_share >= target_sales_pct;
