unit tas_serial_number_record;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.ExtCtrls,
  ControllerSerialNumber, Vcl.Buttons, base_frame_list, lis_frame_product,
  Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient,
  cad_img_product,th_record_serial_number, ComPort, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,ControllerProduct, Winapi.TlHelp32;

type
  TTasSerialNumberRecord = class(TFr_Base)
    pnl_fundo: TPanel;
    pnl_botao: TPanel;
    SB_Start: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    SB_Stop: TSpeedButton;
    listFrameProduct: TlistFrameProduct;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    ds_search: TDataSource;
    Pnl_Produto: TPanel;
    Button1: TButton;
    Pnl_Processamento: TPanel;
    ConfiguraDispositivo1: TMenuItem;
    ComPort: TComPort;
    cds_search: TFDMemTable;
    cds_searchserialNumberId: TStringField;
    cds_searchnumber: TStringField;
    cds_searchstatus: TStringField;
    cds_searchdescription: TStringField;
    pnl_ciclo: TPanel;
    Lb_qtty_record: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    E_qtty_record: TEdit;
    E_SH: TEdit;
    E_LN: TEdit;
    Label4: TLabel;
    E_mask_default: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure SB_StartClick(Sender: TObject);
    procedure SB_StopClick(Sender: TObject);
    procedure ConfiguraDispositivo1Click(Sender: TObject);
    procedure ComPortPortOpen(Sender: TObject);
    procedure ComPortReceiveCallBack(Data: string);
    procedure listFrameProductDBLCB_ListaClick(Sender: TObject);
    procedure E_qtty_recordExit(Sender: TObject);
  private
    FRecordSerialNumber : TThRecordSerialNumber;
    FPortaAberta : Boolean;
    FProduct : TControllerProduct;

    procedure ConfigDEvice;
    procedure AbrirPortaCom;
    procedure FecharPortaCom;
    function ValidateProductList:Boolean;
    function ValidateSeeImage:Boolean;
    procedure SeeImage;
    function ValidateStartProcess:Boolean;
    procedure StartProcess;
    procedure StopProcess;
    procedure EditionControler;
    procedure FinalizarOperacao(Sender: TObject);
    function VerificaEzCad2: Boolean;
    procedure onterminateProcess(Sender: TObject);
  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FinalizaVariaveis;Override;

  public
    { Public declarations }
  end;

var
  TasSerialNumberRecord: TTasSerialNumberRecord;

implementation

{$R *.dfm}

uses Un_Msg, cfg_device, env;



{ TTasSerialNumberRecord }

procedure TTasSerialNumberRecord.AbrirPortaCom;
begin
  ComPort.Port := ConfigFile('L','DEVICE','PORTA','');
  ComPort.Open;
end;

procedure TTasSerialNumberRecord.Button1Click(Sender: TObject);
begin
  if ValidateSeeImage then
    SeeImage;

end;

procedure TTasSerialNumberRecord.ComPortPortOpen(Sender: TObject);
begin
  inherited;
  FPortaAberta := True;
end;

procedure TTasSerialNumberRecord.ComPortReceiveCallBack(Data: string);
begin
  inherited;
  FRecordSerialNumber.ReceiveCallBack(Data);
end;

procedure TTasSerialNumberRecord.ConfigDEvice;
begin
  ComPort.Baud      := StrToIntDef(ConfigFile('L','DEVICE','BAUDRATE',''),9600);
  ComPort.DataBits.Parse(ConfigFile('L','DEVICE','DATABITS',''));
  ComPort.Parity    := TParity(StrToIntDef(ConfigFile('L','DEVICE','PARIDADE',''),0));
  ComPort.Port      := ConfigFile('L','DEVICE','PORTA','');
  ComPort.StopBits  := TStopBit(StrToIntDef(ConfigFile('L','DEVICE','BITSPARADA',''),0));
end;

procedure TTasSerialNumberRecord.ConfiguraDispositivo1Click(Sender: TObject);
Var
  Lc_Form : TCfgDevice;
begin
  Lc_Form := TCfgDevice.Create(Self);
  try
    Lc_Form.ShowModal;
  finally
    Lc_Form.DisposeOf;
  end;
end;

procedure TTasSerialNumberRecord.CriarVariaveis;
begin
  inherited;
  FProduct := TControllerProduct.Create(Self);
