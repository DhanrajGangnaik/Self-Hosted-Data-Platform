-- Total requests per minute
SELECT
  time_bucket('1 minute', time) AS bucket,
  count(*) AS total_requests
FROM security_events
GROUP BY bucket
ORDER BY bucket DESC;

-- High traffic buckets
SELECT
  time_bucket('1 minute', time) AS bucket,
  count(*) AS total_requests
FROM security_events
GROUP BY bucket
HAVING count(*) > 100
ORDER BY bucket DESC;

-- Top IPs
SELECT
  raw_event->>'ip' AS ip,
  count(*) AS requests
FROM security_events
GROUP BY ip
ORDER BY requests DESC
LIMIT 10;

-- Top paths
SELECT
  raw_event->>'path' AS path,
  count(*) AS requests
FROM security_events
GROUP BY path
ORDER BY requests DESC
LIMIT 10;