# Issues Faced & Fixes

---

## 1. SSH Host Key Error

Cause:
- VM recreated with same IP

Fix:
```bash
ssh-keygen -R <IP>
```

---

## 2. Log File Not Found

Cause:

ingestion script ran on wrong VM

Fix:
```
run on edge-proxy OR fetch logs
```

---

## 3. PostgreSQL Table Not Found

Error:
```
relation "security_events" does not exist
```

Cause:

- wrong DB/schema

Fix:

- verified DB using:
```
SELECT current_database();
```

---

## 4. Hypertable Unique Index Error

Error:
```
cannot create unique index without partition column
```

Fix:

- switched to normal table

---

## 5. Cron Not Working (False Alarm)

Observation:

- log file empty

Reality:

- cron working

- SQL produced no output

---

## 6. psql not found in cron

Fix:

- use full path:
```
/usr/bin/psql
```

---

## 7. Password issue in cron

Fix:

- use  ```.pgpass```
