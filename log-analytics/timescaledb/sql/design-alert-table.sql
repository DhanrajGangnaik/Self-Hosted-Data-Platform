CREATE TABLE IF NOT EXISTS detection_alerts_v2 (
  id BIGSERIAL PRIMARY KEY,
  alert_time TIMESTAMPTZ NOT NULL,
  alert_bucket TIMESTAMPTZ,
  rule_name TEXT NOT NULL,
  severity TEXT NOT NULL,
  source TEXT,
  entity TEXT,
  value_numeric DOUBLE PRECISION,
  message TEXT,
  details JSONB,
  labels JSONB
);

-- Unique constraints
CREATE UNIQUE INDEX IF NOT EXISTS idx_req_spike
ON detection_alerts_v2 (rule_name, alert_bucket);

CREATE UNIQUE INDEX IF NOT EXISTS idx_ip_dom
ON detection_alerts_v2 (rule_name, alert_bucket, entity);