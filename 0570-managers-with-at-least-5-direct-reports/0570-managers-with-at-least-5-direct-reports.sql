SELECT 
    name 
FROM Employee 
WHERE id IN (
        SELECT
            managerId 
        FROM Employee 
        GROUP BY managerId 
        HAVING COUNT(*)>= 5
)

-- Synced seamlessly with LeetHub Pro
-- Pro features: https://bit.ly/leethubpro | Free version: https://bit.ly/leethubv4
-- Get it here: https://chromewebstore.google.com/detail/bcilpkkbokcopmabingnndookdogmbna