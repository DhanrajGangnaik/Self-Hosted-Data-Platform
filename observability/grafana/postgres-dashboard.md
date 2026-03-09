# PostgreSQL Grafana Dashboard

Grafana visualizes PostgreSQL metrics collected by Prometheus.

### Dashboard panels include:

• Active connections
• Transactions per second
• Cache hit ratio
• Database size
• Inserts / Updates / Deletes
• WAL activity
• Query latency

### Datasource:
Prometheus

### PromQL examples:

- Active connections:
```
pg_stat_activity_count
```

- Transactions per second:
```
rate(pg_stat_database_xact_commit[5m])
```

- Database size:
```
pg_database_size_bytes
```

- Exporter health:
```
pg_up
```