# BFI_DA: Movie Industry Data Analysis

## Project Overview

This project presents a comprehensive SQL-based analysis of a movie industry database. The goal is to uncover insights related to box office performance, budget efficiency, actor impact, genre trends, and audience engagement.

The analysis supports data-driven decision-making in production planning, casting, and marketing strategies for film studios and stakeholders.

---

## Objectives

- Analyze financial performance of movies against their production budgets.
- Identify high-investment films with poor audience ratings.
- Evaluate actor performance trends and their correlation with movie success.
- Study genre popularity and quality over time.
- Assess the influence of music, awards, and viewer behavior on commercial outcomes.

---

## Dataset Schema

The project utilizes the following key entities:

- **movies**: Basic movie metadata (title, genre, release year, budget, box office, rating)
- **actors**, **directors**: Industry personnel with debut year and identifiers
- **movie_actors**, **movie_directors**: Mapping tables with role or association
- **songs**: Soundtrack information linked to movies
- **reviews**: Platform-specific review scores
- **awards**: Film award wins/nominations by category and year
- **users**, **watch_history**: Viewer profiles and viewing behavior
- **production_houses**: Studio-level business information

---

## SQL Query Categories

### Basic Queries

- Movies with lower box office collection than their budget
- High-budget movies with below-average audience ratings
- Top 5 highest-grossing films
- Actors who debuted before a certain year
- Total number of songs per movie

### Intermediate Queries

- Average rating of lead actors
- Underperforming actors based on box office history
- Top 3 rated movies by release year
- Genres with the highest number of releases but lowest average ratings

### Advanced Queries

- Actors showing consistent improvement in average ratings over time
- Genres with a downward trend in ratings across years
- Correlation between the number of songs in a movie and its box office performance

---

## Key Insights

- A high budget does not guarantee commercial or critical success.
- Several genres experience frequent releases despite poor audience ratings.
- An increase in the number of songs does not significantly impact revenue.
- Actor casting decisions should be based on data, not just popularity or reputation.

---







