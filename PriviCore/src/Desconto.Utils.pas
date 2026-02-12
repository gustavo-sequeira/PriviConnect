unit Desconto.Utils;

interface

uses System.JSON, FireDAC.Comp.Client, System.SysUtils, Desconto.Tipos;

procedure PreencherJSONArrayTerminalBalcao(out AJSONArray: TJSONArray; ACampanha, ATipoItem: string; AFilial, ACodigoProduto, ATerminalBalcao: Integer; ADescricaoProduto: string; AValorUnitario, APercentualDesconto, AValorUnitarioDescontado, AValorLiquido: Double);
procedure PreencherJSONArrayOrcamento(out AJSONArray: TJSONArray; ACampanha, ATipoItem: string; AFilial, AOrcamento: Integer; AValorUnitario, APercentualDesconto, AValorUnitarioDescontado, AValorLiquido: Double);
procedure PreencherJSONArrayProdutoOrcamento(out AJSONArray: TJSONArray; ACampanha, ANomeProduto : string; ACodigoProduto: Integer; AValorUnitario, APercentualDesconto, AValorUnitarioDescontado, AValorLiquido: Double);
procedure PreencherTerminalBalcao(ACpf: Int64; out ATerminalBalcao: TTerminalBalcao; ATipoItem: TTipoItem; AConnection: TFDConnection);

function RetornaDescricaoProduto(ACodigoProduto: integer; AConnection: TFDConnection): string;
function ExisteProduto(ACodigoProduto: Integer; AConstante: array of integer): Boolean;
function ArrayToSQL(const AArray: array of Integer): string;
function StaticToDyn(const AArray: array of Integer): TArray<Integer>;
function TrocaVirgulaPorPonto(AValue: string): string;
function MudarPonto(valor: double): string;
function ExisteNoJson(ACampanhas: TJSONArray; ANovo: TJSONObject): Boolean;
function ExisteNoJsonProdutoOrcamento(ACampanhas: TJSONArray; ANovo: TJSONObject): Boolean;
function ExisteNoJsonOrcamento(ACampanhas: TJSONArray; ANovo: TJSONObject): Boolean;
function BuildKeyOrcamento(AObj: TJSONObject): string;
function BuildKeyProdutoOrcamento(AObj: TJSONObject): string;
function BuildKey(AObj: TJSONObject): string;
function MascaraCPF(const ACpf: string): string;
function DecodeJsonUnicode(const AText: string): string;
function MascaraCPFEmJson(const AJson: string): string;
function usaDescontoPrivilege: Boolean;

implementation

uses
  System.StrUtils, System.Variants, Firedac.Stan.Param, Data.DB,
  System.Generics.Collections, System.RegularExpressions, System.IniFiles;


function DecodeJsonUnicode(const AText: string): string;
var
  vRegex: TRegEx;
  vMatch: TMatch;
  vResult: string;
  vCode: Integer;
  vChar: WideChar;
begin
  vResult := AText;
  vRegex  := TRegEx.Create('\\u([0-9a-fA-F]{4})');

  // Percorre todos os \uXXXX e substitui pelo caractere real
  vMatch := vRegex.Match(vResult);
  while vMatch.Success do
  begin
    vCode := StrToInt('$' + vMatch.Groups[1].Value);
    vChar := WideChar(vCode);

    vResult := vResult.Remove(vMatch.Index - 1, vMatch.Length);
    vResult := vResult.Insert(vMatch.Index - 1, vChar);

    vMatch := vRegex.Match(vResult);
  end;

  Result := vResult;
end;

function MascaraCPF(const ACpf: string): string;
var
  vCpf: string;
begin
  vCpf := Trim(ACpf);

  // Para CPF com 11 dígitos: 12345678901 -> 123***8901
  if Length(vCpf) = 11 then
    Result := Copy(vCpf, 1, 3) + '***' + Copy(vCpf, 9, 3)
  else if Length(vCpf) > 4 then
    // fallback genérico pra outros tamanhos
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

procedure PreencherTerminalBalcao(ACpf: Int64; out ATerminalBalcao: TTerminalBalcao; ATipoItem: TTipoItem; AConnection: TFDConnection);
var
  vQuery: TFDQuery;
