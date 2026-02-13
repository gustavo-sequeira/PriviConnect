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
    FTelefoneClienteStr: string;
    FCodigosProdutos: TList<Integer>;
    procedure PegarDescontos(AInfo: TInfoDesconto; AJSONArray: TJSONArray);
    procedure PegarDescontosProdutosOrcamento(AInfo: TInfoDesconto;
      ACampanha: TRecCampanhaClienteOrcamentos; AJSONArray: TJSONArray; ACodigosProdutos: TList<Integer>);

  public
    constructor Create;
    destructor Destroy; override;
    function ListarDescontosPorProdutos(out erro: string): TJSONArray;
    property TelefoneClienteStr: string read FTelefoneClienteStr write FTelefoneClienteStr;
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

  // telefone sempre vem da string (request)
  if Trim(FTelefoneClienteStr) <> '' then
    vTelefoneNum := StrToInt64Def(FTelefoneClienteStr, 0);

  if vTelefoneNum <= 0 then
    Exit(vCampanhasArray); // retorna array vazio (Controller transforma em 404)

  // monta Info
  FillChar(Info, SizeOf(Info), 0);
  Info.Telefone := vTelefoneNum;


  Info.DatabaseFDConnectionFormulaCerta := Config.Database.ConnectionFC;
  Info.DatabaseFDConnectionPrivilege := Config.Database.ConnectionPRV;

  // executa cálculo e preenche o array
  PegarDescontos(Info, vCampanhasArray);

  Result := vCampanhasArray;
end;

procedure TDesconto.PegarDescontos(AInfo: TInfoDesconto; AJSONArray: TJSONArray);

  procedure ExecutarCampanhaPrivilege(const ANomeCampanha: string; var AValorCartao: Double; ACodigosProdutos: TList<Integer>);
  begin
    // loja
    if SameText(ANomeCampanha, CAMPANHA_DESCONTO_LOJA) then
      Desconto.Base.Desconto_Loja(AInfo, ACodigosProdutos, tcWebService, AJSONArray)

    // cartão / privilege
    else if SameText(ANomeCampanha, CAMPANHA_PRIVILEGE) then
      Desconto.Base.Desconto_Cartao(AValorCartao, AInfo, ACodigosProdutos, [], tcWebService, AJSONArray)

    // franquia
    else if SameText(ANomeCampanha, CAMPANHA_FRANQUIA) then
      Desconto.Base.Desconto_Franquia(AInfo, ACodigosProdutos, tcWebService, AJSONArray)

    // progressivos / performance
    else if SameText(ANomeCampanha, CAMPANHA_PROGRESSIVO) then
      Desconto.Base.Desconto_Progressivo(AValorCartao, AInfo, ACodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_COLAGENO) then
      Desconto.Base.Desconto_Progressivo_Colageno(AValorCartao, AInfo, ACodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_CABELOS) then
      Desconto.Base.Desconto_Progressivo_Cabelo(AValorCartao, AInfo, ACodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_PREVAGING) then
      Desconto.Base.Desconto_Progressivo_PrevAging(AValorCartao, AInfo, ACodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_PERFORMANCE) then
      Desconto.Base.Desconto_Progressivo_PowerTrainning(AValorCartao, AInfo, ACodigosProdutos, tcWebService, AJSONArray)

    // clean / presentes / ifood
    else if SameText(ANomeCampanha, CAMPANHA_CLEAN_THERAPY) then
      Desconto.Base.Desconto_Linha_Clean_Therapy(AValorCartao, AInfo, ACodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_PRESENTES) then
      Desconto.Base.Desconto_Presentes(AValorCartao, AInfo, ACodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_IFOOD) then
      Desconto.Base.Desconto_IFood(AValorCartao, AInfo, ACodigosProdutos, tcWebService, AJSONArray)

    // brindes / pet
    else if SameText(ANomeCampanha, CAMPANHA_CLONE_ALMOFADA) then
      Desconto.Base.Desconto_Clone_Almofada(AValorCartao, AInfo, ACodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_GESSO_PERFUMADO) then
      Desconto.Base.Desconto_Gesso_Perfumado(AValorCartao, AInfo, ACodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_PHARMAPET) then
      Desconto.Base.Desconto_Vendas_Pet(AValorCartao, AInfo, ACodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_BRINDES) then
      Desconto.Base.Desconto_Brinde_Compras(AValorCartao, AInfo, ACodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_STICK_BOLSA_PRAIA) then
      Desconto.Base.Desconto_Stick_Bolsa_Praia(AValorCartao, AInfo, ACodigosProdutos, tcWebService, AJSONArray)

    // sazonal
    else if SameText(ANomeCampanha, CAMPANHA_CARNAVAL_2026) then
      Desconto.Base.Desconto_Carnaval_2026(AValorCartao, AInfo, ACodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_CREATINA_2026) then
      Desconto.Base.Desconto_Campanha_Creatina_2026(AValorCartao, AInfo, ACodigosProdutos, tcWebService, AJSONArray);
  end;

