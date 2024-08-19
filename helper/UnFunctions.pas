unit UnFunctions;


interface

Uses System.SysUtils, Vcl.Grids, System.Classes, Winapi.Windows,
    ControllerInstitution, un_connection_data, Vcl.Forms;


  procedure LimpaStringGrid(Grid : TStringGrid);
  function  LocalizaComponente(Fc_Parent : TComponent; Pc_Alvo:TClass):TComponent;
  function  RemoveCaracterInformado(Str: String; Caracteres: Array of String): String;
  function  StrZero(Num : Real ; Zeros,Deci: integer): string;
  function  StrTran(Entra: string ; Search: string ; Replace : string): string;
  function  DiaDaSemana(Data:TDateTime): String;
  function  LocalizaComponentePorNome(Fc_Parent : TComponent; Pc_Alvo:TClass;Pc_Nome:String;Pc_tamanho:Integer):TComponent;
  function ValidaUserPassword:boolean;
  function criptografar(const key, texto: String): String;
  function descriptografar(const key, texto: String): String;
  procedure DeletaArquivoNumeroSerial;


const
  EOLN  = #13;

implementation

uses env;


procedure LimpaStringGrid(Grid : TStringGrid);
Var
  Lc_I,Lc_J : Integer;
Begin
  For Lc_I := 1 to Grid.RowCount - 1 do
    For Lc_J := 0 to Grid.ColCount do
      Grid.Cells[Lc_J,Lc_I] := '';
  Grid.RowCount := 2;
end;

function  LocalizaComponente(Fc_Parent : TComponent; Pc_Alvo:TClass):TComponent;
Var
  Lc_I : Integer;
Begin
  Result := Nil;
  for Lc_I := 0 to Fc_Parent.ComponentCount - 1 do
  begin
    if (Fc_Parent.Components[Lc_I].ClassType = Pc_Alvo) then
    begin
      Result := Fc_Parent.Components[Lc_I];
      Break;
    end
    else
    begin
      continue;
    end;
  end;
end;




function RemoveCaracterInformado(Str: String; Caracteres: Array of String): String;
var
  I: Integer;
begin
  Result := Str;
  for I := 0 to High(Caracteres) do
  begin
    while Pos(Caracteres[I], Result) > 0 do
      Delete(Result, Pos(Caracteres[I], Result), 1);
  end;
end;


Function unMaskField(Text:String):String;
Begin
  Result := Text;
  Result := stringReplace(Result, '-', '', [rfReplaceAll]);
  Result := stringReplace(Result, '-', '', [rfReplaceAll]);
  Result := stringReplace(Result, '(', '', [rfReplaceAll]);
  Result := stringReplace(Result, ')', '', [rfReplaceAll]);
  Result := stringReplace(Result, '.', '', [rfReplaceAll]);
  Result := stringReplace(Result, '.', '', [rfReplaceAll]);
  Result := stringReplace(Result, '/', '', [rfReplaceAll]);
  Result := stringReplace(Result, '-', '', [rfReplaceAll]);
  Result := stringReplace(Result, ' ', '', [rfReplaceAll]);
End;


{-------------------------------------------------------------------
 Função : StrZero
 Descrição : Acresenta zeros na frente de um numero
 -------------------------------------------------------------------}
function StrZero(Num : Real ; Zeros,Deci: integer): string;
var tam,z : integer;
    res,zer : string;
    lc_negativo : boolean;
begin
   //verifica se o numero é negativo
   Lc_Negativo := False;
   if Num < 0 then
   begin
      Lc_Negativo := True;
      Num := Num * -1;
   end;
   Str(Num:Zeros:Deci, res);
   res := trim(res);
   tam := Length(res);
   zer := '';
   for z := 1 to (Zeros-tam) do
   begin
      //se for numero negativo coloca sinha negativo
      If (Lc_Negativo) and (z = (Zeros-tam)) then
         zer := '-' + zer
      else
         zer := zer + '0';
   end;
   Result := zer+res;
   If Deci <> 0 then
      Result := StrTran(Result,'.',',');
end;
{Fim de StrZero}

