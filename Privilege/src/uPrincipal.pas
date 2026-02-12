unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Math, midaslib, Dialogs, StdCtrls, ComCtrls, Grids, DBGrids, DB, ExtCtrls,
  Buttons, dateutils, clipbrd, Menus, IBCustomDataSet, IBQuery, sSkinProvider,
  sSkinManager, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  UITypes, Desconto.Tipos;

type
  TfrmPrincipal = class(TForm)
    pnlPrincipal: TPanel;
    dsDbgrid: TDataSource;
    dbgTerminal: TDBGrid;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    edtTerminalBalcao: TEdit;
    Panel1: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btInsereDesconto: TSpeedButton;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    lblBalcao: TLabel;
    lblDesconto: TLabel;
    lblFinal: TLabel;
    Image1: TImage;
    MainMenu1: TMainMenu;
    Relatrios1: TMenuItem;
    DescontosConcedidos1: TMenuItem;
    qryTerminalBalcao: TIBQuery;
    TimerAbertura: TTimer;
    TimerHorario: TTimer;
    Administrao1: TMenuItem;
    CodBarrasFuncionarios1: TMenuItem;
    Arquivo1: TMenuItem;
    Solicitao1: TMenuItem;
    gbsubDesc: TGroupBox;
    cbDescontoTipo: TComboBox;
    SolicitaesAbertas1: TMenuItem;
    ConfigAlertas1: TMenuItem;
    edtLoja: TEdit;
    ControledeCartes1: TMenuItem;
    Label4: TLabel;
    rgtpDesc: TRadioGroup;
    lblDescontoValor: TLabel;
    lblDescontoValorBioneov: TLabel;
    lblDescontovarejo: TLabel;
    ImprimirCodBarras1: TMenuItem;
    lblValorVarejo: TLabel;
    qrySelecionaDesconto: TIBQuery;
    qryFcertaTEMP: TIBQuery;
    qryPrivilegeTEMP: TIBQuery;
    qryLimpaPrivilege: TIBQuery;
    qryConsultaDescPrivilege: TIBQuery;
    sSkinManager1: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    CupomPharmapele1: TMenuItem;
    pnlDesconto: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lblDescMeta: TLabel;
    lblAcrescimo: TLabel;
    lblDescUsado: TLabel;
    lblSaldoDesc: TLabel;
    qryDescontosF: TIBQuery;
    qryDescontosV: TIBQuery;
    lblPercDesconto: TLabel;
    lblPercForm: TLabel;
    lblPercVar: TLabel;
    DescontoMdico1: TMenuItem;
    btInsereDescVarejo: TSpeedButton;
    EmissoCodBarrasGerentes1: TMenuItem;
    SolicitaoCortesia1: TMenuItem;
    Cortesias1: TMenuItem;
    Panel4: TPanel;
    Shape4: TShape;
    lblTaxa: TLabel;
    Label10: TLabel;
    btSaldo: TSpeedButton;
    E1: TMenuItem;
    qryConsultaDescFranquias: TIBQuery;
    btDiscriminaDesconto: TBitBtn;
    D1: TMenuItem;
    B1: TMenuItem;
    C1: TMenuItem;
    qryParametros: TIBQuery;
    qryInseredesconto2: TFDQuery;
    qrySaldoCampanha: TIBQuery;
    qryInsereDesconto: TFDQuery;
    P1: TMenuItem;
    menu_ConsultoriaPremium: TMenuItem;
    menu_EnvioSMSClientes: TMenuItem;
    procedure edtTerminalBalcaoKeyPress(Sender: TObject; var Key: Char);
    procedure localizarbalcao(balcao:string);
    procedure btInsereDescontoClick(Sender: TObject);
    procedure TimerAberturaTimer(Sender: TObject);
    procedure TimerHorarioTimer(Sender: TObject);
    procedure DescontosConcedidos1Click(Sender: TObject);
    procedure CodBarrasFuncionarios1Click(Sender: TObject);
    procedure Solicitao1Click(Sender: TObject);
    procedure SolicitaesAbertas1Click(Sender: TObject);
    procedure ConfigAlertas1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtTerminalBalcaoChange(Sender: TObject);
    procedure ControledeCartes1Click(Sender: TObject);
    procedure ImprimirCodBarras1Click(Sender: TObject);
    procedure CupomPharmapele1Click(Sender: TObject);
    procedure rgtpDescClick(Sender: TObject);
    procedure E1Click(Sender: TObject);
    procedure btDiscriminaDescontoClick(Sender: TObject);
    procedure cbDescontoTipoChange(Sender: TObject);
    procedure DescontoMdico1Click(Sender: TObject);
    procedure btInsereDescVarejoClick(Sender: TObject);
    procedure EmissoCodBarrasGerentes1Click(Sender: TObject);
    procedure SolicitaoCortesia1Click(Sender: TObject);
    procedure Cortesias1Click(Sender: TObject);
    procedure btSaldoClick(Sender: TObject);
    procedure D1Click(Sender: TObject);
    procedure B1Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure P1Click(Sender: TObject);
    procedure menu_ConsultoriaPremiumClick(Sender: TObject);
    procedure menu_EnvioSMSClientesClick(Sender: TObject);
    function mudaponto(valor:double):string;
    function TrocaVirgPPto(Valor: string): String;
    function VerificaValor(valor:string):string;
    function ArredUp(nValor: Double; Casas: Integer): Double;
    function  SaldoParceiros(pCPFCli,pTPITM,pMesSaldo,pAnoSaldo:String):Currency;
    function  QtdProdutosCampanhaStickFacial:integer;
    procedure edtLojaExit(Sender: TObject);
    function verQtdProdutos:integer;

    procedure DescontoPromocional;
    procedure DescontoPromocional2;
    procedure DescontoPromocional3;
    procedure DescontoPromocional4;
    procedure DescontoPromocional5;
    procedure DescontoPromocional6;
    procedure DescontoPromocional7;
    procedure DescontoLeva3Paga2;
    procedure DescontoBlackFriday;
    procedure DescontoBlackFriday2;
    procedure DescontoBlackFriday10203040;
    procedure DescontoFuncionarios;
    procedure DescontoCortesiaAntigo;
    procedure DescontoProgressivotraining;
    procedure DescontoSorvete;
    procedure Descontonosegundoitem;
    procedure DescontoProgressivo;
    procedure DescontoProgressivo1;
    procedure DescontoProgressivoBeauty;
    procedure DescontoProgressivoHigienizacao;
    procedure DescontoProgressivoCabelos;
    procedure DescontoProgressivoPrevAging;
    procedure DescontoProgressivoSabonte;
    procedure DescontoDiaDasmaes;
    procedure DiaDasMaesAcima250;
    procedure DescontoKVRA;
    procedure DescontoprogressivoPowerTrainning;
    procedure alimentacombo;
    procedure DescontoMedico;
    procedure DescontoFranquias;
    procedure inseredesc;
    procedure calculadescmed;
    procedure verificaperc;
    procedure atualizameta;
    procedure DescontoHidraTherapy;
    procedure DescontoDiaDasCriancas;
    procedure DescontoCoqueteleira;
    procedure DescontoCoqueteleiraAcima500;
    procedure DescontoGlitterAcima200;
    procedure LipGloss;
    procedure LipGloss15;
    procedure DescontoPrevAging;
    procedure descprodautomatic;
    procedure DescontoCabelos;
    procedure DescontoProgressivoBlackFriday;
    procedure SabonetesNatal;
    procedure LinhaCleanTherapy;
    procedure MesDaMulher;
    procedure CoqueteleiraColagenos;
    procedure SllepMax1;
    procedure SllepMax2;
    procedure CoqueteleiraColagenos2;
    procedure MesDasMaes;
    procedure SOSAntiqueda;
    procedure Aquaporine;
    procedure BotulinUp;
    procedure CampanhaImunoCaps;
    procedure ComprouLevouSabDesejos;
    procedure ComprouLevouHidLavanda;
    procedure QuizenaDoConsumidor;
    procedure CampanhaPerformanceBrinde;
    procedure AniversarianteDoMes;
    procedure CampanhaBSCROSS;
    procedure DescontoProgressivoNatal;
    Procedure CampanhaFotosense;
    procedure CampanhaCarnaval;
    procedure ComboCreatinaPalatinose;
    procedure ManipuladosPET;
    procedure DescontoCortesia;
    procedure CampanhaCortesiaMensal;
    procedure CampanhaRejuvenescimento;
    procedure CampanhaAntiqueda;
    procedure VendasIfood;
    procedure VarejoAcima300;
    procedure SemanaDoCliente;
    procedure CampanhaStickFacial;
    procedure ConsultoriaPremium;
    procedure compre1Leve2Colageno;
    procedure compre1Leve2Palatinose;
    procedure DescontoKitLimaoSiciliano;
    procedure DescontoKitLiroDoVale;
    procedure HomeLuxuryAlfmofada;
    procedure CloneAlmofada;
    procedure GessoPerfumado;
    procedure CampanhaColagenos2025;
    procedure CloneCurcuma;
    procedure SemanaDoConsumidor;
    procedure CampanhaBoosters;
    procedure CampanhaHigienizacao;
    procedure VendasPet;
    procedure CampanhaCabelos2025;
    procedure CampanhaBrindes;
    procedure ProgressivoPresentes;
    procedure SemanaDoCliente2;
    procedure CampanhaBrindesPorValor;
    procedure CampanhaBrindesCompras;
    procedure CampanhaPDRN;
    procedure DiaDasCriancas;
    procedure SemanaEsquentaBlackFriday;
  private
    procedure CampanhaStickBolsaPraia;
    procedure CampanhaCreatina2026;
    procedure Carnaval2026;
    { Private declarations }
  public
    { Public declarations }
    InfoTela:  TInfoDesconto;
  end;

var
  frmPrincipal: TfrmPrincipal;
  vrtot, desconto, vrtotvarejo, vrtotform, vrdescVarejo, vrdescFormula, vrnegocfrm, vrnegocvar, vrtxa: double;
  desc1form, desc2var, meta, SaldoCampanha: double;
  tpdescvar, tpdescform, cpfcliente, useridaut, idcamp, VerificaSaldoCampanha: string;
  desctipo: string;
  CRMDesc, diasuteis, crmtermbalc, MAXPRODFUNC, qtdProd: integer;


implementation
uses
  udmDescontos, uCartaoDesconto, uSenha, uRelatorio, uCodBarras, usolicitacao,
  uSolicitAbertas, uAlertas, uRelatorioControle, uDescontoCRM,
  uImprimeCodBarrasCRM, uRelatCupomDesc, uDescontoMed, uInformaDesconto,
  uCodBarrasGerente, uSolicCortesiasAbertas, uControleCortesias, uExtrato,
  uCartaoCampanha, ufrmDescontosAplicados, uCadDescontoCliente, uCampanhaCliente,
  uBuscaClienteDesconto, uRelatorioCampanha, uPlanilhaDescontos,
  uConsultoriaPremium, uEnvioSMS, System.Generics.Collections, Desconto.Base,
  Desconto.Constantes.Campanhas, Desconto.Constantes.Usuarios, Desconto.Sqls,
  Desconto.Utils;




{$R *.dfm}
function TfrmPrincipal.mudaponto(valor: double): string;
begin
  result := StringReplace(formatfloat('0.##', valor), ',', '.', [rfReplaceAll, rfIgnoreCase]);
end;

function TfrmPrincipal.TrocaVirgPPto(Valor: string): string;
var
  i: integer;
begin
  if Valor = null then
    Valor := '0';
  if Valor <> '' then
  begin
    for i := 0 to Length(Valor) do
    begin
      if Valor[i] = ',' then
        Valor[i] := '.';
    end;
  end;
  Result := Valor;
end;

function TfrmPrincipal.VerificaValor(valor: string): string;
var
  i: integer;
begin
  for i := 1 to Length(valor) do
  begin
    if valor[i] in ['0'..'9'] then
      Result := Result + valor[i];
  end;
end;

function TfrmPrincipal.ArredUp(nValor: Double; Casas: Integer): Double;
var
  sValor, sDecimais, sParteValor, sNovoValor, sCasas: string;
  Ponto, I, UltimoDigito: Integer;
begin

  sCasas := '';                                                                          //zerar a variável que acrescenta as casas decimais
  for I := 1 to Casas do
    sCasas := sCasas + '0';                                                              //quantidade de casas decimais passada na função

  Ponto := Pos(',', FormatFloat('0.' + sCasas, nValor));                                 //verifica onde esta a vírgula que separa as casas decimais, de acordo com o parametro de quantidade de casas passado
  sValor := FloatToStr(nValor);                                                          //grava o valor numa string para separação das casas decimais
  sDecimais := Trim(Copy(sValor, Ponto + 1, length(sValor)));                            //pega as casas decimais do jeito que veio sem tratamento
  sParteValor := Trim(Copy(sValor, 1, Ponto - 1));                                       //pegar a parte anterior as casas decimais

  if Length(sDecimais) > Casas then                                                      //significa que deu mais doque duas casas decimais depois da vírgula
  begin
    sDecimais := Trim(Copy(sDecimais, 1, Casas));                                        //definir a quantidade de casas de acordo com o parametro
    UltimoDigito := StrToInt(Trim(Copy(sDecimais, Length(sDecimais), 1)));               //pegar o ultimo digito de casas decimais
    UltimoDigito := UltimoDigito + 1;                                                    //como a função mesmo diz, jogar mais um, sempre arredondar o ultimo valor para cima
    sDecimais := Copy(sDecimais, 1, Casas - 1) + IntToStr(UltimoDigito);                 //jogar o novo ultimo digito calculado somando mais um nos decimais
    sNovoValor := StringReplace(sParteValor, ',', '', [rfReplaceAll]) + ',' + sDecimais; //define o novo valor gerado
    Result := StrToFloat(sNovoValor);                                                    //retornar o novo valor gerado
  end
  else
    Result := nValor;                                                                    //caso não seja maior, apenas devolver o valor que veio
end;


procedure TfrmPrincipal.DescontoKVRA;
var
  valortotal, valorunitdesc, vrcxa, saldo, valorfor, valdesc, consumo, valorunitproduto: double;
  i, qtdfinal: integer;
begin
  if StrToDate(FormatDateTime('dd/mm/yyyy', now)) > strtodate('31/05/2022') then
    raise Exception.Create('Promoção Encerrada');

  saldo := 100.1;
  valortotal := 0;
  lblDescontoValor.Caption := '0';

  qryPrivilegeTEMP.Close;
  qryPrivilegeTEMP.SQL.Clear;
  qryPrivilegeTEMP.SQL.Add(' select first 1 valorfor ');
  qryPrivilegeTEMP.SQL.Add('   from campanhasclientes a ');
  qryPrivilegeTEMP.SQL.Add('  where idcamp = 54 ');
  qryPrivilegeTEMP.SQL.Add('    and cpfcli = ' + inttostr(qryTerminalBalcao.FieldValues['NRCNPJ']));
  qryPrivilegeTEMP.Open;

  if qryPrivilegeTEMP.IsEmpty then
    raise Exception.Create('Cliente não é participante da campanha KVRA')
  else
    saldo := qryPrivilegeTEMP.FieldValues['VALORFOR'];

  qryFcertaTemp.Close;
  qryFcertaTemp.SQL.Clear;
  qryFcertaTemp.SQL.Add(' select coalesce(sum(a.vrdsc),0)vrdsc ');
  qryFcertaTemp.SQL.Add('   from fc32200 a ,FC32100 B ');
  qryFcertaTemp.SQL.Add('  WHERE A.nrcpm = B.nrcpm ');
  qryFcertaTemp.SQL.Add('    and a.useridaut = ''kvra'' ');
  qryFcertaTemp.SQL.Add('    and a.cdtml = b.cdtml ');
  qryFcertaTemp.SQL.Add('    and a.dtope = b.dtope ');
  qryFcertaTemp.SQL.Add('    and a.operid = b.operid ');
  qryFcertaTemp.SQL.Add('    AND B.cdcli = ' + intToStr(qryTerminalBalcao.FieldValues['CDCLI']));
  qryFcertaTemp.Open;

  if not qryFcertaTemp.IsEmpty then
    consumo := qryFcertaTemp.FieldValues['VRDSC'];

  qryPrivilegeTEMP.Close;
  qryFcertaTEMP.Close;
  saldo := saldo - consumo;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['VRDSC']) > 0 then
      lblDescontoValor.Caption := FloatToStr(StrToFloat(lblDescontoValor.Caption) + (qryTerminalBalcao.FieldValues['VRDSC']));
    valorfor := valorfor + qryTerminalBalcao.FieldValues['VRLIQ'];

    if qryTerminalBalcao.FieldValues['tpitm'] = 'R' then
    begin
      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.SQL.Clear;
      qrySelecionaDesconto.SQL.Add(' select VRDSC,VRLIQ ');
      qrySelecionaDesconto.SQL.Add('   from fc32200 ');
      qrySelecionaDesconto.SQL.Add('  where fc32200.cdfil  = ' + inttostr(qryTerminalBalcao.FieldValues['cdfil']));
      qrySelecionaDesconto.SQL.Add('    and fc32200.cdtml  = ' + quotedstr(qryTerminalBalcao.FieldValues['cdtml']));
      qrySelecionaDesconto.SQL.Add('    and fc32200.dtope  = ' + quotedstr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qrySelecionaDesconto.SQL.Add('    and fc32200.operid = ' + inttostr(qryTerminalBalcao.FieldValues['operid']));
      qrySelecionaDesconto.SQL.Add('    and fc32200.nrcpm  = ' + inttostr(qryTerminalBalcao.FieldValues['nrcpm']));
      qrySelecionaDesconto.SQL.Add('    and fc32200.itemid = ' + inttostr(qryTerminalBalcao.FieldValues['itemid']));
      qrySelecionaDesconto.Open;

      if not (qrySelecionaDesconto.IsEmpty) then
        if (qrySelecionaDesconto.FieldValues['VRDSC']) > 0 then
          lblDescontoValor.Caption := FloatToStr(StrToFloat(lblDescontoValor.Caption) + (qryTerminalBalcao.FieldValues['VRDSC']));

      valortotal := valortotal + qrySelecionaDesconto.FieldValues['VRLIQ'];
    end;
    qryTerminalBalcao.Next;
  end;

  qrySelecionaDesconto.Close;
  if (lblDescontoValor.Caption <> '0') then
  begin
    qrySelecionaDesconto.Close;
    raise exception.create('Já existem descontos lançados nessa venda');
  end;

  if saldo <= 0 then
    raise Exception.Create('Saldo Insuficiente para Promoção');

  SHOWMESSAGE('SALDO DISPONÍVEL:' + floatToStr(saldo) + ' - VALOR FORMULA:' + floatToStr(valorfor));

  if saldo + 0.1 >= valorfor then
  begin
    valdesc := (valorfor - 0.10);
    saldo := (saldo - valorfor);
    SHOWMESSAGE('SALDO RESTANTE:' + floatToStr(saldo) + ' - DESCONTO:' + floatToStr(valdesc));
  end
  else
  begin
    valdesc := saldo;
    saldo := saldo - valdesc;
    SHOWMESSAGE('SALDO RESTANTE:' + floatToStr(saldo) + ' - DESCONTO:' + floatToStr(valdesc));
  end;

  if MessageDlg('Deseja confirmar desconto KVRA?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
  begin
    qrySelecionaDesconto.Close;
    qrySelecionaDesconto.SQL.Clear;
    qrySelecionaDesconto.sql.Add('    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, ');
    qrySelecionaDesconto.sql.Add('           a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, a.TPDSC, a.VRDSC, a.VRLIQ, a.VRCXA, ');
    qrySelecionaDesconto.sql.Add('           a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, coalesce( b.vrtot, a.VRTOT) as VRTOT, ');
    qrySelecionaDesconto.sql.Add('           a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ');
    qrySelecionaDesconto.sql.Add('      from fc32110 a ');
    qrySelecionaDesconto.sql.Add(' left join fc32200 b on ( a.cdfil=b.cdfil and a.cdtml=b.cdtml ');
    qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
    qrySelecionaDesconto.sql.Add('       and a.operid = b.operid ');
    qrySelecionaDesconto.sql.Add('       and a.nrcpm = b.nrcpm ');
    qrySelecionaDesconto.sql.Add('       and a.itemid = b.itemid ) ');
    qrySelecionaDesconto.sql.Add('     where a.cdfil = ' + trim(frmPrincipal.edtLoja.Text));
    qrySelecionaDesconto.sql.Add('       and a.nrcpm = ' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qrySelecionaDesconto.sql.Add('       and a.dtope = ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qrySelecionaDesconto.sql.Add('       and a.tpitm = ' + quotedstr('R') + ' order by a.VRTOT DESC');
    qrySelecionaDesconto.Open;
    qrySelecionaDesconto.FetchAll;
    qrySelecionaDesconto.First;

    for i := 1 to qrySelecionaDesconto.recordcount do
    begin
      valorunitproduto := qrySelecionaDesconto.FieldValues['VRLIQ'];
      valorunitdesc := (valdesc / valortotal) * valorunitproduto;
      valorunitdesc := RoundTo(valorunitdesc, -2);
      showmessage('VALOR PRODUTO:' + floatToStr(valorunitproduto) + '-VALOR DESCONTO UNI:' + floatToStr(valorunitdesc));

      if qrySelecionaDesconto.FieldValues['TPITM'] = 'R' then
      begin
        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32200 ');
        qryInsereDesconto.SQL.Add('    set tpdsc = ' + quotedstr(tpdescform));
        qryInsereDesconto.SQL.Add('        vrliq = vrtot+vrtxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ',');
        qryInsereDesconto.SQL.Add('        vrsdo = vrtot+vrtxa-vrrcb-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ',');
        qryInsereDesconto.SQL.Add('        vrdsc = ' + TrocaVirgPPto(floattostr(valorunitdesc)) + ',');
        qryInsereDesconto.SQL.Add('        useridaut = ' + quotedstr('kvra') + ',');
        qryInsereDesconto.SQL.Add('  where cdfil = ' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml = ' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope = ' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid = ' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm = ' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid = ' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;
        qryInsereDesconto.Close;

        if qrySelecionaDesconto.FieldValues['tppag'] = '1' then
        begin
          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32200 ');
          qryInsereDesconto.SQL.Add('    set vrcxa = vrtot+vrtxa-' + TrocaVirgPPto(floattostr(valorunitdesc)));
          qryInsereDesconto.SQL.Add('  where cdfil = ' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
          qryInsereDesconto.SQL.Add('    and cdtml = ' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
          qryInsereDesconto.SQL.Add('    and dtope = ' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and operid = ' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
          qryInsereDesconto.SQL.Add('    and nrcpm = ' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
          qryInsereDesconto.SQL.Add('    and itemid = ' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
          qryInsereDesconto.Close;
        end
        else
        begin
          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32200 ');
          qryInsereDesconto.SQL.Add('    set vrcxa= vrrcb ');
          qryInsereDesconto.SQL.Add('  where cdfil = ' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
          qryInsereDesconto.SQL.Add('    and cdtml = ' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
          qryInsereDesconto.SQL.Add('    and dtope = ' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and operid = ' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
          qryInsereDesconto.SQL.Add('    and nrcpm = ' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
          qryInsereDesconto.SQL.Add('    and itemid = ' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
          qryInsereDesconto.Close;
        end;
      end;

      if qrySelecionaDesconto.FieldValues['TPITM'] = 'R' then
      begin
        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' select vrcxa  ');
        qryInsereDesconto.SQL.Add('   from fc32200 ');
        qryInsereDesconto.SQL.Add('  where cdfil = ' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml = ' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope = ' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid = ' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm = ' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid = ' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.Open;

        vrcxa := qryInsereDesconto.FieldValues['VRCXA'];

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc = ' + quotedstr(tpdescform) + ', ');
        qryInsereDesconto.SQL.Add('        vrtot = ' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
        qryInsereDesconto.SQL.Add('        pruni = ' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
        qryInsereDesconto.SQL.Add('        pruniliq = ' + TrocaVirgPPto(floattostr(vrcxa)) + '/QUANT, ');
        qryInsereDesconto.SQL.Add('        vrcxa=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=' + TrocaVirgPPto(floattostr(vrcxa)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
      end;

      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;
      qryInsereDesconto.Close;

      qrySelecionaDesconto.Next;
      if qrySelecionaDesconto.Eof then
        break;
    end;

    qrySelecionaDesconto.First;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
    qryInsereDesconto.SQL.Add('   from fc32110 ');
    qryInsereDesconto.SQL.Add('  where cdfil = ' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm = ' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope = ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.Open;
    valortotal := qryInsereDesconto.FieldValues['VALOR'];
    qryInsereDesconto.Close;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update fc32100 ');
    qryInsereDesconto.SQL.Add('    set useridaut = ' + quotedstr('kvra') + ', ');
    qryInsereDesconto.SQL.Add('        vrtot = ' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrliq = VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrcxa = VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrarc = VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
    qryInsereDesconto.SQL.Add('  where cdfil = ' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm = ' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope = ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.CommitRetaining;
    qryInsereDesconto.Close;
    showmessage('DESCONTO CONCEDIDO COM SUCESSO!');

    qrySelecionaDesconto.Close;
  end;
end;


procedure TfrmPrincipal.DescontoDiaDasmaes;
var
  valortotal, valorproduto, valdesc, valdesc2, valdesctot, valdescapl: double;
  qtdprodpromocao, i, percdesc, codproduto: integer;
  nomedesconto: string;
begin
  valdesctot := 0;
  lblDescontoValor.Caption := '0';
  nomedesconto := 'Desconto Dia Das Mães';

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add(' select a.nrcpm,a.useridaut,a.dtope ');
  qryFcertaTEMP.SQL.Add('   from fc32100 a ');
  qryFcertaTEMP.SQL.Add('  where a.cdcli = ' + IntToStr(qryTerminalBalcao.fieldValues['CDCLI']));
  qryFcertaTEMP.SQL.Add('    and a.useridaut = ''diadasmaes''');
  qryFcertaTEMP.Open;

  if not qryFcertaTEMP.IsEmpty then
  begin
    raise Exception.Create('Cliente Já possue produto da promoção Dia Das Mães no terminal Balcão:' + IntToStr(qryFcertaTEMP.fieldValues['NRCPM']) + ' na data ' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryFcertaTEMP.fieldValues['DTOPE'])) + '');
  end
  else
  begin
    qryFcertaTEMP.Close;
    qryFcertaTEMP.SQL.Clear;
    qryFcertaTEMP.SQL.Add(' select a.nrcpm,a.useridaut,a.dtope ');
    qryFcertaTEMP.SQL.Add('   from fc31100 a ');
    qryFcertaTEMP.SQL.Add('  where a.cdcli = ' + IntToStr(qryTerminalBalcao.fieldValues['CDCLI']));
    qryFcertaTEMP.SQL.Add('    and a.useridaut = ''diadasmaes'' ');
    qryFcertaTEMP.Open;

    if not qryFcertaTEMP.IsEmpty then
      raise Exception.Create('Cliente Já possue produto da promoção Dia Das Mães no cupom:' + IntToStr(qryFcertaTEMP.fieldValues['NRCPM']) + ' na data ' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryFcertaTEMP.fieldValues['DTOPE'])) + '');
  end;

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add(' select CDPRO,A.vrliq,A.quant QTD,vrdsc ');
  qryFcertaTEMP.SQL.Add('   from fc32110 a ');
  qryFcertaTEMP.SQL.Add('  where a.tpitm = ' + quotedstr('V'));
  qryFcertaTEMP.SQL.Add('    and a.cdfil = ' + inttostr(qryTerminalBalcao.FieldValues['CDFIL']));
  qryFcertaTEMP.SQL.Add('    and a.nrcpm = ' + inttostr(qryTerminalBalcao.FieldValues['NRCPM']));
  qryFcertaTEMP.Open;

  if not (qryFcertaTEMP.IsEmpty) then
  begin
    qtdprodpromocao := 0;
    valortotal := 0;
    valorproduto := 0;

    qryTerminalBalcao.First;

    while not qryFcertaTEMP.Eof do
    begin
      if (qryFcertaTEMP.FieldValues['CDPRO'] = 14852) or
         (qryFcertaTEMP.FieldValues['CDPRO'] = 14853) or
         (qryFcertaTEMP.FieldValues['CDPRO'] = 14854) then
      begin
        qtdprodpromocao := qtdprodpromocao + qryFcertaTEMP.FieldValues['QTD'];
        valorproduto := qryFcertaTEMP.FieldValues['VRLIQ'];
        valdesc2 := valdesc2 + qryFcertaTEMP.FieldValues['VRDSC'];
      end
      else
      begin
        valortotal := valortotal + qryFcertaTEMP.FieldValues['VRLIQ'];
      end;

      qryfcertaTemp.Next;
    end;

    if valortotal < 350 then
      raise Exception.Create('Valor insuficiente para promoção Dia Das Mães, valor Mímino R$350,00');

    if qtdprodpromocao > 1 then
      raise Exception.Create('Quantidade incorreta,somente uma bolsa por venda.');

    if qtdprodpromocao < 1 then
      raise Exception.Create('Não foram encontrados produtos da promoção Dia das Mães');

    if valdesc2 > 0 then
      raise Exception.Create('Desconto Dia Das Mães já plicado');

    if MessageDlg('Deseja confirmar desconto relativo ao ' + nomedesconto + '?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.SQL.Clear;
      qrySelecionaDesconto.sql.Add(' select * ');
      qrySelecionaDesconto.sql.Add('   from fc32110 ');
      qrySelecionaDesconto.sql.Add('  where tpitm = ' + quotedstr('V'));
      qrySelecionaDesconto.sql.Add('    and cdfil = ' + trim(frmPrincipal.edtLoja.Text));
      qrySelecionaDesconto.sql.Add('    and nrcpm = ' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qrySelecionaDesconto.sql.Add('    and dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
      qrySelecionaDesconto.sql.Add('    and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qrySelecionaDesconto.Open;

      if qrySelecionaDesconto.IsEmpty then
        raise exception.Create('Erro ao lançar desconto ' + nomedesconto);

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set pruniliq = (pruniliq-(59.89)), ');
      qryInsereDesconto.SQL.Add('        ptdsc = 99.97, ');
      qryInsereDesconto.SQL.Add('        tpdsc = ''3'', ');
      qryInsereDesconto.SQL.Add('        vrcxa = (vrcxa-59.89), ');
      qryInsereDesconto.SQL.Add('        vrliq = (vrliq-59.89), ');
      qryInsereDesconto.SQL.Add('        vrdsc = vrdsc+59.89, ');
      qryInsereDesconto.SQL.Add('        BCICM = VRTXAV+vrliq-59.98 ');
      qryInsereDesconto.SQL.Add('  where cdfil = ' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
      qryInsereDesconto.SQL.Add('    and dtope = ' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
      qryInsereDesconto.SQL.Add('    and operid = ' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
      qryInsereDesconto.SQL.Add('    and nrcpm = ' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
      qryInsereDesconto.SQL.Add('    and cdpro in (14852,14853,14854)');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;
      qryInsereDesconto.Close;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut = ' + quotedstr('diadasmaes'));
      qryInsereDesconto.SQL.Add('        vrtot = ' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq = VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa = VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc = VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil = ' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm = ' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope = ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;
      qryInsereDesconto.Close;
      qrySelecionaDesconto.Close;

      lblDescontoValor.Caption := floattostr(valdesctot);
      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end
  else
    showmessage('Erro ao inserir Desconto');
end;

procedure TfrmPrincipal.Descontoprogressivotraining;
var
  valortotal, valorproduto, valdesc, valdesctot, valdescapl: double;
  qtdprodpromocao, i, percdesc, codproduto: integer;
  nomedesconto: string;
begin
  valdesctot := 0;
  lblDescontoValor.Caption := '0';
  nomedesconto := 'Desconto Progressivo Pre-Treino';

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add('   select a.cdpro, sum(a.quant) as qtd, pruni,sum(vrdsc) vrdsc ');
  qryFcertaTEMP.SQL.Add('     from fc32110 a  ');
  qryFcertaTEMP.SQL.Add('    where a.tpitm = ' + quotedstr('V'));
  qryFcertaTEMP.SQL.Add('      and a.cdfil = ' + inttostr(qryTerminalBalcao.FieldValues['CDFIL']));
  qryFcertaTEMP.SQL.Add('      and a.nrcpm = ' + inttostr(qryTerminalBalcao.FieldValues['NRCPM']));
  qryFcertaTEMP.SQL.Add(' group by 1,3');
  qryFcertaTEMP.Open;

  if not (qryFcertaTEMP.IsEmpty) then
  begin
    qtdprodpromocao := 0;
    qryTerminalBalcao.First;

    while not qryTerminalBalcao.EOF do
    begin
      if (qryTerminalBalcao.FieldValues['vrdsc'] > 0) then
        raise Exception.Create('Venda Já possui Desconto');

      if (qryTerminalBalcao.FieldValues['CDPRO'] = codproduto) then
      begin
        if (qryTerminalBalcao.FieldValues['VRDSC']) > 0 then
          lblDescontoValor.Caption := FloatToStr(StrToFloat(lblDescontoValor.Caption) + (qryTerminalBalcao.FieldValues['VRDSC']));
        valdescapl := valdescapl + qryTerminalBalcao.FieldValues['VRDSC'];
      end;
      qryTerminalBalcao.Next;
    end;

    if (valdescapl > 0) then
      raise exception.create('Já existem descontos lançados para ' + nomedesconto + ' nessa venda');

    if MessageDlg('Deseja confirmar desconto relativo ao ' + nomedesconto + '?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      while not (qryFcertaTEMP.Eof) do
      begin
        if (qryFcertaTEMP.FieldValues['cdpro'] = 15447) or (qryFcertaTEMP.FieldValues['cdpro'] = 6045) then
        begin
          qtdprodpromocao := qtdprodpromocao + qryFcertaTEMP.FieldValues['qtd'];
          qryFcertaTEMP.Next;
        end;
      end;

      if (qtdprodpromocao < 1) then
        raise Exception.Create('Quantidade insuficiente para promoção');

      if qtdprodpromocao > 2 then
        percdesc := 15
      else if qtdprodpromocao < 2 then
        percdesc := 5
      else if qtdprodpromocao = 2 then
        percdesc := 10;

      qryFcertaTEMP.First;

      while not (qryFcertaTEMP.Eof) do
      begin
        if (qryFcertaTEMP.FieldValues['cdpro'] = 15447) or (qryFcertaTEMP.FieldValues['cdpro'] = 6045) then
        begin
          codproduto := qryFcertaTEMP.FieldValues['cdpro'];
          valorproduto := qryFcertaTEMP.FieldValues['PRUNI'] * qryFcertaTEMP.FieldValues['QTD'];
          valdesc := (valorproduto * percdesc) / 100;
          valdesctot := valdesctot + valdesc;

          qrySelecionaDesconto.Close;
          qrySelecionaDesconto.SQL.Clear;
          qrySelecionaDesconto.sql.Add('   select * ');
          qrySelecionaDesconto.sql.Add('     from fc32110 ');
          qrySelecionaDesconto.sql.Add('    where tpitm = ' + quotedstr('V'));
          qrySelecionaDesconto.sql.Add('      and cdfil = ' + trim(frmPrincipal.edtLoja.Text));
          qrySelecionaDesconto.sql.Add('      and nrcpm = ' + trim(frmPrincipal.edtTerminalBalcao.Text));
          qrySelecionaDesconto.sql.Add('      and dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
          qrySelecionaDesconto.sql.Add('      and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
          qrySelecionaDesconto.sql.Add('      and cdpro in (' + IntTostr(codproduto) + ') ');
          qrySelecionaDesconto.sql.Add('      and vrliq >' + mudaponto(valdesc));
          qrySelecionaDesconto.sql.Add(' order by vrliq desc');
          qrySelecionaDesconto.Open;

          if qrySelecionaDesconto.IsEmpty then
            raise exception.Create('Erro ao lançar desconto ' + nomedesconto);

          qryInsereDesconto.Close;
          qryInsereDesconto.SQl.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set pruniliq = (pruniliq-(' + mudaponto(valdesc) + ')), ');
          qryInsereDesconto.SQL.Add('        ptdsc = ' + mudaponto(percdesc) + ' ,');
          qryInsereDesconto.SQL.Add('        tpdsc = ' + quotedstr('3') + ' , ');
          qryInsereDesconto.SQL.Add('        vrcxa = (vrcxa-(' + mudaponto(valdesc) + ')), ');
          qryInsereDesconto.SQL.Add('        vrliq = (vrliq-(' + mudaponto(valdesc) + ')), ');
          qryInsereDesconto.SQL.Add('        vrdsc = vrdsc+(' + mudaponto(valdesc) + '),');
          qryInsereDesconto.SQL.Add('        BCICM = VRTXAV+vrliq-' + mudaponto(valdesc));
          qryInsereDesconto.SQL.Add('  where cdfil = ' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
          qryInsereDesconto.SQL.Add('    and cdtml = ' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
          qryInsereDesconto.SQL.Add('    and dtope = ' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and operid = ' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
          qryInsereDesconto.SQL.Add('    and nrcpm = ' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
          qryInsereDesconto.SQL.Add('    and itemid = ' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
          qryInsereDesconto.Close;
        end;
        qryFcertaTEMP.Next;
      end;

      qryFcertaTEMP.Close;
      qryFcertaTEMP.SQL.Clear;
      qryFcertaTEMP.SQL.Add(' select sum(vrliq) as VALOR ');
      qryFcertaTEMP.SQL.Add('   from fc32110 ');
      qryFcertaTEMP.SQL.Add('  where  cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryFcertaTEMP.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryFcertaTEMP.SQL.Add(' and dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
      qryFcertaTEMP.SQL.Add(' and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryFcertaTEMP.Open;

      valortotal := qryFcertaTEMP.FieldValues['VALOR'];
      qryFcertaTEMP.Close;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut = ' + quotedstr('progressTraining') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot = ' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq = VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa = VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc = VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil = ' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm = ' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope = ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;
      qryInsereDesconto.Close;
      qrySelecionaDesconto.Close;

      lblDescontoValor.Caption := floattostr(valdesctot);
      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end
  else
    showmessage('Erro ao inserir Desconto');
end;


procedure TfrmPrincipal.DescontoprogressivoPrevAging;
var
  valortotal, valorproduto, valdesc, valdesctot, valdescapl: double;
  qtdprodpromocao, i, percdesc, codproduto: integer;
  nomedesconto: string;
begin
  valdesctot := 0;
  lblDescontoValor.Caption := '0';
  nomedesconto := CAMPANHA_PREVAGING;

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add(
    RetornarSelectFC32110ItensVarejo(
      qryTerminalBalcao.FieldValues['CDFIL'],
      qryTerminalBalcao.FieldValues['NRCPM']));
  qryFcertaTEMP.Open;

  if not (qryFcertaTEMP.IsEmpty) then
  begin
    qtdprodpromocao := 0;
    qryTerminalBalcao.First;

    while not qryTerminalBalcao.EOF do
    begin
      if (qryTerminalBalcao.FieldValues['vrdsc'] > 0) then
        raise Exception.Create('Venda Já possui Desconto');

      if (qryTerminalBalcao.FieldValues['CDPRO'] = codproduto) then
      begin
        if (qryTerminalBalcao.FieldValues['VRDSC']) > 0 then
          lblDescontoValor.Caption := FloatToStr(StrToFloat(lblDescontoValor.Caption) + (qryTerminalBalcao.FieldValues['VRDSC']));
        valdescapl := valdescapl + qryTerminalBalcao.FieldValues['VRDSC'];
      end;
      qryTerminalBalcao.Next;
    end;

    if (valdescapl > 0) then
      raise exception.create('Já existem descontos lançados para ' + nomedesconto + ' nessa venda');

    if MessageDlg('Deseja confirmar desconto relativo ao ' + nomedesconto + '?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      if qryFcertaTEMP.FieldValues['vrdsc'] > 0 then
        raise Exception.Create('Venda já possue desconto');

      Desconto_Progressivo_PrevAging(valdesctot,InfoTela);
      lblDescontoValor.Caption := floattostr(valdesctot);
      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end
  else
    showmessage('Erro ao inserir Desconto');
end;


procedure TfrmPrincipal.DescontoprogressivoCabelos;
 var valortotal,valorproduto,valdesc,valdesctot,valdescapl : double;
     qtdprodpromocao,i,percdesc,codproduto:integer;
     nomedesconto:string;
 begin
  valdesctot:=0;
  lblDescontoValor.Caption := '0';
  nomedesconto := CAMPANHA_CABELOS;

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add('   select a.cdpro, sum(a.quant) as qtd, pruni,sum(vrdsc) vrdsc ');
  qryFcertaTEMP.SQL.Add('     from fc32110 a  ');
  qryFcertaTEMP.SQL.Add('    where a.tpitm = '+quotedstr('V'));
  qryFcertaTEMP.SQL.Add('      and a.cdfil = '+inttostr(qryTerminalBalcao.FieldValues['CDFIL']));
  qryFcertaTEMP.SQL.Add('      and a.nrcpm = '+inttostr(qryTerminalBalcao.FieldValues['NRCPM']));
  qryFcertaTEMP.SQL.Add(' group by 1,3');
  qryFcertaTEMP.Open;

  if not(qryFcertaTEMP.IsEmpty) then
  begin
    qtdprodpromocao := 0;
    qryTerminalBalcao.First;

    while not qryTerminalBalcao.EOF do
    begin
      if (qryTerminalBalcao.FieldValues['vrdsc'] > 0) then
        raise Exception.Create('Venda Já possui Desconto');

      if (qryTerminalBalcao.FieldValues['CDPRO'] = codproduto) then
      begin
        if (qryTerminalBalcao.FieldValues['VRDSC']) > 0 then
          lblDescontoValor.Caption := FloatToStr(StrToFloat(lblDescontoValor.Caption) + (qryTerminalBalcao.FieldValues['VRDSC']));
        valdescapl := valdescapl + qryTerminalBalcao.FieldValues['VRDSC'];
      end;

      qryTerminalBalcao.next;
    end;

    if (valdescapl > 0) then
      raise exception.create('Já existem descontos lançados para ' + nomedesconto + ' nessa venda');

    if MessageDlg('Deseja confirmar desconto relativo ao ' + nomedesconto + '?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      Desconto_Progressivo_Cabelo(valdesctot,InfoTela);
      lblDescontoValor.Caption := floattostr(valdesctot);
      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end
  else
    showmessage('Erro ao inserir Desconto');
end;


procedure TfrmPrincipal.SabonetesNatal;
 var valortotal,valorproduto,valdesc,valdesctot,valdescapl : double;
     qtdprodpromocao,i,percdesc,codproduto:integer;
     nomedesconto:string;
 begin
  valdesctot:=0;
  lblDescontoValor.Caption := '0';
  nomedesconto := 'Desconto Sabonetes Natal';

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add(' select a.cdpro, a.quant as qtd, pruni, vrdsc ');
  qryFcertaTEMP.SQL.Add('   from fc32110 a  ');
  qryFcertaTEMP.SQL.Add('  where a.tpitm='+quotedstr('V'));
  qryFcertaTEMP.SQL.Add('    and a.cdfil='+inttostr(qryTerminalBalcao.FieldValues['CDFIL']));
  qryFcertaTEMP.SQL.Add('    and a.nrcpm='+inttostr(qryTerminalBalcao.FieldValues['NRCPM']));
  qryFcertaTEMP.Open;

if not(qryFcertaTEMP.IsEmpty) then
 begin
    qtdprodpromocao := 0;
    qryTerminalBalcao.First;

    while not qryTerminalBalcao.EOF do
    begin
      if (qryTerminalBalcao.FieldValues['vrdsc'] > 0) then
        raise Exception.Create('Venda Já possui Desconto');

      if (qryTerminalBalcao.FieldValues['CDPRO'] = codproduto) then
      begin
        if (qryTerminalBalcao.FieldValues['VRDSC']) > 0 then
          lblDescontoValor.Caption := FloatToStr(StrToFloat(lblDescontoValor.Caption) + (qryTerminalBalcao.FieldValues['VRDSC']));
        valdescapl := valdescapl + qryTerminalBalcao.FieldValues['VRDSC'];
      end;
      qryTerminalBalcao.next;
    end;

    if (valdescapl > 0) then
      raise exception.create('Já existem descontos lançados para ' + nomedesconto + ' nessa venda');


    if MessageDlg('Deseja confirmar desconto relativo ao ' + nomedesconto + '?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      if qryFcertaTEMP.FieldValues['vrdsc'] > 0 then
        raise Exception.Create('Venda já possue desconto');

      while not (qryFcertaTEMP.Eof) do
      begin
        if (qryFcertaTEMP.FieldValues['cdpro'] = 15620) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 15619) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 9056) then
        begin
          qtdprodpromocao := qtdprodpromocao + qryFcertaTEMP.FieldValues['qtd'];
        end;
        qryFcertaTEMP.Next;
      end;

      if (qtdprodpromocao < 10) or (qtdprodpromocao = null) then
        raise Exception.Create('Quantidade insuficiente para promoção');

      percdesc := 0;

      if qtdprodpromocao > 9 then
        percdesc := 20;

      qryFcertaTEMP.First;

      while not (qryFcertaTEMP.Eof) do
      begin
        if (qryFcertaTEMP.FieldValues['cdpro'] = 15620) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 15619) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 9056 ) then
        begin
          codproduto := qryFcertaTEMP.FieldValues['cdpro'];
          valorproduto := qryFcertaTEMP.FieldValues['PRUNI'] * qryFcertaTEMP.FieldValues['QTD'];
          valdesc := (valorproduto * percdesc) / 100;
          valdesctot := valdesctot + valdesc;

          qrySelecionaDesconto.Close;
          qrySelecionaDesconto.sql.Clear;
          qrySelecionaDesconto.sql.Add('   select * ');
          qrySelecionaDesconto.sql.Add('     from fc32110 ');
          qrySelecionaDesconto.sql.Add('    where tpitm=' + quotedstr('V'));
          qrySelecionaDesconto.sql.Add('      and cdfil=' + trim(frmPrincipal.edtLoja.Text));
          qrySelecionaDesconto.sql.Add('      and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
          qrySelecionaDesconto.sql.Add('      and dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
          qrySelecionaDesconto.sql.Add('      and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
          qrySelecionaDesconto.sql.Add('      and cdpro in (' + IntTostr(codproduto) + ')');
          qrySelecionaDesconto.sql.Add('      and vrliq >' + mudaponto(valdesc));
          qrySelecionaDesconto.sql.Add(' order by vrliq desc');

          qrySelecionaDesconto.Open;

          if qrySelecionaDesconto.IsEmpty then
            raise exception.Create('Erro ao lançar desconto ' + nomedesconto);

          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set pruniliq = (pruniliq-(' + mudaponto(valdesc) + ')), ');
          qryInsereDesconto.SQL.Add('        ptdsc = 99.97, ');
          qryInsereDesconto.SQL.Add('        tpdsc = ' + quotedstr('3') + ', ');
          qryInsereDesconto.SQL.Add('        vrcxa = (vrcxa-(' + mudaponto(valdesc) + ')), ');
          qryInsereDesconto.SQL.Add('        vrliq = (vrliq-(' + mudaponto(valdesc) + ')), ');
          qryInsereDesconto.SQL.Add('        vrdsc = vrdsc+(' + mudaponto(valdesc) + '),');
          qryInsereDesconto.SQL.Add('        BCICM = VRTXAV+vrliq-' + mudaponto(valdesc));
          qryInsereDesconto.SQL.Add('  where cdfil = ' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
          qryInsereDesconto.SQL.Add('    and cdtml = ' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
          qryInsereDesconto.SQL.Add('    and dtope = ' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and operid = ' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
          qryInsereDesconto.SQL.Add('    and nrcpm = ' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
          qryInsereDesconto.SQL.Add('    and itemid = ' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
          qryInsereDesconto.Close;
        end;
        qryFcertaTEMP.Next;
      end;

      qryFcertaTEMP.Close;
      qryFcertaTEMP.SQL.Clear;
      qryFcertaTEMP.SQL.Add(' select sum(vrliq) as VALOR ');
      qryFcertaTEMP.SQL.Add('   from fc32110 ');
      qryFcertaTEMP.SQL.Add('  where cdfil = ' + trim(frmPrincipal.edtLoja.Text));
      qryFcertaTEMP.SQL.Add('    and nrcpm = ' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryFcertaTEMP.SQL.Add('    and dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
      qryFcertaTEMP.SQL.Add('    and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryFcertaTEMP.Open;

      valortotal := qryFcertaTEMP.FieldValues['VALOR'];
      qryFcertaTEMP.Close;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut = ' + quotedstr('SaboneteNatal') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot = ' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq = VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa = VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc = VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil = ' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm = ' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope = ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;
      qryInsereDesconto.Close;
      qrySelecionaDesconto.Close;

      lblDescontoValor.Caption := floattostr(valdesctot);
      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end
  else
    showmessage('Erro ao inserir Desconto');
end;


procedure TfrmPrincipal.DescontoprogressivoHigienizacao;
 var valortotal,valorproduto,valdesc,valdesctot,valdescapl : double;
     qtdprodpromocao,i,percdesc,codproduto:integer;
     nomedesconto:string;
 begin
  valdesctot:=0;
  lblDescontoValor.Caption := '0';
  nomedesconto := 'Desconto Progressivo Higienização';

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add('   select a.cdpro, sum(a.quant) as qtd, pruni, sum(vrdsc) vrdsc ');
  qryFcertaTEMP.SQL.Add('     from fc32110 a  ');
  qryFcertaTEMP.SQL.Add('    where a.tpitm = '+quotedstr('V'));
  qryFcertaTEMP.SQL.Add('      and a.cdfil = '+inttostr(qryTerminalBalcao.FieldValues['CDFIL']));
  qryFcertaTEMP.SQL.Add('      and a.nrcpm = '+inttostr(qryTerminalBalcao.FieldValues['NRCPM']));
  qryFcertaTEMP.SQL.Add(' group by 1,3');
  qryFcertaTEMP.Open;

  if not (qryFcertaTEMP.IsEmpty) then
  begin
    qtdprodpromocao := 0;
    qryTerminalBalcao.First;

    while not qryTerminalBalcao.EOF do
    begin
      if (qryTerminalBalcao.FieldValues['vrdsc'] > 0) then
        raise Exception.Create('Venda Já possui Desconto');

      if (qryTerminalBalcao.FieldValues['CDPRO'] = codproduto) then
      begin
        if (qryTerminalBalcao.FieldValues['VRDSC']) > 0 then
          lblDescontoValor.Caption := FloatToStr(StrToFloat(lblDescontoValor.Caption) + (qryTerminalBalcao.FieldValues['VRDSC']));
        valdescapl := valdescapl + qryTerminalBalcao.FieldValues['VRDSC'];
      end;

      qryTerminalBalcao.next;
    end;

    if (valdescapl > 0) then
      raise exception.create('Já existem descontos lançados para ' + nomedesconto + ' nessa venda');

    if MessageDlg('Deseja confirmar desconto relativo ao ' + nomedesconto + '?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      if qryFcertaTEMP.FieldValues['vrdsc'] > 0 then
        raise Exception.Create('Venda já possue desconto');

      while not (qryFcertaTEMP.Eof) do
      begin
        if (qryFcertaTEMP.FieldValues['cdpro'] = 3774) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 3776) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 3775) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 3770) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 3768) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 3767) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 3772) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 3769) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 3771) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 15708) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 15709) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 15827) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 15826) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 15825) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 15831)
        then
        begin
          qtdprodpromocao := qtdprodpromocao + qryFcertaTEMP.FieldValues['qtd'];
          qryFcertaTEMP.Next;
        end
        else
        begin
          if (qtdprodpromocao < 2) or (qtdprodpromocao = null) then
            raise Exception.Create('Quantidade insuficiente para promoção');
          break;
        end;
      end;

      if qtdprodpromocao < 2 then
        raise Exception.Create('Quantidade insuficiente para promoção');

      if qtdprodpromocao > 2 then
        percdesc := 15
      else
        percdesc := 10;

      qryFcertaTEMP.First;

      while not (qryFcertaTEMP.Eof) do
      begin
        if (qryFcertaTEMP.FieldValues['cdpro'] = 3774) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 3776) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 3775) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 3770) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 3768) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 3767) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 3772) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 3769) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 3771) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 15708) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 15709) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 15827) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 15826) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 15825) or
           (qryFcertaTEMP.FieldValues['cdpro'] = 15831)
        then
        begin
          codproduto := qryFcertaTEMP.FieldValues['cdpro'];
          valorproduto := qryFcertaTEMP.FieldValues['PRUNI'] * qryFcertaTEMP.FieldValues['QTD'];
          valdesc := (valorproduto * percdesc) / 100;

          valdesctot := valdesctot + valdesc;

          qrySelecionaDesconto.Close;
          qrySelecionaDesconto.SQL.Clear;
          qrySelecionaDesconto.sql.Add('   select * ');
          qrySelecionaDesconto.sql.Add('     from fc32110 ');
          qrySelecionaDesconto.sql.Add('    where tpitm = ' + quotedstr('V'));
          qrySelecionaDesconto.sql.Add('      and cdfil = ' + trim(frmPrincipal.edtLoja.Text));
          qrySelecionaDesconto.sql.Add('      and nrcpm = ' + trim(frmPrincipal.edtTerminalBalcao.Text));
          qrySelecionaDesconto.sql.Add('      and dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
          qrySelecionaDesconto.sql.Add('      and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
          qrySelecionaDesconto.sql.Add('      and cdpro in (' + IntTostr(codproduto) + ')');
          qrySelecionaDesconto.sql.Add('      and vrliq >' + mudaponto(valdesc));
          qrySelecionaDesconto.sql.Add(' order by vrliq desc');
          qrySelecionaDesconto.Open;

          if qrySelecionaDesconto.IsEmpty then
            raise exception.Create('Erro ao lançar desconto ' + nomedesconto);

          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set pruniliq = (pruniliq-(' + mudaponto(valdesc) + ')), ');
          qryInsereDesconto.SQL.Add('        ptdsc = 99.97 ,');
          qryInsereDesconto.SQL.Add('        tpdsc = ' + quotedstr('3') + ' , ');
          qryInsereDesconto.SQL.Add('        vrcxa = (vrcxa-(' + mudaponto(valdesc) + ')), ');
          qryInsereDesconto.SQL.Add('        vrliq = (vrliq-(' + mudaponto(valdesc) + ')), ');
          qryInsereDesconto.SQL.Add('        vrdsc = vrdsc+(' + mudaponto(valdesc) + '), ');
          qryInsereDesconto.SQL.Add('        BCICM = VRTXAV+vrliq-' + mudaponto(valdesc));
          qryInsereDesconto.SQL.Add('  where cdfil = ' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
          qryInsereDesconto.SQL.Add('    and cdtml = ' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
          qryInsereDesconto.SQL.Add('    and dtope = ' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and operid = ' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
          qryInsereDesconto.SQL.Add('    and nrcpm = ' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
          qryInsereDesconto.SQL.Add('    and itemid = ' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
          qryInsereDesconto.Close;
        end;
        qryFcertaTEMP.Next;
      end;

      qryFcertaTEMP.Close;
      qryFcertaTEMP.SQL.Clear;
      qryFcertaTEMP.SQL.Add(' select sum(vrliq) as VALOR ');
      qryFcertaTEMP.SQL.Add('   from fc32110 ');
      qryFcertaTEMP.SQL.Add('  where cdfil = ' + trim(frmPrincipal.edtLoja.Text));
      qryFcertaTEMP.SQL.Add('    and nrcpm = ' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryFcertaTEMP.SQL.Add('    and dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
      qryFcertaTEMP.SQL.Add('    and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryFcertaTEMP.Open;

      valortotal := qryFcertaTEMP.FieldValues['VALOR'];
      qryFcertaTEMP.Close;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('progresHigienizacao') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot = ' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq = VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa = VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc = VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil = ' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm = ' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope = ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;
      qryInsereDesconto.Close;
      qrySelecionaDesconto.Close;

      lblDescontoValor.Caption := floattostr(valdesctot);
      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end
  else
    showmessage('Erro ao inserir Desconto');
end;

procedure TfrmPrincipal.DescontoprogressivoBeauty;
var
  valortotal, valorproduto, valdesc, valdesctot, valdescapl: double;
  qtdprodpromocao, i, percdesc, codproduto: integer;
  nomedesconto: string;
begin
  valdesctot := 0;
  lblDescontoValor.Caption := '0';

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add(
    RetornarSelectFC32110ItensVarejo(
      qryTerminalBalcao.FieldValues['CDFIL'],
      qryTerminalBalcao.FieldValues['NRCPM']));
  qryFcertaTEMP.Open;

    if not (qryFcertaTEMP.IsEmpty) then
    begin
      qtdprodpromocao := 0;
      qryTerminalBalcao.First;

      while not qryTerminalBalcao.EOF do
      begin
        if (qryTerminalBalcao.FieldValues['vrdsc'] > 0) and (qryTerminalBalcao.FieldValues['IDPROMO'] = 0) then
          raise Exception.Create('Venda Já possui Desconto');

        if (qryTerminalBalcao.FieldValues['CDPRO'] = codproduto) then
        begin
          if (qryTerminalBalcao.FieldValues['VRDSC']) > 0 then
            lblDescontoValor.Caption := FloatToStr(StrToFloat(lblDescontoValor.Caption) + (qryTerminalBalcao.FieldValues['VRDSC']));
          valdescapl := valdescapl + qryTerminalBalcao.FieldValues['VRDSC'];
        end;
        qryTerminalBalcao.next;
      end;

      if (valdescapl > 0) then
        raise exception.create('Já existem descontos lançados para ' + CAMPANHA_COLAGENO + ' nessa venda');

      if MessageDlg('Deseja confirmar desconto relativo ao ' + CAMPANHA_COLAGENO + '?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
      begin
        {
        if (qryFcertaTEMP.FieldValues['vrdsc'] > 0) and (qryFcertaTEMP.FieldValues['IDPROMO'] = 0) then
          raise Exception.Create('Venda já possue desconto');

        while not (qryFcertaTEMP.Eof) do
        begin
          if ExisteProduto(qryFcertaTEMP.FieldByName('cdpro').AsInteger, PRODUTOS_DESCONTO_PROGRESSIVO_COLAGENO) then
          begin
            qtdprodpromocao := qtdprodpromocao + qryFcertaTEMP.FieldValues['qtd'];
          end;
          qryFcertaTEMP.Next;
        end;

        if (qtdprodpromocao < 2) or (qtdprodpromocao = null) then
          raise Exception.Create('Quantidade insuficiente para promoção2');
        if qtdprodpromocao > 2 then
          percdesc := 15
        else
          percdesc := 10;

        qryFcertaTEMP.First;

        while not (qryFcertaTEMP.Eof) do
        begin
          if ExisteProduto(qryFcertaTEMP.FieldByName('cdpro').AsInteger, PRODUTOS_DESCONTO_PROGRESSIVO_COLAGENO) then
          begin
            codproduto := qryFcertaTEMP.FieldValues['cdpro'];
            valorproduto := qryFcertaTEMP.FieldValues['PRUNI'] * qryFcertaTEMP.FieldValues['QTD'];
            valdesc := (valorproduto * percdesc) / 100;

            valdesctot := valdesctot + valdesc;

            qrySelecionaDesconto.Close;
            qrySelecionaDesconto.SQL.Clear;
            qrySelecionaDesconto.sql.Add('   select * ');
            qrySelecionaDesconto.sql.Add('     from fc32110 ');
            qrySelecionaDesconto.sql.Add('    where tpitm = ' + quotedstr('V'));
            qrySelecionaDesconto.sql.Add('      and cdfil = ' + trim(frmPrincipal.edtLoja.Text));
            qrySelecionaDesconto.sql.Add('      and nrcpm = ' + trim(frmPrincipal.edtTerminalBalcao.Text) );
            qrySelecionaDesconto.sql.Add('      and dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
            qrySelecionaDesconto.sql.Add('      and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
            qrySelecionaDesconto.sql.Add('      and cdpro in (' + IntTostr(codproduto) + ') and vrliq >' + mudaponto(valdesc));
            qrySelecionaDesconto.sql.Add(' order by vrliq desc');
            qrySelecionaDesconto.Open;

            if qrySelecionaDesconto.IsEmpty then
              raise exception.Create('Erro ao lançar desconto ' + CAMPANHA_COLAGENO);

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' update fc32110 ');
            qryInsereDesconto.SQL.Add('    set pruniliq = (pruniliq-(' + mudaponto(valdesc) + ')), ');
            qryInsereDesconto.SQL.Add('        ptdsc = 99.97, ');
            qryInsereDesconto.SQL.Add('        tpdsc = ' + quotedstr('3') + ', ');
            qryInsereDesconto.SQL.Add('        vrcxa = (vrcxa-(' + mudaponto(valdesc) + ')), ');
            qryInsereDesconto.SQL.Add('        vrliq = (vrliq-(' + mudaponto(valdesc) + ')), ');
            qryInsereDesconto.SQL.Add('        vrdsc = vrdsc+(' + mudaponto(valdesc) + '), ');
            qryInsereDesconto.SQL.Add('        BCICM = VRTXAV+vrliq-' + mudaponto(valdesc));
            qryInsereDesconto.SQL.Add('  where cdfil = ' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
            qryInsereDesconto.SQL.Add('    and cdtml = ' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
            qryInsereDesconto.SQL.Add('    and dtope = ' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
            qryInsereDesconto.SQL.Add('    and operid = ' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
            qryInsereDesconto.SQL.Add('    and nrcpm = ' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
            qryInsereDesconto.SQL.Add('    and itemid = ' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.CommitRetaining;
            qryInsereDesconto.Close;
          end;
          qryFcertaTEMP.Next;
        end;

        qryFcertaTEMP.Close;
        qryFcertaTEMP.SQL.Clear;
        qryFcertaTEMP.SQL.Add(' select sum(vrliq) as VALOR ');
        qryFcertaTEMP.SQL.Add('   from fc32110 ');
        qryFcertaTEMP.SQL.Add('  where cdfil = ' + trim(frmPrincipal.edtLoja.Text));
        qryFcertaTEMP.SQL.Add('    and nrcpm = ' + trim(frmPrincipal.edtTerminalBalcao.Text));
        qryFcertaTEMP.SQL.Add('    and dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
        qryFcertaTEMP.SQL.Add('    and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
        qryFcertaTEMP.Open;

        valortotal := qryFcertaTEMP.FieldValues['VALOR'];
        qryFcertaTEMP.Close;

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32100 ');
        qryInsereDesconto.SQL.Add('    set useridaut = ' + quotedstr(USUARIO_PROGRESSIVO_COLAGENO) + ', ');
        qryInsereDesconto.SQL.Add('        vrtot = ' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq = VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
        qryInsereDesconto.SQL.Add('        vrcxa = VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
        qryInsereDesconto.SQL.Add('        vrarc = VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
        qryInsereDesconto.SQL.Add('  where cdfil = ' + trim(frmPrincipal.edtLoja.Text));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
        qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;
        qryInsereDesconto.Close;
        qrySelecionaDesconto.Close;

        lblDescontoValor.Caption := floattostr(valdesctot);

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update totvsconf ');
        qryInsereDesconto.SQL.Add('    set ENV = ' + quotedstr('N'));
        qryInsereDesconto.SQL.Add('  where fil = ' + trim(frmPrincipal.edtLoja.Text));
        qryInsereDesconto.SQL.Add('    and cupom = ' + trim(frmPrincipal.edtTerminalBalcao.Text));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.Commit;
        qryInsereDesconto.Close;

        }
        Desconto_Progressivo_Colageno(valdesctot,InfoTela);
        lblDescontoValor.Caption := floattostr(valdesctot);
        showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
      end;
    end
    else
      showmessage('Não existem produtos de varejo iguais nessa compra');
end;
procedure TfrmPrincipal.localizarbalcao(balcao: string);
var
  descontovarejo: double;
begin
  qryTerminalBalcao.Close;
   // eliomar alterei em 07/02/2023
  try
    qryTerminalBalcao.Transaction.Commit;
  except
    qryTerminalBalcao.Close;
  end;

  vrdescVarejo := 0;
  vrdescFormula := 0;
  crmtermbalc := 0;

  if trim(edtTerminalBalcao.Text) <> '' then
  begin
    qryTerminalBalcao.SQL.Clear;
    qryTerminalBalcao.SQL.Add(' 			select fc32110.IDPROMO, fc32110.pfcrm,fc32110.ufcrm,fc32110.nrcrm,fc07000.nrcnpj,fc32110.CDFIL,fc32110.CDTML, ');
    qryTerminalBalcao.SQL.Add(' 				   fc32110.DTOPE,fc32110.OPERID,fc32110.NRCPM,fc32110.ITEMID,fc32110.TPITM,fc32110.cdfilr,fc32110.CDPRO,fc32110.QUANT, ');
    qryTerminalBalcao.SQL.Add(' 				   fc32110.PRUNI,fc32110.TPDSC,coalesce(fc32110.VRDSC+coalesce((select fc32200.vrdsc ');
    qryTerminalBalcao.SQL.Add(' 				                                                                  from fc32200 ');
    qryTerminalBalcao.SQL.Add(' 																				 where fc32200.cdfil=fc32110.cdfil ');
    qryTerminalBalcao.SQL.Add(' 																				   and fc32200.cdtml=fc32110.cdtml ');
    qryTerminalBalcao.SQL.Add(' 																				   and fc32200.dtope=fc32110.dtope ');
    qryTerminalBalcao.SQL.Add(' 																				   and fc32200.operid=fc32110.operid ');
    qryTerminalBalcao.SQL.Add(' 																				   and fc32200.nrcpm=fc32110.nrcpm ');
    qryTerminalBalcao.SQL.Add(' 																				   and fc32200.itemid=fc32110.itemid),0),0) as VRDSC, ');
    qryTerminalBalcao.SQL.Add(' 				   fc32110.VRLIQ,fc32110.VRCXA,fc32110.TPDSCG,fc32110.VRDSCG,fc32110.CDTXAG,fc32110.VRTXAG,fc32110.TPPAG,fc32110.VRTOT, ');
    qryTerminalBalcao.SQL.Add(' 				   fc32110.CDTXA,fc32110.VRTXA,fc32110.VRDSCV,fc32110.VRTXAV, fc32110.VRLIQ+coalesce(fc32110.VRDSC,fc32110.VRTOT*0,2) + ');
    qryTerminalBalcao.SQL.Add(' 				   coalesce((  select fc32200.vrdsc ');
    qryTerminalBalcao.SQL.Add(' 				                 from fc32200 ');
    qryTerminalBalcao.SQL.Add(' 								where fc32200.cdfil=fc32110.cdfil ');
    qryTerminalBalcao.SQL.Add(' 								  and fc32200.cdtml=fc32110.cdtml ');
    qryTerminalBalcao.SQL.Add(' 								  and fc32200.dtope=fc32110.dtope ');
    qryTerminalBalcao.SQL.Add(' 								  and fc32200.operid=fc32110.operid ');
    qryTerminalBalcao.SQL.Add(' 								  and fc32200.nrcpm=fc32110.nrcpm ');
    qryTerminalBalcao.SQL.Add(' 								  and fc32200.itemid=fc32110.itemid),0)  - coalesce((   select fc32200.vrtxa ');
    qryTerminalBalcao.SQL.Add(' 								                                                          from fc32200 ');
    qryTerminalBalcao.SQL.Add(' 																						 where fc32200.cdfil=fc32110.cdfil ');
    qryTerminalBalcao.SQL.Add(' 																						   and fc32200.cdtml=fc32110.cdtml ');
    qryTerminalBalcao.SQL.Add(' 																						   and fc32200.dtope=fc32110.dtope ');
    qryTerminalBalcao.SQL.Add(' 																						   and fc32200.operid=fc32110.operid ');
    qryTerminalBalcao.SQL.Add(' 																						   and fc32200.nrcpm=fc32110.nrcpm ');
    qryTerminalBalcao.SQL.Add(' 																						   and fc32200.itemid=fc32110.itemid),0) as SEMDESCONTO, ');
    qryTerminalBalcao.SQL.Add(' 				   coalesce((	select fc32200.vrtxa ');
    qryTerminalBalcao.SQL.Add(' 				                  from fc32200 ');
    qryTerminalBalcao.SQL.Add(' 								 where fc32200.cdfil=fc32110.cdfil ');
    qryTerminalBalcao.SQL.Add(' 								   and fc32200.cdtml=fc32110.cdtml ');
    qryTerminalBalcao.SQL.Add(' 								   and fc32200.dtope=fc32110.dtope ');
    qryTerminalBalcao.SQL.Add(' 								   and fc32200.operid=fc32110.operid ');
    qryTerminalBalcao.SQL.Add(' 								   and fc32200.nrcpm=fc32110.nrcpm ');
    qryTerminalBalcao.SQL.Add(' 								   and fc32200.itemid=fc32110.itemid),0) as VRTXAREC, ');
    qryTerminalBalcao.SQL.Add(' 				   coalesce((	select fc32200.vrtxa ');
    qryTerminalBalcao.SQL.Add(' 				                  from fc32200 ');
    qryTerminalBalcao.SQL.Add(' 								 where fc32200.cdfil=fc32110.cdfil ');
    qryTerminalBalcao.SQL.Add(' 								   and fc32200.cdtml=fc32110.cdtml ');
    qryTerminalBalcao.SQL.Add(' 								   and fc32200.dtope=fc32110.dtope ');
    qryTerminalBalcao.SQL.Add(' 								   and fc32200.operid=fc32110.operid ');
    qryTerminalBalcao.SQL.Add(' 								   and fc32200.nrcpm=fc32110.nrcpm ');
    qryTerminalBalcao.SQL.Add(' 								   and fc32200.itemid=fc32110.itemid),0) as VRTXA, ');
    qryTerminalBalcao.SQL.Add(' 				   coalesce((	select fc03000.descr ');
    qryTerminalBalcao.SQL.Add(' 				                  from fc03000 ');
    qryTerminalBalcao.SQL.Add(' 								 where cdpro=fc32110.cdpro ');
    qryTerminalBalcao.SQL.Add(' 								   and fc32110.tpitm=' + QuotedStr('V') + '),' + quotedstr('FÓRMULA MANIPULADA (A VISTA)') + ') as DESCRPRD, ');
    qryTerminalBalcao.SQL.Add(' 				   coalesce(fc32110.ptdsc,0) as ptdsc,fc32100.cdcli,fc07000.nomecli,fc07000.nrcnpj, fc32100.cdfunre,FC08000.nomefun, FC32100.useridaut ');
    qryTerminalBalcao.SQL.Add('               from fc32110,fc32100 ');
    qryTerminalBalcao.SQL.Add('          left join fc08000 ');
    qryTerminalBalcao.SQL.Add(' 		            on (fc08000.cdcon=fc32100.cdconre ');
    qryTerminalBalcao.SQL.Add(' 			   and fc08000.cdfun=fc32100.cdfunre),fc07000 ');
    qryTerminalBalcao.SQL.Add(' 			 where fc07000.cdcli=fc32100.cdcli ');
    qryTerminalBalcao.SQL.Add(' 			   and fc32100.cdfil=fc32110.cdfil ');
    qryTerminalBalcao.SQL.Add(' 			   and fc32100.cdtml=fc32110.cdtml ');
    qryTerminalBalcao.SQL.Add(' 			   and fc32100.dtope=fc32110.dtope ');
    qryTerminalBalcao.SQL.Add(' 			   and fc32100.operid=fc32110.operid ');
    qryTerminalBalcao.SQL.Add(' 			   and fc32100.nrcpm=fc32110.nrcpm ');
    qryTerminalBalcao.SQL.Add('          and fc32110.nrcpm=' + trim(balcao));
    qryTerminalBalcao.SQL.add('          and fc32110.cdfil=' + trim(edtLoja.Text));
    qryTerminalBalcao.SQL.add('          and fc32110.dtope>=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
    qryTerminalBalcao.SQL.add('          and fc32100.indapro=' + quotedstr('N'));
    qryTerminalBalcao.SQL.add('     order by fc32110.cdpro');
    qryTerminalBalcao.Open;

    if qryTerminalBalcao.IsEmpty then
      ShowMessage('Terminal Balcão não encontrado no dia de hoje')
    else
    begin
      qryFcertaTEMP.Close;
      qryFcertaTEMP.SQL.Clear;
      qryFcertaTEMP.SQL.Add(' select b.nrcrm ');
      qryFcertaTEMP.SQL.Add('   from fc32110 A,fc12100 b ');
      qryFcertaTEMP.SQL.Add('  WHERE a.cdfilr=b.cdfil ');
      qryFcertaTEMP.SQL.Add('    and a.cdpro=b.nrrqu ');
      qryFcertaTEMP.SQL.Add('    and a.tpitm=' + quotedstr('R'));
      qryFcertaTEMP.SQL.Add('    and a.dtope=current_date ');
      qryFcertaTEMP.SQL.Add('    and a.nrcpm=' + trim(balcao));
      qryFcertaTEMP.SQL.Add('    and a.cdfil=' + trim(edtLoja.Text));
      qryFcertaTEMP.Open;

      nomecli := qryTerminalBalcao.FieldValues['nomecli'];
      cpfcliente := qryTerminalBalcao.FieldValues['nrcnpj'];

      if not (qryFcertaTEMP.IsEmpty) then
        crmtermbalc := qryFcertaTEMP.FieldValues['nrcrm']
      else
        crmtermbalc := 0;

      lblBalcao.Caption := 'R$ 0,00';
      lblDesconto.Caption := 'R$ 0,00';
      lblFinal.Caption := 'R$ 0,00';
      lblDescontovarejo.caption := 'R$ 0,00';
      lblDescontoValorBioneov.caption := 'R$ 0,00';
      lblDescontoValor.caption := 'R$ 0,00';
      lblValorVarejo.caption := 'R$ 0,00';
      lblTaxa.Caption := 'R$ 0,00';

      TNumericField(qryTerminalBalcao.FieldByName('pruni')).DisplayFormat := ',0.00;-,0.00';
      TNumericField(qryTerminalBalcao.FieldByName('SEMDESCONTO')).DisplayFormat := ',0.00;-,0.00';
      TNumericField(qryTerminalBalcao.FieldByName('vrdsc')).DisplayFormat := ',0.00;-,0.00';
      TNumericField(qryTerminalBalcao.FieldByName('vrtxarec')).DisplayFormat := ',0.00;-,0.00';

      qryTerminalBalcao.First;

      vrtot := 0;
      desconto := 0;
      descontovarejo := 0;
      vrtotvarejo := 0;
      vrtotform := 0;
      vrtxa := 0;

      lblPercVar.Caption := '0';
      lblPercForm.Caption := '0';

      while not qryTerminalBalcao.Eof do
      begin
        vrtot := vrtot + qryTerminalBalcao.FieldValues['SEMDESCONTO'];
        vrtxa := vrtxa + qryTerminalBalcao.FieldValues['VRTXAREC'] + qryTerminalBalcao.FieldValues['VRTXA'];
        desconto := desconto + RoundTo(qryTerminalBalcao.FieldValues['vrdsc'], -2);

        if ((qryTerminalBalcao.FieldValues['CDPRO'] = 5048) or
            (qryTerminalBalcao.FieldValues['CDPRO'] = 5049) or
            (qryTerminalBalcao.FieldValues['CDPRO'] = 5050) or
            (qryTerminalBalcao.FieldValues['CDPRO'] = 5051) or
            (qryTerminalBalcao.FieldValues['CDPRO'] = 5052) or
            (qryTerminalBalcao.FieldValues['CDPRO'] = 3640) or
            (qryTerminalBalcao.FieldValues['CDPRO'] = 3641)) then
          descontovarejo := descontovarejo + qryTerminalBalcao.FieldValues['vrdsc'];

        if qryTerminalBalcao.FieldValues['tpitm'] = 'V' then
        begin
          vrtotvarejo := vrtotvarejo + qryTerminalBalcao.FieldValues['SEMDESCONTO'];
          vrdescVarejo := vrdescVarejo + qryTerminalBalcao.FieldValues['vrdsc'];
        end
        else
        begin
          vrtotform := vrtotform + qryTerminalBalcao.FieldValues['SEMDESCONTO'];
          vrdescFormula := vrdescFormula + qryTerminalBalcao.FieldValues['vrdsc'];
        end;

        InfoTela.TerminalBalcao[qryTerminalBalcao.RecNo - 1].Filial := qryTerminalBalcao.FieldByName('cdfil').AsInteger;
        InfoTela.TerminalBalcao[qryTerminalBalcao.RecNo - 1].Cupom := qryTerminalBalcao.FieldByName('nrcpm').AsInteger;
        InfoTela.TerminalBalcao[qryTerminalBalcao.RecNo - 1].UsuarioAutorizacao := qryTerminalBalcao.FieldByName('useridaut').AsString;
        InfoTela.TerminalBalcao[qryTerminalBalcao.RecNo - 1].Tipo := qryTerminalBalcao.FieldByName('tpitm').AsString;
        InfoTela.TerminalBalcao[qryTerminalBalcao.RecNo - 1].ValorDesconto := qryTerminalBalcao.FieldByName('vrdsc').AsFloat;
        InfoTela.TerminalBalcao[qryTerminalBalcao.RecNo - 1].PercentualDesconto := qryTerminalBalcao.FieldByName('ptdsc').AsFloat;
        InfoTela.TerminalBalcao[qryTerminalBalcao.RecNo - 1].valortotal := qryTerminalBalcao.FieldByName('semdesconto').AsFloat;
        InfoTela.TerminalBalcao[qryTerminalBalcao.RecNo - 1].DescricaoDesconto := qryTerminalBalcao.FieldByName('descrprd').AsString;
        InfoTela.TerminalBalcao[qryTerminalBalcao.RecNo - 1].CdTml := qryTerminalBalcao.FieldByName('cdtml').AsString;
        InfoTela.TerminalBalcao[qryTerminalBalcao.RecNo - 1].DtOpe := qryTerminalBalcao.FieldByName('dtope').AsDateTime;
        InfoTela.TerminalBalcao[qryTerminalBalcao.RecNo - 1].OperId := qryTerminalBalcao.FieldByName('operid').AsInteger;
        InfoTela.TerminalBalcao[qryTerminalBalcao.RecNo - 1].ItemId := qryTerminalBalcao.FieldByName('itemid').AsInteger;

        qryTerminalBalcao.Next;
      end;

      qryTerminalBalcao.First;
      lblDesconto.Caption := floattostrf(desconto, ffcurrency, 15, 2);
      lblDesconto.Font.Color := clBlack;

      lblTaxa.Caption := floattostrf(vrtxa, ffcurrency, 15, 2);
      lblTaxa.Font.Color := clBlack;

      lblBalcao.Caption := floattostrf(vrtot, ffcurrency, 15, 2);
      lblFinal.Caption := floattostrf(vrtot + vrtxa - desconto, ffcurrency, 15, 2);
      lblFinal.Font.Color := clBlack;

      lblDescontovarejo.Caption := floattostrf(descontovarejo, ffcurrency, 15, 2);
      lblValorVarejo.Caption := floattostr(vrtotvarejo);

      valoratual := vrtot;
      cbDescontoTipo.Enabled := true;
      cbDescontoTipo.Color := clWindow;
    end;
  end;
end;

procedure TfrmPrincipal.atualizameta;
var
  nometabela1, nometabela2, tipoitem, tipoglobal: string;
  datainicial, datafinal: tdate;
  descontousado, descontousadototal, valtotdescparcial, acresacu, acresdia, valordiario: currency;
  qtdiasusados: integer;
begin
  if trim(edtLoja.Text) <> '4' then
  begin
    qryPrivilegeTEMP.Transaction.Commit;
    qryPrivilegeTEMP.Transaction.Active := true;

    qryPrivilegeTEMP.Close;
    qryPrivilegeTEMP.SQL.Clear;
    qryPrivilegeTEMP.SQL.Add(' select * ');
    qryPrivilegeTEMP.SQL.Add('   from METADESCONTO ');
    qryPrivilegeTEMP.SQL.Add('  where cdfil=' + edtLoja.Text);
    qryPrivilegeTEMP.SQL.Add('    and mesrf=' + FormatDateTime('mm', now));
    qryPrivilegeTEMP.SQL.Add('    and anorf=' + FormatDateTime('yyyy', now));
    qryPrivilegeTEMP.Open;

    if ((qryPrivilegeTEMP.IsEmpty) or (qryPrivilegeTEMP.FieldValues['META'] = null)) then
    begin
      raise Exception.Create('Loja sem meta de desconto definida para o mês atual.' + #13 + '          Comunicar ao depto comercial.');
      Application.Terminate;
    end
    else
    begin
      if qryPrivilegeTEMP.FieldValues['DIAS'] = null then
        raise Exception.Create('Loja sem dias úteis definidos para o mês atual.' + #13 + '          Comunicar ao depto comercial.');
    end;

    diasuteis := qryPrivilegeTEMP.FieldValues['DIAS'];
    meta := qryPrivilegeTEMP.FieldValues['META'];

    valordiario := qryPrivilegeTEMP.FieldValues['META'] / qryPrivilegeTEMP.FieldValues['DIAS'];
    lblDescMeta.Caption := FormatFloat('#####0.00', valordiario);

    qryPrivilegeTEMP.Close;
    qryPrivilegeTEMP.SQL.Clear;
    qryPrivilegeTEMP.SQL.Add(' select coalesce(SUM(ACRESCIMO),0) as ACRESCIMO ');
    qryPrivilegeTEMP.SQL.Add('   from METADESCONTO02 ');
    qryPrivilegeTEMP.SQL.Add('  where cdfil=' + edtLoja.Text);
    qryPrivilegeTEMP.SQL.Add('    and mesrf=' + FormatDateTime('mm', now));
    qryPrivilegeTEMP.SQL.Add('    and anorf=' + FormatDateTime('yyyy', now));
    qryPrivilegeTEMP.SQL.Add('    and diarf=' + FormatDateTime('dd', now));
    qryPrivilegeTEMP.Open;

    acresdia := qryPrivilegeTEMP.FieldValues['ACRESCIMO'];
    lblAcrescimo.Caption := FormatFloat('#####0.00', acresdia);

    qryPrivilegeTEMP.Close;
    qryPrivilegeTEMP.SQL.Clear;
    qryPrivilegeTEMP.SQL.Add(' select coalesce(SUM(ACRESCIMO),0) as ACRESCIMO ');
    qryPrivilegeTEMP.SQL.Add('   from METADESCONTO02 ');
    qryPrivilegeTEMP.SQL.Add('  where cdfil=' + edtLoja.Text);
    qryPrivilegeTEMP.SQL.Add('    and mesrf=' + FormatDateTime('mm', now));
    qryPrivilegeTEMP.SQL.Add('    and anorf=' + FormatDateTime('yyyy', now));
    qryPrivilegeTEMP.Open;

    acresacu := qryPrivilegeTEMP.FieldValues['ACRESCIMO'] - acresdia;
    qryPrivilegeTEMP.Close;

    datainicial := strtodate(FormatDateTime('dd/mm/yyyy', now));
    datafinal := strtodate(FormatDateTime('dd/mm/yyyy', now));

    nometabela1 := 'FC31200';

    qryDescontosF.Close;
    qryDescontosF.SQL.Clear;
    qryDescontosF.SQL.Add('      SELECT DISTINCT ');
    qryDescontosF.SQL.Add('             COALESCE( ' + nometabela1 + '.TPDSC,' + QUOTEDSTR('Z') + ') As TipoItem, ');
    qryDescontosF.SQL.Add('             COALESCE( ' + nometabela1 + '.TPDSCG,' + QUOTEDSTR('Z') + ') As TipoGlobal,');
    qryDescontosF.SQL.Add('             coalesce(' + nometabela1 + '.USERIDAUT,' + quotedstr('Nulo') + ') As USERIDAUT,');
    qryDescontosF.SQL.Add('             coalesce( SUM(' + nometabela1 + '.VRDSC) ,0)   As ValorItem, ');
    qryDescontosF.SQL.Add('             coalesce( SUM(' + nometabela1 + '.VRDSCG),0)   As ValorGlobal, ');
    qryDescontosF.SQL.Add('             (     select trim(coalesce(PARAMETRO,' + quotedstr('DESCONTO NAO CADASTRADO') + ' ))');
    qryDescontosF.SQL.Add('                     from FC99999');
    qryDescontosF.SQL.Add('                    where ARGUMENTO=' + quotedstr('DESCONTOR'));
    qryDescontosF.SQL.Add('                      and subargum=' + nometabela1 + '.TPDSC) as  DESCRICAOTIPOITEM,');
    qryDescontosF.SQL.Add('             (     select trim(coalesce(PARAMETRO,' + quotedstr('DESCONTO NAO CADASTRADO') + ' ))');
    qryDescontosF.SQL.Add('                     from FC99999');
    qryDescontosF.SQL.Add('                    where ARGUMENTO=' + quotedstr('DESCONTOR'));
    qryDescontosF.SQL.Add('                      and subargum=' + nometabela1 + '.TPDSCG) as DESCRICAOTIPOGLOBAL');
    qryDescontosF.SQL.Add('      FROM ' + nometabela1);
    qryDescontosF.SQL.Add('     WHERE (    ' + nometabela1 + '.DTOPE >= ' + quotedstr(FormatDateTime('dd.mm.yyyy', datainicial)) + ')');
    qryDescontosF.SQL.Add('       AND (' + nometabela1 + '.DTOPE <= ' + quotedstr(FormatDateTime('dd.mm.yyyy', datafinal)) + ')');
    qryDescontosF.SQL.Add('       AND NOT( ' + nometabela1 + '.TPPAG IN (' + quotedstr('5') + ',' + quotedstr('6') + ' ) )');
    qryDescontosF.SQL.Add('       AND ( ' + nometabela1 + '.VRDSC + ' + nometabela1 + '.VRDSCG ) > 0');
    qryDescontosF.SQL.Add('       AND (' + nometabela1 + '.CDFIL=' + edtLoja.Text + ')');
    qryDescontosF.SQL.Add('  GROUP BY ' + nometabela1 + '.TPDSC, ' + nometabela1 + '.TPDSCG,' + nometabela1 + '.USERIDAUT');

    qryDescontosF.Open;
    qryDescontosF.FetchAll;

    nometabela1 := 'FC31100';
    nometabela2 := 'FC31110';

    qryDescontosV.Close;
    qryDescontosV.SQL.Clear;
    qryDescontosV.SQL.Add('        SELECT DISTINCT ');
    qryDescontosV.SQL.Add('               COALESCE( ' + nometabela1 + '.TPDSC,' + QUOTEDSTR('Z') + ') As TipoItem, ');
    qryDescontosV.SQL.Add('               COALESCE( ' + nometabela1 + '.TPDSCG,' + QUOTEDSTR('Z') + ')       As TipoGlobal,');
    qryDescontosV.SQL.Add('               coalesce(' + nometabela1 + '.USERIDAUT,' + quotedstr('Nulo') + ')    As USERIDAUT,');
    qryDescontosV.SQL.Add('               coalesce(  SUM(' + nometabela2 + '.VRDSC)  ,0)  As ValorItem, ');
    qryDescontosV.SQL.Add('               coalesce(  SUM(' + nometabela2 + '.VRDSCV) ,0)  As ValorGlobal, ');
    qryDescontosV.SQL.Add('               (    select trim(coalesce(PARAMETRO,' + quotedstr('DESCONTO NAO CADASTRADO') + ' ))');
    qryDescontosV.SQL.Add('                      from FC99999');
    qryDescontosV.SQL.Add('                     where ARGUMENTO=' + quotedstr('DESCONTOV'));
    qryDescontosV.SQL.Add('                       and subargum=' + nometabela1 + '.TPDSC) as  DESCRICAOTIPOITEM,');
    qryDescontosV.SQL.Add('               (    select trim(coalesce(PARAMETRO,' + quotedstr('DESCONTO NAO CADASTRADO') + ' ))');
    qryDescontosV.SQL.Add('                      from FC99999');
    qryDescontosV.SQL.Add('                     where ARGUMENTO=' + quotedstr('DESCONTOV'));
    qryDescontosV.SQL.Add('                       and subargum=' + nometabela1 + '.TPDSCG) as DESCRICAOTIPOGLOBAL');
    qryDescontosV.SQL.Add('          FROM ' + nometabela1);
    qryDescontosV.SQL.Add('    INNER JOIN ' + nometabela2);
    qryDescontosV.SQL.Add('            ON (' + nometabela2 + '.CDFIL  = ' + nometabela1 + '.CDFIL) ');
    qryDescontosV.SQL.Add('           AND (' + nometabela2 + '.CDTML  = ' + nometabela1 + '.CDTML) ');
    qryDescontosV.SQL.Add('           AND (' + nometabela2 + '.DTOPE  = ' + nometabela1 + '.DTOPE) ');
    qryDescontosV.SQL.Add('           AND (' + nometabela2 + '.OPERID = ' + nometabela1 + '.OPERID) ');
    qryDescontosV.SQL.Add('           AND (' + nometabela2 + '.NRCPM  = ' + nometabela1 + '.NRCPM) ');
    qryDescontosV.SQL.Add('           AND (' + nometabela2 + '.TPITM  = ' + quotedstr('V') + ')');
    qryDescontosV.SQL.Add('         WHERE (' + nometabela1 + '.DTOPE >= ' + quotedstr(FormatDateTime('dd.mm.yyyy', datainicial)) + ')');
    qryDescontosV.SQL.Add('           AND (' + nometabela1 + '.DTOPE <= ' + quotedstr(FormatDateTime('dd.mm.yyyy', datafinal)) + ')');
    qryDescontosV.SQL.Add('           AND (' + nometabela1 + '.CDFIL=' + edtLoja.Text + ')');
    qryDescontosV.SQL.Add('      GROUP BY ' + nometabela1 + '.TPDSC, ' + nometabela1 + '.TPDSCG,' + nometabela1 + '.USERIDAUT');
    qryDescontosV.SQL.Add('        Having Sum(' + nometabela2 + '.VRDSC + ' + nometabela2 + '.VRDSCV) > 0 ');
    qryDescontosV.Open;
    qryDescontosV.FetchAll;

    while not qryDescontosF.Eof do
    begin
      if qryDescontosF.FieldValues['TIPOITEM'] <> null then
        tipoitem := qryDescontosF.FieldValues['TIPOITEM']
      else
        tipoitem := 'Z';
      if qryDescontosF.FieldValues['TIPOGLOBAL'] <> null then
        tipoglobal := qryDescontosF.FieldValues['TIPOGLOBAL']
      else
        tipoglobal := 'Z';

      if (qryDescontosF.FieldValues['useridaut'] <> 'privilegefunc') and
         (qryDescontosF.FieldValues['useridaut'] <> USUARIO_PRIVILEGEM) and
         (qryDescontosF.FieldValues['useridaut'] <> 'projetocrm') and
         (qryDescontosF.FieldValues['useridaut'] <> 'hidratherapy') and
         (qryDescontosF.FieldValues['useridaut'] <> 'desconto2item') and
         (qryDescontosF.FieldValues['useridaut'] <> 'descpharmapele') and
         (qryDescontosF.FieldValues['useridaut'] <> 'privcortesia') and
         (qryDescontosF.FieldValues['useridaut'] <> USUARIO_FRANQUIA) and
         (qryDescontosF.FieldValues['useridaut'] <> 'privblackf') and
         (trim(qryDescontosF.FieldValues['useridaut']) <> USUARIO_PRIV_CAMPANHA) and
         (qryDescontosF.FieldValues['useridaut'] <> 'diadasmaes') then
      begin
        if (tipoitem <> '2') then
          descontousado := descontousado + qryDescontosF.FieldValues['ValorItem'];
        if (tipoglobal <> '2') then
          descontousado := descontousado + qryDescontosF.FieldValues['ValorGlobal'];
      end;

      qryDescontosF.Next;
    end;

    while not qryDescontosV.Eof do
    begin
      if qryDescontosV.FieldValues['TIPOITEM'] <> null then
        tipoitem := qryDescontosV.FieldValues['TIPOITEM']
      else
        tipoitem := 'Z';
      if qryDescontosV.FieldValues['TIPOGLOBAL'] <> null then
        tipoglobal := qryDescontosV.FieldValues['TIPOGLOBAL']
      else
        tipoglobal := 'Z';

      if (qryDescontosV.FieldValues['useridaut'] <> 'privilegefunc') and
         (qryDescontosV.FieldValues['useridaut'] <> USUARIO_PRIVILEGEM) and
         (qryDescontosV.FieldValues['useridaut'] <> 'projetocrm') and
         (qryDescontosV.FieldValues['useridaut'] <> 'hidratherapy') and
         (qryDescontosF.FieldValues['useridaut'] <> 'desconto2item') and
         (qryDescontosV.FieldValues['useridaut'] <> 'descpharmapele') and
         (qryDescontosV.FieldValues['useridaut'] <> 'privcortesia') and
         (qryDescontosV.FieldValues['useridaut'] <> USUARIO_FRANQUIA) and
         (trim(qryDescontosV.FieldValues['useridaut']) <> 'privblackf') and
         (trim(qryDescontosV.FieldValues['useridaut']) <> USUARIO_PRIV_CAMPANHA) and
         (qryDescontosF.FieldValues['useridaut'] <> 'diadasmaes') then
      begin
        if (tipoitem <> '2') then
          descontousado := descontousado + qryDescontosV.FieldValues['ValorItem'];
        if (tipoglobal <> '2') then
          descontousado := descontousado + qryDescontosV.FieldValues['ValorGlobal'];
      end;
      qryDescontosV.Next;
    end;

    //DESCONTO TOTAL - ACUMULO
    nometabela1 := 'FC31200';
    qryDescontosF.Close;
    qryDescontosF.SQL.Clear;
    qryDescontosF.SQL.Add('      SELECT DISTINCT ');
    qryDescontosF.SQL.Add('             COALESCE( ' + nometabela1 + '.TPDSC,' + QUOTEDSTR('Z') + ')         As TipoItem, ');
    qryDescontosF.SQL.Add('             COALESCE( ' + nometabela1 + '.TPDSCG,' + QUOTEDSTR('Z') + ')       As TipoGlobal,');
    qryDescontosF.SQL.Add('             coalesce( ' + nometabela1 + '.USERIDAUT ,' + quotedstr('Nulo') + ' )  As USERIDAUT,');
    qryDescontosF.SQL.Add('             coalesce( SUM(' + nometabela1 + '.VRDSC) ,0)   As ValorItem, ');
    qryDescontosF.SQL.Add('             coalesce( SUM(' + nometabela1 + '.VRDSCG),0)   As ValorGlobal, ');
    qryDescontosF.SQL.Add('             (      select trim(coalesce(PARAMETRO,' + quotedstr('DESCONTO NAO CADASTRADO') + ' ))');
    qryDescontosF.SQL.Add('                      from FC99999 ');
    qryDescontosF.SQL.Add('                     where ARGUMENTO=' + quotedstr('DESCONTOR'));
    qryDescontosF.SQL.Add('                       and subargum=' + nometabela1 + '.TPDSC) as  DESCRICAOTIPOITEM,');
    qryDescontosF.SQL.Add('             (      select trim(coalesce(PARAMETRO,' + quotedstr('DESCONTO NAO CADASTRADO') + ' ))');
    qryDescontosF.SQL.Add('                      from FC99999');
    qryDescontosF.SQL.Add('                     where ARGUMENTO=' + quotedstr('DESCONTOR'));
    qryDescontosF.SQL.Add('                       and subargum=' + nometabela1 + '.TPDSCG) as DESCRICAOTIPOGLOBAL');
    qryDescontosF.SQL.Add('       FROM ' + nometabela1);
    qryDescontosF.SQL.Add('      WHERE (' + nometabela1 + '.DTOPE >= ' + quotedstr(FormatDateTime('01.mm.yyyy', datainicial)) + ')');
    qryDescontosF.SQL.Add('        AND (' + nometabela1 + '.DTOPE <= ' + quotedstr(FormatDateTime('dd.mm.yyyy', IncDay(datafinal, -1))) + ')');
    qryDescontosF.SQL.Add('        AND NOT( ' + nometabela1 + '.TPPAG IN (' + quotedstr('5') + ',' + quotedstr('6') + ' ) )');
    qryDescontosF.SQL.Add('        AND ( ' + nometabela1 + '.VRDSC + ' + nometabela1 + '.VRDSCG ) > 0');
    qryDescontosF.SQL.Add('        AND (' + nometabela1 + '.CDFIL=' + edtLoja.Text + ')');
    qryDescontosF.SQL.Add('   GROUP BY ' + nometabela1 + '.TPDSC, ' + nometabela1 + '.TPDSCG,' + nometabela1 + '.USERIDAUT');

    qryDescontosF.Open;
    qryDescontosF.FetchAll;

    nometabela1 := 'FC31100';
    nometabela2 := 'FC31110';

    qryDescontosV.Close;
    qryDescontosV.SQL.Clear;
    qryDescontosV.SQL.Add('    SELECT DISTINCT ');
    qryDescontosV.SQL.Add('           COALESCE( ' + nometabela1 + '.TPDSC,' + QUOTEDSTR('Z') + ')         As TipoItem, ');
    qryDescontosV.SQL.Add('           COALESCE( ' + nometabela1 + '.TPDSCG,' + QUOTEDSTR('Z') + ')       As TipoGlobal,');
    qryDescontosV.SQL.Add('           coalesce(' + nometabela1 + '.USERIDAUT,' + quotedstr('Nulo') + ')    As USERIDAUT,');
    qryDescontosV.SQL.Add('           coalesce(SUM(' + nometabela2 + '.VRDSC),0 )   As ValorItem, ');
    qryDescontosV.SQL.Add('           coalesce(SUM(' + nometabela2 + '.VRDSCV),0)   As ValorGlobal, ');
    qryDescontosV.SQL.Add('           (    select trim(coalesce(PARAMETRO,' + quotedstr('DESCONTO NAO CADASTRADO') + ' ))');
    qryDescontosV.SQL.Add('                  from FC99999 ');
    qryDescontosV.SQL.Add('                 where ARGUMENTO=' + quotedstr('DESCONTOV'));
    qryDescontosV.SQL.Add('                   and subargum=' + nometabela1 + '.TPDSC) as  DESCRICAOTIPOITEM,');
    qryDescontosV.SQL.Add('           (    select trim(coalesce(PARAMETRO,' + quotedstr('DESCONTO NAO CADASTRADO') + ' )) ');
    qryDescontosV.SQL.Add('                  from FC99999 ');
    qryDescontosV.SQL.Add('                 where ARGUMENTO=' + quotedstr('DESCONTOV'));
    qryDescontosV.SQL.Add('                   and subargum=' + nometabela1 + '.TPDSCG) as DESCRICAOTIPOGLOBAL');
    qryDescontosV.SQL.Add('      FROM ' + nometabela1);
    qryDescontosV.SQL.Add('INNER JOIN ' + nometabela2);
    qryDescontosV.SQL.Add('        on (' + nometabela2 + '.CDFIL  = ' + nometabela1 + '.CDFIL) ');
    qryDescontosV.SQL.Add('       AND (' + nometabela2 + '.CDTML  = ' + nometabela1 + '.CDTML) ');
    qryDescontosV.SQL.Add('       AND (' + nometabela2 + '.DTOPE  = ' + nometabela1 + '.DTOPE) ');
    qryDescontosV.SQL.Add('       AND (' + nometabela2 + '.OPERID = ' + nometabela1 + '.OPERID) ');
    qryDescontosV.SQL.Add('       AND (' + nometabela2 + '.NRCPM  = ' + nometabela1 + '.NRCPM) ');
    qryDescontosV.SQL.Add('       AND (' + nometabela2 + '.TPITM  = ' + quotedstr('V') + ')');
    qryDescontosV.SQL.Add('     WHERE (' + nometabela1 + '.DTOPE >= ' + quotedstr(FormatDateTime('01.mm.yyyy', datainicial)) + ')');
    qryDescontosV.SQL.Add('       AND (' + nometabela1 + '.DTOPE <= ' + quotedstr(FormatDateTime('dd.mm.yyyy', IncDay(datafinal, -1))) + ')');
    qryDescontosV.SQL.Add('       AND (' + nometabela1 + '.CDFIL=' + edtLoja.Text + ')');
    qryDescontosV.SQL.Add('  GROUP BY ' + nometabela1 + '.TPDSC, ' + nometabela1 + '.TPDSCG,' + nometabela1 + '.USERIDAUT');
    qryDescontosV.SQL.Add('    Having Sum(' + nometabela2 + '.VRDSC + ' + nometabela2 + '.VRDSCV) > 0 ');

    qryDescontosV.Open;
    qryDescontosV.FetchAll;

    descontousadototal := 0;

    qryDescontosF.First;
    while not qryDescontosF.Eof do
    begin
      tipoitem := qryDescontosF.FieldValues['TIPOITEM'];
      tipoglobal := qryDescontosF.FieldValues['TIPOGLOBAL'];

      if (qryDescontosF.FieldValues['useridaut'] = null) or
         ((qryDescontosF.FieldValues['useridaut'] <> 'privilegefunc') and
         (qryDescontosF.FieldValues['useridaut'] <> 'privcortesia') and
         (qryDescontosF.FieldValues['useridaut'] <> USUARIO_PRIVILEGEM) and
         (qryDescontosF.FieldValues['useridaut'] <> 'projetocrm') and
         (qryDescontosF.FieldValues['useridaut'] <> 'hidratherapy') and
         (qryDescontosF.FieldValues['useridaut'] <> 'desconto2item') and
         (qryDescontosF.FieldValues['useridaut'] <> 'descpharmapele') and
         (qryDescontosF.FieldValues['useridaut'] <> USUARIO_FRANQUIA) and
         (trim(qryDescontosF.FieldValues['useridaut']) <> 'privblackf') and
         (trim(qryDescontosF.FieldValues['useridaut']) <> USUARIO_PRIV_CAMPANHA) and
         (qryDescontosF.FieldValues['useridaut'] <> 'diadasmaes')) then
      begin
        if (tipoitem <> '2') or (tipoglobal <> '2') then
        begin
          descontousadototal := descontousadototal + qryDescontosF.FieldValues['ValorItem'] + qryDescontosF.FieldValues['ValorGlobal'];
        end;
      end;
      qryDescontosF.Next;
    end;

    while not qryDescontosV.Eof do
    begin
      if qryDescontosV.FieldValues['TIPOITEM'] <> null then
        tipoitem := qryDescontosV.FieldValues['TIPOITEM']
      else
        tipoitem := 'Z';
      if qryDescontosV.FieldValues['TIPOGLOBAL'] <> null then
        tipoglobal := qryDescontosV.FieldValues['TIPOGLOBAL']
      else
        tipoglobal := 'Z';

      if (qryDescontosV.FieldValues['useridaut'] <> 'privilegefunc') and
         (qryDescontosV.FieldValues['useridaut'] <> 'privilegem') and
         (qryDescontosV.FieldValues['useridaut'] <> 'projetocrm') and
         (qryDescontosV.FieldValues['useridaut'] <> 'hidratherapy') and
         (qryDescontosF.FieldValues['useridaut'] <> 'desconto2item') and
         (qryDescontosV.FieldValues['useridaut'] <> 'descpharmapele') and
         (qryDescontosV.FieldValues['useridaut'] <> 'privcortesia') and
         (qryDescontosV.FieldValues['useridaut'] <> 'privblackf') and
         (trim(qryDescontosV.FieldValues['useridaut']) <> USUARIO_PRIV_CAMPANHA) and
         (qryDescontosV.FieldValues['useridaut'] <> 'diadasmaes') then
      begin
        if (tipoitem <> '1') then
          descontousadototal := descontousadototal + qryDescontosV.FieldValues['ValorItem'];
        if (tipoglobal <> '1') then
          descontousadototal := descontousadototal + qryDescontosV.FieldValues['ValorGlobal'];
      end;

      qryDescontosV.Next;
    end;

    qryFcertaTEMP.Close;
    qryFcertaTEMP.SQL.Clear;
    qryFcertaTEMP.SQL.Add(' select count(distinct dtope) as QTD ');
    qryFcertaTEMP.SQL.Add('   from fc31100 ');
    qryFcertaTEMP.SQL.Add('  where cdfil=' + edtLoja.Text);
    qryFcertaTEMP.SQL.Add('    and dtope between ' + quotedstr(FormatDateTime('01.mm.yyyy', datainicial)));
    qryFcertaTEMP.SQL.Add('    and ' + quotedstr(FormatDateTime('dd.mm.yyyy', incday(datafinal, -1))));
    qryFcertaTEMP.Open;

    qtdiasusados := qryFcertaTEMP.FieldValues['QTD'];
    valtotdescparcial := (valordiario * qtdiasusados) + acresacu - descontousadototal;

    if valtotdescparcial < 0 then
      descontousado := descontousado + (abs(valtotdescparcial))
    else
      lblDescMeta.Caption := CurrToStr(StrToCurr(lblDescMeta.Caption) + valtotdescparcial);

      //DESCONTO TOTAL - ACUMULO
    lblDescMeta.Caption := FormatFloat('#####0.00', StrToCurr(lblDescMeta.Caption));//   lblDescUsado.Caption := CurrToStr( descontousado);
    lblDescUsado.Caption := FormatFloat('#####0.00', descontousado);//   lblDescUsado.Caption := CurrToStr( descontousado);
    lblSaldoDesc.Caption := FormatFloat('#####0.00', StrToCurr(lblDescMeta.Caption) + StrToCurr(lblAcrescimo.Caption) - StrToCurr(lblDescUsado.Caption));// lblSaldoDesc.Caption := CurrToStr( StrToCurr( lblDescMeta.Caption  ) - StrToCurr(lblDescUsado.Caption)  );
  end;
end;

procedure TfrmPrincipal.B1Click(Sender: TObject);
begin
  frmBuscaClienteDesconto.ShowModal;
end;

procedure TfrmPrincipal.alimentacombo;
begin
  if rgtpDesc.ItemIndex = 0 then
  begin
    btInsereDesconto.Width := 90;
    btInsereDesconto.Caption := 'Desc. Fórmula';
    btInsereDescVarejo.Visible := true;

    gbsubDesc.Caption := 'Descrição Desconto';

    qryFcertaTEMP.Close;
    qryFcertaTEMP.SQL.Clear;
    qryFcertaTEMP.SQL.Add('   SELECT substring(trim(PARAMETRO) ');
    qryFcertaTEMP.SQL.Add('     from 1 for  position ( ' + quotedstr('-') + ' in parametro)-1    )  as DESCRICAO ');
    qryFcertaTEMP.SQL.Add('     FROM fc99999 ');
    qryFcertaTEMP.SQL.Add('    WHERE (argumento = ' + quotedstr('DESCONTOV'));
    qryFcertaTEMP.SQL.Add('       or    argumento = ' + QuotedStr('DESCONTOR') + ' )');
    qryFcertaTEMP.SQL.Add('      and  PARAMETRO like ' + quotedstr('%-%'));
    qryFcertaTEMP.SQL.Add(' group by 1 order by 1 ');
    qryFcertaTEMP.Open;

    cbDescontoTipo.Clear;
    while not qryFcertaTEMP.eof do
    begin
      if trim(qryFcertaTEMP.FieldValues['DESCRICAO']) <> 'MÉDICOS E NUTRICIONISTAS' then
        cbDescontoTipo.Items.Add(qryFcertaTEMP.FieldValues['DESCRICAO']);
      qryFcertaTEMP.next;
    end;

    cbDescontoTipo.Items.Add('CORTESIA');
    cbDescontoTipo.Items.Add('NEGOCIAÇÃO LOJA');
    cbDescontoTipo.Items.Add('CONSULTORIA PREMIUM');

    qryFcertaTEMP.Close;
  end
  else
  begin

    lblPercDesconto.Visible := false;
    lblPercForm.Visible := false;
    lblPercVar.Visible := false;

    btInsereDesconto.Width := 180;
    if rgtpDesc.ItemIndex = 11 then
      btInsereDesconto.Caption := 'Remover Desconto'
    else
      btInsereDesconto.Caption := 'Inserir Desconto';

    btInsereDescVarejo.Visible := false;

    gbsubDesc.Caption := 'Parentesco';
    cbDescontoTipo.Items.Text := '01 - Titular' + #13 +
                                 '02 - Conjugue' + #13 +
                                 '03 - Filho(a)' + #13 +
                                 '04 - Pai/Mãe' + #13 +
                                 '05 - Paciente' + #13 +
                                 '06 - Genro/Nora' + #13 +
                                 '07 - Irmão/Irmã' + #13 +
                                 '08 - Sobrinho(a)' + #13 +
                                 '09 - Cunhado(a)' + #13 +
                                 '10 - Primo(a)' + #13 +
                                 '11 - Avô/Avó' + #13 +
                                 '12 - Neto(a)' + #13 +
                                 '13 - Amigo(a)';
  end;
end;

procedure TfrmPrincipal.rgtpDescClick(Sender: TObject);
begin
  alimentacombo;
end;

procedure tfrmPrincipal.descprodautomatic;
var
  i: integer;
  prods, cdpro: string;
  vrprod, valordescun: double;
begin
  qryPrivilegeTEMP.Close;
  qryPrivilegeTEMP.SQL.Clear;
  qryPrivilegeTEMP.SQL.Add(' select * ');
  qryPrivilegeTEMP.SQL.Add('   from desccampanhas a ');
  qryPrivilegeTEMP.SQL.Add('  where cdfil in (' + edtLoja.Text + ',1) ');
  qryPrivilegeTEMP.SQL.Add('    and current_date between dtinic ');
  qryPrivilegeTEMP.SQL.Add('    and dtfin ');
  qryPrivilegeTEMP.Open;

  if not (qryPrivilegeTEMP.IsEmpty) then
  begin
    qryConsultaDescPrivilege.Close;
    qryConsultaDescPrivilege.SQL.Clear;
    qryConsultaDescPrivilege.SQL.Add(' select * ');
    qryConsultaDescPrivilege.SQL.Add('   from fc32110 ');
    qryConsultaDescPrivilege.SQL.Add('  where cdfil=' + edtLoja.Text);
    qryConsultaDescPrivilege.SQL.Add('    and nrcpm=' + edtTerminalBalcao.Text);
    qryConsultaDescPrivilege.SQL.Add('    and cdpro in (0');

    while not qryPrivilegeTEMP.eof do
    begin
      qryConsultaDescPrivilege.SQL.Add(', ' + inttostr(qryPrivilegeTEMP.FieldValues['cdpro']));
      qryPrivilegeTEMP.Next;
    end;

    qryConsultaDescPrivilege.SQL.Add(' )');
    qryConsultaDescPrivilege.Open;

    if not (qryConsultaDescPrivilege.IsEmpty) then
    begin
      if MessageDlg('Deseja confirmar desconto automático relativo ao Liquida Recife?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
      begin

        while not (qryConsultaDescPrivilege.Eof) do
        begin

          if qryPrivilegeTEMP.Locate('CDPRO', qryConsultaDescPrivilege.FieldValues['cdpro'], []) then
          begin
            cdpro := inttostr(qryConsultaDescPrivilege.FieldValues['cdpro']);
            vrprod := qryConsultaDescPrivilege.FieldValues['vrprod'];
            valordescun := qryConsultaDescPrivilege.FieldValues['vrdsc'];

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' update fc32110 ');
            qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr((valordescun * 100) / vrprod)) + ', ');
            qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
            qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
            qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
            qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')), ');
            qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
            qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
            qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
            qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
            qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
            qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
            qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
            qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
            qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
            qryInsereDesconto.SQL.Add('    and cdpro in (' + cdpro + ')');

            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.CommitRetaining;
            qryInsereDesconto.Close;

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
            qryInsereDesconto.SQL.Add('   from fc32110 ');
            qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text) );
            qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
            qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
            qryInsereDesconto.Open;

            valortotal := qryInsereDesconto.FieldValues['VALOR'];

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' update fc32100 ');
            qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('descpharmapele') + ', ');
            qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
            qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
            qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
            qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ' ');
            qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
            qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
            qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.CommitRetaining;
            qryInsereDesconto.Close;
          end;
        end;
        showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
      end;
    end;
  end;
  qryPrivilegeTEMP.Close;
end;

procedure TfrmPrincipal.edtTerminalBalcaoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, #13]) then
    Key := #0
  else
    qryTerminalBalcao.Close;

  if Key = #13 then
  begin
    if trim(edtTerminalBalcao.Text) <> '' then
    begin
      alimentacombo;
      localizarbalcao(edtTerminalBalcao.Text);
      frmDescontosAplicados.CDS.EmptyDataSet;
      atualizameta;
    end;

    cbDescontoTipo.ItemIndex := -1;
  end;
end;

procedure TfrmPrincipal.EmissoCodBarrasGerentes1Click(Sender: TObject);
begin
  frmCodBarrasGerente.ShowModal;
end;

procedure TfrmPrincipal.DescontoPromocional3;
 var valortotal,valdesc,valorunitdesc : double;
              p,i,q,q2 : integer;
begin
  lblDescontoValor.Caption := '0';
  p := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = 5049) or (qryTerminalBalcao.FieldValues['CDPRO'] = 3080) or (qryTerminalBalcao.FieldValues['CDPRO'] = 3287) or (qryTerminalBalcao.FieldValues['CDPRO'] = 4060) then
    begin
      p := p + qryTerminalBalcao.FieldValues['QUANT'];
    end;
    qryTerminalBalcao.next;
  end;

  if (p < 2) then
    raise exception.create('Não existem produtos suficientes da campanha CABELOS nessa venda. Total:' + inttostr(p));

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add('   select a.cdpro as COD, a.quant, a.pruni,a.vrtot ');
  qryFcertaTEMP.SQL.Add('     from fc32110 a ');
  qryFcertaTEMP.SQL.Add('    where a.dtope=current_date ');
  qryFcertaTEMP.SQL.Add('      and a.cdfil=' + edtLoja.Text);
  qryFcertaTEMP.SQL.Add('      and a.nrcpm=' + edtTerminalBalcao.Text);
  qryFcertaTEMP.SQL.Add('      and a.tpitm=' + quotedstr('V'));
  qryFcertaTEMP.SQL.Add('      and a.cdpro in (5049,3080,3287,4060) ');
  qryFcertaTEMP.SQL.Add(' order by 3 ');
  qryFcertaTEMP.Open;

  p := (p div 2);
  q := p;
  valdesc := 0;

  for i := 1 to qryFcertaTEMP.RecordCount do
  begin
    while q > 0 do
    begin
      q2 := qryFcertaTEMP.FieldValues['quant'];

      while (q2 > 0) and (q > 0) do
      begin
        valdesc := valdesc + (qryFcertaTEMP.FieldValues['PRUNI'] * 0.20);
        q2 := q2 - 1;
        q := q - 1;
      end;
      qryFcertaTEMP.Next;
    end;
  end;

  lblDescontoValor.Caption := TrocaVirgPPto(floattostr(valdesc));

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo a campanha Cabelos?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      desc2var := 20;

      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.sql.Clear;
      qrySelecionaDesconto.sql.Add('    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, a.TPDSC, ');
      qrySelecionaDesconto.sql.Add('           a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG,  ');
      qrySelecionaDesconto.sql.Add('           coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ  ');
      qrySelecionaDesconto.sql.Add('      from fc32110 a ');
      qrySelecionaDesconto.sql.Add(' left join fc32200 b ');
      qrySelecionaDesconto.sql.Add('        on ( a.cdfil=b.cdfil and a.cdtml=b.cdtml ');
      qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
      qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
      qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid )  ');
      qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qrySelecionaDesconto.sql.Add('       and a.dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qrySelecionaDesconto.sql.Add('       and a.tpitm=' + quotedstr('V'));
      qrySelecionaDesconto.sql.Add('       and a.cdpro in (5049,3080,3287,4060) ');
      qrySelecionaDesconto.sql.Add('  order by a.PRUNILIQ');
      qrySelecionaDesconto.Open;
      qrySelecionaDesconto.FetchAll;
      qrySelecionaDesconto.First;

      q := p;
      valdesc := 0;
      tpdescvar := '3';

      while not qrySelecionaDesconto.Eof do
      begin
        while q > 0 do
        begin
          q2 := qrySelecionaDesconto.FieldValues['quant'];

          while (q2 > 0) and (q > 0) do
          begin
            valorunitdesc := (qrySelecionaDesconto.FieldValues['PRUNILIQ'] * desc2var) / 100;

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' update fc32110 ');
            qryInsereDesconto.SQL.Add('    set tpdsc = ' + quotedstr(tpdescvar) + ', ');
            qryInsereDesconto.SQL.Add('        ptdsc = ' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
            qryInsereDesconto.SQL.Add('        pruniliq = pruniliq-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
            qryInsereDesconto.SQL.Add('        vrcxa = vrcxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
            qryInsereDesconto.SQL.Add('        vrliq = vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
            qryInsereDesconto.SQL.Add('        vrdsc = ' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
            qryInsereDesconto.SQL.Add('        BCICM = VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)));
            qryInsereDesconto.SQL.Add('  where cdfil = ' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
            qryInsereDesconto.SQL.Add('    and cdtml = ' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
            qryInsereDesconto.SQL.Add('    and dtope = ' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
            qryInsereDesconto.SQL.Add('    and operid = ' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
            qryInsereDesconto.SQL.Add('    and nrcpm = ' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
            qryInsereDesconto.SQL.Add('    and itemid = ' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.CommitRetaining;
            qryInsereDesconto.Close;
            q2 := q2 - 1;
            q := q - 1;
          end;
          qrySelecionaDesconto.Next;

        end;
        qrySelecionaDesconto.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;
      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Text := 'update fc32100 set useridaut=' + quotedstr('privcabelos') + ', vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ',vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ' where  cdfil=' + trim(frmPrincipal.edtLoja.Text) + ' and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text) + ' and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;
      qryInsereDesconto.Close;
      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
      qrySelecionaDesconto.Close;
    end;
  end;
end;


procedure TfrmPrincipal.DescontoPromocional4;
var
  valortotal, valordescun, valordesctot: double;
  i, p, qtdesc, quantitm, quantitmvenda: integer;
begin
  lblDescontoValor.Caption := '0';
  p := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = 7691) then
    begin
      quantitmvenda := quantitmvenda + qryTerminalBalcao.FieldValues['QUANT'];
    end;
    next;
  end;

  if (quantitmvenda < 1) then
    raise exception.create('Não existe bolsa ECOBAG nesta venda.');

  if MessageDlg('Deseja confirmar desconto para bolsa ECOBAG?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
  begin
    tpdescvar := '8';

    //DESCONTO CAMPANHA;
    qrySelecionaDesconto.Close;
    qrySelecionaDesconto.SQL.Clear;
    qrySelecionaDesconto.SQL.Add(' select * ');
    qrySelecionaDesconto.SQL.Add('   from fc32110 ');
    qrySelecionaDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
    qrySelecionaDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qrySelecionaDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qrySelecionaDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qrySelecionaDesconto.SQL.Add('    and cdpro in (7691)');
    qrySelecionaDesconto.Open;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' select SUM(VRDSC) as VRDSC ');
    qryInsereDesconto.SQL.Add('   from fc32110 ');
    qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
    qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.SQL.Add('    and cdpro in (7691)');
    qryInsereDesconto.Open;

    valordescun := qryInsereDesconto.FieldValues['VRDSC'];

    if valordescun > 0 then
      raise Exception.Create('Bolsa Ecobag já possui desconto');

    valordescun := 0;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' select SUM(VRLIQ) as VRLIQ ');
    qryInsereDesconto.SQL.Add('   from fc32110 ');
    qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
    qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.SQL.Add('    and cdpro not in (7691)');
    qryInsereDesconto.Open;

    valordescun := qryInsereDesconto.FieldValues['VRLIQ'];

    if valordescun < 160 then
      raise Exception.Create('É necessário uma compra de varejo de pelo menos R$ 160,00' + #13 + ' para participar da promoção');

    quantitm := trunc(valordescun) div 160;

    qrySelecionaDesconto.FetchAll;

    while quantitmvenda > 0 do
    begin
      p := qrySelecionaDesconto.FieldValues['QUANT'];

      while p > 0 do
      begin
        if quantitm > 0 then
        begin
          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
          qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(99.75)) + ' , ');
          qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(39.8)) + '), ');
          qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(39.80)) + ', ');
          qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(39.8)) + ', ');
          qryInsereDesconto.SQL.Add('        vrdsc=vrdsc+' + TrocaVirgPPto(floattostr(39.8)) + ', ');
          qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(39.8)));
          qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
          qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
          qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
          qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));

          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
          qryInsereDesconto.Close;
          quantitm := quantitm - 1;
        end;

        p := p - 1;
        quantitmvenda := quantitmvenda - 1;
      end;
      qrySelecionaDesconto.Next;
    end;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
    qryInsereDesconto.SQL.Add('   from fc32110 ');
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.Open;
    valortotal := qryInsereDesconto.FieldValues['VALOR'];
    qryInsereDesconto.Close;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update fc32100 ');
    qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('privilebag') + ', ');
    qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.CommitRetaining;
    qryInsereDesconto.Close;

    showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    qrySelecionaDesconto.Close;
  end;
end;

procedure TfrmPrincipal.DescontoSorvete;
var
  valortotal, valordescun, valordesctot, ptdescun: double;
  i, p, qtdesc, quantitm, quantitmvenda: integer;
begin
  lblDescontoValor.Caption := '0';
  p := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = 8186) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 8188) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 8189) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 8190) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 8191) then
    begin
      quantitmvenda := quantitmvenda + qryTerminalBalcao.FieldValues['QUANT'];
    end;
    qryTerminalBalcao.Next;
  end;

  if (quantitmvenda < 1) then
    raise exception.create('Não existem sorvetes nesta venda.');

  if MessageDlg('Deseja confirmar desconto da campanha Frisabor?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
  begin
    //DESCONTO CAMPANHA;
    tpdescvar := '8';

    qrySelecionaDesconto.Close;
    qrySelecionaDesconto.SQL.Clear;
    qrySelecionaDesconto.SQL.Add(' select * ');
    qrySelecionaDesconto.SQL.Add('   from fc32110 ');
    qrySelecionaDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qrySelecionaDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qrySelecionaDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qrySelecionaDesconto.SQL.Add('    and cdpro in (8186,8188,8189,8190,8191)');
    qrySelecionaDesconto.Open;

    valordescun := 0;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' select SUM(VRLIQ) as VRLIQ ');
    qryInsereDesconto.SQL.Add('   from fc32110 ');
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.SQL.Add('    and cdpro not in (8186,8188,8189,8190,8191)');
    qryInsereDesconto.Open;

    valordescun := qryInsereDesconto.FieldValues['VRLIQ'];

    if valordescun < 250 then
      raise Exception.Create('É necessário uma compra de pelo menos R$ 250,00' + #13 + ' para participar da promoção');

    quantitm := trunc(valordescun) div 250;
    qrySelecionaDesconto.FetchAll;

    while quantitmvenda > 0 do
    begin
      p := qrySelecionaDesconto.FieldValues['QUANT'];

      while p > 0 do
      begin
        valordescun := qrySelecionaDesconto.FieldValues['VRLIQ'];

        if valordescun < 4.10 then
        begin
          valordescun := valordescun - 0.1;
          ptdescun := 97.5;
        end
        else
        begin
          ptdescun := (3.89 * 100) / valordescun;
          valordescun := 3.89;
        end;

        if quantitm > 0 then
        begin
          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
          qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(97.50)) + ' , ');
          qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(valordescun)) + ', ');
          qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(valordescun)) + ', ');
          qryInsereDesconto.SQL.Add('        vrdsc=vrdsc+' + TrocaVirgPPto(floattostr(valordescun)) + ', ');
          qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(valordescun)));
          qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
          qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
          qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
          qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));

          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
          qryInsereDesconto.Close;
          quantitm := quantitm - 1;
        end;

        p := p - 1;
        quantitmvenda := quantitmvenda - 1;
      end;
      qrySelecionaDesconto.Next;
    end;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
    qryInsereDesconto.SQL.Add('   from fc32110 ');
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.Open;
    valortotal := qryInsereDesconto.FieldValues['VALOR'];

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update fc32100 ');
    qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('privilebag') + ', ');
    qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.CommitRetaining;
    qryInsereDesconto.Close;

    showmessage('DESCONTO CONCEDIDO COM SUCESSO!');

    qrySelecionaDesconto.Close;
  end;
end;

procedure TfrmPrincipal.E1Click(Sender: TObject);
begin
  frmCartaoCampanha.ShowModal;
end;

procedure TfrmPrincipal.menu_EnvioSMSClientesClick(Sender: TObject);
begin
  frmEnvioSMS.ShowModal;
end;

procedure TfrmPrincipal.DescontoPromocional5;
var
  valortotal, valordescun, valordesctot: double;
  i, p, qtdesc, quantitm, quantitmvenda: integer;
begin
  lblDescontoValor.Caption := '0';
  p := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = 7691) then
    begin
      quantitmvenda := quantitmvenda + qryTerminalBalcao.FieldValues['QUANT'];
    end;
    qryTerminalBalcao.Next;
  end;

  if (quantitmvenda < 1) then
    raise exception.create('Não existe bolsa ECOBAG nesta venda.');

  if MessageDlg('Deseja confirmar desconto para bolsa ECOBAG?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
  begin
    //DESCONTO CAMPANHA;
    tpdescvar := '8';

    qrySelecionaDesconto.Close;
    qrySelecionaDesconto.SQL.Clear;
    qrySelecionaDesconto.SQL.Add(' select * ');
    qrySelecionaDesconto.SQL.Add('   from fc32110 ');
    qrySelecionaDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
    qrySelecionaDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qrySelecionaDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qrySelecionaDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qrySelecionaDesconto.SQL.Add('    and cdpro in (7691)');
    qrySelecionaDesconto.Open;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' select SUM(VRDSC) as VRDSC ');
    qryInsereDesconto.SQL.Add('   from fc32110 ');
    qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
    qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.SQL.Add('    and cdpro in (7691)');
    qryInsereDesconto.Open;

    valordescun := qryInsereDesconto.FieldValues['VRDSC'];

    if valordescun > 0 then
      raise Exception.Create('Bolsa Ecobag já possui desconto');

    valordescun := 0;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' select SUM(VRLIQ) as VRLIQ, SUM(QUANT) as QUANT ');
    qryInsereDesconto.SQL.Add('   from fc32110 ');
    qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
    qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.SQL.Add('    and cdpro in (2662,3929,5553,3949,3948,3678)');
    qryInsereDesconto.Open;

    if (qryInsereDesconto.FieldValues['VRLIQ'] = null) then
      raise exception.create('Não existe Privilege nesta venda.');

    valordescun := 160 * qryInsereDesconto.FieldValues['QUANT'];

    if valordescun < 160 then
      raise Exception.Create('É necessário uma compra de varejo de pelo menos R$ 160,00' + #13 + ' para participar da promoção');

    quantitm := trunc(valordescun) div 160;

    qrySelecionaDesconto.FetchAll;

    while quantitmvenda > 0 do
    begin
      p := qrySelecionaDesconto.FieldValues['QUANT'];

      while p > 0 do
      begin
        if quantitm > 0 then
        begin
          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
          qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(99.75)) + ' , ');
          qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(39.8)) + '), ');
          qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(39.80)) + ', ');
          qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(39.8)) + ', ');
          qryInsereDesconto.SQL.Add('        vrdsc=vrdsc+' + TrocaVirgPPto(floattostr(39.8)) + ', ');
          qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(39.8)));
          qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
          qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
          qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
          qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));

          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
          qryInsereDesconto.Close;
          quantitm := quantitm - 1;
        end;

        p := p - 1;
        quantitmvenda := quantitmvenda - 1;
      end;
      qrySelecionaDesconto.Next;
    end;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
    qryInsereDesconto.SQL.Add('   from fc32110 ');
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.Open;
    valortotal := qryInsereDesconto.FieldValues['VALOR'];

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update fc32100 ');
    qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
    qryInsereDesconto.SQL.Add('        useridaut=' + quotedstr('privilebagprivage') + ', ');
    qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.ExecSQL;

    qryInsereDesconto.Connection.CommitRetaining;
    qryInsereDesconto.Close;
    showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    qrySelecionaDesconto.Close;
  end;
end;

procedure TfrmPrincipal.D1Click(Sender: TObject);
begin
  frmCadDescontoCliente.ShowModal;
end;

procedure TfrmPrincipal.DescontoBlackFriday;
var
  valortotal, valdesc, valorunitdesc: double;
  p, i, q, q2, qt1, qt2, qt3, qt4, qt5, qt6: integer;
begin
  lblDescontoValor.Caption := '0';
  p := 0;
  qt1 := 0;
  qt2 := 0;
  qt3 := 0;
  qt4 := 0;
  qt5 := 0;
  qt6 := 0;

  qryTerminalBalcao.First;
  while not EOF do
  begin
    if ((qryTerminalBalcao.FieldValues['CDPRO'] = 3770) or (qryTerminalBalcao.FieldValues['CDPRO'] = 3768) or (qryTerminalBalcao.FieldValues['CDPRO'] = 3767)) then
    begin
      qt1 := qt1 + qryTerminalBalcao.FieldValues['QUANT'];
    end;
    next;
  end;

  qryTerminalBalcao.First;
  if qt1 > 0 then
  begin
    while not qryTerminalBalcao.EOF do
    begin
      if ((qryTerminalBalcao.FieldValues['CDPRO'] = 3774) or (qryTerminalBalcao.FieldValues['CDPRO'] = 3775) or (qryTerminalBalcao.FieldValues['CDPRO'] = 3776)) then
      begin
        qt2 := qt2 + qryTerminalBalcao.FieldValues['QUANT'];
      end;
      qryTerminalBalcao.next;
    end;
  end;

  qryTerminalBalcao.First;
  if (qt1 > 0) and (qt2 > 0) then
  begin
    while not qryTerminalBalcao.EOF do
    begin
      if ((qryTerminalBalcao.FieldValues['CDPRO'] = 3772) or (qryTerminalBalcao.FieldValues['CDPRO'] = 3771) or (qryTerminalBalcao.FieldValues['CDPRO'] = 3769)) then
      begin
        qt3 := qt3 + qryTerminalBalcao.FieldValues['QUANT'];
      end;
      qryTerminalBalcao.next;
    end;
  end;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if ((qryTerminalBalcao.FieldValues['CDPRO'] = 4377) or (qryTerminalBalcao.FieldValues['CDPRO'] = 4373)) then
    begin
      qt4 := qt4 + qryTerminalBalcao.FieldValues['QUANT'];
    end;
    qryTerminalBalcao.next;
  end;

  qryTerminalBalcao.First;
  if qt4 > 0 then
  begin
    while not qryTerminalBalcao.EOF do
    begin
      if ((qryTerminalBalcao.FieldValues['CDPRO'] = 4378) or (qryTerminalBalcao.FieldValues['CDPRO'] = 4374)) then
      begin
        qt5 := qt5 + qryTerminalBalcao.FieldValues['QUANT'];
      end;
      qryTerminalBalcao.next;
    end;
  end;

  qryTerminalBalcao.First;
  if (qt4 > 0) and (qt5 > 0) then
  begin
    while not qryTerminalBalcao.EOF do
    begin
      if ((qryTerminalBalcao.FieldValues['CDPRO'] = 4379) or (qryTerminalBalcao.FieldValues['CDPRO'] = 4375)) then
      begin
        qt6 := qt6 + qryTerminalBalcao.FieldValues['QUANT'];
      end;
      qryTerminalBalcao.next;
    end;
  end;

  if ((qt1 < 1) or (qt2 < 1) or (qt3 < 1)) then
  begin
    if ((qt4 < 1) or (qt5 < 1) or (qt6 < 1)) then
      raise exception.create('Não existem produtos suficientes da campanha Black Friday nessa venda. ');
  end;

  valdesc := 0;

  if ((qt1 > 0) and (qt2 > 0) and (qt3 > 0)) then
  begin
    qryFcertaTEMP.Close;
    qryFcertaTEMP.SQL.Clear;
    qryFcertaTEMP.SQL.Add('   select a.cdpro as COD, a.quant, a.pruni ,a.vrtot ');
    qryFcertaTEMP.SQL.Add('     from fc32110 a ');
    qryFcertaTEMP.SQL.Add('    where a.dtope=current_date ');
    qryFcertaTEMP.SQL.Add('      and a.cdfil=' + edtLoja.Text);
    qryFcertaTEMP.SQL.Add('      and a.nrcpm=' + edtTerminalBalcao.Text);
    qryFcertaTEMP.SQL.Add('      and a.tpitm=' + quotedstr('V'));
    qryFcertaTEMP.SQL.Add('      and a.cdpro in (3772,3771,3769) ');
    qryFcertaTEMP.SQL.Add(' order by 3 ');
    qryFcertaTEMP.Open;

    while not qryFcertaTEMP.eof do
    begin
      valdesc := valdesc + (41 * qryFcertaTEMP.FieldValues['quant']);
      qryFcertaTEMP.Next;
    end;
  end;

  if ((qt4 > 0) and (qt5 > 0) and (qt6 > 0)) then
  begin
    qryFcertaTEMP.Close;
    qryFcertaTEMP.SQL.Clear;
    qryFcertaTEMP.SQL.Add('   select a.cdpro as COD, a.quant, a.pruni,a.vrtot ');
    qryFcertaTEMP.SQL.Add('     from fc32110 a ');
    qryFcertaTEMP.SQL.Add('    where a.dtope=current_date ');
    qryFcertaTEMP.SQL.Add('      and a.cdfil=' + edtLoja.Text);
    qryFcertaTEMP.SQL.Add('      and a.nrcpm=' + edtTerminalBalcao.Text);
    qryFcertaTEMP.SQL.Add('      and a.tpitm=' + quotedstr('V'));
    qryFcertaTEMP.SQL.Add('      and a.cdpro in (4377,4373,4378,4374,4379,4375) ');
    qryFcertaTEMP.SQL.Add(' order by 3 ');
    qryFcertaTEMP.Open;

    while not qryFcertaTEMP.eof do
    begin
      valdesc := valdesc + (38.1 * qryFcertaTEMP.FieldValues['quant']);
      qryFcertaTEMP.next;
    end;
  end;

  lblDescontoValor.Caption := TrocaVirgPPto(floattostr(valdesc));

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo a campanha Black Friday?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      if ((qt1 > 0) and (qt2 > 0) and (qt3 > 0)) then
      begin
        desc2var := 80.55;

        qrySelecionaDesconto.Close;
        qrySelecionaDesconto.sql.Clear;
        qrySelecionaDesconto.sql.Add('    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, ');
        qrySelecionaDesconto.sql.Add('           a.TPDSC, a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, ');
        qrySelecionaDesconto.sql.Add('           coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ');
        qrySelecionaDesconto.sql.Add('      from fc32110 a ');
        qrySelecionaDesconto.sql.Add(' left join fc32200 b ( ');
        qrySelecionaDesconto.sql.Add('        on a.cdfil=b.cdfil ');
        qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
        qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
        qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
        qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
        qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ');
        qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
        qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
        qrySelecionaDesconto.sql.Add('       and a.dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
        qrySelecionaDesconto.sql.Add('       and a.tpitm=' + quotedstr('V'));
        qrySelecionaDesconto.sql.Add('       and a.cdpro in (3772,3771,3769) ');
        qrySelecionaDesconto.sql.Add('  order by a.PRUNILIQ');
        qrySelecionaDesconto.Open;
        qrySelecionaDesconto.FetchAll;
        qrySelecionaDesconto.First;

        valdesc := 0;
        tpdescvar := '3';

        while not qrySelecionaDesconto.Eof do
        begin
          valorunitdesc := (qrySelecionaDesconto.FieldValues['PRUNILIQ'] * (desc2var / 100));

          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
          qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
          qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
          qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
          qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
          qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
          qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)));
          qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
          qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
          qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
          qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
          qrySelecionaDesconto.Next;
        end;
      end;

      if ((qt4 > 0) and (qt5 > 0) and (qt6 > 0)) then
      begin
        desc2var := 79.37;

        qrySelecionaDesconto.Close;
        qrySelecionaDesconto.sql.Clear;
        qrySelecionaDesconto.sql.Add('    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, a.TPDSC, ');
        qrySelecionaDesconto.sql.Add('           a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, coalesce( b.vrtot, a.VRTOT) as VRTOT, ');
        qrySelecionaDesconto.sql.Add('           a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ');
        qrySelecionaDesconto.sql.Add('      from fc32110 a ');
        qrySelecionaDesconto.sql.Add(' left join fc32200 b ');
        qrySelecionaDesconto.sql.Add('        on ( a.cdfil=b.cdfil ');
        qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
        qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
        qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
        qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
        qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ');
        qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
        qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
        qrySelecionaDesconto.sql.Add('       and a.dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
        qrySelecionaDesconto.sql.Add('       and a.tpitm=' + quotedstr('V'));
        qrySelecionaDesconto.sql.Add('       and a.cdpro in (4379,4375) ');
        qrySelecionaDesconto.sql.Add('  order by a.PRUNILIQ');
        qrySelecionaDesconto.Open;
        qrySelecionaDesconto.FetchAll;
        qrySelecionaDesconto.First;

        valdesc := 0;
        tpdescvar := '3';

        while not qrySelecionaDesconto.Eof do
        begin
          valorunitdesc := (qrySelecionaDesconto.FieldValues['PRUNILIQ'] * (desc2var / 100));

          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
          qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
          qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
          qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
          qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
          qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
          qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)));
          qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
          qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
          qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
          qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;

          qrySelecionaDesconto.Next;
        end;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add('    select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('      from fc32110 ');
      qryInsereDesconto.SQL.Add('     where  cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('       and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('       and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add('    update fc32100 ');
      qryInsereDesconto.SQL.Add('       set useridaut=' + quotedstr('privcabelos') + ', ');
      qryInsereDesconto.SQL.Add('           vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('           vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('           vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('           vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('     where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('       and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('       and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
      qrySelecionaDesconto.Close;
    end;
  end;
end;

procedure TfrmPrincipal.DescontoCabelos;
var
  valortotal, valordescun, vrprod: double;
  p, p1: integer;
  codprod: string;
begin
  lblDescontoValor.Caption := '0';
  p := 0;
  p1 := 0;
  vrprod := 0;
  codprod := '';

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin

    if (qryTerminalBalcao.FieldValues['vrdsc'] > 0) then
      raise Exception.Create('Venda Já possui Desconto');

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 10604) or (qryTerminalBalcao.FieldValues['CDPRO'] = 10606) or (qryTerminalBalcao.FieldValues['CDPRO'] = 10603) or (qryTerminalBalcao.FieldValues['CDPRO'] = 14292) then
    begin

      p := p + qryTerminalBalcao.FieldValues['QUANT'];

      codprod := codprod + IntToStr(qryTerminalBalcao.FieldValues['CDPRO']) + ',';
      vrprod := vrprod + qryTerminalBalcao.FieldValues['PRUNI'];

    end;

    qryTerminalBalcao.next;
  end;

  if (p < 3) then
    raise exception.create('Quantidade Inválida');

  codprod := codprod + '0';
  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 0.15)));
  valordescun := (vrprod * 0.15);

  if (lblDescontoValor.Caption <> '0') then
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo Promoção Cabelos?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
      qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    vrprod := 0;
    vrprod := vrprod + qryTerminalBalcao.FieldValues['PRUNI'];
    codprod := '0';

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 10604) or (qryTerminalBalcao.FieldValues['CDPRO'] = 10606) or (qryTerminalBalcao.FieldValues['CDPRO'] = 10603) or (qryTerminalBalcao.FieldValues['CDPRO'] = 14292) then
    begin
      codprod := codprod + IntToStr(qryTerminalBalcao.FieldValues['CDPRO']);
    end
    else
    begin
      codprod := '0';
    end;

    valordescun := (vrprod * 0.15);

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update fc32110 ');
    qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(15)) + ',  ');
    qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
    qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
    qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
    qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
    qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
    qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
    qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
    qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
    qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
    qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
    qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.SQL.Add('    and cdpro = ' + codprod + '');

    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.CommitRetaining;

    qryTerminalBalcao.next;
  end;

  qryInsereDesconto.Close;
  qryInsereDesconto.SQL.Clear;
  qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
  qryInsereDesconto.SQL.Add('   from fc32110 ');
  qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
  qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
  qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
  qryInsereDesconto.Open;
  valortotal := qryInsereDesconto.FieldValues['VALOR'];
  qryInsereDesconto.Close;

  qryInsereDesconto.Close;
  qryInsereDesconto.SQL.Clear;
  qryInsereDesconto.SQL.Add(' update fc32100 ');
  qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('Cabelos') + ', ');
  qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
  qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
  qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
  qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
  qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
  qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
  qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
  qryInsereDesconto.ExecSQL;
  qryInsereDesconto.Connection.CommitRetaining;

  showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
end;

procedure TfrmPrincipal.LipGloss15;
var
  valortotal, valordescun, vrprod: double;
  p, p1, codprod: integer;
begin
  lblDescontoValor.Caption := '0';
  p := 0;
  p1 := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['vrdsc'] > 0) then
      raise Exception.Create('Venda Já possui Desconto');

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 14631) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 14632) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 14633) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 11403) then
    begin
      p := p + qryTerminalBalcao.FieldValues['QUANT'];

    end;

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 14631) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 14632) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 14633) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 11403) then
    begin
      vrprod := qryTerminalBalcao.FieldValues['PRUNI'];
      codprod := qryTerminalBalcao.FieldValues['CDPRO'];
    end;
    qryTerminalBalcao.next;
  end;

  if (p < 3) then
    raise exception.create('Não existem produtos suficientes para desconto LipGloss 15% na venda. Total:' + inttostr(p));

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 1)));
  valordescun := (vrprod * 0.9998{100% de desconto});

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de 15% relativo Promoção LipGloss 15%?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
      qryTerminalBalcao.First;
    while not qryTerminalBalcao.EOF do
    begin

      if (qryTerminalBalcao.FieldValues['CDPRO'] = 14631) or
         (qryTerminalBalcao.FieldValues['CDPRO'] = 14632) or
         (qryTerminalBalcao.FieldValues['CDPRO'] = 14633) or
         (qryTerminalBalcao.FieldValues['CDPRO'] = 11403) then
      begin
        vrprod := qryTerminalBalcao.FieldValues['PRUNI'];
        codprod := qryTerminalBalcao.FieldValues['CDPRO'];
        valordescun := (vrprod * 0.15{100% de desconto});

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Text := 'update fc32110 set ptdsc=' + TrocaVirgPPto(FloatToStr(0.15)) + ',  pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun))
          + ')))*ALPIS)/100,BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))),' + ' BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))),VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 where tpitm=' + quotedstr('V') + ' and cdfil=' + trim(frmPrincipal.edtLoja.Text) + ' and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text) + ' and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)) + ' and cdpro in (' + IntToStr(codprod) + ')';

        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;
        qryInsereDesconto.Close;
      end;
      qryTerminalBalcao.next;
    end;
    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
    qryInsereDesconto.SQL.Add('   from fc32110 ');
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.Open;

    valortotal := qryInsereDesconto.FieldValues['VALOR'];

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update fc32100 ');
    qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('LipGloss 15%') + ', ');
    qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
    qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
    qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
    qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.CommitRetaining;
  end;

  showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
end;

procedure TfrmPrincipal.LipGloss;
var
  valortotal, valordescun, vrprod: double;
  p, p1, codprod: integer;
begin
  lblDescontoValor.Caption := '0';
  p := 0;
  p1 := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = 14631) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 14632) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 14633) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 11403) then
    begin
      p := p + qryTerminalBalcao.FieldValues['QUANT'];
      if (qryTerminalBalcao.FieldValues['vrdsc'] > 0) then
        raise Exception.Create('Venda Já possui Desconto');
    end;

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 14639) then
    begin
      vrprod := qryTerminalBalcao.FieldValues['PRUNI'];
      p1 := p1 + qryTerminalBalcao.FieldValues['QUANT'];
      if (qryTerminalBalcao.FieldValues['vrdsc'] > 0) then
        raise Exception.Create('Venda Já possui Desconto');
    end;

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 14639) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 14632) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 14633) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 11403) then
    begin
      codprod := qryTerminalBalcao.FieldValues['CDPRO'];
    end;

    qryTerminalBalcao.next;
  end;

  if (p < 2) then
    raise exception.create('Não existem produtos suficientes para desconto LipGloss na venda. Total:' + inttostr(p));
  if (p1 <> 1) then
    raise Exception.Create('Quantidade de Necessaire incorreta');

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 1)));

  valordescun := (vrprod * 0.9998{100% de desconto});

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo Promoção LipGloss?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.98)) + ',  ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA (quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.SQL.Add('    and cdpro in (14639)');

      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;
      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('LipGloss') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.CampanhaRejuvenescimento;
var
  valortotal, valordescun, vrprod: double;
  p, brinde, prodBrind: integer;
begin
  lblDescontoValor.Caption := '0';
  p := 0;
  brinde := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 16730) or (qryTerminalBalcao.FieldValues['CDPRO'] = 11403) then
    begin
      p := p + qryTerminalBalcao.FieldValues['QUANT'];
    end;

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 11408) then
    begin
      vrprod := qryTerminalBalcao.FieldValues['PRUNI'];
      brinde := brinde + qryTerminalBalcao.FieldValues['QUANT'];
    end;

    qryTerminalBalcao.next;
  end;

  prodBrind := trunc(p div 2);

  if (p < 2) then
    raise exception.create('Não existem produtos suficientes para Campanha de Rejuvenescimento ( brinde Necessaire  )  Total:' + inttostr(p));
  if (brinde <> prodBrind) then
    raise Exception.Create('Quantidade de Necessaire incorreta, o total correto é ' + intToStr(prodBrind));

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 1)));
  vrprod := 39.90;
  valordescun := (vrprod * 0.9998{100% de desconto});

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo ao Brinde da Campanha de Rejuvenescimento?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.98)) + ', ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun))+ ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.SQL.Add('    and cdpro in ( 11408 )');

      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;
      qryInsereDesconto.Close;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;
      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('Rejuvenescimento') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      QryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;
      qryInsereDesconto.Close;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;


procedure TfrmPrincipal.CampanhaAntiqueda;
var
  valortotal, valordescun, vrprod, vrDesconto: double;
  p, brinde, prodBrind: integer;
begin

  lblDescontoValor.Caption := '0';
  vrDesconto := 0;
  p := 0;
  brinde := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    {Shampoo SOS antiqueda (cód 10603)
     Condicionador SOS antiqueda (cód 10604)
     Loção SOS antiqueda (cód 10606)
     Nutri Hair (cód 14292)
     brinde : uma necessaire (cod 18177).}

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 10603) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 10604) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 10606) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 14292) then
    begin
      p := p + qryTerminalBalcao.FieldValues['QUANT'];
    end;

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 18177) then
    begin
      vrprod := qryTerminalBalcao.FieldValues['PRUNI'];
      brinde := brinde + qryTerminalBalcao.FieldValues['QUANT'];
    end;

    // produtos em promoção do mes
    qryFcertaTEMP.Close;
    qryFcertaTEMP.SQL.Clear;
    qryFcertaTEMP.SQL.Add(' select b.ptdsc ');
    qryFcertaTEMP.SQL.Add('   from fc0j100 b ');
    qryFcertaTEMP.SQL.Add('  where b.cdpro =' + intToStr(qryTerminalBalcao.FieldValues['CDPRO']));
    qryFcertaTEMP.SQL.Add('    and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)) + ' >= b.datainicial ' );
    qryFcertaTEMP.SQL.Add('    and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)) + ' <= b.datafinal ' );
    qryFcertaTEMP.Open;

    if qryFcertaTEMP.IsEmpty then
      vrDesconto := vrDesconto + qryTerminalBalcao.FieldValues['vrdsc'];

    qryTerminalBalcao.next;
  end;

   // campanha antiqueda pra permite acumular descontos. Tipo, não pode dar progressivo ou progressivo cabelos + a Necessaire
  if (vrDesconto > 0) then
    raise Exception.Create('Venda Já possui Desconto');

  prodBrind := trunc(p div 2);

  if (p < 2) then
    raise exception.create('Não existem produtos suficientes para Campanha Antiqueda ( brinde Necessaire  )  Total:' + inttostr(p));
  if (brinde <> prodBrind) then
    raise Exception.Create('Quantidade de Necessaire incorreta, o total correto é ' + intToStr(prodBrind));

  vrprod := 39.90;
  valordescun := (vrprod * 0.9998{100% de desconto});
  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr(vrprod));

  if (lblDescontoValor.Caption <> '0') then
  begin

    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo ao Brinde da Campanha Antiqueda?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.98)) + ',  ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope>=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.SQL.Add('    and cdpro in ( 18177 )');

      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope>=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('Antiqueda') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope>=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      QryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;
      qryInsereDesconto.Close;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;


procedure TfrmPrincipal.DescontoCoqueteleira;
var
  valortotal, valordescun, vrprod, vrtotal: double;
  p, p1, codprod: integer;
begin
  lblDescontoValor.Caption := '0';
  p := 0;
  p1 := 0;
  vrtotal := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin

    if (qryTerminalBalcao.FieldValues['vrdsc'] > 0) then
      raise Exception.Create('Venda Já possui Desconto');

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 14168) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 12489) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 11785) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 13559) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 14292) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 13560) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 13150) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 12036) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 12035) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 11331) then
    begin
      p := p + qryTerminalBalcao.FieldValues['QUANT'];
      vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];
    end;

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 14247) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 14248) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 14249) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 14250) then
    begin

      p1 := p1 + qryTerminalBalcao.FieldValues['QUANT'];
      vrprod := qryTerminalBalcao.FieldValues['PRUNI'];
      codprod := qryTerminalBalcao.FieldValues['CDPRO'];
    end;
    qryTerminalBalcao.next;
  end;

  if (vrtotal < 250) then
    raise exception.create('Valor de suplementos abaixo de R$ 250,00. Valor insuficiente para Desconto Coqueteleira nessa venda. Valor Total:' + TrocaVirgPPto(FloatToStr((vrtotal * 1))));

  if (p1 <> 1) then
    raise Exception.Create('Quantidade de coqueteleira incorreta');

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 1)));

  valordescun := (vrprod * 0.9998{100% de desconto});

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo Promoção Coqueteleira?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.98)) + ',  ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.SQL.Add('    and cdpro in (' + IntToStr(codprod) + ')');

      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;
      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('coqueteleira') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;


procedure TfrmPrincipal.SOSAntiqueda;
var
  valortotal, valordescun, vrBrinde, vrtotal, vrdsc, vrDescTotal, percdesc: double;
  QTDprod, qtdBrinde, codBrinde, item: integer;

begin
   lblDescontoValor.Caption := '0';
   QTDprod:=0;
   qtdBrinde:=0;

   vrtotal:=0;
   useridaut := '';
   vrdsc :=0;
   vrDescTotal:=0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['tpitm'] = 'V') and   // códigos dos produtos Campanha Antiqueda no Privillege:
      ((qryTerminalBalcao.FieldValues['CDPRO'] = 10603) or
      (qryTerminalBalcao.FieldValues['CDPRO'] = 10604) or
      (qryTerminalBalcao.FieldValues['CDPRO'] = 10606) or
      (qryTerminalBalcao.FieldValues['CDPRO'] = 14292)) then
    begin
      QTDprod := QTDprod + qryTerminalBalcao.FieldValues['QUANT'];
      vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];
    end;

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 16752 ) or // codigo das escovas
      (qryTerminalBalcao.FieldValues['CDPRO'] = 16754 ) or
      (qryTerminalBalcao.FieldValues['CDPRO'] = 16750 ) or
      (qryTerminalBalcao.FieldValues['CDPRO'] = 16751 ) or
      (qryTerminalBalcao.FieldValues['CDPRO'] = 16753 )  then
    begin
      qtdBrinde := qtdBrinde + qryTerminalBalcao.FieldValues['QUANT'];
      vrBrinde := qryTerminalBalcao.FieldValues['PRUNI'];
      codBrinde := qryTerminalBalcao.FieldValues['CDPRO'];
      vrdsc := qryTerminalBalcao.FieldValues['vrdsc'];
    end;

    qryTerminalBalcao.next;
  end;

  if (vrdsc > 0) then
    raise Exception.Create('Venda Já possui Desconto - Campanha Antiqueda. ');

  if (QTDprod < 2) then
    raise exception.create('qtd insuficiente de produtos para o brinde(Escova). qtd de produtos: ' + intToStr(QTDprod));

  if (qtdBrinde <> 1) then
    raise Exception.Create('Quantidade de brinde( escova ) incorreto!');

   valordescun:= (vrBrinde * 0.9997{100% de desconto});
   lblDescontoValor.Caption := TrocaVirgPPto( FloatToStr((valordescun*1))  ) ;

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo Campanha Antiqueda?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryTerminalBalcao.First;
      while not qryTerminalBalcao.eof do
      begin
        if (qryTerminalBalcao.FieldValues['CDPRO'] = 16752) or // codigo das escovas
          (qryTerminalBalcao.FieldValues['CDPRO'] = 16754) or
          (qryTerminalBalcao.FieldValues['CDPRO'] = 16750) or
          (qryTerminalBalcao.FieldValues['CDPRO'] = 16751) or
          (qryTerminalBalcao.FieldValues['CDPRO'] = 16753) then
        begin
          valordescun := (vrBrinde * 0.9997{100% de desconto});
          vrDescTotal := vrDescTotal + ((qryTerminalBalcao.FieldValues['PRUNI'] * 0.9997) * qryTerminalBalcao.FieldValues['QUANT']);

          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.97)) + ',  ');
          qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
          qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
          qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
          qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
          qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
          qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and cdpro in (' + IntToStr(codBrinde) + ')');

          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
        end;

        qryTerminalBalcao.next;
      end;

      percdesc := 0;
      case QTDprod of
        1:
          percdesc := 5;
        2:
          percdesc := 10;
        3:
          percdesc := 15;
      else
        percdesc := 15;
      end;

      if MessageDlg('Deseja aplicar desconto progressivo ( ' + FloatToStr(percdesc) + '%) ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
      begin
        qryTerminalBalcao.First;
        while not qryTerminalBalcao.eof do
        begin
          if (qryTerminalBalcao.FieldValues['CDPRO'] = 10603) or (qryTerminalBalcao.FieldValues['CDPRO'] = 10604) or (qryTerminalBalcao.FieldValues['CDPRO'] = 10606) or (qryTerminalBalcao.FieldValues['CDPRO'] = 14292) then
          begin
            item := qryTerminalBalcao.FieldValues['itemID'];
            valordescun := (qryTerminalBalcao.FieldValues['PRUNI'] * (percdesc / 100)  { % de desconto});
            vrDescTotal := vrDescTotal + ((qryTerminalBalcao.FieldValues['PRUNI'] * (percdesc / 100)) * qryTerminalBalcao.FieldValues['QUANT']);

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' update fc32110 ');
            qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(percdesc)) + ',  ');
            qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
            qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
            qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
            qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
            qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
            qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
            qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
            qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
            qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
            qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
            qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
            qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
            qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
            qryInsereDesconto.SQL.Add('    and itemID = ' + intToStr(item));

            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.CommitRetaining;
          end;
          qryTerminalBalcao.next;
        end;
      end;

      lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrDescTotal)));

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.Open;
      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('sosantiqueda') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.Aquaporine;
var
  valortotal, valordescun, vrBrinde, vrtotal, vrdsc, vrDescTotal, percdesc: double;
  QTDprod, qtdBrinde, codBrinde, item: integer;
begin
  lblDescontoValor.Caption := '0';
  QTDprod := 0;
  qtdBrinde := 0;

  vrtotal := 0;
  useridaut := '';
  vrdsc := 0;
  vrDescTotal := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = 3774) then // codigo do sabonete
    begin
      qtdBrinde := qtdBrinde + qryTerminalBalcao.FieldValues['QUANT'];
      vrBrinde := qryTerminalBalcao.FieldValues['PRUNI'];
      codBrinde := qryTerminalBalcao.FieldValues['CDPRO'];
      vrdsc := qryTerminalBalcao.FieldValues['vrdsc'];
    end
    else if (qryTerminalBalcao.FieldValues['tpitm'] = 'V') then   // códigos dos produtos Campanha Aquaporine;
    begin
      QTDprod := QTDprod + qryTerminalBalcao.FieldValues['QUANT'];
      vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];
    end;

    qryTerminalBalcao.next;
  end;

  if (vrdsc > 0) then
    raise Exception.Create('Venda Já possui Desconto - Campanha Aquaporine. ');

  if (vrtotal < 250) then
    raise exception.create('Valor da compra abaixo de R$ 250,00. Valor insuficiente para o brinde( Sabonete Aquaporine ). Valor Total:' + TrocaVirgPPto(FloatToStr((vrtotal * 1))));

  if (qtdBrinde <> 1) then
    raise Exception.Create('Quantidade de brinde( Sabonete Aquaporine ) incorreto!');

  valordescun := (vrBrinde * 0.9997{100% de desconto});
  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((valordescun * 1)));

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' referente ao brinde da Campanha Aquaporine?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryTerminalBalcao.First;
      while not qryTerminalBalcao.eof do
      begin

        if (qryTerminalBalcao.FieldValues['CDPRO'] = 3774) then
        begin
          valordescun := (vrBrinde * 0.9997{100% de desconto});
          vrDescTotal := vrDescTotal + ((qryTerminalBalcao.FieldValues['PRUNI'] * 0.9997) * qryTerminalBalcao.FieldValues['QUANT']);

          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.97)) + ',  ');
          qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
          qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
          qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100');
          qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
          qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
          qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and cdpro in (' + IntToStr(codBrinde) + ')');

          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
        end;
        qryTerminalBalcao.next;
      end;

      lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrDescTotal)));

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('   where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('     and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('     and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.Open;
      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('Aquaporine') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.QuizenaDoConsumidor;
var
  valortotal, valordescun, vrBrinde, vrtotal, vrdsc, vrDescTotal, percdesc: double;
  QTDprod, qtdBrinde, codBrinde, item: integer;
begin

  lblDescontoValor.Caption := '0';
  QTDprod := 0;
  qtdBrinde := 0;

  vrtotal := 0;
  useridaut := '';
  vrdsc := 0;
  vrDescTotal := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 16941) then // codigo do Brinde  - batom Hidra Lipstick Nude
    begin
      qtdBrinde := qtdBrinde + qryTerminalBalcao.FieldValues['QUANT'];
      vrBrinde := qryTerminalBalcao.FieldValues['PRUNI'];
      codBrinde := qryTerminalBalcao.FieldValues['CDPRO'];
      vrdsc := qryTerminalBalcao.FieldValues['vrdsc'];
    end
    else if (qryTerminalBalcao.FieldValues['tpitm'] = 'V') then   // Total do varejo
    begin
      QTDprod := QTDprod + qryTerminalBalcao.FieldValues['QUANT'];
      vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];
    end;

    qryTerminalBalcao.next;
  end;

  if (vrtotal < 200) then
    raise exception.create('Valor da compra abaixo de R$ 200,00. Valor insuficiente para o brinde( Quinzena do Consumidor ). Valor Total:' + TrocaVirgPPto(FloatToStr((vrtotal * 1))));

  if (qtdBrinde <> 1) then
    raise Exception.Create('Quantidade de brinde( batom Hidra Lipstick Nude ) incorreto!');

  valordescun := (vrBrinde * 0.9993{100% de desconto});
  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((valordescun * 1)));

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' referente ao brinde Campanha Quinzena do Consumidor.?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin

      qryTerminalBalcao.First;
      while not qryTerminalBalcao.eof do
      begin
        if (qryTerminalBalcao.FieldValues['CDPRO'] = 16941) then
        begin
          valordescun := (vrBrinde * 0.9993 {100% de desconto});
          vrDescTotal := vrDescTotal + ((qryTerminalBalcao.FieldValues['PRUNI'] * 0.9993) * qryTerminalBalcao.FieldValues['QUANT']);

          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.93)) + ',  ');
          qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
          qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
          qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
          qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
          qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
          qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and cdpro in (' + IntToStr(codBrinde) + ')');

          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;

          qryInsereDesconto.Close;
        end;

        qryTerminalBalcao.next;
      end;

      lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrDescTotal)));

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.Open;
      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Text := 'update fc32100 set useridaut=' + quotedstr('consumidor') + ', vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ',vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ' where  cdfil=' + trim(frmPrincipal.edtLoja.Text) + ' and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text) + ' and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope']));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      QryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.ComboCreatinaPalatinose;
var
  valordescun, vrPalatinose, vrdscPalatinose, vrDescTotal: double;
  qtdPalatinose, qtdCreatina, itemID, qtdprod, quant: integer;
begin
  if qryTerminalBalcao.FieldByName('USERIDAUT').AsString = 'SemanaCliente' then
    raise Exception.Create('TB com desconto da Campanha Cliente. Remova o desconto e aplique primeiro a Campanha: Combo Creatina + Palatinose (50%) ');

  lblDescontoValor.Caption := '0';

  qtdprod := 0;
  quant := 0;

  qtdCreatina := 0;
  qtdPalatinose := 0;

  vrdscPalatinose := 0;
  vrDescTotal := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = 17244) then // codigo da Palatinose
    begin
      qtdPalatinose := qtdPalatinose + qryTerminalBalcao.FieldValues['QUANT'];
      vrPalatinose := qryTerminalBalcao.FieldValues['PRUNI'];
      vrdscPalatinose := vrdscPalatinose + qryTerminalBalcao.FieldValues['vrdsc'];
    end;

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 17242) then // codigo da Creatina
    begin
      qtdCreatina := qtdCreatina + qryTerminalBalcao.FieldValues['QUANT'];
    end;

    qryTerminalBalcao.Next;
  end;

  if (vrdscPalatinose > 0) then
    raise Exception.Create('Palatinose Já possui Desconto - Combo CREATINA + PALATINOSE(50%). ');

   // creatina não pode ser maior que palatinose
  if qtdCreatina > qtdPalatinose then
    qtdCreatina := qtdPalatinose;

  valordescun := (vrPalatinose * 0.5000 { 50% de desconto});
  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((valordescun * qtdCreatina)));

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' referente ao Combo CREATINA + PALATINOSE(50%).?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryTerminalBalcao.First;

        //* desconto proporcional a qtd creatina
      qtdprod := 1;
      while (not qryTerminalBalcao.eof) and (qtdprod <= qtdCreatina) do
      begin

        if (qryTerminalBalcao.FieldValues['CDPRO'] = 17244) then //Palatinose
        begin

          if (qryTerminalBalcao.FieldValues['QUANT'] >= qtdCreatina) then
            quant := qtdCreatina
          else
            quant := qryTerminalBalcao.FieldValues['QUANT'];

          itemID := qryTerminalBalcao.FieldValues['ITEMID'];
          valordescun := (vrPalatinose * 0.5000 {50% de desconto});
          vrDescTotal := vrDescTotal + ((qryTerminalBalcao.FieldValues['PRUNI'] * 0.5000) * quant);

          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(50.00)) + ',  ');
          qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(  ' + inttostr(quant) + ' * ' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-( ' + inttostr(quant) + ' * ' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrdsc=( ' + inttostr(quant) + ' * (' + TrocaVirgPPto(FloatToStr(valordescun)) + ')), ');
          qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-( ' + inttostr(quant) + ' * (' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-( ' + inttostr(quant) + ' * (' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
          qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-( ' + inttostr(quant) + ' * (' + TrocaVirgPPto(FloatToStr(valordescun)) + '))),');
          qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-( ' + inttostr(quant) + ' * (' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(  ' + inttostr(quant) + ' * (' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
          qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
          qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
          qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(itemID));

          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;

          qtdprod := qtdprod + 1;
        end;
        qryTerminalBalcao.next;
      end;

      lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrDescTotal)));

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where  cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.Open;
      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('Palatinose') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      QryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;


procedure TfrmPrincipal.CampanhaPerformanceBrinde;
  function verQtdProdutos: integer;
  begin
    // de 2 produtos da linha , cliente ganha 1 Necessaire Pós treino
    // retorna a quantidade de produtos  para comparar com quant de brinde lançados no TB
    qryFcertaTEMP.Close;
    qryFcertaTEMP.SQL.Clear;
    qryFcertaTEMP.SQL.Add(' select sum(a.quant) as qtd ');
    qryFcertaTEMP.SQL.Add('   from fc32110 a  ');
    qryFcertaTEMP.SQL.Add(' where a.tpitm=' + quotedstr('V'));
    qryFcertaTEMP.SQL.Add('   and a.cdfil=' + inttostr(qryTerminalBalcao.FieldValues['CDFIL']));
    qryFcertaTEMP.SQL.Add('   and a.nrcpm=' + inttostr(qryTerminalBalcao.FieldValues['NRCPM']));
    qryFcertaTEMP.SQL.Add('   and a.cdpro in ( 6045, 15447, 17243, 17242 ,17244  )  ');
    qryFcertaTEMP.Open;

    result := trunc(qryFcertaTEMP.FieldByName('qtd').AsInteger div 2);
  end;

var
  valortotal, valordescun, vrBrinde, vrtotal, vrdsc, vrDescTotal, percdesc: double;
  QTDprod, qtdBrinde, codBrinde, item: integer;
begin
  lblDescontoValor.Caption := '0';
  QTDprod := 0;
  qtdBrinde := 0;

  vrtotal := 0;
  useridaut := '';
  vrdsc := 0;
  vrDescTotal := 0;

  qryTerminalBalcao.First;

  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = 17278) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 17342) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 17343) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 17347) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 17344) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 17345) then // codigo do Brinde
    begin
      qtdBrinde := qtdBrinde + qryTerminalBalcao.FieldValues['QUANT'];
      vrBrinde := qryTerminalBalcao.FieldValues['PRUNI'];
      codBrinde := qryTerminalBalcao.FieldValues['CDPRO'];
      vrdsc := qryTerminalBalcao.FieldValues['vrdsc'];
    end
    else if (qryTerminalBalcao.FieldValues['CDPRO'] = 6045) or
            (qryTerminalBalcao.FieldValues['CDPRO'] = 15447) or
            (qryTerminalBalcao.FieldValues['CDPRO'] = 17243) or
            (qryTerminalBalcao.FieldValues['CDPRO'] = 17242) or
            (qryTerminalBalcao.FieldValues['CDPRO'] = 17244) then  // códigos dos produtos Campanha Performace;
    begin
      QTDprod := QTDprod + qryTerminalBalcao.FieldValues['QUANT'];
      vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];
    end;
    qryTerminalBalcao.next;
  end;

  if (QTDprod < 2) then
    raise exception.create(' Quantidade de produtos insuficiente para o brinde( Campanha Performace Brinde ). Qtd Total:' + intToStr(QTDprod));

  if (qtdBrinde <> verQtdProdutos) then
    raise Exception.Create('Quantidade de brinde (Necessaire Pós treino) Incorreta!');

  valordescun := (vrBrinde * 0.9960{100% de desconto});

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((valordescun * 1)));

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' referente ao brinde Campanha Performace brinde.?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryTerminalBalcao.First;

      while not qryTerminalBalcao.eof do
      begin
        if (qryTerminalBalcao.FieldValues['CDPRO'] = 17278 ) or
           (qryTerminalBalcao.FieldValues['CDPRO'] = 17342 ) or
           (qryTerminalBalcao.FieldValues['CDPRO'] = 17343 ) or
           (qryTerminalBalcao.FieldValues['CDPRO'] = 17347 ) or
           (qryTerminalBalcao.FieldValues['CDPRO'] = 17344 ) or
           (qryTerminalBalcao.FieldValues['CDPRO'] = 17345 )  then
        begin
          valordescun := (vrBrinde * 0.9960 {100% de desconto});
          vrDescTotal := vrDescTotal + ((qryTerminalBalcao.FieldValues['PRUNI'] * 0.9960) * qryTerminalBalcao.FieldValues['QUANT']);

          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.60)) + ',  ');
          qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
          qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
          qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))),');
          qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
          qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
          qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
          qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and itemid = ' + intToStr(qryTerminalBalcao.FieldValues['itemid']));
          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
        end;
        qryTerminalBalcao.next;
      end;

      lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrDescTotal)));

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('PerfBrinde') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add('update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      QryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.AniversarianteDoMes;
  function MesDoAniversario: Integer;
  begin
    qryFcertaTEMP.Close;
    qryFcertaTEMP.sql.Clear;
    qryFcertaTEMP.SQL.Add('  select a.cdcli , a.nomecli , a.dtnas ');
    qryFcertaTEMP.SQL.Add('    from fc07000 a ');
    qryFcertaTEMP.SQL.Add('   where EXTRACT(MONTH FROM a.dtnas ) = EXTRACT(MONTH FROM current_date ) ');
    qryFcertaTEMP.SQL.Add('     and a.cdcli = ' + qryTerminalBalcao.FieldByName('cdcli').AsString);
    qryFcertaTEMP.Open;

    if qryFcertaTEMP.IsEmpty then
      result := 0
    else
      Result := StrToInt(copy(qryFcertaTEMP.FieldByName('dtnas').value, 4, 2));
  end;

  function ComprasNoMes: integer;
  var
    vMesDoAniversario: integer;
  begin

    vMesDoAniversario := IfThen(MesDoAniversario <> 0, MesDoAniversario, 0);
    qryFcertaTEMP.Close;
    qryFcertaTEMP.sql.Clear;
    qryFcertaTEMP.SQL.Add('     select count(fc32100.operid) as compras ');
    qryFcertaTEMP.SQL.Add('       from fc32100 ');
    qryFcertaTEMP.SQL.Add(' inner join fc07000 ');
    qryFcertaTEMP.SQL.Add('         on fc07000.cdcli = fc32100.cdcli ');
    qryFcertaTEMP.SQL.Add('      where fc32100.useridaut=''AniverDoMes'' ');
    qryFcertaTEMP.SQL.Add('        and fc07000.cdcli = ' + qryTerminalBalcao.FieldByName('cdcli').AsString);
    qryFcertaTEMP.SQL.Add('        and EXTRACT(MONTH FROM fc07000.dtnas ) =:pMes ');
    qryFcertaTEMP.SQL.Add('        and EXTRACT(YEAR FROM fc32100.dtope) = EXTRACT(year from current_date)');
    qryFcertaTEMP.ParamByName('pMes').Value := vMesDoAniversario;
    qryFcertaTEMP.Open;

    if qryFcertaTEMP.IsEmpty then
      result := 0
    else
      Result := qryFcertaTEMP.FieldByName('compras').AsInteger;
  end;

var
  valortotal, valorunitdesc, vrcxa: double;
begin

  if MesDoAniversario = 0 then
    raise Exception.Create('Cliente não é aniversariante do mês, verifique o cadastro no Fórmula Certa. ');

  if ComprasNoMes > 3 then
    raise Exception.Create('Atingiu limite máximo de 4 compras no mês');

    qrySelecionaDesconto.Close;

    if MessageDlg('Deseja confirmar desconto de 10%Fórmula e 20%Varejo ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      desc1form := 10.00;
      desc2var := 20.00;
      tpdescform := '8'; // PRODUTO EM PROMOÇÃO (CAMPANHAS)

      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.sql.Clear;
      qrySelecionaDesconto.sql.Add('    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDPRO,  a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, a.TPDSC, ');
      qrySelecionaDesconto.sql.Add('           a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, ');
      qrySelecionaDesconto.sql.Add('           a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ');
      qrySelecionaDesconto.sql.Add('      from fc32110 a ');
      qrySelecionaDesconto.sql.Add(' left join fc32200 b ');
      qrySelecionaDesconto.sql.Add('        on ( a.cdfil=b.cdfil ');
      qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
      qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
      qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
      qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ');
      qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qrySelecionaDesconto.sql.Add('       and a.dtope>=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qrySelecionaDesconto.SQL.Add('  order by a.VRTOT DESC');

      qrySelecionaDesconto.Open;
      qrySelecionaDesconto.FetchAll;
      qrySelecionaDesconto.First;

      while not qrySelecionaDesconto.eof do
      begin
        if ((qrySelecionaDesconto.FieldValues['TPITM'] = 'R') and (desc1form > 0)) or
           ((qrySelecionaDesconto.FieldValues['TPITM'] = 'V') and (desc2var > 0)) then
        begin
          // brinde de outras campanhas
          if (qrySelecionaDesconto.FieldValues['CDPRO'] = 17278) or
             (qrySelecionaDesconto.FieldValues['CDPRO'] = 17342) or
             (qrySelecionaDesconto.FieldValues['CDPRO'] = 17343) or
             (qrySelecionaDesconto.FieldValues['CDPRO'] = 17347) or
             (qrySelecionaDesconto.FieldValues['CDPRO'] = 17344) or
             (qrySelecionaDesconto.FieldValues['CDPRO'] = 17345) then // codigo do Brinde  100% em outra campanha
          begin
            qrySelecionaDesconto.Next;
            continue;
          end;

          if qrySelecionaDesconto.FieldValues['TPITM'] = 'R' then
            valorunitdesc := (qrySelecionaDesconto.FieldValues['VRTOT'] * desc1form) / 100
          else
            valorunitdesc := (qrySelecionaDesconto.FieldValues['VRTOT'] * desc2var) / 100;

          valorunitdesc := RoundTo(valorunitdesc, -2);

          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32200 ');
          qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescform) + ', ');
          qryInsereDesconto.SQL.Add('        vrliq= vrtot+vrtxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
          qryInsereDesconto.SQL.Add('        vrsdo=vrtot+vrtxa-vrrcb-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
          qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
          qryInsereDesconto.SQL.Add('        useridaut=' + quotedstr(useridaut) );
          qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
          qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
          qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
          qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;


          if qrySelecionaDesconto.FieldValues['tppag'] = '1' then
          begin
            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add('   update fc32200 ');
            qryInsereDesconto.SQL.Add('      set vrcxa = vrtot+vrtxa-' + TrocaVirgPPto(floattostr(valorunitdesc)));
            qryInsereDesconto.SQL.Add('    where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
            qryInsereDesconto.SQL.Add('      and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
            qryInsereDesconto.SQL.Add('      and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
            qryInsereDesconto.SQL.Add('      and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
            qryInsereDesconto.SQL.Add('      and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
            qryInsereDesconto.SQL.Add('  and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.CommitRetaining;
          end
          else
          begin
            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add('   update fc32200 ');
            qryInsereDesconto.SQL.Add('    set vrcxa= vrrcb ');
            qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
            qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
            qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
            qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
            qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
            qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.CommitRetaining;
          end;

          if qrySelecionaDesconto.FieldValues['TPITM'] = 'R' then
          begin
            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' select vrcxa ');
            qryInsereDesconto.SQL.Add('   from fc32200 ');
            qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
            qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
            qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
            qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
            qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
            qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
            qryInsereDesconto.Open;

            vrcxa := qryInsereDesconto.FieldValues['VRCXA'];

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' update fc32110 ');
            qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescform) + ', ');
            qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
            qryInsereDesconto.SQL.Add('        pruni=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
            qryInsereDesconto.SQL.Add('        pruniliq=' + TrocaVirgPPto(floattostr(vrcxa)) + '/QUANT, ');
            qryInsereDesconto.SQL.Add('        vrcxa=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
            qryInsereDesconto.SQL.Add('        vrliq=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
            qryInsereDesconto.SQL.Add('        BCICM=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
            qryInsereDesconto.SQL.Add('        nomepa=' + quotedstr(useridaut));
            qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
            qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
            qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
            qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
            qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
            qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
          end
          else
          begin
            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' update fc32110 ');
            qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
            qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
            qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
            qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
            qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
            qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
            qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
            qryInsereDesconto.SQL.Add('        nomepa=' + quotedstr(useridaut));
            qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
            qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
            qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
            qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
            qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
            qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
          end;

          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
        end;
        qrySelecionaDesconto.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('  from fc32110 ');
      qryInsereDesconto.SQL.Add(' where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('   and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('   and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('AniverDoMes') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
end;


procedure TfrmPrincipal.ManipuladosPET;
var
  valortotal, valorunitdesc, vrcxa, desconto: double;
  existeManipPet: string;

  procedure ExisteManipuladoPet;
  begin
    existeManipPet := 'N';
    qryTerminalBalcao.First;
    while not qryTerminalBalcao.EOF do
    begin
      if (qryTerminalBalcao.FieldValues['pfcrm'] = '3') then
      begin
        existeManipPet := 'S';
        desconto := desconto + qryTerminalBalcao.FieldValues['VRDSC'];
      end;
      qryTerminalBalcao.next;
    end;
  end;

begin
  if existeManipPet = 'N' then
    raise Exception.Create('Venda não possue produto(s) Manipulado(s) de Pet.  ');

  if desconto > 0 then
    raise Exception.Create('Venda Já possui Desconto - Campanha Manipulados de Pet.');

  useridaut := 'ManipPet';
  qrySelecionaDesconto.Close;

  if MessageDlg('Deseja confirmar desconto de 10%Fórmula ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
  begin
    desc1form := 10.00;
    tpdescform := '4'; // vet

    qrySelecionaDesconto.Close;
    qrySelecionaDesconto.sql.Clear;
    qrySelecionaDesconto.sql.Add('    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDPRO,  a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, a.TPDSC, ');
    qrySelecionaDesconto.sql.Add('           a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, ');
    qrySelecionaDesconto.sql.Add('           a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ');
    qrySelecionaDesconto.sql.Add('      from fc32110 a ');
    qrySelecionaDesconto.sql.Add(' left join fc32200 b ');
    qrySelecionaDesconto.sql.Add('        on (a.cdfil=b.cdfil ');
    qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
    qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
    qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
    qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
    qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ');
    qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qrySelecionaDesconto.sql.Add('       and a.TPITM = ' + QuotedStr('R'));
    qrySelecionaDesconto.sql.Add('       and  a.pfcrm = ' + QuotedStr('3'));
    qrySelecionaDesconto.sql.Add('       and a.dtope>=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
    qrySelecionaDesconto.SQL.Add('  order by a.VRTOT DESC');

    qrySelecionaDesconto.Open;
    qrySelecionaDesconto.FetchAll;

    qrySelecionaDesconto.First;
    while not qrySelecionaDesconto.eof do
    begin
      valorunitdesc := (qrySelecionaDesconto.FieldValues['VRTOT'] * desc1form) / 100;
      valorunitdesc := RoundTo(valorunitdesc, -2);

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32200 ');
      qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescform) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq= vrtot+vrtxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
      qryInsereDesconto.SQL.Add('        vrsdo=vrtot+vrtxa-vrrcb-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
      qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
      qryInsereDesconto.SQL.Add('        useridaut=' + quotedstr(useridaut));
      qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
      qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
      qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
      qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
      qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      if qrySelecionaDesconto.FieldValues['tppag'] = '1' then
      begin
        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32200 ');
        qryInsereDesconto.SQL.Add('    set vrcxa = vrtot+vrtxa-' + TrocaVirgPPto(floattostr(valorunitdesc)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;
      end
      else
      begin
        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32200 ');
        qryInsereDesconto.SQL.Add('    set vrcxa= vrrcb ');
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select vrcxa ');
      qryInsereDesconto.SQL.Add('   from fc32200 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
      qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
      qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
      qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
      qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
      qryInsereDesconto.Open;

      vrcxa := qryInsereDesconto.FieldValues['VRCXA'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescform) + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
      qryInsereDesconto.SQL.Add('        pruni=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
      qryInsereDesconto.SQL.Add('        pruniliq=' + TrocaVirgPPto(floattostr(vrcxa)) + '/QUANT, ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
      qryInsereDesconto.SQL.Add('        BCICM=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
      qryInsereDesconto.SQL.Add('        nomepa=' + quotedstr(useridaut));
      qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
      qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
      qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
      qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
      qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));

      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qrySelecionaDesconto.Next;
    end;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
    qryInsereDesconto.SQL.Add('   from fc32110 ');
    qryInsereDesconto.SQL.Add('  where  cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
    qryInsereDesconto.Open;

    valortotal := qryInsereDesconto.FieldValues['VALOR'];

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update fc32100 ');
    qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr(useridaut) + ', ');
    qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.CommitRetaining;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update totvsconf ');
    qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
    qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.Commit;

    showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
  end;
end;

procedure TfrmPrincipal.CampanhaBSCROSS;

  function VerificaCPF: Integer;
  begin
    qryPrivilegeTEMP.Close;
    qryPrivilegeTEMP.sql.Clear;
    qryPrivilegeTEMP.SQL.Add(' select e.cpfcli ');
    qryPrivilegeTEMP.SQL.Add('   from campanhasclientes e ');
    qryPrivilegeTEMP.SQL.Add('  where e.idcamp=68 ');
    qryPrivilegeTEMP.SQL.Add('    and e.cpfcli =' + QuotedStr(qryTerminalBalcao.FieldByName('nrcnpj').AsString));

    qryPrivilegeTEMP.Open;

    if qryPrivilegeTEMP.IsEmpty then
      result := 0
    else
      Result := 1;

    qryPrivilegeTEMP.Close;
  end;

var
  valortotal, valorunitdesc, vrdsc, vrperc, vrcxa, vrsaldodesc, vrdescaplicado: double;
begin
  if VerificaCPF = 0 then
    raise Exception.Create('Cliente não contemplado na campanha BSCROSS ');

  lblDescontoValor.Caption := '0';

  valortotal := 0;
  vrdsc := 0;
  vrperc := 0;
  qryTerminalBalcao.First;

  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['tpitm'] = 'R') then
    begin
      valortotal := valortotal + qryTerminalBalcao.FieldValues['VRTOT'];
      vrdsc := vrdsc + qryTerminalBalcao.FieldValues['vrdsc'];
    end;
    qryTerminalBalcao.next;
  end;

  if (StrToDate(FormatDateTime('dd/mm/yyyy', now)) < strtodate('25/11/2023')) or (StrToDate(FormatDateTime('dd/mm/yyyy', now)) > strtodate('31/12/2023')) then
    Exception.Create('campanha disponível apenas para o período de  ( 25/11 a 31/12 ) ');

  if valortotal < 150 then
    raise Exception.Create('Valor não contempla a campanha BSCROSS');

  if (vrdsc > 0) then
    raise Exception.Create('Venda Já possui Desconto - Campanha BSCROSS. ');

  vrperc := round(5000 / valortotal);
  valorunitdesc := 50.00;
  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((valorunitdesc * 1)));

  qrySelecionaDesconto.Close;

  if MessageDlg('Deseja confirmar desconto de R$ 50,00 em Fórmula ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
  begin
    desc1form := vrperc;

    qrySelecionaDesconto.Close;
    qrySelecionaDesconto.sql.Clear;
    qrySelecionaDesconto.sql.Add('    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDPRO,  a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, a.TPDSC, ');
    qrySelecionaDesconto.sql.Add('           a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, ' + ' coalesce( b.vrtot, a.VRTOT) as VRTOT, ');
    qrySelecionaDesconto.sql.Add('           a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ');
    qrySelecionaDesconto.sql.Add('      from fc32110 a ');
    qrySelecionaDesconto.sql.Add(' left join fc32200 b on ');
    qrySelecionaDesconto.sql.Add('           (a.cdfil=b.cdfil ');
    qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
    qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
    qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
    qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
    qrySelecionaDesconto.sql.Add('       and a.cdpro=b.nrrqu ) ');
    qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qrySelecionaDesconto.sql.Add('       and a.TPITM = ' + QuotedStr('R'));
    qrySelecionaDesconto.sql.Add('       and a.dtope>=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
    qrySelecionaDesconto.SQL.Add(' order by a.VRTOT DESC');

    qrySelecionaDesconto.Open;
    qrySelecionaDesconto.FetchAll;
    qrySelecionaDesconto.First;

    vrsaldodesc := valorunitdesc;

    while not qrySelecionaDesconto.eof do
    begin
        // é preciso controlar o saldo de desconto para caso exista mais de uma fórmula abaixo dos 50 reais, por exemplo,
        // 5 formulas de 30 reais, onde o desconto de 50 não possa ser aplicado completamente em nenhuma das formulas, é necessário dividir o desconto em mais de uma fórmula
      if qrySelecionaDesconto.FieldValues['vrliq'] - vrsaldodesc < 0.01 then
        vrdescaplicado := qrySelecionaDesconto.FieldValues['vrliq'] - 0.01
      else
        vrdescaplicado := vrsaldodesc;

      vrsaldodesc := vrsaldodesc - vrdescaplicado;

          // se valor a ser aplicado já tiver zerado ou seja, já tiver aplicado todo o desconto não há necessidade de alteraçoes no TB
      if vrdescaplicado > 0 then
      begin
        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32200 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr('D') + ', ');
        qryInsereDesconto.SQL.Add('        vrliq= vrtot+vrtxa-' + TrocaVirgPPto(floattostr(vrdescaplicado)) + ', ');
        qryInsereDesconto.SQL.Add('        vrsdo=vrtot+vrtxa-vrrcb-' + TrocaVirgPPto(floattostr(vrdescaplicado)) + ', ');
        qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(vrdescaplicado)) + ', ');
        qryInsereDesconto.SQL.Add('        useridaut=' + quotedstr('BSCROSS'));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;

        if qrySelecionaDesconto.FieldValues['tppag'] = '1' then
        begin
          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32200 ');
          qryInsereDesconto.SQL.Add('    set vrcxa = vrtot+vrtxa-' + TrocaVirgPPto(floattostr(vrdescaplicado)));
          qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
          qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
          qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
          qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
        end
        else
        begin
          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32200 ');
          qryInsereDesconto.SQL.Add('    set vrcxa= vrrcb ');
          qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
          qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
          qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
          qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
        end;

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' select vrcxa ');
        qryInsereDesconto.SQL.Add('   from fc32200 ');
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.Open;

        vrcxa := qryInsereDesconto.FieldValues['VRCXA'];

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescform) + ', ');
        qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
        qryInsereDesconto.SQL.Add('        pruni=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
        qryInsereDesconto.SQL.Add('        pruniliq=' + TrocaVirgPPto(floattostr(vrcxa)) + '/QUANT, ');
        qryInsereDesconto.SQL.Add('        vrcxa=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=' + TrocaVirgPPto(floattostr(vrcxa)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));

        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;
      end;
      qrySelecionaDesconto.Next;
    end;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
    qryInsereDesconto.SQL.Add('   from fc32110 ');
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
    qryInsereDesconto.Open;

    valortotal := qryInsereDesconto.FieldValues['VALOR'];

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update fc32100 ');
    qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('BSCROSS') + ', ');
    qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.CommitRetaining;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update totvsconf ');
    qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
    qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.Commit;

    showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
  end;
end;


procedure TfrmPrincipal.CampanhaCarnaval;
var
  valortotal, valordescun, vrBrinde, vrtotal, vrdsc, vrDescTotal, percdesc: double;
  QTDprod, qtdBrinde, codBrinde, item: integer;
begin
  lblDescontoValor.Caption := '0';
  QTDprod := 0;
  qtdBrinde := 0;

  vrtotal := 0;
  useridaut := '';
  vrdsc := 0;
  vrDescTotal := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 17522) then // codigo do Brinde
    begin
      qtdBrinde := qtdBrinde + qryTerminalBalcao.FieldValues['QUANT'];
      vrBrinde := qryTerminalBalcao.FieldValues['PRUNI'];
      codBrinde := qryTerminalBalcao.FieldValues['CDPRO'];
      vrdsc := qryTerminalBalcao.FieldValues['vrdsc'];
    end
    else if (qryTerminalBalcao.FieldValues['tpitm'] = 'V') then   // códigos dos produtos para Varejo;
    begin
      QTDprod := QTDprod + qryTerminalBalcao.FieldValues['QUANT'];
      vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];
    end;

    qryTerminalBalcao.next;
  end;

  if (vrtotal < 300) then
    raise exception.create('Valor da compra abaixo de R$ 300,00. Valor insuficiente para o brinde( PROMOÇÃO DE CARNAVAL ). Valor Total:' + TrocaVirgPPto(FloatToStr((vrtotal * 1))));

  if (qtdBrinde <> 1) then
    raise Exception.Create('Quantidade de brinde( Delineador  ) incorreto!');

  valordescun := (vrBrinde * 0.9993{100% de desconto});
  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((valordescun * 1)));

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' referente ao brinde PROMOÇÃO DE CARNAVAL?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryTerminalBalcao.First;
      while not qryTerminalBalcao.eof do
      begin
        if (qryTerminalBalcao.FieldValues['CDPRO'] = 17522) then
        begin
          valordescun := (vrBrinde * 0.9993 {100% de desconto});
          vrDescTotal := vrDescTotal + ((qryTerminalBalcao.FieldValues['PRUNI'] * 0.9993) * qryTerminalBalcao.FieldValues['QUANT']);

          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.93)) + ',  ');
          qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
          qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
          qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
          qryInsereDesconto.SQL.Add('   where tpitm=' + quotedstr('V'));
          qryInsereDesconto.SQL.Add('     and cdfil=' + trim(frmPrincipal.edtLoja.Text));
          qryInsereDesconto.SQL.Add('     and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
          qryInsereDesconto.SQL.Add('     and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('     and cdpro in (' + IntToStr(codBrinde) + ')');

          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
        end;
        qryTerminalBalcao.next;
      end;

      lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrDescTotal)));

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('Carnaval') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.CampanhaFotosense;
var
  valortotal, valordescun, vrBrinde, vrtotal, vrdsc, vrDescTotal, percdesc: double;
  QTDprod, qtdBrinde, codBrinde, item: integer;
begin
  lblDescontoValor.Caption := '0';
  QTDprod := 0;
  qtdBrinde := 0;

  vrtotal := 0;
  useridaut := '';
  vrdsc := 0;
  vrDescTotal := 0;

  qryTerminalBalcao.First;

  while not qryTerminalBalcao.EOF do
  begin

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 17633) or (qryTerminalBalcao.FieldValues['CDPRO'] = 17634) or (qryTerminalBalcao.FieldValues['CDPRO'] = 17635) or (qryTerminalBalcao.FieldValues['CDPRO'] = 17636) then // codigo do Brinde
    begin
      qtdBrinde := qtdBrinde + qryTerminalBalcao.FieldValues['QUANT'];
      vrBrinde := qryTerminalBalcao.FieldValues['PRUNI'];
      codBrinde := qryTerminalBalcao.FieldValues['CDPRO'];
      vrdsc := qryTerminalBalcao.FieldValues['vrdsc'];
    end
    else if (qryTerminalBalcao.FieldValues['CDPRO'] = 9935) or (qryTerminalBalcao.FieldValues['CDPRO'] = 9936) or (qryTerminalBalcao.FieldValues['CDPRO'] = 9937) or (qryTerminalBalcao.FieldValues['CDPRO'] = 17517) then  // códigos dos produtos Campanha Fotosense;
    begin
      QTDprod := QTDprod + qryTerminalBalcao.FieldValues['QUANT'];
      vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];
    end;

    qryTerminalBalcao.next;
  end;

  if (QTDprod < 2) then
    raise exception.create(' Quantidade de produtos insuficiente para o brinde( Campanha Fotosense ). Qtd Total:' + intToStr(QTDprod));

  if (qtdBrinde <> verQtdProdutos) then
    raise Exception.Create('Quantidade de brinde (Campanha Fotosense) Incorreta!');

  valordescun := (vrBrinde * 0.9960{100% de desconto});

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((valordescun * 1)));

  if (lblDescontoValor.Caption <> '0') then
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' referente ao brinde Campanha Fotosense?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryTerminalBalcao.First;

      while not qryTerminalBalcao.eof do
      begin
        if (qryTerminalBalcao.FieldValues['CDPRO'] = 17633) or (qryTerminalBalcao.FieldValues['CDPRO'] = 17634) or (qryTerminalBalcao.FieldValues['CDPRO'] = 17635) or (qryTerminalBalcao.FieldValues['CDPRO'] = 17636) then
        begin
          valordescun := (vrBrinde * 0.9960 {100% de desconto});
          vrDescTotal := vrDescTotal + ((qryTerminalBalcao.FieldValues['PRUNI'] * 0.9960) * qryTerminalBalcao.FieldValues['QUANT']);
          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.60)) + ', ');
          qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')), ');
          qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
          qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
          qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
          qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
          qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and itemid = ' + intToStr(qryTerminalBalcao.FieldValues['itemid']));

          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
        end;
        qryTerminalBalcao.next;
      end;
      lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrDescTotal)));

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('   where  cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('     and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('     and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('Fotosense') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      QryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
end;

procedure TfrmPrincipal.BotulinUp;
var
  valortotal, valordescun, vrBrinde, vrtotal, vrdsc, vrDescTotal, percdesc: double;
  qtdCampanha, qtdBrinde, codBrinde, item: integer;
begin
  lblDescontoValor.Caption := '0';

  qtdCampanha := 0;
  qtdBrinde := 0;

  vrtotal := 0;
  useridaut := '';
  vrdsc := 0;
  vrDescTotal := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = 16941) or (qryTerminalBalcao.FieldValues['CDPRO'] = 16942) or (qryTerminalBalcao.FieldValues['CDPRO'] = 16943) then // codigo do sabonete
    begin
      qtdBrinde := qtdBrinde + qryTerminalBalcao.FieldValues['QUANT'];
      vrBrinde := qryTerminalBalcao.FieldValues['PRUNI'];
      codBrinde := qryTerminalBalcao.FieldValues['CDPRO'];
      vrdsc := qryTerminalBalcao.FieldValues['vrdsc'];
    end
    else if (qryTerminalBalcao.FieldValues['CDPRO'] = 16730) then   // código dos produto Campanha Botulin Up
    begin
      qtdCampanha := qtdCampanha + qryTerminalBalcao.FieldValues['QUANT'];
    end;

    qryTerminalBalcao.next;
  end;
  if (qtdCampanha < 1) then
    raise exception.create('Quantidade do produto Botulin Up , incorreto para a campanha. ');

  if (qtdBrinde <> qtdCampanha) then
    raise Exception.Create('Quantidade de brinde( Batom  ) incorreto!');

  valordescun := (vrBrinde * 0.9998{100% de desconto});
  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((valordescun * 1)));

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' referente ao brinde da Campanha Botulin Up?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin

      qryTerminalBalcao.First;
      while not qryTerminalBalcao.eof do
      begin

        if (qryTerminalBalcao.FieldValues['CDPRO'] = 16941) or (qryTerminalBalcao.FieldValues['CDPRO'] = 16942) or (qryTerminalBalcao.FieldValues['CDPRO'] = 16943) then
        begin
          valordescun := (vrBrinde * 0.9998{100% de desconto});
          vrDescTotal := vrDescTotal + ((qryTerminalBalcao.FieldValues['PRUNI'] * 0.9998) * qryTerminalBalcao.FieldValues['QUANT']);

          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.98)) + ',  ');
          qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
          qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
          qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
          qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
          qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
          qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and cdpro = ' + qryTerminalBalcao.FieldByName('CDPRO').AsString);

          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
        end;
        qryTerminalBalcao.next;
      end;

      lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrDescTotal)));

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('   where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('     and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('     and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('BotulinUp') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.MesDasMaes;
var
  valortotal, valordescun, vrBrinde, vrtotal, vrdsc, vrDescTotal: double;
  p, p1, codBrinde, item: integer;
begin
  lblDescontoValor.Caption := '0';
  p := 0;
  p1 := 0;
  vrtotal := 0;
  useridaut := '';
  vrdsc := 0;
  vrDescTotal := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['tpitm'] = 'V') and (qryTerminalBalcao.FieldValues['CDPRO'] <> 13661) then
    begin
      p := p + qryTerminalBalcao.FieldValues['QUANT'];
      vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];
    end;

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 13661) then
    begin
      p1 := p1 + qryTerminalBalcao.FieldValues['QUANT'];
      vrBrinde := qryTerminalBalcao.FieldValues['PRUNI'];
      codBrinde := qryTerminalBalcao.FieldValues['CDPRO'];
      vrdsc := qryTerminalBalcao.FieldValues['vrdsc'];
    end;
    qryTerminalBalcao.next;
  end;

  if (vrdsc > 0) then
    raise Exception.Create('Venda Já possui Desconto - campanha Mês das Mâes. ');

  if (vrtotal < 300) then
    raise exception.create('Valor da compra abaixo de R$ 300,00. Valor insuficiente para o brinde(Bolsa Praia). Valor Total:' + TrocaVirgPPto(FloatToStr((vrtotal * 1))));

  if (p1 <> 1) then
    raise Exception.Create('Quantidade de brinde(Bolsa praia) incorreto!');

  valordescun := (vrBrinde * 0.9998{100% de desconto});
  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((valordescun * 1)));

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo Promoção Mês das Mâes?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin

      qryTerminalBalcao.First;
      while not qryTerminalBalcao.eof do
      begin
        if (qryTerminalBalcao.FieldValues['CDPRO'] = 13661) then
        begin
          valordescun := (vrBrinde * 0.9998{100% de desconto});
          vrDescTotal := vrDescTotal + ((qryTerminalBalcao.FieldValues['PRUNI'] * 0.9998) * qryTerminalBalcao.FieldValues['QUANT']);

          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.98)) + ',  ');
          qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
          qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')), ');
          qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
          qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
          qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
          qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
          qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
          qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add(' and cdpro in (' + IntToStr(codBrinde) + ')');

          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
          qryInsereDesconto.Close;
        end;

        qryTerminalBalcao.next;
      end;

      if MessageDlg('Deseja aplicar desconto (5%) Loja?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
      begin
        qryTerminalBalcao.First;
        while not qryTerminalBalcao.eof do
        begin
          if (qryTerminalBalcao.FieldValues['CDPRO'] = 13661) then  // brinde
          begin
            qryTerminalBalcao.next;
            continue;
          end
          else
          begin
            item := qryTerminalBalcao.FieldValues['itemID'];
            valordescun := (qryTerminalBalcao.FieldValues['PRUNI'] * 0.05{ 5% de desconto});
            vrDescTotal := vrDescTotal + ((qryTerminalBalcao.FieldValues['PRUNI'] * 0.05) * qryTerminalBalcao.FieldValues['QUANT']);

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' update fc32110 ');
            qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(5.00)) + ', ');
            qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
            qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
            qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
            qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
            qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
            qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
            qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
            qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
            qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
            qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
            qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
            qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
            qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
            qryInsereDesconto.SQL.Add('    and itemID = ' + intToStr(item));

            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.CommitRetaining;
          end;
          qryTerminalBalcao.next;
        end;
      end;

      lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrDescTotal)));

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('mesdasmaes') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.P1Click(Sender: TObject);
begin
  frmPlanilhaDescontos.ShowModal;
end;

procedure TfrmPrincipal.MesDaMulher;
var
  valortotal, valordescun, vrprod, vrtotal, vrdsc: double;
  p, p1, codprod: integer;
begin

  lblDescontoValor.Caption := '0';
  p := 0;
  p1 := 0;
  vrtotal := 0;
  useridaut := '';
  vrdsc := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin

    if qryTerminalBalcao.FieldValues['tpitm'] = 'V' then
    begin
      p := p + qryTerminalBalcao.FieldValues['QUANT'];
      vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];
    end;

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 16441) then
    begin
      p1 := p1 + qryTerminalBalcao.FieldValues['QUANT'];
      vrprod := qryTerminalBalcao.FieldValues['PRUNI'];
      codprod := qryTerminalBalcao.FieldValues['CDPRO'];
      vrdsc := qryTerminalBalcao.FieldValues['vrdsc'];
    end;

    qryTerminalBalcao.next;
  end;

  if (vrdsc > 0) then
    raise Exception.Create('Venda Já possui Desconto - campanha Mês da Mulher. ');

  if (vrtotal < 250) then
    raise exception.create('Valor da compra abaixo de R$ 250,00. Valor insuficiente para o brinde. Valor Total:' + TrocaVirgPPto(FloatToStr((vrtotal * 1))));

  if (p1 <> 1) then
    raise Exception.Create('Quantidade de brinde incorreto!');

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 1)));
  valordescun := (vrprod * 0.9998{100% de desconto});
  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo Promoção Mês da Mulher?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.98)) + ',  ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.SQL.Add('    and cdpro in (' + IntToStr(codprod) + ')');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('mesdamulher') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.SllepMax2;
var
  valortotal, valordescun, vrPRUNI, vrtotal, vrdsc, percPromocao: double;
  qtdProd, qtdPromocao, resto: integer;
begin
  lblDescontoValor.Caption := '0';
  qtdProd := 0;
  qtdPromocao := 0;
  vrtotal := 0;
  useridaut := '';

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    vrdsc := vrdsc + qryTerminalBalcao.FieldValues['vrdsc'];

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 13150) then
    begin
      qtdProd := qtdProd + qryTerminalBalcao.FieldValues['QUANT'];
      vrPRUNI := qryTerminalBalcao.FieldValues['PRUNI'];
      vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];
    end;

    qryTerminalBalcao.next;
  end;

  if (vrdsc > 0) then
    raise Exception.Create('Venda Já possui Desconto de campanha. ');

  if (vrtotal = 0) then
    raise Exception.Create('Venda não possui produto da campanha SllepMax. ');

  resto := (qtdProd mod 2);
  if resto = 0 then
    qtdPromocao := qtdProd div 2
  else
    qtdPromocao := (qtdProd - resto) div 2;

  percPromocao := ((vrPRUNI * qtdPromocao) * 100) / vrtotal;
  valordescun := ((vrtotal * percPromocao) / 100);
  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr(valordescun));

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo Promoção SllepMax?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(percPromocao)) + ', ');
      qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(valordescun)) + '/ QUANT) , ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=((' + TrocaVirgPPto(FloatToStr(valordescun)) + ')), ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-((' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-((' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-((' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-( (' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-( (' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.SQL.Add('    and cdpro = 13150 ');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('sllepmax') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;


procedure TfrmPrincipal.SllepMax1;
var
  valortotal, valordescun, vrPRUNI, vrtotal, vrdsc, percPromocao: double;
  qtdProd, qtdPromocao, resto: integer;
begin
  lblDescontoValor.Caption := '0';
  qtdProd := 0;
  qtdPromocao := 0;
  vrtotal := 0;
  useridaut := '';

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    vrdsc := vrdsc + qryTerminalBalcao.FieldValues['vrdsc'];

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 13150) then
    begin
      qtdProd := qtdProd + qryTerminalBalcao.FieldValues['QUANT'];
      vrPRUNI := qryTerminalBalcao.FieldValues['PRUNI'];
      vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];
    end;

    qryTerminalBalcao.next;
  end;
  if (vrdsc > 0) then
    raise Exception.Create('Venda Já possui Desconto de campanha. ');

  if (vrtotal = 0) then
    raise Exception.Create('Venda não possui produto da campanha SllepMax. ');

  resto := (qtdProd mod 2);
  if resto = 0 then
    qtdPromocao := qtdProd div 2
  else
    qtdPromocao := (qtdProd - resto) div 2;

  percPromocao := 99.98;
  valordescun := vrPRUNI * 0.9998;
  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr(valordescun));

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo a ' + intTostr(qtdPromocao) + ' produto(s) da Promoção SllepMax?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryTerminalBalcao.First;
      qtdProd := 1;
      while (not qryTerminalBalcao.Eof) and (qtdProd <= qtdPromocao) and (qryTerminalBalcao.FieldByName('CDPRO').AsString = '13150') do
      begin
        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.98)) + ',  ');
        qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
        qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
        qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qryTerminalBalcao.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qryTerminalBalcao.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qryTerminalBalcao.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qryTerminalBalcao.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qryTerminalBalcao.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;

        qtdProd := qtdProd + 1;

        qryTerminalBalcao.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('sllepmax') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.compre1Leve2Colageno;
var
  valortotal, valordescun, vrPRUNI, vrtotal, vrdsc, percPromocao: double;
  qtdProd, qtdPromocao, resto: integer;
begin

  lblDescontoValor.Caption := '0';
  qtdProd := 0;
  qtdPromocao := 0;
  vrtotal := 0;
  useridaut := '';
  vrdsc := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 17352) then // CODIGO DO COLAGENO
    begin
      qtdProd := qtdProd + qryTerminalBalcao.FieldValues['QUANT'];
      vrPRUNI := qryTerminalBalcao.FieldValues['PRUNI'];
      vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];
      vrdsc := vrdsc + qryTerminalBalcao.FieldValues['vrdsc'];
    end;

    qryTerminalBalcao.next;
  end;

  if (vrtotal = 0) then
    raise Exception.Create('Venda não possui produto da campanha COMPRE 1 LEVE 2 (COLÁGENO). ');

  if (vrdsc > 0) then
    raise Exception.Create('Venda Já possui Desconto de campanha COMPRE 1 LEVE 2 (COLÁGENO). ');

  resto := (qtdProd mod 2);
  if resto = 0 then
    qtdPromocao := qtdProd div 2
  else
    qtdPromocao := (qtdProd - resto) div 2;

  percPromocao := 99.92;
  valordescun := vrPRUNI * 0.9992;
  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr(valordescun));

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo a Campanha COMPRE 1 LEVE 2 (COLÁGENO) ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryTerminalBalcao.First;
      qtdProd := 1;
      while (not qryTerminalBalcao.Eof) and (qtdProd <= qtdPromocao) do
      begin
        if (qryTerminalBalcao.FieldByName('CDPRO').AsString <> '17352') then
        begin
          qryTerminalBalcao.Next;
          continue;
        end;

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.98)) + ',  ');
        qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
        qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
        qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qryTerminalBalcao.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qryTerminalBalcao.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qryTerminalBalcao.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qryTerminalBalcao.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qryTerminalBalcao.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.Commit;

        qtdProd := qtdProd + 1;

        qryTerminalBalcao.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('Compre1Leve2Colageno') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.compre1Leve2Palatinose;
var
  valortotal, valordescun, vrPRUNI, vrtotal, vrdsc, percPromocao: double;
  qtdProd, qtdPromocao, resto: integer;
begin

  lblDescontoValor.Caption := '0';
  qtdProd := 0;
  qtdPromocao := 0;
  vrtotal := 0;
  useridaut := '';

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 17244) then // CODIGO DA PALATINOSE
    begin
      qtdProd := qtdProd + qryTerminalBalcao.FieldValues['QUANT'];
      vrPRUNI := qryTerminalBalcao.FieldValues['PRUNI'];
      vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];
      vrdsc := vrdsc + qryTerminalBalcao.FieldValues['vrdsc'];
    end;

    qryTerminalBalcao.next;
  end;

  if (vrtotal = 0) then
    raise Exception.Create('Venda não possui produto da campanha COMPRE 1 LEVE 2 (PALATINOSE)). ');

  if (vrdsc > 0) then
    raise Exception.Create('Venda Já possui Desconto de campanha COMPRE 1 LEVE 2 (PALATINOSE). ');

  resto := (qtdProd mod 2);
  if resto = 0 then
    qtdPromocao := qtdProd div 2
  else
    qtdPromocao := (qtdProd - resto) div 2;

  percPromocao := 99.89;
  valordescun := vrPRUNI * 0.9989;
  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr(valordescun));

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo a Campanha COMPRE 1 LEVE 2 (PALATINOSE) ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryTerminalBalcao.First;
      qtdProd := 1;
      while (not qryTerminalBalcao.Eof) and (qtdProd <= qtdPromocao) do
      begin

        if (qryTerminalBalcao.FieldByName('CDPRO').AsString <> '17244') then
        begin
          qryTerminalBalcao.Next;
          continue;
        end;

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.98)) + ', ');
        qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
        qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
        qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qryTerminalBalcao.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qryTerminalBalcao.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qryTerminalBalcao.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qryTerminalBalcao.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qryTerminalBalcao.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.Commit;

        qtdProd := qtdProd + 1;

        qryTerminalBalcao.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;
      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('Compre1Leve2Palatin') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.HomeLuxuryAlfmofada;
var
  valortotal, valordescun, vrPRUNI, vrtotal, vrdsc, percPromocao: double;
  qtdProd, qtdPromocao, resto: integer;
begin
  lblDescontoValor.Caption := '0';
  qtdProd := 0;
  qtdPromocao := 0;
  vrtotal := 0;
  useridaut := '';

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = 19027) then // HOME LUXURY - ALMOFADA
    begin
      qtdProd := qtdProd + qryTerminalBalcao.FieldValues['QUANT'];
      vrPRUNI := qryTerminalBalcao.FieldValues['PRUNI'];
      vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];
      vrdsc := vrdsc + qryTerminalBalcao.FieldValues['vrdsc'];
    end;

    qryTerminalBalcao.next;
  end;

  if (vrtotal = 0) then
    raise Exception.Create('Venda não possui produto da campanha HOME LUXURY - ALMOFADA. ');

  if (vrdsc > 0) then
    raise Exception.Create('Venda Já possui Desconto de campanha HOME LUXURY - ALMOFADA. ');

  resto := (qtdProd mod 2);
  if resto = 0 then
    qtdPromocao := qtdProd div 2
  else
    qtdPromocao := (qtdProd - resto) div 2;

  percPromocao := 50.00;
  valordescun := vrPRUNI * 0.5000;
  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr(valordescun));

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto 50% de R$ ' + lblDescontoValor.Caption + ' relativo a Campanha HOME LUXURY - ALMOFADA  ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin

      qryTerminalBalcao.First;
      qtdProd := 1;
      while (not qryTerminalBalcao.Eof) and (qtdProd <= qtdPromocao) do
      begin

        if (qryTerminalBalcao.FieldByName('CDPRO').AsString <> '19027') then
        begin
          qryTerminalBalcao.Next;
          continue;
        end;

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(50.00)) + ',  ');
        qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
        qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
        qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qryTerminalBalcao.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qryTerminalBalcao.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qryTerminalBalcao.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qryTerminalBalcao.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qryTerminalBalcao.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.Commit;

        qtdProd := qtdProd + 1;

        qryTerminalBalcao.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('HomeLuxuryAlfmofada') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.CloneAlmofada;
var
  valortotal, valordescun, vrPRUNI, vrtotal, vrdsc, percPromocao: double;
  qtdProd, qtdPromocao, resto: integer;
begin
  lblDescontoValor.Caption := '0';
  qtdProd := 0;
  qtdPromocao := 0;
  vrtotal := 0;
  useridaut := '';

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 19027) then // HOME LUXURY - ALMOFADA
    begin
      qtdProd := qtdProd + qryTerminalBalcao.FieldValues['QUANT'];
      vrPRUNI := qryTerminalBalcao.FieldValues['PRUNI'];
      vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];
      vrdsc := vrdsc + qryTerminalBalcao.FieldValues['vrdsc'];
    end;

    qryTerminalBalcao.next;
  end;

  if (vrtotal = 0) then
    raise Exception.Create('Venda não possui produto da Campanha Clone de ALMOFADA. ');

  if (vrdsc > 0) then
    raise Exception.Create('Venda Já possui Desconto de Campanha Clone de ALMOFADA. ');

  if qtdProd < 2 then
    raise Exception.Create('Quantidade de produtos infuciente para a Campanha Clone de ALMOFADA.');

  qtdPromocao := qtdProd;

  percPromocao := 50.00;
  valordescun := vrPRUNI * 0.5000;
  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr(valordescun));

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar 50% de desconto - R$ ' + lblDescontoValor.Caption + ' em cada item, relativo a Campanha Clone de ALMOFADA?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryTerminalBalcao.First;
      qtdProd := 1;
      while (not qryTerminalBalcao.Eof) and (qtdProd <= qtdPromocao) do
      begin

        if (qryTerminalBalcao.FieldByName('CDPRO').AsString <> '19027') then
        begin
          qryTerminalBalcao.Next;
          continue;
        end;

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(50.00)) + ', ');
        qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
        qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
        qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qryTerminalBalcao.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qryTerminalBalcao.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qryTerminalBalcao.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qryTerminalBalcao.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qryTerminalBalcao.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.Commit;

        qtdProd := qtdProd + 1;

        qryTerminalBalcao.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;
      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('CloneAlfmofada') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.CloneCurcuma;
var
  valortotal, valordescun, vrPRUNI, vrtotal, vrdsc, percPromocao: double;
  qtdProd, qtdPromocao: integer;
begin
  if (StrToDate(FormatDateTime('dd/mm/yyyy', now)) < strtodate('01/02/2025')) then
    raise Exception.Create('Promoção disponível a partir de fevereiro/2025.');

  lblDescontoValor.Caption := '0';
  qtdProd := 0;
  qtdPromocao := 0;
  vrtotal := 0;
  useridaut := '';
  vrdsc := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 17718) then // Clone Cúrcuma
    begin
      qtdProd := qtdProd + qryTerminalBalcao.FieldValues['QUANT'];
      vrPRUNI := qryTerminalBalcao.FieldValues['PRUNI'];
      vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];
      vrdsc := vrdsc + qryTerminalBalcao.FieldValues['vrdsc'];
    end;

    qryTerminalBalcao.next;
  end;

  if (vrtotal = 0) then
    raise Exception.Create('Venda não possui produto da Campanha Clone Cúrcuma. ');

  if qtdProd < 2 then
    raise Exception.Create('Quantidade de produtos infuciente para a Campanha Clone Cúrcuma.');

  qtdPromocao := qtdProd;

  percPromocao := 50.00;
  valordescun := vrPRUNI * 0.5000;
  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr(valordescun));

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar 50% de desconto - R$ ' + lblDescontoValor.Caption + ' em cada item, relativo a Campanha Clone Cúrcuma?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryTerminalBalcao.First;
      qtdProd := 1;
      while (not qryTerminalBalcao.Eof) and (qtdProd <= qtdPromocao) do
      begin

        if (qryTerminalBalcao.FieldByName('CDPRO').AsString <> '17718') then
        begin
          qryTerminalBalcao.Next;
          continue;
        end;

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(50.00)) + ',  ');
        qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
        qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
        qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qryTerminalBalcao.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qryTerminalBalcao.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qryTerminalBalcao.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qryTerminalBalcao.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qryTerminalBalcao.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.Commit;

        qtdProd := qtdProd + 1;

        qryTerminalBalcao.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;
      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('CloneCurcuma') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.GessoPerfumado;
var
  valortotal, valordescun, vrPRUNI, vrtotal, vrdsc, percPromocao: double;
  qtdProd, qtdPromocao, resto, qtdQuant: integer;
begin
  {}
  lblDescontoValor.Caption := '0';
  qtdProd := 0;
  qtdPromocao := 0;
  vrtotal := 0;
  useridaut := '';

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 17459) then // GessoPerfumado
    begin
      qtdProd := qtdProd + qryTerminalBalcao.FieldValues['QUANT'];
      vrPRUNI := qryTerminalBalcao.FieldValues['PRUNI'];
      vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];
      vrdsc := vrdsc + qryTerminalBalcao.FieldValues['vrdsc'];
    end;

    qryTerminalBalcao.next;
  end;

  if (vrtotal = 0) then
    raise Exception.Create('Venda não possui produto da campanha GESSO PERFUMADO.  ');

  if (vrdsc > 0) then
    raise Exception.Create('Venda Já possui Desconto de campanha GESSO PERFUMADO. ');

  resto := (qtdProd mod 2);
  if resto = 0 then
    qtdPromocao := qtdProd div 2
  else
    qtdPromocao := (qtdProd - resto) div 2;

  percPromocao := 50.00;
  valordescun := vrPRUNI * 0.5000;
  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr(valordescun));

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto (50%) de R$ ' + lblDescontoValor.Caption + ' relativo a Campanha '+CAMPANHA_GESSO_PERFUMADO+'?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin

      qryTerminalBalcao.First;
      qtdProd := 1;
      while (not qryTerminalBalcao.Eof) and (qtdProd <= qtdPromocao) do
      begin

        if (qryTerminalBalcao.FieldByName('CDPRO').AsString <> '17459') then
        begin
          qryTerminalBalcao.Next;
          continue;
        end;

        qtdQuant := qryTerminalBalcao.FieldByName('quant').AsInteger;
        if qryTerminalBalcao.FieldByName('quant').AsInteger > 1 then
          qtdQuant := qtdPromocao;

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(50.00)) + ', ');
        qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(' + intToStr(qtdQuant) + ' * ' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(' + IntToStr(qtdQuant) + ' * ' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrdsc=(' + IntToStr(qtdQuant) + ' * (' + TrocaVirgPPto(FloatToStr(valordescun)) + ')), ');
        qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(' + IntToStr(qtdQuant) + ' * (' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(' + IntToStr(qtdQuant) + ' * (' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
        qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(' + IntToStr(qtdQuant) + ' *(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-( ' + IntToStr(qtdQuant) + ' *(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(' + IntToStr(qtdQuant) + ' *(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qryTerminalBalcao.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qryTerminalBalcao.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qryTerminalBalcao.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qryTerminalBalcao.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qryTerminalBalcao.FieldValues['itemid']));

        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.Commit;

        qtdProd := qtdProd + 1;

        qryTerminalBalcao.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;
      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('GessoPerfumado') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;
             {}
      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.LinhaCleanTherapy;
var
  valortotal, valdesc, valorunitdesc, valdescBrinde: double;
  p, i, q, qt, qtBrinde: integer;
  qt1, percdesc: integer;
  msg: string;
begin
  lblDescontoValor.Caption := '0';
  p := 0;
  qt1 := 0;

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add('   select a.cdpro as COD, a.quant, a.pruni ,a.vrtot, a.vrdsc ');
  qryFcertaTEMP.SQL.Add('     from fc32110 a ');
  qryFcertaTEMP.SQL.Add('    where a.dtope=current_date ');
  qryFcertaTEMP.SQL.Add('      and a.cdfil=' + edtLoja.Text);
  qryFcertaTEMP.SQL.Add('      and a.nrcpm=' + edtTerminalBalcao.Text);
  qryFcertaTEMP.SQL.Add('      and a.tpitm=' + quotedstr('V'));
  qryFcertaTEMP.SQL.Add('      and a.cdpro in (  15825 ,15708,15709,15826,15831,15827,16095,16097,15985,16096,16098,17260	)  ');
  qryFcertaTEMP.SQL.Add(' order by 3 ');

  qryFcertaTEMP.Open;
  valdesc := 0;
  while not qryFcertaTEMP.Eof do
  begin

    if (qryFcertaTEMP.FieldValues['cod'] = 16095) or (qryFcertaTEMP.FieldValues['cod'] = 16097) or (qryFcertaTEMP.FieldValues['cod'] = 15985) or (qryFcertaTEMP.FieldValues['cod'] = 16096) or (qryFcertaTEMP.FieldValues['cod'] = 16098) then
    begin
      qtBrinde := qtBrinde + 1;
    end
    else
    begin
      qt1 := qt1 + qryFcertaTEMP.FieldValues['quant'];
      valdesc := valdesc + qryFcertaTEMP.FieldValues['vrdsc'];
    end;

    qryFcertaTEMP.Next;
  end;

  if valdesc > 0 then
    raise Exception.Create('Venda Já possui Desconto');

  if (qt1 < 2) then
  begin
    qryFcertaTEMP.Close;
    raise exception.create('Não existem produtos suficientes da campanha LinhaCleanTherapy nessa venda. ');
  end;

  if qt1 = 2 then
    percdesc := 10;
  if qt1 >= 3 then
    percdesc := 15;

  valdesc := 0;//zera valor de desconto

  qryFcertaTEMP.First;
  while not qryFcertaTEMP.Eof do
  begin
     //  valordescun:= (vrprod * 0.9998{100% de desconto});
    if (qryFcertaTEMP.FieldValues['cod'] = 16095) or (qryFcertaTEMP.FieldValues['cod'] = 16097) or (qryFcertaTEMP.FieldValues['cod'] = 15985) or (qryFcertaTEMP.FieldValues['cod'] = 16096) or (qryFcertaTEMP.FieldValues['cod'] = 16098) then
      valdesc := valdesc + ((qryFcertaTEMP.FieldValues['vrtot'] * 0.9998))
    else
      valdesc := valdesc + ((qryFcertaTEMP.FieldValues['vrtot'] * percdesc) / 100);

    qryFcertaTEMP.Next;

  end;

  qryFcertaTEMP.Close;
//  lblDescontoValor.Caption := TrocaVirgPPto(floattostr(valdesc));

  msg := 'Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo a campanha LinhaCleanTherapy?' + #13 + inttostr(percdesc) + '% nos itens válidos';

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg(msg, mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      Desconto_Linha_Clean_Therapy(valortotal,InfoTela);
      lblDescontoValor.Caption := TrocaVirgulaPorPonto(FloatToStr(valortotal));
      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.CoqueteleiraColagenos;
var
  valortotal, valdesc, valorunitdesc, valdescBrinde, percdesc: double;
  percdesc_beauty, percdesc_articula, qtBrinde, beauty, articula: integer;
  msg: string;
begin
  lblDescontoValor.Caption := '0';
  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add('   select a.cdpro as COD, a.quant, a.pruni ,a.vrtot, a.vrdsc ');
  qryFcertaTEMP.SQL.Add('     from fc32110 a ');
  qryFcertaTEMP.SQL.Add('    where a.dtope=current_date ');
  qryFcertaTEMP.SQL.Add('      and a.cdfil=' + edtLoja.Text);
  qryFcertaTEMP.SQL.Add('      and a.nrcpm=' + edtTerminalBalcao.Text);
  qryFcertaTEMP.SQL.Add('      and a.tpitm=' + quotedstr('V'));
  qryFcertaTEMP.SQL.Add('      and a.cdpro  in (  12489, 12491 , 12492 , 16450 , 16451, 16452 , 16453 , 16454  	)  ');
  qryFcertaTEMP.SQL.Add(' order by 3 ');

  qryFcertaTEMP.Open;
  valdesc := 0;
  beauty := 0;
  articula := 0;
  while not qryFcertaTEMP.Eof do
  begin

    if (qryFcertaTEMP.FieldValues['cod'] = 16450) or (qryFcertaTEMP.FieldValues['cod'] = 16451) or (qryFcertaTEMP.FieldValues['cod'] = 16452) or (qryFcertaTEMP.FieldValues['cod'] = 16453) or (qryFcertaTEMP.FieldValues['cod'] = 16454) then
      qtBrinde := qtBrinde + 1
    else
    begin
      if (qryFcertaTEMP.FieldValues['cod'] = 12491) or  // codigo dos produtos beauty
        (qryFcertaTEMP.FieldValues['cod'] = 12492) then
      begin
        beauty := beauty + qryFcertaTEMP.FieldValues['quant'];
        valdesc := valdesc + qryFcertaTEMP.FieldValues['vrdsc'];
      end
      else   // 12489 cod do produto articula
      begin
        articula := articula + qryFcertaTEMP.FieldValues['quant'];
        valdesc := valdesc + qryFcertaTEMP.FieldValues['vrdsc'];
      end;

    end;

    qryFcertaTEMP.Next;
  end;

  if valdesc > 0 then
    raise Exception.Create('Venda Já possui Desconto');

  if (qtBrinde <> 1) then
    raise Exception.Create('Quantidade de brinde incorreta');  // não pode lançar sem o brinde

  percdesc_beauty := 0;
  percdesc_articula := 0;

  if (beauty = 2) then
    percdesc_beauty := 10;
  if (beauty > 2) then
    percdesc_beauty := 15;

  if (articula = 2) then
    percdesc_articula := 10;
  if (articula > 2) then
    percdesc_articula := 15;

  if (beauty + articula < 2) then
  begin
    qryFcertaTEMP.Close;
    raise exception.create('Não existem produtos suficientes nessa venda para o brinde Coqueteleira. ');
  end;

  valdesc := 0;//zera valor de desconto - monta mensagem
  lblDescontoValor.Caption := '';
  qryFcertaTEMP.First;

  while not qryFcertaTEMP.Eof do
  begin
    if (qryFcertaTEMP.FieldValues['cod'] = 16450) or (qryFcertaTEMP.FieldValues['cod'] = 16451) or (qryFcertaTEMP.FieldValues['cod'] = 16452) or (qryFcertaTEMP.FieldValues['cod'] = 16453) or (qryFcertaTEMP.FieldValues['cod'] = 16454) then
    begin
      valdesc := valdesc + (qryFcertaTEMP.FieldValues['vrtot'] * 0.9998);
      percdesc := 99.98;
      lblDescontoValor.Caption := lblDescontoValor.Caption + ' ' + #13 + TrocaVirgPPto(floattostr(valdesc)) + ' - Brinde - ' + CurrTostr(percdesc) + '%';
    end;

    if (percdesc_beauty > 0) and ((qryFcertaTEMP.FieldValues['cod'] = 12491) or (qryFcertaTEMP.FieldValues['cod'] = 12492)) then
    begin
      valdesc := valdesc + ((qryFcertaTEMP.FieldValues['vrtot'] * percdesc_beauty) / 100);
      percdesc := percdesc_beauty;
      lblDescontoValor.Caption := lblDescontoValor.Caption + ' ' + #13 + TrocaVirgPPto(floattostr(valdesc)) + ' - BEAUTY COLLAGEN - ' + inttostr(percdesc_beauty) + '%';
    end;

    if (percdesc_articula > 0) and (qryFcertaTEMP.FieldValues['cod'] = 12489) then
    begin
      valdesc := valdesc + ((qryFcertaTEMP.FieldValues['vrtot'] * percdesc_articula) / 100);
      percdesc := percdesc_articula;
      lblDescontoValor.Caption := lblDescontoValor.Caption + ' ' + #13 + TrocaVirgPPto(floattostr(valdesc)) + '  - ARTICULA FLEX COLAGENO - ' + inttostr(percdesc_articula) + '%';
    end;

    qryFcertaTEMP.Next;

  end;

  qryFcertaTEMP.Close;

  msg := 'Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo a Campanha do Colágeno? nos itens válidos';

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg(msg, mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
              // selecionando o brinde
      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.sql.Clear;
      qrySelecionaDesconto.sql.Add('    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, a.TPDSC, a.VRDSC, ');
      qrySelecionaDesconto.sql.Add('           a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, a.CDPRO, coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, ');
      qrySelecionaDesconto.sql.Add('           a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ');
      qrySelecionaDesconto.sql.Add('      from fc32110 a ');
      qrySelecionaDesconto.sql.Add(' left join fc32200 b on ( ');
      qrySelecionaDesconto.sql.Add('           a.cdfil=b.cdfil ');
      qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
      qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
      qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
      qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ');
      qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qrySelecionaDesconto.sql.Add('       and a.dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qrySelecionaDesconto.sql.Add('       and a.tpitm=' + quotedstr('V'));
      qrySelecionaDesconto.sql.Add('       and a.cdpro in (  16450 , 16451, 16452, 16453, 16454	) ');
      qrySelecionaDesconto.sql.Add('  order by a.PRUNILIQ');
      qrySelecionaDesconto.Open;
      qrySelecionaDesconto.FetchAll;
      qrySelecionaDesconto.First;

      valdesc := 0;
      tpdescvar := '3';
      while not qrySelecionaDesconto.Eof do
      begin

        desc2var := 99.98;
        valorunitdesc := (qrySelecionaDesconto.FieldValues['PRUNILIQ'] * 0.9998);

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
        qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
        qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
        qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;

        qrySelecionaDesconto.Next;
      end;

              //**********************************  BEAUTY COLLAGEN

      if percdesc_beauty > 0 then
      begin

        qrySelecionaDesconto.Close;
        qrySelecionaDesconto.sql.Clear;
        qrySelecionaDesconto.sql.Add('    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, a.TPDSC, ');
        qrySelecionaDesconto.sql.Add('           a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, a.CDPRO, coalesce( b.vrtot, a.VRTOT) as VRTOT, ');
        qrySelecionaDesconto.sql.Add('           a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ');
        qrySelecionaDesconto.sql.Add('      from fc32110 a ');
        qrySelecionaDesconto.sql.Add(' left join fc32200 b on ( ');
        qrySelecionaDesconto.sql.Add('           a.cdfil=b.cdfil ');
        qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
        qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
        qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
        qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
        qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ');
        qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
        qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
        qrySelecionaDesconto.sql.Add('       and a.dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
        qrySelecionaDesconto.sql.Add('       and a.tpitm=' + quotedstr('V'));
        qrySelecionaDesconto.sql.Add('       and a.cdpro in  (  12491, 12492	)');
        qrySelecionaDesconto.sql.Add('  order by a.PRUNILIQ ');
        qrySelecionaDesconto.Open;
        qrySelecionaDesconto.FetchAll;
        qrySelecionaDesconto.First;

        valdesc := 0;
        tpdescvar := '3';
        while not qrySelecionaDesconto.Eof do
        begin
          desc2var := percdesc_beauty;
          valorunitdesc := ((qrySelecionaDesconto.FieldValues['PRUNILIQ'] * qrySelecionaDesconto.FieldValues['QUANT']) * (desc2var / 100));

          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
          qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
          qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
          qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
          qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
          qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
          qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)));
          qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
          qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
          qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
          qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
          qrySelecionaDesconto.Next;
        end;

      end;

            //************************************** ARTICULA FLEX COLAGENO **************************************************
      if percdesc_articula > 0 then
      begin

        qrySelecionaDesconto.Close;
        qrySelecionaDesconto.sql.Clear;
        qrySelecionaDesconto.sql.Add('    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, a.TPDSC, a.VRDSC, ');
        qrySelecionaDesconto.sql.Add('           a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, a.CDPRO, coalesce( b.vrtot, a.VRTOT) as VRTOT, ');
        qrySelecionaDesconto.sql.Add('           a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ  ');
        qrySelecionaDesconto.sql.Add('      from fc32110 a ');
        qrySelecionaDesconto.sql.Add(' left join fc32200 b on ( ');
        qrySelecionaDesconto.sql.Add('           a.cdfil=b.cdfil ');
        qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
        qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
        qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
        qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
        qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid )  ');
        qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
        qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
        qrySelecionaDesconto.sql.Add('       and a.dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
        qrySelecionaDesconto.sql.Add('       and a.tpitm=' + quotedstr('V'));
        qrySelecionaDesconto.sql.Add('       and a.cdpro in ( 12489	)  ');
        qrySelecionaDesconto.sql.Add('  order by a.PRUNILIQ');

        qrySelecionaDesconto.Open;
        qrySelecionaDesconto.FetchAll;
        qrySelecionaDesconto.First;

        valdesc := 0;
        tpdescvar := '3';
        while not qrySelecionaDesconto.Eof do
        begin
          desc2var := percdesc_articula;
          valorunitdesc := ((qrySelecionaDesconto.FieldValues['PRUNILIQ'] * qrySelecionaDesconto.FieldValues['QUANT']) * (desc2var / 100));

          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
          qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
          qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
          qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
          qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
          qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
          qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)));
          qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
          qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
          qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
          qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;

          qrySelecionaDesconto.Next;
        end;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('colagenos') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.CoqueteleiraColagenos2;
var
  valortotal, valdesc, valorunitdesc, valdescBrinde, percdesc: double;
  percdesc_beauty, percdesc_articula, qtBrinde, beauty, articula: integer;
  msg: string;
begin
  lblDescontoValor.Caption := '0';

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add('  select a.cdpro as COD, a.quant, a.pruni ,a.vrtot, a.vrdsc ');
  qryFcertaTEMP.SQL.Add('    from fc32110 a ');
  qryFcertaTEMP.SQL.Add('    where a.cdfil=' + edtLoja.Text);
  qryFcertaTEMP.SQL.Add('      and a.nrcpm=' + edtTerminalBalcao.Text);
  qryFcertaTEMP.SQL.Add('      and a.tpitm=' + quotedstr('V'));
  qryFcertaTEMP.SQL.Add('      and a.cdpro  in (  12489, 12491 , 12492 , 16450 , 16451, 16452 , 16453 , 16454  	)  ');
  qryFcertaTEMP.SQL.Add(' order by 3 ');

  qryFcertaTEMP.Open;
  qryFcertaTEMP.FetchAll;
  qryFcertaTEMP.First;

  valdesc := 0;
  beauty := 0;
  articula := 0;
  while not qryFcertaTEMP.Eof do
  begin

    if (qryFcertaTEMP.FieldValues['cod'] = 16450) or (qryFcertaTEMP.FieldValues['cod'] = 16451) or (qryFcertaTEMP.FieldValues['cod'] = 16452) or (qryFcertaTEMP.FieldValues['cod'] = 16453) or (qryFcertaTEMP.FieldValues['cod'] = 16454) then
      qtBrinde := qtBrinde + 1
    else
    begin
      if (qryFcertaTEMP.FieldValues['cod'] = 12491) or  // codigo dos produtos beauty
        (qryFcertaTEMP.FieldValues['cod'] = 12492) then
      begin
        beauty := beauty + qryFcertaTEMP.FieldValues['quant'];
        valdesc := valdesc + qryFcertaTEMP.FieldValues['vrdsc'];
      end
      else   // 12489 cod do produto articula
      begin
        articula := articula + qryFcertaTEMP.FieldValues['quant'];
        valdesc := valdesc + qryFcertaTEMP.FieldValues['vrdsc'];
      end;

    end;

    qryFcertaTEMP.Next;
  end;

  if valdesc > 0 then
    raise Exception.Create('Venda Já possui Desconto');

  if (qtBrinde <> 1) then
    raise Exception.Create('Quantidade de brinde incorreta');  // não pode lançar sem o brinde

  percdesc_beauty := 0;
  percdesc_articula := 0;

  if (beauty = 2) then
    percdesc_beauty := 10;
  if (beauty > 2) then
    percdesc_beauty := 15;

  if (articula = 2) then
    percdesc_articula := 10;
  if (articula > 2) then
    percdesc_articula := 15;

  if (beauty + articula < 2) then
  begin
    qryFcertaTEMP.Close;
    raise exception.create('Não existem produtos suficientes nessa venda para o brinde Coqueteleira. ');
  end;

  valdesc := 0;//zera valor de desconto - monta mensagem
  lblDescontoValor.Caption := '';
  qryFcertaTEMP.First;
  while not qryFcertaTEMP.Eof do
  begin

    if (qryFcertaTEMP.FieldValues['cod'] = 16450) or (qryFcertaTEMP.FieldValues['cod'] = 16451) or (qryFcertaTEMP.FieldValues['cod'] = 16452) or (qryFcertaTEMP.FieldValues['cod'] = 16453) or (qryFcertaTEMP.FieldValues['cod'] = 16454) then
    begin
      valdesc := valdesc + (qryFcertaTEMP.FieldValues['vrtot'] * 0.9998);
      percdesc := 99.98;
            /// lblDescontoValor.Caption := lblDescontoValor.Caption + ' ' +#13+TrocaVirgPPto(floattostr(valdesc) )+' - Brinde - '+CurrTostr(percdesc)+'%' ;
    end;

    if (percdesc_beauty > 0) and ((qryFcertaTEMP.FieldValues['cod'] = 12491) or (qryFcertaTEMP.FieldValues['cod'] = 12492)) then
    begin
      valdesc := valdesc + ((qryFcertaTEMP.FieldValues['vrtot'] * percdesc_beauty) / 100);
      percdesc := percdesc_beauty;
      lblDescontoValor.Caption := lblDescontoValor.Caption + ' ' + #13 + TrocaVirgPPto(floattostr(valdesc)) + ' - BEAUTY COLLAGEN - ' + inttostr(percdesc_beauty) + '%';
    end;

    if (percdesc_articula > 0) and (qryFcertaTEMP.FieldValues['cod'] = 12489) then
    begin
      valdesc := valdesc + ((qryFcertaTEMP.FieldValues['vrtot'] * percdesc_articula) / 100);
      percdesc := percdesc_articula;
      lblDescontoValor.Caption := lblDescontoValor.Caption + ' ' + #13 + TrocaVirgPPto(floattostr(valdesc)) + '  - ARTICULA FLEX COLAGENO - ' + inttostr(percdesc_articula) + '%';
    end;

    qryFcertaTEMP.Next;

  end;

  qryFcertaTEMP.Close;

  if (lblDescontoValor.Caption <> '0') then
  begin
              // selecionando o brinde
    qrySelecionaDesconto.Close;
    qrySelecionaDesconto.sql.Clear;
    qrySelecionaDesconto.sql.Add('    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, ');
    qrySelecionaDesconto.sql.Add('           a.TPDSC, a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, a.CDPRO, ');
    qrySelecionaDesconto.sql.Add('           coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ');
    qrySelecionaDesconto.sql.Add('      from fc32110 a ');
    qrySelecionaDesconto.sql.Add(' left join fc32200 b on ( ');
    qrySelecionaDesconto.sql.Add('           a.cdfil=b.cdfil ');
    qrySelecionaDesconto.sql.Add('         and a.cdtml=b.cdtml ');
    qrySelecionaDesconto.sql.Add('         and a.dtope = b.dtope ');
    qrySelecionaDesconto.sql.Add('         and a.operid=b.operid ');
    qrySelecionaDesconto.sql.Add('         and a.nrcpm=b.nrcpm ');
    qrySelecionaDesconto.sql.Add('         and a.itemid=b.itemid ) ');
    qrySelecionaDesconto.sql.Add('       where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qrySelecionaDesconto.sql.Add('         and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qrySelecionaDesconto.sql.Add('         and a.dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qrySelecionaDesconto.sql.Add('         and a.tpitm=' + quotedstr('V'));
    qrySelecionaDesconto.sql.Add('         and a.cdpro in (  16450 , 16451, 16452, 16453, 16454	) ');
    qrySelecionaDesconto.sql.Add('    order by a.PRUNILIQ');
    qrySelecionaDesconto.Open;
    qrySelecionaDesconto.FetchAll;
    qrySelecionaDesconto.First;

    valdesc := 0;
    tpdescvar := '3';

    while not qrySelecionaDesconto.Eof do
    begin

      desc2var := 99.98;
      valorunitdesc := (qrySelecionaDesconto.FieldValues['PRUNILIQ'] * 0.9998);

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
      qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
      qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
      qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
      qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
      qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
      qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
      qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
      qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
      qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qrySelecionaDesconto.Next;
    end;
  end;

  msg := 'Deseja aplicar desconto progressivo?';

  if MessageDlg(msg, mtconfirmation, [mbYes, MbNo], 0) = mryes then
  begin

              //**********************************  BEAUTY COLLAGEN

    if percdesc_beauty > 0 then
    begin

      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.sql.Clear;
      qrySelecionaDesconto.sql.Add('    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, ');
      qrySelecionaDesconto.sql.Add('           a.TPDSC, a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, a.CDPRO, ');
      qrySelecionaDesconto.sql.Add('           coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ');
      qrySelecionaDesconto.sql.Add('      from fc32110 a ');
      qrySelecionaDesconto.sql.Add(' left join fc32200 b on ( ');
      qrySelecionaDesconto.sql.Add('           a.cdfil=b.cdfil ');
      qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
      qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
      qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
      qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ');
      qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qrySelecionaDesconto.sql.Add('       and a.dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qrySelecionaDesconto.sql.Add('       and a.tpitm=' + quotedstr('V'));
      qrySelecionaDesconto.sql.Add('       and a.cdpro in (  12491, 12492	) ');
      qrySelecionaDesconto.sql.Add('  order by a.PRUNILIQ');

      qrySelecionaDesconto.Open;
      qrySelecionaDesconto.FetchAll;
      qrySelecionaDesconto.First;

      valdesc := 0;
      tpdescvar := '3';
      while not qrySelecionaDesconto.Eof do
      begin
        desc2var := percdesc_beauty;
        valorunitdesc := ((qrySelecionaDesconto.FieldValues['PRUNILIQ'] * qrySelecionaDesconto.FieldValues['QUANT']) * (desc2var / 100));

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
        qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
        qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
        qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;

        qrySelecionaDesconto.Next;
      end;
    end;

            //************************************** ARTICULA FLEX COLAGENO **************************************************
    if percdesc_articula > 0 then
    begin
      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.sql.Clear;
      qrySelecionaDesconto.sql.Add('     select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, ');
      qrySelecionaDesconto.sql.Add('            a.PTDSC, a.TPDSC, a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, a.CDPRO, ');
      qrySelecionaDesconto.sql.Add('            coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ');
      qrySelecionaDesconto.sql.Add('       from fc32110 a ');
      qrySelecionaDesconto.sql.Add('  left join fc32200 b on ( ');
      qrySelecionaDesconto.sql.Add('          a.cdfil=b.cdfil ');
      qrySelecionaDesconto.sql.Add('      and a.cdtml=b.cdtml ');
      qrySelecionaDesconto.sql.Add('      and a.dtope = b.dtope ');
      qrySelecionaDesconto.sql.Add('      and a.operid=b.operid ');
      qrySelecionaDesconto.sql.Add('      and a.nrcpm=b.nrcpm ');
      qrySelecionaDesconto.sql.Add('      and a.itemid=b.itemid ) ');
      qrySelecionaDesconto.sql.Add('    where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qrySelecionaDesconto.sql.Add('      and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qrySelecionaDesconto.sql.Add('      and a.dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qrySelecionaDesconto.sql.Add('      and a.tpitm=' + quotedstr('V'));
      qrySelecionaDesconto.sql.Add('      and a.cdpro in ( 12489	)  ');
      qrySelecionaDesconto.sql.Add(' order by a.PRUNILIQ');
      qrySelecionaDesconto.Open;
      qrySelecionaDesconto.FetchAll;

      qrySelecionaDesconto.First;

      valdesc := 0;
      tpdescvar := '3';
      while not qrySelecionaDesconto.Eof do
      begin
        desc2var := percdesc_articula;
        valorunitdesc := ((qrySelecionaDesconto.FieldValues['PRUNILIQ'] * qrySelecionaDesconto.FieldValues['QUANT']) * (desc2var / 100));

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
        qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
        qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
        qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;
        qryInsereDesconto.Close;

        qrySelecionaDesconto.Next;
      end;
    end;
  end;

  qryInsereDesconto.Close;
  qryInsereDesconto.SQL.Clear;
  qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
  qryInsereDesconto.SQL.Add('   from fc32110 ');
  qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
  qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
  qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
  qryInsereDesconto.Open;

  valortotal := qryInsereDesconto.FieldValues['VALOR'];

  qryInsereDesconto.Close;
  qryInsereDesconto.SQL.Clear;
  qryInsereDesconto.SQL.Add(' update fc32100 ');
  qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('colagenos') + ', ');
  qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
  qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
  qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
  qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
  qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
  qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
  qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
  qryInsereDesconto.ExecSQL;
  qryInsereDesconto.Connection.CommitRetaining;

  showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
end;

procedure TfrmPrincipal.DescontoCoqueteleiraAcima500;
var
  valortotal, valordescun, vrprod, vrtotal, descBrinde: double;
  brinde, codprod: integer;
begin

  lblDescontoValor.Caption := '0';

  brinde := 0;
  vrtotal := 0;
  descBrinde := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin

    vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 14247) then
    begin

      brinde := brinde + qryTerminalBalcao.FieldValues['QUANT'];
      vrprod := qryTerminalBalcao.FieldValues['PRUNI'];
      codprod := qryTerminalBalcao.FieldValues['CDPRO'];
      descBrinde := descBrinde + qryTerminalBalcao.FieldValues['vrdsc'];

    end;

    qryTerminalBalcao.next;
  end;

  if descBrinde <> 0 then
    raise Exception.Create('Valor do Desconto da Coqueteleira já lançado. ');

  if (vrtotal < 500) then
    raise exception.create('Valor de compra abaixo de R$ 500,00. Valor insuficiente para Desconto Coqueteleira nessa venda. Valor Total:' + TrocaVirgPPto(FloatToStr((vrtotal * 1))));

  if (brinde = 0) then
    raise Exception.Create('Adicione uma coqueteleira azul de brinde.');
  if (brinde > 1) then
    raise Exception.Create('Quantidade de coqueteleira incorreta.');

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 1)));
  valordescun := (vrprod * 0.9998{100% de desconto});

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo Promoção Coqueteleira?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.98)) + ',  ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.SQL.Add('    and cdpro in (' + IntToStr(codprod) + ')');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Text := 'update fc32100 set useridaut=' + quotedstr('coqueteleira') + ', vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ',vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ' where  cdfil=' + trim(frmPrincipal.edtLoja.Text) + ' and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text) + ' and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Text := 'update totvsconf set ENV=' + quotedstr('N') + ' where  fil=' + trim(frmPrincipal.edtLoja.Text) + ' and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text);
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;
      qryInsereDesconto.Close;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.CampanhaImunoCaps;
var
  valortotal, valordescun, vrprod, vrtotal, descBrinde: double;
  brinde, codprod: integer;
begin

  lblDescontoValor.Caption := '0';

  brinde := 0;
  vrtotal := 0;
  descBrinde := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin

    vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 11785) then
    begin

      brinde := brinde + qryTerminalBalcao.FieldValues['QUANT'];
      vrprod := qryTerminalBalcao.FieldValues['PRUNI'];
      codprod := qryTerminalBalcao.FieldValues['CDPRO'];
      descBrinde := descBrinde + qryTerminalBalcao.FieldValues['vrdsc'];

    end;

    qryTerminalBalcao.next;
  end;

  if (vrtotal < 300) then
    raise exception.create('Valor de compra abaixo de R$ 300,00. Valor insuficiente para a Campanha Imuno Caps, nessa venda. Valor Total:' + TrocaVirgPPto(FloatToStr((vrtotal * 1))));

  if (brinde = 0) then
    raise Exception.Create('Adicione o Imuno Caps de brinde.');
  if (brinde > 1) then
    raise Exception.Create('Quantidade de Imuno Caps incorreta.');

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 1)));
  valordescun := (vrprod * 0.9997{100% de desconto});

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo Promoção "Campanha Imuno Caps" ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.97)) + ',  ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))),');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.SQL.Add('    and cdpro in (' + IntToStr(codprod) + ')');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('ImunoCaps') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.ComprouLevouSabDesejos;
// Sabonete Barra Desejos Dourado (cod: 15620) e Sabonete Barra Desejos Prata (cod: 15619)
// COMPRE 2 E LEVE 3. Da mesma forma, configura para a cada 2, o terceiro sai de graça.

var
  valortotal, valordescun, vrprod, vrtotal, descPromocao: double;
  qtdProd, ItensComDesconto, codprod, item: integer;
  matrizItemID: array of string;
begin
  lblDescontoValor.Caption := '0';

  qtdProd := 0;
  vrtotal := 0;
  descPromocao := 0;
  item := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 15619) or (qryTerminalBalcao.FieldValues['CDPRO'] = 15620) then
    begin
      qtdProd := qtdProd + qryTerminalBalcao.FieldValues['QUANT'];
      vrprod := qryTerminalBalcao.FieldValues['PRUNI'];
      codprod := qryTerminalBalcao.FieldValues['CDPRO'];
      descPromocao := descPromocao + qryTerminalBalcao.FieldValues['vrdsc'];
      item := item + 1;
      SetLength(matrizItemID, item);
      matrizItemID[item - 1] := qryTerminalBalcao.FieldByName('itemid').AsString;
    end;

    qryTerminalBalcao.next;
  end;

  if (item < 3) then
    raise Exception.Create('Lançar os produtos separadamente para a campanha: Compre2, Leve3 - Sab.Desejos.');
  if descPromocao <> 0 then
    raise Exception.Create('Valor do Desconto do brinde já lançado. ');

  ItensComDesconto := trunc((qtdProd) / 3);

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * ItensComDesconto)));
  valordescun := (vrprod * 0.9997{100% de desconto});

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo Promoção "Compre2, Leve3 - Sab.Desejos" ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      for item := 1 to ItensComDesconto do
      begin

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.97)) + ',  ');
        qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
        qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
        qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
        qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
        qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
        qryInsereDesconto.SQL.Add('    and ITEMID =' + matrizItemID[item - 1]);

        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('SabDesejos') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.ComprouLevouHidLavanda;
// Hidratante Lavanda (cod 15618) – COMPRE 1 E LEVE 2.
// Configura também para se comprar 2, levar 4 e por aí vai...
var
  valortotal, valordescun, vrprod, vrtotal, descPromocao: double;
  qtdProd, ItensComDesconto, codprod, item: integer;
  matrizItemID: array of string;
begin
  lblDescontoValor.Caption := '0';

  qtdProd := 0;
  vrtotal := 0;
  descPromocao := 0;

  qryTerminalBalcao.First;
  item := 0;
  while not qryTerminalBalcao.EOF do
  begin

    vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 15618) then   // hidratante
    begin
      qtdProd := qtdProd + qryTerminalBalcao.FieldValues['QUANT'];
      vrprod := qryTerminalBalcao.FieldValues['PRUNI'];
      codprod := qryTerminalBalcao.FieldValues['CDPRO'];
      descPromocao := descPromocao + qryTerminalBalcao.FieldValues['vrdsc'];
      item := item + 1;
      SetLength(matrizItemID, item);
      matrizItemID[item - 1] := qryTerminalBalcao.FieldByName('itemid').AsString;
    end;

    qryTerminalBalcao.next;
  end;

  if (item < 2) then
    raise Exception.Create('Lançar os produtos separadamente para a campanha: Compre1, Leve2 - Hid.Lavanda.');

  if descPromocao <> 0 then
    raise Exception.Create('Valor do Desconto do brinde já lançado. ');

  ItensComDesconto := trunc((qtdProd) / 2);

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * ItensComDesconto)));
  valordescun := (vrprod * 0.9997{100% de desconto});

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo Promoção "Hidratante Lavanda" ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      for item := 1 to ItensComDesconto do
      begin
        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.97)) + ',  ');
        qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
        qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
        qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
        qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))),');
        qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
        qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
        qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
        qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
        qryInsereDesconto.SQL.Add('    and ITEMID =' + matrizItemID[item - 1]);
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('Hidratante') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.DescontoGlitterAcima200;
var
  valortotal, valordescun, vrprod, vrtotal: double;
  p, p1, codprod: integer;
begin

  lblDescontoValor.Caption := '0';
  p := 0;
  p1 := 0;
  vrtotal := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if qryTerminalBalcao.FieldValues['tpitm'] = 'V' then
    begin
      if (qryTerminalBalcao.FieldValues['CDPRO'] = 19262) then
        p1 := p1 + qryTerminalBalcao.FieldValues['QUANT']
      else
      begin
        p := p + qryTerminalBalcao.FieldValues['QUANT'];
        vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];
      end;
    end;
    qryTerminalBalcao.next;
  end;

  if (vrtotal < 200) then
    raise exception.create('Valor de compra abaixo de R$ 200,00. Valor insuficiente para o Brinde Glitter nessa venda. Valor Total:' + TrocaVirgPPto(FloatToStr((vrtotal * 1))));

  if (p1 <> 1) then
    raise Exception.Create('Quantidade Glitter incorreta');

  vrprod := 29.9;
  codprod := 19262;

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 1)));

  valordescun := (vrprod * 0.9968 { quase 100% de desconto => 0,10 });

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo ao brinde Glitter?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.68)) + ', ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))),');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.SQL.Add('    and cdpro in (' + IntToStr(codprod) + ')');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('glitter2025') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.DiaDasMaesAcima250;
var
  valortotal, valordescun, vrprod, vrtotal: double;
  qtdBrinde, codprod: integer;
begin

  lblDescontoValor.Caption := '0';

  qtdBrinde := 0;
  vrtotal := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin

    if qryTerminalBalcao.FieldValues['tpitm'] = 'V' then
    begin

      if (qryTerminalBalcao.FieldValues['CDPRO'] = 19455) or (qryTerminalBalcao.FieldValues['CDPRO'] = 19456) or (qryTerminalBalcao.FieldValues['CDPRO'] = 19457) or (qryTerminalBalcao.FieldValues['CDPRO'] = 19458) then
      begin
        qtdBrinde := qtdBrinde + qryTerminalBalcao.FieldValues['QUANT'];
        vrprod := qryTerminalBalcao.FieldValues['PRUNI'];
        codprod := qryTerminalBalcao.FieldValues['CDPRO'];
      end
      else
        vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT']
    end;
    qryTerminalBalcao.next;
  end;

  if (vrtotal < 250) then
    raise exception.create('Valor de compra abaixo de R$ 250,00. Valor insuficiente para o brinde: Mini Bag, nessa venda. Valor Total:' + TrocaVirgPPto(FloatToStr((vrtotal * 1))));

  if (qtdBrinde <> 1) then
    raise Exception.Create('Quantidade de Mini Bag incorreta.');

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 1)));

  valordescun := (vrprod * 0.9980{100% de desconto});

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo ao brinde da Promoção campanha do Dia das Mães?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.80)) + ', ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.SQL.Add('    and cdpro in (' + IntToStr(codprod) + ')');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('DiaDasMaes2025') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.VendasPet;
{ na compra acima de 200,00 reais ganha o KitHigiene - acima de 300,00 ganha o GarBebedouro }
var
  valortotal, valordescun, vrprod, vrprod_200, vrprod_300, vrtotal: double;
  qtdBrinde_200, qtdBrinde_300, codprod, codprod_200, codprod_300: integer;
  campanha: string;
begin
  lblDescontoValor.Caption := '0';

  qtdBrinde_200 := 0;
  qtdBrinde_300 := 0;
  vrprod := 0;
  vrtotal := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = 18513) then // brinde
    begin
      qtdBrinde_200 := qtdBrinde_200 + qryTerminalBalcao.FieldValues['QUANT'];
      vrprod_200 := qryTerminalBalcao.FieldValues['PRUNI'];
      codprod_200 := qryTerminalBalcao.FieldValues['CDPRO'];
    end
    else if (qryTerminalBalcao.FieldValues['CDPRO'] = 18512) then  // brinde
    begin
      qtdBrinde_300 := qtdBrinde_300 + qryTerminalBalcao.FieldValues['QUANT'];
      vrprod_300 := qryTerminalBalcao.FieldValues['PRUNI'];
      codprod_300 := qryTerminalBalcao.FieldValues['CDPRO'];
    end
    else
      vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRTOT'];

    qryTerminalBalcao.next;
  end;

  if (vrtotal < 200) then
    raise exception.create('Valor de compra abaixo de R$ 200,00. Valor insuficiente para o brinde da Campanha Pet, nessa venda. Valor Total:' + TrocaVirgPPto(FloatToStr((vrtotal * 1))));

  if (qtdBrinde_200 <> 0) and (qtdBrinde_300 <> 0) then
    raise Exception.Create('Escolha um dos brindes para esta venda.');

  if (vrtotal >= 200) and (vrtotal < 299) then
  begin
    if qtdBrinde_200 <> 1 then
      raise Exception.Create('Quant.Brinde: KIT DE HIGIENE, incorreta. ');
    codprod := codprod_200;
    vrprod := vrprod_200;
    campanha := 'KitHigiene';
  end
  else
  begin
    if qtdBrinde_300 <> 1 then
      raise Exception.Create('Quant.Brinde: GARRAFA BEBEDOURO, incorreta. ');
    codprod := codprod_300;
    vrprod := vrprod_300;
    campanha := 'GarBebedouro';
  end;

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 1)));

  valordescun := (vrprod * 0.9964 { é para deixar proximo 100% de desconto});

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo ao brinde da Promoção Campanha Pet?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.64)) + ',  ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')), ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.SQL.Add('    and cdpro in (' + IntToStr(codprod) + ')');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr(campanha) + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;


procedure TfrmPrincipal.VarejoAcima300;
var
  valortotal, valordescun, vrprod, vrtotal: double;
  qtdBrinde, codprod: integer;
begin
  if (trim(frmPrincipal.edtLoja.Text) = '23') or (trim(frmPrincipal.edtLoja.Text) = '159') or (trim(frmPrincipal.edtLoja.Text) = '137') then
    Exception.Create('Campanha disponível apenas para as lojas físicas Gradar (todas as lojas, exceto 23, 159 e 137). ');

  lblDescontoValor.Caption := '0';

  qtdBrinde := 0;
  vrtotal := 0;

  if (StrToDate(FormatDateTime('dd/mm/yyyy', now)) < strtodate('01/08/2024')) or (StrToDate(FormatDateTime('dd/mm/yyyy', now)) > strtodate('08/09/2024')) then
    Exception.Create('campanha disponível até o dia 08/09/2024 ');

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin

    if qryTerminalBalcao.FieldValues['tpitm'] = 'V' then
    begin
      if qryTerminalBalcao.FieldValues['CDPRO'] <> 16941 then
        vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRLIQ']
      else
      begin
        vrprod := qryTerminalBalcao.FieldValues['pruni'];
        codprod := 16941;
        qtdBrinde := qtdBrinde + qryTerminalBalcao.FieldValues['QUANT'];
      end;
    end;

    qryTerminalBalcao.next;
  end;

  if (vrtotal < 300) then
    raise exception.create('Valor de compra abaixo de R$ 300,00. Valor insuficiente para o brinde: batom Hidra Lipstick Nude, nessa venda. Valor Total:' + TrocaVirgPPto(FloatToStr((vrtotal * 1))));

  if (qtdBrinde <> 1) then
    raise Exception.Create('Quantidade de brinde incorreta.');

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 1)));
  valordescun := (vrprod * 0.9998{100% de desconto});

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo ao brinde da Promoção: Varejo acima de R$300,00?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.98)) + ', ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')), ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.SQL.Add('    and cdpro in (' + IntToStr(codprod) + ')');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('VarejoAcima300') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.CampanhaHigienizacao;
var
  valortotal, valordescun, vrprod, vrtotal: double;
  qtdBrinde, codprod, qtdProdutos, resto, qtdPromocao: integer;
begin
  lblDescontoValor.Caption := '0';

  qtdBrinde := 0;
  vrtotal := 0;
  qtdProdutos := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if qryTerminalBalcao.FieldValues['tpitm'] = 'V' then
    begin

      if (qryTerminalBalcao.FieldValues['CDPRO'] = 10641) then
      begin
        vrprod := qryTerminalBalcao.FieldValues['pruni'];  // valor do brinde
        codprod := qryTerminalBalcao.FieldValues['CDPRO'];
        qtdBrinde := qtdBrinde + qryTerminalBalcao.FieldValues['QUANT'];
      end
      else
      begin
        if (qryTerminalBalcao.FieldValues['CDPRO'] = 15825) or
           (qryTerminalBalcao.FieldValues['CDPRO'] = 15708) or
           (qryTerminalBalcao.FieldValues['CDPRO'] = 17260) or
           (qryTerminalBalcao.FieldValues['CDPRO'] = 15709) or
           (qryTerminalBalcao.FieldValues['CDPRO'] = 15826) or
           (qryTerminalBalcao.FieldValues['CDPRO'] = 15831) or
           (qryTerminalBalcao.FieldValues['CDPRO'] = 15827) then
          qtdProdutos := qtdProdutos + qryTerminalBalcao.FieldValues['QUANT'];
      end;
    end;
    qryTerminalBalcao.next;
  end;

  resto := (qtdProdutos mod 2);
  if resto = 0 then
    qtdPromocao := qtdProdutos div 2
  else
    qtdPromocao := (qtdProdutos - resto) div 2;

  if (qtdProdutos < 2) then
    raise exception.create('Quantidade: ' + intToStr(qtdProdutos) + ' de produtos insuficientes para Campanha Higienização , nessa venda. ');

  if (qtdBrinde <> qtdPromocao) then
    raise Exception.Create('Quantidade do Brinde kit Viagem da Campanha Higienização, incorreta.');

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 1)));
  valordescun := (vrprod * 0.9973{ 100% de desconto });

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo ao brinde Kit Viagem?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.73)) + ',  ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')), ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.SQL.Add('    and cdpro in (  10641   )');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('kitViagem') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

function TfrmPrincipal.QtdProdutosCampanhaStickFacial: integer;
var
  qtdprodutos: integer;
begin
    // brinde da campanha stick
  qtdprodutos := 0;
  qryTerminalBalcao.First;
  while not qryTerminalBalcao.eof do
  begin
    if qryTerminalBalcao.FieldValues['tpitm'] = 'V' then
    begin
      if qryTerminalBalcao.FieldValues['CDPRO'] = 16441 then
        qtdprodutos := qtdprodutos + qryTerminalBalcao.FieldValues['QUANT'];
    end;
    qryTerminalBalcao.Next;
  end;
  result := qtdprodutos;
end;

procedure TfrmPrincipal.CampanhaStickFacial;
var
  valortotal, valordescun, vrprod, vrtotal: double;
  qtdBrinde, codprod, qtdProdutos: integer;
begin
  lblDescontoValor.Caption := '0';

  qtdBrinde := 0;
  vrtotal := 0;
  qtdProdutos := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if qryTerminalBalcao.FieldValues['tpitm'] = 'V' then
    begin
      if qryTerminalBalcao.FieldValues['CDPRO'] = 16441 then
      begin
        vrprod := qryTerminalBalcao.FieldValues['pruni'];
        codprod := 16441;
        qtdBrinde := qtdBrinde + qryTerminalBalcao.FieldValues['QUANT'];
      end
      else
      begin
        if (qryTerminalBalcao.FieldValues['CDPRO'] = 18343) or (qryTerminalBalcao.FieldValues['CDPRO'] = 18344) or (qryTerminalBalcao.FieldValues['CDPRO'] = 18345) or (qryTerminalBalcao.FieldValues['CDPRO'] = 18339) or (qryTerminalBalcao.FieldValues['CDPRO'] = 17517) then
          qtdProdutos := qtdProdutos + qryTerminalBalcao.FieldValues['QUANT'];
      end;
    end;
    qryTerminalBalcao.next;
  end;

  if (qtdProdutos < 2) then
    raise exception.create('Quantidade: ' + intToStr(qtdProdutos) + ' de produtos insuficientes para Campanha linha Stick Facial, nessa venda. ');

  if (qtdBrinde <> 1) then
    raise Exception.Create('Quantidade de brinde Porta Joias (cod 16441) incorreta.');

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 1)));
  valordescun := (vrprod * 0.9998{100% de desconto});

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo ao brinde um Porta Joias (cod 16441) ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.98)) + ',  ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.SQL.Add('    and cdpro in (' + IntToStr(codprod) + ')');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('StickFacial') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.CampanhaColagenos2025;
var
  valortotal, valordescun, vrprod, vrtotal: double;
  qtdBrinde, codprod, qtdProdutos, resto, qtdPromocao: integer;
begin
  lblDescontoValor.Caption := '0';

  qtdBrinde := 0;
  vrtotal := 0;
  qtdProdutos := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if qryTerminalBalcao.FieldValues['tpitm'] = 'V' then
    begin
      if (qryTerminalBalcao.FieldValues['CDPRO'] = 16450) or (qryTerminalBalcao.FieldValues['CDPRO'] = 16451) or (qryTerminalBalcao.FieldValues['CDPRO'] = 16452) or (qryTerminalBalcao.FieldValues['CDPRO'] = 16453) or (qryTerminalBalcao.FieldValues['CDPRO'] = 16454) then
      begin
        vrprod := qryTerminalBalcao.FieldValues['pruni'];  // valor do brinde
        codprod := qryTerminalBalcao.FieldValues['CDPRO'];
        qtdBrinde := qtdBrinde + qryTerminalBalcao.FieldValues['QUANT'];
      end
      else
      begin
        if (qryTerminalBalcao.FieldValues['CDPRO'] = 12491) or (qryTerminalBalcao.FieldValues['CDPRO'] = 12492) or (qryTerminalBalcao.FieldValues['CDPRO'] = 16747) or (qryTerminalBalcao.FieldValues['CDPRO'] = 17352) or (qryTerminalBalcao.FieldValues['CDPRO'] = 12489) then
          qtdProdutos := qtdProdutos + qryTerminalBalcao.FieldValues['QUANT'];
      end;
    end;
    qryTerminalBalcao.next;
  end;

  resto := (qtdProdutos mod 2);
  if resto = 0 then
    qtdPromocao := qtdProdutos div 2
  else
    qtdPromocao := (qtdProdutos - resto) div 2;

  if (qtdProdutos < 2) then
    raise exception.create('Quantidade: ' + intToStr(qtdProdutos) + ' de produtos insuficientes para Campanha Colágeno 2025, nessa venda. ');

  if (qtdBrinde <> qtdPromocao) then
    raise Exception.Create('Quantidade de Brinde Campanha Colágeno 2025, incorreta.');

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 1)));
  valordescun := (vrprod * 0.9964{ 100% de desconto });

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo ao brinde Coqueteleira Duo Pack ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.64)) + ',  ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.SQL.Add('    and cdpro in (  16450, 16451, 16452,16453, 16454    )');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Text := 'select sum(vrliq) as VALOR from fc32110 where cdfil=' + trim(frmPrincipal.edtLoja.Text) + ' and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text) + ' and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('CoqueteleiraDuoPack') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.CampanhaBoosters;
var
  valortotal, valordescun, vrprod, vrtotal: double;
  qtdBrinde, codprod, qtdProdutos, resto, qtdPromocao: integer;
begin
  lblDescontoValor.Caption := '0';

  qtdBrinde := 0;
  vrtotal := 0;
  qtdProdutos := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if qryTerminalBalcao.FieldValues['tpitm'] = 'V' then
    begin
      if (qryTerminalBalcao.FieldValues['CDPRO'] = 19293) then
      begin
        vrprod := qryTerminalBalcao.FieldValues['pruni'];  // valor do brinde
        codprod := qryTerminalBalcao.FieldValues['CDPRO'];
        qtdBrinde := qtdBrinde + qryTerminalBalcao.FieldValues['QUANT'];
      end
      else
      begin
        if (qryTerminalBalcao.FieldValues['CDPRO'] = 19251) or (qryTerminalBalcao.FieldValues['CDPRO'] = 19253) or (qryTerminalBalcao.FieldValues['CDPRO'] = 16730) then
          qtdProdutos := qtdProdutos + qryTerminalBalcao.FieldValues['QUANT'];
      end;
    end;
    qryTerminalBalcao.next;
  end;

  resto := (qtdProdutos mod 2);
  if resto = 0 then
    qtdPromocao := qtdProdutos div 2
  else
    qtdPromocao := (qtdProdutos - resto) div 2;

  if (qtdProdutos < 2) then
    raise exception.create('Quantidade: ' + intToStr(qtdProdutos) + ' de produtos insuficientes para Campanha Boosters, nessa venda. ');

  if (qtdBrinde <> qtdPromocao) then
    raise Exception.Create('Quantidade de Brinde Skin Roller, incorreta.');

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 1)));
  valordescun := (vrprod * 0.9975{  100% de desconto });

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo ao brinde Skin Roller ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.75)) + ',  ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.SQL.Add('    and cdpro = 19293 ');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('SkinRoller') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.CampanhaBrindes;
{ Na compra do Young Booster (cod 11403), o cliente leva de brinde 1 pote com 5 gomas do Beauty Collagen (cod 19127).
 Na compra do Power Training (cod 17823 ou 15447), o cliente recebe 1 potinho com 4 unidades da Creatina Caramelo (cod 19396).}
var
  valortotal, valordescun, vrBrinde1, vrBrinde2: double;
  qtdBrinde1, qtdBrinde2, qtdProduto1, qtdProduto2, qtdPromocao1, qtdPromocao2: integer;
begin
  lblDescontoValor.Caption := '0';

  qtdBrinde1 := 0;
  qtdProduto1 := 0;

  qtdBrinde2 := 0;
  qtdProduto2 := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if qryTerminalBalcao.FieldValues['tpitm'] = 'V' then
    begin
      case qryTerminalBalcao.FieldValues['CDPRO'] of
        11403:
          qtdProduto1 := qtdProduto1 + qryTerminalBalcao.FieldValues['QUANT']; // produto - Young Booster (cod 11403)
        19127:
          begin
            vrBrinde1 := qryTerminalBalcao.FieldValues['pruni'];   //  brinde - 1 pote com 5 gomas do Beauty Collagen (cod 19127)
            qtdBrinde1 := qtdBrinde1 + qryTerminalBalcao.FieldValues['QUANT'];
          end;
        17823:
          qtdProduto2 := qtdProduto2 + qryTerminalBalcao.FieldValues['QUANT']; // produto - Power Training (cod 17823 ou 15447)
        15447:
          qtdProduto2 := qtdProduto2 + qryTerminalBalcao.FieldValues['QUANT']; // produto - Power Training (cod 17823 ou 15447)
        19396:
          begin
            vrBrinde2 := qryTerminalBalcao.FieldValues['pruni'];  // brinde - 1 potinho com 4 unidades da Creatina Caramelo (cod 19396)
            qtdBrinde2 := qtdBrinde2 + qryTerminalBalcao.FieldValues['QUANT'];
          end;
      else
         // codigo não faz parte da campanha
      end;
    end;
    qryTerminalBalcao.next;
  end;

  if (qtdProduto1 <> qtdBrinde1) then
    raise exception.create('Quantidade: ' + intToStr(qtdProduto1) + ' de Young Booster (cod 11403) insuficientes para o brinde - ' + IntToStr(qtdBrinde1) + ' pote(s) com 5 gomas do Beauty Collagen (cod 19127) , nessa venda. ');

  if (qtdProduto2 <> qtdBrinde2) then
    raise exception.create('Quantidade: ' + intToStr(qtdProduto2) + ' de Power Training (cod 17823 e 15447) insuficientes para o brinde - ' + IntToStr(qtdBrinde2) + ' potinho(s) com 4 unidades da Creatina Caramelo (cod 19396) , nessa venda. ');

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr(((vrBrinde1 * qtdBrinde1) + (vrBrinde2 * qtdBrinde2))));

  if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo ao brinde da Campanha Goma e Caramelo ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
  begin
    if vrBrinde1 > 0 then
    begin
      valordescun := (vrBrinde1 * 0.9952381 { quase 100% de desconto, tem que deixar 10 centavos  });
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.52381)) + ',  ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.SQL.Add('    and cdpro = 19127   ');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;
    end;

    if vrBrinde2 > 0 then
    begin
      valordescun := (vrBrinde2 * 0.9900 { quase 100% de desconto, tem que deixar 10 centavos  });
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.00)) + ',  ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')), ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V') + ' and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.SQL.Add('    and cdpro = 19396   ');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;
    end;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
    qryInsereDesconto.SQL.Add('   from fc32110 ');
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
    qryInsereDesconto.Open;

    valortotal := qryInsereDesconto.FieldValues['VALOR'];

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update fc32100 ');
    qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('Goma&Caramelo') + ', ');
    qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
    qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
    qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
    qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.Commit;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update totvsconf ');
    qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
    qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.Commit;

    showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
  end;
end;

procedure TfrmPrincipal.CampanhaBrindesPorValor;
{ Nas compras acima de R$ 500 em fórmulas : Coqueteleira (cod. 16450 – rosa e cod. 16453 – preta)
  	Nas compras acima de R$ 1.000 em fórmulas:  Porta-joias (cod. 16441)

    obs. desativada pelo setor de marketing  em 12/09/2025 , entrou a CampanhaBrindesCompras;}
var
  valortotal, valordescun, vrDescBrinde, vrPrUniBrinde, PercDescBrinde: double;
  qtdBrinde, qtdBrinde1, qtdBrinde2, qtdBrinde3: integer;
  CodBrinde: string;
begin

  lblDescontoValor.Caption := '0';
  CodBrinde := '';

  qtdBrinde := 0;
  vrDescBrinde := 0;
  vrPrUniBrinde := 0;

  qtdBrinde1 := 0;
  qtdBrinde2 := 0;
  qtdBrinde3 := 0;

  valortotal := 0;

  qryTerminalBalcao.First;

  while not qryTerminalBalcao.EOF do
  begin
    if qryTerminalBalcao.FieldValues['tpitm'] = 'R' then
    begin
                 // os valores dos brindes não totaliza ao valor da compra
      valortotal := valortotal + qryTerminalBalcao.FieldValues['VRLIQ'];
    end;

    case qryTerminalBalcao.FieldValues['CDPRO'] of
      16450:
        begin
          vrPrUniBrinde := qryTerminalBalcao.FieldValues['pruni'];   // R$ 500 em fórmulas - Coqueteleira (cod. 16450 – rosa )
          qtdBrinde1 := qtdBrinde1 + qryTerminalBalcao.FieldValues['QUANT'];
          CodBrinde := '16450';
          PercDescBrinde := 0.9964;
        end;
      16453:
        begin
          vrPrUniBrinde := qryTerminalBalcao.FieldValues['pruni'];   // R$ 500 em fórmulas - Coqueteleira (cod. 16453 – preta)
          qtdBrinde2 := qtdBrinde2 + qryTerminalBalcao.FieldValues['QUANT'];
          CodBrinde := '16453';
          PercDescBrinde := 0.9964;
        end;
      16441:
        begin
          vrPrUniBrinde := qryTerminalBalcao.FieldValues['pruni'];  // R$ 1.000 em fórmulas - Porta-joias (cod. 16441)
          qtdBrinde3 := qtdBrinde3 + qryTerminalBalcao.FieldValues['QUANT'];
          CodBrinde := '16441';
          PercDescBrinde := 0.9974;
        end;
    end;

    next;
  end;

  if valortotal < 500.00 then
    raise Exception.Create('Campanha Brindes Fórmulas é somente para compras de Fórmulas igual ou acima de R$ 500,00 ');

  if (valortotal >= 500.00) and (valortotal < 1000.00) then
  begin
    if (qtdBrinde1 + qtdBrinde2) <> 1 then
      raise Exception.Create('Brinde Incorreto!');

    if qtdBrinde3 > 0 then
      raise Exception.Create('O brinde Porta-joias é somente para a compra(fórmulas) igual ou acima de R$ 1.000,00 ');

  end;

  if (valortotal >= 1000.00) then
  begin
    if (qtdBrinde1 + qtdBrinde2 + qtdBrinde3) <> 1 then
      raise Exception.Create('Brinde Incorreto! para a compra(fórmulas) igual ou acima de R$ 1.000,00  ');
  end;

   { quase 100% de desconto, tem que deixar 10 centavos  }
  vrDescBrinde := vrPrUniBrinde * PercDescBrinde;

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr(vrPrUniBrinde));

  if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo ao brinde da Campanha Brindes Fórmulas ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
  begin
    valordescun := vrDescBrinde;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update fc32110 ');
    qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(PercDescBrinde)) + ',  ');
    qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
    qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
    qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
    qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
    qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
    qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
    qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
    qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
    qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
    qryInsereDesconto.SQL.Add('    and cdpro = ' + CodBrinde);
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.Commit;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
    qryInsereDesconto.SQL.Add('   from fc32110 ');
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
    qryInsereDesconto.Open;

    valortotal := qryInsereDesconto.FieldValues['VALOR'];

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update fc32100 ');
    qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('BrindesPorValor') + ', ');
    qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
    qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
    qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
    qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.Commit;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update totvsconf ');
    qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
    qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.Commit;

    showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
  end;
end;

procedure TfrmPrincipal.CampanhaBrindesCompras;
{ Nas compras acima de R$ 800 em fórmulas e Varejo, brindes : Coqueteleira (cod. 16450 – rosa e cod. 16453 – preta)
  	ou  Porta-joias (cod. 16441)}
var
  valortotal, valordescun, vrDescBrinde, vrPrUniBrinde, PercDescBrinde, ValorCampanha: double;
  qtdBrinde, qtdBrinde1, qtdBrinde2, qtdBrinde3: integer;
  CodBrinde: string;
begin
  lblDescontoValor.Caption := '0';
  CodBrinde := '';

  qtdBrinde := 0;
  vrDescBrinde := 0;
  vrPrUniBrinde := 0;

  qtdBrinde1 := 0;
  qtdBrinde2 := 0;
  qtdBrinde3 := 0;

  valortotal := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin

    case qryTerminalBalcao.FieldValues['CDPRO'] of
      16450:
        begin
          vrPrUniBrinde := qryTerminalBalcao.FieldValues['pruni'];  // Coqueteleira (cod. 16450 – rosa )
          qtdBrinde1 := qtdBrinde1 + qryTerminalBalcao.FieldValues['QUANT'];
          CodBrinde := '16450';
          PercDescBrinde := 0.9964;
        end;
      16453:
        begin
          vrPrUniBrinde := qryTerminalBalcao.FieldValues['pruni'];  // Coqueteleira (cod. 16453 – preta)
          qtdBrinde2 := qtdBrinde2 + qryTerminalBalcao.FieldValues['QUANT'];
          CodBrinde := '16453';
          PercDescBrinde := 0.9964;
        end;
      16441:
        begin
          vrPrUniBrinde := qryTerminalBalcao.FieldValues['pruni'];  // Porta-joias (cod. 16441)
          qtdBrinde3 := qtdBrinde3 + qryTerminalBalcao.FieldValues['QUANT'];
          CodBrinde := '16441';
          PercDescBrinde := 0.9974;
        end;
    else
        // os valores dos brindes não totaliza ao valor da compra
      valortotal := valortotal + qryTerminalBalcao.FieldValues['VRLIQ'];
    end;
    qryTerminalBalcao.next;
  end;

  ValorCampanha := 800.00;

  if (trim(frmPrincipal.edtLoja.Text) = '159') or (trim(frmPrincipal.edtLoja.Text) = '151') then
    ValorCampanha := 500.00;

  if valortotal < ValorCampanha then
    raise Exception.Create('Campanha Brindes Compras é somente para Venda com valor igual ou acima de R$ ' + FloatToStr(ValorCampanha) + ' ');

  if (qtdBrinde1 + qtdBrinde2 + qtdBrinde3) <> 1 then
    raise Exception.Create('Brinde Incorreto! para a venda com valor igual ou acima de R$ ' + FloatToStr(ValorCampanha) + '  ');


   { quase 100% de desconto, tem que deixar 10 centavos  }
  vrDescBrinde := vrPrUniBrinde * PercDescBrinde;

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr(vrPrUniBrinde));

  if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo ao brinde da Campanha Brindes >= R$ ' + FloatToStr(ValorCampanha) + ' ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
  begin
    valordescun := vrDescBrinde;
    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update fc32110 ');
    qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(PercDescBrinde)) + ',  ');
    qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
    qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
    qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
    qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')), ');
    qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
    qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
    qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
    qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
    qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
    qryInsereDesconto.SQL.Add('    and cdpro = ' + CodBrinde);
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.Commit;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
    qryInsereDesconto.SQL.Add('   from fc32110 ');
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
    qryInsereDesconto.Open;

    valortotal := qryInsereDesconto.FieldValues['VALOR'];

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update fc32100 ');
    qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('BrindeCompra800') + ', ');
    qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
    qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
    qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
    qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.Commit;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update totvsconf ');
    qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
    qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.Commit;

    showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
  end;
end;

procedure TfrmPrincipal.CampanhaCabelos2025;
{ campanhas Cabelos2025 : na compra de dois produtos da campanha ganha um brinde necessaire , 4 produtos 2 brindes e assim progressivamente  }
var
  valortotal, valordescun, vrprod, vrtotal: double;
  qtdBrinde, qtdProdutos, resto, qtdPromocao: integer;
begin
  vrprod := 0;
  lblDescontoValor.Caption := '0';

  qtdBrinde := 0;
  vrtotal := 0;
  qtdProdutos := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin

    if qryTerminalBalcao.FieldValues['tpitm'] = 'V' then
    begin
      if (qryTerminalBalcao.FieldValues['CDPRO'] = 19610) or
         (qryTerminalBalcao.FieldValues['CDPRO'] = 19611) or
         (qryTerminalBalcao.FieldValues['CDPRO'] = 19612) or
         (qryTerminalBalcao.FieldValues['CDPRO'] = 19613) or
         (qryTerminalBalcao.FieldValues['CDPRO'] = 19614) then
      begin
        vrprod := qryTerminalBalcao.FieldValues['pruni'];  // valor do brinde Necessaire
        qtdBrinde := qtdBrinde + qryTerminalBalcao.FieldValues['QUANT'];
      end
      else
      begin
        if (qryTerminalBalcao.FieldValues['CDPRO'] = 14292) or
           (qryTerminalBalcao.FieldValues['CDPRO'] = 10603) or
           (qryTerminalBalcao.FieldValues['CDPRO'] = 10604) or
           (qryTerminalBalcao.FieldValues['CDPRO'] = 10606) then
          qtdProdutos := qtdProdutos + qryTerminalBalcao.FieldValues['QUANT'];
      end;
    end;
    qryTerminalBalcao.next;
  end;

  resto := (qtdProdutos mod 2);
  if resto = 0 then
    qtdPromocao := qtdProdutos div 2
  else
    qtdPromocao := (qtdProdutos - resto) div 2;

  if (qtdProdutos < 2) then
    raise exception.create('Quantidade: ' + intToStr(qtdProdutos) + ' de produtos insuficientes para a Campanha Cabelos, nessa venda. ');

  if (qtdBrinde <> qtdPromocao) then
    raise Exception.Create('Quantidade de Brinde Necessaire, incorreta.');

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * qtdBrinde)));
  valordescun := (vrprod * 0.9975{ quase 100% de desconto, tem que deixar 10 centavos  });

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo ao brinde Necessaire ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.75)) + ',  ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.SQL.Add('    and cdpro in ( 19610 , 19611, 19612, 19613, 19614 ) ');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('Cabelos2025') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.SemanaDoCliente;
{ Regra: Nas compras acima de 250 reais de varejo o
 cliente ganha uma necessaire (códigos: 17633, 17634, 17635, 17636).
 Cumulativo com outras campanhas. Contanto que o valor final ultrapasse 250 reais.
 Válido a partir de 09/09. }
var
  valortotal, valordescun, vrprod, vrtotal: double;
  qtdBrinde, codprod: integer;
begin
  lblDescontoValor.Caption := '0';

  qtdBrinde := 0;
  vrtotal := 0;

  if (StrToDate(FormatDateTime('dd/mm/yyyy', now)) < strtodate('09/09/2024')) then
    raise Exception.Create('campanha disponível a partir do dia 09/09/2024 ');

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if qryTerminalBalcao.FieldValues['tpitm'] = 'V' then
    begin
      if (qryTerminalBalcao.FieldValues['CDPRO'] = 17633) or
         (qryTerminalBalcao.FieldValues['CDPRO'] = 17634) or
         (qryTerminalBalcao.FieldValues['CDPRO'] = 17635) or
         (qryTerminalBalcao.FieldValues['CDPRO'] = 17636) then
      begin
        vrprod := qryTerminalBalcao.FieldValues['pruni'];
        codprod := qryTerminalBalcao.FieldValues['CDPRO'];
        qtdBrinde := qtdBrinde + qryTerminalBalcao.FieldValues['QUANT'];
      end
      else
      begin
        vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRLIQ'];
      end;
    end;
    qryTerminalBalcao.next;
  end;

  if (vrtotal <= 250) then
    raise exception.create('Valor da compra R$' + TrocaVirgPPto(FloatToStr((vrtotal * 1))) + ' abaixo ou igual a R$ 250,00. Valor insuficiente para o brinde: necessaire (códigos: 17633, 17634, 17635, 17636)');
  if (qtdBrinde <> 1) then
    raise Exception.Create('Quantidade de brinde incorreta.');

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 1)));
  valordescun := (vrprod * 0.9998{100% de desconto});

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo ao brinde da Promoção Semana do Cliente?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.98)) + ',  ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.SQL.Add('    and cdpro in (' + IntToStr(codprod) + ')');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('SemanaCliente') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.DiaDasCriancas;
{ Regra: Nas compras acima de 250 reais
 cliente ganha uma Pharma Goods
 Cumulativo com outras campanhas. Contanto que o valor final ultrapasse 250 reais.}
var
  valortotal, valordescun, vrprod, vrtotal: double;
  qtdBrinde, codprod: integer;
begin

  lblDescontoValor.Caption := '0';

  qtdBrinde := 0;
  vrtotal := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = 20327) then
    begin
      vrprod := qryTerminalBalcao.FieldValues['pruni'];
      codprod := qryTerminalBalcao.FieldValues['CDPRO'];
      qtdBrinde := qtdBrinde + qryTerminalBalcao.FieldValues['QUANT'];
    end
    else
    begin
      vrtotal := vrtotal + qryTerminalBalcao.FieldValues['VRLIQ'];
    end;
    qryTerminalBalcao.next;
  end;

  if (vrtotal <= 250) then
    raise exception.create('Valor da compra R$' + TrocaVirgPPto(FloatToStr((vrtotal * 1))) + ' abaixo ou igual a R$ 250,00. Valor insuficiente para o brinde: Pharma Goods ');

  if (qtdBrinde <> 1) then
    raise Exception.Create('Quantidade de brinde incorreta.');

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 1)));
  valordescun := (vrprod * 0.9966 { quase 100% de desconto , deixar 0,10 centavos });

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo ao brinde dias das Crianças?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.66)) + ',  ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')), ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.SQL.Add('    and cdpro in (' + IntToStr(codprod) + ')');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('DiaDasCriancas') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.DescontoDiaDasCriancas;
var
  valortotal, valordescun, vrprod, vrprod2: double;
  p1, p2: integer;
begin
  lblDescontoValor.Caption := '0';
  p1 := 0;
  p2 := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['vrdsc'] > 0) then
      raise Exception.Create('Venda Já possui Desconto');

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 13850) then
    begin
      p1 := qryTerminalBalcao.FieldValues['QUANT'];
      vrprod2 := vrprod2 + qryTerminalBalcao.FieldValues['PRUNI'];
    end;

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 13851) then
    begin
      p2 := qryTerminalBalcao.FieldValues['QUANT'];
      vrprod := vrprod + qryTerminalBalcao.FieldValues['PRUNI'];
    end;
    qryTerminalBalcao.next;
  end;

  if (p1 < 2) then
    raise exception.create('Não existem produtos suficientes para completar o kit nessa venda. Total:' + inttostr(p1));
  if (p1 = 3) then
    raise exception.create('Não existem produtos suficientes para completar o kit nessa venda. Total:' + inttostr(p1));
  if (p1 > 4) then
    raise exception.create('Excedeu quantidade do kit nessa venda. Total:' + inttostr(p1));
  if (p2 < 1) then
    raise exception.create('Não existem produtos suficientes para completar o kit nessa venda. Total:' + inttostr(p2));
  if (p2 > 2) then
    raise exception.create('Excedeu quantidade do kit nessa venda. Total:' + inttostr(p2));
  if (p1 = 2) and (p2 <> 1) then
    raise exception.create('Forma incorreta.');
  if (p1 = 4) and (p2 <> 2) then
    raise exception.create('Forma Incorreta');
  if (p2 = 1) and (p1 <> 2) then
    raise exception.create('Forma incorreta.');
  if (p2 = 2) and (p1 <> 4) then
    raise exception.create('Forma Incorreta');

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 1)));
  valordescun := (vrprod * 0.9722{100% de desconto});

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto relativo a campanha dia das crianças?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(97.22)) + ',  ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.SQL.Add('    and cdpro in (13851)');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('dia_das_criancas') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod2 * p1)));
      valordescun := (vrprod2 * 0.9800{100% de desconto});

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(98.00)) + ',  ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.SQL.Add('    and cdpro in (13850)');
      qryInsereDesconto.ExecSQL;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('fotosense') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

function TfrmPrincipal.SaldoParceiros(pCPFCli,pTPITM,pMesSaldo,pAnoSaldo:String):Currency;
begin
  // verifica o saldo do parceiro, quanto ja utilizou de desconto dentro do mes e ano da campanha Cortesia Mensal
  qryPrivilegeTEMP.Close;
  qryPrivilegeTEMP.SQL.Clear;
  qryPrivilegeTEMP.SQL.Add(' select sum(vrdesc) as descontos from CORTESIAMENSAL where idcamp=79 ');
  qryPrivilegeTEMP.SQL.Add(' and cpfcli='+quotedstr(pCPFCli));
  qryPrivilegeTEMP.SQL.Add(' and extract(month from DTOPE) = '+pMesSaldo+' AND extract(YEAR from DTOPE) = '+pAnoSaldo+'  ');
  qryPrivilegeTEMP.SQL.Add(' and TPITM = '+quotedstr(pTPITM));
  qryPrivilegeTEMP.Open;

  if qryPrivilegeTEMP.IsEmpty then
     result := 0
  else
     result := qryPrivilegeTEMP.FieldByName('descontos').AsCurrency;
end;

procedure TfrmPrincipal.CampanhaCortesiaMensal;

  procedure GravaDesconto(pvrBruto, pvrDesc, pvrLiq: Currency);
  begin
    qryPrivilegeTEMP.Close;
    qryPrivilegeTEMP.SQL.Clear;
    qryPrivilegeTEMP.SQL.Add('INSERT INTO CORTESIAMENSAL ');
    qryPrivilegeTEMP.SQL.Add('( IDCAMP,CDFIL,TBALCAO,CPFCLI,DTOPE,ITEMID,TPITM,CDFILR,CDPRO,QUANT,VRBRUT,VRDESC,VRLIQ ) values ');
    qryPrivilegeTEMP.SQL.Add('( :pidCamp,:pCDFIL,:pTBALCAO,:pCpfCli,:pDTOPE,:pITEMID,:pTPITM,:pCDFILR,:pCDPRO,:pQUANT,:pVRBRUT,:pVRDESC,:pVRLIQ ) ');
    qryPrivilegeTEMP.Params[0].Value := 79;
    qryPrivilegeTEMP.Params[1].Value := qryTerminalBalcao.FieldValues['CDFIL'];
    qryPrivilegeTEMP.Params[2].Value := qryTerminalBalcao.FieldValues['NRCPM'];
    qryPrivilegeTEMP.Params[3].Value := qryTerminalBalcao.FieldValues['NRCNPJ'];
    qryPrivilegeTEMP.Params[4].Value := qryTerminalBalcao.FieldValues['DTOPE'];
    qryPrivilegeTEMP.Params[5].Value := qryTerminalBalcao.FieldValues['ITEMID'];
    qryPrivilegeTEMP.Params[6].Value := qryTerminalBalcao.FieldValues['TPITM'];

    if qryTerminalBalcao.FieldValues['CDFILR'] = null then
      qryPrivilegeTEMP.Params[7].Value := qryTerminalBalcao.FieldValues['CDFIL']
    else
      qryPrivilegeTEMP.Params[7].Value := qryTerminalBalcao.FieldValues['CDFILR'];

    qryPrivilegeTEMP.Params[8].Value := qryTerminalBalcao.FieldValues['CDPRO'];
    qryPrivilegeTEMP.Params[9].Value := qryTerminalBalcao.FieldValues['QUANT'];
    qryPrivilegeTEMP.Params[10].Value := pvrBruto;
    qryPrivilegeTEMP.Params[11].Value := pvrDesc;
    qryPrivilegeTEMP.Params[12].Value := pvrLiq;

    qryPrivilegeTEMP.ExecSQL;
    qryPrivilegeTEMP.Transaction.CommitRetaining;
  end;

var
  vrBruto, vrDesc, vrLiq, vrUtilizado, vrCrdFormula, vrCredVarejo, VrSaldo, vrComDesc, percDesc, vrDescTotal, vrcxa, vrUtilVar, vrUtilForm: double;
  MesSaldo, AnoSaldo: string;
  quant, item: integer;
  GravaJson, ProdEmPromocao: boolean;
begin

  GravaJson := false;

  qryPrivilegeTEMP.Close;
  qryPrivilegeTEMP.SQL.Clear;
  qryPrivilegeTEMP.SQL.Add(' select * ');
  qryPrivilegeTEMP.SQL.Add('   from campanhasclientes a ');
  qryPrivilegeTEMP.SQL.Add('  where idcamp=79 ');
  qryPrivilegeTEMP.SQL.Add('    and cpfcli=' + inttostr(qryTerminalBalcao.FieldValues['NRCNPJ']));
  qryPrivilegeTEMP.Open;

  vrCrdFormula := qryPrivilegeTEMP.FieldByName('ValorFor').AsCurrency;
  vrCredVarejo := qryPrivilegeTEMP.FieldByName('ValorVar').AsCurrency;

  MesSaldo := FormatDateTime('MM', qryTerminalBalcao.FieldByName('DTOPE').AsDateTime);
  AnoSaldo := FormatDateTime('YYYY', qryTerminalBalcao.FieldByName('DTOPE').AsDateTime);

  vrUtilVar := vrCredVarejo - SaldoParceiros(qryTerminalBalcao.FieldValues['NRCNPJ'], 'V', MesSaldo, AnoSaldo);
  vrUtilForm := vrCrdFormula - SaldoParceiros(qryTerminalBalcao.FieldValues['NRCNPJ'], 'R', MesSaldo, AnoSaldo);

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.eof do
  begin

    if (qryTerminalBalcao.FieldValues['TPDSC'] = 'V') or (qryTerminalBalcao.FieldValues['TPDSC'] = 'R') then
    begin
      ShowMessage('Já existe desconto de R$ ' + floattostr(qryTerminalBalcao.FieldValues['vrdsc']) + ' para ' + qryTerminalBalcao.FieldValues['descrprd']);
      qryTerminalBalcao.Next;
      continue;
    end;

    ProdEmPromocao := false;
    qryFcertaTEMP.Close;
    qryFcertaTEMP.SQL.Clear;
    qryFcertaTEMP.SQL.Add(' select b.ptdsc ');
    qryFcertaTEMP.SQL.Add('   from fc0j100 b ');
    qryFcertaTEMP.SQL.Add('  where b.cdpro =' + intToStr(qryTerminalBalcao.FieldValues['CDPRO']));
    qryFcertaTEMP.SQL.Add('    and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)) + ' >= b.datainicial ');
    qryFcertaTEMP.SQL.Add('    and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)) + ' <= b.datafinal ');
    qryFcertaTEMP.Open;

    if not qryFcertaTEMP.IsEmpty then
      ProdEmPromocao := true;

    // desconto de promoção é permitido aplicar o saldo
    if (qryTerminalBalcao.FieldValues['vrdsc'] > 0) and (ProdEmPromocao = false) then
    begin
      ShowMessage('Já existe desconto R$ ' + floattostr(qryTerminalBalcao.FieldValues['vrdsc']) + ' para ' + qryTerminalBalcao.FieldValues['descrprd']);
      qryTerminalBalcao.Next;
      continue;
    end;

    MesSaldo := FormatDateTime('MM', qryTerminalBalcao.FieldByName('DTOPE').AsDateTime);
    AnoSaldo := FormatDateTime('YYYY', qryTerminalBalcao.FieldByName('DTOPE').AsDateTime);

    vrUtilizado := SaldoParceiros(qryTerminalBalcao.FieldValues['NRCNPJ'], qryTerminalBalcao.FieldValues['TPITM'], MesSaldo, AnoSaldo);

    item := qryTerminalBalcao.FieldValues['itemID'];
    quant := qryTerminalBalcao.FieldValues['quant'];
    vrBruto := qryTerminalBalcao.FieldValues['vrtot'];
    vrDesc := qryTerminalBalcao.FieldValues['vrdsc'];
    vrLiq := qryTerminalBalcao.FieldValues['vrliq'];
    percDesc := 0;

    if (qryTerminalBalcao.FieldValues['TPITM'] = 'R') then
      VrSaldo := vrCrdFormula - vrUtilizado
    else
      VrSaldo := vrCredVarejo - vrUtilizado;

    if VrSaldo >= (vrLiq - 0.02) then
    begin
      vrDesc := (vrLiq - 0.02);
      vrLiq := 0.02;
      percDesc := 99.98;
    end
    else
    begin
      vrDesc := VrSaldo;
      vrLiq := vrBruto - vrDesc;
      percDesc := RoundTo((vrLiq * 100) / vrBruto, -2);
    end;

    if vrDesc = 0 then
    begin
      ShowMessage('Não há saldo suficiente para o desconto no item: ' + intToStr(item));
      qryTerminalBalcao.Next;
      continue;
    end;

    vrDesc := RoundTo(vrDesc, -2);
    GravaJson := true;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update fc32200 ');
    qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescform) + ', ');
    qryInsereDesconto.SQL.Add('        vrliq= vrtot+vrtxa-' + TrocaVirgPPto(floattostr(vrDesc)) + ', ');
    qryInsereDesconto.SQL.Add('        vrsdo=vrtot+vrtxa-vrrcb-' + TrocaVirgPPto(floattostr(vrDesc)) + ', ');
    qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(vrDesc)) + ', ');
    qryInsereDesconto.SQL.Add('        useridaut=' + quotedstr('CortesiaMensal'));
    qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qryTerminalBalcao.FieldValues['cdfil']));
    qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qryTerminalBalcao.FieldValues['cdtml']));
    qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
    qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qryTerminalBalcao.FieldValues['operid']));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qryTerminalBalcao.FieldValues['nrcpm']));
    qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qryTerminalBalcao.FieldValues['itemid']));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.CommitRetaining;

    if qryTerminalBalcao.FieldValues['tppag'] = '1' then
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32200 ');
      qryInsereDesconto.SQL.Add('    set vrcxa = vrtot+vrtxa-' + TrocaVirgPPto(floattostr(vrDesc)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qryTerminalBalcao.FieldValues['cdfil']));
      qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qryTerminalBalcao.FieldValues['cdtml']));
      qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qryTerminalBalcao.FieldValues['operid']));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qryTerminalBalcao.FieldValues['nrcpm']));
      qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qryTerminalBalcao.FieldValues['itemid']));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;
    end
    else
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32200 ');
      qryInsereDesconto.SQL.Add('    set vrcxa= vrrcb ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qryTerminalBalcao.FieldValues['cdfil']));
      qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qryTerminalBalcao.FieldValues['cdtml']));
      qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qryTerminalBalcao.FieldValues['operid']));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qryTerminalBalcao.FieldValues['nrcpm']));
      qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qryTerminalBalcao.FieldValues['itemid']));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;
    end;

    if qryTerminalBalcao.FieldValues['TPITM'] = 'R' then
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select vrcxa ');
      qryInsereDesconto.SQL.Add('   from fc32200 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qryTerminalBalcao.FieldValues['cdfil']));
      qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qryTerminalBalcao.FieldValues['cdtml']));
      qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qryTerminalBalcao.FieldValues['operid']));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qryTerminalBalcao.FieldValues['nrcpm']));
      qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qryTerminalBalcao.FieldValues['itemid']));
      qryInsereDesconto.Open;

      vrcxa := qryInsereDesconto.FieldValues['VRCXA'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr('R') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
      qryInsereDesconto.SQL.Add('        pruni=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
      qryInsereDesconto.SQL.Add('        pruniliq=' + TrocaVirgPPto(floattostr(vrcxa)) + '/QUANT, ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
      qryInsereDesconto.SQL.Add('        BCICM=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
      qryInsereDesconto.SQL.Add('        nomepa=' + quotedstr(useridaut));
      qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qryTerminalBalcao.FieldValues['cdfil']));
      qryInsereDesconto.SQL.Add('    and cdtml=' +quotedstr(qryTerminalBalcao.FieldValues['cdtml']));
      qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qryTerminalBalcao.FieldValues['operid']));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qryTerminalBalcao.FieldValues['nrcpm']));
      qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qryTerminalBalcao.FieldValues['itemid']));
    end
    else
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr('V') + ', ');
      qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(percDesc)) + ' , ');
      qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(vrDesc)) + '/QUANT), ');
      qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(vrDesc)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(vrDesc)) + ', ');
      qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(vrDesc)) + ', ');
      qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(vrDesc)) + ', ');
      qryInsereDesconto.SQL.Add('        nomepa=' + quotedstr(useridaut));
      qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qryTerminalBalcao.FieldValues['cdfil']));
      qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qryTerminalBalcao.FieldValues['cdtml']));
      qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qryTerminalBalcao.FieldValues['operid']));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qryTerminalBalcao.FieldValues['nrcpm']));
      qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qryTerminalBalcao.FieldValues['itemid']));
    end;

    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.CommitRetaining;

    GravaDesconto(vrBruto, vrDesc, vrLiq);

    vrDescTotal := vrDescTotal + vrDesc;
    qryTerminalBalcao.Next;
  end;

  if GravaJson = true then
  begin
    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
    qryInsereDesconto.SQL.Add('   from fc32110 ');
    qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qryTerminalBalcao.FieldValues['cdfil']));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qryTerminalBalcao.FieldValues['nrcpm']));
    qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
    qryInsereDesconto.Open;

    valortotal := qryInsereDesconto.FieldValues['VALOR'];

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update fc32100 ');
    qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('CortesiaMensal') + ', ');
    qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
    qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
    qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
    qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
    qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qryTerminalBalcao.FieldValues['cdfil']));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qryTerminalBalcao.FieldValues['nrcpm']));
    qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.CommitRetaining;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update totvsconf ');
    qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
    qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.Commit;

    lblDescontoValor.Caption := floattostr(vrDescTotal);

    showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
  end;
end;

procedure TfrmPrincipal.DescontoHidraTherapy;
var
  valortotal, valordescun, vrprod: double;
  p, p1: integer;
begin

  lblDescontoValor.Caption := '0';
  p := 0;
  p1 := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = 9937) or (qryTerminalBalcao.FieldValues['CDPRO'] = 9936) or (qryTerminalBalcao.FieldValues['CDPRO'] = 9935) then
    begin
      p := p + qryTerminalBalcao.FieldValues['QUANT'];
    end;

    if (qryTerminalBalcao.FieldValues['CDPRO'] = 13661) then
    begin
      vrprod := qryTerminalBalcao.FieldValues['PRUNI'];
    end;
    qryTerminalBalcao.next;
  end;

  if (p < 2) then
    raise exception.create('Não existem produtos suficientes da linha Fotosense nessa venda. Total:' + inttostr(p));

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 1)));

  ShowMessage(FloatToStr(vrprod));
  ShowMessage(lblDescontoValor.Caption);
  valordescun := (vrprod * 0.9998{100% de desconto});

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo a linha Fotosense?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.98)) + ',  ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')),  ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.SQL.Add('    and cdpro in (13661)');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('fotosense') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.DescontoPrevAging;
var
  valortotal, valdesc, valorunitdesc: double;
  p, q: integer;
  produtos: string;
begin
  lblDescontoValor.Caption := '0';
  p := 0;
  produtos := '2662,3678,9183,9184,9185,9186';

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = 2662) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 3678) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 9183) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 9184) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 9186) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 9185) then
    begin
      p := p + qryTerminalBalcao.FieldValues['QUANT'];
    end;
    qryTerminalBalcao.next;
  end;

  if (p < 2) then
    raise exception.create('Não existem produtos suficientes da linha Prev Aging nessa venda. Total:' + inttostr(p));

  qryInsereDesconto.Close;
  qryInsereDesconto.SQL.Clear;
  qryInsereDesconto.SQL.Add(' select sum(vrliq) as valor ');
  qryInsereDesconto.SQL.Add('   from fc32110 ');
  qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
  qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
  qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
  qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
  qryInsereDesconto.SQL.Add('    and cdpro in (' + produtos + ')');
  qryInsereDesconto.Open;

  desc2var := 15;

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr(qryInsereDesconto.FieldValues['valor'] * (desc2var / 100)));

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo a linha Prev Aging?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin

      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.sql.Clear;
      qrySelecionaDesconto.sql.Add('    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, ');
      qrySelecionaDesconto.sql.Add('           a.PRUNI, a.PTDSC, a.TPDSC, a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, ');
      qrySelecionaDesconto.sql.Add('           a.VRTXAG, a.TPPAG, coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, a.VRTXA, a.VRDSCV, ');
      qrySelecionaDesconto.sql.Add('           a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ  ');
      qrySelecionaDesconto.sql.Add('      from fc32110 a ');
      qrySelecionaDesconto.sql.Add(' left join fc32200 b on ( ');
      qrySelecionaDesconto.sql.Add('           a.cdfil=b.cdfil ');
      qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
      qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
      qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
      qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ');
      qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text) );
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qrySelecionaDesconto.sql.Add('       and a.dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qrySelecionaDesconto.sql.Add('       and a.tpitm=' + quotedstr('V'));
      qrySelecionaDesconto.sql.Add('       and a.cdpro in (' + produtos + ')');
      qrySelecionaDesconto.sql.Add('  order by a.PRUNILIQ');
      qrySelecionaDesconto.Open;

      qrySelecionaDesconto.FetchAll;
      qrySelecionaDesconto.First;

      valdesc := 0;
      tpdescvar := '3';

      while not qrySelecionaDesconto.Eof do
      begin
        valorunitdesc := (qrySelecionaDesconto.FieldValues['PRUNILIQ'] * qrySelecionaDesconto.FieldValues['QUANT'] * desc2var) / 100;

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
        qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
        qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
        qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;

        qrySelecionaDesconto.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('diadasmaes') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.DescontoBlackFriday2;
var
  valortotal, valdesc, valorunitdesc: double;
  p, i, q, q2, qt, qt1, qt2: integer;
begin
  lblDescontoValor.Caption := '0';
  p := 0;
  qt1 := 0;
  qt2 := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if ((qryTerminalBalcao.FieldValues['CDPRO'] = 3770) or
        (qryTerminalBalcao.FieldValues['CDPRO'] = 3768) or
        (qryTerminalBalcao.FieldValues['CDPRO'] = 3767) or
        (qryTerminalBalcao.FieldValues['CDPRO'] = 3774) or
        (qryTerminalBalcao.FieldValues['CDPRO'] = 3775) or
        (qryTerminalBalcao.FieldValues['CDPRO'] = 3776) or
        (qryTerminalBalcao.FieldValues['CDPRO'] = 4377) or
        (qryTerminalBalcao.FieldValues['CDPRO'] = 4373) or
        (qryTerminalBalcao.FieldValues['CDPRO'] = 4378) or
        (qryTerminalBalcao.FieldValues['CDPRO'] = 4374)) then
    begin
      qt1 := qt1 + qryTerminalBalcao.FieldValues['QUANT'];
    end;
    qryTerminalBalcao.next;
  end;

  qryTerminalBalcao.First;
  if (qt1 > 0) then
  begin
    while not qryTerminalBalcao.EOF do
    begin
      if ((qryTerminalBalcao.FieldValues['CDPRO'] = 3772) or
          (qryTerminalBalcao.FieldValues['CDPRO'] = 3771) or
          (qryTerminalBalcao.FieldValues['CDPRO'] = 3769) or
          (qryTerminalBalcao.FieldValues['CDPRO'] = 4379) or
          (qryTerminalBalcao.FieldValues['CDPRO'] = 4375)) then
      begin
        qt2 := qt2 + qryTerminalBalcao.FieldValues['QUANT'];
      end;
      qryTerminalBalcao.next;
    end;
  end;

  if ((qt1 < 1) or (qt2 < 1)) then
    raise exception.create('Não existem produtos suficientes da campanha Black Friday nessa venda. ');

  valdesc := 0;

  if ((qt1 > 0) and (qt2 > 0)) then
  begin

    qryFcertaTEMP.Close;
    qryFcertaTEMP.SQL.Clear;
    qryFcertaTEMP.SQL.Add('   select a.cdpro as COD, a.quant, a.pruni ,a.vrtot ');
    qryFcertaTEMP.SQL.Add('     from fc32110 a ');
    qryFcertaTEMP.SQL.Add('    where a.dtope=current_date ');
    qryFcertaTEMP.SQL.Add('      and a.cdfil=' + edtLoja.Text);
    qryFcertaTEMP.SQL.Add('      and a.nrcpm=' + edtTerminalBalcao.Text);
    qryFcertaTEMP.SQL.Add('      and a.tpitm=' + quotedstr('V'));
    qryFcertaTEMP.SQL.Add('      and a.cdpro in (3772,3771,3769,4379,4375) ');
    qryFcertaTEMP.SQL.Add(' order by 3 ');
    qryFcertaTEMP.Open;

    while not qryFcertaTEMP.eof do
    begin
      valdesc := valdesc + ((qryFcertaTEMP.FieldValues['pruni'] * qryFcertaTEMP.FieldValues['quant']) - 9.9);
      qryFcertaTEMP.Next;
    end;
  end;

  lblDescontoValor.Caption := TrocaVirgPPto(floattostr(valdesc));

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo a campanha Black Friday?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin

      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.sql.Clear;
      qrySelecionaDesconto.sql.Add('    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, a.TPDSC, ');
      qrySelecionaDesconto.sql.Add('           a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, a.CDPRO, coalesce( b.vrtot, a.VRTOT) as VRTOT, ');
      qrySelecionaDesconto.sql.Add('           a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ  ');
      qrySelecionaDesconto.sql.Add('      from fc32110 a ');
      qrySelecionaDesconto.sql.Add(' left join fc32200 b on ( ');
      qrySelecionaDesconto.sql.Add('           a.cdfil=b.cdfil ');
      qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
      qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
      qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
      qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ');
      qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qrySelecionaDesconto.sql.Add('       and a.dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qrySelecionaDesconto.sql.Add('       and a.tpitm=' + quotedstr('V'));
      qrySelecionaDesconto.sql.Add('       and a.cdpro in (3772,3771,3769,4379,4375) ');
      qrySelecionaDesconto.sql.Add('  order by a.PRUNILIQ');
      qrySelecionaDesconto.Open;

      qrySelecionaDesconto.FetchAll;
      qrySelecionaDesconto.First;

      valdesc := 0;
      tpdescvar := '3';

      while not qrySelecionaDesconto.Eof do
      begin
        if (qrySelecionaDesconto.FieldValues['cdpro'] = 3772) or
           (qrySelecionaDesconto.FieldValues['cdpro'] = 3771) or
           (qrySelecionaDesconto.FieldValues['cdpro'] = 3769) then
          desc2var := 80.55
        else
          desc2var := 79.37;

        valorunitdesc := (qrySelecionaDesconto.FieldValues['PRUNILIQ'] * (desc2var / 100));

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
        qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
        qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
        qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;

        qrySelecionaDesconto.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('privcabelos') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.DescontoBlackFriday10203040;
var
  valortotal, valdesc, valorunitdesc: double;
  p, i, q, q2, qt, qt2: integer;
  qt1, percdesc: integer;
  msg: string;
begin
  if (StrToDate(FormatDateTime('dd/mm/yyyy', now)) < strtodate('26/11/2021')) or (StrToDate(FormatDateTime('dd/mm/yyyy', now)) > strtodate('28/11/2021')) then
    Exception.Create('Promoção disponível apenas no período Black Friday');

  lblDescontoValor.Caption := '0';
  p := 0;
  qt1 := 0;
  qt2 := 0;

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add('   select a.cdpro as COD, a.quant, a.pruni ,a.vrtot ');
  qryFcertaTEMP.SQL.Add('     from fc32110 a ');
  qryFcertaTEMP.SQL.Add('    where a.dtope=current_date ');
  qryFcertaTEMP.SQL.Add('      and a.cdfil=' + edtLoja.Text);
  qryFcertaTEMP.SQL.Add('      and a.nrcpm=' + edtTerminalBalcao.Text);
  qryFcertaTEMP.SQL.Add('      and a.tpitm=' + quotedstr('V'));
  qryFcertaTEMP.SQL.Add('      and a.cdpro not in (11368 , 11367, 12489 ,12491	,12492 ,10393	,8280	,10444	,10385	,10382	,8273	,10549	,10129	,10389	,10381	,8287	,9735	,8063	,11731	,8277	,9634	,8061	,8276	,8171	,8283	,8057	) ');
  qryFcertaTEMP.SQL.Add('      and a.cdpro not in (8058 ,10143 ,8065	,10387,8274	,8172	,8056	,8055	,8275	,10133	,8286	,8281	,8064	,9035	,8223	,8062	,10386 ,8052 ,8053 ,11688 ,8054 ,10142	,8285	,8060	)  ');
  qryFcertaTEMP.SQL.Add(' order by 3 ');
  qryFcertaTEMP.Open;

  while not qryFcertaTEMP.Eof do
  begin
    qt1 := qt1 + qryFcertaTEMP.FieldValues['quant'];
    qryFcertaTEMP.Next;
  end;

  if (qt1 < 1) then
  begin
    qryFcertaTEMP.Close;
    raise exception.create('Não existem produtos suficientes da campanha Black Friday nessa venda. ');
  end;

  if qt1 > 3 then
    qt1 := 3;  // maximo de 30% dew desconto
  percdesc := qt1 * 10; // se for 1 é 10% se for 2 é  20%... até se for 3 é 30%

  valdesc := 0;//zera valor de desconto

  qryFcertaTEMP.First;

  while not qryFcertaTEMP.Eof do
  begin
    valdesc := valdesc + ((qryFcertaTEMP.FieldValues['vrtot'] * percdesc) / 100);
    qryFcertaTEMP.Next;
  end;

  qryFcertaTEMP.Close;
  lblDescontoValor.Caption := TrocaVirgPPto(floattostr(valdesc));

  msg := 'Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo a campanha Black Friday?' + #13 + inttostr(percdesc) + '% nos itens válidos';

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg(msg, mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.sql.Clear;
      qrySelecionaDesconto.sql.Add('    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, ');
      qrySelecionaDesconto.sql.Add('           a.TPDSC, a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, a.CDPRO, coalesce( b.vrtot, a.VRTOT) as VRTOT, ');
      qrySelecionaDesconto.sql.Add('           a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ  ');
      qrySelecionaDesconto.sql.Add('      from fc32110 a ');
      qrySelecionaDesconto.sql.Add(' left join fc32200 b on ( ');
      qrySelecionaDesconto.sql.Add('           a.cdfil=b.cdfil ');
      qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
      qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
      qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
      qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ');
      qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qrySelecionaDesconto.sql.Add('       and a.dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qrySelecionaDesconto.sql.Add('       and a.tpitm=' + quotedstr('V'));
      qrySelecionaDesconto.sql.Add('       and a.cdpro not in (11368	,11367	,12489	,12491	,12492	,10393	,8280	,10444	,10385	,10382	,8273	,10549	,10129	,10389	,10381	,8287	,9735	,8063	,11731	,8277	,9634	,8061	,8276	,8171	,8283	,8057	)');
      qrySelecionaDesconto.sql.Add('       and a.cdpro not in (8058	,10143	,8065	,10387	,8274	,8172	,8056	,8055	,8275	,10133	,8286	,8281	,8064	,9035	,8223	,8062	, 10386	,8052	,8053	,11688	,8054 	,10142	,8285	,8060	)  ');
      qrySelecionaDesconto.sql.Add('  order by a.PRUNILIQ');
      qrySelecionaDesconto.Open;

      qrySelecionaDesconto.FetchAll;
      qrySelecionaDesconto.First;

      valdesc := 0;
      tpdescvar := '3';

      while not qrySelecionaDesconto.Eof do
      begin
        desc2var := percdesc;

        valorunitdesc := ((qrySelecionaDesconto.FieldValues['PRUNILIQ'] * qrySelecionaDesconto.FieldValues['QUANT']) * (desc2var / 100));

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
        qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
        qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
        qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;

        qrySelecionaDesconto.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('   and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('   and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('privblackf') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.DescontoProgressivoBlackFriday;
var
  valortotal, valdesc, valorunitdesc: double;
  qtdprom, qt1, percdesc: integer;
  msg: string;
begin
  if (StrToDate(FormatDateTime('dd/mm/yyyy', now)) < strtodate('29/11/2024')) or (StrToDate(FormatDateTime('dd/mm/yyyy', now)) > strtodate('06/12/2024')) then
    raise Exception.Create('Promoção disponível apenas no período Black Friday ( 29/11/2024 a 01/12/2024 ) ');

  lblDescontoValor.Caption := '0';
  qt1 := 0;

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add('   select a.cdpro as COD, a.quant, a.pruni ,a.vrtot, a.vrdsc, a.IDPROMO ');
  qryFcertaTEMP.SQL.Add('     from fc32110 a ');
  qryFcertaTEMP.SQL.Add('    where a.cdfil=' + edtLoja.Text);
  qryFcertaTEMP.SQL.Add('      and a.nrcpm=' + edtTerminalBalcao.Text);
  qryFcertaTEMP.SQL.Add('      and a.tpitm=' + quotedstr('V'));
  qryFcertaTEMP.SQL.Add('      and a.cdpro not in ( 5901, 5900, 15618, 4667, 15615, 15612, 15617, 15613, 17459, 19027, 4666, 17455, 17455, 19072, 19076, 19068, 19073, 19074, 19075, 19071, 19070 )  ');
  qryFcertaTEMP.SQL.Add(' order by 3 ');
  qryFcertaTEMP.Open;

  valdesc := 0;
  qtdprom := 0;

  while not qryFcertaTEMP.Eof do
  begin
    qt1 := qt1 + qryFcertaTEMP.FieldValues['quant'];

    if qryFcertaTEMP.FieldValues['IDPROMO'] = 0 then
      valdesc := valdesc + qryFcertaTEMP.FieldValues['vrdsc']
    else
      qtdprom := qtdprom + 1;

    qryFcertaTEMP.Next;
  end;

  if valdesc > 0 then
    raise Exception.Create('Venda Já possui Desconto');

  if (qt1 < 1) then
  begin
    qryFcertaTEMP.Close;
    raise exception.create('Não existem produtos suficientes da campanha Black Friday nessa venda. ');
  end;

  if qt1 = 1 then
    percdesc := 10;
  if qt1 = 2 then
    percdesc := 20;
  if qt1 >= 3 then
    percdesc := 30;

  valdesc := 0;//zera valor de desconto

  qryFcertaTEMP.First;
  while not qryFcertaTEMP.Eof do
  begin
    if (qryFcertaTEMP.FieldValues['IDPROMO'] > 0) and (qt1 = 1) then
      valdesc := valdesc + qryFcertaTEMP.FieldValues['vrdsc']
    else
      valdesc := valdesc + ((qryFcertaTEMP.FieldValues['PRUNI'] * qryFcertaTEMP.FieldValues['QUANT']) * (percdesc / 100));

    qryFcertaTEMP.Next;
  end;

  lblDescontoValor.Caption := TrocaVirgPPto(floattostr(valdesc));

  msg := 'Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo a campanha Black Friday?' + #13 + inttostr(percdesc) + '% nos itens válidos';

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg(msg, mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.sql.Clear;
      qrySelecionaDesconto.sql.Add('    select a.IDPROMO , a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, a.TPDSC, ');
      qrySelecionaDesconto.sql.Add('           a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, a.CDPRO, coalesce( b.vrtot, a.VRTOT) as VRTOT, ');
      qrySelecionaDesconto.sql.Add('           a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ' );
      qrySelecionaDesconto.sql.Add('      from fc32110 a ');
      qrySelecionaDesconto.sql.Add(' left join fc32200 b on ( ');
      qrySelecionaDesconto.sql.Add('           a.cdfil=b.cdfil ');
      qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
      qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
      qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
      qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ');
      qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qrySelecionaDesconto.sql.Add('       and a.dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qrySelecionaDesconto.sql.Add('       and a.tpitm=' + quotedstr('V'));
      qrySelecionaDesconto.sql.Add('       and a.cdpro not in ( 5901, 5900, 15618, 4667, 15615, 15612, 15617, 15613, 17459, 19027, 4666, 17455, 17455, 19072, 19076, 19068, 19073, 19074, 19075, 19071, 19070 )  ');
      qrySelecionaDesconto.sql.Add('  order by a.PRUNILIQ');

      qrySelecionaDesconto.Open;
      qrySelecionaDesconto.FetchAll;
      qrySelecionaDesconto.First;

      valdesc := 0;
      tpdescvar := '3';

      while not qrySelecionaDesconto.Eof do
      begin
        if (qrySelecionaDesconto.FieldValues['IDPROMO'] > 0) and (qt1 = 1) then
          desc2var := qrySelecionaDesconto.FieldValues['PTDSC']
        else
          desc2var := percdesc;

        valorunitdesc := ((qrySelecionaDesconto.FieldValues['PRUNI'] * qrySelecionaDesconto.FieldValues['QUANT']) * (desc2var / 100));

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
        qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
        qryInsereDesconto.SQL.Add('        pruniliq=PRUNI-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrtot-' + TrocaVirgPPto(floattostr(valorunitdesc)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;

        qrySelecionaDesconto.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('progblackf') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.DescontoProgressivoNatal;
var
  valortotal, valdesc, valorunitdesc: double;
  qt, percdesc: integer;
  msg: string;
begin
  lblDescontoValor.Caption := '0';
  qt := 0;

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add('   select a.cdpro as COD, a.quant, a.pruni ,a.vrtot, a.vrdsc, a.IDPROMO ');
  qryFcertaTEMP.SQL.Add('     from fc32110 a ');
  qryFcertaTEMP.SQL.Add('    where a.cdfil=' + edtLoja.Text );
  qryFcertaTEMP.SQL.Add('      and a.nrcpm=' + edtTerminalBalcao.Text);
  qryFcertaTEMP.SQL.Add('      and a.tpitm=' + quotedstr('V'));
  qryFcertaTEMP.SQL.Add('      and a.cdpro  in ( 17458, 17459, 17454, 17455, 4666, 15618, 4667, 5900, 5901, 15617, 15612, 15615  )  ');
  qryFcertaTEMP.SQL.Add(' order by 3 ');
  qryFcertaTEMP.Open;

  valdesc := 0;

  qryFcertaTEMP.First;

  while not qryFcertaTEMP.Eof do
  begin
    qt := qt + qryFcertaTEMP.FieldValues['quant'];
    valdesc := valdesc + qryFcertaTEMP.FieldValues['vrdsc'];

    qryFcertaTEMP.Next;
  end;

  if valdesc > 0 then
    raise Exception.Create('Venda Já possui Desconto');

  if (qt < 2) then
  begin
    qryFcertaTEMP.Close;
    raise exception.create('Não existem produtos suficientes para a campanha Progressivo de Natal. ');
  end;

  if qt = 2 then
    percdesc := 10;
  if qt = 3 then
    percdesc := 15;
  if qt = 4 then
    percdesc := 15;
  if qt >= 4 then
    percdesc := 20;

  valdesc := 0;//zera valor de desconto

  qryFcertaTEMP.First;

  while not qryFcertaTEMP.Eof do
  begin
    valdesc := valdesc + ((qryFcertaTEMP.FieldValues['vrtot'] * percdesc) / 100);
    qryFcertaTEMP.Next;
  end;

  qryFcertaTEMP.Close;
  lblDescontoValor.Caption := TrocaVirgPPto(floattostr(valdesc));

  msg := 'Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo a campanha Progressivo Natal ?' + #13 + inttostr(percdesc) + '% nos itens válidos';

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg(msg, mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin

      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.sql.Clear;
      qrySelecionaDesconto.sql.Add('    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, a.TPDSC, a.VRDSC, ');
      qrySelecionaDesconto.sql.Add('           a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, a.CDPRO, coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, ');
      qrySelecionaDesconto.sql.Add('           a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ');
      qrySelecionaDesconto.sql.Add('      from fc32110 a ');
      qrySelecionaDesconto.sql.Add(' left join fc32200 b on ( ');
      qrySelecionaDesconto.sql.Add('           a.cdfil=b.cdfil ');
      qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
      qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
      qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
      qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ');
      qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text) );
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qrySelecionaDesconto.sql.Add('       and a.dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qrySelecionaDesconto.sql.Add('       and a.tpitm=' + quotedstr('V'));
      qrySelecionaDesconto.sql.Add('       and a.cdpro in (  17458, 17459, 17454, 17455, 4666, 15618, 4667, 5900, 5901, 15617, 15612, 15615  )  ');
      qrySelecionaDesconto.sql.Add('  order by a.PRUNILIQ');
      qrySelecionaDesconto.Open;

      qrySelecionaDesconto.FetchAll;
      qrySelecionaDesconto.First;

      valdesc := 0;
      tpdescvar := '3';

      while not qrySelecionaDesconto.Eof do
      begin
        desc2var := percdesc;
        valorunitdesc := ((qrySelecionaDesconto.FieldValues['PRUNI'] * qrySelecionaDesconto.FieldValues['QUANT']) * (desc2var / 100));

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
        qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
        qryInsereDesconto.SQL.Add('        pruniliq=PRUNI-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrtot-' + TrocaVirgPPto(floattostr(valorunitdesc)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;

        qrySelecionaDesconto.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Text := 'update fc32100 set useridaut=' + quotedstr('progNatal') + ', vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ',vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ' where  cdfil=' + trim(frmPrincipal.edtLoja.Text) + ' and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text) + ' and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;
      qryInsereDesconto.Close;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Text := 'update totvsconf set ENV=' + quotedstr('N') + ' where  fil=' + trim(frmPrincipal.edtLoja.Text) + ' and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text);
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;
      qryInsereDesconto.Close;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
      qrySelecionaDesconto.Close;

    end;
  end;
end;

procedure TfrmPrincipal.DescontoKitLimaoSiciliano;
var
  valortotal, valdesc, valorunitdesc: double;
  qt, percdesc: integer;
  msg: string;
begin

  lblDescontoValor.Caption := '0';
  qt := 0;

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add('   select a.cdpro as COD, a.quant, a.pruni ,a.vrtot, a.vrdsc, a.IDPROMO ');
  qryFcertaTEMP.SQL.Add('     from fc32110 a ');
  qryFcertaTEMP.SQL.Add('    where a.cdfil=' + edtLoja.Text);
  qryFcertaTEMP.SQL.Add('      and a.nrcpm=' + edtTerminalBalcao.Text);
  qryFcertaTEMP.SQL.Add('      and a.tpitm=' + quotedstr('V'));
  qryFcertaTEMP.SQL.Add('      and a.cdpro  in ( 15615 , 15612  ) ');
  qryFcertaTEMP.SQL.Add(' order by 3 ');
  qryFcertaTEMP.Open;
  valdesc := 0;

  while not qryFcertaTEMP.Eof do
  begin
    qt := qt + qryFcertaTEMP.FieldValues['quant'];
    valdesc := valdesc + qryFcertaTEMP.FieldValues['vrdsc'];

    qryFcertaTEMP.Next;
  end;

  if valdesc > 0 then
    raise Exception.Create('Venda Já possui Desconto');

  if (qt < 2) then
  begin
    qryFcertaTEMP.Close;
    raise exception.create('Não existem produtos suficientes para a campanha KIT LIMÃO SICILIANO.');
  end;

  if qt >= 2 then
    percdesc := 20;

  valdesc := 0;//zera valor de desconto

  qryFcertaTEMP.First;

  while not qryFcertaTEMP.Eof do
  begin
    valdesc := valdesc + ((qryFcertaTEMP.FieldValues['vrtot'] * percdesc) / 100);
    qryFcertaTEMP.Next;
  end;

  qryFcertaTEMP.Close;
  lblDescontoValor.Caption := TrocaVirgPPto(floattostr(valdesc));

  msg := 'Deseja confirmar desconto(20%) de R$ ' + lblDescontoValor.Caption + ' relativo a campanha KIT LIMÃO SICILIANO?';

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg(msg, mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin

      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.sql.Clear;
      qrySelecionaDesconto.sql.Add('    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, a.TPDSC, a.VRDSC, ');
      qrySelecionaDesconto.sql.Add('           a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, a.CDPRO, coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, ');
      qrySelecionaDesconto.sql.Add('           a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ');
      qrySelecionaDesconto.sql.Add('      from fc32110 a ');
      qrySelecionaDesconto.sql.Add(' left join fc32200 b on ( ');
      qrySelecionaDesconto.sql.Add('           a.cdfil=b.cdfil ');
      qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
      qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
      qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
      qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ');
      qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qrySelecionaDesconto.sql.Add('       and a.dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qrySelecionaDesconto.sql.Add('       and a.tpitm=' + quotedstr('V'));
      qrySelecionaDesconto.sql.Add('       and a.cdpro in ( 15615 , 15612 ) ');
      qrySelecionaDesconto.sql.Add('  order by a.PRUNILIQ');
      qrySelecionaDesconto.Open;
      qrySelecionaDesconto.FetchAll;
      qrySelecionaDesconto.First;

      valdesc := 0;
      tpdescvar := '3';

      while not qrySelecionaDesconto.Eof do
      begin
        desc2var := percdesc;
        valorunitdesc := ((qrySelecionaDesconto.FieldValues['PRUNI'] * qrySelecionaDesconto.FieldValues['QUANT']) * (desc2var / 100));

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
        qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
        qryInsereDesconto.SQL.Add('        pruniliq=PRUNI-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrtot-' + TrocaVirgPPto(floattostr(valorunitdesc)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.Commit;

        qrySelecionaDesconto.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add('  select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('    from fc32110 ');
      qryInsereDesconto.SQL.Add('   where  cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('     and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('     and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('KitLimaoSiciliano') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Text := 'update totvsconf set ENV=' + quotedstr('N') + ' where  fil=' + trim(frmPrincipal.edtLoja.Text) + ' and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text);
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;
      qryInsereDesconto.Close;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
      qrySelecionaDesconto.Close;
    end;
  end;
end;


procedure TfrmPrincipal.DescontoKitLiroDoVale;
var
  valortotal, valdesc, valorunitdesc: double;
  qt, percdesc: integer;
  msg: string;
begin
  lblDescontoValor.Caption := '0';
  qt := 0;

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add('   select a.cdpro as COD, a.quant, a.pruni ,a.vrtot, a.vrdsc, a.IDPROMO ');
  qryFcertaTEMP.SQL.Add('     from fc32110 a ');
  qryFcertaTEMP.SQL.Add('    where a.cdfil=' + edtLoja.Text);
  qryFcertaTEMP.SQL.Add('      and a.nrcpm=' + edtTerminalBalcao.Text);
  qryFcertaTEMP.SQL.Add('      and a.tpitm=' + quotedstr('V'));
  qryFcertaTEMP.SQL.Add('      and a.cdpro  in (15617, 15613) ');
  qryFcertaTEMP.SQL.Add(' order by 3 ');

  qryFcertaTEMP.Open;
  valdesc := 0;

  while not qryFcertaTEMP.Eof do
  begin
    qt := qt + qryFcertaTEMP.FieldValues['quant'];
    valdesc := valdesc + qryFcertaTEMP.FieldValues['vrdsc'];

    qryFcertaTEMP.Next;
  end;

  if valdesc > 0 then
    raise Exception.Create('Venda Já possui Desconto');

  if (qt < 2) then
  begin
    qryFcertaTEMP.Close;
    raise exception.create('Não existem produtos suficientes para a campanha KIT LÍRIO DO VALE.');
  end;

  if qt >= 2 then
    percdesc := 20;

  valdesc := 0;//zera valor de desconto

  qryFcertaTEMP.First;

  while not qryFcertaTEMP.Eof do
  begin
    valdesc := valdesc + ((qryFcertaTEMP.FieldValues['vrtot'] * percdesc) / 100);
    qryFcertaTEMP.Next;
  end;

  qryFcertaTEMP.Close;
  lblDescontoValor.Caption := TrocaVirgPPto(floattostr(valdesc));

  msg := 'Deseja confirmar desconto(20%) de R$ ' + lblDescontoValor.Caption + ' relativo a campanha KIT LÍRIO DO VALE?';

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg(msg, mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin

      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.sql.Clear;
      qrySelecionaDesconto.sql.Add('    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, ');
      qrySelecionaDesconto.sql.Add('           a.TPDSC, a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, a.CDPRO, ');
      qrySelecionaDesconto.sql.Add('           coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ');
      qrySelecionaDesconto.sql.Add('      from fc32110 a ');
      qrySelecionaDesconto.sql.Add(' left join fc32200 b on ( ');
      qrySelecionaDesconto.sql.Add('           a.cdfil=b.cdfil ');
      qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
      qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
      qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
      qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ');
      qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qrySelecionaDesconto.sql.Add('       and a.dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qrySelecionaDesconto.sql.Add('       and a.tpitm=' + quotedstr('V'));
      qrySelecionaDesconto.sql.Add('       and a.cdpro in  (  15617 , 15613  ) ');
      qrySelecionaDesconto.sql.Add('  order by a.PRUNILIQ');
      qrySelecionaDesconto.Open;
      qrySelecionaDesconto.FetchAll;
      qrySelecionaDesconto.First;

      valdesc := 0;
      tpdescvar := '3';

      while not qrySelecionaDesconto.Eof do
      begin

        desc2var := percdesc;
        valorunitdesc := ((qrySelecionaDesconto.FieldValues['PRUNI'] * qrySelecionaDesconto.FieldValues['QUANT']) * (desc2var / 100));

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
        qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
        qryInsereDesconto.SQL.Add('        pruniliq=PRUNI-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrtot-' + TrocaVirgPPto(floattostr(valorunitdesc)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.Commit;

        qrySelecionaDesconto.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('KitLiroDoVale') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.VendasIfood;
var
  valortotal, valdesc: double;
begin

  lblDescontoValor.Caption := '0';
  valdesc := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if qryTerminalBalcao.FieldValues['vrdsc'] > 0 then
      valdesc := valdesc + qryTerminalBalcao.FieldValues['vrdsc'];
    qryTerminalBalcao.next;
  end;

  lblDescontoValor.Caption := TrocaVirgPPto(floattostr(valdesc));

  if (lblDescontoValor.Caption = '0') then
    raise exception.create('Não existe desconto do mês, nessa venda para remover.');

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja remover  ' + lblDescontoValor.Caption + ' relativo ao descontos do mês?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin

      qryTerminalBalcao.First;
      while not qryTerminalBalcao.eof do
      begin

        if qryTerminalBalcao.FieldValues['vrdsc'] = 0 then
        begin
          qryTerminalBalcao.Next;
          continue;
        end;

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set pruniliq=vrtot, ');
        qryInsereDesconto.SQL.Add('        vrcxa=vrtot, ');
        qryInsereDesconto.SQL.Add('        vrliq=vrtot, ');
        qryInsereDesconto.SQL.Add('        vrdsc=0, ');
        qryInsereDesconto.SQL.Add('        PTDSC=0, ');
        qryInsereDesconto.SQL.Add('        BCPIS=vrtot, ');
        qryInsereDesconto.SQL.Add('        VRPIS= vrtot *(ALPIS/100) , ');
        qryInsereDesconto.SQL.Add('        BCCOFINS=vrtot, ');
        qryInsereDesconto.SQL.Add('        BCICM=vrtot, ');
        qryInsereDesconto.SQL.Add('        VRCOFINS= vrtot * ( ALCOFINS/100), ');
        qryInsereDesconto.SQL.Add('        VRICM = vrtot * ( ALICM/100 ) ');
        qryInsereDesconto.SQL.Add('  where cdfil=' + qryTerminalBalcao.FieldByName('cdfil').AsString);
        qryInsereDesconto.SQL.Add('    and nrcpm=' + qryTerminalBalcao.FieldByName('nrcpm').AsString);
        qryInsereDesconto.SQL.Add('    and itemid = ' + qryTerminalBalcao.FieldByName('itemid').AsString);
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.Commit;

        qryTerminalBalcao.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope>=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('VendasIfood') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope>=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      QryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO REMOVIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.DescontoPromocional;
var
  valortotal: double;
begin
  lblDescontoValor.Caption := '0';
  lblDescontoValorBioneov.Caption := '0';

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = 5048) or (qryTerminalBalcao.FieldValues['CDPRO'] = 5049) or (qryTerminalBalcao.FieldValues['CDPRO'] = 5050) or (qryTerminalBalcao.FieldValues['CDPRO'] = 5051) or (qryTerminalBalcao.FieldValues['CDPRO'] = 5052) then
      lblDescontoValor.Caption := inttostr(strtoint(lblDescontoValor.Caption) + 10 * (qryTerminalBalcao.FieldValues['QUANT']));
    qryTerminalBalcao.next;
  end;

  if (lblDescontoValor.Caption = '0') then
    raise exception.create('Não existem produtos da linha Capsolution nessa venda');

  if strtoint(lblDescontoValor.Caption) > 30 then
    lblDescontoValor.Caption := '30';

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de ' + lblDescontoValor.Caption + '% relativo ao Capsolution?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set pruniliq=(pruni)-(pruni*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + ')), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(vrtot*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + ')), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(vrtot*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + ')), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(pruni*quant*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + ')), ');
      qryInsereDesconto.SQL.Add('        PTDSC=' + lblDescontoValor.Caption + ', ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(pruni*quant*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=(((VRCXA-(pruni*quant*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + '))))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(pruni*quant*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(pruni*quant*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=(((VRCXA-(pruni*quant*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + '))))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.SQL.Add('    and cdpro in (5048,5049,5050,5051,5052)');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set pruniliq=(pruni)-(pruni*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + ')), ');
      qryInsereDesconto.SQL.Add('        BCICM=((pruni)-(pruni*quant*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + '))), ');
      qryInsereDesconto.SQL.Add('        vrtot=((pruni*quant)-(pruni*quant*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + '))), ');
      qryInsereDesconto.SQL.Add('        vrcxa=((pruni)-(pruni*quant*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + '))), ');
      qryInsereDesconto.SQL.Add('        vrliq=((pruni)-(pruni*quant*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + '))), ');
      qryInsereDesconto.SQL.Add('        pruni=(pruni)-(pruni*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + '))');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('R'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.SQL.Add('    and cdpro in (5048,5049,5050,5051,5052)');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('capsolution') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.DescontoPromocional2;
var
  valortotal: double;
  qtdprodpromocao, i: integer;
begin
  qtdprodpromocao := 0;
  lblDescontoValor.Caption := '0';

  qryTerminalBalcao.First;

  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = 4695) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 4696) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 4697) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 4699) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 4701) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 4702) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 4694) or
       (qryTerminalBalcao.FieldValues['CDPRO'] = 4700) then
    begin
      if (qryTerminalBalcao.FieldValues['VRDSC']) > 0 then
        lblDescontoValor.Caption := FloatToStr(StrToFloat(lblDescontoValor.Caption) + (qryTerminalBalcao.FieldValues['VRDSC']));
      qtdprodpromocao := qtdprodpromocao + qryTerminalBalcao.FieldValues['QUANT'];
    end;
    qryTerminalBalcao.next;
  end;

  if (qtdprodpromocao < 3) then
    raise exception.create('Não existem produtos suficiente da linha Hidrasoft para incluir descontos nessa venda');

  if (lblDescontoValor.Caption <> '0') then
    raise exception.create('Já existem descontos lançados para linha Hidrasoft nessa venda');

  qtdprodpromocao := (qtdprodpromocao div 3);
  lblDescontoValor.Caption := floattostr(qtdprodpromocao * 27.89);

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto relativo a linha Hidrasoft?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.sql.Clear;
      qrySelecionaDesconto.sql.Add(' select * ');
      qrySelecionaDesconto.sql.Add('   from fc32110 ');
      qrySelecionaDesconto.sql.Add('  where tpitm=' + quotedstr('V'));
      qrySelecionaDesconto.sql.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qrySelecionaDesconto.sql.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qrySelecionaDesconto.sql.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qrySelecionaDesconto.sql.Add('    and cdpro in (4695,4696)');
      qrySelecionaDesconto.Open;

      if qrySelecionaDesconto.IsEmpty then
        raise exception.create('Inclua o hidrasoft para mãos ou pés na venda e tente novamente');

      qrySelecionaDesconto.FetchAll;

      if qrySelecionaDesconto.RecordCount < qtdprodpromocao then
        raise exception.create('Inclua ' + inttostr(qtdprodpromocao) + ' produtos para mãos ou pés na venda para entregar ao cliente');

      qrySelecionaDesconto.First;

      for i := 1 to qtdprodpromocao do
      begin
        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set pruniliq=(pruniliq-(pruniliq-0.01)), ');
        qryInsereDesconto.SQL.Add('        ptdsc=99.97 , ');
        qryInsereDesconto.SQL.Add('        tpdsc=' + quotedstr('3') + ' ,');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrtot-(vrtot-0.01)), ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrtot-(vrtot-0.01)), ');
        qryInsereDesconto.SQL.Add('        vrdsc=(27.89), ');
        qryInsereDesconto.SQL.Add('        BCPIS=(0.01), ');
        qryInsereDesconto.SQL.Add('        VRPIS=(0.01), ');
        qryInsereDesconto.SQL.Add('        BCCOFINS=(0.01), ');
        qryInsereDesconto.SQL.Add('        BCICM=(0.01), ');
        qryInsereDesconto.SQL.Add('        VRCOFINS=(0.01) ');
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;

        qrySelecionaDesconto.Next;
        if qrySelecionaDesconto.Eof then
          qrySelecionaDesconto.First;
      end;

      qrySelecionaDesconto.First;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('hidrasoft') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.DescontoLeva3Paga2;
var
  valortotal: double;
  qtdprodpromocao, i: integer;
  valdesc: string;
begin
  qtdprodpromocao := 0;
  lblDescontoValor.Caption := '0';

  qryTerminalBalcao.First;

  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = 8074) then
    begin
      if (qryTerminalBalcao.FieldValues['VRDSC']) > 0 then
        lblDescontoValor.Caption := FloatToStr(StrToFloat(lblDescontoValor.Caption) + (qryTerminalBalcao.FieldValues['VRDSC']));
      qtdprodpromocao := qtdprodpromocao + qryTerminalBalcao.FieldValues['QUANT'];
    end;
    qryTerminalBalcao.next;
  end;

  if (qtdprodpromocao < 3) then
    raise exception.create('Não existem produtos suficientes do Combo Sabonete Wishes para incluir descontos nessa venda');

  if (lblDescontoValor.Caption <> '0') then
    raise exception.create('Já existem descontos lançados nessa venda');

  qtdprodpromocao := (qtdprodpromocao div 3);

  lblDescontoValor.Caption := floattostr(qtdprodpromocao * 26.80);
  valdesc := '26.80';

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto relativo ao Combo Wishes?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      for i := 1 to qtdprodpromocao do
      begin
        qrySelecionaDesconto.Close;
        qrySelecionaDesconto.sql.Clear;
        qrySelecionaDesconto.sql.Add('   select * ');
        qrySelecionaDesconto.sql.Add('     from fc32110 ');
        qrySelecionaDesconto.sql.Add('    where tpitm=' + quotedstr('V'));
        qrySelecionaDesconto.sql.Add('      and cdfil=' + trim(frmPrincipal.edtLoja.Text));
        qrySelecionaDesconto.sql.Add('      and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
        qrySelecionaDesconto.sql.Add('      and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
        qrySelecionaDesconto.sql.Add('      and cdpro in (8074) ');
        qrySelecionaDesconto.sql.Add('      and vrliq > 26.89 ');
        qrySelecionaDesconto.sql.Add(' order by vrliq desc');
        qrySelecionaDesconto.Open;

        if qrySelecionaDesconto.IsEmpty then
          raise exception.Create('Erro ao lançar desconto Combo Wishes');

        qryInsereDesconto.Close;
        qryInsereDesconto.sql.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set pruniliq=(pruniliq-(' + valdesc + ')), ');
        qryInsereDesconto.SQL.Add('        ptdsc=99.97 ,');
        qryInsereDesconto.SQL.Add('        tpdsc=' + quotedstr('3') + ' ,');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrcxa-(' + valdesc + ')), ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrliq-(' + valdesc + ')), ');
        qryInsereDesconto.SQL.Add('        vrdsc=vrdsc+(' + valdesc + '),');
        qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + valdesc);
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;
      end;

      qrySelecionaDesconto.First;

      qryInsereDesconto.Close;
      qryInsereDesconto.sql.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.sql.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('hidratherapy') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ',');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.DescontoPromocional6;
var
  valortotal: double;
  qtdprodpromocao, i: integer;
  qtdbrinde: integer;
  valdesc: string;
begin
  qtdprodpromocao := 0;
  qtdbrinde := 0;
  lblDescontoValor.Caption := '0';

  qryTerminalBalcao.First;

  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = 9936) or (qryTerminalBalcao.FieldValues['CDPRO'] = 9935) or (qryTerminalBalcao.FieldValues['CDPRO'] = 9937) then
    begin
      if (qryTerminalBalcao.FieldValues['VRDSC']) > 0 then
        lblDescontoValor.Caption := FloatToStr(StrToFloat(lblDescontoValor.Caption) + (qryTerminalBalcao.FieldValues['VRDSC']));
      qtdprodpromocao := qtdprodpromocao + qryTerminalBalcao.FieldValues['QUANT'];
    end;
    qryTerminalBalcao.next;
  end;

  qryTerminalBalcao.First;

  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = 4701) or (qryTerminalBalcao.FieldValues['CDPRO'] = 4702) or (qryTerminalBalcao.FieldValues['CDPRO'] = 4694) then
    begin
      qtdbrinde := qtdbrinde + qryTerminalBalcao.FieldValues['QUANT'];
    end;
    qryTerminalBalcao.next;
  end;

  if ((qtdprodpromocao < 2)) then
    raise exception.create('Não existem produtos suficientes da campanha fotosense para participar da campanha');

  qtdprodpromocao := (qtdprodpromocao div 2);

  if ((qtdbrinde < qtdprodpromocao)) then
    raise exception.create('Não existem brindes suficientes da campanha fotosense para participar da campanha');

  if (lblDescontoValor.Caption <> '0') then
    raise exception.create('Já existem descontos lançados para campanha fotosense nessa venda');

  lblDescontoValor.Caption := floattostr(qtdprodpromocao * 7.5);
  valdesc := '7.5';

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto relativo a campanha fotosense?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      for i := 1 to qtdprodpromocao do
      begin
        qrySelecionaDesconto.Close;
        qrySelecionaDesconto.sql.Clear;
        qrySelecionaDesconto.sql.Add('   select * ');
        qrySelecionaDesconto.sql.Add('     from fc32110 ');
        qrySelecionaDesconto.sql.Add('    where tpitm=' + quotedstr('V'));
        qrySelecionaDesconto.sql.Add('      and cdfil=' + trim(frmPrincipal.edtLoja.Text));
        qrySelecionaDesconto.sql.Add('      and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
        qrySelecionaDesconto.sql.Add('      and dtope>=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
        qrySelecionaDesconto.sql.Add('      and cdpro in (4701,4702,4694) ');
        qrySelecionaDesconto.sql.Add('      and vrdsc=0');
        qrySelecionaDesconto.sql.Add(' order by vrliq desc');
        qrySelecionaDesconto.Open;

        if qrySelecionaDesconto.IsEmpty then
          raise exception.Create('Erro ao lançar desconto campanha fotosense');

        qryInsereDesconto.Close;
        qryInsereDesconto.sql.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set pruniliq=(pruniliq-(pruniliq-0.1)), ');
        qryInsereDesconto.SQL.Add('        ptdsc=99.37 ,tpdsc=' + quotedstr('3') + ' , ');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrcxa-(vrcxa-0.1)), ');
        qryInsereDesconto.SQL.Add('        vrliq=vrliq-(vrliq-(0.1)), ');
        qryInsereDesconto.SQL.Add('        vrdsc=vrdsc+(pruniliq-0.1), ');
        qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-(vrliq-(0.1)) ');
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope>=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;
      end;

      qrySelecionaDesconto.First;

      qryInsereDesconto.Close;
      qryInsereDesconto.sql.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope>=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.sql.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('hidratherapy') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope>=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.DescontoPromocional7;
var
  valortotal: double;
  qtdprodpromocao, i: integer;
  valdesc: string;
begin

  qtdprodpromocao := 0;
  lblDescontoValor.Caption := '0';

  qryTerminalBalcao.First;

  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = 9056) or (qryTerminalBalcao.FieldValues['CDPRO'] = 10270) then
    begin
      if (qryTerminalBalcao.FieldValues['VRDSC']) > 0 then
        lblDescontoValor.Caption := FloatToStr(StrToFloat(lblDescontoValor.Caption) + (qryTerminalBalcao.FieldValues['VRDSC']));
      qtdprodpromocao := qtdprodpromocao + qryTerminalBalcao.FieldValues['QUANT'];
    end;

    qryTerminalBalcao.next;
  end;

  if (qtdprodpromocao < 4) then
    raise exception.create('Não existem produtos suficientes do Combo Sabonete para incluir descontos nessa venda');

  if (qtdprodpromocao < 5) then
    raise exception.create('Inclua o item que será brinde nessa venda');

  if (lblDescontoValor.Caption <> '0') then
    raise exception.create('Já existem descontos lançados para linha Oceanic nessa venda');

  qtdprodpromocao := (qtdprodpromocao div 5);

  lblDescontoValor.Caption := floattostr(qtdprodpromocao * 26.89);
  valdesc := '26.89';

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto relativo ao combo sabonete?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      for i := 1 to qtdprodpromocao do
      begin
        qrySelecionaDesconto.Close;
        qrySelecionaDesconto.sql.Clear;
        qrySelecionaDesconto.sql.Add('   select * ');
        qrySelecionaDesconto.sql.Add('     from fc32110 ');
        qrySelecionaDesconto.sql.Add('    where tpitm=' + quotedstr('V'));
        qrySelecionaDesconto.sql.Add('      and cdfil=' + trim(frmPrincipal.edtLoja.Text));
        qrySelecionaDesconto.sql.Add('      and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
        qrySelecionaDesconto.sql.Add('      and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
        qrySelecionaDesconto.sql.Add('      and cdpro in (9056,10270) ');
        qrySelecionaDesconto.sql.Add('      and vrliq > 26.89 ');
        qrySelecionaDesconto.sql.Add(' order by vrliq desc');
        qrySelecionaDesconto.Open;

        if qrySelecionaDesconto.IsEmpty then
          raise exception.Create('Erro ao lançar desconto combo sabonete');

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set pruniliq=(pruniliq-(' + valdesc + ')), ');
        qryInsereDesconto.SQL.Add('        ptdsc=99.97 ,');
        qryInsereDesconto.SQL.Add('        tpdsc=' + quotedstr('3') + ' ,');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrcxa-(' + valdesc + ')), ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrliq-(' + valdesc + ')), ');
        qryInsereDesconto.SQL.Add('        vrdsc=vrdsc+(' + valdesc + '),');
        qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + valdesc);
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;
      end;

      qrySelecionaDesconto.First;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('hidratherapy') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.Descontonosegundoitem;
var
  valortotal, valorproduto, valdesc: double;
  qtdprodpromocao, i, percdesc, codproduto: integer;
  nomedesconto: string;
begin

  qtdprodpromocao := 0;
  lblDescontoValor.Caption := '0';
  nomedesconto := 'Moro Shape';
  codproduto := 12917;

  qryTerminalBalcao.First;

  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['CDPRO'] = codproduto) then
    begin
      if (qryTerminalBalcao.FieldValues['VRDSC']) > 0 then
        lblDescontoValor.Caption := FloatToStr(StrToFloat(lblDescontoValor.Caption) + (qryTerminalBalcao.FieldValues['VRDSC']));
      qtdprodpromocao := qtdprodpromocao + qryTerminalBalcao.FieldValues['QUANT'];
      valorproduto := qryTerminalBalcao.FieldValues['PRUNI']
    end;
    qryTerminalBalcao.next;
  end;

  if (qtdprodpromocao < 2) then
    raise exception.create('Não existem produtos suficientes ' + nomedesconto + ' para incluir descontos nessa venda');

  if (lblDescontoValor.Caption <> '0') then
    raise exception.create('Já existem descontos lançados para ' + nomedesconto + ' nessa venda');

  qtdprodpromocao := (qtdprodpromocao div 2);

  percdesc := 20;

  lblDescontoValor.Caption := floattostr(qtdprodpromocao * ((valorproduto * percdesc) / 100));

  valdesc := (valorproduto * percdesc) / 100;

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto relativo ao ' + nomedesconto + '?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      for i := 1 to qtdprodpromocao do
      begin
        qrySelecionaDesconto.Close;
        qrySelecionaDesconto.sql.Clear;
        qrySelecionaDesconto.sql.Add('   select * ');
        qrySelecionaDesconto.sql.Add('     from fc32110 ');
        qrySelecionaDesconto.sql.Add('    where tpitm=' + quotedstr('V'));
        qrySelecionaDesconto.sql.Add('      and cdfil=' + trim(frmPrincipal.edtLoja.Text));
        qrySelecionaDesconto.sql.Add('      and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
        qrySelecionaDesconto.sql.Add('      and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
        qrySelecionaDesconto.sql.Add('      and cdpro in (' + inttostr(codproduto) + ')');
        qrySelecionaDesconto.sql.Add('      and vrliq >' + mudaponto(valdesc));
        qrySelecionaDesconto.sql.Add(' order by vrliq desc');
        qrySelecionaDesconto.Open;

        if qrySelecionaDesconto.IsEmpty then
          raise exception.Create('Erro ao lançar desconto ' + nomedesconto);

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set pruniliq=(pruniliq-(' + mudaponto(valdesc) + ')), ');
        qryInsereDesconto.SQL.Add('        ptdsc=99.97 ,');
        qryInsereDesconto.SQL.Add('        tpdsc=' + quotedstr('3') + ' ,');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrcxa-(' + mudaponto(valdesc) + ')), ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrliq-(' + mudaponto(valdesc) + ')), ');
        qryInsereDesconto.SQL.Add('        vrdsc=vrdsc+(' + mudaponto(valdesc) + '),');
        qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + mudaponto(valdesc));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;
      end;

      qrySelecionaDesconto.First;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('desconto2item') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');

      btInsereDesconto.Enabled := false;
    end;
  end;
end;

procedure TfrmPrincipal.Descontoprogressivo;
var
  valortotal, valorproduto, valdesc, valdesctot, valdescapl: double;
  qtdprodpromocao, i, percdesc, codproduto: integer;
  nomedesconto, itemId: string;
begin
  valdesctot := 0;
  lblDescontoValor.Caption := '0';

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Text := RetornarSelectFC32110ItensVarejo( qryTerminalBalcao.FieldValues['CDFIL'], qryTerminalBalcao.FieldValues['NRCPM']);
  qryFcertaTEMP.Open;

  if not (qryFcertaTEMP.IsEmpty) then
  begin
    qtdprodpromocao := 0;
    qryTerminalBalcao.First;

    while not qryTerminalBalcao.EOF do
    begin
      if (qryTerminalBalcao.FieldValues['vrdsc'] > 0) and (qryTerminalBalcao.FieldValues['IDPROMO'] = 0) then
        raise Exception.Create('Venda já possui Desconto');

      if (qryTerminalBalcao.FieldValues['CDPRO'] = codproduto) then
      begin
        if (qryTerminalBalcao.FieldValues['VRDSC']) > 0 then
          lblDescontoValor.Caption := FloatToStr(StrToFloat(lblDescontoValor.Caption) + (qryTerminalBalcao.FieldValues['VRDSC']));
        valdescapl := valdescapl + qryTerminalBalcao.FieldValues['VRDSC'];
      end;
      qryTerminalBalcao.next;
    end;

    if (valdescapl > 0) then
      raise exception.create('Já existem descontos lançados para ' + CAMPANHA_PROGRESSIVO + ' nessa venda');

    if MessageDlg('Deseja confirmar desconto relativo ao ' + CAMPANHA_PROGRESSIVO + '?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin

      if qryFcertaTEMP.FieldValues['vrdsc'] > 0 then
        raise Exception.Create('Venda já possue desconto');

     { while not (qryFcertaTEMP.Eof) do
      begin
        codproduto := qryFcertaTEMP.FieldValues['cdpro'];
        qtdprodpromocao := qryFcertaTEMP.FieldValues['qtd'];

        if qtdprodpromocao > 2 then
          percdesc := 15
        else
          percdesc := 10;

        qryTerminalBalcao.First;

        for i := 1 to qtdprodpromocao do
        begin
          qryInsereDesconto.Close;
          qryInsereDesconto.sql.Clear;
          qryInsereDesconto.sql.Add(' select * ');
          qryInsereDesconto.sql.Add('   from fc32110');
          qryInsereDesconto.sql.Add('  where tpitm=' + quotedstr('V'));
          qryInsereDesconto.sql.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
          qryInsereDesconto.sql.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
          qryInsereDesconto.sql.Add('    and dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
          qryInsereDesconto.sql.Add('    and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
          qryInsereDesconto.sql.Add('    and cdpro in (' + inttostr(codproduto) + ') and vrdsc = 0 order by itemID');
          qryInsereDesconto.Open;

          if qryInsereDesconto.IsEmpty then
            continue;

          valorproduto := qryInsereDesconto.FieldValues['pruni'] * qryInsereDesconto.FieldValues['quant'];
          valdesc := (valorproduto * percdesc) / 100;

          valdesctot := valdesctot + valdesc;

          itemId := inttostr(qryInsereDesconto.FieldValues['itemid']);

          if qryInsereDesconto.IsEmpty then
            raise exception.Create('Erro ao lançar desconto ' + CAMPANHA_PROGRESSIVO);

          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set pruniliq=(pruniliq-(' + mudaponto(valdesc) + ')),');
          qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(percdesc)) + ',');
          qryInsereDesconto.SQL.Add('        tpdsc=' + quotedstr('3') + ' ,');
          qryInsereDesconto.SQL.Add('        vrcxa=(vrcxa-(' + mudaponto(valdesc) + ')), ');
          qryInsereDesconto.SQL.Add('        vrliq=(vrliq-(' + mudaponto(valdesc) + ')), ');
          qryInsereDesconto.SQL.Add('        vrdsc=' + mudaponto(valdesc) + ',');
          qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + mudaponto(valdesc));
          qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
          qryInsereDesconto.SQL.Add('    and itemid=' + itemId);
          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.Commit;
        end;
        qryFcertaTEMP.Next;
      end;

      qryInseredesconto2.Close;
      qryInseredesconto2.SQL.Clear;
      qryInseredesconto2.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInseredesconto2.SQL.Add('   from fc32110 ');
      qryInseredesconto2.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInseredesconto2.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInseredesconto2.SQL.Add('    and dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
      qryInseredesconto2.SQL.Add('    and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInseredesconto2.Open;

      valortotal := qryInseredesconto2.FieldValues['VALOR'];
      qryInseredesconto2.Close;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr(USUARIO_PROGRESSIVO) + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ',');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;     }

      Desconto_Progressivo(valdesctot, InfoTela);
      lblDescontoValor.Caption := floattostr(valdesctot);
      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end
  else
    showmessage('Não existem produtos de varejo iguais nessa compra');
end;

procedure TfrmPrincipal.Descontoprogressivo1;
// rotina antiga, vou deixa temporariamente até o final dos teste nas lojas - deletar em breve
var
  valortotal, valorproduto, valdesc, valdesctot, valdescapl: double;
  qtdprodpromocao, i, percdesc, codproduto: integer;
  nomedesconto: string;
begin
  valdesctot := 0;
  lblDescontoValor.Caption := '0';
  nomedesconto := 'Desconto Progressivo';

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add('   select a.cdpro, sum(a.quant) as qtd, pruni,sum(vrdsc)vrdsc ');
  qryFcertaTEMP.SQL.Add('     from fc32110 a ');
  qryFcertaTEMP.SQL.Add('    where a.tpitm=' + quotedstr('V'));
  qryFcertaTEMP.SQL.Add('      and a.cdfil=' + inttostr(qryTerminalBalcao.FieldValues['CDFIL']));
  qryFcertaTEMP.SQL.Add('      and a.nrcpm=' + inttostr(qryTerminalBalcao.FieldValues['NRCPM']));
  qryFcertaTEMP.SQL.Add(' group by 1,3 ');
  qryFcertaTEMP.SQL.Add('   having sum(a.quant)>1 ');

  qryFcertaTEMP.Open;

  if not (qryFcertaTEMP.IsEmpty) then
  begin
    qtdprodpromocao := 0;
    qryTerminalBalcao.First;

    while not qryTerminalBalcao.EOF do
    begin
      if (qryTerminalBalcao.FieldValues['vrdsc'] > 0) then
        raise Exception.Create('Venda já possui Desconto');

      if (qryTerminalBalcao.FieldValues['CDPRO'] = codproduto) then
      begin
        if (qryTerminalBalcao.FieldValues['VRDSC']) > 0 then
          lblDescontoValor.Caption := FloatToStr(StrToFloat(lblDescontoValor.Caption) + (qryTerminalBalcao.FieldValues['VRDSC']));
        valdescapl := valdescapl + qryTerminalBalcao.FieldValues['VRDSC'];
      end;
      qryTerminalBalcao.next;
    end;

    if (valdescapl > 0) then
      raise exception.create('Já existem descontos lançados para ' + nomedesconto + ' nessa venda');

    if MessageDlg('Deseja confirmar desconto relativo ao ' + nomedesconto + '?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      if qryFcertaTEMP.FieldValues['vrdsc'] > 0 then
        raise Exception.Create('Venda já possue desconto');

      while not (qryFcertaTEMP.Eof) do
      begin
        codproduto := qryFcertaTEMP.FieldValues['cdpro'];
        qtdprodpromocao := qryFcertaTEMP.FieldValues['qtd'];

        if qtdprodpromocao > 2 then
          percdesc := 15
        else
          percdesc := 10;

        qryTerminalBalcao.First;

        valorproduto := qryFcertaTEMP.FieldValues['PRUNI'];
        valdesc := (valorproduto * percdesc) / 100;
        valdesctot := valdesctot + valdesc;

        for i := 1 to qtdprodpromocao do
        begin
          qrySelecionaDesconto.Close;
          qrySelecionaDesconto.sql.Clear;
          qrySelecionaDesconto.sql.Add('   select * ');
          qrySelecionaDesconto.sql.Add('     from fc32110 ');
          qrySelecionaDesconto.sql.Add('    where tpitm=' + quotedstr('V'));
          qrySelecionaDesconto.sql.Add('      and cdfil=' + trim(frmPrincipal.edtLoja.Text));
          qrySelecionaDesconto.sql.Add('      and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
          qrySelecionaDesconto.sql.Add('      and dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
          qrySelecionaDesconto.sql.Add('      and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
          qrySelecionaDesconto.sql.Add('      and cdpro in (' + inttostr(codproduto) + ')');
          qrySelecionaDesconto.sql.Add('      and vrliq >' + mudaponto(valdesc));
          qrySelecionaDesconto.sql.Add(' order by vrliq desc');
          qrySelecionaDesconto.Open;

          if qrySelecionaDesconto.IsEmpty then
            raise exception.Create('Erro ao lançar desconto ' + nomedesconto);

          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set pruniliq=(pruniliq-(' + mudaponto(valdesc) + ')), ');
          qryInsereDesconto.SQL.Add('        ptdsc=99.97 , ');
          qryInsereDesconto.SQL.Add('        tpdsc=' + quotedstr('3') + ' ,');
          qryInsereDesconto.SQL.Add('        vrcxa=(vrcxa-(' + mudaponto(valdesc) + ')), ');
          qryInsereDesconto.SQL.Add('        vrliq=(vrliq-(' + mudaponto(valdesc) + ')), ');
          qryInsereDesconto.SQL.Add('        vrdsc=vrdsc+(' + mudaponto(valdesc) + '),');
          qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + mudaponto(valdesc));
          qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
          qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
          qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
          qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
        end;
        qryFcertaTEMP.Next;
      end;

      qryFcertaTEMP.Close;
      qryFcertaTEMP.SQL.Clear;
      qryFcertaTEMP.SQL.Add(' select sum(vrliq) as VALOR ');
      qryFcertaTEMP.SQL.Add('   from fc32110 ');
      qryFcertaTEMP.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryFcertaTEMP.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryFcertaTEMP.SQL.Add('    and dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
      qryFcertaTEMP.SQL.Add('    and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryFcertaTEMP.Open;

      valortotal := qryFcertaTEMP.FieldValues['VALOR'];
      qryFcertaTEMP.Close;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('DescProgressivo') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ',');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      lblDescontoValor.Caption := floattostr(valdesctot);
      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end
  else
    showmessage('Não existem produtos de varejo iguais nessa compra');
end;


procedure TfrmPrincipal.DescontoProgressivoSabonte;
var
  valortotal, valdesc, valorunitdesc: double;
  qt1, percdesc: integer;
  msg: string;
begin

  lblDescontoValor.Caption := '0';
  qt1 := 0;

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add('   select a.cdpro as COD, a.quant, a.pruni ,a.vrtot, a.vrdsc, a.IDPROMO ');
  qryFcertaTEMP.SQL.Add('     from fc32110 a ');
  qryFcertaTEMP.SQL.Add('    where a.cdfil=' + edtLoja.Text);
  qryFcertaTEMP.SQL.Add('      and a.nrcpm=' + edtTerminalBalcao.Text);
  qryFcertaTEMP.SQL.Add('      and a.tpitm=' + quotedstr('V'));
  qryFcertaTEMP.SQL.Add('      and a.cdpro in ( 17455, 4666, 17454 ) ');
  qryFcertaTEMP.SQL.Add(' order by 3 ');
  qryFcertaTEMP.Open;

  valdesc := 0;

  while not qryFcertaTEMP.Eof do
  begin
    qt1 := qt1 + qryFcertaTEMP.FieldValues['quant'];

    if qryFcertaTEMP.FieldValues['IDPROMO'] = 0 then
      valdesc := valdesc + qryFcertaTEMP.FieldValues['vrdsc'];

    qryFcertaTEMP.Next;
  end;

  if valdesc > 0 then
    raise Exception.Create('Venda Já possui Desconto');

  if (qt1 = 1) then
  begin
    qryFcertaTEMP.Close;
    raise exception.create('Não existem produtos suficientes para Campanha Desconto Progressivo Sabonete, nesta venda. ');
  end;

  if qt1 > 2 then
    percdesc := 15
  else
    percdesc := 10;

  valdesc := 0;//zera valor de desconto para calcular o valor da campanha

  qryFcertaTEMP.First;
  while not qryFcertaTEMP.Eof do
  begin
    if (qryFcertaTEMP.FieldValues['IDPROMO'] > 0) then
      valdesc := valdesc + qryFcertaTEMP.FieldValues['vrdsc']
    else
      valdesc := valdesc + ((qryFcertaTEMP.FieldValues['PRUNI'] * qryFcertaTEMP.FieldValues['QUANT']) * (percdesc / 100));

    qryFcertaTEMP.Next;
  end;

  qryFcertaTEMP.Close;
  lblDescontoValor.Caption := TrocaVirgPPto(floattostr(valdesc));

  msg := 'Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo a campanha Desconto Progressivo Sabonete?' + #13 + inttostr(percdesc) + '% nos itens válidos';

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg(msg, mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.sql.Clear;
      qrySelecionaDesconto.sql.Add('    select a.IDPROMO , a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, a.TPDSC, ' );
      qrySelecionaDesconto.sql.Add('           a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, a.CDPRO, coalesce( b.vrtot, a.VRTOT) as VRTOT, ' );
      qrySelecionaDesconto.sql.Add('           a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ' );
      qrySelecionaDesconto.sql.Add('      from fc32110 a ' );
      qrySelecionaDesconto.sql.Add(' left join fc32200 b on ( ' );
      qrySelecionaDesconto.sql.Add('           a.cdfil=b.cdfil ' );
      qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ' );
      qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ' );
      qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ' );
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ' );
      qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ' );
      qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text) );
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text) );
      qrySelecionaDesconto.sql.Add('       and a.dtope>=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)) );
      qrySelecionaDesconto.sql.Add('       and a.tpitm=' + quotedstr('V') );
      qrySelecionaDesconto.sql.Add('       and a.cdpro  in ( 17455, 4666, 17454 ) ' );
      qrySelecionaDesconto.sql.Add('  order by a.PRUNILIQ' );

      qrySelecionaDesconto.Open;
      qrySelecionaDesconto.FetchAll;
      qrySelecionaDesconto.First;

      valdesc := 0;
      tpdescvar := '3';

      while not qrySelecionaDesconto.Eof do
      begin
        if (qrySelecionaDesconto.FieldValues['IDPROMO'] > 0) then
          desc2var := qrySelecionaDesconto.FieldValues['PTDSC']
        else
          desc2var := percdesc;

        valorunitdesc := ((qrySelecionaDesconto.FieldValues['PRUNI'] * qrySelecionaDesconto.FieldValues['QUANT']) * (desc2var / 100));

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
        qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
        qryInsereDesconto.SQL.Add('        pruniliq=PRUNI-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrtot-' + TrocaVirgPPto(floattostr(valorunitdesc)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;

        qrySelecionaDesconto.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope>=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('DescProgSabonete') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ',');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N') );
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text) );
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
      qrySelecionaDesconto.Close;
    end;
  end;
end;

procedure TfrmPrincipal.SemanaDoConsumidor;
var
  valortotal, valdesc, valorunitdesc: double;
  qtd, percdesc: integer;
  msg: string;
begin
  if (StrToDate(FormatDateTime('dd/mm/yyyy', now)) < strtodate('10/03/2025')) or
     (StrToDate(FormatDateTime('dd/mm/yyyy', now)) > strtodate('15/03/2025')) then
    Exception.Create('campanha disponível apenas para o período de  ( 10/03 a 15/03 ) ');

  lblDescontoValor.Caption := '0';
  qtd := 0;

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add('   select a.cdpro as COD, a.quant, a.pruni ,a.vrtot, a.vrdsc, a.IDPROMO ');
  qryFcertaTEMP.SQL.Add('     from fc32110 a ');
  qryFcertaTEMP.SQL.Add('    where a.cdfil=' + edtLoja.Text );
  qryFcertaTEMP.SQL.Add('      and a.nrcpm=' + edtTerminalBalcao.Text );
  qryFcertaTEMP.SQL.Add('      and a.tpitm=' + quotedstr('V') );
  qryFcertaTEMP.SQL.Add(' order by 3 ');
  qryFcertaTEMP.Open;
  valdesc := 0;

  while not qryFcertaTEMP.Eof do
  begin
    qtd := qtd + qryFcertaTEMP.FieldValues['quant'];

    if qryFcertaTEMP.FieldValues['IDPROMO'] = 0 then
      valdesc := valdesc + qryFcertaTEMP.FieldValues['vrdsc'];

    qryFcertaTEMP.Next;
  end;

  if valdesc > 0 then
    raise Exception.Create('Venda Já possui Desconto');

  if (qtd = 1) then
  begin
    qryFcertaTEMP.Close;
    raise exception.create('Não existem produtos suficientes para Campanha Semana do Consumidor, nesta venda. ');
  end;

  if qtd = 2 then
    percdesc := 10;
  if qtd = 3 then
    percdesc := 15;
  if qtd > 3 then
    percdesc := 20;

  valdesc := 0;//zera valor de desconto para calcular o valor da campanha

  qryFcertaTEMP.First;
  while not qryFcertaTEMP.Eof do
  begin
    if (qryFcertaTEMP.FieldValues['IDPROMO'] > 0) then
      valdesc := valdesc + qryFcertaTEMP.FieldValues['vrdsc']
    else
      valdesc := valdesc + ((qryFcertaTEMP.FieldValues['PRUNI'] * qryFcertaTEMP.FieldValues['QUANT']) * (percdesc / 100));

    qryFcertaTEMP.Next;
  end;

  qryFcertaTEMP.Close;
  lblDescontoValor.Caption := TrocaVirgPPto(floattostr(valdesc));

  msg := 'Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo a campanha Semana do Consumidor?';

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg(msg, mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.sql.Clear;
      qrySelecionaDesconto.sql.Add('    select a.IDPROMO , a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, ' );
      qrySelecionaDesconto.sql.Add('           a.PRUNI, a.PTDSC, a.TPDSC, a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, a.CDPRO, ' );
      qrySelecionaDesconto.sql.Add('           coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ' );
      qrySelecionaDesconto.sql.Add('      from fc32110 a ' );
      qrySelecionaDesconto.sql.Add(' left join fc32200 b on ( ' );
      qrySelecionaDesconto.sql.Add('           a.cdfil=b.cdfil ' );
      qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ' );
      qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ' );
      qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ' );
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ' );
      qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ' );
      qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text) );
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text) );
      qrySelecionaDesconto.sql.Add('       and a.dtope>=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)) );
      qrySelecionaDesconto.sql.Add('       and a.tpitm=' + quotedstr('V') );
      qrySelecionaDesconto.sql.Add('  order by a.PRUNILIQ' );
      qrySelecionaDesconto.Open;
      qrySelecionaDesconto.FetchAll;
      qrySelecionaDesconto.First;

      valdesc := 0;
      tpdescvar := '3';

      while not qrySelecionaDesconto.Eof do
      begin
        if (qrySelecionaDesconto.FieldValues['IDPROMO'] > 0) then
          desc2var := qrySelecionaDesconto.FieldValues['PTDSC']
        else
          desc2var := percdesc;

        valorunitdesc := ((qrySelecionaDesconto.FieldValues['PRUNI'] * qrySelecionaDesconto.FieldValues['QUANT']) * (desc2var / 100));

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
        qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
        qryInsereDesconto.SQL.Add('        pruniliq=PRUNI-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrtot-' + TrocaVirgPPto(floattostr(valorunitdesc)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.Commit;

        qrySelecionaDesconto.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text) );
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text) );
      qryInsereDesconto.SQL.Add('    and dtope>=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)) );
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('SemanaDoConsumidor') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N') );
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;


      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.SemanaDoCliente2;
var
  valortotal, valdesc, valorunitdesc: double;
  qtd, percdesc: integer;
  msg: string;
begin

  if (StrToDate(FormatDateTime('dd/mm/yyyy', now)) < strtodate('12/09/2025')) or (StrToDate(FormatDateTime('dd/mm/yyyy', now)) > strtodate('21/09/2025')) then
    Exception.Create('campanha disponível apenas para o período de  ( 12/09 a 21/09 ) ');

  lblDescontoValor.Caption := '0';
  qtd := 0;

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add('   select a.cdpro as COD, a.quant, a.pruni ,a.vrtot, a.vrdsc, a.IDPROMO ');
  qryFcertaTEMP.SQL.Add('     from fc32110 a ');
  qryFcertaTEMP.SQL.Add('    where a.cdfil=' + edtLoja.Text);
  qryFcertaTEMP.SQL.Add('      and a.nrcpm=' + edtTerminalBalcao.Text);
  qryFcertaTEMP.SQL.Add('      and a.tpitm=' + quotedstr('V'));
  qryFcertaTEMP.SQL.Add(' order by 3 ');
  qryFcertaTEMP.Open;

  valdesc := 0;

  while not qryFcertaTEMP.Eof do
  begin
    qtd := qtd + qryFcertaTEMP.FieldValues['quant'];
    if qryFcertaTEMP.FieldValues['IDPROMO'] = 0 then
      valdesc := valdesc + qryFcertaTEMP.FieldValues['vrdsc'];
    qryFcertaTEMP.Next;
  end;

  if valdesc > 0 then
    raise Exception.Create('Venda Já possui Desconto');

  if (qtd = 1) then
  begin
    qryFcertaTEMP.Close;
    raise exception.create('Não existem produtos suficientes para Campanha Semana do Cliente, nesta venda. ');
  end;

  if qtd = 2 then
    percdesc := 10;
  if qtd = 3 then
    percdesc := 15;
  if qtd >= 4 then
    percdesc := 20;

  valdesc := 0;//zera valor de desconto para calcular o valor da campanha

  qryFcertaTEMP.First;
  while not qryFcertaTEMP.Eof do
  begin
    valdesc := valdesc + ((qryFcertaTEMP.FieldValues['PRUNI'] * qryFcertaTEMP.FieldValues['QUANT']) * (percdesc / 100));
    qryFcertaTEMP.Next;
  end;

  qryFcertaTEMP.Close;
  lblDescontoValor.Caption := TrocaVirgPPto(floattostr(valdesc));

  msg := 'Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo a campanha Semana do Cliente ?';

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg(msg, mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.sql.Clear;
      qrySelecionaDesconto.sql.Add('    select a.IDPROMO , a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, ');
      qrySelecionaDesconto.sql.Add('           a.TPDSC, a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, a.CDPRO, ');
      qrySelecionaDesconto.sql.Add('           coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ');
      qrySelecionaDesconto.sql.Add('      from fc32110 a ');
      qrySelecionaDesconto.sql.Add(' left join fc32200 b on ( ');
      qrySelecionaDesconto.sql.Add('           a.cdfil=b.cdfil ');
      qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
      qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
      qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
      qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ');
      qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qrySelecionaDesconto.sql.Add('       and a.dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qrySelecionaDesconto.sql.Add('       and a.tpitm=' + quotedstr('V') + ' order by a.PRUNILIQ');
      qrySelecionaDesconto.Open;
      qrySelecionaDesconto.FetchAll;
      qrySelecionaDesconto.First;

      valdesc := 0;
      tpdescvar := '3';

      while not qrySelecionaDesconto.Eof do
      begin
        desc2var := percdesc;
        valorunitdesc := ((qrySelecionaDesconto.FieldValues['PRUNI'] * qrySelecionaDesconto.FieldValues['QUANT']) * (desc2var / 100));

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
        qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
        qryInsereDesconto.SQL.Add('        pruniliq=PRUNI-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrtot-' + TrocaVirgPPto(floattostr(valorunitdesc)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.Commit;

        qrySelecionaDesconto.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('SemanaDoCliente') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.SemanaEsquentaBlackFriday;
var
  valortotal, valdesc, valorunitdesc: double;
  qtd, percdesc: integer;
  msg: string;
begin
  if (StrToDate(FormatDateTime('dd/mm/yyyy', now)) < strtodate('27/10/2025')) or (StrToDate(FormatDateTime('dd/mm/yyyy', now)) > strtodate('31/10/2025')) then
    raise Exception.Create('campanha disponível apenas para o período de  ( 27/10 a 31/10 ) ');

  lblDescontoValor.Caption := '0';
  qtd := 0;

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add('   select a.cdpro as COD, a.quant, a.pruni ,a.vrtot, a.vrdsc, a.IDPROMO ');
  qryFcertaTEMP.SQL.Add('     from fc32110 a ');
  qryFcertaTEMP.SQL.Add('    where a.cdfil=' + edtLoja.Text);
  qryFcertaTEMP.SQL.Add('      and a.nrcpm=' + edtTerminalBalcao.Text);
  qryFcertaTEMP.SQL.Add('      and a.tpitm=' + quotedstr('V'));
  qryFcertaTEMP.SQL.Add(' order by 3 ');
  qryFcertaTEMP.Open;
  valdesc := 0;

  while not qryFcertaTEMP.Eof do
  begin
    qtd := qtd + qryFcertaTEMP.FieldValues['quant'];

    if qryFcertaTEMP.FieldValues['IDPROMO'] = 0 then
      valdesc := valdesc + qryFcertaTEMP.FieldValues['vrdsc'];

    qryFcertaTEMP.Next;
  end;

  if valdesc > 0 then
    raise Exception.Create('Venda Já possui Desconto');

  if (qtd = 1) then
  begin
    qryFcertaTEMP.Close;
    raise exception.create('Não existem produtos suficientes para Campanha Semana Esquenta Black Friday, nesta venda. ');
  end;

  if qtd = 2 then
    percdesc := 10;
  if qtd = 3 then
    percdesc := 15;
  if qtd >= 4 then
    percdesc := 20;

  valdesc := 0;//zera valor de desconto para calcular o valor da campanha

  qryFcertaTEMP.First;

  while not qryFcertaTEMP.Eof do
  begin
    valdesc := valdesc + ((qryFcertaTEMP.FieldValues['PRUNI'] * qryFcertaTEMP.FieldValues['QUANT']) * (percdesc / 100));
    qryFcertaTEMP.Next;
  end;

  qryFcertaTEMP.Close;
  lblDescontoValor.Caption := TrocaVirgPPto(floattostr(valdesc));

  msg := 'Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo a campanha Semana Esquenta Black Friday ?';

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg(msg, mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.sql.Clear;
      qrySelecionaDesconto.sql.Add('    select a.IDPROMO , a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, ');
      qrySelecionaDesconto.sql.Add('           a.PTDSC, a.TPDSC, a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, a.CDPRO, ');
      qrySelecionaDesconto.sql.Add('           coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ');
      qrySelecionaDesconto.sql.Add('      from fc32110 a ');
      qrySelecionaDesconto.sql.Add(' left join fc32200 b on ( ');
      qrySelecionaDesconto.sql.Add('           a.cdfil=b.cdfil ');
      qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
      qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
      qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
      qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ');
      qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qrySelecionaDesconto.sql.Add('       and a.dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qrySelecionaDesconto.sql.Add('       and a.tpitm=' + quotedstr('V'));
      qrySelecionaDesconto.sql.Add('  order by a.PRUNILIQ');
      qrySelecionaDesconto.Open;
      qrySelecionaDesconto.FetchAll;
      qrySelecionaDesconto.First;

      valdesc := 0;
      tpdescvar := '3';

      while not qrySelecionaDesconto.Eof do
      begin
        desc2var := percdesc;
        valorunitdesc := ((qrySelecionaDesconto.FieldValues['PRUNI'] * qrySelecionaDesconto.FieldValues['QUANT']) * (desc2var / 100));

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
        qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
        qryInsereDesconto.SQL.Add('        pruniliq=PRUNI-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
        qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrtot-' + TrocaVirgPPto(floattostr(valorunitdesc)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.Commit;

        qrySelecionaDesconto.Next;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('BlackFriday') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;


procedure TfrmPrincipal.CampanhaStickBolsaPraia;
begin

end;

procedure TfrmPrincipal.Carnaval2026;
begin

end;

procedure TfrmPrincipal.CampanhaCreatina2026;
begin

end;

procedure TfrmPrincipal.CampanhaPDRN;
var
  valortotal, valordescun, vrprod, vrtotal: double;
  qtdBrinde, codprod, qtdProdutos: integer;
begin
  lblDescontoValor.Caption := '0';

  qtdBrinde := 0;
  vrtotal := 0;
  qtdProdutos := 0;
  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if qryTerminalBalcao.FieldValues['tpitm'] = 'V' then
    begin
      if (qryTerminalBalcao.FieldValues['CDPRO'] = 20267) or
         (qryTerminalBalcao.FieldValues['CDPRO'] = 20268) or
         (qryTerminalBalcao.FieldValues['CDPRO'] = 19610) or
         (qryTerminalBalcao.FieldValues['CDPRO'] = 19613) or
         (qryTerminalBalcao.FieldValues['CDPRO'] = 19611) or
         (qryTerminalBalcao.FieldValues['CDPRO'] = 19612) or
         (qryTerminalBalcao.FieldValues['CDPRO'] = 19614) then   // Nécessaire Holográfica  e necessaires simples
      begin
        vrprod := qryTerminalBalcao.FieldValues['pruni'];
        codprod := qryTerminalBalcao.FieldValues['CDPRO'];
        qtdBrinde := qtdBrinde + qryTerminalBalcao.FieldValues['QUANT'];
      end
      else
      begin
        if (qryTerminalBalcao.FieldValues['CDPRO'] = 19649) then
          qtdProdutos := qtdProdutos + qryTerminalBalcao.FieldValues['QUANT'];
      end;
    end;
    qryTerminalBalcao.next;
  end;

  if (qtdBrinde <> qtdProdutos) then
    raise Exception.Create('Quantidade(s) de brinde(s) incorreta!');

  lblDescontoValor.Caption := TrocaVirgPPto(FloatToStr((vrprod * 1)));
  valordescun := (vrprod * 0.9975  {100% de desconto});

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg('Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo ao brinde Nécessaire Holográfica ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set ptdsc=' + TrocaVirgPPto(FloatToStr(99.75)) + ', ');
      qryInsereDesconto.SQL.Add('        pruniliq=(pruni)-(' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(quant*' + TrocaVirgPPto(FloatToStr(valordescun)) + '), ');
      qryInsereDesconto.SQL.Add('        vrdsc=(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')), ');
      qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRPIS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun))+ ')))*ALPIS)/100, ');
      qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + '))), ');
      qryInsereDesconto.SQL.Add('        VRCOFINS=((VRCXA-(quant*(' + TrocaVirgPPto(FloatToStr(valordescun)) + ')))*ALCOFINS)/100 ');
      qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
      qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.SQL.Add('    and cdpro in (' + IntToStr(codprod) + ')');
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
      qryInsereDesconto.SQL.Add('   from fc32110 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.Open;

      valortotal := qryInsereDesconto.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('CampanhaPDRN') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.ProgressivoPresentes;
var
  valortotal, valdesc, valorunitdesc: double;
  qtd, percdesc: integer;
  msg: string;
begin

  lblDescontoValor.Caption := '0';
  qtd := 0;

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add('   select a.cdpro as COD, a.quant, a.pruni ,a.vrtot, a.vrdsc, a.IDPROMO ');
  qryFcertaTEMP.SQL.Add('     from fc32110 a ');
  qryFcertaTEMP.SQL.Add('    where a.cdfil=' + edtLoja.Text );
  qryFcertaTEMP.SQL.Add('      and a.nrcpm=' + edtTerminalBalcao.Text);
  qryFcertaTEMP.SQL.Add('      and a.cdpro in ( 15618, 5901, 4667, 5900, 15612, 15613, 15615, 15617 ) ');
  qryFcertaTEMP.SQL.Add('      and a.tpitm=' + quotedstr('V'));
  qryFcertaTEMP.SQL.Add(' order by 3 ');
  qryFcertaTEMP.Open;

  valdesc := 0;

  while not qryFcertaTEMP.Eof do
  begin
    qtd := qtd + qryFcertaTEMP.FieldValues['quant'];
    if qryFcertaTEMP.FieldValues['IDPROMO'] = 0 then
      valdesc := valdesc + qryFcertaTEMP.FieldValues['vrdsc'];
    qryFcertaTEMP.Next;
  end;

  if valdesc > 0 then
    raise Exception.Create('Venda Já possui Desconto');

  if (qtd = 1) then
  begin
    qryFcertaTEMP.Close;
    raise exception.create('Não existem produtos suficientes para Campanha Progressivo Presentes, nesta venda. ');
  end;

  if qtd = 2 then
    percdesc := 10;
  if qtd = 3 then
    percdesc := 15;
  if qtd > 3 then
    percdesc := 15;

  valdesc := 0;//zera valor de desconto para calcular o valor da campanha

  qryFcertaTEMP.First;
  while not qryFcertaTEMP.Eof do
  begin
    if (qryFcertaTEMP.FieldValues['IDPROMO'] > 0) then
      valdesc := valdesc + qryFcertaTEMP.FieldValues['vrdsc']
    else
      valdesc := valdesc + ((qryFcertaTEMP.FieldValues['PRUNI'] * qryFcertaTEMP.FieldValues['QUANT']) * (percdesc / 100));

    qryFcertaTEMP.Next;
  end;

  qryFcertaTEMP.Close;
  lblDescontoValor.Caption := TrocaVirgPPto(floattostr(valdesc));

  msg := 'Deseja confirmar desconto de R$ ' + lblDescontoValor.Caption + ' relativo a campanha Progressivo Presentes ?';

  if (lblDescontoValor.Caption <> '0') then
  begin
    if MessageDlg(msg, mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin
      Desconto_Presentes(valortotal, InfoTela);
//    lblDescontoValor.Caption := TrocaVirgulaPorPonto(FloatToStr(valortotal));
      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
      qrySelecionaDesconto.Close;
    end;
  end;
end;

procedure TfrmPrincipal.DescontoFuncionarios;
var
  valortotal, valorunitdesc, vrcxa, vrDescVar, vrDescForm: double;
  i, qtdprodpromocao, qtdfinal: integer;
begin
  qtdprodpromocao := 0;
  lblDescontoValor.Caption := '0';
  vrDescVar := 0;
  vrDescForm := 0;

  qrySelecionaDesconto.Close;
  qrySelecionaDesconto.SQL.Clear;
  qrySelecionaDesconto.SQL.Add(' select count(*) as QTD ');
  qrySelecionaDesconto.SQL.Add('   from fc08000 ');
  qrySelecionaDesconto.SQL.Add('  where fc08000.nrcpf in ( select fc07000.nrcnpj ');
  qrySelecionaDesconto.SQL.Add('                             from fc07000 ');
  qrySelecionaDesconto.SQL.Add('                            where fc07000.cdcli=' + inttostr(qryTerminalBalcao.fieldvalues['cdcli']) + ')');
  qrySelecionaDesconto.Open;

  if qrySelecionaDesconto.FieldValues['QTD'] = 0 then
    raise Exception.Create('Cliente não está cadastrado como funcionário Pharmapele');

  qrySelecionaDesconto.Close;
  qrySelecionaDesconto.SQL.Clear;
  qrySelecionaDesconto.SQL.Add('   select fc31100.cdcli,fc31110.vrdsc as VRDSC1, ');
  qrySelecionaDesconto.SQL.Add('          fc31110.quant, ( select fc31200.vrdsc ');
  qrySelecionaDesconto.SQL.Add('                             from fc31200 ');
  qrySelecionaDesconto.SQL.Add('                            where fc31110.cdfil  = fc31200.cdfil ');
  qrySelecionaDesconto.SQL.Add('                              and fc31110.cdtml  = fc31200.cdtml ');
  qrySelecionaDesconto.SQL.Add('                              and fc31110.dtope  = fc31200.dtope ');
  qrySelecionaDesconto.SQL.Add('                              and fc31110.operid = fc31200.operid ');
  qrySelecionaDesconto.SQL.Add('                              and fc31110.nrcpm  = fc31200.nrcpm ');
  qrySelecionaDesconto.SQL.Add('                              and fc31110.itemid = fc31200.itemid ) as VRDSC2 ');
  qrySelecionaDesconto.SQL.Add('     from fc31110, ');
  qrySelecionaDesconto.SQL.Add('          fc31100, ');
  qrySelecionaDesconto.SQL.Add('          fc07000 ');
  qrySelecionaDesconto.SQL.Add('    where fc31100.cdfil=fc31110.cdfil ');
  qrySelecionaDesconto.SQL.Add('      and fc31100.cdtml=fc31110.cdtml ');
  qrySelecionaDesconto.SQL.Add('      and fc31100.dtope=fc31110.dtope ');
  qrySelecionaDesconto.SQL.Add('      and fc31100.operid=fc31110.operid ');
  qrySelecionaDesconto.SQL.Add('      and fc31100.nrcpm=fc31110.nrcpm ');
  qrySelecionaDesconto.SQL.Add('      and fc07000.cdcli=fc31100.cdcli ');
  qrySelecionaDesconto.SQL.Add('      and fc31100.useridaut = ' + quotedstr('privilegefunc'));
  qrySelecionaDesconto.SQL.Add('      and fc07000.nrcnpj in (select fc08000.nrcpf ');
  qrySelecionaDesconto.SQL.Add('                               from fc08000 ');
  qrySelecionaDesconto.SQL.Add('                              where fc08000.nrcpf is not null) ');
  qrySelecionaDesconto.SQL.Add('      and fc31110.dtope between ' + quotedstr(FormatDateTime('01.mm.yy', now)));
  qrySelecionaDesconto.SQL.Add('      and current_date ');
  qrySelecionaDesconto.SQL.Add('      and fc31100.cdcli=' + inttostr(qryTerminalBalcao.fieldvalues['cdcli']));
  qrySelecionaDesconto.SQL.Add(' order by 1');
  qrySelecionaDesconto.Open;

  while not qrySelecionaDesconto.EOF do
  begin
    if (qrySelecionaDesconto.FieldValues['VRDSC1'] > 0) or (qrySelecionaDesconto.FieldValues['VRDSC2'] > 0) then
      qtdprodpromocao := qtdprodpromocao + qrySelecionaDesconto.FieldValues['quant'];
    qrySelecionaDesconto.next;
  end;

  if (qtdprodpromocao >= MAXPRODFUNC) then
    raise exception.create('Funcionário já usou seu desconto em 4 itens no mês')
  else
    ShowMessage('Total de itens já adquiridos com desconto no mês :' + inttostr(qtdprodpromocao) + #13 + ' total de itens com desconto ainda disponíveis :' + inttostr(4 - qtdprodpromocao));

  qtdfinal := qtdprodpromocao;
  vrDescVar := 0;
  vrDescForm := 0;

  qryTerminalBalcao.First;
  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['VRDSC']) > 0 then
      lblDescontoValor.Caption := FloatToStr(StrToFloat(lblDescontoValor.Caption) + (qryTerminalBalcao.FieldValues['VRDSC']));

    if qryTerminalBalcao.FieldValues['tpitm'] = 'R' then
    begin
      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.SQL.Clear;
      qrySelecionaDesconto.SQL.Add(' select VRDSC ');
      qrySelecionaDesconto.SQL.Add('   from fc32200 ');
      qrySelecionaDesconto.SQL.Add('  where fc32200.cdfil  = ' + inttostr(qryTerminalBalcao.FieldValues['cdfil']));
      qrySelecionaDesconto.SQL.Add('    and fc32200.cdtml  = ' + quotedstr(qryTerminalBalcao.FieldValues['cdtml']));
      qrySelecionaDesconto.SQL.Add('    and fc32200.dtope  = ' + quotedstr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qrySelecionaDesconto.SQL.Add('    and fc32200.operid = ' + inttostr(qryTerminalBalcao.FieldValues['operid']));
      qrySelecionaDesconto.SQL.Add('    and fc32200.nrcpm  = ' + inttostr(qryTerminalBalcao.FieldValues['nrcpm']));
      qrySelecionaDesconto.SQL.Add('    and fc32200.itemid = ' + inttostr(qryTerminalBalcao.FieldValues['itemid']));
      qrySelecionaDesconto.Open;

      if not (qrySelecionaDesconto.IsEmpty) then
        if (qrySelecionaDesconto.FieldValues['VRDSC']) > 0 then
          lblDescontoValor.Caption := FloatToStr(StrToFloat(lblDescontoValor.Caption) + (qryTerminalBalcao.FieldValues['VRDSC']));
    end;

    if (qryTerminalBalcao.FieldValues['VRDSC'] > 0) and (qryTerminalBalcao.FieldValues['tpitm'] = 'R') then
      vrDescForm := vrDescForm + qryTerminalBalcao.FieldValues['VRDSC'];
    if (qryTerminalBalcao.FieldValues['VRDSC'] > 0) and (qryTerminalBalcao.FieldValues['tpitm'] = 'V') then
      vrDescVar := vrDescVar + qryTerminalBalcao.FieldValues['VRDSC'];

    qryTerminalBalcao.next;
  end;

  qrySelecionaDesconto.Close;

  if (desctipo = 'R') and (vrDescForm > 0) then
    raise exception.create('Já existe desconto lançado em Fórmula');
  if (desctipo = 'V') and (vrDescVar > 0) then
    raise exception.create('Já existe desconto lançado em Varejo');

  qtdprodpromocao := 4 - qtdprodpromocao; // verificar quantos itens da compra ainda podem receber 20% de desconto

  if MessageDlg('Deseja confirmar desconto de 20% do funcionário?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
  begin
    desc1form := StrToFloat(lblPercForm.Caption);
    desc2var := StrToFloat(lblPercVar.Caption);

    qrySelecionaDesconto.Close;
    qrySelecionaDesconto.sql.Clear;
    qrySelecionaDesconto.sql.Add('    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, ');
    qrySelecionaDesconto.sql.Add('           a.PTDSC, a.TPDSC, a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, ');
    qrySelecionaDesconto.sql.Add('           coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ');
    qrySelecionaDesconto.sql.Add('      from fc32110 a ');
    qrySelecionaDesconto.sql.Add(' left join fc32200 b on ( ');
    qrySelecionaDesconto.sql.Add('           a.cdfil=b.cdfil ');
    qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
    qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
    qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
    qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
    qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ');
    qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qrySelecionaDesconto.sql.Add('       and a.dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qrySelecionaDesconto.sql.Add('       and a.tpitm=' + quotedstr(desctipo));
    qrySelecionaDesconto.sql.Add('  order by a.VRTOT DESC');
    qrySelecionaDesconto.Open;
    qrySelecionaDesconto.FetchAll;
    qrySelecionaDesconto.First;

    for i := 1 to qtdprodpromocao do
    begin
      if qrySelecionaDesconto.FieldValues['TPITM'] = 'R' then
        valorunitdesc := (qrySelecionaDesconto.FieldValues['VRTOT'] * desc1form) / 100
      else
        valorunitdesc := (qrySelecionaDesconto.FieldValues['VRTOT'] * desc2var) / 100;

      valorunitdesc := RoundTo(valorunitdesc, -2);

      if qrySelecionaDesconto.FieldValues['TPITM'] = 'R' then
      begin
        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32200 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescform) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq= vrtot+vrtxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrsdo=vrtot+vrtxa-vrrcb-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        useridaut=' + quotedstr('privilegefunc'));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;

        if qrySelecionaDesconto.FieldValues['tppag'] = '1' then
        begin
          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32200 ');
          qryInsereDesconto.SQL.Add('    set vrcxa = vrtot+vrtxa-' + TrocaVirgPPto(floattostr(valorunitdesc)));
          qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
          qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
          qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
          qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
        end
        else
        begin
          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32200 ');
          qryInsereDesconto.SQL.Add('    set vrcxa= vrrcb ');
          qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
          qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
          qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
          qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
        end;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;

      if qrySelecionaDesconto.FieldValues['TPITM'] = 'R' then
      begin

        qryInsereDesconto.SQL.Add(' select vrcxa ');
        qryInsereDesconto.SQL.Add('   from fc32200 ');
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.Open;

        vrcxa := qryInsereDesconto.FieldValues['VRCXA'];

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescform) + ', ');
        qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
        qryInsereDesconto.SQL.Add('        pruni=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
        qryInsereDesconto.SQL.Add('        pruniliq=' + TrocaVirgPPto(floattostr(vrcxa)) + '/QUANT, ');
        qryInsereDesconto.SQL.Add('        vrcxa=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=' + TrocaVirgPPto(floattostr(vrcxa)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));

      end
      else
      begin
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescvar) + ', ');
        qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
        qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
        qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
      end;

      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qtdfinal := qtdfinal + qrySelecionaDesconto.FieldValues['quant'];
      qrySelecionaDesconto.Next;
      if qrySelecionaDesconto.Eof then
        break;
    end;

    qrySelecionaDesconto.First;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
    qryInsereDesconto.SQL.Add('   from fc32110 ');
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.Open;

    valortotal := qryInsereDesconto.FieldValues['VALOR'];

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update fc32100 ');
    qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('privilegefunc') + ', ');
    qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.CommitRetaining;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update totvsconf ');
    qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
    qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.Commit;

    showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    qrySelecionaDesconto.Close;

    showmessage('QTD de itens adquiridos com desconto pelo funcionário no mês : ' + inttostr(qtdfinal) + #13 + ' QTD ainda disponível : ' + inttostr(4 - qtdfinal));
  end;
end;

procedure TfrmPrincipal.DescontoFranquias;
var
  valortotal, valorunitdesc, vrcxa, percvarf, percformf: double;
  i: integer;
  cpffranquiado: string;
begin
  lblDescontoValor.Caption := '0';

  qryTerminalBalcao.First;

  qrySelecionaDesconto.Close;
  qrySelecionaDesconto.SQL.Clear;
  qrySelecionaDesconto.SQL.Add('   Select count(fc07000.nrcnpj) as QTD, fc07000.nrcnpj ');
  qrySelecionaDesconto.SQL.Add('     from fc07000 ');
  qrySelecionaDesconto.SQL.Add('    where fc07000.cdcli=' + inttostr(qryTerminalBalcao.fieldvalues['cdcli']));
  qrySelecionaDesconto.SQL.Add(' group by 2 ');
  qrySelecionaDesconto.Open;

  if not (qrySelecionaDesconto.IsEmpty) then
    cpffranquiado := qrySelecionaDesconto.FieldValues['nrcnpj']
  else
    raise Exception.Create('Cliente não está cadastrado como franqueado Pharmapele');

  qryTerminalBalcao.First;

  while not qryTerminalBalcao.EOF do
  begin
    if (qryTerminalBalcao.FieldValues['VRDSC']) > 0 then
      lblDescontoValor.Caption := FloatToStr(StrToFloat(lblDescontoValor.Caption) + (qryTerminalBalcao.FieldValues['VRDSC']));

    if qryTerminalBalcao.FieldValues['tpitm'] = 'R' then
    begin
      qrySelecionaDesconto.Close;
      qrySelecionaDesconto.SQL.Clear;
      qrySelecionaDesconto.SQL.Add(' select VRDSC ');
      qrySelecionaDesconto.SQL.Add('   from fc32200 ');
      qrySelecionaDesconto.SQL.Add('  where fc32200.cdfil  = ' + IntToStr(qryTerminalBalcao.FieldValues['cdfil']));
      qrySelecionaDesconto.SQL.Add('    and fc32200.cdtml  = ' + QuotedStr(qryTerminalBalcao.FieldValues['cdtml']));
      qrySelecionaDesconto.SQL.Add('    and fc32200.dtope  = ' + QuotedStr(FormatDateTime('dd.mm.yyyy', qryTerminalBalcao.FieldValues['dtope'])));
      qrySelecionaDesconto.SQL.Add('    and fc32200.operid = ' + IntToStr(qryTerminalBalcao.FieldValues['operid']));
      qrySelecionaDesconto.SQL.Add('    and fc32200.nrcpm  = ' + IntToStr(qryTerminalBalcao.FieldValues['nrcpm']));
      qrySelecionaDesconto.SQL.Add('    and fc32200.itemid = ' + IntToStr(qryTerminalBalcao.FieldValues['itemid']));
      qrySelecionaDesconto.Open;

      if not (qrySelecionaDesconto.IsEmpty) then
        if (qrySelecionaDesconto.FieldValues['VRDSC']) > 0 then
          lblDescontoValor.Caption := FloatToStr(StrToFloat(lblDescontoValor.Caption) + (qryTerminalBalcao.FieldValues['VRDSC']));
    end;
    next;
  end;

  if (lblDescontoValor.Caption <> '0') then
    raise exception.create('Já existem descontos lançados nessa venda');

  if MessageDlg('Deseja confirmar desconto de ' + floattostr(percformf) + '% do franqueado?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
  begin
    Desconto_Franquia( InfoTela );
    showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
  end;
end;

procedure TfrmPrincipal.DescontoCortesiaAntigo;
var
  valortotal, valorunitdesc, vrcortesia, vrcortrest, vrcxa: double;
  codsol, tbalcao: string;
begin

  qrySelecionaDesconto.Close;
  qrySelecionaDesconto.SQL.Clear;
  qrySelecionaDesconto.SQL.Add(' select count(*) as QTD ');
  qrySelecionaDesconto.SQL.Add('   from fc08000 ');
  qrySelecionaDesconto.SQL.Add('  where fc08000.nrcpf in ( select fc07000.nrcnpj ');
  qrySelecionaDesconto.SQL.Add('                             from fc07000 ');
  qrySelecionaDesconto.SQL.Add('                            where fc07000.cdcli=' + inttostr(qryTerminalBalcao.fieldvalues['cdcli']) + ')');
  qrySelecionaDesconto.Open;

  if qrySelecionaDesconto.FieldValues['QTD'] = 0 then
    raise Exception.Create('Cliente não está cadastrado como funcionário Pharmapele');

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add(' select * ');
  qryFcertaTEMP.SQL.Add('   from fc32200 ');
  qryFcertaTEMP.SQL.Add('  where fc32200.nrcpm=' + trim(edtTerminalBalcao.Text));
  qryFcertaTEMP.SQL.Add('    and fc32200.cdfil=' + trim(edtLoja.Text));
  qryFcertaTEMP.SQL.Add('    and fc32200.dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
  qryFcertaTEMP.SQL.Add('    and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
  qryFcertaTEMP.Open;

  if qryFcertaTEMP.IsEmpty then
    raise Exception.Create('Não existem receitas nessa venda para lançamento de cortesia');

  qryPrivilegeTEMP.Close;
  qryPrivilegeTEMP.SQL.Clear;
  qryPrivilegeTEMP.SQL.Add(' select * ');
  qryPrivilegeTEMP.SQL.Add('   from soliccortesia a ');
  qryPrivilegeTEMP.SQL.Add('  where a.nrrqur in (');

  while not (qryFcertaTEMP.Eof) do
  begin
    if length(trim(qryPrivilegeTEMP.Text)) > 49 then
      qryPrivilegeTEMP.SQL.Add(','); //se sql já foi modificado
    qryPrivilegeTEMP.SQL.Add(inttostr(qryFcertaTEMP.FieldValues['nrrqu']));
    qryFcertaTEMP.Next;
  end;

  qryPrivilegeTEMP.SQL.Add(',0)');

  qryPrivilegeTEMP.SQL.Add(' and cancelado=0 and indapr=1 ');
  qryPrivilegeTEMP.Open;

  if qryPrivilegeTEMP.IsEmpty then
    raise Exception.Create('Não existe cortesia aprovada nessa venda');

  vrcortesia := 0;

  codsol := '';
  while not (qryPrivilegeTEMP.eof) do
  begin
    vrcortesia := vrcortesia + qryPrivilegeTEMP.FieldValues['VALORCORT'];
    qryPrivilegeTEMP.Next;
    if codsol <> '' then
      codsol := codsol + ',';
    codsol := codsol + inttostr(qryPrivilegeTEMP.FieldValues['codsol']);
  end;

  lblDesconto.Font.Color := clBlue;
  lblFinal.Caption := floattostrf(vrtot - vrcortesia, ffcurrency, 15, 2);
  lblFinal.Font.Color := clBlue;

  if MessageDlg('Deseja confirmar desconto cortesia?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
  begin

    tpdescform := 'R';

    desc1form := StrToFloat(lblPercForm.Caption);
    desc2var := StrToFloat(lblPercVar.Caption);

    qrySelecionaDesconto.Close;
    qrySelecionaDesconto.sql.Clear;
    qrySelecionaDesconto.sql.Add('   select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, ');
    qrySelecionaDesconto.sql.Add('          a.PTDSC, a.TPDSC, a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, ');
    qrySelecionaDesconto.sql.Add('          coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ');
    qrySelecionaDesconto.sql.Add('     from fc32110 a ');
    qrySelecionaDesconto.sql.Add('left join fc32200 b on ( ');
    qrySelecionaDesconto.sql.Add('          a.cdfil=b.cdfil ');
    qrySelecionaDesconto.sql.Add('      and a.cdtml=b.cdtml ');
    qrySelecionaDesconto.sql.Add('      and a.dtope = b.dtope ');
    qrySelecionaDesconto.sql.Add('      and a.operid=b.operid ');
    qrySelecionaDesconto.sql.Add('      and a.nrcpm=b.nrcpm ');
    qrySelecionaDesconto.sql.Add('      and a.itemid=b.itemid ) ');
    qrySelecionaDesconto.sql.Add('    where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qrySelecionaDesconto.sql.Add('      and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qrySelecionaDesconto.sql.Add('      and a.dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
    qrySelecionaDesconto.sql.Add('      and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qrySelecionaDesconto.sql.Add('      and a.tpitm=' + quotedstr(desctipo));
    qrySelecionaDesconto.sql.Add(' order by a.VRTOT DESC');
    qrySelecionaDesconto.Open;
    qrySelecionaDesconto.FetchAll;
    qrySelecionaDesconto.First;

    vrcortrest := vrcortesia;

    while not qrySelecionaDesconto.eof do
    begin

      if (qrySelecionaDesconto.FieldValues['VRTOT'] + qrySelecionaDesconto.FieldValues['VRTXA']) > (vrcortrest + 0.10) then
        valorunitdesc := vrcortrest
      else
        valorunitdesc := qrySelecionaDesconto.FieldValues['VRTOT'] + qrySelecionaDesconto.FieldValues['VRTXA'] - 0.1;

      valorunitdesc := RoundTo(valorunitdesc, -2);

      if (vrcortrest > valorunitdesc) then
        vrcortrest := valorunitdesc - 0.10
      else if (vrcortrest = valorunitdesc) then
        vrcortrest := vrcortrest - 0.10
      else
        vrcortrest := vrcortrest - valorunitdesc;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32200 ');
      qryInsereDesconto.SQL.Add('    set vrcxa=vrtot-' + TrocaVirgPPto(floattostr(vrcortesia)) + ', ');
      qryInsereDesconto.SQL.Add('        tpdsc=' + quotedstr(tpdescform) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq= vrtot+vrtxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
      qryInsereDesconto.SQL.Add('        vrsdo=vrtot+vrtxa-vrrcb-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
      qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
      qryInsereDesconto.SQL.Add('        useridaut=' + quotedstr(USUARIO_PRIVILEGE_LOJA));
      qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
      qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
      qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
      qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
      qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      if qrySelecionaDesconto.FieldValues['TPITM'] = 'R' then
      begin
        qryInsereDesconto.SQL.Add(' select vrcxa ');
        qryInsereDesconto.SQL.Add('   from fc32200 ');
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
        qryInsereDesconto.SQL.Add('    and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.Open;

        vrcxa := qryInsereDesconto.FieldValues['VRCXA'];

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescform) + ', ');
        qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
        qryInsereDesconto.SQL.Add('        pruni=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
        qryInsereDesconto.SQL.Add('        pruniliq=' + TrocaVirgPPto(floattostr(vrcxa)) + '/QUANT, ');
        qryInsereDesconto.SQL.Add('        vrcxa=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=' + TrocaVirgPPto(floattostr(vrcxa)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
      end
      else
      begin
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescform) + ', ');
        qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ', ');
        qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
        qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
      end;

      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;
      qryInsereDesconto.Close;

      qrySelecionaDesconto.Next;
    end;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
    qryInsereDesconto.SQL.Add('   from fc32110 ');
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
    qryInsereDesconto.SQL.Add('    and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.Open;

    valortotal := qryInsereDesconto.FieldValues['VALOR'];

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update fc32100 ');
    qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('privcortesia') + ', ');
    qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.CommitRetaining;

    qryPrivilegeTEMP.Close;
    qryPrivilegeTEMP.SQL.Clear;
    qryPrivilegeTEMP.SQL.Add(' update soliccortesia ');
    qryPrivilegeTEMP.SQL.Add('    set indusd=1, ');
    qryPrivilegeTEMP.SQL.Add('        dtusd=' + quotedstr(FormatDateTime('dd.mm.yyyy', now)) + ',');
    qryPrivilegeTEMP.SQL.Add('        hrusd=' + quotedstr(FormatDateTime('hh:nn:ss', now)));
    qryPrivilegeTEMP.SQL.Add('  where codsol in (' + codsol + ')');
    qryPrivilegeTEMP.ExecSQL;
    qryPrivilegeTEMP.Transaction.CommitRetaining;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update totvsconf ');
    qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
    qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.Commit;

    showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
  end;
end;

procedure TfrmPrincipal.DescontoCortesia;
var
  valortotal, valorunitdesc, vrcortesia, vrcortrest, vrcxa: double;
  codsol, tbalcao: string;
begin
  qrySelecionaDesconto.Close;
  qrySelecionaDesconto.SQL.Clear;
  qrySelecionaDesconto.SQL.Add(' select count(*) as QTD ');
  qrySelecionaDesconto.SQL.Add('   from fc08000 ');
  qrySelecionaDesconto.SQL.Add('  where fc08000.nrcpf in ( select fc07000.nrcnpj ');
  qrySelecionaDesconto.SQL.Add('                             from fc07000 ');
  qrySelecionaDesconto.SQL.Add('                            where fc07000.cdcli=' + inttostr(qryTerminalBalcao.fieldvalues['cdcli']) + ')');
  qrySelecionaDesconto.Open;

  if qrySelecionaDesconto.FieldValues['QTD'] = 0 then
    raise Exception.Create('Cliente não está cadastrado como funcionário Pharmapele');

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add(' select * ');
  qryFcertaTEMP.SQL.Add('   from fc32200 ');
  qryFcertaTEMP.SQL.Add('  where fc32200.nrcpm=' + trim(edtTerminalBalcao.Text));
  qryFcertaTEMP.SQL.Add('    and fc32200.cdfil=' + trim(edtLoja.Text));
  qryFcertaTEMP.SQL.Add('    and fc32200.dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
  qryFcertaTEMP.SQL.Add('    and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
  qryFcertaTEMP.Open;

  if qryFcertaTEMP.IsEmpty then
    raise Exception.Create('Não existem receitas nessa venda para lançamento de cortesia');

  qryPrivilegeTEMP.Close;
  qryPrivilegeTEMP.SQL.Clear;
  qryPrivilegeTEMP.SQL.Add(' select * from soliccortesia a where a.nrrqur in (');

  while not (qryFcertaTEMP.Eof) do
  begin
    if length(trim(qryPrivilegeTEMP.Text)) > 49 then
      qryPrivilegeTEMP.SQL.Add(','); //se sql já foi modificado
    qryPrivilegeTEMP.SQL.Add(inttostr(qryFcertaTEMP.FieldValues['nrrqu']));
    qryFcertaTEMP.Next;
  end;
  qryPrivilegeTEMP.SQL.Add(',0)');
  qryPrivilegeTEMP.SQL.Add(' and cancelado=0 and indapr=1 and a.CDFILR = ' + trim(edtLoja.Text));
  qryPrivilegeTEMP.Open;

  if qryPrivilegeTEMP.IsEmpty then
    raise Exception.Create('Não existe cortesia aprovada nessa venda');

  vrcortesia := 0;

  codsol := '';
  while not (qryPrivilegeTEMP.eof) do
  begin
    vrcortesia := vrcortesia + qryPrivilegeTEMP.FieldValues['VALORCORT'];
    qryPrivilegeTEMP.Next;
    if codsol <> '' then
      codsol := codsol + ',';
    codsol := codsol + inttostr(qryPrivilegeTEMP.FieldValues['codsol']);
  end;

  lblDesconto.Font.Color := clBlue;
  lblFinal.Caption := floattostrf(vrtot - vrcortesia, ffcurrency, 15, 2);
  lblFinal.Font.Color := clBlue;

  if MessageDlg('Deseja confirmar desconto cortesia?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
  begin
    tpdescform := 'R';

    qrySelecionaDesconto.Close;
    qrySelecionaDesconto.sql.Clear;
    qrySelecionaDesconto.sql.Add('    select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.CDPRO, a.QUANT, a.PRUNI, ');
    qrySelecionaDesconto.sql.Add('           a.PTDSC, a.TPDSC, a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, ');
    qrySelecionaDesconto.sql.Add('           coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ');
    qrySelecionaDesconto.sql.Add('      from fc32110 a ');
    qrySelecionaDesconto.sql.Add(' left join fc32200 b on ( ');
    qrySelecionaDesconto.sql.Add('           a.cdfil=b.cdfil ');
    qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
    qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
    qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
    qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
    qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ');
    qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qrySelecionaDesconto.sql.Add('       and a.dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
    qrySelecionaDesconto.sql.Add('       and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qrySelecionaDesconto.sql.Add('       and a.tpitm=' + quotedstr(desctipo));
    qrySelecionaDesconto.sql.Add('  order by a.VRTOT DESC');
    qrySelecionaDesconto.Open;
    qrySelecionaDesconto.FetchAll;
    qrySelecionaDesconto.First;

    vrcortrest := vrcortesia;
    qrySelecionaDesconto.First;
    while not qrySelecionaDesconto.eof do
    begin
      qryPrivilegeTEMP.Close;
      qryPrivilegeTEMP.SQL.Clear;
      qryPrivilegeTEMP.SQL.Add(' select * ');
      qryPrivilegeTEMP.SQL.Add('   from soliccortesia a ');
      qryPrivilegeTEMP.SQL.Add('  where a.cdfilr=:pCDFilr and  a.nrrqur =:pNRrqur ');
      qryPrivilegeTEMP.Params[0].Value := qrySelecionaDesconto.FieldValues['cdfilr'];
      qryPrivilegeTEMP.Params[1].Value := qrySelecionaDesconto.FieldValues['cdpro'];
      qryPrivilegeTEMP.Open;

      if not qryPrivilegeTEMP.IsEmpty then
        valorunitdesc := qryPrivilegeTEMP.FieldValues['VALORCORT'];

      if valorunitdesc > 0 then
      begin

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32200 ');
        qryInsereDesconto.SQL.Add('    set vrcxa=vrtot-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        tpdsc=' + quotedstr(tpdescform) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq= vrtot+vrtxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrsdo=vrtot+vrtxa-vrrcb-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
        qryInsereDesconto.SQL.Add('        useridaut=' + quotedstr(USUARIO_PRIVILEGE_LOJA));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' select vrcxa ');
        qryInsereDesconto.SQL.Add('   from fc32200 ');
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
        qryInsereDesconto.SQL.Add('    and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.Open;

        vrcxa := qryInsereDesconto.FieldValues['VRCXA'];

        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32110 ');
        qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescform) + ', ');
        qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
        qryInsereDesconto.SQL.Add('        pruni=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
        qryInsereDesconto.SQL.Add('        pruniliq=' + TrocaVirgPPto(floattostr(vrcxa)) + '/QUANT, ');
        qryInsereDesconto.SQL.Add('        vrcxa=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
        qryInsereDesconto.SQL.Add('        vrliq=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
        qryInsereDesconto.SQL.Add('        BCICM=' + TrocaVirgPPto(floattostr(vrcxa)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.Commit;
      end;
      qrySelecionaDesconto.Next;
    end;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
    qryInsereDesconto.SQL.Add('   from fc32110 ');
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
    qryInsereDesconto.SQL.Add('    and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.Open;

    valortotal := qryInsereDesconto.FieldValues['VALOR'];

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update fc32100 ');
    qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('privcortesia') + ', ');
    qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.Commit;

    qryPrivilegeTEMP.Close;
    qryPrivilegeTEMP.SQL.Clear;
    qryPrivilegeTEMP.SQL.Add(' update soliccortesia ');
    qryPrivilegeTEMP.SQL.Add('    set indusd=1, ');
    qryPrivilegeTEMP.SQL.Add('        dtusd=' + quotedstr(FormatDateTime('dd.mm.yyyy', now)) + ',');
    qryPrivilegeTEMP.SQL.Add('        hrusd=' + quotedstr(FormatDateTime('hh:nn:ss', now)));
    qryPrivilegeTEMP.SQL.Add('  where codsol in (' + codsol + ')');
    qryPrivilegeTEMP.ExecSQL;
    qryPrivilegeTEMP.Transaction.CommitRetaining;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update totvsconf ');
    qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
    qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.Commit;

    showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
  end;
end;

procedure TfrmPrincipal.DescontoMedico;
var
  valortotal, valortabela, valortabelaqt, valordescaplic, volume, valorunitdesc: double;
  qtform, qtcpm: integer;
  codformula: string;
  achou, achoumed: boolean;
begin

  qrySelecionaDesconto.Close;

  if MessageDlg('Deseja confirmar desconto ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
  begin
    desc1form := StrToFloat(lblPercForm.Caption);
    desc2var := StrToFloat(lblPercVar.Caption);

    qrySelecionaDesconto.Close;
    qrySelecionaDesconto.sql.Clear;
    qrySelecionaDesconto.sql.Add('   select * ');
    qrySelecionaDesconto.sql.Add('     from fc32110 ');
    qrySelecionaDesconto.sql.Add('    where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qrySelecionaDesconto.sql.Add('      and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qrySelecionaDesconto.sql.Add('      and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
    qrySelecionaDesconto.sql.Add('      and TPITM=' + quotedstr(desctipo));
    qrySelecionaDesconto.sql.Add(' order by VRTOT DESC');
    qrySelecionaDesconto.Open;

    if qrySelecionaDesconto.IsEmpty then
      if desctipo = 'V' then
        raise exception.Create('Não há varejos sem desconto nesse terminal balcão')
      else
        raise exception.Create('Não há receitas sem desconto nesse terminal balcão');

    if desctipo = 'V' then
    begin
      if MessageDlg('Deseja confirmar desconto ?',mtconfirmation,[mbYes,MbNo],0)=mryes then
      begin
        try
          Desconto_Loja(InfoTela);
          showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
        except
          on e: Exception do
          begin
            Application.MessageBox(PWideChar(e.message), 'Privilege', MB_OK + MB_ICONSTOP + MB_DEFBUTTON2);
          end;
        end;
      end; //uDesconto
    end
    else
    begin
      qrySelecionaDesconto.FetchAll;
      qrySelecionaDesconto.First;
      achou := false;
      achoumed := false;

      while not qrySelecionaDesconto.eof do
      begin
        qryFcertaTEMP.Close;
        qryFcertaTEMP.SQL.Clear;
        qryFcertaTEMP.SQL.Add(' select fc12100.nrcrm, fc12100.volume ');
        qryFcertaTEMP.SQL.Add('   from fc12100 ');
        qryFcertaTEMP.SQL.Add('  where fc12100.cdfil=:cod1 ');
        qryFcertaTEMP.SQL.Add('    and fc12100.nrrqu=:cod2 ');
        qryFcertaTEMP.SQL.Add('    and fc12100.serier=:cod4 ');

        qryFcertaTEMP.Params[0].Value := qrySelecionaDesconto.FieldValues['cdfilr'];
        qryFcertaTEMP.Params[1].Value := qrySelecionaDesconto.FieldValues['cdpro'];
        qryFcertaTEMP.Params[2].Value := '0';

        qryFcertaTEMP.Open;

        if qryFcertaTEMP.FieldValues['NRCRM'] = CRMDesc then
        begin
          achoumed := true;
          volume := qryFcertaTEMP.FieldValues['VOLUME'];

          qryFcertaTEMP.Close;
          qryFcertaTEMP.SQL.Clear;
          qryFcertaTEMP.SQL.Add('  select fc12110.cdfil,fc12110.nrrqu,fc12110.serier,fc12110.cdprin,fc12110.descr,fc12110.quant,fc12110.unida,fc12110.vrcmp,fc12110.porta, ');
          qryFcertaTEMP.SQL.Add('         fc12110.tpcmp,fc12110.itemid from fc12110 ');
          qryFcertaTEMP.SQL.Add('    where (( fc12110.tpcmp=' + quotedstr('C') + ')  or  ( fc12110.tpcmp=' + quotedstr('S') + ')) ');
          qryFcertaTEMP.SQL.Add('      and fc12110.cdfil=:cod1 ');
          qryFcertaTEMP.SQL.Add('      and fc12110.nrrqu=:cod2 ');
          qryFcertaTEMP.SQL.Add('      and fc12110.serier=:cod4 ');
          qryFcertaTEMP.SQL.Add(' order by fc12110.cdprin ');

          qryFcertaTEMP.Params[0].Value := qrySelecionaDesconto.FieldValues['cdfilr'];
          qryFcertaTEMP.Params[1].Value := qrySelecionaDesconto.FieldValues['cdpro'];
          qryFcertaTEMP.Params[2].Value := '0';

          qryFcertaTEMP.Open;

          codformula := '';

          qtcpm := 0;
          qryFcertaTEMP.FetchAll;
          qtcpm := qryFcertaTEMP.RecordCount;
          qryFcertaTEMP.First;

          while not qryFcertaTEMP.Eof do
          begin
            if qtcpm > 1 then
              codformula := codformula + inttostr(qryFcertaTEMP.FieldValues['CDPRIN']) + '|'//composto n considera concentracao
            else
              codformula := codformula + inttostr(qryFcertaTEMP.FieldValues['CDPRIN']) + '|' + floattostr(qryFcertaTEMP.FieldValues['QUANT']) + '|'; //monodroga considera concentracao

            qryFcertaTEMP.Next;
          end;

          codformula := floattostr(volume) + '-' + codformula;

          qryPrivilegeTEMP.Close;
          qryPrivilegeTEMP.SQL.Clear;
          qryPrivilegeTEMP.SQL.Add(' select * ');
          qryPrivilegeTEMP.SQL.Add('   from FORMTABELADAS A ');
          qryPrivilegeTEMP.SQL.Add('  where a.hashform=' + quotedstr(codformula));
          qryPrivilegeTEMP.SQL.Add('    and a.NRCRM=' + inttostr(CRMDesc));
          qryPrivilegeTEMP.Open;
          achou := false;

          if not (qryPrivilegeTEMP.IsEmpty) then
            achou := true
          else
          begin

            qryPrivilegeTEMP.Close;
            qryPrivilegeTEMP.SQL.Clear;
            qryPrivilegeTEMP.SQL.Add(' select * ');
            qryPrivilegeTEMP.SQL.Add('   from FORMTABELADAS2 A ');
            qryPrivilegeTEMP.SQL.Add('  where a.qtdcpm<=' + inttostr(qtcpm));
            qryPrivilegeTEMP.SQL.Add('    and a.NRCRM=' + inttostr(CRMDesc));
            qryPrivilegeTEMP.SQL.Add('    and a.volume=' + FloatToStr(volume));
            qryPrivilegeTEMP.Open;

            if not (qryPrivilegeTEMP.IsEmpty) then
              achou := true
          end;

          if not (qryPrivilegeTEMP.IsEmpty) then
          begin
            valortabela := qryPrivilegeTEMP.FieldValues['VALFORM'];
            qtform := qrySelecionaDesconto.FieldValues['QUANT'];
            valortabelaqt := valortabela * qtform;

            if valortabela < qrySelecionaDesconto.FieldValues['VRLIQ'] then
              valordescaplic := qrySelecionaDesconto.FieldValues['VRLIQ'] - valortabela
            else
              valordescaplic := 0;

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' update fc32200 ');
            qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescform) + ', ');
            qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(valordescaplic)) + ', ');
            qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(valordescaplic)) + ', ');
            qryInsereDesconto.SQL.Add('        vrsdo=vrsdo-' + TrocaVirgPPto(floattostr(valordescaplic)) + ', ');
            qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valordescaplic)) + ', ');
            qryInsereDesconto.SQL.Add('        useridaut=' + quotedstr('privilegem'));
            qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
            qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
            qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
            qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
            qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
            qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.CommitRetaining;

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' update fc32110 ');
            qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescform) + ', ');
            qryInsereDesconto.SQL.Add('        vrtot=vrtot-' + TrocaVirgPPto(floattostr(valordescaplic)) + ', ');
            qryInsereDesconto.SQL.Add('        pruni=pruni-' + TrocaVirgPPto(floattostr(valordescaplic)) + ', ');
            qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(valordescaplic)) + '/QUANT), ');
            qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(valordescaplic)) + ', ');
            qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(valordescaplic)) + ', ');
            qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(valordescaplic)));
            qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
            qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
            qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
            qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
            qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
            qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.CommitRetaining;
          end;

          if achou = true then
          begin
            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
            qryInsereDesconto.SQL.Add('   from fc32110 ');
            qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
            qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
            qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
            qryInsereDesconto.Open;

            valortotal := qryInsereDesconto.FieldValues['VALOR'];

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' update fc32100 ');
            qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('privilegem') + ', ');
            qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
            qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
            qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
            qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
            qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
            qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
            qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.CommitRetaining;
          end
          else
          begin

            desc1form := StrToFloat(lblPercForm.Caption);
            desc2var := StrToFloat(lblPercVar.Caption);

            if qrySelecionaDesconto.FieldValues['TPITM'] = 'R' then
              valorunitdesc := (qrySelecionaDesconto.FieldValues['VRTOT'] * desc1form) / 100
            else
              valorunitdesc := (qrySelecionaDesconto.FieldValues['VRTOT'] * desc2var) / 100;

            valorunitdesc := RoundTo(valorunitdesc, -2);

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' update fc32200 ');
            qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescform) + ', ');
            qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
            qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
            qryInsereDesconto.SQL.Add('        vrsdo=vrsdo-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
            qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
            qryInsereDesconto.SQL.Add('        useridaut=' + quotedstr('privilegem'));
            qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
            qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
            qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
            qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
            qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
            qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.CommitRetaining;

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;

            if qrySelecionaDesconto.FieldValues['TPITM'] = 'R' then
            begin
              qryInsereDesconto.SQL.Add(' update fc32110 ');
              qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescform) + ', ');
              qryInsereDesconto.SQL.Add('        vrtot=vrtot-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
              qryInsereDesconto.SQL.Add('        pruni=pruni-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
              qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
              qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
              qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
              qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)));
              qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
              qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
              qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
              qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
              qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
              qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
            end
            else
            begin
              qryInsereDesconto.SQL.Add(' update fc32110 ');
              qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescform) + ', ');
              qryInsereDesconto.SQL.Add('        ptdsc=' + TrocaVirgPPto(floattostr(desc2var)) + ' , ');
              qryInsereDesconto.SQL.Add('        pruniliq=pruniliq-(' + TrocaVirgPPto(floattostr(valorunitdesc)) + '/QUANT), ');
              qryInsereDesconto.SQL.Add('        vrcxa=vrcxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
              qryInsereDesconto.SQL.Add('        vrliq=vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
              qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
              qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + TrocaVirgPPto(floattostr(valorunitdesc)));
              qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
              qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
              qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
              qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
              qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
              qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
            end;

            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.CommitRetaining;

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
            qryInsereDesconto.SQL.Add('   from fc32110 ');
            qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
            qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
            qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
            qryInsereDesconto.Open;

            valortotal := qryInsereDesconto.FieldValues['VALOR'];

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' update fc32100 ');
            qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('privilegem') + ', ');
            qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
            qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
            qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
            qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
            qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
            qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
            qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.CommitRetaining;
          end;
        end;
        qrySelecionaDesconto.Next;
      end;

      if achoumed = false then
        raise Exception.Create('Não existem receitas deste médico na venda');

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      if achou = true then
        showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end;
end;

procedure TfrmPrincipal.DescontoMdico1Click(Sender: TObject);
begin
  frmDescontoMedico.ShowModal;
end;

procedure tfrmPrincipal.ConsultoriaPremium;

  function TempoValidadeCompra(cpf: string): Boolean;
  var
    PrimeiraData: TDateTime;
    meses: integer;
  begin

    qryPrivilegeTEMP.Close;
    qryPrivilegeTEMP.SQL.Clear;
    qryPrivilegeTEMP.SQL.Add('   select c.dtope  ');
    qryPrivilegeTEMP.SQL.Add('     from consultoria C ');
    qryPrivilegeTEMP.SQL.Add('    where c.cpf = ' + QuotedStr(cpf));
    qryPrivilegeTEMP.SQL.Add(' order by c.dtope');
    qryPrivilegeTEMP.Open;

    PrimeiraData := qryPrivilegeTEMP.FieldByName('dtope').AsDateTime;
    meses := MonthsBetween(PrimeiraData, now);

    if meses > 6 then
    begin
      showMessage('O Tempo da consultoria é de 6 meses: primeira compra foi em: ' + dateToStr(PrimeiraData) + '. Há um intervalo de ' + intToStr(meses) + ' meses');
      result := false;
    end
    else
    begin
      result := true;
    end;

  end;

  function TBcomDesconto: Boolean;
  var
    vrDesc: Currency;
  begin

    qryPrivilegeTEMP.Close;
    qryPrivilegeTEMP.SQL.Clear;
    qryPrivilegeTEMP.SQL.Add('select sum(c.vrdesc) as desconto ');
    qryPrivilegeTEMP.SQL.Add('  from consultoria C ');
    qryPrivilegeTEMP.SQL.Add(' where c.cdfil = ' + qrySelecionaDesconto.FieldByName('CDFIL').asString);
    qryPrivilegeTEMP.SQL.Add('   and c.tbalcao = ' + qrySelecionaDesconto.FieldByName('NRCPM').asString);
    qryPrivilegeTEMP.Open;

    vrDesc := qryPrivilegeTEMP.FieldByName('desconto').AsCurrency;
    if vrDesc > 0 then
      result := true
    else
      result := false;
  end;

  procedure GravaDescontoConsultoria(pvrBruto, pvrDesc, pvrLiq: Currency);
  begin
    qryPrivilegeTEMP.Close;
    qryPrivilegeTEMP.SQL.Clear;
    qryPrivilegeTEMP.SQL.Add('INSERT INTO CONSULTORIA ');
    qryPrivilegeTEMP.SQL.Add('( PFCRM,UFCRM,NRCRM,CDFIL,TBALCAO,ITEMID,CPF,DTOPE,HORA,CDFILR,CDPRO,QUANT,VRBRUTO,VRDESC,VRLIQ,CDCLI,NOMECLI,USUID ) values ');
    qryPrivilegeTEMP.SQL.Add('( :pN0,:pN1,:pN2,:pN3,:pN4,:pN5,:pN6,:pN7,:pN8,:pN9,:pN10,:pN11,:pN12,:pN13,:pN14,:pN15,:pN16,:pN17 ) ');
    qryPrivilegeTEMP.Params[0].Value := qrySelecionaDesconto.FieldValues['PFCRM'];
    qryPrivilegeTEMP.Params[1].Value := qrySelecionaDesconto.FieldValues['UFCRM'];
    qryPrivilegeTEMP.Params[2].Value := qrySelecionaDesconto.FieldValues['NRCRM'];
    qryPrivilegeTEMP.Params[3].Value := qrySelecionaDesconto.FieldValues['CDFIL'];
    qryPrivilegeTEMP.Params[4].Value := qrySelecionaDesconto.FieldValues['NRCPM'];
    qryPrivilegeTEMP.Params[5].Value := qrySelecionaDesconto.FieldValues['ITEMID'];
    qryPrivilegeTEMP.Params[6].Value := copy(qryTerminalBalcao.FieldValues['nrcnpj'], 1, 11);
    qryPrivilegeTEMP.Params[7].Value := qrySelecionaDesconto.FieldValues['DTOPE'];
    qryPrivilegeTEMP.Params[8].Value := FormatDateTime('hh:mm:ss', now);
    qryPrivilegeTEMP.Params[9].Value := qrySelecionaDesconto.FieldValues['CDFILR'];
    qryPrivilegeTEMP.Params[10].Value := qrySelecionaDesconto.FieldValues['CDPRO'];
    qryPrivilegeTEMP.Params[11].Value := qrySelecionaDesconto.FieldValues['QUANT'];
    qryPrivilegeTEMP.Params[12].Value := pvrBruto;
    qryPrivilegeTEMP.Params[13].Value := pvrDesc;
    qryPrivilegeTEMP.Params[14].Value := pvrLiq;
    qryPrivilegeTEMP.Params[15].Value := QryTerminalBalcao.FieldValues['CDCLI'];
    qryPrivilegeTEMP.Params[16].Value := QryTerminalBalcao.FieldValues['NOMECLI'];
    qryPrivilegeTEMP.Params[17].Value := frmsenha.Usuario.Text;
    qryPrivilegeTEMP.ExecSQL;
    qryPrivilegeTEMP.Transaction.CommitRetaining;
  end;

var
  valortotal, valorunitdesc, vrcxa, desconto: double;
  perform: Real;
  validade: boolean;
begin
   // precisa verificar so o medico faz parta da consultoria preminum
  qryPrivilegeTEMP.Close;
  qryPrivilegeTEMP.SQL.Clear;
  qryPrivilegeTEMP.SQL.Add(' select * ');
  qryPrivilegeTEMP.SQL.Add('   from Parceria ');
  qryPrivilegeTEMP.SQL.Add('  where pfcrm =' + QuotedStr(qryTerminalBalcao.FieldByName('pfcrm').asString));
  qryPrivilegeTEMP.SQL.Add('    and ufcrm = ' + QuotedStr(qryTerminalBalcao.FieldByName('ufcrm').asString));
  qryPrivilegeTEMP.SQL.Add('    and nrcrm = ' + qryTerminalBalcao.FieldByName('nrcrm').asString);

   //CLIPBOARD.AsText := qryPrivilegeTEMP.SQL.Text;
  qryPrivilegeTEMP.Open;
  if qryPrivilegeTEMP.IsEmpty then
    raise Exception.Create('Esse Terminal Balcão não tem médico na Consultoria Premium.');

  perform := qryPrivilegeTEMP.FieldByName('perForm').AsFloat;
  validade := TempoValidadeCompra(qryTerminalBalcao.FieldByName('nrcnpj').asString);

  if validade = false then
    exit;

  useridaut := 'ConsPremium';
  qrySelecionaDesconto.Close;

  desc1form := perform;
  tpdescform := '8'; // desconto campanha

  qrySelecionaDesconto.Close;
  qrySelecionaDesconto.sql.Clear;
  qrySelecionaDesconto.sql.Add('    select a.pfcrm , a.ufcrm , a.nrcrm , a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDPRO,');
  qrySelecionaDesconto.sql.Add('           a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, a.TPDSC, a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, ');
  qrySelecionaDesconto.sql.Add('           coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ ');
  qrySelecionaDesconto.sql.Add('      from fc32110 a ');
  qrySelecionaDesconto.sql.Add(' left join fc32200 b on ( ');
  qrySelecionaDesconto.sql.Add('           a.cdfil=b.cdfil ');
  qrySelecionaDesconto.sql.Add('       and a.cdtml=b.cdtml ');
  qrySelecionaDesconto.sql.Add('       and a.dtope = b.dtope ');
  qrySelecionaDesconto.sql.Add('       and a.operid=b.operid ');
  qrySelecionaDesconto.sql.Add('       and a.nrcpm=b.nrcpm ');
  qrySelecionaDesconto.sql.Add('       and a.itemid=b.itemid ) ');
  qrySelecionaDesconto.sql.Add('     where a.cdfil=' + trim(frmPrincipal.edtLoja.Text));
  qrySelecionaDesconto.sql.Add('       and a.nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
  qrySelecionaDesconto.sql.Add('       and a.TPITM = ' + QuotedStr('R'));
  qrySelecionaDesconto.sql.Add('       and  a.dtope>=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
  qrySelecionaDesconto.SQL.Add(' order by a.VRTOT DESC');

  qrySelecionaDesconto.Open;
  qrySelecionaDesconto.FetchAll;

  if TBcomDesconto = true then
    raise Exception.Create('Já foi aplicado desconto para esse Terminal Balcão.');

  if MessageDlg('Deseja confirmar desconto exclusivo de ' + FloatToStr(perform) + '%Fórmula ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
  begin
    qrySelecionaDesconto.First;
    while not qrySelecionaDesconto.eof do
    begin
      valorunitdesc := (qrySelecionaDesconto.FieldValues['VRTOT'] * desc1form) / 100;
      valorunitdesc := RoundTo(valorunitdesc, -2);

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32200 ');
      qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescform) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq= vrtot+vrtxa-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
      qryInsereDesconto.SQL.Add('        vrsdo=vrtot+vrtxa-vrrcb-' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
      qryInsereDesconto.SQL.Add('        vrdsc=' + TrocaVirgPPto(floattostr(valorunitdesc)) + ', ');
      qryInsereDesconto.SQL.Add('        useridaut=' + quotedstr(useridaut));
      qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
      qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
      qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
      qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
      qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      if qrySelecionaDesconto.FieldValues['tppag'] = '1' then
      begin
        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32200 ');
        qryInsereDesconto.SQL.Add('    set vrcxa = vrtot+vrtxa-' + TrocaVirgPPto(floattostr(valorunitdesc)));
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;
      end
      else
      begin
        qryInsereDesconto.Close;
        qryInsereDesconto.SQL.Clear;
        qryInsereDesconto.SQL.Add(' update fc32200 ');
        qryInsereDesconto.SQL.Add('    set vrcxa= vrrcb ');
        qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
        qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
        qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
        qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
        qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
        qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
        qryInsereDesconto.ExecSQL;
        qryInsereDesconto.Connection.CommitRetaining;
      end;

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' select vrcxa ');
      qryInsereDesconto.SQL.Add('   from fc32200 ');
      qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
      qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
      qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
      qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
      qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));
      qryInsereDesconto.Open;

      vrcxa := qryInsereDesconto.FieldValues['VRCXA'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32110 ');
      qryInsereDesconto.SQL.Add('    set tpdsc=' + quotedstr(tpdescform) + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
      qryInsereDesconto.SQL.Add('        pruni=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
      qryInsereDesconto.SQL.Add('        pruniliq=' + TrocaVirgPPto(floattostr(vrcxa)) + '/QUANT, ');
      qryInsereDesconto.SQL.Add('        vrcxa=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
      qryInsereDesconto.SQL.Add('        BCICM=' + TrocaVirgPPto(floattostr(vrcxa)) + ', ');
      qryInsereDesconto.SQL.Add('        nomepa=' + quotedstr(useridaut));
      qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qrySelecionaDesconto.FieldValues['cdfil']));
      qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qrySelecionaDesconto.FieldValues['cdtml']));
      qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
      qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qrySelecionaDesconto.FieldValues['operid']));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qrySelecionaDesconto.FieldValues['nrcpm']));
      qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qrySelecionaDesconto.FieldValues['itemid']));

      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.CommitRetaining;

      //grava desconto consultoria Premium
      GravaDescontoConsultoria(qrySelecionaDesconto.FieldValues['VRTOT'], valorunitdesc, qrySelecionaDesconto.FieldValues['VRTOT'] - valorunitdesc);

      qrySelecionaDesconto.Next;
    end;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
    qryInsereDesconto.SQL.Add('   from fc32110 ');
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
    qryInsereDesconto.Open;

    valortotal := qryInsereDesconto.FieldValues['VALOR'];

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update fc32100 ');
    qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr(useridaut) + ', ');
    qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
    qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
    qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qrySelecionaDesconto.FieldValues['dtope'])));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.CommitRetaining;

    qryInsereDesconto.Close;
    qryInsereDesconto.SQL.Clear;
    qryInsereDesconto.SQL.Add(' update totvsconf ');
    qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
    qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
    qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
    qryInsereDesconto.ExecSQL;
    qryInsereDesconto.Connection.Commit;

    showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
  end;
  localizarbalcao(edtTerminalBalcao.Text);
end;

procedure tfrmPrincipal.inseredesc;
var
  MAXDESCVARGER, MAXDESCFORGER, MAXDESCVARNEG, MAXDESCFORNEG: INTEGER;
  VERIFICASALDO: string;
begin
  qryParametros.Close;
  qryParametros.SQL.Clear;
  qryParametros.SQL.Add(' SELECT ARGUMENTO ');
  qryParametros.SQL.Add('   FROM PARAMETROS ');
  qryParametros.SQL.Add('  WHERE PARAMETRO = ''MAXDESCVARGER''');
  qryParametros.Open;

  MAXDESCVARGER := qryParametros.FieldValues['ARGUMENTO'];

  qryParametros.Close;
  qryParametros.SQL.Clear;
  qryParametros.SQL.Add(' SELECT ARGUMENTO ');
  qryParametros.SQL.Add('   FROM PARAMETROS ');
  qryParametros.SQL.Add('  WHERE PARAMETRO = ''MAXDESCFORGER''');
  qryParametros.Open;

  MAXDESCFORGER := qryParametros.FieldValues['ARGUMENTO'];

  qryParametros.Close;
  qryParametros.SQL.Clear;
  qryParametros.SQL.Add('   select first 1 * ');
  qryParametros.SQL.Add('     from (  SELECT PARAMETRO,ARGUMENTO, cast(SUBARGUM as integer) as SUBARGUM ');
  qryParametros.SQL.Add('               FROM PARAMETROS ');
  qryParametros.SQL.Add('              WHERE PARAMETRO = ' + quotedstr('MAXDESCVARNEG') + ')');
  qryParametros.SQL.Add(' order by subargum  desc');

  qryParametros.Open;

  MAXDESCVARNEG := qryParametros.FieldValues['SUBARGUM'];

  qryParametros.Close;
  qryParametros.SQL.Clear;
  qryParametros.SQL.Add('   select first 1 * ');
  qryParametros.SQL.Add('     from (     SELECT PARAMETRO,ARGUMENTO, cast(SUBARGUM as integer) as SUBARGUM ');
  qryParametros.SQL.Add('                  FROM PARAMETROS ');
  qryParametros.SQL.Add('                 WHERE PARAMETRO = ' + quotedstr('MAXDESCFORNEG'));
  qryParametros.SQL.Add('             union all ');
  qryParametros.SQL.Add('                SELECT PARAMETRO,ARGUMENTO, cast(SUBARGUM as integer) as SUBARGUM ');
  qryParametros.SQL.Add('                  FROM PARAMETROS ');
  qryParametros.SQL.Add('                 WHERE PARAMETRO = ' + quotedstr('DESCPUSU') + ' and ARGUMENTO =' + quotedstr(usu));
  qryParametros.SQL.Add('             union all ');
  qryParametros.SQL.Add('                SELECT PARAMETRO,ARGUMENTO, cast(SUBARGUM as integer) as SUBARGUM ');
  qryParametros.SQL.Add('                  FROM PARAMETROS ');
  qryParametros.SQL.Add('                 WHERE PARAMETRO = ' + quotedstr('MAXDESCLOJA'));
  qryParametros.SQL.Add('                   AND ARGUMENTO=' + quotedstr(edtLoja.Text));
  qryParametros.SQL.Add('             union all ');
  qryParametros.SQL.Add('                SELECT PARAMETRO,ARGUMENTO, cast(SUBARGUM as integer) as SUBARGUM ');
  qryParametros.SQL.Add('                  FROM PARAMETROS ');
  qryParametros.SQL.Add('                 WHERE PARAMETRO = ' + quotedstr('DESCMAXCRM'));
  qryParametros.SQL.Add('                   AND ARGUMENTO=' + quotedstr(inttostr(crmtermbalc)) + ')');
  qryParametros.SQL.Add(' order by subargum  desc');
  qryParametros.Open;

  MAXDESCFORNEG := qryParametros.FieldValues['SUBARGUM'];

  qryParametros.Close;
  qryParametros.SQL.Clear;
  qryParametros.SQL.Add(' SELECT ARGUMENTO ');
  qryParametros.SQL.Add('   FROM PARAMETROS ');
  qryParametros.SQL.Add('  WHERE PARAMETRO = ''VERIFICASALDODESC''');
  qryParametros.Open;

  VERIFICASALDO := qryParametros.FieldValues['ARGUMENTO'];

  qryParametros.Close;
  qryParametros.SQL.Clear;
  qryParametros.SQL.Add(' SELECT ARGUMENTO ');
  qryParametros.SQL.Add('   FROM PARAMETROS ');
  qryParametros.SQL.Add('  WHERE PARAMETRO = ''MAXPRODFUNC''');
  qryParametros.Open;

  MAXPRODFUNC := StrToInt(qryParametros.FieldValues['ARGUMENTO']);

  if (trim(frmPrincipal.edtLoja.Text) = '159') or ((trim(frmPrincipal.edtLoja.Text) = '151')) then
  begin
    qryParametros.Close;
    qryParametros.SQL.Clear;
    qryParametros.SQL.Add(' select * ');
    qryParametros.SQL.Add('   from parametros ');
    qryParametros.SQL.Add('  where parametro =' + quotedstr('MAXDESCCARUARU'));
    qryParametros.SQL.Add('    and argumento=' + quotedstr(usu));
    qryParametros.Open;

    if not (qryParametros.IsEmpty) then
    begin
      MAXDESCFORNEG := qryParametros.FieldValues['SUBARGUM'];
      MAXDESCVARNEG := qryParametros.FieldValues['SUBARGUM'];
    end;
  end;

  if not (qryTerminalBalcao.IsEmpty) then
  begin
    case rgtpDesc.ItemIndex of
      0: //DESCONTO LOJA
        begin
          if (rgtpDesc.ItemIndex = 0) and (cbDescontoTipo.ItemIndex <> -1) and (copy(cbDescontoTipo.Text, 1, 3) <> 'DR.') and (copy(cbDescontoTipo.Text, 1, 4) <> 'DRA.') and (copy(cbDescontoTipo.Text, 1, 5) <> 'CUPOM') and (copy(cbDescontoTipo.Text, 1, 8) <> 'CORTESIA') and (trim(cbDescontoTipo.Text) <> 'FUNCIONÁRIO PHARMAPELE') and (trim(cbDescontoTipo.Text) <> 'PAGAMENTO À VISTA') then
          begin
            if (VERIFICASALDO = 'S') then
            begin
              if strtofloat(lblSaldoDesc.Caption) < strtofloat(copy(lblDesconto.Caption, 3, length(lblDesconto.Caption) - 3)) then
                raise Exception.Create('A loja não possui saldo de desconto disponível para efetuar esse desconto' + #13 + 'Por favor contacte o depto comercial.');
            end;
          end;

          if trim(cbDescontoTipo.Text) = 'GERENTE' then
          begin
            vrnegocfrm := MAXDESCFORGER;
            vrnegocvar := MAXDESCVARGER;
            frmInformaDesconto.ShowModal;
          end
          else if trim(cbDescontoTipo.Text) = 'NEGOCIAÇÃO LOJA' then
          begin
            vrnegocfrm := MAXDESCFORNEG;
            vrnegocvar := MAXDESCVARNEG;
            frmInformaDesconto.ShowModal;
          end
          else if trim(cbDescontoTipo.Text) = 'FUNCIONÁRIO PHARMAPELE' then
            DescontoFuncionarios
          else if trim(cbDescontoTipo.Text) = 'CORTESIA' then
            DescontoCortesia
          else if trim(cbDescontoTipo.Text) = 'CONSULTORIA PREMIUM' then
            ConsultoriaPremium
          else if trim(cbDescontoTipo.Text) = 'MÉDICOS E NUTRICIONISTAS' then
            raise exception.create('USE O CARTÃO PRIVILEGE PARA DESCONTO MÉDICO' + #13 + 'CASO NÃO SEJA POSSÍVEL USE O DESCONTO GERENTE.')
          else if (CRMDesc > 0) then
            DescontoMedico    // se na mudança de combobox for detectado que esse médico possui um link de desconto
          else
          begin
            if MessageDlg('Deseja confirmar desconto ?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
            begin
              try
                Desconto_Loja(InfoTela);
                Application.MessageBox('Desconto concedido com sucesso!', 'Privilege', MB_OK + MB_ICONINFORMATION);
              except
                on e: Exception do
                begin
                  Application.MessageBox(PWideChar(e.message), 'Privilege', MB_OK + MB_ICONSTOP);
                end;
              end;
            end;
          end;
        end;

      1:
        begin
          if desconto > 0 then
            raise exception.create('Venda já possui desconto');
          frmCartaoDesconto.InfoTela := InfoTela;
          frmCartaoDesconto.ShowModal;
        end;

      2:
        begin
          if desconto > 0 then
            raise exception.create('Venda já possui desconto');

          with frmCampanhaCliente do
          begin
            qryCampanha.Close;
            qryCampanha.SQL.Clear;
            qryCampanha.SQL.Add('   select b.* ');
            qryCampanha.SQL.Add('     from campanhasclientes a, ');
            qryCampanha.SQL.Add('          campanhas b ');
            qryCampanha.SQL.Add('    where a.idcamp=b.idcamp ');
            qryCampanha.SQL.Add('      and cpfcli=' + quotedstr(cpfcliente));
            qryCampanha.SQL.Add(' order by b.nomecampanha');
            qryCampanha.Open;

            if qryCampanha.IsEmpty then
            begin
              qryCampanha.Close;
              raise Exception.Create('Cliente não está cadastrado em Campanhas Pharmapele');
            end
            else
            begin
              cbCampanhaNome.Clear;
              while not qryCampanha.Eof do
              begin
                cbCampanhaNome.Items.Add(qryCampanha.FieldValues['nomecampanha']);
                qryCampanha.Next;
              end;

              qryCampanha.Close;
              frmCampanhaCliente.ShowModal;
              // TODO -cREFATORAR -oGustavo Sequeira: realizar refatoramento para que, quando for solicitado enviar o codigo de seguraca para o celular do cliente e o mesmo codigo sera a senha para descompactar o JSON dos descontos
            end;
          end;
        end;
      3: DescontoFranquias;
      4: Descontoprogressivo;
      5: DescontoprogressivoBeauty;
      6: DescontoprogressivoCabelos;
      7: DescontoprogressivoPrevAging;
      8: DescontoprogressivoPowerTrainning;
      9: LinhaCleanTherapy;
      10: ProgressivoPresentes;
      11: VendasIfood;
      12: CloneAlmofada;
      13: GessoPerfumado;
      14: VendasPet;
      15: CampanhaBrindesCompras;
      16: CampanhaStickBolsaPraia;
      17: Carnaval2026;
      18: CampanhaCreatina2026;
    end;

    localizarbalcao(edtTerminalBalcao.Text);
    edtTerminalBalcao.SetFocus;
    edtTerminalBalcao.SelectAll;
  end
  else
    showmessage('Informe um terminal balcão');
end;

procedure TfrmPrincipal.DescontoprogressivoPowerTrainning;
var
  valortotal, valorproduto, valdesc, valdesctot, valdescapl: double;
  qtdprodpromocao, i, percdesc, codproduto: integer;
  nomedesconto: string;
begin
  valdesctot := 0;
  lblDescontoValor.Caption := '0';
  nomedesconto := CAMPANHA_PERFORMANCE;

  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.add(' select a.cdpro, a.quant as qtd, a.pruni, a.vrdsc, a.itemid , a.cdfil , a.NRCPM , a.itemid , a.cdtml , a.dtope , a.operid ');
  qryFcertaTEMP.SQL.add('   from fc32110 a ');
  qryFcertaTEMP.SQL.add('  where a.tpitm=' + quotedstr('V'));
  qryFcertaTEMP.SQL.add('    and a.cdfil=' + inttostr(qryTerminalBalcao.FieldValues['CDFIL']));
  qryFcertaTEMP.SQL.add('    and a.nrcpm=' + inttostr(qryTerminalBalcao.FieldValues['NRCPM']));
  qryFcertaTEMP.SQL.add('    and a.cdpro in (15447 , 17243, 17242, 17244, 6045, 17823, 18397,19000, 17823, 19486, 19553 , 20271   ) ');
  qryFcertaTEMP.Open;
  if not (qryFcertaTEMP.IsEmpty) then
  begin

    qtdprodpromocao := 0;

    qryTerminalBalcao.First;
    while not EOF do
    begin
      if (qryTerminalBalcao.FieldValues['vrdsc'] > 0) then
        raise Exception.Create('Venda Já possui Desconto');
      next;
    end;

    if MessageDlg('Deseja confirmar desconto relativo ao ' + nomedesconto + '?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
    begin

      if qryFcertaTEMP.FieldValues['vrdsc'] > 0 then
        raise Exception.Create('Venda já possue desconto');

      qryFcertaTEMP.First;
      while not (qryFcertaTEMP.Eof) do
      begin

        if (qryFcertaTEMP.FieldValues['cdpro'] = 15447) or (qryFcertaTEMP.FieldValues['cdpro'] = 17243) or (qryFcertaTEMP.FieldValues['cdpro'] = 17242) or (qryFcertaTEMP.FieldValues['cdpro'] = 17244) or (qryFcertaTEMP.FieldValues['cdpro'] = 17823) or (qryFcertaTEMP.FieldValues['cdpro'] = 18397) or (qryFcertaTEMP.FieldValues['cdpro'] = 19000) or (qryFcertaTEMP.FieldValues['cdpro'] = 17823) or (qryFcertaTEMP.FieldValues['cdpro'] = 19486) or (qryFcertaTEMP.FieldValues['cdpro'] = 19553) or (qryFcertaTEMP.FieldValues['cdpro'] = 20271) or (qryFcertaTEMP.FieldValues['cdpro'] = 6045) then
        begin
          qtdprodpromocao := qtdprodpromocao + qryFcertaTEMP.FieldValues['qtd'];
        end;

        qryFcertaTEMP.Next;
      end;

      percdesc := 0;
      case qtdprodpromocao of
        1:
          percdesc := 5;
        2:
          percdesc := 10;
        3:
          percdesc := 15;
      else
        percdesc := 15;
      end;

      qryFcertaTEMP.First;

      while not (qryFcertaTEMP.Eof) do
      begin

        if (qryFcertaTEMP.FieldValues['cdpro'] = 15447) or (qryFcertaTEMP.FieldValues['cdpro'] = 17243) or (qryFcertaTEMP.FieldValues['cdpro'] = 17242) or (qryFcertaTEMP.FieldValues['cdpro'] = 17244) or (qryFcertaTEMP.FieldValues['cdpro'] = 17823) or (qryFcertaTEMP.FieldValues['cdpro'] = 18397) or (qryFcertaTEMP.FieldValues['cdpro'] = 19000) or (qryFcertaTEMP.FieldValues['cdpro'] = 17823) or (qryFcertaTEMP.FieldValues['cdpro'] = 19486) or (qryFcertaTEMP.FieldValues['cdpro'] = 19553) or (qryFcertaTEMP.FieldValues['cdpro'] = 20271) or (qryFcertaTEMP.FieldValues['cdpro'] = 6045) then
        begin
          codproduto := qryFcertaTEMP.FieldValues['cdpro'];
          valorproduto := qryFcertaTEMP.FieldValues['PRUNI'] * qryFcertaTEMP.FieldValues['QTD'];

          valdesc := (valorproduto * percdesc) / 100;

          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Clear;
          qryInsereDesconto.SQL.Add(' update fc32110 ');
          qryInsereDesconto.SQL.Add('    set pruniliq=(pruniliq-(' + mudaponto(valdesc) + ')), ');
          qryInsereDesconto.SQL.Add('        ptdsc=' + mudaponto(percdesc) + ' ,');
          qryInsereDesconto.SQL.Add('        tpdsc=' + quotedstr('3') + ' ,');
          qryInsereDesconto.SQL.Add('        vrcxa=(vrcxa-(' + mudaponto(valdesc) + ')), ');
          qryInsereDesconto.SQL.Add('        vrliq=(vrliq-(' + mudaponto(valdesc) + ')), ');
          qryInsereDesconto.SQL.Add('        vrdsc=vrdsc+(' + mudaponto(valdesc) + '),');
          qryInsereDesconto.SQL.Add('        BCICM=VRTXAV+vrliq-' + mudaponto(valdesc));
          qryInsereDesconto.SQL.Add('  where cdfil=' + inttostr(qryFcertaTEMP.FieldValues['cdfil']));
          qryInsereDesconto.SQL.Add('    and cdtml=' + quotedstr(qryFcertaTEMP.FieldValues['cdtml']));
          qryInsereDesconto.SQL.Add('    and dtope=' + quotedstr(FormatDateTime('dd.mm.yyyy', qryFcertaTEMP.FieldValues['dtope'])));
          qryInsereDesconto.SQL.Add('    and operid=' + inttostr(qryFcertaTEMP.FieldValues['operid']));
          qryInsereDesconto.SQL.Add('    and nrcpm=' + inttostr(qryFcertaTEMP.FieldValues['nrcpm']));
          qryInsereDesconto.SQL.Add('    and itemid=' + inttostr(qryFcertaTEMP.FieldValues['itemid']));
          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
          qryInsereDesconto.Close;
        end;
        qryFcertaTEMP.Next;
      end;

      qryFcertaTEMP.Close;
      qryFcertaTEMP.SQL.Clear;
      qryFcertaTEMP.SQL.Add(' select sum(vrliq) as VALOR ');
      qryFcertaTEMP.SQL.Add('   from fc32110 ');
      qryFcertaTEMP.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryFcertaTEMP.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryFcertaTEMP.SQL.Add('    and dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
      qryFcertaTEMP.SQL.Add('    and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryFcertaTEMP.Open;

      valortotal := qryFcertaTEMP.FieldValues['VALOR'];

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update fc32100 ');
      qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('Progprtreino') + ', ');
      qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ',');
      qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
      qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
      qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.SQL.Add('    and dtope=' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;

      lblDescontoValor.Caption := floattostr(valdesctot);

      qryInsereDesconto.Close;
      qryInsereDesconto.SQL.Clear;
      qryInsereDesconto.SQL.Add(' update totvsconf ');
      qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
      qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
      qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
      qryInsereDesconto.ExecSQL;
      qryInsereDesconto.Connection.Commit;
      qryInsereDesconto.Close;

      showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
    end;
  end
  else
    showmessage('Erro ao inserir Desconto');
end;

procedure TfrmPrincipal.verificaperc;
begin
  if (rgtpDesc.ItemIndex = 0) and (cbDescontoTipo.ItemIndex <> -1) then
  begin
    CRMDesc := 0;

    qryFcertaTEMP.Close;
    qryFcertaTEMP.SQL.Clear;
    qryFcertaTEMP.SQL.Add(' SELECT argumento,subargum as TPDESC, substring(trim(PARAMETRO) ');
    qryFcertaTEMP.SQL.Add('   from 1 for position ( ' + quotedstr('-') + ' in parametro)-1 )  as DESCRICAO, ');
    qryFcertaTEMP.SQL.Add('        substring(trim(PARAMETRO) from position (' + quotedstr('-') + ' in parametro)+1 ');
    qryFcertaTEMP.SQL.Add('        for char_length(PARAMETRO)-(position (' + quotedstr('-') + ' in parametro)+1) )  as DESCONTO, ');
    qryFcertaTEMP.SQL.Add('        PARAMETRO2 as NRCRM ');
    qryFcertaTEMP.SQL.Add('   FROM fc99999 ');
    qryFcertaTEMP.SQL.Add('  WHERE (argumento = ' + quotedstr('DESCONTOV'));
    qryFcertaTEMP.SQL.Add('     or    argumento = ' + QuotedStr('DESCONTOR') + ' )');
    qryFcertaTEMP.SQL.Add('    and PARAMETRO like ' + quotedstr('%-%'));
    qryFcertaTEMP.SQL.Add('    AND PARAMETRO LIKE ' + quotedstr('%' + cbDescontoTipo.Text + '%'));
    qryFcertaTEMP.SQL.Add('  group by 1,2,3,4,5 order by 1 ');
    qryFcertaTEMP.Open;

    if qryFcertaTEMP.Locate('ARGUMENTO', 'DESCONTOV', [loCaseInsensitive, loPartialKey]) then
    begin
      lblPercVar.Caption := VerificaValor(qryFcertaTEMP.FieldValues['DESCONTO']);
      InfoTela.TerminalBalcao[0].PercentualDesconto := StrToFloat(VerificaValor(qryFcertaTEMP.FieldValues['DESCONTO']));
      InfoTela.TerminalBalcao[0].TipoDesconto := trim(qryFcertaTEMP.FieldValues['TPDESC']);
      if qryFcertaTEMP.FieldValues['NRCRM'] <> null then
        CRMDesc := strtoint(qryFcertaTEMP.FieldValues['NRCRM']);
    end
    else
      lblPercVar.Caption := '0';

    if qryFcertaTEMP.Locate('ARGUMENTO', 'DESCONTOR', [loCaseInsensitive, loPartialKey]) then
    begin
      lblPercForm.Caption := VerificaValor(qryFcertaTEMP.FieldValues['DESCONTO']);
      InfoTela.TerminalBalcao[0].PercentualDesconto := StrToFloat(VerificaValor(qryFcertaTEMP.FieldValues['DESCONTO']));
      InfoTela.TerminalBalcao[0].TipoDesconto := trim(qryFcertaTEMP.FieldValues['TPDESC']);
      if qryFcertaTEMP.FieldValues['NRCRM'] <> null then
        CRMDesc := strtoint(qryFcertaTEMP.FieldValues['NRCRM']);
    end
    else
      lblPercForm.Caption := '0';
  end;
end;

function TfrmPrincipal.verQtdProdutos: integer;
begin
    // de 2 produtos da linha , cliente ganha 1 Necessaire Pós treino
    // retorna a quantidade de produtos  para comparar com quant de brinde lançados no TB
  qryFcertaTEMP.Close;
  qryFcertaTEMP.SQL.Clear;
  qryFcertaTEMP.SQL.Add(' select sum(a.quant) as qtd ');
  qryFcertaTEMP.SQL.Add('   from fc32110 a  ');
  qryFcertaTEMP.SQL.Add('  where a.tpitm=' + quotedstr('V') + ' and a.cdfil=' + inttostr(qryTerminalBalcao.FieldValues['CDFIL']));
  qryFcertaTEMP.SQL.Add('    and a.nrcpm=' + inttostr(qryTerminalBalcao.FieldValues['NRCPM']) + '  and a.cdpro in ( 9935, 9936, 9937, 17517 )  ');
  qryFcertaTEMP.Open;

  result := trunc(qryFcertaTEMP.FieldByName('qtd').AsInteger div 2);
end;

procedure TfrmPrincipal.btDiscriminaDescontoClick(Sender: TObject);
begin
  frmDescontosAplicados.ShowModal;
end;

procedure TfrmPrincipal.btInsereDescontoClick(Sender: TObject);
begin
  if ((copy(usu, 1, 2) = 'CX') and (rgtpDesc.ItemIndex = 0)) then
    raise Exception.Create('Caixas não podem negociar descontos');

  if Trim(edtTerminalBalcao.Text) = EmptyStr then
    raise Exception.Create('Não é possível realizar o desconto sem o terminal balcão');


  inseredesc;
  verificaperc;
end;

procedure TfrmPrincipal.calculadescmed;
var
  valortabela, valordescaplic, volume, descaplform, descparcvalor, valortotalpd: double;
  qtform, qtcpm: integer;
  codformula, descrform: string;
  achou: boolean;
begin
  descaplform := 0;
  valortotalpd := 0;
  valortabela := 0;

  qrySelecionaDesconto.Close;
  qrySelecionaDesconto.sql.Clear;
  qrySelecionaDesconto.sql.Add('   select * ');
  qrySelecionaDesconto.sql.Add('     from fc32110 ');
  qrySelecionaDesconto.sql.Add('    where cdfil=' + trim(frmPrincipal.edtLoja.Text));
  qrySelecionaDesconto.sql.Add('      and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
  qrySelecionaDesconto.sql.Add('      and dtope>=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
  qrySelecionaDesconto.sql.Add('      and TPITM=' + quotedstr('R'));
  qrySelecionaDesconto.sql.Add(' order by VRTOT DESC');
  qrySelecionaDesconto.Open;

  //calcula descontos receitas
  if not (qrySelecionaDesconto.IsEmpty) then
  begin
    qrySelecionaDesconto.FetchAll;
    qrySelecionaDesconto.First;
    frmDescontosAplicados.CDS.EmptyDataSet;

    while not qrySelecionaDesconto.eof do
    begin
      qryFcertaTEMP.Close;
      qryFcertaTEMP.SQL.Clear;
      qryFcertaTEMP.SQL.Add(' select fc12100.nrcrm,fc12100.volume ');
      qryFcertaTEMP.SQL.Add('   from fc12100 ');
      qryFcertaTEMP.SQL.Add('  where fc12100.cdfil=:cod1 ');
      qryFcertaTEMP.SQL.Add('    and fc12100.nrrqu=:cod2 ');
      qryFcertaTEMP.SQL.Add('    and fc12100.serier=:cod4 ');

      qryFcertaTEMP.Params[0].Value := qrySelecionaDesconto.FieldValues['cdfilr'];
      qryFcertaTEMP.Params[1].Value := qrySelecionaDesconto.FieldValues['cdpro'];
      qryFcertaTEMP.Params[2].Value := '0';

      qryFcertaTEMP.Open;

      if qryFcertaTEMP.FieldValues['NRCRM'] = CRMDesc then
      begin
        volume := qryFcertaTEMP.FieldValues['VOLUME'];
        qryFcertaTEMP.Close;
        qryFcertaTEMP.SQL.Clear;
        qryFcertaTEMP.SQL.Add('   select fc12110.cdfil,fc12110.nrrqu,fc12110.serier,fc12110.cdprin,fc12110.descr,fc12110.quant,fc12110.unida, ');
        qryFcertaTEMP.SQL.Add('          fc12110.vrcmp,fc12110.porta,fc12110.tpcmp,fc12110.itemid ');
        qryFcertaTEMP.SQL.Add('     from fc12110 ');
        qryFcertaTEMP.SQL.Add('    where (( fc12110.tpcmp=' + quotedstr('C') + ') ');
        qryFcertaTEMP.SQL.Add('       or  ( fc12110.tpcmp=' + quotedstr('S') + ')) ');
        qryFcertaTEMP.SQL.Add('      and fc12110.cdfil=:cod1 ');
        qryFcertaTEMP.SQL.Add('      and fc12110.nrrqu=:cod2 ');
        qryFcertaTEMP.SQL.Add('      and fc12110.serier=:cod4 ');
        qryFcertaTEMP.SQL.Add(' order by fc12110.cdprin ');

        qryFcertaTEMP.Params[0].Value := qrySelecionaDesconto.FieldValues['cdfilr'];
        qryFcertaTEMP.Params[1].Value := qrySelecionaDesconto.FieldValues['cdpro'];
        qryFcertaTEMP.Params[2].Value := '0';

        qryFcertaTEMP.Open;

        codformula := '';

        qryFcertaTEMP.FetchAll;
        qtcpm := qryFcertaTEMP.RecordCount;
        qryFcertaTEMP.First;

        while not qryFcertaTEMP.Eof do
        begin
          if qtcpm > 1 then
            codformula := codformula + inttostr(qryFcertaTEMP.FieldValues['CDPRIN']) + '|' //composto   n considera concentracao
          else
            codformula := codformula + inttostr(qryFcertaTEMP.FieldValues['CDPRIN']) + '|' + floattostr(qryFcertaTEMP.FieldValues['QUANT']) + '|';   //monodroga   considera concentracao

          qryFcertaTEMP.Next;
        end;

        codformula := floattostr(volume) + '-' + codformula;
        qryFcertaTEMP.Close;

        qryPrivilegeTEMP.Close;
        qryPrivilegeTEMP.SQL.Clear;
        qryPrivilegeTEMP.SQL.Add(' select * ');
        qryPrivilegeTEMP.SQL.Add('   from FORMTABELADAS A ');
        qryPrivilegeTEMP.SQL.Add('  where a.hashform=' + quotedstr(codformula));
        qryPrivilegeTEMP.SQL.Add('    and a.nrcrm=' + inttostr(CRMDesc));
        qryPrivilegeTEMP.Open;

        if not (qryPrivilegeTEMP.IsEmpty) then
        begin
          achou := true;
          descrform := qryPrivilegeTEMP.FieldValues['tituloform'];
        end
        else
        begin
          descrform := 'FÓRMULA NÃO ENCONTRADA';
          qryPrivilegeTEMP.Close;
          qryPrivilegeTEMP.SQL.Clear;
          qryPrivilegeTEMP.SQL.Add(' select * ');
          qryPrivilegeTEMP.SQL.Add('   from FORMTABELADAS2 A ');
          qryPrivilegeTEMP.SQL.Add('  where a.qtdcpm<=' + inttostr(qtcpm));
          qryPrivilegeTEMP.SQL.Add('    and a.NRCRM=' + inttostr(CRMDesc));
          qryPrivilegeTEMP.SQL.Add('    and a.volume=' + floattostr(volume));
          qryPrivilegeTEMP.Open;

          if not (qryPrivilegeTEMP.IsEmpty) then
            achou := true

        end;

        if not (qryPrivilegeTEMP.IsEmpty) then
        begin
          valortabela := qryPrivilegeTEMP.FieldValues['VALFORM'];
          qtform := qrySelecionaDesconto.FieldValues['QUANT'];
          if valortabela < qrySelecionaDesconto.FieldValues['VRLIQ'] then
            valordescaplic := qrySelecionaDesconto.FieldValues['VRLIQ'] - valortabela
          else
            valordescaplic := 0;//valordescaplic := (qrySelecionaDesconto.FieldValues['VRLIQ'] * ( strtoint(lblPercForm.Caption)/100  ) );
          descaplform := descaplform + valordescaplic;
        end
        else
        begin
          valordescaplic := (qrySelecionaDesconto.FieldValues['VRLIQ'] * (strtoint(lblPercForm.Caption) / 100));
          descaplform := descaplform + valordescaplic;
          valortabela := 0;
        end;

      end;

      with frmDescontosAplicados do
      begin
        Cds.Append;
        Cds.FieldByName('NRREQ').Value := qrySelecionaDesconto.FieldValues['cdpro'];
        Cds.FieldByName('DESCRFORM').Value := descrform;
        Cds.FieldByName('VRREQ').Value := qrySelecionaDesconto.FieldValues['VRLIQ'];
        Cds.FieldByName('VRDESC').Value := valordescaplic;
        Cds.FieldByName('VRLIQ').Value := qrySelecionaDesconto.FieldValues['VRLIQ'] - valordescaplic;
        Cds.FieldByName('VRTAB').Value := valortabela;
        valortotalpd := valortotalpd + qrySelecionaDesconto.FieldValues['VRLIQ'] - valordescaplic;
      end;

      qrySelecionaDesconto.Next;

    end;

    frmDescontosAplicados.lblvrtot.caption := 'Valor Total - ' + floattostrf(valortotalpd, ffcurrency, 15, 2);
  end;

  descparcvalor := descaplform + (vrtotvarejo * (strtoint(lblPercVar.Caption) / 100));

  lblDesconto.Caption := floattostrf(descparcvalor, ffcurrency, 15, 2);
  lblDesconto.Font.Color := clBlue;

  lblFinal.Caption := floattostrf(vrtot + vrtxa - descparcvalor, ffcurrency, 15, 2);
  lblFinal.Font.Color := clBlue;
end;

procedure TfrmPrincipal.cbDescontoTipoChange(Sender: TObject);
var
  descparcvalor: double;
begin
  if (rgtpDesc.ItemIndex = 0) and (cbDescontoTipo.ItemIndex <> -1) then
  begin

    CRMDesc := 0;
    frmDescontosAplicados.CDS.EmptyDataSet;

    qryFcertaTEMP.Close;
    qryFcertaTEMP.SQL.Clear;
    qryFcertaTEMP.SQL.Add('   SELECT argumento,subargum as TPDESC, substring(trim(PARAMETRO) from 1 for  position ( ' + quotedstr('-') + ' in parametro)-1 )  as DESCRICAO, ');
    qryFcertaTEMP.SQL.Add('          substring(trim(PARAMETRO) from position (' + quotedstr('-') + ' in parametro)+1 for char_length(PARAMETRO)-(position (' + quotedstr('-') + ' in parametro)+1)) as DESCONTO, ');
    qryFcertaTEMP.SQL.Add('          PARAMETRO2 as NRCRM ');
    qryFcertaTEMP.SQL.Add('     FROM fc99999 ');
    qryFcertaTEMP.SQL.Add('    WHERE (argumento = ' + quotedstr('DESCONTOV'));
    qryFcertaTEMP.SQL.Add('       or argumento = ' + QuotedStr('DESCONTOR') + ' ) ');
    qryFcertaTEMP.SQL.Add('      and PARAMETRO like ' + quotedstr('%-%'));
    qryFcertaTEMP.SQL.Add('      AND PARAMETRO LIKE ' + quotedstr('%' + cbDescontoTipo.Text + '%'));
    qryFcertaTEMP.SQL.Add(' group by 1,2,3,4,5 order by 1 ');
    qryFcertaTEMP.Open;

    if qryFcertaTEMP.Locate('ARGUMENTO', 'DESCONTOV', [loCaseInsensitive, loPartialKey]) then
    begin
      lblPercVar.Caption := VerificaValor(qryFcertaTEMP.FieldValues['DESCONTO']);
      tpdescvar := trim(qryFcertaTEMP.FieldValues['TPDESC']);
      if qryFcertaTEMP.FieldValues['NRCRM'] <> null then
        CRMDesc := strtoint(qryFcertaTEMP.FieldValues['NRCRM']);
    end
    else
      lblPercVar.Caption := '0';

    if qryFcertaTEMP.Locate('ARGUMENTO', 'DESCONTOR', [loCaseInsensitive, loPartialKey]) then
    begin
      lblPercForm.Caption := VerificaValor(qryFcertaTEMP.FieldValues['DESCONTO']);
      tpdescform := trim(qryFcertaTEMP.FieldValues['TPDESC']);
      if qryFcertaTEMP.FieldValues['NRCRM'] <> null then
        CRMDesc := strtoint(qryFcertaTEMP.FieldValues['NRCRM']);
    end
    else if pos('CORTESIA', cbDescontoTipo.Text) > 1 then
      tpdescform := 'R'
    else
      lblPercForm.Caption := '0';

    qryFcertaTEMP.Close;

    if (cbDescontoTipo.ItemIndex = cbDescontoTipo.Items.Count - 1) or (cbDescontoTipo.ItemIndex = cbDescontoTipo.Items.Count - 2) then
    begin
      lblDesconto.Caption := floattostrf(desconto, ffcurrency, 15, 2);
      lblDesconto.Font.Color := clBlack;

      lblFinal.Caption := floattostrf(vrtot + vrtxa - desconto, ffcurrency, 15, 2);
      lblFinal.Font.Color := clBlack;
    end
    else
    begin
      if (pos('ADEILSON', cbDescontoTipo.Text) > 0) or (pos('ANGELO', cbDescontoTipo.Text) > 0) then
      begin
        calculadescmed;
      end
      else if (pos('CORTESIA', cbDescontoTipo.Text) > 0) then
      begin
        qryFcertaTEMP.Close;
        qryFcertaTEMP.SQL.Clear;
        qryFcertaTEMP.SQL.Add(' select * ');
        qryFcertaTEMP.SQL.Add('   from fc32200 ');
        qryFcertaTEMP.SQL.Add('  where fc32200.nrcpm=' + trim(edtTerminalBalcao.Text));
        qryFcertaTEMP.SQL.Add('    and fc32200.cdfil=' + trim(edtLoja.Text));
        qryFcertaTEMP.SQL.Add('    and fc32200.dtope between ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now - 1)));
        qryFcertaTEMP.SQL.Add('    and ' + QuotedStr(FormatDateTime('dd.mm.yyyy', now)));
        qryFcertaTEMP.Open;

        if qryFcertaTEMP.IsEmpty then
          raise Exception.Create('Não existem receitas nessa venda para lançamento de cortesia');

        qryPrivilegeTEMP.Close;
        qryPrivilegeTEMP.SQL.Text := 'select * from soliccortesia a where a.nrrqur in (';

        while not (qryFcertaTEMP.Eof) do
        begin
          if length(trim(qryPrivilegeTEMP.Text)) > 49 then
            qryPrivilegeTEMP.SQL.Add(','); //se sql já foi modificado
          qryPrivilegeTEMP.SQL.Add(inttostr(qryFcertaTEMP.FieldValues['nrrqu']));
          qryFcertaTEMP.Next;
        end;

        qryPrivilegeTEMP.SQL.Add(',0)');

        qryPrivilegeTEMP.SQL.Add(' and cancelado=0 and indapr=1 and a.cdfilr=' + trim(edtLoja.Text));
        qryPrivilegeTEMP.Open;

        if qryPrivilegeTEMP.IsEmpty then
          raise Exception.Create('Não existe cortesia aprovada nessa venda');

        descparcvalor := 0;
        while not (qryPrivilegeTEMP.eof) do
        begin
          descparcvalor := descparcvalor + qryPrivilegeTEMP.FieldValues['VALORCORT'];
          qryPrivilegeTEMP.Next;
        end;

        lblPercForm.Caption := FloatToStr(RoundTo(((descparcvalor * 100) / vrtot), -2));
        descparcvalor := ((vrtot * strtofloat(lblPercForm.Caption)) / 100); //caso tenha ocorrido algum arredondamento devido ao percentual
        lblDesconto.Caption := floattostrf(descparcvalor, ffcurrency, 15, 2);
        lblDesconto.Font.Color := clBlue;

        lblFinal.Caption := floattostrf(vrtot + vrtxa - descparcvalor, ffcurrency, 15, 2);
        lblFinal.Font.Color := clBlue;
      end
      else
      begin
        descparcvalor := desconto + (vrtotvarejo * (strtoint(lblPercVar.Caption) / 100)) + (vrtotform * (strtoint(lblPercForm.Caption) / 100));
        lblDesconto.Caption := floattostrf(descparcvalor, ffcurrency, 15, 2);
        lblDesconto.Font.Color := clBlue;

        lblFinal.Caption := floattostrf(vrtot + vrtxa - descparcvalor, ffcurrency, 15, 2);
        lblFinal.Font.Color := clBlue;
      end;
    end;

    if (cbDescontoTipo.ItemIndex <> cbDescontoTipo.Items.Count - 1) and
       (cbDescontoTipo.ItemIndex <> cbDescontoTipo.Items.Count - 2) then
    begin
      lblPercDesconto.Visible := true;
      lblPercForm.Visible := true;
      lblPercVar.Visible := true;

      btInsereDesconto.Width := 90;
      btInsereDesconto.Caption := 'Desc. Fórmula';
      btInsereDescVarejo.Visible := true;
    end
    else
    begin
      lblPercDesconto.Visible := false;
      lblPercForm.Visible := false;
      lblPercVar.Visible := false;

      btInsereDesconto.Width := 180;
      btInsereDesconto.Caption := 'Inserir Desconto';
      btInsereDescVarejo.Visible := false;
    end;
  end
  else
  begin
    lblPercDesconto.Visible := false;
    lblPercForm.Visible := false;
    lblPercVar.Visible := false;

    lblDesconto.Caption := floattostrf(desconto, ffcurrency, 15, 2);
    lblDesconto.Font.Color := clBlack;

    lblFinal.Caption := floattostrf(vrtot + vrtxa - desconto, ffcurrency, 15, 2);
    lblFinal.Font.Color := clBlack;
  end;
end;

procedure TfrmPrincipal.TimerAberturaTimer(Sender: TObject);
begin
  if (autenticado=false) and (frmSenha.Showing=false) then frmSenha.ShowModal;
  if (autenticado=false) and (frmSenha.Showing=false) then FrmPrincipal.Close;
end;

procedure TfrmPrincipal.TimerHorarioTimer(Sender: TObject);
{# Função informa dia atual da semana em extenso e em português #}
  function DiaSemana(Data: TDateTime): string;
  const
    Dias: array[1..7] of string[13] = ('Domingo', 'Segunda-Feira', 'Terça-Feira', 'Quarta-Feira', 'Quinta-Feira', 'Sexta-Feira', 'Sábado');
  begin
    Result := Dias[DayOfWeek(Data)];
  end;

begin
  StatusBar1.Panels[0].Text := '  Hora : ' + TimeToStr(Time);
  if (StatusBar1.Panels[1].Text) <> (DiaSemana(Date) + '  ' + DateToStr(Date)) then
    StatusBar1.Panels[1].Text := DiaSemana(Date) + '  ' + DateToStr(Date);
end;

procedure TfrmPrincipal.DescontosConcedidos1Click(Sender: TObject);
begin
  frmRelatorioDesconto.ShowModal;
end;

procedure TfrmPrincipal.CodBarrasFuncionarios1Click(Sender: TObject);
begin
  frmCodBarrasMedicos.ShowModal;
end;

procedure TfrmPrincipal.Solicitao1Click(Sender: TObject);
begin
  frmSolicitacao.ShowModal;
end;

procedure TfrmPrincipal.SolicitaoCortesia1Click(Sender: TObject);
begin
  frmCortesiasAbertas.ShowModal;
end;

procedure TfrmPrincipal.btInsereDescVarejoClick(Sender: TObject);
begin
  if ((copy(usu, 1, 2) = 'CX') and (rgtpDesc.ItemIndex = 0)) then
    raise Exception.Create('Caixas não podem negociar descontos');

  if (InfoTela.TerminalBalcao = nil) or (Length(InfoTela.TerminalBalcao) = 0) then
    SetLength(InfoTela.TerminalBalcao, 1);

  InfoTela.TerminalBalcao[0].Filial := StrtoInt(edtLoja.Text);
  InfoTela.TerminalBalcao[0].Cupom := StrtoInt(edtTerminalBalcao.Text);
  InfoTela.TerminalBalcao[0].Tipo := 'V';
  InfoTela.TerminalBalcao[0].DescricaoDesconto := cbDescontoTipo.Text;
  InfoTela.TerminalBalcao[0].UsuarioAutorizacao := USUARIO_PRIVILEGE_LOJA;
  InfoTela.TerminalBalcao[0].PercentualDesconto := StrToFloat(lblPercVar.Caption);
  InfoTela.DatabaseIBConnectionFormulaCerta := dmDescontos.bdFcerta;
  InfoTela.DatabaseIBConnectionPrivilege := dmDescontos.bdDescontos;
  InfoTela.DatabaseFDConnectionFormulaCerta := dmDescontos.bdFcerta3;

  if vrtotvarejo > 0 then
    inseredesc
  else
    showmessage('Não há varejos nessa compra');

  verificaperc;
end;

procedure TfrmPrincipal.btSaldoClick(Sender: TObject);
begin
  frmExtrato.ShowModal;
end;

procedure TfrmPrincipal.C1Click(Sender: TObject);
begin
  frmRelCampanhas.ShowModal;
end;

procedure TfrmPrincipal.menu_ConsultoriaPremiumClick(Sender: TObject);
begin
  frmConsultoriaPremium.ShowModal;
end;

procedure TfrmPrincipal.SolicitaesAbertas1Click(Sender: TObject);
begin
  frmSolicitacaoesAbertas.ShowModal;
end;

procedure TfrmPrincipal.ConfigAlertas1Click(Sender: TObject);
begin
  frmAlertas.ShowModal;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  edtTerminalBalcao.SetFocus;

  qryPrivilegeTEMP.Close;
  qryPrivilegeTEMP.SQL.Clear;
  qryPrivilegeTEMP.SQL.Add(' select * ');
  qryPrivilegeTEMP.SQL.Add('   from descclientes ');
  qryPrivilegeTEMP.SQL.Add('  where usado=' + quotedstr('0'));
  qryPrivilegeTEMP.SQL.Add('    and cancelado=' + quotedstr('0'));
  qryPrivilegeTEMP.SQL.Add('    and dtvalfim<' + quotedstr(FormatDateTime('dd.mm.yyyy', now)));
  qryPrivilegeTEMP.Open;

  if not (qryPrivilegeTEMP.IsEmpty) then
  begin
    while not qryPrivilegeTEMP.Eof do
    begin

      qryLimpaPrivilege.Close;
      qryLimpaPrivilege.SQL.Clear;
      qryLimpaPrivilege.SQL.Add(' select * ');
      qryLimpaPrivilege.SQL.Add('   from descclientes ');
      qryLimpaPrivilege.SQL.Add('  where cdcli=' + inttostr(qryPrivilegeTEMP.FieldValues['cdcli']));
      qryLimpaPrivilege.SQL.Add('    and usado=' + quotedstr('0'));
      qryLimpaPrivilege.SQL.Add('    and dtvalfim>=' + quotedstr(FormatDateTime('dd.mm.yyyy', now)));
      qryLimpaPrivilege.Open;

      if qryLimpaPrivilege.IsEmpty then
      begin
        qryFcertaTEMP.Close;
        qryFcertaTEMP.SQL.Clear;
        qryFcertaTEMP.SQL.Add(' update fc07000 ');
        qryFcertaTEMP.SQL.Add('    set clcli=null ');
        qryFcertaTEMP.SQL.Add('  where cdcli=' + inttostr(qryPrivilegeTEMP.FieldValues['cdcli']));
        qryFcertaTEMP.ExecSQL;
        qryFcertaTEMP.Transaction.CommitRetaining;
        qryFcertaTEMP.Close;
      end;

      qryLimpaPrivilege.Close;
      qryLimpaPrivilege.SQL.Clear;
      qryLimpaPrivilege.SQL.Add(' update descclientes ');
      qryLimpaPrivilege.SQL.Add('    set cancelado=' + quotedstr('1'));
      qryLimpaPrivilege.SQL.Add('  where cdfil=' + inttostr(qryPrivilegeTEMP.FieldValues['cdfil']));
      qryLimpaPrivilege.SQL.Add('    and cpfiscal=' + inttostr(qryPrivilegeTEMP.FieldValues['cpfiscal']));
      qryLimpaPrivilege.ExecSQL;
      qryLimpaPrivilege.Transaction.CommitRetaining;
      qryLimpaPrivilege.Close;

      qryPrivilegeTEMP.Next;
    end;
  end;

  qryPrivilegeTEMP.Close;
end;

procedure TfrmPrincipal.edtLojaExit(Sender: TObject);
begin
  edtTerminalBalcao.SetFocus;
end;

procedure TfrmPrincipal.edtTerminalBalcaoChange(Sender: TObject);
begin
  if rgtpDesc.ItemIndex = 0 then
    cbDescontoTipo.ItemIndex := -1
  else
    cbDescontoTipo.ItemIndex := 0;

  cbDescontoTipo.Enabled := false;
  cbDescontoTipo.Color := clScrollBar;
  lblBalcao.Caption := 'R$ 0,00';
  lblDesconto.Caption := 'R$ 0,00';
  lblTaxa.Caption := 'R$ 0,00';
  lblFinal.Caption := 'R$ 0,00';

  if (InfoTela.TerminalBalcao = nil) or (Length(InfoTela.TerminalBalcao) = 0) then
    SetLength(InfoTela.TerminalBalcao, 1);

  InfoTela.TerminalBalcao[0].SaldoCampanha := 0.00;
  InfoTela.TerminalBalcao[0].VerificaSaldoCampanha := 'N';

  qryTerminalBalcao.Close;
  nomecli := '';
end;

procedure TfrmPrincipal.ControledeCartes1Click(Sender: TObject);
begin
  frmRelatorioControle.ShowModal;
end;

procedure TfrmPrincipal.Cortesias1Click(Sender: TObject);
begin
  frmControleCortesias.ShowModal;
end;

procedure TfrmPrincipal.CupomPharmapele1Click(Sender: TObject);
begin
  frmRelatCupom.ShowModal;
end;

procedure TfrmPrincipal.ImprimirCodBarras1Click(Sender: TObject);
begin
  frmImprimeCodBarras.ShowModal;
end;

end.





