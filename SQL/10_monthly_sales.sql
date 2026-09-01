-- Task 10: Monthly sales and profit
-- Include only sales transactions ('իրացում').
-- Group by year and month and sort chronologically.

SELECT
    TO_CHAR(t.transaction_date, 'YYYY-MM') AS sales_month,
    SUM(td.total_amount) AS total_sales,
    SUM(td.profit) AS total_profit
FROM P_Transactions t
JOIN P_TransactionDetails td
    ON td.transaction_id = t.transaction_id
WHERE LOWER(TRIM(t.transaction_type)) = 'իրացում'
GROUP BY
    TO_CHAR(t.transaction_date, 'YYYY-MM')
ORDER BY
    sales_month;
