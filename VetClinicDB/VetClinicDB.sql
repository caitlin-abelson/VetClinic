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


print '' print ' *** Creating Account Ownwer Table'
GO
CREATE TABLE [dbo].[AccountOwner] (
	[AccountOwnerID]		[int] IDENTITY(10000, 1)	NOT NULL,
	[FirstName]				[nvarchar](50)				NOT NULL,
	[LastName]				[nvarchar](150)				NOT NULL,
	[Email]					[nvarchar](250)				,
	[Password]				[nvarchar](100)				NOT NULL DEFAULT
		'9c9064c59f1ffa2e174ee754d2979be80dd30db552ec03e7e327e9b1a4bd594e',
	[Address]				[nvarchar](250)				NOT NULL,
	[City]					[nvarchar](50)				NOT NULL,
	[State]					[nvarchar](2)				NOT NULL DEFAULT 'IA',
	[Zipcode]				[nvarchar](10)				NOT NULL,
	[DateCreated]			[date]						NOT NULL,
	[Active]				[bit]						NOT NULL DEFAULT 1,
	
	CONSTRAINT [pk_AccountOwnerID] PRIMARY KEY([AccountOwnerID] ASC),
	CONSTRAINT [ak_Email] UNIQUE([Email] ASC)
)
GO

print '' print '*** Inserting Account Owner Test Records ***'
GO
INSERT INTO [dbo].[AccountOwner]
		([FirstName], [LastName], [Email], [Address], [City], [Zipcode], [DateCreated])
	VALUES
		('Danielle', 'Russo', 'drusso@gmail.com', '123 Fake St SW', 'Cedar Rapids', '52404', '2004-08-12'),
		('Caitlin', 'Abelson', 'cableman@yahoo.com', '524 1st Ave', 'Iowa City', '52243', '2010-03-25'),
		('Miranda', 'Pilsbery', 'rlux@gmail.com', '11520 Como Rd', 'Cedar Rapids', '52403', '2011-05-25'),
		('Jeffree', 'Star', 'teaspill@hotmail.com', '1  Maquillaje Ct NE', 'Cedar Rapids', '52404', '2018-01-11'),
		('Peter', 'Quinn', 'pquinn@gmail.com', '500 18th St SE', 'Cedar Rapids', '52402', '2009-10-13')
GO	

print '' print '*** NEED TO INSERT INACTIVE ACCOUNT OWNER TEST DATA ***'
GO

print '' print ' *** Creating Order Table'
GO
CREATE TABLE [dbo].[Order] (
	[OrderID]				[int]IDENTITY(10000, 1)		NOT NULL,
	[AccountOwnerID]		[int]						NOT NULL,
	[DateCreated]			[date]						NOT NULL,
	
	CONSTRAINT [pk_OrderID] PRIMARY KEY([OrderID] ASC)
)
GO

print '' print '*** Inserting Order Test Records ***'
GO
INSERT INTO [dbo].[Order]
		([AccountOwnerID], [DateCreated])
	VALUES
		(10000, '2018-03-15'),
		(10000, '2018-06-12'),
		(10000, '2019-01-08'),
		(10000, '2019-05-26'),
		(10001, '2019-01-15'),
		(10001, '2018-02-15'),
		(10001, '2018-04-30'),
		(10001, '2018-07-29'),
		(10002, '2018-07-15'),
		(10002, '2018-07-26'),
		(10003, '2017-07-15'),
		(10003, '2018-02-28'),
		(10003, '2018-12-15'),
		(10004, '2019-03-18'),
		(10004, '2019-04-23'),
		(10004, '2010-06-04')
GO


print '' print ' *** Creating Item Type Table'
GO
CREATE TABLE [dbo].[ItemType] (
	[ItemTypeID]			[nvarchar](50)		NOT NULL,
	[Description]			[nvarchar](1000)			,
	
	CONSTRAINT [pk_ItemTypeID] PRIMARY KEY([ItemTypeID] ASC)
)
GO

