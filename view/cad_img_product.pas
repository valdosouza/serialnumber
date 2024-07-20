unit cad_img_product;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,un_base,
  Un_JPEGImageExt , Vcl.Imaging.jpeg,base_registry,ControllerProductImage,
  Dialogs, Buttons, ExtCtrls, ComCtrls, StdCtrls, Mask, Grids, DBGrids, DBCtrls,
  Vcl.Menus, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TCadImgProduct = class(TBaseRegistry)
    Pnl_Navegacao: TPanel;
    pnl_topo: TPanel;
    nagevation: TDBNavigator;
    OpenDialogo: TOpenDialog;
    Lb_Produto: TLabel;
    img_produto: TImage;
    Qr_Imagem: TFDQuery;
    Qr_Imagemid: TStringField;
    Qr_Imagemtb_product_id: TStringField;
    Qr_Imagemcontent: TBlobField;
    Ds_Imagem: TDataSource;
    procedure nagevationClick(Sender: TObject; Button: TNavigateBtn);
  private
    FPath,FFile:String;
    procedure CarregaImagem;
    procedure AtivarListaImagens;
    procedure showImage;
  protected
    //Variaveis
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    //procedure ImagemBotao;Override;
    procedure FormataTela;Override;
    procedure setPerfil;Override;

    procedure ShowData;Override;
    procedure ShowNoData;Override;
    procedure ClearAllFields;Override;
    //inserir
    function ValidaInsert():boolean;Override;
    procedure Insert;Override;
    //Deletar
    function ValidateDelete():boolean;Override;
    procedure Delete;Override;
    //Salvar
    function ValidateSave():boolean;Override;
    procedure Save;Override;
    //Cancelar
    function ValidateCancel():boolean;Override;
    procedure Cancel;Override;


  public
    { Public declarations }
    Image : TControllerProductImage;



  end;

var
  CadImgProduct: TCadImgProduct;

implementation


{$R *.dfm}

uses Un_Msg, un_dm, env;


procedure TCadImgProduct.ClearAllFields;
Begin
  inherited;
end;

procedure TCadImgProduct.CriarVariaveis;
begin
  inherited;
  Image := TControllerProductImage.Create(self);
end;

procedure TCadImgProduct.Delete;
begin
  Image.Registro.Codigo := Qr_Imagemid.AsString;
  Image.delete;
  AtivarListaImagens;
  Qr_Imagem.First;
  showImage;
end;

procedure TCadImgProduct.FormataTela;
begin
  inherited;

end;

