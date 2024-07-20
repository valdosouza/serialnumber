unit tblMailingGroup;

interface

Uses GenericEntity,GenericOrm,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_mailing_group')]
  TMailingGroup = Class(TGenericEntity)
  private
    Fdescription: String;
    FID: String;
    procedure setFdescription(const Value: String);
    procedure setFID(const Value: String);

  public

    [KeyField('id')]
    [FieldName('id')]
    property Codigo: String read FID write setFID;

    [FieldName('description')]
    property Descricao: String read Fdescription write setFdescription;

  End;

implementation



{ TMailingGroup }

procedure TMailingGroup.setFdescription(const Value: String);
begin
  Fdescription := Value;
end;

procedure TMailingGroup.setFID(const Value: String);
begin
  FID := Value;
end;

end.
