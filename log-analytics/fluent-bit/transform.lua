function build_record(tag, timestamp, record)
    local ts = os.date("%Y-%m-%d %H:%M:%S")

    local service = "journald"
    if record["_SYSTEMD_UNIT"] ~= nil then
        service = record["_SYSTEMD_UNIT"]
    elseif record["SYSLOG_IDENTIFIER"] ~= nil then
        service = record["SYSLOG_IDENTIFIER"]
    end

    local level = "info"
    if record["PRIORITY"] ~= nil then
        level = tostring(record["PRIORITY"])
    end

    local message = ""
    if record["MESSAGE"] ~= nil then
        message = tostring(record["MESSAGE"])
    end

    local raw = message
    if record["MESSAGE"] ~= nil then
        raw = tostring(record["MESSAGE"])
    end

    local new_record = {
        timestamp = ts,
        hostname = "edge-proxy",
        service = service,
        level = level,
        source_type = "journald",
        message = message,
        raw = raw
    }

    return 1, timestamp, new_record
end