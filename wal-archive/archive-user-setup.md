# WAL Archive User Setup

## On archive host:

```
sudo useradd -m -s /bin/bash walarch
sudo mkdir -p /srv/postgres/wal/primary
sudo chown -R walarch:walarch /srv/postgres/wal
sudo chmod 750 /srv/postgres/wal/primary
```

## Add SSH public key from primary to:

```
/home/walarch/.ssh/
```