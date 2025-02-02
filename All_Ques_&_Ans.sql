-- Q.1 What were the top 10 movies according to IMDB score?
SELECT 
    id,
    title,
    imdb_score
FROM 
    titles
WHERE
 type = 'MOVIE' AND imdb_score IS NOT NULL
ORDER BY 
    imdb_score DESC
LIMIT 10;

-- Q.2 What were the top 10 shows according to IMDB score?

SELECT 
    id,
    title,
    imdb_score
FROM 
    titles
WHERE 
    type = 'SHOW' AND imdb_score IS NOT NULL
ORDER BY 
    imdb_score DESC, imdb_votes DESC
LIMIT 10;

-- Q.3 What were the bottom 10 movies according to IMDB score?
SELECT 
    id,
    title,
    imdb_score
FROM 
    titles
WHERE 
    type = 'MOVIE' AND imdb_score IS NOT NULL
ORDER BY 
    imdb_score ASC
LIMIT 10;



-- Q. 4 What were the bottom 10 shows according to IMDB score?

SELECT 
    id,
    title,
    imdb_score
FROM 
    titles
WHERE 
    type = 'SHOW' AND imdb_score IS NOT NULL
ORDER BY 
    imdb_score ASC
LIMIT 10;



--What were the average IMDB and TMDB scores for shows and movies?

SELECT
    type,
    AVG(imdb_score) AS avg_imdb_score,
    AVG(tmdb_score) AS avg_tmdb_score
FROM 
    titles
WHERE 
    imdb_score IS NOT NULL AND tmdb_score IS NOT NULL
GROUP BY 
    type;




--Count of movies and shows in each decade

SELECT 
    (EXTRACT(YEAR FROM TO_DATE(CAST(release_year AS TEXT), 'YYYY')) / 10 * 10) AS decade,
    type,
    COUNT(*) AS count
FROM 
    titles
WHERE 
    release_year IS NOT NULL
GROUP BY 
    decade, type
ORDER BY 
    decade, type;





--What were the average IMDB and TMDB scores for each production country?

SELECT
    unnest(production_countries) AS country,
    AVG(imdb_score) AS avg_imdb_score,
    AVG(tmdb_score) AS avg_tmdb_score
FROM
    titles
WHERE
    imdb_score IS NOT NULL AND tmdb_score IS NOT NULL
GROUP BY
    country
ORDER BY
    avg_imdb_score DESC, avg_tmdb_score DESC;



--What were the average IMDB and TMDB scores for each age certification for shows and movies?
SELECT
    age_certification,
    AVG(imdb_score) AS avg_imdb_score,
    AVG(tmdb_score) AS avg_tmdb_score
FROM
    titles
WHERE
    imdb_score IS NOT NULL AND tmdb_score IS NOT NULL and age_certification is not null
GROUP BY
    age_certification
ORDER BY
    avg_imdb_score DESC, avg_tmdb_score DESC;


--What were the 5 most common age certifications for movies?
SELECT
    age_certification,
    COUNT(*) AS count
FROM
    titles
WHERE
    type = 'MOVIE' AND age_certification IS NOT NULL
GROUP BY
    age_certification
ORDER BY
    count DESC
LIMIT 5;


--Who were the top 20 actors that appeared the most in movies/shows?
SELECT
    name,
    COUNT(*) AS appearance_count
FROM
    credits
WHERE
    role = 'ACTOR'  -- Filters only for actor roles
GROUP BY
    name
ORDER BY
    appearance_count DESC
LIMIT 20;



--Who were the top 20 directors that directed the most movies/shows?
SELECT
    name,
    COUNT(*) AS directed_count
FROM
    credits
WHERE
    role = 'DIRECTOR'  -- Filters only for director roles
GROUP BY
    name
ORDER BY
    directed_count DESC
LIMIT 20;


--Calculating the average runtime of movies and TV shows separately
SELECT
    type,
    AVG(runtime) AS avg_runtime
FROM
    titles
WHERE
    runtime IS NOT NULL
GROUP BY
    type
ORDER BY
    avg_runtime DESC;


--Finding the titles and directors of movies released on or after 2010
SELECT
    t.title,
    c.name AS director
FROM
    titles t
JOIN
    credits c ON t.id = c.id
WHERE
    t.release_year >= 2010
    AND c.role = 'DIRECTOR'
ORDER BY
    t.release_year DESC;




--Which shows on Netflix have the most seasons?
SELECT
    title,
    seasons
FROM
    titles
WHERE
    type = 'SHOW'
    AND production_countries is not null  
