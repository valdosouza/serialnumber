unit th_record_serial_number;

interface

uses
  Classes, SysUtils, Vcl.Forms, System.Threading, Winapi.Windows,
  ControllerSerialNumber, Vcl.ExtCtrls, System.SyncObjs, ComPort,
  Datasnap.DBClient, System.Generics.Collections,tblSerialNumber,
  FireDAC.Comp.Client, ControllerProductSerialNorma, System.StrUtils;

type
  TListSerialNumber = TObjectList<TSerialNumber>;

  TThRecordSerialNumber = class(TThread)
  private
    FCriticalSection: TCriticalSection;
    FSerialNumber : TControllerSerialNumber;
    FlistaSerialNumber : TListSerialNumber;
    FProduto: String;
    FReferencia: String;
    FProcessamento: TPanel;
    FDadoRecebido : String;
    FPortaCom: TComPort;
    FClienteDataSet: TFDMemTable;
    FGravacaoPorCiclo: Integer;
    FNorma : TControllerProductSerialNorma;
    FSerialSH: String;
    FSerialLN: String;
    procedure setFProduto(const Value: String);
    procedure setFReferencia(const Value: String);
    procedure setFProcessamento(const Value: TPanel);
    procedure InsereRegistroSerial;
    procedure AtualizaRegistroSerial;
    procedure setFPortaCom(const Value: TComPort);
    procedure setFClienteDataSet(const Value: TFDMemTable);
    procedure InsereClientDataSet;
    procedure AtualizaClientDataSet;
    procedure GerarArquivoNumeroSerial(lista:TListSerialNumber);
    procedure DeletaArquivoNumeroSerial;
    procedure setFGravacaoPorCiclo(const Value: Integer);
    procedure setFSerialSH(const Value: String);
    procedure setFSerialLN(const Value: String);
  protected

  public
    constructor Create();
    destructor Destroy; override;
    procedure stop;
    procedure Execute;override;
    procedure ReceiveCallBack(Valor: String);

    property Produto : String read FProduto write setFProduto;
    property Referencia : String read FReferencia write setFReferencia;
    property Processamento : TPanel read FProcessamento write setFProcessamento;
    property PortaCom : TComPort read FPortaCom write setFPortaCom;
    property ClienteDataSet : TFDMemTable read FClienteDataSet write setFClienteDataSet;
    property GravacaoPorCiclo : Integer read FGravacaoPorCiclo write setFGravacaoPorCiclo;
    property SerialSH : String read FSerialSH write setFSerialSH;
    property SerialLN : String read FSerialLN write setFSerialLN;
  end;

implementation

{ TThreadLoadGeneral }

uses Un_DM, env;

procedure TThRecordSerialNumber.AtualizaClientDataSet;
begin
  FClienteDataSet.Edit;
  FClienteDataSet.FieldByName('status').AsString          := FSerialNumber.Historico.Registro.Situacao;
  FClienteDataSet.FieldByName('description').AsString     := FSerialNumber.Historico.Registro.Descricao;
  FClienteDataSet.Post;
end;

procedure TThRecordSerialNumber.AtualizaRegistroSerial;
begin
  with FSerialNumber do
  Begin
    Try
      FProcessamento.Caption := 'Atualizando Situação da peça.';
      Try
        Historico.Registro.Situacao := 'Gravação';
        Historico.Registro.Descricao := '';
      Except
        on E: Exception do
        Begin
          Historico.Registro.Situacao := 'Falha';
          Historico.Registro.Descricao := E.Message;
        End;
      End;
    Finally
      Historico.update;
      if Historico.Registro.Situacao = 'Falha' then
        FProcessamento.Caption := Historico.Registro.Descricao
      else
        FProcessamento.Caption := 'Processamento: Operação executada com Sucesso'
    End;
  End;
end;

constructor TThRecordSerialNumber.Create;
begin
  inherited Create (True);
  FreeOnTerminate := True;
  FSerialNumber := TControllerSerialNumber.Create(nil);
  FCriticalSection := TCriticalSection.Create;
  FDadoRecebido := '';
  FlistaSerialNumber := TListSerialNumber.Create;
  FNorma := TControllerProductSerialNorma.Create(nil);
end;

procedure TThRecordSerialNumber.DeletaArquivoNumeroSerial;
var
  Lc_file_name:String;
  Lc_file_path : String;
