unit cad_user;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls,ControllerUser,ControllerEntityHasMailing;

type
  TCadUser = class(TBaseRegistry)
    Label28: TLabel;
    E_name_company: TEdit;
    Label1: TLabel;
    E_Email: TEdit;
    Label2: TLabel;
    CB_Nivel: TComboBox;
    chbx_active: TCheckBox;
    Permiso1: TMenuItem;
    procedure Permiso1Click(Sender: TObject);
  private
      EntidadeHasMailing : TControllerEntityHasMailing;
  protected
    //Variaveis
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    //procedure ImagemBotao;Override;
    procedure FormataTela;Override;
    procedure setPerfil;Override;

    procedure ShowData;Override;
    procedure ShowNoData;Override;

    //inserir
    function ValidaInsert():boolean;Override;
    procedure Insert;Override;
    //Editar
    function ValidateChange():boolean;Override;
    procedure Change;Override;
    //Deletar
    function ValidateDelete():boolean;Override;
    procedure Delete;Override;
    //Salvar
    function ValidateSave():boolean;Override;
    procedure Save;Override;
    procedure SaveMailing;
    procedure SaveEntity;
    procedure SaveEntityHasMailing;
    procedure SaveUser;
    procedure SaveInnerInstitution; Virtual;

    //Cancelar
    function ValidateCancel():boolean;Override;
    procedure Cancel;Override;

    procedure EditionControler(T: TComponent);
    procedure EditionControl;Override;

  public
    { Public declarations }
    User : TControllerUser;
  end;

var
  CadUser: TCadUser;

implementation

{$R *.dfm}

uses uMain, Un_Msg, tas_user_has_privilege, env;

{ TCadUser }

procedure TCadUser.Cancel;
begin
  inherited;

end;

procedure TCadUser.Change;
begin
  inherited;
  E_name_company.SetFocus;
end;

procedure TCadUser.CriarVariaveis;
begin
  inherited;
  User := TControllerUser.create(Self);
  EntidadeHasMailing := TControllerEntityHasMailing.Create(self);
end;

procedure TCadUser.Delete;
begin
  inherited;
  User.Registro.Ativo := 'N';
  User.save;
  User.HasInstitution.Registro.Ativo := 'N';
  User.HasInstitution.save;
  self.Close;
end;

procedure TCadUser.EditionControl;
begin
  inherited;

end;

procedure TCadUser.EditionControler(T: TComponent);
begin

end;

procedure TCadUser.FormataTela;
begin
  inherited;

end;

procedure TCadUser.IniciaVariaveis;
begin
  if CodigoRegistro <> '' then
  Begin
    User.Registro.Codigo := CodigoRegistro;
    User.HasInstitution.Registro.Estabelecimento := GbInstitution.Registro.Codigo;
    User.HasInstitution.Registro.Usuario := USer.Registro.Codigo;
    User.getAllByKey;
    User.HasInstitution.getbyKey;
    // Entidade
    User.Entity.Registro.Codigo := User.Registro.Codigo;
    User.Entity.getbyKey;
    // Mailing
    User.Mailing.getbyKind(User.Registro.Codigo, 'sistema');
  End;
  inherited;

end;

procedure TCadUser.Insert;
begin
  inherited;
  E_name_company.SetFocus;
end;

procedure TCadUser.Permiso1Click(Sender: TObject);
Var
  Lc_Form : TTasUserHasPrivilege;
Begin
  if getPrivilege('Cadastro Usuário','ALTERAR') then
  Begin
    Lc_Form := TTasUserHasPrivilege.Create(self);
    try
      Lc_Form.User.Registro.Codigo := User.Registro.Codigo;
      Lc_Form.ShowModal;
    finally
      Lc_Form.DisposeOf;
    end;
  End;
end;

procedure TCadUser.Save;
begin
  SaveMailing;
  SaveEntity;
  SaveEntityHasMailing;
  SaveUser;
  SaveInnerInstitution;
  inherited;