ORDER BY
    seasons DESC
LIMIT 10;





--Which genres had the most movies?
SELECT
    genres,
    COUNT(*) AS movie_count
FROM
    titles,
    unnest(genres) AS genre
WHERE
    type = 'MOVIE'
GROUP BY
    genres
ORDER BY
    movie_count DESC
LIMIT 10;



--Which genres had the most shows?
SELECT
    genres,
    COUNT(*) AS show_count
FROM
    titles,
    unnest(genres) AS genre
WHERE
    type = 'SHOW'
GROUP BY
    genres
ORDER BY
    show_count DESC
LIMIT 10;


--Titles and Directors of movies with high IMDB scores (>7.5) and high TMDB popularity scores (>80)
SELECT
    t.title,
    c.name AS director
FROM
    titles t
JOIN
    credits c ON t.id = c.id
WHERE
    t.type = 'MOVIE'
    AND t.imdb_score > 7.5
    AND t.tmdb_popularity > 80
    AND c.role = 'DIRECTOR'
ORDER BY
    t.imdb_score DESC, t.tmdb_popularity DESC;

--What were the total number of titles for each year?

SELECT
    release_year,
    COUNT(*) AS total_titles
FROM
    titles
GROUP BY
    release_year
ORDER BY
    release_year DESC;


--Actors who have starred in the most highly rated movies or shows

SELECT
    c.name AS actor,
    COUNT(*) AS high_rated_titles
FROM
    titles t
JOIN
    credits c ON t.id = c.id
WHERE
    t.imdb_score > 7.5
    AND (t.type = 'MOVIE' OR t.type = 'SHOW')  -- Adjust if you want to include only one type
    AND c.role = 'ACTOR'
GROUP BY
    c.name
ORDER BY
    high_rated_titles DESC
LIMIT 10;






--Which actors/actresses played the same character in multiple movies or TV shows?

SELECT
    c.name AS actor,
    c.character AS character,
    COUNT(*) AS title_count
FROM
    credits c
JOIN
    titles t ON c.id = t.id
WHERE
    c.character IS NOT NULL
    AND (t.type = 'MOVIE' OR t.type = 'SHOW')  -- Adjust to include either MOVIE or SHOW
GROUP BY
    c.name, c.character
HAVING
    COUNT(*) > 1
ORDER BY
    title_count DESC;





--What were the top 3 most common genres?

SELECT
    unnest(t.genres) AS genre,
    COUNT(*) AS genre_count
FROM
    titles t
WHERE
    t.genres IS NOT NULL
GROUP BY
    genre
ORDER BY
    genre_count DESC
LIMIT 3;



--Average IMDB score for leading actors/actresses in movies or shows

SELECT
    c.name AS actor,
    AVG(t.imdb_score) AS avg_imdb_score
FROM
    credits c
JOIN
    titles t ON c.id = t.id
WHERE
    c.role IN ('ACTOR', 'LEAD')  -- Adjust role as per your data (could be 'LEAD', 'ACTOR', etc.)
    AND t.imdb_score IS NOT NULL
GROUP BY
    c.name
ORDER BY
    avg_imdb_score DESC;






--Which movies or shows had the highest number of votes?
SELECT
    t.id AS title_id,
    t.title AS title_name,
    t.imdb_votes AS vote_count
FROM
    titles t
WHERE
    t.imdb_votes IS NOT NULL
ORDER BY
    t.imdb_votes DESC
LIMIT 10;



--Which movies or shows had the longest runtime?
SELECT
    t.id AS title_id,
    t.title AS title_name,
    t.runtime AS runtime_minutes
FROM
    titles t
WHERE
    t.runtime IS NOT NULL
ORDER BY
    t.runtime DESC
LIMIT 10;



--What were the top 5 most popular genres for movies?
SELECT
    unnest(t.genres) AS genre,
    COUNT(*) AS genre_count
FROM
    titles t
WHERE
    t.type = 'MOVIE' 
    AND t.genres IS NOT NULL
GROUP BY
    genre
ORDER BY
    genre_count DESC
LIMIT 5;





--How many movies or shows were released each year?

SELECT
    t.release_year,
    COUNT(*) AS titles_count
FROM
    titles t
WHERE
    t.release_year IS NOT NULL
GROUP BY
    t.release_year
ORDER BY
    t.release_year DESC;





--Which actors appeared in the most genres?
SELECT
    a.name AS actor_name,
    COUNT(DISTINCT g.genre) AS genre_count
FROM
    credits a
JOIN
    titles t ON t.id = a.id
