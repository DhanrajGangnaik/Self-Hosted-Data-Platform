# PostgreSQL Alerts Runbook

## Alert: PostgreSQLDown
**Meaning:** Prometheus sees `pg_up == 0` for > 1 minute.

---

### Immediate checks
1. Check exporter:
   - `curl http://<postgres-host>:9187/metrics | grep '^pg_up'`
2. Check Postgres port:
   - `ss -lntp | grep 5432`
3. Check DB login:
   - `psql -h 127.0.0.1 -U postgres_exporter -d postgres`

---

### Common causes
- exporter DSN wrong
- Postgres not running
- pg_hba/role permissions
- port mismatch or binding issue

---

### Resolution
- Fix DSN / credentials
- Restart exporter container
- Restart postgresql service

---

## Detection Alerts Pipeline

### Table: detection_alerts_v2

Purpose:
Stores deduplicated alerts generated from SQL-based detection rules.

### Key Design

- NOT a hypertable (important)
- Allows unique constraints
- Avoids Timescale partition limitations

---

### Deduplication Strategy

Uses:
```sql
ON CONFLICT DO NOTHING
```

### Unique keys:

- request_rate_spike → (rule_name, alert_bucket)

- single_ip_dominance → (rule_name, alert_bucket, entity)

## Validation Queries

- Check latest alerts:
```
SELECT * FROM detection_alerts_v2 ORDER BY alert_time DESC;
```

- Check system activity:
```
SELECT now(), max(alert_time) FROM detection_alerts_v2;
```