var
  vGerenciador: TGerenciadorCampanhas;
  vCampanhasPrivilegeDet: TObjectList<TCampanhaAplicavel>;
  vCampanhaItem: TCampanhaAplicavel;
  vCampanhasOrcamento: TList<TRecCampanhaClienteOrcamentos>;
  vCampanhaPriv: ICampanha;
  vCampanhaOrc: TRecCampanhaClienteOrcamentos;
  vValorCartao: Double;
begin
  vCampanhasOrcamento := TList<TRecCampanhaClienteOrcamentos>.Create;
  try
    // 1) Campanhas via Privilege -> Fórmula
    Desconto.Base.Desconto_Campanha(AInfo, CodigosProdutos, vCampanhasOrcamento, tcWebService, AJSONArray);

    // 2) Campanhas aplicáveis do Privilege (por produtos)
    vGerenciador := TGerenciadorCampanhas.Create;
    try
      vCampanhasPrivilegeDet := vGerenciador.ObterCampanhasAplicaveisDetalhado(CodigosProdutos);
      if (vCampanhasPrivilegeDet.Count > 0) then
      begin
        for vCampanhaItem in vCampanhasPrivilegeDet do
        begin
          if vCampanhaItem.Aplicabilidade.Status in [asParcial, asNenhuma] then
          begin
            for vCampanhaOrc in vCampanhasOrcamento do
              PegarDescontosProdutosOrcamento(AInfo, vCampanhaOrc, AJSONArray, vCampanhaItem.Aplicabilidade.ProdutosNaoCobertos);
          end;

          if vCampanhaItem.Aplicabilidade.Status in [asParcial, asTotal] then
          begin
          // garante terminal balcão
            if Length(AInfo.TerminalBalcao) = 0 then
              SetLength(AInfo.TerminalBalcao, 1);

            ExecutarCampanhaPrivilege(vCampanhaItem.Campanha.Nome, vValorCartao, vCampanhaItem.Aplicabilidade.ProdutosCobertos);
          end;
        end;
      end else if (CodigosProdutos.Count > 0) then
      begin
        for vCampanhaOrc in vCampanhasOrcamento do
          PegarDescontosProdutosOrcamento(AInfo, vCampanhaOrc, AJSONArray, CodigosProdutos);
      end;
    finally
      vGerenciador.Free;
    end;
  finally
    vCampanhasOrcamento.Free;
  end;
end;

procedure TDesconto.PegarDescontosProdutosOrcamento(AInfo: TInfoDesconto;
  ACampanha: TRecCampanhaClienteOrcamentos; AJSONArray: TJSONArray; ACodigosProdutos: TList<Integer>);
var
  vQueryFC: TFDQuery;
begin
  vQueryFC := TFDQuery.Create(nil);
  try
    vQueryFC.Connection := AInfo.DatabaseFDConnectionFormulaCerta;

    vQueryFC.Close;
    vQueryFC.SQL.Clear;
    vQueryFC.SQL.Add(RetornarSelectFC03000Produtos(ACodigosProdutos, ACampanha.PercentualVarejo));
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

