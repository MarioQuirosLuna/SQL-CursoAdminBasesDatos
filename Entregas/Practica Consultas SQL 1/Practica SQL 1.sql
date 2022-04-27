USE IF5100_2022_b76090

--1) SE NECESITA EXTRAER EL CUSTOMER QUE MAS EVENTOS TENGA, SI EXISTE MAS DE UN CUSTOMER CON LA MISMA CANTIDAD DE EVENTOS, DEVUELVE TODOS.


SELECT CA.[CUSTOMER_ACCOUNT_ID],
	   CONCAT (CA.[CUSTOMER_NAME],' ',CA.[CUSTOMER_LAST_NAME]) AS COMPLETE_NAME,
	   Evnt.CNT,
	   Evnt.LAST_MODIFIED_DATE
FROM [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS] CA
	CROSS APPLY (
		SELECT TOP 1 
			COUNT(CUSTOMER_ACCOUNT_ID) AS CNT,
			E.LAST_MODIFIED_DATE
		FROM [FINANCIAL_DEPOSIT].[tb_EVENTS] E
		WHERE CA.[CUSTOMER_ACCOUNT_ID] = E.[CUSTOMER_ACCOUNT_ID]
		GROUP BY E.LAST_MODIFIED_DATE
		ORDER BY E.LAST_MODIFIED_DATE DESC
	) Evnt

SELECT
	   CA.[CUSTOMER_ACCOUNT_ID],
	   CONCAT (CA.[CUSTOMER_NAME],' ',CA.[CUSTOMER_LAST_NAME]) AS COMPLETE_NAME,
	   COUNT(E.EVENT_ID) AS CANTIDAD_EVENTOS,
	   Evnt.LAST_MODIFIED_DATE
FROM [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS] CA
	JOIN [FINANCIAL_DEPOSIT].[tb_EVENTS] E
		ON CA.[CUSTOMER_ACCOUNT_ID] = E.[CUSTOMER_ACCOUNT_ID]
			CROSS APPLY (
				SELECT TOP 1 
					E.LAST_MODIFIED_DATE
				FROM [FINANCIAL_DEPOSIT].[tb_EVENTS] E
				WHERE CA.[CUSTOMER_ACCOUNT_ID] = E.[CUSTOMER_ACCOUNT_ID]
				ORDER BY E.LAST_MODIFIED_DATE DESC
			) Evnt
GROUP BY CA.[CUSTOMER_ACCOUNT_ID], CA.[CUSTOMER_NAME], CA.[CUSTOMER_LAST_NAME], Evnt.LAST_MODIFIED_DATE
ORDER BY COUNT(E.EVENT_ID) DESC

--2) SE NECESITA VERIFICAR LA CANTIDAD DE CUSTOMERS POR PAIS

SELECT C.[COUNTRY_NAME],
	   COUNT(CAC.CUSTOMER_ACCOUNT_ID) AS CUSTOMERS
FROM [CUSTOMERS].[tb_COUNTRY] C
	JOIN [CUSTOMERS].[tb_STATE_PROVINCE] P
		ON P.[COUNTRY_ID] = C.[COUNTRY_ID]
			JOIN [CUSTOMERS].[tb_ADDRESS] A
				ON A.[STATE_PROVINCE_ID] = P.STATE_PROVINCE_ID
					JOIN [CUSTOMERS].[tb_CUSTOMER_ADDRESSES] CA
						ON CA.ADDRESS_ID = A.ADDRESS_ID
							JOIN [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS] CAC
								ON CAC.CUSTOMER_ACCOUNT_ID = CA.CUSTOMER_ACCOUNT_ID
GROUP BY C.[COUNTRY_NAME]
ORDER BY CUSTOMERS DESC

--SE NECESITA VERIFICAR LA CANTIDAD DE TARJETAS DE CREDITO POR BRAND
CREATE TABLE [CUSTOMERS].[tb_CREDIT_CARD_BRANDS]
(
	CREDIT_CARD_BRAND_ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,CREDIT_CARD_BRAND_NAME VARCHAR(30) NOT NULL
	,IS_ACTIVE BIT DEFAULT 1 --Si esta activo o no
	,IS_DELETED BIT DEFAULT 0 --Si esta borrado o no
	,LAST_MODIFIED_BY VARCHAR(50) --La ultima persona que modifica
	,LAST_MODIFIED_DATE DATETIME
)

