unit uLogger;

interface

procedure LogInfo(const AMsg: string);
procedure LogErro(const AMsg: string);
procedure LogDebug(const AMsg: string);

// Para logs de JSON (request/response)
procedure LogJson(const AContexto, AJson: string; const AMaxLen: Integer = 5000);

function GetLogFolder: string;

implementation

uses
  System.SysUtils, System.Classes, Desconto.Utils;

procedure Gravar(const ATipo, AMsg: string);
var
  vArquivo: TextFile;
  vPath, vFile: string;
begin
  vPath := GetLogFolder+'';

  vFile := vPath + '\priviconnect_' +
           FormatDateTime('yyyymmdd', Now) + '.log';

  AssignFile(vArquivo, vFile);

  if FileExists(vFile) then
    Append(vArquivo)
  else
    Rewrite(vArquivo);

  Writeln(vArquivo,
    Format('%s [%s] %s',
      [
        FormatDateTime('dd/mm/yyyy hh:nn:ss', Now),
        ATipo,
        AMsg
      ]
    )
  );

  CloseFile(vArquivo);
end;

procedure LogInfo(const AMsg: string);
begin
  Gravar('INFO', AMsg);
end;

procedure LogErro(const AMsg: string);
begin
  Gravar('ERRO', AMsg);
end;

procedure LogDebug(const AMsg: string);
begin
  Gravar('DEBUG', AMsg);
end;

procedure LogJson(const AContexto, AJson: string; const AMaxLen: Integer);
var
  vTexto: string;
begin
  vTexto := DecodeJsonUnicode(AJson);
  if (AMaxLen > 0) and (Length(vTexto) > AMaxLen) then
    vTexto := Copy(vTexto, 1, AMaxLen) + '... [TRUNCADO]';

  Gravar('JSON', AContexto + ' ' + vTexto);
end;

function GetLogFolder: string;
begin
  if not (DirectoryExists(ExtractFilePath(ParamStr(0)) + 'logs')) then
    ForceDirectories(ExtractFilePath(ParamStr(0)) + 'logs');
  Result := ExtractFilePath(ParamStr(0)) + 'logs';
end;


end.

