-- =============================================
-- Author:		Mario Quiros Luna
-- Create date: 20/04/2022
-- Description:	Simula la insercion de eventos en la base de datos.
-- =============================================
CREATE PROCEDURE FINANCIAL_DEPOSIT.sp_INSERT_EVENTS_MOCK
AS
BEGIN
	INSERT INTO [FINANCIAL_DEPOSIT].[tb_EVENTS]
           ([CLIENT_ID]
           ,[EVENT_TYPE_ID]
           ,[CUSTOMER_ACCOUNT_ID]
           ,[AMOUNT]
           ,[PAYMENT_TYPE_ID]
           ,[CURRENCY_ID]
           ,[SUBMITTED_DATE]
           ,[IS_ACTIVE]
           ,[IS_DELETED]
           ,[LAST_MODIFIED_BY]
           ,[LAST_MODIFIED_DATE])
     VALUES
           (FLOOR(RAND()*(1003-1000+1)+1000)	--ID DE LOS BANCOS DE 1000 A 1003
           ,FLOOR(RAND()*(3-1+1)+1)				--ID DEL TIPO DE EVENTO DE 1 A 3
           ,FLOOR(RAND()*(303-1+1)+1)			--ID DEL CLIENTE QUE REALIZA EL EVENTO
           ,FLOOR(RAND()*(100000-1000+1)+1000)	--SIMULACION DE UN MONTO
           ,FLOOR(RAND()*(5-1+1)+1)				--ID DE TIPO DE PAGO
           ,FLOOR(RAND()*(6-1+1)+1)				--ID DE DIVISA UTILIZADA
           ,GETDATE()							--FECHA A LA QUE SE REALIZA EL EVENTO
           ,1									--ACTIVO
           ,0									--BORRADO
           ,SUSER_NAME()						--ULTIMA PERSONA QUE MODIFICO
           ,GETDATE())							--ULTIMA HORA DED MODIFICACION
END
GO
