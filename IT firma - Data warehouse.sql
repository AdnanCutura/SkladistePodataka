CREATE DATABASE IT_Firma_DW;
GO
USE IT_Firma_DW;
GO

CREATE TABLE dbo.DimLokacija
(
    LokacijaKey INT IDENTITY(1, 1) NOT NULL,
    LokacijaAltKey INT NOT NULL,
    Grad NVARCHAR(50) NOT NULL,
    Regija NVARCHAR(50) NOT NULL,
    Drzava NVARCHAR(50) NOT NULL
        CONSTRAINT [PK_Lokacija]
        PRIMARY KEY CLUSTERED (LokacijaKey ASC)
);

CREATE TABLE dbo.DimDatum
(
    DatumKey INT IDENTITY(1, 1) NOT NULL,
    DatumAltKey DATE NOT NULL,
    Dan SMALLINT NOT NULL,
    Mjesec SMALLINT NOT NULL,
    Godina SMALLINT NOT NULL
        CONSTRAINT [PK_Datum]
        PRIMARY KEY CLUSTERED (DatumKey ASC)
);

CREATE TABLE dbo.DimKlijent
(
    KlijentKey INT IDENTITY(1, 1) NOT NULL,
    KlijentAltKey INT NOT NULL,
    ImePrezime NVARCHAR(100) NOT NULL,
    Spol NCHAR(1) NOT NULL,
    CONSTRAINT [PK_Klijent]
        PRIMARY KEY CLUSTERED (KlijentKey ASC)
);

CREATE TABLE dbo.DimFramework
(
    FrameworkKey INT IDENTITY(1, 1) NOT NULL,
    FrameworkAltKey INT NOT NULL,
    Framework NVARCHAR(40) NOT NULL
        CONSTRAINT [PK_Framework]
        PRIMARY KEY CLUSTERED (FrameworkKey ASC)
);

CREATE TABLE dbo.DimUgovor
(
    UgovorKey INT IDENTITY(1, 1) NOT NULL,
    UgovorAltKey INT NOT NULL,
    CijenaProjekta DECIMAL(12, 2) NOT NULL,
    DatumSklapanja DATE NOT NULL,
    DatumIsporuke DATE NOT NULL,
	NazivAplikacije NVARCHAR(40) NOT NULL,
    StopaPoreza INT NOT NULL
        CONSTRAINT [PK_Ugovor]
        PRIMARY KEY CLUSTERED (UgovorKey ASC)
);

CREATE TABLE dbo.DimPoslovnaJedinica
(
    PoslovnaJedinicaKey INT IDENTITY(1, 1) NOT NULL,
    PoslovnaJedinicaAltKey NVARCHAR(40) NOT NULL
        CONSTRAINT [PK_PoslovnaJedinica]
        PRIMARY KEY CLUSTERED (PoslovnaJedinicaKey ASC)
);

CREATE TABLE dbo.DimRazvojniTim
(
    RazvojniTimKey INT IDENTITY(1, 1) NOT NULL,
    RazvojniTimAltKey NVARCHAR(50) NOT NULL,
    BrojRadnika SMALLINT NOT NULL
        CONSTRAINT [PK_RazvojniTim]
        PRIMARY KEY CLUSTERED (RazvojniTimKey ASC)
);

CREATE TABLE dbo.DimTipAplikacije(
	TipAplikacijeKey INT IDENTITY(1, 1) NOT NULL,
    TipAplikacijeAltKey  NVARCHAR(40) NOT NULL,    
        CONSTRAINT [PK_TipAplikacije]
        PRIMARY KEY CLUSTERED (TipAplikacijeKey ASC)
);

CREATE TABLE dbo.FactDobitFirme(
    DobitFirmeKey INT NOT NULL IDENTITY(1, 1),
    UkupnaDobit DECIMAL(12, 2) NOT NULL,	
    LokacijaKlijentKey INT
        CONSTRAINT FK_DobitFirme_LokacijaKlijent
        FOREIGN KEY REFERENCES dbo.DimLokacija (LokacijaKey) NOT NULL,
    LokacijaPoslovnaJedinicaKey INT
        CONSTRAINT FK_DobitFirme_LokacijaPoslovnaJedinica
        FOREIGN KEY REFERENCES dbo.DimLokacija (LokacijaKey) NOT NULL,
    UgovorSklapanjeDatumKey INT
        CONSTRAINT FK_DobitFirme_UgovorSklapanjeDatum
        FOREIGN KEY REFERENCES dbo.DimDatum (DatumKey) NOT NULL,
    UgovorIsporukaDatumKey INT
        CONSTRAINT FK_DobitFirme_UgovorIsporukaDatum
        FOREIGN KEY REFERENCES dbo.DimDatum (DatumKey) NOT NULL, 
    KlijentKey INT
        CONSTRAINT FK_DobitFirme_Klijent
        FOREIGN KEY REFERENCES dbo.DimKlijent (KlijentKey) NOT NULL,
    FrameworkKey INT
        CONSTRAINT FK_DobitFirme_Framework
        FOREIGN KEY REFERENCES dbo.DimFramework (FrameworkKey) NOT NULL,
    UgovorKey INT
        CONSTRAINT FK_DobitFirme_Ugovor
        FOREIGN KEY REFERENCES dbo.DimUgovor (UgovorKey) NOT NULL,
    PoslovnaJedinicaKey INT
        CONSTRAINT FK_DobitFirme_PoslovnaJedinica
        FOREIGN KEY REFERENCES dbo.DimPoslovnaJedinica (PoslovnaJedinicaKey) NOT NULL,
    RazvojniTimKey INT
        CONSTRAINT FK_DobitFirme_RazvojniTim
        FOREIGN KEY REFERENCES dbo.DimRazvojniTim (RazvojniTimKey) NOT NULL,
	TipAplikacijeKey INT
        CONSTRAINT FK_DobitFirme_TipAplikacije
        FOREIGN KEY REFERENCES dbo.DimTipAplikacije (TipAplikacijeKey) NOT NULL,
        CONSTRAINT [PK_DobitFirme]
        PRIMARY KEY CLUSTERED (DobitFirmeKey ASC)
);

