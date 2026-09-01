-- Task 12: Customer count, sales and profit by city
-- Assumption: the city is the text before the first comma.
-- Missing or unparseable addresses are labeled 'Unknown'.
-- Count all registered customers, including those without sales.

WITH customer_cities AS (
    SELECT
        customer_id,
        CASE
            WHEN INSTR(address, ',') > 1
            THEN NVL(
                TRIM(SUBSTR(address, 1, INSTR(address, ',') - 1)),
                'Unknown'
            )
            ELSE 'Unknown'
        END AS city
    FROM P_Customers
)
SELECT
    c.city,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    NVL(SUM(td.total_amount), 0) AS total_sales,
    NVL(SUM(td.profit), 0) AS total_profit
FROM customer_cities c
LEFT JOIN P_Transactions t
    ON t.customer_id = c.customer_id
    AND LOWER(TRIM(t.transaction_type)) = 'իրացում'
LEFT JOIN P_TransactionDetails td
    ON td.transaction_id = t.transaction_id
GROUP BY
    c.city
ORDER BY
    total_sales DESC,
    c.city;
