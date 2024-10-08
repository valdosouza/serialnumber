USE [db_serial_number]
GO
/****** Object:  Table [dbo].[tb_config]    Script Date: 20/07/2024 12:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_entity]    Script Date: 20/07/2024 12:14:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_entity_has_mailing]    Script Date: 20/07/2024 12:14:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_institution]    Script Date: 20/07/2024 12:14:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_institution_has_module]    Script Date: 20/07/2024 12:14:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_institution_has_user]    Script Date: 20/07/2024 12:14:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_interface]    Script Date: 20/07/2024 12:14:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_interface_has_privilege]    Script Date: 20/07/2024 12:14:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_mailing]    Script Date: 20/07/2024 12:14:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_mailing_group]    Script Date: 20/07/2024 12:14:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_module]    Script Date: 20/07/2024 12:14:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_module_has_interface]    Script Date: 20/07/2024 12:14:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_privilege]    Script Date: 20/07/2024 12:14:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_product]    Script Date: 20/07/2024 12:14:32 ******/
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
	[mask_t1] [varchar](100) NULL,
	[mask_t2] [varchar](100) NULL,
	[mask_rd] [varchar](100) NULL,
	[mask_default] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[tb_institution_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_product_image]    Script Date: 20/07/2024 12:14:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_product_serial_norma]    Script Date: 20/07/2024 12:14:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_serial_number]    Script Date: 20/07/2024 12:14:32 ******/
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
	[standard_used] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[tb_institution_id] ASC,
	[id] ASC,
	[tb_product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_serial_number_has_historic]    Script Date: 20/07/2024 12:14:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_user]    Script Date: 20/07/2024 12:14:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_user_has_privilege]    Script Date: 20/07/2024 12:14:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
