unit BaseController;

interface

uses System.Classes,System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param,
    System.Generics.Collections,GenericOrm, FireDAC.DApt ,
    FireDAC.UI.Intf,  FireDAC.Comp.UI, Vcl.Forms;

Type

  TBaseController = Class(TComponent)
  private

  protected
    function clearObj<T: class>(Obj: T):Boolean;
    function insertObj<T: class>(Obj: T):Boolean;
    function updateObj<T: class>(Obj: T):Boolean;
    function deleteObj<T: class>(Obj: T):Boolean;
    procedure SaveObj<T: class>(Obj: T);
    function getLastInsert<T: class>(Obj: T):Integer;
    function getNext:String;
    function getNextByField<T: class>(Obj: T; Field: String;Institution: String): String;
    function getByField(strTable:String;field:String; Content:String):TFDQuery;
    procedure _assign<T: class>(ObjOri: T;ObjClone: T);
    procedure _getByKey<T: class>(Obj: T);

    function existObj<T: class>(Obj: T):Boolean;

    procedure get<T: class>(Qry: TFdQuery;Obj: T);
    function dataMysql(data:String) : String;

    function execcmd(sql:STring):Boolean;
  public
    exist : Boolean;
    orderby : String;
    function createQuery(): TFDQuery;Virtual;
    procedure FinalizaQuery(Qry:TFDQuery);Virtual;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GeneratePrimaryKey:string;
    function setOrderBy:String;
    Function ConverteDataMysql(Data:TDateTime) : String;
    procedure ClonarObj<T: class>(ObjOri: T;ObjClone: T);
    function getDataSQLServer:TDateTime;
    Procedure geralog(origem,msg : string);
  End;

implementation

uses
   un_dm, unFunctions;


{ TBaseController }

function TBaseController.clearObj<T>(Obj: T): Boolean;
begin
  Try
    TGenericOrm._Clear(Obj);
    Result := True;
  except
    Result := False;
  End;
end;


procedure TBaseController.ClonarObj<T>(ObjOri, ObjClone: T);
begin
  TGenericOrm._assign(ObjOri,ObjClone);
end;

function TBaseController.ConverteDataMysql(Data: TDateTime): String;
Var
  Lc_Dia,Lc_Mes, Lc_Ano, Lc_Hora : String;
  Lc_data :String;

begin
  Result := '1900-01-01 01:00:00';
  Lc_data := DateTimeToStr(Data);
  if trim(Lc_data) <> '' then
  Begin
    if (Pos('-',Lc_data) > 0) then
    Begin
       Result := Lc_data ;
    End
    else
    if (Pos('/',Lc_data) > 0) then
    Begin
      //01/01/2016 00:00:01
      Lc_Dia  := Copy(Lc_data,1,2);
      Lc_Mes  := Copy(Lc_data,4,2);
      Lc_Ano  := Copy(Lc_data,7,4);
      Lc_Hora := Copy(Lc_data,12,8);
      Result := concat(Lc_Ano,'-',Lc_Mes,'-',Lc_Dia,' ', Lc_Hora);
    End
  End;
end;

constructor TBaseController.Create(AOwner: TComponent);
begin
  inherited;
  orderby := '';
end;

destructor TBaseController.Destroy;
begin
  inherited; //- quando ativa aparece invalida operator
end;



function TBaseController.execcmd(sql: STring): Boolean;
Var
  Lc_Qry : TFDQuery;
begin
  Lc_Qry := createQuery;
  try
    Result := True;
    Lc_Qry.SQL.Add( sql );
    Lc_Qry.Prepare;
    Lc_Qry.ExecSQL;
    FinalizaQuery(Lc_Qry);
  finally

  end;
end;

function TBaseController.existObj<T>(Obj: T): Boolean;
Var
  Lc_Qry : TFDQuery;
