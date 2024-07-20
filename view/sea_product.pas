unit sea_product;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB,
  Datasnap.Provider, Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Comp.Client,FireDAC.Stan.Param;

type
  TSeaProduct = class(TBaseSearch)
    Label28: TLabel;
    Label1: TLabel;
    E_Reference: TEdit;
    E_description: TEdit;
    chbx_ativo: TCheckBox;
    cds_searchid: TStringField;
    cds_searchtb_institution_id: TStringField;
    cds_searchdescription: TStringField;
    cds_searchreference: TStringField;
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
  SeaProduct: TSeaProduct;

implementation

{$R *.dfm}

uses un_dm, uMain, cad_product, env;

{ TSeaProduct }

procedure TSeaProduct.CriarVariaveis;
begin
  inherited;

end;

procedure TSeaProduct.FormataTela;
begin
  inherited;

end;

procedure TSeaProduct.GetView;
Var
  Lc_Form : TCadProduct;
begin
  Lc_Form := TCadProduct.Create(Self);
  try
    Lc_Form.CodigoRegistro := cds_searchid.AsString;
    Lc_Form.ShowModal
  finally
    Lc_Form.DisposeOf;
    inherited;
  end;
end;

procedure TSeaProduct.GroupBySql;
begin
  inherited;

end;

procedure TSeaProduct.IniciaVariaveis;
begin
  inherited;
end;

procedure TSeaProduct.InnerJoinSql;
begin
  inherited;

end;

procedure TSeaProduct.OrderBySql;
begin
  inherited;
  OrderByTxt := 'order by p.description ';
end;

procedure TSeaProduct.returnRegister;
begin
  inherited;

end;

procedure TSeaProduct.SelectSql;
begin
  inherited;
   SelectTxt := ' Select id, tb_institution_id, description, reference   '+
               ' from tb_product p ';
end;

procedure TSeaProduct.SetParameters(Param: TFDQuery);
begin
  inherited;
  with DM.Qr_Crud do
  Begin
    ParamByName('tb_institution_id').AsString := GbInstitution.Registro.Codigo;

    if E_description.Text <> '' then
      ParamByName('description').AsString := '%' + E_description.Text + '%';

    if E_Reference.Text <> '' then
      ParamByName('reference').AsString := '%' + E_Reference.Text + '%' ;

    if chbx_Ativo.Checked then
      ParamByName('active').AsString := 'S'
    else
      ParamByName('active').AsString := 'N';

  end;

end;

procedure TSeaProduct.setPerfil;
begin
  TelaInterface := 'Cadastro Produto';
  inherited;
end;

procedure TSeaProduct.SetRegister;
Var
  Lc_Form : TCadProduct;
begin
  Lc_Form := TCadProduct.Create(Self);
  try
    Lc_Form.CodigoRegistro := '';
    Lc_Form.ShowModal
  finally
    Lc_Form.DisposeOf;
    inherited;
  end;
end;

procedure TSeaProduct.totalizer;
begin
  inherited;

end;

function TSeaProduct.validateGetView: Boolean;
begin
  result := inherited;
end;

procedure TSeaProduct.WhereSql;
begin
  inherited;
  WhereTxt := ' where p.tb_institution_id =:tb_institution_id ';

  WhereTxt := WhereTxt + ' and (p.active =:active) ';

  if E_description.Text <> '' then
    WhereTxt := WhereTxt + ' and (p.description like :description)';

  if E_Reference.Text <> '' then
    WhereTxt := WhereTxt + ' and (p.reference like :reference)';

end;

end.
