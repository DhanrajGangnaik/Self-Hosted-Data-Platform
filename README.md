#  Self-Hosted Data Platform

### High-Availability Databases • Observability • Log Analytics • Time-Series Processing

<p align="center">

<!-- ![Platform Architecture](architecture/diagrams.png) -->

</p>

---

# 📌 Overview

**Self-Hosted Data Platform** is a production-style infrastructure platform built using open-source technologies.
The project demonstrates how to design, operate, and observe a **high-availability data system** with integrated monitoring, log analytics, and time-series processing.

The platform combines multiple infrastructure components into a cohesive architecture:

* PostgreSQL High Availability cluster
* WAL archival and recovery workflows
* Prometheus-based monitoring stack
* Grafana dashboards
* Alertmanager-driven alerting
* ClickHouse log analytics
* Fluent Bit log ingestion
* TimescaleDB time-series analytics

The goal of this project is to simulate **real-world data platform operations** similar to those used by SRE and DevOps teams.

---

# 🏗 Architecture

The platform architecture integrates **database replication, observability, and log analytics pipelines**.

```
                           ┌──────────────────────────┐
                           │         Grafana          │
                           │  Dashboards & Analytics  │
                           └─────────────┬────────────┘
                                         │
                          ┌──────────────▼──────────────┐
                          │          Prometheus         │
                          │        Metrics Engine       │
                          └───────┬───────────┬─────────┘
                                  │           │
                       ┌──────────▼───┐   ┌───▼──────────┐
                       │ postgres_    │   │ redis_       │
                       │ exporter     │   │ exporter     │
                       └───────┬──────┘   └──────┬───────┘
                               │                 │
                     ┌─────────▼────────┐   ┌────▼─────┐
                     │ PostgreSQL HA    │   │  Redis   │
                     │ Primary + Replica│   │  Cache   │
                     └───────┬──────────┘   └──────────┘
                             │
                             ▼
                      WAL Archive Host


     ┌──────────────┐      ┌──────────────┐      ┌──────────────┐
     │ Edge Proxy   │ ───► │  Fluent Bit  │ ───► │  ClickHouse  │
     │ Application  │      │ Log Collector│      │ Log Storage  │
     └──────────────┘      └──────────────┘      └──────┬───────┘
                                                         ▼
                                                      Grafana
                                                   Log Analytics
```

---

# ⚙️ Technology Stack

### Databases

* PostgreSQL 16
* TimescaleDB
* Redis

### Observability

* Prometheus
* Grafana
* Alertmanager
* postgres_exporter
* redis_exporter
* node_exporter

### Log Analytics

* Fluent Bit
* ClickHouse

### Infrastructure

* Linux
* SSH / rsync
* WAL archiving
* Streaming replication

---

# 📊 Platform Capabilities

### 🔹 Database High Availability

* PostgreSQL primary node
* Streaming replica
* Replication slot
* WAL archiving host
* Failover-ready architecture

### 🔹 Observability & Monitoring

* Prometheus metrics collection
* Grafana dashboards
* Database health monitoring
* Alertmanager alerts

### 🔹 Log Analytics

* Fluent Bit log ingestion
* ClickHouse storage
* Grafana log dashboards

### 🔹 Time-Series Analytics

* TimescaleDB hypertables
* Continuous aggregates
* Retention policies

### 🔹 Incident Documentation

* WAL loss recovery case study
* Operational runbooks
* Platform troubleshooting guides

---

# 📂 Repository Structure

```
Self-Hosted-Data-Platform
│
├── architecture
│   ├── components.md
│   ├── diagrams.png
│   └── topology.md
│
├── docs
│   ├── phases.md
│   └── runbooks
│
├── observability
│   ├── prometheus
│   ├── grafana
│   └── alertmanager
│
├── log-analytics
│   ├── clickhouse
│   ├── fluent-bit
│   └── grafana
│
├── postgres-primary
├── postgres-replica
├── wal-archive
├── timescaledb
├── scripts
├── troubleshooting
│
└── README.md
```

---

# 📈 Metrics Pipeline

```
PostgreSQL
     │
postgres_exporter
     │
Prometheus
     │
Grafana Dashboards
```

### Example Metrics

* Active connections
* Transaction rate
* Cache hit ratio
* Database size
* WAL activity
* Query performance

---

# 🚨 Alerting Pipeline

```
Prometheus
     │
Alertmanager
     │
Notification Channels
```

Example alert:

**PostgreSQLDown**

Triggers when the database exporter reports that PostgreSQL is unavailable.

---

# 🔍 Verification

### On Primary Node

```sql
SELECT pg_is_in_recovery();

SELECT client_addr, state, sync_state
FROM pg_stat_replication;

SELECT archived_count, failed_count
FROM pg_stat_archiver;
```

### On Replica Node

```sql
SELECT pg_is_in_recovery();
```

Expected result:

```
t
```

---

# ⚠️ Incident Case Study

During testing, a WAL segment loss caused PostgreSQL startup failure:

```
invalid checkpoint record
could not locate a valid checkpoint record
```

The issue required:

* WAL reset
* archive configuration hardening
* replication recovery

<!-- Detailed breakdown available in: 

```
troubleshooting/wal-loss-incident.md
```
-->
---

# 📷 Dashboards

The platform includes dashboards for:

* PostgreSQL metrics
* Redis monitoring
* TimescaleDB metrics
* Log analytics
* System health

Located in:

```
observability/grafana/dashboards
```

---

# 🎯 Project Goals

This platform demonstrates:

* Infrastructure reliability design
* Observability architecture
* Real-world database operations
* Incident handling workflows
* Data platform engineering practices

The repository is structured to resemble **a real production SRE / DevOps platform project**.

---

# 📜 License

MIT License

---

# ⭐ Future Improvements

Planned upgrades:

* automated failover
* distributed tracing
* anomaly detection
* infrastructure as code deployment
* unified observability dashboards



