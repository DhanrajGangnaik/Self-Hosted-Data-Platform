# Phase 4 – Log Analytics with ClickHouse

## Objective
Build a centralized logging and analytics pipeline for the self-hosted data platform.

## Architecture
edge-proxy -> Fluent Bit -> ClickHouse -> Grafana

## Components
- **Fluent Bit** for log collection
- **ClickHouse** for log storage and analytics
- **Grafana** for visualization

## Current Implementation
- Systemd/journald logs collected from `edge-proxy`
- Logs inserted into `logs.platform_logs`
- Grafana dashboard created for observability

## ClickHouse Table
Columns:
- timestamp
- hostname
- service
- level
- source_type
- message
- raw

## Dashboard Panels
- Severity Distribution
- Services Generating Most Logs
- Error Rate by Service
- Log Volume Over Time
- Live Log Stream
- Top Error Messages

## Status
Phase 4 core milestone completed.

## Next Expansion
- Add `monitoring-vm`
- Add `postgres-vm`
- Add `timescaledb-vm`
- Add better parsing and field extraction