# SQL Reference

This folder contains all SQL queries used in the project.

---

## Sections

1. Validation Queries
2. Analytics Queries
3. Continuous Aggregates
4. Detection Rules
5. Alert Validation

---

## Key Concepts

- time_bucket → time-based aggregation
- JSONB extraction → raw_event->>'ip'
- window functions → IP dominance calculation
- ON CONFLICT → deduplication

---

## Usage

Run detection manually:

```bash
psql -f detect.sql
```

---

## Important

This project heavily relies on:

- SQL as detection engine not external tools.
