# Project Phases

## Phase 1 — PostgreSQL High Availability
- PostgreSQL primary
- Streaming replication
- WAL archiving
- Replica promotion procedures

## Phase 2 — Monitoring & Observability Foundation
- Prometheus
- Grafana
- Node exporter

## Phase 3 — TimescaleDB Analytics
- Time-series database setup
- Hypertables
- Continuous aggregates
- Data retention policies

## Phase 4 — Log Analytics
- Fluent Bit log collection
- ClickHouse storage
- Grafana log dashboards

## Phase 5 — Caching Layer
- Redis exporter integration
- Prometheus scrape configuration
- Grafana cache performance dashboards
- Alerts for cache health and memory usage
  
## Phase 6: Log Analytics + Detection

### Completed

- nginx log ingestion
- parsing into structured JSON
- TimescaleDB storage
- hypertable creation
- continuous aggregates
- detection rules
- alert table
- cron automation

### Lessons Learned

- Hypertables cannot enforce unique constraints without partition key
- Detection tables should NOT be hypertables
- Cron runs with minimal environment (PATH issues)
- `.pgpass` required for non-interactive execution
- `ON CONFLICT DO NOTHING` ensures idempotency

