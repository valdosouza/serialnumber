USE [db_serial_number]
GO

/****** Object:  Table [dbo].[tb_product]    Script Date: 18/07/2024 11:52:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER TABLE [dbo].[tb_serial_number] ADD  [standard_used] [varchar](100);
