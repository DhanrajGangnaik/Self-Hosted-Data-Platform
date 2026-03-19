# ClickHouse Setup Notes

## VM Role
Dedicated ClickHouse VM used for:
- centralized log storage
- log analytics
- Grafana datasource backend

## Service Validation
Check service status:

```bash
sudo systemctl status clickhouse-server
```

## Check listening ports:
```
sudo ss -tulpn | grep clickhouse
```

- Important Configuration Change

The server needed to listen beyond localhost so that Fluent Bit on other nodes could push logs.

- Working listen_host setting

Only this active line should remain:
```
<listen_host>::</listen_host>
```

Using both:
```
<listen_host>0.0.0.0</listen_host>
<listen_host>::</listen_host>
```
caused port binding conflicts on 9009 in this setup.

- Connectivity Validation

Local ping check:
```
curl http://127.0.0.1:8123/ping
```

Remote VM validation:
```
curl http://IP:8123/ping
```

Expected result:
```
Ok.
```

- Table Validation

Count rows:
```
SELECT count() FROM logs.platform_logs;
```

Recent logs:
```
SELECT
    timestamp,
    hostname,
    service,
    message
FROM logs.platform_logs
ORDER BY timestamp DESC
LIMIT 20;
```

Hosts sending logs:
```
SELECT
    hostname,
    count() AS rows
FROM logs.platform_logs
GROUP BY hostname
ORDER BY rows DESC;
```

## Notes

- level is stored as String

- In Grafana queries, numerical filtering requires casting:
```
toInt32(level)
```

Example:
```
SELECT
    service,
    count() AS errors
FROM logs.platform_logs
WHERE toInt32(level) <= 3
GROUP BY service
ORDER BY errors DESC;
```
---

- Final implementation uses TimescaleDB instead of ClickHouse for detection pipeline.

- ClickHouse setup retained for future evaluation.