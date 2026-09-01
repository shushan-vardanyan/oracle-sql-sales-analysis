-- Task 05: Top 3 products by total profit
-- Only sales transactions ('իրացում') are included.

SELECT
    p.product_id,
    p.name AS product_name,
    p.product_type,
    SUM(td.quantity) AS total_quantity_sold,
    SUM(td.profit) AS total_profit,
    ROUND(
        SUM(td.profit) /
        NULLIF(SUM(td.total_amount), 0) * 100,
        2
    ) AS profit_margin_pct
FROM P_Products p
JOIN P_TransactionDetails td
    ON td.product_id = p.product_id
JOIN P_Transactions t
    ON t.transaction_id = td.transaction_id
WHERE LOWER(TRIM(t.transaction_type)) = 'իրացում'
GROUP BY
    p.product_id,
    p.name,
    p.product_type
ORDER BY
    total_profit DESC
FETCH FIRST 3 ROWS ONLY;
