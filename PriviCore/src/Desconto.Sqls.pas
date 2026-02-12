unit Desconto.Sqls;

interface

uses Desconto.Tipos,  System.Generics.Collections;


{$REGION ' UPDATES'}
// tabela: totvsConf
function RetornarUpdateTotvsConfEnvio(AFilial, ACupom: Integer): string;

// tabela: campanha
function RetornarUpdateCampanhaSaldo(AIDCampanha: Integer; AValorSaldo: Double): string;

// tabela: fc32100 - cabecalho terminal balcao
function RetornarUpdateTerminalBalcaoFC32100UsuarioValores(AFilial, ACupom, AIDCampanha : Integer; AValorLiquido, AValorArc, AValorCaixa, AValorTotal: Double; AUsuarioAutorizado: string; ADataOperacao: TDate): string;

// tabela: fc32200 - balcao receita
function RetornarUpdateBalcaoReceitasFC32200TipoDescontoValores(AFilial, ACupom, ACodigoItem, ACodigoOperacao: Integer; AValorLiquido, AValorSaldo, AValorDesconto: Double; ATipoDesconto, AUsuarioAutorizado, ACodigoTerminal: string; ADataOperacao: TDate): string;
function RetornarUpdateBalcaoReceitasFC32200ValorCaixa(AFilial, ACupom, ACodigoItem, ACodigoOperacao: Integer; AValorCaixa: Double; ACodigoTerminal, ATipoPagamento: string; ADataOperacao: TDate): string;

// tabela: fc32110 - itens terminal balcao
function RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(AFilial, ACupom, ACodigoItem, ACodigoOperacao: Integer; AValorLiquido, AValorCaixa, ABaseCalculoICM, AValorTotal, APrecoUnitario, APrecoUnitarioLiq, APercentualDesc, AValorDesconto: Double; ATipoDesconto, ACodigoTerminal, ANomePaciente, ATipoItem: string; ADataOperacao: TDate): string;
{$ENDREGION}

{$REGION ' SELECTS'}

// tabela: fc03000 - produtos
function RetornarSelectFC03000Produtos(AProdutos: TList<Integer>; APercentual: Double): string;

// tabela: fc15000 - orcamentos
function RetornarSelectFC15000OrcamentosCampanhas(ACpf: Int64): string;

// tabela: campanhas - descontos
function RetornarSelectDescontoCampanhas(ATelefone: Int64): string; overload;
function RetornarSelectDescontoCampanhas(ATelefone, ACpf: Int64): string; overload;



// tabela: descfranquias - quantidade e valor
function RetornarSelectDescontoFranquiaQuantidadeValor(ACpf: Integer): string;

// tabela: fc12110 - itens receita
function RetornarSelectFC12110QuantidadeExistente(AFilial, ACupom: Integer; AArrayItens: string): string;

// tabela: fc32110 - itens terminal balcao
function RetornarSelectFC32110SomaValorLiquido(AFilial, ACupom: Integer; ADataOperacao: TDate): string;
function RetornarSelectFC32110ItensVarejo(AFilial, ACupom: Integer): string;
function RetornarSelectFC32110Itens(AFilial, ACupom: Integer; ATipoItem: TTipoItem = tiAmbos): string;
function RetornarSelectFC32110ItensFormulaVarejo(AFilial, ACupom: Integer; ATipoItem: TTipoItem = tiAmbos): string;

// tabela: fc32200 - balcao receita
function RetornarSelectBalcaoReceitasFC32200ValorCaixa(AFilial, ACupom, ACodigoItem, ACodigoOperacao: Integer; ACodigoTerminal: string; ADataOperacao: TDate): string;
{$ENDREGION}

implementation

uses System.SysUtils, Desconto.Utils, Desconto.Constantes.Usuarios;

function RetornarSelectFC03000Produtos( AProdutos: TList<Integer>; APercentual: Double): string;
var
  vSQL, vProdutos: string;
  FS: TFormatSettings;
  Arr: TArray<string>;
  I: Integer;