begin
  vQuery := TFDQuery.Create(nil);

  try
    try
      vQuery.Connection := AConnection;
      vQuery.Close;
      vQuery.SQL.Clear;
      vQuery.SQL.Add('         select ');
      vQuery.SQL.Add('             f10.idpromo, ');
      vQuery.SQL.Add('             f10.pfcrm, ');
      vQuery.SQL.Add('             f10.ufcrm, ');
      vQuery.SQL.Add('             f10.nrcrm, ');
      vQuery.SQL.Add('             f07.nrcnpj, ');
      vQuery.SQL.Add('             f10.cdfil, ');
      vQuery.SQL.Add('             f10.cdtml, ');
      vQuery.SQL.Add('             f10.dtope, ');
      vQuery.SQL.Add('             f10.operid, ');
      vQuery.SQL.Add('             f10.nrcpm, ');
      vQuery.SQL.Add('             f10.itemid, ');
      vQuery.SQL.Add('             f10.tpitm, ');
      vQuery.SQL.Add('             f10.cdfilr, ');
      vQuery.SQL.Add('             f10.cdpro, ');
      vQuery.SQL.Add('             f10.quant, ');
      vQuery.SQL.Add('             f10.pruni, ');
      vQuery.SQL.Add('             f10.tpdsc, ');
      vQuery.SQL.Add('             coalesce(f10.vrdsc, 0) + coalesce(f22.vrdsc, 0) as vrdsc, ');
      vQuery.SQL.Add('             f10.vrliq, ');
      vQuery.SQL.Add('             f10.vrcxa, ');
      vQuery.SQL.Add('             f10.tpdscg, ');
      vQuery.SQL.Add('             f10.vrdscg, ');
      vQuery.SQL.Add('             f10.cdtxag, ');
      vQuery.SQL.Add('             f10.vrtxag, ');
      vQuery.SQL.Add('             f10.tppag, ');
      vQuery.SQL.Add('             f10.vrtot, ');
      vQuery.SQL.Add('             f10.cdtxa, ');
      vQuery.SQL.Add('             f10.vrtxa, ');
      vQuery.SQL.Add('             f10.vrdscv, ');
      vQuery.SQL.Add('             f10.vrtxav, ');
      vQuery.SQL.Add('             ( ');
      vQuery.SQL.Add('                 f10.vrliq ');
      vQuery.SQL.Add('                 + coalesce(f10.vrdsc, 0) ');
      vQuery.SQL.Add('                 + coalesce(f22.vrdsc, 0) ');
      vQuery.SQL.Add('                 - coalesce(f22.vrtxa, 0) ');
      vQuery.SQL.Add('             ) as semdesconto, ');
      vQuery.SQL.Add('             coalesce(f22.vrtxa, 0) as vrtxarec, ');
      vQuery.SQL.Add('             coalesce(f22.vrtxa, 0) as vrtxa, ');
      vQuery.SQL.Add('             coalesce( ');
      vQuery.SQL.Add('                 ( ');
      vQuery.SQL.Add('                     select f03.descr ');
      vQuery.SQL.Add('                       from fc03000 f03 ');
      vQuery.SQL.Add('                      where f03.cdpro = f10.cdpro ');
      vQuery.SQL.Add('                        and f10.tpitm = ''V'' ');
      vQuery.SQL.Add('                 ), ');
      vQuery.SQL.Add('                 ''FÓRMULA MANIPULADA (A VISTA)'' ');
      vQuery.SQL.Add('             ) as descrprd, ');
      vQuery.SQL.Add('             coalesce( ');
      vQuery.SQL.Add('                 nullif(max(f22.ptdsc), 0), ');
      vQuery.SQL.Add('                 nullif(max(f10.ptdsc), 0), ');
      vQuery.SQL.Add('                 ( ');
      vQuery.SQL.Add('                     coalesce(sum(f22.vrdsc), sum(f10.vrdsc)) ');
      vQuery.SQL.Add('                     / nullif(sum(f10.quant * f10.vrliq), 0) ');
      vQuery.SQL.Add('                 ) * 100 ');
      vQuery.SQL.Add('             ) as ptdsc, ');
      vQuery.SQL.Add('             f00.cdcli, ');
      vQuery.SQL.Add('             f07.nomecli, ');
      vQuery.SQL.Add('             f07.nrcnpj, ');
      vQuery.SQL.Add('             f00.cdfunre, ');
      vQuery.SQL.Add('             f08.nomefun, ');
      vQuery.SQL.Add('             f00.useridaut ');
      vQuery.SQL.Add('         from fc32110 f10 ');
      vQuery.SQL.Add('         inner join fc32100 f00 ');
      vQuery.SQL.Add('                 on f00.cdfil  = f10.cdfil ');
      vQuery.SQL.Add('                and f00.cdtml  = f10.cdtml ');
      vQuery.SQL.Add('                and f00.dtope  = f10.dtope ');
      vQuery.SQL.Add('                and f00.operid = f10.operid ');
      vQuery.SQL.Add('                and f00.nrcpm  = f10.nrcpm ');
      vQuery.SQL.Add('         inner join fc07000 f07 ');
      vQuery.SQL.Add('                 on f07.cdcli = f00.cdcli ');
      vQuery.SQL.Add('         left join fc08000 f08 ');
      vQuery.SQL.Add('                on f08.cdcon = f00.cdconre ');
      vQuery.SQL.Add('               and f08.cdfun = f00.cdfunre ');
      vQuery.SQL.Add('         left join fc32200 f22 ');
      vQuery.SQL.Add('                on f22.cdfil  = f10.cdfil ');
      vQuery.SQL.Add('               and f22.cdtml  = f10.cdtml ');
      vQuery.SQL.Add('               and f22.dtope  = f10.dtope ');
      vQuery.SQL.Add('               and f22.operid = f10.operid ');
      vQuery.SQL.Add('               and f22.nrcpm  = f10.nrcpm ');
      vQuery.SQL.Add('               and f22.itemid = f10.itemid ');
      vQuery.SQL.Add('         where f10.dtope >= (current_date - 1) ');
      vQuery.SQL.Add('           and f00.indapro = ''N'' ');
      vQuery.SQL.Add('           and f07.nrcnpj = lpad(cast(:cpf as varchar(11)), 11, ''0'') ');
      vQuery.SQL.Add('         group by ');
      vQuery.SQL.Add('             f10.idpromo, ');
      vQuery.SQL.Add('             f10.pfcrm, ');
      vQuery.SQL.Add('             f10.ufcrm, ');
      vQuery.SQL.Add('             f10.nrcrm, ');
      vQuery.SQL.Add('             f07.nrcnpj, ');
      vQuery.SQL.Add('             f10.cdfil, ');
      vQuery.SQL.Add('             f10.cdtml, ');
      vQuery.SQL.Add('             f10.dtope, ');
      vQuery.SQL.Add('             f10.operid, ');
      vQuery.SQL.Add('             f10.nrcpm, ');
      vQuery.SQL.Add('             f10.itemid, ');
      vQuery.SQL.Add('             f10.tpitm, ');
      vQuery.SQL.Add('             f10.cdfilr, ');
      vQuery.SQL.Add('             f10.cdpro, ');
      vQuery.SQL.Add('             f10.quant, ');
      vQuery.SQL.Add('             f10.pruni, ');
      vQuery.SQL.Add('             f10.tpdsc, ');
      vQuery.SQL.Add('             f10.vrdsc, ');
      vQuery.SQL.Add('             f22.vrdsc, ');
      vQuery.SQL.Add('             f10.vrliq, ');
      vQuery.SQL.Add('             f10.vrcxa, ');
      vQuery.SQL.Add('             f10.tpdscg, ');
      vQuery.SQL.Add('             f10.vrdscg, ');
      vQuery.SQL.Add('             f10.cdtxag, ');
      vQuery.SQL.Add('             f10.vrtxag, ');
      vQuery.SQL.Add('             f10.tppag, ');
      vQuery.SQL.Add('             f10.vrtot, ');
      vQuery.SQL.Add('             f10.cdtxa, ');
      vQuery.SQL.Add('             f10.vrtxa, ');
      vQuery.SQL.Add('             f10.vrdscv, ');
      vQuery.SQL.Add('             f10.vrtxav, ');
      vQuery.SQL.Add('             f22.vrtxa, ');
      vQuery.SQL.Add('             f00.cdcli, ');
      vQuery.SQL.Add('             f07.nomecli, ');
      vQuery.SQL.Add('             f00.cdfunre, ');
      vQuery.SQL.Add('             f08.nomefun, ');
      vQuery.SQL.Add('             f00.useridaut ');
      vQuery.SQL.Add('         order by f10.cdpro ');

      vQuery.ParamByName('cpf').Value := ACpf;
      vQuery.Open;

      if not(vQuery.IsEmpty) then
      begin
        vQuery.First;
        SetLength(ATerminalBalcao, vQuery.RecordCount);
        while not(vQuery.Eof) do
        begin
          ATerminalBalcao[vQuery.RecNo - 1].Filial := vQuery.FieldByName('cdfil').AsInteger;
          ATerminalBalcao[vQuery.RecNo - 1].Cupom := vQuery.FieldByName('nrcpm').AsInteger;
          ATerminalBalcao[vQuery.RecNo - 1].UsuarioAutorizacao := vQuery.FieldByName('useridaut').AsString;
          ATerminalBalcao[vQuery.RecNo - 1].Tipo := vQuery.FieldByName('tpitm').AsString;
          ATerminalBalcao[vQuery.RecNo - 1].ValorDesconto := vQuery.FieldByName('vrdsc').AsFloat;
          ATerminalBalcao[vQuery.RecNo - 1].PercentualDesconto := vQuery.FieldByName('ptdsc').AsFloat;
          ATerminalBalcao[vQuery.RecNo - 1].ValorTotal := vQuery.FieldByName('semdesconto').AsFloat;
          ATerminalBalcao[vQuery.RecNo - 1].DescricaoDesconto := vQuery.FieldByName('descrprd').AsString;
          ATerminalBalcao[vQuery.RecNo - 1].CdTml := vQuery.FieldByName('cdtml').AsString;
          ATerminalBalcao[vQuery.RecNo - 1].DtOpe := vQuery.FieldByName('dtope').AsDateTime;
          ATerminalBalcao[vQuery.RecNo - 1].OperId := vQuery.FieldByName('operid').AsInteger;
          ATerminalBalcao[vQuery.RecNo - 1].ItemId := vQuery.FieldByName('itemid').AsInteger;

          vQuery.Next;
        end;
      end;
    except
      on e: Exception do
        raise Exception.Create('Erro ao tentar pegar o terminal balcão. (' + e.Message + ')');
    end;
  finally
    vQuery.Free;
  end;
