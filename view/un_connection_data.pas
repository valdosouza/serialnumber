unit un_connection_data;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.StdCtrls, Vcl.Menus,
  Vcl.Buttons, Vcl.ExtCtrls, Un_Msg, System.IniFiles;

type
  TFr_ConnectionData = class(TFr_Base)
    pnl_botao: TPanel;
    SB_Start: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    Panel1: TPanel;
    Label28: TLabel;
    E_Server: TEdit;
    Label1: TLabel;
    E_User: TEdit;
    E_Password: TEdit;
    Label2: TLabel;
    procedure SB_Sair_0Click(Sender: TObject);
    procedure SB_StartClick(Sender: TObject);
  private

    function ValidateSave:Boolean;
    procedure save;


  protected
    procedure CriarVariaveis;Override;
  public
    { Public declarations }
  end;

var
  Fr_ConnectionData: TFr_ConnectionData;

implementation

{$R *.dfm}

uses env, UnFunctions;

procedure TFr_ConnectionData.CriarVariaveis;
begin
  inherited;

end;

procedure TFr_ConnectionData.save;
var
   ArquivoIni: TIniFile;
   Lc_NameArq: string;
begin
  ArquivoIni := TIniFile.Create(Lc_NameArq);
  TRy
    GbPathExe := ExtractFilePath(Application.ExeName);
    Lc_NameArq := GbPathExe + 'CONFIG.INI';
    if ArquivoIni.SectionExists('DB') then
    begin
      ArquivoIni.WriteString('DB','Server',E_Server.text);
      ArquivoIni.WriteString('DB','User_Name',criptografar(GbSecretPrase, E_User.text));
      ArquivoIni.WriteString('DB','Password',criptografar(GbSecretPrase,E_Password.text));

    end;
  Finally
    ArquivoIni.DisposeOf;
  End;

end;

procedure TFr_ConnectionData.SB_Sair_0Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFr_ConnectionData.SB_StartClick(Sender: TObject);
begin
  if ValidateSave then
  Begin
    Save;
    Close;
  End;
end;

function TFr_ConnectionData.ValidateSave: Boolean;
begin
  Result := true;
  if (Trim(E_Server.Text) = '') then
  begin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Campo Server não informado.'+EOLN+
                   'Preencha o campo para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    E_Server.SetFocus;
    Exit;
  end;

  if (Trim(E_User.Text) = '') then
  begin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Campo User não informado.'+EOLN+
                   'Preencha o campo para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    E_User.SetFocus;
    Exit;
  end;

  if (Trim(E_Password.Text) = '') then
  begin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Campo Password não informado.'+EOLN+
                   'Preencha o campo para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    E_Password.SetFocus;
    Exit;
  end;

end;

end.
