FROM postgres:latest as postgres-f1db

RUN apt-get update && apt-get install -y curl bzip2

RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.UTF-8

COPY 00-setup.sql /docker-entrypoint-initdb.d/
COPY 01-setup.sh /docker-entrypoint-initdb.d/
