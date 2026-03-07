CREATE DATABASE IF NOT EXISTS logs;

CREATE TABLE IF NOT EXISTS logs.platform_logs
(
    timestamp DateTime,
    hostname String,
    service String,
    level String,
    source_type String,
    message String,
    raw String
)
ENGINE = MergeTree
PARTITION BY toDate(timestamp)
ORDER BY (hostname, service, timestamp)
TTL timestamp + INTERVAL 30 DAY;