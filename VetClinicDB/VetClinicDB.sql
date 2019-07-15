IF EXISTS (SELECT 1 FROM master.dbo.sysdatabases 
WHERE name = 'VetClinicDB')

BEGIN
	DROP	DATABASE [VETCLINICDB];
	print '' print ' *** Dropping database VETCLINICDB'
	
END
GO

print '' print ' *** Creating Database VETCLINICDB'

GO
CREATE DATABASE [VETCLINICDB]
GO

print '' print ' *** Using Database VETCLINICDB'

GO
USE [VETCLINICDB]
GO


print '' print ' *********** TABLES START HERE *********** '


print '' print ' ***Creating Account Ownwer Table'
GO
CREATE TABLE [dbo].[AccountOwner] (
	[AccountOwnerID]		[int]				NOT NULL,
	[FirstName]				[nvarchar](50)		NOT NULL,
	[LastName]				[nvarchar](150)		NOT NULL,
	[Email]					[nvarchar](250)				,
	[Password]				[nvarchar](100)		NOT NULL,
	[Address]				[nvarchar](250)		NOT NULL,
	[City]					[nvarchar](50)		NOT NULL,
	[State]					[nvarchar](2)		NOT NULL DEFAULT 'IA',
	[Zipcode]				[nvarchar](10)		NOT NULL,
	[DateCreated]			[date]				NOT NULL,
	[Active]				[bit]				NOT NULL DEFAULT 1,
	
	CONSTRAINT [pk_AccountOwnerID] PRIMARY KEY([AccountOwnerID] ASC),
	CONSTRAINT [ak_Email] UNIQUE([Email] ASC)
)
GO

print '' print '*** NEED TO INSERT RECORDS FOR ACCOUNT OWNER HERE ***'


print '' print ' ***Creating Order Table'
GO
CREATE TABLE [dbo].[Order] (
	[OrderID]				[int]				NOT NULL,
	[AccountOwnerID]		[int]				NOT NULL,
	[DateCreated]			[date]				NOT NULL,
	[Total]					[decimal](5,2)		NOT NULL,
	
	CONSTRAINT [pk_OrderID] PRIMARY KEY([OrderID] ASC)
)
GO

print '' print '*** NEED TO INSERT RECORDS FOR ORDER HERE ***'


print '' print ' ***Creating Item Type Table'
GO
CREATE TABLE [dbo].[ItemType] (
	[ItemTypeID]			[nvarchar](50)		NOT NULL,
	[Description]			[nvarchar](1000)			,
	
	CONSTRAINT [pk_ItemTypeID] PRIMARY KEY([ItemTypeID] ASC)
)
GO

print '' print '*** NEED TO INSERT RECORDS FOR ITEM TYPE HERE ***'


print '' print ' ***Creating Item Table'
GO
CREATE TABLE [dbo].[Item] (
	[ItemID]				[nvarchar](25)		NOT NULL,
	[ItemTypeID]			[nvarchar](50)		NOT NULL,
	[Price]					[decimal](5,2)		NOT NULL,
	[Quantity]				[int]				NOT NULL,
	
	CONSTRAINT [pk_ItemID] PRIMARY KEY([ItemID] ASC)
)
GO

print '' print '*** NEED TO INSERT RECORDS FOR ITEM HERE ***'



print '' print ' ***Creating Order Line Table'
GO
CREATE TABLE [dbo].[OrderLine] (
	[OrderID]				[int]				NOT NULL,
	[ItemID]				[nvarchar](25)		NOT NULL,
	
	CONSTRAINT [pk_OrderLines] PRIMARY KEY([OrderID], [ItemID] ASC),
)
GO

print '' print '*** NEED TO INSERT RECORDS FOR ORDER LINE HERE ***'


print '' print ' ***Creating Appointment Type Table'
GO
CREATE TABLE [dbo].[AppointmentType] (
	[AppointmentTypeID]		[nvarchar](50)		NOT NULL,
	[Description]			[nvarchar](1000)	NOT NULL,
	
	CONSTRAINT [pk_AppointmentTypeID] PRIMARY KEY([AppointmentTypeID] ASC)
)
GO

print '' print '*** NEED TO INSERT RECORDS FOR APPOINTMENT TYPE HERE ***'



print '' print ' ***Creating Employee Type Table'
GO
CREATE TABLE [dbo].[EmployeeType] (
	[EmployeeTypeID]		[nvarchar](50)		NOT NULL,
	[Description]			[nvarchar](1000)			,
	
	CONSTRAINT [pk_EmployeeTypeID] PRIMARY KEY([EmployeeTypeID] ASC)
)
GO

print '' print '*** NEED TO INSERT RECORDS FOR EMPLOYEE TYPE HERE ***'


print '' print ' ***Creating Employee Table'
GO
CREATE TABLE [dbo].[Employee] (
	[EmployeeID]			[int]				NOT NULL,
	[EmployeeTypeID]		[nvarchar](50)		NOT NULL,
	[FirstName]				[nvarchar](50)		NOT NULL,
	[LastName]				[nvarchar](150)		NOT NULL,
	[Email]					[nvarchar](250)		NOT NULL,
	[Password]				[nvarchar](100)		NOT NULL,
	[StartDate]				[date]				NOT NULL,
	[EndDate]				[date]						,
	[Active]				[bit]				NOT NULL DEFAULT 1,
	
	CONSTRAINT [pk_EmployeeID] PRIMARY KEY([EmployeeID] ASC),
	CONSTRAINT [ak_EmailEmployee] UNIQUE([Email] ASC)
)
GO

