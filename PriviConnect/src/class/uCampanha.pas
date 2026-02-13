unit uCampanha;

interface

uses
  System.SysUtils, System.Generics.Collections, Desconto.Constantes.Campanhas,
  FireDAC.Comp.Client, Desconto.Tipos;

type

  TRecCampanhaClienteOrcamentos = record
    Cpf: Int64;
    Ddd: Integer;
    Celular: Int64;
    NomeCliente: string;

    IdCampanha: Integer;
    NomeCampanha: string;

    VerificaSaldo: string;
    Saldo: Double;
    DtValidade: TDate;

    TpDesc: string;
    TipoDesconto: string;

    ValorVarejo: Double;
    ValorFormula: Double;

    PercentualVarejo: Double;
    PercentualFormula: Double;

    Orcamento: Integer;
  end;

  ICampanha = interface
    ['{9D52F65C-9E9C-4D4D-81BE-CCAD92E87E47}']
    function Nome: string;
    function Valida: Boolean;
    function Aplicavel(const ACodProduto: TList<Integer>): Boolean;
    function PossuiProduto(const AListaProdutos: TList<Integer>): Boolean;
  end;

  TCampanha = class(TInterfacedObject, ICampanha)
  private
    FNome: string;
    FProdutos: TArray<TArray<Integer>>;
    FValida: Boolean;
  public
    constructor Create(const ANome: string; const AProdutos: TArray<TArray<Integer>>; const AValida: Boolean); overload;
    constructor Create(const ANome: string; const AProdutos: TArray<Integer>; const AValida: Boolean); overload;
    function Nome: string;
    function Valida: Boolean;
    function Aplicavel(const AListaProdutos: TList<Integer>): Boolean;
    function PossuiProduto(const AListaProdutos: TList<Integer>): Boolean;
    function Aplicabilidade(const AListaProdutos: TList<Integer>): TAplicabilidadeInfo;
  end;

  TCampanhaAplicavel = class
  public
    Campanha: ICampanha;
    Aplicabilidade: TAplicabilidadeInfo;
    destructor Destroy; override;
  end;

  TGerenciadorCampanhas = class
  private
    FLista: TList<ICampanha>;
    procedure CarregarCampanhas;
  public
    constructor Create;
    destructor Destroy; override;
    function ObterCampanhasAplicaveis(const AListaProdutos: TList<Integer>): TList<ICampanha>;
    function ObterCampanhasAplicaveisDetalhado(const AListaProdutos: TList<Integer>): TObjectList<TCampanhaAplicavel>;
  end;

  TCampanhaClienteOrcamentos = class
  public
    class function FromQuery(Qry: TFDQuery; out Campanha: TRecCampanhaClienteOrcamentos): Boolean;
    class function FillList(Qry: TFDQuery; Lista: TList<TRecCampanhaClienteOrcamentos>): Boolean;
    class function GetList(Qry: TFDQuery): TList<TRecCampanhaClienteOrcamentos>;
  end;

implementation

uses
  Desconto.Base, Desconto.Utils, Desconto.Constantes.Produtos;

{ TCampanha }

function TCampanha.Aplicabilidade(const AListaProdutos: TList<Integer>): TAplicabilidadeInfo;

  function CampanhaCobreProduto(const AProduto: Integer): Boolean;
  var
    i, j: Integer;
  begin
    Result := False;

    if Length(FProdutos) = 0 then
      Exit(False);

    for i := 0 to Length(FProdutos) - 1 do
    begin
      if Length(FProdutos[i]) = 0 then
        Continue;

      for j := 0 to Length(FProdutos[i]) - 1 do
      begin
        if AProduto = FProdutos[i][j] then
        begin
          Result := True;
          Exit; // sai imediatamente
        end;
      end;
    end;
  end;

var
  i: Integer;
  vProduto: Integer;
begin
  Result := TAplicabilidadeInfo.Create;

  if (AListaProdutos = nil) or (AListaProdutos.Count = 0) or (Length(FProdutos) = 0) then
  begin
    Result.Status := asNenhuma;
    Exit;
  end;

  Result.TotalInformados := AListaProdutos.Count;

  // Verifica cobertura produto a produto
  for i := 0 to AListaProdutos.Count - 1 do
  begin
    vProduto := AListaProdutos[i];
    if CampanhaCobreProduto(vProduto) then
    begin
      Inc(Result.TotalCobertos);
      Result.ProdutosCobertos.Add(vProduto);
    end
    else
      Result.ProdutosNaoCobertos.Add(vProduto);
  end;

  if Result.TotalCobertos = 0 then
    Result.Status := asNenhuma
  else if Result.TotalCobertos = Result.TotalInformados then
    Result.Status := asTotal
  else
    Result.Status := asParcial;
