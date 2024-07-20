unit sea_user;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Comp.Client,  Datasnap.Provider, Datasnap.DBClient,FireDAC.Stan.Param;

type
  TSeaUSer = class(TBaseSearch)
    Label28: TLabel;
    E_name_company: TEdit;
    Label1: TLabel;
    E_Email: TEdit;
    chbx_ativo: TCheckBox;
    cds_searchid: TGuidField;
    cds_searchname_company: TStringField;
    cds_searchemail: TStringField;
  private

  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;
    procedure setPerfil;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBySql;Override;
    procedure GroupBySql;Override;
    procedure SetParameters(Param: TFDQuery);Override;
    function validateGetView:Boolean;Override;
    procedure GetView;Override;
    procedure totalizer;Override;
    procedure SetRegister;Override;
    procedure returnRegister;Override;

  public
    { Public declarations }
  end;

var
  SeaUSer: TSeaUSer;

implementation

uses
  cad_user, un_dm, uMain, env;

{$R *.dfm}

{ TSeaUSer }

procedure TSeaUSer.CriarVariaveis;
begin
  //PInterface := 13;
  inherited;

end;

procedure TSeaUSer.FormataTela;
begin
  inherited;

end;

procedure TSeaUSer.GetView;
Var
  Lc_Form : TCadUser;
Begin
  Lc_Form := TCadUser.Create(self);
  Try
    Lc_Form.CodigoRegistro := cds_searchid.AsString;
    Lc_Form.ShowModal;
  Finally
    Lc_Form.DisposeOf;
    inherited;
  End;
end;

procedure TSeaUSer.GroupBySql;
begin
  inherited;

end;

procedure TSeaUSer.IniciaVariaveis;
begin
  inherited;

end;

procedure TSeaUSer.InnerJoinSql;
begin
  InnerJoinTxt := Concat(
                        'inner join tb_entity en ',
                        'on (u.id = en.id ) ',
                        'inner join tb_entity_has_mailing ehm ',
                        'on (ehm.tb_entity_id = en.id) and (ehm.tb_mailing_group_id = :tb_mailing_group_id) ',
                        'inner join tb_mailing ma ',
                        'on (ehm.tb_mailing_id = ma.id ) ',
                        'inner join tb_institution_has_user i ',
                        'on (u.id = i.tb_user_id) ');
end;

procedure TSeaUSer.OrderBySql;
begin
  inherited;
  OrderByTxt := 'order by en.name_company ';
end;

procedure TSeaUSer.returnRegister;
begin
  inherited;

end;


procedure TSeaUSer.SelectSql;
begin
  inherited;
   SelectTxt := ' Select distinct u.id, en.name_company, ma.email   '+
               ' from tb_user u ';
end;

procedure TSeaUSer.SetParameters(Param: TFDQuery);
begin
  inherited;
  with DM.Qr_Crud do
  Begin
    ParamByName('tb_institution_id').AsString := GbInstitution.Registro.Codigo;
    ParamByName('tb_mailing_group_id').AsString :=  'F03F8E47-6D7B-4DF7-8581-92CD36616FD4';

    if E_Name_Company.Text <> '' then
      ParamByName('name_company').AsString := '%' + E_Name_Company.Text + '%';

    if E_Email.Text <> '' then
      ParamByName('email').AsString := '%' + E_Email.Text + '%' ;

    if chbx_Ativo.Checked then
      ParamByName('active').AsString := 'S'
    else
      ParamByName('active').AsString := 'N';

  end;
end;

procedure TSeaUSer.setPerfil;
begin
  TelaInterface := 'Cadastro Usuário';
  inherited;
end;

procedure TSeaUSer.SetRegister;
Var
  Lc_Form : TCadUser;
Begin
  Lc_Form := TCadUser.Create(self);
  Try
    Lc_Form.CodigoRegistro := '';
    Lc_Form.ShowModal;
  Finally
    Lc_Form.DisposeOf;
    inherited;
  End;
end;

procedure TSeaUSer.totalizer;
begin
  inherited;

end;

function TSeaUSer.validateGetView: Boolean;
begin
  result := inherited;
end;

procedure TSeaUSer.WhereSql;
begin
  inherited;
  WhereTxt := ' where i.tb_institution_id =:tb_institution_id ';

  WhereTxt := WhereTxt + ' and (i.active =:active) ';

  if E_Name_Company.Text <> '' then
    WhereTxt := WhereTxt + ' and (en.name_company like :name_company)';

  if E_email.Text <> '' then
    WhereTxt := WhereTxt + ' and (ma.email like :email)';

end;

end.