print '' print '*** Inserting Item Type Test Records ***'
GO
INSERT INTO [dbo].[ItemType]
		([ItemTypeID], [Description])
	VALUES
		('Dog Food', 'Food for all dogs of all ages.'),
		('Cat Food', 'Food for all cats of all ages.'),
		('Cat Toys', 'Hair ties, paper bags, and cat nip.'),
		('Dog Toys', 'Toys for dogs of all ages.'),
		('Dog Health', 'Flea, tick, heart worm prevention.'),
		('Cat Health', 'Flea prevention and mental health remedies.')
GO
	
print '' print ' ***Creating Item Table'
GO
CREATE TABLE [dbo].[Item] (
	[ItemID]				[int]IDENTITY(10000, 1)		NOT NULL,
	[Name]					[nvarchar](50)				NOT NULL,
	[ItemTypeID]			[nvarchar](50)				NOT NULL,
	[Price]					[decimal](5,2)				NOT NULL,
	
	CONSTRAINT [pk_ItemID] PRIMARY KEY([ItemID] ASC)
)
GO

print '' print '*** Inserting Item Test Records ***'
GO
INSERT INTO [dbo].[Item]
		([Name], [ItemTypeID], [Price])
	VALUES
		('Puppy Chow', 'Dog Food', 19.99),
		('Chicken and Rice', 'Dog Food', 25.50),
		('Beef and Carrots', 'Dog Food', 25.50),
		('Senior Diet', 'Dog Food', 32.99),
		('Weight Management', 'Dog Food', 35.00),
		('Chicken, 6 cans', 'Cat Food', 6.99),
		('Chicken, 10 cans', 'Cat Food', 10.99),
		('Surf & Turf', 'Cat Food', 17.99),
		('Chubby Kitty', 'Cat Food', 19.99),
		('Vegan & Gluten Free', 'Cat Food', 38.65),
		('Cat Nip Mice', 'Cat Toys', 2.99),
		('Lazer Pointer', 'Cat Toys', 9.99),
		('Exercise Ball', 'Cat Toys', 29.50),
		('Tennis Ball, 3 pack', 'Dog Toys', 5.50),
		('Tug-a-Rope', 'Dog Toys', 19.99),
		('Stuffed Duck', 'Dog Toys', 15.50),
		('Triple Care Drops', 'Dog Health', 79.98),
		('Flea Coller', 'Dog Health', 19.95),
		('Flea Spray', 'Cat Health', 49.95),
		('Calming Spray', 'Cat Health', 29.00)
GO


print '' print ' ***Creating Order Line Table'
GO
CREATE TABLE [dbo].[OrderLine] (
	[OrderID]				[int]				NOT NULL,
	[ItemID]				[int]				NOT NULL,
	[Quantity]				[int]				NOT NULL,
	
	CONSTRAINT [pk_OrderLines] PRIMARY KEY([OrderID] ASC, [ItemID] ASC)
)
GO

print '' print '*** Inserting Order Line Test Records ***'
GO
INSERT INTO [dbo].[OrderLine]
		([OrderID], [ItemID], [Quantity])
	VALUES
		(10000, 10001, 1),
		(10000, 10018, 1),
		(10000, 10002, 3),
		(10000, 10005, 1),
		(10000, 10010, 1),
		(10000, 10012, 2),
		(10001, 10002, 8),
		(10002, 10019, 1),
		(10002, 10001, 1),
		(10003, 10002, 2),
		(10003, 10004, 1),
		(10004, 10011, 1),
		(10005, 10013, 1),
		(10005, 10008, 1),
		(10005, 10009, 1),
		(10006, 10003, 1),
		(10006, 10009, 1),
		(10007, 10018, 1),
		(10008, 10006, 1),
		(10009, 10000, 1),
		(10009, 10012, 2),
		(10009, 10013, 2),
		(10010, 10007, 1),
		(10011, 10010, 1),
		(10012, 10008, 1),
		(10012, 10002, 2),
		(10013, 10019, 1),
		(10014, 10019, 2),
		(10014, 10013, 1),
		(10015, 10003, 1),
		(10015, 10005, 1)
