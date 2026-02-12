unit Desconto.Base;

{***********************************************************}
{                                                           }
{           gustavo sequeira - 12.11.2025                   }
{           Copyright (C) 2025 Pharmapele                   }
{                                                           }
{ Unit com responsabilidade para servir a regra de negocios }
{ para o Privilege e para o Web Service sobre os descontos  }
{***********************************************************}

interface

uses
  System.SysUtils, System.Generics.Collections, IBX.IBQuery, IBX.IBDatabase,
  FireDAC.Comp.Client, System.JSON, Desconto.Tipos, uCampanha;

procedure Desconto_Loja(AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
procedure Desconto_Cartao(out AUsouDesconto: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; AParams: TParametros = []; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
procedure Desconto_Campanha(AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil; ACampanhaOrcamento: TList<TRecCampanhaClienteOrcamentos> = nil);
procedure Desconto_Franquia(AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
procedure Desconto_Progressivo(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
procedure Desconto_Progressivo_Colageno(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
procedure Desconto_Progressivo_Cabelo(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
procedure Desconto_Progressivo_PrevAging(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
procedure Desconto_Progressivo_PowerTrainning(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
procedure Desconto_Linha_Clean_Therapy(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
procedure Desconto_Presentes(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
procedure Desconto_IFood(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
procedure Desconto_Clone_Almofada(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
procedure Desconto_Gesso_Perfumado(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
procedure Desconto_Vendas_Pet(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
procedure Desconto_Brinde_Compras(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
procedure Desconto_Stick_Bolsa_Praia(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
procedure Desconto_Carnaval_2026(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
procedure Desconto_Campanha_Creatina_2026(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);

implementation

uses
  System.StrUtils, System.DateUtils, System.Math, Data.DB, FireDAC.Stan.Param,
  System.Variants, Desconto.Constantes.Campanhas, Desconto.Constantes.Produtos,
  Desconto.Constantes.Usuarios, Desconto.Variaveis, Desconto.Sqls, Desconto.Utils,
  Vcl.Dialogs, Vcl.Controls, Desconto.Constantes.Percentuais, Desconto.Constantes.Datas,
  System.UITypes;

procedure Desconto_Loja(AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
var
  vValorTotal: Double;
  vQuerySelecionaDesconto, vQueryIncluiDesconto: TFDQuery;
  vQuerySaldoCampanha: TIBQuery;
  vQtdContadorCampanhas: Integer;
  vTipoItem: TTipoItem;
begin
  vQuerySelecionaDesconto := TFDQuery.Create(nil);
  vQueryIncluiDesconto := TFDQuery.Create(nil);
  vQuerySaldoCampanha := TIBQuery.Create(nil);

  vQuerySelecionaDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQueryIncluiDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQuerySaldoCampanha.Database := AInfo.DatabaseIBConnectionPrivilege;

  try
    for vQtdContadorCampanhas := 0 to Length(AInfo.TerminalBalcao) - 1 do
    begin
      if AInfo.TerminalBalcao[vQtdContadorCampanhas].UsuarioAutorizacao = USUARIO_PRIVILEGE_LOJA then
        vTipoItem := tiFormula
      else
        vTipoItem := tiAmbos;

      vQuerySelecionaDesconto.Close;
      vQuerySelecionaDesconto.sql.Clear;
      case ATipo of
        tcDesktop:
          vQuerySelecionaDesconto.Open(
            RetornarSelectFC32110Itens(AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial, AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom, vTipoItem));
        tcWebService:
        // mudar isso aqui
          vQuerySelecionaDesconto.Open(
            RetornarSelectFC03000Produtos(AProdutos, AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial));
      end;

      vQuerySelecionaDesconto.FetchAll;

      vQuerySelecionaDesconto.First;

      while not vQuerySelecionaDesconto.eof do
      begin
        if (vQuerySelecionaDesconto.FieldValues['tpitm'] = 'V') and (ExisteProduto(vQuerySelecionaDesconto.FieldValues['cdpro'], PRODUTOS_DESCONTO_LOJA)) then
        begin
            vQuerySelecionaDesconto.Next;
            continue;
        end;

        if (vQuerySelecionaDesconto.FieldValues['vrdsc'] > 0) then
        begin
          vQuerySelecionaDesconto.Next;
          continue;
        end;

        if (ATipo = tcWebService) then
          PreencherJSONArrayTerminalBalcao(
            ALista,
            CAMPANHA_DESCONTO_LOJA,
            vQuerySelecionaDesconto.FieldValues['tpitm'],
            vQuerySelecionaDesconto.FieldValues['cdfil'],
            vQuerySelecionaDesconto.FieldValues['cdpro'],
            vQuerySelecionaDesconto.FieldValues['nrcpm'],
            vQuerySelecionaDesconto.FieldValues['descrprd'],
            vQuerySelecionaDesconto.FieldValues['vrtot'],
            vQuerySelecionaDesconto.FieldValues['ptdsc'],
            vQuerySelecionaDesconto.FieldValues['vrdsc'],
            vQuerySelecionaDesconto.FieldValues['vrliq'])
        else
        begin
          vQueryIncluiDesconto.Close;
          vQueryIncluiDesconto.SQL.Clear;
          vQueryIncluiDesconto.ExecSQL(
            RetornarUpdateBalcaoReceitasFC32200TipoDescontoValores(
               vQuerySelecionaDesconto.FieldValues['cdfil'],
               vQuerySelecionaDesconto.FieldValues['nrcpm'],
               vQuerySelecionaDesconto.FieldValues['itemid'],
               vQuerySelecionaDesconto.FieldValues['operid'],
               vQuerySelecionaDesconto.FieldValues['vrdscv'],
               vQuerySelecionaDesconto.FieldValues['vrdscv'],
               vQuerySelecionaDesconto.FieldValues['vrdscv'],
               vQuerySelecionaDesconto.FieldValues['tpdsc'],
               USUARIO_PRIVILEGE_LOJA,
               vQuerySelecionaDesconto.FieldValues['cdtml'],
               vQuerySelecionaDesconto.FieldValues['dtope']));
          vQueryIncluiDesconto.Connection.CommitRetaining;

          vQueryIncluiDesconto.Close;
          vQueryIncluiDesconto.SQL.Clear;
          vQueryIncluiDesconto.ExecSQL(
            RetornarUpdateBalcaoReceitasFC32200ValorCaixa(
              vQuerySelecionaDesconto.FieldValues['cdfil'],
              vQuerySelecionaDesconto.FieldValues['nrcpm'],
              vQuerySelecionaDesconto.FieldValues['itemid'],
              vQuerySelecionaDesconto.FieldValues['operid'],
              vQuerySelecionaDesconto.FieldValues['vrdscv'],
              vQuerySelecionaDesconto.FieldValues['cdtml'],
              vQuerySelecionaDesconto.FieldValues['tppag'],
              vQuerySelecionaDesconto.FieldValues['dtope']));
          vQueryIncluiDesconto.Connection.CommitRetaining;

          vQueryIncluiDesconto.Close;
          vQueryIncluiDesconto.SQL.Clear;
          if vQuerySelecionaDesconto.FieldValues['tpitm'] = 'R' then
            vQueryIncluiDesconto.ExecSQL(
              RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(
                vQuerySelecionaDesconto.FieldValues['cdfil'],
                vQuerySelecionaDesconto.FieldValues['nrcpm'],
                vQuerySelecionaDesconto.FieldValues['itemid'],
                vQuerySelecionaDesconto.FieldValues['operid'],
                vQuerySelecionaDesconto.FieldValues['vrcxa'],
                vQuerySelecionaDesconto.FieldValues['vrcxa'],
                vQuerySelecionaDesconto.FieldValues['vrcxa'],
                vQuerySelecionaDesconto.FieldValues['vrcxa'],
                vQuerySelecionaDesconto.FieldValues['vrcxa'],
                vQuerySelecionaDesconto.FieldValues['vrcxa'],
                0,
                0,
                vQuerySelecionaDesconto.FieldValues['tpdsc'],
                vQuerySelecionaDesconto.FieldValues['cdtml'],
                USUARIO_PRIVILEGE_LOJA,
                vQuerySelecionaDesconto.FieldValues['tpitm'],
                vQuerySelecionaDesconto.FieldValues['dtope']))
          else
            vQueryIncluiDesconto.ExecSQL(
              RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(
                vQuerySelecionaDesconto.FieldValues['cdfil'],
                vQuerySelecionaDesconto.FieldValues['nrcpm'],
                vQuerySelecionaDesconto.FieldValues['itemid'],
                vQuerySelecionaDesconto.FieldValues['operid'],
                vQuerySelecionaDesconto.FieldValues['vrdscv'],
                vQuerySelecionaDesconto.FieldValues['vrdscv'],
                vQuerySelecionaDesconto.FieldValues['vrdscv'],
                0,
                0,
                vQuerySelecionaDesconto.FieldValues['vrdscv'],
                vQuerySelecionaDesconto.FieldValues['ptdsc'],
                vQuerySelecionaDesconto.FieldValues['vrdscv'],
                vQuerySelecionaDesconto.FieldValues['tpdsc'],
                vQuerySelecionaDesconto.FieldValues['cdtml'],
                USUARIO_PRIVILEGE_LOJA,
                vQuerySelecionaDesconto.FieldValues['tpitm'],
                vQuerySelecionaDesconto.FieldValues['dtope']));
          vQueryIncluiDesconto.Connection.CommitRetaining;
        end;
        vQuerySelecionaDesconto.Next;
      end;

      if (ATipo = tcDesktop) then
      begin
        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.Open(
          RetornarSelectFC32110SomaValorLiquido(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            vQuerySelecionaDesconto.FieldValues['dtope']));

        vValorTotal := vQueryIncluiDesconto.FieldValues['VALOR'];

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTerminalBalcaoFC32100UsuarioValores(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].IDCampanha,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].UsuarioAutorizacao,
            vQuerySelecionaDesconto.FieldValues['dtope']));
        vQueryIncluiDesconto.Connection.CommitRetaining;

        if (AInfo.TerminalBalcao[vQtdContadorCampanhas].VerificaSaldoCampanha = 'S') then
        begin
          vQuerySaldoCampanha.Close;
          vQuerySaldoCampanha.SQL.Clear;
          vQuerySaldoCampanha.SQL.Add(
            RetornarUpdateCampanhaSaldo(
              AInfo.TerminalBalcao[vQtdContadorCampanhas].IDCampanha,
              AInfo.TerminalBalcao[vQtdContadorCampanhas].SaldoCampanha));
          vQuerySaldoCampanha.ExecSQL;
          vQuerySaldoCampanha.Transaction.CommitRetaining;
        end;

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTotvsConfEnvio(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));

        vQueryIncluiDesconto.Connection.CommitRetaining;
      end;
    end;
  finally
    vQuerySelecionaDesconto.Free;
    vQueryIncluiDesconto.Free;
    vQuerySaldoCampanha.Free;
  end;
end;

procedure Desconto_Cartao(out AUsouDesconto: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; AParams: TParametros = []; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
var
  vQuerySelecionaDesconto, vQueryIncluiDesconto: TFDQuery;
  vPodeAtualizar, vQtdContadorCampanhas: Integer;
begin
 // se não tiver código de barras, não faz sentido entrar nesse procedimento.
  // Web Service não esta contemplado para enviar o código de barras
  if Length(AParams) = 0 then
    Exit;

  vQuerySelecionaDesconto := TFDQuery.Create(nil);
  vQueryIncluiDesconto := TFDQuery.Create(nil);

  vQuerySelecionaDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQueryIncluiDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;

  try
    for vQtdContadorCampanhas := 0 to Length(AInfo.TerminalBalcao) - 1 do
    begin
      vQuerySelecionaDesconto.Close;
      vQuerySelecionaDesconto.sql.Clear;
      vQuerySelecionaDesconto.Open(
        RetornarSelectFC32110Itens(
        AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
        AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
      vQuerySelecionaDesconto.FetchAll;
      vQuerySelecionaDesconto.First;

      while not vQuerySelecionaDesconto.eof do
      begin
        if AParams[vQtdContadorCampanhas][0] = 'codigoBarras' then
        begin
          if Copy(AParams[vQtdContadorCampanhas][1],1,1) = '0' then
            vPodeAtualizar := 1
          else if Copy(AParams[vQtdContadorCampanhas][1],1,1) = '1' then
            vPodeAtualizar := 0
          else
            vPodeAtualizar := -1;

          if vPodeAtualizar = 0 then
          begin
            vQueryIncluiDesconto.Close;
            vQueryIncluiDesconto.SQL.Clear;
            vQueryIncluiDesconto.Open(
              RetornarSelectFC12110QuantidadeExistente(
                vQuerySelecionaDesconto.FieldValues['cdfilr'],
                vQuerySelecionaDesconto.FieldValues['cdpro'],
                ArrayToSQL(PRODUTOS_DESCONTO_CARTAO_01)));

            if vQueryIncluiDesconto.FieldValues['quant'] > 0 then
              vPodeAtualizar := 1;
          end;

          if vPodeAtualizar = 0 then
          begin
            vQueryIncluiDesconto.Close;
            vQueryIncluiDesconto.SQL.Clear;
            vQueryIncluiDesconto.Open(
              RetornarSelectFC12110QuantidadeExistente(
                vQuerySelecionaDesconto.FieldValues['cdfilr'],
                vQuerySelecionaDesconto.FieldValues['cdpro'],
                ArrayToSQL(PRODUTOS_DESCONTO_CARTAO_02)));

            if vQueryIncluiDesconto.FieldValues['quant'] > 1 then
              vPodeAtualizar := 1;
          end;

          if vPodeAtualizar = 0 then
          begin
            vQueryIncluiDesconto.Close;
            vQueryIncluiDesconto.SQL.Clear;
            vQueryIncluiDesconto.Open(
              RetornarSelectFC12110QuantidadeExistente(
                vQuerySelecionaDesconto.FieldValues['cdfilr'],
                vQuerySelecionaDesconto.FieldValues['cdpro'],
                ArrayToSQL(PRODUTOS_DESCONTO_CARTAO_03)));

            if vQueryIncluiDesconto.FieldValues['quant'] > 2 then
              vPodeAtualizar := 1;
          end;

          if vPodeAtualizar = 0 then
          begin
            vQueryIncluiDesconto.Close;
            vQueryIncluiDesconto.SQL.Clear;
            vQueryIncluiDesconto.Open(
              RetornarSelectFC12110QuantidadeExistente(
                vQuerySelecionaDesconto.FieldValues['cdfilr'],
                vQuerySelecionaDesconto.FieldValues['cdpro'],
                ArrayToSQL(PRODUTOS_DESCONTO_CARTAO_04)));

            if vQueryIncluiDesconto.FieldValues['quant'] > 2 then
              vPodeAtualizar := 1;
          end;

          if vPodeAtualizar = 0 then
          begin
            vQueryIncluiDesconto.Close;
            vQueryIncluiDesconto.SQL.Clear;
            vQueryIncluiDesconto.Open(
              RetornarSelectFC12110QuantidadeExistente(
                vQuerySelecionaDesconto.FieldValues['cdfilr'],
                vQuerySelecionaDesconto.FieldValues['cdpro'],
                ArrayToSQL(PRODUTOS_DESCONTO_CARTAO_05)));

            if vQueryIncluiDesconto.FieldValues['quant'] > 2 then
              vPodeAtualizar := 1;
          end;

          if vPodeAtualizar = 0 then
          begin
            vQueryIncluiDesconto.Close;
            vQueryIncluiDesconto.SQL.Clear;
            vQueryIncluiDesconto.Open(
              RetornarSelectFC12110QuantidadeExistente(
                vQuerySelecionaDesconto.FieldValues['cdfilr'],
                vQuerySelecionaDesconto.FieldValues['cdpro'],
                ArrayToSQL(PRODUTOS_DESCONTO_CARTAO_06)));

            if vQueryIncluiDesconto.FieldValues['quant'] > 2 then
              vPodeAtualizar := 1;
          end;

          if vPodeAtualizar = 1 then
          begin
            if ATipo = tcWebService then
              PreencherJSONArrayTerminalBalcao(
                ALista,
                CAMPANHA_PRIVILEGE,
                vQuerySelecionaDesconto.FieldValues['tpitm'],
                vQuerySelecionaDesconto.FieldValues['cdfil'],
                vQuerySelecionaDesconto.FieldValues['cdpro'],
                vQuerySelecionaDesconto.FieldValues['nrcpm'],
                vQuerySelecionaDesconto.FieldValues['descrprd'],
                vQuerySelecionaDesconto.FieldValues['vrtot'],
                vQuerySelecionaDesconto.FieldValues['ptdsc'],
                vQuerySelecionaDesconto.FieldValues['vrdsc'],
                vQuerySelecionaDesconto.FieldValues['vrliq'])
            else
            begin
              vQueryIncluiDesconto.Close;
              vQueryIncluiDesconto.SQL.Clear;
              vQueryIncluiDesconto.ExecSQL(
                RetornarUpdateBalcaoReceitasFC32200TipoDescontoValores(
                  vQuerySelecionaDesconto.FieldValues['cdfil'],
                  vQuerySelecionaDesconto.FieldValues['nrcpm'],
                  vQuerySelecionaDesconto.FieldValues['itemid'],
                  vQuerySelecionaDesconto.FieldValues['operid'],
                  vQuerySelecionaDesconto.FieldValues['vrdsc'],
                  vQuerySelecionaDesconto.FieldValues['vrdsc'],
                  vQuerySelecionaDesconto.FieldValues['vrdsc'],
                  '2',
                  USUARIO_PRIVILEGEM,
                  vQuerySelecionaDesconto.FieldValues['cdtml'],
                  vQuerySelecionaDesconto.FieldValues['dtope']));
              vQueryIncluiDesconto.Connection.CommitRetaining;

              vQueryIncluiDesconto.Close;
              vQueryIncluiDesconto.SQL.Clear;
              vQueryIncluiDesconto.ExecSQL(
                RetornarUpdateBalcaoReceitasFC32200ValorCaixa(
                  vQuerySelecionaDesconto.FieldValues['cdfil'],
                  vQuerySelecionaDesconto.FieldValues['nrcpm'],
                  vQuerySelecionaDesconto.FieldValues['itemid'],
                  vQuerySelecionaDesconto.FieldValues['operid'],
                  vQuerySelecionaDesconto.FieldValues['vrdscv'],
                  vQuerySelecionaDesconto.FieldValues['cdtml'],
                  vQuerySelecionaDesconto.FieldValues['tppag'],
                  vQuerySelecionaDesconto.FieldValues['dtope']));
              vQueryIncluiDesconto.Connection.CommitRetaining;

              vQueryIncluiDesconto.Close;
              vQueryIncluiDesconto.SQL.Clear;
              if vQuerySelecionaDesconto.FieldValues['tpitm'] = 'R' then
                vQueryIncluiDesconto.ExecSQL(
                  RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(
                    vQuerySelecionaDesconto.FieldValues['cdfil'],
                    vQuerySelecionaDesconto.FieldValues['nrcpm'],
                    vQuerySelecionaDesconto.FieldValues['itemid'],
                    vQuerySelecionaDesconto.FieldValues['operid'],
                    vQuerySelecionaDesconto.FieldValues['vrcxa'],
                    vQuerySelecionaDesconto.FieldValues['vrcxa'],
                    vQuerySelecionaDesconto.FieldValues['vrcxa'],
                    vQuerySelecionaDesconto.FieldValues['vrcxa'],
                    vQuerySelecionaDesconto.FieldValues['vrcxa'],
                    vQuerySelecionaDesconto.FieldValues['vrcxa'],
                    0,
                    0,
                    vQuerySelecionaDesconto.FieldValues['tpdsc'],
                    vQuerySelecionaDesconto.FieldValues['cdtml'],
                    EmptyStr,
                    vQuerySelecionaDesconto.FieldValues['tpitm'],
                    vQuerySelecionaDesconto.FieldValues['dtope']))
              else
                vQueryIncluiDesconto.ExecSQL(
                  RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(
                    vQuerySelecionaDesconto.FieldValues['cdfil'],
                    vQuerySelecionaDesconto.FieldValues['nrcpm'],
                    vQuerySelecionaDesconto.FieldValues['itemid'],
                    vQuerySelecionaDesconto.FieldValues['operid'],
                    vQuerySelecionaDesconto.FieldValues['vrdscv'],
                    vQuerySelecionaDesconto.FieldValues['vrdscv'],
                    vQuerySelecionaDesconto.FieldValues['vrdscv'],
                    0,
                    0,
                    vQuerySelecionaDesconto.FieldValues['vrdscv'],
                    vQuerySelecionaDesconto.FieldValues['ptdsc'],
                    vQuerySelecionaDesconto.FieldValues['vrdscv'],
                    '2',
                    vQuerySelecionaDesconto.FieldValues['cdtml'],
                    EmptyStr,
                    vQuerySelecionaDesconto.FieldValues['tpitm'],
                    vQuerySelecionaDesconto.FieldValues['dtope']));

              vQueryIncluiDesconto.Connection.CommitRetaining;
            end;
          end;
        end;
        vQuerySelecionaDesconto.Next;
      end;
    end;
  finally
    vQuerySelecionaDesconto.Free;
    vQueryIncluiDesconto.Free;
  end;
end;

procedure Desconto_Campanha(AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil; ACampanhaOrcamento: TList<TRecCampanhaClienteOrcamentos> = nil);
var
  vQueryFC, vQueryPRV: TFDQuery;
  vQtdCampanhas: Integer;
begin
  vQueryFC := TFDQuery.Create(nil);
  vQueryPRV := TFDQuery.Create(nil);

  vQueryFC.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQueryPRV.Connection := AInfo.DatabaseFDConnectionPrivilege;

  try
    if ATipo = tcWebService then
    begin
      try
        vQueryPRV.Close;
        vQueryPRV.SQL.Clear;
        vQueryPRV.SQL.Add(RetornarSelectDescontoCampanhas(AInfo.Telefone, AInfo.Cpf));
        vQueryPRV.Open;
        ACampanhaOrcamento := TCampanhaClienteOrcamentos.GetList(vQueryPRV);
        if ACampanhaOrcamento.Count > 0 then
        begin
          if AInfo.Cpf = 0 then
            AInfo.Cpf := TRecCampanhaClienteOrcamentos(ACampanhaOrcamento[0]).Cpf;

          for vQtdCampanhas := 0 to ACampanhaOrcamento.Count - 1 do
          begin
            vQueryFC.Close;
            vQueryFC.SQL.Clear;
            vQueryFC.SQL.Add(RetornarSelectFC15000OrcamentosCampanhas(TRecCampanhaClienteOrcamentos(ACampanhaOrcamento[vQtdCampanhas]).Cpf));
            vQueryFC.Open;

            if not (vQueryFC.IsEmpty) then
            begin
              vQueryFC.First;
              while not vQueryFC.Eof do
              begin
                PreencherJSONArrayOrcamento(
                  ALista,
                  TRecCampanhaClienteOrcamentos(ACampanhaOrcamento[vQtdCampanhas]).NomeCampanha,
                  'R',
                  vQueryFC.FieldByName('cdfil').AsInteger,
                  vQueryFC.FieldByName('nrorc').AsInteger,
                  vQueryFC.FieldByName('vrrqu').AsFloat,
                  TRecCampanhaClienteOrcamentos(ACampanhaOrcamento[vQtdCampanhas]).PercentualFormula,
                  vQueryFC.FieldByName('vrrqu').AsFloat * (TRecCampanhaClienteOrcamentos(ACampanhaOrcamento[vQtdCampanhas]).PercentualFormula / 100),
                  vQueryFC.FieldByName('vrrqu').AsFloat - (vQueryFC.FieldByName('vrrqu').AsFloat * (TRecCampanhaClienteOrcamentos(ACampanhaOrcamento[vQtdCampanhas]).PercentualFormula / 100)));
                vQueryFC.Next;
              end;
            end;
          end;
        end;
      except
        Exit;
      end;
    end else
    begin
      try
        /// falta implementar a parte do privilege
      except
        on e: Exception do
        raise Exception.Create('Venda já possui Desconto')
      end;
    end;
  finally
    vQueryFC.Free;
    vQueryPRV.Free;
  end;
end;

procedure Desconto_Franquia(AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
var vQuerySelecionaDesconto, vQueryIncluiDesconto: TFDQuery;
  vQryConsultaDescFranquias: TIBQuery;
  vValorUnitarioDesconto, vValorTotal, vPercentualDesconto, vPercentualDescontoFormula, vPercentualDescontoVarejo: Double;
  vQtdContadorCampanhas: Integer;
begin
  vQuerySelecionaDesconto := TFDQuery.Create(nil);
  vQueryIncluiDesconto := TFDQuery.Create(nil);
  vQryConsultaDescFranquias := TIBQuery.Create(nil);

  vQuerySelecionaDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQueryIncluiDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQryConsultaDescFranquias.Database := AInfo.DatabaseIBConnectionPrivilege;

  try
    for vQtdContadorCampanhas := 0 to Length(AInfo.TerminalBalcao) - 1 do
    begin
      vQryConsultaDescFranquias.Close;
      vQryConsultaDescFranquias.SQL.Clear;
      vQryConsultaDescFranquias.SQL.Add(
        RetornarSelectDescontoFranquiaQuantidadeValor(AInfo.Cpf));
      vQryConsultaDescFranquias.Open;

      if (vQryConsultaDescFranquias.IsEmpty) then
        raise Exception.Create('Cliente não está cadastrado como franqueado Pharmapele');

      vPercentualDescontoVarejo := vQryConsultaDescFranquias.FieldValues['DESCPVAR'];
      vPercentualDescontoFormula := vQryConsultaDescFranquias.FieldValues['DESCPFORM'];

      vQuerySelecionaDesconto.Close;
      vQuerySelecionaDesconto.SQL.Clear;
      vQuerySelecionaDesconto.Open(
        RetornarSelectFC32110Itens(
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
      vQuerySelecionaDesconto.FetchAll;
      vQuerySelecionaDesconto.First;

      while not(vQuerySelecionaDesconto.Eof) do
      begin
        if vQuerySelecionaDesconto.FieldValues['TPITM'] = 'R' then
        begin
          vValorUnitarioDesconto := (vQuerySelecionaDesconto.FieldValues['VRTOT'] * vPercentualDescontoFormula) / 100;
          vPercentualDesconto := vPercentualDescontoFormula;
        end
        else
        begin
          vValorUnitarioDesconto := (vQuerySelecionaDesconto.FieldValues['VRTOT'] * vPercentualDescontoVarejo) / 100;
          vPercentualDesconto := vPercentualDescontoVarejo;
        end;

        vValorUnitarioDesconto := RoundTo(vValorUnitarioDesconto, -2);

        if ATipo = tcWebService then
          PreencherJSONArrayTerminalBalcao(
            ALista,
            CAMPANHA_FRANQUIA,
            vQuerySelecionaDesconto.FieldValues['tpitm'],
            vQuerySelecionaDesconto.FieldValues['cdfil'],
            vQuerySelecionaDesconto.FieldValues['cdpro'],
            vQuerySelecionaDesconto.FieldValues['nrcpm'],
            vQuerySelecionaDesconto.FieldValues['descrprd'],
            vQuerySelecionaDesconto.FieldValues['vrtot'],
            vPercentualDesconto,
            vValorUnitarioDesconto,
            vQuerySelecionaDesconto.FieldValues['vrliq'])
        else
        begin
          vQueryIncluiDesconto.Close;
          vQueryIncluiDesconto.SQL.Clear;
          vQueryIncluiDesconto.ExecSQL(
            RetornarUpdateBalcaoReceitasFC32200TipoDescontoValores(
               vQuerySelecionaDesconto.FieldValues['cdfil'],
               vQuerySelecionaDesconto.FieldValues['nrcpm'],
               vQuerySelecionaDesconto.FieldValues['itemid'],
               vQuerySelecionaDesconto.FieldValues['operid'],
               vValorUnitarioDesconto,
               vValorUnitarioDesconto,
               vValorUnitarioDesconto,
               vQuerySelecionaDesconto.FieldValues['tpdsc'],
               USUARIO_FRANQUIA,
               vQuerySelecionaDesconto.FieldValues['cdtml'],
               vQuerySelecionaDesconto.FieldValues['dtope']));
          vQueryIncluiDesconto.Connection.CommitRetaining;

          vQueryIncluiDesconto.Close;
          vQueryIncluiDesconto.SQL.Clear;
          vQueryIncluiDesconto.ExecSQL(
            RetornarUpdateBalcaoReceitasFC32200ValorCaixa(
              vQuerySelecionaDesconto.FieldValues['cdfil'],
              vQuerySelecionaDesconto.FieldValues['nrcpm'],
              vQuerySelecionaDesconto.FieldValues['itemid'],
              vQuerySelecionaDesconto.FieldValues['operid'],
              vValorUnitarioDesconto,
              vQuerySelecionaDesconto.FieldValues['cdtml'],
              vQuerySelecionaDesconto.FieldValues['tppag'],
              vQuerySelecionaDesconto.FieldValues['dtope']));
          vQueryIncluiDesconto.Connection.CommitRetaining;

          vQueryIncluiDesconto.Close;
          vQueryIncluiDesconto.SQL.Clear;
          if vQuerySelecionaDesconto.FieldValues['tpitm'] = 'R' then
            vQueryIncluiDesconto.ExecSQL(
              RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(
                vQuerySelecionaDesconto.FieldValues['cdfil'],
                vQuerySelecionaDesconto.FieldValues['nrcpm'],
                vQuerySelecionaDesconto.FieldValues['itemid'],
                vQuerySelecionaDesconto.FieldValues['operid'],
                vQuerySelecionaDesconto.FieldValues['vrcxa'],
                vQuerySelecionaDesconto.FieldValues['vrcxa'],
                vQuerySelecionaDesconto.FieldValues['vrcxa'],
                vQuerySelecionaDesconto.FieldValues['vrcxa'],
                vQuerySelecionaDesconto.FieldValues['vrcxa'],
                vQuerySelecionaDesconto.FieldValues['vrcxa'],
                0,
                0,
                vQuerySelecionaDesconto.FieldValues['tpdsc'],
                vQuerySelecionaDesconto.FieldValues['cdtml'],
                EmptyStr,
                vQuerySelecionaDesconto.FieldValues['tpitm'],
                vQuerySelecionaDesconto.FieldValues['dtope']))
          else
            vQueryIncluiDesconto.ExecSQL(
              RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(
                vQuerySelecionaDesconto.FieldValues['cdfil'],
                vQuerySelecionaDesconto.FieldValues['nrcpm'],
                vQuerySelecionaDesconto.FieldValues['itemid'],
                vQuerySelecionaDesconto.FieldValues['operid'],
                vValorUnitarioDesconto,
                vValorUnitarioDesconto,
                vValorUnitarioDesconto,
                0,
                0,
                vValorUnitarioDesconto,
                vPercentualDesconto,
                vValorUnitarioDesconto,
                vQuerySelecionaDesconto.FieldValues['tpdsc'],
                vQuerySelecionaDesconto.FieldValues['cdtml'],
                EmptyStr,
                vQuerySelecionaDesconto.FieldValues['tpitm'],
                vQuerySelecionaDesconto.FieldValues['dtope']));
          vQueryIncluiDesconto.Connection.CommitRetaining;

          vQuerySelecionaDesconto.Next;
        end;
      end;
      vQuerySelecionaDesconto.First;

      if (ATipo = tcDesktop) then
      begin
        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.Open(
          RetornarSelectFC32110SomaValorLiquido(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            vQuerySelecionaDesconto.FieldValues['dtope']));

        vValorTotal := vQueryIncluiDesconto.FieldValues['VALOR'];

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTerminalBalcaoFC32100UsuarioValores(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].IDCampanha,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            USUARIO_FRANQUIA,
            vQuerySelecionaDesconto.FieldValues['dtope']));
        vQueryIncluiDesconto.Connection.CommitRetaining;

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTotvsConfEnvio(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
        vQueryIncluiDesconto.Connection.CommitRetaining;
      end;
    end;
  finally
    vQuerySelecionaDesconto.Free;
    vQueryIncluiDesconto.Free;
    vQryConsultaDescFranquias.Free;
  end;
end;

procedure Desconto_Progressivo(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
var
  vQuerySelecionaDesconto, vQueryIncluiDesconto: TFDQuery;
  vContador, vCodigoProduto, vQtdProdutosPromocao, vIDItem, vQtdContadorCampanhas: Integer;
  vPercentualDesconto, vValorProduto, vValorTotal, vValorDesconto: Double;
begin
  vQuerySelecionaDesconto := TFDQuery.Create(nil);
  vQueryIncluiDesconto := TFDQuery.Create(nil);

  vQuerySelecionaDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQueryIncluiDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;

  try
    for vQtdContadorCampanhas := 0 to Length(AInfo.TerminalBalcao) - 1 do
    begin
      vQuerySelecionaDesconto.Close;
      vQuerySelecionaDesconto.SQL.Clear;
      vQuerySelecionaDesconto.Open(
        RetornarSelectFC32110Itens(
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
          tiVarejo));
      vQuerySelecionaDesconto.First;

      if vQuerySelecionaDesconto.IsEmpty then
        Exit;

      vQuerySelecionaDesconto.First;
      while not vQuerySelecionaDesconto.Eof do
      begin
        if (vQuerySelecionaDesconto.FieldValues['vrdsc'] > 0) and (vQuerySelecionaDesconto.FieldValues['IDPROMO'] = 0) then
        begin
          if ATipo = tcDesktop then
            raise Exception.Create('Venda já possui Desconto')
          else
            Exit;
        end;
        vQuerySelecionaDesconto.Next;
      end;

      while not (vQuerySelecionaDesconto.Eof) do
      begin
        vCodigoProduto := vQuerySelecionaDesconto.FieldValues['cdpro'];
        vQtdProdutosPromocao := vQuerySelecionaDesconto.FieldValues['quant'];

        if vQtdProdutosPromocao > 2 then
          vPercentualDesconto := 15
        else
          vPercentualDesconto := 10;

        for vContador := 1 to vQtdProdutosPromocao do
        begin
          vQueryIncluiDesconto.Close;
          vQueryIncluiDesconto.sql.Clear;
          vQueryIncluiDesconto.sql.Add('   select * ');
          vQueryIncluiDesconto.sql.Add('     from fc32110 ');
          vQueryIncluiDesconto.sql.Add('    where tpitm=' + QuotedStr('V'));
          vQueryIncluiDesconto.sql.Add('      and cdfil=' + IntToStr(AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial));
          vQueryIncluiDesconto.sql.Add('      and nrcpm=' + IntToStr(AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
          vQueryIncluiDesconto.sql.Add('      and dtope >= (current_date -1) ');
          vQueryIncluiDesconto.sql.Add('      and cdpro in (' + inttostr(vCodigoProduto) + ') ');
          vQueryIncluiDesconto.sql.Add('      and vrdsc = 0 ');
          vQueryIncluiDesconto.sql.Add(' order by itemID');
          vQueryIncluiDesconto.Open;

          if vQueryIncluiDesconto.IsEmpty then
            continue;

          vValorProduto := vQueryIncluiDesconto.FieldValues['pruni'] * vQueryIncluiDesconto.FieldValues['quant'];
          vValorDesconto := (vValorProduto * vPercentualDesconto) / 100;
          AValorTotal := AValorTotal + vValorDesconto;

          if ATipo = tcWebService then
            PreencherJSONArrayTerminalBalcao(
              ALista,
              CAMPANHA_PROGRESSIVO,
              'V',
              vQuerySelecionaDesconto.FieldValues['cdfil'],
              vQuerySelecionaDesconto.FieldValues['cdpro'],
              vQuerySelecionaDesconto.FieldValues['nrcpm'],
              vQuerySelecionaDesconto.FieldValues['descrprd'],
              vQuerySelecionaDesconto.FieldValues['vrtot'],
              vPercentualDesconto,
              vValorDesconto,
              vQuerySelecionaDesconto.FieldValues['vrliq'])
          else
          begin
            vIDItem := vQueryIncluiDesconto.FieldValues['itemid'];

            if vQueryIncluiDesconto.IsEmpty then
              raise exception.Create('Erro ao lançar desconto ' + CAMPANHA_PROGRESSIVO);

            vQueryIncluiDesconto.Close;
            vQueryIncluiDesconto.SQL.Clear;
            vQueryIncluiDesconto.ExecSQL(
              RetornarUpdateBalcaoReceitasFC32200TipoDescontoValores(
                 vQuerySelecionaDesconto.FieldValues['cdfil'],
                 vQuerySelecionaDesconto.FieldValues['nrcpm'],
                 vQuerySelecionaDesconto.FieldValues['itemid'],
                 vQuerySelecionaDesconto.FieldValues['operid'],
                 vValorDesconto,
                 vValorDesconto,
                 vValorDesconto,
                 '3',
                 AInfo.TerminalBalcao[vQtdContadorCampanhas].UsuarioAutorizacao,
                 vQuerySelecionaDesconto.FieldValues['cdtml'],
                 vQuerySelecionaDesconto.FieldValues['dtope'] )
            );


            vQueryIncluiDesconto.Close;
            vQueryIncluiDesconto.SQL.Clear;
            vQueryIncluiDesconto.ExecSQL(
              RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
                vIDItem,
                vQuerySelecionaDesconto.FieldValues['operid'],
                vValorDesconto,
                vValorDesconto,
                vValorDesconto,
                0,
                0,
                vValorDesconto,
                vPercentualDesconto,
                vValorDesconto,
                '3',
                vQuerySelecionaDesconto.FieldValues['tpdsc'],
                EmptyStr,
                vQuerySelecionaDesconto.FieldValues['tpitm'],
                vQuerySelecionaDesconto.FieldValues['dtope']));
            vQueryIncluiDesconto.Connection.CommitRetaining;
          end;
        end;
        vQuerySelecionaDesconto.Next;
      end;

      if ATipo = tcDesktop then
      begin
        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.Open(
          RetornarSelectFC32110SomaValorLiquido(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            vQuerySelecionaDesconto.FieldValues['dtope']));

        vValorTotal := vQueryIncluiDesconto.FieldValues['VALOR'];

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTerminalBalcaoFC32100UsuarioValores(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            vQuerySelecionaDesconto.FieldValues['idpromo'],
            vValorTotal,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            USUARIO_PROGRESSIVO,
            now));

        vQueryIncluiDesconto.Connection.CommitRetaining;

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTotvsConfEnvio(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
        vQueryIncluiDesconto.Connection.CommitRetaining;
      end;
    end;
  finally
    vQuerySelecionaDesconto.Free;
    vQueryIncluiDesconto.Free;
  end;
end;

procedure Desconto_Progressivo_Colageno(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
var
  vQuery, vQuerySelecionaDesconto, vQueryIncluiDesconto: TFDQuery;
  vQtdProdutosPromocao, vQtdContadorCampanhas: Integer;
  vPercentualDesconto, vValorProduto, vValorDesconto, vValorTotal: Double;
begin
  vQuerySelecionaDesconto := TFDQuery.Create(nil);
  vQueryIncluiDesconto := TFDQuery.Create(nil);
  vQuery := TFDQuery.Create(nil);

  vQuerySelecionaDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQueryIncluiDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQuery.Connection := AInfo.DatabaseFDConnectionFormulaCerta;

  try
    for vQtdContadorCampanhas := 0 to Length(AInfo.TerminalBalcao) - 1 do
    begin
      vQuerySelecionaDesconto.Close;
      vQuerySelecionaDesconto.SQL.Clear;
      vQuerySelecionaDesconto.Open(
        RetornarSelectFC32110Itens(
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
          tiVarejo));

      if vQuerySelecionaDesconto.IsEmpty then
        Exit;

      vQuerySelecionaDesconto.First;
      vQtdProdutosPromocao := 0;

      while not vQuerySelecionaDesconto.Eof do
      begin
        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_DESCONTO_PROGRESSIVO_COLAGENO) then
          vQtdProdutosPromocao := vQtdProdutosPromocao + vQuerySelecionaDesconto.FieldValues['quant'];
        vQuerySelecionaDesconto.Next;
      end;

      if vQtdProdutosPromocao > 2 then
        vPercentualDesconto := VALOR_PERCENTUAL_15
      else
        vPercentualDesconto := VALOR_PERCENTUAL_10;

      vQuerySelecionaDesconto.First;

      while not vQuerySelecionaDesconto.Eof do
      begin
        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_DESCONTO_PROGRESSIVO_COLAGENO) then
        begin
          vValorProduto := vQuerySelecionaDesconto.FieldValues['PRUNI'] * vQuerySelecionaDesconto.FieldValues['quant'];
          vValorDesconto := (vValorProduto * vPercentualDesconto) / 100;
          AValorTotal := vValorDesconto;


          if ATipo = tcWebService then
            PreencherJSONArrayTerminalBalcao(
              ALista,
              CAMPANHA_COLAGENO,
              vQuerySelecionaDesconto.FieldValues['tpitm'],
              vQuerySelecionaDesconto.FieldValues['cdfil'],
              vQuerySelecionaDesconto.FieldValues['cdpro'],
              vQuerySelecionaDesconto.FieldValues['nrcpm'],
              vQuerySelecionaDesconto.FieldValues['descrprd'],
              vQuerySelecionaDesconto.FieldValues['vrtot'],
              vPercentualDesconto,
              vValorDesconto,
              vQuerySelecionaDesconto.FieldValues['vrliq'])
          else
          begin
            vQueryIncluiDesconto.Close;
            vQueryIncluiDesconto.SQL.Clear;
            vQueryIncluiDesconto.ExecSQL(
              RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
                vQuerySelecionaDesconto.FieldValues['itemid'],
                vQuerySelecionaDesconto.FieldValues['operid'],
                vValorDesconto,
                vValorDesconto,
                vValorDesconto,
                0,
                0,
                vValorDesconto,
                vPercentualDesconto,
                vValorDesconto,
                '3',
                vQuerySelecionaDesconto.FieldValues['cdtml'],
                EmptyStr,
                vQuerySelecionaDesconto.FieldValues['tpitm'],
                vQuerySelecionaDesconto.FieldValues['dtope']));
            vQueryIncluiDesconto.Connection.CommitRetaining;
          end;
        end;
        vQuerySelecionaDesconto.Next;
      end;

      if ATipo = tcDesktop then
      begin
        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.Open(
          RetornarSelectFC32110SomaValorLiquido(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            Now -1));

        vValorTotal := vQueryIncluiDesconto.FieldValues['valor'];

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTerminalBalcaoFC32100UsuarioValores(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            vQuerySelecionaDesconto.FieldValues['idpromo'],
            vValorTotal,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            USUARIO_PROGRESSIVO_COLAGENO,
            now));
        vQueryIncluiDesconto.Connection.CommitRetaining;

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTotvsConfEnvio(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
        vQueryIncluiDesconto.Connection.CommitRetaining;
      end;
    end;
  finally
    vQuerySelecionaDesconto.Free;
    vQueryIncluiDesconto.Free;
  end;
end;

procedure Desconto_Progressivo_Cabelo(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
var
  vQuery, vQuerySelecionaDesconto, vQueryIncluiDesconto: TFDQuery;
  vQtdProdutosPromocao, vQtdContadorCampanhas: Integer;
  vPercentualDesconto, vValorProduto, vValorTotal, vValorDesconto: Double;
begin
  vQuerySelecionaDesconto := TFDQuery.Create(nil);
  vQueryIncluiDesconto := TFDQuery.Create(nil);
  vQuery := TFDQuery.Create(nil);

  vQuerySelecionaDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQueryIncluiDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQuery.Connection := AInfo.DatabaseFDConnectionFormulaCerta;

  try
    for vQtdContadorCampanhas := 0 to Length(AInfo.TerminalBalcao) - 1 do
    begin
      vQuerySelecionaDesconto.Close;
      vQuerySelecionaDesconto.SQL.Clear;
      vQuerySelecionaDesconto.Open(
        RetornarSelectFC32110Itens(
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
          tiVarejo));

      if vQuerySelecionaDesconto.IsEmpty then
        Exit;

      vQuerySelecionaDesconto.First;
      vQtdProdutosPromocao := 0;
      while not vQuerySelecionaDesconto.Eof do
      begin
        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_DESCONTO_PROGRESSIVO_CABELO) then
          vQtdProdutosPromocao := vQtdProdutosPromocao + vQuerySelecionaDesconto.FieldValues['quant'];
        vQuerySelecionaDesconto.Next;
      end;

      if vQtdProdutosPromocao < 2 then
      begin
        if ATipo = tcDesktop then

        raise Exception.Create('Quantidade insuficiente para promoção')
        else

      end;

      if vQtdProdutosPromocao > 2 then
        vPercentualDesconto := VALOR_PERCENTUAL_15
      else
        vPercentualDesconto := VALOR_PERCENTUAL_10;

      vQuerySelecionaDesconto.First;

      while not vQuerySelecionaDesconto.Eof do
      begin

        vValorProduto := vQuerySelecionaDesconto.FieldValues['PRUNI'] * vQuerySelecionaDesconto.FieldValues['quant'];
        vValorDesconto := (vValorProduto * vPercentualDesconto) / 100;
        AValorTotal := vValorDesconto + AValorTotal;

        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_DESCONTO_PROGRESSIVO_CABELO) then
        begin
          if ATipo = tcWebService then
            PreencherJSONArrayTerminalBalcao(
              ALista,
              CAMPANHA_CABELOS,
              vQuerySelecionaDesconto.FieldValues['tpitm'],
              vQuerySelecionaDesconto.FieldValues['cdfil'],
              vQuerySelecionaDesconto.FieldValues['cdpro'],
              vQuerySelecionaDesconto.FieldValues['nrcpm'],
              vQuerySelecionaDesconto.FieldValues['descrprd'],
              vQuerySelecionaDesconto.FieldValues['vrtot'],
              vPercentualDesconto,
              vValorDesconto,
              vQuerySelecionaDesconto.FieldValues['vrliq'] - vValorDesconto)
          else
          begin
            vQuery.Close;
            vQuery.SQL.Clear;
            vQuery.sql.Add('   select * ');
            vQuery.sql.Add('     from fc32110 ');
            vQuery.sql.Add('    where tpitm = ' + QuotedStr(vQuerySelecionaDesconto.FieldValues['tpitm']));
            vQuery.sql.Add('      and cdfil = ' + IntToStr(AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial));
            vQuery.sql.Add('      and nrcpm = ' + IntToStr(AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
            vQuery.sql.Add('      and dtope >= (current_date -1)');
            vQuery.sql.Add('      and cdpro in (' + IntTostr(vQuerySelecionaDesconto.FieldValues['cdpro']) + ') and vrliq >' + MudarPonto(vValorDesconto));
            vQuery.sql.Add(' order by vrliq desc');
            vQuery.Open;

            if vQuery.IsEmpty then
              raise exception.Create('Erro ao lançar desconto ' + CAMPANHA_CABELOS);

            vQueryIncluiDesconto.Close;
            vQueryIncluiDesconto.SQL.Clear;
            vQueryIncluiDesconto.ExecSQL(
              RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
                vQuerySelecionaDesconto.FieldValues['itemid'],
                vQuerySelecionaDesconto.FieldValues['operid'],
                vValorDesconto,
                vValorDesconto,
                vValorDesconto,
                0,
                0,
                vValorDesconto,
                vPercentualDesconto,
                vValorDesconto,
                '3',
                vQuerySelecionaDesconto.FieldValues['cdtml'],
                EmptyStr,
                vQuerySelecionaDesconto.FieldValues['tpitm'],
                vQuerySelecionaDesconto.FieldValues['dtope']));
            vQueryIncluiDesconto.Connection.CommitRetaining;
          end;
        end;
        vQuerySelecionaDesconto.Next;
      end;

      if ATipo = tcDesktop then
      begin
        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.Open(
          RetornarSelectFC32110SomaValorLiquido(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            Now - 1));

        vValorTotal := vQueryIncluiDesconto.FieldValues['VALOR'];

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTerminalBalcaoFC32100UsuarioValores(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
           vQuerySelecionaDesconto.FieldValues['idpromo'],
           vValorTotal,
           vValorTotal,
           vValorTotal,
           vValorTotal,
           USUARIO_PROGRESSIVO_CABELO,
           Now));
        vQueryIncluiDesconto.Connection.CommitRetaining;

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTotvsConfEnvio(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
        vQueryIncluiDesconto.Connection.CommitRetaining;
      end;
    end;
  finally
    vQuerySelecionaDesconto.Free;
    vQueryIncluiDesconto.Free;
    vQuery.Free;
  end;
end;

procedure Desconto_Progressivo_PrevAging(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
var
  vQuery, vQuerySelecionaDesconto, vQueryIncluiDesconto: TFDQuery;
  vQtdProdutosPromocao, vQtdContadorCampanhas: Integer;
  vPercentualDesconto, vValorProduto, vValorTotal, vValorDesconto: Double;
begin
  vQuerySelecionaDesconto := TFDQuery.Create(nil);
  vQueryIncluiDesconto := TFDQuery.Create(nil);
  vQuery := TFDQuery.Create(nil);

  vQuerySelecionaDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQueryIncluiDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQuery.Connection := AInfo.DatabaseFDConnectionFormulaCerta;

  try
    for vQtdContadorCampanhas := 0 to Length(AInfo.TerminalBalcao) - 1 do
    begin
      vQuerySelecionaDesconto.Close;
      vQuerySelecionaDesconto.SQL.Clear;
      vQuerySelecionaDesconto.Open(
        RetornarSelectFC32110Itens(
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
          tiVarejo));

      if vQuerySelecionaDesconto.IsEmpty then
        Exit;
      vQuerySelecionaDesconto.First;
      vQtdProdutosPromocao := 0;
      while not vQuerySelecionaDesconto.Eof do
      begin
        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_DESCONTO_PROGRESSIVO_CABELO) then
          vQtdProdutosPromocao := vQtdProdutosPromocao + vQuerySelecionaDesconto.FieldValues['quant'];
        vQuerySelecionaDesconto.Next;
      end;

      if vQtdProdutosPromocao > 2 then
        vPercentualDesconto := VALOR_PERCENTUAL_15
      else
        vPercentualDesconto := VALOR_PERCENTUAL_10;

      vValorProduto := vQuerySelecionaDesconto.FieldValues['pruni'] * vQuerySelecionaDesconto.FieldValues['quant'];
      vValorDesconto := (vValorProduto * vPercentualDesconto) / 100;
      AValorTotal := vValorDesconto;

      vQuerySelecionaDesconto.First;

      while not vQuerySelecionaDesconto.Eof do
      begin
        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_DESCONTO_PROGRESSIVO_PREVAGING) then
        begin
          if ATipo = tcWebService then
            PreencherJSONArrayTerminalBalcao(
              ALista,
              CAMPANHA_PREVAGING,
              vQuerySelecionaDesconto.FieldValues['tpitm'],
              vQuerySelecionaDesconto.FieldValues['cdfil'],
              vQuerySelecionaDesconto.FieldValues['cdpro'],
              vQuerySelecionaDesconto.FieldValues['nrcpm'],
              vQuerySelecionaDesconto.FieldValues['descrprd'],
              vQuerySelecionaDesconto.FieldValues['vrtot'],
              vPercentualDesconto,
              vValorDesconto,
              vQuerySelecionaDesconto.FieldValues['vrliq'])
          else
          begin
            vQuery.Close;
            vQuery.SQL.Clear;
            vQuery.sql.Add('   select * ');
            vQuery.sql.Add('     from fc32110 ');
            vQuery.sql.Add('    where tpitm = ' + vQuerySelecionaDesconto.FieldValues['tpitm']);
            vQuery.sql.Add('      and cdfil = ' + IntToStr(AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial));
            vQuery.sql.Add('      and nrcpm = ' + IntToStr(AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
            vQuery.sql.Add('      and dtope >= (current_date -1)');
            vQuery.sql.Add('      and cdpro in (' + IntTostr(vQuerySelecionaDesconto.FieldValues['cdpro']) + ') and vrliq >' + MudarPonto(vValorDesconto));
            vQuery.sql.Add(' order by vrliq desc');
            vQuery.Open;

            if vQuery.IsEmpty then
              raise exception.Create('Erro ao lançar desconto ' + CAMPANHA_PREVAGING);

            vQueryIncluiDesconto.Close;
            vQueryIncluiDesconto.SQL.Clear;
            vQueryIncluiDesconto.ExecSQL(
              RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
                vQuerySelecionaDesconto.FieldValues['itemid'],
                vQuerySelecionaDesconto.FieldValues['operid'],
                vValorDesconto,
                vValorDesconto,
                vValorDesconto,
                0,
                0,
                vValorDesconto,
                vPercentualDesconto,
                vValorDesconto,
                '3',
                vQuerySelecionaDesconto.FieldValues['cdtml'],
                USUARIO_PROGRESSIVO_PREVAGING,
                vQuerySelecionaDesconto.FieldValues['tpitm'],
                vQuerySelecionaDesconto.FieldValues['dtope']));
            vQueryIncluiDesconto.Connection.CommitRetaining;
          end;
        end;
        vQuerySelecionaDesconto.Next;
      end;

      if ATipo = tcDesktop then
      begin
        vQuerySelecionaDesconto.Close;
        vQuerySelecionaDesconto.SQL.Clear;
        vQuerySelecionaDesconto.Open(
          RetornarSelectFC32110SomaValorLiquido(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            Now-1));

        vValorTotal := vQuerySelecionaDesconto.FieldValues['VALOR'];

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTerminalBalcaoFC32100UsuarioValores(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            0,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            USUARIO_PROGRESSIVO_COLAGENO,
            Now));
        vQueryIncluiDesconto.Connection.CommitRetaining;

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTotvsConfEnvio(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
        vQueryIncluiDesconto.Connection.CommitRetaining;
      end;
    end;
  finally
    vQuerySelecionaDesconto.Free;
    vQueryIncluiDesconto.Free;
  end;
end;

procedure Desconto_Progressivo_PowerTrainning(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
var
  vQuery, vQuerySelecionaDesconto, vQueryIncluiDesconto: TFDQuery;
  vQtdProdutosPromocao,vQtdContadorCampanhas: Integer;
  vPercentualDesconto, vValorProduto, vValorTotal, vValorDesconto: Double;
begin
  vQuerySelecionaDesconto := TFDQuery.Create(nil);
  vQueryIncluiDesconto := TFDQuery.Create(nil);
  vQuery := TFDQuery.Create(nil);

  vQuerySelecionaDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQueryIncluiDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQuery.Connection := AInfo.DatabaseFDConnectionFormulaCerta;

  try

    for vQtdContadorCampanhas := 0 to Length(AInfo.TerminalBalcao) - 1 do
    begin
      vQuerySelecionaDesconto.Close;
      vQuerySelecionaDesconto.SQL.Clear;

      case ATipo of
        tcDesktop:
          vQuerySelecionaDesconto.Open(
            RetornarSelectFC32110Itens(AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial, AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom, tiVarejo));
        tcWebService:
          vQuerySelecionaDesconto.Open(
            RetornarSelectFC03000Produtos(AProdutos, AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial));
      end;

      if vQuerySelecionaDesconto.IsEmpty then
        Exit;

      vQuerySelecionaDesconto.First;
      vQtdProdutosPromocao := 0;
      while not vQuerySelecionaDesconto.Eof do
      begin
        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_DESCONTO_POWERTRAINNING) then
          vQtdProdutosPromocao := vQtdProdutosPromocao + vQuerySelecionaDesconto.FieldValues['quant'];
        vQuerySelecionaDesconto.Next;
      end;

      case vQtdProdutosPromocao of
        1: vPercentualDesconto := VALOR_PERCENTUAL_05;
        2: vPercentualDesconto := VALOR_PERCENTUAL_10;
      else
        vPercentualDesconto := VALOR_PERCENTUAL_15;
      end;

      vValorProduto := vQuerySelecionaDesconto.FieldValues['PRUNI'] * vQuerySelecionaDesconto.FieldValues['quant'];
      vValorDesconto := (vValorProduto * vPercentualDesconto) / 100;
      AValorTotal := vValorDesconto;

      vQuerySelecionaDesconto.First;

      while not vQuerySelecionaDesconto.Eof do
      begin
        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_DESCONTO_POWERTRAINNING) then
        begin
          if ATipo = tcWebService then
            if vQuerySelecionaDesconto.FieldByName('tpitm').AsString = 'V' then
              PreencherJSONArrayProdutoOrcamento(
                ALista,
                CAMPANHA_POWERTRAINING,
                vQuerySelecionaDesconto.FieldValues['descricao'],
                vQuerySelecionaDesconto.FieldValues['cdpro'],
                vQuerySelecionaDesconto.FieldValues['pruni'],
                vPercentualDesconto,
                vValorDesconto,
                vQuerySelecionaDesconto.FieldValues['valor_liquido'])
              else
              PreencherJSONArrayOrcamento(
                ALista,
                CAMPANHA_POWERTRAINING,
                vQuerySelecionaDesconto.FieldValues['tpitm'],
                ,//orcamento
                vQuerySelecionaDesconto.FieldValues['pruni'],// valor unitario
                vPercentualDesconto,
                vValorDesconto,
                vQuerySelecionaDesconto.FieldValues['valor_liquido'])

          else
          begin
            vQuery.Close;
            vQuery.SQL.Clear;
            vQuery.sql.Add('   select * ');
            vQuery.sql.Add('     from fc32110 ');
            vQuery.sql.Add('    where tpitm = ' + vQuerySelecionaDesconto.FieldValues['tpitm']);
            vQuery.sql.Add('      and cdfil = ' + IntToStr(AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial));
            vQuery.sql.Add('      and nrcpm = ' + IntToStr(AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
            vQuery.sql.Add('      and dtope >= (current_date -1)');
            vQuery.sql.Add('      and cdpro in (' + IntTostr(vQuerySelecionaDesconto.FieldValues['cdpro']) + ') and vrliq >' + MudarPonto(vValorDesconto));
            vQuery.sql.Add(' order by vrliq desc');
            vQuery.Open;

            if vQuery.IsEmpty then
              raise exception.Create('Erro ao lançar desconto ' + CAMPANHA_POWERTRAINING);

            vQueryIncluiDesconto.Close;
            vQueryIncluiDesconto.SQL.Clear;
            vQueryIncluiDesconto.ExecSQL(
              RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
                vQuerySelecionaDesconto.FieldValues['itemid'],
                vQuerySelecionaDesconto.FieldValues['operid'],
                vValorDesconto,
                vValorDesconto,
                vValorDesconto,
                0,
                0,
                vValorDesconto,
                vPercentualDesconto,
                vValorDesconto,
                '3',
                vQuerySelecionaDesconto.FieldValues['cdtml'],
                USUARIO_PROGRESSIVO_POWERTRAINNING,
                vQuerySelecionaDesconto.FieldValues['tpitm'],
                vQuerySelecionaDesconto.FieldValues['dtope']));
            vQueryIncluiDesconto.Connection.CommitRetaining;
          end;
        end;
        vQuerySelecionaDesconto.Next;
      end;

      if ATipo = tcDesktop then
      begin
        vQuerySelecionaDesconto.Close;
        vQuerySelecionaDesconto.SQL.Clear;
        vQuerySelecionaDesconto.Open(
          RetornarSelectFC32110SomaValorLiquido(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            Now - 1));
        vValorTotal := vQuerySelecionaDesconto.FieldValues['valor'];

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTerminalBalcaoFC32100UsuarioValores(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            0,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            USUARIO_PROGRESSIVO_POWERTRAINNING,
            Now));
        vQueryIncluiDesconto.Connection.CommitRetaining;

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTotvsConfEnvio(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
        vQueryIncluiDesconto.Connection.CommitRetaining;
      end;
    end;
  finally
    vQuerySelecionaDesconto.Free;
    vQueryIncluiDesconto.Free;
  end;
end;

procedure Desconto_Linha_Clean_Therapy(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
var
  vQuery, vQuerySelecionaDesconto, vQueryIncluiDesconto: TFDQuery;
  vQtdProdutosPromocao,vQtdContadorCampanhas: Integer;
  vPercentualDesconto, vValorProduto, vValorTotal, vValorDesconto: Double;
begin
  vQuerySelecionaDesconto := TFDQuery.Create(nil);
  vQueryIncluiDesconto := TFDQuery.Create(nil);
  vQuery := TFDQuery.Create(nil);

  vQuerySelecionaDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQueryIncluiDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQuery.Connection := AInfo.DatabaseFDConnectionFormulaCerta;

  try
    for vQtdContadorCampanhas := 0 to Length(AInfo.TerminalBalcao) - 1 do
    begin
      vQuerySelecionaDesconto.Close;
      vQuerySelecionaDesconto.SQL.Clear;
      vQuerySelecionaDesconto.Open(
        RetornarSelectFC32110Itens(
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
          tiVarejo));

      if vQuerySelecionaDesconto.IsEmpty then
        Exit;

      vQuerySelecionaDesconto.First;
      vQtdProdutosPromocao := 0;
      while not vQuerySelecionaDesconto.Eof do
      begin
        if not(ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_LINHA_CLEAN_THERAPY)) then
          vQtdProdutosPromocao := vQtdProdutosPromocao + vQuerySelecionaDesconto.FieldValues['quant'];
        vQuerySelecionaDesconto.Next;
      end;

      case vQtdProdutosPromocao of
        1: vPercentualDesconto := 0.01;
        2: vPercentualDesconto := 10;
      else
        vPercentualDesconto := 15;    { rever isso auqi... ta certo mesmo??}
      end;

      vValorProduto := vQuerySelecionaDesconto.FieldValues['PRUNI'] * vQuerySelecionaDesconto.FieldValues['quant'];
      vValorDesconto := (vValorProduto * vPercentualDesconto) / 100;
      AValorTotal := vValorDesconto;

      vQuerySelecionaDesconto.First;

      while not vQuerySelecionaDesconto.Eof do
      begin
        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_LINHA_CLEAN_THERAPY) then
        begin
          if ATipo = tcWebService then
            PreencherJSONArrayTerminalBalcao(
              ALista,
              CAMPANHA_CLEAN_THERAPY,
              vQuerySelecionaDesconto.FieldValues['tpitm'],
              vQuerySelecionaDesconto.FieldValues['cdfil'],
              vQuerySelecionaDesconto.FieldValues['cdpro'],
              vQuerySelecionaDesconto.FieldValues['nrcpm'],
              vQuerySelecionaDesconto.FieldValues['descrprd'],
              vQuerySelecionaDesconto.FieldValues['vrtot'],
              vPercentualDesconto,
              vValorDesconto,
              vQuerySelecionaDesconto.FieldValues['vrliq'])
          else
          begin
            vQueryIncluiDesconto.Close;
            vQueryIncluiDesconto.SQL.Clear;
            vQueryIncluiDesconto.ExecSQL(
              RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
                vQuerySelecionaDesconto.FieldValues['itemid'],
                vQuerySelecionaDesconto.FieldValues['operid'],
                vValorDesconto,
                vValorDesconto,
                vValorDesconto,
                0,
                0,
                vValorDesconto,
                vPercentualDesconto,
                vValorDesconto,
                '3',
                vQuerySelecionaDesconto.FieldValues['cdtml'],
                USUARIO_LINHA_CLEAN_THERAPY,
                vQuerySelecionaDesconto.FieldValues['tpitm'],
                vQuerySelecionaDesconto.FieldValues['dtope']));
            vQueryIncluiDesconto.Connection.CommitRetaining;
          end;
        end;
        vQuerySelecionaDesconto.Next;
      end;

      if ATipo = tcDesktop then
      begin
        vQuerySelecionaDesconto.Close;
        vQuerySelecionaDesconto.SQL.Clear;
        vQuerySelecionaDesconto.Open(
          RetornarSelectFC32110SomaValorLiquido(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            Now));
        vValorTotal := vQuerySelecionaDesconto.FieldValues['valor'];

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTerminalBalcaoFC32100UsuarioValores(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            0,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            USUARIO_LINHA_CLEAN_THERAPY,
            Now));
        vQueryIncluiDesconto.Connection.CommitRetaining;

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTotvsConfEnvio(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
        vQueryIncluiDesconto.Connection.CommitRetaining;
      end;
    end;
  finally
    vQuerySelecionaDesconto.Free;
    vQueryIncluiDesconto.Free;
  end;
end;

procedure Desconto_Presentes(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
var
  vQuerySelecionaDesconto, vQueryIncluiDesconto: TFDQuery;
  vQtdProdutosPromocao,vQtdContadorCampanhas: Integer;
  vPercentualDesconto, vValorProduto, vValorTotal, vValorDesconto: Double;
begin
  vQuerySelecionaDesconto := TFDQuery.Create(nil);
  vQueryIncluiDesconto := TFDQuery.Create(nil);

  vQuerySelecionaDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQueryIncluiDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;

  try
    for vQtdContadorCampanhas := 0 to Length(AInfo.TerminalBalcao) - 1 do
    begin
      vQuerySelecionaDesconto.Close;
      vQuerySelecionaDesconto.SQL.Clear;
      vQuerySelecionaDesconto.Open(
        RetornarSelectFC32110Itens(
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
          tiVarejo));

      if vQuerySelecionaDesconto.IsEmpty then
        Exit;

      vQuerySelecionaDesconto.First;
      vQtdProdutosPromocao := 0;
      while not vQuerySelecionaDesconto.Eof do
      begin
        if not(ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_PROGRESSIVO_PRESENTE)) then
          vQtdProdutosPromocao := vQtdProdutosPromocao + vQuerySelecionaDesconto.FieldValues['quant'];
        vQuerySelecionaDesconto.Next;
      end;

      case vQtdProdutosPromocao of
        1: vPercentualDesconto := 0.01;
        2: vPercentualDesconto := 10;
      else
        vPercentualDesconto := 15; { rever isso auqi... ta certo mesmo??}
      end;

      vValorProduto := vQuerySelecionaDesconto.FieldValues['PRUNI'] * vQuerySelecionaDesconto.FieldValues['quant'];
      vValorDesconto := (vValorProduto * vPercentualDesconto) / 100;
      AValorTotal := vValorDesconto;

      vQuerySelecionaDesconto.First;

      while not vQuerySelecionaDesconto.Eof do
      begin
        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_PROGRESSIVO_PRESENTE) then
        begin
          if ATipo = tcWebService then
            PreencherJSONArrayTerminalBalcao(
              ALista,
              CAMPANHA_PRESENTES,
              vQuerySelecionaDesconto.FieldValues['tpitm'],
              vQuerySelecionaDesconto.FieldValues['cdfil'],
              vQuerySelecionaDesconto.FieldValues['cdpro'],
              vQuerySelecionaDesconto.FieldValues['nrcpm'],
              vQuerySelecionaDesconto.FieldValues['descrprd'],
              vQuerySelecionaDesconto.FieldValues['vrtot'],
              vPercentualDesconto,
              vValorDesconto,
              vQuerySelecionaDesconto.FieldValues['vrliq'])
          else
          begin
            vQueryIncluiDesconto.Close;
            vQueryIncluiDesconto.SQL.Clear;
            vQueryIncluiDesconto.ExecSQL(
              RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
                vQuerySelecionaDesconto.FieldValues['itemid'],
                vQuerySelecionaDesconto.FieldValues['operid'],
                vValorDesconto,
                vValorDesconto,
                vValorDesconto,
                0,
                0,
                vValorDesconto,
                vPercentualDesconto,
                vValorDesconto,
                '3',
                vQuerySelecionaDesconto.FieldValues['cdtml'],
                USUARIO_PROGRESSIVO_PRESENTE,
                vQuerySelecionaDesconto.FieldValues['tpitm'],
                vQuerySelecionaDesconto.FieldValues['dtope']));
            vQueryIncluiDesconto.Connection.CommitRetaining;
          end;
        end;
        vQuerySelecionaDesconto.Next;
      end;

      if ATipo = tcDesktop then
      begin
        vQuerySelecionaDesconto.Close;
        vQuerySelecionaDesconto.SQL.Clear;
        vQuerySelecionaDesconto.Open(
          RetornarSelectFC32110SomaValorLiquido(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            Now));
        vValorTotal := vQuerySelecionaDesconto.FieldValues['valor'];

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTerminalBalcaoFC32100UsuarioValores(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            0,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            USUARIO_PROGRESSIVO_PRESENTE,
            Now));
        vQueryIncluiDesconto.Connection.CommitRetaining;

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTotvsConfEnvio(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
        vQueryIncluiDesconto.Connection.CommitRetaining;
      end;
    end;
  finally
    vQuerySelecionaDesconto.Free;
    vQueryIncluiDesconto.Free;
  end;
end;

procedure Desconto_IFood(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
var
  vQuerySelecionaDesconto, vQueryIncluiDesconto: TFDQuery;
  vQtdContadorCampanhas: Integer;
  vValorTotal, vValorDesconto: Double;
begin
  vQuerySelecionaDesconto := TFDQuery.Create(nil);
  vQueryIncluiDesconto := TFDQuery.Create(nil);

  vQuerySelecionaDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQueryIncluiDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;

  try
    for vQtdContadorCampanhas := 0 to Length(AInfo.TerminalBalcao) - 1 do
    begin
      vQuerySelecionaDesconto.Close;
      vQuerySelecionaDesconto.SQL.Clear;
      vQuerySelecionaDesconto.Open(
        RetornarSelectFC32110Itens(
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));

      if vQuerySelecionaDesconto.IsEmpty then
        Exit;

      vQuerySelecionaDesconto.First;
      vValorDesconto := 0;
      while not vQuerySelecionaDesconto.Eof do
      begin
        if vQuerySelecionaDesconto.FieldValues['vrdsc'] > 0 then
          vValorDesconto := vValorDesconto + vQuerySelecionaDesconto.FieldValues['vrdsc'];
        vQuerySelecionaDesconto.Next;
      end;

      AValorTotal := vValorDesconto;

      vQuerySelecionaDesconto.First;

      while not vQuerySelecionaDesconto.Eof do
      begin

        if ATipo = tcWebService then
          PreencherJSONArrayTerminalBalcao(
            ALista,
            CAMPANHA_IFOOD,
            vQuerySelecionaDesconto.FieldValues['tpitm'],
            vQuerySelecionaDesconto.FieldValues['cdfil'],
            vQuerySelecionaDesconto.FieldValues['cdpro'],
            vQuerySelecionaDesconto.FieldValues['nrcpm'],
            vQuerySelecionaDesconto.FieldValues['descrprd'],
            vQuerySelecionaDesconto.FieldValues['vrtot'],
            vQuerySelecionaDesconto.FieldValues['ptdsc'],
            vQuerySelecionaDesconto.FieldValues['vrdsc'],
            vQuerySelecionaDesconto.FieldValues['vrliq'])
        else
        begin
          if vQuerySelecionaDesconto.FieldValues['vrdsc'] = 0 then
          begin
            vQuerySelecionaDesconto.Next;
            continue;
          end;

          vQueryIncluiDesconto.Close;
          vQueryIncluiDesconto.SQL.Clear;
          vQueryIncluiDesconto.SQL.Add(' update fc32110 ');
          vQueryIncluiDesconto.SQL.Add('    set pruniliq=vrtot, ');
          vQueryIncluiDesconto.SQL.Add('        vrcxa=vrtot, ');
          vQueryIncluiDesconto.SQL.Add('        vrliq=vrtot, ');
          vQueryIncluiDesconto.SQL.Add('        vrdsc=0, ');
          vQueryIncluiDesconto.SQL.Add('        PTDSC=0, ');
          vQueryIncluiDesconto.SQL.Add('        BCPIS=vrtot, ');
          vQueryIncluiDesconto.SQL.Add('        VRPIS= vrtot *(ALPIS/100) , ');
          vQueryIncluiDesconto.SQL.Add('        BCCOFINS=vrtot, ');
          vQueryIncluiDesconto.SQL.Add('        BCICM=vrtot, ');
          vQueryIncluiDesconto.SQL.Add('        VRCOFINS= vrtot * ( ALCOFINS/100), ');
          vQueryIncluiDesconto.SQL.Add('        VRICM = vrtot * ( ALICM/100 ) ');
          vQueryIncluiDesconto.SQL.Add('  where cdfil=' + IntToStr(AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial));
          vQueryIncluiDesconto.SQL.Add('    and nrcpm=' + IntToStr(AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
          vQueryIncluiDesconto.SQL.Add('    and itemid = ' + IntToStr(vQuerySelecionaDesconto.FieldValues['itemid']));
          vQueryIncluiDesconto.ExecSQL;
          vQueryIncluiDesconto.Connection.CommitRetaining;
        end;
        vQuerySelecionaDesconto.Next;
      end;

      if ATipo = tcDesktop then
      begin
        vQuerySelecionaDesconto.Close;
        vQuerySelecionaDesconto.SQL.Clear;
        vQuerySelecionaDesconto.Open(
          RetornarSelectFC32110SomaValorLiquido(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            Now-1));
        vValorTotal := vQuerySelecionaDesconto.FieldValues['valor'];

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTerminalBalcaoFC32100UsuarioValores(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            0,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            USUARIO_IFOOD,
            Now-1));
        vQueryIncluiDesconto.Connection.CommitRetaining;

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTotvsConfEnvio(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
        vQueryIncluiDesconto.Connection.CommitRetaining;
      end;
    end;
  finally
    vQuerySelecionaDesconto.Free;
    vQueryIncluiDesconto.Free;
  end;
end;

procedure Desconto_Clone_Almofada(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
var
  vQuerySelecionaDesconto, vQueryIncluiDesconto: TFDQuery;
  vQtdProdutosPromocao,vQtdContadorCampanhas: Integer;
  vPercentualDesconto, vValorProduto, vValorTotal, vValorDesconto: Double;
begin
  vQuerySelecionaDesconto := TFDQuery.Create(nil);
  vQueryIncluiDesconto := TFDQuery.Create(nil);

  vQuerySelecionaDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQueryIncluiDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;

  try
    for vQtdContadorCampanhas := 0 to Length(AInfo.TerminalBalcao) - 1 do
    begin
      vQuerySelecionaDesconto.Close;
      vQuerySelecionaDesconto.SQL.Clear;
      vQuerySelecionaDesconto.Open(
        RetornarSelectFC32110Itens(
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));

      if vQuerySelecionaDesconto.IsEmpty then
        Exit;

      vQuerySelecionaDesconto.First;
      vQtdProdutosPromocao := 0;
      while not vQuerySelecionaDesconto.Eof do
      begin
        if not(ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_CLONE_ALMOFADA)) then
          vQtdProdutosPromocao := vQtdProdutosPromocao + vQuerySelecionaDesconto.FieldValues['quant'];
        vQuerySelecionaDesconto.Next;
      end;

      case vQtdProdutosPromocao of
        1: vPercentualDesconto := 0.01;
        2: vPercentualDesconto := 10;
      else
        vPercentualDesconto := 15;   { rever isso auqi... ta certo mesmo??}
      end;

      vValorProduto := vQuerySelecionaDesconto.FieldValues['PRUNI'] * vQuerySelecionaDesconto.FieldValues['quant'];
      vValorDesconto := (vValorProduto * vPercentualDesconto) / 100;
      AValorTotal := vValorDesconto;

      vQuerySelecionaDesconto.First;

      while not vQuerySelecionaDesconto.Eof do
      begin
        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_CLONE_ALMOFADA) then
        begin
          if ATipo = tcWebService then
            PreencherJSONArrayTerminalBalcao(
              ALista,
              CAMPANHA_PRESENTES,
              vQuerySelecionaDesconto.FieldValues['tpitm'],
              vQuerySelecionaDesconto.FieldValues['cdfil'],
              vQuerySelecionaDesconto.FieldValues['cdpro'],
              vQuerySelecionaDesconto.FieldValues['nrcpm'],
              vQuerySelecionaDesconto.FieldValues['descrprd'],
              vQuerySelecionaDesconto.FieldValues['vrtot'],
              vPercentualDesconto,
              vValorDesconto,
              vQuerySelecionaDesconto.FieldValues['vrliq'])
          else
          begin
            vQueryIncluiDesconto.Close;
            vQueryIncluiDesconto.SQL.Clear;
            vQueryIncluiDesconto.ExecSQL(
              RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
                vQuerySelecionaDesconto.FieldValues['itemid'],
                vQuerySelecionaDesconto.FieldValues['operid'],
                vValorDesconto,
                vValorDesconto,
                vValorDesconto,
                0,
                0,
                vValorDesconto,
                vPercentualDesconto,
                vValorDesconto,
                '3',
                vQuerySelecionaDesconto.FieldValues['cdtml'],
                USUARIO_PROGRESSIVO_PRESENTE,
                vQuerySelecionaDesconto.FieldValues['tpitm'],
                vQuerySelecionaDesconto.FieldValues['dtope']));
            vQueryIncluiDesconto.Connection.CommitRetaining;
          end;
        end;
        vQuerySelecionaDesconto.Next;
      end;

      if ATipo = tcDesktop then
      begin
        vQuerySelecionaDesconto.Close;
        vQuerySelecionaDesconto.SQL.Clear;
        vQuerySelecionaDesconto.Open(
          RetornarSelectFC32110SomaValorLiquido(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            Now));
        vValorTotal := vQuerySelecionaDesconto.FieldValues['valor'];

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTerminalBalcaoFC32100UsuarioValores(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            0,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            USUARIO_PROGRESSIVO_PRESENTE,
            Now));
        vQueryIncluiDesconto.Connection.CommitRetaining;

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTotvsConfEnvio(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
        vQueryIncluiDesconto.Connection.CommitRetaining;
      end;
    end;
  finally
    vQuerySelecionaDesconto.Free;
    vQueryIncluiDesconto.Free;
  end;
end;

procedure Desconto_Gesso_Perfumado(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
var
  vQuerySelecionaDesconto, vQueryIncluiDesconto: TFDQuery;
  vQtdProdutosPromocao,vQtdContadorCampanhas: Integer;
  vPercentualDesconto, vValorProduto, vValorTotal, vValorDesconto: Double;
begin
  vQuerySelecionaDesconto := TFDQuery.Create(nil);
  vQueryIncluiDesconto := TFDQuery.Create(nil);

  vQuerySelecionaDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQueryIncluiDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;

  try
    for vQtdContadorCampanhas := 0 to Length(AInfo.TerminalBalcao) - 1 do
    begin
      vQuerySelecionaDesconto.Close;
      vQuerySelecionaDesconto.SQL.Clear;
      vQuerySelecionaDesconto.Open(
        RetornarSelectFC32110Itens(
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
          tiVarejo));

      if vQuerySelecionaDesconto.IsEmpty then
        Exit;

      vQuerySelecionaDesconto.First;
      vQtdProdutosPromocao := 0;
      vValorDesconto := 0;
      vValorTotal := 0;

      while not vQuerySelecionaDesconto.Eof do
      begin
        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_GESSO_PERFUMADO) then
        begin
          vQtdProdutosPromocao := vQtdProdutosPromocao + vQuerySelecionaDesconto.FieldValues['quant'];
          vValorTotal := vValorTotal + vQuerySelecionaDesconto.FieldValues['vrtot'];
          vValorDesconto := vValorDesconto + vQuerySelecionaDesconto.FieldValues['vrdsc'];
        end;
        vQuerySelecionaDesconto.Next;
      end;

      if ((vValorTotal = 0) or (vValorDesconto > 0)) then
      begin
        if ATipo = tcWebService then
          Exit
        else
        begin
          if (vValorTotal = 0) then
            raise Exception.Create('Venda não possui produto da campanha '+CAMPANHA_GESSO_PERFUMADO+'.');

          if (vValorDesconto > 0) then
            raise Exception.Create('Venda já possui desconto de campanha '+CAMPANHA_GESSO_PERFUMADO+'.');
        end;
      end;

      vPercentualDesconto := VALOR_PERCENTUAL_50;

      vValorProduto := vQuerySelecionaDesconto.FieldValues['PRUNI'] * vQuerySelecionaDesconto.FieldValues['quant'];
      vValorDesconto := (vValorProduto * vPercentualDesconto) / 100;
      AValorTotal := vValorDesconto;

      if ATipo = tcDesktop then
      begin
        if MessageDlg('Deseja confirmar desconto ('+IntToStr(VALOR_PERCENTUAL_50)+'%) de R$ ' + FloatToStr(AValorTotal) + ' relativo a Campanha '+CAMPANHA_GESSO_PERFUMADO+'?', mtconfirmation, [mbYes, MbNo], 0) = mrNo then
          Exit;
      end;

      if ((vValorDesconto <> 0) and (vQtdProdutosPromocao >= 1)) then
      begin

        vQuerySelecionaDesconto.First;
        while not vQuerySelecionaDesconto.Eof do
        begin
          if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_GESSO_PERFUMADO) then
          begin
            if ATipo = tcWebService then
              PreencherJSONArrayTerminalBalcao(
                ALista,
                CAMPANHA_GESSO_PERFUMADO,
                vQuerySelecionaDesconto.FieldValues['tpitm'],
                vQuerySelecionaDesconto.FieldValues['cdfil'],
                vQuerySelecionaDesconto.FieldValues['cdpro'],
                vQuerySelecionaDesconto.FieldValues['nrcpm'],
                vQuerySelecionaDesconto.FieldValues['descrprd'],
                vQuerySelecionaDesconto.FieldValues['vrtot'],
                vPercentualDesconto,
                vValorDesconto,
                vQuerySelecionaDesconto.FieldValues['vrliq'])
            else
            begin
              vQueryIncluiDesconto.Close;
              vQueryIncluiDesconto.SQL.Clear;
              vQueryIncluiDesconto.ExecSQL(
                RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(
                  AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
                  AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
                  vQuerySelecionaDesconto.FieldValues['itemid'],
                  vQuerySelecionaDesconto.FieldValues['operid'],
                  vValorDesconto,
                  vValorDesconto,
                  vValorDesconto,
                  0,
                  0,
                  vValorDesconto,
                  vPercentualDesconto,
                  vValorDesconto,
                  EmptyStr,
                  vQuerySelecionaDesconto.FieldValues['cdtml'],
                  USUARIO_GESSO_PERFUMADO,
                  vQuerySelecionaDesconto.FieldValues['tpitm'],
                  vQuerySelecionaDesconto.FieldValues['dtope']));
              vQueryIncluiDesconto.Connection.CommitRetaining;
            end;
          end;
          vQuerySelecionaDesconto.Next;
        end;

        if ATipo = tcDesktop then
        begin
          vQuerySelecionaDesconto.Close;
          vQuerySelecionaDesconto.SQL.Clear;
          vQuerySelecionaDesconto.Open(
            RetornarSelectFC32110SomaValorLiquido(
              AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
              AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
              Now));

          vValorTotal := vQuerySelecionaDesconto.FieldValues['valor'];

          vQueryIncluiDesconto.Close;
          vQueryIncluiDesconto.SQL.Clear;
          vQueryIncluiDesconto.ExecSQL(
            RetornarUpdateTerminalBalcaoFC32100UsuarioValores(
              AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
              AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
              0,
              vValorTotal,
              vValorTotal,
              vValorTotal,
              vValorTotal,
              USUARIO_GESSO_PERFUMADO,
              Now));
          vQueryIncluiDesconto.Connection.CommitRetaining;

          vQueryIncluiDesconto.Close;
          vQueryIncluiDesconto.SQL.Clear;
          vQueryIncluiDesconto.ExecSQL(
            RetornarUpdateTotvsConfEnvio(
              AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
              AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
          vQueryIncluiDesconto.Connection.CommitRetaining;
        end;
      end;
    end;
  finally
    vQuerySelecionaDesconto.Free;
    vQueryIncluiDesconto.Free;
  end;
end;

procedure Desconto_Vendas_Pet(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
var
  vQuerySelecionaDesconto, vQueryIncluiDesconto: TFDQuery;
  vQtdProdutosPromocao200,vQtdProdutosPromocao300,vQtdContadorCampanhas: Integer;
  vPercentualDesconto, vValorProduto, vValorTotal, vValorDesconto: Double;
  vNomeUsuarioAutorizador: string;
begin
  vQuerySelecionaDesconto := TFDQuery.Create(nil);
  vQueryIncluiDesconto := TFDQuery.Create(nil);

  vQuerySelecionaDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQueryIncluiDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;

  try
    for vQtdContadorCampanhas := 0 to Length(AInfo.TerminalBalcao) - 1 do
    begin
      vQuerySelecionaDesconto.Close;
      vQuerySelecionaDesconto.SQL.Clear;
      vQuerySelecionaDesconto.Open(
        RetornarSelectFC32110Itens(
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
          tiVarejo));

      if vQuerySelecionaDesconto.IsEmpty then
        Exit;

      vQuerySelecionaDesconto.First;
      vQtdProdutosPromocao200 := 0;
      vQtdProdutosPromocao300 := 0;
      vValorProduto := 0;
      vValorTotal := 0;

      while not vQuerySelecionaDesconto.Eof do
      begin
        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_VENDAS_PET_01) then
        begin
          vQtdProdutosPromocao200 := vQuerySelecionaDesconto.FieldValues['quant'];
          vValorProduto := vQuerySelecionaDesconto.FieldValues['pruni'];
        end else if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_VENDAS_PET_02) then
        begin
          vQtdProdutosPromocao300 := vQuerySelecionaDesconto.FieldValues['quant'];
          vValorProduto := vQuerySelecionaDesconto.FieldValues['pruni'];
        end;
        vQuerySelecionaDesconto.Next;
      end;

      if (vValorProduto < 200) then
       if (ATipo = tcDesktop) then
         raise exception.create('Valor de compra abaixo de R$ 200,00. Valor insuficiente para o brinde da '+CAMPANHA_PHARMAPET+', nessa venda. Valor Total:'+TrocaVirgulaPorPonto(FloatToStr((vValorTotal*1))))
       else if ATipo = tcWebService then
          Exit;

      if ((vQtdProdutosPromocao200 <> 0) and (vQtdProdutosPromocao300 <> 0)) then
       if (ATipo = tcDesktop) then
         raise exception.create('Escolha um dos brindes para esta venda.')
       else if ATipo = tcWebService then
          Exit;

      if ATipo = tcDesktop then
        if (vValorProduto >= 200) and (vValorProduto < 299) then
        begin
          if vQtdProdutosPromocao200 <> 1 then
            raise Exception.Create('Quantidade de brinde: KIT DE HIGIENE, incorreta. ');
          vNomeUsuarioAutorizador := USUARIO_VENDAS_PET_01;
        end
        else
        begin
          if vQtdProdutosPromocao200 <> 1 then
            raise Exception.Create('Quantidade de brinde: GARRAFA BEBEDOURO, incorreta. ');
          vNomeUsuarioAutorizador := USUARIO_VENDAS_PET_02;
        end
      else if ATipo = tcWebService then
        Exit;

      vPercentualDesconto := VALOR_PERCENTUAL_99; { rever isso auqi... ta certo mesmo??}

      vValorDesconto := vValorProduto * vPercentualDesconto;
      AValorTotal := vValorDesconto;

      if ATipo = tcDesktop then
      begin
        if MessageDlg('Deseja confirmar desconto ('+FloatToStr(VALOR_PERCENTUAL_99)+'%) de R$ ' + FloatToStr(vValorProduto) + ' relativo a Campanha '+CAMPANHA_PHARMAPET+'?', mtconfirmation, [mbYes, MbNo], 0) = mrNo then
          Exit;
      end;

      vQuerySelecionaDesconto.First;
      while not vQuerySelecionaDesconto.Eof do
      begin
        if (ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_VENDAS_PET_01)) or (ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_VENDAS_PET_02)) then
        begin
          if ATipo = tcWebService then
            PreencherJSONArrayTerminalBalcao(
              ALista,
              CAMPANHA_PHARMAPET,
              vQuerySelecionaDesconto.FieldValues['tpitm'],
              vQuerySelecionaDesconto.FieldValues['cdfil'],
              vQuerySelecionaDesconto.FieldValues['cdpro'],
              vQuerySelecionaDesconto.FieldValues['nrcpm'],
              vQuerySelecionaDesconto.FieldValues['descrprd'],
              vQuerySelecionaDesconto.FieldValues['vrtot'],
              vPercentualDesconto,
              vValorDesconto,
              vQuerySelecionaDesconto.FieldValues['vrliq'])
          else
          begin
            vQueryIncluiDesconto.Close;
            vQueryIncluiDesconto.SQL.Clear;
            vQueryIncluiDesconto.ExecSQL(
              RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
                vQuerySelecionaDesconto.FieldValues['itemid'],
                vQuerySelecionaDesconto.FieldValues['operid'],
                vValorDesconto,
                vValorDesconto,
                vValorDesconto,
                0,
                0,
                vValorDesconto,
                vPercentualDesconto,
                vValorDesconto,
                EmptyStr,
                vQuerySelecionaDesconto.FieldValues['cdtml'],
                vNomeUsuarioAutorizador,
                vQuerySelecionaDesconto.FieldValues['tpitm'],
                vQuerySelecionaDesconto.FieldValues['dtope']));
            vQueryIncluiDesconto.Connection.CommitRetaining;
          end;
        end;
        vQuerySelecionaDesconto.Next;
      end;

      if ATipo = tcDesktop then
      begin
        vQuerySelecionaDesconto.Close;
        vQuerySelecionaDesconto.SQL.Clear;
        vQuerySelecionaDesconto.Open(
          RetornarSelectFC32110SomaValorLiquido(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            Now-1));

        vValorTotal := vQuerySelecionaDesconto.FieldValues['valor'];

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTerminalBalcaoFC32100UsuarioValores(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            0,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            vNomeUsuarioAutorizador,
            Now-1));
        vQueryIncluiDesconto.Connection.CommitRetaining;

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTotvsConfEnvio(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
        vQueryIncluiDesconto.Connection.CommitRetaining;
      end;
    end;
  finally
    vQuerySelecionaDesconto.Free;
    vQueryIncluiDesconto.Free;
  end;
end;

procedure Desconto_Brinde_Compras(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
var
  vQuerySelecionaDesconto, vQueryIncluiDesconto, vQuery: TFDQuery;
  vQtdProdutosPromocao,vQtdContadorCampanhas: Integer;
  vPercentualDesconto, vValorProduto, vValorTotal, vValorDesconto, vValorCampanha: Double;
  vNomeUsuarioAutorizador: string;
begin
  vQuerySelecionaDesconto := TFDQuery.Create(nil);
  vQueryIncluiDesconto := TFDQuery.Create(nil);
  vQuery := TFDQuery.Create(nil);

  vQuerySelecionaDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQueryIncluiDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQuery.Connection := AInfo.DatabaseFDConnectionPrivilege;

  try
    for vQtdContadorCampanhas := 0 to Length(AInfo.TerminalBalcao) - 1 do
    begin
      vQuerySelecionaDesconto.Close;
      vQuerySelecionaDesconto.SQL.Clear;
      vQuerySelecionaDesconto.Open(
        RetornarSelectFC32110Itens(
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
          tiVarejo));

      if vQuerySelecionaDesconto.IsEmpty then
        Exit;

      vQuerySelecionaDesconto.First;
      vQtdProdutosPromocao := 0;
      vValorProduto := 0;
      vValorTotal := 0;

      while not vQuerySelecionaDesconto.Eof do
      begin
        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_BRINDE_COMPRA) then
          vQtdProdutosPromocao := vQtdProdutosPromocao + vQuerySelecionaDesconto.FieldValues['quant']
        else
        begin
          vQuery.Close;
          vQuery.SQL.Clear;
          vQuery.SQL.Add(
            ' select 1 ' +
            '   from brindes ' +
            '   where cdpro = ' + vQuerySelecionaDesconto.FieldByName('cdpro').asString);
          vQuery.Open;
          if vQuery.IsEmpty then // não é brinde , então pode somar ao total do tb
          begin
            // os valores dos brindes não totaliza ao valor da compra
            vValorTotal := vValorTotal + vQuerySelecionaDesconto.FieldValues['VRLIQ'];
          end;
        end;
        vQuerySelecionaDesconto.Next;
      end;

      vPercentualDesconto := VALOR_PERCENTUAL_99; { rever isso auqi... ta certo mesmo??}
      vValorCampanha := 500;

      vValorDesconto := vPercentualDesconto * 100;
      AValorTotal := vValorDesconto;

      if (vValorTotal < vValorCampanha) then
       if (ATipo = tcDesktop) then
         raise exception.create('Campanha '+CAMPANHA_BRINDES_COMPRAS+' é somente para venda com valor igual ou acima de R$ '+FloatToStr(vValorCampanha))
       else if ATipo = tcWebService then
          Exit;

      if (vQtdProdutosPromocao <> 1) then
       if (ATipo = tcDesktop) then
         raise Exception.Create('Brinde Incorreto! Para a venda com valor igual ou acima de R$ '+FloatToStr(vValorCampanha))
       else if ATipo = tcWebService then
          Exit;

      if ATipo = tcDesktop then
      begin
        if MessageDlg('Deseja confirmar desconto ('+FloatToStr(VALOR_PERCENTUAL_99)+'%) de R$ ' + FloatToStr(vValorProduto) + ' relativo a Campanha '+CAMPANHA_PHARMAPET+'?', mtconfirmation, [mbYes, MbNo], 0) = mrNo then
          Exit;
      end;

      vQuerySelecionaDesconto.First;
      while not vQuerySelecionaDesconto.Eof do
      begin
        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_BRINDE_COMPRA) then
        begin
          if ATipo = tcWebService then
            PreencherJSONArrayTerminalBalcao(
              ALista,
              CAMPANHA_BRINDES,
              vQuerySelecionaDesconto.FieldValues['tpitm'],
              vQuerySelecionaDesconto.FieldValues['cdfil'],
              vQuerySelecionaDesconto.FieldValues['cdpro'],
              vQuerySelecionaDesconto.FieldValues['nrcpm'],
              vQuerySelecionaDesconto.FieldValues['descrprd'],
              vQuerySelecionaDesconto.FieldValues['vrtot'],
              vPercentualDesconto,
              vValorDesconto,
              vQuerySelecionaDesconto.FieldValues['vrliq'])
          else
          begin
            vQueryIncluiDesconto.Close;
            vQueryIncluiDesconto.SQL.Clear;
            vQueryIncluiDesconto.ExecSQL(
              RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
                vQuerySelecionaDesconto.FieldValues['itemid'],
                vQuerySelecionaDesconto.FieldValues['operid'],
                vValorDesconto,
                vValorDesconto,
                vValorDesconto,
                0,
                0,
                vValorDesconto,
                vPercentualDesconto,
                vValorDesconto,
                EmptyStr,
                vQuerySelecionaDesconto.FieldValues['cdtml'],
                vNomeUsuarioAutorizador,
                vQuerySelecionaDesconto.FieldValues['tpitm'],
                vQuerySelecionaDesconto.FieldValues['dtope']));
            vQueryIncluiDesconto.Connection.CommitRetaining;
          end;
        end;
        vQuerySelecionaDesconto.Next;
      end;

      if ATipo = tcDesktop then
      begin
        vQuerySelecionaDesconto.Close;
        vQuerySelecionaDesconto.SQL.Clear;
        vQuerySelecionaDesconto.Open(
          RetornarSelectFC32110SomaValorLiquido(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            Now-1));

        vValorTotal := vQuerySelecionaDesconto.FieldValues['valor'];

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTerminalBalcaoFC32100UsuarioValores(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            0,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            vNomeUsuarioAutorizador,
            Now-1));
        vQueryIncluiDesconto.Connection.CommitRetaining;

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTotvsConfEnvio(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
        vQueryIncluiDesconto.Connection.CommitRetaining;
      end;
    end;
  finally
    vQuerySelecionaDesconto.Free;
    vQueryIncluiDesconto.Free;
    vQuery.Free;
  end;
end;

procedure Desconto_Stick_Bolsa_Praia(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
var
  vQuerySelecionaDesconto, vQueryIncluiDesconto: TFDQuery;
  vQtdProdutos, vQtdProdutosPromocao,vQtdContadorCampanhas: Integer;
  vPercentualDesconto, vValorProduto, vValorTotal, vValorDesconto: Double;
begin
  vQuerySelecionaDesconto := TFDQuery.Create(nil);
  vQueryIncluiDesconto := TFDQuery.Create(nil);


  vQuerySelecionaDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQueryIncluiDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;

  try
    for vQtdContadorCampanhas := 0 to Length(AInfo.TerminalBalcao) - 1 do
    begin
      vQuerySelecionaDesconto.Close;
      vQuerySelecionaDesconto.SQL.Clear;
      vQuerySelecionaDesconto.Open(
        RetornarSelectFC32110Itens(
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
          tiVarejo));

      if vQuerySelecionaDesconto.IsEmpty then
        Exit;

      vQuerySelecionaDesconto.First;
      vQtdProdutosPromocao := 0;
      vQtdProdutos := 0;
      vValorProduto := 0;

      while not vQuerySelecionaDesconto.Eof do
      begin
        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_STICK_BOLSA_PRAIA_01) then
        begin
          vQtdProdutosPromocao := vQtdProdutosPromocao + vQuerySelecionaDesconto.FieldValues['quant'];
          vValorProduto := vQuerySelecionaDesconto.FieldValues['pruni'];
        end
        else if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_STICK_BOLSA_PRAIA_02) then
          vQtdProdutos := vQtdProdutos + vQuerySelecionaDesconto.FieldValues['quant'];
        vQuerySelecionaDesconto.Next;
      end;

      if (vQtdProdutos < 2) then
        if ATipo = tcDesktop then
          raise Exception.Create('Quantidade: ' + intToStr(vQtdProdutos) + ' de produtos insuficientes para ' + CAMPANHA_STICK_BOLSA_PRAIA + ', nessa venda. ')
        else
          exit;

      if ( vQtdProdutosPromocao <> vQtdProdutos  ) then
        if ATipo = tcDesktop then
          raise Exception.Create('Quantidade de brinde da campanha ' + CAMPANHA_STICK_BOLSA_PRAIA + ', incorreta.')
        else
          exit;

      vPercentualDesconto := VALOR_PERCENTUAL_99;  { rever isso auqi... ta certo mesmo??}
      vValorDesconto := (vValorProduto * vPercentualDesconto) / 100;
      AValorTotal := vValorDesconto;

      if ATipo = tcDesktop then
      begin
        if MessageDlg('Deseja confirmar desconto ('+FloatToStr(VALOR_PERCENTUAL_99)+'%) de R$ ' + FloatToStr(vValorProduto) + ' relativo a campanha '+CAMPANHA_STICK_BOLSA_PRAIA+'?', mtconfirmation, [mbYes, MbNo], 0) = mrNo then
          Exit;
      end;

      vQuerySelecionaDesconto.First;
      while not vQuerySelecionaDesconto.Eof do
      begin
        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_STICK_BOLSA_PRAIA_01) then
        begin
          if ATipo = tcWebService then
            PreencherJSONArrayTerminalBalcao(
              ALista,
              CAMPANHA_STICK_BOLSA_PRAIA,
              vQuerySelecionaDesconto.FieldValues['tpitm'],
              vQuerySelecionaDesconto.FieldValues['cdfil'],
              vQuerySelecionaDesconto.FieldValues['cdpro'],
              vQuerySelecionaDesconto.FieldValues['nrcpm'],
              vQuerySelecionaDesconto.FieldValues['descrprd'],
              vQuerySelecionaDesconto.FieldValues['vrtot'],
              vPercentualDesconto,
              vValorDesconto,
              vQuerySelecionaDesconto.FieldValues['vrliq'])
          else
          begin
            vQueryIncluiDesconto.Close;
            vQueryIncluiDesconto.SQL.Clear;
            vQueryIncluiDesconto.ExecSQL(
              RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
                vQuerySelecionaDesconto.FieldValues['itemid'],
                vQuerySelecionaDesconto.FieldValues['operid'],
                vValorDesconto,
                vValorDesconto,
                vValorDesconto,
                0,
                0,
                vValorDesconto,
                vPercentualDesconto,
                vValorDesconto,
                EmptyStr,
                vQuerySelecionaDesconto.FieldValues['cdtml'],
                USUARIO_STICK_BOLSA_PRAIA,
                vQuerySelecionaDesconto.FieldValues['tpitm'],
                vQuerySelecionaDesconto.FieldValues['dtope']));
            vQueryIncluiDesconto.Connection.CommitRetaining;
          end;
        end;
        vQuerySelecionaDesconto.Next;
      end;

      if ATipo = tcDesktop then
      begin
        vQuerySelecionaDesconto.Close;
        vQuerySelecionaDesconto.SQL.Clear;
        vQuerySelecionaDesconto.Open(
          RetornarSelectFC32110SomaValorLiquido(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            Now-1));

        vValorTotal := vQuerySelecionaDesconto.FieldValues['valor'];

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTerminalBalcaoFC32100UsuarioValores(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            0,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            USUARIO_STICK_BOLSA_PRAIA,
            Now-1));
        vQueryIncluiDesconto.Connection.CommitRetaining;

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTotvsConfEnvio(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
        vQueryIncluiDesconto.Connection.CommitRetaining;
      end;
    end;
  finally
    vQuerySelecionaDesconto.Free;
    vQueryIncluiDesconto.Free;
  end;
end;

procedure Desconto_Carnaval_2026(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
var
  vQuerySelecionaDesconto, vQueryIncluiDesconto, vQuery: TFDQuery;
  vQtdProdutosPromocao,vQtdContadorCampanhas: Integer;
  vPercentualDesconto, vValorProduto, vValorTotal, vValorDesconto, vValorCampanha: Double;
begin
  vQuerySelecionaDesconto := TFDQuery.Create(nil);
  vQueryIncluiDesconto := TFDQuery.Create(nil);
  vQuery := TFDQuery.Create(nil);

  vQuerySelecionaDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQueryIncluiDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQuery.Connection := AInfo.DatabaseFDConnectionFormulaCerta;

  try

    if (StrToDate(FormatDateTime('dd/mm/yyyy', Now)) < StrToDate(DATA_INICIO_CAMPANHA_CARNAVAL_2026)) or (StrToDate(FormatDateTime('dd/mm/yyyy', Now)) > StrToDate(DATA_FINAL_CAMPANHA_CARNAVAL_2026)) then
      if (ATipo = tcDesktop) then
        raise exception.create('Campanha disponível apenas para o período de ' + DATA_INICIO_CAMPANHA_CARNAVAL_2026 + ' a ' + DATA_FINAL_CAMPANHA_CARNAVAL_2026)
      else if ATipo = tcWebService then
        Exit;

    for vQtdContadorCampanhas := 0 to Length(AInfo.TerminalBalcao) - 1 do
    begin
      vQuerySelecionaDesconto.Close;
      vQuerySelecionaDesconto.SQL.Clear;
      vQuerySelecionaDesconto.Open(
        RetornarSelectFC32110Itens(
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
          tiVarejo));

      if vQuerySelecionaDesconto.IsEmpty then
        Exit;

      vQuerySelecionaDesconto.First;
      vQtdProdutosPromocao := 0;
      vValorProduto := 0;
      vValorTotal := 0;

      while not vQuerySelecionaDesconto.Eof do
      begin
        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_CARNAVAL_2026) then
        begin
          vQtdProdutosPromocao := vQtdProdutosPromocao + vQuerySelecionaDesconto.FieldValues['quant'];
          vValorProduto := vQuerySelecionaDesconto.FieldValues['pruni'];
        end
        else
          vValorTotal := vValorTotal + vQuerySelecionaDesconto.FieldValues['VRLIQ'];
        vQuerySelecionaDesconto.Next;
      end;

      vPercentualDesconto := VALOR_PERCENTUAL_99;  { rever isso auqi... ta certo mesmo??}
      vValorCampanha := 200;

      vValorDesconto := (vValorProduto * vPercentualDesconto) / 100;
      AValorTotal := vValorDesconto;

      if (vValorTotal < vValorCampanha) then
       if (ATipo = tcDesktop) then
         raise exception.create('Campanha '+CAMPANHA_CARNAVAL_2026+' é somente para venda com valor igual ou acima de R$ '+FloatToStr(vValorCampanha))
       else if ATipo = tcWebService then
          Exit;

      if (vQtdProdutosPromocao <> 1) then
       if (ATipo = tcDesktop) then
         raise Exception.Create('Quantidade de brindes incorretos')
       else if ATipo = tcWebService then
          Exit;

      if ATipo = tcDesktop then
      begin
        if MessageDlg('Deseja confirmar desconto ('+FloatToStr(VALOR_PERCENTUAL_99)+'%) de R$ ' + FloatToStr(vValorProduto) + ' relativo a campanha '+CAMPANHA_CARNAVAL_2026+'?', mtconfirmation, [mbYes, MbNo], 0) = mrNo then
          Exit;
      end;

      vQuerySelecionaDesconto.First;
      while not vQuerySelecionaDesconto.Eof do
      begin
        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_CARNAVAL_2026) then
        begin
          if ATipo = tcWebService then
            PreencherJSONArrayTerminalBalcao(
              ALista,
              CAMPANHA_CARNAVAL_2026,
              vQuerySelecionaDesconto.FieldValues['tpitm'],
              vQuerySelecionaDesconto.FieldValues['cdfil'],
              vQuerySelecionaDesconto.FieldValues['cdpro'],
              vQuerySelecionaDesconto.FieldValues['nrcpm'],
              vQuerySelecionaDesconto.FieldValues['descrprd'],
              vQuerySelecionaDesconto.FieldValues['vrtot'],
              vPercentualDesconto,
              vValorDesconto,
              vQuerySelecionaDesconto.FieldValues['vrliq'])
          else
          begin
            vQueryIncluiDesconto.Close;
            vQueryIncluiDesconto.SQL.Clear;
            vQueryIncluiDesconto.ExecSQL(
              RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
                vQuerySelecionaDesconto.FieldValues['itemid'],
                vQuerySelecionaDesconto.FieldValues['operid'],
                vValorDesconto,
                vValorDesconto,
                vValorDesconto,
                0,
                0,
                vValorDesconto,
                vPercentualDesconto,
                vValorDesconto,
                EmptyStr,
                vQuerySelecionaDesconto.FieldValues['cdtml'],
                USUARIO_CARNAVAL_2026,
                vQuerySelecionaDesconto.FieldValues['tpitm'],
                vQuerySelecionaDesconto.FieldValues['dtope']));
            vQueryIncluiDesconto.Connection.CommitRetaining;
          end;
        end;
        vQuerySelecionaDesconto.Next;
      end;

      if ATipo = tcDesktop then
      begin
        vQuerySelecionaDesconto.Close;
        vQuerySelecionaDesconto.SQL.Clear;
        vQuerySelecionaDesconto.Open(
          RetornarSelectFC32110SomaValorLiquido(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            Now-1));

        vValorTotal := vQuerySelecionaDesconto.FieldValues['valor'];

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTerminalBalcaoFC32100UsuarioValores(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            0,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            USUARIO_CARNAVAL_2026,
            Now-1));
        vQueryIncluiDesconto.Connection.CommitRetaining;

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTotvsConfEnvio(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
        vQueryIncluiDesconto.Connection.CommitRetaining;
      end;
    end;
  finally
    vQuerySelecionaDesconto.Free;
    vQueryIncluiDesconto.Free;
    vQuery.Free;
  end;
end;

procedure Desconto_Campanha_Creatina_2026(out AValorTotal: Double; AInfo: TInfoDesconto; AProdutos: TList<Integer>; ATipo: TTipoChamada = tcDesktop; ALista: TJSONArray = nil);
var
  vQuerySelecionaDesconto, vQueryIncluiDesconto, vQuery: TFDQuery;
  vQtdProdutos, vQtdProdutosPromocao,vQtdContadorCampanhas: Integer;
  vPercentualDesconto, vValorProduto, vValorTotal, vValorDesconto: Double;
begin
  vQuerySelecionaDesconto := TFDQuery.Create(nil);
  vQueryIncluiDesconto := TFDQuery.Create(nil);
  vQuery := TFDQuery.Create(nil);

  vQuerySelecionaDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQueryIncluiDesconto.Connection := AInfo.DatabaseFDConnectionFormulaCerta;
  vQuery.Connection := AInfo.DatabaseFDConnectionFormulaCerta;

  try

    if (StrToDate(FormatDateTime('dd/mm/yyyy', Now)) < StrToDate(DATA_INICIO_CAMPANHA_CREATINA_2026)) then
      if (ATipo = tcDesktop) then
        raise exception.create('Campanha disponível a partir do dia ' + DATA_INICIO_CAMPANHA_CREATINA_2026 )
      else if ATipo = tcWebService then
        Exit;

    for vQtdContadorCampanhas := 0 to Length(AInfo.TerminalBalcao) - 1 do
    begin
      vQuerySelecionaDesconto.Close;
      vQuerySelecionaDesconto.SQL.Clear;
      vQuerySelecionaDesconto.Open(
        RetornarSelectFC32110Itens(
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
          AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
          tiVarejo));

      if vQuerySelecionaDesconto.IsEmpty then
        Exit;

      vQuerySelecionaDesconto.First;
      vQtdProdutosPromocao := 0;
      vValorProduto := 0;
      vQtdProdutos := 0;

      while not vQuerySelecionaDesconto.Eof do
      begin
        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_CREATINA_2026_01) then
        begin
          vQtdProdutosPromocao := vQtdProdutosPromocao + vQuerySelecionaDesconto.FieldValues['quant'];
          vValorProduto := vQuerySelecionaDesconto.FieldValues['pruni'];
        end
        else if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_CREATINA_2026_02) then
          vQtdProdutos := vQtdProdutos + vQuerySelecionaDesconto.FieldValues['quant'];
        vQuerySelecionaDesconto.Next;
      end;

      if (vQtdProdutos < 2) then
        if ATipo = tcDesktop then
          raise Exception.Create('Quantidade: ' + IntToStr(vQtdProdutos) + ' de produtos insuficientes para ' + CAMPANHA_CREATINA_2026 + ', nessa venda. ')
        else
          exit;

      if (vQtdProdutosPromocao <> vQtdProdutos) then
        if ATipo = tcDesktop then
          raise Exception.Create('Quantidade de brinde da campanha ' + CAMPANHA_CREATINA_2026 + ', incorreta.')
        else
          exit;

      vPercentualDesconto := VALOR_PERCENTUAL_99;

      vValorDesconto := (vValorProduto * vPercentualDesconto) / 100;
      AValorTotal := vValorDesconto;

      if ATipo = tcDesktop then
      begin
        if MessageDlg('Deseja confirmar desconto ('+FloatToStr(VALOR_PERCENTUAL_99)+'%) de R$ ' + FloatToStr(vValorProduto) + ' relativo a campanha '+CAMPANHA_CREATINA_2026+'?', mtconfirmation, [mbYes, MbNo], 0) = mrNo then
          Exit;
      end;

      vQuerySelecionaDesconto.First;
      while not vQuerySelecionaDesconto.Eof do
      begin
        if ExisteProduto(vQuerySelecionaDesconto.FieldByName('cdpro').AsInteger, PRODUTOS_CREATINA_2026_01) then
        begin
          if ATipo = tcWebService then
            PreencherJSONArrayTerminalBalcao(
              ALista,
              CAMPANHA_CREATINA_2026,
              vQuerySelecionaDesconto.FieldValues['tpitm'],
              vQuerySelecionaDesconto.FieldValues['cdfil'],
              vQuerySelecionaDesconto.FieldValues['cdpro'],
              vQuerySelecionaDesconto.FieldValues['nrcpm'],
              vQuerySelecionaDesconto.FieldValues['descrprd'],
              vQuerySelecionaDesconto.FieldValues['vrtot'],
              vPercentualDesconto,
              vValorDesconto,
              vQuerySelecionaDesconto.FieldValues['vrliq'])
          else
          begin
            vQueryIncluiDesconto.Close;
            vQueryIncluiDesconto.SQL.Clear;
            vQueryIncluiDesconto.ExecSQL(
              RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
                AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
                vQuerySelecionaDesconto.FieldValues['itemid'],
                vQuerySelecionaDesconto.FieldValues['operid'],
                vValorDesconto,
                vValorDesconto,
                vValorDesconto,
                0,
                0,
                vValorDesconto,
                vPercentualDesconto,
                vValorDesconto,
                EmptyStr,
                vQuerySelecionaDesconto.FieldValues['cdtml'],
                USUARIO_CREATINA_2026,
                vQuerySelecionaDesconto.FieldValues['tpitm'],
                vQuerySelecionaDesconto.FieldValues['dtope']));
            vQueryIncluiDesconto.Connection.CommitRetaining;
          end;
        end;
        vQuerySelecionaDesconto.Next;
      end;

      if ATipo = tcDesktop then
      begin
        vQuerySelecionaDesconto.Close;
        vQuerySelecionaDesconto.SQL.Clear;
        vQuerySelecionaDesconto.Open(
          RetornarSelectFC32110SomaValorLiquido(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            Now-1));

        vValorTotal := vQuerySelecionaDesconto.FieldValues['valor'];

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTerminalBalcaoFC32100UsuarioValores(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom,
            0,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            vValorTotal,
            USUARIO_CREATINA_2026,
            Now-1));
        vQueryIncluiDesconto.Connection.CommitRetaining;

        vQueryIncluiDesconto.Close;
        vQueryIncluiDesconto.SQL.Clear;
        vQueryIncluiDesconto.ExecSQL(
          RetornarUpdateTotvsConfEnvio(
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Filial,
            AInfo.TerminalBalcao[vQtdContadorCampanhas].Cupom));
        vQueryIncluiDesconto.Connection.CommitRetaining;
      end;
    end;
  finally
    vQuerySelecionaDesconto.Free;
    vQueryIncluiDesconto.Free;
    vQuery.Free;
  end;
end;


{$ENDREGION}

end.
