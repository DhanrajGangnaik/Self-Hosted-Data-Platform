#!/bin/bash
set -e

systemctl stop postgresql@16-main
rm -rf /var/lib/postgresql/16/main/*
chown -R postgres:postgres /var/lib/postgresql/16/main
chmod 700 /var/lib/postgresql/16/main

sudo -u postgres pg_basebackup \
  -h 192.168.50.212 \
  -D /var/lib/postgresql/16/main \
  -U replication \
  -R \
  -X stream \
  -S replica1 \
  -W