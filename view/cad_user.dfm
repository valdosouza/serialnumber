inherited CadUser: TCadUser
  Caption = 'Cadastro de Usuarios'
  ClientHeight = 217
  ClientWidth = 626
  ExplicitWidth = 632
  ExplicitHeight = 266
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 153
    Width = 626
    ExplicitTop = 153
    ExplicitWidth = 626
    inherited SB_Inserir: TSpeedButton
      Left = -1
      ExplicitLeft = -1
    end
    inherited SB_Alterar: TSpeedButton
      Left = 103
      ExplicitLeft = 103
    end
    inherited SB_Excluir: TSpeedButton
      Left = 207
      ExplicitLeft = 207
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 415
      ExplicitLeft = 415
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 519
      ExplicitLeft = 519
    end
    inherited SB_Gravar: TSpeedButton
      Left = 311
      ExplicitLeft = 311
    end
  end
  inherited pnl_fundo: TPanel
    Width = 626
    Height = 153
    ExplicitWidth = 626
    ExplicitHeight = 153
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
    object Label2: TLabel
      Left = 6
      Top = 83
      Width = 78
      Height = 14
      Caption = 'Nivel de Acesso'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_name_company: TEdit
      Left = 5
      Top = 18
      Width = 466
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object E_Email: TEdit
      Left = 6
      Top = 55
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
    object CB_Nivel: TComboBox
      Left = 6
      Top = 99
      Width = 159
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 2
      Text = 'Usu'#225'rio'
      Items.Strings = (
        'Usu'#225'rio'
        'Administrador')
    end
    object chbx_active: TCheckBox
      Left = 6
      Top = 126
      Width = 97
      Height = 17
      Caption = 'Ativo'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
  end
  inherited MnuMain: TMainMenu
    inherited arefas1: TMenuItem
      object Permiso1: TMenuItem [0]
        Caption = 'Permiss'#227'o'
        OnClick = Permiso1Click
      end
    end
  end
end
