/* a) A partir del siguiente �Query� y el resultado esperado determine que se debe ajustar a la sentencia SQL para que funcione correctamente. Tambi�n, documente que hace: */
WITH Numbers AS
(SELECT 1 as x FROM dual
UNION ALL SELECT 2 FROM dual
UNION ALL SELECT 2 FROM dual
UNION ALL SELECT 5 FROM dual
UNION ALL SELECT 8 FROM dual
UNION ALL SELECT 10 FROM dual
UNION ALL SELECT 10 FROM dual
UNION ALL SELECT 10 FROM dual
UNION ALL SELECT 11 FROM dual)
SELECT x,
RANK() OVER (ORDER BY x ASC) AS rank
FROM Numbers;
/* R// Hace Ranking  de los numeros proporcionados dentro del query, duplicando el ranking de acuerdo a los numeros que hayan repetidos y saltandose el n�mero de rank cuando se repita alg�n n�mero */

/* b) A partir del siguiente �Query� y el resultado esperado determine que se debe ajustar a la sentencia SQL para que funcione correctamente. Tambi�n, documente que hace: */
WITH Numbers AS
(SELECT 1 as x FROM dual
UNION ALL SELECT 2 FROM dual
UNION ALL SELECT 2 FROM dual
UNION ALL SELECT 5 FROM dual
UNION ALL SELECT 8 FROM dual
UNION ALL SELECT 10 FROM dual
UNION ALL SELECT 10 FROM dual)
SELECT x,
DENSE_RANK() OVER (ORDER BY x ASC) AS dense_rank
FROM Numbers;
/* R// Hace Ranking  de los los numeros proporcionados dentro del query duplicando el ranking de acuerdo a los numeros que hayan repetidos, respetando el orden del rank, no se los salta como el query anterior.

/* c) A partir del siguiente �Query� y el resultado esperado determine que se debe ajustar a la sentencia SQL para que funcione correctamente. Tambi�n, documente que hace: */
WITH finishers AS
(SELECT 'Sophia Liu' as name,
TIMESTAMP '2016-10-18 2:51:45' as finish_time,'F30-34' as division FROM dual
UNION ALL SELECT 'Lisa Stelzner', TIMESTAMP '2016-10-18 2:54:11', 'F35-39' FROM dual
UNION ALL SELECT 'Nikki Leith', TIMESTAMP '2016-10-18 2:59:01', 'F30-34' FROM dual
UNION ALL SELECT 'Lauren Matthews', TIMESTAMP '2016-10-18 3:01:17', 'F35-39' FROM dual
UNION ALL SELECT 'Desiree Berry', TIMESTAMP '2016-10-18 3:05:42', 'F35-39' FROM dual
UNION ALL SELECT 'Suzy Slane', TIMESTAMP '2016-10-18 3:06:24', 'F35-39' FROM dual 
UNION ALL SELECT 'Jen Edwards', TIMESTAMP '2016-10-18 3:06:36', 'F30-34' FROM dual
UNION ALL SELECT 'Meghan Lederer', TIMESTAMP '2016-10-18 2:59:01', 'F30-34' FROM dual)
SELECT
 name,
 finish_time,
 division,
RANK() OVER (PARTITION BY division ORDER BY finish_time ASC) AS finish_rank
FROM finishers;
/* R// Hace Ranking  de los por tiempos de finalizaci�n proporcionados dentro del query y los clasifica por categor�as por medio del PARTITION BY division */

/* d) A partir del siguiente �Query� y el resultado esperado determine que se debe ajustar a la sentencia SQL para que funcione correctamente. Tambi�n, documente que hace: */
WITH finishers AS
(SELECT 'Sophia Liu' as name,
TIMESTAMP '2016-10-18 2:51:45' as finish_time,
'F30-34' as division FROM dual
UNION ALL SELECT 'Lisa Stelzner', TIMESTAMP '2016-10-18 2:54:11', 'F35-39' FROM dual
UNION ALL SELECT 'Nikki Leith', TIMESTAMP '2016-10-18 2:59:01', 'F30-34' FROM dual
UNION ALL SELECT 'Lauren Matthews', TIMESTAMP '2016-10-18 3:01:17', 'F35-39' FROM dual
UNION ALL SELECT 'Desiree Berry', TIMESTAMP '2016-10-18 3:05:42', 'F35-39' FROM dual
UNION ALL SELECT 'Suzy Slane', TIMESTAMP '2016-10-18 3:06:24', 'F35-39' FROM dual
UNION ALL SELECT 'Jen Edwards', TIMESTAMP '2016-10-18 3:06:36', 'F30-34' FROM dual
UNION ALL SELECT 'Meghan Lederer', TIMESTAMP '2016-10-18 2:59:01', 'F30-34' FROM dual)
SELECT name,
finish_time,
division,
PERCENT_RANK() OVER (PARTITION BY division ORDER BY finish_time ASC) AS
finish_rank
FROM finishers;
/* R// Hace Ranking  de los por tiempos de finalizaci�n proporcionados dentro del query y los clasifica por categor�as por medio del PARTITION BY division pero en este caso es por percentiles*/