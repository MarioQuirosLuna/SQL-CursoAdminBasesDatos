--id usuario, nombre completo, telefono mas reciente, cantidad de telefonos

USE [IF5100_2022_B76090]
GO
SELECT 
	[tb_CUSTOMER_ACCOUNTS].[CUSTOMER_ACCOUNT_ID]
    ,[CUSTOMER_NAME]+' '+[CUSTOMER_LAST_NAME] AS FULL_NAME
	,PHONE.PHONE_NUMBER AS LAST_PHONE
	,(
		SELECT
			COUNT(CUSTOMER_ACCOUNT_ID)
		FROM [CUSTOMERS].tb_CUSTOMER_PHONES
		WHERE tb_CUSTOMER_ACCOUNTS.[CUSTOMER_ACCOUNT_ID] = tb_CUSTOMER_PHONES.CUSTOMER_ACCOUNT_ID
	) AS CANT_PHONES
FROM [CUSTOMERS].tb_CUSTOMER_ACCOUNTS
	CROSS APPLY (
		SELECT TOP 1
			CUSTOMER_ACCOUNT_ID
			,tb_PHONE.PHONE_ID
			,tb_PHONE.PHONE_NUMBER
			,tb_PHONE.LAST_MODIFIED_DATE
		FROM [CUSTOMERS].tb_CUSTOMER_PHONES
			JOIN [CUSTOMERS].tb_PHONE
			ON [tb_CUSTOMER_PHONES].PHONE_ID = [tb_PHONE].PHONE_ID
		WHERE tb_CUSTOMER_ACCOUNTS.CUSTOMER_ACCOUNT_ID = tb_CUSTOMER_PHONES.CUSTOMER_ACCOUNT_ID
		ORDER BY tb_PHONE.LAST_MODIFIED_DATE DESC
	) AS PHONE
GO



SELECT * FROM [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]
SELECT * FROM [CUSTOMERS].tb_CUSTOMER_PHONES
SELECT * FROM [CUSTOMERS].tb_PHONE