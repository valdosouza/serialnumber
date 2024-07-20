CREATE DATABASE db_serial_number;
GO
USE [db_serial_number]
GO

CREATE TABLE [tb_config](
	[tb_institution_id] char(36) NOT NULL,
	[tb_user_id] char(36) NOT NULL,
	[field] [varchar](50) NOT NULL,
	[kind] [char](1) NULL,
	[content] [varchar](100) NOT NULL,
	[created_at] datetime default CURRENT_TIMESTAMP,
	[updated_at] datetime default CURRENT_TIMESTAMP,
      PRIMARY KEY(tb_institution_id, tb_user_id)
) 
GO

CREATE TABLE [tb_entity](
	[id] char(36) NOT NULL,
	[name_company] [varchar](100) NULL,
	[nick_trade] [varchar](100) NULL,
	[note] [binary](1) NULL,
      [created_at] datetime default CURRENT_TIMESTAMP,
	[updated_at] datetime default CURRENT_TIMESTAMP,	
      PRIMARY KEY(id)	
) 
GO

INSERT INTO [dbo].[tb_entity]
           ([id]
           ,[name_company]
           ,[nick_trade])
     VALUES
           ('41D0423D-39C5-49F4-BC59-84C2B74A5F1D'
           ,'Valdo Souza'
           ,'Valdo Souza')


CREATE TABLE [tb_entity_has_mailing](
	[tb_entity_id] char(36) NOT NULL,
	[tb_mailing_id] char(36) NOT NULL,
	[tb_mailing_group_id] char(36) NOT NULL,
	[created_at] datetime default CURRENT_TIMESTAMP,
	[updated_at] datetime default CURRENT_TIMESTAMP,
      PRIMARY KEY(tb_entity_id,tb_mailing_id,tb_mailing_group_id) 
)
GO

CREATE TABLE tb_product_image (
    [tb_institution_id] char(36) NOT NULL,
    [id] char(36) NOT NULL,    
    [tb_product_id] char(36) NOT NULL,
    content  varbinary(MAX),
    [created_at] datetime default CURRENT_TIMESTAMP,
    [updated_at] datetime default CURRENT_TIMESTAMP,
   PRIMARY KEY(tb_institution_id,id,tb_product_id) 
)
GO

CREATE TABLE [tb_institution](
	[id] char(36) NOT NULL,
	[active] [char](1) NULL,
	[created_at] datetime default CURRENT_TIMESTAMP,
	[updated_at] datetime default CURRENT_TIMESTAMP,
      PRIMARY KEY(id) 
)
GO

INSERT INTO [dbo].[tb_institution]
           ([id]
           ,[active])
     VALUES
           ('EC9FDCD0-41B2-4D2E-8BD6-A90F968815A3'
           ,'S')
GO

CREATE TABLE [tb_institution_has_user](
	[tb_institution_id] char(36) NOT NULL,
	[tb_user_id] char(36) NOT NULL,
	[kind] [varchar](20) NULL,
	[active] [char](1) NULL,
	[created_at] datetime default CURRENT_TIMESTAMP,
	[updated_at] datetime default CURRENT_TIMESTAMP,
      PRIMARY KEY(tb_institution_id,tb_user_id) 
)
GO
INSERT INTO [dbo].[tb_institution_has_user]
           ([tb_institution_id]
           ,[tb_user_id]
           ,[kind]
           ,[active])
     VALUES
           ('EC9FDCD0-41B2-4D2E-8BD6-A90F968815A3'
            '41D0423D-39C5-49F4-BC59-84C2B74A5F1D'
           ,'Sistema'
           ,'S')
GO

CREATE TABLE [tb_interface](
	[id] char(36) NOT NULL,
	[description] [varchar](100) NULL,
	[kind] [varchar](26) NULL,
	[position] [varchar](10) NULL,
	[img_index] [int] NOT NULL,
	[acao_botao] [varchar](100) NULL,
	[created_at] datetime default CURRENT_TIMESTAMP,
	[updated_at] datetime default CURRENT_TIMESTAMP,
      PRIMARY KEY(id) 
)
GO

INSERT INTO [dbo].[tb_interface]
           ([id]
           ,[description]           
           ,[img_index])
     VALUES
           ('B70138AC-C13C-4939-A1E6-5278BB08ACC4'
           ,'Cadastro Usuário'
		   ,0)
GO
INSERT INTO [dbo].[tb_interface]
           ([id]
           ,[description]           
           ,[img_index])
     VALUES
           ('5733051D-7D60-4F4E-A617-8E88975CD122'
           ,'Cadastro Produto'
		   ,0)
