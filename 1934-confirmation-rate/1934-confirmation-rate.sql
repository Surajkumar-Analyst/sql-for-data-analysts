SELECT 
    s.user_id,
    ROUND(
        IFNULL(
            SUM(c.action = 'confirmed')/count(c.action),0
                 ),2
        ) AS confirmation_rate 
FROM Signups s
LEFT JOIN Confirmations c
    ON s.user_id = c.user_id 
GROUP BY s.user_id 

-- Synced seamlessly with LeetHub Pro
-- Pro features: https://bit.ly/leethubpro | Free version: https://bit.ly/leethubv4
-- Get it here: https://chromewebstore.google.com/detail/bcilpkkbokcopmabingnndookdogmbna