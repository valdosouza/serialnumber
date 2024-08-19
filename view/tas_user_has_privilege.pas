unit tas_user_has_privilege;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_base, Vcl.Menus, Data.DB, Datasnap.DBClient,
  un_dm,   Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.CheckLst, ControllerUser;

type

  TTasUserHasPrivilege = class(TFr_Base)
    pnl_fundos: TPanel;
    dbg_modules: TDBGrid;
    cds_modules: TClientDataSet;
    cds_modulesdescription: TStringField;
    ds_modules: TDataSource;
    cds_interfaces: TClientDataSet;
    ds_interfaces: TDataSource;
    dbg_interface: TDBGrid;
    pnl_buttons: TPanel;
    Sb_Close: TSpeedButton;
    cds_interfacesdescription: TStringField;
    Sb_Apply: TSpeedButton;
    Sb_Cancel: TSpeedButton;
    cds_modulesid: TStringField;
    cds_interfacesid: TStringField;
    ChlBx_Permissao: TCheckListBox;
    procedure cds_modulesAfterScroll(DataSet: TDataSet);
    procedure Sb_CloseClick(Sender: TObject);
    procedure cds_interfacesAfterScroll(DataSet: TDataSet);
    procedure Sb_ApplyClick(Sender: TObject);
    procedure Sb_CancelClick(Sender: TObject);
    procedure dbg_modulesCellClick(Column: TColumn);
    procedure ChlBx_PermissaoClick(Sender: TObject);
    procedure ChlBx_PermissaoClickCheck(Sender: TObject);
  private
    { Private declarations }
    Procedure ShowModules;
    Procedure ShowInterfaces;
    Procedure Showprivileges;
    procedure SavePrivilege;
    procedure StatusButton(Enab:Boolean);
  protected

    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;

  public
    { Public declarations }
    User : TControllerUser;
  end;

var
  TasUserHasPrivilege: TTasUserHasPrivilege;

implementation

{$R *.dfm}

uses uMain, env;


{ TTasUserHasPrivilege }

procedure TTasUserHasPrivilege.cds_interfacesAfterScroll(DataSet: TDataSet);
begin
  inherited;
  Showprivileges;
  StatusButton(False);
end;

procedure TTasUserHasPrivilege.cds_modulesAfterScroll(DataSet: TDataSet);
begin
  inherited;
  ShowInterfaces;
  cds_interfacesAfterScroll(cds_interfaces);
end;

procedure TTasUserHasPrivilege.ChlBx_PermissaoClick(Sender: TObject);
begin
  inherited;
  Sb_Apply.Enabled := true;
  Sb_Cancel.Enabled := true;
end;

procedure TTasUserHasPrivilege.ChlBx_PermissaoClickCheck(Sender: TObject);
Var
  Lc_I : Integer;
begin
  inherited;
  Lc_I :=  TCheckListBox(Sender).ItemIndex;
  if (ChlBx_Permissao.Checked[Lc_I]) then
    User.ListaPrivilegio[Lc_I].Ativo := 'S'
  else
    User.ListaPrivilegio[Lc_I].Ativo := 'N';
end;

procedure TTasUserHasPrivilege.CriarVariaveis;
begin
  inherited;
  User := TControllerUser.Create(Self);
end;

procedure TTasUserHasPrivilege.dbg_modulesCellClick(Column: TColumn);
begin
 inherited;
  ShowInterfaces;
  cds_interfacesAfterScroll(cds_interfaces);
end;

procedure TTasUserHasPrivilege.FormataTela;
begin
  inherited;

end;

procedure TTasUserHasPrivilege.SavePrivilege;
Var
  I : Integer;