end;


function RetornaDescricaoProduto(ACodigoProduto: integer; AConnection: TFDConnection): string;
var
  vQuery: TFDQuery;
begin
  Result := EmptyStr;
  vQuery := TFDQuery.Create(nil);

  try
    try
      vQuery.Connection := AConnection;
      vQuery.Close;
      vQuery.SQL.Add(' select upper(descprd) as descricao ');
      vQuery.SQL.Add('   from fc03000 ');
      vQuery.SQL.Add('  where fc03000.cdpro = :cdpro ');
      vQuery.ParamByName('cdpro').AsInteger := ACodigoProduto;
      vQuery.Open;

      Result := vQuery.FieldByName('descricao').AsString;
    except
      on e: Exception do
        raise Exception.Create('Erro ao tentar pegar a descrição do produto. (' + e.Message + ')');
    end;
  finally
    vQuery.Free;
  end;
end;

function usaDescontoPrivilege: Boolean;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'PriviConnect.ini');
  try
    Result := Ini.ReadString('API', 'usaDescontoPrivilege', 'S') = 'S';
  finally
    Ini.Free;
  end;
end;

function ExisteProduto(ACodigoProduto: Integer; AConstante: array of integer): Boolean;
var
  vContador: Integer;
begin
  Result := False;
  for vContador := Low(AConstante) to High(AConstante) do
    if AConstante[vContador] = ACodigoProduto then
      Exit(True);
