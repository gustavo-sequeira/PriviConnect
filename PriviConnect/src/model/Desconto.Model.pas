unit Desconto.Model;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB, Config.Database,
  System.Generics.Collections, System.JSON, Desconto.Tipos, uCampanha;

type
  TDesconto = class
  private
    FCampanha: String;
    FFilial: Integer;
    FTerminalBalcao: Integer;
    FCpfCliente: Int64;
    FTelefoneCliente: Int64;
    FCodigoProduto: Integer;
    FCodigosProdutos: TList<Integer>;
    FDescricaoProduto: string;
    FValor: Double;
    FPercentualDesconto: Double;
    FValorDesaconto: Double;
  private
    procedure PegarDescontosProdutosOrcamento(AInfo: TInfoDesconto; ACampanha: TRecCampanhaClienteOrcamentos; AJSONArray: TJSONArray);
  public
    property Campanha: String read FCampanha write FCampanha;
    property Filial: Integer read FFilial write FFilial;
    property TerminalBalcao: Integer read FTerminalBalcao write FTerminalBalcao;
    property TelefoneCliente: Int64 read FTelefoneCliente write FTelefoneCliente;
    property CpfCliente: Int64 read FCpfCliente write FCpfCliente;
    property CodigoProduto: Integer read FCodigoProduto write FCodigoProduto;
    property CodigosProdutos: TList<Integer> read FCodigosProdutos write FCodigosProdutos;
    property DescricaoProduto: string read FDescricaoProduto write FDescricaoProduto;
    property Valor: Double read FValor write FValor;
    property PercentualDesconto: Double read FPercentualDesconto write FPercentualDesconto;
    property ValorDesconto: Double read FValorDesaconto write FValorDesaconto;

    constructor Create;
    destructor Destroy; override;

    function ListarDescontosPorProdutos(out erro: string): TJSONArray;
    procedure PegarDescontos(AInfo: TInfoDesconto; AJSONArray: TJSONArray);
  end;

implementation

uses
  System.SysUtils, FireDAC.DApt, Desconto.Constantes.Campanhas, Desconto.Utils, Desconto.Base,
  Desconto.Sqls;

{ TDesconto }

constructor TDesconto.Create;
begin
  config.database.Connect;
  FCodigosProdutos := TList<Integer>.Create;
end;

destructor TDesconto.Destroy;
begin
  config.database.Disconect;
end;

function TDesconto.ListarDescontosPorProdutos(out erro: string): TJSONArray;
var
  vQuery: TFDQuery;
  vCampanhasArray: TJSONArray;
  Info: TInfoDesconto;
begin
  vQuery := TFDQuery.Create(nil);
  vQuery.Connection := Config.Database.ConnectionFC;

  vCampanhasArray := TJSONArray.Create;

  Info.Cpf := CpfCliente;
  Info.Telefone := TelefoneCliente;

  Info.DatabaseFDConnectionFormulaCerta := Config.Database.ConnectionFC;
  Info.DatabaseFDConnectionPrivilege := Config.Database.ConnectionPRV;

  PegarDescontos(Info, vCampanhasArray);

  Result := vCampanhasArray;
end;

