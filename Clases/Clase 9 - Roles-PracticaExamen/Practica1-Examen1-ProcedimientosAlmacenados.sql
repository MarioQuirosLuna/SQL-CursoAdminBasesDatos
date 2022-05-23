USE IF5100_2022_B76090

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
CREATE TABLE CUSTOMERS.tb_CONTINENT
(
	CONTINENT_ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,CONTINENT_NAME VARCHAR(50) NOT NULL
	,IS_ACTIVE BIT NOT NULL DEFAULT 1
	,IS_DELETED BIT NOT NULL DEFAULT 0
	,LAST_MODIFIED_BY VARCHAR(50) NULL DEFAULT SUSER_NAME()
	,LAST_MODIFIED_DATE DATETIME NULL DEFAULT GETDATE()
)

CREATE TABLE CUSTOMERS.tb_ERROR
(
	ERROR_ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,DESCRIPTION VARCHAR(300) NOT NULL
	,IS_ACTIVE BIT NOT NULL DEFAULT 1
	,IS_DELETED BIT NOT NULL DEFAULT 0
	,LAST_MODIFIED_BY VARCHAR(50) NULL DEFAULT SUSER_NAME()
	,LAST_MODIFIED_DATE DATETIME NULL DEFAULT GETDATE()
)

INSERT INTO CUSTOMERS.tb_CONTINENT
(CONTINENT_NAME)
VALUES
('America'),
('Europa'),
('Asia'),
('Oceania'),
('Africa')

ALTER TABLE [CUSTOMERS].[tb_COUNTRY]
ADD CONTINENT_ID INT DEFAULT NULL,
FOREIGN KEY(CONTINENT_ID) REFERENCES CUSTOMERS.tb_CONTINENT 

SELECT * FROM CUSTOMERS.tb_CONTINENT
SELECT * FROM [CUSTOMERS].[tb_COUNTRY]

UPDATE [CUSTOMERS].[tb_COUNTRY]
   SET [CONTINENT_ID] = 2
 WHERE COUNTRY_ID = 9 OR COUNTRY_ID = 10



 
CREATE MASTER KEY ENCRYPTION BY   
PASSWORD = '12345_ABCD';

CREATE CERTIFICATE CreditCardCertificate  
   WITH SUBJECT = 'Employee Social Security Numbers';  
GO  

CREATE SYMMETRIC KEY SymmetricKey  
    WITH ALGORITHM = AES_256  
    ENCRYPTION BY CERTIFICATE CreditCardCertificate;  
GO  

USE IF5100_2022_B76090;  
GO  

ALTER TABLE [CUSTOMERS].[tb_CREDIT_CARD]
    ADD CREDIT_CARD_NUMBER_ENCRYPTED VARBINARY(128);   
GO  
 
OPEN SYMMETRIC KEY SymmetricKey  
   DECRYPTION BY CERTIFICATE CreditCardCertificate;  

UPDATE [CUSTOMERS].[tb_CREDIT_CARD]
SET CREDIT_CARD_NUMBER_ENCRYPTED = EncryptByKey(Key_GUID('SymmetricKey'), CREDIT_CARD_NUMBER);  
GO  



OPEN SYMMETRIC KEY SymmetricKey  
   DECRYPTION BY CERTIFICATE CreditCardCertificate;  
GO  


SELECT 
	CREDIT_CARD_NUMBER,
	CREDIT_CARD_NUMBER_ENCRYPTED AS 'Encrypted ID Number',  
    CONVERT(varchar, DecryptByKey(CREDIT_CARD_NUMBER_ENCRYPTED)) AS 'Decrypted ID Number'  
    FROM [CUSTOMERS].[tb_CREDIT_CARD]
GO

EXEC sp_getCustomerAccount