begin
  Lc_file_name := 'qrcode.txt';
  Lc_file_path := concat(GbPathExe + Lc_file_name);
  if FileExists(Lc_file_path) then
    DeleteFile(PChar(Lc_file_path));
end;

destructor TThRecordSerialNumber.Destroy;
begin
  FSerialNumber.DisposeOf;
  FlistaSerialNumber.DisposeOf;
  FNorma.DisposeOf;
  inherited;
end;

procedure TThRecordSerialNumber.execute;
Var
  I : Integer;
  Lc_item : TSerialNumber;
begin
  while not Terminated do
  begin
    // Aguarda o sinal de prontidão da gravadora
    FProcessamento.Caption := 'Aguardando Fechamento do Compartimento.';
    repeat
      Sleep(100);
    until (FDadoRecebido = '1')  or
          ((FDadoRecebido = '') and  Terminated) OR
          ((FDadoRecebido = '0') and Terminated);

    if Terminated then
      Break;
    // Geração do número serial
    FProcessamento.Caption := 'Gerando Serial no Banco de Dados.';
    //inicia o loop (implementação
    FlistaSerialNumber.Clear;
    for I := 1 to FGravacaoPorCiclo do
    Begin
      InsereRegistroSerial;
      //Guarda na lista para as gravações fisicas
      Lc_item := TSerialNumber.Create;
      Lc_item.Codigo          := FSerialNumber.Registro.Codigo;
      Lc_item.Estabelecimento := FSerialNumber.Registro.Estabelecimento;
      Lc_item.Produto         := FSerialNumber.Registro.Produto;
      Lc_item.Number          := FSerialNumber.Registro.Number;
      Lc_item.Sequencia       := FSerialNumber.Registro.Sequencia;
      FlistaSerialNumber.Add(Lc_item);
      //Grava na Grid para o Usuario acompanhar
      TThread.Synchronize(nil,
          procedure
          begin
            InsereClientDataSet;
          end
        );
      Sleep(200);
    End;

    FProcessamento.Caption := 'Aguardando gravação física na peça.';

    {Envia Sinal para o equipamento de gração}
    //FPortaCom.send( FSerialNumber.Registro.Number  );       //+ #13#10
    //Deleta o arquivo para garantir que o processo será do zero
    DeletaArquivoNumeroSerial;
    //Gera o arquivo para a gravadora ler
    GerarArquivoNumeroSerial(FlistaSerialNumber);
    Sleep(100);
    {Aguardando a abertura da Tampa e envio do sinal para Atualizar}
    FDadoRecebido := '1';
    FProcessamento.Caption := 'Aguardando finalização da gravação.';
    repeat
      Sleep(100);
    until (FDadoRecebido = '0');
    //Deletar o arquivo para que o gravadora não leia o arquivo em outro momento
    DeletaArquivoNumeroSerial;
    //Atualizar a situação do processo de gravação
    for I := 0 to FlistaSerialNumber.Count-1 do
    Begin
      FSerialNumber.Historico.Registro.SerialNumberId := FlistaSerialNumber[I].Codigo;
      FSerialNumber.Historico.getBySerialNumber;
      AtualizaRegistroSerial;
    End;
    //Atualiza o Dataset para acompanhamento do Usuario
    FClienteDataSet.First;
    while not FClienteDataSet.Eof do
    Begin
      if FClienteDataSet.FieldByName('status').AsString = 'em andamento' then
      Begin
        AtualizaClientDataSet;
      end;
      FClienteDataSet.Next;
    End;
    FClienteDataSet.Last;
  end;
end;


procedure TThRecordSerialNumber.GerarArquivoNumeroSerial(Lista: TListSerialNumber);
var
  Lc_file_name:String;
  Lc_file_path : String;
  lc_arquivo:TextFile;
  I : Integer;
  Lc_norma_id : String;
