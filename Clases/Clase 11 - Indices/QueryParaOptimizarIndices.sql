USE [IF5100_2022_EXAMEN1]

SELECT 
						CA.[CUSTOMER_ACCOUNT_ID],
						CONCAT(CA.[CUSTOMER_NAME], ' ', CA.[CUSTOMER_LAST_NAME]) AS COMPLETE_NAME,
						CONVERT(DATE,CA.[LAST_MODIFIED_DATE]) AS LAST_MODIFIED_DATE,
						CA.IS_DELETED,
						-1 AS CLIENT_NAME
					FROM [CUSTOMERS].[tb_CUSTOMER_ACCOUNTS] CA
						JOIN [CLI_COMMON].[tb_CLIENTS] CL
							ON CA.[CLIENT_ID] = CL.[CLIENT_ID]
								JOIN [CUSTOMERS].[tb_CUSTOMER_ADDRESSES] CAD
									ON CA.[CUSTOMER_ACCOUNT_ID] = CAD.[CUSTOMER_ACCOUNT_ID]
										JOIN [CUSTOMERS].[tb_ADDRESS] A
											ON CAD.[ADDRESS_ID] = A.[ADDRESS_ID]
												JOIN [CUSTOMERS].[tb_STATE_PROVINCE] SP
													ON A.[STATE_PROVINCE_ID] = SP.[STATE_PROVINCE_ID]
														JOIN [CUSTOMERS].[tb_COUNTRY] C
															ON SP.[COUNTRY_ID] = C.[COUNTRY_ID]
																	JOIN [CUSTOMERS].[tb_CUSTOMER_CREDIT_CARDS] CCC
																		ON CA.[CUSTOMER_ACCOUNT_ID] = CCC.[CUSTOMER_ACCOUNT_ID]
																			JOIN [CUSTOMERS].[tb_CREDIT_CARD] CCA
																				ON CCC.[CREDIT_CARD_ID] = CCA.[CREDIT_CARD_ID]
																					JOIN [CUSTOMERS].[tb_CUSTOMER_PHONES] CP
																						ON CA.[CUSTOMER_ACCOUNT_ID] = CP.[CUSTOMER_ACCOUNT_ID]
																							JOIN [CUSTOMERS].[tb_PHONE] P
																								ON CP.[PHONE_ID] = P.[PHONE_ID]
					