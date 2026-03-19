-- Requests per IP per minute
SELECT
  time_bucket('1 minute', time) AS bucket,
  raw_event->>'ip' AS ip,
  count(*) AS requests
FROM security_events
GROUP BY bucket, ip
ORDER BY bucket DESC, requests DESC;

-- Detect IP dominance
SELECT
  time_bucket('1 minute', time) AS bucket,
  raw_event->>'ip' AS ip,
  count(*) * 100.0 / SUM(count(*)) OVER (PARTITION BY time_bucket('1 minute', time)) AS percentage
FROM security_events
GROUP BY bucket, ip
HAVING count(*) > 50
ORDER BY bucket DESC;