begin
  FS := TFormatSettings.Invariant;

  if AProdutos.Count = 0 then
    Exit('select 1 from rdb$database where 1 = 0');

  SetLength(Arr, AProdutos.Count);
  for I := 0 to AProdutos.Count - 1 do
    Arr[I] := AProdutos[I].ToString;

  vProdutos := string.Join(',', Arr);

  vSQL :=
    ' select prd.cdpro, ' +
    '        prd.cdpro as produto, ' +
    '        1 as quant, ' +
    '        prd.descr as descricao, ' +
    '        prd.prven as pruni, ' +
    '        ''V'' as tpitm, ' +
//    '        prd.prven as valor_total, ' +
    '        ' + FloatToStr(APercentual, FS) + ' as percentual_desconto, ' +
    '        (prd.prven * ' + FloatToStr(APercentual, FS) + ' / 100) as valor_desconto, ' +
    '        (prd.prven - (prd.prven * ' + FloatToStr(APercentual, FS) + ' / 100)) as valor_liquido ' +
    ' from fc03000 prd ' +
    ' where 1 = 1 ' +
    '   and cdpro in (' + vProdutos + ') ' +
    '   and situa = ''A'' ' +
    '   and indinsumo = ''N'' ';

  Result := vSQL;
end;


function RetornarSelectFC15000OrcamentosCampanhas(ACpf: Int64): string;
var
  vSQL: string;
begin
  vSQL :=
    '	     	select orc.cdfil, ' +
    '	     	       orc.nrorc, ' +
    '	     	       orc.vrrqu ' +
    '	     	  from fc15000 orc ' +
    '	  inner join fc07000 cli ' +
    '	          on orc.cdcli = cli.cdcli ' +
    '	       where 1 = 1 ' +
    '	         and cli.nrcnpj = ' + QuotedStr(IntToStr(ACpf).PadLeft(11, '0')) +
    '	         and orc.vrdsc = 0 ' +
    '	     	   and orc.flagenv = ''N'' ' +
    '	    	   and orc.dtentr >= current_date-1 ' ;

  Result := vSQL;
end;

function RetornarSelectDescontoCampanhas(ATelefone: Int64): string;
var
  vSQL: string;
begin
  // Novo cenário: sempre por telefone
  vSQL :=
    '	     select cc.cpfcli, ' +
    '	            cc.ddd, ' +
    '	            cc.celular, ' +
    '	            cast(cast(nomecli as varchar(120) character set win1252) as varchar(120)) as nomecli, ' +
    '		          c.idcamp, ' +
    '	            c.nomecampanha, ' +
    '	            c.verificasaldo, ' +
    '	            c.saldo, ' +
    '	            c.dtvalidade, ' +
    '	            upper(c.tpdesc) as tpdesc, ' +
    '	            case upper(c.tpdesc) ' +
    '	       	      when ''P'' then ''Percentual'' ' +
    '	       	      else ''Valor'' ' +
    '	            end as TipoDesconto, ' +
    '		       	  case upper(c.tpdesc) ' +
    '		 	      	  when ''P'' then 0 ' +
    '			      	  else round(percvar,2) ' +
    '		       	  end as ValorVarejo, ' +
    '		       	  case upper(c.tpdesc) ' +
    '		 	      	  when ''P'' then 0 ' +
    '			      	  else round(percfor, 2) ' +
    '		       	  end as ValorFormula, ' +
    '		      	  case upper(c.tpdesc) ' +
    '	       	  	 	when ''V'' then 0 ' +
    '		      	  	else round(percvar) ' +
    '		       	  end as PercentualVarejo, ' +
    '		       	  case upper(c.tpdesc) ' +
    '		 	      	  when ''V'' then 0 ' +
    '			      	  else round(percfor) ' +
    '	          	end as PercentualFormula ' +
    '	       from campanhasclientes cc ' +
    '  inner join campanhas c ' +
    '          on c.idcamp = cc.idcamp ' +
    '	      where 1 = 1 ' +
    '	        and (coalesce(cc.dtvalidade, current_date) >= current_date) ' +
    '	        and (coalesce(c.dtvalidade, current_date) >= current_date) ' +
    '	        and (cc.ddd||cc.celular = ' + QuotedStr(IntToStr(ATelefone)) + ')';

  Result := vSQL;
end;

