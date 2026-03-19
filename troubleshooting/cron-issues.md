## Problem: No log output

Cause:
- `ON CONFLICT DO NOTHING` produces no output

---

## Problem: command not found

#### Fix:
- Use full path:

```
/usr/bin/psql
```

## Problem: password prompt

#### Fix:
Use ```.pgpass```

## Debug Commands
```
systemctl status cron
grep CRON /var/log/syslog
```