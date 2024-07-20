unit tblSerialNumber;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;
Type
  //nome da classe de entidade
  [TableName('tb_serial_number')]
  TSerialNumber = Class(TGenericEntity)
  private
    Ftb_product_id: String;
    Fid: String;
    FNumber: String;
    Ftb_institution_id: String;
    Fsequence: Integer;
    Fstandard_used: String;
    procedure setFid(const Value: String);
    procedure setFNumber(const Value: String);
    procedure setFtb_institution_id(const Value: String);
    procedure setFtb_product_id(const Value: String);
    procedure setFsequence(const Value: Integer);
    procedure setFstandard_used(const Value: String);


  public
    [KeyField('id')]
    [FieldName('id')]
    property Codigo: String read Fid write setFid;

    [FieldName('tb_institution_id')]
    property Estabelecimento: String read Ftb_institution_id write setFtb_institution_id;

    [FieldName('tb_product_id')]
    property Produto: String read Ftb_product_id write setFtb_product_id;

    [FieldName('number')]
    property Number: String read FNumber write setFNumber;


    [FieldName('standard_used')]
    property PadraoUtilizado: String read Fstandard_used write setFstandard_used;

    [FieldName('sequence')]
    property Sequencia: Integer read Fsequence write setFsequence;

  End;

implementation

{ TSerialNumber }

procedure TSerialNumber.setFid(const Value: String);
begin
  Fid := Value;
end;

procedure TSerialNumber.setFNumber(const Value: String);
begin
  FNumber := Value;
end;

procedure TSerialNumber.setFsequence(const Value: Integer);
begin
  Fsequence := Value;
end;

procedure TSerialNumber.setFstandard_used(const Value: String);
begin
  Fstandard_used := Value;
end;

procedure TSerialNumber.setFtb_institution_id(const Value: String);
begin
  Ftb_institution_id := Value;
end;

procedure TSerialNumber.setFtb_product_id(const Value: String);
begin
  Ftb_product_id := Value;
end;

end.
