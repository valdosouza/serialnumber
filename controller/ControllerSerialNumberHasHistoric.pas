unit ControllerSerialNumberHasHistoric;


interface

uses System.Classes, System.SysUtils,BaseController,
      tblSerialNumberHasHistoric,FireDAC.Comp.Client, FireDAC.Stan.Param;


Type

  TControllerSerialNumberHasHistoric = Class(TBaseController)
    procedure clear;
  private

  public
    Registro    : TSerialNumberHasHistoric;
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    function    insert:boolean;
    function    update:boolean;
    function    getByKey:Boolean;
    function    getBySerialNumber:Boolean;
    function    delete: boolean;
  End;

implementation

{ TControllerSerialNumberHasHistoric }

procedure TControllerSerialNumberHasHistoric.clear;
begin
  clearObj(Registro);
end;

constructor TControllerSerialNumberHasHistoric.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := TSerialNumberHasHistoric.Create;
end;

function TControllerSerialNumberHasHistoric.delete: boolean;
begin
  try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  end;
end;

destructor TControllerSerialNumberHasHistoric.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerSerialNumberHasHistoric.getByKey: Boolean;
begin
  _getByKey(Registro);
  Result := True;
end;

function TControllerSerialNumberHasHistoric.getBySerialNumber: Boolean;
Var
  Lc_Qry :TFDQuery;
begin
  Lc_Qry := createQuery;
  Result := True;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'Select * ' ,
                'from tb_serial_number_has_historic ',
                'where tb_serial_number_id =:tb_serial_number_id '
      ));
      paramByName('tb_serial_number_id').AsString := Registro.SerialNumberId;
      active := True;
      FetchAll;
      exist := RecordCount > 0;
      if exist then
        get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerSerialNumberHasHistoric.insert: boolean;
begin
  try
    Registro.Codigo := getNext;
    insertObj(Registro);
    Result := True;
  Except
    Result := False;
  end;

end;

function TControllerSerialNumberHasHistoric.update: boolean;
begin
  try
    updateObj(Registro);
    Result := True;
  Except
    Result := False;
  end;
end;

end.

