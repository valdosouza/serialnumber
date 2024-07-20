inherited CfgDevice: TCfgDevice
  BorderStyle = bsDialog
  Caption = 'Configura'#231#227'o do Dispositivo'
  ClientHeight = 271
  ClientWidth = 273
  ExplicitWidth = 279
  ExplicitHeight = 320
  PixelsPerInch = 96
  TextHeight = 13
  object Panel11: TPanel [0]
    Left = 0
    Top = 0
    Width = 273
    Height = 235
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label10: TLabel
      Left = 10
      Top = 6
      Width = 55
      Height = 13
      Caption = 'Porta Serial'
    end
    object Label42: TLabel
      Left = 10
      Top = 49
      Width = 47
      Height = 13
      Caption = 'Baud rate'
    end
    object Label43: TLabel
      Left = 10
      Top = 94
      Width = 43
      Height = 13
      Caption = 'Data Bits'
    end
    object Label44: TLabel
      Left = 10
      Top = 138
      Width = 28
      Height = 13
      Caption = 'Parity'
    end
    object Label46: TLabel
      Left = 10
      Top = 181
      Width = 42
      Height = 13
      Caption = 'Stop Bits'
    end
    object Cb_Porta_Serial: TComboBox
      Left = 10
      Top = 22
      Width = 145
      Height = 21
      TabOrder = 0
      Text = 'COM1'
      Items.Strings = (
        'COM1'
        'COM2'
        'COM3'
        'COM4'
        'COM5'
        'COM6'
        'COM7'
        'COM8')
    end
    object Cb_Baud_Rate: TComboBox
      Left = 10
      Top = 67
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      Items.Strings = (
        '110'
        '300'
        '600'
        '1200'
        '2400'
        '4800'
        '9600'
        '14400'
        '19200'
        '38400'
        '56000'
        '57600'
        '115200')
    end
    object Cb_Data_Bits: TComboBox
      Left = 10
      Top = 110
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      Items.Strings = (
        '5'
        '6'
        '7'
        '8'
        '16'
        '32')
    end
    object Cb_Paridade: TComboBox
      Left = 10
      Top = 155
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      Items.Strings = (
        'none'
        'odd'
        'even'
        'mark'
        'space')
    end
    object Cb_BitsParada: TComboBox
      Left = 10
      Top = 199
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 4
      Items.Strings = (
        'sbONE'
        'sbONE5'
        'snTWO')
    end
  end
  object pnl_botao: TPanel [1]
    Left = 0
    Top = 235
    Width = 273
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      273
      36)
    object Btn_Ok_12: TButton
      Left = 26
      Top = 5
      Width = 79
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      TabOrder = 0
      OnClick = Btn_Ok_12Click
    end
    object Btn_Cn_12: TButton
      Left = 111
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = Btn_Cn_12Click
    end
    object Btn_AP_12: TButton
      Left = 186
      Top = 5
      Width = 79
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Aplicar'
      TabOrder = 2
      OnClick = Btn_AP_12Click
    end
  end
  inherited MnuMain: TMainMenu
    Left = 200
    Top = 16
  end
end
