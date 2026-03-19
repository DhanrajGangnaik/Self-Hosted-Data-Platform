-- Check current database
SELECT current_database();

-- Check connection info
SELECT inet_server_addr(), inet_server_port(), version();

-- Verify table existence
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_name = 'security_events';

-- Preview raw data
SELECT *
FROM security_events
ORDER BY time DESC
LIMIT 20;