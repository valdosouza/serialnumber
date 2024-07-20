inherited CadImgProduct: TCadImgProduct
  Left = 186
  Top = 33
  Caption = 'Imagens do Produto'
  ClientHeight = 496
  ClientWidth = 790
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 796
  ExplicitHeight = 545
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Navegacao: TPanel [0]
    Left = 0
    Top = 390
    Width = 790
    Height = 42
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    object nagevation: TDBNavigator
      Left = 8
      Top = 6
      Width = 225
      Height = 33
      DataSource = Ds_Imagem
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
      TabOrder = 0
      OnClick = nagevationClick
    end
  end
  object pnl_topo: TPanel [1]
    Left = 0
    Top = 0
    Width = 790
    Height = 33
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object Lb_Produto: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 85
      Height = 24
      Align = alClient
      Caption = 'Produto X'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  inherited pnl_botao: TPanel
    Top = 432
    Width = 790
    ExplicitTop = 432
    ExplicitWidth = 790
    inherited SB_Inserir: TSpeedButton
      Left = 267
      ExplicitLeft = 267
    end
    inherited SB_Alterar: TSpeedButton
      Left = 3
      Align = alLeft
      Visible = False
      ExplicitLeft = 3
    end
    inherited SB_Excluir: TSpeedButton
      Left = 371
      ExplicitLeft = 371
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 579
      ExplicitLeft = 579
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 683
      ExplicitLeft = 683
    end
    inherited SB_Gravar: TSpeedButton
      Left = 475
      ExplicitLeft = 475
    end
  end
  inherited pnl_fundo: TPanel
    Top = 33
    Width = 790
    Height = 357
    ExplicitTop = 33
    ExplicitWidth = 790
    ExplicitHeight = 357
    object img_produto: TImage
      Left = 2
      Top = 2
      Width = 786
      Height = 353
      Align = alClient
      Center = True
      ExplicitLeft = 0
      ExplicitTop = 1
    end
  end
  object OpenDialogo: TOpenDialog
    Filter = '*.jpg'
    Left = 532
    Top = 25
  end
  object Qr_Imagem: TFDQuery
    Active = True
    Connection = DM.FDConnection
    SQL.Strings = (
      'select id, tb_product_id, content'
      'from tb_product_image'
      'where tb_product_id =:tb_product_id')
    Left = 176
    Top = 72
    ParamData = <
      item
        Name = 'TB_PRODUCT_ID'
        DataType = ftWideString
        ParamType = ptInput
        Value = '29b511b1-55b6-4321-9201-64e658b5fb1f'
      end>
    object Qr_Imagemid: TStringField
      FieldName = 'id'
      Origin = 'id'
      Required = True
      FixedChar = True
      Size = 36
    end
    object Qr_Imagemtb_product_id: TStringField
      FieldName = 'tb_product_id'
      Origin = 'tb_product_id'
      Required = True
      FixedChar = True
      Size = 36
    end
    object Qr_Imagemcontent: TBlobField
      FieldName = 'content'
      Origin = 'content'
      Required = True
    end
  end
  object Ds_Imagem: TDataSource
    DataSet = Qr_Imagem
    Left = 176
    Top = 128
  end
end