function RetornarSelectDescontoCampanhas(ATelefone, ACpf: Int64): string;
begin
  // Mantém compatibilidade: se vier telefone usa telefone, senão cai no CPF (legado)
  if ATelefone > 0 then
    Result := RetornarSelectDescontoCampanhas(ATelefone)
  else
  begin
    // fallback legado por CPF (se ainda existir alguma chamada antiga)
    Result :=
      '	     select cc.cpfcli, ' +
      '	            cc.ddd, ' +
      '	            cc.celular, ' +
      '	            cast(cast(nomecli as varchar(120) character set win1252) as varchar(120)) as nomecli, ' +
      '		          c.idcamp, ' +
      '	            c.nomecampanha, ' +
      '	            c.verificasaldo, ' +
      '	            c.saldo, ' +
      '	            c.dtvalidade, ' +
      '	            upper(c.tpdesc) as tpdesc, ' +
      '	            case upper(c.tpdesc) ' +
      '	       	      when ''P'' then ''Percentual'' ' +
      '	       	      else ''Valor'' ' +
      '	            end as TipoDesconto, ' +
      '		       	  case upper(c.tpdesc) ' +
      '		 	      	  when ''P'' then 0 ' +
      '			      	  else round(percvar,2) ' +
      '		       	  end as ValorVarejo, ' +
      '		       	  case upper(c.tpdesc) ' +
      '		 	      	  when ''P'' then 0 ' +
      '			      	  else round(percfor, 2) ' +
      '		       	  end as ValorFormula, ' +
      '		      	  case upper(c.tpdesc) ' +
      '	       	  	 	when ''V'' then 0 ' +
      '		      	  	else round(percvar) ' +
      '		       	  end as PercentualVarejo, ' +
      '		       	  case upper(c.tpdesc) ' +
      '		 	      	  when ''V'' then 0 ' +
      '			      	  else round(percfor) ' +
      '	          	end as PercentualFormula ' +
      '	       from campanhasclientes cc ' +
      '  inner join campanhas c ' +
      '          on c.idcamp = cc.idcamp ' +
      '	      where 1 = 1 ' +
      '	        and (coalesce(cc.dtvalidade, current_date) >= current_date) ' +
      '	        and (coalesce(c.dtvalidade, current_date) >= current_date) ' +
      '	        and (cc.cpfcli = ' + QuotedStr(IntToStr(ACpf)) + ')';
  end;
end;

function RetornarSelectDescontoFranquiaQuantidadeValor(ACpf: Integer): string;
var
  vSQL: string;
begin
  vSQL :=
    '   select count(*) as qtd,cpf,descpform,descpvar,nome ' +
    '     from descfranquias ' +
    '    where cpf = ' + IntToStr(ACpf) +
    ' group by cpf,descpform,descpvar,nome ' ;
  Result:= vSQL;
end;

function RetornarSelectFC12110QuantidadeExistente(AFilial, ACupom: Integer; AArrayItens: string): string;
var
  vSQL: string;
begin
  vSQL :=
            ' select count(*) as quant ' +
            '   from fc12110 ' +
            '  where cdfil=' + inttostr(AFilial) +
            '    and nrrqu=' + inttostr(ACupom) +
            '    and cdprin in (' + AArrayItens + ')';
  Result:= vSQL;
end;

function RetornarUpdateCampanhaSaldo(AIDCampanha: Integer; AValorSaldo: Double): string;
var
  vSQL: string;
begin
    { CAMPOS QUE IRAO SOFRER ALTERACAO        }
    {---------------------------------------- }
    { CAMPO     | PARAMETRO         | TIPO    }
    {---------------------------------------- }
    { saldo     | AValorSaldo        | Double }

    { CAMPOS DE CONDICIONAIS                  }
    {---------------------------------------- }
    { CAMPO     | PARAMETRO         | TIPO    }
    {---------------------------------------- }
    { idcamp     | AIDCampanha      | integer }

    vSQL :=
      ' update campanhas ' +
      '    set saldo =  ' + TrocaVirgulaPorPonto(FloatToStr(AValorSaldo)) +
      '  where idcamp =' + QuotedStr(IntToStr(AIDCampanha));

  Result := vSQL;
end;

