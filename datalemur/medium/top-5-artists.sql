-- Question : Top 5 Artists

-- Solution
WITH song_appearnaces_list AS (

    SELECT
        artists.artist_name,
        artists.artist_id,
        DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS artist_rank
    FROM (SELECT *
          FROM global_song_rank
          WHERE rank <= 10) global_song_rank_filtered
    INNER JOIN songs
        ON global_song_rank_filtered.song_id = songs.song_id
    INNER JOIN artists 
        ON songs.artist_id = artists.artist_id
    GROUP BY artists.artist_name, artists.artist_id
    
)

SELECT 
    artist_name,
    artist_rank
FROM song_appearnaces_list
WHERE artist_rank <= 5
ORDER BY artist_rank, artist_name;