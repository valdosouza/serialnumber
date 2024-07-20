unit tblPrivilege;

interface

Uses GenericEntity,GenericOrm,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_privilege')]
  TPrivilege = Class(TGenericEntity)
  private
    FAtivo: String;
    Fdescription: String;
    FId: String;
    procedure setFAtivo(const Value: String);
    procedure setFdescription(const Value: String);
    procedure setFId(const Value: String);
  public
    [FieldName('id')]
    [KeyField('id')]
    property Codigo: String read FId write setFId;

    [FieldName('description')]
    property Descricao: String read Fdescription write setFdescription;

    property Ativo: String read FAtivo write setFAtivo;
  End;
implementation


{ TPrivilege }

procedure TPrivilege.setFAtivo(const Value: String);
begin
  FAtivo := Value;
end;

procedure TPrivilege.setFdescription(const Value: String);
begin
  Fdescription := Value;
end;

procedure TPrivilege.setFId(const Value: String);
begin
  FId := Value;
end;


end.
