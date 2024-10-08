unit Un_Base;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Data.Db, Vcl.Menus,Vcl.DBCtrls,BaseController,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,IniFiles,FireDAC.Stan.Param,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.Mask,  ControllerConfig,
  ControllerInstitution,  FireDAC.Comp.Client,  System.Generics.Collections,GenericOrm;


type
  TFr_Base = class(TForm)
    MnuMain: TMainMenu;
    arefas1: TMenuItem;
    Sair1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure CarregaImagemBotao(Sb: TSpeedButton;Fc_Operacao: String);
    procedure Sair1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  protected
    Pf_Inserir , Pf_Alterar, Pf_Excluir,Pf_Visualizar : Boolean;
    EditionState : String;
    Config : TControllerConfig;
    function ConfigSistema(Fc_Tipo: char; Fc_CAmpo: string; Fc_Conteudo: string): string;
    function ConfigFile(Fc_Tipo: char; Fc_Secao,Fc_Chave,Fc_Valor: string): string;
    procedure ImagemBotao;Virtual;
    procedure CriarVariaveis;Virtual;
    procedure IniciaVariaveis;Virtual;
    procedure FinalizaVariaveis;Virtual;
    function getPrivilege(TelaInterface,TipoPrivilegio: String): Boolean;

    procedure setPerfil;Virtual;
    procedure FormataTela;Virtual;
    procedure AtivaTabelas;Virtual;
    procedure ClearFields(T: TComponent);
    procedure EditionControler(T: TComponent);
    procedure execShorCutKeyReturn;Virtual;
    procedure execShorCutKeyF1;Virtual;
    procedure execShorCutKeyF2;Virtual;
    procedure execShorCutKeyF3;Virtual;
    procedure execShorCutKeyF4;Virtual;
    procedure execShorCutKeyF5;Virtual;
    procedure execShorCutKeyF6;Virtual;
    procedure execShorCutKeyF7;Virtual;
    procedure execShorCutKeyF8;Virtual;
    procedure execShorCutKeyF9;Virtual;
    procedure execShorCutKeyF10;Virtual;
    procedure execShorCutKeyF11;Virtual;
    procedure execShorCutKeyF12;Virtual;
    procedure execShorCutEsc;Virtual;
    procedure IniciaProcesso;
    procedure FinalizaProcesso;
  private
    { Private declarations }
  protected
    TelaInterface : String;
  public
    { Public declarations }
    CodigoRegistro : Integer;

  end;

var
  Fr_Base: TFr_Base;

implementation

{$R *.dfm}

uses Un_Msg, env;


{ TFr_Base }

procedure TFr_Base.EditionControler(T: TComponent);
Var
  I:Integer;
begin
  with T do
  Begin
    for I := 0 to ((ComponentCount)-1) do
    begin
      if (Components[I].ClassName = 'TEdit') then
      Begin
        if TEdit (Components[I]).Name = 'E_ID' then
          TEdit (Components[I]).ReadOnly := True
        else
          TEdit (Components[I]).ReadOnly := ( EditionState = 'B' );
      End;

      if (Components[I].ClassName = 'TMaskEdit') then
      Begin
        if TMaskEdit (Components[I]).Name = 'E_ID' then
          TMaskEdit (Components[I]).ReadOnly := True
        else
          TMaskEdit (Components[I]).ReadOnly := ( EditionState = 'B' );
      End;

      if (Components[I].ClassName = 'TDBLookupComboBox') then
        TDBLookupComboBox (Components[I]).ReadOnly := ( EditionState = 'B' );

      if (Components[I].ClassName = 'TMemo') then
        TMemo (Components[I]).ReadOnly := ( EditionState = 'B' );

      if (Components[I].ClassName = 'TCheckBox') then
        TCheckBox (Components[I]).Enabled := ( EditionState <> 'B' );

      if (Components[I].ClassName = 'TComboBox') then
        TComboBox (Components[I]).Enabled := ( EditionState <> 'B' );

      if (Components[I].ClassName = 'TRadioGroup') then
        TRadioGroup (Components[I]).Enabled := ( EditionState <> 'B' );

      if (Components[I].ClassName = 'TDateTimePicker') then
        TDateTimePicker (Components[I]).Enabled := ( EditionState <> 'B' );

      if (Components[I].ClassName = 'TTreeView') then
        TTreeView (Components[I]).Enabled := ( EditionState = 'B' );

