

SELECT
    product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';
-- ✅ Correct! Your query accurately filters the products based on both criteria.
-- Time Complexity: O(N) where N is the number of rows in the Products table (Full table scan).
-- Space Complexity: O(1) as we are only returning the filtered IDs.
-- This is the optimal approach for this problem. You can now click the "Submit" button!
-- Tip: To sync this to GitHub, you can use the Auto-Sync feature or click the Git icon in the toolbar.

-- Synced seamlessly with LeetHub Pro
-- Pro features: https://bit.ly/leethubpro | Free version: https://bit.ly/leethubv4
-- Get it here: https://chromewebstore.google.com/detail/bcilpkkbokcopmabingnndookdogmbna