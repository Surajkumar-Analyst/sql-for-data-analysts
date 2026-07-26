SELECT
    v.customer_id,
    COUNT(*) AS count_no_trans
FROM Visits v
WHERE NOT EXISTS (
    SELECT 1
    FROM Transactions t
    WHERE t.visit_id = v.visit_id
)
GROUP BY v.customer_id;

-- Synced seamlessly with LeetHub Pro
-- Pro features: https://bit.ly/leethubpro | Free version: https://bit.ly/leethubv4
-- Get it here: https://chromewebstore.google.com/detail/bcilpkkbokcopmabingnndookdogmbna