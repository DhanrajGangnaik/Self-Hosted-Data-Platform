# PostgreSQL + pgAdmin Setup

## Overview

The platform uses PostgreSQL (with TimescaleDB extension) as the primary storage and analytics engine.

pgAdmin is used as the administrative and query interface.

---

## Architecture Role

| Component  | Role |
|-----------|------|
| PostgreSQL (TimescaleDB) | Data storage + analytics |
| pgAdmin | Querying, debugging, validation |
| mgmt VM | Runs detection jobs via cron |

---

## PostgreSQL Details

- Host: <DB_HOST>
- Database: metrics
- User: pgadmin_mgmt
- Extension: TimescaleDB

---

## Connection Example

```bash
psql -h <DB_HOST> -U pgadmin_mgmt -d metrics
```

---

## pgAdmin Usage

pgAdmin was used for:

- Running SQL queries interactively

- Debugging detection logic

- Validating continuous aggregates

- Inspecting alert outputs

---

## Key Queries Used in pgAdmin

### Check data flow
```
SELECT *
FROM security_events
ORDER BY time DESC
LIMIT 20;
```

---

### Validate aggregation
```
SELECT
  time_bucket('1 minute', time) AS bucket,
  count(*) AS total_requests
FROM security_events
GROUP BY bucket
ORDER BY bucket DESC;
```

---

### Detect traffic spikes
```
SELECT
  bucket,
  total_requests
FROM request_rate_1m
WHERE total_requests >= 100
ORDER BY bucket DESC;
```

---

### Validate alerts
```
SELECT *
FROM detection_alerts_v2
ORDER BY alert_time DESC;
```

---

## Key Debugging Steps

### Issue: No alerts generated

Cause:

- Aggregation threshold not met

Fix:

- Reduced threshold OR increased test traffic

---

### Issue: Duplicate alerts

- Cause:

No uniqueness constraint

- Fix:

Added composite unique indexes:
```
CREATE UNIQUE INDEX idx_req_spike
ON detection_alerts_v2 (rule_name, alert_bucket);
```

---

### Issue: Hypertable index error

Error:
```
cannot create a unique index without the column "time"
```
Fix:

- Moved to v2 table (non-hypertable alert store)

---

## Why pgAdmin Was Important 

- Faster debugging than CLI

- Visual inspection of JSONB fields

- Query iteration without breaking pipeline

---

## Operational Flow

1. Logs ingested → PostgreSQL

2. Aggregates computed → TimescaleDB

3. Detection queries executed (cron)

4. Alerts stored → detection_alerts_v2

5. pgAdmin used to validate + debug