function RetornarUpdateTerminalBalcaoFC32100UsuarioValores(AFilial, ACupom, AIDCampanha : Integer; AValorLiquido, AValorArc, AValorCaixa, AValorTotal: Double; AUsuarioAutorizado: string; ADataOperacao: TDate): string;
var
  vIDCampanha, vSQL: string;
begin
    { CAMPOS QUE IRAO SOFRER ALTERACAO        }
    {---------------------------------------- }
    { CAMPO     | PARAMETRO         | TIPO    }
    {---------------------------------------- }
    { destnf    | AIDCampanha        | integer}
    { useridaut | AUsuarioAutorizado | string }
    { vrtot     | AValorTotal        | Double }
    { vrliq     | AValorLiquido      | Double }
    { vrcxa     | AValorCaixa        | Double }
    { vrarc     | AValorArc          | Double }

    { CAMPOS DE CONDICIONAIS                  }
    {---------------------------------------- }
    { CAMPO     | PARAMETRO         | TIPO    }
    {---------------------------------------- }
    { cdfil     | AFilial           | integer }
    { dtope     | ADataOperacao     | date    }
    { nrcpm     | ACupom            | integer }

  if AUsuarioAutorizado = USUARIO_PRIV_CAMPANHA then
    vIDCampanha := '        ,destnf = ' + IntToStr(AIDCampanha)
  else
  vIDCampanha := EmptyStr;

  vSQL :=
    ' update fc32100 '+
    '    set useridaut=' + QuotedStr(AUsuarioAutorizado) + ', '+
    '        vrtot=' + TrocaVirgulaPorPonto(FloatToStr(AValorTotal)) + ', '+
    '        vrliq=VRTXAG+' + TrocaVirgulaPorPonto(FloatToStr(AValorLiquido)) + ', '+
    '        vrcxa=VRTXAG+' + TrocaVirgulaPorPonto(FloatToStr(AValorCaixa)) + ', '+
    '        vrarc=VRTXAG+' + TrocaVirgulaPorPonto(FloatToStr(AValorArc))+
    vIDCampanha +
    '  where cdfil=' + IntToStr(AFilial)+
    '    and nrcpm=' + IntToStr(ACupom)+
    '    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', ADataOperacao));
  Result := vSQL;
end;

function RetornarSelectFC32110SomaValorLiquido(AFilial, ACupom: Integer; ADataOperacao: TDate): string;
var
  vSQL: string;
begin

  vSQL :=
    ' select sum(vrliq) as valor ' +
    '   from fc32110 ' +
    '  where cdfil     = ' + IntToStr(AFilial)+
    '    and dtope     = ' + QuotedStr(FormatDateTime('dd.mm.yyyy', ADataOperacao))+
    '    and nrcpm     = ' + IntToStr(ACupom);

  Result := vSQL;
end;
function RetornarSelectFC32110ItensFormulaVarejo(AFilial, ACupom: Integer; ATipoItem: TTipoItem): string;
var
  vTipoItem, vSQL: string;
begin
  if ATipoItem = tiFormula then
    vTipoItem := '       and a.tpitm = ' + QuotedStr('R')
  else if ATipoItem = tiVarejo then
    vTipoItem := '       and a.tpitm = ' + QuotedStr('V')
  else
  vTipoItem := EmptyStr;

  vSQL :=
    '    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDPRO, a.CDFILR, a.QUANT, a.PRUNI, ' +
    '           a.PTDSC, a.TPDSC, a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, ' +
    '           coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ' +
    '      from fc32110 a ' +
    ' left join fc32200 b on ( ' +
    '           a.cdfil=b.cdfil ' +
    '       and a.cdtml=b.cdtml ' +
    '       and a.dtope = b.dtope ' +
    '       and a.operid=b.operid ' +
    '       and a.nrcpm=b.nrcpm ' +
    '       and a.itemid=b.itemid ) ' +
    '     where a.cdfil=' + IntToStr(AFilial) +
    '       and a.nrcpm=' + IntToStr(ACupom) +
    vTipoItem +
    '       and a.dtope >= (current_date -1) '+
    '  order by a.VRTOT DESC ';
  Result := vSQL;
end;

function RetornarSelectFC32110Itens(AFilial, ACupom: Integer; ATipoItem: TTipoItem = tiAmbos): string;
var
  vTipoItem, vSQL: string;
