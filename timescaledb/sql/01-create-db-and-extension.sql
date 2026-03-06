CREATE USER metrics_user WITH PASSWORD 'strongpassword';

CREATE DATABASE metrics OWNER metrics_user;

\c metrics

CREATE EXTENSION IF NOT EXISTS timescaledb;

GRANT USAGE ON SCHEMA public TO metrics_user;
GRANT CREATE ON SCHEMA public TO metrics_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO metrics_user;