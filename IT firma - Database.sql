CREATE DATABASE IT_Firma_DB
GO

USE IT_Firma_DB
GO

CREATE TABLE dbo.Drzava(
	DrzavaId INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Naziv NVARCHAR(50) NOT NULL
)

CREATE TABLE dbo.Regija(
	RegijaId INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Naziv NVARCHAR(50) NOT NULL,
	DrzavaId INT FOREIGN KEY REFERENCES dbo.Drzava(DrzavaId) NOT NULL
)

CREATE TABLE dbo.Grad(
	GradId INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Naziv NVARCHAR(50) NOT NULL,
	RegijaId INT FOREIGN KEY REFERENCES dbo.Regija(RegijaId) NOT NULL
)

CREATE TABLE dbo.Klijent(
	KlijentId INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ImePrezime NVARCHAR(100) NOT NULL,
	Spol NCHAR(1) NOT NULL,
	GradId INT FOREIGN KEY REFERENCES dbo.Grad(GradId) NOT NULL,
	DatumRodjenja DATETIME NULL
)

CREATE TABLE dbo.PoslovnaJedinica(
	PoslovnaJedinicaId INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Naziv NVARCHAR(40) NOT NULL,
	GradId INT FOREIGN KEY REFERENCES dbo.Grad(GradId) NOT NULL
)


CREATE TABLE dbo.RazvojniTim(
	RazvojniTimId INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Naziv NVARCHAR(50) NOT NULL,
	PoslovnaJedinicaId INT FOREIGN KEY REFERENCES dbo.PoslovnaJedinica(PoslovnaJedinicaId) NOT NULL	
)

CREATE TABLE dbo.Pozicija(
	PozicijaId INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Naziv NVARCHAR(50) NOT NULL
)

CREATE TABLE dbo.Radnik(
	RadnikId INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ImePrezime NVARCHAR(100) NOT NULL,
	GodineIskustva INT NOT NULL,	
	Plata DECIMAL (12,2) NOT NULL,
	PozicijaId INT FOREIGN KEY REFERENCES dbo.Pozicija(PozicijaId) NOT NULL,
	RazvojniTimId INT FOREIGN KEY REFERENCES dbo.RazvojniTim(RazvojniTimId) NOT NULL
)

CREATE TABLE dbo.Framework(
	FrameworkId INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Naziv NVARCHAR(40) NOT NULL
)

CREATE TABLE dbo.Ugovor(
	UgovorId INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	DatumSklapanja DATE NOT NULL,
	DatumIsporuke DATE NOT NULL,
	CijenaProjekta DECIMAL (12,2) NOT NULL,
	StopaPoreza INT NOT NULL,
	OpisZahtjeva NTEXT NOT NULL,
	PoslovnaJedinicaId INT FOREIGN KEY REFERENCES dbo.PoslovnaJedinica(PoslovnaJedinicaId) NOT NULL,
	KlijentId INT FOREIGN KEY REFERENCES dbo.Klijent(KlijentId) NOT NULL
)

CREATE TABLE dbo.TipAplikacije(
	TipAplikacijeId INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Naziv NVARCHAR(40) NOT NULL

)
CREATE TABLE dbo.Aplikacija(
	AplikacijaId INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Naziv NVARCHAR(40) NOT NULL,
	RazvojniTimId INT FOREIGN KEY REFERENCES dbo.RazvojniTim(RazvojniTimId) NOT NULL,
	UgovorId INT UNIQUE FOREIGN KEY REFERENCES dbo.Ugovor(UgovorId) NOT NULL,
	TipAplikacijeId INT FOREIGN KEY REFERENCES dbo.TipAplikacije(TipAplikacijeId) NOT NULL,
	FrameworkId INT FOREIGN KEY REFERENCES dbo.Framework(FrameworkId) NOT NULL
)
CREATE TABLE dbo.TipRashoda(
	TipRashodaId INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Naziv NVARCHAR(40) NOT NULL
)
CREATE TABLE dbo.Rashod(
	RashodId INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	AplikacijaId INT FOREIGN KEY REFERENCES dbo.Aplikacija(AplikacijaId) NOT NULL,	
	IznosRashoda DECIMAL (12,2) NOT NULL,
	TipRashodaId INT FOREIGN KEY REFERENCES dbo.TipRashoda(TipRashodaId) NOT NULL
)