end;

constructor TCampanha.Create(const ANome: string; const AProdutos: TArray<TArray<Integer>>; const AValida: Boolean);
begin
  FNome := ANome;
  FProdutos := AProdutos;
  FValida := AValida;
end;

constructor TCampanha.Create(const ANome: string; const AProdutos: TArray<Integer>; const AValida: Boolean);
begin
  Create(ANome, [AProdutos], AValida);
end;

function TCampanha.Nome: string;
begin
  Result := FNome;
end;

function TCampanha.PossuiProduto(const AListaProdutos: TList<Integer>): Boolean;
begin
  Result := Aplicavel(AListaProdutos);
end;

function TCampanha.Valida: Boolean;
begin
  Result := FValida;
end;

function TCampanha.Aplicavel(const AListaProdutos: TList<Integer>): Boolean;
var
  vInfo: TAplicabilidadeInfo;
begin
  vInfo := Aplicabilidade(AListaProdutos);
  try
    Result := vInfo.Status <> asNenhuma;
  finally
    vInfo.Free;
  end;
end;

{ TGerenciadorCampanhas }

constructor TGerenciadorCampanhas.Create;
begin
  FLista := TList<ICampanha>.Create;
  CarregarCampanhas;
end;

destructor TGerenciadorCampanhas.Destroy;
begin
  FLista.Free;
  inherited;
end;

procedure TGerenciadorCampanhas.CarregarCampanhas;
begin
  FLista.Add(TCampanha.Create(CAMPANHA_DESCONTO_LOJA, StaticToDyn(PRODUTOS_DESCONTO_LOJA), False));
  FLista.Add(TCampanha.Create(CAMPANHA_PRIVILEGE, [
    StaticToDyn(PRODUTOS_DESCONTO_CARTAO_01),
    StaticToDyn(PRODUTOS_DESCONTO_CARTAO_02),
    StaticToDyn(PRODUTOS_DESCONTO_CARTAO_03),
    StaticToDyn(PRODUTOS_DESCONTO_CARTAO_04),
    StaticToDyn(PRODUTOS_DESCONTO_CARTAO_05),
    StaticToDyn(PRODUTOS_DESCONTO_CARTAO_06)], True));
  FLista.Add(TCampanha.Create(CAMPANHA_CAMPANHAS, [[]], True));
  FLista.Add(TCampanha.Create(CAMPANHA_FRANQUIA, [[]], False));
  FLista.Add(TCampanha.Create(CAMPANHA_PROGRESSIVO, [[]], True));
  FLista.Add(TCampanha.Create(CAMPANHA_COLAGENO, StaticToDyn(PRODUTOS_DESCONTO_PROGRESSIVO_COLAGENO), True));
  FLista.Add(TCampanha.Create(CAMPANHA_CABELOS, StaticToDyn(PRODUTOS_DESCONTO_PROGRESSIVO_CABELO), True));
  FLista.Add(TCampanha.Create(CAMPANHA_PREVAGING, StaticToDyn(PRODUTOS_DESCONTO_PROGRESSIVO_PREVAGING), True));
  FLista.Add(TCampanha.Create(CAMPANHA_PERFORMANCE, StaticToDyn(PRODUTOS_DESCONTO_POWERTRAINNING), True));
  FLista.Add(TCampanha.Create(CAMPANHA_CLEAN_THERAPY, StaticToDyn(PRODUTOS_LINHA_CLEAN_THERAPY), True));
  FLista.Add(TCampanha.Create(CAMPANHA_PRESENTES, StaticToDyn(PRODUTOS_PROGRESSIVO_PRESENTE), True));
  FLista.Add(TCampanha.Create(CAMPANHA_IFOOD, [[]], False));
  FLista.Add(TCampanha.Create(CAMPANHA_CLONE_ALMOFADA, StaticToDyn(PRODUTOS_CLONE_ALMOFADA), True));
  FLista.Add(TCampanha.Create(CAMPANHA_GESSO_PERFUMADO, StaticToDyn(PRODUTOS_GESSO_PERFUMADO), True));
  FLista.Add(TCampanha.Create(CAMPANHA_PHARMAPET, [StaticToDyn(PRODUTOS_VENDAS_PET_01), StaticToDyn(PRODUTOS_VENDAS_PET_02)], True));
  FLista.Add(TCampanha.Create(CAMPANHA_BRINDES, StaticToDyn(PRODUTOS_BRINDE_COMPRA), True));
  FLista.Add(TCampanha.Create(CAMPANHA_PDRN, [[]], False));
  FLista.Add(TCampanha.Create(CAMPANHA_DIA_CRIANCAS, [[]], False));
  FLista.Add(TCampanha.Create(CAMPANHA_STICK_BOLSA_PRAIA, [StaticToDyn(PRODUTOS_STICK_BOLSA_PRAIA_01), StaticToDyn(PRODUTOS_STICK_BOLSA_PRAIA_02)], True));
  FLista.Add(TCampanha.Create(CAMPANHA_CARNAVAL_2026, StaticToDyn(PRODUTOS_CARNAVAL_2026), True));
  FLista.Add(TCampanha.Create(CAMPANHA_CREATINA_2026, [StaticToDyn(PRODUTOS_CREATINA_2026_01), StaticToDyn(PRODUTOS_CREATINA_2026_02)], True));
