unit ControllerInstitutionHasUser;

interface
uses System.Classes, System.SysUtils,BaseController,
      tblInstitutionHasUser,FireDAC.Comp.Client,
      FireDAC.Stan.Param;

Type
  TControllerInstitutionHasUser = Class(TBaseController)
    procedure clear;
  private

  public
    Registro : TInstitutionHasUser;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function  delete:Boolean;
    function getbyKey:Boolean;
    function getInstitution:Boolean;
    function getList:Boolean;
  End;

implementation

{ ControllerInterface }

procedure TControllerInstitutionHasUser.clear;
begin
  clearObj(Registro);
end;

constructor TControllerInstitutionHasUser.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TInstitutionHasUser.Create;

end;

function TControllerInstitutionHasUser.delete: Boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerInstitutionHasUser.Destroy;
begin

  Registro.DisposeOf;
  inherited;
end;

function TControllerInstitutionHasUser.getbyKey: Boolean;
begin
  try
    _getByKey(Registro);
    Result := True;
  except
    Result := FAlse;
  end;

end;

function TControllerInstitutionHasUser.getInstitution: Boolean;
var
  Lc_Qry : TFDQuery;
begin
  Lc_Qry := createQuery;
  Result := True;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
               'select * ',
               ' from tb_institution_has_User ',
               ' where tb_user_id is not null '
      ));

      //Incrementa SQL
      if registro.Usuario <> '' then
        sql.add('and tb_user_id =:tb_user_id ');

      //Passagem de parametros
      if registro.Usuario <> '' then
        parambyname('tb_user_id').AsString := Registro.Usuario;
      Active := True;
      FetchAll;
      First;
      get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerInstitutionHasUser.getList: Boolean;
var
  Lc_Qry : TFDQuery;
  lcItem : TInstitutionHasUser;
begin
  Lc_Qry := createQuery;
  Result := True;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
               'select * ',
               ' from tb_institution_has_User ',
               ' where tb_user_id is not null '
      ));

      //Incrementa SQL
      if registro.Usuario <> '' then
        sql.add('and tb_user_id =:tb_user_id ');

      //Passagem de parametros
      parambyname('tb_user_id').AsString := Registro.Usuario;
      Active := True;
      FetchAll;
      First;

      while not eof do
      Begin
        LcITem := TInstitutionHasUser.Create;
        get(Lc_Qry,LcITem);

        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

function TControllerInstitutionHasUser.save: boolean;
begin
  Try
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

end.
