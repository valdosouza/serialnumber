inherited CadProduct: TCadProduct
  Caption = 'Cadastro de Produtos'
  ClientHeight = 244
  ClientWidth = 639
  ExplicitWidth = 645
  ExplicitHeight = 293
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 180
    Width = 639
    ExplicitTop = 180
    ExplicitWidth = 639
    inherited SB_Inserir: TSpeedButton
      Left = 12
      ExplicitLeft = 15
    end
    inherited SB_Alterar: TSpeedButton
      Left = 116
      ExplicitLeft = 119
    end
    inherited SB_Excluir: TSpeedButton
      Left = 220
      ExplicitLeft = 223
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 428
      ExplicitLeft = 431
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 532
      ExplicitLeft = 535
    end
    inherited SB_Gravar: TSpeedButton
      Left = 324
      ExplicitLeft = 327
    end
  end
  inherited pnl_fundo: TPanel
    Width = 639
    Height = 180
    ExplicitWidth = 639
    ExplicitHeight = 180
    object Label28: TLabel
      Left = 6
      Top = 3
      Width = 115
      Height = 14
      Caption = 'CF - C'#243'digo Fornecedor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 164
      Top = 3
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
    object Label2: TLabel
      Left = 6
      Top = 40
      Width = 31
      Height = 14
      Caption = 'Norma'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_PartNumber_01: TLabel
      Left = 164
      Top = 41
      Width = 94
      Height = 14
      Caption = 'PN - PartNumber 01'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_PartNumber_02: TLabel
      Left = 403
      Top = 40
      Width = 94
      Height = 14
      Caption = 'PN - PartNumber 02'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label3: TLabel
      Left = 6
      Top = 79
      Width = 71
      Height = 14
      Caption = 'T1 - Texto Fixo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 211
      Top = 79
      Width = 71
      Height = 14
      Caption = 'T2 - Texto Fixo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 414
      Top = 79
      Width = 108
      Height = 14
      Caption = 'RD - Revis'#227'o desenho'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 6
      Top = 116
      Width = 79
      Height = 14
      Caption = 'M'#225'scara padr'#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_code_Provider: TEdit
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
      Left = 163
      Top = 16
      Width = 466
      Height = 22
      CharCase = ecUpperCase
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
      Top = 157
      Width = 97
      Height = 17
      TabStop = False
      Anchors = [akLeft, akBottom]
      Caption = 'Cadastro Ativo'
      Checked = True
      State = cbChecked
      TabOrder = 9
    end
    object Cb_Normas: TComboBox
      Left = 6
      Top = 55
      Width = 156
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      OnChange = Cb_NormasChange
      Items.Strings = (
        'N'#195'O INFORMADA'
        'PF.901106'
        'FPW.PTTSTR')
    end
    object E_PartNumber_01: TEdit
      Left = 164
      Top = 55
      Width = 233
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object E_PartNumber_02: TEdit
      Left = 397
      Top = 55
      Width = 233
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Visible = False
    end
    object E_T1: TEdit
      Left = 6
      Top = 93
      Width = 205
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object E_T2: TEdit
      Left = 211
      Top = 93
      Width = 201
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object E_RD: TEdit
      Left = 413
      Top = 93
      Width = 216
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object E_Mascara_padrao: TEdit
      Left = 6
      Top = 131
      Width = 623
      Height = 22
      Hint = 
        'PN: Part Number CF:  C'#195#179'digo do Fornecedor Metalkraft no cliente' +
        ' CJ:  Dia e ano no calend'#195#161'rio Juliano SQ: Sequencial T1: Um tex' +
        'to fixo que fa'#195#167'a parte do n'#195#186'mero serial. T2: Um segundo texto ' +
        'fixo que fa'#195#167'a parte do n'#195#186'mero serial RD: A revis'#195#163'o do desenho' +
        ' do Produto SH: o turno de fabrica'#195#167#195#163'o (SHIFT) LN: Linha de Pro' +
        'du'#195#167#195#163'o do Produto '
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
    end
  end
  inherited MnuMain: TMainMenu
    Left = 40
    Top = 192
    inherited arefas1: TMenuItem
      object Imagens1: TMenuItem [0]
        Caption = 'Imagens'
        OnClick = Imagens1Click
      end
    end
  end
end
