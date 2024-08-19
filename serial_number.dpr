program serial_number;

uses
  Vcl.Forms,
  Winapi.Windows,
  un_dm in 'un_dm.pas' {DM: TDataModule},
  Un_Base in 'repository\Un_Base.pas' {Fr_Base},
  base_search in 'repository\base_search.pas' {BaseSearch},
  base_registry in 'repository\base_registry.pas' {BaseRegistry},
  base_frame_list in 'repository\base_frame_list.pas' {BaseFrameList: TFrame},
  UnFunctions in 'helper\UnFunctions.pas',
  cad_img_product in 'view\cad_img_product.pas' {CadImgProduct},
  cad_product in 'view\cad_product.pas' {CadProduct},
  cad_user in 'view\cad_user.pas' {CadUser},
  cfg_device in 'view\cfg_device.pas' {CfgDevice},
  lis_frame_product in 'view\lis_frame_product.pas' {listFrameProduct: TFrame},
  lis_frame_user in 'view\lis_frame_user.pas' {ListFrameUser: TFrame},
  sea_product in 'view\sea_product.pas' {SeaProduct},
  sea_serial_number in 'view\sea_serial_number.pas' {SeaSerialNumber},
  sea_user in 'view\sea_user.pas' {SeaUSer},
  tas_change_password in 'view\tas_change_password.pas' {TasChangePassword},
  tas_config in 'view\tas_config.pas' {TasConfig},
  tas_serial_number_check in 'view\tas_serial_number_check.pas' {TasSerialNumberCheck},
  tas_serial_number_record in 'view\tas_serial_number_record.pas' {TasSerialNumberRecord},
  tas_user_has_privilege in 'view\tas_user_has_privilege.pas' {TasUserHasPrivilege},
  uMain in 'view\uMain.pas' {Main},
  un_connection_data in 'view\un_connection_data.pas' {Fr_ConnectionData},
  env in 'env.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TDM, DM);
  Application.CreateForm(TMain, Main);
  if GbExecApplication then
    Application.Run
  else
    winexec('taskkill /f /im Gestao.exe',sw_hide);

end.