INSERT INTO [CUSTOMERS].[tb_CREDIT_CARD_BRANDS]
(
	 [CREDIT_CARD_BRAND_NAME]
	,[IS_ACTIVE]
	,[IS_DELETED]
	,[LAST_MODIFIED_BY]
	,[LAST_MODIFIED_DATE]
)
VALUES
(
	'Mastercard'
	,1
	,0
	,SUSER_NAME()
	,GETDATE()
),
(
	'Visa'
	,1
	,0
	,SUSER_NAME()
	,GETDATE()
),
(
	'Amex'
	,1
	,0
	,SUSER_NAME()
	,GETDATE()
)

USE [IF5100_2022_B75934]
GO

UPDATE [CUSTOMERS].[tb_CREDIT_CARD]
   SET [CREDIT_CARD_NUMBER] = <CREDIT_CARD_NUMBER, varchar(16),>
      ,[CREDIT_CARD_BRAND] = <CREDIT_CARD_BRAND, int,>
      ,[EXPIRATION_MONTH] = <EXPIRATION_MONTH, smallint,>
      ,[EXPIRATION_YEAR] = <EXPIRATION_YEAR, smallint,>
      ,[CVV] = <CVV, smallint,>
      ,[IS_ACTIVE] = <IS_ACTIVE, bit,>
      ,[IS_DELETED] = <IS_DELETED, bit,>
      ,[LAST_MODIFIED_BY] = <LAST_MODIFIED_BY, varchar(50),>
      ,[LAST_MODIFIED_DATE] = <LAST_MODIFIED_DATE, datetime,>
	  ,CONSTRAINT FK_CREDIT_CARD_BRAND FOREIGN KEY ([CREDIT_CARD_BRAND]) REFERENCES [CUSTOMERS].[tb_CREDIT_CARD_BRANDS]([CREDIT_CARD_BRAND_ID])
GO
	

SELECT * FROM [CUSTOMERS].[tb_CREDIT_CARD]
SELECT * FROM [CUSTOMERS].[tb_CREDIT_CARD_BRANDS]

--CANTIDAD DE TARJETAS DE CREDITO POR BRAND

SELECT 
	  CCB.[CREDIT_CARD_BRAND_NAME]
	  ,COUNT(CC.CREDIT_CARD_ID) AS CREDIT_CARDS
FROM [CUSTOMERS].[tb_CREDIT_CARD_BRANDS] CCB
	JOIN [CUSTOMERS].[tb_CREDIT_CARD] CC
		ON CC.CREDIT_CARD_BRAND = CCB.CREDIT_CARD_BRAND_ID
GROUP BY CCB.[CREDIT_CARD_BRAND_NAME]
ORDER BY CREDIT_CARDS DESC

--CONSULTA 3.4

SELECT 
	   CC.CREDIT_CARD_ID
	   ,REPLACE(REPLACE(CC.CREDIT_CARD_NUMBER, SUBSTRING(CC.CREDIT_CARD_NUMBER , 1, 4),'****'), SUBSTRING(CC.CREDIT_CARD_NUMBER , 13, 4),'****') AS CREDIT_CARD_NUMBER
	   ,EXPIRED.EXPIRED
	   ,VALID.VALID
FROM [CUSTOMERS].[tb_CREDIT_CARD] CC
	CROSS APPLY (
				SELECT 
					  CC.IS_ACTIVE
					  ,COUNT(CC.CREDIT_CARD_ID) AS EXPIRED
				FROM [CUSTOMERS].[tb_CREDIT_CARD] CC
				WHERE CC.EXPIRATION_YEAR <= YEAR(GETDATE()) AND CC.EXPIRATION_MONTH < MONTH(GETDATE())
				GROUP BY CC.IS_ACTIVE
			) EXPIRED
			CROSS APPLY (
				SELECT 
					  CC.IS_ACTIVE
					  ,COUNT(CC.CREDIT_CARD_ID) AS VALID
				FROM [CUSTOMERS].[tb_CREDIT_CARD] CC
				WHERE CC.EXPIRATION_YEAR >= YEAR(GETDATE()) AND CC.EXPIRATION_MONTH > MONTH(GETDATE())
				GROUP BY CC.IS_ACTIVE
			) VALID
WHERE CC.EXPIRATION_YEAR <= YEAR(GETDATE()) AND CC.EXPIRATION_MONTH < MONTH(GETDATE())
GROUP BY CC.CREDIT_CARD_ID, CC.CREDIT_CARD_NUMBER, EXPIRED.EXPIRED, VALID.VALID

--4)DEVOLVER LA CONSULTA QUE HEMOST TRABAJADO EN CLASE, PERO CON UNA COLUMNA EXTRA QUE DIGA:



--5)INGRESAR EN LA TABLA DE CURRENCY