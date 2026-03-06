-- Useful indexes for filtering and dashboard queries

CREATE INDEX IF NOT EXISTS idx_system_metrics_host_time
ON system_metrics (host, time DESC);

CREATE INDEX IF NOT EXISTS idx_system_metrics_service_time
ON system_metrics (service, time DESC);

CREATE INDEX IF NOT EXISTS idx_system_metrics_metric_name_time
ON system_metrics (metric_name, time DESC);