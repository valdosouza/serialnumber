unit cad_product;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, ControllerProduct;

type
  TCadProduct = class(TBaseRegistry)
    Label28: TLabel;
    Label1: TLabel;
    E_code_Provider: TEdit;
    E_description: TEdit;
    chbx_ativo: TCheckBox;
    Imagens1: TMenuItem;
    Cb_Normas: TComboBox;
    Label2: TLabel;
    E_PartNumber_01: TEdit;
    Lb_PartNumber_01: TLabel;
    E_PartNumber_02: TEdit;
    Lb_PartNumber_02: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    E_T1: TEdit;
    E_T2: TEdit;
    Label5: TLabel;
    E_RD: TEdit;
    Label6: TLabel;
    E_Mascara_padrao: TEdit;
    procedure Imagens1Click(Sender: TObject);
    procedure Cb_NormasChange(Sender: TObject);
  private
    function VerificaExistenciaReferencia:Boolean;
    function saveProduct:boolean;
    function saveNorma:boolean;
    function ValidaNorma:Boolean;
    function ValidaNormaPF_901106:Boolean;
    function ValidaNormaFPW_PTTSTR:Boolean;
  protected
    //Variaveis
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    //procedure ImagemBotao;Override;
    procedure FormataTela;Override;
    procedure setPerfil;Override;

    procedure ShowData;Override;
    procedure ShowNoData;Override;

    //inserir
    function ValidaInsert():boolean;Override;
    procedure Insert;Override;
    //Editar
    function ValidateChange():boolean;Override;
    procedure Change;Override;
    //Deletar
    function ValidateDelete():boolean;Override;
    procedure Delete;Override;
    //Salvar
    function ValidateSave():boolean;Override;
    procedure Save;Override;
    //Cancelar
    function ValidateCancel():boolean;Override;
    procedure Cancel;Override;

    procedure EditionControler(T: TComponent);
    procedure EditionControl;Override;
  public
    Product : TControllerProduct;
  end;

var
  CadProduct: TCadProduct;

implementation

{$R *.dfm}

uses Un_Msg, uMain, cad_img_product, env;

{ TCadProduct }

procedure TCadProduct.Cancel;
begin
  inherited;

end;

procedure TCadProduct.Cb_NormasChange(Sender: TObject);
begin
  case Cb_Normas.ItemIndex of
    0:BEgin
        Lb_PartNumber_01.Visible := true;
        Lb_PartNumber_01.Caption := 'PN - PartNumber';
        E_PartNumber_01.Visible := true;
        Lb_PartNumber_02.Visible := False;
        E_PartNumber_02.Visible := False;
      End;
    1:BEgin
        Lb_PartNumber_01.Visible := true;
        Lb_PartNumber_01.Caption := 'PN - FCA PartNumber';
        E_PartNumber_01.Visible := true;
        Lb_PartNumber_02.Visible := False;
        E_PartNumber_02.Visible := False;
      End;
    2:BEgin
        Lb_PartNumber_01.Visible := true;
        Lb_PartNumber_01.Caption := 'PN - FCA NAFTA PartNumber';
        E_PartNumber_01.Visible := true;
        Lb_PartNumber_02.Visible := true;
        Lb_PartNumber_02.Caption := 'PN - FCA LATAM PartNumber';
        E_PartNumber_02.Visible := true;
      End;
  end;

end;

procedure TCadProduct.Change;
begin
  inherited;
  E_code_Provider.SetFocus;
end;

procedure TCadProduct.CriarVariaveis;
begin
  inherited;
  Product := TControllerProduct.Create(Self);
end;

procedure TCadProduct.Delete;
begin
  inherited;
  Product.Registro.referencia := '';
  Product.Registro.Ativo := 'N';
  Product.save;
  Self.Close;
end;

procedure TCadProduct.EditionControl;
begin
  inherited;

end;

procedure TCadProduct.EditionControler(T: TComponent);
begin

end;

procedure TCadProduct.FormataTela;
begin
  inherited;

end;

procedure TCadProduct.Imagens1Click(Sender: TObject);
Var
  Lc_Form: TCadImgProduct;
