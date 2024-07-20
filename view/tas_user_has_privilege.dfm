inherited TasUserHasPrivilege: TTasUserHasPrivilege
  Caption = 'Privilegios de Usu'#225'rios'
  ClientHeight = 308
  ClientWidth = 663
  ExplicitWidth = 669
  ExplicitHeight = 357
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_fundos: TPanel [0]
    Left = 0
    Top = 0
    Width = 663
    Height = 244
    Align = alClient
    TabOrder = 0
    object dbg_modules: TDBGrid
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 221
      Height = 236
      Align = alLeft
      DataSource = ds_modules
      Options = [dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = dbg_modulesCellClick
      Columns = <
        item
          Expanded = False
          FieldName = 'description'
          Title.Caption = 'Interfaces Disponiveis'
          Width = 200
          Visible = True
        end>
    end
    object dbg_interface: TDBGrid
      AlignWithMargins = True
      Left = 231
      Top = 4
      Width = 226
      Height = 236
      Align = alLeft
      DataSource = ds_interfaces
      Options = [dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'description'
          Title.Caption = 'Interfaces Disponiveis'
          Width = 200
          Visible = True
        end>
    end
    object ChlBx_Permissao: TCheckListBox
      AlignWithMargins = True
      Left = 463
      Top = 4
      Width = 196
      Height = 236
      OnClickCheck = ChlBx_PermissaoClickCheck
      Align = alClient
      Color = clCream
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Inserir'
        'Alterar'
        'Excluir'
        'Visualizar')
      ParentFont = False
      Style = lbOwnerDrawFixed
      TabOrder = 2
      OnClick = ChlBx_PermissaoClick
    end
  end
  object pnl_buttons: TPanel [1]
    Left = 0
    Top = 244
    Width = 663
    Height = 64
    Align = alBottom
    TabOrder = 1
    object Sb_Close: TSpeedButton
      AlignWithMargins = True
      Left = 191
      Top = 4
      Width = 95
      Height = 56
      Margins.Left = 0
      Margins.Right = 0
      Align = alLeft
      Caption = 'Sair'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      OnClick = Sb_CloseClick
      ExplicitLeft = 192
      ExplicitTop = 5
      ExplicitHeight = 54
    end
    object Sb_Apply: TSpeedButton
      AlignWithMargins = True
      Left = 1
      Top = 4
      Width = 95
      Height = 56
      Margins.Left = 0
      Margins.Right = 0
      Align = alLeft
      Caption = 'Aplicar'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      OnClick = Sb_ApplyClick
      ExplicitLeft = 4
      ExplicitTop = 6
    end
    object Sb_Cancel: TSpeedButton
      AlignWithMargins = True
      Left = 96
      Top = 4
      Width = 95
      Height = 56
      Margins.Left = 0
      Margins.Right = 0
      Align = alLeft
      Caption = 'Cancelar'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      OnClick = Sb_CancelClick
      ExplicitLeft = 97
      ExplicitTop = 5
      ExplicitHeight = 54
    end
  end
  object cds_modules: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSP'
    AfterScroll = cds_modulesAfterScroll
    Left = 144
    Top = 98
    object cds_modulesid: TStringField
      DisplayWidth = 36
      FieldName = 'id'
      Size = 36
    end
    object cds_modulesdescription: TStringField
      FieldName = 'description'
      Size = 100
    end
  end
  object ds_modules: TDataSource
    DataSet = cds_modules
    Left = 120
    Top = 146
  end
  object cds_interfaces: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSP'
    AfterScroll = cds_interfacesAfterScroll
    Left = 336
    Top = 82
    object cds_interfacesid: TStringField
      FieldName = 'id'
      Size = 36
    end
    object cds_interfacesdescription: TStringField
      FieldName = 'description'
      Size = 100
    end
  end
  object ds_interfaces: TDataSource
    DataSet = cds_interfaces
    Left = 336
    Top = 138
  end
end
