USE IF5100_2022_B76090

USE [IF5100_2022_B76090]
GO
INSERT INTO [CUSTOMERS].[tb_COUNTRY]
           ([COUNTRY_NAME]
           ,[IS_ACTIVE]
           ,[IS_DELETED]
           ,[LAST_MODIFIED_BY]
           ,[LAST_MODIFIED_DATE])
     VALUES
           ('Costa Rica'
           ,1
           ,0
           ,SUSER_NAME()
           ,GETDATE()),
		   ('Mexico'
           ,1
           ,0
           ,SUSER_NAME()
           ,GETDATE()),
		   ('Estados Unidos'
           ,1
           ,0
           ,SUSER_NAME()
           ,GETDATE())
GO

USE [IF5100_2022_B76090]
GO
INSERT INTO [CUSTOMERS].[tb_STATE_PROVINCE]
           ([STATE_NAME]
           ,[COUNTRY_ID]
           ,[IS_ACTIVE]
           ,[IS_DELETED]
           ,[LAST_MODIFIED_BY]
           ,[LAST_MODIFIED_DATE])
     VALUES
           ('San Jose'
           ,1
           ,1
           ,0
           ,SUSER_NAME()
           ,GETDATE()),
		   ('Mexico DC'
           ,3
           ,1
           ,0
           ,SUSER_NAME()
           ,GETDATE()),
		   ('Oregon'
           ,2
           ,1
           ,0
           ,SUSER_NAME()
           ,GETDATE())
GO

USE [IF5100_2022_B76090]
GO
INSERT INTO [CUSTOMERS].[tb_ADDRESS]
           ([DETAILS]
           ,[STATE_PROVINCE_ID]
           ,[IS_ACTIVE]
           ,[IS_DELETED]
           ,[LAST_MODIFIED_BY]
           ,[LAST_MODIFIED_DATE])
     VALUES
           ('San Pedro'
           ,1
           ,1
           ,0
           ,SUSER_NAME()
           ,GETDATE()),
		   ('Paseo la reforma'
           ,2
           ,1
           ,0
           ,SUSER_NAME()
           ,GETDATE()),
		   ('Clackamas'
           ,3
           ,1
           ,0
           ,SUSER_NAME()
           ,GETDATE())
GO

USE [IF5100_2022_B76090]
GO
INSERT INTO [CUSTOMERS].[tb_PHONE]
(
	[PHONE_NUMBER]
    ,[IS_ACTIVE]
    ,[IS_DELETED]
    ,[LAST_MODIFIED_BY]
    ,[LAST_MODIFIED_DATE])
VALUES
(
	'87111111'
    ,1
    ,0
    ,SUSER_NAME()
    ,GETDATE()
),
(
	'87222222'
	,1
	,0
	,SUSER_NAME()
	,GETDATE()
),
(
	'87333333'
	,1
	,0
	,SUSER_NAME()
	,GETDATE()
),
(
	'87444444'
    ,1
    ,0
    ,SUSER_NAME()
    ,GETDATE()
),
(
	'87555555'
	,1
	,0
	,SUSER_NAME()
	,GETDATE()
),
(
	'87666666'
	,1
	,0
	,SUSER_NAME()
	,GETDATE()
),
(
	'87777777'
    ,1
    ,0
    ,SUSER_NAME()
    ,GETDATE()
)
GO


USE [IF5100_2022_B76090]
GO
INSERT INTO [CLI_COMMON].[tb_CLIENTS]
           ([NAME]
           ,[INDUSTRY_DESC]
           ,[IS_ACTIVE]
           ,[IS_DELETED]
           ,[LAST_MODIFIED_BY]
           ,[LAST_MODIFIED_DATE])
     VALUES
           ('BAC'
           ,'Empty Data'
           ,1
           ,0
           ,SUSER_NAME()
           ,GETDATE()),
		   ('BN'
           ,'Empty Data'
           ,1
           ,0
           ,SUSER_NAME()
           ,GETDATE()),
		   ('BCR'
           ,'Empty Data'
           ,1
           ,0
           ,SUSER_NAME()
           ,GETDATE()),
		   ('BP'
           ,''
           ,1
           ,0
           ,SUSER_NAME()
           ,GETDATE())
GO

USE [IF5100_2022_B76090]
GO
UPDATE [CLI_COMMON].[tb_CLIENTS]
   SET 
      [INDUSTRY_DESC] = 'Financiero'
 WHERE [CLI_COMMON].[tb_CLIENTS].CLIENT_ID != 1
GO

SELECT * FROM [CLI_COMMON].[tb_CLIENTS]


USE [IF5100_2022_B76090]
GO
INSERT INTO [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]
           ([CLIENT_ID]
           ,[CUSTOMER_NAME]
           ,[CUSTOMER_LAST_NAME]
           ,[IS_ACTIVE]
           ,[IS_DELETED]
           ,[LAST_MODIFIED_BY]
           ,[LAST_MODIFIED_DATE])
     VALUES
           (1000
           ,'Mario'
           ,'Quirós Luna'
           ,1
           ,0
           ,SUSER_NAME()
           ,GETDATE()),
		   (1000
           ,'ISA'
           ,'Portugues Calderón'
           ,1
           ,0
           ,SUSER_NAME()
           ,GETDATE()),
		   (1000
           ,'Franklin'
           ,'Salas Fernandez'
           ,1
           ,0
           ,SUSER_NAME()
           ,GETDATE())
GO

USE [IF5100_2022_B76090]
GO

UPDATE [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]
   SET [CLIENT_ID] = 1002,
	[LAST_MODIFIED_BY] = SUSER_NAME(),
	[LAST_MODIFIED_DATE] = GETDATE()
 WHERE [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS].CUSTOMER_ACCOUNT_ID = 3
GO


select * from [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]


SELECT * FROM [CUSTOMERS].tb_PHONE
SELECT * FROM [CUSTOMERS].tb_CUSTOMER_ACCOUNTS

USE [IF5100_2022_B76090]
GO
INSERT INTO [CUSTOMERS].[tb_CUSTOMER_PHONES]
           ([CUSTOMER_ACCOUNT_ID]
           ,[PHONE_ID]
           ,[IS_ACTIVE]
           ,[IS_DELETED]
           ,[LAST_MODIFIED_BY]
           ,[LAST_MODIFIED_DATE])
     VALUES
(
	1
    ,1
    ,1
    ,0
    ,SUSER_NAME()
    ,GETDATE()
),
(
	2
	,2
    ,1
    ,0
    ,SUSER_NAME()
    ,GETDATE()
),
(
	3
    ,3
    ,1
    ,0
    ,SUSER_NAME()
    ,GETDATE()
),
(
	1
    ,4
    ,1
    ,0
    ,SUSER_NAME()
    ,GETDATE()
),
(
	2
	,5
    ,1
    ,0
    ,SUSER_NAME()
    ,GETDATE()
),
(
	3
    ,6
    ,1
    ,0
    ,SUSER_NAME()
    ,GETDATE()
),
(
	1
    ,7
    ,1
    ,0
    ,SUSER_NAME()
    ,GETDATE()
)
GO

SELECT * FROM [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]
SELECT * FROM [CUSTOMERS].[tb_CUSTOMER_PHONES]
SELECT * FROM [CUSTOMERS].[tb_PHONE]


