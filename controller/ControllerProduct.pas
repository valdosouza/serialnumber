unit ControllerProduct;


interface

uses System.Classes, System.SysUtils,BaseController,
      tblProduct,FireDAC.Comp.Client, FireDAC.Stan.Param,
      ControllerConfig, ControllerProductSerialNorma;

Type

  TControllerProduct = Class(TBaseController)
    procedure clear;
  private
  public
    Registro    : TProduct;
    Norma : TControllerProductSerialNorma;
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    function    insert:boolean;
    function    save:boolean;
    function    update:boolean;
    function    getByKey:Boolean;
    function    getAllByKey:Boolean;
    function    delete: boolean;
    function    checkExistReference:Boolean;
    procedure   assigner(ObjOri : TProduct);
  End;

implementation

{ ControllerProduct }

procedure TControllerProduct.assigner(ObjOri: TProduct);
begin
  _assign(ObjOri,Registro);
end;

function TControllerProduct.checkExistReference: Boolean;
Var
  Lc_Qry : TFDQuery;
begin
  Lc_Qry := createQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
                'Select p.reference ',
                'from tb_product p ',
                'where tb_institution_id =:tb_institution_id ',
                ' and reference =:reference ',
                ' and id <>:id '
      ));
      ParamByName('tb_institution_id').AsString := Registro.Estabelecimento;
      ParamByName('reference').AsString         := Registro.referencia;
      ParamByName('id').AsString                := Registro.Codigo;
      active := True;
      FetchAll;
      Result := (RecordCount > 0)
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

procedure TControllerProduct.clear;
begin
  clearObj(Registro);
  Norma.clear;
end;

constructor TControllerProduct.Create(AOwner: TComponent);
begin
  inherited;
  Registro    := TProduct.Create;
  Norma := TControllerProductSerialNorma.Create(self);
end;

function TControllerProduct.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerProduct.Destroy;
begin
  Norma.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;


function TControllerProduct.update: boolean;
begin
  try
    updateObj(Registro);
    Result := true;
  except
    Result := False;
  end;

end;

function TControllerProduct.getAllByKey: Boolean;
begin
  _getByKey(Registro);
  result := True;
end;

function TControllerProduct.getByKey: Boolean;
begin
  _getByKey(Registro);
  result := True;
end;


function TControllerProduct.insert: boolean;
begin
  try
    Registro.Codigo := getNext;
    InsertObj(Registro);
    Result := true;
  except
    Result := False;
  end;

end;


function TControllerProduct.save: boolean;
Begin
  result := True;
  if Registro.Codigo = '' then
    Registro.Codigo := getNext;
  SaveObj(Registro);
end;

end.

