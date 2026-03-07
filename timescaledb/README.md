# Phase 3 – TimescaleDB

## Overview

This phase adds a dedicated TimescaleDB-based time-series analytics layer to the Self-Hosted Data Platform.

The goal of this phase is to:

- deploy a dedicated TimescaleDB VM
- enable PostgreSQL + TimescaleDB extension
- create hypertables for metrics storage
- create continuous aggregates for efficient dashboard queries
- connect Grafana to TimescaleDB
- validate SQL-backed dashboards

## Implemented in this phase

- Dedicated TimescaleDB VM
- PostgreSQL 16.13
- TimescaleDB 2.25.2
- `system_metrics` hypertable
- `system_metrics_5m` continuous aggregate
- Grafana PostgreSQL datasource
- SQL dashboards
- Node Exporter installed on TimescaleDB VM
- Prometheus scraping Node Exporter successfully

## Current architecture

### Real live monitoring path

```text
Node Exporter
    ↓
Prometheus
    ↓
Grafana
```