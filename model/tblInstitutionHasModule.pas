unit tblInstitutionHasModule;


interface

Uses GenericEntity,GenericOrm,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_institution_has_module')]
  TInstitutionHasModule = Class(TGenericEntity)
  private
    Factive: String;
    Ftb_modules_id: String;
    Ftb_institution_id: String;
    procedure setFactive(const Value: String);
    procedure setFtb_institution_id(const Value: String);
    procedure setFtb_modules_id(const Value: String);

  public
    [FieldName('tb_institution_id')]
    [KeyField('tb_institution_id')]
    property Estabelecimento: String read Ftb_institution_id write setFtb_institution_id;

    [FieldName('tb_modules_id')]
    [KeyField('tb_modules_id')]
    property CodigoModulo: String read Ftb_modules_id write setFtb_modules_id;

    [FieldName('active')]
    property Ativo: String read Factive write setFactive;


  End;
implementation

{ TInstitutionHasModule }

procedure TInstitutionHasModule.setFactive(const Value: String);
begin
  Factive := Value;
end;

procedure TInstitutionHasModule.setFtb_institution_id(const Value: String);
begin
  Ftb_institution_id := Value;
end;

procedure TInstitutionHasModule.setFtb_modules_id(const Value: String);
begin
  Ftb_modules_id := Value;
end;

end.
