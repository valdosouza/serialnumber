unit prm_base;

interface

uses System.SysUtils;

Type
  TPrmBase = class
  private
    FEstabelecimento: String;
    FUltimaAtualizacao: String;
    FResultado: Boolean;
    FLimite: String;
    FUsuario: String;
    FDataFinal: String;
    FDataInicial: String;
    FPagina: Integer;
    procedure setFDataFinal(const Value: String);
    procedure setFDataInicial(const Value: String);
    procedure setFEstabelecimento(const Value: String);
    procedure setFLimite(const Value: String);
    procedure setFPagina(const Value: Integer);
    procedure setFResultado(const Value: Boolean);
    procedure setFUltimaAtualizacao(const Value: String);
    procedure setFUsuario(const Value: String);

  public
    constructor Create;Virtual;
    destructor Destroy;override;

    property Usuario: String read FUsuario write setFUsuario;
    property Pagina : Integer read FPagina write setFPagina;
    property DataInicial : String read FDataInicial write setFDataInicial;
    property DataFinal : String read FDataFinal write setFDataFinal;
    property Limite : String read FLimite write setFLimite;
    property UltimaAtualizacao:String read FUltimaAtualizacao write setFUltimaAtualizacao;
    property Estabelecimento : String read FEstabelecimento write setFEstabelecimento;
    property Resultado : Boolean read FResultado write setFResultado;
  end;
implementation

{ TPrmBase }

constructor TPrmBase.Create;
begin

end;

destructor TPrmBase.Destroy;
begin

  inherited;
end;

procedure TPrmBase.setFDataFinal(const Value: String);
begin
  FDataFinal := Value;
end;

procedure TPrmBase.setFDataInicial(const Value: String);
begin
  FDataInicial := Value;
end;

procedure TPrmBase.setFEstabelecimento(const Value: String);
begin
  FEstabelecimento := Value;
end;

procedure TPrmBase.setFLimite(const Value: String);
begin
  FLimite := Value;
end;

procedure TPrmBase.setFPagina(const Value: Integer);
begin
  FPagina := Value;
end;

procedure TPrmBase.setFResultado(const Value: Boolean);
begin
  FResultado := Value;
end;

procedure TPrmBase.setFUltimaAtualizacao(const Value: String);
begin
  FUltimaAtualizacao := Value;
end;

procedure TPrmBase.setFUsuario(const Value: String);
begin
  FUsuario := Value;
end;

end.
