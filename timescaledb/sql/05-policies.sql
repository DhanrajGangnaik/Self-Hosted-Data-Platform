-- Continuous aggregate refresh policy
SELECT add_continuous_aggregate_policy(
    'system_metrics_5m',
    start_offset => INTERVAL '7 days',
    end_offset => INTERVAL '5 minutes',
    schedule_interval => INTERVAL '5 minutes'
);

-- Retention policy for raw metrics
SELECT add_retention_policy('system_metrics', INTERVAL '60 days');