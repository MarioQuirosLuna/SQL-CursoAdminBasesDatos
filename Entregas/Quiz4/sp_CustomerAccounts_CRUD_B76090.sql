
-- =============================================
-- Author:		Mario Quiros Luna
-- Create date: 6-5-2022
-- Description:	Procedimiento que pueda insertar, borrar o actualizar mediante un parametro "customerAccount" de la bd
-- =============================================
USE IF5100_2022_B76090
GO

CREATE PROCEDURE sp_CustomerAccounts_CRUD
	@param_Action VARCHAR(20),
	@param_CustomerAccountId INT = NULL,
	@param_ClientID INT = NULL,
	@param_CustomerName VARCHAR(25) = NULL,
	@param_CustomerLastName VARCHAR(25) = NULL,
	@param_PhoneNumber VARCHAR(15) = NULL,
	@param_AddressCountryName VARCHAR(50) = NULL,
	@param_AddressStateProvinceName VARCHAR(50) = NULL,
	@param_AddressDetails VARCHAR(200) = NULL,
	@param_CreditCardNumber VARCHAR(16) = NULL,
	@param_CreditCardBrandId INT = NULL,
	@param_ExpirationMonth SMALLINT = NULL,
	@param_ExpirationYear SMALLINT = NULL,
	@param_CVV SMALLINT = NULL

