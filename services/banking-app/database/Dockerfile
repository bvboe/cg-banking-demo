FROM postgres:18

ENV POSTGRES_USER=banking_user
ENV POSTGRES_PASSWORD=banking_password
ENV POSTGRES_DB=banking_db

COPY schema.sql /docker-entrypoint-initdb.d/01-schema.sql
COPY seed.sql   /docker-entrypoint-initdb.d/02-seed.sql
