unit tas_change_password;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.Mask, Vcl.ExtCtrls, Vcl.Menus;

type
  TTasChangePassword = class(TFr_Base)
    Panel1: TPanel;
    Panel2: TPanel;
    SB_Confirma: TSpeedButton;
    SB_Cancela: TSpeedButton;
    Label1: TLabel;
    E_SenhaAtual: TMaskEdit;
    E_SenhaNova: TMaskEdit;
    E_ConfirmeSenhaNova: TMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    procedure SB_ConfirmaClick(Sender: TObject);
  private

    function ValidateChangePassword:boolean;
    procedure ChangePassword;
  protected
    procedure CriarVariaveis;override;
  public
    { Public declarations }
  end;

var
  TasChangePassword: TTasChangePassword;

implementation

{$R *.dfm}

uses Un_Msg, env;

procedure TTasChangePassword.ChangePassword;
begin
  GbInstitution.User.Registro.Password := GbInstitution.User.encryptPassword(E_SenhaNova.Text);
  GbInstitution.User.save;
end;

procedure TTasChangePassword.CriarVariaveis;
begin
  inherited;

end;

procedure TTasChangePassword.SB_ConfirmaClick(Sender: TObject);
begin
  if ValidateChangePassword then
  Begin
    ChangePassword;
    MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Senha Alterado com Sucesso.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Close;
  End;
end;

function TTasChangePassword.ValidateChangePassword: boolean;
begin
  Result := True;
  If Trim(E_SenhaAtual.Text) = '' then
  Begin
    MensagemPadrao('Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   'Por Favor informe a senha atual.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    E_SenhaAtual.Setfocus;
    exit;
  end;

  if (GbInstitution.user.encryptPassword(E_SenhaAtual.Text) <> (UpperCase(GbInstitution.User.Registro.Password))) then
  begin
    MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Senha Atual Incorreta.'+EOLN+
                   'Verifique!!'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    E_SenhaAtual.Setfocus;
    exit;
  end;

  If Trim(E_SenhaNova.Text) = '' then
  Begin
    MensagemPadrao('Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   'Por Favor informe uma nova senha.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    E_SenhaNova.Setfocus;
    exit;
  end;

  If Trim(E_ConfirmeSenhaNova.Text) = '' then
  Begin
    MensagemPadrao('Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   'Por favor informe uma confirmação da senha.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    E_ConfirmeSenhaNova.Setfocus;
    exit;
  end;

  if E_SenhaNova.Text <> E_ConfirmeSenhaNova.Text then
  Begin
      MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'A Confirmação da senha não confere.'+EOLN+
                     'Verifique a digitação  e tente novamente!!'+EOLN,
                     ['OK'],[bEscape],mpAlerta);
    Result := False;
    E_ConfirmeSenhaNova.Setfocus;
    exit;
  end;
end;

end.
