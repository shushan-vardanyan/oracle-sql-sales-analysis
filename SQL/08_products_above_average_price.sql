-- Task 08: Products with an average selling price
-- above the overall average recorded selling price.

SELECT
    p.product_id,
    p.name AS product_name,
    ROUND(AVG(td.selling_price), 2) AS avg_selling_price
FROM P_Products p
JOIN P_TransactionDetails td
    ON td.product_id = p.product_id
JOIN P_Transactions t
    ON t.transaction_id = td.transaction_id
WHERE LOWER(TRIM(t.transaction_type)) = 'իրացում'
GROUP BY
    p.product_id,
    p.name
HAVING AVG(td.selling_price) > (
    SELECT AVG(td2.selling_price)
    FROM P_TransactionDetails td2
    JOIN P_Transactions t2
        ON t2.transaction_id = td2.transaction_id
    WHERE LOWER(TRIM(t2.transaction_type)) = 'իրացում'
)
ORDER BY
    avg_selling_price DESC,
    p.product_id;
