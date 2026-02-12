unit Desconto.RequestModel;

interface

type
  // Request do endpoint /descontos
  // Somente telefone é obrigatório.
  TDescontoRequest = class
  private
    FTelefone: string;
    FProdutos: TArray<Integer>;
  published
    property telefone: string read FTelefone write FTelefone;           // obrigatório
    property produtos: TArray<Integer> read FProdutos write FProdutos; // opcional
  end;

implementation

end.

