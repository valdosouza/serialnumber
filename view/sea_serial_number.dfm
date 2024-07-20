inherited SeaSerialNumber: TSeaSerialNumber
  Caption = 'Pesquisa de n'#250'mero serial registrado'
  ClientHeight = 635
  ClientWidth = 1174
  ExplicitWidth = 1180
  ExplicitHeight = 684
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 107
    Width = 1168
    Height = 525
    ExplicitTop = 107
    ExplicitWidth = 1168
    ExplicitHeight = 525
    inherited DBG_Pesquisa: TDBGrid
      Width = 1072
      Height = 507
      Columns = <
        item
          Expanded = False
          FieldName = 'created_at'
          Title.Caption = 'Data e Hora'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'number'
          Title.Caption = 'N'#250'mero Serial'
          Width = 269
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'status'
          Title.Caption = 'Situa'#231#227'o'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name_company'
          Title.Caption = 'Usu'#225'rio'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'description'
          Title.Caption = 'Detalhe'
          Width = 300
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 1074
      Height = 507
      ExplicitLeft = 1074
      ExplicitHeight = 507
      inherited Sb_Sair_0: TSpeedButton
        Top = 444
        ExplicitTop = 319
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 381
        Visible = False
        ExplicitTop = 256
      end
      inherited SB_Buscar: TSpeedButton
        Top = 318
        ExplicitTop = 193
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 255
        Visible = False
        ExplicitTop = 130
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 1168
    Height = 98
    ExplicitWidth = 1168
    ExplicitHeight = 98
    object Lb_Situacao: TLabel
      Left = 485
      Top = 4
      Width = 42
      Height = 14
      Caption = 'Situa'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Data_Ini: TDateTimePicker
      Left = 3
      Top = 21
      Width = 100
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 0
    end
    object E_Data_Fim: TDateTimePicker
      Left = 108
      Top = 21
      Width = 100
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object ChBx_Periodo: TCheckBox
      Left = 6
      Top = 6
      Width = 180
      Height = 12
      Caption = 'Data Inicial           Data Final'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    inline ListFrameUser: TListFrameUser
      Left = 210
      Top = 4
      Width = 273
      Height = 40
      TabOrder = 2
      ExplicitLeft = 210
      ExplicitTop = 4
      ExplicitWidth = 273
      ExplicitHeight = 40
      inherited Lb_Lista: TLabel
        Width = 273
      end
      inherited pnl_Lista: TPanel
        Width = 273
        ExplicitWidth = 273
        inherited DBLCB_Lista: TDBLookupComboBox
          Width = 267
          Align = alClient
          ExplicitWidth = 267
        end
      end
    end
    object CB_Situacao: TComboBox
      Left = 485
      Top = 21
      Width = 159
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 3
      Text = 'Grava'#231#227'o'
      Items.Strings = (
        'Grava'#231#227'o'
        'Primeira Confer'#234'ncia'
        'Segunda Confer'#234'ncia')
    end
    inline listFrameProduct: TlistFrameProduct
      Left = 5
      Top = 45
      Width = 620
      Height = 47
      TabOrder = 5
      ExplicitLeft = 5
      ExplicitTop = 45
      ExplicitWidth = 620
      inherited Lb_Lista: TLabel
        Width = 614
      end
      inherited pnl_Lista: TPanel
        Width = 620
        ExplicitWidth = 620
        inherited DBLCB_Lista: TDBLookupComboBox
          Width = 489
          ExplicitWidth = 489
        end
      end
    end
  end
  inherited MnuMain: TMainMenu
    Left = 32
    Top = 176
    inherited arefas1: TMenuItem
      object Gravao1: TMenuItem [0]
        Caption = 'Grava'#231#227'o'
        OnClick = Gravao1Click
      end
      object Conferncia1: TMenuItem [1]
        Caption = 'Confer'#234'ncia'
        OnClick = Conferncia1Click
      end
    end
  end
  inherited cds_search: TClientDataSet
    object cds_searchcreated_at: TSQLTimeStampField
      FieldName = 'created_at'
      Origin = 'created_at'
    end
    object cds_searchnumber: TStringField
      FieldName = 'number'
      Origin = 'number'
      Required = True
      Size = 100
    end
    object cds_searchstatus: TStringField
      FieldName = 'status'
      Origin = 'status'
      Required = True
      Size = 50
    end
    object cds_searchname_company: TStringField
      FieldName = 'name_company'
      Origin = 'name_company'
      Size = 100
    end
    object cds_searchdescription: TStringField
      FieldName = 'description'
      Origin = 'description'
      Size = 100
    end
  end
end
