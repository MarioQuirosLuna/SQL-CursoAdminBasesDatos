USE [IF5100_2022_B76090]

INSERT INTO [CUSTOMERS].[tb_STATE_PROVINCE](
	[STATE_NAME],[COUNTRY_ID],[IS_ACTIVE],[IS_DELETED],[LAST_MODIFIED_BY],[LAST_MODIFIED_DATE]
)VALUES
	('Cartago', 1, 1, 0, 'laboratorios', '2022-01-17T04:52:22Z'),
	('Puntarenas', 1, 1, 0, 'laboratorios', '2022-01-09T04:52:22Z'),
	('Limon', 1, 1, 0, 'laboratorios', '2022-01-13T04:52:22Z'),
	('Guanacaste', 1, 1, 0, 'laboratorios', '2022-01-12T04:52:22Z'),
	('Alajuela', 1, 1, 0, 'laboratorios', '2022-01-11T04:52:22Z'),
	('Heredia', 1, 1, 0, 'laboratorios', '2022-01-13T04:52:22Z'),

	('Washington', 2, 1, 0, 'laboratorios', '2022-01-15T04:52:22Z'),
	('Pensilvania', 2, 1, 0, 'laboratorios', '2022-01-15T04:52:22Z'),
	('Texas', 2, 1, 0, 'laboratorios', '2022-01-13T04:52:22Z'),
	('New York', 2, 1, 0, 'laboratorios', '2022-01-11T04:52:22Z'),
	('California', 2, 1, 0, 'laboratorios', '2022-01-10T04:52:22Z'),

	('Aguascalientes', 3, 1, 0, 'laboratorios', '2022-01-13T04:52:22Z'),
	('Puebla', 3, 1, 0, 'laboratorios', '2022-01-13T04:52:22Z'),
	('Nuevo Leon', 3, 1, 0, 'laboratorios', '2022-01-13T04:52:22Z'),

	('Bocas del Toro', 4, 1, 0, 'laboratorios', '2022-01-13T04:52:22Z'),
	('Barcelona', 5, 1, 0, 'laboratorios', '2022-01-13T04:52:22Z'),
	('Caranavi', 6, 1, 0, 'laboratorios', '2022-01-13T04:52:22Z'),
	('San Salvador', 7, 1, 0, 'laboratorios', '2022-01-13T04:52:22Z'),
	('Tegulcigalpa', 8, 1, 0, 'laboratorios', '2022-01-13T04:52:22Z'),
	('Berlin', 9, 1, 0, 'laboratorios', '2022-01-13T04:52:22Z'),
	('Viena', 10, 1, 0, 'laboratorios', '2022-01-13T04:52:22Z');

	SELECT * FROM CUSTOMERS.tb_COUNTRY
	SELECT * FROM CUSTOMERS.tb_STATE_PROVINCE
	SELECT * FROM CUSTOMERS.tb_ADDRESS