end;

function ArrayToSQL(const AArray: array of Integer): string;
var
  I: Integer;
begin
  Result := '';
  for I := Low(AArray) to High(AArray) do
  begin
    Result := Result + AArray[I].ToString;
    if I < High(AArray) then
      Result := Result + ',';
  end;
end;

function StaticToDyn(const AArray: array of Integer): TArray<Integer>;
var
  I: Integer;
begin
  SetLength(Result, Length(AArray));
  for I := 0 to High(AArray) do
    Result[I] := AArray[I];
end;

procedure PreencherJSONArrayProdutoOrcamento(out AJSONArray: TJSONArray; ACampanha, ANomeProduto : string; ACodigoProduto: Integer; AValorUnitario, APercentualDesconto, AValorUnitarioDescontado, AValorLiquido: Double);
var
  vJSONObject: TJSONObject;
begin
  vJSONObject := TJSONObject.Create;

  vJSONObject.AddPair('campanha', ACampanha);
  vJSONObject.AddPair('tipo_item', 'Varejo');
  vJSONObject.AddPair('produto', IntToStr(ACodigoProduto));
  vJSONObject.AddPair('nome_produto', ANomeProduto);
  vJSONObject.AddPair('valor_total', FloatToStr(AValorUnitario));
  vJSONObject.AddPair('percentual_desconto', FloatToStr(APercentualDesconto));
  vJSONObject.AddPair('valor_desconto', FloatToStr(AValorUnitarioDescontado));
  vJSONObject.AddPair('valor_liquido', FloatToStr(AValorLiquido));

  if not ExisteNoJsonProdutoOrcamento(AJSONArray, vJSONObject) then
    AJSONArray.AddElement(vJSONObject)
  else
    vJSONObject.Free;
