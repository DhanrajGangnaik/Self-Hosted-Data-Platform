# Observability Stack

## Components
- Prometheus (systemd)
- Grafana
- Postgres Exporter (Docker on Postgres hosts)
- Alert rules (Prometheus rule_files)
- Alertmanager (routing/receivers)

## What’s working
- `pg_up` scraping = 1
- Postgres dashboards show DB activity metrics
- Prometheus rules load successfully
- Alert pipeline validated (Prometheus → Alertmanager)

## Next
- Add Node Exporter across nodes
- Add Loki (logs) + Tempo (traces)
- Add real notification receiver (Telegram/Discord/Email)