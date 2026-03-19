
-- Create security_events_1m
CREATE MATERIALIZED VIEW IF NOT EXISTS security_events_1m
WITH (timescaledb.continuous) AS
SELECT
  time_bucket('1 minute', time) AS bucket,
  event_type,
  severity,
  count(*) AS events
FROM security_events
GROUP BY bucket, event_type, severity;

-- Add refresh policy
SELECT add_continuous_aggregate_policy(
  'security_events_1m',
  start_offset => INTERVAL '1 hour',
  end_offset => INTERVAL '1 minute',
  schedule_interval => INTERVAL '1 minute'
);


-- Create request_rate_1m
CREATE MATERIALIZED VIEW IF NOT EXISTS request_rate_1m
WITH (timescaledb.continuous) AS
SELECT
  time_bucket('1 minute', time) AS bucket,
  count(*) AS total_requests
FROM security_events
GROUP BY bucket;

-- Add refresh policy
SELECT add_continuous_aggregate_policy(
  'request_rate_1m',
  start_offset => INTERVAL '1 hour',
  end_offset => INTERVAL '1 minute',
  schedule_interval => INTERVAL '1 minute'
);