# Self-Hosted Data Platform – Phase 1

## Overview

This project implements a PostgreSQL 16 high-availability architecture with:

- Primary node 
- Streaming replica
- Dedicated WAL archive host 
- Replication slot
- Atomic WAL archiving via rsync + SSH
- Incident recovery (missing WAL segment case study)

---

## Architecture

Primary → Streaming Replica  
Primary → WAL Archive Host  

Streaming replication with replication slot.  
WAL archiving enabled with atomic transfer.

---

## Phase 1 Components

- PostgreSQL Primary (writable)
- PostgreSQL Replica (read-only)
- WAL Archiving Host
- Replication Role
- pg_hba network authentication
- Incident handling and recovery documentation

---

## Verification Commands

### On Primary

```sql
SELECT pg_is_in_recovery();
SELECT client_addr, state, sync_state FROM pg_stat_replication;
SELECT archived_count, failed_count FROM pg_stat_archiver;

### On Replica

```sql
SELECT pg_is_in_recovery();

### Incident Summary

- A WAL segment was lost during archiving, causing:

- invalid checkpoint record

- could not locate a valid checkpoint record

- The cluster required WAL reset and architecture hardening.

- Full breakdown available in troubleshooting/wal-loss-incident.md.