# DataLemur SQL Archive (~100 Questions)

A complete archive of my SQL practice across ~100 DataLemur-style interview problems.  
Organized by difficulty and written to be **easy to scan** for interview prep and reviewer evaluation.

> **Note on content:** I do **not** include DataLemur prompt text, schemas, examples, or test cases—only my summaries + SQL solutions.

---

## Table of Contents

- [Quick Navigation](#quick-navigation)
- [What this demonstrates (SQL skills)](#what-this-demonstrates-sql-skills)
  - [Query fundamentals](#query-fundamentals)
  - [Aggregations & analytics](#aggregations--analytics)
  - [Joins (including tricky interview patterns)](#joins-including-tricky-interview-patterns)
  - [Window functions](#window-functions)
  - [Time-series & growth](#time-series--growth)
  - [Hard patterns](#hard-patterns)
- [Advanced SQL concepts covered](#advanced-sql-concepts-covered)
- [How to use this repo](#how-to-use-this-repo)
  - [If you're a recruiter / interviewer](#if-youre-a-recruiter--interviewer)
  - [If you're me (review workflow)](#if-youre-me-review-workflow)
- [File format (what you’ll see at the top of each `.sql`)](#file-format-what-youll-see-at-the-top-of-each-sql)


## Quick Navigation

- **[Easy](./01_easy/000_README.md)** — Fundamentals + core patterns
- **[Medium](./02_medium/000_README.md)** — Multi-step logic + joins + windows
- **[Hard](./03_hard/000_README.md)** — Advanced analytics, streaks, retention, concurrency

---

## What this demonstrates (SQL skills)

Across these solutions, I repeatedly practiced:

### Query fundamentals
- `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`
- conditional logic with `CASE WHEN`
- correct handling of `NULL`s, duplicates, and edge cases

### Aggregations & analytics
- conditional aggregation (`COUNT(*) FILTER`, `SUM(CASE WHEN ...)`)
- percent/rate metrics, weighted averages
- cohort-style metrics and retention calculations

### Joins (including tricky interview patterns)
- `INNER`, `LEFT`, `ANTI-JOIN` patterns (`LEFT JOIN ... WHERE right IS NULL`)
- de-duplication before joining (CTEs / window ranks)

### Window functions
- `ROW_NUMBER`, `RANK`, `DENSE_RANK`
- running totals, rolling averages, moving windows
- “top-N per group” and “latest row per user” patterns

### Time-series & growth
- period-over-period comparisons (WoW / MoM / YoY)
- `LAG/LEAD`-based deltas, alignment by date/month

### Hard patterns
- sessionization / streaks (consecutive-day logic)
- “sweep line” concurrency (start/end events + running sum)
- multi-CTE pipelines with intermediate validation

## Advanced SQL concepts covered

- **Window frames:** rolling averages / moving windows (`ROWS BETWEEN ...`)
- **Ranking & tie logic:** `ROW_NUMBER` vs `RANK` vs `DENSE_RANK`
- **Top-N per group:** keep top rows per partition (with or without ties)
- **Retention/cohorts:** activation + returning-user metrics
- **Sessionization & streaks:** consecutive-day and session boundary logic
- **Concurrency:** sweep-line technique (start/+1, end/-1 → running sum)
- **Multi-step transformations:** CTE pipelines with intermediate validation
- **Anti-joins:** find entities with “no match” using `LEFT JOIN ... IS NULL`
- **Time-series comparisons:** `LAG/LEAD`, YoY/WoW deltas, month alignment
- **Data correctness:** null handling, de-duplication, numeric casting to avoid integer division

---

## How to use this repo

### If you're a recruiter / interviewer
Start here:
1. **Hard folder** for advanced patterns: concurrency, streaks, retention
2. **Medium folder** for windows + join logic
3. **Easy folder** for breadth + fundamentals

Each solution file includes:
- a short summary in my own words
- problem metadata (company, difficulty, access)
- my SQL solution

### If you're me (review workflow)
- I browse by difficulty using each folder’s `000_README.md` index.
- I revisit patterns by searching keywords:
  - `rank`, `dense_rank`, `row_number`
  - `anti join`, `left join`, `is null`
  - `lag`, `lead`, `rolling`, `yoy`, `retention`, `streak`, `session`

---

## File format (what you’ll see at the top of each `.sql`)

```sql
-- Title: ...
-- Company: ...
-- Difficulty: ...
-- Access: Free/Premium
-- Pattern: ...
-- Summary: ...
-- Notes: ...
-- Dialect: PostgreSQL
-- Followed by Solution
