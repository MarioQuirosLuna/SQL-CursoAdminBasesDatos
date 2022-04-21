USE IF5100_2022_B76090

USE [IF5100_2022_B76090]
GO
INSERT INTO [FINANCIAL_DEPOSIT].[tb_CURRENCY]
           ([CURRENCY_NAME])
     VALUES
           ('Euro'),
		   ('Dolar'),
		   ('Colon'),
		   ('Soles'),
		   ('Yen'),
		   ('Libras')
GO
SELECT * FROM [FINANCIAL_DEPOSIT].[tb_CURRENCY]