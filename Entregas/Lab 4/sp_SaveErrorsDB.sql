
-- =============================================
-- Author:		Mario Quiros Luna
-- DataBase:	IF5100_2022_B76090
-- Create date: 4-5-2022
-- Description:	Guarda los errores en la tabla correspondiente
-- =============================================
CREATE PROCEDURE sp_SaveErrorsDB
	@param_IdSource INT = NULL,
	@param_Destination INT = NULL,
	@param_ErrorMessage varchar(200) = NULL,
	@param_EventType INT = NULL
AS
BEGIN
	-- SI ES UN ERROR PERSONALIZADO
	IF(@param_ErrorMessage IS NOT NULL)
	BEGIN
		INSERT INTO [FINANCIAL_DEPOSIT].[tb_ERROR]
			([CUSTOMER_ACCOUNT_SOURCE]
			,[CUSTOMER_ACCOUNT_DESTINATION]
			,[ERRORNUMBER]
			,[ERRORSTATE]
			,[ERRORSEVERITY]
			,[ERROR_DESCRIPTION]
			,[EVENT_TYPE])
		VALUES
			(@param_IdSource
			,@param_Destination
			,NULL
			,NULL
			,NULL
			,@param_ErrorMessage
			,@param_EventType)
	END
	ELSE -- SI ES UN ERROR DE UN TRY CATCH
	BEGIN
		INSERT INTO [FINANCIAL_DEPOSIT].[tb_ERROR]
			([CUSTOMER_ACCOUNT_SOURCE]
			,[CUSTOMER_ACCOUNT_DESTINATION]
			,[EVENT_TYPE])
		VALUES
			(@param_IdSource
			,@param_Destination
			,@param_EventType)
	END

END
GO
