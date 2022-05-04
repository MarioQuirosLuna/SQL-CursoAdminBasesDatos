-- =============================================
-- Author:		Mario Quiros Luna
-- Create date: 2-5-2022
-- Description:	Mueve dinero
-- =============================================
CREATE PROCEDURE sp_MoveMoneyFromCustomerAccount
	@param_CustomerAccountIdSource INT = NULL,
	@param_CustomerAccountIdDestination INT = NULL,
	@param_Amount NUMERIC(9,3)
AS
BEGIN
BEGIN TRY

	IF EXISTS(	SELECT TOP 1 
					1 --DEVUELVE 1 SI EXISTE
				FROM CUSTOMERS.tb_CUSTOMER_ACCOUNTS
				WHERE CUSTOMER_ACCOUNT_ID = @param_CustomerAccountIdSource)
		BEGIN

			DECLARE @local_BALANCE NUMERIC(9,3) = (
													SELECT TOP 1 BALANCE
													FROM [CUSTOMERS].[tb_BALANCE]
													WHERE CUSTOMER_ACCOUNT_ID = @param_CustomerAccountIdSource
												)

			IF EXISTS(	SELECT TOP 1
							1
						FROM CUSTOMERS.tb_CUSTOMER_ACCOUNTS
						WHERE CUSTOMER_ACCOUNT_ID = @param_CustomerAccountIdDestination)
				BEGIN
					
					IF(@param_Amount <= @local_BALANCE)
					BEGIN

						BEGIN TRANSACTION

						UPDATE CUSTOMERS.tb_BALANCE
						SET BALANCE = BALANCE - @param_Amount
						WHERE CUSTOMER_ACCOUNT_ID = @param_CustomerAccountIdSource

						UPDATE CUSTOMERS.tb_BALANCE
						SET BALANCE = BALANCE + @param_Amount
						WHERE CUSTOMER_ACCOUNT_ID = @param_CustomerAccountIdDestination

						COMMIT

					END --BALANCE CONDITIONAL
					ELSE
					BEGIN
						SELECT 'ERROR'
					END
				END --
		
		END

END TRY
BEGIN CATCH

	--SE PUEDE TENER UNA TABLA DONDE SE GUARDAN TODOS LOS ERRORES CON LOS DETALLES
	PRINT N''+@@ERROR
	ROLLBACK

END CATCH

END
GO
