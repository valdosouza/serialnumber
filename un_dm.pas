unit un_dm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Phys.ODBCBase, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, System.IniFiles, Vcl.Forms;

type
  TDM = class(TDataModule)
    FDConnection: TFDConnection;
    FDPMSSQLLink: TFDPhysMSSQLDriverLink;
    Qr_Crud: TFDQuery;
    FDTransaction: TFDTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ConfiguraDB;
    procedure ConectaDB;
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Un_Msg, env, UnFunctions;

{$R *.dfm}

procedure TDM.ConectaDB;
begin
  try
    FDConnection.Connected := True;
    GbExecApplication := True;
  except
    MensagemPadrao( 'Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                    'Não foi possível Conectar o Banco de Dados.' + EOLN +
                    'Verifique os dados de Conexão.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    ValidaUserPassword;
    GbExecApplication := False;
  end;
end;

procedure TDM.ConfiguraDB;
var
  ArquivoIni: TIniFile;
  Lc_NameArq: string;
  Lc_User,Lc_Password : String;
begin
  GbPathExe := ExtractFilePath(Application.ExeName);
  Lc_NameArq := GbPathExe + 'CONFIG.INI';
  ArquivoIni := TIniFile.Create(Lc_NameArq);
  TRy
    if ArquivoIni.SectionExists('DB') then
    begin
      FDConnection.Connected := False;
      FDConnection.Params.Clear;

      Lc_User := descriptografar(GbSecretPrase,ArquivoIni.ReadString('DB','User_Name',''));
      Lc_Password := descriptografar(GbSecretPrase,ArquivoIni.ReadString('DB','Password',''));
      if (Lc_User <> '') and (Lc_Password <> '') then
      Begin
        FDConnection.Params.Add(concat('Database=',ArquivoIni.ReadString('DB','Database','')));
        FDConnection.Params.Add(concat('User_Name=',Lc_User));
        FDConnection.Params.Add(concat('Password=',Lc_Password));
        FDConnection.Params.Add(concat('Server=',ArquivoIni.ReadString('DB','Server','')));
        FDConnection.Params.Add(concat('DriverID=',ArquivoIni.ReadString('DB','DriverID','')));
      end;

    end;
  Finally
    ArquivoIni.DisposeOf;
  End;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
Begin
  ConfiguraDB;
  ConectaDB;
end;

end.
