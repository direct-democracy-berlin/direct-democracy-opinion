#!/bin/bash

echo "If ok, direct to psql: psql < <($0)" >&2
cat <( psql -Atc "select 'drop database \"'||datname||'\";' from pg_database where datistemplate=false /* AND add_extra_conditions_here */;)"