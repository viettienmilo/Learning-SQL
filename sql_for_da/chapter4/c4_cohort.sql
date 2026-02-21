USE sql_da;
-- create tables
DROP TABLE IF EXISTS legislators;
CREATE TABLE legislators (
    full_name varchar(256),
    first_name varchar(256),
    last_name varchar(256),
    middle_name varchar(256),
    nickname varchar(256),
    suffix varchar(256),
    other_names_end date,
    other_names_middle varchar(256),
    other_names_last varchar(256),
    birthday date,
    gender varchar(256),
    id_bioguide varchar(256) PRIMARY KEY,
    id_bioguide_previous_0 varchar(256),
    id_govtrack int,
    id_icpsr int,
    id_wikipedia varchar(256),
    id_wikidata varchar(256),
    id_google_entity_id varchar(256),
    id_house_history bigint,
    id_house_history_alternate int,
    id_thomas int,
    id_cspan int,
    id_votesmart int,
    id_lis varchar(256),
    id_ballotpedia varchar(256),
    id_opensecrets varchar(256),
    id_fec_0 varchar(256),
    id_fec_1 varchar(256),
    id_fec_2 varchar(256)
);
DROP TABLE IF EXISTS legislators_terms;
CREATE TABLE legislators_terms (
    id_bioguide varchar(256),
    term_number int,
    term_id varchar(256) PRIMARY KEY,
    term_type varchar(256),
    term_start date,
    term_end date,
    state varchar(256),
    district int,
    class int,
    party varchar(256),
    how varchar(256),
    url varchar(256),
    address varchar(256),
    phone varchar(256),
    fax varchar(256),
    contact_form varchar(256),
    office varchar(256),
    state_rank varchar(256),
    rss_url varchar(256),
    caucus varchar(256)
);
-- test data
SELECT *
FROM legislators
LIMIT 10;
SELECT COUNT(*)
FROM legislators;
SELECT *
FROM legislators_terms
LIMIT 10;
SELECT COUNT(*)
FROM legislators_terms;
/*
 Basic retention analysis
 */
-- find the first date for each legis took office
SELECT id_bioguide,
    MIN(term_start) AS first_term
FROM legislators_terms
GROUP BY 1;
-- calculate years of each legis retain in office
SELECT TIMESTAMPDIFF(YEAR, a.first_term, b.term_start) AS period,
    COUNT(DISTINCT a.id_bioguide) as cohort_retained
FROM (
        SELECT id_bioguide,
            MIN(term_start) AS first_term
        FROM legislators_terms
        GROUP BY 1
    ) AS a
    INNER JOIN legislators_terms b ON a.id_bioguide = b.id_bioguide
GROUP BY 1;
-- calculate the percentage of cohort_retained per total cohort
-- (total cohort = value of period 0)
-- (result in file c4_plot_1.csv)
SELECT period,
    cohort_retained,
    (
        cohort_retained / FIRST_VALUE(cohort_retained) OVER (
            ORDER BY period
        )
    ) * 100 AS pct_retained
FROM (
        SELECT TIMESTAMPDIFF(YEAR, a.first_term, b.term_start) AS period,
            COUNT(DISTINCT a.id_bioguide) as cohort_retained
        FROM (
                SELECT id_bioguide,
                    MIN(term_start) AS first_term
                FROM legislators_terms
                GROUP BY 1
            ) AS a
            INNER JOIN legislators_terms b ON a.id_bioguide = b.id_bioguide
        GROUP BY 1
    ) AS T;
/*
 Increase accuracy by Adjusting timeseries
 */
SELECT *
FROM legislators_terms
WHERE id_bioguide = 'A000002';