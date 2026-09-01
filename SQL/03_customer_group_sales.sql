-- Task 03: Sales and profit by customer group
-- Include only sales transactions ('իրացում').
-- Sort customer groups by total sales in descending order.

SELECT
    c.partner_group,
    SUM(td.total_amount) AS total_sales,
    SUM(td.profit) AS total_profit
FROM P_Customers c
JOIN P_Transactions t
    ON t.customer_id = c.customer_id
JOIN P_TransactionDetails td
    ON td.transaction_id = t.transaction_id
WHERE LOWER(TRIM(t.transaction_type)) = 'իրացում'
GROUP BY
    c.partner_group
ORDER BY
    total_sales DESC;
