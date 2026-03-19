-- Request Rate Spike Detection
INSERT INTO detection_alerts_v2 (
  alert_time,
  alert_bucket,
  rule_name,
  severity,
  source,
  entity,
  value_numeric,
  message,
  details,
  labels
)
SELECT
  NOW(),
  bucket,
  'request_rate_spike',
  CASE
    WHEN total_requests >= 300 THEN 'HIGH'
    WHEN total_requests >= 100 THEN 'MEDIUM'
    ELSE 'LOW'
  END,
  'nginx',
  'global',
  total_requests,
  'Request volume exceeded threshold',
  jsonb_build_object(
    'bucket', bucket,
    'total_requests', total_requests
  ),
  jsonb_build_object(
    'env', 'lab',
    'service', 'edge-proxy'
  )
FROM request_rate_1m
WHERE total_requests >= 100
ON CONFLICT DO NOTHING;


-- Single IP Dominance Detection
INSERT INTO detection_alerts_v2 (
  alert_time,
  alert_bucket,
  rule_name,
  severity,
  source,
  entity,
  value_numeric,
  message,
  details,
  labels
)
SELECT
  NOW(),
  bucket,
  'single_ip_dominance',
  CASE
    WHEN percentage >= 50 THEN 'HIGH'
    WHEN percentage >= 30 THEN 'MEDIUM'
    ELSE 'LOW'
  END,
  'nginx',
  ip,
  percentage,
  'Single IP dominates request share',
  jsonb_build_object(
    'bucket', bucket,
    'ip', ip,
    'percentage', percentage
  ),
  jsonb_build_object(
    'env', 'lab',
    'service', 'edge-proxy'
  )
FROM (
  SELECT
    time_bucket('1 minute', time) AS bucket,
    raw_event->>'ip' AS ip,
    count(*) * 100.0 / SUM(count(*)) OVER (PARTITION BY time_bucket('1 minute', time)) AS percentage
  FROM security_events
  GROUP BY bucket, ip
) t
WHERE percentage >= 30
ON CONFLICT DO NOTHING;