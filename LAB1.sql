CREATE DATABASE CSE_4B_427



--Part – A 



--1. Retrieve a unique genre of songs. 
SELECT DISTINCT GENRE 
FROM SONGS

--2. Find top 2 albums released before 2010. 
SELECT TOP 2 ALBUM_TITLE 
FROM ALBUMS 
WHERE RELEASE_YEAR > 2010;

--3. Insert Data into the Songs Table. (1245, ‘Zaroor’, 2.55, ‘Feel good’, 1005) 
INSERT INTO SONGS (SONG_ID, SONG_TITLE, DURATION, GENRE, ALBUM_ID) VALUES (1245, 'ZAROOR', 2.55, 'FEEL GOOD', 1005);
SELECT * FROM SONGS

--4. Change the Genre of the song ‘Zaroor’ to ‘Happy’ 
UPDATE SONGS 
SET GENRE = 'HAPPY' 
WHERE SONG_TITLE = 'ZAROOR';

--5. Delete an Artist ‘Ed Sheeran’ 
DELETE FROM ARTISTS 
WHERE ARTIST_NAME = 'ED SHEERAN';

--6. Add a New Column for Rating in Songs Table. [Ratings decimal(3,2)] 
ALTER TABLE SONGS 
ADD RATINGS DECIMAL(3,2);

--7. Retrieve songs whose title starts with 'S'. 
SELECT * FROM SONGS 
WHERE SONG_TITLE LIKE 'S%';

--8. Retrieve all songs whose title contains 'Everybody'. 
SELECT * FROM SONGS 
WHERE SONG_TITLE LIKE '%EVERYBODY%';

--9. Display Artist Name in Uppercase. 
SELECT UPPER(ARTIST_NAME) 
FROM ARTISTS;

--10. Find the Square Root of the Duration of a Song ‘Good Luck’ 
SELECT SQRT(DURATION) AS Duration_SquareRoot 
FROM SONGS 
WHERE SONG_TITLE = 'GOOD LUCK';

--11. Find Current Date. 
SELECT GETDATE();

--12. Find the number of albums for each artist. 
SELECT ARTIST_ID, COUNT(ALBUM_ID) AS Album_Count 
FROM ALBUMS 
GROUP BY ARTIST_ID;

--13. Retrieve the Album_id which has more than 5 songs in it. 
SELECT ALBUM_ID 
FROM SONGS 
GROUP BY ALBUM_ID 
HAVING COUNT(SONG_ID) > 5;

