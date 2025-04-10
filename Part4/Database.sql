USE [master]
GO
/****** Object:  Database [superMarketDB]    Script Date: 07/04/2025 22:09:46 ******/
CREATE DATABASE [superMarketDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'superMarketDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\superMarketDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'superMarketDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\superMarketDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [superMarketDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [superMarketDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [superMarketDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [superMarketDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [superMarketDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [superMarketDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [superMarketDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [superMarketDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [superMarketDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [superMarketDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [superMarketDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [superMarketDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [superMarketDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [superMarketDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [superMarketDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [superMarketDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [superMarketDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [superMarketDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [superMarketDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [superMarketDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [superMarketDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [superMarketDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [superMarketDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [superMarketDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [superMarketDB] SET RECOVERY FULL 
GO
ALTER DATABASE [superMarketDB] SET  MULTI_USER 
GO
ALTER DATABASE [superMarketDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [superMarketDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [superMarketDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [superMarketDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [superMarketDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [superMarketDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'superMarketDB', N'ON'
GO
ALTER DATABASE [superMarketDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [superMarketDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [superMarketDB]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 07/04/2025 22:09:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orderItems]    Script Date: 07/04/2025 22:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orderItems](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[productId] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[Orderid] [int] NULL,
 CONSTRAINT [PK_orderItems] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 07/04/2025 22:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[date] [datetime2](7) NOT NULL,
	[status] [nvarchar](max) NOT NULL,
	[supplierId] [int] NOT NULL,
	[OwnerId] [int] NOT NULL,
 CONSTRAINT [PK_orders] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Owners]    Script Date: 07/04/2025 22:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Owners](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NOT NULL,
	[password] [nvarchar](max) NOT NULL,
	[phone] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Owners] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 07/04/2025 22:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NOT NULL,
	[price] [int] NOT NULL,
	[minimumQuantity] [int] NOT NULL,
	[supplierId] [int] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 07/04/2025 22:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[companyName] [nvarchar](max) NOT NULL,
	[phone] [nvarchar](max) NOT NULL,
	[RepresentativeName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250404123303_InitialCreate', N'9.0.3')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250405214236_A', N'9.0.3')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250405215010_B', N'9.0.3')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250405215441_C', N'9.0.3')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250405221825_D', N'9.0.3')
GO
SET IDENTITY_INSERT [dbo].[orderItems] ON 

INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (1, 4, 20, 1)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (2, 4, 20, 2)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (3, 4, 20, 3)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (4, 6, 7, 4)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (5, 8, 10, 5)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (6, 9, 200, 5)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (7, 8, 50, 6)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (8, 9, 68, 6)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (9, 4, 25, 7)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (10, 5, 25, 7)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (11, 2, 1500, 8)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (12, 3, 9999, 9)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (13, 7, 99999, 10)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (14, 9, 99999999, 11)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (15, 7, 999999, 12)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (16, 4, 30, 13)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (17, 5, 15, 13)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (18, 8, 2, 14)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (19, 9, 3, 14)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (20, 3, 1050, 15)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (21, 4, 25, 16)
INSERT [dbo].[orderItems] ([id], [productId], [quantity], [Orderid]) VALUES (22, 5, 25, 16)
SET IDENTITY_INSERT [dbo].[orderItems] OFF
GO
SET IDENTITY_INSERT [dbo].[orders] ON 

INSERT [dbo].[orders] ([id], [date], [status], [supplierId], [OwnerId]) VALUES (1, CAST(N'2025-04-06T17:38:31.9691046' AS DateTime2), N'הושלמה', 3, 1)
INSERT [dbo].[orders] ([id], [date], [status], [supplierId], [OwnerId]) VALUES (2, CAST(N'2025-04-06T17:39:51.6558304' AS DateTime2), N'הושלמה', 3, 1)
INSERT [dbo].[orders] ([id], [date], [status], [supplierId], [OwnerId]) VALUES (3, CAST(N'2025-04-06T17:44:38.9599645' AS DateTime2), N'הושלמה', 3, 1)
INSERT [dbo].[orders] ([id], [date], [status], [supplierId], [OwnerId]) VALUES (4, CAST(N'2025-04-06T18:13:27.8494363' AS DateTime2), N'ממתינה לאישור', 4, 1)
INSERT [dbo].[orders] ([id], [date], [status], [supplierId], [OwnerId]) VALUES (5, CAST(N'2025-04-06T20:38:04.0018741' AS DateTime2), N'הושלמה', 10, 1)
INSERT [dbo].[orders] ([id], [date], [status], [supplierId], [OwnerId]) VALUES (6, CAST(N'2025-04-06T20:39:33.2465109' AS DateTime2), N'הושלמה', 10, 1)
INSERT [dbo].[orders] ([id], [date], [status], [supplierId], [OwnerId]) VALUES (7, CAST(N'2025-04-06T20:42:54.8108132' AS DateTime2), N'הושלמה', 3, 1)
INSERT [dbo].[orders] ([id], [date], [status], [supplierId], [OwnerId]) VALUES (8, CAST(N'2025-04-06T20:43:20.1857325' AS DateTime2), N'ממתינה לאישור', 1, 1)
INSERT [dbo].[orders] ([id], [date], [status], [supplierId], [OwnerId]) VALUES (9, CAST(N'2025-04-06T20:44:40.0205699' AS DateTime2), N'ממתינה לאישור', 2, 1)
INSERT [dbo].[orders] ([id], [date], [status], [supplierId], [OwnerId]) VALUES (10, CAST(N'2025-04-06T20:45:24.7572908' AS DateTime2), N'ממתינה לאישור', 9, 1)
INSERT [dbo].[orders] ([id], [date], [status], [supplierId], [OwnerId]) VALUES (11, CAST(N'2025-04-06T20:46:20.9688846' AS DateTime2), N'הושלמה', 10, 1)
INSERT [dbo].[orders] ([id], [date], [status], [supplierId], [OwnerId]) VALUES (12, CAST(N'2025-04-06T20:48:46.3925409' AS DateTime2), N'ממתינה לאישור', 9, 1)
INSERT [dbo].[orders] ([id], [date], [status], [supplierId], [OwnerId]) VALUES (13, CAST(N'2025-04-06T21:18:49.2751645' AS DateTime2), N'הושלמה', 3, 1)
INSERT [dbo].[orders] ([id], [date], [status], [supplierId], [OwnerId]) VALUES (14, CAST(N'2025-04-07T16:50:04.7381755' AS DateTime2), N'ממתינה לאישור', 10, 1)
INSERT [dbo].[orders] ([id], [date], [status], [supplierId], [OwnerId]) VALUES (15, CAST(N'2025-04-07T17:18:20.4651279' AS DateTime2), N'ממתינה לאישור', 2, 1)
INSERT [dbo].[orders] ([id], [date], [status], [supplierId], [OwnerId]) VALUES (16, CAST(N'2025-04-07T17:25:12.3228034' AS DateTime2), N'הושלמה', 3, 1)
SET IDENTITY_INSERT [dbo].[orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([id], [name], [price], [minimumQuantity], [supplierId]) VALUES (2, N'C', 20, 50, 1)
INSERT [dbo].[Products] ([id], [name], [price], [minimumQuantity], [supplierId]) VALUES (3, N'C', 20, 50, 2)
INSERT [dbo].[Products] ([id], [name], [price], [minimumQuantity], [supplierId]) VALUES (4, N'"טשו"', 10, 20, 3)
INSERT [dbo].[Products] ([id], [name], [price], [minimumQuantity], [supplierId]) VALUES (5, N'"נייר"', 5, 10, 3)
INSERT [dbo].[Products] ([id], [name], [price], [minimumQuantity], [supplierId]) VALUES (6, N'"בשר"', 80, 7, 4)
INSERT [dbo].[Products] ([id], [name], [price], [minimumQuantity], [supplierId]) VALUES (7, N'"עוף"', 30, 12, 9)
INSERT [dbo].[Products] ([id], [name], [price], [minimumQuantity], [supplierId]) VALUES (8, N'שעון יד', 150, 1, 10)
INSERT [dbo].[Products] ([id], [name], [price], [minimumQuantity], [supplierId]) VALUES (9, N'שעון כיס', 200, 1, 10)
INSERT [dbo].[Products] ([id], [name], [price], [minimumQuantity], [supplierId]) VALUES (10, N'מודעין חשוב מאוד', 20000, 3, 11)
INSERT [dbo].[Products] ([id], [name], [price], [minimumQuantity], [supplierId]) VALUES (11, N'אקונומיקה', 12, 30, 12)
INSERT [dbo].[Products] ([id], [name], [price], [minimumQuantity], [supplierId]) VALUES (12, N'כפפות', 6, 80, 12)
INSERT [dbo].[Products] ([id], [name], [price], [minimumQuantity], [supplierId]) VALUES (13, N'סבון כלים', 15, 45, 12)
INSERT [dbo].[Products] ([id], [name], [price], [minimumQuantity], [supplierId]) VALUES (14, N'במבה', 5, 50, 13)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Suppliers] ON 

INSERT [dbo].[Suppliers] ([id], [companyName], [phone], [RepresentativeName]) VALUES (1, N'A', N'0055', N'B')
INSERT [dbo].[Suppliers] ([id], [companyName], [phone], [RepresentativeName]) VALUES (2, N'A', N'05', N'B')
INSERT [dbo].[Suppliers] ([id], [companyName], [phone], [RepresentativeName]) VALUES (3, N'"A"', N'0555', N'"Ruchama"')
INSERT [dbo].[Suppliers] ([id], [companyName], [phone], [RepresentativeName]) VALUES (4, N'"B"', N'044', N'"MEIR"')
INSERT [dbo].[Suppliers] ([id], [companyName], [phone], [RepresentativeName]) VALUES (5, N'"J"', N'222', N'"l"')
INSERT [dbo].[Suppliers] ([id], [companyName], [phone], [RepresentativeName]) VALUES (6, N'"H"', N'5', N'"Y"')
INSERT [dbo].[Suppliers] ([id], [companyName], [phone], [RepresentativeName]) VALUES (7, N'"L"', N'8', N'"ם"')
INSERT [dbo].[Suppliers] ([id], [companyName], [phone], [RepresentativeName]) VALUES (8, N'"P"', N'7', N'"M"')
INSERT [dbo].[Suppliers] ([id], [companyName], [phone], [RepresentativeName]) VALUES (9, N'"C"', N'02', N'"CHANA"')
INSERT [dbo].[Suppliers] ([id], [companyName], [phone], [RepresentativeName]) VALUES (10, N'"ברוך"', N'0123456789', N'"שמיעלקא"')
INSERT [dbo].[Suppliers] ([id], [companyName], [phone], [RepresentativeName]) VALUES (11, N'"Hacker"', N'0000', N'"bob"')
INSERT [dbo].[Suppliers] ([id], [companyName], [phone], [RepresentativeName]) VALUES (12, N'"סנו"', N'9999', N'"אור"')
INSERT [dbo].[Suppliers] ([id], [companyName], [phone], [RepresentativeName]) VALUES (13, N'"אסם"', N'87', N'"במבה"')
SET IDENTITY_INSERT [dbo].[Suppliers] OFF
GO
/****** Object:  Index [IX_orderItems_Orderid]    Script Date: 07/04/2025 22:09:48 ******/
CREATE NONCLUSTERED INDEX [IX_orderItems_Orderid] ON [dbo].[orderItems]
(
	[Orderid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_orderItems_productId]    Script Date: 07/04/2025 22:09:48 ******/
CREATE NONCLUSTERED INDEX [IX_orderItems_productId] ON [dbo].[orderItems]
(
	[productId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_supplierId]    Script Date: 07/04/2025 22:09:48 ******/
CREATE NONCLUSTERED INDEX [IX_Products_supplierId] ON [dbo].[Products]
(
	[supplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT ((0)) FOR [supplierId]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT ((0)) FOR [OwnerId]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [supplierId]
GO
ALTER TABLE [dbo].[orderItems]  WITH CHECK ADD  CONSTRAINT [FK_orderItems_orders_Orderid] FOREIGN KEY([Orderid])
REFERENCES [dbo].[orders] ([id])
GO
ALTER TABLE [dbo].[orderItems] CHECK CONSTRAINT [FK_orderItems_orders_Orderid]
GO
ALTER TABLE [dbo].[orderItems]  WITH CHECK ADD  CONSTRAINT [FK_orderItems_Products_productId] FOREIGN KEY([productId])
REFERENCES [dbo].[Products] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[orderItems] CHECK CONSTRAINT [FK_orderItems_Products_productId]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Suppliers_supplierId] FOREIGN KEY([supplierId])
REFERENCES [dbo].[Suppliers] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Suppliers_supplierId]
GO
USE [master]
GO
ALTER DATABASE [superMarketDB] SET  READ_WRITE 
GO