begin

  if ATipoItem = tiFormula then
    vTipoItem := '          and fc321.tpitm = ' + QuotedStr('R')
  else if ATipoItem = tiVarejo then
    vTipoItem := '          and fc321.tpitm = ' + QuotedStr('V')
  else
  vTipoItem := EmptyStr;

  vSQL :=
    '       select fc321.cdfil, ' +
    '              fc321.cdtml, ' +
    '              fc321.dtope, ' +
    '              fc321.operid, ' +
    '              fc321.idpromo, ' +
    '              fc321.nrcpm, ' +
    '              fc321.itemid, ' +
    '              fc321.tpitm, ' +
    '              fc321.cdfilr, ' +
    '              fc321.cdpro, ' +
    '              coalesce( ' +
    '                 max(fc030.descr), ' +
    '                 ''FÓRMULA MANIPULADA (À VISTA)'' ' +
    '              ) as descrprd, ' +
    '              sum(fc321.quant) as quant, ' +
    '              sum(fc321.pruni) as pruni, ' +
    '              coalesce( ' +
    '                      nullif(max(fc322.ptdsc), 0), ' +
    '                      nullif(max(fc321.ptdsc), 0), ' +
    '                      ( ' +
    '                          coalesce(sum(fc322.vrdsc), sum(fc321.vrdsc)) ' +
    '                          / nullif( ' +
    '                              sum(fc321.quant * fc321.vrliq) ' +
    '                              + coalesce(sum(fc322.vrdsc), sum(fc321.vrdsc)), ' +
    '                              0 ' +
    '                          ) ' +
    '                      ) * 100 ' +
    '                  ) as ptdsc, ' +
    '              coalesce(max(fc322.tpdsc),  max(fc321.tpdsc))  as tpdsc, ' +
    '              coalesce(max(fc322.tpdscg), max(fc321.tpdscg)) as tpdscg, ' +
    '              coalesce(max(fc322.tppag),  max(fc321.tppag))  as tppag, ' +
    '              coalesce(sum(fc322.vrdsc),  sum(fc321.vrdsc))  as vrdsc, ' +
    '              coalesce(sum(fc322.vrliq),  sum(fc321.vrliq))  as vrliq, ' +
    '              coalesce(sum(fc322.vrcxa),  sum(fc321.vrcxa))  as vrcxa, ' +
    '              coalesce(sum(fc322.vrdscg), sum(fc321.vrdscg)) as vrdscg, ' +
    '              coalesce(sum(fc322.vrtxag), sum(fc321.vrtxag)) as vrtxag, ' +
    '              coalesce(sum(fc322.vrtxa),  sum(fc321.vrtxa))  as vrtxa, ' +
    '              coalesce(sum(fc322.vrtot),  sum(fc321.vrtot))  as vrtot, ' +
    '              coalesce(max(fc322.cdtxag), max(fc321.cdtxag)) as cdtxag, ' +
    '              coalesce(max(fc322.cdtxa),  max(fc321.cdtxa))  as cdtxa, ' +
    '              max(fc321.vrdscv)  as vrdscv, ' +
    '              max(fc321.vrtxav)  as vrtxav, ' +
    '              max(fc321.bcicm)   as bcicm, ' +
    '              max(fc321.vricm)   as vricm ' +
    '         from fc32110 fc321 ' +
    '    left join fc03000 fc030 ' +
    '           on fc321.cdpro = fc030.cdpro ' +
    '          and fc321.tpitm = ''V'' ' +
    '    left join fc32200 fc322 ' +
    '           on fc321.cdfil  = fc322.cdfil ' +
    '          and fc321.cdtml  = fc322.cdtml ' +
    '          and fc321.dtope  = fc322.dtope ' +
    '          and fc321.operid = fc322.operid ' +
    '          and fc321.nrcpm  = fc322.nrcpm ' +
    '          and fc321.itemid = fc322.itemid ' +
    '          and fc321.tpitm  = ''R'' ' +
    '        where fc321.dtope >= current_date - 1 ' +
    '          and fc321.cdfil = ' + IntToStr(AFilial) +
    '          and fc321.nrcpm = ' + IntToStr(ACupom) +
    vTipoItem +
    '     group by fc321.cdfil, ' +
    '              fc321.cdtml, ' +
    '              fc321.dtope, ' +
    '              fc321.operid, ' +
    '              fc321.idpromo, ' +
    '              fc321.nrcpm, ' +
    '              fc321.itemid, ' +
    '              fc321.tpitm, ' +
    '              fc321.cdfilr, ' +
    '              fc321.cdpro ' ;

  Result := vSQL;
 end;

