-- Task 01: Total sales by warehouse
-- Include warehouses with no sales and display 0.
-- Only sales transactions ('իրացում') are included.

SELECT
    w.warehouse_id,
    w.name AS warehouse_name,
    NVL(SUM(td.total_amount), 0) AS total_sales
FROM P_Warehouses w
LEFT JOIN P_Transactions t
    ON w.warehouse_id = t.warehouse_id
    AND LOWER(TRIM(t.transaction_type)) = 'իրացում'
LEFT JOIN P_TransactionDetails td
    ON t.transaction_id = td.transaction_id
GROUP BY
    w.warehouse_id,
    w.name
ORDER BY
    total_sales DESC,
    w.warehouse_id;
