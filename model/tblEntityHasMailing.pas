unit tblEntityHasMailing;

interface

Uses GenericEntity,GenericOrm,CAtribEntity, System.Classes, System.SysUtils;
Type
  //nome da classe de entidade
  [TableName('tb_entity_has_mailing')]
  TEntityHasMailing = Class(TGenericEntity)
  private
    Ftb_entity_id: String;
    Ftb_mailing_id: String;
    Ftb_mailing_group_id: String;
    procedure setFtb_entity_id(const Value: String);
    procedure setFtb_mailing_group_id(const Value: String);
    procedure setFtb_mailing_id(const Value: String);

  public
    [FieldName('tb_entity_id')]
    [KeyField('tb_entity_id')]
    property Entidade: String read Ftb_entity_id write setFtb_entity_id;

    [FieldName('tb_mailing_id')]
    [KeyField('tb_mailing_id')]
    property Mailing: String read Ftb_mailing_id write setFtb_mailing_id;

    [FieldName('tb_mailing_group_id')]
    [KeyField('tb_mailing_group_id')]
    property Grupo: String read Ftb_mailing_group_id write setFtb_mailing_group_id;

  End;

implementation
{ TEntityHasMailing }

procedure TEntityHasMailing.setFtb_entity_id(const Value: String);
begin
  Ftb_entity_id := Value;
end;

procedure TEntityHasMailing.setFtb_mailing_group_id(const Value: String);
begin
  Ftb_mailing_group_id := Value;
end;

procedure TEntityHasMailing.setFtb_mailing_id(const Value: String);
begin
  Ftb_mailing_id := Value;
end;

end.
