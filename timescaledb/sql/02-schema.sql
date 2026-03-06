-- Run inside the metrics database

CREATE TABLE IF NOT EXISTS system_metrics (
    time TIMESTAMPTZ NOT NULL,
    host TEXT NOT NULL,
    service TEXT NOT NULL,
    metric_name TEXT NOT NULL,
    metric_value DOUBLE PRECISION NOT NULL,
    labels JSONB
);

SELECT create_hypertable('system_metrics', 'time', if_not_exists => TRUE);