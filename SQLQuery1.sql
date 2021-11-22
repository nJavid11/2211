CREATE DATABASE CinemaPlus
 
USE CinemaPlus

CREATE TABLE Movies
(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR(50)
)

CREATE TABLE Languages
(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR(50)
)

CREATE TABLE MovieLanguages
(
Id INT IDENTITY PRIMARY KEY,
MovieId INT FOREIGN KEY REFERENCES Movies(Id),
LanguageId INT FOREIGN KEY REFERENCES Languages(Id)
)

CREATE TABLE Branches
(
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(50)
)

CREATE TABLE Halls
(
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(30),
	BranchId INT FOREIGN KEY REFERENCES Branches(Id)
)

CREATE TABLE Seanses
(
	Id INT IDENTITY PRIMARY KEY,
	MovieLanguageId INT FOREIGN KEY REFERENCES MovieLanguages(Id),
	HallId INT FOREIGN KEY REFERENCES Halls(Id),
	Time datetime2,
	SubtitleLanguageId INT FOREIGN KEY REFERENCES Languages(Id),
	Price DECIMAL
)

INSERT INTO Movies
VALUES
('Interstellar'),
('Inception'),
('Breaking Bad'),
('Venom 2'),
('Venom')

INSERT INTO Languages
VALUES
('Azerbaijani'),
('Turkish'),
('English')

SELECT * FROM Movies
SELECT * FROM Languages

INSERT INTO MovieLanguages
VALUES
(1,3),
(2,2),
(3,3),
(4,1),
(5,2)

Select * FROM MovieLanguages


INSERT INTO Branches
VALUES
('Deniz Mall'),
('Khamsa Park (Ganja)'),
('28 Mall'),
('Ganjlik Mall'),
('Sumqayit'),
('Ganja Mall (Ganja)'),
('Amburan Mall'),
('Azerbaijan Cinema')

Select * FROM Branches
truncate table Branches

INSERT INTO Halls
VALUES
('Zal 8 (Atmos)',1),
('Zal 1',2),
('Platinum',3),
('Zal 5',4),
('Zal 1',5),
('Emiland VIP',6),
(N'PAŞA Bank',7),
('Zal 2',8),
('Mastercard',1),
('InvestAZ',2),
('Zal 3',3)

INSERT INTO Seanses
VALUES
(1,1,'11-11-2021',1,12)
(3,4,'08-08-2021',2,15)
(4,2,'10-11-2021',1,20)
(5,3,'12-10-2021',3,12)
(3,5,'10-10-2021',2,20)

INSERT INTO Seanses
VALUES
(3,1,'10-11-2021',2,12),
(2,1,'09-11-2021',1,12),
(1,1,'07-08-2021',3,16),
(2,4,'06-05-2021',2,15),
(1,4,'11-06-2021',3,15),
(3,4,'03-02-2021',1,17)

--1ST TASK
Select * FROM Seanses
Where Time Like '2021-08-08%'

---2ND TASK
SELECT * FROM Movies AS M
JOIN MovieLanguages AS ML ON MovieId = M.Id
WHERE EXISTS (SELECT * FROM Seanses WHERE MovieLanguageId = ML.Id)

--3ND TASK
SELECT *,Halls.Name,Branches.Name FROM Seanses
JOIN Halls ON HallId=Halls.Id
JOIN Branches ON BranchId=Branches.Id

--4TH TASK
Select *, (Select Count(HallId) From Seanses Where HallId = Halls.Id) as 'Count' From Halls

--5TH TASK
create view CounTofHalls
as
select *, (select count(HallId) from Seanses where HallId = Halls.Id ) as 'Count' from Halls
join Seanses on Seanses.HallId=Halls.Id

select /*Halls.Id,Halls.Name,--> gives errors*/ count(Count) as 'CountofHalls' from CounTofHalls
WHERE Count > 3 /*and Seanses.Time like '%22%'--> gives errors*/