GO


print '' print ' ***Creating Appointment Type Table'
GO
CREATE TABLE [dbo].[AppointmentType] (
	[AppointmentTypeID]		[nvarchar](50)		NOT NULL,
	[Description]			[nvarchar](1000)	NOT NULL,
	[AllotedTime]			int					NOT NULL,
	
	CONSTRAINT [pk_AppointmentTypeID] PRIMARY KEY([AppointmentTypeID] ASC)
)
GO

print '' print '*** Inserting Appointment Type Test Records ***'
GO
INSERT INTO [dbo].[AppointmentType]
		([AppointmentTypeID], [Description], [AllotedTime])
	VALUES
		('General Checkup & Vaccination', 'Having your veterinarian perform an annual wellness exam with appropriate vaccinations will help your pets immune system against contagious diseases and allow for early detection of changes in your pets health.', 10),
		('Sick Visit', 'Many reasons could explain loss of appetite or vomiting, including some serious conditions. Your veterinarian will be able to determine the exact cause in order find the solution that is best suited for your pet.', 20),
		('Follow-up', 'Your pet just had a special treatment or a surgery that need a recommended follow-up.', 10),
		('Tech', 'Keeping your pet comfortable and clean is an important of his/her health. We recommend the following regular visits.', 20)
GO		



print '' print ' ***Creating Employee Type Table'
GO
CREATE TABLE [dbo].[EmployeeType] (
	[EmployeeTypeID]		[nvarchar](50)		NOT NULL,
	[Description]			[nvarchar](1000)			,
	
	CONSTRAINT [pk_EmployeeTypeID] PRIMARY KEY([EmployeeTypeID] ASC)
)
GO

print '' print '*** Inserting Employee Type Test Records ***'
INSERT INTO [dbo].[EmployeeType]
		([EmployeeTypeID], [Description])
	VALUES
		('Veterinarian', 'Liscensed veterinarian'),
		('Veterinary Technician', 'Liscensed vet tech'),
		('Receptionist', 'Check-ins, answers calls, make appointments')
GO


print '' print ' ***Creating Employee Table'
GO
CREATE TABLE [dbo].[Employee] (
	[EmployeeID]			[int] IDENTITY(10000, 1)	NOT NULL,
	[EmployeeTypeID]		[nvarchar](50)				NOT NULL,
	[FirstName]				[nvarchar](50)				NOT NULL,
	[LastName]				[nvarchar](150)				NOT NULL,
	[Email]					[nvarchar](250)				NOT NULL,
	[Password]				[nvarchar](100)				NOT NULL DEFAULT
		'9c9064c59f1ffa2e174ee754d2979be80dd30db552ec03e7e327e9b1a4bd594e',
	[StartDate]				[date]						NOT NULL,
	[EndDate]				[date]						,
	[Active]				[bit]						NOT NULL DEFAULT 1,
	
	CONSTRAINT [pk_EmployeeID] PRIMARY KEY([EmployeeID] ASC),
	CONSTRAINT [ak_EmailEmployee] UNIQUE([Email] ASC)
)
GO