print '' print '*** NEED TO INSERT RECORDS FOR EMPLOYEE HERE ***'


print '' print ' ***Creating Breed Table'
GO
CREATE TABLE [dbo].[Breed] (
	[BreedID]			[nvarchar](250)		NOT NULL,
	[PetTypeID]			[nvarchar](50)		NOT NULL,
	
	CONSTRAINT [pk_BreedID] PRIMARY KEY([BreedID] ASC)
)
GO

print '' print '*** NEED TO INSERT RECORDS FOR BREED HERE ***'



print '' print ' ***Creating Pet Type Table'
GO
CREATE TABLE [dbo].[PetType] (
	[PetTypeID]			[nvarchar](50)		NOT NULL,
	
	CONSTRAINT [pk_PetTypeID] PRIMARY KEY([PetTypeID] ASC)
)
GO

print '' print '*** NEED TO INSERT RECORDS FOR PET TYPE HERE ***'


print '' print ' ***Creating Pet Table'
GO
CREATE TABLE [dbo].[Pet] (
	[PetID]					[int]				NOT NULL,
	[AccountOwnerID]		[int]				NOT NULL,
	[PetTypeID]				[nvarchar](50)		NOT NULL,
	[Name]					[nvarchar](50)		NOT NULL,
	[Age]					[int]				NOT NULL,
	[Weight]				[decimal](3,2)		NOT NULL,
	[Color]					[nvarchar](50)		NOT NULL,
	[Gender]				[nvarchar](50)		NOT NULL,
	[Fixed]					[bit]				NOT NULL DEFAULT 0,
	[Birthday]				[date]				NOT NULL,
	[Active]				[bit]				NOT NULL DEFAULT 1,
	
	CONSTRAINT [pk_PetID] PRIMARY KEY([PetID] ASC),
	CONSTRAINT [ak_AccountOwnerIDPet] UNIQUE([AccountOwnerID] ASC)
)
GO

print '' print '*** NEED TO INSERT RECORDS FOR PET HERE ***'



print '' print ' ***Creating Appointment Table'
GO
CREATE TABLE [dbo].[Appointment] (
	[AppointmentID]			[int]				NOT NULL,
	[AppointmentTypeID]		[nvarchar](50)		NOT NULL,
	[AccountOwnerID]		[int]				NOT NULL,
	[PetID]					[int]				NOT NULL,
	[EmployeeID]			[int]				NOT NULL,
	[DateCreated]			[date]				NOT NULL,
	[AppointmentDate]		[date]				NOT NULL,
	[StartTime]				[time]				NOT NULL,
	[EndTime]				[time]				NOT NULL,
	[CheckedIn]				[bit]				NOT NULL DEFAULT 0,
	
	CONSTRAINT [pk_AppointmentID] PRIMARY KEY([AppointmentID] ASC)
)
GO

print '' print '*** NEED TO INSERT RECORDS FOR APPOINTMENT HERE ***'


print '' print ' ***Creating Drug Type Table'
GO
CREATE TABLE [dbo].[DrugType] (
	[DrugTypeID]			[nvarchar](50)		NOT NULL,
	[Description]			[nvarchar](1000)			,
	
	CONSTRAINT [pk_DrugTypeID] PRIMARY KEY([DrugTypeID] ASC)
)
GO

print '' print '*** NEED TO INSERT RECORDS FOR DRUG TYPE HERE ***'



print '' print ' ***Creating Drug Table'
GO
CREATE TABLE [dbo].[Drug] (
	[DrugID]				[int]				NOT NULL,
	[DrugTypeID]			[nvarchar](50)		NOT NULL,
	[Name]					[nvarchar](100)		NOT NULL,
	[Description]			[nvarchar](1000)	NOT NULL,
	
	CONSTRAINT [pk_DrugID] PRIMARY KEY([DrugID] ASC)
)
GO

print '' print '*** NEED TO INSERT RECORDS FOR DRUG HERE ***'


print '' print ' ***Creating Prescription Table'
GO
CREATE TABLE [dbo].[Prescription] (
	[PrescriptionID]		[int]				NOT NULL,
	[DrugID]				[int]				NOT NULL,
	[EmployeeID]			[int]				NOT NULL,
	[PetID]					[int]				NOT NULL,
	[Dosage]				[nvarchar](50)		NOT NULL,
	[Directions]			[nvarchar](1000)	NOT NULL,
	
	CONSTRAINT [pk_PrescriptionID] PRIMARY KEY([PrescriptionID] ASC)
)
GO

print '' print '*** NEED TO INSERT RECORDS FOR PRESCRIPTION HERE ***'



print '' print ' *********** TABLES END HERE *********** '




print '' print ' *********** FK CONSTRAINTS START HERE *********** '


print '' print ' *********** FK CONSTRAINTS END HERE *********** '





print '' print ' *********** STORED PROCEDURES START HERE *********** '



print '' print ' *********** STORED PROCEDURES END HERE *********** '


