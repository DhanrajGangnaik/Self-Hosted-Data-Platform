# Grafana ClickHouse Datasource

## Plugin
Installed plugin:

```
sudo grafana-cli plugins install grafana-clickhouse-datasource
```
```
sudo systemctl restart grafana-server
```

- Datasource Name

Example datasource name:
```
grafana-clickhouse-datasource
```

- Connection Settings

Host: IP

Port: 8123

Protocol: http

Database: logs

Username: default

Password: configured locally or blank if allowed

- Connectivity Test

From Grafana VM:
```
curl http://192.168.50.188:8123/ping
```

Expected:
```
Ok.
```

## Notes

- Queries are executed against logs.platform_logs

- level is stored as String, so use toInt32(level) when numeric comparisons are needed

- Host filtering is handled via Grafana variable ${hostname:sqlstring}