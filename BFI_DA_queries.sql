--Q1.List all movies that have lower box office collection than their budget
SELECT title, budget_crore, box_office_collection_crore
FROM movies
WHERE box_office_collection_crore < budget_crore;

--Problem 1: Declining Box Office Performance
--Solution: Invest more in lower-budget but genre-specific content that has higher engagement, e.g. thrillers or biopics.



--Q2. List the movies which have high budget but low ratings.
SELECT title, rating, budget_crore
FROM movies
WHERE budget_crore > 100 AND rating < 6;
--Observation: High-budget movies aren't receiving good ratings.
--Solution: Redirect budget towards script quality and audience research rather than purely star power.

--Q3.Find the top 5 highest-grossing movies?
SELECT title, box_office_collection_crore AS collection
FROM movies
ORDER BY collection desc
LIMIT 5

--Q4.Show all actors who debuted before 2010
SELECT *
FROM actors
WHERE debut_year <2010

--Q5.Count the number of songs in each movie

SELECT m.title, COUNT(s.song_id) AS song_count
FROM movies m
JOIN songs s ON m.movie_id = s.movie_id
GROUP BY m.title;

SELECT * FROM movies
SELECT * FROM reviews

--MODERATE QUERIES
--Q6.Find the lead actors and average movie rating
SELECT a.name, AVG(m.rating) AS avg_movie_rating
FROM actors a
JOIN movie_actors ma ON a.actor_id = ma.actor_id
JOIN movies m ON m.movie_id = ma.movie_id
WHERE ma.role_type = 'Lead'
GROUP BY a.name
ORDER BY avg_movie_rating DESC;

--Q7. Find underperforming actors: many movies, low box office?
SELECT a.name,
COUNT(m.movie_id) AS total_movies,
AVG(m.box_office_collection_crore) AS avg_box_office
FROM actors a
JOIN movie_actors ma ON a.actor_id = ma.actor_id
JOIN movies m ON m.movie_id = ma.movie_id
GROUP BY a.name
HAVING COUNT(m.movie_id) >= 2 AND AVG(m.box_office_collection_crore) < 90;
--Observation: Some lead actors consistently underperform.
--Solution: Cast based on past performance data, not only popularity.
SELECT * FROM movies
SELECT * FROM movie_actors

--Q8. Find the top 3 highest-rated movies for each year.

WITH ranked_movies AS (
  SELECT title, release_year, rating,
         RANK() OVER (PARTITION BY release_year ORDER BY rating DESC) AS rank
  FROM movies
)
SELECT *
FROM ranked_movies
WHERE rank <= 3;

--Q9.Which genre had the highest number of releases in the last 5 years but the lowest average rating?
SELECT m.genre, COUNT(*) AS total_movies, AVG(r.review_score) AS avg_rating
FROM movies m
JOIN reviews r ON m.movie_id = r.movie_id
WHERE m.release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 5
GROUP BY m.genre
ORDER BY total_movies DESC, avg_rating ASC
LIMIT 1;
--Observation: Some genres perform poorly despite high budgets
--Solution: Invest more in genres with high ROI (Return on Investment) like biopics or comedies.

--ADVANCED QUERIES
--Q10.List actors whose average rating has increased across consecutive years.
WITH actor_yearly_rating AS (
  SELECT a.name, m.release_year, AVG(m.rating) AS avg_rating
  FROM actors a
  JOIN movie_actors ma ON a.actor_id = ma.actor_id
  JOIN movies m ON m.movie_id = ma.movie_id
  GROUP BY a.name, m.release_year
),
rating_diff AS (
  SELECT name, release_year,
         avg_rating - LAG(avg_rating) OVER (PARTITION BY name ORDER BY release_year) AS diff
  FROM actor_yearly_rating
)
SELECT name
FROM rating_diff
GROUP BY name
HAVING MIN(diff) > 0;

--Q11. Find genres where movie ratings have dropped over time consistently.
WITH genre_year_avg AS (
  SELECT genre, release_year, AVG(rating) AS avg_rating
  FROM movies
  GROUP BY genre, release_year
),
genre_drop AS (
  SELECT genre,
         avg_rating - LAG(avg_rating) OVER (PARTITION BY genre ORDER BY release_year) AS diff
  FROM genre_year_avg
)
SELECT genre
FROM genre_drop
GROUP BY genre
HAVING COUNT(*) FILTER (WHERE diff < 0) >= 3;

--Q12.Analyze if the more of songs per movie increases box office colllection.
WITH song_counts AS (
  SELECT m.release_year, COUNT(s.song_id)::FLOAT / COUNT(DISTINCT m.movie_id) AS avg_songs
  FROM movies m
  LEFT JOIN songs s ON s.movie_id = m.movie_id
  GROUP BY m.release_year
)
SELECT *
FROM song_counts
ORDER BY release_year;
--Observation: More songs don’t mean better performance. 
--Solution: Focus on quality over quantity. Promote fewer but high-impact songs.













