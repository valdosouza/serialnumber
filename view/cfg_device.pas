unit cfg_device;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.ExtCtrls, ComPort;

type
  TCfgDevice = class(TFr_Base)
    Panel11: TPanel;
    Label10: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label46: TLabel;
    Cb_Porta_Serial: TComboBox;
    Cb_Baud_Rate: TComboBox;
    Cb_Data_Bits: TComboBox;
    Cb_Paridade: TComboBox;
    Cb_BitsParada: TComboBox;
    pnl_botao: TPanel;
    Btn_Ok_12: TButton;
    Btn_Cn_12: TButton;
    Btn_AP_12: TButton;
    procedure Btn_AP_12Click(Sender: TObject);
    procedure Btn_Cn_12Click(Sender: TObject);
    procedure Btn_Ok_12Click(Sender: TObject);
  private
    { Private declarations }
    procedure Show;
    procedure Save;
  protected
    procedure IniciaVariaveis;Override;
  public
    { Public declarations }
  end;

var
  CfgDevice: TCfgDevice;

implementation

{$R *.dfm}

procedure TCfgDevice.Btn_AP_12Click(Sender: TObject);
begin
  inherited;
  Save;
end;

procedure TCfgDevice.Btn_Cn_12Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TCfgDevice.Btn_Ok_12Click(Sender: TObject);
begin
  inherited;
  save;
  close;
end;

procedure TCfgDevice.IniciaVariaveis;
begin
  inherited;
  Cb_Porta_Serial.Items.Clear;
  EnumPorts( Cb_Porta_Serial.Items );
  Show;
end;

procedure TCfgDevice.Save;
begin
  ConfigFile('G','DEVICE','PARIDADE',IntToStr(Cb_Paridade.ItemIndex));
  ConfigFile('G','DEVICE','BITSPARADA',IntToStr(Cb_BitsParada.ItemIndex));
  ConfigFile('G','DEVICE','DATABITS',Cb_Data_Bits.Text);
  ConfigFile('G','DEVICE','BAUDRATE',Cb_Baud_Rate.Text);
  ConfigFile('G','DEVICE','PORTA',Cb_Porta_Serial.Text);

end;

procedure TCfgDevice.Show;
Var
  Lc_aux : String;
  I:Integer;
begin
  Cb_Paridade.ItemIndex     := StrToIntDef(ConfigFile('L','DEVICE','PARIDADE',''),0);
  Cb_BitsParada.ItemIndex   := StrToIntDef(ConfigFile('L','DEVICE','BITSPARADA',''),0);
  Lc_aux                    := ConfigFile('L','DEVICE','DATABITS','');
  for I := 0 to Cb_Data_Bits.Items.Count do
  Begin
    if Cb_Data_Bits.Items[I] = Lc_aux then
    Begin
      Cb_Data_Bits.ItemIndex := I;
      Break
    End;
  End;
  Lc_aux              := ConfigFile('L','DEVICE','BAUDRATE','');
  for I := 0 to Cb_Baud_Rate.Items.Count do
  Begin
    if Cb_Baud_Rate.Items[I] = Lc_aux then
    Begin
      Cb_Baud_Rate.ItemIndex := I;
      Break
    End;
  End;
  Cb_Porta_Serial.Text      := ConfigFile('L','DEVICE','PORTA','');
end;

end.
