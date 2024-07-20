unit ControllerUser;

interface

uses System.Classes, System.SysUtils,BaseController,tblPrivilege, prm_user,
      tblUser, ControllerMailing,ControllerEntity ,FireDAC.Comp.Client,
      FireDAC.Stan.Param,ControllerInstitutionHasUser,ControllerUserHasPrivilege,
  System.Generics.Collections,tblMailing;

Type
  TListPrivilege = TObjectList<TPrivilege>;
  TControllerUser = Class(TBaseController)
    procedure clear;
  private


  public
    Registro        : TUser;
    Mailing         : TControllerMailing;
    Entity          : TControllerEntity;
    Parametro       : TPrmUser;
    HasInstitution  : TControllerInstitutionHasUser;
    HasPrivilegio   : TControllerUserHasPrivilege;
    ListaPrivilegio : TListPrivilege;


    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function update:boolean;
    procedure getbyKey;
    procedure getAllByKey;

    Function delete:boolean;
    Function activeRegister:Boolean;
    Function desactiveRegiter:Boolean;
    Function getListEMail:boolean;
    function insert:boolean;
    function autenticacao(email,senha:String):Boolean;
    function getByEmail: Boolean;
    function encryptUser(Value:String):String;
    function encryptPassword(Value:String):String;
    function getInstitutionUSer:String;
    function getListprivilege:boolean;
    function getPrivilege:Boolean;

  End;

implementation

{ TControllerUser }

uses Md5;

function TControllerUser.activeRegister: Boolean;
begin
  Result := True;
  if (Registro.Codigo <> '') then
  Begin
    with HasInstitution.Registro do
    Begin
      Usuario := Registro.Codigo;
      Ativo := 'S';
      RegistroCriado := Now;
      RegistroAlterado := Now;
    End;
    HasInstitution.save;
  End;
end;

function TControllerUser.autenticacao(email, senha: String): Boolean;
Var
  Lc_Qry : TFDQuery;
begin
  Lc_Qry := createQuery;
  Try
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      //Vincular o usuario a entidade - e pela entidade has mailing verifica o email e o grupo
      SQL.Add(concat(
              'Select u.* ',
              'from tb_user u ',
              ' inner join  tb_entity_has_mailing ehm ',
              ' on (ehm.tb_entity_id = u.id)',
              '  inner join tb_mailing m ',
              '  on (m.id = ehm.tb_mailing_id) ',
              'where ( email=:email ) and ( password=:password ) ',
              ' and (ehm.tb_mailing_group_id =:tb_mailing_group_id) '
      ));
      ParamByName('email').AsString := email;
      ParamByName('tb_mailing_group_id').AsString :=  'F03F8E47-6D7B-4DF7-8581-92CD36616FD4';
      ParamByName('password').AsString := String(senha);
      active := True;
      FetchAll;
      result := (RowsAffected > 0) ;
      if result then get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerUser.getAllByKey;
begin
  getbyKey;
  Entity.Registro.Codigo := Registro.Codigo;
  Entity.getByKey;
  HasInstitution.Registro.Usuario := Registro.Codigo;
  HasInstitution.getInstitution;
end;

function TControllerUser.getByEmail: Boolean;
Var
  Lc_Qry : TFDQuery;
begin
  Lc_Qry := createQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add('Select m.email '+
              'from tb_mailing m '+
              'where email=:email '+
              ' and (m.id > 0) '+
              ' and (m.id <>:id) ');
      ParamByName('email').AsString := Mailing.Registro.Email;
      ParamByName('id').AsString := Registro.Codigo;
      active := True;
      FetchAll;
      result := (RowsAffected > 0) ;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerUser.getbyKey;
Var
  Lc_Qry : TFDQuery;
begin
  Lc_Qry := createQuery;
  Try
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      sql.Add('SELECT u.*, i.tb_institution_id,  i.active '+
              'from tb_user u ' +
              '  inner join tb_institution_has_user i '+
              '   on (i.tb_user_id = u.id ) '+
              'where (i.tb_institution_id =:tb_institution_id) '+
              ' and  (u.id =:id) ' );

      ParamByName('tb_institution_id').AsString := Self.HasInstitution.Registro.Estabelecimento;
      ParamByName('id').AsString := Registro.Codigo;
      Active := true;
      FetchAll;
      exist := ( RecordCount > 0 );
      if (exist) then get(Lc_Qry,Registro);
    End;
  Finally
    finalizaQuery(Lc_Qry);
  End;
end;

function TControllerUser.getInstitutionUSer: String;
Var
  Lc_Qry : TFDQuery;
begin
  Lc_Qry := createQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
                'Select ihu.tb_institution_id ',
                'from tb_institution_has_user ihu ',
               'where (ihu.tb_user_id=:tb_user_id)'
               ));
      ParamByName('tb_user_id').AsString := Registro.Codigo;
      active := True;
      FetchAll;
      result := FieldByName('tb_institution_id').AsString;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerUser.getListEMail: boolean;
Var
  Lc_Qry : TFDQuery;
  Lc_item : TMailing;
begin
  Lc_Qry := createQuery;
  Result := True;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
                'Select distinct u.id, en.name_company, ma.* ',
                'from tb_user u ',
                '  inner join tb_entity en on (u.id = en.id ) ',
                '  inner join tb_entity_has_mailing ehm ',
                '  on (ehm.tb_entity_id = en.id) ',
                '  and (ehm.tb_mailing_group_id = :tb_mailing_group_id) ',
                '  inner join tb_mailing ma on (ehm.tb_mailing_id = ma.id ) ',
                '  inner join tb_institution_has_user i ',
                '  on (u.id = i.tb_user_id) ',
                'where (i.active =:active) ',
                'order by en.name_company '
               ));
      ParamByName('tb_mailing_group_id').AsString :=  'F03F8E47-6D7B-4DF7-8581-92CD36616FD4';
      ParamByName('active').AsString :=  'S';
      active := True;
      FetchAll;
      while not eof do
      Begin
        Lc_item := TMailing.create;
        get(Lc_Qry,lc_Item);
        Mailing.Lista.Add(Lc_item);
        Next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerUser.getListprivilege: boolean;
