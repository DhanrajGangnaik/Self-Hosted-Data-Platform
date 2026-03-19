## Why TimescaleDB?

- Native time-series support
- time_bucket() simplifies aggregation
- continuous aggregates reduce query cost

---

## Why NOT use hypertable for alerts?

Problem:
- hypertables require partition column in unique index

Impact:
- cannot enforce deduplication

Decision:
- use normal table for alerts

---

## Why SQL-based detection?

- simple
- explainable
- reproducible
- no external dependencies

---

## Why cron instead of streaming?

- simplicity
- predictable execution
- easier debugging

---

## Why JSONB for raw_event?

- flexible schema
- allows extracting fields (ip, path)

---

## Why ON CONFLICT DO NOTHING?

- ensures idempotency
- prevents duplicate alerts
- allows safe re-execution