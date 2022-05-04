USE IF5100_2022_B76090

-- TEST1: MOVER DINERO DE CUENTA 1 A 2 CON DINERO SUFICIENTE
EXEC [dbo].[sp_MoveMoneyFromCustomerAccount] @param_CustomerAccountIdSource = 1,
	@param_CustomerAccountIdDestination = 2,
	@param_Amount = 2000

SELECT * FROM [CUSTOMERS].[tb_BALANCE]
SELECT * FROM [FINANCIAL_DEPOSIT].[tb_EVENTS]


-- TEST2: MOVER DINERO DE CUENTA 1 A 2 CON DINERO INSUFICIENTE
EXEC [dbo].[sp_MoveMoneyFromCustomerAccount] @param_CustomerAccountIdSource = 1,
	@param_CustomerAccountIdDestination = 2,
	@param_Amount = 230000

SELECT * FROM [CUSTOMERS].[tb_BALANCE]
SELECT * FROM [FINANCIAL_DEPOSIT].[tb_ERROR]



-- TEST3: MOVER DINERO DE CUENTA 1 A 2 CON CUENTA 1 INEXISTENTE
EXEC [dbo].[sp_MoveMoneyFromCustomerAccount] @param_CustomerAccountIdSource = 112312,
	@param_CustomerAccountIdDestination = 2,
	@param_Amount = 2000

SELECT * FROM [CUSTOMERS].[tb_BALANCE]
SELECT * FROM [FINANCIAL_DEPOSIT].[tb_ERROR]

-- TEST4: MOVER DINERO DE CUENTA 1 A 2 CON CUENTA 2 INEXISTENTE
EXEC [dbo].[sp_MoveMoneyFromCustomerAccount] @param_CustomerAccountIdSource = 1,
	@param_CustomerAccountIdDestination = 112312,
	@param_Amount = 2000

SELECT * FROM [CUSTOMERS].[tb_BALANCE]
SELECT * FROM [FINANCIAL_DEPOSIT].[tb_ERROR]