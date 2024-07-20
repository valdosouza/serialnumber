unit ControllerProductSerialNorma;


interface

uses System.Classes, System.SysUtils,BaseController,
      tblProductSerialNorma,FireDAC.Comp.Client, FireDAC.Stan.Param,
      Generics.Collections;

Type
  TListaProductSerialNorma = TObjectList<TProductSerialNorma>;

  TControllerProductSerialNorma = Class(TBaseController)
  private

  public
    Registro : TProductSerialNorma;
    Lista : TListaProductSerialNorma;
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    function insert:boolean;
    function update:boolean;
    function save:boolean;
    function getByKey:Boolean;
    function delete: boolean;
    function deleteByProduto: boolean;
    function getList:Boolean;
    function getNorma:String;
    procedure clear;
  End;

implementation

{ TControllerProductSerialNorma }

procedure TControllerProductSerialNorma.clear;
begin
  clearObj(Registro);
end;

constructor TControllerProductSerialNorma.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := TProductSerialNorma.Create;
  Lista := TListaProductSerialNorma.Create;
end;

function TControllerProductSerialNorma.delete: boolean;
begin
  try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  end;
end;

function TControllerProductSerialNorma.deleteByProduto: boolean;
Var
  Lc_Qry : TFDquery;
begin
  Lc_Qry := createQuery;
  result := True;
  try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'delete  ',
                'from tb_product_serial_norma ',
                'where (tb_product_id =:tb_product_id) ',
                ' and (tb_institution_id =:tb_institution_id) '
      ));
      ParamByName('tb_institution_id').AsString := Registro.Estabelecimento;
      ParamByName('tb_product_id').AsString := Registro.Produto;
      ExecSQL;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

destructor TControllerProductSerialNorma.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerProductSerialNorma.getNorma: String;
Var
  Lc_Qry : TFDquery;
begin
  Lc_Qry := createQuery;
  try
    Result := '';
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'select TOP(1) norma_id ',
                'from tb_product_serial_norma ',
                'where (tb_product_id =:tb_product_id) ',
                ' and (tb_institution_id =:tb_institution_id) '
      ));
      ParamByName('tb_institution_id').AsString := Registro.Estabelecimento;
      ParamByName('tb_product_id').AsString := Registro.Produto;
      Active := True;
      FetchAll;
      exist := ( RecordCount >0 );
      if exist then
        Result := FieldByName('norma_id').AsString;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerProductSerialNorma.getByKey: Boolean;
begin
  _getByKey(Registro);
  result := True;
end;

function TControllerProductSerialNorma.getList: Boolean;
Var
  Lc_Qry : TFDquery;
  Lc_item : TProductSerialNorma;
begin
  Lc_Qry := createQuery;
  result := True;
  try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'select * ',
                'from tb_product_serial_norma ',
                'where (tb_product_id =:tb_product_id) ',
                ' and (tb_institution_id =:tb_institution_id) '
      ));
      ParamByName('tb_institution_id').AsString := Registro.Estabelecimento;
      ParamByName('tb_product_id').AsString := Registro.Produto;
      Active := True;
      FetchAll;
      first;
      Lista.Clear;
      while not eof do
      Begin
        Lc_item := TProductSerialNorma.Create;
        get(Lc_Qry,Lc_item);
        Lista.Add(Lc_item);
        next;
      End;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerProductSerialNorma.insert: boolean;
begin
  try
    insertObj(Registro);
    Result := True;
  Except
    Result := False;
  end;
end;

function TControllerProductSerialNorma.save: boolean;
begin
  result := True;
  SaveObj(Registro);
end;

function TControllerProductSerialNorma.update: boolean;
begin
  try
    updateObj(Registro);
    Result := True;
  Except
    Result := False;
  end;
end;

end.
