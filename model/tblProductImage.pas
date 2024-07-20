unit tblProductImage;

interface

Uses GenericEntity,CAtribEntity, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_product_image')]
  TProductImage = Class(TGenericEntity)
  private
    Ftb_product_id: String;
    FId: String;
    Ftb_institution_id: String;
    procedure setFId(const Value: String);
    procedure setFtb_institution_id(const Value: String);
    procedure setFtb_product_id(const Value: String);

  public
    [KeyField('id')]
    [FieldName('id')]
    property Codigo: String read FId write setFId;

    [FieldName('tb_institution_id')]
    property Estabelecimento: String read Ftb_institution_id write setFtb_institution_id;

    [FieldName('tb_product_id')]
    property Produto: String read Ftb_product_id write setFtb_product_id;

  End;

implementation

{ TProductImage }

procedure TProductImage.setFId(const Value: String);
begin
  FId := Value;
end;

procedure TProductImage.setFtb_institution_id(const Value: String);
begin
  Ftb_institution_id := Value;
end;

procedure TProductImage.setFtb_product_id(const Value: String);
begin
  Ftb_product_id := Value;
end;

end.
