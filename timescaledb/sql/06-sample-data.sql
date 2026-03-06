-- Sample telemetry used to validate dashboards

INSERT INTO system_metrics (time, host, service, metric_name, metric_value, labels)
VALUES
(NOW() - INTERVAL '20 minutes', 'monitoring-vm', 'node-exporter', 'cpu_usage', 18.7, '{"unit":"percent"}'),
(NOW() - INTERVAL '15 minutes', 'monitoring-vm', 'node-exporter', 'cpu_usage', 22.3, '{"unit":"percent"}'),
(NOW() - INTERVAL '10 minutes', 'timescale-database', 'node-exporter', 'cpu_usage', 14.8, '{"unit":"percent"}'),
(NOW() - INTERVAL '5 minutes', 'timescale-database', 'node-exporter', 'cpu_usage', 17.2, '{"unit":"percent"}'),
(NOW(), 'monitoring-vm', 'node-exporter', 'cpu_usage', 24.1, '{"unit":"percent"}'),

(NOW() - INTERVAL '20 minutes', 'monitoring-vm', 'node-exporter', 'memory_usage', 60.1, '{"unit":"percent"}'),
(NOW() - INTERVAL '15 minutes', 'monitoring-vm', 'node-exporter', 'memory_usage', 62.3, '{"unit":"percent"}'),
(NOW() - INTERVAL '10 minutes', 'monitoring-vm', 'node-exporter', 'memory_usage', 63.5, '{"unit":"percent"}'),
(NOW() - INTERVAL '5 minutes', 'timescale-database', 'node-exporter', 'memory_usage', 48.1, '{"unit":"percent"}'),
(NOW(), 'timescale-database', 'node-exporter', 'memory_usage', 48.1, '{"unit":"percent"}'),

(NOW() - INTERVAL '10 minutes', 'monitoring-vm', 'node-exporter', 'disk_usage', 41.2, '{"mount":"/","unit":"percent"}'),
(NOW() - INTERVAL '5 minutes', 'timescale-database', 'node-exporter', 'disk_usage', 36.8, '{"mount":"/","unit":"percent"}'),
(NOW(), 'monitoring-vm', 'prometheus', 'targets_up', 5, '{"job":"node-exporter"}');