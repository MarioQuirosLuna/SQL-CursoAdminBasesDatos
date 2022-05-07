
-- =============================================
-- Author:		Mario Quiros Luna
-- Create date: 6-5-2022
-- Description:	Procedimiento que pueda insertar, borrar o actualizar mediante un parametro "customerAccount" de la bd
-- =============================================
CREATE PROCEDURE sp_CustomerAccounts_CRUD
	@param_Action VARCHAR(20),
	@param_CustomerAccountId INT = NULL,
	@param_ClientID INT = NULL,
	@param_CustomerName VARCHAR(25) = NULL,
	@param_CustomerLastName VARCHAR(25) = NULL,
	@param_PhoneNumber VARCHAR(15) = NULL,
	@param_AddressCountryName VARCHAR(50) = NULL,
	@param_AddressStateProvinceName VARCHAR(50) = NULL,
	@param_AddressDetails VARCHAR(200) = NULL
AS
BEGIN
BEGIN TRY
	IF(@param_Action = 'U' OR @param_Action = 'u' OR @param_Action = 'D' OR @param_Action = 'd' OR @param_Action = 'I' OR @param_Action = 'i')
	BEGIN
		IF(@param_Action = 'U' OR @param_Action = 'u')
		BEGIN
			BEGIN TRANSACTION
			BEGIN TRY

			--ACTUALIZA
			IF(@param_ClientID) IS NOT NULL
			BEGIN
				IF EXISTS(SELECT 1 FROM [CLI_COMMON].[tb_CLIENTS] WHERE [CLIENT_ID] = @param_ClientID)
				BEGIN
					UPDATE [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]
					SET [CLIENT_ID] = @param_ClientID
					WHERE [CUSTOMER_ACCOUNT_ID] = @param_CustomerAccountId
				END
				ELSE
				BEGIN
					SELECT 'CLIENT ID NO EXISTE'
				END
			END
			IF(@param_CustomerName) IS NOT NULL
			BEGIN
				UPDATE [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]
				SET [CUSTOMER_NAME] = @param_CustomerName
				WHERE [CUSTOMER_ACCOUNT_ID] = @param_CustomerAccountId
			END

			IF(@param_CustomerLastName) IS NOT NULL
			BEGIN
				UPDATE [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]
				SET [CUSTOMER_LAST_NAME] = @param_CustomerLastName
				WHERE [CUSTOMER_ACCOUNT_ID] = @param_CustomerAccountId
			END

			COMMIT
			
			END TRY
			BEGIN CATCH
				ROLLBACK
				SELECT ERROR_MESSAGE()
			END CATCH
		END
		ELSE
		BEGIN
			IF(@param_Action = 'D' OR @param_Action = 'd')
			BEGIN
				--BORRA
				IF EXISTS(SELECT 1 FROM [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS] WHERE [CUSTOMER_ACCOUNT_ID] = @param_CustomerAccountId)
				BEGIN
					UPDATE [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]
						SET [IS_DELETED] = 1
						WHERE [CUSTOMER_ACCOUNT_ID] = @param_CustomerAccountId
				END
				ELSE
				BEGIN
					SELECT 'CUSTOMER ACCOUNT NO EXISTE'
				END
			END
			ELSE
			BEGIN
				IF(@param_Action = 'I' OR @param_Action = 'i')
				BEGIN
					--INSERTA
					IF EXISTS(SELECT 1 FROM [CLI_COMMON].[tb_CLIENTS] WHERE [CLIENT_ID] = @param_ClientID)
					BEGIN
						IF(@param_ClientID) IS NOT NULL
						BEGIN
							IF(@param_CustomerName) IS NOT NULL
							BEGIN
								IF(@param_CustomerLastName) IS NOT NULL
								BEGIN
									BEGIN TRANSACTION
									BEGIN TRY
									--SCOPE IDENTITY() ULTIMO DATO ALMACENADO
									DECLARE @idPhone INT
									DECLARE @idCountry INT
									DECLARE @idStateProvince INT
									DECLARE @idDetailsAddress INT

									INSERT INTO [CUSTOMERS].[tb_PHONE]
										   ([PHONE_NUMBER])
									 VALUES
										   (@param_PhoneNumber)
									--SELECT TOP 1
										--SET @idPhone = [PHONE_ID]
									--FROM [CUSTOMERS].[tb_PHONE]
									--WHERE [PHONE_NUMBER] = @param_PhoneNumber

									INSERT INTO [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]
										([CLIENT_ID]
										,[CUSTOMER_NAME]
										,[CUSTOMER_LAST_NAME])
										VALUES
										(@param_ClientID
										,@param_CustomerName
										,@param_CustomerLastName)

									COMMIT
									END TRY
									BEGIN CATCH
										ROLLBACK
										SELECT ERROR_MESSAGE()
									END CATCH
								END
							END
						END
					END
					ELSE
					BEGIN
						SELECT 'CLIENT ID NO EXISTE'
					END

				END
			END
		END
	END
	ELSE
	BEGIN
		SELECT 'ERROR PARAM ACTION'
	END
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE()
END CATCH
END
GO
