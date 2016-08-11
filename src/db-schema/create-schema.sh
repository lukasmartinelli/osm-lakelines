#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

function exec_psql_file() {
    local file_name="$1"
    PGPASSWORD=$POSTGRES_ENV_POSTGRES_PASSWORD psql \
        -v ON_ERROR_STOP=1 \
        --host="$POSTGRES_PORT_5432_TCP_ADDR" \
        --port="5432" \
        --dbname="$POSTGRES_ENV_POSTGRES_DB" \
        --username="$POSTGRES_ENV_POSTGRES_USER" \
        -f "$file_name"
}

function main() {
    exec_psql_file "polygon_label.sql"
    exec_psql_file "lake_label.sql"
}

main
