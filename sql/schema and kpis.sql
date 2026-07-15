-- Table Schema ---

-- =========================
-- CREATING TABLE
-- =========================
CREATE TABLE IPL_Data (
    full_name VARCHAR(255),
    country VARCHAR(100),
    state_association VARCHAR(255),
    national_international VARCHAR(50),
    age INT,
    age_group VARCHAR(50),
    team_2024 VARCHAR(255),
    c_u VARCHAR(10),
    team VARCHAR(255),
    type VARCHAR(100),
    base VARCHAR(100),
    sold DECIMAL(18,2),
    category VARCHAR(100)
);

--------------------------------------------------
-- Q1) What is the total auction spend across all sold players?

SELECT SUM(Sold) AS total_auction_spend
FROM IPL_Data;

-- Q2) How many total players are there in the auction?

SELECT COUNT(*) AS total_players
FROM IPL_Data;

-- Q3) What is the average price of a player in the auction?

SELECT ROUND(AVG(Sold), 2) AS average_player_price
FROM IPL_Data;

-- Q4) What was the highest bid placed for a player in the auction?

SELECT MAX(Sold) AS highest_bid
FROM IPL_Data;

-- Q5) What is the average amount spent by each team in the auction?

SELECT ROUND(AVG(team_spend), 2) AS average_team_spend
FROM (
    SELECT Team, SUM(Sold) AS team_spend
    FROM IPL_Data
    GROUP BY Team
) AS team_totals;

-- Q6) What is the percentage distribution of Domestic and International players in the auction?

SELECT
    national_international AS player_type,
    COUNT(*) AS player_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM IPL_Data), 2) AS percentage
FROM IPL_Data
GROUP BY national_international;

-- Q7) What is the percentage distribution of Capped and Uncapped players in the auction?

SELECT
    c_u AS player_category,
    COUNT(*) AS player_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM IPL_Data), 2) AS percentage
FROM IPL_Data
GROUP BY c_u;

-- Q8) What is the distribution of players by their playing type (e.g., Batter, Bowler, All-Rounder, Wicketkeeper)?
-- Player Count

SELECT
    Type AS player_type,
    COUNT(*) AS player_count
FROM IPL_Data
GROUP BY Type
ORDER BY player_count DESC;

-- Player Percentage
SELECT
    Type AS player_type,
    COUNT(*) AS player_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM IPL_Data), 2) AS percentage
FROM IPL_Data
GROUP BY Type
ORDER BY player_count DESC;

