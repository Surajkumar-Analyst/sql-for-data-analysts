WITH Ranked AS (
    SELECT
        e.name,
        e.salary,
        e.departmentId,
        DENSE_RANK() OVER (
            PARTITION BY departmentId
            ORDER BY salary DESC
        ) AS salary_rank
    FROM Employee e
)

SELECT
    d.name AS Department,
    r.name AS Employee,
    r.salary AS Salary
FROM Ranked r
JOIN Department d
ON r.departmentId = d.id
WHERE salary_rank <= 3;

-- Synced seamlessly with LeetHub Pro
-- Pro features: https://bit.ly/leethubpro | Free version: https://bit.ly/leethubv4
-- Get it here: https://chromewebstore.google.com/detail/bcilpkkbokcopmabingnndookdogmbna