-- Task 04: Returns analysis
-- Assumption: return quantities and amounts are stored as positive values.
-- Returned amounts are reported separately from sales.

-- 1. Return totals

SELECT
    COUNT(DISTINCT t.transaction_id) AS return_count,
    SUM(td.quantity) AS returned_quantity,
    SUM(td.total_amount) AS returned_amount,
    SUM(td.profit) AS returned_profit
FROM P_Transactions t
JOIN P_TransactionDetails td
    ON td.transaction_id = t.transaction_id
WHERE LOWER(TRIM(t.transaction_type)) = 'վերադարձ';


-- 2. Recorded return reasons

SELECT
    NVL(TRIM(t.comments), 'Պատճառը նշված չէ') AS return_reason,
    COUNT(DISTINCT t.transaction_id) AS return_count,
    SUM(td.quantity) AS returned_quantity,
    SUM(td.total_amount) AS returned_amount,
    SUM(td.profit) AS returned_profit
FROM P_Transactions t
JOIN P_TransactionDetails td
    ON td.transaction_id = t.transaction_id
WHERE LOWER(TRIM(t.transaction_type)) = 'վերադարձ'
GROUP BY
    NVL(TRIM(t.comments), 'Պատճառը նշված չէ')
ORDER BY
    return_count DESC,
    returned_amount DESC;


-- 3. Product returns compared with recorded sales
-- Return rate = returned quantity / sold quantity * 100.
-- A NULL rate means there is no nonzero sales denominator.

WITH product_totals AS (
    SELECT
        p.product_id,
        p.name AS product_name,
        SUM(
            CASE
                WHEN LOWER(TRIM(t.transaction_type)) = 'իրացում'
                THEN td.quantity
                ELSE 0
            END
        ) AS sold_quantity,
        SUM(
            CASE
                WHEN LOWER(TRIM(t.transaction_type)) = 'վերադարձ'
                THEN td.quantity
                ELSE 0
            END
        ) AS returned_quantity
    FROM P_Products p
    JOIN P_TransactionDetails td
        ON td.product_id = p.product_id
    JOIN P_Transactions t
        ON t.transaction_id = td.transaction_id
    GROUP BY
        p.product_id,
        p.name
)
SELECT
    product_id,
    product_name,
    sold_quantity,
    returned_quantity,
    ROUND(
        returned_quantity / NULLIF(sold_quantity, 0) * 100,
        2
    ) AS quantity_return_rate_pct
FROM product_totals
WHERE returned_quantity > 0
ORDER BY
    quantity_return_rate_pct DESC NULLS LAST,
    returned_quantity DESC;


-- 4. Customer returns compared with recorded sales
-- Amount return rate = returned amount / sales amount * 100.

WITH customer_totals AS (
    SELECT
        c.customer_id,
        c.name AS customer_name,
        c.partner_group,
        COUNT(DISTINCT
            CASE
                WHEN LOWER(TRIM(t.transaction_type)) = 'վերադարձ'
                THEN t.transaction_id
            END
        ) AS return_count,
        SUM(
            CASE
                WHEN LOWER(TRIM(t.transaction_type)) = 'իրացում'
                THEN td.total_amount
                ELSE 0
            END
        ) AS sales_amount,
        SUM(
            CASE
                WHEN LOWER(TRIM(t.transaction_type)) = 'վերադարձ'
                THEN td.total_amount
                ELSE 0
            END
        ) AS returned_amount
    FROM P_Customers c
    JOIN P_Transactions t
        ON t.customer_id = c.customer_id
    JOIN P_TransactionDetails td
        ON td.transaction_id = t.transaction_id
    GROUP BY
        c.customer_id,
        c.name,
        c.partner_group
)
SELECT
    customer_id,
    customer_name,
    partner_group,
    return_count,
    sales_amount,
    returned_amount,
    ROUND(
        returned_amount / NULLIF(sales_amount, 0) * 100,
        2
    ) AS amount_return_rate_pct
FROM customer_totals
WHERE return_count > 0
ORDER BY
    amount_return_rate_pct DESC NULLS LAST,
    returned_amount DESC;