print '' print '*** Inserting Employee Test Records ***'
GO
INSERT INTO [dbo].[Employee]
		([EmployeeTypeID], [FirstName], [LastName], [Email], [StartDate])
	VALUES
		('Veterinarian', 'June', 'Osborne', 'jbone@freyvet.com', '2009-04-20'),
		('Veterinarian', 'Dexter', 'Morgan', 'dexmo@freyvet.com', '2014-08-10'),
		('Veterinarian', 'Elliot', 'Skyrim', 'elderscrolls@freyvet.com', '2018-03-30'),
		('Veterinarian Technician', 'Parker', 'Rexington', 'prex@freyvet.com', '2010-11-15'),
		('Veterinarian Technician', 'Harvey', 'Rabbit', 'harvey@freyvet.com', '2019-03-01'),
		('Receptionist', 'Tonya', 'Atari', 'tatari@freyvet.com', '2005-12-09'),
		('Receptionist', 'Thomas', 'Chains', 'txchain@freyvet.com', '2014-08-23')
GO

print '' print '*** Inserting Inactive Employee Test Records ***'
GO
INSERT INTO [dbo].[Employee]
		([EmployeeTypeID], [FirstName], [LastName], [Email], [StartDate], [EndDate], [Active])
	VALUES
		('Veterinarian', 'Glynnis', 'Waters', 'gwaters@freyvet.com', '2009-04-20', '2010-01-01', 0),
		('Veterinarian Technician', 'Lex', 'Pika', 'pikapika@freyvet.com', '2010-11-15', '2018-05-03', 0)
GO

print '' print ' ***Creating Pet Type Table'
GO
CREATE TABLE [dbo].[PetType] (
	[PetTypeID]			[nvarchar](50)		NOT NULL,
	
	CONSTRAINT [pk_PetTypeID] PRIMARY KEY([PetTypeID] ASC)
)
GO

print '' print '*** Inserting Pet Type Test Records ***'
GO
INSERT INTO [dbo].[PetType]
		([PetTypeID])
	VALUES
		('Cat'),
		('Dog')
GO

print '' print ' ***Creating Breed Table'
GO
CREATE TABLE [dbo].[Breed] (
	[BreedID]			[nvarchar](250)		NOT NULL,
	[PetTypeID]			[nvarchar](50)		NOT NULL,
	
	CONSTRAINT [pk_BreedID] PRIMARY KEY([BreedID] ASC)
)
GO

print '' print '*** Inserting Breed Test Data ***'
GO
INSERT INTO [dbo].[Breed]
		([PetTypeID], [BreedID])
	VALUES
		('Cat', 'Domestic Short Hair'),
		('Cat', 'Domestic Medium Hair'),
		('Cat', 'Domestic Long Hair'),
		('Cat', 'Maine Coon'),
		('Cat', 'Bangle'),
		('Dog', 'Lab Mix'),
		('Dog', 'Chocolate Lab'),
		('Dog', 'Black Lab'),
		('Dog', 'Yellow Lab'),
		('Dog', 'German Shepard'),
		('Dog', 'Corgi'),
		('Dog', 'St. Bernard'),
		('Dog', 'English Springer Spanel'),
		('Dog', 'Border Collie')
GO

print '' print ' ***Creating Pet Table'
GO
CREATE TABLE [dbo].[Pet] (
	[PetID]					[int] IDENTITY(10000, 1)	NOT NULL,
	[AccountOwnerID]		[int]						NOT NULL,
	[BreedID]				[nvarchar](250)				NOT NULL,
	[Name]					[nvarchar](50)				NOT NULL,
	[Age]					[int]						NOT NULL,
	[Weight]				[decimal](4,2)				NOT NULL,
	[Color]					[nvarchar](50)				NOT NULL,
	[Gender]				[nvarchar](50)				NOT NULL,
	[Fixed]					[bit]						NOT NULL DEFAULT 0,
	[Birthday]				[date]						NOT NULL,
	[Active]				[bit]						NOT NULL DEFAULT 1,
	
	CONSTRAINT [pk_PetID] PRIMARY KEY([PetID] ASC)
)
GO


