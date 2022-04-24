USE IF5100_2022_B76090
 
INSERT INTO [FINANCIAL_DEPOSIT].[tb_PAYMENT_TYPE]
    ([PAYMENT_TYPE])
VALUES
(
	'Bitcoin'
),(
	'Paypal'
),(
	'Tarjeta de credito'
),(
	'Tarjeta de debito'
),(
	'Criptomoneda'
)

SELECT * FROM [FINANCIAL_DEPOSIT].[tb_PAYMENT_TYPE]