
-- ==================================================== --
/*			INDEXES		 	  	*/
-- ==================================================== --
-- ===================================================== --
	CREATE NONCLUSTERED INDEX IX_UnitsInStock
	ON [dbo].[Products] (UnitsInStock) 
	WHERE UnitsInStock <= 20
-- ===================================================== --
-- ===================================================== --
	CREATE NONCLUSTERED INDEX IX_CategoryName
	ON [dbo].[Category Products] (CategoryName)
-- ===================================================== --
-- ===================================================== --
	CREATE NONCLUSTERED INDEX IX_CustomerLastName
	ON [dbo].[Customer] (LastName)
-- ===================================================== --
-- ===================================================== --
	CREATE NONCLUSTERED INDEX IX_EmployeeLastName
	ON [dbo].[Employee] (LastName)
-- ===================================================== --
-- ===================================================== --
	CREATE NONCLUSTERED INDEX IX_Suppliers
	ON [dbo].[Suppliers] (CompanyName)
-- ===================================================== --
	CREATE UNIQUE INDEX IX_UniqueCategoryName
	ON [dbo].[Category Products] (CategoryName DESC)
-- ===================================================== --
-- ===================================================== --
	CREATE UNIQUE INDEX IX_MeasurementQuantities
	ON [dbo].[Measurement Quantities] (Measurements)
-- ===================================================== --
-- ===================================================== --
	CREATE UNIQUE INDEX IX_PresentationContents
	ON [dbo].[Presentation] (Contents)
