unit prm_user;

interface

uses prm_base,tbluser,tblentity, tblMailing,  System.SysUtils ;

Type
  TPrmUser = class(TPrmBase)
  private
    FNovaSenha: String;
    FEntidade: TEntity;
    FEmail: TMailing;
    FTelaInterface: String;
    FSenha: String;
    FUser: TUser;
    FTipoPrivilegio: String;
    procedure setFEmail(const Value: TMailing);
    procedure setFEntidade(const Value: TEntity);
    procedure setFNovaSenha(const Value: String);
    procedure setFSenha(const Value: String);
    procedure setFTelaInterface(const Value: String);
    procedure setFUser(const Value: TUser);
    procedure setFTipoPrivilegio(const Value: String);

  public
    Constructor Create;override;
    Destructor Destroy;override;
    property User :TUser read FUser write setFUser;
    property Entidade :TEntity read FEntidade write setFEntidade;
    property Email : TMailing read FEmail write setFEmail;
    property Senha : String read FSenha write setFSenha;
    property NovaSenha : String read FNovaSenha write setFNovaSenha;
    property TelaInterface: String read FTelaInterface write setFTelaInterface;
    property TipoPrivilegio : String read FTipoPrivilegio write setFTipoPrivilegio;
  end;

implementation

{ TPrmUser }

constructor TPrmUser.Create;
begin
  inherited;
  FUser   := TUser.create;
  FEntidade  := TEntity.create;
  FEmail     := TMailing.create;
end;

destructor TPrmUser.Destroy;
begin
  FUser.DisposeOf;
  FEntidade.DisposeOf;
  FEmail.DisposeOf;
  inherited;
end;


procedure TPrmUser.setFEmail(const Value: TMailing);
begin
  FEmail := Value;
end;

procedure TPrmUser.setFEntidade(const Value: TEntity);
begin
  FEntidade := Value;
end;

procedure TPrmUser.setFNovaSenha(const Value: String);
begin
  FNovaSenha := Value;
end;

procedure TPrmUser.setFSenha(const Value: String);
begin
  FSenha := Value;
end;

procedure TPrmUser.setFTelaInterface(const Value: String);
begin
  FTelaInterface := Value;
end;

procedure TPrmUser.setFTipoPrivilegio(const Value: String);
begin
  FTipoPrivilegio := Value;
end;

procedure TPrmUser.setFUser(const Value: TUser);
begin
  FUser := Value;
end;

end.
