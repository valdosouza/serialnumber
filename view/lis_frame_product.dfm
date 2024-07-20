inherited listFrameProduct: TlistFrameProduct
  Width = 750
  Height = 47
  ExplicitWidth = 750
  ExplicitHeight = 47
  inherited Lb_Lista: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 744
    Margins.Bottom = 1
    Caption = 'Codigo Refer'#234'ncia            Nome do produto'
    ExplicitLeft = 3
    ExplicitTop = 3
    ExplicitWidth = 207
  end
  object Label37: TLabel [1]
    Left = 416
    Top = 48
    Width = 72
    Height = 14
    Caption = 'N'#250'mero pedido'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  inherited pnl_Lista: TPanel
    Top = 18
    Width = 750
    ExplicitTop = 18
    ExplicitWidth = 750
    inherited DBLCB_Lista: TDBLookupComboBox
      Left = 128
      Width = 619
      Align = alClient
      KeyField = 'id'
      ListField = 'description'
      TabOrder = 1
      OnClick = DBLCB_ListaClick
      ExplicitLeft = 128
      ExplicitWidth = 619
    end
    object E_Reference: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 2
      Width = 121
      Height = 22
      Margins.Top = 2
      Margins.Right = 1
      Margins.Bottom = 2
      Align = alLeft
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnExit = E_ReferenceExit
    end
  end
  inherited Qr_Lista: TFDQuery
    SQL.Strings = (
      
        ' Select id, tb_institution_id,reference, description, reference ' +
        '  '
      ' from tb_product p '
      ' where active ='#39'S'#39)
  end
end
