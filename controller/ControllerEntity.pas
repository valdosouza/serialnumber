unit ControllerEntity;

interface

uses
  System.Classes, System.SysUtils, System.Variants, FireDAC.Comp.Client,
  FireDAC.Stan.Param,BaseController, tblEntity,ControllerMailing,
  ControllerEntityHasMailing;

Type
  TControllerEntity = Class(TBaseController)
    procedure clear;
  private

  public
    Registro : TEntity;
    Email : TControllerMailing;
    EntityHasMailing : TControllerEntityHasMailing;


    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function update:boolean;
    function getByKey:Boolean;Virtual;

    function delete: boolean;
    function insert:boolean;



  End;

implementation

{ ControllerAddress }

procedure TControllerEntity.clear;
begin
  clearObj(Registro);
end;

constructor TControllerEntity.Create(AOwner: TComponent);
begin
  inherited;
  Registro          := TEntity.Create;
  email           := TControllerMailing.Create(Self);
  EntityHasMailing  := TControllerEntityHasMailing.Create(Self);

end;

function TControllerEntity.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;

end;

destructor TControllerEntity.Destroy;
begin

  Registro.DisposeOf;
  email.DisposeOf;
  EntityHasMailing.DisposeOf;

  inherited;
end;



function TControllerEntity.save: boolean;
begin
  try
    if Registro.Codigo = '' then
      Registro.Codigo :=  getNexT;
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;



function TControllerEntity.update: boolean;
begin
  try
    updateObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;



function TControllerEntity.getByKey: Boolean;
begin
  _getByKey(Registro);
  Result := True;
end;

function TControllerEntity.insert: boolean;
begin
  try
    if Registro.Codigo <> '' then
      Registro.Codigo := getNext;
    insertObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

end.