GO
INSERT INTO [dbo].[Pet]
	([AccountOwnerID], [BreedID], [Name], [Age], [Weight], [Color], [Gender], [Fixed], [Birthday], [Active])
	VALUES
	('10000', 'Domestic Shorthair', 'Scrambles', 2, 9.7, 'Grey Tabby', 'Male', 1, '07-04-2017', 1),
	('10000', 'Domestic Shorthair', 'Tybalt', 5, 13.4, 'Brown and Black', 'Male', 1, '05-01-2014', 1),
	('10000', 'Domestic Medium Hair', 'Wilder', 4, 12.8, 'Orange', 'Male', 1, '05-31-2015', 1),
	('10001', 'Domestic Short Hair', 'Mika', 4, 10.2, 'Brown Tabby', 'Female', 1, '10-20-2015', 1),
	('10001', 'Domestic Short Hair', 'Ren', 3, 12.3, 'Black and White', 'Male', 1, '05-03-2016', 1),
	('10002', 'Corgi', 'Sir Lancelot', 6, 27.9, 'Yellow and White', 'Male', 1, '11-21-2012', 1),
	('10003', 'Border Collie', 'Sandbag', 2, 22.3, 'Black and White', 'Male', 1, '01-19-2017', 1),
	('10003', 'Maine Coon', 'Taco', 5, 11.9, 'Black and Grey', 'Female', 1, '07-27-2014', 1),
	('10004', 'Chocolate Lab', 'Hank', 9, 76.4, 'Brown', 'Male', 1, '02-13-2010', 1)


print '' print ' ***Creating Appointment Table'
GO
CREATE TABLE [dbo].[Appointment] (
	[AppointmentID]			[int]IDENTITY(10000, 1)	NOT NULL,
	[AppointmentTypeID]		[nvarchar](50)			NOT NULL,
	[AccountOwnerID]		[int]					NOT NULL,
	[PetID]					[int]					NOT NULL,
	[EmployeeID]			[int]					NOT NULL,
	[DateCreated]			[date]					NOT NULL,
	[AppointmentDate]		[date]					NOT NULL,
	[StartTime]				[time]					NOT NULL,
	[EndTime]				[time]					NOT NULL,
	[CheckedIn]				[bit]					NOT NULL DEFAULT 0,
	
	CONSTRAINT [pk_AppointmentID] PRIMARY KEY([AppointmentID] ASC)
)
GO

print '' print '*** Inserting Appointment Test Records ***'
GO
INSERT INTO [dbo].[Appointment]
		([AppointmentTypeID],[AccountOwnerID],[PetID],[EmployeeID],[DateCreated],[AppointmentDate],[StartTime],[EndTime], [CheckedIn])
	VALUES
		('General Checkup & Vaccination', 10000, 10000, 10000,'2019-06-05','2019-06-22','09:00:00','09:10:00', 0),
		('Sick Visit', 10000, 10001, 10003,'2019-04-20','2019-04-21','13:30:00','13:40:00', 1),
		('Follow-up', 10001, 10003, 10000,'2019-06-15','2019-07-01','08:40:00','09:00:00', 0)
GO

print '' print ' ***Creating Drug Type Table'
GO
CREATE TABLE [dbo].[DrugType] (
	[DrugTypeID]			[nvarchar](50)		NOT NULL,
	[Description]			[nvarchar](1000)			,
	
	CONSTRAINT [pk_DrugTypeID] PRIMARY KEY([DrugTypeID] ASC)
)
GO

print '' print '*** Inserting Records for DrugType'
GO
INSERT INTO [dbo].[DrugType]
	([DrugTypeID], [Description])
	Values
	('Pill','Administered orally'),
	('Liquid','Administered orally'),
	('Injection','Administered through needle'),
	('Rectal','Administered through rectum')
GO


print '' print ' ***Creating Drug Table'
GO
CREATE TABLE [dbo].[Drug] (
	[DrugID]				[int] IDENTITY		NOT NULL,
	[DrugTypeID]			[nvarchar](50)		NOT NULL,
	[Name]					[nvarchar](100)		NOT NULL,
	[Description]			[nvarchar](1000)	NOT NULL,
	
	CONSTRAINT [pk_DrugID] PRIMARY KEY([DrugID] ASC)
)
GO

