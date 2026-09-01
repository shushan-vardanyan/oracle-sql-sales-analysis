-- Task 06: Warehouse performance
-- Include all warehouses, even those with no sales.
-- Count only sales transactions with detail records.
-- Average profitability is the mean of recorded detail margins.

SELECT
    w.warehouse_id,
    w.name AS warehouse_name,
    NVL(SUM(td.total_amount), 0) AS total_sales_amount,
    NVL(
        ROUND(AVG(td.profit_margin), 2),
        0
    ) AS avg_profitability,
    COUNT(DISTINCT td.transaction_id) AS sales_count,
    NVL(
        ROUND(
            SUM(td.total_amount)
            / NULLIF(COUNT(DISTINCT td.transaction_id), 0),
            2
        ),
        0
    ) AS avg_transaction_amount
FROM P_Warehouses w
LEFT JOIN P_Transactions t
    ON t.warehouse_id = w.warehouse_id
    AND LOWER(TRIM(t.transaction_type)) = 'իրացում'
LEFT JOIN P_TransactionDetails td
    ON td.transaction_id = t.transaction_id
GROUP BY
    w.warehouse_id,
    w.name
ORDER BY
    total_sales_amount DESC,
    w.warehouse_id;
