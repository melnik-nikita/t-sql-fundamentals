USE TSQLV4;

-- Ex1
SELECT -- use * to explore
    request_session_id AS sid,
    resource_type AS restype,
    resource_database_id AS dbid,
    resource_description as res,
    resource_associated_entity_id AS resid,
    request_mode AS mode,
    request_status AS status
FROM sys.dm_tran_locks;

-- Connection info:
SELECT -- use * to explore
    session_id AS sid,
    connect_time,
    last_read,
    last_write,
    most_recent_sql_handle
FROM sys.dm_exec_connections
WHERE session_id IN(60, 65);
-- Session info
SELECT -- use * to explore
    session_id AS sid,
    login_time,
    host_name,
    program_name,
    login_name,
    nt_user_name,
    last_request_start_time,
    last_request_end_time
FROM sys.dm_exec_sessions
WHERE session_id IN(60, 65);
-- Blocking
SELECT -- use * to explore
    session_id AS sid,
    blocking_session_id,
    command,
    sql_handle,
    database_id,
    wait_type,
    wait_time,
    wait_resource
FROM sys.dm_exec_requests
WHERE blocking_session_id > 0;

SELECT session_id, text
FROM sys.dm_exec_connections
CROSS APPLY sys.dm_exec_sql_text(most_recent_sql_handle) AS ST
WHERE session_id IN(60, 65);

-- Ex2
