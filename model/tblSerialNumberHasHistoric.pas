unit tblSerialNumberHasHistoric;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;
Type
  //nome da classe de entidade
  [TableName('tb_serial_number_has_historic')]
  TSerialNumberHasHistoric = Class(TGenericEntity)
  private
    Fdescription: String;
    Fid: String;
    Ftb_serial_number_id: String;
    FStatus: String;
    Ftb_user_id: String;
    procedure setFdescription(const Value: String);
    procedure setFid(const Value: String);
    procedure setFStatus(const Value: String);
    procedure setFtb_serial_number_id(const Value: String);
    procedure setFtb_user_id(const Value: String);

  public
    [KeyField('id')]
    [FieldName('id')]
    property Codigo: String read Fid write setFid;

    [KeyField('tb_serial_number_id')]
    [FieldName('tb_serial_number_id')]
    property SerialNumberId: String read Ftb_serial_number_id write setFtb_serial_number_id;

    [FieldName('tb_user_id')]
    property Usuario: String read Ftb_user_id write setFtb_user_id;

    [FieldName('Status')]
    property Situacao: String read FStatus write setFStatus;

    [FieldName('description')]
    property Descricao: String read Fdescription write setFdescription;


  End;

implementation

{ TSerialNumberHasHistoric }

procedure TSerialNumberHasHistoric.setFdescription(const Value: String);
begin
  Fdescription := Value;
end;

procedure TSerialNumberHasHistoric.setFid(const Value: String);
begin
  Fid := Value;
end;

procedure TSerialNumberHasHistoric.setFStatus(const Value: String);
begin
  FStatus := Value;
end;

procedure TSerialNumberHasHistoric.setFtb_serial_number_id(const Value: String);
begin
  Ftb_serial_number_id := Value;
end;

procedure TSerialNumberHasHistoric.setFtb_user_id(const Value: String);
begin
  Ftb_user_id := Value;
end;

end.