Var
  Lc_Qry : TFDQuery;
  LcItem : TPrivilege;
begin
  Lc_Qry := createQuery;
  Result := True;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
                'Select p.id, p.description, uhp.active ',
                'from tb_privilege p ',
                ' inner join tb_user_has_privilege uhp ',
                '  on (uhp.tb_privilege_id = p.id ) ',
                'where  ( uhp.tb_institution_id =:tb_institution_id) ',
                '  and  ( uhp.tb_user_id =:tb_user_id) ',
                '  and  ( uhp.tb_interface_id =:tb_interface_id) ',
                'union ',
                'Select p.id, p.description, ''N'' active ',
                'from tb_privilege p ',
                '  inner join tb_interface_has_privilege ihp ',
                '  on (ihp.tb_privilege_id = p.id) ',
                'where  p.id not in ( ',
                '  Select p.id ',
                '  from tb_privilege p ',
                '   inner join tb_user_has_privilege uhp ',
                '    on (uhp.tb_privilege_id = p.id ) ',
                '  where  ( uhp.tb_institution_id =:tb_institution_id) ',
                '    and  ( uhp.tb_user_id =:tb_user_id) ',
                '    and  ( uhp.tb_interface_id =:tb_interface_id) ',
                ') ',
                'and  (ihp.tb_interface_id =:tb_interface_id) '

               ));
      ParamByName('tb_institution_id').AsString  := Parametro.Estabelecimento;
      ParamByName('tb_user_id').AsString         := Parametro.Usuario;
      ParamByName('tb_interface_id').AsString    := Parametro.TelaInterface;
      active := True;
      FetchAll;
      ListaPrivilegio.Clear;
      while not eof do
      Begin
        LcItem := TPrivilege.Create;
        LcItem.Codigo    := FieldByName('id').AsString;
        LcItem.Descricao := FieldByName('description').AsString;
        LcItem.Ativo     := FieldByName('active').AsString;
        ListaPrivilegio.Add(LcItem);
        Next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerUser.getPrivilege: Boolean;
Var
  Lc_Qry : TFDQuery;
begin
  if HasInstitution.Registro.Tipo = 'Administrador' then
  Begin
    Result := True;
  End
  else
  Begin
    Lc_Qry := createQuery;
    Try
      with Lc_Qry do
      Begin
        SQL.Clear;
        SQL.Add(concat(
                  'Select p.id, p.description, uhp.active ',
                  'from tb_privilege p ',
                  ' inner join tb_user_has_privilege uhp ',
                  '  on (uhp.tb_privilege_id = p.id ) ',
                  '  INNER JOIN tb_interface ifc ',
                  '  on (ifc.id = uhp.tb_interface_id) ',
                  'where  ( uhp.tb_institution_id =:tb_institution_id) ',
                  '  and  ( uhp.tb_user_id =:tb_user_id) ',
                  '  and  ( ifc.description =:TelaInterface) ',
                  '  and  ( p.description =:TipoPrivilegio ) '
                 ));
        ParamByName('tb_institution_id').AsString  := Parametro.Estabelecimento;
        ParamByName('tb_user_id').AsString         := Parametro.Usuario;
        ParamByName('TelaInterface').AsString    := Parametro.TelaInterface;
        ParamByName('TipoPrivilegio').AsString        := Parametro.TipoPrivilegio;
        active := True;
        FetchAll;
        //Se não definido vamos liberar por enquanto
        if RecordCount = 0 then
        BEgin
          REsult := False;
        End
        else
        Begin
          REsult := (FieldByName('active').AsString = 'S');
        End;
      End;
    Finally
      FinalizaQuery(Lc_Qry);
    End;
  End;
end;

procedure TControllerUser.clear;
begin
  clearObj(Registro);
  HasInstitution.clear;
  Mailing.clear;
end;

constructor TControllerUser.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := TUser.Create;
  Mailing   := TControllerMailing.Create(Self);
  Entity    := TControllerEntity.Create(Self);
  HasInstitution  := TControllerInstitutionHasUser.Create(Self);
  Parametro       := TPrmUser.Create;
  ListaPrivilegio := TListPrivilege.create;
  HasPrivilegio   := TControllerUserHasPrivilege.Create(Self);
end;

function TControllerUser.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerUser.desactiveRegiter: Boolean;
begin
  Result := True;
  if (Registro.Codigo <> '') then
  Begin
    with HasInstitution.Registro do
    Begin
        Usuario := Self.Registro.Codigo;
        Ativo := 'N';
        RegistroCriado := Now;
        RegistroAlterado := Now;
      End;
    HasInstitution.save;
  End;
end;

destructor TControllerUser.Destroy;
begin
  HasPrivilegio.DisposeOf;

  Registro.DisposeOf;
  Mailing.DisposeOf;
  Entity.DisposeOf;
  HasInstitution.DisposeOf;

  inherited;
end;




function TControllerUser.encryptPassword(Value: String): String;
begin
  Result := MD5String(Value);
end;




function TControllerUser.encryptUser(Value: String): String;
begin
  Result := MD5String(Value);
end;

function TControllerUser.insert: boolean;
begin
  Registro.Codigo := getNext;
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerUser.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


function TControllerUser.update: boolean;
begin
  try
    UpdateObj(Registro);
    Result := true;
  except
    Result := False;
  end;

end;

end.
