unit lis_frame_user;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_frame_list, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TListFrameUser = class(TBaseFrameList)
  private
  protected
    procedure GeraConsulta;Override;
  public
    { Public declarations }
  end;

var
  ListFrameUser: TListFrameUser;

implementation

{$R *.dfm}

{ TBaseFrameList1 }

procedure TListFrameUser.GeraConsulta;
begin
  with Qr_Lista do
  Begin
    SQL.Clear;
    SQL.Add(concat(
              'Select distinct u.id, en.name_company, ma.email ',
              'from tb_user u ',
              '  inner join tb_entity en on (u.id = en.id ) ',
              '  inner join tb_entity_has_mailing ehm ',
              '  on (ehm.tb_entity_id = en.id) ',
              '  and (ehm.tb_mailing_group_id = :tb_mailing_group_id) ',
              '  inner join tb_mailing ma on (ehm.tb_mailing_id = ma.id ) ',
              '  inner join tb_institution_has_user i ',
              '  on (u.id = i.tb_user_id) ',
              'where (i.active =:active) ',
              'order by en.name_company '
             ));
    ParamByName('tb_mailing_group_id').AsString :=  'F03F8E47-6D7B-4DF7-8581-92CD36616FD4';
    ParamByName('active').AsString :=  'S';
  End;
end;

end.