end;

procedure TCadUser.SaveEntity;
begin
  // Entidade
  with User.Entity.Registro do
  Begin
    //Caso já exista um email usaremos a mesma entidade do email
    if (User.Entity.Registro.codigo <> '')  then
      Codigo := User.Entity.Registro.codigo;
    NomeRazao := E_name_company.Text;
    ApelidoFantasia := '';
  End;
  User.Entity.Save;
end;

procedure TCadUser.SaveEntityHasMailing;
begin
  with EntidadeHasMailing.Registro do
  Begin
    Entidade := User.Entity.Registro.Codigo;
    Mailing := User.Mailing.Registro.Codigo;
    Grupo := 'F03F8E47-6D7B-4DF7-8581-92CD36616FD4';
  End;
  EntidadeHasMailing.Save;
end;

procedure TCadUser.SaveInnerInstitution;
begin
  User.HasInstitution.Registro.Estabelecimento := GbInstitution.Registro.Codigo;
  User.HasInstitution.Registro.Usuario := USer.Registro.Codigo;
  User.HasInstitution.Registro.Tipo := CB_Nivel.Text;
  if chbx_active.Checked  then
    User.HasInstitution.Registro.Ativo := 'S'
  else
    User.HasInstitution.Registro.Ativo := 'N';
  User.HasInstitution.save;
end;

procedure TCadUser.SaveMailing;
begin
  // Mailing
  with User do
  Begin
    Mailing.Registro.Email := E_email.Text;
    Mailing.Save;
  End;

end;

procedure TCadUser.SaveUser;
begin
  // User
  with User.Registro do
  Begin
    Codigo := User.Entity.Registro.Codigo;
    if ( EditionState = 'I' ) then
      Password := User.encryptPassword('12345');

    if chbx_active.Checked then
      Ativo := 'S'
    else
      Ativo := 'N';
    Tipo := 'sistema';
  End;
  User.Save;
  CodigoRegistro := User.Registro.Codigo;
end;

procedure TCadUser.setPerfil;
begin
  TelaInterface := 'Cadastro Usuário';
  inherited;

end;

procedure TCadUser.ShowData;
var
  Lc_I : Integer;
begin
  E_name_company.Text := User.Entity.Registro.NomeRazao;
  E_Email.Text := User.Mailing.Registro.Email;
  for Lc_I := 0 to CB_Nivel.Items.Count -1 do
  Begin
    if (User.HasInstitution.Registro.Tipo = CB_Nivel.Items[Lc_I]) then
      CB_Nivel.ItemIndex := Lc_I;
  End;
  chbx_active.Checked := User.HasInstitution.Registro.Ativo = 'S';
end;

procedure TCadUser.ShowNoData;
begin
  ClearAllFields;
end;

function TCadUser.ValidaInsert: boolean;
begin
  REsult := True;
end;

function TCadUser.ValidateCancel: boolean;
begin
  Result := True;
end;

function TCadUser.ValidateChange: boolean;
begin
  Result := True;
end;

function TCadUser.ValidateDelete: boolean;
begin
  REsult := True;
  if (MensagemPadrao('Mensagem de Confirmação',
                      'Excluir o usuário de seus arquivos.' + EOLN + EOLN +
                      'Confirmar a exclusão ?',
                      ['Sim', 'Não'], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao2) then
  Begin
    Result := False;
    Exit;
  End;
end;

function TCadUser.ValidateSave: boolean;
begin
  Result:=true;
  if TRIM(E_name_company.Text) = '' then
  begin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Nome do Usuário não informado.'+EOLN+
                   'Preencha o Nome deste Usuário.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    E_name_company.SetFocus;
    Exit;
  end;

  if TRIM(E_Email.Text) = '' then
  begin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Email do Usuário não informado.'+EOLN+
                   'Preencha o Login deste Usuário.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    E_Email.SetFocus;
    Exit;
  end;
end;

end.