AS
BEGIN
BEGIN TRY
	IF((@param_Action = 'U' OR @param_Action = 'u' OR @param_Action = 'D' OR @param_Action = 'd' OR @param_Action = 'I' OR @param_Action = 'i') AND @param_Action != '')
	BEGIN
		IF(@param_Action = 'U' OR @param_Action = 'u')
		BEGIN
			BEGIN TRANSACTION
			BEGIN TRY

			--ACTUALIZA
			IF(@param_ClientID IS NOT NULL)
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
			IF(@param_CustomerName IS NOT NULL) 
			BEGIN
				UPDATE [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]
				SET [CUSTOMER_NAME] = @param_CustomerName
				WHERE [CUSTOMER_ACCOUNT_ID] = @param_CustomerAccountId
			END

			IF(@param_CustomerLastName IS NOT NULL)
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
						SET [IS_ACTIVE] = 0, [IS_DELETED] = 1
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
					IF(@param_ClientID IS NOT NULL AND @param_ClientID != '')
					BEGIN
						IF EXISTS(SELECT 1 FROM [CLI_COMMON].[tb_CLIENTS] WHERE [CLIENT_ID] = @param_ClientID)
						BEGIN
							IF(@param_CustomerName IS NOT NULL AND @param_CustomerName != '')
							BEGIN
								IF(@param_CustomerLastName IS NOT NULL AND @param_CustomerLastName != '')
								BEGIN
									IF (@param_AddressCountryName IS NOT NULL AND @param_AddressCountryName != '' AND
										@param_AddressStateProvinceName IS NOT NULL AND @param_AddressStateProvinceName != '' AND
										@param_PhoneNumber IS NOT NULL AND @param_PhoneNumber != '' AND
										@param_AddressDetails IS NOT NULL AND @param_AddressDetails != '')
									BEGIN
										BEGIN TRANSACTION
										BEGIN TRY

										DECLARE @idCustomerAccount INT
										DECLARE @idPhone INT
										DECLARE @idCountry INT
										DECLARE @idStateProvince INT
										DECLARE @idDetailsAddress INT
										DECLARE @idCreditCard INT

										--GUARDA TELEFONO
										INSERT INTO [CUSTOMERS].[tb_PHONE]
											   ([PHONE_NUMBER])
										 VALUES
											   (@param_PhoneNumber)
										SET @idPhone = SCOPE_IDENTITY()

										--BUSCA EL ID DEL PAIS
										SET @idCountry =(SELECT 
															[COUNTRY_ID]
														FROM [CUSTOMERS].[tb_COUNTRY]
														WHERE [COUNTRY_NAME] LIKE '%'+@param_AddressCountryName+'%')

										--BUSCA EL ID DE LA PROVINVIA
										SET @idStateProvince = (SELECT 
																	[STATE_PROVINCE_ID]
															  FROM [CUSTOMERS].[tb_STATE_PROVINCE]
															  WHERE [STATE_NAME] LIKE '%'+@param_AddressStateProvinceName+'%')
									
										--GUARDA EL DETALLE DE LA DIRECCION
										INSERT INTO [CUSTOMERS].[tb_ADDRESS]
											   ([DETAILS]
											   ,[STATE_PROVINCE_ID])
										 VALUES
											   (@param_AddressDetails, @idStateProvince)
										SET @idDetailsAddress = SCOPE_IDENTITY()

										--GUARDA EL CUSTOMER ACCOUNT
										INSERT INTO [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]
											([CLIENT_ID]
											,[CUSTOMER_NAME]
											,[CUSTOMER_LAST_NAME])
											VALUES
											(@param_ClientID
											,@param_CustomerName
											,@param_CustomerLastName)
										SET @idCustomerAccount = SCOPE_IDENTITY()

										IF (@param_CreditCardNumber IS NOT NULL AND @param_CreditCardNumber != ''
											AND @param_CreditCardBrandId IS NOT NULL AND @param_CreditCardBrandId != ''
											AND @param_ExpirationMonth IS NOT NULL AND @param_ExpirationMonth != ''
											AND @param_ExpirationYear IS NOT NULL AND @param_ExpirationYear != ''
											AND @param_CVV IS NOT NULL AND @param_CVV != '')
										BEGIN									
											--GUARDA LA TARJETA DE CREDITO
											INSERT INTO [CUSTOMERS].[tb_CREDIT_CARD]
												([CREDIT_CARD_NUMBER], [CREDIT_CARD_BRAND_ID]
												,[EXPIRATION_MONTH], [EXPIRATION_YEAR], [CVV])
											VALUES
												(@param_CreditCardNumber, @param_CreditCardBrandId
												,@param_ExpirationMonth, @param_ExpirationYear, @param_CVV)
											SET @idCreditCard = SCOPE_IDENTITY()
											
										END
										ELSE
										BEGIN
											SELECT 'Error falta algun dato de la tarjeta'
										END

										--GUARDA LA RELACION DE CUSTOMER Y PHONE
										INSERT INTO [CUSTOMERS].[tb_CUSTOMER_PHONES]
											   ([CUSTOMER_ACCOUNT_ID]
											   ,[PHONE_ID])
										 VALUES
											   (@idCustomerAccount, @idPhone)
									
										--GUARDA LA RELACION DE CUSTOMER Y ADDRESS
										INSERT INTO [CUSTOMERS].[tb_CUSTOMER_ADDRESSES]
											   ([CUSTOMER_ACCOUNT_ID]
											   ,[ADDRESS_ID])
										VALUES
											   (@idCustomerAccount, @idDetailsAddress)

										--GUARDA LA RELACION DE CUSTOMER Y CREDIT CARD
										INSERT INTO [CUSTOMERS].[tb_CUSTOMER_CREDIT_CARDS]
												([CUSTOMER_ACCOUNT_ID], [CREDIT_CARD_ID])
										VALUES
												(@idCustomerAccount, @idCreditCard)

										COMMIT
										END TRY
										BEGIN CATCH
											ROLLBACK
											SELECT ERROR_MESSAGE()
										END CATCH
									END
									ELSE
									BEGIN
										SELECT 'ERROR DATOS DE LA DIRECCION O TELEFONO NULL O VACIOS'
									END
								END
								ELSE
								BEGIN
									SELECT 'ERROR LAST NAME NULL O VACIO'
								END
							END
							ELSE
							BEGIN
								SELECT 'ERROR NAME NULL O VACIO'
							END
						END
						ELSE
						BEGIN
							SELECT 'ERROR CLIENT ID NO EXISTE'
						END
					END
					ELSE
					BEGIN
						SELECT 'CLIENT ID NULL O VACIO'
					END

				END --END INSERT
			END --END BORRAR
		END --END UPDATE
	END --END ACTION
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
