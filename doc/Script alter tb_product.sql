USE [db_serial_number]
GO

/****** Object:  Table [dbo].[tb_product]    Script Date: 18/07/2024 11:52:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER TABLE [dbo].[tb_product] ADD  [mask_t1] [varchar](100);
ALTER TABLE [dbo].[tb_product] ADD  [mask_t2] [varchar](100);
ALTER TABLE [dbo].[tb_product] ADD  [mask_rd] [varchar](100);
ALTER TABLE [dbo].[tb_product] ADD  [mask_default] [varchar](100);