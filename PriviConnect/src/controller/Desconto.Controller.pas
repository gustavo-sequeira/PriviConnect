unit Desconto.Controller;

interface

uses
  Horse;

procedure Registry;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.JSON,
  Desconto.Model;

function GetTelefoneAsString(const AObj: TJSONObject): string;
var
  vVal: TJSONValue;
begin
  Result := '';
  if Assigned(AObj) and AObj.TryGetValue('telefone', vVal) then
    Result := vVal.Value;

  Result := Trim(Result);
  Result := StringReplace(Result, '"', '', [rfReplaceAll]);
end;

procedure SendError(const Res: THorseResponse; const AMsg: string; AStatus: Integer);
begin
  Res.Send(TJSONObject.Create.AddPair('erro', AMsg)).Status(AStatus);
end;

procedure SendInfo(const Res: THorseResponse; const AMsg: string; AStatus: Integer);
begin
  Res.Send(TJSONObject.Create.AddPair('info', AMsg)).Status(AStatus);
end;

procedure ListarDescontosOrcamentosProdutos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  vBody: TJSONObject;
  vRetorno: TJSONObject;
  vCampanhas: TJSONArray;
  vDesconto: TDesconto;
  vErro: string;

  vTelefone: string;
  vArrProdutos: TJSONArray;
  i: Integer;
begin
  vBody := nil;
  vRetorno := TJSONObject.Create;
  vCampanhas := nil;
  vDesconto := TDesconto.Create;
  vErro := '';

  try
  try
    vBody := Req.Body<TJSONObject>;
    if not Assigned(vBody) then
    begin
      SendError(Res, 'JSON inválido.', 400);
      Exit;
    end;

    // telefone obrigatório
    vTelefone := GetTelefoneAsString(vBody);
    if vTelefone = '' then
    begin
      SendError(Res, 'Informe "telefone" (string com DDD).', 400);
      Exit;
    end;

    vDesconto.TelefoneClienteStr := vTelefone;
    vRetorno.AddPair('telefone', vTelefone);

    // produtos opcionais
    vDesconto.CodigosProdutos.Clear;
    vArrProdutos := nil;

    if vBody.TryGetValue<TJSONArray>('produtos', vArrProdutos) and Assigned(vArrProdutos) then
    begin
      for i := 0 to vArrProdutos.Count - 1 do
        vDesconto.CodigosProdutos.Add(StrToIntDef(vArrProdutos.Items[i].Value, 0));
    end;

    // chama model (retorna array flat)
    vCampanhas := vDesconto.ListarDescontosPorProdutos(vErro);

    if Assigned(vCampanhas) and (vCampanhas.Count > 0) then
    begin
      // ? flat (sem array dentro de array)
      vRetorno.AddPair('campanhas', vCampanhas);
      vCampanhas := nil;

      Res.Send<TJSONObject>(vRetorno).Status(200);
      vRetorno := nil;
    end
    else
      SendInfo(Res, 'Nenhuma campanha aplicável para o telefone/produtos informados.', 404);

  except
    on E: Exception do
      SendError(Res, E.Message + IfThen(vErro <> '', ' - ' + vErro, ''), 500);
      end

  finally
    vDesconto.Free;
    vRetorno.Free;
    vCampanhas.Free;
  end;
end;


procedure Registry;
begin
  THorse.Post('/descontos', ListarDescontosOrcamentosProdutos);
end;

end.

