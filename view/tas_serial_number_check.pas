unit tas_serial_number_check;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls,ControllerSerialNumber;

type
  TTasSerialNumberCheck = class(TFr_Base)
    pnl_botao: TPanel;
    SB_Sair_0: TSpeedButton;
    Panel1: TPanel;
    Lb_Situacao: TLabel;
    CB_Situacao: TComboBox;
    E_Serial_Number: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Lb_Resultado_Verificacao: TLabel;
    procedure SB_Sair_0Click(Sender: TObject);
    procedure E_Serial_NumberKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FSerialNumber :TControllerSerialNumber;
    procedure VerificaSerialNumber;
    function RegistraHistorico:boolean;
  protected
    procedure CriarVariaveis;override;
    procedure IniciaVariaveis;override;
    procedure FinalizaVariaveis;override;

  public
    { Public declarations }
  end;

var
  TasSerialNumberCheck: TTasSerialNumberCheck;

implementation

{$R *.dfm}

uses env;

procedure TTasSerialNumberCheck.CriarVariaveis;
begin
  inherited;
  FSerialNumber := TControllerSerialNumber.Create((self));
end;

procedure TTasSerialNumberCheck.E_Serial_NumberKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) then
  Begin
    VerificaSerialNumber;
    Key:= #0;
  End;
end;

procedure TTasSerialNumberCheck.FinalizaVariaveis;
begin
  inherited;
  FSerialNumber.DisposeOf;
end;

procedure TTasSerialNumberCheck.FormKeyPress(Sender: TObject; var Key: Char);
begin
  //
end;

procedure TTasSerialNumberCheck.IniciaVariaveis;
begin
  inherited;
  E_Serial_Number.SetFocus;
end;

function TTasSerialNumberCheck.RegistraHistorico:Boolean;
begin
  Result := False;
  with FSerialNumber do
  Begin
    Registro.Number := E_Serial_Number.Text;
    getBySerialnumber;
    if exist then
    Begin
      Historico.Registro.Codigo         := '';
      Historico.Registro.SerialNumberId := FSerialNumber.Registro.Codigo;
      Historico.Registro.Usuario        := GbInstitution.User.Registro.Codigo;
      Historico.Registro.Situacao       := CB_Situacao.Text;
      Historico.Registro.Descricao      := '';
      Historico.insert;
      REsult := True;
    End;
  End;
end;

procedure TTasSerialNumberCheck.SB_Sair_0Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TTasSerialNumberCheck.VerificaSerialNumber;
begin
  if Length(Trim(E_Serial_Number.Text)) > 0 then
  Begin
    if RegistraHistorico then
    Begin
      Lb_Resultado_Verificacao.Caption := concat('Número serial: ',E_Serial_Number.Text, ' verificada com sucesso.');
      Lb_Resultado_Verificacao.Font.Color := clNavy;
      Lb_Resultado_Verificacao.Font.Style := [fsBold];
    End
    else
    Begin
      Lb_Resultado_Verificacao.Caption := concat('Número serial: ',E_Serial_Number.Text, ' não encontrado. Verifique.');
      Lb_Resultado_Verificacao.Font.Color := clRed;
      Lb_Resultado_Verificacao.Font.Style := [fsBold];
    End;
    Lb_Resultado_Verificacao.Update;
    E_Serial_Number.Clear;
    E_Serial_Number.SetFocus;
  End;
end;

end.
