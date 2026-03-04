# PostgreSQL Alerts Runbook

## Alert: PostgreSQLDown
**Meaning:** Prometheus sees `pg_up == 0` for > 1 minute.

### Immediate checks
1. Check exporter:
   - `curl http://<postgres-host>:9187/metrics | grep '^pg_up'`
2. Check Postgres port:
   - `ss -lntp | grep 5432`
3. Check DB login:
   - `psql -h 127.0.0.1 -U postgres_exporter -d postgres`

### Common causes
- exporter DSN wrong
- Postgres not running
- pg_hba/role permissions
- port mismatch or binding issue

### Resolution
- Fix DSN / credentials
- Restart exporter container
- Restart postgresql service