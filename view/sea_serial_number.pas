unit sea_serial_number;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB,
   Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
   Vcl.ComCtrls, base_frame_list, lis_frame_user, lis_frame_product,
   FireDAC.Comp.Client, tas_serial_number_record, Datasnap.Provider,
  Datasnap.DBClient,FireDAC.Stan.Param;

type
  TSeaSerialNumber = class(TBaseSearch)
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    ListFrameUser: TListFrameUser;
    Lb_Situacao: TLabel;
    CB_Situacao: TComboBox;
    listFrameProduct: TlistFrameProduct;
    Gravao1: TMenuItem;
    Conferncia1: TMenuItem;
    cds_searchcreated_at: TSQLTimeStampField;
    cds_searchnumber: TStringField;
    cds_searchstatus: TStringField;
    cds_searchname_company: TStringField;
    cds_searchdescription: TStringField;
    procedure Gravao1Click(Sender: TObject);
    procedure Conferncia1Click(Sender: TObject);
  private
  protected
    procedure ImagemBotao;Override;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;
    procedure setPerfil;Override;

    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBySql;Override;
    procedure SetParameters(Param: TFDQuery);Override;

  public
    { Public declarations }
  end;

var
  SeaSerialNumber: TSeaSerialNumber;

implementation

{$R *.dfm}

uses tas_serial_number_check, env;

{ TSeaSerialNumber }

procedure TSeaSerialNumber.Conferncia1Click(Sender: TObject);
Var
  Lc_Form : TTasSerialNumberCheck;
begin
  if getPrivilege('Conferência Serial','CONFERÊNCIA') then
  Begin
    Lc_Form := TTasSerialNumberCheck.Create(self);
    try
      Lc_Form.ShowModal;
    finally
      Lc_Form.DisposeOf;
    end;
  End;

end;

procedure TSeaSerialNumber.CriarVariaveis;
begin
  inherited;

end;

procedure TSeaSerialNumber.FormataTela;
begin
  inherited;

end;


procedure TSeaSerialNumber.Gravao1Click(Sender: TObject);
Var
  Lc_Form : TTasSerialNumberRecord;
begin
  if getPrivilege('Registro Serial','GRAVAÇÃO') then
  Begin
    Lc_Form := TTasSerialNumberRecord.Create(self);
    try
      Lc_Form.ShowModal;
    finally
      Lc_Form.DisposeOf;
    end;
  End;
end;


procedure TSeaSerialNumber.ImagemBotao;
begin
  inherited;

end;

procedure TSeaSerialNumber.IniciaVariaveis;
begin
  inherited;
  SB_Cadastrar.Visible := Pf_Inserir;
  ListFrameUser.Listar;
  listFrameProduct.Listar;
  E_Data_Ini.DateTime := Date;
  E_Data_Fim.DateTime := Date;
end;

procedure TSeaSerialNumber.InnerJoinSql;
begin
  inherited;
  InnerJoinTxt := concat(
                   'inner join tb_serial_number_has_historic snh ',
                   'on (sn.id = snh.tb_serial_number_id) ',
                   'inner join tb_entity usr ',
                   'on (usr.id = snh.tb_user_id) '
  );
end;

procedure TSeaSerialNumber.OrderBySql;
begin
  inherited;
  OrderByTxt := 'order by snh.created_at, sn.number '
end;

procedure TSeaSerialNumber.SelectSql;
begin
  inherited;
  SelectTxt := concat(
                'SELECT  snh.created_at, sn.number, snh.status, usr.name_company, snh.description ',
                'FROM tb_serial_number sn '
  )

end;

procedure TSeaSerialNumber.SetParameters(Param: TFDQuery);
begin
  inherited;
  with Param do
  Begin
    ParamByName('tb_institution_id').AsString := GbInstitution.Registro.Codigo;
    ParamByName('status').AsString := CB_Situacao.Text;

  if ChBx_Periodo.Checked then
  Begin
    ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime + StrtoTime('00:00:00');
    ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime + StrtoTime('23:59:59');;
  End;
  if ( Trim(ListFrameUser.DBLCB_Lista.Text) <> '' ) then
    ParamByName('tb_user_id').AsString := ListFrameUser.DBLCB_Lista.KeyValue;

  if ( Trim(listFrameProduct.DBLCB_Lista.Text) <> '' ) then
    ParamByName('tb_product_id').AsString := listFrameProduct.DBLCB_Lista.KeyValue;

  End;

end;

procedure TSeaSerialNumber.setPerfil;
begin
  inherited;
  Pf_Inserir := false;
  Pf_Visualizar := false;
end;

procedure TSeaSerialNumber.WhereSql;
begin
  inherited;
  WhereTxt := concat(
                WhereTxt,
                'Where (tb_institution_id =:tb_institution_id) ',
                ' and (snh.status =:status) '
  );

  if ChBx_Periodo.Checked then
    WhereTxt := concat(
                  WhereTxt,
                  ' AND (snh.created_at BETWEEN :DATAINI AND :DATAFIM) '
    );

  if ( Trim(ListFrameUser.DBLCB_Lista.Text) <> '' ) then
    WhereTxt := concat(
                  WhereTxt,
                  ' AND (snh.tb_user_id =:tb_user_id) '
    ) ;

  if ( Trim(listFrameProduct.DBLCB_Lista.Text) <> '' ) then
    WhereTxt := concat(
                  WhereTxt,
                  ' AND (sn.tb_product_id =:tb_product_id) '
    ) ;

end;

end.
