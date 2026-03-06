-- Continuous aggregate for 5-minute metric buckets

CREATE MATERIALIZED VIEW IF NOT EXISTS system_metrics_5m
WITH (timescaledb.continuous) AS
SELECT
    time_bucket('5 minutes', time) AS bucket,
    host,
    service,
    metric_name,
    AVG(metric_value) AS avg_value,
    MAX(metric_value) AS max_value,
    MIN(metric_value) AS min_value
FROM system_metrics
GROUP BY bucket, host, service, metric_name
WITH NO DATA;

-- Backfill the aggregate
CALL refresh_continuous_aggregate('system_metrics_5m', NULL, NULL);