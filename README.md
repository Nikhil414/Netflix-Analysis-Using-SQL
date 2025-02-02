# Netflix-Analysis-Using-SQL
SQL Project

# Netflix Movies & TV Shows Analysis (SQL Project)

## Project Objective
This project aims to perform a comprehensive SQL-based analysis of movies and TV shows using IMDb and TMDb scores, genres, actors, directors, release years, runtimes, and other attributes. The analysis provides insights into content performance, trends, and key success factors.

## Dataset
The analysis is based on two datasets stored in the **netflix_data** folder:

### 1. Titles Dataset
Contains details about movies, TV shows, and other media content.
- **id**: Unique identifier for each title.
- **title**: Name of the movie/show.
- **type**: Content type (Movie/TV Show).
- **release_year**: Year of release.
- **runtime**: Duration (minutes).
- **genre**: Associated genre(s).
- **production_country**: Country of production.
- **imdb_score**: IMDb rating.
- **tmdb_popularity**: Popularity score (TMDb).
- **seasons**: Number of seasons (for TV shows).
- **age_certification**: Age rating.
- **keyword**: Keywords related to the title.

### 2. Credits Dataset
Contains information about cast and crew members.
- **title_id**: Links to the `id` in Titles Dataset.
- **actor_name**: Actor/actress name.
- **director_name**: Director name.
- **role**: Role (Actor/Director/Producer, etc.).
- **character_name**: Character played by the actor.

## Key Analytical Questions
- Top 10 movies & TV shows by IMDb score.
- Bottom 10 movies & TV shows by IMDb score.
- Average IMDb and TMDb scores for movies & shows.
- Count of movies & shows per decade.
- IMDb & TMDb scores per production country.
- IMDb & TMDb scores per age certification.
- Most common age certifications for movies.
- Top 20 most frequent actors & directors.
- Average runtime of movies & TV shows.
- Titles & directors of movies released after 2010.
- Shows with the highest number of seasons.
- Most frequent movie & TV show genres.
- Movies with high IMDb (>7.5) & TMDb (>80) scores.
- Number of titles released per year.
- Actors with the highest-rated movies/shows.
- Actors playing the same character in multiple titles.
- Most common genres & highest-rated actors.
- Longest runtime movies/shows.
- Most frequent movie ratings per decade.
- Actors appearing in multiple genres.
- Production countries with the highest number of movies/shows.
- Actors with the highest average ratings.
- Directors with the most projects.
- Most common keywords in movie titles.
- Actor-director frequent collaborations.
- Highest TMDb popularity scores.
- Actors who starred in both movies & TV shows.

## Tools & Technologies
- SQL for data extraction and analysis.
- PostgreSQL for querying structured data.
- Data visualization tools (optional).


This project helps in understanding the trends and factors contributing to successful movies and TV shows. 🚀

