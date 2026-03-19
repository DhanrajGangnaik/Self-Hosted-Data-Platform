# Self-Hosted Data Platform

Production-style homelab platform combining:

- PostgreSQL HA (primary + replica + WAL)
- Observability (Prometheus, Grafana, Alertmanager)
- Log analytics (Fluent Bit + ClickHouse)
- Time-series analytics (TimescaleDB)
- SQL-based detection pipeline
- pgAdmin-driven DB operations

---

## Architecture

```text
NGINX → Python Ingest → TimescaleDB → Aggregates → Detection → Alerts → Grafana
                                  ↓
                             Prometheus
                                  ↓
                               Grafana
```

---

## Core Components
| Layer         | Stack                             |
| ------------- | --------------------------------- |
| Database      | PostgreSQL, TimescaleDB           |
| Observability | Prometheus, Grafana, Alertmanager |
| Logs          | Fluent Bit, ClickHouse            |
| Detection     | SQL (TimescaleDB)                 |
| Management    | pgAdmin, mgmt VM (cron)           |

---

## Data Pipelines
1. Metrics
```
PostgreSQL → Exporters → Prometheus → Grafana
```
2. Logs
```
Fluent Bit → ClickHouse → Grafana
```
3. Detection
```NGINX logs → Python → security_events
           → Aggregates → Detection SQL → detection_alerts_v2
```

---

## Detection Engine

Runs every minute via cron (mgmt VM).

### Rules

Request Rate Spike

- HIGH ≥ 300 req/min

- MEDIUM ≥ 100 req/min

Single IP Dominance

- HIGH ≥ 50%

- MEDIUM ≥ 30%

---

## Key SQL Patterns
```
-- time-based aggregation
time_bucket('1 minute', time)

-- JSON extraction
raw_event->>'ip'

-- window function
SUM(count(*)) OVER (...)

-- deduplication
ON CONFLICT DO NOTHING
```

---

## Alert Storage

Table: ```detection_alerts_v2```

- NOT a hypertable

- supports unique constraints

- prevents duplicate alerts

---

## Automation
```

* * * * * /usr/bin/psql -h <DB> -U <USER> -d metrics -f detect.sql
```

---

## pgAdmin Usage

Used for:

- query debugging

- aggregate validation

- alert inspection

- schema verification

---

## Key Challenges

- log ingestion from correct host (edge vs mgmt)

- TimescaleDB unique index limitation

- cron silent execution

- PostgreSQL connection mismatches

- Python (PEP 668) environment restrictions


---

## Limitations

- rule-based detection only

- no real-time streaming

- no automated response system
- 