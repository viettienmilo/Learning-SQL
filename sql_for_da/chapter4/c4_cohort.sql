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