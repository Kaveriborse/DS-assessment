/* Q1
The given query selects all rows from the table runners where the id column is not present in the result of the subquery (SELECT winner_id FROM races).

The subquery (SELECT winner_id FROM races) retrieves all winner_id values from the races table. Then, the main query selects all rows from the runners table where the id
  column is not among the retrieved winner_id values.

The issue with this query arises if the winner_id column in the races table contains NULL values. If any winner_id in the races table is NULL, the subquery 
  (SELECT winner_id FROM races) will return a result set that includes NULL values. In SQL, NULL comparisons with the IN operator return unknown, which means that 
  rows with NULL id values in the runners table will not be included in the result, even if they should be considered as not present in the winner_id values.
*/

/*
To avoid this issue, one alternative version of the query is to use a LEFT JOIN with a WHERE clause that filters out rows where the winner_id is not NULL:
*/
SELECT r.*
FROM runners r
LEFT JOIN races ra ON r.id = ra.winner_id
WHERE ra.winner_id IS NULL;

-- Q2
SELECT a.*
FROM test_a a
LEFT JOIN test_b b ON a.column_name = b.column_name
WHERE b.column_name IS NULL;

--Q3
SELECT user_id, lesson_id, lesson_date
FROM (
    SELECT user_id, lesson_id, lesson_date,
           ROW_NUMBER() OVER (PARTITION BY user_id, lesson_id, DATE(lesson_date) ORDER BY lesson_date DESC) AS lesson_count
    FROM lessons
) AS subquery
WHERE lesson_count > 1
ORDER BY user_id, lesson_id, lesson_date DESC;


