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
-- 12. Updating a Row and Rerunning a Full-Text Search
-- Write a MySQL query to update the "Content" column of a specific 
-- article and then perform a full-text search for the updated keyword 
-- "cloud".
UPDATE TABLE Articles
SET Content = 'cloud storage'
WHERE articleId = 1;
SELECT *
FROM Articles
WHERE MATCH(Content) AGAINST ('cloud');
-- 13. Combining Full-Text Search with Sorting by Relevance
-- Write a MySQL query to search for "cybersecurity" in the "Content" column 
-- and order the results by their relevance score.
SELECT *,
    MATCH(Content) AGAINST ('cybersecurity') AS SCORE
WHERE MATCH(Content) AGAINST ('cybersecurity')
ORDER BY SCORE DESC;
-- 14. Limiting Full-Text Search Results
-- Write a MySQL query to perform a full-text search for "innovation" in the 
-- "Content" column and limit the results to the top 10 matches.
SELECT *,
    MATCH(Content) AGAINST ('innvation') AS SCORE
WHERE MATCH(Content) AGAINST ('innvation')
ORDER BY SCORE DESC
LIMIT 10;
-- 15. Using Full-Text Search in a Subquery
-- Write a MySQL query to use a subquery that retrieves ArticleIDs matching 
-- "machine learning" and then fetch complete details for those articles.
SELECT *
FROM Articles
WHERE ArticleID IN (
        SELECT ArticleID
        FROM Articles
        WHERE MATCH(Content) AGAINST ('machine learning')
    );
-- 16. Searching for Exact Phrases Using Quoted Strings
-- Write a MySQL query to perform a full-text search for the exact phrase 
-- "data science" in the "Content" column using boolean mode.
SELECT *
FROM Articles
WHERE MATCH(Content) AGAINST ('"data science"' IN BOOLEAN MODE);
-- 17. Using Full-Text Search with a JOIN Query
-- Write a MySQL query to perform a full-text search for "blockchain" in the 
-- "Content" column of the Articles table and join with the Authors table to 
-- retrieve author details.
SELECT ar.*,
    au.AuthorName
FROM Articles ar
    INNER JOIN Authors au ON ar.AuthorID = ar.AuthorID
WHERE MATCH(ar.Content) AGAINST ('blockchain');
-- 18. Full-Text Search with Custom Stopword List Consideration
-- Write a MySQL query to perform a full-text search for "network" in the 
-- "Content" column, considering that a custom stopword list has been applied.
SELECT *
FROM Articles
WHERE MATCH (Content) AGAINST ('network');
-- 19. Full-Text Search with Column Weighting Simulation
-- Write a MySQL query to perform a full-text search for "technology" in both 
-- the "Title" and "Content" columns and simulate column weighting by comparing 
-- relevance scores.
SELECT *,
    MATCH(Content) AGAINST ('technology') AS CONTENT_MATCH_SCORE,
    MATCH(Title) AGAINST ('technology') AS TITLE_MATCH_SCORE,
    (
        MATCH(Content) AGAINST ('technology') * 2 + MATCH(Title) AGAINST ('technology')
    ) AS TOTAL_MATCH_SCORE
FROM Articles
WHERE MATCH(Content, Title) AGAINST ('technology')
ORDER BY TOTAL_MATCH_SCORE DESC;
-- 20. Paginating Full-Text Search Results
-- Write a MySQL query to perform a full-text search for "innovation" in the 
-- "Content" column and retrieve results for page 2 assuming 10 results per page.
SELECT *
FROM Articles
WHERE MATCH(Content) AGAINST ('innovation')
LIMIT 10 OFFSET 10;