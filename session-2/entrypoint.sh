#!/bin/bash

set -e

if [ ! -s "$PGDATA/PG_VERSION" ]; then
  echo "deb http://ftp.at.debian.org/debian testing main" > /etc/apt/sources.list
  apt-get update
  apt-get -yy install wget

  echo "Downloading dataset.."
  wget -O /docker-entrypoint-initdb.d/oz.sql.gz http://otvorenezmluvy.sk/data/otvorenezmluvy_dump_2013-09-08.sql.gz

  echo "Unpacking.."
  gunzip /docker-entrypoint-initdb.d/oz.sql.gz
fi

echo "Launching PostgreSQL"
/docker-entrypoint.sh postgres
