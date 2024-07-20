unit tblModuleHasInterface;

interface

Uses GenericEntity,GenericOrm,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_module_has_interface')]
  TModuleHasInterface = Class(TGenericEntity)
  private
    Factive: String;
    Ftb_modules_id: String;
    Ftb_interfaces_id: String;
    procedure setFactive(const Value: String);
    procedure setFtb_interfaces_id(const Value: String);
    procedure setFtb_modules_id(const Value: String);

  public
    [FieldName('tb_module_id')]
    [KeyField('tb_module_id')]
    property CodigoModulo: String read Ftb_modules_id write setFtb_modules_id;

    [FieldName('tb_interface_id')]
    [KeyField('tb_interface_id')]
    property CodigoInterface: String read Ftb_interfaces_id write setFtb_interfaces_id;

    [FieldName('active')]
    property Ativo: String read Factive write setFactive;


  End;
implementation

{ TModuleHasInterface }

procedure TModuleHasInterface.setFactive(const Value: String);
begin
  Factive := Value;
end;

procedure TModuleHasInterface.setFtb_interfaces_id(const Value: String);
begin
  Ftb_interfaces_id := Value;
end;

procedure TModuleHasInterface.setFtb_modules_id(const Value: String);
begin
  Ftb_modules_id := Value;
end;

end.
