-- 1. Basic Full-Text Search on a Single Column
-- Write a MySQL query to perform a basic full-text search 
-- on the "Content" column of the Articles table for the 
-- term "database".
SELECT *
FROM Articles
WHERE MATCH(Content) AGAINST('database');
-- 2. Full-Text Search on Multiple Columns
-- Write a MySQL query to search for the term "tutorial" in 
-- both the "Title" and "Content" columns of the Articles table.
SELECT *
FROM Articles
WHERE MATCH(Title, Content) AGAINST('tutorial');
-- 3. Boolean Mode Full-Text Search
-- Write a MySQL query to perform a full-text search in boolean 
-- mode on the "Content" column for the term "SQL" including 
-- the "+" operator.
SELECT *
FROM Articles
WHERE MATCH(Content) AGAINST('+SQL' IN BOOLEAN MODE);
-- 4. Full-Text Search with Relevance Ranking
-- Write a MySQL query to search for "performance" in the "Content" 
-- column and display a relevance score for each result.
SELECT *,
    MATCH(Content) AGAINST ('performance') as MATCH_SCORE
FROM Articles
WHERE MATCH(Content) AGAINST ('performance')
ORDER BY MATCH_SCORE DESC;
-- 5. Full-Text Search Using Query Expansion
-- Write a MySQL query to perform a full-text search with query 
-- expansion on the "Content" column for the term "optimization".
SELECT *,
    MATCH(Content) AGAINST ('performance' WITH QUERY EXPANSION) as MATCH_SCORE
FROM Articles
WHERE MATCH(Content) AGAINST ('optimization' WITH QUERY EXPANSION)
ORDER BY MATCH_SCORE DESC;
-- 6. Full-Text Search with a WHERE Clause Filter
-- Write a MySQL query to search for the term "security" in the 
-- "Content" column and filter results by articles published in 2024.
SELECT *
FROM Articles
WHERE MATCH(Content) AGAINST ('security')
    AND YEAR(PublishDate) = 2024;
-- 7. Full-Text Search Combined with Sorting by Date
-- Write a MySQL query to search for "innovation" in the "Content" 
-- column and order the results by the PublishDate in descending order.
SELECT *
FROM Articles
WHERE MATCH(Content) AGAINST ('innovation')
ORDER BY PublishDate DESC;
-- 8. Creating a Full-Text Index on a Single Column
-- Write a MySQL query to add a full-text index on the "Content" 
-- column of the Articles table.
ALTER TABLE Articles
ADD FULLTEXT INDEX idx_content(Content);
-- 9. Creating a Full-Text Index on Multiple Columns
-- Write a MySQL query to add a full-text index on both the "Title" and 
-- "Content" columns of the Articles table.
ALTER TABLE Articles
ADD FULLTEXT INDEX idx_title_content(Title, Content);
-- 10. Full-Text Search in Natural Language Mode
-- Write a MySQL query to search for the term "analytics" in the 
-- "Content" column using natural language mode explicitly.
SELECT *
FROM Articles
WHERE MATCH(Content) AGAINST ('analytics' IN NATURAL LANGUAGE MODE);
-- 11. Excluding Specific Terms Using Boolean Full-Text Search
-- Write a MySQL query to search for "marketing" in the "Content" 
-- column but exclude results that contain the term "advertising" 
-- using boolean operators.
SELECT *
FROM Articles
WHERE MATCH(Content) AGAINST ('+marketing -advertising' IN BOOLEAN MODE);