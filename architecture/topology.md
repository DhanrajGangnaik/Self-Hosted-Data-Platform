# Topology

## Core Components

- **PostgreSQL Primary**
  - Main transactional database
  - Streams WAL to replica
  - Archives WAL segments to WAL archive server

- **PostgreSQL Replica**
  - Streaming replication target
  - Read-only standby for redundancy and failover readiness

- **WAL Archive**
  - Stores archived WAL segments from primary
  - Supports recovery and point-in-time restore workflows

- **TimescaleDB**
  - Dedicated time-series database node
  - Used for metrics / time-series workloads

- **Redis**
  - Dedicated caching layer
  - Used for fast in-memory access and reduced backend load

- **Monitoring VM**
  - Runs **Prometheus**
  - Runs **Grafana**
  - Runs **Alertmanager**
  - Scrapes exporters and centralizes observability

- **Log Analytics Stack**
  - **Fluent Bit** collects and forwards logs
  - **ClickHouse** stores log data
  - **Grafana** visualizes log analytics dashboards

- **Edge Proxy**
  - Receives / forwards service traffic
  - Sends logs through Fluent Bit pipeline

---

## Observability Components

- **node_exporter**
  - System metrics for VMs / nodes

- **postgres_exporter**
  - PostgreSQL metrics exposed to Prometheus

- **redis_exporter**
  - Redis metrics exposed to Prometheus

---

## Data Flow

### Database Replication Flow
Primary → Replica (streaming replication)  
Primary → WAL Archive (archive_command via rsync)

### Metrics Flow
PostgreSQL → postgres_exporter → Prometheus → Grafana  
Redis → redis_exporter → Prometheus → Grafana  
Node Exporter → Prometheus → Grafana

### Log Flow
Edge Proxy / Services → Fluent Bit → ClickHouse → Grafana

---

## Network / Service View

```text
                        +---------------------+
                        |       Grafana       |
                        +----------+----------+
                                   |
                                   v
                        +---------------------+
                        |     Prometheus      |
                        +-----+----------+----+
                              |          |
                +-------------+          +-------------+
                |                                      |
                v                                      v
      +--------------------+                +--------------------+
      | postgres_exporter  |                |   redis_exporter   |
      +---------+----------+                +---------+----------+
                |                                     |
                v                                     v
      +--------------------+                +--------------------+
      | PostgreSQL Primary |                |       Redis        |
      +---------+----------+                +--------------------+
                |
                +----------------------+
                |                      |
                v                      v
      +--------------------+   +--------------------+
      | PostgreSQL Replica |   |    WAL Archive     |
      +--------------------+   +--------------------+


      +--------------------+   +--------------------+   +------------------+
      |     Edge Proxy     |-->|     Fluent Bit     |-->|    ClickHouse    |
      +--------------------+   +--------------------+   +------------------+
                                                                  |
                                                                  v
                                                            +------------+
                                                            |  Grafana   |
                                                            +------------+
```

