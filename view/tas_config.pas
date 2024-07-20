unit tas_config;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TTasConfig = class(TFr_Base)
    pnl_bottom: TPanel;
    pnl_body: TPanel;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    Label1: TLabel;
    E_path_execad: TEdit;
    procedure SB_CancelarClick(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
  private
  protected
    procedure IniciaVariaveis;Override;
  public
    { Public declarations }
  end;

var
  TasConfig: TTasConfig;

implementation

{$R *.dfm}

procedure TTasConfig.IniciaVariaveis;
begin
  inherited;
  E_path_execad.Text :=  ConfigFile('L','PROGRAMA','PATH_EZECAD','');
end;

procedure TTasConfig.SB_CancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TTasConfig.SB_GravarClick(Sender: TObject);
begin
  ConfigFile('G','PROGRAMA','PATH_EZECAD',E_path_execad.Text);
  Close;
end;

end.
