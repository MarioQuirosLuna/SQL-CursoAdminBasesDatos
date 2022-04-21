USE [IF5100_2022_B76090]

GO
INSERT INTO [CUSTOMERS].[tb_COUNTRY]
    ([COUNTRY_NAME]
    ,[IS_ACTIVE]
    ,[IS_DELETED]
    ,[LAST_MODIFIED_BY]
    ,[LAST_MODIFIED_DATE])
VALUES
(
	'Panama'
	,1
	,0
	,SUSER_NAME()
	,GETDATE()
),(
	'Espana'
	,1
	,0
	,SUSER_NAME()
	,GETDATE()
),(
	'Bolivia'
	,1
	,0
	,SUSER_NAME()
	,GETDATE()
),(
	'El Salvador'
	,1
	,0
	,SUSER_NAME()
	,GETDATE()
),(
	'Honduras'
	,1
	,0
	,SUSER_NAME()
	,GETDATE()
),(
	'Alemania'
	,1
	,0
	,SUSER_NAME()
	,GETDATE()
),(
	'Austria'
	,1
	,0
	,SUSER_NAME()
	,GETDATE()
)
GO

SELECT * FROM CUSTOMERS.tb_COUNTRY
