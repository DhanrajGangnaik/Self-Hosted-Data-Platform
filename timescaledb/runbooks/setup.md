## 1. Install PostgreSQL and TimescaleDB

- Install PostgreSQL 16
- Install TimescaleDB extension package
- Run `timescaledb-tune`
- Restart PostgreSQL

## 2. Create database and extension

Run:

```sql
CREATE USER metrics_user WITH PASSWORD 'strongpassword';
CREATE DATABASE metrics OWNER metrics_user;
\c metrics
CREATE EXTENSION IF NOT EXISTS timescaledb;
```

## 3. Create hypertable

Run 
```
sql/02-schema.sql
```

## 4. Create indexes

Run 
```
sql/03-indexes.sql
```

##5. Create continuous aggregate

Run 
```
sql/04-continuous-aggregates.sql
```
## 6. Add policies

Run 
```
sql/05-policies.sql
```

## 7. Insert sample telemetry

Run 
```
sql/06-sample-data.sql
```

## 8. Connect Grafana

Add PostgreSQL datasource with:

Host: <timescaledb-vm-ip>:5432

Database: metrics

User: metrics_user

SSL mode: disable

## 9. Install Node Exporter on TimescaleDB VM

Install Node Exporter and verify:
```
curl localhost:9100/metrics
```

## 10. Verify Prometheus scrape

In Prometheus UI:

Status > Targets > verify node-exporter target is UP