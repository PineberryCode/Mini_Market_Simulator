/* -- =================================================================== --
	*|	Database	:	[MINI MARKET SIMULATOR]
	*|	BirthDate	:	July 4th, 2022
	*|	By		:	PineberryCode	||	MINDLUNNY
-- =================================================================== -- */
	CREATE DATABASE [MINI MARKET SIMULATOR]
	GO
--	....................................... 	--
	USE [MINI MARKET SIMULATOR]
	GO

/* *************************************************************************************************************** */
	CREATE TABLE [dbo].[Method Customer's Pay]
	(
		ID_Pay					INT IDENTITY				NOT NULL,
		PayMethod				VARCHAR(15)				NOT NULL,

		PRIMARY KEY				(ID_Pay)					,

		CONSTRAINT chk_PayMethod CHECK (PayMethod = 'Cash' OR PayMethod = 'Debit' OR PayMethod = 'Credit')
	)
/* *************************************************************************************************************** */


/* ************************************************************************************************************************************** */
	CREATE TABLE [dbo].[Customer]
	(
		IdentityCarnet				INT					NOT NULL,
		FirstName				VARCHAR(25)				NOT NULL,
		SecondName				VARCHAR(25)				NOT NULL,
		LastName				VARCHAR(25)				NOT NULL,
		MothersLastName				VARCHAR(25)				NOT NULL,
		Celphone				VARCHAR(20)				NOT NULL,
		PostalCode				VARCHAR(10)				NOT NULL,
		Country					VARCHAR(30)				NOT NULL,
		Region					VARCHAR(30)				NOT NULL,
		City					VARCHAR(30)				NOT NULL,
		CustomerAddress				VARCHAR(80)				NOT NULL,

		PRIMARY KEY				(IdentityCarnet)				
	)
/* ************************************************************************************************************************************** */


/* ****************************************************************************************************** */
	CREATE TABLE [dbo].[Salary]
	(
		ID_Salary				CHAR(5)					NOT NULL,
		Rol					VARCHAR(20)				NOT NULL,
		Salary					MONEY					NOT NULL,

		PRIMARY KEY				(ID_Salary)
	)
/* ****************************************************************************************************** */


/* **************************************************************************************************************************************** */
	CREATE TABLE [dbo].[Employee]
	(
		ID_Employee				CHAR(5)					NOT NULL,
		FkID_Salary				CHAR(5)					NOT NULL,
		FirstName				VARCHAR(25)				NOT NULL,
		SecondName				VARCHAR(25)					,
		LastName				VARCHAR(25)				NOT NULL,
		MothersLastName				VARCHAR(25)				NOT NULL,
		Celphone				VARCHAR(20)				NOT NULL,
		BirthDate				DATE					NOT NULL,
		PostalCode				VARCHAR(10)				NOT NULL,
		Country					VARCHAR(30)				NOT NULL,
		Region					VARCHAR(30)				NOT NULL,
		City					VARCHAR(30)				NOT NULL,
		EmployeeAddress				VARCHAR(80)				NOT NULL,
		Photo					IMAGE						,

		PRIMARY KEY				(ID_Employee)					,

		CONSTRAINT fk_Salary FOREIGN KEY (FkID_Salary) REFERENCES [dbo].[Salary] (ID_Salary)
	)
/* **************************************************************************************************************************************** */


/* **************************************************************************************************************************************** */
	CREATE TABLE [dbo].[Suppliers]
	(
		ID_Supplier				CHAR(5)					NOT NULL,
		CompanyName				VARCHAR(25)				NOT NULL,
		E_mail					VARCHAR(30)				NOT NULL,
		Celphone				VARCHAR(20)				NOT NULL,
		HomePage				TEXT						,
		PostalCode				VARCHAR(10)				NOT NULL,
		Country					VARCHAR(30)				NOT NULL,
		Region					VARCHAR(30)				NOT NULL,
		City					VARCHAR(30)				NOT NULL,
		SupplierAddress				VARCHAR(80)				NOT NULL,
		Active					BIT					NOT NULL,

		PRIMARY KEY				(ID_Supplier)					,

		CONSTRAINT chk_ActiveSupplier CHECK (Active = 1 OR Active = 0 OR Active = 'True' OR Active = 'False')
	)
/* **************************************************************************************************************************************** */


/* ****************************************************************************************************** */
	CREATE TABLE [dbo].[Category Products]
	(
		ID_Category				CHAR(5)					NOT NULL,
		CategoryName				VARCHAR(25)				NOT NULL,

		PRIMARY KEY				(ID_Category)
	)
/* ****************************************************************************************************** */


/* ****************************************************************************************************** */
	CREATE TABLE [dbo].[Presentation]
	(
		ID_Presentation				INT IDENTITY				NOT NULL,
		Contents				VARCHAR(20)				NOT NULL,

		PRIMARY KEY				(ID_Presentation)
	)
/* ****************************************************************************************************** */


/* ****************************************************************************************************** */
	CREATE TABLE [dbo].[Measurement Quantities]
	(
		ID_Measurement				INT IDENTITY				NOT NULL,
		Measurements				VARCHAR(5)				NOT NULL,

		PRIMARY KEY				(ID_Measurement)
	)
/* ****************************************************************************************************** */


/* ****************************************************************************************************************************************** */
	CREATE TABLE [dbo].[Quantities]
	(
		ID_Quantities				INT IDENTITY				NOT NULL,
		FkID_Measurement			INT					NOT NULL,
		MeasurQuantities			FLOAT					NOT NULL,

		PRIMARY KEY				(ID_Quantities)					,

		CONSTRAINT fk_MeasurementQuantities FOREIGN KEY (FkID_Measurement) REFERENCES [dbo].[Measurement Quantities] (ID_Measurement)
	)
/* ****************************************************************************************************************************************** */


/* *************************************************************************************************************************** */
	CREATE TABLE [dbo].[Products]
	(
		ID_Product				CHAR(5)					NOT NULL,
		FkID_Category				CHAR(5)					NOT NULL,
		FkID_Presentation			INT					NOT NULL,
		FkID_Quantities				INT					NOT NULL,
		FkID_Supplier				CHAR(5)					NOT NULL,
		ProductName				VARCHAR(25)				NOT NULL,
		Mark					VARCHAR(25)				NOT NULL,
		UnitPrice				MONEY					NOT NULL,
		UnitsInStock				INT						,

		PRIMARY KEY				(ID_Product)					,

		CONSTRAINT fk_categoryProducts FOREIGN KEY (FkID_Category) REFERENCES [dbo].[Category Products] (ID_Category),
		CONSTRAINT fk_Presentation FOREIGN KEY (FkID_Presentation) REFERENCES [dbo].[Presentation] (ID_Presentation),
		CONSTRAINT fk_Quantities FOREIGN KEY (FkID_Quantities) REFERENCES [dbo].[Quantities] (ID_Quantities),
		CONSTRAINT fk__Supplier FOREIGN KEY (FkID_Supplier) REFERENCES [dbo].[Suppliers] (ID_Supplier)
	)
/* *************************************************************************************************************************** */


/* *********************************************************************************************************************** */
	CREATE TABLE [dbo].[Sell]
	(
		SellCode				CHAR(20)				NOT NULL,
		FkID_Pay				INT					NOT NULL,
		FkIdentityCarnet			INT					NOT NULL,
		FkID_Employee				CHAR(5)					NOT NULL,
		FkID_Product				CHAR(5)					NOT NULL,
		RegistrationDate			DATETIME				NOT NULL,
		QuantityProducts			INT					NOT NULL,
		Discount				SMALLINT				NOT NULL,

		PRIMARY KEY				(SellCode)					,

		CONSTRAINT fk_MethodCustomersPay FOREIGN KEY (FkID_Pay) REFERENCES [dbo].[Method Customer's Pay] (ID_Pay),
		CONSTRAINT fk_customer FOREIGN KEY (FkIdentityCarnet) REFERENCES [dbo].[Customer] (IdentityCarnet),
		CONSTRAINT fk_cashier FOREIGN KEY (FkID_Employee) REFERENCES [dbo].[Employee] (ID_Employee),
		CONSTRAINT fk___Products FOREIGN KEY (FkID_Product) REFERENCES [dbo].[Products] (ID_Product)
	)
/* *********************************************************************************************************************** */


/* ****************************************************************************************************** */
	CREATE TABLE [dbo].[Eagle Eye]
	(
		NameParameters				VARCHAR(20)				NOT NULL,
		ColumnValues				VARCHAR(30)				NOT NULL,

		PRIMARY KEY				(NameParameters)
	)
/* ****************************************************************************************************** */
