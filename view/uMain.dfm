inherited Main: TMain
  BorderStyle = bsSizeable
  Caption = 'Gerenciador de Serial Number'
  ClientHeight = 450
  ClientWidth = 855
  Menu = nil
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnResize = FormResize
  ExplicitWidth = 871
  ExplicitHeight = 489
  DesignSize = (
    855
    450)
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Login: TPanel [0]
    Left = 289
    Top = 54
    Width = 331
    Height = 172
    ParentCustomHint = False
    Anchors = [akBottom]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    BiDiMode = bdLeftToRight
    Color = clNavy
    Ctl3D = True
    DoubleBuffered = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBiDiMode = False
    ParentBackground = False
    ParentCtl3D = False
    ParentDoubleBuffered = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    DesignSize = (
      331
      172)
    object Lb_Title: TLabel
      Left = 2
      Top = 2
      Width = 327
      Height = 20
      ParentCustomHint = False
      Align = alTop
      Alignment = taCenter
      BiDiMode = bdLeftToRight
      Caption = 'Acesso ao Sistema'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      ExplicitWidth = 155
    end
    object Panel1: TPanel
      Left = 5
      Top = 28
      Width = 321
      Height = 139
      ParentCustomHint = False
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelInner = bvLowered
      BevelOuter = bvNone
      BiDiMode = bdLeftToRight
      Color = clWhite
      Ctl3D = True
      DoubleBuffered = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBiDiMode = False
      ParentBackground = False
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      object SB_Login: TSpeedButton
        Left = 113
        Top = 104
        Width = 91
        Height = 31
        Caption = 'Entrar'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = '@Arial Unicode MS'
        Font.Style = []
        NumGlyphs = 2
        ParentFont = False
        OnClick = SB_LoginClick
      end
      object Label1: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 313
        Height = 13
        Align = alTop
        Caption = 'e-mail'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 27
      end
      object Label2: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 53
        Width = 313
        Height = 15
        Align = alTop
        Caption = 'Senha'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = '@Arial Unicode MS'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 31
      end
      object E_Password: TMaskEdit
        AlignWithMargins = True
        Left = 4
        Top = 74
        Width = 313
        Height = 24
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 1
        Text = ''
      end
      object CB_User: TComboBox
        AlignWithMargins = True
        Left = 4
        Top = 23
        Width = 313
        Height = 24
        Align = alTop
        CharCase = ecLowerCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  object SB_Status: TStatusBar [1]
    Left = 0
    Top = 429
    Width = 855
    Height = 21
    BorderWidth = 2
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Panels = <
      item
        Alignment = taCenter
        Text = '20:42:51'
        Width = 60
      end
      item
        Alignment = taCenter
        Text = '14/12/2021'
        Width = 65
      end
      item
        Alignment = taCenter
        Text = 'Vers'#227'o: 1.2023'
        Width = 180
      end
      item
        Text = 'Usu'#225'rio:'
        Width = 230
      end
      item
        Alignment = taCenter
        Text = 'NUM'
        Width = 50
      end
      item
        Alignment = taCenter
        Text = 'CAPS'
        Width = 50
      end
      item
        Alignment = taCenter
        Text = 'INS'
        Width = 50
      end
      item
        Width = 200
      end>
    ParentShowHint = False
    ShowHint = False
    UseSystemFont = False
  end
  inherited MnuMain: TMainMenu
    object Arquivos1: TMenuItem [0]
      Caption = 'Arquivos'
      object CadastrodeProdutos1: TMenuItem
        Caption = 'Cadastro de Produtos'
        OnClick = CadastrodeProdutos1Click
      end
      object Sair2: TMenuItem
        Caption = 'Sair'
        OnClick = Sair2Click
      end
    end
    inherited arefas1: TMenuItem
      object RegistroSerial1: TMenuItem [0]
        Caption = 'Registro Serial'
        OnClick = RegistroSerial1Click
      end
      inherited Sair1: TMenuItem
        Caption = 'Sair (Heran'#231'a)'
        Visible = False
      end
    end
    object Administrao2: TMenuItem
      Caption = 'Administra'#231#227'o'
      object CadastrodeUsuarios: TMenuItem
        Caption = 'Cadastro de Usu'#225'rios'
        OnClick = CadastrodeUsuariosClick
      end
      object Config1: TMenuItem
        Caption = 'Config'
        OnClick = Config1Click
      end
      object rocadeSenha1: TMenuItem
        Caption = 'Troca de Senha'
        OnClick = rocadeSenha1Click
      end
    end
    object Logout1: TMenuItem
      Caption = 'Logout'
      OnClick = Logout1Click
    end
  end
  object AppEvents: TApplicationEvents
    OnException = AppEventsException
    OnHint = AppEventsHint
    Left = 16
    Top = 112
  end
  object Tm_Status: TTimer
    Enabled = False
    OnTimer = Tm_StatusTimer
    Left = 16
    Top = 168
  end
end
