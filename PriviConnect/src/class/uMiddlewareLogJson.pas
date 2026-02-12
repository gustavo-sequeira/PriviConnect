unit uMiddlewareLogJson;

interface

uses
  Horse;

procedure UseJsonLogger;

implementation

uses
  System.SysUtils, uLogger, System.RegularExpressions;

function MascaraCPF(const ACpf: string): string;
var
  vCpf: string;
begin
  vCpf := Trim(ACpf);

  if Length(vCpf) = 11 then
    Result := Copy(vCpf, 1, 3) + '***' + Copy(vCpf, 9, 3)
  else if Length(vCpf) > 4 then
    Result := Copy(vCpf, 1, 3) + '***' + Copy(vCpf, Length(vCpf)-1, 2)
  else
    Result := '***';
end;

function MascaraCPFEmJson(const AJson: string): string;
var
  vMatch: TMatch;
  vCpfOriginal: string;
  vCpfMascarado: string;
begin
  Result := AJson;

  vMatch := TRegEx.Match(AJson, '"cpf"\s*: \s*(\d+)');

  if not vMatch.Success then
  begin
    vMatch := TRegEx.Match(AJson,
      '"cpf"\s*:\s*"(\d+)"');
  end;

  if not vMatch.Success then
    Exit; // não achou CPF, devolve igual

  // Grupo 1 é o valor capturado dentro das aspas
  vCpfOriginal := vMatch.Groups[1].Value;
  if vCpfOriginal = '' then
    Exit;

  vCpfMascarado := MascaraCPF(vCpfOriginal);

  // Substitui TODAS as ocorrências do CPF original pelo mascarado
  Result := StringReplace(
    Result,
    vCpfOriginal,
    vCpfMascarado,
    [rfReplaceAll]
  );
end;

procedure JsonLoggerMiddleware(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  vRequestJson: string;
  vResponseJson: string;
  vRota: string;
  vContentType: string;
begin
  // Na sua versão, usamos o RawWebRequest para pegar método e path
  vRota := Format('%s %s',
    [Req.RawWebRequest.Method, Req.RawWebRequest.PathInfo]);

  // Content-Type também vem do RawWebRequest
  vContentType := LowerCase(Req.RawWebRequest.ContentType);

  // Só loga JSON se o Content-Type indicar JSON
  if vContentType.Contains('application/json') then
  begin
    vRequestJson := Req.Body;

    // Opcional: mascarar dados sensíveis (CPF etc.)
    vRequestJson := MascaraCPFEmJson(vRequestJson);

    LogJson('REQUEST ' + vRota + ' - BODY:', vRequestJson);
  end
  else
    LogInfo('REQUEST ' + vRota + ' - Content-Type=' + vContentType);

  // Chama a rota real
  try
    Next;
  except
    on E: Exception do
    begin
      LogErro(Format('EXCEPTION em %s: %s', [vRota, E.Message]));
      raise;
    end;
  end;

  // Tenta logar a resposta como JSON também
  try
    // Em versões antigas do Horse, use RawWebResponse.Content
    vResponseJson := Res.RawWebResponse.Content;
    // Se a sua versão tiver Res.Content, pode trocar pra ele sem problemas

    if vResponseJson <> '' then
    begin
      vResponseJson := MascaraCPFEmJson(vResponseJson);
      LogJson('RESPONSE ' + vRota + ' - BODY:', vResponseJson);
    end
    else
      LogInfo('RESPONSE ' + vRota + ' - sem corpo de resposta');
  except
    on E: Exception do
      LogErro('Falha ao logar response JSON em ' + vRota + ': ' + E.Message);
  end;
end;

procedure UseJsonLogger;
begin
  THorse.Use(JsonLoggerMiddleware);
end;

end.