GO

INSERT INTO [dbo].[tb_interface]
           ([id]
           ,[description]           
           ,[img_index])
     VALUES
           ('5D6F9021-E4AF-4848-B175-00F17AA8268A'
           ,'Registro Serial'
	     ,0)
GO


CREATE TABLE [tb_privilege](
	[id] char(36) NOT NULL,
	[description] [varchar](100) NULL,
	[created_at] datetime default CURRENT_TIMESTAMP,
	[updated_at] datetime default CURRENT_TIMESTAMP,
      PRIMARY KEY(id) 
)
GO
INSERT INTO [dbo].[tb_privilege]
           ([id]
           ,[description])
     VALUES
           (newId()
           ,'INSERIR')
GO
INSERT INTO [dbo].[tb_privilege]
           ([id]
           ,[description])
     VALUES
           (newId()
           ,'ALTERAR')
GO
INSERT INTO [dbo].[tb_privilege]
           ([id]
           ,[description])
     VALUES
           (newId()
           ,'EXCLUIR')
GO
INSERT INTO [dbo].[tb_privilege]
           ([id]
           ,[description])
     VALUES
           (newId()
           ,'VISUALIZAR')
GO

INSERT INTO [dbo].[tb_privilege]
           ([id]
           ,[description])
     VALUES
           ('9997A596-F435-48B6-8D1B-A3F13E817F75'
           ,'GRAVAÇÃO')
GO

INSERT INTO [dbo].[tb_privilege]
           ([id]
           ,[description])
     VALUES
           ('30B677DF-1A5E-4D2D-9A8F-3E2CDCAC9D96'
           ,'CONFERÊNCIA')
GO

CREATE TABLE [tb_interface_has_privilege](
	[tb_interface_id] char(36) NOT NULL,
	[tb_privilege_id] char(36) NOT NULL,	
	[active] [char](1) NULL,
	[created_at] datetime default CURRENT_TIMESTAMP,
	[updated_at] datetime default CURRENT_TIMESTAMP,
      PRIMARY KEY(tb_interface_id,tb_privilege_id) 
)
GO

INSERT INTO [dbo].[tb_interface_has_privilege]
           ([tb_interface_id]
           ,[tb_privilege_id]
           ,[active])
     VALUES
           ('B70138AC-C13C-4939-A1E6-5278BB08ACC4'
           ,'6AE6BC3D-9EA2-4B5C-8011-C685A59BA48F'
           ,'S')
GO
INSERT INTO [dbo].[tb_interface_has_privilege]
           ([tb_interface_id]
           ,[tb_privilege_id]
           ,[active])
     VALUES
           ('B70138AC-C13C-4939-A1E6-5278BB08ACC4'
           ,'CB092853-1663-4213-B2E2-C5ED266F3BDC'
           ,'S')
GO
INSERT INTO [dbo].[tb_interface_has_privilege]
           ([tb_interface_id]
           ,[tb_privilege_id]
           ,[active])
     VALUES
           ('B70138AC-C13C-4939-A1E6-5278BB08ACC4'
           ,'B8DC1753-B030-4DA0-8060-D31A56AF4922'
           ,'S')
GO
INSERT INTO [dbo].[tb_interface_has_privilege]
           ([tb_interface_id]
           ,[tb_privilege_id]
           ,[active])
     VALUES
           ('B70138AC-C13C-4939-A1E6-5278BB08ACC4'
           ,'894394D1-0E6B-4D98-971E-63CD83FFE6C2'
           ,'S')
GO

INSERT INTO [dbo].[tb_interface_has_privilege]
           ([tb_interface_id]
           ,[tb_privilege_id]
           ,[active])
     VALUES
           ('5733051D-7D60-4F4E-A617-8E88975CD122'
           ,'6AE6BC3D-9EA2-4B5C-8011-C685A59BA48F'
           ,'S')
GO
INSERT INTO [dbo].[tb_interface_has_privilege]
           ([tb_interface_id]
           ,[tb_privilege_id]
           ,[active])
     VALUES
           ('5733051D-7D60-4F4E-A617-8E88975CD122'
           ,'CB092853-1663-4213-B2E2-C5ED266F3BDC'
           ,'S')
GO
INSERT INTO [dbo].[tb_interface_has_privilege]
           ([tb_interface_id]
           ,[tb_privilege_id]
           ,[active])
     VALUES
           ('5733051D-7D60-4F4E-A617-8E88975CD122'
           ,'B8DC1753-B030-4DA0-8060-D31A56AF4922'
           ,'S')
