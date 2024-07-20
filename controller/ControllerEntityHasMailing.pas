unit ControllerEntityHasMailing;

interface
uses System.Classes, System.SysUtils,BaseController,
      tblEntityHasMailing,FireDAC.Comp.Client,FireDAC.Stan.Param;

Type
  TControllerEntityHasMailing = Class(TBaseController)
    procedure clear;
  private

  public
    Registro : TEntityHasMailing;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetIdbyGroupMailing(NameGroup:String):String;
    function save:boolean;
    function delete:boolean;
  End;

implementation

{ ControllerEntityHasMailing }

procedure TControllerEntityHasMailing.clear;
begin
  clearObj(Registro);
end;

constructor TControllerEntityHasMailing.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TEntityHasMailing.Create;
end;

function TControllerEntityHasMailing.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerEntityHasMailing.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerEntityHasMailing.GetIdbyGroupMailing(
  NameGroup: String): String;
Var
  Lc_Qry : TFDQuery;
begin
  Lc_Qry := createQuery;
  TRy
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add(
        Concat('SELECT id ',
               'from tb_mailing_group mg ',
               'where mg.description_name=:description_name')
              );
      ParamByName('description_name').Value := NameGroup;
      active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if exist then
        Result := FieldByName('id').AsString;
    End;
  Finally
    finalizaQuery(Lc_Qry);
  End;

end;

function TControllerEntityHasMailing.save: boolean;
begin
  Try
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


end.
