-------------
--Statistics
-------------
CREATE STATISTICS Sales_SalesKey_FullScan ON dbo.Sales (SalesKey) WITH FULLSCAN;

UPDATE STATISTICS dbo.Sales (Sales_SalesKey_FullScan) WITH FULLSCAN;

DBCC SHOW_STATISTICS ("dbo.Sales", "Sales_SalesKey_FullScan") WITH HISTOGRAM;

SELECT object_name(s.object_id) AS [object_name]
	,c.name AS [column_name]
	,s.name AS [stats_name]
	,s.stats_id
	,STATS_DATE(s.object_id, s.stats_id) AS [stats_update_date]
	,s.auto_created
	,s.user_created
	,s.stats_generation_method_desc
FROM sys.stats AS s
INNER JOIN sys.objects AS o ON o.object_id = s.object_id
INNER JOIN sys.stats_columns AS sc ON s.object_id = sc.object_id
	AND s.stats_id = sc.stats_id
INNER JOIN sys.columns AS c ON sc.object_id = c.object_id
	AND c.column_id = sc.column_id
WHERE o.type = 'U'
	--AND s.auto_created = 1
	AND o.name = 'Sales'
ORDER BY object_name
	,column_name;

-------------
--Monitor a data warehouse in Microsoft Fabric
-------------
--connections
SELECT connections.connection_id,
 connections.connect_time,
 sessions.session_id, sessions.login_name, sessions.login_time, sessions.status
FROM sys.dm_exec_connections AS connections
INNER JOIN sys.dm_exec_sessions AS sessions
ON connections.session_id=sessions.session_id;

--exec query
SELECT request_id, session_id, start_time, total_elapsed_time
FROM sys.dm_exec_requests
WHERE status = 'running'
ORDER BY total_elapsed_time DESC;

-------------
--Query insights in Fabric data warehousing
--https://learn.microsoft.com/ko-kr/fabric/data-warehouse/query-insights
-------------

--Identify queries run by you in the last 30 minutes
SELECT * 
FROM queryinsights.exec_requests_history 
WHERE start_time >= DATEADD(MINUTE, -30, GETUTCDATE())
AND login_name = USER_NAME();

--Identify the most frequently run queries using a substring in the query text
SELECT * 
FROM queryinsights.frequently_run_queries
WHERE last_run_command LIKE '%*****%'
ORDER BY number_of_successful_runs DESC;

--Identify long-running queries using a substring in the query text
SELECT * 
FROM queryinsights.long_running_queries
WHERE last_run_command LIKE '%*****%'
ORDER BY median_total_elapsed_time_ms DESC;