#!/bin/bash

echo "Primary status:"
sudo -u postgres psql -c "SELECT client_addr, state FROM pg_stat_replication;"

echo "Archiver status:"
sudo -u postgres psql -c "SELECT archived_count, failed_count FROM pg_stat_archiver;"