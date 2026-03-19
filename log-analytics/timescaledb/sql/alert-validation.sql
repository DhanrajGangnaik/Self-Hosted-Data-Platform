-- Latest alerts
SELECT *
FROM detection_alerts_v2
ORDER BY alert_time DESC;

-- Alert activity check
SELECT now(), max(alert_time)
FROM detection_alerts_v2;

-- Alerts by severity
SELECT severity, count(*)
FROM detection_alerts_v2
GROUP BY severity;

-- Alerts by rule
SELECT rule_name, count(*)
FROM detection_alerts_v2
GROUP BY rule_name;