unit Desconto.RequestModel;

interface

uses
  System.Generics.Collections,
  GBSwagger.Model.Attributes;

type
  TProduto = class
  private
    FCodigo: Integer;
  public
    [SwagRequired]
    property codigo: Integer read FCodigo write FCodigo;

  end;

  TDescontoRequest = class
  private
    FCpf: integer;
    FTelefone: integer;
    FProdutos: TObjectList<TProduto>;
    FCampanha: string;
  public
    [SwagNumber(11)]
    property cpf: integer read FCpf write FCpf;
    [SwagString(100)]
    property campanha: string read FCampanha write FCampanha;
    [SwagNumber(15)]
    property telefone: integer read FTelefone write FTelefone;
    property produtos: TObjectList<TProduto> read FProdutos write FProdutos;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TDesconto }

constructor TDescontoRequest.Create;
begin
  inherited;
  FProdutos := TObjectList<TProduto>.Create;
end;

destructor TDescontoRequest.Destroy;
begin
  FProdutos.Free;
  inherited;
end;

end.

