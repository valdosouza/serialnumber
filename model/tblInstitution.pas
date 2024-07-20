unit tblInstitution;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;
Type
  //nome da classe de entidade
  [TableName('tb_institution')]
  TInstitution = Class(TGenericEntity)
  private
    FActive: String;
    FId: String;
    procedure setFActive(const Value: String);
    procedure setFId(const Value: String);

  public
    [FieldName('id')]
    [KeyField('id')]
    property Codigo: String read FId write setFId;

    [FieldName('active')]
    property Ativo: String read FActive write setFActive;

  End;
implementation

{ TInstitution }

procedure TInstitution.setFActive(const Value: String);
begin
  FActive := Value;
end;

procedure TInstitution.setFId(const Value: String);
begin
  FId := Value;
end;

end.