JOIN LATERAL
    unnest(t.genres) AS g(genre) ON TRUE
WHERE
    t.genres IS NOT NULL
GROUP BY
    a.name
ORDER BY
    genre_count DESC
LIMIT 10;







--Which production countries have the highest number of movies or shows?

SELECT
    unnest(t.production_countries) AS production_country,
    COUNT(*) AS movie_count
FROM
    titles t
WHERE
    t.production_countries IS NOT NULL
GROUP BY
    production_country
ORDER BY
    movie_count DESC
LIMIT 10;



--Which actors name have the highest average rating across all their movies/shows?
SELECT
    c.name AS actor_name,
    AVG(t.imdb_score) AS average_imdb_score
FROM
    credits c
JOIN
    titles t ON t.id = c.id  -- Assuming 'id' links the credits to titles
WHERE
    t.imdb_score IS NOT NULL  -- Make sure to only include movies/shows with an IMDb score
GROUP BY
    c.name
ORDER BY
    average_imdb_score DESC
LIMIT 1;  -- Only the top actor





--Which shows had the most seasons?
SELECT
    title,
    seasons
FROM
    titles
WHERE
    seasons IS NOT NULL  
ORDER BY
    seasons DESC
LIMIT 1;  


------------------Which movies had the highest box office revenue?

SELECT
    title,
    tmdb_popularity
FROM
    titles
WHERE
    type = 'MOVIE' 
ORDER BY
    tmdb_popularity DESC
LIMIT 10;



--Which directors have worked on the most movies or shows?
SELECT
    c.name AS director_name,
    COUNT(*) AS number_of_titles
FROM
    credits c
JOIN
    titles t ON t.id = c.id  -- Joining using the 'id' column from credits and titles
WHERE
    c.role = 'DIRECTOR'  -- Filters for directors only
GROUP BY
    c.name
ORDER BY
    number_of_titles DESC  -- Orders by the highest count first
LIMIT 1;  -- Returns the director with the most titles



--What are the most common keywords or phrases in movie titles?

WITH title_words AS (
    SELECT
        unnest(string_to_array(lower(t.title), ' ')) AS word
    FROM
        titles t
)
SELECT
    word,
    COUNT(*) AS word_count
FROM
    title_words
GROUP BY
    word
ORDER BY
    word_count DESC
LIMIT 10;  -- Adjust to get more or fewer keywords






--Which actors or actresses have the most frequent collaborations with the same director?

WITH director_actor_collaborations AS (
    SELECT
        c1.name AS director_name,
        c2.name AS actor_name,
        COUNT(*) AS collaboration_count
    FROM
        credits c1
    JOIN
        credits c2 ON c1.id = c2.id  -- Joining on the same title (using 'id' as 'title_id')
    WHERE
        c1.role = 'DIRECTOR'  -- Only directors in the first table
        AND c2.role = 'ACTOR'  -- Only actors in the second table
    GROUP BY
        c1.name, c2.name  -- Grouping by director and actor
)
SELECT
    director_name,
    actor_name,
    collaboration_count
FROM
    director_actor_collaborations
ORDER BY
    collaboration_count DESC
LIMIT 10;  -- Adjust this to see more or fewer top collaborations





--What were the most common movie ratings (IMDB scores) for movies released in a particular decade?

SELECT
    (release_year / 10) * 10 AS decade,
    imdb_score,
    COUNT(*) AS score_count
FROM
    titles
WHERE
    release_year BETWEEN 1900 AND 2020  -- Adjust the range of years if needed
GROUP BY
    decade, imdb_score
ORDER BY
    decade DESC, score_count DESC
LIMIT 10;  -- Adjust the limit based on how many top scores you want to display


--Which movies or shows had the highest popularity score on TMDB?

SELECT
    title,
    tmdb_popularity
FROM
    titles
ORDER BY
    tmdb_popularity is not null DESC
LIMIT 10;  -- Adjust the limit as needed to get the top 10 or more titles







--How many actors or actresses have starred in both movies and TV shows?

SELECT
    c.name AS actor_name,
    COUNT(DISTINCT t.type) AS genres_count  -- Count of distinct types (MOVIE or SHOW)
FROM
    credits c
JOIN
    titles t ON t.id = c.id  -- Using c.id as the reference
WHERE
    c.role = 'ACTOR'  -- Only considering actors
    AND t.type IN ('MOVIE', 'SHOW')  -- Considering both movies and shows
GROUP BY
    c.name
HAVING
    COUNT(DISTINCT t.type) = 2  -- Actor must have appeared in both movie and show
ORDER BY
    actor_name;





















