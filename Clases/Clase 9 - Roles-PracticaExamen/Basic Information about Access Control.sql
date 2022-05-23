
//Se crea un usuario desde el usuario que tiene todos los permisos 
USE [master]
GO
CREATE LOGIN [auditor] WITH PASSWORD=N'12345', DEFAULT_DATABASE=[AdventureWorks2019], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

//Utilizando la BD creada y crear un usuario para el login que se creó antes 
//Si no hace esto no va a poder ingresar a la sesión
USE [AdventureWorks2019]
GO
CREATE USER [auditor] FOR LOGIN [auditor]
GO

//Aquí van a tener que asignar a ese usuario algún rol en específico 
//Se usa member porque se mete al grupo de propietario
USE [AdventureWorks2019]
GO
ALTER ROLE [db_owner] ADD MEMBER [auditor]