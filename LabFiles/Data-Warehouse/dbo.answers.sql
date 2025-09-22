-------------------
-- CREATE TABLE
-------------------
--DROP TABLE dbo.answers
CREATE TABLE dbo.answers (
    questionId      	bigint			NULL
,   question		varchar(500)		NULL	
,   connectionId	varchar(100)		NULL
,   userAgent		varchar(100)		NULL
,   answerId		int			NULL
,   answer 		varchar(2000)		NULL
,   responseTime   	smallint		NULL
,   createdAt		date			NULL
)	