//      if (Components[I].ClassName = 'TDBGrid') then
//        TDBGrid (Components[I]).ReadOnly := ( EditionState = 'B' );

      if (Components[I].ClassName = 'TSpeedButton') then
        TSpeedButton (Components[I]).Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );

      if (Components[I].ClassName = 'TButton') then
        TButton (Components[I]).Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );

    end;
  End;
end;

function TFr_Base.ConfigFile(Fc_Tipo: char; Fc_Secao,Fc_Chave,Fc_Valor: string): string;
var
   ArquivoIni: TIniFile;
   Lc_NameArq: string;
begin
  Result := '';
  Lc_NameArq := GbPathExe + 'CONFIG.INI';
  ArquivoIni := TIniFile.Create(Lc_NameArq);
  if Fc_Tipo = 'L' then
  begin
    if ArquivoIni.SectionExists(Fc_Secao) then
    begin
      Result := ArquivoIni.ReadString(Fc_Secao, Fc_CHave, fc_Valor);
      if Result = '' then
        Result := fc_Valor;
      ArquivoIni.DisposeOf;
      exit;
    end
    else
    begin
      ArquivoIni.WriteString(Fc_Secao, Fc_CHave, Fc_Valor);
      Result := Fc_Valor;
      ArquivoIni.DisposeOf;
    end;
  end
  else
  begin
    ArquivoIni.WriteString(Fc_Secao, Fc_CHave, Fc_Valor);
    Result := Fc_Valor;
    ArquivoIni.DisposeOf;
  end;

end;

function TFr_Base.ConfigSistema(Fc_Tipo: char; Fc_CAmpo,
  Fc_Conteudo: string): string;
begin
  with Config do
  Begin
    Registro.Campo := Fc_CAmpo;
    Registro.Conteudo := Fc_Conteudo;

    if Fc_Tipo = 'G' then
    Begin
      save;
    End
    else
    Begin

      if not exist then save;
    End;
    Result := Registro.Conteudo;
  End;
end;

procedure TFr_Base.execShorCutEsc;
begin

end;

procedure TFr_Base.execShorCutKeyF1;
begin

end;

procedure TFr_Base.execShorCutKeyF10;
begin

end;

procedure TFr_Base.execShorCutKeyF11;
begin

end;

procedure TFr_Base.execShorCutKeyF12;
begin

end;

procedure TFr_Base.execShorCutKeyF2;
begin

end;

procedure TFr_Base.execShorCutKeyF3;
begin

end;

procedure TFr_Base.execShorCutKeyF4;
begin

end;

procedure TFr_Base.execShorCutKeyF5;
begin

end;

procedure TFr_Base.execShorCutKeyF6;
begin

end;

procedure TFr_Base.execShorCutKeyF7;
begin

end;

procedure TFr_Base.execShorCutKeyF8;
begin

end;

procedure TFr_Base.execShorCutKeyF9;
begin

end;

procedure TFr_Base.execShorCutKeyReturn;
begin

end;

procedure TFr_Base.ClearFields(T: TComponent);
Var
  I:Integer;
begin
  with T do
  Begin
    for I := 0 to ((ComponentCount)-1) do
    begin
      if (Components[I].ClassName = 'TEdit') then
        TEdit (Components[I]).Clear;

      //if (Components[I].ClassName = 'TEdit_Setes') then
       // TEdit_Setes(Components[I]).Clear;

      if (Components[I].ClassName = 'TMemo') then
        TMemo (Components[I]).Clear;

      if (Components[I].ClassName = 'TCheckBox') then
      Begin
        if ( TCheckBox (Components[I]).name = 'chbx_cad_active' ) then
          TCheckBox (Components[I]).Checked := true
        else
        if ( TCheckBox (Components[I]).name = 'ChBx_Periodo' ) then
          TCheckBox (Components[I]).Checked := true
        else
          TCheckBox (Components[I]).Checked := False;
      End;

      if (Components[I].ClassName = 'TComboBox') then
        TComboBox (Components[I]).ItemIndex := 0;

      if (Components[I].ClassName = 'TDBLookupComboBox') then
        TDBLookupComboBox(Components[I]).KeyValue := Null;

      if (Components[I].ClassName = 'TRadioGroup') then
        TRadioGroup (Components[I]).ItemIndex := 0;

      if (Components[I].ClassName = 'TDateTimePicker') then
        TDateTimePicker (Components[I]).DateTime := Now;

      if (Components[I].ClassName = 'TTreeView') then
        TTreeView (Components[I]).Items.Clear;

       // Desativado em 18/08/17 fechando dbgrid ao inserir na Compossi��o
      //if (Components[I].ClassName = 'TDBGrid') then
        //TDBGrid (Components[I]).DataSource.DataSet.Close;
    end;
  End;

