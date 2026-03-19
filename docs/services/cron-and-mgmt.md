# Detection Execution (Cron + Mgmt VM)

## Overview

Detection queries are executed periodically using cron on a dedicated management VM.

---

## Why Separate VM?

- Isolation of control plane
- Centralized execution of detection logic
- Avoid load on DB node

---

## Cron Job

```bash
* * * * * psql -h <DB_HOST> -U pgadmin_mgmt -d metrics -f /opt/detection/detect.sql >> /var/log/detect.log 2>&1
```

---

## Behavior

- Runs every 1 minute

- Executes detection rules

- Appends logs to /var/log/detect.log

---

## Validation
Check cron service
```
systemctl status cron
```

Check execution logs
```
tail -f /var/log/detect.log
```

Check system logs
```
grep CRON /var/log/syslog
```

---

## Common Issues

### Log file not created

Fix:
```
touch /var/log/detect.log
chmod 644 /var/log/detect.log
```

### No alerts generated

Check:
```
SELECT now(), max(alert_time)
FROM detection_alerts_v2;
```

---

## Security Note

Credentials were passed via environment:
```
PGPASSWORD='your-strong-password'
```