end;

procedure TTasSerialNumberRecord.EditionControler;
begin
  if EditionState = 'I' then
  Begin
    Pnl_Produto.Enabled := False;
    SB_Start.Enabled    := False;
    SB_Stop.Enabled     := True;
    SB_Sair_0.Enabled   := False;
    Pnl_Processamento.Visible := True;
    Pnl_Processamento.Caption := 'Processamento: Iniciando....';
  End
  else
  Begin
    Pnl_Produto.Enabled := True;
    SB_Start.Enabled    := True;
    SB_Stop.Enabled     := False;
    SB_Sair_0.Enabled   := true;
    Pnl_Processamento.Visible := False;
  End;
end;

procedure TTasSerialNumberRecord.E_qtty_recordExit(Sender: TObject);
begin
  TEdit(sender).Text := IntToStr(StrToIntDef(TEdit(sender).Text,1));
end;

procedure TTasSerialNumberRecord.FecharPortaCom;
begin
  ComPort.Close;
end;

procedure TTasSerialNumberRecord.FinalizarOperacao(Sender: TObject);
begin
  Try
    EditionState := 'B';
    EditionControler;
    FecharPortaCom;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TTasSerialNumberRecord.FinalizaVariaveis;
begin
  FreeAndNil(FProduct);
  inherited;
end;

procedure TTasSerialNumberRecord.IniciaVariaveis;
begin
  inherited;
  listFrameProduct.Listar;
  FPortaAberta := False;
  cds_search.CreateDataSet;
end;

procedure TTasSerialNumberRecord.listFrameProductDBLCB_ListaClick(
  Sender: TObject);
begin
  inherited;
  listFrameProduct.DBLCB_ListaClick(Sender);
  FProduct.Registro.Codigo := listFrameProduct.Qr_Lista.FieldByName('id').AsString;
  FProduct.Registro.Estabelecimento:= GbInstitution.Registro.Codigo;
  FProduct.getByKey;
  E_mask_default.Text := FProduct.Registro.MascaraPadrao;

end;

procedure TTasSerialNumberRecord.onterminateProcess(Sender: TObject);
begin
  E_qtty_record.ReadOnly := False;
  E_SH.ReadOnly := False;
  E_LN.ReadOnly := False;
end;

procedure TTasSerialNumberRecord.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TTasSerialNumberRecord.SB_StartClick(Sender: TObject);
begin
  if ValidateStartProcess then
  BEgin
    EditionState := 'I';
    EditionControler;
    StartProcess;
  End;
end;

procedure TTasSerialNumberRecord.SB_StopClick(Sender: TObject);
begin
  StopProcess;
end;

procedure TTasSerialNumberRecord.SeeImage;
Var
  Lc_Form: TCadImgProduct;
Begin
  Lc_Form := TCadImgProduct.Create(Self);
  Try
    Lc_Form.CodigoRegistro := listFrameProduct.Qr_Lista.FieldByName('id').AsString;
    Lc_Form.Lb_Produto.Caption := concat('Produto: ', listFrameProduct.Qr_Lista.FieldByName('reference').AsString, ' - ', listFrameProduct.Qr_Lista.FieldByName('description').AsString);
    Lc_Form.ShowModal;
  Finally
    Lc_Form.DisposeOf;
  End;
end;

procedure TTasSerialNumberRecord.StartProcess;
begin
  E_qtty_record.ReadOnly := True;
  E_SH.ReadOnly := True;
  E_LN.ReadOnly := True;

  FRecordSerialNumber := nil;
  FRecordSerialNumber := TThRecordSerialNumber.Create;
  FRecordSerialNumber.OnTerminate := FinalizarOperacao;
  FRecordSerialNumber.Produto     := listFrameProduct.Qr_Lista.FieldByName('id').AsString;
  FRecordSerialNumber.Referencia  := listFrameProduct.Qr_Lista.FieldByName('reference').AsString;
  FRecordSerialNumber.Processamento := Pnl_Processamento;
  FRecordSerialNumber.PortaCom := ComPort;
  FRecordSerialNumber.ClienteDataSet := cds_search;
  FRecordSerialNumber.GravacaoPorCiclo := StrToIntDef(E_qtty_record.Text,1);
  FRecordSerialNumber.SerialSH := E_SH.text;
  FRecordSerialNumber.SerialLN := E_LN.text;
  FRecordSerialNumber.FreeOnTerminate := true;
  FRecordSerialNumber.OnTerminate := onterminateProcess;
  FRecordSerialNumber.Start;