{-----------------------------
 Função : StrTran
 Descrição : Procura pelas ocorrencias de um caracter numa
             string e troca por outro valor.
 OBS : Esta função ainda não é totalmente com o Clipper.
       É necessário acrescentar dois parametros para a
       compatibilidade total.
------------------------------}
function StrTran(Entra: string ; Search: string ; Replace : string): string;
var
   tamanho,
   Count : Integer;
   StrTemp,
   Sai : string;
begin
  If Pos(Search,Entra) = 0 Then
  Begin
    Result := Entra;
    Exit;
  End;
  tamanho := length(Search);
  Sai := '';
  for count := 1 to length(Entra) do
  begin
      StrTemp := StrTemp + Entra[count];

      if length (StrTemp) = tamanho then
      begin
          if AnsiCompareText (StrTemp,Search) = 0 then
          begin
              if Replace <> '' then
              begin
                  Sai := Sai + Replace;
              end;
              StrTemp := '';
         end
         else
         begin
            Sai := Sai + StrTemp[1];
            Strtemp := copy (StrTemp,2,tamanho - 1);
         end;
      end;
  end;
  Sai := Sai + StrTemp;

  Result := Sai;
end;




function DiaDaSemana(Data:TDateTime): String;
{Para exibir uma data por extenso no Delphi, coloque a seguinte rotina}
var
  NoDia : Integer;
  DiaDaSemana : array [1..7] of String;
begin
  { Dias da Semana }
  DiaDasemana [1]:= 'Domingo';
  DiaDasemana [2]:= 'Segunda';
  DiaDasemana [3]:= 'Terça';
  DiaDasemana [4]:= 'Quarta';
  DiaDasemana [5]:= 'Quinta';
  DiaDasemana [6]:= 'Sexta';
  DiaDasemana [7]:= 'Sábado';
  NoDia := DayOfWeek (Data);
  Result := DiaDaSemana [NoDia];
end;



function JsonMinify(const S: string): string;
Var
  SL : TStringStream;
begin
  SL := TStringStream.Create;
  Result := StringReplace(S,'\','',[rfReplaceAll]);
  Result := Copy(Result,2,Length(Result)-2);
  SL.WriteString(Result);
  REsult := SL.DataString;
  FreeAndNil(SL);
end;

function  LocalizaComponentePorNome(Fc_Parent : TComponent; Pc_Alvo:TClass;Pc_Nome:String;Pc_tamanho:Integer):TComponent;
Var
  Lc_I : Integer;
Begin
  Result := Nil;
  for Lc_I := 0 to Fc_Parent.ComponentCount - 1 do
  begin
    if (Fc_Parent.Components[Lc_I].ClassType = Pc_Alvo) then
    begin
      if (Fc_Parent.Components[Lc_I].Name = Pc_Nome) then
      Begin
        Result := Fc_Parent.Components[Lc_I];
        Break;
      end;
    end
    else
    begin
      continue;
    end;
  end;
end;

function ValidaUserPassword:boolean;
Var
  LcForm : TFr_ConnectionData;
Begin
  Result := True;
  LcForm := TFr_ConnectionData.Create(application);
  try
    LcForm.ShowModal;
  finally
    LcForm.DisposeOf;
  end;
End;

function criptografar(const key, texto: String): String;
var
  I: Integer;
  C: Byte;
begin
  Result := '';
  for I := 1 to Length(texto) do begin
    if Length(Key) > 0 then
      C := Byte(Key[1 + ((I - 1) mod Length(Key))]) xor Byte(texto[I])
    else
      C := Byte(texto[I]);
    Result := Result + AnsiLowerCase(IntToHex(C, 2));
  end;
end;

function descriptografar(const key, texto: String): String;
var
  I: Integer;
  C: Char;
begin
  Result := '';
  for I := 0 to Length(texto) div 2 - 1 do begin
    C := Chr(StrToIntDef('$' + Copy(texto, (I * 2) + 1, 2), Ord(' ')));
    if Length(Key) > 0 then
      C := Chr(Byte(Key[1 + (I mod Length(Key))]) xor Byte(C));
    Result := Result + C;
  end;
end;

procedure DeletaArquivoNumeroSerial;
var
  Lc_file_name:String;
  Lc_file_path : String;
begin
  Lc_file_name := 'qrcode.txt';
  Lc_file_path := concat(GbPathExe + Lc_file_name);
  if FileExists(Lc_file_path) then
    DeleteFile(PChar(Lc_file_path));
end;

end.

