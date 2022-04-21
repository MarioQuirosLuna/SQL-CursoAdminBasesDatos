USE IF5100_2022_B76090
 
INSERT INTO [FINANCIAL_DEPOSIT].[tb_PAYMENT_TYPE]
    ([PAYMENT_TYPE]
    ,[IS_ACTIVE]
    ,[IS_DELETED]
    ,[LAST_MODIFIED_BY]
    ,[LAST_MODIFIED_DATE])
VALUES
    ('Bitcoin'
    ,1
    ,0
    ,SUSER_NAME()
    ,GETDATE()),
	('Paypal'
    ,1
    ,0
    ,SUSER_NAME()
    ,GETDATE()),
	('Tarjeta de credito'
    ,1
    ,0
    ,SUSER_NAME()
    ,GETDATE()),
	('Tarjeta de debito'
    ,1
    ,0
    ,SUSER_NAME()
    ,GETDATE()),
	('Criptomoneda'
    ,1
    ,0
    ,SUSER_NAME()
    ,GETDATE())

SELECT * FROM [FINANCIAL_DEPOSIT].[tb_PAYMENT_TYPE]