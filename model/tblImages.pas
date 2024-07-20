unit tblImages;

interface

Uses GenericEntity,GenericOrm,CAtribEntity, Classes, SysUtils;
Type
  //nome da classe de entidade
  [TableName('tb_images')]
  TImages = Class(TGenericEntity)
  private
    Ftb_entity_id: String;
    Fsequence: Integer;
    Ffile_name: String;
    Ftb_institution_id: String;
    Falbum: String;
    procedure setFalbum(const Value: String);
    procedure setFfile_name(const Value: String);
    procedure setFsequence(const Value: Integer);
    procedure setFtb_entity_id(const Value: String);
    procedure setFtb_institution_id(const Value: String);


  public
    [KeyField('tb_institution_id')]
    [FieldName('tb_institution_id')]
    property Estabelecimento: String read Ftb_institution_id write setFtb_institution_id;

    [KeyField('album')]
    [FieldName('album')]
    property Album: String read Falbum write setFalbum;

    [KeyField('file_name')]
    [FieldName('file_name')]
    property NomeArquivo: String read Ffile_name write setFfile_name;

    [FieldName('tb_entity_id')]
    property Entidade: String read Ftb_entity_id write setFtb_entity_id;

    [FieldName('sequence')]
    property Sequencia: Integer read Fsequence write setFsequence;

  End;

implementation

{ TImages }

procedure TImages.setFalbum(const Value: String);
begin
  Falbum := Value;
end;

procedure TImages.setFfile_name(const Value: String);
begin
  Ffile_name := Value;
end;

procedure TImages.setFsequence(const Value: Integer);
begin
  Fsequence := Value;
end;

procedure TImages.setFtb_entity_id(const Value: String);
begin
  Ftb_entity_id := Value;
end;

procedure TImages.setFtb_institution_id(const Value: String);
begin
  Ftb_institution_id := Value;
end;

end.
