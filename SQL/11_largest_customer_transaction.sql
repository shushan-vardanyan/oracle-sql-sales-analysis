-- Task 11: Each customer's largest sales transaction
-- Include only sales transactions ('իրացում').
-- For equal amounts, select the most recent transaction,
-- then the transaction with the highest ID.

WITH transaction_totals AS (
    SELECT
        c.customer_id,
        c.name AS customer_name,
        t.transaction_id,
        t.transaction_date,
        SUM(td.total_amount) AS transaction_total
    FROM P_Customers c
    JOIN P_Transactions t
        ON t.customer_id = c.customer_id
    JOIN P_TransactionDetails td
        ON td.transaction_id = t.transaction_id
    WHERE LOWER(TRIM(t.transaction_type)) = 'իրացում'
    GROUP BY
        c.customer_id,
        c.name,
        t.transaction_id,
        t.transaction_date
),
ranked_transactions AS (
    SELECT
        customer_id,
        customer_name,
        transaction_id,
        transaction_date,
        transaction_total,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY
                transaction_total DESC NULLS LAST,
                transaction_date DESC NULLS LAST,
                transaction_id DESC
        ) AS rn
    FROM transaction_totals
)
SELECT
    customer_id,
    customer_name,
    transaction_id,
    transaction_date,
    transaction_total
FROM ranked_transactions
WHERE rn = 1
ORDER BY
    transaction_total DESC NULLS LAST,
    customer_id;
