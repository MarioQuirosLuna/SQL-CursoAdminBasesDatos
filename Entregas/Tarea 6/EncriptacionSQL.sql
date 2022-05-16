USE IF5100_2022_B76090

/******************************************************************************/

--Crea tabla para prueba

CREATE TABLE Tarea6_Encriptacion
(
	Usuario VARCHAR(50),
	Contrasenna_Encryptada VARBINARY(256)
)

/******************************************************************************/

--Crea procedimiento almacenado para guardar los usuarios

CREATE PROCEDURE sp_GuardarUsuario
	@usuario VARCHAR(50),
	@contrasenna VARCHAR(50),
	@fraseEncryptacion VARCHAR(50)
AS
DECLARE @contrasennaEncryptada VARBINARY(256)
BEGIN
	--Encriptacion de la clave con una frase que ingresa el usuario
	SET @contrasennaEncryptada = (ENCRYPTBYPASSPHRASE(@fraseEncryptacion, @contrasenna))

	--Guarda la cuenta del usuario con la contrasenna encriptada
	INSERT INTO Tarea6_Encriptacion(Usuario,Contrasenna_Encryptada)
		VALUES(@usuario,@contrasennaEncryptada)
END

/******************************************************************************/

--Crea procedimiento que lee los datos del usuario desencriptados

CREATE PROCEDURE sp_LeerUsuario
	@usuario VARCHAR(50),
	@contrasenna VARCHAR(50),
	@fraseEncryptacion VARCHAR(50)
AS
DECLARE @contrasennaDesencriptada VARCHAR(256)
BEGIN
	--Devuelve la contrasenna despues de ser desencriptada con la frase ingresada por el usuario
	IF((CONVERT(VARCHAR(256), DECRYPTBYPASSPHRASE(@fraseEncryptacion,(SELECT Contrasenna_Encryptada FROM Tarea6_Encriptacion)))) = @contrasenna)
	BEGIN
		SELECT Usuario, CONVERT(VARCHAR(256), DECRYPTBYPASSPHRASE(@fraseEncryptacion,Contrasenna_Encryptada)) AS ContrasennaDesencriptada
		FROM Tarea6_Encriptacion
	END
	ELSE
	BEGIN
		SELECT 'Contrasenna incorrecta o frase' AS ERROR
	END
END

/******************************************************************************/

--Prueba

EXEC sp_GuardarUsuario 'Luis','123','UnaFraseParaEncriptar'

--Desencriptacion incorrecta
SELECT * FROM Tarea6_Encriptacion
EXEC sp_LeerUsuario 'Luis','123','UnaFraseParaEncriptarIncorrecta'
EXEC sp_LeerUsuario 'Luis','1234','UnaFraseParaEncriptar'

--Desencriptacion correcta
EXEC sp_LeerUsuario 'Luis','123','UnaFraseParaEncriptar'

/******************************************************************************/