unit base_search;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_base, Data.DB, Datasnap.Provider,un_dm,
  Datasnap.DBClient, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Menus, Vcl.StdCtrls,  FireDAC.Comp.Client,System.UITypes,
  Midas, MidasLib;



type
  TBaseSearch = class(TFr_Base)
    Pnl_Fundo: TPanel;
    Pnl_Parametros: TPanel;
    ds_search: TDataSource;
    cds_search: TClientDataSet;
    DSP: TDataSetProvider;
    Sb_Sair_0: TSpeedButton;
    SB_Visualizar: TSpeedButton;
    SB_Buscar: TSpeedButton;
    SB_Cadastrar: TSpeedButton;
    Lb_ResultadoPesquisa: TLabel;
    DBG_Pesquisa: TDBGrid;
    pnl_pesq_right: TPanel;
    procedure Sb_Sair_0Click(Sender: TObject);
    //procedure SB_VisualizarClick(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure SB_CadastrarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBG_PesquisaDblClick(Sender: TObject);
    procedure DBG_PesquisaTitleClick(Column: TColumn);
    procedure SB_VisualizarClick(Sender: TObject);

  private

  protected
    FSelecionar: Boolean;
    FSelecionado: Boolean;

    SelectTxt : String;
    InnerJoinTxt : String;
    WhereTxt : String;

    UnionSelectTxt : String;
    UnionInnerJoinTxt : String;
    UnionWhereTxt : String;

    OrderByTxt : String;
    GroupByTxt : String;

    procedure setFSelecionar(const Value: Boolean);
    procedure setFSelecionado(const Value: Boolean);

    procedure ImagemBotao;Override;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;
    procedure setPerfil;Override;

    procedure SelectSql;Virtual;
    procedure InnerJoinSql;Virtual;
    procedure WhereSql;Virtual;
    procedure OrderBySql;Virtual;
    procedure GroupBySql;Virtual;
    procedure SetParameters(Param: TFDQuery);Virtual;
    function validateGetView:Boolean;Virtual;
    procedure GetView;Virtual;
    procedure Search;Virtual;
    procedure totalizer;Virtual;
    procedure SetRegister;Virtual;
    procedure returnRegister;Virtual;

    procedure execShorCutKeyF2;Override;
    procedure execShorCutKeyF7;Override;
    procedure execShorCutKeyF8;Override;
    procedure execShorCutEsc;Override;

  public
    property Selecionar : Boolean read FSelecionar write setFSelecionar;
    property Selecionado : Boolean read FSelecionado write setFSelecionado;
  end;

var
  BaseSearch: TBaseSearch;

implementation

{$R *.dfm}

uses Un_Msg, env;



procedure TBaseSearch.CriarVariaveis;
begin
  inherited;
  FSelecionar := False;
end;

procedure TBaseSearch.DBG_PesquisaDblClick(Sender: TObject);
begin
  //SB_VisualizarClick(Self);
end;

procedure TBaseSearch.DBG_PesquisaTitleClick(Column: TColumn);
var
   i: Integer;
begin

   // apply grid formatting changes here e.g. title styling
  with DBG_Pesquisa do
    for i := 0 to Columns.Count - 1 do
      Columns[i].Title.Font.Style := Columns[i].Title.Font.Style - [fsBold];
   Column.Title.Font.Style := Column.Title.Font.Style + [fsBold];
  cds_search.IndexFieldNames := Column.FieldName;

end;

procedure TBaseSearch.execShorCutEsc;
begin
  Close;
end;

procedure TBaseSearch.execShorCutKeyF2;
begin
  if SB_Cadastrar.Enabled then SB_CadastrarClick(Self);
end;

procedure TBaseSearch.execShorCutKeyF7;
begin
  if SB_Buscar.Enabled then SB_BuscarClick(Self);
end;

procedure TBaseSearch.execShorCutKeyF8;
begin
  inherited;
  //if SB_visualizar.Enabled then SB_visualizarClick(Self);
end;

procedure TBaseSearch.FormataTela;
begin

end;

procedure TBaseSearch.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (shift = []) then
  begin
    case Key of
      VK_F2:execShorCutKeyF2;
      VK_F7: execShorCutKeyF7;
      VK_F8: execShorCutKeyF8;
      VK_Escape: execShorCutEsc;
    end;
  end;
end;

procedure TBaseSearch.GetView;
begin
  //ser� implementada nas descendencias
  Search;
end;

procedure TBaseSearch.Search;
begin
  Try
    cds_search.Active := False;
    with DM.Qr_Crud do
    Begin
      Active := False;
      sql.Clear;
      SelectTxt := '';
      InnerJoinTxt := '';
      WhereTxt := '';
      UnionSelectTxt := '';
      UnionInnerJoinTxt := '';
      UnionWhereTxt := '';
      OrderByTxt := '';
      SelectSql;
      InnerJoinSql;
      WhereSql;
      GroupBySql;
      OrderBySql;
      SQL.Add(SelectTxt);
      SQL.Add(InnerJoinTxt);
      SQL.Add(WhereTxt);
      if Trim(UnionSelectTxt) <> '' then
      Begin
        SQL.Add(' Union ');
        SQL.Add(UnionSelectTxt);
      End;
      if Trim(UnionInnerJoinTxt) <> '' then
        SQL.Add(UnionInnerJoinTxt);
      if Trim(UnionWhereTxt) <> ''     then
        SQL.Add(UnionWhereTxt);
      SQL.Add(GroupByTxt);
      SQL.Add(OrderByTxt);
      SetParameters(DM.Qr_Crud);
      Prepare;
      Active := True;
      FetchAll;
      Lb_ResultadoPesquisa.Caption := 'Resultado da pesquisa : ' + IntTostr(recordCount) + ' registro(s)';
      Lb_ResultadoPesquisa.Update;
    End;
    cds_search.Active := True;
  Except on E:Exception do
    ShowMessage(e.Message);

  End;
