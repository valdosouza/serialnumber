unit tblProduct;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;
Type
  //nome da classe de entidade
  [TableName('tb_product')]
  TProduct = Class(TGenericEntity)
  private
    Fnote: String;
    Factive: String;
    Fdescription: String;
    FId: String;
    Ftb_institution_id: String;
    Freference: String;
    Fmask_rd: String;
    Fmask_default: String;
    Fmask_t2: String;
    Fmask_t1: String;
    procedure setFactive(const Value: String);
    procedure setFdescription(const Value: String);
    procedure setFId(const Value: String);
    procedure setFnote(const Value: String);
    procedure setFtb_institution_id(const Value: String);
    procedure setFreference(const Value: String);
    procedure setFmask_default(const Value: String);
    procedure setFmask_rd(const Value: String);
    procedure setFmask_t1(const Value: String);
    procedure setFmask_t2(const Value: String);


  public
    [KeyField('id')]
    [FieldName('id')]
    property Codigo: String read FId write setFId;

    [KeyField('tb_institution_id')]
    [FieldName('tb_institution_id')]
    property Estabelecimento: String read Ftb_institution_id write setFtb_institution_id;

    [FieldName('description')]
    property Descricao: String read Fdescription write setFdescription;

    [FieldName('reference')]
    property referencia: String read Freference write setFreference;

    [FieldName('mask_t1')]
    property T1: String read Fmask_t1 write setFmask_t1;

    [FieldName('mask_t2')]
    property T2: String read Fmask_t2 write setFmask_t2;

    [FieldName('mask_rd')]
    property RD: String read Fmask_rd write setFmask_rd;

    [FieldName('mask_default')]
    property MascaraPadrao: String read Fmask_default write setFmask_default;

    [FieldName('active')]
    property Ativo: String read Factive write setFactive;

    [FieldName('note')]
    property Observaocao: String read Fnote write setFnote;

  End;


implementation


{ TProduct }

procedure TProduct.setFactive(const Value: String);
begin
  Factive := Value;
end;

procedure TProduct.setFdescription(const Value: String);
begin
  Fdescription := Value;
end;

procedure TProduct.setFId(const Value: String);
begin
  FId := Value;
end;

procedure TProduct.setFmask_default(const Value: String);
begin
  Fmask_default := Value;
end;

procedure TProduct.setFmask_rd(const Value: String);
begin
  Fmask_rd := Value;
end;

procedure TProduct.setFmask_t1(const Value: String);
begin
  Fmask_t1 := Value;
end;

procedure TProduct.setFmask_t2(const Value: String);
begin
  Fmask_t2 := Value;
end;

procedure TProduct.setFnote(const Value: String);
begin
  Fnote := Value;
end;

procedure TProduct.setFreference(const Value: String);
begin
  Freference := Value;
end;

procedure TProduct.setFtb_institution_id(const Value: String);
begin
  Ftb_institution_id := Value;
end;

end.