print '' print '*** Inserting Records for Drug'
GO
INSERT INTO [dbo].[Drug]
	([DrugTypeID], [Name], [Description])
	Values
	('Injection', 'Ivermectin', 'Deworming medication for dogs. Takes effect within 1-2 hours.'),
	('Pill', 'Ketoconazole', 'Antifungal medication for dogs and cats. For both internal and external fungus.'),
	('Pill', 'Prednisone', 'Steroid for both cats and dogs. Used to treat various conditions.'),
	('Pill', 'Tramadol', 'Medication for pain management for both cats and dogs.'),
	('Injection', 'Insulin', 'Used to treat diabetes in both cats and dogs.'),
	('Rectal', 'Valium', 'Used to treat dogs that are have seizures.')
GO

print '' print ' ***Creating Prescription Table'
GO
CREATE TABLE [dbo].[Prescription] (
	[PrescriptionID]		[int] IDENTITY			NOT NULL,
	[DrugID]				[int]				NOT NULL,
	[EmployeeID]			[int]				NOT NULL,
	[PetID]					[int]				NOT NULL,
	[Dosage]				[nvarchar](50)		NOT NULL,
	[Directions]			[nvarchar](1000)	NOT NULL,
	
	CONSTRAINT [pk_PrescriptionID] PRIMARY KEY([PrescriptionID] ASC)
)
GO

print '' print '*** Inserting Records for Prescription'
GO
INSERT INTO [dbo].[Prescription]
	([DrugID], [EmployeeID], [PetID], [Dosage], [Directions])
	Values
	('100000', '100000', '10000', '5ml', 'Deworming medication for dogs. Takes effect within 1-2 hours.'),
	('100002', '100001', '10002', '5mg', 'Antifungal medication for dogs and cats. For both internal and external fungus.'),
	('100004', '100001', '10002', '4ml', 'Steroid for both cats and dogs. Used to treat various conditions.'),
	('100003', '100002', '10002', '10mg', 'Medication for pain management for both cats and dogs.'),
	('100001', '100000', '10001', '2mg', 'Used to treat diabetes in both cats and dogs.'),
	('100005', '100002', '10000', '10mg', 'Used to treat dogs that are have seizures.')
GO



print '' print ' *********** TABLES END HERE *********** '




print '' print ' *********** FK CONSTRAINTS START HERE *********** '

print '' print '*** Adding foreign key AccountOwnerID for Order'
ALTER TABLE [dbo].[Order] WITH NOCHECK 
	ADD CONSTRAINT [fk_AccountOwnerID] FOREIGN KEY([AccountOwnerID])
	REFERENCES [dbo].[AccountOwner]([AccountOwnerID])
	ON UPDATE CASCADE
GO

print '' print '*** Adding foreign key ItemTypeID for Item'
ALTER TABLE [dbo].[Item] WITH NOCHECK 
	ADD CONSTRAINT [fk_ItemTypeID] FOREIGN KEY([ItemTypeID])
	REFERENCES [dbo].[ItemType]([ItemTypeID])
	ON UPDATE CASCADE
GO

print '' print '*** Adding foreign key EmployeeTypeID for Employee'
ALTER TABLE [dbo].[Employee] WITH NOCHECK 
	ADD CONSTRAINT [fk_EmployeeTypeID] FOREIGN KEY([EmployeeTypeID])
	REFERENCES [dbo].[EmployeeType]([EmployeeTypeID])
	ON UPDATE CASCADE
GO

print '' print '*** Adding foreign key PetTypeID for Breed'
ALTER TABLE [dbo].[Breed] WITH NOCHECK 
	ADD CONSTRAINT [fk_PetTypeID] FOREIGN KEY([PetTypeID])
	REFERENCES [dbo].[PetType]([PetTypeID])
	ON UPDATE CASCADE
