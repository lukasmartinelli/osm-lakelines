CREATE OR REPLACE VIEW lake_label AS
SELECT polygon_label(geometry, 400) AS geometry, osm_id, area FROM osm_lake_polygon
WHERE area > 2 * 1000 * 1000;
