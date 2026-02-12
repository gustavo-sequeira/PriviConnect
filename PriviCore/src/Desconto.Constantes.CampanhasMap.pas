{***********************************************************}
{                                                           }
{           gustavo sequeira - 03.02.2026                   }
{           Copyright (C) 2025 Pharmapele                   }
{                                                           }
{ Unit com responsabilidade para servir os mapeamentos das  }
{ constantes dos nomes das campanhas do Privilege e         }
{ do Web Service dos descontos                              }
{***********************************************************}

unit Desconto.Constantes.CampanhasMap;

interface

uses
  System.Generics.Collections;

function MapaCampanhas: TDictionary<string, string>;

implementation

uses
  Desconto.Constantes.Campanhas;

function MapaCampanhas: TDictionary<string, string>;
begin
  Result := TDictionary<string, string>.Create;

  Result.Add('CAMPANHA_DESCONTO_LOJA', CAMPANHA_DESCONTO_LOJA);
  Result.Add('CAMPANHA_PRIVILEGE', CAMPANHA_PRIVILEGE);
  Result.Add('CAMPANHA_CAMPANHAS', CAMPANHA_CAMPANHAS);
  Result.Add('CAMPANHA_FRANQUIA', CAMPANHA_FRANQUIA);
  Result.Add('CAMPANHA_PROGRESSIVO', CAMPANHA_PROGRESSIVO);
  Result.Add('CAMPANHA_COLAGENO', CAMPANHA_COLAGENO);
  Result.Add('CAMPANHA_CABELOS', CAMPANHA_CABELOS);
  Result.Add('CAMPANHA_PREVAGING', CAMPANHA_PREVAGING);
  Result.Add('CAMPANHA_PERFORMANCE', CAMPANHA_PERFORMANCE);
  Result.Add('CAMPANHA_CLEAN_THERAPY', CAMPANHA_CLEAN_THERAPY);
  Result.Add('CAMPANHA_PRESENTES', CAMPANHA_PRESENTES);
  Result.Add('CAMPANHA_IFOOD', CAMPANHA_IFOOD);
  Result.Add('CAMPANHA_CLONE_ALMOFADA', CAMPANHA_CLONE_ALMOFADA);
  Result.Add('CAMPANHA_GESSO_PERFUMADO', CAMPANHA_GESSO_PERFUMADO);
  Result.Add('CAMPANHA_PHARMAPET', CAMPANHA_PHARMAPET);
  Result.Add('CAMPANHA_BRINDES', CAMPANHA_BRINDES);
  Result.Add('CAMPANHA_PDRN', CAMPANHA_PDRN);
  Result.Add('CAMPANHA_DIA_CRIANCAS', CAMPANHA_DIA_CRIANCAS);
  Result.Add('CAMPANHA_ESQUENTA_BLACKFRIDAY', CAMPANHA_ESQUENTA_BLACKFRIDAY);
  Result.Add('CAMPANHA_POWERTRAINING', CAMPANHA_POWERTRAINING);
  Result.Add('CAMPANHA_LINHA_CLEAN_THERAPY', CAMPANHA_LINHA_CLEAN_THERAPY);
  Result.Add('CAMPANHA_BRINDES_COMPRAS', CAMPANHA_BRINDES_COMPRAS);
  Result.Add('CAMPANHA_STICK_BOLSA_PRAIA', CAMPANHA_STICK_BOLSA_PRAIA);
  Result.Add('CAMPANHA_CARNAVAL_2026', CAMPANHA_CARNAVAL_2026);
  Result.Add('CAMPANHA_CREATINA_2026', CAMPANHA_CREATINA_2026);
end;

end.