GO
INSERT INTO [dbo].[tb_interface_has_privilege]
           ([tb_interface_id]
           ,[tb_privilege_id]
           ,[active])
     VALUES
           ('5733051D-7D60-4F4E-A617-8E88975CD122'
           ,'894394D1-0E6B-4D98-971E-63CD83FFE6C2'
           ,'S')
GO

INSERT INTO [dbo].[tb_interface_has_privilege]
           ([tb_interface_id]
           ,[tb_privilege_id]
           ,[active])
     VALUES 
           ('5D6F9021-E4AF-4848-B175-00F17AA8268A'
           ,'894394D1-0E6B-4D98-971E-63CD83FFE6C2'
           ,'S')
GO


INSERT INTO [dbo].[tb_interface_has_privilege]
           ([tb_interface_id]
           ,[tb_privilege_id]
           ,[active])
     VALUES
           ('5D6F9021-E4AF-4848-B175-00F17AA8268A'
           ,'9997A596-F435-48B6-8D1B-A3F13E817F75'
           ,'S')
GO


INSERT INTO [dbo].[tb_interface_has_privilege]
           ([tb_interface_id]
           ,[tb_privilege_id]
           ,[active])
     VALUES
           ('5D6F9021-E4AF-4848-B175-00F17AA8268A'
           ,'30B677DF-1A5E-4D2D-9A8F-3E2CDCAC9D96'
           ,'S')
GO

CREATE TABLE [tb_mailing](
	[id] char(36) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[created_at] datetime default CURRENT_TIMESTAMP,
	[updated_at] datetime default CURRENT_TIMESTAMP,
      PRIMARY KEY(id) 
)
GO

INSERT INTO [dbo].[tb_mailing]
           ([id]
           ,[email])
           
     VALUES
           ('14921AE3-741F-4DC5-854B-574FEAA681D3'
           ,'valdo@setes.com.br')

CREATE TABLE [tb_mailing_group](
	[id] char(36) NOT NULL,
	[description] [varchar](100) NULL,
	[created_at] datetime default CURRENT_TIMESTAMP,
	[updated_at] datetime default CURRENT_TIMESTAMP,
      PRIMARY KEY(id) 
)
GO
INSERT INTO [dbo].[tb_mailing_group]
           ([id]
           ,[description])
     VALUES
           ('F03F8E47-6D7B-4DF7-8581-92CD36616FD4'
           ,'Sistema')
GO

INSERT INTO [dbo].[tb_entity_has_mailing]
           ([tb_entity_id]
           ,[tb_mailing_id]
           ,[tb_mailing_group_id])
     VALUES
           ('41D0423D-39C5-49F4-BC59-84C2B74A5F1D'
           ,'14921AE3-741F-4DC5-854B-574FEAA681D3'
           ,'F03F8E47-6D7B-4DF7-8581-92CD36616FD4')
GO

CREATE TABLE [tb_product](
	[id] char(36) NOT NULL,
	[tb_institution_id] char(36) NOT NULL,
	[description] [varchar](100) NULL,
	[active] [char](1) NULL,
	[note] [binary](1) NULL,
	[created_at] datetime default CURRENT_TIMESTAMP,
	[updated_at] datetime default CURRENT_TIMESTAMP,
      PRIMARY KEY(tb_institution_id,id) 
)
GO

CREATE TABLE [tb_serial_number](
	[id] char(36) NOT NULL,
	[tb_institution_id] char(36) NOT NULL,
	[tb_product_id] char(36) NOT NULL,
	[sequence] bigint not null,
	[number] [varchar](100) NOT NULL,
	[created_at] datetime default CURRENT_TIMESTAMP,
	[updated_at] datetime default CURRENT_TIMESTAMP,
      PRIMARY KEY(tb_institution_id,id,tb_product_id)       
)
GO

CREATE TABLE [tb_serial_number_has_historic](
	[id] char(36) NOT NULL,	
	[tb_serial_number_id] char(36) NOT NULL,
	[tb_user_id] char(36) NOT NULL,
	[status] varchar(50) NOT NULL,
	[description] [varchar](100) NULL,
	[created_at] datetime default CURRENT_TIMESTAMP,
	[updated_at] datetime default CURRENT_TIMESTAMP,
      PRIMARY KEY(id,tb_serial_number_id, tb_user_id)       
)
GO

