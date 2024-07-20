unit tblMailing;

interface

Uses GenericEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_mailing')]
  TMailing = Class(TGenericEntity)
  private
    Femail: String;
    FID: String;
    procedure setFemail(const Value: String);
    procedure setFID(const Value: String);



  public
    [KeyField('id')]
    [FieldName('id')]
    property Codigo: String read FID write setFID;

    [FieldName('email')]
    property Email: String read Femail write setFemail;

  End;

implementation


{ TMailing }

procedure TMailing.setFemail(const Value: String);
begin
  Femail := Value;
end;

procedure TMailing.setFID(const Value: String);
begin
  FID := Value;
end;

end.

