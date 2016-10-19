#!/bin/bash

set -e

if [ ! -s "$PGDATA/PG_VERSION" ]; then
  echo "deb http://ftp.at.debian.org/debian testing main" > /etc/apt/sources.list
  apt-get update
  apt-get -yy install wget

  if [[ ! -f "/docker-entrypoint-initdb.d/oz.sql.gz" ]]; then
    echo "Downloading dataset.."
    wget -O /docker-entrypoint-initdb.d/oz.sql.gz http://otvorenezmluvy.sk/data/otvorenezmluvy_dump_2013-09-08.sql.gz
  else
    echo "Using previously downloaded dataset: /docker-entrypoint-initdb.d/oz.sql.gz"
  fi

  if [[ ! -f "/docker-entrypoint-initdb.d/oz.sql" ]]; then
    echo "Unpacking.."
    gunzip /docker-entrypoint-initdb.d/oz.sql.gz
  else
    echo "Using previously unpacked dataset: /docker-entrypoint-initdb.d/oz.sql"
  fi
fi

echo "Launching PostgreSQL"
/docker-entrypoint.sh postgres

