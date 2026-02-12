unit Desconto.Model;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  System.JSON,
  FireDAC.Comp.Client,
  Data.DB,
  Config.Database,
  Desconto.Tipos,
  uCampanha;

type
  TDesconto = class
  private
    // ✅ Novo cenário: fonte oficial é TelefoneClienteStr
    FTelefoneClienteStr: string;

    // Mantive os antigos por compatibilidade (se outras units usam)
    FCpfCliente: Int64;
    FTelefoneCliente: Int64;

    FCodigosProdutos: TList<Integer>;

    procedure PegarDescontos(AInfo: TInfoDesconto; AJSONArray: TJSONArray);
    procedure PegarDescontosProdutosOrcamento(AInfo: TInfoDesconto;
      ACampanha: TRecCampanhaClienteOrcamentos; AJSONArray: TJSONArray);

  public
    constructor Create;
    destructor Destroy; override;

    // 🔑 Entrada principal usada pelo Controller
    function ListarDescontosPorProdutos(out erro: string): TJSONArray;

    // propriedades
    property TelefoneClienteStr: string read FTelefoneClienteStr write FTelefoneClienteStr;
    property TelefoneCliente: Int64 read FTelefoneCliente write FTelefoneCliente; // legado
    property CpfCliente: Int64 read FCpfCliente write FCpfCliente;               // legado (não usado externamente)
    property CodigosProdutos: TList<Integer> read FCodigosProdutos;
  end;

implementation

uses
  System.StrUtils,
  Desconto.Base,
  Desconto.Sqls,
  Desconto.Utils,
  Desconto.Constantes.Campanhas;

{ TDesconto }

constructor TDesconto.Create;
begin
  inherited Create;

  Config.Database.Connect;
  FCodigosProdutos := TList<Integer>.Create;
  FCpfCliente := 0;
  FTelefoneCliente := 0;
  FTelefoneClienteStr := '';
end;

destructor TDesconto.Destroy;
begin
  FCodigosProdutos.Free;
  Config.Database.Disconect;
  inherited Destroy;
end;

function TDesconto.ListarDescontosPorProdutos(out erro: string): TJSONArray;
var
  vCampanhasArray: TJSONArray;
  Info: TInfoDesconto;
  vTelefoneNum: Int64;
begin
  erro := '';
  vCampanhasArray := TJSONArray.Create;

  // ✅ telefone sempre vem da string (request)
  if Trim(FTelefoneClienteStr) <> '' then
    vTelefoneNum := StrToInt64Def(FTelefoneClienteStr, 0)
  else
    vTelefoneNum := FTelefoneCliente; // fallback legado

  if vTelefoneNum <= 0 then
    Exit(vCampanhasArray); // retorna array vazio (Controller transforma em 404)

  // monta Info
  FillChar(Info, SizeOf(Info), 0);
  Info.Telefone := vTelefoneNum;
  Info.Cpf := 0; // ✅ não usamos CPF externo

  Info.DatabaseFDConnectionFormulaCerta := Config.Database.ConnectionFC;
  Info.DatabaseFDConnectionPrivilege := Config.Database.ConnectionPRV;

  // executa cálculo e preenche o array
  PegarDescontos(Info, vCampanhasArray);

  Result := vCampanhasArray;
end;

procedure TDesconto.PegarDescontos(AInfo: TInfoDesconto; AJSONArray: TJSONArray);

  procedure ExecutarCampanhaPrivilege(const ANomeCampanha: string; var AValorCartao: Double);
  begin
    // loja
    if SameText(ANomeCampanha, CAMPANHA_DESCONTO_LOJA) then
      Desconto.Base.Desconto_Loja(AInfo, CodigosProdutos, tcWebService, AJSONArray)

    // cartão / privilege
    else if SameText(ANomeCampanha, CAMPANHA_PRIVILEGE) then
      Desconto.Base.Desconto_Cartao(AValorCartao, AInfo, CodigosProdutos, [], tcWebService, AJSONArray)

    // franquia
    else if SameText(ANomeCampanha, CAMPANHA_FRANQUIA) then
      Desconto.Base.Desconto_Franquia(AInfo, CodigosProdutos, tcWebService, AJSONArray)

    // progressivos / performance
    else if SameText(ANomeCampanha, CAMPANHA_PROGRESSIVO) then
      Desconto.Base.Desconto_Progressivo(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_COLAGENO) then
      Desconto.Base.Desconto_Progressivo_Colageno(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_CABELOS) then
      Desconto.Base.Desconto_Progressivo_Cabelo(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_PREVAGING) then
      Desconto.Base.Desconto_Progressivo_PrevAging(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_PERFORMANCE) then
      Desconto.Base.Desconto_Progressivo_PowerTrainning(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)

    // clean / presentes / ifood
    else if SameText(ANomeCampanha, CAMPANHA_CLEAN_THERAPY) then
      Desconto.Base.Desconto_Linha_Clean_Therapy(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_PRESENTES) then
      Desconto.Base.Desconto_Presentes(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_IFOOD) then
      Desconto.Base.Desconto_IFood(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)

    // brindes / pet
    else if SameText(ANomeCampanha, CAMPANHA_CLONE_ALMOFADA) then
      Desconto.Base.Desconto_Clone_Almofada(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_GESSO_PERFUMADO) then
      Desconto.Base.Desconto_Gesso_Perfumado(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_PHARMAPET) then
      Desconto.Base.Desconto_Vendas_Pet(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_BRINDES) then
      Desconto.Base.Desconto_Brinde_Compras(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_STICK_BOLSA_PRAIA) then
      Desconto.Base.Desconto_Stick_Bolsa_Praia(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)

    // sazonal
    else if SameText(ANomeCampanha, CAMPANHA_CARNAVAL_2026) then
      Desconto.Base.Desconto_Carnaval_2026(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_CREATINA_2026) then
      Desconto.Base.Desconto_Campanha_Creatina_2026(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray);
  end;

