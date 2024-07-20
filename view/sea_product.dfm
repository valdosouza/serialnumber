inherited SeaProduct: TSeaProduct
  Caption = 'Pesquisa de Produtos'
  ClientHeight = 364
  ClientWidth = 711
  ExplicitWidth = 717
  ExplicitHeight = 413
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 76
    Width = 705
    Height = 285
    ExplicitTop = 76
    ExplicitWidth = 705
    ExplicitHeight = 285
    inherited DBG_Pesquisa: TDBGrid
      Width = 609
      Height = 267
      Columns = <
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'tb_institution_id'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'reference'
          Title.Caption = 'Refer'#234'ncia'
          Width = 168
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'description'
          Title.Caption = 'Descri'#231#227'o'
          Width = 401
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 611
      Height = 267
      ExplicitLeft = 611
      ExplicitHeight = 267
      inherited Sb_Sair_0: TSpeedButton
        Top = 204
        ExplicitTop = 204
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 141
        ExplicitTop = 141
      end
      inherited SB_Buscar: TSpeedButton
        Top = 78
        ExplicitTop = 78
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 15
        ExplicitTop = 15
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 705
    Height = 67
    ExplicitWidth = 705
    ExplicitHeight = 67
    object Label28: TLabel
      Left = 6
      Top = 3
      Width = 53
      Height = 14
      Caption = 'Refer'#234'ncia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 168
      Top = 0
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Reference: TEdit
      Left = 6
      Top = 16
      Width = 156
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
    object E_description: TEdit
      Left = 167
      Top = 16
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
      Left = 6
      Top = 44
      Width = 97
      Height = 17
      Caption = 'Cadastro Ativo'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
  inherited cds_search: TClientDataSet
    object cds_searchid: TStringField
      FieldName = 'id'
      Required = True
      FixedChar = True
      Size = 36
    end
    object cds_searchtb_institution_id: TStringField
      FieldName = 'tb_institution_id'
      Required = True
      FixedChar = True
      Size = 36
    end
    object cds_searchdescription: TStringField
      FieldName = 'description'
      Size = 100
    end
    object cds_searchreference: TStringField
      FieldName = 'reference'
      Size = 30
    end
  end
end