Begin
  Lc_Form := TCadImgProduct.Create(Self);
  Try
    Lc_Form.CodigoRegistro := Product.Registro.Codigo;
    Lc_Form.Lb_Produto.Caption := concat('Produto: ', Product.Registro.referencia, ' - ', Product.Registro.Descricao);
    Lc_Form.ShowModal;
  Finally
    Lc_Form.DisposeOf;
  End;
end;

procedure TCadProduct.IniciaVariaveis;
begin
  if CodigoRegistro <> '' then
  Begin
    Product.Registro.Codigo           := CodigoRegistro;
    Product.Registro.Estabelecimento  := GbInstitution.Registro.Codigo;
    Product.getByKey;
    Product.Norma.Registro.Estabelecimento  := GbInstitution.Registro.Codigo;
    Product.Norma.Registro.Produto          := Product.Registro.Codigo;
    Product.Norma.getList;
  End;
  inherited;
end;

procedure TCadProduct.Insert;
begin
  inherited;
  E_code_Provider.Clear;
  E_description.Clear;
  Cb_Normas.ItemIndex := 0;
  E_PartNumber_01.Clear;
  E_PartNumber_02.Clear;
  Product.clear;
  E_code_Provider.SetFocus;
end;

procedure TCadProduct.Save;
begin
  saveProduct;
  saveNorma;
  inherited;
end;

function TCadProduct.saveNorma: boolean;
begin
  Result := True;
  with Product do
  Begin
    Norma.Registro.Estabelecimento := Product.Registro.Estabelecimento;
    Norma.Registro.Produto := Product.Registro.Codigo;
    Norma.deleteByProduto;
    if Length(Trim(E_PartNumber_01.Text))>0 then
    Begin
      Norma.Registro.Estabelecimento  := GbInstitution.Registro.Codigo;
      Norma.Registro.Produto          := Product.Registro.Codigo;
      Norma.Registro.CodeNorma        := Cb_Normas.Text;
      Norma.Registro.ParNumber        := E_PartNumber_01.Text;
      Norma.save;
    End;

    if Length(Trim(E_PartNumber_02.Text))>0 then
    Begin
      Norma.Registro.Estabelecimento  := GbInstitution.Registro.Codigo;
      Norma.Registro.Produto          := Product.Registro.Codigo;
      Norma.Registro.CodeNorma        := Cb_Normas.Text;
      Norma.Registro.ParNumber        := E_PartNumber_02.Text;
      Norma.save;
    End;
  End;
end;

function TCadProduct.saveProduct: boolean;
begin
  Result := True;
  Product.Registro.Estabelecimento := GbInstitution.Registro.Codigo;
  Product.Registro.referencia := E_code_Provider.Text;
  Product.Registro.Descricao := E_description.Text;
  if chbx_ativo.Checked then
    Product.Registro.Ativo := 'S'
  else
    Product.Registro.Ativo := 'N';
  Product.Registro.T1 := E_T1.Text;
  Product.Registro.T2 := E_T2.Text;
  Product.Registro.RD := E_RD.Text;
  Product.Registro.MascaraPadrao := E_Mascara_padrao.Text;
  Product.save;
  CodigoRegistro := Product.Registro.Codigo;
end;

procedure TCadProduct.setPerfil;
begin
  TelaInterface := 'Cadastro Produto';
  inherited;
end;

procedure TCadProduct.ShowData;
Var
  I,J : Integer;
begin
  inherited;
  E_code_Provider.Text    := Product.Registro.referencia;
  E_description.Text  := Product.Registro.Descricao;
  chbx_ativo.Checked  := Product.Registro.Ativo = 'S';
  //NÃO INFORMADA
  //PF.901106
  //FPW.PTTSTR
  for I := 0 to Product.Norma.Lista.Count-1 do
  BEgin
    if (I = 0) then
    Begin
      for J := 0 to Cb_Normas.Items.Count - 1 do
      Begin
        //Norma
        if (Cb_Normas.Items[J] = Product.Norma.Lista[I].CodeNorma )then
        BEgin
          Cb_Normas.ItemIndex := J;
          Cb_NormasChange(self);
          break;
        End;
      End;
      //Primeiro Number Par
      E_PartNumber_01.Text := Product.Norma.Lista[I].ParNumber;
    End;
    //Norma
    if (I = 1) then
    Begin
      E_PartNumber_02.Text := Product.Norma.Lista[I].ParNumber;
    End;
  End;
  E_T1.Text := Product.Registro.T1;
  E_T2.Text := Product.Registro.T2;
  E_RD.Text := Product.Registro.RD;
  E_Mascara_padrao.Text := Product.Registro.MascaraPadrao;

