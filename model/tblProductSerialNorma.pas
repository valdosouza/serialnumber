unit tblProductSerialNorma;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;
Type
  //nome da classe de entidade
  [TableName('tb_product_serial_norma')]
  TProductSerialNorma = Class(TGenericEntity)
  private
    Ftb_product_id: String;
    Fpart_number: String;
    Fnorma_id: String;
    Ftb_institution_id: String;
    procedure setFnorma_id(const Value: String);
    procedure setFpart_number(const Value: String);
    procedure setFtb_institution_id(const Value: String);
    procedure setFtb_product_id(const Value: String);

  public

    [KeyField('tb_institution_id')]
    [FieldName('tb_institution_id')]
    property Estabelecimento: String read Ftb_institution_id write setFtb_institution_id;

    [KeyField('tb_product_id')]
    [FieldName('tb_product_id')]
    property Produto: String read Ftb_product_id write setFtb_product_id;

    [KeyField('norma_id')]
    [FieldName('norma_id')]
    property CodeNorma: String read Fnorma_id write setFnorma_id;

    [KeyField('part_number')]
    [FieldName('part_number')]
    property ParNumber: String read Fpart_number write setFpart_number;
  End;

implementation

{ TProductSerialNorma }


procedure TProductSerialNorma.setFnorma_id(const Value: String);
begin
  Fnorma_id := Value;
end;

procedure TProductSerialNorma.setFpart_number(const Value: String);
begin
  Fpart_number := Value;
end;

procedure TProductSerialNorma.setFtb_institution_id(const Value: String);
begin
  Ftb_institution_id := Value;
end;

procedure TProductSerialNorma.setFtb_product_id(const Value: String);
begin
  Ftb_product_id := Value;
end;

end.
