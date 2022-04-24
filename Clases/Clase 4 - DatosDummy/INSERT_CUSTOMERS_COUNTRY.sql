USE [IF5100_2022_B76090]

GO
INSERT INTO [CUSTOMERS].[tb_COUNTRY]
    ([COUNTRY_NAME])
VALUES
(
	'Costa Rica'
),(
	'Estados Unidos'
),(
	'Mexico'
),(
	'Panama'
),(
	'Espana'
),(
	'Bolivia'
),(
	'El Salvador'
),(
	'Honduras'
),(
	'Alemania'
),(
	'Austria'
)
GO

SELECT * FROM CUSTOMERS.tb_COUNTRY
