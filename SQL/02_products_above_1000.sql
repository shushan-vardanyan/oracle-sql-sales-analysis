-- Task 02: Products with a selling price above AMD 1,000
-- Show each distinct product and qualifying recorded price.

SELECT DISTINCT
    p.product_id,
    p.name AS product_name,
    td.selling_price
FROM P_Products p
JOIN P_TransactionDetails td
    ON td.product_id = p.product_id
WHERE td.selling_price > 1000
ORDER BY
    td.selling_price DESC,
    p.product_id;
