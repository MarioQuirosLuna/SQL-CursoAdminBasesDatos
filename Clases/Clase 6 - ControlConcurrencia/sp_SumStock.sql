/*
También tenemos dos procedimientos , el primero de ellos suma la cantidad comprada de un
producto, busca el stock del producto, calcula el nuevo stock y lo guarda en una variable, luego
modifica el stock y termina.
*/

CREATE PROCEDURE sp_SumStock(@id_product int, @newStock int out)
AS
BEGIN
	DECLARE @fullPurcharse int
	DECLARE @auxAmount int

	SELECT 
		SUM(amount) INTO @fullPurcharse
	FROM PURCHARSE
	WHERE PURCHARSE.id_product = @id_product

	SELECT
		SET @auxAmount = STOCK.amount
	FROM STOCK
	WHERE STOCK.id_product = @id_product

	SET @newStock = auxAmount + fullPurcharse
	SELECT sleep(10)

	UPDATE STOCK
		SET @amount = @newStock
	WHERE STOCK.id_product = @id_product
END