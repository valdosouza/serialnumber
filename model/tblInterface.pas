unit tblInterface;

interface

Uses GenericEntity,GenericOrm,CAtribEntity, System.Classes, System.SysUtils;
Type
  //nome da classe de entidade
  [TableName('tb_interface')]
  Tinterface = Class(TGenericEntity)
  private
    Fimg_index: Integer;
    Fdescription: String;
    FId: String;
    Fposition: String;
    Facao_botao: String;
    Fkind: String;
    procedure setFacao_botao(const Value: String);
    procedure setFdescription(const Value: String);
    procedure setFId(const Value: String);
    procedure setFimg_index(const Value: Integer);
    procedure setFkind(const Value: String);
    procedure setFposition(const Value: String);

  public
    [FieldName('id')]
    [KeyField('id')]
    property Codigo: String read FId write setFId;

    [FieldName('description')]
    property Descricao: String read Fdescription write setFdescription;

    [FieldName('kind')]
    property Tipo: String read Fkind write setFkind;

    [FieldName('position')]
    property Posicao: String read Fposition write setFposition;

    [FieldName('img_index')]
    property ImagemIndex: Integer read Fimg_index write setFimg_index;

    [FieldName('acao_botao')]
    property AcaoBotao: String read Facao_botao write setFacao_botao;

  End;
implementation

{ Tinterface }

procedure Tinterface.setFacao_botao(const Value: String);
begin
  Facao_botao := Value;
end;

procedure Tinterface.setFdescription(const Value: String);
begin
  Fdescription := Value;
end;

procedure Tinterface.setFId(const Value: String);
begin
  FId := Value;
end;

procedure Tinterface.setFimg_index(const Value: Integer);
begin
  Fimg_index := Value;
end;

procedure Tinterface.setFkind(const Value: String);
begin
  Fkind := Value;
end;

procedure Tinterface.setFposition(const Value: String);
begin
  Fposition := Value;
end;

end.
