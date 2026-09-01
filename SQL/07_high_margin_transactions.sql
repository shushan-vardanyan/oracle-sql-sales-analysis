-- Task 07: High-margin sales transactions
-- Total sales amount must exceed AMD 50,000.
-- Profit margin must exceed 30%.

SELECT
    t.transaction_id,
    SUM(td.total_amount) AS total_sales_amount,
    ROUND(
        SUM(td.profit)
        / NULLIF(SUM(td.total_amount), 0) * 100,
        2
    ) AS profit_margin_pct
FROM P_Transactions t
JOIN P_TransactionDetails td
    ON td.transaction_id = t.transaction_id
WHERE LOWER(TRIM(t.transaction_type)) = 'իրացում'
GROUP BY
    t.transaction_id
HAVING SUM(td.total_amount) > 50000
    AND SUM(td.profit)
        / NULLIF(SUM(td.total_amount), 0) * 100 > 30
ORDER BY
    total_sales_amount DESC,
    t.transaction_id;
