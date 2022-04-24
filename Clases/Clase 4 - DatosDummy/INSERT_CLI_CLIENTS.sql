USE [IF5100_2022_B76090]
GO
INSERT INTO [CLI_COMMON].[tb_CLIENTS]
    ([NAME]
    ,[INDUSTRY_DESC])
VALUES
(
	'BAC'
    ,'Financiero'
),(
	'BN'
    ,'Financiero'
),(
	'BCR'
    ,'Financiero'
),(
	'BP'
    ,'Financiero'
)

SELECT * FROM [CLI_COMMON].[tb_CLIENTS]