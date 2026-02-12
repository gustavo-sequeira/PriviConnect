unit Desconto.ResponseModel;

interface

type
  // Item pode representar Varejo OU Fórmula (Orçamento) no mesmo array "campanhas"
  // tipo_item define quais campos vêm preenchidos.
  TCampanhaRetornoItem = class
  private
    FCampanha: string;
    FTipoItem: string; // 'Varejo' ou 'Fórmula'

    // Varejo
    FProduto: Integer;
    FNomeProduto: string;

    // Fórmula / Orçamento
    FOrcamento: Integer;
    FFilial: Integer;
    FRequisicao: string;
    FDescricao: string;

    // Comuns
    FValorTotal: Double;
    FPercentualDesconto: Double;
    FValorDesconto: Double;
    FValorLiquido: Double;
  published
    property campanha: string read FCampanha write FCampanha;
    property tipo_item: string read FTipoItem write FTipoItem;

    property produto: Integer read FProduto write FProduto;
    property nome_produto: string read FNomeProduto write FNomeProduto;

    property orcamento: Integer read FOrcamento write FOrcamento;
    property filial: Integer read FFilial write FFilial;
    property requisicao: string read FRequisicao write FRequisicao;
    property descricao: string read FDescricao write FDescricao;

    property valor_total: Double read FValorTotal write FValorTotal;
    property percentual_desconto: Double read FPercentualDesconto write FPercentualDesconto;
    property valor_desconto: Double read FValorDesconto write FValorDesconto;
    property valor_liquido: Double read FValorLiquido write FValorLiquido;
  end;

  TDescontosResponse = class
  private
    FTelefone: string;
    FCampanhas: TArray<TCampanhaRetornoItem>;
  published
    property telefone: string read FTelefone write FTelefone;
    property campanhas: TArray<TCampanhaRetornoItem> read FCampanhas write FCampanhas;
  end;

implementation

end.

