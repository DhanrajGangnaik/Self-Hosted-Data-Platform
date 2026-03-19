# Detection Engine (SQL-based)

This module implements rule-based anomaly detection using SQL on TimescaleDB.

## Design

- Detection runs periodically via cron
- Uses aggregated data (continuous aggregates)
- Stores results in `detection_alerts_v2`
- Uses `ON CONFLICT DO NOTHING` for idempotency

---

## Rules Implemented

### 1. Request Rate Spike
Detects abnormal traffic volume per minute.

Thresholds:
- HIGH ≥ 300 requests
- MEDIUM ≥ 100 requests

---

### 2. Single IP Dominance
Detects if one IP dominates traffic.

Thresholds:
- HIGH ≥ 50%
- MEDIUM ≥ 30%

---

## Execution

Executed every minute via:

```bash
cron (mgmt-1)
```

## Output Table
```
detection_alerts_v2
```

### Stores:

- alert_time

- alert_bucket

- rule_name

- severity

- entity

- value_numeric

- details (JSON)