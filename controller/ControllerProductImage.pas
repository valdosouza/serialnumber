unit ControllerProductImage;


interface

uses System.Classes, System.SysUtils,BaseController,
      tblProductImage,FireDAC.Comp.Client, FireDAC.Stan.Param,
      ControllerConfig;

Type

  TControllerProductImage = Class(TBaseController)
    procedure clear;
  private

  public
    Registro    : TProductImage;
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    function    insert:boolean;
    function    getByKey:Boolean;
    function    delete: boolean;
  End;

implementation

{ TControllerProductImage }

procedure TControllerProductImage.clear;
begin

end;

constructor TControllerProductImage.Create(AOwner: TComponent);
begin
  inherited;
  Registro    := TProductImage.Create;
end;

function TControllerProductImage.delete: boolean;
begin
  try
    deleteObj(Registro);
    Result := True;
  except
    Result := False;
  end;
end;

destructor TControllerProductImage.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerProductImage.getByKey: Boolean;
begin
  _getByKey(Registro);
  Result := True;
end;

function TControllerProductImage.insert: boolean;
begin
  try
    Registro.Codigo := getNext;
    insertObj(Registro);
    Result := True;
  except
    Result := False;
  end;
end;

end.
