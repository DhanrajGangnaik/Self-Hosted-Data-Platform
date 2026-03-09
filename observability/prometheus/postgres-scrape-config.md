# PostgreSQL Prometheus Scrape Configuration

PostgreSQL metrics are exported using **postgres_exporter** and scraped by Prometheus.

- Exporter endpoint:

http://POSTGRESQL-SERVER-IP:9187/metrics

- Prometheus scrape configuration:
```
scrape_configs:
  - job_name: 'postgres'
    static_configs:
      - targets: ['192.168.50.212:9187']
```

- Verification:
```
curl http://192.168.50.212:9187/metrics | grep pg_up
```

- Expected output:
```
pg_up 1
``` 