unit ControllerSerialNumber;


interface

uses System.Classes, System.SysUtils,BaseController,
     tblSerialNumber,FireDAC.Comp.Client, FireDAC.Stan.Param,
     ControllerSerialNumberHasHistoric, ControllerProductSerialNorma,
     System.StrUtils, ControllerProduct,System.DateUtils, Vcl.Dialogs;

Type

  TControllerSerialNumber = Class(TBaseController)
    procedure clear;
  private
    FProduct : TControllerProduct;
    FSerialSH: String;
    FSerialLN: String;
    function GeraSerial:String;

    function GetPartNumber:String;
    function GetPartNumberNoNorma:String;
    function GetPartNumberPF_901106:String;
    function GetPartNumberFPW_PTTSTR:String;


    function getDiaAnoJuliano:String;
    function GetSequence : Integer;
    procedure setFSerialLN(const Value: String);
    procedure setFSerialSH(const Value: String);


  public
    Registro    : TSerialNumber;
    Historico : TControllerSerialNumberHasHistoric;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function insert:boolean;
    function getByKey:Boolean;
    function getBySerialnumber:Boolean;
    function delete: boolean;
    property SerialSH : String read FSerialSH write setFSerialSH;
    property SerialLN : String read FSerialLN write setFSerialLN;

  End;

implementation

{ TControllerSerialNumber }

uses UnFunctions;


procedure TControllerSerialNumber.clear;
begin
  clearObj(Registro);
  Historico.clear;
end;

constructor TControllerSerialNumber.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := TSerialNumber.Create;
  Historico := TControllerSerialNumberHasHistoric.Create(self);
  FProduct  := TControllerProduct.Create(self);
end;

function TControllerSerialNumber.delete: boolean;
begin
  try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  end;
end;

destructor TControllerSerialNumber.Destroy;
begin
  FreeAndNil(FProduct);
  FreeAndNil(Historico);
  FreeAndNil(Registro);
  inherited;
end;

function TControllerSerialNumber.GeraSerial: String;
Var
  Lc_vetor_Mascara : TArray<string>;
  I : Integer;
  Lc_Numero : String;
begin
  FProduct.Registro.Estabelecimento := Registro.Estabelecimento;
  FProduct.Registro.Codigo          := Registro.Produto;
  FProduct.getByKey;
  FProduct.Norma.Registro.Estabelecimento := Registro.Estabelecimento;
  FProduct.Norma.Registro.Produto  :=  Registro.Produto;
  FProduct.Norma.getList;

  Lc_vetor_Mascara := FProduct.Registro.MascaraPadrao.Split(['+']);
  Lc_Numero := '';
  for I := 0 to High(Lc_vetor_Mascara) do
  Begin
    //PN: Part Number
    if Lc_vetor_Mascara[I] = 'PN' then
      Lc_Numero := concat(Lc_Numero, GetPartNumber);

    //CF:  Código do Fornecedor Metalkraft no cliente
    if Lc_vetor_Mascara[I] = 'CF' then
      Lc_Numero := concat(Lc_Numero,FProduct.Registro.referencia);

    //CJ:  Dia e ano no calendário Juliano
    if Lc_vetor_Mascara[I] = 'CJ' then
      Lc_Numero := concat(Lc_Numero,getDiaAnoJuliano);

    //SQ: Sequencial
    if Lc_vetor_Mascara[I] = 'SQ' then
      Lc_Numero := concat(Lc_Numero,StrZero(Registro.Sequencia,5,0));

    //T1: Um texto fixo que faça parte do número serial.
    if Lc_vetor_Mascara[I] = 'T1' then
      Lc_Numero := concat(Lc_Numero, FProduct.Registro.T1);

    //T2: Um segundo texto fixo que faça parte do número serial
    if Lc_vetor_Mascara[I] = 'T2' then
      Lc_Numero := concat(Lc_Numero,FProduct.Registro.T2);

    //RD: A revisão do desenho do Produto
    if Lc_vetor_Mascara[I] = 'RD' then
      Lc_Numero := concat(Lc_Numero,FProduct.Registro.RD);

    //SH: o turno de fabricação (SHIFT)
    if Lc_vetor_Mascara[I] = 'SH' then
      Lc_Numero := concat(Lc_Numero,FSerialSH);

    //LN: Linha de Produção do Produto
    if Lc_vetor_Mascara[I] = 'LN' then
      Lc_Numero := concat(Lc_Numero,FSerialLN);
  End;
  Result := Lc_Numero;
