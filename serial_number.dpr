program serial_number;

uses
  Vcl.Forms,
  Winapi.Windows,
  uMain in 'view\uMain.pas' {Main},
  un_dm in 'un_dm.pas' {DM: TDataModule},
  Un_Base in 'repository\Un_Base.pas' {Fr_Base},
  base_search in 'repository\base_search.pas' {BaseSearch},
  base_registry in 'repository\base_registry.pas' {BaseRegistry},
  base_frame_list in 'repository\base_frame_list.pas' {BaseFrameList: TFrame},
  UnFunctions in 'helper\UnFunctions.pas',
  env in 'helper\env.pas',
  lis_frame_product in 'view\lis_frame_product.pas' {listFrameProduct: TFrame},
  lis_frame_user in 'view\lis_frame_user.pas' {ListFrameUser: TFrame},
  tas_config in 'view\tas_config.pas' {TasConfig};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TDM, DM);
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TTasConfig, TasConfig);
  if GbExecApplication then
    Application.Run
  else
    winexec('taskkill /f /im Gestao.exe',sw_hide);
end.
