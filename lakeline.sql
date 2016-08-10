 SELECT st_line_substring((geom_segment).geom, 0.1, 0.9) AS geom, ST_Length((geom_segment).geom) FROM 
(
SELECT ST_Dump(ST_LineMerge(geom)) AS geom_segment, name from (

 SELECT st_approximatemedialaxis(st_makevalid(st_simplify(lake.geom, 0.003::double precision))) AS geom,
    lake.name
   FROM lake
  
 where name = 'Lai da Genevra' 
) AS likeline
) AS dump
ORDER BY 2 DESC
 
