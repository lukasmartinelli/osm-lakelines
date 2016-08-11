#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

function export_geojson() {
    PGHOST="$POSTGRES_PORT_5432_TCP_ADDR" \
    PGPORT="5432" \
    PGDATABASE="$POSTGRES_ENV_POSTGRES_DB" \
    PGUSER="$POSTGRES_ENV_POSTGRES_USER" \
    PGPASSWORD="$POSTGRES_ENV_POSTGRES_PASSWORD" \
    npm start
}

export_geojson
