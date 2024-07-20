unit tblEntity;

interface

Uses GenericEntity,CAtribEntity, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_entity')]
  TEntity = Class(TGenericEntity)
  private
    FNote: String;
    FID: String;
    FNickTrade: String;
    FNameCompany: String;
    procedure setFID(const Value: String);
    procedure setFNameCompany(const Value: String);
    procedure setFNickTrade(const Value: String);
    procedure setFNote(const Value: String);

  public
    [KeyField('id')]
    [FieldName('id')]
    property Codigo: String read FID write setFID;

    [FieldName('name_company')]
    property NomeRazao: String read FNameCompany write setFNameCompany;

    [FieldName('nick_trade')]
    property ApelidoFantasia: String read FNickTrade write setFNickTrade;

    [FieldName('note')]
    property Observacao: String read FNote write setFNote;

  End;

implementation
{ TEntity }

procedure TEntity.setFID(const Value: String);
begin
  FID := Value;
end;

procedure TEntity.setFNameCompany(const Value: String);
begin
  FNameCompany := Value;
end;

procedure TEntity.setFNickTrade(const Value: String);
begin
  FNickTrade := Value;
end;

procedure TEntity.setFNote(const Value: String);
begin
  FNote := Value;
end;

end.
