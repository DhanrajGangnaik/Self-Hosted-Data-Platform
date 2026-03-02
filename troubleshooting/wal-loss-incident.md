# WAL Loss Incident

## Problem

Primary failed to start with:

- invalid checkpoint record
- could not locate a valid checkpoint record

Missing WAL segment:
000000010000000000000013

## Root Cause

WAL segment was not archived successfully.
Primary entered recovery state without required WAL.

## Resolution

- Removed standby signal files
- Executed pg_resetwal
- Reconfigured archive_command
- Implemented atomic WAL transfer
- Rebuilt replica from clean base backup

## Lessons Learned

- Always verify pg_stat_archiver
- Use atomic WAL archive strategy
- Avoid archiving as root
- Monitor replication slots