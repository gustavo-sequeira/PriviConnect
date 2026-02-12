unit Desconto.Controller;

interface

uses
  Horse,
  System.JSON,
  System.SysUtils,
  System.StrUtils,           // SameText / IfThen
  Desconto.Model,
  FireDAC.Comp.Client,
  DataSet.Serialize;

procedure Registry;

implementation

uses
  Data.DB,
  System.Generics.Collections,
  uCampanha,
  Desconto.Constantes.CampanhasMap,
  Desconto.RequestModel;

{ --- Helpers de resposta --------------------------------------------------- }

procedure SendError(const Res: THorseResponse; const AMsg: string; AStatus: Integer = 400);
begin
  Res.Send(
    TJSONObject.Create.AddPair('erro', AMsg)
  ).Status(AStatus);
end;

procedure SendInfo(const Res: THorseResponse; const AMsg: string; AStatus: Integer = 404);
begin
  Res.Send(
    TJSONObject.Create.AddPair('info', AMsg)
  ).Status(AStatus);
end;

{ --- Helpers de parsing ---------------------------------------------------- }

/// <summary>
/// Lê o body como JSON e valida se veio algo.
/// </summary>
function GetBodyJSON(const Req: THorseRequest; const Res: THorseResponse;
  out ABody: TJSONObject): Boolean;
begin
  ABody := Req.Body<TJSONObject>;
  Result := Assigned(ABody);
  if not Result then
    SendError(Res, 'JSON de entrada inválido.', 400);
end;

/// <summary>
/// Lê CPF / telefone. Pelo menos um deles precisa vir.
/// Preenche também o JSON de retorno.
/// </summary>
procedure ParseCliente(const ABody: TJSONObject; const ADesconto: TDesconto;
  const ARetorno: TJSONObject);
var
  vTelefoneValue: TJSONValue;
begin
  ADesconto.TelefoneCliente := 0;

  if ABody.TryGetValue('telefone', vTelefoneValue) then
  begin
    ADesconto.TelefoneCliente := vTelefoneValue.AsType<Int64>;
    ARetorno.AddPair('telefone', IntToStr(ADesconto.TelefoneCliente));
  end;

  if (ADesconto.TelefoneCliente = 0) then
    raise Exception.Create('É obrigatório informar Telefone.');
end;

/// <summary>
/// Lê a lista de produtos do JSON e joga em ADesconto.CodigosProdutos.
/// </summary>
procedure ParseProdutos(const ABody: TJSONObject; const ADesconto: TDesconto);
var
  vJsonCodigos: TJSONArray;
  vIndice: Integer;
begin
  ADesconto.CodigosProdutos.Clear;

  if ABody.TryGetValue('produtos', vJsonCodigos) then
  begin
    vJsonCodigos := ABody.GetValue<TJSONArray>('produtos');

    for vIndice := 0 to vJsonCodigos.Count - 1 do
      ADesconto.CodigosProdutos.Add(
        StrToIntDef(vJsonCodigos.Items[vIndice].Value, 0)
      );
  end;
end;

/// <summary>
/// Valida a campanha informada (se houver) e se ela é aplicável
/// para os produtos / CPF informados.
/// </summary>
procedure ParseCampanha(const ABody: TJSONObject; const ADesconto: TDesconto);
var
  vCampanhaId: string;
  vMapa: TDictionary<string, string>;
  vGerenciador: TGerenciadorCampanhas;
  vCampanhasValidas: TList<ICampanha>;
  vCampanha: ICampanha;
  vCampanhaAplicavel: Boolean;
begin
  // campanha é opcional
  if not ABody.TryGetValue<string>('campanha', vCampanhaId) then
    Exit;

  // 1) valida se existe no mapa da API
  vMapa := MapaCampanhas;
  try
    if not vMapa.ContainsKey(vCampanhaId) then
      raise Exception.CreateFmt(
        'A campanha "%s" não é conhecida pela API do PriviConnect.',
        [vCampanhaId]
      );

    ADesconto.Campanha := vCampanhaId;
  finally
    vMapa.Free;
  end;

  // 2) valida se a campanha está ativa e aplicável para os produtos enviados
  vGerenciador := TGerenciadorCampanhas.Create;
  try
    vCampanhasValidas := vGerenciador.ObterCampanhasAplicaveis(ADesconto.CodigosProdutos);
    vCampanhaAplicavel := False;

    for vCampanha in vCampanhasValidas do
    begin
      if not vCampanha.Valida then
        Continue;

      // compara pelo NOME da campanha (usando o mapa para achar a descrição)
      if SameText(vCampanha.Nome, MapaCampanhas[vCampanhaId]) then
      begin
        vCampanhaAplicavel := True;
        Break;
      end;
    end;

    if not vCampanhaAplicavel then
      raise Exception.CreateFmt(
        'A campanha "%s" não está ativa ou não é aplicável para os produtos/CPF informados.',
        [ADesconto.Campanha]
      );
  finally
    vGerenciador.Free;
  end;
end;

{ --- Endpoint principal ---------------------------------------------------- }

procedure ListarDescontosOrcamentosProdutos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  vBody: TJSONObject;
  vRetorno: TJSONObject;
  vCampanhasJson: TJSONArray;
  vDesconto: TDesconto;
  vErro: string;
begin
  vDesconto      := TDesconto.Create;
  vRetorno       := TJSONObject.Create;
  vCampanhasJson := nil;
  vBody          := nil;
  vErro          := '';

  try
    try
      // 1) Body JSON
      if not GetBodyJSON(Req, Res, vBody) then
        Exit;

      // 2) Cliente (CPF / telefone)
      ParseCliente(vBody, vDesconto, vRetorno);

      // 3) Produtos
      ParseProdutos(vBody, vDesconto);

      // 4) Campanha (opcional, mas se vier precisa ser válida)
      ParseCampanha(vBody, vDesconto);

      // 5) Chama o core para buscar os descontos
      vCampanhasJson := vDesconto.ListarDescontosPorProdutos(vErro);

      if Assigned(vCampanhasJson) and (vCampanhasJson.Count > 0) then
      begin
        // transfere a posse do array para o JSON de retorno
        vRetorno.AddPair('campanhas', vCampanhasJson);
        vCampanhasJson := nil;

        Res.Send<TJSONObject>(vRetorno).Status(200);
        vRetorno := nil;
      end
      else
      begin
        SendInfo(Res, Format('Não existe campanha ativa para esse CPF (%s).', [IntToStr(vDesconto.CpfCliente)]), 404);
      end;

    except
      on E: Exception do
        // se vErro vier preenchido do Model, inclui na mensagem
        SendError(Res, E.Message + IfThen(vErro <> '', ' - ' + vErro, ''), 500);
    end;

  finally
    vDesconto.Free;
    vRetorno.Free;
    vCampanhasJson.Free;
  end;
end;

procedure Registry;
begin
  THorse.Post('/descontos', ListarDescontosOrcamentosProdutos);
end;

end.

