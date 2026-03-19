# End-to-End Data Flow

This document describes the complete pipeline from raw logs to detection alerts.

---

## 1. Log Generation (edge-proxy)

- NGINX generates access logs at:

```bash
/var/log/nginx/access.log
```

#### Log format includes:

- IP

- request path

- timestamp

- status code

---

## 2. Log Ingestion (mgmt-1)

Script: ```ingest_logs.py```

Initial Issue Encountered

### Error:
```
FileNotFoundError: /var/log/nginx/access.log
```

#### Cause:

- Script executed on mgmt-1

- Logs existed on edge-proxy

### Fix:

- Moved ingestion to run on edge-proxy

##### OR

- Pulled logs remotely

---

## 3. Parsing

Regex-based parsing of nginx logs

Converted into structured JSON:

Example:
```
{
  "ip": "192.168.50.127",
  "path": "/",
  "time": "18/Mar/2026:07:19:38"
}
```
---

## 4. Storage (TimescaleDB)

### Target DB:

Host: 192.168.50.99

DB: metrics

### Table: security_events

#### Columns:

- time (TIMESTAMPTZ)

- host
  
- event type

- severity

- source

- message

- raw_event (JSONB)

---

## 5. Continuous Aggregates

### security_events_1m

Aggregates:

- grouped by minute

- grouped by event_type + severity

---

### request_rate_1m

Aggregates:
```
time_bucket('1 minute', time)
count(*)
```
---

## 6. Detection Engine

- Runs on:

mgmt-1 via cron

- Frequency:

every 1 minute

---

### Rule 1: Request Rate Spike

- Logic:

detect high request volume

- Thresholds:

≥300 → HIGH

≥100 → MEDIUM

---

### Rule 2: Single IP Dominance

Logic:

% of requests per IP per bucket

Calculation:
```
count(*) * 100.0 / SUM(count(*)) OVER (...)
```

---

## 7. Alert Storage
### Problem Faced

- Original table:

hypertable

### Error:
```
cannot create unique index without partition column
```

---

### Final Design

Table: ```detection_alerts_v2```

- Reason:

normal table allows deduplication

---

### Deduplication Strategy
```
ON CONFLICT DO NOTHING
```

---

## 8. Automation

#### Cron runs:
```
* * * * * psql ...
```

#### Issue Faced

- cron log file not created

#### Root Causes:

- silent SQL execution

- no output due to ON CONFLICT

---

### Debug Steps
```
systemctl status cron
grep CRON /var/log/syslog
```

#### Confirmed:

- cron running correctly

---

## 9. Visualization (Grafana)

- PostgreSQL data source added

- dashboards built using SQL queries

---

## Final Pipeline
NGINX → ingestion → TimescaleDB → aggregates → detection → alerts → Grafana