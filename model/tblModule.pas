unit tblModule;


interface

Uses GenericEntity,GenericOrm,CAtribEntity, System.Classes, System.SysUtils;
Type
  //nome da classe de entidade
  [TableName('tb_module')]
  TModule = Class(TGenericEntity)
  private
    Fimg_index: Integer;
    Fdescription: String;
    FId: String;
    Facao_botao: String;
    Ftechnical_name: String;
    procedure setFacao_botao(const Value: String);
    procedure setFdescription(const Value: String);
    procedure setFId(const Value: String);
    procedure setFimg_index(const Value: Integer);
    procedure setFtechnical_name(const Value: String);
  public
    [FieldName('id')]
    [KeyField('id')]
    property Codigo: String read FId write setFId;

    [FieldName('description')]
    property Descricao: String read Fdescription write setFdescription;

    [FieldName('technical_name')]
    property NomeTecnico: String read Ftechnical_name write setFtechnical_name;

    [FieldName('img_index')]
    property ImagemIndex: Integer read Fimg_index write setFimg_index;

    [FieldName('acao_botao')]
    property AcaoBotao: String read Facao_botao write setFacao_botao;

  End;
implementation

{ TModule }

procedure TModule.setFacao_botao(const Value: String);
begin
  Facao_botao := Value;
end;

procedure TModule.setFdescription(const Value: String);
begin
  Fdescription := Value;
end;

procedure TModule.setFId(const Value: String);
begin
  FId := Value;
end;

procedure TModule.setFimg_index(const Value: Integer);
begin
  Fimg_index := Value;
end;

procedure TModule.setFtechnical_name(const Value: String);
begin
  Ftechnical_name := Value;
end;

end.