GO

print '' print '*** Adding foreign key PetTypeID for Pet'
ALTER TABLE [dbo].[Pet] WITH NOCHECK 
	ADD CONSTRAINT [fk_AccountOwnerID_Pet] FOREIGN KEY([AccountOwnerID])
	REFERENCES [dbo].[AccountOwner]([AccountOwnerID])
	ON UPDATE CASCADE
GO


print '' print '*** Adding foreign key BreedID for Pet'
ALTER TABLE [dbo].[Pet] WITH NOCHECK 
	ADD CONSTRAINT [fk_BreedID] FOREIGN KEY([BreedID])
	REFERENCES [dbo].[Breed]([BreedID])
	ON UPDATE CASCADE
GO

print '' print '*** Adding foreign key AccountOwnerID for Appointment'
ALTER TABLE [dbo].[Appointment] WITH NOCHECK 
	ADD CONSTRAINT [fk_AccountOwnerID_Appointment] FOREIGN KEY([AccountOwnerID])
	REFERENCES [dbo].[AccountOwner]([AccountOwnerID])
	ON UPDATE CASCADE
GO

print '' print '*** Adding foreign key Pet for Appointment'
ALTER TABLE [dbo].[Appointment] WITH NOCHECK 
	ADD CONSTRAINT [fk_PetID] FOREIGN KEY([PetID])
	REFERENCES [dbo].[Pet]([PetID])
GO

print '' print '*** Adding foreign key EmployeeID for Appoinment'
ALTER TABLE [dbo].[Appointment] WITH NOCHECK 
	ADD CONSTRAINT [fk_EmployeeID] FOREIGN KEY([EmployeeID])
	REFERENCES [dbo].[Employee]([EmployeeID])
	ON UPDATE CASCADE
GO

print '' print '*** Adding foreign key AppointmentTypeID for Appointment'
ALTER TABLE [dbo].[Appointment] WITH NOCHECK 
	ADD CONSTRAINT [fk_AppointmentTypeID] FOREIGN KEY([AppointmentTypeID])
	REFERENCES [dbo].[AppointmentType]([AppointmentTypeID])
	ON UPDATE CASCADE
GO

print '' print '*** Adding foreign key DrugTypeID for Drug'
ALTER TABLE [dbo].[Drug] WITH NOCHECK 
	ADD CONSTRAINT [fk_DrugTypeID] FOREIGN KEY([DrugTypeID])
	REFERENCES [dbo].[DrugType]([DrugTypeID])
	ON UPDATE CASCADE
GO


print '' print '*** Adding foreign key PetID for Prescription'
ALTER TABLE [dbo].[Prescription] WITH NOCHECK 
	ADD CONSTRAINT [fk_PetID_Prescription] FOREIGN KEY([PetID])
	REFERENCES [dbo].[Pet]([PetID])
	ON UPDATE CASCADE
GO

print '' print '*** Adding foreign key EmployeeID for Prescription'
ALTER TABLE [dbo].[Prescription] WITH NOCHECK 
	ADD CONSTRAINT [fk_EmployeeID_Prescription] FOREIGN KEY([EmployeeID])
	REFERENCES [dbo].[Employee]([EmployeeID])
	ON UPDATE CASCADE
GO

print '' print '*** Adding foreign key DrugID for Prescription'
ALTER TABLE [dbo].[Prescription] WITH NOCHECK 
	ADD CONSTRAINT [fk_DrugID] FOREIGN KEY([DrugID])
	REFERENCES [dbo].[Drug]([DrugID])
	ON UPDATE CASCADE
GO

print '' print ' *********** FK CONSTRAINTS END HERE *********** '





print '' print ' *********** STORED PROCEDURES START HERE *********** '



print '' print ' *********** STORED PROCEDURES END HERE *********** '