end;

procedure TTasSerialNumberRecord.StopProcess;
begin
  FRecordSerialNumber.stop;
  Pnl_Processamento.Caption := 'Processamento: Parando...Aguarde a finalização da gravação';
end;

function TTasSerialNumberRecord.ValidateProductList: Boolean;
begin
  Result := True;
  if listFrameProduct.DBLCB_Lista.Text = '' then
  Begin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Por favor Escolha um produto na lista.'+EOLN+
                   'Preencha o campo para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    Exit;
  End;

end;

function TTasSerialNumberRecord.ValidateSeeImage: Boolean;
begin
  Result := True;
  if not getPrivilege('Cadastro Produto','VISUALIZAR') then
  Begin
    Result := false;
    exit;
  End;

  if not ValidateProductList then
  Begin
    result:=False;
    Exit;
  End;

end;

function TTasSerialNumberRecord.ValidateStartProcess: Boolean;
Var
  Lc_Ezecad : String;
begin
  Result := True;
  ConfigDEvice;

  if StrToIntDef(E_qtty_record.Text,0) = 0 then
  BEgin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'A quantidade de gravações por ciclo não informada.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    Exit;
  End;

  if not ValidateProductList then
  Begin
    result:=False;
    Exit;
  End;
  AbrirPortaCom;
  if not FPortaAberta then
  BEgin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Não foi possivel conectar com a Porta COM.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    Exit;
  End;

  //Valida a mascara do produto
  if (Trim(E_SH.Text) = '')  or (Trim(E_LN.Text)= '')  then
  Begin
    if (Trim(E_SH.Text) = '')then
    Begin
      if (Pos('SH',FProduct.Registro.MascaraPadrao) > 0) then
      Begin
        MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                       'A máscara do produto exige o preencimento do Campo SH.'+EOLN+
                       'Verifique e tente novamente.'+EOLN,
                      ['OK'],[bEscape],mpErro);
        E_SH.SetFocus;
        Result := False;
        exit;
      End;
    End;

    if (Trim(E_LN.Text) = '')then
    Begin
      if (Pos('LN',FProduct.Registro.MascaraPadrao) > 0) then
      Begin
        MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                       'A máscara do produto exige o preencimento do Campo LN.'+EOLN+
                       'Verifique e tente novamente.'+EOLN,
                      ['OK'],[bEscape],mpErro);
        E_SH.SetFocus;
        Result := False;
        exit;
      End;
    End;
  End;

  Lc_Ezecad := ConfigFile('L','PROGRAMA','PATH_EZECAD','');
  if Trim(Lc_Ezecad) <> '' then
  Begin
    if not VerificaEzCad2 then
    Begin
      MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'O Programa EzCad2.exe precisar estar aberto.'+EOLN+
                     'Verifique para continuar.'+EOLN,
                    ['OK'],[bEscape],mpErro);

      if (MensagemPadrao('Mensagem de Confirmação',
                       'O sistema Vai tentar abrir o sistema.' + EOLN +
                       'De qualquer forma verifique antes de continuar'+ EOLN +
                       'Confirmar a execução ?',
                       ['Sim', 'Não'], [bNormal,bEscape], mpConfirmacao, clBtnFace) = mrBotao1) then
      Begin
        WinExec(PAnsiChar(UTF8String(Lc_Ezecad)),SW_NORMAL);
      End;
    End;
    Result := False;
    exit;
  End;
end;

function TTasSerialNumberRecord.VerificaEzCad2: Boolean;
const
  PROCESS_TERMINATE=$0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32{declarar Uses Tlhelp32};
begin
  Result := False;

  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle,FProcessEntry32);

  while integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase('EzCad2.exe')) or
       (UpperCase(FProcessEntry32.szExeFile) = UpperCase('EzCad2.exe'))) then
    begin
      Result := true;
      exit;
    end;
    ContinueLoop := Process32Next(FSnapshotHandle,FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;


end.