begin
  Try
    Lc_file_name := 'qrcode.txt';
    Lc_file_path := concat(GbPathExe + Lc_file_name);
    AssignFile (lc_arquivo, Lc_file_path );
    Rewrite ( lc_arquivo );
    for I := 0 to Lista.Count -1 do
    Begin
      FNorma.Registro.Estabelecimento  :=  Lista[I].Estabelecimento;
      FNorma.Registro.Produto          := Lista[I].Produto;
      Lc_norma_id := FNorma.getNorma;
      //NÃO INFORMADA
      //PF.901106
      //FPW.PTTSTR
      case AnsiIndexStr(UpperCase(Trim(Lc_norma_id)), ['NÃO INFORMADA', 'PF.901106','FPW.PTTSTR']) of
        0:Begin
            Writeln(lc_arquivo,Lista[I].Number);
        End;
        1:Begin//PF.901106
            Writeln(lc_arquivo,Copy(Lista[I].Number,1,11));
            Writeln(lc_arquivo,Copy(Lista[I].Number,12,5));
            Writeln(lc_arquivo,Copy(Lista[I].Number,17,5));
            Writeln(lc_arquivo,Copy(Lista[I].Number,22,5));
            Writeln(lc_arquivo,'');
        End;
        2:Begin//FPW.PTTSTR
            Writeln(lc_arquivo,Copy(Lista[I].Number,1,10));
            Writeln(lc_arquivo,Copy(Lista[I].Number,11,11));
            Writeln(lc_arquivo,Copy(Lista[I].Number,22,10));
            Writeln(lc_arquivo,Copy(Lista[I].Number,32,7));
            Writeln(lc_arquivo,'');
        End
        else
          Writeln(lc_arquivo,Lista[I].Number);
      end;

    End;
  Finally
    CloseFile(lc_arquivo);
  End;



end;

procedure TThRecordSerialNumber.InsereRegistroSerial;
begin
  with FSerialNumber do
  Begin
    clear;
    Registro.Codigo           := '';
    Registro.Estabelecimento  := GbInstitution.Registro.Codigo;
    Registro.Produto          := FProduto;
    Registro.Number           := FReferencia;
    FSerialNumber.SerialSH    := self.SerialSH;
    FSerialNumber.SerialLN    := self.SerialLN;
    insert;
    //
    Historico.Registro.Codigo         := '';
    Historico.Registro.SerialNumberId := FSerialNumber.Registro.Codigo;
    Historico.Registro.Usuario        := GbInstitution.User.Registro.Codigo;
    Historico.Registro.Situacao       := 'em andamento';
    Historico.Registro.Descricao      := '';
    Historico.insert;
  End;
end;

procedure TThRecordSerialNumber.InsereClientDataSet;
begin
  FClienteDataSet.Append;
  FClienteDataSet.FieldByName('serialNumberId').AsString  := FSerialNumber.Registro.Codigo;
  FClienteDataSet.FieldByName('number').AsString          := FSerialNumber.Registro.Number;
  FClienteDataSet.FieldByName('status').AsString          := FSerialNumber.Historico.Registro.Situacao;
  FClienteDataSet.FieldByName('description').AsString     := FSerialNumber.Historico.Registro.Descricao;
  FClienteDataSet.Post;
end;

procedure TThRecordSerialNumber.ReceiveCallBack(Valor: String);
begin
  try
    FCriticalSection.Enter; // Bloqueia o acesso a outros threads
    FDadoRecebido := Valor;
  finally
    FCriticalSection.Leave; // Libera o acesso para outros threads
  end;
end;

procedure TThRecordSerialNumber.setFClienteDataSet(const Value: TFDMemTable);
begin
  FClienteDataSet := Value;
end;

procedure TThRecordSerialNumber.setFGravacaoPorCiclo(const Value: Integer);
begin
  FGravacaoPorCiclo := Value;
end;

procedure TThRecordSerialNumber.setFPortaCom(const Value: TComPort);
begin
  FPortaCom := Value;
end;

procedure TThRecordSerialNumber.setFProcessamento(const Value: TPanel);
begin
  FProcessamento := Value;
  FProcessamento.Visible := True;
end;

procedure TThRecordSerialNumber.setFProduto(const Value: String);
begin
  FProduto := Value;
end;

procedure TThRecordSerialNumber.setFReferencia(const Value: String);
begin
  FReferencia := Value;
end;

procedure TThRecordSerialNumber.setFSerialLN(const Value: String);
begin
  FSerialLN := Value;
end;

procedure TThRecordSerialNumber.setFSerialSH(const Value: String);
begin
  FSerialSH := Value;
end;

procedure TThRecordSerialNumber.stop;
begin
  terminate;
  FProcessamento.Caption := 'Terminando a última operação de gravação.';
end;

end.
