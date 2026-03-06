## Database verification

### Check extension

```sql
SELECT extname, extversion
FROM pg_extension
WHERE extname = 'timescaledb';
```

## Node Exporter verification

On the TimescaleDB VM:

```bash
systemctl status node_exporter
```

Expected:
```
service state: active (running)
```

Check metrics endpoint:
```
curl localhost:9100/metrics
```

Expected:
```
Prometheus formatted metrics output
```

---

## Prometheus verification

- Open Prometheus UI.

- Navigate to:

Status → Targets

- Verify the following:

node-exporter target exists

target state = UP

scrape endpoint:
```
http://<timescaledb-vm-ip>:9100/metrics
```

## Grafana verification

- Verify the PostgreSQL datasource connection.

Example query test:
```
SELECT
  bucket AS time,
  host AS metric,
  avg_value AS value
FROM system_metrics_5m
WHERE metric_name = 'cpu_usage'
AND $__timeFilter(bucket)
ORDER BY bucket;
```

# Expected:

- time-series graph returned

- host metrics visible