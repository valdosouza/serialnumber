unit uMain;

interface

uses
  Winapi.Windows, Un_Base, Vcl.ExtCtrls, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.Menus, System.Classes,
  Vcl.Forms,  System.SysUtils, Vcl.Graphics;

type
  TMain = class(TFr_Base)
    Pnl_Login: TPanel;
    Lb_Title: TLabel;
    Panel1: TPanel;
    SB_Login: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    E_Password: TMaskEdit;
    CB_User: TComboBox;
    SB_Status: TStatusBar;
    AppEvents: TApplicationEvents;
    Tm_Status: TTimer;
    Arquivos1: TMenuItem;
    Administrao2: TMenuItem;
    CadastrodeUsuarios: TMenuItem;
    CadastrodeProdutos1: TMenuItem;
    RegistroSerial1: TMenuItem;
    Sair2: TMenuItem;
    Logout1: TMenuItem;
    rocadeSenha1: TMenuItem;
    Config1: TMenuItem;
    procedure SB_LoginClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure AppEventsHint(Sender: TObject);
    procedure Tm_StatusTimer(Sender: TObject);
    procedure CadastrodeProdutos1Click(Sender: TObject);
    procedure CadastrodeUsuariosClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Sair2Click(Sender: TObject);
    procedure Logout1Click(Sender: TObject);
    procedure RegistroSerial1Click(Sender: TObject);
    procedure rocadeSenha1Click(Sender: TObject);
    procedure Config1Click(Sender: TObject);
    procedure AppEventsException(Sender: TObject; E: Exception);

  private
   procedure ChamarTela(FormClass: TFormClass);
    procedure resolution;
    procedure OnMessageOwn(var Msg: TMsg; var Handled: Boolean);
    procedure FillUserCombo(Lista: TComboBox);
    function ValidateAuthentication:Boolean;
    function getAuthentication(Login,Password:String):Boolean;
    procedure setAuthentication;

  protected
    procedure CriarVariaveis;override;
    procedure IniciaVariaveis;override;
    procedure FinalizaVariaveis;override;
    procedure execShorCutKeyReturn;override;
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

uses sea_product, sea_user, Un_Msg, cad_img_product, sea_serial_number,
      tas_change_password, env,tas_config,ControllerUser,ControllerInstitution,
      tas_serial_number_record, UnFunctions;

procedure TMain.AppEventsException(Sender: TObject; E: Exception);
begin
  inherited;
  DeletaArquivoNumeroSerial;
end;

procedure TMain.AppEventsHint(Sender: TObject);
begin
  SB_Status.Panels[7].Text := Application.Hint;
end;

procedure TMain.CadastrodeProdutos1Click(Sender: TObject);
Begin
  if getPrivilege('Cadastro Produto','VISUALIZAR') then
  Begin
    ChamarTela(TSeaProduct);
  End;
end;

procedure TMain.CadastrodeUsuariosClick(Sender: TObject);
Begin
  if getPrivilege('Cadastro Usuário','VISUALIZAR') then
  Begin
    ChamarTela(TSeaUSer);
  End;
end;

procedure TMain.ChamarTela(FormClass: TFormClass);
var
  Lc_form: TForm;
begin
  Lc_form := FormClass.Create(Self);
  try
    Lc_form.ShowModal;
  finally
    FreeAndNil(Lc_form);
  end;
end;

procedure TMain.Config1Click(Sender: TObject);
Begin
  ChamarTela(TTasConfig);
end;

procedure TMain.CriarVariaveis;
begin
  inherited;
  GbInstitution := TControllerInstitution.Create(Self);
  Application.OnMessage := OnMessageOwn;
end;

procedure TMain.execShorCutKeyReturn;
begin
  if Pnl_Login.Visible then
    SB_LoginClick(Self);
end;

procedure TMain.FillUserCombo(Lista: TComboBox);
var
  I : Integer;
begin
  with GbInstitution.User do
  Begin
    getListEMail;
    CB_User.Items.Clear;
    for I := 0 to Mailing.Lista.Count -1 do
    Begin
      CB_User.Items.Add(Mailing.Lista[I].Email);
    End;
  End;
end;

procedure TMain.FinalizaVariaveis;
begin
end;

procedure TMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  case Application.MessageBox('Finalizar o Sistema!', 'Atenção', MB_YESNO or MB_APPLMODAL or MB_ICONINFORMATION) of
    mrYes:
      begin
        CanClose := True;
        Application.Terminate;
      end;
    mrNo: CanClose := False;
  end;