var
  vGerenciador: TGerenciadorCampanhas;
  vCampanhasPrivilege: TList<ICampanha>;
  vCampanhasOrcamento: TList<TRecCampanhaClienteOrcamentos>;
  vCampanhaPriv: ICampanha;
  vCampanhaOrc: TRecCampanhaClienteOrcamentos;
  vValorCartao: Double;
begin
  vCampanhasOrcamento := TList<TRecCampanhaClienteOrcamentos>.Create;
  try
    // ✅ 1) Campanhas via Privilege -> Fórmula (usa telefone; CPF interno vem do banco, se necessário)
    Desconto.Base.Desconto_Campanha(AInfo, CodigosProdutos, vCampanhasOrcamento, tcWebService, AJSONArray);

    // ✅ 2) Campanhas aplicáveis do Privilege (por produtos)
    vGerenciador := TGerenciadorCampanhas.Create;
    try
      vCampanhasPrivilege := vGerenciador.ObterCampanhasAplicaveis(CodigosProdutos);

      // se não tem campanha no Privilege, detalha apenas orçamentos (Fórmula)
      if (vCampanhasPrivilege = nil) or (vCampanhasPrivilege.Count = 0) then
      begin
        for vCampanhaOrc in vCampanhasOrcamento do
          PegarDescontosProdutosOrcamento(AInfo, vCampanhaOrc, AJSONArray);
        Exit;
      end;

      // garante terminal balcão (se sua regra interna depende disso)
      if Length(AInfo.TerminalBalcao) = 0 then
        SetLength(AInfo.TerminalBalcao, 1);

      // aplica campanhas Privilege
      for vCampanhaPriv in vCampanhasPrivilege do
      begin
        if (CodigosProdutos.Count > 0) and (not vCampanhaPriv.PossuiProduto(CodigosProdutos)) then
          Continue;

        ExecutarCampanhaPrivilege(vCampanhaPriv.Nome, vValorCartao);
      end;

    finally
      vGerenciador.Free;
    end;

  finally
    vCampanhasOrcamento.Free;
  end;
end;

procedure TDesconto.PegarDescontosProdutosOrcamento(AInfo: TInfoDesconto;
  ACampanha: TRecCampanhaClienteOrcamentos; AJSONArray: TJSONArray);
var
  vQueryFC: TFDQuery;
begin
  vQueryFC := TFDQuery.Create(nil);
  try
    vQueryFC.Connection := AInfo.DatabaseFDConnectionFormulaCerta;

    vQueryFC.Close;
    vQueryFC.SQL.Clear;
    vQueryFC.SQL.Add(RetornarSelectFC03000Produtos(CodigosProdutos, ACampanha.PercentualVarejo));
    vQueryFC.Open;

    if vQueryFC.IsEmpty then
      Exit;

    vQueryFC.First;
    while not vQueryFC.Eof do
    begin
      PreencherJSONArrayProdutoOrcamento(
        AJSONArray,
        ACampanha.NomeCampanha,
        vQueryFC.FieldByName('descricao').AsString,
        vQueryFC.FieldByName('cdpro').AsInteger,
        vQueryFC.FieldByName('valor_total').AsFloat,
        vQueryFC.FieldByName('percentual_desconto').AsFloat,
        vQueryFC.FieldByName('valor_desconto').AsFloat,
        vQueryFC.FieldByName('valor_liquido').AsFloat
      );

      vQueryFC.Next;
    end;
  finally
    vQueryFC.Free;
  end;
end;

end.