end;

procedure PreencherJSONArrayOrcamento(out AJSONArray: TJSONArray; ACampanha, ATipoItem: string; AFilial, AOrcamento: Integer; AValorUnitario, APercentualDesconto, AValorUnitarioDescontado, AValorLiquido: Double);
var
  vJSONObject: TJSONObject;
begin
  vJSONObject := TJSONObject.Create;

  vJSONObject.AddPair('campanha', ACampanha);
  vJSONObject.AddPair('orcamento', IntToStr(AOrcamento));
  vJSONObject.AddPair('tipo_item', IfThen((ATipoItem = 'R'),'Fórmula','Varejo'));
  vJSONObject.AddPair('filial', IntToStr(AFilial));
  vJSONObject.AddPair(IfThen((ATipoItem = 'R'),'requisicao','produto'), '');
  vJSONObject.AddPair('descricao', 'Requisição ainda não gerada');
  vJSONObject.AddPair('valor_total', FloatToStr(AValorUnitario));
  vJSONObject.AddPair('percentual_desconto', FloatToStr(APercentualDesconto));
  vJSONObject.AddPair('valor_desconto', FloatToStr(AValorUnitarioDescontado));
  vJSONObject.AddPair('valor_liquido', FloatToStr(AValorLiquido));

  if not ExisteNoJsonOrcamento(AJSONArray, vJSONObject) then
    AJSONArray.AddElement(vJSONObject)
  else
    vJSONObject.Free;
end;

procedure PreencherJSONArrayTerminalBalcao(out AJSONArray: TJSONArray; ACampanha, ATipoItem: string; AFilial, ACodigoProduto, ATerminalBalcao: Integer; ADescricaoProduto: string; AValorUnitario, APercentualDesconto, AValorUnitarioDescontado, AValorLiquido: Double);
var
  vJSONObject: TJSONObject;
begin
  vJSONObject := TJSONObject.Create;

  vJSONObject.AddPair('campanha', ACampanha);
  vJSONObject.AddPair('terminal_balcao', IntToStr(ATerminalBalcao));
  vJSONObject.AddPair('tipo_item', IfThen((ATipoItem = 'R'),'Fórmula','Varejo'));
  vJSONObject.AddPair('filial', IntToStr(AFilial));
  vJSONObject.AddPair(IfThen((ATipoItem = 'R'),'requisicao','produto'), IntToStr(ACodigoProduto));
  vJSONObject.AddPair('descricao', ADescricaoProduto);
  vJSONObject.AddPair('valor_total', FloatToStr(AValorUnitario));
  vJSONObject.AddPair('percentual_desconto', FloatToStr(APercentualDesconto));
  vJSONObject.AddPair('valor_desconto', FloatToStr(AValorUnitarioDescontado));
  vJSONObject.AddPair('valor_liquido', FloatToStr(AValorLiquido));

  if not ExisteNoJson(AJSONArray, vJSONObject) then
    AJSONArray.AddElement(vJSONObject)
  else
    vJSONObject.Free;

