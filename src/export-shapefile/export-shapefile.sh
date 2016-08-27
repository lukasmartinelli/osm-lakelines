#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

function export_shp() {
    local lake_shapefile="/data/osm_lake_polygon.shp"
    local query="SELECT osm_id, ST_SimplifyPreserveTopology(geometry, 100) AS geometry FROM osm_lake_polygon WHERE area > 2 * 1000 * 1000 AND ST_GeometryType(geometry)='ST_Polygon'"
    pgsql2shp -f "$lake_shapefile" \
        -h "$POSTGRES_PORT_5432_TCP_ADDR" \
        -u "$POSTGRES_ENV_POSTGRES_USER" \
        -P "$POSTGRES_ENV_POSTGRES_PASSWORD" \
        "$POSTGRES_ENV_POSTGRES_DB" "$query"
}

export_shp
