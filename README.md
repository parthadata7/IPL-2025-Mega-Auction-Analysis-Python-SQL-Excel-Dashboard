# 🏏 IPL 2025 Mega Auction Analysis

## Screenshots

---

### IPL 2025 Dashboard Mega Auction
![IPL 2025 Dashboard Mega Auction](https://github.com/parthadata7/IPL-2025-Mega-Auction-Analysis-Python-SQL-Excel-Dashboard/blob/main/screenshots/dashboard.PNG)

---

## Project Overview

This project analyzes the **IPL 2025 Mega Auction** to understand how franchises build competitive squads through different spending and recruitment strategies. Using **Python (Pandas)** for data cleaning and exploratory analysis, **SQL** for business queries and KPI generation, and **Microsoft Excel** for interactive dashboards, the project uncovers patterns in player valuation, team spending, talent acquisition, and squad composition.

The objective was to transform raw auction data into actionable business insights that explain how franchises balance star players, squad depth, overseas talent, experience, and budget allocation.

---

# 🎯 Business Questions

Initial questions 
- Which team spent the most this season? 
- Capped vs uncapped player trends 
- Foreign vs domestic distribution 
- Team-wise spending strategy 
- how franciesactually build their squads?

The analysis was designed to answer the following questions:

### Budget & Spending

* Which franchise spent the most?
* Did teams invest in a few expensive players or distribute spending evenly?
* Which teams carried the highest financial concentration risk?

### Talent Acquisition

* Are experienced (capped) players worth significantly more than uncapped players?
* Do franchises prefer domestic or overseas talent?
* Which teams invest heavily in youth versus experience?

### Squad Construction

* Which player roles receive the highest investment?
* How important are retained players compared to auction purchases?
* Can franchises be classified into different recruitment strategies?

---

## Objectives

* Clean and preprocess IPL auction data.
* Perform exploratory data analysis using Pandas.
* Write SQL queries to generate business KPIs.
* Build an interactive Excel dashboard for visualization.
* Identify franchise spending and recruitment strategies.
* Generate executive-level insights from auction data.

---

## Dataset Description

The dataset contains IPL 2025 Mega Auction player information, including:

* full name
* Country
* National/International
* Age
* 2024 Team
* C/U (Capped/Uncapped)
* Team
* Type (BAT,BOWL, AR)
* Base price
* Sold price
* Category (Auctioned/Retained)

---

## Tech Stack

| Tool             | Purpose                                 |
| ---------------- | --------------------------------------- |
| Python (Pandas)  | Data cleaning, transformation, EDA      |
| SQL              | Business queries and KPI generation     |
| Microsoft Excel  | Interactive dashboard and visualization |
| Jupyter Notebook | Analysis environment                    |


---

## Project Workflow

1. Data Collection
2. Data Cleaning using Pandas
3. Exploratory Data Analysis
4. SQL Business Analysis
5. Dashboard Development in Excel
6. Business Insight Generation

---

## 📈 Dashboard Features

* Auction overview (spending, players sold, average & highest bid)
* Domestic vs Overseas player analysis
* Capped vs Uncapped player comparison
* Team-wise spending distribution
* Foreign dependency by franchise
* Squad composition by player role (BAT, BOWL, AR, WK)

---

## 📐 DAX Measures Used

| **Measure**                 | **DAX Formula**                                                                                                                                                             | **Purpose**                                           |
| --------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- |
| **Avg Team Spend**          | `Avg Team Spend = DIVIDE([Sum of Sold], DISTINCTCOUNT(Merge3[Team]))`                                                                                                       | Calculates the average auction spending per team.     |
| **Domestic Players %**      | `Domestic Players = DIVIDE(CALCULATE(COUNT(Merge3[National/International]), Merge3[National/International] = "National"), COUNT(Merge3[National/International]))`           | Returns the percentage of domestic players purchased. |
| **International Players %** | `International Players = DIVIDE(CALCULATE(COUNT(Merge3[National/International]), Merge3[National/International] = "International"), COUNT(Merge3[National/International]))` | Returns the percentage of overseas players purchased. |
| **Capped Players %**        | `Capped Players = DIVIDE(CALCULATE(COUNT(Merge3[C/U]), Merge3[C/U] = "Capped"), COUNT(Merge3[C/U]))`                                                                        | Calculates the percentage of capped players.          |
| **Uncapped Players %**      | `Uncapped Players = DIVIDE(CALCULATE(COUNT(Merge3[C/U]), Merge3[C/U] = "Uncapped"), COUNT(Merge3[C/U]))`                                                                    | Calculates the percentage of uncapped players.        |
| **Median Price**            | `Median Price = MEDIAN(Merge3[Sold])`                                                                                                                                       | Returns the median auction price of sold players.     |


---

## 🧠 Key Insights

* **PBKS** spent the most, while **KKR** spent the least.
* **68.28%** of players bought were domestic; **31.72%** were overseas.
* Teams invested more in **capped players** than uncapped players.
* Most franchises maintained a balanced domestic-overseas squad.
* Spending patterns show different squad-building strategies, with varying focus on batters, bowlers, all-rounders, and wicketkeepers.

---

# SQL 

## Schema Design

```sql
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
```

---

## Q1) What is the total auction spend across all sold players?

```sql
SELECT SUM(Sold) AS total_auction_spend
FROM IPL_Data;
```

**Output:** 1,182.1 Cr

---

## Q2) How many total players are there in the auction? 

```sql
SELECT COUNT(*) AS total_players
FROM IPL_Data;
```

**Output:**  227

---

## Q3) What is the average price of a player in the auction?

```sql
SELECT ROUND(AVG(Sold), 2) AS average_player_price
FROM IPL_Data;
```

**Output:** ₹5.21 Cr

---

## Q4) What was the highest bid placed for a player in the auction?

```sql
SELECT MAX(Sold) AS highest_bid
FROM IPL_Data;
```

**Output:** ₹27 Cr

---

## Q5) What is the average amount spent by each team in the auction?

```sql
SELECT ROUND(AVG(team_spend), 2) AS average_team_spend
FROM (
    SELECT Team, SUM(Sold) AS team_spend
    FROM IPL_Data
    GROUP BY Team
) AS team_totals;
```

**Output:**  ₹118.21 Cr

---

## Q6) What is the percentage distribution of Domestic and International players in the auction?

```sql
SELECT
    national_international AS player_type,
    COUNT(*) AS player_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM IPL_Data), 2) AS percentage
FROM IPL_Data
GROUP BY national_international;
```

**Output:** Domestic Players: 68.28%, International Players: 31.72%

---

## Q7) What is the percentage distribution of Capped and Uncapped players in the auction?

```sql
SELECT
    c_u AS player_category,
    COUNT(*) AS player_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM IPL_Data), 2) AS percentage
FROM IPL_Data
GROUP BY c_u;
```

**Output:** Capped Players: 58.15%, Uncapped Players: 41.85%

---

### Key Performance Indicators

| KPI                   | Value       |
| --------------------- | ----------- |
| Total Auction Spend   | ₹1,182.1 Cr |
| Players Sold          | 227         |
| Average Player Price  | ₹5.21 Cr    |
| Highest Bid           | ₹27 Cr      |
| Average Team Spend    | ₹118.21 Cr  |
| Domestic Players      | 68.28%      |
| International Players | 31.72%      |
| Capped Players        | 58.15%      |
| Uncapped Players      | 41.85%      |

**Key SQL Insight**

The auction demonstrated a clear preference for experienced domestic talent. Bowlers were the most frequently purchased role, while overall spending remained highly competitive, with franchises spending nearly their full available budgets.

---

# Python (Pandas) Analysis

The exploratory analysis focused on understanding franchise auction strategies and identifying patterns in spending behavior.

---

## Team-wise Total Spending

###Total Spend by Team

![Total Spend by Team]([1a](https://github.com/parthadata7/IPL-2025-Mega-Auction-Analysis-Python-SQL-Excel-Dashboard/blob/main/screenshots/charts/1a.png))

### Insights

**CSK** was the highest spender (**119.95 Cr**), closely followed by **GT (119.85 Cr)** and **SRH/MI (119.80 Cr)**. **KKR** spent the least (**107.95 Cr**), suggesting a more conservative auction strategy.

### Spending Concentration

![Spending Concentration]([1b](https://github.com/parthadata7/IPL-2025-Mega-Auction-Analysis-Python-SQL-Excel-Dashboard/blob/main/screenshots/charts/1b.png))

### Insights

PBKS showed the highest spending concentration, investing 52.4% of its total budget in just three players, followed by LSG (49.3%). On the other hand, DC (37.5%) and RCB (37.7%) spread their budget more evenly across the squad, reducing reliance on a few marquee signings.

---

## Experience Analysis

### Team Preferences: Which teams rely more on capped players and which teams actively invest in uncapped talent?

![Team Preferences](https://github.com/parthadata7/IPL-2025-Mega-Auction-Analysis-Python-SQL-Excel-Dashboard/blob/main/screenshots/charts/2a.png)

### Insights

Recruitment strategies varied across franchises. LSG (47.8% capped; 52.2% uncapped) and PBKS (48.0% capped; 52.0% uncapped) maintained relatively balanced squads with a slight preference for uncapped players. In contrast, KKR (71.4% capped), SRH (65.0% capped), and RCB (63.6% capped) allocated a substantially higher proportion of their squads to capped players, reflecting a greater emphasis on experienced talent while complementing their rosters with a smaller share of emerging uncapped players.

### Overall Business Insight

The auction data shows that IPL franchises prioritize quality over quantity when investing in experienced players. Despite uncapped players representing a substantial portion of squad selections, 89% of the total auction spending (₹1,052.1 Cr) was directed toward capped players.

---

## Domestic vs Overseas Analysis

### Budget Allocation: How much auction money was invested in domestic vs overseas players?

![Budget Allocation](https://github.com/parthadata7/IPL-2025-Mega-Auction-Analysis-Python-SQL-Excel-Dashboard/blob/main/screenshots/charts/3a.png)

### Insights

Franchises invested ₹774.35 Cr (65.5%) in domestic players compared to ₹407.75 Cr (34.5%) in overseas players. The majority of auction spending was directed toward Indian talent, highlighting that domestic players remain the primary long-term investment for team construction.

### Foreign Player Dependency

![Foreign Player Dependency](https://github.com/parthadata7/IPL-2025-Mega-Auction-Analysis-Python-SQL-Excel-Dashboard/blob/main/screenshots/charts/3b.png)

### Insights

SRH showed the highest reliance on overseas talent, allocating 50.4% of its auction budget to international players. In contrast, MI had the lowest foreign dependency at 22.8%, investing nearly four-fifths of its budget in domestic talent. This indicates considerable variation in team-building strategies across franchises.
---

## Squad Building Strategy

### Squad Balance (Role Investment) : Which skill areas received the highest investment?

![Squad Balance](https://github.com/parthadata7/IPL-2025-Mega-Auction-Analysis-Python-SQL-Excel-Dashboard/blob/main/screenshots/charts/4a.png)

### Insights
Franchises clearly prioritized different skill sets based on their team-building philosophy. CSK (₹54.55 Cr) and KKR (₹54.15 Cr) invested most heavily in all-rounders, emphasizing squad flexibility. LSG (₹58.85 Cr) and RCB (₹56.80 Cr) focused primarily on specialist batters, while GT (₹55.55 Cr) and MI (₹47.45 Cr) allocated the largest share of their budgets to bowlers, strengthening their bowling attack. SRH adopted a batting and all-rounder-focused strategy, spending ₹52.35 Cr on batters and ₹47.75 Cr on all-rounders while investing only ₹19.70 Cr in bowlers.

# Overall Team Strategy Classification

| Team     | Strategy                     | Evidence                                                                                                                            |
| -------- | ---------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| **CSK**  | Balanced                     | Large squad (25 players), moderate average price, high all-rounder investment, moderate budget concentration (59.2%).               |
| **DC**   | Balanced / Value-based       | Lowest budget concentration (56.8%), low CV (1.06), balanced spending across batting and bowling.                                   |
| **GT**   | Overseas-leaning             | Highest overseas spending after SRH (₹52.25 Cr), major investment in bowlers, moderate concentration.                               |
| **KKR**  | Star-focused                 | 67.4% of budget spent on top five players with heavy all-rounder investment.                                                        |
| **LSG**  | Star-focused                 | High budget concentration (66.7%), second-highest CV (1.35), batting-centric investment.                                            |
| **MI**   | Domestic-heavy               | Lowest overseas spending (₹27.35 Cr), significant investment in capped domestic players despite high concentration.                 |
| **PBKS** | Youth-focused + Star-focused | Highest CV (1.41), highest top-five concentration (67.5%), and largest uncapped investment (₹24.85 Cr).                             |
| **RCB**  | Balanced                     | Lowest CV (1.02), lowest top-five concentration (56.2%), strong batting investment spread across the squad.                         |
| **RR**   | Balanced                     | Low CV (1.04), premium average player price, balanced spending across all three roles.                                              |
| **SRH**  | Overseas-heavy               | Highest overseas spending (₹60.35 Cr), highest average player price (₹5.99 Cr), and premium investment in batting and all-rounders. |

---

### Retained vs Auctioned (core stability)

![Retained vs Auctioned](https://github.com/parthadata7/IPL-2025-Mega-Auction-Analysis-Python-SQL-Excel-Dashboard/blob/main/screenshots/charts/4b.png)

### Insights

**Team-wise Recruitment Strategy Narratives**

**CSK** — All-rounder-led model: 45.5% of purse on all-rounders, only 5 retained players but they absorb 54.2% of spend — a small, expensive core surrounded by cheaper auction fill-ins. Balanced age spread, no clear youth or veteran bias.

**DC** — Rebuild mode: 62.5% of spend came via auction (only 4 retentions), bowling-heavy (40.1% spend) and skewed toward 30-35 age band (45.5% of spend) — buying ready-now bowling experience rather than building youth.

**GT** — Bowling-first, auction-built squad: 46.3% spend on bowlers, 57.4% via auction. Heavy bet on 25-30 age group (58.3% of spend) — peak-career batting/all-round talent, not high-risk youth.

**KKR** — All-rounder-anchored (50.2% spend, highest among all teams) with retention-heavy core (52.8% spend on just 6 retained players) and a tilt to 30-35 experience (43.9%) — title-defense, experience-over-youth strategy.

**LSG** — Batting-heavy (49.2% spend) built almost entirely through auction (57.4%), concentrated in 25-30 age group (55.7%) — also the most star-dependent squad: top 2 buys eat 40.1% of total purse, signalling reliance on a couple of marquee picks.

**MI** — Most retention-stable franchise: 62.6% of spend locked in just 5 retained players, lowest international spend share (22.8%) — domestic-core, bowling-tilted (39.6%) team betting on experienced (30-35 & Above-35 combine to 77.4%) talent, prioritizing continuity over auction gambles.

**PBKS** — Almost a fresh build: 92.1% of spend via auction (only 2 retained players, 7.9% spend) — by far the most auction-dependent franchise. Balanced Bat/Bowl/AR split (~32-36% each) but skewed to 30-35 experience (46.9%) and second-highest star concentration (37.4% on top 2 buys) — high-risk, high-reinvestment strategy.

**RCB** — Batting-first identity (47.6% spend, highest among all), majority via auction (69%), concentrated in 30-35 prime-batting years (44.9%) — clear strategy: buy proven middle-order/top-order bats at auction.

**RR** — Retention-core team (66% spend on 6 retained), lowest all-rounder count (4 players, smallest depth) but balanced age spread (~32-34% across 20-25/25-30/30-35) — a young, retained-core, less reliant on overseas (30.6%) strategy.

**SRH** — International-bowling/overseas-leaning team (50.4% spend — highest overseas share of any team), batting-led spend (43.7%) skewed to 30-35 group (58.1%, highest concentration in this band) — clear "experienced batting core + overseas firepower" model.


---

# 🎯 Executive Summary

The analysis demonstrates that IPL franchises do not simply spend money differently—they build teams differently.

Three major strategic patterns emerged:

* **Retention-driven franchises** prioritized continuity and experienced cores.
* **Auction-dependent franchises** accepted greater financial risk by concentrating spending on marquee signings.
* **Role-specialist franchises** deliberately invested in batting, bowling, or all-rounders based on their competitive philosophy.

Despite nearly identical auction budgets, franchises adopted distinct approaches to balancing immediate performance, squad depth, financial concentration, and long-term sustainability.

Ultimately, successful squad construction is not determined by **how much** a franchise spends, but **how intelligently** it allocates its resources.

---

## Conclusion

The IPL auction is not driven by a single winning strategy. Instead, franchises follow distinct squad-building philosophies shaped by spending concentration, player experience, role specialization, retention strategy, and domestic versus overseas investment. These insights demonstrate how data analysis can uncover strategic decision-making beyond simple auction expenditure and provide a business perspective on team construction.

---

## Project Structure

```text
├── data/
│   ├──raw_data.xlsx
│   ├──sold_players.xlsx
│   ├──finsal_data.xlsx
│   └──finsal_data_with_dashboard.xlsx
├── screenshots/
│   ├──assets
│   ├──charts
│   ├──dashboard.png
├── panda
│   ├──01_Data_understanding_and_cleaning.ipynb
│   ├──02_Which_team_spent_the_most.ipynb
│   ├──03_Capped_vs_Uncapped_Player_Trends.ipynb
│   ├──04_Foreign_vs_Domestic_Distribution.ipynb
│   ├──05_Most_Expensive_Player_Role.ipynb
│   ├──06_Team-wise_Spending_Strategy.ipynb
│   └──07_How_franchises_actually_build_their_squads.ipynb
├── SQL
│   └──schema_and_kpis.sql
└── README.md
```

---

## Contact

**Name:** Partha Pratim Das

**Email:** [parthadataanalyst@gmail.com](mailto:parthadataanalyst@gmail.com)

**LinkedIn:** []()

**Portfolio:** []()

**GitHub:** []()