begin
  Lc_Qry := createQuery;
  try
    try
      Lc_Qry.SQL.Clear;
      Lc_Qry.SQL.Add (TGenericOrm._Select(Obj,''));
      Lc_Qry.Prepare;
      Lc_Qry.Active := True;
      Lc_Qry.FetchAll;
      result := ( Lc_Qry.RecordCount > 0 );
    Except
      on E: Exception do
        geralog('Base - existObj - ',concat(E.Message,' - SQL: ',Lc_Qry.SQL.text) );
    end;
  finally
    Lc_Qry.Unprepare;
    FinalizaQuery(Lc_Qry);
  end;
end;

procedure TBaseController.FinalizaQuery(Qry: TFDQuery);
begin
  Qry.Transaction.Commit;
  Qry.Transaction.DisposeOf;
  Qry.Close;
  Qry.DisposeOf;
end;

function TBaseController.GeneratePrimaryKey: string;
begin
  Result := TGUID.Empty.NewGuid.ToString;
  Result := RemoveCaracterInformado(Result,['}','{','-']);
end;

function TBaseController.createQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  try
    //Result.UpdateOptions.RequestLive := False;
    Result.Connection := DM.FDConnection;
    REsult.Transaction := TFDTransaction.Create(Result);
    REsult.Transaction.Connection := DM.FDConnection;
    REsult.Transaction.StartTransaction;
  Except
    on E: Exception do
     geralog('Base - createQuery - ',E.Message);
  end;
end;

procedure TBaseController.geralog(origem,msg : string);
begin
  exit;
  TGenericOrm._geralog(origem,msg);
end;

procedure TBaseController.get<T>(Qry: TFDQuery; Obj: T);
begin
  clearObj(Obj);
  TGenericOrm._get(Qry,Obj);
end;

function TBaseController.getByField(strTable:String;field, Content: String): TFDQuery;
var
  vSelect: string;
begin
  Result := createQuery;
  with Result do
  begin
    Active := False;
    SQL.Clear;
    vSelect := Format('Select * from %s where ( %s = :%s ) ',[strTable, Field, Field]);
    SQL.Add(vSelect);
    ParamByName(Field).Value := Content;
    Prepare;
    active := True;
    FetchAll;
    exist := (RecordCount > 0);
  end;
end;

function TBaseController.getDataSQLServer: TDateTime;
VAr
  Lc_Qry : TFdQuery;
begin
  Lc_Qry := createQuery;
  Try
    Lc_Qry.SQL.Clear;
    Lc_Qry.SQL.Add('SELECT GETDATE() AS CurrentDateTime;');
    Lc_Qry.Prepare;
    Lc_Qry.Active := True;
    Lc_Qry.FetchAll;
    Result := Lc_Qry.FieldByName('CurrentDateTime').asdateTime;
  Finally
    Lc_Qry.Unprepare;
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TBaseController.SaveObj<T>(Obj: T);
begin
  if existObj(Obj)  then
    updateObj(Obj)
  else
    InsertObj(Obj);
end;

function TBaseController.setOrderBy: String;
begin
  if Trim(orderby)<>'' then
    Result := concat(' ORDER BY ', orderby,' asc  ')
end;

procedure TBaseController._assign<T>(ObjOri, ObjClone: T);
begin
  TGenericOrm._assign(ObjOri,ObjClone);
end;

procedure TBaseController._getByKey<T>(Obj: T);
VAr
  Lc_Qry : TFdQuery;
begin
  Lc_Qry := createQuery;
  Try
    try
      Lc_Qry.SQL.Clear;
      Lc_Qry.SQL.Add (TGenericOrm._Select(Obj,''));
      Lc_Qry.Prepare;
      Lc_Qry.Active := True;
      Lc_Qry.FetchAll;
      exist  := ( Lc_Qry.RecordCount > 0 );
      if exist then TGenericOrm._get(Lc_Qry,Obj) ;
    Except
      on E: Exception do
      geralog('Base - _getByKey',concat(E.Message,' - SQL: ',Lc_Qry.SQL.text) );
    end;
  Finally
    Lc_Qry.Unprepare;
    FinalizaQuery(Lc_Qry);
  End;