end;

function BuildKey(AObj: TJSONObject): string;
var
  LItem: string;
begin
  if AObj.GetValue('tipo_item').Value = 'Fórmula' then
    LItem := AObj.GetValue('requisicao').Value
  else
    LItem := AObj.GetValue('produto').Value;

  Result :=
    AObj.GetValue('campanha').Value + '|' +
    AObj.GetValue('terminal_balcao').Value + '|' +
    AObj.GetValue('tipo_item').Value + '|' +
    AObj.GetValue('filial').Value + '|' +
    LItem;
end;

function BuildKeyProdutoOrcamento(AObj: TJSONObject): string;
var
  LItem: string;
begin
  if AObj.GetValue('tipo_item').Value = 'Fórmula' then
    LItem := AObj.GetValue('requisicao').Value
  else
    LItem := AObj.GetValue('produto').Value;

  Result :=
    AObj.GetValue('campanha').Value + '|' +
    LItem;
end;


function BuildKeyOrcamento(AObj: TJSONObject): string;
var
  LItem: string;
begin
  if AObj.GetValue('tipo_item').Value = 'Fórmula' then
    LItem := AObj.GetValue('requisicao').Value
  else
    LItem := AObj.GetValue('produto').Value;

  Result :=
    AObj.GetValue('campanha').Value + '|' +
    AObj.GetValue('orcamento').Value + '|' +
    AObj.GetValue('tipo_item').Value + '|' +
    AObj.GetValue('filial').Value + '|' +
    LItem;
end;

function ExisteNoJson(ACampanhas: TJSONArray; ANovo: TJSONObject): Boolean;
var
  I: Integer;
  Obj: TJSONObject;
  KeyNovo, KeyExistente: string;
begin
  Result := False;
  KeyNovo := BuildKey(ANovo);

  for I := 0 to ACampanhas.Count - 1 do
  begin
    Obj := ACampanhas.Items[I] as TJSONObject;
    KeyExistente := BuildKey(Obj);

    if KeyExistente = KeyNovo then
      Exit(True);
  end;
end;

function ExisteNoJsonProdutoOrcamento(ACampanhas: TJSONArray; ANovo: TJSONObject): Boolean;
var
  I: Integer;
  Obj: TJSONObject;
  KeyNovo, KeyExistente: string;
begin
  Result := False;
  KeyNovo := BuildKeyProdutoOrcamento(ANovo);

  for I := 0 to ACampanhas.Count - 1 do
  begin
    Obj := ACampanhas.Items[I] as TJSONObject;
    KeyExistente := BuildKeyProdutoOrcamento(Obj);

    if KeyExistente = KeyNovo then
      Exit(True);
  end;
end;


function ExisteNoJsonOrcamento(ACampanhas: TJSONArray; ANovo: TJSONObject): Boolean;
var
  I: Integer;
  Obj: TJSONObject;
  KeyNovo, KeyExistente: string;
begin
  Result := False;
  KeyNovo := BuildKeyOrcamento(ANovo);

  for I := 0 to ACampanhas.Count - 1 do
  begin
    Obj := ACampanhas.Items[I] as TJSONObject;
    KeyExistente := BuildKeyOrcamento(Obj);

    if KeyExistente = KeyNovo then
      Exit(True);
  end;
end;


function TrocaVirgulaPorPonto(AValue: string): string;
var
  i: integer;
begin
  if AValue = null then
    AValue := '0';
  if AValue <> '' then
  begin
    for i := 0 to Length(AValue) do
    begin
      if AValue[i] = ',' then
        AValue[i] := '.';
    end;
  end;
  Result := AValue;
end;

function MudarPonto(valor: double): string;
begin
  result := StringReplace(formatfloat('0.##', valor), ',', '.', [rfReplaceAll, rfIgnoreCase]);
end;

end.
