unit ControllerInstitution;

interface

uses
  System.Classes, System.SysUtils,BaseController,
  FireDAC.Comp.Client,FireDAC.Stan.Param, Rest.json,tblInstitution,
  ControllerUser, ControllerModule,ControllerInstitutionHasModule;

Type
  TControllerInstitution = Class(TBaseController)
    procedure clear;
  private
    FPathPrivado: String;
    FPathPublico: String;
    FURL: String;
    FEstoque: Integer;
    FPathImage: String;
    procedure setFEstoque(const Value: Integer);
  public
    Registro : TInstitution;
    InstitutionHasModule : TControllerInstitutionHasModule;
    Module : TControllerModule;
    User : TControllerUser;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    procedure getlistByUser;
    property PathImage : String read FPathImage;
    property PathPublico : String read FPathPublico;
    property PathPrivado : String read FPathPrivado;
    property URL : String read FURL;
//    property Usuario : Integer read FUsuario write setFUsuario;
    property Estoque : Integer Read FEstoque write setFEstoque;
  End;

implementation

{ ControllerInstitution }


procedure TControllerInstitution.clear;
begin
  clearObj(Registro);
end;

constructor TControllerInstitution.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TInstitution.Create;
  User := TControllerUser.Create(self);
  Module := TControllerModule.Create(self);
  InstitutionHasModule := TControllerInstitutionHasModule.Create(self);
end;

function TControllerInstitution.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerInstitution.Destroy;
begin

  Registro.DisposeOf;

  User.DisposeOf;

  inherited;
end;



function TControllerInstitution.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


function TControllerInstitution.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;



procedure TControllerInstitution.setFEstoque(const Value: Integer);
begin
  FEstoque := Value;
end;



function TControllerInstitution.getByKey: Boolean;
begin
  _getByKey(Registro);
  Result := True;
end;



procedure TControllerInstitution.getlistByUser;
var
  Lc_Qry : TFDQuery;
  LITem : TInstitution;
begin
  Lc_Qry := createQuery;
  try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT i.* ',
                'FROM tb_institution i ',
                'inner join tb_institution_has_user ihu ',
                'on (ihu.tb_institution_id = i.id) ',
                'where ( ihu.tb_user_id =:tb_user_id ) and ( ihu.tb_user_id > 0 ) '
        ));
      ParamByName('tb_user_id').AsString := Registro.Ativo;
      Active := True;
      FetchAll;
      First;
      Clear;
      while not eof do
      Begin
        LITem := TInstitution.Create;
        get(Lc_Qry,LITem);

        next;
      end;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;



end.


