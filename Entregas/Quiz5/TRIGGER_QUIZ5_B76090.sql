/*
* QUIZ 5
* MARIO QUIROS LUNA - B76090
* TRIGGERS
*/

USE IF5100_2022_B76090

CREATE TABLE tb_CA_HISTORY
(
	ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,ACTION_HISTORY VARCHAR(50) NOT NULL
	,COLUM VARCHAR(50) NOT NULL
	,OLD_DATA VARCHAR(50) NOT NULL
	,NEW_DATA VARCHAR(50) NOT NULL
	,LAST_MODIFIED_BY VARCHAR(25) DEFAULT SUSER_NAME()
	,LAST_MODIFIED_DATE DATETIME DEFAULT GETDATE()
)

CREATE TRIGGER tr_Customer_Accounts_Movement
	ON [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]
	FOR INSERT, DELETE, UPDATE
	AS
	DECLARE @Operation VARCHAR(15)
 
	IF EXISTS (SELECT 0 FROM inserted)
	BEGIN
	   IF EXISTS (SELECT 0 FROM deleted)
	   BEGIN 
		  SELECT @Operation = 'UPDATE'
	   END ELSE
	   BEGIN
		  SELECT @Operation = 'INSERT'
	   END
	END ELSE 
	BEGIN
	   SELECT @Operation = 'DELETE'
	END 

	IF(@Operation = 'INSERT')
	BEGIN
			BEGIN TRY
				BEGIN TRANSACTION
					INSERT INTO tb_CA_HISTORY
					(
						ACTION_HISTORY
						,COLUM
						,OLD_DATA
						,NEW_DATA
					)
					VALUES
					(
						'INSERT',
						'ALL',
						'NULL',
						'ALL NEW'
					)
				COMMIT
			END TRY
			BEGIN CATCH
				ROLLBACK
			END CATCH
	END
	ELSE
	BEGIN
		IF(@Operation = 'DELETE')
		BEGIN
				BEGIN TRY
					BEGIN TRANSACTION
						INSERT INTO tb_CA_HISTORY
						(
							ACTION_HISTORY
							,COLUM
							,OLD_DATA
							,NEW_DATA
						)
						VALUES
						(
							'DELETE',
							'ALL',
							'ALL VALUES',
							'ALL DELETED'
						)
					COMMIT
				END TRY
				BEGIN CATCH
					ROLLBACK
				END CATCH
		END
		ELSE
		BEGIN
			IF(@Operation = 'UPDATE')
			BEGIN
					BEGIN TRY
						BEGIN TRANSACTION		
							DECLARE @local_colum varchar(50) = null
							DECLARE	@local_old varchar(50) = null
							DECLARE	@local_new varchar(50) = null					
							IF UPDATE([CLIENT_ID])
							BEGIN
								SELECT 
								@local_colum = 'CLIENT_ID',
								@local_old = d.[CLIENT_ID],
								@local_new = i.[CLIENT_ID]
								FROM deleted as d
									JOIN inserted as i
										ON d.CUSTOMER_ACCOUNT_ID=i.CUSTOMER_ACCOUNT_ID
							END
							ELSE
							BEGIN								
								IF UPDATE([CUSTOMER_NAME])
								BEGIN
									SELECT 
									@local_colum = 'CUSTOMER_NAME',
									@local_old = d.[CUSTOMER_NAME],
									@local_new = i.[CUSTOMER_NAME]
									FROM deleted as d
										JOIN inserted as i
											ON d.CUSTOMER_ACCOUNT_ID=i.CUSTOMER_ACCOUNT_ID
								END
								ELSE
								BEGIN
									IF UPDATE([CUSTOMER_LAST_NAME])
									BEGIN
										SELECT 
										@local_colum = 'CUSTOMER_LAST_NAME',
										@local_old = d.[CUSTOMER_LAST_NAME],
										@local_new = i.[CUSTOMER_LAST_NAME]
										FROM deleted as d
											JOIN inserted as i
												ON d.CUSTOMER_ACCOUNT_ID=i.CUSTOMER_ACCOUNT_ID
									END
									ELSE
									BEGIN
										IF UPDATE([IS_ACTIVE])
										BEGIN
											SELECT 
											@local_colum = 'IS_ACTIVE',
											@local_old = d.[IS_ACTIVE],
											@local_new = i.[IS_ACTIVE]
											FROM deleted as d
												JOIN inserted as i
													ON d.CUSTOMER_ACCOUNT_ID=i.CUSTOMER_ACCOUNT_ID
										END
										ELSE
										BEGIN
											IF UPDATE([IS_DELETED])
											BEGIN
												SELECT 
												@local_colum = 'IS_DELETED',
												@local_old = d.[IS_DELETED],
												@local_new = i.[IS_DELETED]
												FROM deleted as d
													JOIN inserted as i
														ON d.CUSTOMER_ACCOUNT_ID=i.CUSTOMER_ACCOUNT_ID
											END
											ELSE
											BEGIN
												IF UPDATE([LAST_MODIFIED_BY])
												BEGIN
													SELECT 
													@local_colum = 'LAST_MODIFIED_BY',
													@local_old = d.[LAST_MODIFIED_BY],
													@local_new = i.[LAST_MODIFIED_BY]
													FROM deleted as d
														JOIN inserted as i
															ON d.CUSTOMER_ACCOUNT_ID=i.CUSTOMER_ACCOUNT_ID
												END
												ELSE
												BEGIN
													IF UPDATE([LAST_MODIFIED_DATE])
													BEGIN
														SELECT 
														@local_colum = 'LAST_MODIFIED_DATE',
														@local_old = d.[LAST_MODIFIED_DATE],
														@local_new = i.[LAST_MODIFIED_DATE]
														FROM deleted as d
															JOIN inserted as i
																ON d.CUSTOMER_ACCOUNT_ID=i.CUSTOMER_ACCOUNT_ID
													END
												END
											END
										END
									END
								END
							END
							INSERT INTO tb_CA_HISTORY
							(
								ACTION_HISTORY
								,COLUM
								,OLD_DATA
								,NEW_DATA
							)
							VALUES
							(
								'UPDATE',
								@local_colum,
								@local_old,
								@local_new
							)
						COMMIT
					END TRY
					BEGIN CATCH
						ROLLBACK
					END CATCH
			END
		END
	END

	/*
	*	TEST DE LOS TRIGGERS
	*/


	INSERT INTO [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]
	(
		[CLIENT_ID], [CUSTOMER_NAME], [CUSTOMER_LAST_NAME]
	)
	VALUES
	(
		1000, 'Paquito8', 'Juarez8'
	)

	UPDATE [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]
	SET [CLIENT_ID] = 1001
	WHERE CUSTOMER_ACCOUNT_ID = 111

	UPDATE [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]
	SET [CUSTOMER_LAST_NAME] = 'Juarecito'
	WHERE CUSTOMER_ACCOUNT_ID = 111

	DELETE FROM [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]
    WHERE CUSTOMER_ACCOUNT_ID = 117

	SELECT * FROM [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS]
	SELECT * FROM tb_CA_HISTORY
