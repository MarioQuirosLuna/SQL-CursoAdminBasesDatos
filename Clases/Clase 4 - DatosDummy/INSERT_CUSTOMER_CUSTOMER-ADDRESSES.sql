USE [IF5100_2022_B76090]

GO
DECLARE @FromDate DATETIME2(0)
DECLARE @ToDate   DATETIME2(0)
DECLARE @intFlag INT = 1
DECLARE @intIter INT = 1

SET @FromDate = '2020-01-01 08:22:13' 
SET @ToDate = '2022-04-24 17:56:31'

DECLARE @Seconds INT = DATEDIFF(SECOND, @FromDate, @ToDate)
DECLARE @Random INT = ROUND(((@Seconds-1) * RAND()), 0)

WHILE (@intFlag <= 80)
BEGIN

INSERT INTO [CUSTOMERS].[tb_CUSTOMER_ADDRESSES](
	[CUSTOMER_ACCOUNT_ID],[ADDRESS_ID],[IS_ACTIVE],[IS_DELETED],[LAST_MODIFIED_BY],[LAST_MODIFIED_DATE]
)VALUES
(
	@intIter,
	FLOOR(RAND()*(1037-1000+1)+1000),
	1,
	0,
	'laboratorios', 
	DATEADD(SECOND, @Random, @FromDate)
)
SET @intFlag = @intFlag + 1
SET @intIter = @intIter + 1

END
GO

SELECT * FROM [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]
SELECT * FROM [CUSTOMERS].[tb_ADDRESS]
SELECT * FROM [CUSTOMERS].[tb_CUSTOMER_ADDRESSES]