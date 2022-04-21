-- =============================================
-- Author:		Mario Quiros Luna
-- Create date: 20/04/2022
-- Description:	Simula la insercion de cuentas cliente en la base de datos. 
--				Usando una tabla con nombres dummy y otra con apellitos dummy para crear nombres aleatorios.
-- =============================================
CREATE PROCEDURE FINANCIAL_DEPOSIT.sp_INSERT_CUSTOMER_ACCOUNT_MOCK
AS
BEGIN

	INSERT INTO [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS] (
		[CLIENT_ID], [CUSTOMER_NAME], [CUSTOMER_LAST_NAME], [IS_ACTIVE], [IS_DELETED], [LAST_MODIFIED_BY], [LAST_MODIFIED_DATE]
	) VALUES (
	FLOOR(RAND()*(1003-1000+1)+1000),
	(
		SELECT 
			first_name
		FROM MOCKS.MOCK_DATA_FIRST_NAMES
		WHERE ID = FLOOR(RAND()*(500-1+1)+1) 
	),
	(
		SELECT 
			last_name
		FROM MOCKS.MOCK_DATA_LAST_NAMES
		WHERE ID = FLOOR(RAND()*(500-1+1)+1) 
	),
	1,
	0,
	SUSER_NAME(),
	GETDATE());
END
GO