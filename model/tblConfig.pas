unit tblConfig;

interface

Uses GenericEntity,GenericOrm,CAtribEntity, System.Classes, System.SysUtils;
Type
  //nome da classe de entidade
  [TableName('tb_config')]
  TConfig = Class(TGenericEntity)
  private
    Fcontent: String;
    Ffield: String;
    Ftb_institution_id: String;
    Ftb_user_id: String;
    procedure setFcontent(const Value: String);
    procedure setFfield(const Value: String);
    procedure setFtb_institution_id(const Value: String);
    procedure setFtb_user_id(const Value: String);

  public
    [KeyField('tb_institution_id')]
    [FieldName('tb_institution_id')]
    property Estabelecimento: String read Ftb_institution_id write setFtb_institution_id;

    [KeyField('field')]
    [FieldName('field')]
    property Campo: String read Ffield write setFfield;

    [FieldName('tb_user_id')]
    property Usuario: String read Ftb_user_id write setFtb_user_id;

    [FieldName('content')]
    property Conteudo: String read Fcontent write setFcontent;

  End;

implementation
{ TConfig }

procedure TConfig.setFcontent(const Value: String);
begin
  Fcontent := Value;
end;

procedure TConfig.setFfield(const Value: String);
begin
  Ffield := Value;
end;

procedure TConfig.setFtb_institution_id(const Value: String);
begin
  Ftb_institution_id := Value;
end;

procedure TConfig.setFtb_user_id(const Value: String);
begin
  Ftb_user_id := Value;
end;

end.

