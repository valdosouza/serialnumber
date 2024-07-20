object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 241
  Width = 215
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=db_serial_number'
      'User_Name=sa'
      'Password=masterkey'
      'Server=NOTEVALDO\SQLEXPRESS'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 24
    Top = 16
  end
  object FDPMSSQLLink: TFDPhysMSSQLDriverLink
    Left = 152
    Top = 24
  end
  object Qr_Crud: TFDQuery
    Connection = FDConnection
    Transaction = FDTransaction
    SQL.Strings = (
      
        'SELECT  snh.created_at, sn.number, snh.status, usr.name_company,' +
        ' snh.description'
      'FROM tb_serial_number sn'
      '   inner join tb_serial_number_has_historic snh'
      '   on (sn.id = snh.tb_serial_number_id)'
      '   inner join tb_entity usr'
      '   on (usr.id = snh.tb_user_id)')
    Left = 24
    Top = 88
  end
  object FDTransaction: TFDTransaction
    Connection = FDConnection
    Left = 24
    Top = 144
  end
end