end;

procedure TMain.FormResize(Sender: TObject);
begin
  resolution;
end;

function TMain.getAuthentication(Login, Password: String): Boolean;
begin
  Result := False;
  with GbInstitution.User do
  Begin
    if autenticacao(login,encryptPassword(password)) then
    Begin
      Entity.Registro.Codigo := Registro.Codigo;
      Entity.getByKey;
      Result := True;
      Mailing.getbyEmail(CB_User.Text);
      HasInstitution.Registro.Estabelecimento := GbInstitution.Registro.Codigo;
      HasInstitution.Registro.Usuario := Registro.Codigo;
      HasInstitution.getbyKey;
    End
    else
    Begin
      MensagemPadrao('Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                     'Falha na autenticação.' + EOLN +
                     'Verifique o login ou a senha para continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      E_Password.Clear;
      E_Password.SetFocus;
      exit;
    End;
  End;
end;


procedure TMain.IniciaVariaveis;
begin
  GbInstitution.Registro.Codigo := GbIdInstitution;
  GbInstitution.getByKey ;
  GbInstitution.User.Registro.Codigo := GbIdUser;
  GbInstitution.User.getbyKey;
  top := 0;
  Left := 0;
  FillUserCombo(CB_User);
  SB_Status.Panels[1].Text := DateToStr(Date);
  SB_Status.Panels[2].Text := 'Versão: 1.2024';
  resolution;
  if CB_User.canfocus then CB_User.SetFocus;
end;

procedure TMain.Logout1Click(Sender: TObject);
begin
  CB_User.Text := '';
  E_Password.Clear;
  Pnl_Login.Visible := True;
  GbInstitution.User.clear;
  Menu := nil;
  CB_User.SetFocus;
end;

procedure TMain.OnMessageOwn(var Msg: TMsg; var Handled: Boolean);
var
  KeyState: TKeyboardState;
begin
  GetKeyboardState(KeyState);
  if KeyState[VK_NUMLOCK] = 0 then
    sb_status.Panels[4].Text:= ''
  else
    sb_status.Panels[4].Text:= 'NUM';
  if KeyState[VK_CAPITAL] = 0 then
    sb_status.Panels[5].Text:= ''
  else
    sb_status.Panels[5].Text:= 'CAPS';

  if KeyState[VK_INSERT] = 0 then
    sb_status.Panels[6].Text:= ''
  else
    sb_status.Panels[6].Text:= 'INS';

end;

procedure TMain.RegistroSerial1Click(Sender: TObject);
begin
  if getPrivilege('Registro Serial','VISUALIZAR') then
  Begin
    ChamarTela(TSeaSerialNumber);
  End;
end;

procedure TMain.resolution;
begin
  Pnl_Login.Top  := Trunc( (Height - Pnl_Login.Height) / 2);
  Pnl_Login.Left := Trunc( (Width - Pnl_Login.Width) / 2);
  Lb_Title.Color := clNavy;
  Lb_Title.Font.Color := clWhite;
end;

procedure TMain.rocadeSenha1Click(Sender: TObject);
begin
  ChamarTela(TTasChangePassword);
end;

procedure TMain.Sair2Click(Sender: TObject);
begin
  Close;
end;

procedure TMain.SB_LoginClick(Sender: TObject);
begin
  if ValidateAuthentication then
  Begin
    if getAuthentication(CB_User.Text,E_PassWord.Text) then
      setAuthentication;
    E_PassWord.clear;
  End;
end;

procedure TMain.setAuthentication;
begin
  Pnl_Login.Visible := False;
  Menu := MnuMain;
  SB_Status.Panels[3].Text := 'Usuário: '+ GbInstitution.User.Mailing.Registro.Email;
end;

procedure TMain.Tm_StatusTimer(Sender: TObject);
begin
  SB_Status.Panels[0].Text := TimeToStr(time);
end;

function TMain.ValidateAuthentication: Boolean;
begin
  Result := True;
  If Trim(CB_User.Text) = '' then
  Begin
    MensagemPadrao('Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   'Por Favor informe o email do usuário.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    CB_User.Setfocus;
    exit;
  end;

  If Trim(E_Password.Text) = '' then
  Begin
    MensagemPadrao('Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   'Por favor informe uma senha.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    E_Password.Setfocus;
    exit;
  end;
end;

end.