-- ===================================================== --
-- ===================================================== --
	CREATE UNIQUE INDEX [IX_MethodCustomer'sPay]
	ON [dbo].[Method Customer's Pay] (PayMethod)
-- ===================================================== --
-- ===================================================== --
	CREATE UNIQUE INDEX IX_EagleEye
	ON [dbo].[Eagle Eye] (ColumnValues)
-- ===================================================== --
-- ===================================================== --
	CREATE UNIQUE INDEX IX_RolTableSalary
	ON [dbo].[Salary] (Rol)
-- ===================================================== --
-- ===================================================== --


-- ============================================================================== --
/*				CUSTOMER'S TRIGGER				  */
-- ============================================================================== --
	CREATE TRIGGER [TX_Deleten't Customer]
	ON [dbo].[Customer]
	INSTEAD OF DELETE
	AS
	BEGIN
		DECLARE @NotID INT
		SELECT @NotID = COUNT(*) FROM [Customer]
		WHERE IdentityCarnet = IdentityCarnet
		IF (@NotID > 1)
		BEGIN
			RAISERROR('Deny: Delete Customer',16,1)
			ROLLBACK TRANSACTION
		END
	END
-- ============================================================================== --


-- ============================================================================== --
/*				SUPPLIERS' TRIGGER				  */
-- ============================================================================== --
	CREATE TRIGGER [TX_Delent't Suppliers]
	ON [dbo].[Suppliers]
	INSTEAD OF DELETE
	AS
	BEGIN
		DECLARE @NotIDSupplier INT
		SELECT @NotIDSupplier = COUNT(*) FROM [Suppliers]
		WHERE ID_Supplier = ID_Supplier
		IF (@NotIDSupplier > 1)
		BEGIN
			RAISERROR('Deny: Delete Suppliers',16,1)
			ROLLBACK TRANSACTION
		END
	END
-- ============================================================================== --


-- ================================================================================================================================================================= --
/*									EMPLOYEE STORED PROCEDURES					      			     */
-- ================================================================================================================================================================= --

CREATE PROCEDURE [dbo].[SP Insert Employee Data]
(
	@ID_Employee					CHAR(5)			OUTPUT	  	,
	@FkID_Salary					CHAR(5)				  	,
	@FirstName					VARCHAR(25)			  	,
	@SecondName					VARCHAR(25)			  	,
	@LastName					VARCHAR(25)			  	,
	@MothersLastName				VARCHAR(25)			  	,
	@Celphone					VARCHAR(20)			  	,
	@BirthDate					DATE				  	,
	@PostalCode					VARCHAR(10)			  	,
	@Country					VARCHAR(30)			  	,
	@Region						VARCHAR(30)			  	,
	@City						VARCHAR(30)			  	,
	@EmployeeAddress				VARCHAR(80)			  	,
	@Photo						IMAGE				  	,
	@levelState					INT			OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			SET @levelState = 1

			IF NOT EXISTS (SELECT * FROM [dbo].[Employee])
			BEGIN
				DECLARE @Number INT = 100

				SET @ID_Employee = CONCAT(CAST('E' AS CHAR(1)), CAST('M' AS CHAR(1)), CAST(@Number AS CHAR(3)))

				INSERT INTO [dbo].[Employee] (ID_Employee, FkID_Salary, FirstName, SecondName, LastName, MothersLastName, Celphone, BirthDate, PostalCode, Country, Region, City, EmployeeAddress, Photo)
				SELECT @ID_Employee, @FkID_Salary, @FirstName, @SecondName, @LastName, @MothersLastName, @Celphone, @BirthDate, @PostalCode, @Country, @Region, @City, @EmployeeAddress, @Photo

				DECLARE @Count INT = (SELECT COUNT(ID_Employee) FROM [dbo].[Employee])
			
				INSERT INTO [dbo].[Eagle Eye] (NameParameters, ColumnValues) VALUES ('Employees', @Count)

				SELECT CONCAT(@levelState, ':') AS [Level State], 'First successful insertion of employee data' AS [ Message ]
			END
			ELSE
			BEGIN
				IF EXISTS (SELECT * FROM [dbo].[Employee])
				BEGIN
					SET @levelState = 2

					DECLARE @Iterate INT = 1

					DECLARE @Kidnapper INT = (SELECT CAST(SUBSTRING(MAX(ID_Employee),3,1) AS INT) FROM Employee)

					SET @Kidnapper = @Iterate + @Kidnapper

					SET @ID_Employee = CONCAT(CAST('E' AS CHAR(1)), CAST('M' AS CHAR(1)), CAST(@Kidnapper AS CHAR(3)))

					INSERT INTO [dbo].[Employee] (ID_Employee, FkID_Salary, FirstName, SecondName, LastName, MothersLastName, Celphone, BirthDate, PostalCode, Country, Region, City, EmployeeAddress, Photo)
					SELECT @ID_Employee, @FkID_Salary, @FirstName, @SecondName, @LastName, @MothersLastName, @Celphone, @BirthDate, @PostalCode, @Country, @Region, @City, @EmployeeAddress, @Photo
				
					DECLARE @SecondCount INT = (SELECT COUNT(ID_Employee) FROM [dbo].[Employee])

					UPDATE [dbo].[Eagle Eye]
					SET	ColumnValues		=		@SecondCount
					WHERE	NameParameters		=		'Employees'

					SELECT CONCAT(@levelState, ':') AS [Level State], 'Last successful insertion of employee data' AS [ Message ]
				END
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		SELECT		ERROR_LINE()		AS 	[ERROR LINE],
				ERROR_MESSAGE()		AS	[ERROR MESSAGE],
				ERROR_NUMBER()		AS 	[ERROR NUMBER],
				ERROR_PROCEDURE()	AS 	[ERROR PROCEDURE],
				ERROR_SEVERITY()	AS 	[ERROR SEVERITY],
				ERROR_STATE()		AS 	[ERROR STATE]
	END CATCH
END
-- ================================================================================================================================================================= --

-- ================================================================================================================================================================= --
CREATE PROCEDURE [dbo].[SP Update Employee]
(
	@ID_Employee					CHAR(5)			OUTPUT	  	,
	@FkID_Salary					CHAR(5)				  	,
	@FirstName					VARCHAR(25)			 	,
	@SecondName					VARCHAR(25)			  	,
	@LastName					VARCHAR(25)			  	,
	@MothersLastName				VARCHAR(25)			  	,
	@Celphone					VARCHAR(20)			  	,
	@BirthDate					DATETIME			  	,
	@PostalCode					VARCHAR(10)			  	,
	@Country					VARCHAR(30)			  	,
	@Region						VARCHAR(30)			  	,
	@City						VARCHAR(30)			  	,
	@EmployeeAddress				VARCHAR(80)			  	,
	@Photo						IMAGE				  	,
	@StateProcedure					INT			OUTPUT
)
AS
BEGIN
	BEGIN TRY
		SET @StateProcedure = 1

		IF EXISTS (SELECT * FROM [dbo].[Employee] WHERE ID_Employee = @ID_Employee)
		BEGIN
			UPDATE [dbo].[Employee]
			SET		FkID_Salary			=		@FkID_Salary		,
					FirstName			=		@FirstName		,
					SecondName			=		@SecondName		,
					LastName			=		@LastName		,
					MothersLastName			=		@MothersLastName	,
					Celphone			=		@Celphone		,
					BirthDate			=		@BirthDate		,
					PostalCode			=		@PostalCode		,
					Country				=		@Country		,
					Region				=		@Region			,
					City				=		@City			,
					EmployeeAddress			=		@EmployeeAddress	,
					Photo				=		@Photo
			WHERE		ID_Employee			=		@ID_Employee

			SELECT CONCAT(@StateProcedure,':') AS [State Update], 'Successful modify' AS [ Mensaje ]
		END
		ELSE
		BEGIN
			IF NOT EXISTS (SELECT * FROM [dbo].[Employee] WHERE ID_Employee = @ID_Employee)
			BEGIN
				SET @StateProcedure = - 1

				SELECT CONCAT(@StateProcedure,':') AS [State Update], 'Not found ID_Employee' AS [ Mensaje ]
			END
		END
	END TRY
	BEGIN CATCH
		SELECT		ERROR_LINE()		AS 	[ERROR LINE],
				ERROR_MESSAGE()		AS	[ERROR MESSAGE],
				ERROR_NUMBER()		AS 	[ERROR NUMBER],
				ERROR_PROCEDURE()	AS 	[ERROR PROCEDURE],
				ERROR_SEVERITY()	AS 	[ERROR SEVERITY],
				ERROR_STATE()		AS 	[ERROR STATE]
	END CATCH
END
-- ================================================================================================================================================================= --


-- ================================================================================================================================================================= --
/*									CUSTOMER STORED PROCEDURES			  					     */
-- ================================================================================================================================================================= --
CREATE PROCEDURE [dbo].[SP Update Customer]
(
	@IdentityCarnet					INT					,
	@FirstName					VARCHAR(25)				,
	@SecondName					VARCHAR(25)				,
	@LastName					VARCHAR(25)				,
	@MothersLastName				VARCHAR(25)				,
	@Celphone					VARCHAR(20)				,
	@PostalCode					VARCHAR(10)			  	,
	@Country					VARCHAR(30)			 	,
	@Region						VARCHAR(30)			  	,
	@City						VARCHAR(30)			  	,
	@CustomerAddress				VARCHAR(80)			  	,
	@StateProcedure					INT 			OUTPUT
)
AS
BEGIN
	BEGIN TRY
		SET @StateProcedure = 1

		IF EXISTS (SELECT * FROM [dbo].[Customer] WHERE IdentityCarnet = @IdentityCarnet)
		BEGIN
			UPDATE [dbo].[Customer] 
			SET		FirstName			=		@FirstName		,
					SecondName			=		@SecondName		,
					LastName			=		@LastName		,
					MothersLastName			=		@MothersLastName	,
					Celphone			=		@Celphone		,
					PostalCode			=		@PostalCode		,
					Country				=		@Country		,
					Region				=		@Region			,
					City				=		@City			,
					CustomerAddress			=		@CustomerAddress
			WHERE		IdentityCarnet			=		@IdentityCarnet
				
			SELECT CONCAT(@StateProcedure, ':') AS [State Procedure], 'Successful modification' AS [ Message ]
		END
		ELSE
		BEGIN
			IF NOT EXISTS (SELECT * FROM [dbo].[Customer] WHERE IdentityCarnet = @IdentityCarnet)
			BEGIN
				SET @StateProcedure = - 1

				SELECT CONCAT(@StateProcedure, ':') AS [State Procedure], 'Not exists Identity carnet' AS [ Message ]
			END
		END
	END TRY
	BEGIN CATCH
		SELECT		ERROR_LINE()		AS 	[ERROR LINE],
				ERROR_MESSAGE()		AS	[ERROR MESSAGE],
				ERROR_NUMBER()		AS 	[ERROR NUMBER],
				ERROR_PROCEDURE()	AS 	[ERROR PROCEDURE],
				ERROR_SEVERITY()	AS 	[ERROR SEVERITY],
				ERROR_STATE()		AS 	[ERROR STATE]
	END CATCH
END
-- ================================================================================================================================================================= --

-- ================================================================================================================================================================= --
CREATE PROCEDURE [dbo].[SP Insert Customer Data]
(
	@IdentityCarnet					INT					,
	@FirstName					VARCHAR(25)				,
	@SecondName					VARCHAR(25)				,
	@LastName					VARCHAR(25)				,
	@MothersLastName				VARCHAR(25)				,
	@Celphone					VARCHAR(20)				,
	@PostalCode					VARCHAR(10)			  	,
	@Country					VARCHAR(30)			  	,
	@Region						VARCHAR(30)			  	,
	@City						VARCHAR(30)			  	,
	@CustomerAddress				VARCHAR(80)			  
)
AS
BEGIN
	BEGIN TRY

		INSERT INTO [dbo].[Customer] (IdentityCarnet, FirstName, SecondName, LastName, MothersLastName, Celphone, PostalCode, Country, Region, City, CustomerAddress)
		SELECT @IdentityCarnet, @FirstName, @SecondName, @LastName, @MothersLastName, @Celphone, @PostalCode, @Country, @Region, @City, @CustomerAddress

		SELECT 'Successful insertion customer data' AS [ Message ]
	END TRY
	BEGIN CATCH
		SELECT		ERROR_LINE()		AS 	[ERROR LINE],
				ERROR_MESSAGE()		AS	[ERROR MESSAGE],
				ERROR_NUMBER()		AS 	[ERROR NUMBER],
				ERROR_PROCEDURE()	AS 	[ERROR PROCEDURE],
				ERROR_SEVERITY()	AS 	[ERROR SEVERITY],
				ERROR_STATE()		AS 	[ERROR STATE]
	END CATCH
END
-- ================================================================================================================================================================= --


-- ================================================================================================================================================================= --
/*								SUPPLIER STORED PROCEDURES			  						     */
-- ================================================================================================================================================================= --
CREATE PROCEDURE [dbo].[SP Insert Suppliers Data]
(
	@ID_Supplier					CHAR(5) 		OUTPUT		,
	@CompanyName					VARCHAR(25)				,
	@E_mail						VARCHAR(30)				,
	@Celphone					VARCHAR(20)				,
	@HomePage					TEXT					,
	@PostalCode					VARCHAR(10)			  	,
	@Country					VARCHAR(30)			  	,
	@Region						VARCHAR(30)			  	,
	@City						VARCHAR(30)			  	,
	@SupplierAddress				VARCHAR(80)			  	,
	@Active						BIT
)
AS
BEGIN
	BEGIN TRY
		SET @ID_Supplier = CONCAT(SUBSTRING(@Country, 1,2), SUBSTRING(@CompanyName, 1, 3))

		INSERT INTO [dbo].[Suppliers] (ID_Supplier, CompanyName, E_mail, Celphone, HomePage, PostalCode, Country, Region, City, SupplierAddress, Active)
		SELECT @ID_Supplier, @CompanyName, @E_mail, @Celphone, @HomePage, @PostalCode, @Country, @Region, @City, @SupplierAddress, @Active

		SELECT 'Successful insertion suppliers data' AS [ Message ]
	END TRY
	BEGIN CATCH
		SELECT		ERROR_LINE()		AS 	[ERROR LINE],
				ERROR_MESSAGE()		AS	[ERROR MESSAGE],
				ERROR_NUMBER()		AS 	[ERROR NUMBER],
				ERROR_PROCEDURE()	AS 	[ERROR PROCEDURE],
				ERROR_SEVERITY()	AS 	[ERROR SEVERITY],
				ERROR_STATE()		AS 	[ERROR STATE]
	END CATCH
END

-- ================================================================================================================================================================= --

-- ================================================================================================================================================================= --
CREATE PROCEDURE [dbo].[SP Update Supplier Data]
(
	@ID_Supplier					CHAR(5)					,
	@CompanyName					VARCHAR(25)				,
	@E_mail						VARCHAR(30)				,
	@Celphone					VARCHAR(20)				,
	@HomePage					TEXT					,
	@PostalCode					VARCHAR(10)			  	,
	@Country					VARCHAR(30)			  	,
	@Region						VARCHAR(30)			  	,
	@City						VARCHAR(30)			  	,
	@SupplierAddress				VARCHAR(80)		  		,
	@Active						BIT					,
	@StateProcedure					INT 			OUTPUT
)
AS
BEGIN
	BEGIN TRY
		SET @StateProcedure = 1

		IF EXISTS (SELECT * FROM [dbo].[Suppliers] WHERE ID_Supplier = @ID_Supplier)
		BEGIN
			UPDATE [dbo].[Suppliers]
			SET		CompanyName			=		@CompanyName		,
					E_mail				=		@E_mail			,
					Celphone			=		@Celphone		,
					HomePage			=		@HomePage		,
					PostalCode			=		@PostalCode		,
					Country				=		@Country		,
					Region				=		@Region			,
					City				=		@City			,
					SupplierAddress			=		@SupplierAddress	,
					Active				=		@Active
			WHERE		ID_Supplier			=		@ID_Supplier

			SELECT CONCAT(@StateProcedure, ':') AS [State Procedure], 'Successful Modification' AS [ Message ]
		END
		ELSE
		BEGIN
			IF NOT EXISTS(SELECT*FROM [dbo].[Suppliers] WHERE ID_Supplier = @ID_Supplier)
			BEGIN
				SELECT CONCAT(@StateProcedure, ':'), 'Not found ID_Supplier'
			END
		END
	END TRY
	BEGIN CATCH
		SELECT		ERROR_LINE()		AS 	[ERROR LINE],
				ERROR_MESSAGE()		AS	[ERROR MESSAGE],
				ERROR_NUMBER()		AS 	[ERROR NUMBER],
				ERROR_PROCEDURE()	AS 	[ERROR PROCEDURE],
				ERROR_SEVERITY()	AS 	[ERROR SEVERITY],
				ERROR_STATE()		AS 	[ERROR STATE]
	END CATCH
END
-- ================================================================================================================================================================= --


-- ================================================================================================================================================================= --
/*									PRODUCT STORED PROCEDURES			  					     */
-- ================================================================================================================================================================= --
CREATE PROCEDURE [dbo].[SP Insert Product Data]
(
	@ID_Product					CHAR(5) 		OUTPUT		,
	@FkID_Category					CHAR(5)					,
	@FkID_Presentation				INT					,
	@FkID_Quantities				INT					,
	@FkID_Supplier					CHAR(5)					,
	@ProductName					VARCHAR(25)				,
	@Mark						VARCHAR(25)				,
	@UnitPrice					MONEY					,
	@UnitsInStock					INT
)
AS
BEGIN
	BEGIN TRY
		SET @ID_Product = CONCAT(SUBSTRING(@Mark,1,2), SUBSTRING(@ProductName,1,3))

		INSERT INTO [dbo].[Products] (ID_Product, FkID_Category, FkID_Presentation, FkID_Quantities, FkID_Supplier, ProductName, Mark, UnitPrice, UnitsInStock)
		SELECT @ID_Product, @FkID_Category, @FkID_Presentation, @FkID_Quantities, @FkID_Supplier, @ProductName, @Mark, @UnitPrice, @UnitsInStock

		SELECT 'Successful insertion product data' AS [ Message ]
	END TRY
	BEGIN CATCH
		SELECT		ERROR_LINE()		AS 	[ERROR LINE],
				ERROR_MESSAGE()		AS	[ERROR MESSAGE],
				ERROR_NUMBER()		AS 	[ERROR NUMBER],
				ERROR_PROCEDURE()	AS 	[ERROR PROCEDURE],
				ERROR_SEVERITY()	AS 	[ERROR SEVERITY],
				ERROR_STATE()		AS 	[ERROR STATE]
	END CATCH
END
-- ================================================================================================================================================================= --

-- ================================================================================================================================================================= --
CREATE PROCEDURE [dbo].[SP Update Product Data]
(
	@ID_Product					CHAR(5)					,
	@FkID_Category					CHAR(5)					,
	@FkID_Presentation				INT					,
	@FkID_Quantities				INT					,
	@FkID_Supplier					CHAR(5)					,
	@ProductName					VARCHAR(25)				,
	@Mark						VARCHAR(25)				,
	@UnitPrice					MONEY					,
	@UnitsInStock					INT					,
	@StateProcedure					INT
)
AS
BEGIN
	BEGIN TRY
		SET @StateProcedure = 1

		IF EXISTS (SELECT * FROM Products WHERE ID_Product = @ID_Product)
		BEGIN
			UPDATE [dbo].[Products]
			SET		FkID_Category			=		@FkID_Category		,
					FkID_Presentation		=		@FkID_Presentation	,
					FkID_Quantities			=		@FkID_Quantities	,
					FkID_Supplier			=		@FkID_Supplier		,
					ProductName			=		@ProductName		,
					Mark				=		@Mark			,
					UnitPrice			=		@UnitPrice		,
					UnitsInStock			=		@UnitsInStock
			WHERE		ID_Product			=		@ID_Product

			SELECT CONCAT(@StateProcedure, ':') AS [State Procedure], 'Successful modification' AS [ Message ]
		END
		ELSE
		BEGIN
			IF NOT EXISTS (SELECT * FROM Products WHERE ID_Product = @ID_Product)
			BEGIN
				SET @StateProcedure = - 1

				SELECT CONCAT(@StateProcedure, ':') AS [State Procedure], 'Not found ID_Product' AS [ Message ]
			END
		END
	END TRY
	BEGIN CATCH
		SELECT		ERROR_LINE()		AS 	[ERROR LINE],
				ERROR_MESSAGE()		AS	[ERROR MESSAGE],
				ERROR_NUMBER()		AS 	[ERROR NUMBER],
				ERROR_PROCEDURE()	AS 	[ERROR PROCEDURE],
				ERROR_SEVERITY()	AS 	[ERROR SEVERITY],
				ERROR_STATE()		AS 	[ERROR STATE]
	END CATCH
END
-- ================================================================================================================================================================= --


-- ================================================================================================================================================================= --
/*									SELL STORED PROCEDURES			  						     */
-- ================================================================================================================================================================= --

CREATE PROCEDURE [SP Insert Sell Data]
(
	@SellCode					CHAR(20)		OUTPUT		,
	@FkID_Pay					INT					,
	@FkIdentityCarnet				INT					,
	@FkID_Employee					CHAR(5)					,
	@FkID_Product					CHAR(5)					,
	@RegistrationDate				DATETIME		OUTPUT		,
	@QuantityProducts				INT					,
	@Discount					SMALLINT			
)
AS
BEGIN
	BEGIN TRY
		SET DATEFORMAT DMY
		BEGIN TRANSACTION

			SET @RegistrationDate = GETDATE()

			IF NOT EXISTS (SELECT * FROM [dbo].[Sell])
			BEGIN
				DECLARE @Number INT = 1000000000000000
				SET @SellCode = CONCAT(CAST('N' AS CHAR(1)), CAST('SELL' AS CHAR(4)), CAST(@Number AS CHAR(15)))

				INSERT INTO [dbo].[Sell] (SellCode, FkID_Pay, FkIdentityCarnet, FkID_Employee, FkID_Product, RegistrationDate, QuantityProducts, Discount)
				SELECT @SellCode, @FkID_Pay, @FkIdentityCarnet, @FkID_Employee, @FkID_Product, @RegistrationDate, @QuantityProducts, @Discount

				SELECT 'First successful insertion sell data' AS [Insertion Message]

				UPDATE [dbo].[Products]
				SET 		UnitsInStock			=		UnitsInStock 		- 1
				WHERE 		ID_Product			=		@FkID_Product

				SELECT 'Stock product has updated' AS [Product Stock update message]
			END
			ELSE
			BEGIN
				IF EXISTS (SELECT * FROM [dbo].[Sell])
				BEGIN
					DECLARE @Iterate INT = 1

					DECLARE @Kidnapper INT = (SELECT CAST(SUBSTRING(MAX(SellCode),6,15) AS INT) FROM [dbo].[Sell])

					SET @Kidnapper = @Iterate + @Kidnapper

					SET @SellCode = CONCAT(CAST('N' AS CHAR(1)), CAST('SELL' AS CHAR(4)), CAST(@Kidnapper AS CHAR(15)))

					INSERT INTO [dbo].[Sell] (SellCode, FkID_Pay, FkIdentityCarnet, FkID_Employee, FkID_Product, RegistrationDate, QuantityProducts, Discount)
					SELECT @SellCode, @FkID_Pay, @FkIdentityCarnet, @FkID_Employee, @FkID_Product, @RegistrationDate, @QuantityProducts, @Discount

					SELECT 'Last successful insertion sell data' AS [Insertion Message]

					UPDATE [dbo].[Products]
					SET 		UnitsInStock			=		UnitsInStock 		- 1
					WHERE 		ID_Product			=		@FkID_Product

					SELECT 'Stock product has updated' AS [Product Stock update message]
				END
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		SELECT		ERROR_LINE()		AS [ERROR LINE],
				ERROR_MESSAGE()		AS [ERROR MESSAGE],
				ERROR_NUMBER()		AS [ERROR NUMBER],
				ERROR_PROCEDURE()	AS [ERROR PROCEDURE],
				ERROR_SEVERITY()	AS [ERROR SEVERITY],
				ERROR_STATE()		AS [ERROR STATE]
	END CATCH
END
-- ================================================================================================================================================================= --
