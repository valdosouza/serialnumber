unit lis_frame_product;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_frame_list, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TlistFrameProduct = class(TBaseFrameList)
    Label37: TLabel;
    E_Reference: TEdit;
    procedure E_ReferenceExit(Sender: TObject);
    procedure DBLCB_ListaClick(Sender: TObject);
    procedure DBLCB_ListaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  protected
    procedure GeraConsulta;Override;
  public
    { Public declarations }
  end;

var
  listFrameProduct: TlistFrameProduct;

implementation

{$R *.dfm}

{ TlistFrameProduct }

procedure TlistFrameProduct.DBLCB_ListaClick(Sender: TObject);
begin
  inherited;
  E_Reference.Clear;
  if DBLCB_Lista.Text <> '' then
    E_Reference.Text := Qr_Lista.FieldByName('reference').AsString;
end;

procedure TlistFrameProduct.DBLCB_ListaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  E_Reference.Clear;
  inherited;

end;

procedure TlistFrameProduct.E_ReferenceExit(Sender: TObject);
begin
  inherited;
  if trim(E_Reference.Text) <> '' then
  Begin
    if Qr_Lista.Locate('reference',E_Reference.Text,[]) then
      DBLCB_Lista.KeyValue := Qr_Lista.FieldByName('id').AsString;
  End;

end;

procedure TlistFrameProduct.GeraConsulta;
begin
  with Qr_Lista do
  Begin
    SQL.Clear;
    SQL.Add(concat(
               ' Select id, tb_institution_id, reference, description   '+
               ' from tb_product p ',
               ' where active =:active '
             ));
    ParamByName('active').AsString :=  'S';
  End;
end;

end.