begin
  with  User  do
  Begin
    for I := 0 to ListaPrivilegio.Count - 1 do
    Begin
      HasPrivilegio.clear;
      HasPrivilegio.Registro.Estabelecimento  := HasInstitution.Registro.Estabelecimento;
      HasPrivilegio.Registro.Usuario          := User.Registro.Codigo;
      HasPrivilegio.Registro.TelaInterface    := cds_interfacesid.AsString;
      HasPrivilegio.Registro.Privilegio       := ListaPrivilegio[i].Codigo;
      if (ListaPrivilegio[i].Ativo = 'S') then
        HasPrivilegio.Registro.Ativo  := 'S'
      else
        HasPrivilegio.Registro.Ativo  := 'N';
      HasPrivilegio.save;
    End;
  End;
end;

procedure TTasUserHasPrivilege.Sb_ApplyClick(Sender: TObject);
begin
  SavePrivilege;
  StatusButton(False);
end;

procedure TTasUserHasPrivilege.Sb_CancelClick(Sender: TObject);
begin
  Showprivileges;
  StatusButton(False);
end;

procedure TTasUserHasPrivilege.Sb_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TTasUserHasPrivilege.IniciaVariaveis;
begin
  inherited;
  User.getAllByKey;
  ShowModules;
  cds_modulesAfterScroll(cds_modules);
end;

procedure TTasUserHasPrivilege.ShowInterfaces;
Var
  I : Integer;
begin
  if cds_modules.active then
  Begin
    if cds_modulesid.AsString <> '' then
    Begin
      cds_interfaces.AfterScroll := nil;
      GbInstitution.Module.Interfaces.getUsedList(cds_modulesid.AsString,'');
      with self.cds_interfaces, GBInstitution.Module.Interfaces  do
      Begin
        Active := False;
        CreateDataSet;
        EmptyDataSet;
        LogChanges := False;
        DisableControls;
        for I := 0 to Lista.Count - 1 do
        Begin
          Append;
          FieldByName('id').AsString         := Lista[I].Codigo;
          FieldByName('description').AsString := Lista[I].Descricao;
          Post;
        End;
        First;
        LogChanges := True;
        EnableControls;
      End;
      cds_interfaces.AfterScroll := cds_interfacesAfterScroll;
    End;
  End;
end;

procedure TTasUserHasPrivilege.ShowModules;
Var
  I : Integer;
begin
  GbInstitution.Module.getUsedList(user.HasInstitution.Registro.Estabelecimento);
  cds_modules.AfterScroll := nil;
  with self.cds_modules, GBInstitution.Module  do
  Begin
    Active := False;
    CreateDataSet;
    EmptyDataSet;
    LogChanges := False;
    DisableControls;
    for I := 0 to Lista.Count - 1 do
    Begin
      if Lista[I].Descricao <> 'Sair' then
      Begin
        Append;
        FieldByName('id').AsString         := Lista[I].Codigo;
        FieldByName('description').AsString := Lista[I].Descricao;
        Post;
      End;
    End;
    First;
    LogChanges := True;
    EnableControls;
  End;
  cds_modules.AfterScroll := cds_modulesAfterScroll;
end;

procedure TTasUserHasPrivilege.Showprivileges;
Var
  I : Integer;
begin
  User.Parametro.Estabelecimento := user.HasInstitution.Registro.Estabelecimento;
  User.Parametro.Usuario         := User.Registro.Codigo;
  User.Parametro.TelaInterface   := cds_interfacesid.AsString;
  User.getListprivilege;

  with User  do
  Begin
    ChlBx_Permissao.Items.Clear;
    for I := 0 to ListaPrivilegio.Count - 1 do
    Begin
      ChlBx_Permissao.Items.Add(ListaPrivilegio[i].Descricao);
      ChlBx_Permissao.Checked[I] := (ListaPrivilegio[i].Ativo = 'S');
    End;
  End;
end;

procedure TTasUserHasPrivilege.StatusButton(Enab: Boolean);
begin
  Sb_Apply.Enabled := Enab;
  Sb_Cancel.Enabled := Enab;
end;

end.
