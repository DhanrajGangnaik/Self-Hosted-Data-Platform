# Grafana Dashboard Panels

## Dashboard Name
Suggested dashboard name:
- `Log Analytics`
- or `Phase 4 - ClickHouse Log Analytics`

## Variable
### Hostname Variable
- **Name**: `hostname`
- **Type**: `Query`
- **Datasource**: ClickHouse
- **Query**:

```
SELECT DISTINCT hostname FROM logs.platform_logs ORDER BY hostname
```

- Selection Options

Multi-value: ON

- Include All option: ON

Custom all value:

.*

### Panel 1 — Severity Distribution
- Panel Title
```
Severity Distribution
```
- Query
```
SELECT
    level,
    count() AS logs
FROM logs.platform_logs
WHERE hostname IN (${hostname:sqlstring})
AND timestamp >= now() - INTERVAL 1 HOUR
GROUP BY level
ORDER BY level
```

- Visualization
```
Bar chart
```

---

### Panel 2 — Services Generating Most Logs
- Panel Title
```
Services Generating Most Logs
```
- Query
```
SELECT
    service,
    count() AS rows
FROM logs.platform_logs
WHERE hostname IN (${hostname:sqlstring})
AND timestamp >= now() - INTERVAL 1 HOUR
GROUP BY service
ORDER BY rows DESC
LIMIT 10
```

- Visualization
```
Bar chart
```

---

### Panel 3 — Error Rate by Service
- Panel Title
```
Error Rate by Service
```

- Query
```
SELECT
    service,
    count() AS errors
FROM logs.platform_logs
WHERE hostname IN (${hostname:sqlstring})
AND toInt32(level) <= 6
AND timestamp >= now() - INTERVAL 1 HOUR
GROUP BY service
ORDER BY errors DESC
```

- Visualization
```
Bar chart
```

- Note

If you want only critical/error-level logs, use:
```
toInt32(level) <= 3
```

---

### Panel 4 — Log Volume Over Time
- Panel Title
```
Log Volume Over Time
```

- Query
```
SELECT
    toStartOfMinute(timestamp) AS time,
    count() AS logs_count
FROM logs.platform_logs
WHERE hostname IN (${hostname:sqlstring})
AND timestamp >= now() - INTERVAL 1 HOUR
GROUP BY time
ORDER BY time
```

- Visualization
```
Time series
```

---

### Panel 5 — Live System Logs
- Panel Title
```
Live System Logs
```

- Query
```
SELECT
    timestamp,
    hostname,
    service,
    level,
    source_type,
    substring(message,1,120) AS message
FROM logs.platform_logs
WHERE hostname IN (${hostname:sqlstring})
ORDER BY timestamp DESC
LIMIT 100
```

- Visualization
```
Table
``` 

---

### Panel 6 — Most Frequent Error Messages
- Panel Title
```
Most Frequent Error Messages
```

- Query
```
SELECT
    substring(message,1,120) AS message,
    count() AS occurrences
FROM logs.platform_logs
WHERE hostname IN (${hostname:sqlstring})
AND toInt32(level) <= 6
AND timestamp >= now() - INTERVAL 1 HOUR
GROUP BY message
ORDER BY occurrences DESC
LIMIT 10
```

- Visualization
```
Table
```

- Note

If you want stricter errors only:
```
toInt32(level) <= 3
```

---

## Security Dashboards

### Traffic Overview

#### Requests Per Minute
```sql
SELECT bucket AS "time", total_requests FROM request_rate_1m;
```

#### Top IPs
```
SELECT raw_event->>'ip' AS ip, count(*) FROM security_events GROUP BY ip ORDER BY count DESC LIMIT 10;
```

### Detection Dashboard

#### Recent Alerts
```
SELECT alert_time, rule_name, severity, entity FROM detection_alerts_v2 ORDER BY alert_time DESC;
```

#### Alerts by Rule
```
SELECT rule_name, count(*) FROM detection_alerts_v2 GROUP BY rule_name;
```