function RetornarSelectFC32110ItensVarejo(AFilial, ACupom: Integer): string;
var
  vSQL: string;
begin
  vSQL :=
    '    select f10.cdfil, ' +
    '	          f10.nrcpm, ' +
    '	          f10.cdpro, ' +
    '	          sum(f10.quant) as qtd, ' +
    '	          f10.pruni, ' +
    '	          sum(vrdsc) as vrdsc, ' +
    '	          f03.descr as descrprd, ' +
    '	          sum(f10.quant * f10.vrliq) as vrliq, ' +
    '	          sum(f10.vrliq + f10.vrdsc) as semdesconto, ' +
    '	          ((sum(f10.vrdsc) / nullif( sum((f10.quant * f10.vrliq) + f10.vrdsc), 0 )) * 100) as ptdsc, ' +
    '	          f10.idpromo, ' +
    '	          f10.cdtml, ' +
    '	          f10.operid, ' +
    '	          f10.itemid ' +
    '      from fc32110 f10 ' +
    'inner join fc03000 f03 ' +
    '        on f10.cdpro = f03.cdpro ' +
    '     where f10.tpitm = ' + QuotedStr('V')+
    '	      and f10.cdfil = ' + IntToStr(AFilial)+
    '	      and f10.nrcpm = ' + IntToStr(ACupom)+
    '  group by f10.cdfil, ' +
    '	          f10.nrcpm, ' +
    '	          f10.cdpro, ' +
    '	          f10.pruni, ' +
    '	          f03.descr, ' +
    '	          f10.idpromo, ' +
    '	          f10.cdtml, ' +
    '	          f10.operid, ' +
    '	          f10.itemid ' ;
  Result := vSQL;
end;

function RetornarUpdateTotvsConfEnvio(AFilial, ACupom: Integer): string;
var
  vSQL: string;
begin

    { CAMPOS QUE IRAO SOFRER ALTERACAO   }
    {----------------------------------- }
    { CAMPO     | PARAMETRO     | TIPO   }
    {----------------------------------- }
    { env       | N/A           | String }

    { CAMPOS DE CONDICIONAIS             }
    {----------------------------------- }
    { CAMPO     | PARAMETRO    | TIPO    }
    {----------------------------------- }
    { cdfil     | AFilial      | integer }
    { nrcpm     | ACupom       | integer }

  vSQL :=
    ' update totvsconf '+
    '    set env   = ' + QuotedStr('N')+
    '  where fil   = ' + IntToStr(AFilial)+
    '    and cupom = ' + IntToStr(ACupom);
  Result := vSQL;
end;

function RetornarUpdateBalcaoReceitasFC32200TipoDescontoValores(AFilial, ACupom, ACodigoItem, ACodigoOperacao: Integer; AValorLiquido, AValorSaldo, AValorDesconto: Double; ATipoDesconto, AUsuarioAutorizado, ACodigoTerminal: string; ADataOperacao: TDate): string;
var
  vSQL: string;
