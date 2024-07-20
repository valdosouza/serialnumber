unit GenericEntity;

interface

uses
  System.SysUtils,CAtribEntity;

Type
  TGenericEntity = class(TObject)
  private
    Fupdated_at: TDAteTime;
    Fcreated_at: TDAteTime;
    function formataDataSQLServer(Value: TDAteTime):TDateTime;
    procedure setFcreated_at(const Value: TDAteTime);
    procedure setFupdated_at(const Value: TDAteTime);

  public

    [FieldName('created_at')]
    property RegistroCriado: TDAteTime read Fcreated_at write setFcreated_at;

    [FieldName('updated_at')]
    property RegistroAlterado: TDAteTime read Fupdated_at write setFupdated_at;
  end;

implementation


{ TGenericEntity }

function TGenericEntity.formataDataSQLServer(Value: TDAteTime): TDateTime;
//Var
  //Lc_Ano,Lc_Mes,Lc_Dia,Lc_Hora:String;
  //Lc_Str_Data : String;
  //Lc_Data : TDateTime;
  //Lc_Settings : TFormatSettings;
begin
  Result := Value;
  {Avaliando se as modificações na gração
  if DateToStr(Value) = '30/12/1899' then
    Value := Now;

  Lc_Str_Data := DateTimeToStr(Value);
  Result := Value;
  if (trim(Lc_Str_Data) <> '') and (trim(Lc_Str_Data) <> '01-01-1900') then
  Begin
    if (Pos('-',Lc_Str_Data) > 0) then
    Begin
       Result := StrToDateTime(Lc_Str_Data) ;
    End
    else
    if (Pos('/',Lc_Str_Data) > 0) then
    Begin
      FillFormatSettings(Lc_Settings);
      //01/01/2016 00:00:01
      Lc_Dia  := Copy(Lc_Str_Data,1,2);
      Lc_Mes  := Copy(Lc_Str_Data,4,2);
      Lc_Ano  := Copy(Lc_Str_Data,7,4);
      Lc_Hora := Copy(Lc_Str_Data,12,8);
      Lc_Data := StrToDateTime(concat(Lc_Ano,'-',Lc_Mes,'-',Lc_Dia,' ', Lc_Hora));
      Lc_Str_Data := DateToStr(Lc_Data, Lc_Settings)+' '+TimeToStr(Lc_Data, Lc_Settings);
      Try
        Result := StrToDateTime(Lc_str_Data,Lc_Settings);
      except
        Result := Now;
      End;

    End
  End;
  }
end;

procedure TGenericEntity.setFcreated_at(const Value: TDAteTime);
begin
  Fcreated_at := formataDataSQLServer(Value);
end;

procedure TGenericEntity.setFupdated_at(const Value: TDAteTime);
begin
  Fupdated_at := formataDataSQLServer(Value);
end;

end.