--14. Retrieve all songs from the album 'Album1'. (using Subquery
SELECT * 
FROM SONGS 
WHERE ALBUM_ID = (SELECT ALBUM_ID FROM ALBUMS WHERE ALBUM_TITLE = 'Album1');

--15. Retrieve all albums name from the artist ‘Aparshakti Khurana’ (using Subquery) 
SELECT ALBUM_TITLE 
FROM ALBUMS 
WHERE ARTIST_ID = (SELECT ARTIST_ID FROM ARTISTS WHERE ARTIST_NAME = 'APARSHAKTI KHURANA');

--16. Retrieve all the song titles with its album title. 
SELECT SONGS.SONG_TITLE, ALBUMS.ALBUM_TITLE 
FROM SONGS JOIN ALBUMS 
ON SONGS.ALBUM_ID = ALBUMS.ALBUM_ID;

--17. Find all the songs which are released in 2020. 
SELECT SONGS.* 
FROM SONGS JOIN ALBUMS 
ON SONGS.ALBUM_ID = ALBUMS.ALBUM_ID 
WHERE ALBUMS.RELEASE_YEAR = 2020;

--18. Create a view called ‘Fav_Songs’ from the songs table having songs with song_id 101-105.  
CREATE VIEW Fav_Songs AS 
SELECT * FROM SONGS 
WHERE SONG_ID BETWEEN 101 AND 105;

SELECT * FROM Fav_Songs;

--19. Update a song name to ‘Jannat’ of song having song_id 101 in Fav_Songs view. 
UPDATE Fav_Songs 
SET SONG_TITLE = 'Jannat' 
WHERE SONG_ID = 101;

--20. Find all artists who have released an album in 2020.  
SELECT DISTINCT ARTISTS.ARTIST_NAME 
FROM ARTISTS JOIN ALBUMS 
ON ARTISTS.ARTIST_ID = ALBUMS.ARTIST_ID
WHERE ALBUMS.RELEASE_YEAR = 2020;

--21. Retrieve all songs by Shreya Ghoshal and order them by duration.  
SELECT SONGS.* 
FROM SONGS JOIN ALBUMS 
ON SONGS.ALBUM_ID = ALBUMS.ALBUM_ID 
JOIN ARTISTS 
ON ALBUMS.ARTIST_ID = ARTISTS.ARTIST_ID 
WHERE ARTISTS.ARTIST_NAME = 'SHREYA GHOSHAL' 
ORDER BY SONGS.DURATION;



--Part – B 



--22. Retrieve all song titles by artists who have more than one album. 
SELECT Songs.Song_title 
FROM Songs JOIN Albums 
ON Songs.Album_id = Albums.Album_id 
JOIN Artists 
ON Albums.Artist_id = Artists.Artist_id 
WHERE Albums.Artist_id IN (SELECT Artist_id
FROM Albums 
GROUP BY Artist_id 
HAVING COUNT(Album_id) > 1);

--23. Retrieve all albums along with the total number of songs.
SELECT Albums.Album_id, COUNT(Songs.Song_id) AS Total_Songs 
FROM Albums LEFT JOIN Songs 
ON Albums.Album_id = Songs.Album_id 
GROUP BY Albums.Album_id;

--24. Retrieve all songs and release year and sort them by release year. 
SELECT Songs.Song_title, Albums.Release_year 
FROM Songs JOIN Albums 
ON Songs.Album_id = Albums.Album_id 
ORDER BY Albums.Release_year;

--25. Retrieve the total number of songs for each genre, showing genres that have more than 2 songs.
SELECT Genre, COUNT(Song_id) AS Total_Songs 
FROM Songs 
GROUP BY Genre 
HAVING COUNT(Song_id) > 2; 

--26. List all artists who have albums that contain more than 3 songs. 
SELECT DISTINCT Artists.Artist_name 
FROM Artists JOIN Albums 
ON Artists.Artist_id = Albums.Artist_id 
JOIN Songs 
ON Albums.Album_id = Songs.Album_id 
GROUP BY Albums.Album_id 
HAVING COUNT(Songs.Song_id) > 3;



--Part – C 



--27. Retrieve albums that have been released in the same year as 'Album4' 
SELECT Album_title 
FROM Albums 
WHERE Release_year = (SELECT Release_year 
FROM Albums 
WHERE Album_title = 'Album4');

--28. Find the longest song in each genre 
SELECT Genre, Song_title 
FROM Songs 
WHERE Duration = (SELECT MAX(Duration) 
FROM Songs AS S 
WHERE S.Genre = Songs.Genre);

--29. Retrieve the titles of songs released in albums that contain the word 'Album' in the title. 
SELECT Songs.Song_title 
FROM Songs JOIN Albums 
ON Songs.Album_id = Albums.Album_id 
WHERE Albums.Album_title LIKE '%Album%';

--30. Retrieve the total duration of songs by each artist where total duration exceeds 15 minutes. 
SELECT Artists.Artist_name, SUM(Songs.Duration) AS Total_Duration 
FROM Songs JOIN Albums 
ON Songs.Album_id = Albums.Album_id 
JOIN Artists ON Albums.Artist_id = Artists.Artist_id 
GROUP BY Artists.Artist_name 
HAVING SUM(Songs.Duration) > 15;