--Creacion de bases de datos para prueba
CREATE DATABASE TEST_WITHOUT_ENCRYPTION
CREATE DATABASE TEST_ENCRYPTION

--Insercion de datos de prueba en la base de datos que sera encriptada.
USE TEST_ENCRYPTION
CREATE TABLE NAMES (
	ID INT IDENTITY(1,1) PRIMARY KEY,
	NAME VARCHAR(50) NOT NULL
)
INSERT INTO NAMES(
	NAME
)VALUES
	('Martin'),
	('Francisco')

--Insercion de datos de prueba en la base de datos que NO sera encriptada.
USE TEST_WITHOUT_ENCRYPTION
CREATE TABLE NAMES (
	ID INT IDENTITY(1,1) PRIMARY KEY,
	NAME VARCHAR(50) NOT NULL
)
INSERT INTO NAMES(
	NAME
)VALUES
	('Martin'),
	('Francisco')




--Creacion de copias de seguridad
USE master
GO
	BACKUP DATABASE [TEST_ENCRYPTION] TO DISK = 'D:\ArchivosImportantes\BackupsSQL\TestEncryption.bak'
GO

USE master
GO
	BACKUP DATABASE [TEST_WITHOUT_ENCRYPTION] TO DISK = 'D:\ArchivosImportantes\BackupsSQL\TestWithOutEncryption.bak'
GO






--Creacion del cerificado y la clave
USE master;
GO
	CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'ThisIsAStrongPassword';
go
	CREATE CERTIFICATE MyServerCert WITH SUBJECT = 'My DEK Certificate';
go

--Crea clave de encriptacion para el certificado
	USE [TEST_ENCRYPTION]
GO
	CREATE DATABASE ENCRYPTION KEY
	WITH ALGORITHM = AES_128
	ENCRYPTION BY SERVER CERTIFICATE MyServerCert;
GO

--Backup del certificado y la key
USE master
GO
	BACKUP CERTIFICATE MyServerCert
	TO FILE = 'D:\ArchivosImportantes\BackupsSQL\MyServeCert.cer'
	WITH PRIVATE KEY (FILE = 'D:\ArchivosImportantes\BackupsSQL\MyCertKey.pvk', ENCRYPTION BY PASSWORD = 'ThisIsAStrongPassword')
GO
--Habilita la enciptacion de la base de datos
	ALTER DATABASE [TEST_ENCRYPTION]
	SET ENCRYPTION ON;
GO




--Muestra losd detalles de los certificados
USE master
GO
	SELECT * FROM sys.certificates WHERE pvt_key_encryption_type <> 'NA'
GO

--Muestra los detalles de las claves
USE master
GO
	SELECT encryptor_type, key_length, key_algorithm, encryption_state, create_date
	FROM sys.dm_database_encryption_keys
GO