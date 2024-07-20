unit tblInstitutionHasUser;

interface

Uses GenericEntity,GenericOrm,CAtribEntity, System.Classes, System.SysUtils;
Type
  //nome da classe de entidade
  [TableName('tb_institution_has_User')]
  TInstitutionHasUser = Class(TGenericEntity)
  private
    Factive: String;
    FTb_institution_id: String;
    Ftb_user_id: String;
    Fkind: String;
    procedure setFactive(const Value: String);
    procedure setFkind(const Value: String);
    procedure setFTb_institution_id(const Value: String);
    procedure setFtb_user_id(const Value: String);

  public
    [FieldName('tb_institution_id')]
    [KeyField('tb_institution_id')]
    property Estabelecimento: String read FTb_institution_id write setFTb_institution_id;

    [FieldName('tb_user_id')]
    [KeyField('tb_user_id')]
    property Usuario: String read Ftb_user_id write setFtb_user_id;

    [FieldName('kind')]
    property Tipo: String read Fkind write setFkind;

    [FieldName('active')]
    property Ativo: String read Factive write setFactive;

  End;

implementation
{ TInstitutionHasUser }

procedure TInstitutionHasUser.setFactive(const Value: String);
begin
  Factive := Value;
end;

procedure TInstitutionHasUser.setFkind(const Value: String);
begin
  Fkind := Value;
end;

procedure TInstitutionHasUser.setFTb_institution_id(const Value: String);
begin
  FTb_institution_id := Value;
end;

procedure TInstitutionHasUser.setFtb_user_id(const Value: String);
begin
  Ftb_user_id := Value;
end;

end.
