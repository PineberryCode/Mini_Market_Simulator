-- ================================================================================================================ --
/*						[Mehotd Customer's Pay]					            */
-- ================================================================================================================ --
	INSERT INTO [dbo].[Method Customer's Pay] VALUES ('Cash')
	INSERT INTO [dbo].[Method Customer's Pay] VALUES ('Debit')
	INSERT INTO [dbo].[Method Customer's Pay] VALUES ('Credit')
-- ================================================================================================================ --


-- ================================================================================================================ --
/*					[INSERTION TO TABLE PRESENTATION]			            	    */
-- ================================================================================================================ --
	INSERT INTO [dbo].[Presentation] VALUES ('Tin')
	INSERT INTO [dbo].[Presentation] VALUES ('Bottle')
	INSERT INTO [dbo].[Presentation] VALUES ('Box')
	INSERT INTO [dbo].[Presentation] VALUES ('Bag')
	INSERT INTO [dbo].[Presentation] VALUES ('Glass bottle')
-- ================================================================================================================ --


-- ================================================================================================================ --
/*					[INSERTION TO TABLE CATEGORY PRODUCTS]				            */
-- ================================================================================================================ --
	INSERT INTO [dbo].[Category Products] VALUES ('CAP01','Dairy products')
	INSERT INTO [dbo].[Category Products] VALUES ('CAP02','Meats')
	INSERT INTO [dbo].[Category Products] VALUES ('CAP03','Snacks')
	INSERT INTO [dbo].[Category Products] VALUES ('CAP04','Cereals')
	INSERT INTO [dbo].[Category Products] VALUES ('CAP05','Cleanlinnes')
	INSERT INTO [dbo].[Category Products] VALUES ('CAP06','Medicines')
	INSERT INTO [dbo].[Category Products] VALUES ('CAP07','Fruits')

-- ================================================================================================================ --


-- ================================================================================================================ --
/*					[INSERTION TO TABLE MEASUREMENT QUANTITIES]				    */
-- ================================================================================================================ --
	INSERT INTO [dbo].[Measurement Quantities] VALUES ('L')
	INSERT INTO [dbo].[Measurement Quantities] VALUES ('ml')
	INSERT INTO [dbo].[Measurement Quantities] VALUES ('kg')
	INSERT INTO [dbo].[Measurement Quantities] VALUES ('g')
-- ================================================================================================================ --


-- ================================================================================================================ --
/*						[INSERTION TO TABLE QUANTITIES]					    */
-- ================================================================================================================ --
	INSERT INTO [dbo].[Quantities] VALUES (1,1)
	INSERT INTO [dbo].[Quantities] VALUES (1,1.5)
	INSERT INTO [dbo].[Quantities] VALUES (1,2)
	INSERT INTO [dbo].[Quantities] VALUES (1,3)
	INSERT INTO [dbo].[Quantities] VALUES (1,3.5)
	INSERT INTO [dbo].[Quantities] VALUES (2,500)
	INSERT INTO [dbo].[Quantities] VALUES (2,700)
	INSERT INTO [dbo].[Quantities] VALUES (2,350)
	INSERT INTO [dbo].[Quantities] VALUES (3,1)
	INSERT INTO [dbo].[Quantities] VALUES (3,2)
	INSERT INTO [dbo].[Quantities] VALUES (3,3)
	INSERT INTO [dbo].[Quantities] VALUES (3,3.5)
	INSERT INTO [dbo].[Quantities] VALUES (3,5)
	INSERT INTO [dbo].[Quantities] VALUES (3,15)
	INSERT INTO [dbo].[Quantities] VALUES (4,300)
	INSERT INTO [dbo].[Quantities] VALUES (4,500)
-- ================================================================================================================ --


-- ================================================================================================================ --
/*						[INSERTION TO TABLE SALARY]					    */
-- ================================================================================================================ --
	INSERT INTO [dbo].[Salary] VALUES ('CASHI','Cashier',1200)
	INSERT INTO [dbo].[Salary] VALUES ('CSUPP','Customer Support',1800)
	INSERT INTO [dbo].[Salary] VALUES ('SUPMA', 'Supermarket Manager', 15300)
-- ================================================================================================================ --
