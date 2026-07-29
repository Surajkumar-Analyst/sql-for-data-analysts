SELECT 
    id,
    movie,
    description,
    rating
FROM Cinema
WHERE id % 2 = 1  
      AND description != "boring"
ORDER BY rating DESC;

-- Synced seamlessly with LeetHub Pro
-- Pro features: https://bit.ly/leethubpro | Free version: https://bit.ly/leethubv4
-- Get it here: https://chromewebstore.google.com/detail/bcilpkkbokcopmabingnndookdogmbna