begin

    { CAMPOS QUE IRAO SOFRER ALTERACAO        }
    {---------------------------------------- }
    { CAMPO     | PARAMETRO         | TIPO    }
    {---------------------------------------- }
    { tpdsc     | ATipoDesconto      | String }
    { vrliq     | AValorLiquido      | Double }
    { vrsdo     | AValorSaldo        | Double }
    { vrdsc     | AValorDesconto     | Double }
    { useridaut | AUsuarioAutorizado | String }

    { CAMPOS DE CONDICIONAIS                  }
    {---------------------------------------- }
    { CAMPO     | PARAMETRO         | TIPO    }
    {---------------------------------------- }
    { cdfil     | AFilial           | integer }
    { cdtml     | ACodigoTerminal   | string  }
    { dtope     | ADataOperacao     | date    }
    { operid    | ACodigoOperacao   | integer }
    { nrcpm     | ACupom            | integer }
    { itemid    | ACodigoItem       | integer }


  vSQL :=
    ' update fc32200 ' +
    '    set tpdsc     = ' + QuotedStr(ATipoDesconto) + ', '+
    '        vrliq     = vrtot+vrtxa-' + TrocaVirgulaPorPonto(floattostr(AValorLiquido)) + ', '+
    '        vrsdo     = vrtot+vrtxa-vrrcb-' + TrocaVirgulaPorPonto(floattostr(AValorDesconto)) + ', '+
    '        vrdsc     = ' + TrocaVirgulaPorPonto(floattostr(AValorDesconto)) + ', '+
    '        useridaut = ' + QuotedStr(AUsuarioAutorizado)+
    '  where cdfil     = ' + IntToStr(AFilial)+
    '    and cdtml     = ' + QuotedStr(ACodigoTerminal)+
    '    and dtope     = ' + QuotedStr(FormatDateTime('dd.mm.yyyy', ADataOperacao))+
    '    and operid    = ' + IntToStr(ACodigoOperacao)+
    '    and nrcpm     = ' + IntToStr(ACupom)+
    '    and itemid    = ' + IntToStr(ACodigoItem);
  Result := vSQL;
end;

function RetornarUpdateBalcaoReceitasFC32200ValorCaixa(AFilial, ACupom, ACodigoItem, ACodigoOperacao: Integer; AValorCaixa: Double; ACodigoTerminal, ATipoPagamento: string; ADataOperacao: TDate): string;
var
  vTipoValor, vSQL: string;
begin

    { CAMPOS QUE IRAO SOFRER ALTERACAO        }
    {---------------------------------------- }
    { CAMPO     | PARAMETRO         | TIPO    }
    {---------------------------------------- }
    { vrliq     | AValorLiquido      | Double }

    { CAMPOS DE CONDICIONAIS                  }
    {---------------------------------------- }
    { CAMPO     | PARAMETRO         | TIPO    }
    {---------------------------------------- }
    { cdfil     | AFilial           | integer }
    { cdtml     | ACodigoTerminal   | string  }
    { dtope     | ADataOperacao     | date    }
    { operid    | ACodigoOperacao   | integer }
    { nrcpm     | ACupom            | integer }
    { itemid    | ACodigoItem       | integer }

  if ATipoPagamento = '1' then
    vTipoValor := '    set vrcxa = vrtot+vrtxa-'+ TrocaVirgulaPorPonto(floattostr(AValorCaixa))
  else
    vTipoValor := '    set vrcxa = vrrcb ';

  vSQL :=
    ' update fc32200 ' +
    vTipoValor +
    '  where cdfil     = ' + IntToStr(AFilial)+
    '    and cdtml     = ' + QuotedStr(ACodigoTerminal)+
    '    and dtope     = ' + QuotedStr(FormatDateTime('dd.mm.yyyy', ADataOperacao))+
    '    and operid    = ' + IntToStr(ACodigoOperacao)+
    '    and nrcpm     = ' + IntToStr(ACupom)+
    '    and itemid    = ' + IntToStr(ACodigoItem);
  Result := vSQL;
end;

function RetornarSelectBalcaoReceitasFC32200ValorCaixa(AFilial, ACupom, ACodigoItem, ACodigoOperacao: Integer; ACodigoTerminal: string; ADataOperacao: TDate): string;
var
  vSQL: string;
begin

  vSQL :=
    ' select vrcxa ' +
    '   from fc32200 ' +
    '  where cdfil     = ' + IntToStr(AFilial)+
    '    and cdtml     = ' + QuotedStr(ACodigoTerminal)+
    '    and dtope     = ' + QuotedStr(FormatDateTime('dd.mm.yyyy', ADataOperacao))+
    '    and operid    = ' + IntToStr(ACodigoOperacao)+
    '    and nrcpm     = ' + IntToStr(ACupom)+
    '    and itemid    = ' + IntToStr(ACodigoItem);
  Result := vSQL;
end;

