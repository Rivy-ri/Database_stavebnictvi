USE [master]
GO
/****** Object:  Database [Kamenne_obklady]    Script Date: 24.12.2022 22:09:54 ******/
CREATE DATABASE [Kamenne_obklady]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Kamenne_obklady', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Kamenne_obklady.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Kamenne_obklady_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Kamenne_obklady_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Kamenne_obklady] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Kamenne_obklady].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Kamenne_obklady] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Kamenne_obklady] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Kamenne_obklady] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Kamenne_obklady] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Kamenne_obklady] SET ARITHABORT OFF 
GO
ALTER DATABASE [Kamenne_obklady] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Kamenne_obklady] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Kamenne_obklady] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Kamenne_obklady] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Kamenne_obklady] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Kamenne_obklady] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Kamenne_obklady] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Kamenne_obklady] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Kamenne_obklady] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Kamenne_obklady] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Kamenne_obklady] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Kamenne_obklady] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Kamenne_obklady] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Kamenne_obklady] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Kamenne_obklady] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Kamenne_obklady] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Kamenne_obklady] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Kamenne_obklady] SET RECOVERY FULL 
GO
ALTER DATABASE [Kamenne_obklady] SET  MULTI_USER 
GO
ALTER DATABASE [Kamenne_obklady] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Kamenne_obklady] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Kamenne_obklady] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Kamenne_obklady] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Kamenne_obklady] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Kamenne_obklady] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Kamenne_obklady', N'ON'
GO
ALTER DATABASE [Kamenne_obklady] SET QUERY_STORE = ON
GO
ALTER DATABASE [Kamenne_obklady] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Kamenne_obklady]
GO
/****** Object:  User [vydejce]    Script Date: 24.12.2022 22:09:54 ******/
CREATE USER [vydejce] FOR LOGIN [Vydejce] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [prodejce]    Script Date: 24.12.2022 22:09:54 ******/
CREATE USER [prodejce] FOR LOGIN [Prodejce] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [majitel]    Script Date: 24.12.2022 22:09:54 ******/
CREATE USER [majitel] FOR LOGIN [Majitel] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [vydejce]
GO
ALTER ROLE [db_datareader] ADD MEMBER [prodejce]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [prodejce]
GO
ALTER ROLE [db_owner] ADD MEMBER [majitel]
GO
USE [Kamenne_obklady]
GO
/****** Object:  Sequence [dbo].[Cislo_objednavky_generate]    Script Date: 24.12.2022 22:09:55 ******/
CREATE SEQUENCE [dbo].[Cislo_objednavky_generate] 
 AS [int]
 START WITH 6000
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
GO
/****** Object:  Table [dbo].[Prodejna]    Script Date: 24.12.2022 22:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prodejna](
	[ID_prodejna] [int] IDENTITY(1,1) NOT NULL,
	[Adresa] [varchar](60) NOT NULL,
	[Kod_prodejny] [varchar](10) NOT NULL,
 CONSTRAINT [Prodejna_PK] PRIMARY KEY CLUSTERED 
(
	[ID_prodejna] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Zamestnanec]    Script Date: 24.12.2022 22:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zamestnanec](
	[ID_zamestnanec] [int] IDENTITY(1,1) NOT NULL,
	[Jmeno] [varchar](30) NOT NULL,
	[Prijmeni] [varchar](30) NOT NULL,
	[Prodejna_ID_prodejna] [int] NOT NULL,
 CONSTRAINT [Zamestnanec_PK] PRIMARY KEY CLUSTERED 
(
	[ID_zamestnanec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Pocet_zamestnancu_na_Prodejne]    Script Date: 24.12.2022 22:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create view [dbo].[Pocet_zamestnancu_na_Prodejne] as
	Select count(Zamestnanec.Jmeno) Pocet_zamestnancu,Prodejna.Kod_prodejny
		From Zamestnanec 
			inner join Prodejna
				on Prodejna.ID_prodejna=Zamestnanec.Prodejna_ID_prodejna group by Prodejna.Kod_prodejny;
GO
/****** Object:  Table [dbo].[Vyrobce]    Script Date: 24.12.2022 22:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vyrobce](
	[ID_vyrobce] [int] IDENTITY(1,1) NOT NULL,
	[Nazev] [varchar](30) NOT NULL,
	[Zkratka] [varchar](10) NULL,
	[E-mail] [varchar](30) NOT NULL,
 CONSTRAINT [Vyrobce_PK] PRIMARY KEY CLUSTERED 
(
	[ID_vyrobce] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Zbozi]    Script Date: 24.12.2022 22:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zbozi](
	[ID_zbozi] [int] IDENTITY(1,1) NOT NULL,
	[Kod] [varchar](30) NOT NULL,
	[Cely_nazev] [varchar](50) NOT NULL,
	[Vyrobce_ID_vyrobce] [int] NOT NULL,
	[Cena] [int] NOT NULL,
	[Pocet_ks_na_sklade] [int] NOT NULL,
	[Merna_jednotka] [varchar](30) NOT NULL,
 CONSTRAINT [Zbozi_PK] PRIMARY KEY CLUSTERED 
(
	[ID_zbozi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Zasoby_na_sklade]    Script Date: 24.12.2022 22:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[Zasoby_na_sklade]  as 
	Select Zbozi.Cely_nazev produkt, Zbozi.Kod kod_produktu,Zbozi.Pocet_ks_na_sklade,Zbozi.Merna_jednotka, Vyrobce.Nazev dodavatel, Vyrobce.[E-mail] kontakt_na_dodavatele
		From Zbozi 
			inner join Vyrobce
				on Vyrobce.ID_vyrobce=Zbozi.Vyrobce_ID_vyrobce
GO
/****** Object:  Table [dbo].[Objednavka]    Script Date: 24.12.2022 22:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Objednavka](
	[ID_Objednavka] [int] IDENTITY(1,1) NOT NULL,
	[Cislo_objednavky] [numeric](28, 0) NOT NULL,
	[Faktura_ID_Faktura] [int] NOT NULL,
	[Prodejna_ID_prodejna] [int] NOT NULL,
	[Celkova_castka_k_zaplaceni] [int] NULL,
 CONSTRAINT [Objednavka_PK] PRIMARY KEY CLUSTERED 
(
	[ID_Objednavka] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Objednavka/Zbozi]    Script Date: 24.12.2022 22:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Objednavka/Zbozi](
	[ID_Zbozi/objednavka] [int] IDENTITY(1,1) NOT NULL,
	[Zbozi_ID_zbozi] [int] NOT NULL,
	[Objednavka_ID_Objednavka] [int] NOT NULL,
	[Pocet_objednanych_ks] [int] NULL,
 CONSTRAINT [Relation_28_PK] PRIMARY KEY CLUSTERED 
(
	[ID_Zbozi/objednavka] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Polozky_Objednavky]    Script Date: 24.12.2022 22:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[Polozky_Objednavky] as
	Select Objednavka.Cislo_objednavky, Zbozi.Kod,Zbozi.Cely_nazev, [Objednavka/Zbozi].Pocet_objednanych_ks, Zbozi.Merna_jednotka
		From [Objednavka/Zbozi]
		inner join Objednavka
			on Objednavka.ID_Objednavka=[Objednavka/Zbozi].Objednavka_ID_Objednavka
		inner join Zbozi 
			on Zbozi.ID_zbozi=[Objednavka/Zbozi].Zbozi_ID_zbozi
GO
/****** Object:  Table [dbo].[Faktura]    Script Date: 24.12.2022 22:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faktura](
	[ID_Faktura] [int] IDENTITY(1,1) NOT NULL,
	[Datum_vystaveni] [datetime] NOT NULL,
	[Datum_splatnosti] [date] NOT NULL,
	[Variabilni_symbol] [numeric](28, 0) NOT NULL,
	[Konstantni_symbol] [numeric](28, 0) NOT NULL,
	[Zakaznik_ID_zakaznik] [int] NOT NULL,
	[Zamestnanec_ID_zamestnanec] [int] NOT NULL,
	[Zaplaceno] [bit] NOT NULL,
 CONSTRAINT [Faktura_PK] PRIMARY KEY CLUSTERED 
(
	[ID_Faktura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Zakaznik]    Script Date: 24.12.2022 22:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zakaznik](
	[ID_zakaznik] [int] IDENTITY(1,1) NOT NULL,
	[Jmeno] [varchar](30) NOT NULL,
	[Prijmeni] [varchar](30) NOT NULL,
	[E-mail] [varchar](50) NOT NULL,
	[Telefon] [varchar](15) NOT NULL,
 CONSTRAINT [Zakaznik_PK] PRIMARY KEY CLUSTERED 
(
	[ID_zakaznik] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Vypis_Faktur_a_Zakazniku]    Script Date: 24.12.2022 22:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[Vypis_Faktur_a_Zakazniku] as 
	Select Zakaznik.Jmeno+' '+Zakaznik.Prijmeni as [jmeno zakaznika],
			Objednavka.Cislo_objednavky [cislo objednavky],
			Faktura.Datum_vystaveni,
			Faktura.Datum_splatnosti,
			Objednavka.[Celkova_castka_k_zaplaceni],
			Faktura.Zaplaceno [stav platby],
			Zamestnanec.Jmeno+' '+Zamestnanec.Prijmeni as [vystavil zamestnanec]
				From Faktura
				inner join Zamestnanec on
					Zamestnanec.ID_zamestnanec=Faktura.Zamestnanec_ID_zamestnanec
				inner join Zakaznik on
					Zakaznik.ID_zakaznik=Faktura.Zakaznik_ID_zakaznik
				inner join Objednavka on
					Objednavka.Faktura_ID_Faktura=Faktura.ID_Faktura
GO
/****** Object:  Index [Cislo_objednavky]    Script Date: 24.12.2022 22:09:55 ******/
CREATE NONCLUSTERED INDEX [Cislo_objednavky] ON [dbo].[Objednavka]
(
	[Cislo_objednavky] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Objednavka__IDX]    Script Date: 24.12.2022 22:09:55 ******/