end;

function TControllerSerialNumber.GetPartNumber: String;
Var
  Lc_norma_id : String;
begin
  with FProduct do
  Begin
    Norma.Registro.Estabelecimento  := FProduct.Registro.Estabelecimento;
    Norma.Registro.Produto          := FProduct.Registro.Codigo;
    Lc_norma_id := Norma.getNorma;

    case AnsiIndexStr(UpperCase(Trim(Lc_norma_id)), ['NÃO INFORMADA', 'PF.901106','FPW.PTTSTR']) of
      0:Result := GetPartNumberNoNorma;     //NÃO INFORMADA
      1:Result := GetPartNumberPF_901106;   //PF.901106
      2:Result := GetPartNumberFPW_PTTSTR;  //FPW.PTTSTR
      else
        Result := GetPartNumberNoNorma;     //NÃO INFORMADA
    end;
  End;
end;

function TControllerSerialNumber.GetPartNumberFPW_PTTSTR: String;
begin
  with FProduct do
  Begin
    Norma.Registro.Estabelecimento := Registro.Estabelecimento;
    Norma.Registro.Produto         := Registro.Codigo;
    Norma.getList;
    Result := concat(
                  Norma.Lista[1].ParNumber, //nafta
                  Norma.Lista[0].ParNumber //latam
              );
  End;
end;

function TControllerSerialNumber.GetPartNumberNoNorma: String;
begin
  with FProduct do
  Begin
    Result :=  Norma.Registro.ParNumber;
  End;
end;

function TControllerSerialNumber.GetPartNumberPF_901106: String;
begin
  with FProduct do
  Begin
    Norma.Registro.Estabelecimento := Registro.Estabelecimento;
    Norma.Registro.Produto         := Registro.Codigo;
    Norma.getList;
    Result :=  Norma.Lista[0].ParNumber;
  End;
end;

function TControllerSerialNumber.getByKey: Boolean;
begin
  Result := True;
  _getByKey(Registro);
end;

function TControllerSerialNumber.getBySerialnumber: Boolean;
Var
  Lc_Qry : TFDquery;
begin
  Lc_Qry := createQuery;
  Result := True;
  try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'select * ',
                'from tb_serial_number ',
                'where (number =:number) '
      ));
      ParamByName('number').AsString := Registro.Number;
      Active := True;
      FetchAll;
      exist := RecordCount >0;
      if exist then
        get(Lc_Qry,Registro);
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;


function TControllerSerialNumber.getDiaAnoJuliano: String;
var
  DiaJuliano: Integer;
  Ano: String;
  Lc_data : TDate;

begin
  Lc_data := getDataSQLServer;
  Ano := IntToStr(YearOf(Lc_data));
  Ano := Copy(Ano,3,2);
  diaJuliano := DayOfTheYear(Lc_data);
  Result := concat(IntToStr(DiaJuliano),Ano);

end;


function TControllerSerialNumber.GetSequence: Integer;
Var
  Lc_Qry : TFDquery;
begin
  Lc_Qry := createQuery;
  try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                  'select max(sequence) seqMax ',
                  'from tb_serial_number ',
                  'where ( tb_institution_id =:tb_institution_id) ',
                  ' and (tb_product_id =:tb_product_id)'
      ));
      ParamByName('tb_institution_id').AsString := Registro.Estabelecimento;
      ParamByName('tb_product_id').AsString := Registro.Produto;
      Active := True;
      FetchAll;
      Result := StrToIntDef(FieldByName('seqMax').AsString,0) + 1;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerSerialNumber.insert: boolean;
begin
  Registro.Codigo    := getNext;
  Registro.Sequencia := GetSequence;
  Registro.Number    := GeraSerial;
  try
    insertObj(Registro);
    Result := True;
  Except
    Result := False;
  end;

end;

procedure TControllerSerialNumber.setFSerialLN(const Value: String);
begin
  FSerialLN := Value;
end;

procedure TControllerSerialNumber.setFSerialSH(const Value: String);
begin
  FSerialSH := Value;
end;

end.
