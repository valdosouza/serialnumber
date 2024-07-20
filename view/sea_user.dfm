inherited SeaUSer: TSeaUSer
  Caption = 'SeaUSer'
  ClientHeight = 400
  ClientWidth = 734
  ExplicitWidth = 740
  ExplicitHeight = 449
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 118
    Width = 728
    Height = 279
    ExplicitTop = 118
    ExplicitWidth = 728
    ExplicitHeight = 279
    inherited DBG_Pesquisa: TDBGrid
      Width = 632
      Height = 261
      Columns = <
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'name_company'
          Title.Caption = 'Nome do Usu'#225'rio'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'email'
          Title.Caption = 'e-mail'
          Width = 300
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 634
      Height = 261
      ExplicitLeft = 634
      ExplicitHeight = 261
      inherited Sb_Sair_0: TSpeedButton
        Top = 198
        ExplicitTop = 327
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 135
        ExplicitTop = 264
      end
      inherited SB_Buscar: TSpeedButton
        Top = 72
        ExplicitTop = 201
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 9
        ExplicitTop = 138
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 728
    Height = 109
    ExplicitWidth = 728
    ExplicitHeight = 109
    object Label28: TLabel
      Left = 5
      Top = 3
      Width = 30
      Height = 14
      Caption = 'Nome '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 6
      Top = 43
      Width = 28
      Height = 14
      Caption = 'E-mail'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_name_company: TEdit
      Left = 4
      Top = 19
      Width = 466
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object E_Email: TEdit
      Left = 5
      Top = 60
      Width = 466
      Height = 22
      CharCase = ecLowerCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object chbx_ativo: TCheckBox
      Left = 8
      Top = 88
      Width = 97
      Height = 17
      Caption = 'Cadastro Ativo'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
  inherited MnuMain: TMainMenu
    Left = 56
    Top = 184
  end
  inherited cds_search: TClientDataSet
    object cds_searchid: TGuidField
      FieldName = 'id'
      Origin = 'id'
      Required = True
      Size = 38
    end
    object cds_searchname_company: TStringField
      FieldName = 'name_company'
      Origin = 'name_company'
      Size = 100
    end
    object cds_searchemail: TStringField
      FieldName = 'email'
      Origin = 'email'
      Required = True
      Size = 100
    end
  end
end