function RetornarUpdateItensTerminalBalcaoFC32110TipoDescontoValores(AFilial, ACupom, ACodigoItem, ACodigoOperacao: Integer; AValorLiquido, AValorCaixa, ABaseCalculoICM, AValorTotal, APrecoUnitario, APrecoUnitarioLiq, APercentualDesc, AValorDesconto: Double; ATipoDesconto, ACodigoTerminal, ANomePaciente, ATipoItem: string; ADataOperacao: TDate): string;
var
  vUpdate, vSQL: string;
begin

    { CAMPOS QUE IRAO SOFRER ALTERACAO        }
    {---------------------------------------- }
    { CAMPO     | PARAMETRO         | TIPO    }
    {---------------------------------------- }
    { tpdsc     | ATipoDesconto      | String }
    { tpitm     | ATipoItem          | String }
    { vrliq     | AValorLiquido      | Double }
    { vrcxa     | AValorCaixa        | Double }
    { bcicm     | ABaseCalculoICM    | Double }
    { nomepa    | ANomePaciente      | String }
    { vrtot     | AValorTotal        | Double }
    { pruni     | APrecoUnitario     | Double }
    { pruniliq  | APrecoUnitarioLiq  | Double }
    { ptdsc     | APercentualDesc    | Double }
    { vrdsc     | AValorDesconto     | Double }

    { CAMPOS DE CONDICIONAIS                  }
    {---------------------------------------- }
    { CAMPO     | PARAMETRO         | TIPO    }
    {---------------------------------------- }
    { cdfil     | AFilial           | integer }
    { cdtml     | ACodigoTerminal   | string  }
    { dtope     | ADataOperacao     | date    }
    { operid    | ACodigoOperacao   | integer }
    { nrcpm     | ACupom            | integer }
    { itemid    | ACodigoItem       | integer }

  if ATipoItem = 'R' then
    vUpdate :=
      '        vrtot     = ' + TrocaVirgulaPorPonto(FloatToStr(AValorTotal)) + ', '+
      '        pruni     = ' + TrocaVirgulaPorPonto(FloatToStr(APrecoUnitario)) + ', '+
      '        pruniliq  = ' + TrocaVirgulaPorPonto(FloatToStr(APrecoUnitarioLiq)) + '/QUANT, '+
      '        vrcxa     = ' + TrocaVirgulaPorPonto(FloatToStr(AValorCaixa)) + ', '+
      '        vrliq     = ' + TrocaVirgulaPorPonto(FloatToStr(AValorLiquido)) + ', '+
      '        bcicm     = ' + TrocaVirgulaPorPonto(FloatToStr(ABaseCalculoICM)) + ', '
  else
    vUpdate :=
      '        ptdsc     = ' + TrocaVirgulaPorPonto(floattostr(APercentualDesc)) + ' , '+
      '        pruniliq  = pruniliq-(' + TrocaVirgulaPorPonto(floattostr(APrecoUnitarioLiq)) + '/QUANT), '+
      '        vrcxa     = vrcxa-' + TrocaVirgulaPorPonto(floattostr(AValorCaixa)) + ', '+
      '        vrliq     = vrliq-' + TrocaVirgulaPorPonto(floattostr(AValorLiquido)) + ', '+
      '        vrdsc     = ' + TrocaVirgulaPorPonto(floattostr(AValorDesconto)) + ', '+
      '        bcicm     = vrtxav+vrliq-' + TrocaVirgulaPorPonto(floattostr(ABaseCalculoICM)) + ', ';

  vSQL :=
    ' update fc32110 ' +
    '    set tpdsc     = ' + QuotedStr(ATipoDesconto) + ', '+
    vUpdate +
    '        nomepa    = ' + QuotedStr(ANomePaciente)+
    '  where cdfil     = ' + IntToStr(AFilial)+
    '    and cdtml     = ' + QuotedStr(ACodigoTerminal)+
    '    and dtope     = ' + QuotedStr(FormatDateTime('dd.mm.yyyy', ADataOperacao))+
    '    and operid    = ' + IntToStr(ACodigoOperacao)+
    '    and nrcpm     = ' + IntToStr(ACupom)+
    '    and itemid    = ' + IntToStr(ACodigoItem);
  Result := vSQL;
end;

end.
