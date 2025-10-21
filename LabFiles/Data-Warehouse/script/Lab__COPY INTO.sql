-------------
--CREATE TABLE
-------------
--DROP TABLE dbo.answers
CREATE TABLE dbo.answers (
    questionId          bigint              NULL
,   question            varchar(500)        NULL
,   connectionId        varchar(100)        NULL
,   userAgent           varchar(100)        NULL
,   answerId            int                 NULL
,   answer              varchar(2000)       NULL
,   responseTime        smallint            NULL
,   createdAt            date                NULL
)
GO
-------------
--DATA COPY
-------------
COPY INTO dbo.answers
FROM 'https://mskranalyticwestus3.dfs.core.windows.net/datasets/answers.csv' WITH ( 
            FILE_TYPE = 'CSV'
            ,CREDENTIAL = ( 
                IDENTITY = 'Shared Access Signature'
                , SECRET = '?sv={enter-SAS-Token}'
                )
            ,FIRSTROW = 2
			,FIELDTERMINATOR=','
            )
GO


SELECT COUNT(*) FROM dbo.answers;
