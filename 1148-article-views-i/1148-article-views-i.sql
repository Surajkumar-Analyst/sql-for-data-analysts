# Write your MySQL query statement below
SELECT 
    DISTINCT(author_id) AS id
FROM Views
WHERE author_id  = viewer_id
ORDER BY author_id;

-- Synced seamlessly with LeetHub Pro
-- Pro features: https://bit.ly/leethubpro | Free version: https://bit.ly/leethubv4
-- Get it here: https://chromewebstore.google.com/detail/bcilpkkbokcopmabingnndookdogmbna