USE [db_serial_number]
GO
CREATE TABLE [dbo].[tb_config](
	[tb_institution_id] [char](36) NOT NULL,
	[tb_user_id] [char](36) NOT NULL,
	[field] [varchar](50) NOT NULL,
	[kind] [char](1) NULL,
	[content] [varchar](100) NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[tb_institution_id] ASC,
	[tb_user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_entity]    Script Date: 07/08/2023 19:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_entity](
	[id] [char](36) NOT NULL,
	[name_company] [varchar](100) NULL,
	[nick_trade] [varchar](100) NULL,
	[note] [binary](1) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_entity_has_mailing]    Script Date: 07/08/2023 19:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_entity_has_mailing](
	[tb_entity_id] [char](36) NOT NULL,
	[tb_mailing_id] [char](36) NOT NULL,
	[tb_mailing_group_id] [char](36) NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[tb_entity_id] ASC,
	[tb_mailing_id] ASC,
	[tb_mailing_group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_institution]    Script Date: 07/08/2023 19:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_institution](
	[id] [char](36) NOT NULL,
	[active] [char](1) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_institution_has_module]    Script Date: 07/08/2023 19:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_institution_has_module](
	[tb_institution_id] [char](36) NOT NULL,
	[tb_modules_id] [char](36) NOT NULL,
	[active] [char](1) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[tb_institution_id] ASC,
	[tb_modules_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_institution_has_user]    Script Date: 07/08/2023 19:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_institution_has_user](
	[tb_institution_id] [char](36) NOT NULL,
	[tb_user_id] [char](36) NOT NULL,
	[kind] [varchar](20) NULL,
	[active] [char](1) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[tb_institution_id] ASC,
	[tb_user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_interface]    Script Date: 07/08/2023 19:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_interface](
	[id] [char](36) NOT NULL,
	[description] [varchar](100) NULL,
	[kind] [varchar](26) NULL,
	[position] [varchar](10) NULL,
	[img_index] [int] NOT NULL,
	[acao_botao] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_interface_has_privilege]    Script Date: 07/08/2023 19:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_interface_has_privilege](
	[tb_interface_id] [char](36) NOT NULL,
	[tb_privilege_id] [char](36) NOT NULL,
	[active] [char](1) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[tb_interface_id] ASC,
	[tb_privilege_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_mailing]    Script Date: 07/08/2023 19:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_mailing](
	[id] [char](36) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_mailing_group]    Script Date: 07/08/2023 19:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_mailing_group](
	[id] [char](36) NOT NULL,
	[description] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_module]    Script Date: 07/08/2023 19:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_module](
	[id] [char](36) NOT NULL,
	[description] [varchar](100) NULL,
	[technical_name] [varchar](50) NOT NULL,
	[img_index] [int] NULL,
	[acao_botao] [varchar](255) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_module_has_interface]    Script Date: 07/08/2023 19:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_module_has_interface](
	[tb_module_id] [char](36) NOT NULL,
	[tb_interface_id] [char](36) NOT NULL,
	[active] [char](1) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[tb_module_id] ASC,
	[tb_interface_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_privilege]    Script Date: 07/08/2023 19:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_privilege](
	[id] [char](36) NOT NULL,
	[description] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_product]    Script Date: 07/08/2023 19:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_product](
	[id] [char](36) NOT NULL,
	[tb_institution_id] [char](36) NOT NULL,
	[reference] [varchar](100) NULL,
	[description] [varchar](100) NULL,
	[active] [char](1) NULL,
	[note] [binary](1) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[tb_institution_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_product_image]    Script Date: 07/08/2023 19:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_product_image](
	[tb_institution_id] [char](36) NOT NULL,
	[id] [char](36) NOT NULL,
	[tb_product_id] [char](36) NOT NULL,
	[content] [varbinary](max) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[tb_institution_id] ASC,
	[id] ASC,
	[tb_product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_product_serial_norma]    Script Date: 07/08/2023 19:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_product_serial_norma](
	[tb_institution_id] [char](36) NOT NULL,
	[tb_product_id] [char](36) NOT NULL,
	[norma_id] [varchar](50) NOT NULL,
	[part_number] [varchar](20) NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[tb_institution_id] ASC,
	[tb_product_id] ASC,
	[norma_id] ASC,
	[part_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_serial_number]    Script Date: 07/08/2023 19:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_serial_number](
	[id] [char](36) NOT NULL,
	[tb_institution_id] [char](36) NOT NULL,
	[tb_product_id] [char](36) NOT NULL,
	[sequence] [bigint] NOT NULL,
	[number] [varchar](100) NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[tb_institution_id] ASC,
	[id] ASC,
	[tb_product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_serial_number_has_historic]    Script Date: 07/08/2023 19:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_serial_number_has_historic](
	[id] [char](36) NOT NULL,
	[tb_serial_number_id] [char](36) NOT NULL,
	[tb_user_id] [char](36) NOT NULL,
	[status] [varchar](50) NOT NULL,
	[description] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[tb_serial_number_id] ASC,
	[tb_user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_user]    Script Date: 07/08/2023 19:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_user](
	[id] [char](36) NOT NULL,
	[password] [varchar](100) NULL,
	[kind] [varchar](20) NOT NULL,
	[salt] [varchar](255) NULL,
	[active] [char](1) NULL,
	[activation_key] [varchar](255) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_user_has_privilege]    Script Date: 07/08/2023 19:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_user_has_privilege](
	[tb_institution_id] [char](36) NOT NULL,
	[tb_user_id] [char](36) NOT NULL,
	[tb_interface_id] [char](36) NOT NULL,
	[tb_privilege_id] [char](36) NOT NULL,
	[active] [char](1) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[tb_institution_id] ASC,
	[tb_user_id] ASC,
	[tb_interface_id] ASC,
	[tb_privilege_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[tb_entity] ([id], [name_company], [nick_trade], [note], [created_at], [updated_at]) VALUES (N'41D0423D-39C5-49F4-BC59-84C2B74A5F1D', N'Valdo Souza', N'Valdo Souza', NULL, CAST(N'2023-08-07T17:02:44.423' AS DateTime), CAST(N'2023-08-07T17:02:44.423' AS DateTime))
GO
INSERT [dbo].[tb_entity_has_mailing] ([tb_entity_id], [tb_mailing_id], [tb_mailing_group_id], [created_at], [updated_at]) VALUES (N'41D0423D-39C5-49F4-BC59-84C2B74A5F1D', N'14921AE3-741F-4DC5-854B-574FEAA681D3', N'F03F8E47-6D7B-4DF7-8581-92CD36616FD4', CAST(N'2023-08-07T17:04:40.750' AS DateTime), CAST(N'2023-08-07T17:04:40.750' AS DateTime))
GO
INSERT [dbo].[tb_institution] ([id], [active], [created_at], [updated_at]) VALUES (N'EC9FDCD0-41B2-4D2E-8BD6-A90F968815A3', N'S', CAST(N'2023-08-07T16:47:40.427' AS DateTime), CAST(N'2023-08-07T16:47:40.427' AS DateTime))
GO
INSERT [dbo].[tb_institution_has_module] ([tb_institution_id], [tb_modules_id], [active], [created_at], [updated_at]) VALUES (N'EC9FDCD0-41B2-4D2E-8BD6-A90F968815A3', N'D2A79A07-09A5-4A05-A5C9-547C3B4502E0', N'S', CAST(N'2023-08-07T16:47:40.567' AS DateTime), CAST(N'2023-08-07T16:47:40.567' AS DateTime))
GO
INSERT [dbo].[tb_institution_has_user] ([tb_institution_id], [tb_user_id], [kind], [active], [created_at], [updated_at]) VALUES (N'EC9FDCD0-41B2-4D2E-8BD6-A90F968815A3', N'41D0423D-39C5-49F4-BC59-84C2B74A5F1D', N'Administrador', N'S', CAST(N'2023-08-07T17:12:29.307' AS DateTime), CAST(N'2023-08-07T17:12:29.307' AS DateTime))
GO
INSERT [dbo].[tb_interface] ([id], [description], [kind], [position], [img_index], [acao_botao], [created_at], [updated_at]) VALUES (N'5733051D-7D60-4F4E-A617-8E88975CD122', N'Cadastro Produto', NULL, NULL, 0, NULL, CAST(N'2023-08-07T16:47:40.457' AS DateTime), CAST(N'2023-08-07T16:47:40.457' AS DateTime))
INSERT [dbo].[tb_interface] ([id], [description], [kind], [position], [img_index], [acao_botao], [created_at], [updated_at]) VALUES (N'5D6F9021-E4AF-4848-B175-00F17AA8268A', N'Registro Serial', NULL, NULL, 0, NULL, CAST(N'2023-08-07T16:47:40.460' AS DateTime), CAST(N'2023-08-07T16:47:40.460' AS DateTime))
INSERT [dbo].[tb_interface] ([id], [description], [kind], [position], [img_index], [acao_botao], [created_at], [updated_at]) VALUES (N'B70138AC-C13C-4939-A1E6-5278BB08ACC4', N'Cadastro Usuário', NULL, NULL, 0, NULL, CAST(N'2023-08-07T16:47:40.453' AS DateTime), CAST(N'2023-08-07T16:47:40.453' AS DateTime))
GO
INSERT [dbo].[tb_interface_has_privilege] ([tb_interface_id], [tb_privilege_id], [active], [created_at], [updated_at]) VALUES (N'5733051D-7D60-4F4E-A617-8E88975CD122', N'4C75B3B5-8931-47B1-B4F0-D5846B71FEF4', N'S', CAST(N'2023-08-07T16:47:40.510' AS DateTime), CAST(N'2023-08-07T16:47:40.510' AS DateTime))
INSERT [dbo].[tb_interface_has_privilege] ([tb_interface_id], [tb_privilege_id], [active], [created_at], [updated_at]) VALUES (N'5733051D-7D60-4F4E-A617-8E88975CD122', N'A68D9EAE-D484-4C96-9A79-6AA44D99A342', N'S', CAST(N'2023-08-07T16:47:40.513' AS DateTime), CAST(N'2023-08-07T16:47:40.513' AS DateTime))
INSERT [dbo].[tb_interface_has_privilege] ([tb_interface_id], [tb_privilege_id], [active], [created_at], [updated_at]) VALUES (N'5733051D-7D60-4F4E-A617-8E88975CD122', N'C2CA8771-0B61-4F1B-B797-EBD329982B36', N'S', CAST(N'2023-08-07T16:47:40.517' AS DateTime), CAST(N'2023-08-07T16:47:40.517' AS DateTime))
INSERT [dbo].[tb_interface_has_privilege] ([tb_interface_id], [tb_privilege_id], [active], [created_at], [updated_at]) VALUES (N'5733051D-7D60-4F4E-A617-8E88975CD122', N'F45593EB-A6BC-44F7-890C-C60CC441E94B', N'S', CAST(N'2023-08-07T16:47:40.510' AS DateTime), CAST(N'2023-08-07T16:47:40.510' AS DateTime))
INSERT [dbo].[tb_interface_has_privilege] ([tb_interface_id], [tb_privilege_id], [active], [created_at], [updated_at]) VALUES (N'5D6F9021-E4AF-4848-B175-00F17AA8268A', N'30B677DF-1A5E-4D2D-9A8F-3E2CDCAC9D96', N'S', CAST(N'2023-08-07T16:47:40.523' AS DateTime), CAST(N'2023-08-07T16:47:40.523' AS DateTime))
INSERT [dbo].[tb_interface_has_privilege] ([tb_interface_id], [tb_privilege_id], [active], [created_at], [updated_at]) VALUES (N'5D6F9021-E4AF-4848-B175-00F17AA8268A', N'9997A596-F435-48B6-8D1B-A3F13E817F75', N'S', CAST(N'2023-08-07T16:47:40.520' AS DateTime), CAST(N'2023-08-07T16:47:40.520' AS DateTime))
INSERT [dbo].[tb_interface_has_privilege] ([tb_interface_id], [tb_privilege_id], [active], [created_at], [updated_at]) VALUES (N'5D6F9021-E4AF-4848-B175-00F17AA8268A', N'F45593EB-A6BC-44F7-890C-C60CC441E94B', N'S', CAST(N'2023-08-07T16:53:30.617' AS DateTime), CAST(N'2023-08-07T16:53:30.617' AS DateTime))
INSERT [dbo].[tb_interface_has_privilege] ([tb_interface_id], [tb_privilege_id], [active], [created_at], [updated_at]) VALUES (N'B70138AC-C13C-4939-A1E6-5278BB08ACC4', N'4C75B3B5-8931-47B1-B4F0-D5846B71FEF4', N'S', CAST(N'2023-08-07T16:47:40.490' AS DateTime), CAST(N'2023-08-07T16:47:40.490' AS DateTime))
INSERT [dbo].[tb_interface_has_privilege] ([tb_interface_id], [tb_privilege_id], [active], [created_at], [updated_at]) VALUES (N'B70138AC-C13C-4939-A1E6-5278BB08ACC4', N'A68D9EAE-D484-4C96-9A79-6AA44D99A342', N'S', CAST(N'2023-08-07T16:47:40.503' AS DateTime), CAST(N'2023-08-07T16:47:40.503' AS DateTime))
INSERT [dbo].[tb_interface_has_privilege] ([tb_interface_id], [tb_privilege_id], [active], [created_at], [updated_at]) VALUES (N'B70138AC-C13C-4939-A1E6-5278BB08ACC4', N'C2CA8771-0B61-4F1B-B797-EBD329982B36', N'S', CAST(N'2023-08-07T16:47:40.507' AS DateTime), CAST(N'2023-08-07T16:47:40.507' AS DateTime))
INSERT [dbo].[tb_interface_has_privilege] ([tb_interface_id], [tb_privilege_id], [active], [created_at], [updated_at]) VALUES (N'B70138AC-C13C-4939-A1E6-5278BB08ACC4', N'F45593EB-A6BC-44F7-890C-C60CC441E94B', N'S', CAST(N'2023-08-07T16:47:40.500' AS DateTime), CAST(N'2023-08-07T16:47:40.500' AS DateTime))
GO
INSERT [dbo].[tb_mailing] ([id], [email], [created_at], [updated_at]) VALUES (N'14921AE3-741F-4DC5-854B-574FEAA681D3', N'valdo@setes.com.br', CAST(N'2023-08-07T16:59:59.340' AS DateTime), CAST(N'2023-08-07T16:59:59.340' AS DateTime))
GO
INSERT [dbo].[tb_mailing_group] ([id], [description], [created_at], [updated_at]) VALUES (N'F03F8E47-6D7B-4DF7-8581-92CD36616FD4', N'Sistema', CAST(N'2023-08-07T16:47:40.533' AS DateTime), CAST(N'2023-08-07T16:47:40.533' AS DateTime))
GO
INSERT [dbo].[tb_module] ([id], [description], [technical_name], [img_index], [acao_botao], [created_at], [updated_at]) VALUES (N'D2A79A07-09A5-4A05-A5C9-547C3B4502E0', N'Operação', N'Operação', 0, N'NULL', CAST(N'2023-08-07T16:47:40.550' AS DateTime), CAST(N'2023-08-07T16:47:40.550' AS DateTime))
GO
INSERT [dbo].[tb_module_has_interface] ([tb_module_id], [tb_interface_id], [active], [created_at], [updated_at]) VALUES (N'D2A79A07-09A5-4A05-A5C9-547C3B4502E0', N'5733051D-7D60-4F4E-A617-8E88975CD122', N'S', CAST(N'2023-08-07T16:47:40.573' AS DateTime), CAST(N'2023-08-07T16:47:40.573' AS DateTime))
INSERT [dbo].[tb_module_has_interface] ([tb_module_id], [tb_interface_id], [active], [created_at], [updated_at]) VALUES (N'D2A79A07-09A5-4A05-A5C9-547C3B4502E0', N'5D6F9021-E4AF-4848-B175-00F17AA8268A', N'S', CAST(N'2023-08-07T16:47:40.577' AS DateTime), CAST(N'2023-08-07T16:47:40.577' AS DateTime))
INSERT [dbo].[tb_module_has_interface] ([tb_module_id], [tb_interface_id], [active], [created_at], [updated_at]) VALUES (N'D2A79A07-09A5-4A05-A5C9-547C3B4502E0', N'B70138AC-C13C-4939-A1E6-5278BB08ACC4', N'S', CAST(N'2023-08-07T16:47:40.573' AS DateTime), CAST(N'2023-08-07T16:47:40.573' AS DateTime))
GO
INSERT [dbo].[tb_privilege] ([id], [description], [created_at], [updated_at]) VALUES (N'30B677DF-1A5E-4D2D-9A8F-3E2CDCAC9D96', N'CONFERÊNCIA', CAST(N'2023-08-07T16:47:40.483' AS DateTime), CAST(N'2023-08-07T16:47:40.483' AS DateTime))
INSERT [dbo].[tb_privilege] ([id], [description], [created_at], [updated_at]) VALUES (N'4C75B3B5-8931-47B1-B4F0-D5846B71FEF4', N'INSERIR', CAST(N'2023-08-07T16:47:40.467' AS DateTime), CAST(N'2023-08-07T16:47:40.467' AS DateTime))
INSERT [dbo].[tb_privilege] ([id], [description], [created_at], [updated_at]) VALUES (N'9997A596-F435-48B6-8D1B-A3F13E817F75', N'GRAVAÇÃO', CAST(N'2023-08-07T16:47:40.480' AS DateTime), CAST(N'2023-08-07T16:47:40.480' AS DateTime))
INSERT [dbo].[tb_privilege] ([id], [description], [created_at], [updated_at]) VALUES (N'A68D9EAE-D484-4C96-9A79-6AA44D99A342', N'EXCLUIR', CAST(N'2023-08-07T16:47:40.470' AS DateTime), CAST(N'2023-08-07T16:47:40.470' AS DateTime))
INSERT [dbo].[tb_privilege] ([id], [description], [created_at], [updated_at]) VALUES (N'C2CA8771-0B61-4F1B-B797-EBD329982B36', N'ALTERAR', CAST(N'2023-08-07T16:47:40.470' AS DateTime), CAST(N'2023-08-07T16:47:40.470' AS DateTime))
INSERT [dbo].[tb_privilege] ([id], [description], [created_at], [updated_at]) VALUES (N'F45593EB-A6BC-44F7-890C-C60CC441E94B', N'VISUALIZAR', CAST(N'2023-08-07T16:47:40.473' AS DateTime), CAST(N'2023-08-07T16:47:40.473' AS DateTime))
GO
INSERT [dbo].[tb_user] ([id], [password], [kind], [salt], [active], [activation_key], [created_at], [updated_at]) VALUES (N'41D0423D-39C5-49F4-BC59-84C2B74A5F1D', N'827ccb0eea8a706c4c34a16891f84e7b', N'Sistema', NULL, N'S', NULL, CAST(N'2023-08-07T17:09:38.187' AS DateTime), CAST(N'2023-08-07T17:09:38.187' AS DateTime))
GO
INSERT [dbo].[tb_user_has_privilege] ([tb_institution_id], [tb_user_id], [tb_interface_id], [tb_privilege_id], [active], [created_at], [updated_at]) VALUES (N'EC9FDCD0-41B2-4D2E-8BD6-A90F968815A3', N'41D0423D-39C5-49F4-BC59-84C2B74A5F1D', N'5D6F9021-E4AF-4848-B175-00F17AA8268A', N'30B677DF-1A5E-4D2D-9A8F-3E2CDCAC9D96', N'S', CAST(N'2023-08-07T18:18:34.847' AS DateTime), CAST(N'2023-08-07T18:18:34.847' AS DateTime))
INSERT [dbo].[tb_user_has_privilege] ([tb_institution_id], [tb_user_id], [tb_interface_id], [tb_privilege_id], [active], [created_at], [updated_at]) VALUES (N'EC9FDCD0-41B2-4D2E-8BD6-A90F968815A3', N'41D0423D-39C5-49F4-BC59-84C2B74A5F1D', N'5D6F9021-E4AF-4848-B175-00F17AA8268A', N'9997A596-F435-48B6-8D1B-A3F13E817F75', N'S', CAST(N'2023-08-07T18:18:34.850' AS DateTime), CAST(N'2023-08-07T18:18:34.850' AS DateTime))
INSERT [dbo].[tb_user_has_privilege] ([tb_institution_id], [tb_user_id], [tb_interface_id], [tb_privilege_id], [active], [created_at], [updated_at]) VALUES (N'EC9FDCD0-41B2-4D2E-8BD6-A90F968815A3', N'41D0423D-39C5-49F4-BC59-84C2B74A5F1D', N'5D6F9021-E4AF-4848-B175-00F17AA8268A', N'F45593EB-A6BC-44F7-890C-C60CC441E94B', N'S', CAST(N'2023-08-07T18:18:34.853' AS DateTime), CAST(N'2023-08-07T18:18:34.853' AS DateTime))
GO
ALTER TABLE [dbo].[tb_config] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tb_config] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[tb_entity] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tb_entity] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[tb_entity_has_mailing] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tb_entity_has_mailing] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[tb_institution] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tb_institution] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[tb_institution_has_module] ADD  DEFAULT (NULL) FOR [active]
GO
ALTER TABLE [dbo].[tb_institution_has_module] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tb_institution_has_module] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[tb_institution_has_user] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tb_institution_has_user] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[tb_interface] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tb_interface] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[tb_interface_has_privilege] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tb_interface_has_privilege] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[tb_mailing] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tb_mailing] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[tb_mailing_group] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tb_mailing_group] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[tb_module] ADD  DEFAULT (NULL) FOR [description]
GO
ALTER TABLE [dbo].[tb_module] ADD  DEFAULT ((0)) FOR [img_index]
GO
ALTER TABLE [dbo].[tb_module] ADD  DEFAULT ('NULL') FOR [acao_botao]
GO
ALTER TABLE [dbo].[tb_module] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tb_module] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[tb_module_has_interface] ADD  DEFAULT (NULL) FOR [active]
GO
ALTER TABLE [dbo].[tb_module_has_interface] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tb_module_has_interface] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[tb_privilege] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tb_privilege] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[tb_product] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tb_product] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[tb_product_image] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tb_product_image] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[tb_product_serial_norma] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tb_product_serial_norma] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[tb_serial_number] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tb_serial_number] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[tb_serial_number_has_historic] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tb_serial_number_has_historic] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[tb_user] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tb_user] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[tb_user_has_privilege] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tb_user_has_privilege] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
USE [master]
GO
ALTER DATABASE [db_serial_number] SET  READ_WRITE 
GO