end;

procedure TFr_Base.CarregaImagemBotao(Sb: TSpeedButton;Fc_Operacao: String);
Var
  St_Image: TStream;
  St_BMP  : TBitmap;
  Lc_Qry  : TFDQuery;
  LcBase  : TBaseController;
Begin
  LcBase := TBaseController.create(nil);
  Lc_Qry := LcBase.createQuery;
  try
    with Lc_Qry do
    Begin
      sql.add(Concat(
                'SELECT OPF_IMAGEM ',
                'FROM TB_OPER_INTERFACE ',
                'WHERE OPF_DESCRICAO =:OPF_DESCRICAO '
      ));
      ParamByName('OPF_DESCRICAO').AsString :=  Fc_Operacao;
      Active := True;
      FetchAll;
      First;
      if recordCount > 0 then
      Begin
        St_Image := CreateBlobStream(FieldByName('OPF_IMAGEM'),bmRead);
        if St_Image.Size > 0 then
        begin
          St_BMP := TBitmap.Create;
          St_BMP.LoadFromStream(St_Image);
          Sb.Glyph.Assign(St_BMP);
          St_BMP.disposeOf;
        end;
        St_Image.disposeOf;
      End;
    End;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

procedure TFr_Base.CriarVariaveis;
begin
  Config := TControllerConfig.create(Self);
end;

procedure TFr_Base.AtivaTabelas;
begin
  //Ser� implementado nas classes Filhas
end;

procedure TFr_Base.IniciaProcesso;
begin
end;

procedure TFr_Base.IniciaVariaveis;
begin
  //Ser� implementado nas classes Filhas
end;

procedure TFr_Base.Sair1Click(Sender: TObject);
begin
  Close
end;

procedure TFr_Base.setPerfil;
begin

end;

procedure TFr_Base.FinalizaProcesso;
begin
end;

procedure TFr_Base.FinalizaVariaveis;
begin

end;

procedure TFr_Base.FormataTela;
begin
  //Ser� implementado nas classes Filhas
end;

procedure TFr_Base.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FinalizaVariaveis;
end;

procedure TFr_Base.FormCreate(Sender: TObject);
begin
  CriarVariaveis;
end;

procedure TFr_Base.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (shift = []) then
  begin
    case Key of
      VK_RETURN:execShorCutKeyReturn;
      VK_F1:execShorCutKeyF1;
      VK_F2:execShorCutKeyF2;
      VK_F3:execShorCutKeyF3;
      VK_F4:execShorCutKeyF4;
      VK_F5:execShorCutKeyF5;
      VK_F6:execShorCutKeyF6;
      VK_F7:execShorCutKeyF7;
      VK_F8:execShorCutKeyF8;
      VK_F9:execShorCutKeyF9;
      VK_F10:execShorCutKeyF10;
      VK_F11:execShorCutKeyF11;
      VK_F12:execShorCutKeyF12;
      VK_Escape:execShorCutEsc;
    end;
  end;
end;

procedure TFr_Base.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = #13) and not ( (ActiveControl is TDBMemo) or (ActiveControl is TMemo) ) then
   Begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;
end;

procedure TFr_Base.ImagemBotao;
Begin
  //Ser� implementado nas classes Filhas
end;

procedure TFr_Base.FormShow(Sender: TObject);
begin
  setPerfil;
  IniciaVariaveis;
  AtivaTabelas;
  FormataTela;
  ImagemBotao;
end;


function TFr_Base.getPrivilege(TelaInterface, TipoPrivilegio: String): Boolean;
begin
  Result := True;
  GbInstitution.User.Parametro.Estabelecimento  := GbInstitution.Registro.Codigo;
  GbInstitution.User.Parametro.Usuario          := GbInstitution.User.Registro.Codigo;
  GbInstitution.User.Parametro.TelaInterface    := TelaInterface;
  GbInstitution.User.Parametro.TipoPrivilegio   := TipoPrivilegio;
  if not GbInstitution.User.getPrivilege then
  Begin
    MensagemPadrao('Mensagem de alerta', 'A T E N � � O!.' + EOLN + EOLN +
                   'Usu�rio sem permiss�o. Verifique!' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  End;
end;

end.
