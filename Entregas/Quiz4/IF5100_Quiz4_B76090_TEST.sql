USE IF5100_2022_B76090
SELECT * FROM [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]



/********************************************************************************************************************/

--TEST UPDATE: 
-- Puede modificar el client id que es al banco que pertenece (1000=BAC,1001=BN,1002=BCR,1003=BP)
-- Puede modificar el nombre y apellido

EXEC [dbo].[sp_CustomerAccounts_CRUD]
	@param_Action = 'U',
	@param_CustomerAccountId = 3,
	@param_ClientID = 1001, /**(1000=BAC,1001=BN,1002=BCR,1003=BP)*/
	@param_CustomerName = 'Mohandis',
	@param_CustomerLastName = 'MacEntee'




/********************************************************************************************************************/



--TEST DELETE:
-- Cambia la columna IS_DELETED a 0

EXEC [dbo].[sp_CustomerAccounts_CRUD]
	@param_Action = 'D',
	@param_CustomerAccountId = 5



/********************************************************************************************************************/



--TEST INSERT:
--Puede insertar el client id, que es al banco que pertenece (1000=BAC,1001=BN,1002=BCR,1003=BP)
--Credit card brands del (1=Visa, 2=MasterCard, 3=AMEX)
SELECT * FROM [CUSTOMERS].[tb_COUNTRY]
SELECT * FROM [CUSTOMERS].[tb_STATE_PROVINCE]

EXEC [dbo].[sp_CustomerAccounts_CRUD]
	@param_Action = 'I',
	@param_ClientID = 1000, /**(1000=BAC,1001=BN,1002=BCR,1003=BP)*/
	@param_CustomerName = 'Rafael',
	@param_CustomerLastName = 'Brown',
	@param_PhoneNumber = '123654333',
	@param_AddressCountryName = 'Costa Rica',
	@param_AddressStateProvinceName = 'Cartago',
	@param_AddressDetails = '100mts al norte de la universidad de Costa Rica',
	@param_CreditCardNumber = '1112223334447788',
	@param_CreditCardBrandId = 3, /**(1=Visa, 2=MasterCard, 3=AMEX)*/
	@param_ExpirationMonth = 6,
	@param_ExpirationYear = 2023,
	@param_CVV = 329



/********************************************************************************************************************/


--CONSULTA PARA VER EL REGISTRO INSERTADO
SELECT
	[tb_CUSTOMER_ACCOUNTS].[CUSTOMER_ACCOUNT_ID], [CLIENT_ID], [CUSTOMER_NAME], [CUSTOMER_LAST_NAME], [tb_CUSTOMER_ACCOUNTS].[LAST_MODIFIED_DATE],
	[PHONE_NUMBER],
	[COUNTRY_NAME], [STATE_NAME], [DETAILS],
	[CREDIT_CARD_NUMBER], [CREDIT_CARD_BRAND_ID], [EXPIRATION_MONTH], [EXPIRATION_YEAR], [CVV]
FROM [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]
	JOIN [CUSTOMERS].[tb_CUSTOMER_PHONES]
		ON [tb_CUSTOMER_ACCOUNTS].[CUSTOMER_ACCOUNT_ID] = [tb_CUSTOMER_PHONES].[CUSTOMER_ACCOUNT_ID]
		JOIN [CUSTOMERS].[tb_PHONE]
			ON [tb_CUSTOMER_PHONES].[PHONE_ID] = [tb_PHONE].[PHONE_ID]
			JOIN [CUSTOMERS].[tb_CUSTOMER_ADDRESSES]
				ON [tb_CUSTOMER_ACCOUNTS].[CUSTOMER_ACCOUNT_ID] = [tb_CUSTOMER_ADDRESSES].[CUSTOMER_ACCOUNT_ID]
				JOIN [CUSTOMERS].[tb_ADDRESS]
					ON [tb_CUSTOMER_ADDRESSES].[ADDRESS_ID] = [tb_ADDRESS].[ADDRESS_ID]
					JOIN [CUSTOMERS].[tb_STATE_PROVINCE]
						ON [tb_ADDRESS].[STATE_PROVINCE_ID] = [tb_STATE_PROVINCE].[STATE_PROVINCE_ID]
						JOIN [CUSTOMERS].[tb_COUNTRY]
							ON [tb_STATE_PROVINCE].[COUNTRY_ID] = [tb_COUNTRY].COUNTRY_ID
							JOIN [CUSTOMERS].[tb_CUSTOMER_CREDIT_CARDS]
								ON [tb_CUSTOMER_ACCOUNTS].CUSTOMER_ACCOUNT_ID = [tb_CUSTOMER_CREDIT_CARDS].CUSTOMER_ACCOUNT_ID
									JOIN [CUSTOMERS].[tb_CREDIT_CARD]
										ON [tb_CUSTOMER_CREDIT_CARDS].CREDIT_CARD_ID = [tb_CREDIT_CARD].CREDIT_CARD_ID
ORDER BY [tb_CUSTOMER_ACCOUNTS].[LAST_MODIFIED_DATE] DESC

