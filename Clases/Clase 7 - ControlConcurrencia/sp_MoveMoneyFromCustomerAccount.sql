-- =============================================
-- Author:		Mario Quiros Luna
-- DataBase:	IF5100_2022_B76090
-- Create date: 2-5-2022
-- Description:	Mueve dinero guardano errores y eventos
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
						BEGIN TRY

							UPDATE CUSTOMERS.tb_BALANCE
							SET BALANCE = BALANCE - @param_Amount
							WHERE CUSTOMER_ACCOUNT_ID = @param_CustomerAccountIdSource

							UPDATE CUSTOMERS.tb_BALANCE
							SET BALANCE = BALANCE + @param_Amount
							WHERE CUSTOMER_ACCOUNT_ID = @param_CustomerAccountIdDestination

							INSERT INTO [FINANCIAL_DEPOSIT].[tb_EVENTS]
								([CLIENT_ID]
								,[EVENT_TYPE_ID]
								,[CUSTOMER_ACCOUNT_ID]
								,[AMOUNT]
								,[PAYMENT_TYPE_ID]
								,[CURRENCY_ID])
							VALUES
								((SELECT CLIENT_ID FROM [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS] WHERE CUSTOMER_ACCOUNT_ID = @param_CustomerAccountIdSource)
								,4 --SINPE
								,@param_CustomerAccountIdSource
								,@param_Amount
								,4  --Tarjeta de debito
								,3) --Colon

							COMMIT

						END TRY
						BEGIN CATCH
							ROLLBACK

							EXEC [dbo].[sp_SaveErrorsDB] 
								@param_IdSource = @param_CustomerAccountIdSource,
								@param_Destination = @param_CustomerAccountIdDestination,
								@param_ErrorMessage = NULL,
								@param_EventType = 4
						END CATCH

					END --BALANCE CONDITIONAL
					ELSE
					BEGIN
					EXEC [dbo].[sp_SaveErrorsDB] 
						@param_IdSource = @param_CustomerAccountIdSource,
						@param_Destination = @param_CustomerAccountIdDestination,
						@param_ErrorMessage = 'Saldo es insuficiente para la transaccion',
						@param_EventType = 4
					END -- ELSE BALANCE CONDITIONAL
				END -- EXISTS DESTINATION
				ELSE
				BEGIN
					EXEC [dbo].[sp_SaveErrorsDB] 
						@param_IdSource = @param_CustomerAccountIdSource,
						@param_Destination = @param_CustomerAccountIdDestination,
						@param_ErrorMessage = 'Destinatario inexistente',
						@param_EventType = 4
				END -- ELSE DESTINATION
		END -- EXISTS SOURCE
		ELSE
		BEGIN
			EXEC [dbo].[sp_SaveErrorsDB] 
				@param_IdSource = @param_CustomerAccountIdSource,
				@param_Destination = @param_CustomerAccountIdDestination,
				@param_ErrorMessage = 'Fuente inexistente',
				@param_EventType = 4
		END -- ELSE SOURCE

END TRY
BEGIN CATCH
	EXEC [dbo].[sp_SaveErrorsDB] 
		@param_IdSource = @param_CustomerAccountIdSource,
		@param_Destination = @param_CustomerAccountIdDestination,
		@param_ErrorMessage = NULL,
		@param_EventType = 4
END CATCH
END
GO