function TCadImgProduct.ValidaInsert: boolean;
begin
  Result := True;
  if not OpenDialogo.Execute then
  Begin
    Result := False;
    exit;
  end;

  if not FileExists(OpenDialogo.FileName) then
  Begin
    MensagemPadrao('Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   'Imagem não encontrado no caminho especificado.' + EOLN +
                   'Verifique o caminho e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;
end;

function TCadImgProduct.ValidateCancel: boolean;
begin
  REsult := true;
end;

function TCadImgProduct.ValidateDelete: boolean;
begin
  REsult := true;
  if not Qr_Imagem.Active then
  Begin
    MensagemPadrao('Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   'Lista de Imagens Vazia' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;

  if not Qr_Imagem.RecordCount > 0 then
  Begin
    MensagemPadrao('Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   'Imagem não encontrada' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;

  if (MensagemPadrao('Mensagem de Confirmação',
                      'Excluir a imagem de seus arquivos.' + EOLN + EOLN +
                      'Confirmar a exclusão ?',
                      ['Sim', 'Não'], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao2) then
  Begin
    Result := False;
    Exit;
  End;

end;

function TCadImgProduct.ValidateSave: boolean;
begin
  REsult := true;
  if not FileExists(FPath + '\' + FFile) then
  Begin
    MensagemPadrao('Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   'Arquivo da Imagem não encontrado.' + EOLN +
                   'Verifique o caminho e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;
end;


procedure TCadImgProduct.IniciaVariaveis;
begin
  if CodigoRegistro <> '' then
  Begin
    AtivarListaImagens;
  End;
  inherited;
end;

procedure TCadImgProduct.Insert;
begin
  img_produto.Picture.Graphic := nil;
  inherited;
  CarregaImagem;
end;

procedure TCadImgProduct.nagevationClick(Sender: TObject; Button: TNavigateBtn);
begin
  inherited;
  showImage;
end;

procedure TCadImgProduct.Save;
Var
  Lc_Ins : TFDQuery;
begin
  Image.Registro.Estabelecimento := GbInstitution.Registro.Codigo;
  //Codigo registro será o codigo do produto
  Image.Registro.Produto         := CodigoRegistro;
  Image.insert;
  Lc_Ins := Image.createQuery;
  try
    with Lc_Ins do
    Begin
      SQL.Add(concat(
              'update tb_product_image set ',
              '  content =:content ',
              'where id = :id '
      ));
      ParamByName('content').LoadFromFile(GbPathExe + 'temp\' + FFile , ftBlob);
      ParamByName('id').AsString := Image.Registro.Codigo;
      ExecSQL;
    End;
  finally
    Image.FinalizaQuery(Lc_Ins);
    AtivarListaImagens;
    Qr_Imagem.Last;
    showImage;
  end;
end;

procedure TCadImgProduct.AtivarListaImagens;
begin
  Qr_Imagem.Active := False;
  Qr_Imagem.ParamByName('tb_product_id').AsString := CodigoRegistro;
  Qr_Imagem.Active := True;
end;

procedure TCadImgProduct.Cancel;
begin
  img_produto.Picture.Graphic := nil;
  Qr_Imagem.First;
  showImage;
end;

procedure TCadImgProduct.setPerfil;
begin
  inherited;

end;

procedure TCadImgProduct.ShowData;
begin
  showImage;
  inherited;
end;

procedure TCadImgProduct.showImage;
var
  St_Image:TStream;
  Jp_IMage: TJpegImage; // sem a unit 'jpeg' essa classe não existiria
begin
  Jp_IMage := nil;
  img_produto.Picture.Graphic := nil;
  with Qr_Imagem do
  Begin
    if (RecordCount > 0) and (not FieldByName('content').IsNull) then
    Begin
      St_Image := CreateBlobStream(FieldByName('content'),bmRead);
      if St_Image.Size > 0 then
      begin
        try
          Try
            Jp_IMage := TJpegImage.Create;
            Jp_IMage.LoadFromStream(St_Image);
            img_produto.Picture.Assign(Jp_IMage);
            img_produto.Visible := true;
          Finally
            FreeAndNil(Jp_IMage);
          End;
        except
          img_produto.Picture.LoadFromFile('');
          img_produto.Visible := false;
        end;
      end
      else
      begin
        img_produto.Picture.LoadFromFile('');
        img_produto.Visible := False;
      end;
      Jp_IMage.Free;
      St_Image.Destroy;
    End;
  end;
end;

procedure TCadImgProduct.ShowNoData;
begin
  inherited;

end;

procedure TCadImgProduct.CarregaImagem;
Var

  Lc_imgProduto: TJPEGImageExt;
  Jp_IMage: TJpegImage;
begin
  try
    FPath := OpenDialogo.FileName;
    FPath := StringReplace(FPath, ExtractFileName(OpenDialogo.FileName), '',[rfReplaceAll, rfIgnoreCase]);
    FFile := ExtractFileName(OpenDialogo.FileName);
    TRy
      Jp_IMage := TJpegImage.Create;
      Jp_IMage.LoadFromFile(FPath + '\' + FFile);
      Lc_imgProduto := TJPEGImageExt.create;
      Lc_imgProduto.JPGImage := Jp_IMage;
      Lc_imgProduto.imageResize(GbPathExe + 'temp\' ,FFile, 360, 360, 100, true); // NORMAL SEMPRE DIMENSIONA PRA 360X360
      img_produto.Picture.LoadFromFile(GbPathExe + 'temp\' + FFile);
      img_produto.Visible := True;
    Except
      on E: Exception do
      Begin
        MensagemPadrao('Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                       'Não foi possivel carregar a image.' + EOLN +
                       e.Message + EOLN +
                       'Verifique o caminho e tente novamente.' + EOLN,
                       ['OK'], [bEscape], mpErro);
        FPath := '';
        FFile := '';
      End;
    End;
  Finally
    FreeAndNil(Jp_IMage)
  End;
end;

end.