end;

procedure TBaseSearch.SelectSql;
begin
  //
end;

procedure TBaseSearch.setFSelecionado(const Value: Boolean);
begin
  FSelecionado := Value;
end;

procedure TBaseSearch.setFSelecionar(const Value: Boolean);
begin
  FSelecionar := Value;
end;

procedure TBaseSearch.ImagemBotao;
begin
  exit;
  CarregaImagemBotao(SB_Cadastrar,'CADASTRAR');
  CarregaImagemBotao(SB_Buscar,'BUSCAR');
  if FSelecionar then
  Begin
    SB_Cadastrar.Visible := False;
    CarregaImagemBotao(SB_Visualizar,'CONFIRMAR');
    SB_Visualizar.Caption:= 'Selecionar - F8';
  End
  else
  Begin
    SB_Cadastrar.Visible := True;
    CarregaImagemBotao(SB_Visualizar,'VISUALIZAR');
    SB_Visualizar.Caption:= 'Visualizar - F8';
  End;


  CarregaImagemBotao(Sb_Sair_0,'SAIR');

end;

procedure TBaseSearch.SetParameters(Param: TFdQuery);
begin

end;

procedure TBaseSearch.setPerfil;
begin
  GbInstitution.User.Parametro.Estabelecimento  := GbInstitution.Registro.Codigo;
  GbInstitution.User.Parametro.Usuario          := GbInstitution.User.Registro.Codigo;
  GbInstitution.User.Parametro.TelaInterface    := TelaInterface;

  GbInstitution.User.Parametro.TipoPrivilegio   := 'INSERIR';
  Pf_Inserir    := GbInstitution.User.getPrivilege;

  GbInstitution.User.Parametro.TipoPrivilegio   := 'VISUALIZAR';
  Pf_Visualizar    := GbInstitution.User.getPrivilege;

end;

procedure TBaseSearch.SetRegister;
begin
  //ser� implementada nas descendencias
  Search;
end;


procedure TBaseSearch.totalizer;
begin

end;

function TBaseSearch.validateGetView: Boolean;
begin
  Result := True;
  if not cds_search.Active then
  Begin
    MensagemPadrao('Mensagem de erro','A T E N � � O!.'+EOLN+EOLN+
                   'Nenhuma busca foi efetuada'+EOLN+
                   'Clique em buscar e tente novamente'+EOLN,
                  ['OK'],[bEscape],mpErro);

    Result := False;
    exit;
  end;

  if cds_search.RecordCount = 0 then
  Begin
    MensagemPadrao('Mensagem de erro','A T E N � � O!.'+EOLN+EOLN+
                   'N�o h� registros para visualizar'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
  end;

end;

{function TBaseSearch.validateGetView: Boolean;
begin
  Result := True;
  if not cds_search.Active then
  Begin
    MensagemPadrao('Mensagem','A T E N � � O!.'+EOLN+EOLN+
                   'Nenhuma busca foi efetuada.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;

  if cds_search.RecordCount = 0 then
  Begin
    MensagemPadrao('Mensagem','A T E N � � O!.'+EOLN+EOLN+
                   'N�o h� registros para visualizar.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;
  FSelecionado := True;
end; }

procedure TBaseSearch.GroupBySql;
begin
  //
end;

procedure TBaseSearch.IniciaVariaveis;
begin
  inherited;
  SB_Cadastrar.Enabled := Pf_Inserir;
  SB_Visualizar.Enabled := Pf_Visualizar;

  if FSelecionar then
  Begin
    SB_Cadastrar.Visible := False;
    SB_Visualizar.Caption:= 'Selecionar - F8';
  End
  else
  Begin
    SB_Cadastrar.Visible := True;
    SB_Visualizar.Caption:= 'Visualizar - F8';
  End;
  cds_search.Close;
end;

procedure TBaseSearch.InnerJoinSql;
begin
  //
end;

procedure TBaseSearch.OrderBySql;
begin
  //
end;

procedure TBaseSearch.returnRegister;
begin
  //
end;


procedure TBaseSearch.WhereSql;
begin
  //
end;

procedure TBaseSearch.Sb_Sair_0Click(Sender: TObject);
begin
  FSelecionado := False;
  Close;
end;

procedure TBaseSearch.SB_VisualizarClick(Sender: TObject);
begin
  if validateGetView then
    GetView;
end;

procedure TBaseSearch.SB_CadastrarClick(Sender: TObject);
begin
  SetRegister;
end;

procedure TBaseSearch.SB_BuscarClick(Sender: TObject);
begin
  Search;
  totalizer;
end;

{procedure TBaseSearch.SB_VisualizarClick(Sender: TObject);
begin
  if validateGetView then
    Begin
        if FSelecionar then
            Begin
                  returnRegister;
                        Self.Close
                            End
                                else
                                      GetView;
                                        End;
                                        end;}

end.

