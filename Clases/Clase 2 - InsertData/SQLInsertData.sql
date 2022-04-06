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
           ([PHONE_NUMBER]
           ,[IS_ACTIVE]
           ,[IS_DELETED]
           ,[LAST_MODIFIED_BY]
           ,[LAST_MODIFIED_DATE])
     VALUES
           ('87111111'
           ,1
           ,0
           ,SUSER_NAME()
           ,GETDATE()),
		   ('87222222'
           ,1
           ,0
           ,SUSER_NAME()
           ,GETDATE()),
		   ('87333333'
           ,1
           ,0
           ,SUSER_NAME()
           ,GETDATE())
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
   SET [CUSTOMER_NAME] = 'Isabel'
 WHERE [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS].CUSTOMER_ACCOUNT_ID = 2
GO


select * from [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]