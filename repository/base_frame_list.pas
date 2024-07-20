unit base_frame_list;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TBaseFrameList = class(TFrame)
    DBLCB_Lista: TDBLookupComboBox;
    Lb_Lista: TLabel;
    pnl_Lista: TPanel;
    Qr_Lista: TFDQuery;
    Ds_Lista: TDataSource;
    procedure DBLCB_ListaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  protected
    procedure GeraConsulta;Virtual;
  public
    procedure Listar;
  end;

implementation

{$R *.dfm}

uses un_dm;

{ TBaseFrameList }

procedure TBaseFrameList.DBLCB_ListaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
      begin
        DBLCB_Lista.KeyValue := Null;
      end;
    end;
end;

procedure TBaseFrameList.GeraConsulta;
begin

end;

procedure TBaseFrameList.Listar;
begin
  with Qr_Lista do
  Begin
    Active := False;
    GeraConsulta;
    Active := true;
    FetchAll;
  end;
end;

end.