end;

function TBaseController.getLastInsert<T>(Obj: T): Integer;
Var
  Lc_Qry : TFDQuery;
begin
  Lc_Qry := createQuery;
  try
    try
      Lc_Qry.SQL.Clear;
      Lc_Qry.SQL.Add ( TGenericOrm._getLastInsert( Obj ) );
      Lc_Qry.Prepare;
      Lc_Qry.Active := True;
      Result := StrToIntDef(Lc_Qry.FieldByName('id').AsString,0);
    Except on E: Exception do
        geralog('Base - getLastInsert - ',concat(E.Message,'SQL: ',Lc_Qry.SQL.text) );
    end;
  finally
    Lc_Qry.Unprepare;
    FinalizaQuery(Lc_Qry);
  end;
end;


function TBaseController.getNext: String;
begin
  Result := LowerCase(Copy(TGUID.NewGuid.ToString(),2,36));
end;

function TBaseController.getNextByField<T>(Obj: T; Field: String;
  Institution: String): String;
Var
  Lc_Qry : TFDQuery;
begin
  Lc_Qry := createQuery;
  try
    try
      Lc_Qry.SQL.Clear;
      Lc_Qry.SQL.Add ( TGenericOrm._getNextByField( Obj,Field, Institution));
      Lc_Qry.Prepare;
      Lc_Qry.Active := True;
      Result := ( Lc_Qry.FieldByName(Field).AsString);
    Except
      on E: Exception do
        geralog('Base - getNextByField - ',concat(E.Message,'SQL: ',Lc_Qry.SQL.text) );
    end;
  finally
    Lc_Qry.Unprepare;
    FinalizaQuery(Lc_Qry);
  end;

end;

function TBaseController.insertObj<T>(Obj: T):Boolean;
Var
  LcSql : String;
  Lc_Qry :TFDQuery;
begin
  Lc_Qry := createQuery;
  Try
    LcSql := TGenericOrm._Insert(Obj);
    try
      Lc_Qry.SQL.Add(LcSql);
      Lc_Qry.ExecSQL;
    Except
      on E: Exception do
        geralog('Base - insertObj - ',concat(E.Message,'SQL: ',LcSql) );
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
End;


function TBaseController.updateObj<T>(Obj: T):Boolean;
Var
  LcSql : String;
  Lc_Qry :TFDQuery;
begin
  Lc_Qry := createQuery;
  Try
    try
      LcSql := TGenericOrm._Update(Obj);
      Lc_Qry.SQL.Add( LcSql);
      Lc_Qry.ExecSQL;
    Except
      on E: Exception do
      geralog('Base - updateObj - ',concat(E.Message,'SQL: ',LcSql) );
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
End;

function TBaseController.dataMysql(Data: String): String;
Var
  Lc_Dia,Lc_Mes, Lc_Ano, Lc_Hora : String;
begin
  Result := '1900-01-01 01:00:00';
  if trim(data) <> '' then
  Begin
    if (Pos('-',data) > 0) then
    Begin
       Result := Data ;
    End
    else
    if (Pos('/',data) > 0) then
    Begin
      //01/01/2016 00:00:01
      Lc_Dia  := Copy(data,1,2);
      Lc_Mes  := Copy(data,4,2);
      Lc_Ano  := Copy(data,7,4);
      Lc_Hora := Copy(data,12,8);
      Result := concat(Lc_Ano,'-',Lc_Mes,'-',Lc_Dia,' ', Lc_Hora);
    End
  End;

end;

function TBaseController.deleteObj<T>(Obj: T):Boolean;
Var
  LcSql : String;
  Lc_Qry :TFDQuery;
begin
  Lc_Qry := createQuery;
  Try
    LcSql := TGenericOrm._Delete(Obj) ;
    try
      Lc_Qry.SQL.Add(LcSql);
      Lc_Qry.ExecSQL;
    Except
      on E: Exception do
        geralog('Base - deleteObj - ',concat(E.Message,'SQL: ',LcSql) );
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;



end.

