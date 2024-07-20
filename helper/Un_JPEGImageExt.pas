unit Un_JPEGImageExt;

interface


uses
  SysUtils, Windows, Graphics, Jpeg, Classes;

type
  TJPEGImageExt = class(TJPEGImage)
  private
    procedure setFJPGImage(const Value: TJPEGImage);
  protected
      FJPGImage : TJPEGImage;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure imageResize(filePathDestino: String; fileNameDestino: String; Width, Height, Quality: integer; saveToFile : Boolean);
    property JPGImage : TJPEGImage read FJPGImage write setFJPGImage;
  end;

implementation

constructor TJPEGImageExt.Create();
begin
  FJPGImage := Inherited Create;
end;

destructor TJPEGImageExt.Destroy;
begin

  inherited;
end;

procedure TJPEGImageExt.imageResize(filePathDestino: String; fileNameDestino: String; Width, Height, Quality: integer; saveToFile : Boolean);
  var
    JpegImage: TJpegImage;
    Bitmap: TBitmap;
    fileName: String;
    Ratio: double;
    ARect: TRect;
    AHeight, AHeightOffset: integer;
    AWidth, AWidthOffset: integer;
  begin
    //Verifica passagem de parametros inválidos
    if Width < 1 then
      raise Exception.Create('Comprimento informado para a imagen deve ser maior que 1 (um)');

    if Height < 1 then
      raise Exception.Create('Altura informada para a imagen deve ser maior que 1 (um)');

    JpegImage := TJpegImage.Create;
    try
      //Carrega a imagem
      JpegImage.Assign(self);

      //Cria o Bitmap
      Bitmap := TBitmap.Create;

      // Calcula os parametros de escala para o redimensionamento da imagem
      try
        Ratio := JpegImage.Width / JpegImage.Height;
        if Ratio > 1 then
        begin
          AHeight := Round(Width / Ratio);
          AHeightOffset := (Height - AHeight) div 2;
          AWidth := Width;
          AWidthOffset := 0;
        end  // end if Ratio > 1 then
        else
        begin
          AWidth := Round(Height * Ratio);
          AWidthOffset := (Width - AWidth) div 2;
          AHeight := Height;
          AHeightOffset := 0;
        end;  // end else

        // Atribui as dimensões da imagem
        Bitmap.Width := Width;
        Bitmap.Height := Height;

        // Gera a área onde a imagem será redimensionada
        Bitmap.Canvas.FillRect(Rect(0, 0, Width, Height));
        ARect := Rect( AWidthOffset, AHeightOffset, AWidth + AWidthOffset, AHeight + AHeightOffset );

        // Ajusta a imagem a área previamente definida
        Bitmap.Canvas.StretchDraw(ARect, JpegImage);

        // Vincula a imagem redimencionada BMP a imagem JPG
        JpegImage.Assign(Bitmap);

        // Comprime a imagem
        JpegImage.CompressionQuality := Quality;
        JpegImage.Compress;

        // Verifica se o diretório existe, caso não exista o mesmo será criado
        If ( not DirectoryExists(filePathDestino) ) then
          ForceDirectories(filePathDestino);

        // Salva a imagem em arquivo
        if ( saveToFile ) then
        begin
          fileName := filePathDestino + fileNameDestino;
          JpegImage.SaveToFile(fileName);
        end;
      finally
        Bitmap.disposeOf;
    end;
    finally
      JpegImage.disposeOf;
    end;
  end;
procedure TJPEGImageExt.setFJPGImage(const Value: TJPEGImage);
begin
  FJPGImage.Assign(Value);
end;

end.
