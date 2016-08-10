CREATE OR REPLACE FUNCTION polygon_label(geom geometry, simplify_tolerance float) returns geometry 
AS $$ 
  DECLARE 
    simplified_geom geometry := st_makevalid(st_simplify(geom, simplify_tolerance));
    center_line geometry := st_linemerge(st_approximatemedialaxis(simplified_geom));
    longest_segment geometry := (segment).geom FROM (SELECT st_dump(center_line) AS segment) AS t
           ORDER BY st_length((segment).geom)
           DESC limit 1;
  BEGIN  
    RETURN CASE
    	WHEN longest_segment IS NULL THEN ST_Centroid(geom) 
    	ELSE longest_segment
    END; 
  EXCEPTION WHEN OTHERS THEN 
    RETURN st_centroid(geom); 
  END; 
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION polygon_label (geometry, float) IS 'Calculates a center line across a simplified polygon and chooses the longest continous linestring suitable for labelling. Adjust the tolerance value to tweak results.';
