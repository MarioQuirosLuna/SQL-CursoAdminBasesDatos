USE IF5100_2022_B76090
GO

SELECT * FROM [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]
SELECT * FROM [CLI_COMMON].[tb_CLIENTS]


USE [IF5100_2022_B76090]
GO
INSERT INTO [CUSTOMERS].[tb_BALANCE]
           ([CUSTOMER_ACCOUNT_ID]
           ,[ID_CLIENT]
           ,[BALANCE])
     VALUES
           (1, 1000, 10000),
		   (2, 1000, 10000)
GO

SELECT * FROM [CUSTOMERS].[tb_BALANCE]

EXEC [dbo].[sp_MoveMoneyFromCustomerAccount] @param_CustomerAccountIdSource = 1,
	@param_CustomerAccountIdDestination = 2,
	@param_Amount = 1000


EXEC [dbo].[sp_MoveMoneyFromCustomerAccount] @param_CustomerAccountIdSource = 1,
	@param_CustomerAccountIdDestination = 2,
	@param_Amount = 2000

SELECT * FROM [CUSTOMERS].[tb_BALANCE]
SELECT * FROM [FINANCIAL_DEPOSIT].[tb_ERROR]
SELECT * FROM [FINANCIAL_DEPOSIT].[tb_EVENTS]
