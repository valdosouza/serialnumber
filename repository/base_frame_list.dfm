object BaseFrameList: TBaseFrameList
  Left = 0
  Top = 0
  Width = 408
  Height = 43
  TabOrder = 0
  object Lb_Lista: TLabel
    Left = 0
    Top = 0
    Width = 408
    Height = 14
    Align = alTop
    Caption = 'Nome da Lista'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 68
  end
  object pnl_Lista: TPanel
    Left = 0
    Top = 14
    Width = 408
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnl_Lista'
    TabOrder = 0
    object DBLCB_Lista: TDBLookupComboBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 402
      Height = 22
      Align = alLeft
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ListSource = Ds_Lista
      ParentFont = False
      TabOrder = 0
      OnKeyDown = DBLCB_ListaKeyDown
    end
  end
  object Qr_Lista: TFDQuery
    Connection = DM.FDConnection
    Left = 104
    Top = 40
  end
  object Ds_Lista: TDataSource
    DataSet = Qr_Lista
    Left = 160
    Top = 40
  end
end