end;

procedure TCadProduct.ShowNoData;
begin
  E_code_Provider.Clear;
  E_description.Clear;
  chbx_ativo.Checked  := True;
  Cb_Normas.ItemIndex := 0;
  E_PartNumber_01.Clear;
  E_PartNumber_02.Clear;
end;

function TCadProduct.ValidaInsert: boolean;
begin
  REsult := True;
end;

function TCadProduct.ValidaNorma: Boolean;
begin
  Result := True;
  case Cb_Normas.ItemIndex of
    1:Result := ValidaNormaPF_901106;
    2:Result := ValidaNormaFPW_PTTSTR;
  end;
end;

function TCadProduct.ValidaNormaFPW_PTTSTR: Boolean;
begin
  Result := True;
  if Length(Trim(E_PartNumber_01.Text)) <> 10 then
  begin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'FCA NAFTA PartNumber da norma FPW.PTTSTR precisa de 10 caracteres.'+EOLN+
                   'Preencha o campo para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    E_PartNumber_01.SetFocus;
    Exit;
  end;

  if Length(Trim(E_PartNumber_02.Text)) <> 11 then
  begin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'FCA LATAM PartNumber da norma FPW.PTTSTR precisa de 11 caracteres.'+EOLN+
                   'Preencha o campo para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    E_PartNumber_02.SetFocus;
    Exit;
  end;
end;

function TCadProduct.ValidaNormaPF_901106: Boolean;
begin
  Result := True;
  if Length(Trim(E_PartNumber_01.Text)) <> 11 then
  begin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'FCA PartNumber da norma PF.901106 precisa de 11 caracteres.'+EOLN+
                   'Preencha o campo para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    E_PartNumber_01.SetFocus;
    Exit;
  end;
end;

function TCadProduct.ValidateCancel: boolean;
begin
  REsult := True;
end;

function TCadProduct.ValidateChange: boolean;
begin
  REsult := True;
end;

function TCadProduct.ValidateDelete: boolean;
begin
  REsult := True;
  if (MensagemPadrao('Mensagem de Confirmação',
                      'Excluir o produto  de seus arquivos.' + EOLN + EOLN +
                      'Confirmar a exclusão ?',
                      ['Sim', 'Não'], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao2) then
  Begin
    Result := False;
    Exit;
  End;
end;

function TCadProduct.ValidateSave: boolean;
begin
  Result:=true;
  if TRIM(E_code_Provider.Text) = '' then
  begin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Código Fornecedor não informado.'+EOLN+
                   'Preencha o campo para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    E_code_Provider.SetFocus;
    Exit;
  end;

  if TRIM(E_description.Text) = '' then
  begin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Descrição do produto não informado.'+EOLN+
                   'Preencha o campo para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    E_description.SetFocus;
    Exit;
  end;

  if VerificaExistenciaReferencia then
  Begin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Este número de referência já existe.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    E_description.SetFocus;
    Exit;
  End;

  If not ValidaNorma then
  Begin
    result:=False;
    Exit;
  End;

  if TRIM(E_Mascara_padrao.Text) = '' then
  begin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Mascara do número de série não informado.'+EOLN+
                   'Preencha o campo para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    E_Mascara_padrao.SetFocus;
    Exit;
  end;


end;

function TCadProduct.VerificaExistenciaReferencia: Boolean;
Var
  LcProduct : TControllerProduct;
begin
  LcProduct := TControllerProduct.Create(self);
  try
    LcProduct.Registro.Codigo := Product.Registro.Codigo;
    LcProduct.Registro.Estabelecimento := GbInstitution.Registro.Codigo;
    LcProduct.Registro.referencia := E_code_Provider.Text;
    Result := LcProduct.checkExistReference;
  finally
    LcProduct.DisposeOf;
  end;
end;

end.
