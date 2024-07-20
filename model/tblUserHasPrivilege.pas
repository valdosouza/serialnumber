unit tblUserHasPrivilege;

interface

Uses GenericEntity,GenericOrm,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_user_has_privilege')]
  TUserHasPrivilege = Class(TGenericEntity)
  private
    Factive: String;
    Ftb_interface_id: String;
    Ftb_privilege_id: String;
    Ftb_institution_id: String;
    Ftb_user_id: String;
    procedure setFactive(const Value: String);
    procedure setFtb_institution_id(const Value: String);
    procedure setFtb_interface_id(const Value: String);
    procedure setFtb_privilege_id(const Value: String);
    procedure setFtb_user_id(const Value: String);


  public

    [FieldName('tb_institution_id')]
    [KeyField('tb_institution_id')]
    property Estabelecimento: String read Ftb_institution_id write setFtb_institution_id;

    [FieldName('tb_user_id')]
    [KeyField('tb_user_id')]
    property Usuario: String read Ftb_user_id write setFtb_user_id;

    [FieldName('tb_interface_id')]
    [KeyField('tb_interface_id')]
    property TelaInterface: String read Ftb_interface_id write setFtb_interface_id;

    [FieldName('tb_privilege_id')]
    [KeyField('tb_privilege_id')]
    property Privilegio: String read Ftb_privilege_id write setFtb_privilege_id;

    [FieldName('active')]
    property Ativo: String read Factive write setFactive;


  End;
implementation


{ TUserHasPrivilege }

procedure TUserHasPrivilege.setFactive(const Value: String);
begin
  Factive := Value;
end;

procedure TUserHasPrivilege.setFtb_institution_id(const Value: String);
begin
  Ftb_institution_id := Value;
end;

procedure TUserHasPrivilege.setFtb_interface_id(const Value: String);
begin
  Ftb_interface_id := Value;
end;

procedure TUserHasPrivilege.setFtb_privilege_id(const Value: String);
begin
  Ftb_privilege_id := Value;
end;

procedure TUserHasPrivilege.setFtb_user_id(const Value: String);
begin
  Ftb_user_id := Value;
end;

end.
