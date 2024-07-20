unit tblUser;

interface

Uses GenericEntity,GenericOrm,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_user')]
  TUser = Class(TGenericEntity)
  private
    Factivation_key: String;
    Fsalt: String;
    Factive: String;
    Fid: String;
    Fpassword: String;
    FKind: String;
    procedure setFactivation_key(const Value: String);
    procedure setFactive(const Value: String);
    procedure setFid(const Value: String);
    procedure setFKind(const Value: String);
    procedure setFpassword(const Value: String);
    procedure setFSalt(const Value: String);

  public

    [KeyField('id')]
    [FieldName('id')]
    property Codigo: String read Fid write setFid;

    [FieldName('password')]
    property Password: String read Fpassword write setFpassword;

    [FieldName('kind')]
    property Tipo: String read FKind write setFKind;

    [FieldName('salt')]
    property Salt: String read Fsalt write setFSalt;

    [FieldName('active')]
    property Ativo: String read Factive write setFactive;

    [FieldName('activation_key')]
    property ChaveAtivacao: String read Factivation_key write setFactivation_key;

  End;

implementation

{ TUser }

procedure TUser.setFactivation_key(const Value: String);
begin
  Factivation_key := Value;
end;

procedure TUser.setFactive(const Value: String);
begin
  Factive := Value;
end;

procedure TUser.setFid(const Value: String);
begin
  Fid := Value;
end;

procedure TUser.setFKind(const Value: String);
begin
  FKind := Value;
end;

procedure TUser.setFpassword(const Value: String);
begin
  Fpassword := Value;
end;

procedure TUser.setFSalt(const Value: String);
begin
  Fsalt := Value;
end;

end.

