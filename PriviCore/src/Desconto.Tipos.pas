unit Desconto.Tipos;

{***********************************************************}
{                                                           }
{           gustavo sequeira - 12.11.2025                   }
{           Copyright (C) 2025 Pharmapele                   }
{                                                           }
{ Unit com responsabilidade para servir os tipos de objetos }
{ para o Privilege e para o Web Service sobre os descontos  }
{***********************************************************}

interface

uses IBX.IBQuery, IBX.IBDatabase, FireDAC.Comp.Client;

type
  TTipoItem = (tiFormula, tiVarejo, tiAmbos);

  TTipoChamada = (tcDesktop, tcWebService);

  TParametros = array of array of Variant;

  TRECTerminalBalcao = record
    Filial: Integer;
    Cupom: Integer;
    IDCampanha: Integer;
    Tipo: string;
    TipoDesconto: string;
    CdTml: string;
    DtOpe: TDate;
    OperId: Integer;
    ItemId: Integer;
    DescricaoDesconto: string;
    UsuarioAutorizacao: string;
    ValorDesconto: Double;
    PercentualDesconto: Double;
    VerificaSaldoCampanha: string;
    SaldoCampanha: Double;
    ValorTotal: Double;
  end;

  TTerminalBalcao = TArray<TRECTerminalBalcao>;

  TInfoDesconto = record
    Cpf: Int64;
    Telefone: Int64;
    IDCliente:Integer;
    TerminalBalcao: TTerminalBalcao;
    IdCampanha: string;
    ValorDescontoFormula: Double;
    PercentualDescontoFormula: Double;
    ValorDescontoVarejo: Double;
    PercentualDescontoVarejo: Double;
    DatabaseIBConnectionFormulaCerta: TIBDatabase;
    DatabaseIBConnectionPrivilege: TIBDatabase;
    DatabaseFDConnectionPrivilege: TFDConnection;
    DatabaseFDConnectionFormulaCerta: TFDConnection;
  end;

implementation

end.