end;

function TGerenciadorCampanhas.ObterCampanhasAplicaveis(const AListaProdutos: TList<Integer>): TList<ICampanha>;
var
  Det: TObjectList<TCampanhaAplicavel>;
  i: Integer;
begin
  Result := TList<ICampanha>.Create;

  Det := ObterCampanhasAplicaveisDetalhado(AListaProdutos);
  try
    for i := 0 to Det.Count - 1 do
      Result.Add(Det[i].Campanha);
  finally
    Det.Free;
  end;
end;

function TGerenciadorCampanhas.ObterCampanhasAplicaveisDetalhado(
  const AListaProdutos: TList<Integer>): TObjectList<TCampanhaAplicavel>;
var
  C: ICampanha;
  Item: TCampanhaAplicavel;
  Info: TAplicabilidadeInfo;
begin
  Result := TObjectList<TCampanhaAplicavel>.Create(True);

  for C in FLista do
  begin
    if not C.Valida then
      Continue;

    Info := (C as TCampanha).Aplicabilidade(AListaProdutos);
    if Info.Status = asNenhuma then
    begin
      Info.Free;
      Continue;
    end;

    Item := TCampanhaAplicavel.Create;
    Item.Campanha := C;
    Item.Aplicabilidade := Info;
    Result.Add(Item);
  end;
end;

{ TCampanhaClienteOrcamentos }

class function TCampanhaClienteOrcamentos.FillList(Qry: TFDQuery; Lista: TList<TRecCampanhaClienteOrcamentos>): Boolean;
var
  Item: TRecCampanhaClienteOrcamentos;
begin
  Lista.Clear;

  Qry.First;
  while not Qry.Eof do
  begin
    FromQuery(Qry, Item);
    Lista.Add(Item);
    Qry.Next;
  end;

  Result := Lista.Count > 0;
end;

class function TCampanhaClienteOrcamentos.FromQuery(Qry: TFDQuery;
  out Campanha: TRecCampanhaClienteOrcamentos): Boolean;
begin
  Result := not Qry.IsEmpty;
  if not Result then
    Exit;

  Campanha.Cpf               := Qry.FieldByName('cpfcli').AsLargeInt;
  Campanha.Ddd               := Qry.FieldByName('ddd').AsInteger;
  Campanha.Celular           := Qry.FieldByName('celular').AsLargeInt;
  Campanha.NomeCliente       := Qry.FieldByName('nomecli').AsString;

  Campanha.IdCampanha        := Qry.FieldByName('idcamp').AsInteger;
  Campanha.NomeCampanha      := Qry.FieldByName('nomecampanha').AsString;

  Campanha.VerificaSaldo     := Qry.FieldByName('verificasaldo').AsString;
  Campanha.Saldo             := Qry.FieldByName('saldo').AsFloat;
  Campanha.DtValidade        := Qry.FieldByName('dtvalidade').AsDateTime;

  Campanha.TpDesc            := Qry.FieldByName('tpdesc').AsString;
  Campanha.TipoDesconto      := Qry.FieldByName('TipoDesconto').AsString;

  Campanha.ValorVarejo       := Qry.FieldByName('ValorVarejo').AsFloat;
  Campanha.ValorFormula      := Qry.FieldByName('ValorFormula').AsFloat;

  Campanha.PercentualVarejo  := Qry.FieldByName('PercentualVarejo').AsFloat;
  Campanha.PercentualFormula := Qry.FieldByName('PercentualFormula').AsFloat;
end;

class function TCampanhaClienteOrcamentos.GetList(Qry: TFDQuery): TList<TRecCampanhaClienteOrcamentos>;
var
  Item: TRecCampanhaClienteOrcamentos;
begin
  Result := TList<TRecCampanhaClienteOrcamentos>.Create;

  Qry.First;
  while not Qry.Eof do
  begin
    FromQuery(Qry, Item);
    Result.Add(Item);
    Qry.Next;
  end;
end;

{ TCampanhaAplicavel }

destructor TCampanhaAplicavel.Destroy;
begin
  Aplicabilidade.Free;
  inherited;
end;

end.

