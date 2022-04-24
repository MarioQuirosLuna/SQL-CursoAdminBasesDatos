USE IF5100_2022_B76090

GO
INSERT INTO [CUSTOMERS].[tb_ADDRESS]
           ([DETAILS]
           ,[STATE_PROVINCE_ID]
           ,[IS_ACTIVE]
           ,[IS_DELETED]
           ,[LAST_MODIFIED_BY]
           ,[LAST_MODIFIED_DATE])
     VALUES
           ('500mts al Sur del parque central', FLOOR(RAND()*(21-1)+1), 1, 0, 'laboratorios','2022-02-11T04:52:22Z'),
		   ('200mts al Norte del parque central', FLOOR(RAND()*(21-1)+1), 1, 0, 'laboratorios','2022-03-13T04:52:22Z'),
		   ('100mts al Sur del parque central', FLOOR(RAND()*(21-1)+1), 1, 0, 'laboratorios','2022-01-13T04:52:22Z'),
		   ('700mts al Este del parque central', FLOOR(RAND()*(21-1)+1), 1, 0, 'laboratorios','2022-02-13T04:52:22Z'),
		   ('1000mts al Oeste del parque central', FLOOR(RAND()*(21-1)+1), 1, 0, 'laboratorios','2022-01-13T04:52:22Z'),
		   ('400mts al Este del parque central', FLOOR(RAND()*(21-1)+1), 1, 0, 'laboratorios','2022-02-14T04:52:22Z'),
		   ('500mts al Norte del parque central', FLOOR(RAND()*(21-1)+1), 1, 0, 'laboratorios','2022-01-13T04:52:22Z'),
		   ('800mts al Sur del parque central', FLOOR(RAND()*(21-1)+1), 1, 0, 'laboratorios','2022-01-16T04:52:22Z'),
		   ('200mts al Este del parque central', FLOOR(RAND()*(21-1)+1), 1, 0, 'laboratorios','2022-03-17T04:52:22Z'),
		   ('900mts al Sur del parque central', FLOOR(RAND()*(21-1)+1), 1, 0, 'laboratorios','2022-01-13T04:52:22Z'),
		   ('500mts al Este del parque central', FLOOR(RAND()*(21-1)+1), 1, 0, 'laboratorios','2022-01-16T04:52:22Z'),
		   ('200mts al Norte del parque central', FLOOR(RAND()*(21-1)+1), 1, 0, 'laboratorios','2022-02-13T04:52:22Z'),
		   ('200mts al Este del parque central', FLOOR(RAND()*(21-1)+1), 1, 0, 'laboratorios','2022-03-16T04:52:22Z'),
		   ('500mts al Este del parque central', FLOOR(RAND()*(21-1)+1), 1, 0, 'laboratorios','2022-03-16T04:52:22Z'),
		   ('800mts al Sur del parque central', FLOOR(RAND()*(21-1)+1), 1, 0, 'laboratorios','2022-03-18T04:52:22Z'),
		   ('800mts al Oeste del parque central', FLOOR(RAND()*(21-1)+1), 1, 0, 'laboratorios','2022-04-18T04:52:22Z'),
		   ('900mts al Oeste del parque central', FLOOR(RAND()*(21-1)+1), 1, 0, 'laboratorios','2022-04-13T04:52:22Z'),
		   ('600mts al Sur del parque central', FLOOR(RAND()*(21-1)+1), 1, 0, 'laboratorios','2022-04-13T04:52:22Z'),
		   ('300mts al Norte del parque central', FLOOR(RAND()*(21-1)+1), 1, 0, 'laboratorios','2022-04-18T04:52:22Z')
GO

SELECT * FROM CUSTOMERS.tb_STATE_PROVINCE
SELECT * FROM CUSTOMERS.tb_ADDRESS