CREATE TABLE [tb_user](
	[id] char(36) NOT NULL,
	[password] [varchar](100) NULL,
	[kind] [varchar](20) NOT NULL,
	[salt] [varchar](255) NULL,
	[active] [char](1) NULL,
	[activation_key] [varchar](255) NULL,
	[created_at] datetime default CURRENT_TIMESTAMP,
	[updated_at] datetime default CURRENT_TIMESTAMP,
      PRIMARY KEY(id) 
)
GO
INSERT INTO [dbo].[tb_user]
           ([id]
           ,[password]
           ,[kind]
           ,[active])
     VALUES
           ('41D0423D-39C5-49F4-BC59-84C2B74A5F1D'
           ,'827ccb0eea8a706c4c34a16891f84e7b'
           ,'Sistema'           
           ,'S')
GO

CREATE TABLE [tb_user_has_privilege](
	[tb_institution_id] char(36) NOT NULL,
	[tb_user_id] char(36) NOT NULL,
	[tb_interface_id] char(36) NOT NULL,
	[tb_privilege_id] char(36) NOT NULL,
	[active] [char](1) NULL,
	[created_at] datetime default CURRENT_TIMESTAMP,
	[updated_at] datetime default CURRENT_TIMESTAMP,
      PRIMARY KEY(tb_institution_id,tb_user_id,tb_interface_id,tb_privilege_id) 
)
GO
CREATE TABLE tb_module (
  id char(36) NOT NULL,
  description varchar(100) DEFAULT NULL,
  technical_name varchar(50) NOT NULL,
  img_index int DEFAULT 0,
  acao_botao varchar(255) DEFAULT 'NULL',
  [created_at] datetime default CURRENT_TIMESTAMP,
  [updated_at] datetime default CURRENT_TIMESTAMP,
  PRIMARY KEY(id) 
) 
GO
CREATE TABLE tb_institution_has_module (
  tb_institution_id char(36) NOT NULL,
  tb_modules_id char(36) NOT NULL,
  active char(1) DEFAULT NULL,
  [created_at] datetime default CURRENT_TIMESTAMP,
  [updated_at] datetime default CURRENT_TIMESTAMP,
  PRIMARY KEY(tb_institution_id,tb_modules_id) 
)
GO
INSERT INTO [dbo].[tb_module]
           ([id]
           ,[description]
           ,[technical_name])
     VALUES
           ('D2A79A07-09A5-4A05-A5C9-547C3B4502E0'
           ,'Operação'
           ,'Operação')
GO
INSERT INTO [dbo].[tb_institution_has_module]
           ([tb_institution_id]
           ,[tb_modules_id]
           ,[active])
     VALUES
           ('EC9FDCD0-41B2-4D2E-8BD6-A90F968815A3'
           ,'D2A79A07-09A5-4A05-A5C9-547C3B4502E0'
           ,'S')
GO

CREATE TABLE tb_module_has_interface (
  tb_module_id char(36) NOT NULL,
  tb_interface_id char(36) NOT NULL,
  active char(1) DEFAULT NULL,
  created_at datetime default CURRENT_TIMESTAMP,
  updated_at datetime default CURRENT_TIMESTAMP,
  PRIMARY KEY(tb_module_id,tb_interface_id)  

)
GO

INSERT INTO [dbo].[tb_module_has_interface]
           ([tb_module_id]
           ,[tb_interface_id]
           ,[active])
     VALUES
           ('D2A79A07-09A5-4A05-A5C9-547C3B4502E0'
           ,'B70138AC-C13C-4939-A1E6-5278BB08ACC4'
           ,'S')
GO


INSERT INTO [dbo].[tb_module_has_interface]
           ([tb_module_id]
           ,[tb_interface_id]
           ,[active])
     VALUES
           ('D2A79A07-09A5-4A05-A5C9-547C3B4502E0'
           ,'5733051D-7D60-4F4E-A617-8E88975CD122'
           ,'S')
GO

INSERT INTO [dbo].[tb_module_has_interface]
           ([tb_module_id]
           ,[tb_interface_id]
           ,[active])
     VALUES
           ('D2A79A07-09A5-4A05-A5C9-547C3B4502E0'
           ,'5D6F9021-E4AF-4848-B175-00F17AA8268A'
           ,'S')
GO
create table tb_product_serial_norma(
      tb_institution_id char(36) NOT NULL,
      tb_product_id char(36) NOT NULL,
      norma_id varchar(50) NOT NULL,
      part_number varchar(20) NOT NULL, 
      created_at datetime default CURRENT_TIMESTAMP,
      updated_at datetime default CURRENT_TIMESTAMP,
      PRIMARY KEY(tb_institution_id,tb_product_id,norma_id, part_number) 
)
GO