procedure TDesconto.PegarDescontos(AInfo: TInfoDesconto;
  AJSONArray: TJSONArray);

  // Filtro geral: quando a propriedade Campanha vier preenchida,
  // só executa a campanha se o nome/código bater.
  function CampanhaPassaFiltro(const ANomeCampanha,
    ACodigoInterno: string): Boolean;
  var
    vFiltro: string;
  begin
    vFiltro := Trim(Campanha);

    // se não foi especificada uma campanha, qualquer uma serve
    if vFiltro = '' then
      Exit(True);

    Result :=
      SameText(vFiltro, ANomeCampanha) or      // nome bonito: "Desconto Loja"
      SameText(vFiltro, ACodigoInterno);       // código: "CAMPANHA_DESCONTO_LOJA"
  end;

  procedure ExecutarCampanhaPrivilege(const ANomeCampanha: string;
    var AValorCartao: Double);
  begin
    // loja
    if SameText(ANomeCampanha, CAMPANHA_DESCONTO_LOJA) and CampanhaPassaFiltro(ANomeCampanha, 'CAMPANHA_DESCONTO_LOJA') then
      Desconto.Base.Desconto_Loja(AInfo, CodigosProdutos, tcWebService, AJSONArray)

    // cartão / privilege
    else if SameText(ANomeCampanha, CAMPANHA_PRIVILEGE) and CampanhaPassaFiltro(ANomeCampanha, 'CAMPANHA_PRIVILEGE') then
      Desconto.Base.Desconto_Cartao(AValorCartao, AInfo, CodigosProdutos, [], tcWebService, AJSONArray)

    // franquia
    else if SameText(ANomeCampanha, CAMPANHA_FRANQUIA) and CampanhaPassaFiltro(ANomeCampanha, 'CAMPANHA_FRANQUIA') then
      Desconto.Base.Desconto_Franquia(AInfo, CodigosProdutos, tcWebService, AJSONArray)

    // progressivos / performance
    else if SameText(ANomeCampanha, CAMPANHA_PROGRESSIVO) and CampanhaPassaFiltro(ANomeCampanha, 'CAMPANHA_PROGRESSIVO') then
      Desconto.Base.Desconto_Progressivo(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_COLAGENO) and CampanhaPassaFiltro(ANomeCampanha, 'CAMPANHA_COLAGENO') then
      Desconto.Base.Desconto_Progressivo_Colageno(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_CABELOS) and CampanhaPassaFiltro(ANomeCampanha, 'CAMPANHA_CABELOS') then
      Desconto.Base.Desconto_Progressivo_Cabelo(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_PREVAGING) and CampanhaPassaFiltro(ANomeCampanha, 'CAMPANHA_PREVAGING') then
      Desconto.Base.Desconto_Progressivo_PrevAging(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_PERFORMANCE) and CampanhaPassaFiltro(ANomeCampanha, 'CAMPANHA_PERFORMANCE') then
      Desconto.Base.Desconto_Progressivo_PowerTrainning(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)

    // clean / presentes / ifood
    else if SameText(ANomeCampanha, CAMPANHA_CLEAN_THERAPY) and CampanhaPassaFiltro(ANomeCampanha, 'CAMPANHA_CLEAN_THERAPY') then
      Desconto.Base.Desconto_Linha_Clean_Therapy(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_PRESENTES) and CampanhaPassaFiltro(ANomeCampanha, 'CAMPANHA_PRESENTES') then
      Desconto.Base.Desconto_Presentes(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_IFOOD) and CampanhaPassaFiltro(ANomeCampanha, 'CAMPANHA_IFOOD') then
      Desconto.Base.Desconto_IFood(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)

    // brindes / pet
    else if SameText(ANomeCampanha, CAMPANHA_CLONE_ALMOFADA) and CampanhaPassaFiltro(ANomeCampanha, 'CAMPANHA_CLONE_ALMOFADA') then
      Desconto.Base.Desconto_Clone_Almofada(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_GESSO_PERFUMADO) and CampanhaPassaFiltro(ANomeCampanha, 'CAMPANHA_GESSO_PERFUMADO') then
      Desconto.Base.Desconto_Gesso_Perfumado(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_PHARMAPET) and CampanhaPassaFiltro(ANomeCampanha, 'CAMPANHA_PHARMAPET') then
      Desconto.Base.Desconto_Vendas_Pet(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_BRINDES) and CampanhaPassaFiltro(ANomeCampanha, 'CAMPANHA_BRINDES') then
      Desconto.Base.Desconto_Brinde_Compras(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_STICK_BOLSA_PRAIA) and CampanhaPassaFiltro(ANomeCampanha, 'CAMPANHA_STICK_BOLSA_PRAIA') then
      Desconto.Base.Desconto_Stick_Bolsa_Praia(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)

    // sazonal
    else if SameText(ANomeCampanha, CAMPANHA_CARNAVAL_2026) and
            CampanhaPassaFiltro(ANomeCampanha, 'CAMPANHA_CARNAVAL_2026') then
      Desconto.Base.Desconto_Carnaval_2026(AValorCartao, AInfo, CodigosProdutos, tcWebService, AJSONArray)
    else if SameText(ANomeCampanha, CAMPANHA_CREATINA_2026) and CampanhaPassaFiltro(ANomeCampanha, 'CAMPANHA_CREATINA_2026') then
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
    // 1) Busca campanhas pelo orçamento (Formula Certa) e já preenche AJSONArray
    Desconto.Base.Desconto_Campanha(AInfo, CodigosProdutos, tcWebService,
      AJSONArray, vCampanhasOrcamento);

    // 2) Tenta achar campanhas no Privilege para esses produtos
    vGerenciador := TGerenciadorCampanhas.Create;
    try
      vCampanhasPrivilege := vGerenciador.ObterCampanhasAplicaveis(CodigosProdutos);

      // 2.1) Se NÃO tem campanha no Privilege -> usa só as do orçamento
      if (vCampanhasPrivilege.Count = 0) then
      begin
        for vCampanhaOrc in vCampanhasOrcamento do
          PegarDescontosProdutosOrcamento(AInfo, vCampanhaOrc, AJSONArray);

        Exit;
      end;

      // 2.2) Se tem campanha no Privilege -> aplica as regras de lá
      for vCampanhaPriv in vCampanhasPrivilege do
      begin
        // se veio lista de produtos, só aplica se a campanha possuir algum deles
        if (CodigosProdutos.Count > 0) and
           (not vCampanhaPriv.PossuiProduto(CodigosProdutos)) then
          Continue;
        SetLength(AInfo.TerminalBalcao,1);
        ExecutarCampanhaPrivilege(vCampanhaPriv.Nome, vValorCartao);
      end;

    finally
      vGerenciador.Free;
    end;
  finally
    vCampanhasOrcamento.Free;
  end;
end;


procedure TDesconto.PegarDescontosProdutosOrcamento(AInfo: TInfoDesconto; ACampanha: TRecCampanhaClienteOrcamentos; AJSONArray: TJSONArray);
var
  vIdxProdutos: Integer;
  vQueryFC: TFDQuery;
  
begin
  vQueryFC := TFDQuery.Create(nil);
  vQueryFC.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  try    
    vQueryFC.Close;
    vQueryFC.SQL.Clear;
    vQueryFC.SQL.Add( RetornarSelectFC03000Produtos( CodigosProdutos, ACampanha.PercentualVarejo ) );
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
        vQueryFC.FieldByName('valor_liquido').AsFloat);     
      
      vQueryFC.Next;
    end;
  finally
    vQueryFC.Free;
  end;
end;
end.

