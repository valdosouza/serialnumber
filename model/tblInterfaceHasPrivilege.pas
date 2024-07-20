unit tblInterfaceHasPrivilege;

interface

Uses GenericEntity,GenericOrm,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_interface_has_privilege')]
  TInterfaceHasPrivilege = Class(TGenericEntity)
  private
    Factive: String;
    Ftb_interface_id: String;
    Ftb_privilege_id: String;
    procedure setFactive(const Value: String);
    procedure setFtb_interface_id(const Value: String);
    procedure setFtb_privilege_id(const Value: String);


  public

    [FieldName('tb_interface_id')]
    [KeyField('tb_interface_id')]
    property CodigoInterface: String read Ftb_interface_id write setFtb_interface_id;

    [FieldName('tb_privilege_id')]
    [KeyField('tb_privilege_id')]
    property CodigoPrivilegio: String read Ftb_privilege_id write setFtb_privilege_id;

    [FieldName('active')]
    property Ativo: String read Factive write setFactive;

  End;
implementation


{ TInterfaceHasPrivilege }

procedure TInterfaceHasPrivilege.setFactive(const Value: String);
begin
  Factive := Value;
end;

procedure TInterfaceHasPrivilege.setFtb_interface_id(const Value: String);
begin
  Ftb_interface_id := Value;
end;

procedure TInterfaceHasPrivilege.setFtb_privilege_id(const Value: String);
begin
  Ftb_privilege_id := Value;
end;

end.
