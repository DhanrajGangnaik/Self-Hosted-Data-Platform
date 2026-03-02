# Replica Setup

## Stop service

```
sudo systemctl stop postgresql@16-main
```

## Clear data directory

```
sudo rm -rf /var/lib/postgresql/16/main/*
```

## Run base backup

```
sudo -u postgres pg_basebackup
-h 192.168.50.212
-D /var/lib/postgresql/16/main
-U replication
-R
-X stream
-C -S replica1
-W
```

## Start replica

```
sudo systemctl start postgresql@16-main
```