CREATE UNIQUE NONCLUSTERED INDEX [Objednavka__IDX] ON [dbo].[Objednavka]
(
	[Faktura_ID_Faktura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Jmeno_a_prijmeni]    Script Date: 24.12.2022 22:09:55 ******/
CREATE NONCLUSTERED INDEX [Jmeno_a_prijmeni] ON [dbo].[Zakaznik]
(
	[Jmeno] ASC,
	[Prijmeni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Cely_nazev]    Script Date: 24.12.2022 22:09:55 ******/
CREATE NONCLUSTERED INDEX [Cely_nazev] ON [dbo].[Zbozi]
(
	[Cely_nazev] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Kod]    Script Date: 24.12.2022 22:09:55 ******/
CREATE NONCLUSTERED INDEX [Kod] ON [dbo].[Zbozi]
(
	[Kod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Faktura]  WITH CHECK ADD  CONSTRAINT [Faktura_Zakaznik_FK] FOREIGN KEY([Zakaznik_ID_zakaznik])
REFERENCES [dbo].[Zakaznik] ([ID_zakaznik])
GO
ALTER TABLE [dbo].[Faktura] CHECK CONSTRAINT [Faktura_Zakaznik_FK]
GO
ALTER TABLE [dbo].[Faktura]  WITH CHECK ADD  CONSTRAINT [Faktura_Zamestnanec_FK] FOREIGN KEY([Zamestnanec_ID_zamestnanec])
REFERENCES [dbo].[Zamestnanec] ([ID_zamestnanec])
GO
ALTER TABLE [dbo].[Faktura] CHECK CONSTRAINT [Faktura_Zamestnanec_FK]
GO
ALTER TABLE [dbo].[Objednavka]  WITH CHECK ADD  CONSTRAINT [Objednavka_Faktura_FK] FOREIGN KEY([Faktura_ID_Faktura])
REFERENCES [dbo].[Faktura] ([ID_Faktura])
GO
ALTER TABLE [dbo].[Objednavka] CHECK CONSTRAINT [Objednavka_Faktura_FK]
GO
ALTER TABLE [dbo].[Objednavka]  WITH CHECK ADD  CONSTRAINT [Objednavka_Prodejna_FK] FOREIGN KEY([Prodejna_ID_prodejna])
REFERENCES [dbo].[Prodejna] ([ID_prodejna])
GO
ALTER TABLE [dbo].[Objednavka] CHECK CONSTRAINT [Objednavka_Prodejna_FK]
GO
ALTER TABLE [dbo].[Objednavka/Zbozi]  WITH CHECK ADD  CONSTRAINT [Relation_28_Objednavka_FK] FOREIGN KEY([Objednavka_ID_Objednavka])
REFERENCES [dbo].[Objednavka] ([ID_Objednavka])
GO
ALTER TABLE [dbo].[Objednavka/Zbozi] CHECK CONSTRAINT [Relation_28_Objednavka_FK]
GO
ALTER TABLE [dbo].[Objednavka/Zbozi]  WITH CHECK ADD  CONSTRAINT [Relation_28_Zbozi_FK] FOREIGN KEY([Zbozi_ID_zbozi])
REFERENCES [dbo].[Zbozi] ([ID_zbozi])
GO
ALTER TABLE [dbo].[Objednavka/Zbozi] CHECK CONSTRAINT [Relation_28_Zbozi_FK]
GO
ALTER TABLE [dbo].[Zamestnanec]  WITH CHECK ADD  CONSTRAINT [Zamestnanec_Prodejna_FK] FOREIGN KEY([Prodejna_ID_prodejna])
REFERENCES [dbo].[Prodejna] ([ID_prodejna])
GO
ALTER TABLE [dbo].[Zamestnanec] CHECK CONSTRAINT [Zamestnanec_Prodejna_FK]
GO
ALTER TABLE [dbo].[Zbozi]  WITH CHECK ADD  CONSTRAINT [Zbozi_Vyrobce_FK] FOREIGN KEY([Vyrobce_ID_vyrobce])
REFERENCES [dbo].[Vyrobce] ([ID_vyrobce])
GO
ALTER TABLE [dbo].[Zbozi] CHECK CONSTRAINT [Zbozi_Vyrobce_FK]
GO
/****** Object:  StoredProcedure [dbo].[Vypis_polozek_objednavky_podle_cisla]    Script Date: 24.12.2022 22:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Vypis_polozek_objednavky_podle_cisla]
@Cislo_objenavky numeric(28)
AS
Select 
	Polozky_Objednavky.Kod [Kod polozky],
	Polozky_Objednavky.Cely_nazev [polozka],
	Cast(Polozky_Objednavky.Pocet_objednanych_ks as varchar)+ ' '+Polozky_Objednavky.Merna_jednotka [pocet] ,
	Celkova_castka_k_zaplaceni [Celkova cena]
From Objednavka 
	inner join Polozky_Objednavky
		on Objednavka.Cislo_objednavky=Polozky_Objednavky.cislo_objednavky
where Objednavka.Cislo_objednavky=@Cislo_objenavky;
GO
/****** Object:  StoredProcedure [dbo].[Vypocet_cenny_objednavky]    Script Date: 24.12.2022 22:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Vypocet_cenny_objednavky]
 @Cislo_objenavky int 
AS 
declare @Castka int;
BEGIN
  SELECT @Castka = SUM(Celkova_cena_polozek)
  FROM
  (
    SELECT SUM(Zbozi.Cena*Polozky_Objednavky.Pocet_objednanych_ks) AS Celkova_cena_polozek
    FROM Polozky_Objednavky 
      INNER JOIN Zbozi 
        ON Zbozi.Kod=Polozky_Objednavky.Kod
    WHERE Polozky_Objednavky.Cislo_objednavky=@Cislo_objenavky
    GROUP BY Polozky_Objednavky.Kod
  ) AS Celkova_cena;
Update Objednavka 
set Celkova_castka_k_zaplaceni=@Castka 
where Cislo_objednavky=@Cislo_objenavky; 
END
GO
USE [master]
GO
ALTER DATABASE [Kamenne_obklady] SET  READ_WRITE 
GO
