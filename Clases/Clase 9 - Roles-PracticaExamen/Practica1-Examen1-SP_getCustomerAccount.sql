-- =============================================
-- Author:		MarioQuirosLuna
-- Create date: 22-5-2022
-- Description:	
/**
1) Crear un procedimiento almacenado que reciba un parámetro (customerAccountId), el mismo tiene que retornar:

CustomerAccountId	
NombreCompleto
Tarjeta de Crédito (tiene que desencriptarlo y mostrar solo los primeros 4 números y los últimos 4)
Continente al que pertenece el customer (ejemplo: Costa Rica = América, China = Asia)
	
	1.1 Deberá permitir leer datos no committeados para evitar un bloqueo en la BD.
	1.2 Deberá hacer uso del try-catch para control de errores, y si algo falla durante la ejecución deberá 
	documentarlo en una tabla de errores (tiene que crear una tabla de errores)
	1.3 Si el customerAccountId no existe deberá retornar lo siguiente:
		CustomerAccountId = -1
		NombreCompleto    = N/A
		TC                            = N/A
	Deberá guardar en la tabla de errores que se buscó un “customer” que no existe
	1.4 Si no hay parámetro, devuelven toda la información de las tablas

	Tabla de errores:
		ErrorId
		Description (@@error)
		UserId
		Datetime
*/
-- =============================================
CREATE PROCEDURE sp_getCustomerAccount
	@param_CustomerAccountId INT = NULL
AS
BEGIN 
	BEGIN TRY
		OPEN SYMMETRIC KEY SymmetricKey  
		DECRYPTION BY CERTIFICATE CreditCardCertificate;  
			
		IF (@param_CustomerAccountId IS NULL OR @param_CustomerAccountId = '')
		BEGIN
			SELECT
				CA.CUSTOMER_ACCOUNT_ID,
				CA.CUSTOMER_NAME +' '+ CA.CUSTOMER_LAST_NAME AS NAME,
				CC.CREDIT_CARD_NUMBER_ENCRYPTED,
				REPLACE(REPLACE(CONVERT(VARCHAR, DecryptByKey(CC.CREDIT_CARD_NUMBER_ENCRYPTED)), SUBSTRING(CONVERT(VARCHAR, DecryptByKey(CC.CREDIT_CARD_NUMBER_ENCRYPTED)) , 5, 8),'********'), SUBSTRING(CONVERT(VARCHAR, DecryptByKey(CC.CREDIT_CARD_NUMBER_ENCRYPTED)) , 9,12),'********') AS CREDIT_CARD_NUMBER,
				C.COUNTRY_NAME +' = '+ CO.CONTINENT_NAME AS CONTINENT
			FROM CUSTOMERS.tb_CUSTOMER_ACCOUNTS CA WITH (READUNCOMMITTED) -- Punto 1.1
				JOIN CUSTOMERS.tb_CUSTOMER_CREDIT_CARDS CCC
					ON CA.CUSTOMER_ACCOUNT_ID = CCC.CUSTOMER_ACCOUNT_ID
					JOIN CUSTOMERS.tb_CREDIT_CARD CC
						ON CCC.CREDIT_CARD_ID = CC.CREDIT_CARD_ID
						JOIN CUSTOMERS.tb_CUSTOMER_ADDRESSES 
							ON CA.CUSTOMER_ACCOUNT_ID = tb_CUSTOMER_ADDRESSES.CUSTOMER_ACCOUNT_ID
							JOIN CUSTOMERS.tb_ADDRESS A
								ON tb_CUSTOMER_ADDRESSES.ADDRESS_ID = A.ADDRESS_ID
								JOIN CUSTOMERS.tb_STATE_PROVINCE
									ON A.STATE_PROVINCE_ID = tb_STATE_PROVINCE.STATE_PROVINCE_ID
									JOIN CUSTOMERS.tb_COUNTRY C
										ON tb_STATE_PROVINCE.COUNTRY_ID = C.COUNTRY_ID
										JOIN CUSTOMERS.tb_CONTINENT CO
											ON C.CONTINENT_ID = CO.CONTINENT_ID
		END
		ELSE
		BEGIN
			IF EXISTS (SELECT TOP 1 1 FROM CUSTOMERS.tb_CUSTOMER_ACCOUNTS WHERE CUSTOMER_ACCOUNT_ID = @param_CustomerAccountId)
			BEGIN
				SELECT
					CA.CUSTOMER_ACCOUNT_ID,
					CA.CUSTOMER_NAME +' '+ CA.CUSTOMER_LAST_NAME AS NAME,
					CC.CREDIT_CARD_NUMBER_ENCRYPTED,
					REPLACE(REPLACE(CONVERT(VARCHAR, DecryptByKey(CC.CREDIT_CARD_NUMBER_ENCRYPTED)), SUBSTRING(CONVERT(VARCHAR, DecryptByKey(CC.CREDIT_CARD_NUMBER_ENCRYPTED)) , 5, 8),'********'), SUBSTRING(CONVERT(VARCHAR, DecryptByKey(CC.CREDIT_CARD_NUMBER_ENCRYPTED)) , 9,12),'********') AS CREDIT_CARD_NUMBER,
					C.COUNTRY_NAME +' = '+ CO.CONTINENT_NAME AS CONTINENT
				FROM CUSTOMERS.tb_CUSTOMER_ACCOUNTS CA WITH (READUNCOMMITTED) -- Punto 1.1
					JOIN CUSTOMERS.tb_CUSTOMER_CREDIT_CARDS CCC
						ON CA.CUSTOMER_ACCOUNT_ID = CCC.CUSTOMER_ACCOUNT_ID
						JOIN CUSTOMERS.tb_CREDIT_CARD CC
							ON CCC.CREDIT_CARD_ID = CC.CREDIT_CARD_ID
							JOIN CUSTOMERS.tb_CUSTOMER_ADDRESSES 
								ON CA.CUSTOMER_ACCOUNT_ID = tb_CUSTOMER_ADDRESSES.CUSTOMER_ACCOUNT_ID
								JOIN CUSTOMERS.tb_ADDRESS A
									ON tb_CUSTOMER_ADDRESSES.ADDRESS_ID = A.ADDRESS_ID
									JOIN CUSTOMERS.tb_STATE_PROVINCE
										ON A.STATE_PROVINCE_ID = tb_STATE_PROVINCE.STATE_PROVINCE_ID
										JOIN CUSTOMERS.tb_COUNTRY C
											ON tb_STATE_PROVINCE.COUNTRY_ID = C.COUNTRY_ID
											JOIN CUSTOMERS.tb_CONTINENT CO
												ON C.CONTINENT_ID = CO.CONTINENT_ID
				WHERE	CA.CUSTOMER_ACCOUNT_ID = @param_CustomerAccountId
			END
			ELSE
			BEGIN
				-- Punto 1.3
				INSERT INTO CUSTOMERS.tb_ERROR 
					([DESCRIPTION])
				VALUES
					('Busco customer account inexistente')
				SELECT
					-1 AS CUSTOMER_ACCOUNT_ID,
					'N/A' AS NAME,
					'N/A' AS CREDIT_CARD_NUMBER
			END	
		END
	END TRY
	BEGIN CATCH
		INSERT INTO CUSTOMERS.tb_ERROR 
			([DESCRIPTION])
		VALUES
			(ERROR_MESSAGE()) -- Punto 1.2
	END CATCH
END
GO
