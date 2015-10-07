FROM postgres:9.3

ENV POSTGRES_DB oz

ADD entrypoint.sh /

VOLUME ["/docker-entrypoint-initdb.d"]

ENTRYPOINT ["/entrypoint.sh"]
