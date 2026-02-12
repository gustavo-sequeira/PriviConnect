unit uCartaoDesconto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  math, Dialogs, StdCtrls, ExtCtrls, DB, IBCustomDataSet, IBQuery,
  System.DateUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Desconto.Tipos;

type
  TfrmCartaoDesconto = class(TForm)
    pnlCodBarras: TPanel;
    pnlInformacoes: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    qryAchaMedico: TIBQuery;
    lblTipoCartao: TLabel;
    lblNomeMedico: TLabel;
    lblDescontoValor: TLabel;
    qryGravaLog: TIBQuery;
    qryAchaFuncionario: TIBQuery;
    qrySelecionaDesconto: TIBQuery;
    qryInsereDesconto: TFDQuery;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    InfoTela: TInfoDesconto;
  end;

var
  frmCartaoDesconto: TfrmCartaoDesconto;

implementation

uses
  udmDescontos, StrUtils, uPrincipal, System.UITypes, Desconto.Constantes.Campanhas, Desconto.Constantes.Produtos,
  Desconto.Constantes.Usuarios, Desconto.Base;


{$R *.dfm}

procedure TfrmCartaoDesconto.FormKeyPress(Sender: TObject; var Key: Char);

  function codestado(estado: string): string;
  begin

    case AnsiIndexStr(estado, ['00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25']) of
      0:
        result := 'MT';
      1:
        result := 'AC';
      2:
        result := 'AL';
      3:
        result := 'AP';
      4:
        result := 'AM';
      5:
        result := 'BA';
      6:
        result := 'CE';
      7:
        result := 'DF';
      8:
        result := 'ES';
      9:
        result := 'GO';
      10:
        result := 'MA';
      11:
        result := 'MS';
      12:
        result := 'MG';
      13:
        result := 'PA';
      14:
        result := 'PB';
      15:
        result := 'PR';
      16:
        result := 'PE';
      17:
        result := 'PI';
      18:
        result := 'RJ';
      19:
        result := 'RN';
      20:
        result := 'RS';
      21:
        result := 'RO';
      22:
        result := 'RR';
      23:
        result := 'SP';
      24:
        result := 'SE';
      25:
        result := 'TO';
    end;
  end;

  function TrocaVirgPPto(Valor: string): string;
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

  function CalculaDigEAN13(Cod: string): string;

    function Par(Cod: Integer): Boolean;
    begin
      Result := Cod mod 2 = 0;
    end;

  var
    i, SomaPar, SomaImpar: Integer;
  begin
    SomaPar := 0;
    SomaImpar := 0;
    for i := 1 to 12 do
      if Par(i) then
        SomaPar := SomaPar + StrToInt(Cod[i])
      else
        SomaImpar := SomaImpar + StrToInt(Cod[i]);
    SomaPar := SomaPar * 3;
    i := 0;
    while i < (SomaPar + SomaImpar) do
      Inc(i, 10);
    Result := IntToStr(i - (SomaPar + SomaImpar));
  end;

var
  codbarras: string;
  valortotal, valordescontovarejo: Double;
  flagusoudesconto, valorunitdesc, vrcxa: double;
  achoucombinacao: integer;
  Params: TParametros;
begin

  if not charinset(Key , ['0'..'9', #8, #13]) then
    Key := #0
  else
  begin
    if (pnlCodBarras.Caption = 'Informe Cartão de Desconto') then
      pnlCodBarras.Caption := '';
    pnlCodBarras.Caption := pnlCodBarras.Caption + (Key);
    if Key = #13 then
    begin
      if (length(trim(pnlCodBarras.Caption)) <> 13) then
      begin
        ShowMessage('ERRO! Código inválido ou leitor desconfigurado');
        pnlCodBarras.Caption := 'Informe Cartão de Desconto';
      end
      else if (copy(pnlCodBarras.Caption, 1, 1) <> '0') and (copy(pnlCodBarras.Caption, 1, 1) <> '1') and (copy(pnlCodBarras.Caption, 1, 7) <> '7585333') then
      begin
        ShowMessage('ERRO! Cartão inválido');
        pnlCodBarras.Caption := 'Informe Cartão de Desconto';
      end
      else
      begin
        codbarras := pnlCodBarras.Caption;

        setLength(Params, 1); // linhas
        setLength(Params[0], 2); // colunas

        Params[0][0] := 'codigoBarras';
        Params[0][1] := codbarras;

        if copy(codbarras, 1, 1) = '0' then
        begin

          raise Exception.Create('Para desconto médico utilize Campanhas');

          qryAchaMedico.Close;
          qryAchaMedico.SQL.Clear;
          qryAchaMedico.SQL.Add(' select fc04000.nomemed,fc04300.cdesp, ');
          qryAchaMedico.SQL.Add('        ( select fc99999.parametro ');
          qryAchaMedico.SQL.Add('            from fc99999 ');
          qryAchaMedico.SQL.Add('           where fc99999.cdpar=14 ');
          qryAchaMedico.SQL.Add('             and fc99999.argumento=' + quotedstr('ESPEC'));
          qryAchaMedico.SQL.Add('             and subargum=fc04300.cdesp ) as ESPECIALIDADE, ');
          qryAchaMedico.SQL.Add('        ( select fc99999.parametro ');
          qryAchaMedico.SQL.Add('            from fc99999 ');
          qryAchaMedico.SQL.Add('           where fc99999.cdpar=14 ');
          qryAchaMedico.SQL.Add('             and ARGUMento=' + quotedstr('PFCRM'));
          qryAchaMedico.SQL.Add('             and subargum=fc04000.pfcrm ) as PROFISSAO ');
          qryAchaMedico.SQL.Add('   from fc04000,fc04300 ');
          qryAchaMedico.SQL.Add('  where fc04000.pfcrm=fc04300.pfcrm ');
          qryAchaMedico.SQL.Add('    and fc04000.ufcrm=fc04300.ufcrm ');
          qryAchaMedico.SQL.Add('    and fc04000.nrcrm=fc04300.nrcrm ');
          qryAchaMedico.SQL.Add('    and fc04000.ufcrm=' + quotedstr(codestado(copy(codbarras, 3, 2))));
          qryAchaMedico.SQL.Add('    and fc04000.pfcrm=' + quotedstr(copy(codbarras, 6, 1)));
          qryAchaMedico.SQL.Add('    and fc04000.nrcrm=' + inttostr(strtoint(copy(codbarras, 7, 6))));
          qryAchaMedico.Open;

          if qryAchaMedico.IsEmpty then
            raise Exception.Create('Médico não cadastrado no sistema');

          qryGravaLog.Close;
          qryGravaLog.SQL.Clear;
          qryGravaLog.SQL.Add(' select * ');
          qryGravaLog.SQL.Add('   from CARTBLOQUEADOS ');
          qryGravaLog.SQL.Add('  WHERE NRCARTAO=' + QuotedStr(codbarras));
          qryGravaLog.Open;

          if not (qryGravaLog.IsEmpty) then
            raise Exception.Create('Cartão está bloqueado, favor entrar em contato com a CIG');

          qryGravaLog.Close;

          lblTipoCartao.Caption := 'Cartão Privilege - Médico';
          lblNomeMedico.Caption := qryAchaMedico.FieldValues['nomemed'];
          lblDescontoValor.Caption := '20%';

          if MessageDlg('Deseja confirmar desconto de ' + lblDescontoValor.Caption + ' para o(a) médico(a)' + #13 + lblNomeMedico.Caption + '?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
          begin

            desc1form := StrToFloat('20');
            desc2var := StrToFloat('20');
            tpdescform := '2';
            tpdescvar := '2';

            InfoTela.TerminalBalcao[0].PercentualDesconto := 20;
            InfoTela.TerminalBalcao[0].TipoDesconto := '2';
            flagusoudesconto := 0;

            Desconto_Cartao(flagusoudesconto, InfoTela, Params);

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
            qryInsereDesconto.SQL.Add('   from fc32110 ');
            qryInsereDesconto.SQL.Add('  where  cdfil=' + trim(frmPrincipal.edtLoja.Text));
            qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
            qryInsereDesconto.SQL.Add('    and dtope >=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
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
            qryInsereDesconto.SQL.Add('    and dtope >=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.CommitRetaining;

            qryInsereDesconto.Close;
            qrySelecionaDesconto.Close;

            qryGravaLog.Close;
            qryGravaLog.SQL.Clear;
            qryGravaLog.SQL.Add(' insert into descconcedidos ( ');
            qryGravaLog.SQL.Add('            CDFIL,TBALCAO,DATA,HORA,USUARIO,CDFUN,TIPOCARTAO,TITULARCARTAO, ');
            qryGravaLog.SQL.Add('            DESCONTO,VRDESC,NRCARTAO,PFCRM,UFCRM,NRCRM,CODESP,ESPECIALIDADE, ');
            qryGravaLog.SQL.Add('            PARENTESCO,PROFISSAO,VRTOTAL,CLIENTE,NOMEFUNC) ');
            qryGravaLog.SQL.Add('     VALUES (');
            qryGravaLog.SQL.Add(trim(frmPrincipal.edtLoja.Text) + ',');
            qryGravaLog.SQL.Add(trim(frmPrincipal.edtTerminalBalcao.Text) + ',');
            qryGravaLog.SQL.Add(quotedstr(FormatDateTime('dd.mm.yyyy', now)) + ',');
            qryGravaLog.SQL.Add(QuotedStr(FormatDateTime('hh:nn:ss', now)) + ',');
            qryGravaLog.SQL.Add(quotedstr(usu) + ',');
            qryGravaLog.SQL.Add(inttostr(cdfun) + ',');
            qryGravaLog.SQL.Add(quotedstr('P') + ',');
            qryGravaLog.SQL.Add(quotedstr(lblNomeMedico.Caption) + ',');
            qryGravaLog.SQL.Add(copy(lblDescontoValor.Caption, 1, 2) + ',');
            qryGravaLog.SQL.Add(TrocaVirgPPto(floattostr(valoratual * ((StrToInt(copy(lblDescontoValor.Caption, 1, 2))) * 0.01))) + ',');
            qryGravaLog.SQL.Add(quotedstr(trim(codbarras)) + ',');
            qryGravaLog.SQL.Add(quotedstr(copy(codbarras, 6, 1)) + ',');
            qryGravaLog.SQL.Add(quotedstr(codestado(copy(codbarras, 3, 2))) + ',');
            qryGravaLog.SQL.Add(inttostr(strtoint(copy(codbarras, 7, 6))) + ',');
            qryGravaLog.SQL.Add(quotedstr(qryAchaMedico.FieldValues['cdesp']) + ',');
            qryGravaLog.SQL.Add(quotedstr(COPY(qryAchaMedico.FieldValues['ESPECIALIDADE'], 1, 20)) + ',');
            qryGravaLog.SQL.Add(quotedstr(frmPrincipal.cbDescontoTipo.Text) + ',');
            qryGravaLog.SQL.Add(quotedstr(qryAchaMedico.FieldValues['PROFISSAO']) + ',');
            qryGravaLog.SQL.Add(TrocaVirgPPto(FloatToStr(vrtot)) + ',');
            qryGravaLog.SQL.Add(quotedstr(frmPrincipal.qryTerminalBalcao.FieldValues['NOMECLI']) + ',');
            qryGravaLog.SQL.Add(quotedstr(frmPrincipal.qryTerminalBalcao.FieldValues['NOMEFUN']) + ')');

            qryGravaLog.Open;
            qryGravaLog.Transaction.CommitRetaining;
            qryGravaLog.Close;

            frmPrincipal.qryTerminalBalcao.Transaction.CommitRetaining;
            frmPrincipal.qryTerminalBalcao.Close;
            frmPrincipal.qryTerminalBalcao.Open;
            frmPrincipal.qryTerminalBalcao.First;

            while not frmPrincipal.qryTerminalBalcao.Eof do
            begin
              qryGravaLog.Close;
              qryGravaLog.SQL.Clear;
              qryGravaLog.SQL.Add(' INSERT INTO DESCCONCITENS ( ');
              qryGravaLog.SQL.Add('     CDFIL,CDTML,DTOPE,OPERID,NRCPM,ITEMID,TPITM,CDPRO,QUANT,PRUNI,PTDSC, ');
              qryGravaLog.SQL.Add('     TPDSC,VRDSC,VRLIQ,VRCXA,VRDSCG,VRTXAG,TPPAG,VRTOT,VRTXA,VRDSCV,VRTXAV,DESCRPRD) ');
              qryGravaLog.SQL.Add(' VALUES ( ');
              qryGravaLog.SQL.Add(IntToStr(frmPrincipal.qryTerminalBalcao.FieldValues['CDFIL']) + ',');
              qryGravaLog.SQL.Add(QuotedStr(frmPrincipal.qryTerminalBalcao.FieldValues['CDTML']));
              qryGravaLog.SQL.Add(',' + QuotedStr(FormatDateTime('dd.mm.yyyy', frmPrincipal.qryTerminalBalcao.FieldValues['DTOPE'])));
              qryGravaLog.SQL.Add(',' + inttostr(frmPrincipal.qryTerminalBalcao.FieldValues['OPERID']));
              qryGravaLog.SQL.Add(',' + inttostr(frmPrincipal.qryTerminalBalcao.FieldValues['NRCPM']));
              qryGravaLog.SQL.Add(',' + inttostr(frmPrincipal.qryTerminalBalcao.FieldValues['ITEMID']));
              qryGravaLog.SQL.Add(',' + quotedstr(frmPrincipal.qryTerminalBalcao.FieldValues['TPITM']));
              qryGravaLog.SQL.Add(',' + inttostr(frmPrincipal.qryTerminalBalcao.FieldValues['CDPRO']));
              qryGravaLog.SQL.Add(',' + inttostr(frmPrincipal.qryTerminalBalcao.FieldValues['QUANT']));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['PRUNI'])));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['PTDSC'])));
              qryGravaLog.SQL.Add(',' + quotedstr('A'));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRDSC'])));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRLIQ'])));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRCXA'])));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRDSCG'])));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRTXAG'])));
              qryGravaLog.SQL.Add(',' + quotedstr(frmPrincipal.qryTerminalBalcao.FieldValues['TPPAG']));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['SEMDESCONTO'])));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRTXA'])));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRDSCV'])));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRTXAV'])));
              qryGravaLog.SQL.Add(',' + quotedstr(frmPrincipal.qryTerminalBalcao.FieldValues['DESCRPRD']) + ')');

              qryGravaLog.Open;
              qryGravaLog.Transaction.CommitRetaining;
              frmPrincipal.qryTerminalBalcao.Next;
            end;
            frmPrincipal.qryTerminalBalcao.Close;

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' update totvsconf ');
            qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N'));
            qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text));
            qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.Commit;
            qryInsereDesconto.Close;

            ShowMessage('Desconto inserido com sucesso');
            qryAchaMedico.Close;
            frmCartaoDesconto.Close;
          end
          else
          begin
            lblTipoCartao.Caption := '';
            lblNomeMedico.Caption := '';
            lblDescontoValor.Caption := '';
            pnlCodBarras.Caption := 'Informe Cartão de Desconto';
          end;
        end;

        if copy(codbarras, 1, 1) = '1' then
        begin

          raise Exception.Create('Para desconto médico utilize Campanhas');

          qryAchaMedico.Close;
          qryAchaMedico.SQL.Clear;
          qryAchaMedico.SQL.Add(' select fc04000.nomemed,fc04300.cdesp, ');
          qryAchaMedico.SQL.Add('        ( select fc99999.parametro ');
          qryAchaMedico.SQL.Add('            from fc99999 ');
          qryAchaMedico.SQL.Add('           where fc99999.cdpar=14 ');
          qryAchaMedico.SQL.Add('             and fc99999.argumento=' + quotedstr('ESPEC'));
          qryAchaMedico.SQL.Add('             and subargum=fc04300.cdesp ) as ESPECIALIDADE, ');
          qryAchaMedico.SQL.Add('        ( select fc99999.parametro ');
          qryAchaMedico.SQL.Add('            from fc99999 ');
          qryAchaMedico.SQL.Add('           where fc99999.cdpar=14 ');
          qryAchaMedico.SQL.Add('             and ARGUMento=' + quotedstr('PFCRM'));
          qryAchaMedico.SQL.Add('             and subargum=fc04000.pfcrm ) as PROFISSAO ');
          qryAchaMedico.SQL.Add('   from fc04000,fc04300 ');
          qryAchaMedico.SQL.Add('  where fc04000.pfcrm=fc04300.pfcrm ');
          qryAchaMedico.SQL.Add('    and fc04000.ufcrm=fc04300.ufcrm ');
          qryAchaMedico.SQL.Add('    and fc04000.nrcrm=fc04300.nrcrm ');
          qryAchaMedico.SQL.Add('    and fc04000.ufcrm=' + quotedstr(codestado(copy(codbarras, 3, 2))));
          qryAchaMedico.SQL.Add('    and fc04000.pfcrm=' + quotedstr(copy(codbarras, 6, 1)));
          qryAchaMedico.SQL.Add('    and fc04000.nrcrm=' + inttostr(strtoint(copy(codbarras, 7, 6))));
          qryAchaMedico.Open;

          if qryAchaMedico.IsEmpty then
            raise Exception.Create('Médico não cadastrado no sistema');

          qryGravaLog.Close;
          qryGravaLog.SQL.Text := 'select * from CARTBLOQUEADOS WHERE NRCARTAO=' + QuotedStr(codbarras);
          qryGravaLog.Open;

          if not (qryGravaLog.IsEmpty) then
            raise Exception.Create('Cartão está bloqueado, favor entrar em contato com a CIG');

          qryGravaLog.Close;

          lblTipoCartao.Caption := 'Cartão Privilege - Peeling';
          lblNomeMedico.Caption := qryAchaMedico.FieldValues['nomemed'];
          lblDescontoValor.Caption := '30%';

          if MessageDlg('Deseja confirmar desconto de ' + lblDescontoValor.Caption + ' para o(a) médico(a)' + #13 + lblNomeMedico.Caption + '?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
          begin

            desc1form := StrToFloat('30');
            desc2var := StrToFloat('30');
            tpdescform := '2';
            tpdescvar := '2';

            InfoTela.TerminalBalcao[0].PercentualDesconto := 30;
            InfoTela.TerminalBalcao[0].TipoDesconto := '2';
            flagusoudesconto := 0;

            Desconto_Cartao(flagusoudesconto, InfoTela, Params);

            if flagusoudesconto = 1 then
            begin

              qryInsereDesconto.Close;
              qryInsereDesconto.SQL.Clear;
              qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
              qryInsereDesconto.SQL.Add('   from fc32110 ');
              qryInsereDesconto.SQL.Add('  where  cdfil=' + trim(frmPrincipal.edtLoja.Text));
              qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
              qryInsereDesconto.SQL.Add('    and dtope >= ' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
              qryInsereDesconto.Open;
              valortotal := qryInsereDesconto.FieldValues['VALOR'];
              qryInsereDesconto.Close;

              qryInsereDesconto.Close;
              qryInsereDesconto.SQL.Clear;
              qryInsereDesconto.SQL.Add(' update fc32100 ');
              qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('privilegem') + ', ' );
              qryInsereDesconto.SQL.Add('        vrtot=' + TrocaVirgPPto(FloatToStr(valortotal)) + ', ');
              qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ',');
              qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)) + ',');
              qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + TrocaVirgPPto(FloatToStr(valortotal)));
              qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
              qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
              qryInsereDesconto.SQL.Add('    and dtope >=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
              qryInsereDesconto.ExecSQL;
              qryInsereDesconto.Connection.CommitRetaining;
              qryInsereDesconto.Close;
              qrySelecionaDesconto.Close;

              qryGravaLog.Close;
              qryGravaLog.SQL.Clear;
              qryGravaLog.SQL.Add(' insert into descconcedidos ( ');
              qryGravaLog.SQL.Add('               CDFIL,TBALCAO,DATA,HORA,USUARIO,CDFUN,TIPOCARTAO,TITULARCARTAO,DESCONTO,VRDESC,NRCARTAO,PFCRM, ');
              qryGravaLog.SQL.Add('               UFCRM,NRCRM,CODESP,ESPECIALIDADE,PARENTESCO,PROFISSAO,VRTOTAL) ');
              qryGravaLog.SQL.Add(' VALUES (');
              qryGravaLog.SQL.Add(trim(frmPrincipal.edtLoja.Text) + ',');
              qryGravaLog.SQL.Add(trim(frmPrincipal.edtTerminalBalcao.Text) + ',');
              qryGravaLog.SQL.Add(quotedstr(FormatDateTime('dd.mm.yyyy', now)) + ',');
              qryGravaLog.SQL.Add(QuotedStr(FormatDateTime('hh:nn:ss', now)) + ',');
              qryGravaLog.SQL.Add(quotedstr(usu) + ',');
              qryGravaLog.SQL.Add(inttostr(cdfun) + ',');
              qryGravaLog.SQL.Add(quotedstr('P') + ',');
              qryGravaLog.SQL.Add(quotedstr(lblNomeMedico.Caption) + ',');
              qryGravaLog.SQL.Add(copy(lblDescontoValor.Caption, 1, 2) + ',');
              qryGravaLog.SQL.Add(TrocaVirgPPto(floattostr(valoratual * ((StrToInt(copy(lblDescontoValor.Caption, 1, 2))) * 0.01))) + ',');
              qryGravaLog.SQL.Add(quotedstr(trim(codbarras)) + ',');
              qryGravaLog.SQL.Add(quotedstr(copy(codbarras, 6, 1)) + ',');
              qryGravaLog.SQL.Add(quotedstr(codestado(copy(codbarras, 3, 2))) + ',');
              qryGravaLog.SQL.Add(inttostr(strtoint(copy(codbarras, 7, 6))) + ',');
              qryGravaLog.SQL.Add(quotedstr(qryAchaMedico.FieldValues['cdesp']) + ',');
              qryGravaLog.SQL.Add(quotedstr(qryAchaMedico.FieldValues['ESPECIALIDADE']) + ',');
              qryGravaLog.SQL.Add(quotedstr(frmPrincipal.cbDescontoTipo.Text) + ',');
              qryGravaLog.SQL.Add(quotedstr(qryAchaMedico.FieldValues['PROFISSAO']) + ',');
              qryGravaLog.SQL.Add(TrocaVirgPPto(FloatToStr(vrtot)) + ')');
              qryGravaLog.Open;
              qryGravaLog.Transaction.CommitRetaining;
              qryGravaLog.Close;

              frmPrincipal.qryTerminalBalcao.Transaction.CommitRetaining;
              frmPrincipal.qryTerminalBalcao.Close;
              frmPrincipal.qryTerminalBalcao.Open;
              frmPrincipal.qryTerminalBalcao.First;
              while not frmPrincipal.qryTerminalBalcao.Eof do
              begin
                qryGravaLog.Close;
                qryGravaLog.SQL.Clear;
                qryGravaLog.SQL.Add(' INSERT INTO DESCCONCITENS ( ');
                qryGravaLog.SQL.Add('                   CDFIL,CDTML,DTOPE,OPERID,NRCPM,ITEMID,TPITM,CDPRO,QUANT,PRUNI,PTDSC, ');
                qryGravaLog.SQL.Add('                   TPDSC,VRDSC,VRLIQ,VRCXA,VRDSCG,VRTXAG,TPPAG,VRTOT,VRTXA,VRDSCV,VRTXAV,DESCRPRD) ');
                qryGravaLog.SQL.Add('      VALUES ( ');
                qryGravaLog.SQL.Add(IntToStr(frmPrincipal.qryTerminalBalcao.FieldValues['CDFIL']) + ',');
                qryGravaLog.SQL.Add(QuotedStr(frmPrincipal.qryTerminalBalcao.FieldValues['CDTML']));
                qryGravaLog.SQL.Add(',' + QuotedStr(FormatDateTime('dd.mm.yyyy', frmPrincipal.qryTerminalBalcao.FieldValues['DTOPE'])));
                qryGravaLog.SQL.Add(',' + inttostr(frmPrincipal.qryTerminalBalcao.FieldValues['OPERID']));
                qryGravaLog.SQL.Add(',' + inttostr(frmPrincipal.qryTerminalBalcao.FieldValues['NRCPM']));
                qryGravaLog.SQL.Add(',' + inttostr(frmPrincipal.qryTerminalBalcao.FieldValues['ITEMID']));
                qryGravaLog.SQL.Add(',' + quotedstr(frmPrincipal.qryTerminalBalcao.FieldValues['TPITM']));
                qryGravaLog.SQL.Add(',' + inttostr(frmPrincipal.qryTerminalBalcao.FieldValues['CDPRO']));
                qryGravaLog.SQL.Add(',' + inttostr(frmPrincipal.qryTerminalBalcao.FieldValues['QUANT']));
                qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['PRUNI'])));
                qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['PTDSC'])));
                qryGravaLog.SQL.Add(',' + quotedstr('A'));
                qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRDSC'])));
                qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRLIQ'])));
                qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRCXA'])));
                qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRDSCG'])));
                qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRTXAG'])));
                qryGravaLog.SQL.Add(',' + quotedstr(frmPrincipal.qryTerminalBalcao.FieldValues['TPPAG']));
                qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['SEMDESCONTO'])));
                qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRTXA'])));
                qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRDSCV'])));
                qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRTXAV'])));
                qryGravaLog.SQL.Add(',' + quotedstr(frmPrincipal.qryTerminalBalcao.FieldValues['DESCRPRD']) + ')');

                qryGravaLog.Open;
                qryGravaLog.Transaction.CommitRetaining;
                frmPrincipal.qryTerminalBalcao.Next;
              end;
              frmPrincipal.qryTerminalBalcao.Close;

              qryInsereDesconto.Close;
              qryInsereDesconto.SQL.Clear;
              qryInsereDesconto.SQL.Add(' update totvsconf ');
              qryInsereDesconto.SQL.Add('    set ENV=' + quotedstr('N') );
              qryInsereDesconto.SQL.Add('  where fil=' + trim(frmPrincipal.edtLoja.Text) );
              qryInsereDesconto.SQL.Add('    and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text));
              qryInsereDesconto.ExecSQL;
              qryInsereDesconto.Connection.Commit;
              qryInsereDesconto.Close;

              ShowMessage('Desconto inserido com sucesso');
              qryAchaMedico.Close;
              frmCartaoDesconto.Close;
            end
            else
            begin
              ShowMessage('Não há fórmulas válidas para o desconto nessa compra');
              lblTipoCartao.Caption := '';
              lblNomeMedico.Caption := '';
              lblDescontoValor.Caption := '';
              pnlCodBarras.Caption := 'Informe Cartão de Desconto';
            end;

          end
          else
          begin
            lblTipoCartao.Caption := '';
            lblNomeMedico.Caption := '';
            lblDescontoValor.Caption := '';
            pnlCodBarras.Caption := 'Informe Cartão de Desconto';
          end;
        end;

        if copy(codbarras, 1, 7) = '7585333' then
        begin
          if CalculaDigEAN13(copy(codbarras, 1, 12)) <> copy(codbarras, 13, 1) then
            raise Exception.Create('Código Inválido, favor verifique o' + #13 + ' código informado e tente novamente');

          lblTipoCartao.Caption := 'Cartão Desconto Campanha';
          lblNomeMedico.Caption := 'Portador';
          lblDescontoValor.Caption := '10%';

          qryGravaLog.Close;
          qryGravaLog.SQL.Clear;
          qryGravaLog.SQL.Add(' select * ');
          qryGravaLog.SQL.Add('   from descconcedidos ');
          qryGravaLog.SQL.Add('  where tipocartao=' + quotedstr('C'));
          qryGravaLog.SQL.Add('    and nrcrm=' + inttostr(strtoint(copy(codbarras, 8, 5))));
          qryGravaLog.Open;

          if not (qryGravaLog.IsEmpty) then
            showmessage('Cartão de desconto já utilizado')
          else if MessageDlg('Deseja confirmar desconto de ' + lblDescontoValor.Caption + ' no varejo, relativo a Campanha Marketing?', mtconfirmation, [mbYes, MbNo], 0) = mryes then
          begin

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' update fc32110 ');
            qryInsereDesconto.SQL.Add('    set pruniliq=(pruni)-(pruni*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + ')), ');
            qryInsereDesconto.SQL.Add('        vrcxa=(vrtot)-(vrtot*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + ')), ');
            qryInsereDesconto.SQL.Add('        vrliq=(vrtot)-(vrtot*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + ')), ');
            qryInsereDesconto.SQL.Add('        vrdsc=(pruni*quant*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01))+ ')), ');
            qryInsereDesconto.SQL.Add('        PTDSC=' + copy(lblDescontoValor.Caption, 1, 2) + ', ');
            qryInsereDesconto.SQL.Add('        BCPIS=(VRCXA-(pruni*quant*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + '))), ');
            qryInsereDesconto.SQL.Add('        VRPIS=(((VRCXA-(pruni*quant*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + '))))*ALPIS)/100, ');
            qryInsereDesconto.SQL.Add('        BCCOFINS=(VRCXA-(pruni*quant*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + '))),');
            qryInsereDesconto.SQL.Add('        BCICM=(VRCXA-(pruni*quant*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + '))),');
            qryInsereDesconto.SQL.Add('        VRCOFINS=(((VRCXA-(pruni*quant*(' + TrocaVirgPPto(FloatToStr(StrToInt(copy(lblDescontoValor.Caption, 1, 2)) * 0.01)) + '))))*ALCOFINS)/100 ');
            qryInsereDesconto.SQL.Add('  where tpitm=' + quotedstr('V'));
            qryInsereDesconto.SQL.Add('    and cdfil=' + trim(frmPrincipal.edtLoja.Text));
            qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
            qryInsereDesconto.SQL.Add('    and dtope >=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
            qryInsereDesconto.SQL.Add('    and tpitm = ' + quotedstr('V'));

            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.CommitRetaining;

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' select sum(vrliq) as VALOR ');
            qryInsereDesconto.SQL.Add('   from fc32110 ');
            qryInsereDesconto.SQL.Add('  where  cdfil=' + trim(frmPrincipal.edtLoja.Text) );
            qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
            qryInsereDesconto.SQL.Add('    and dtope >=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
            qryInsereDesconto.Open;

            valortotal := qryInsereDesconto.FieldValues['VALOR'];

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' select sum(vrdsc) as VALOR ');
            qryInsereDesconto.SQL.Add('   from fc32110 ');
            qryInsereDesconto.SQL.Add('  where  cdfil=' + trim(frmPrincipal.edtLoja.Text) );
            qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
            qryInsereDesconto.SQL.Add('    and tpitm=' + quotedstr('V'));
            qryInsereDesconto.SQL.Add('    and dtope >=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
            qryInsereDesconto.Open;

            valordescontovarejo := qryInsereDesconto.FieldValues['VALOR'];

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Clear;
            qryInsereDesconto.SQL.Add(' update fc32100 ');
            qryInsereDesconto.SQL.Add('    set useridaut=' + quotedstr('campanhamkt') + ', ');
            qryInsereDesconto.SQL.Add('        vrtot=' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
            qryInsereDesconto.SQL.Add('        vrliq=VRTXAG+' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
            qryInsereDesconto.SQL.Add('        vrcxa=VRTXAG+' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))) + ', ');
            qryInsereDesconto.SQL.Add('        vrarc=VRTXAG+' + quotedstr(TrocaVirgPPto(FloatToStr(valortotal))));
            qryInsereDesconto.SQL.Add('  where cdfil=' + trim(frmPrincipal.edtLoja.Text));
            qryInsereDesconto.SQL.Add('    and nrcpm=' + trim(frmPrincipal.edtTerminalBalcao.Text));
            qryInsereDesconto.SQL.Add('    and dtope >=' + QuotedStr(FormatDateTime('dd.mm.yyyy', IncDay(now, -1))));
            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.CommitRetaining;
            qryInsereDesconto.Close;

            qryGravaLog.Close;
            qryGravaLog.SQL.Clear;
            qryGravaLog.SQL.Add(' insert into descconcedidos ( ');
            qryGravaLog.SQL.Add('               CDFIL,TBALCAO,DATA,HORA,USUARIO,CDFUN,TIPOCARTAO, ');
            qryGravaLog.SQL.Add('               TITULARCARTAO,DESCONTO,VRDESC,NRCARTAO,NRCRM,VRTOTAL) ');
            qryGravaLog.SQL.Add('    VALUES (');
            qryGravaLog.SQL.Add(trim(frmPrincipal.edtLoja.Text) + ',');
            qryGravaLog.SQL.Add(trim(frmPrincipal.edtTerminalBalcao.Text) + ',');
            qryGravaLog.SQL.Add(quotedstr(FormatDateTime('dd.mm.yyyy', now)) + ',');
            qryGravaLog.SQL.Add(QuotedStr(FormatDateTime('hh:nn:ss', now)) + ',');
            qryGravaLog.SQL.Add(quotedstr(usu) + ',');
            qryGravaLog.SQL.Add(inttostr(cdfun) + ',');
            qryGravaLog.SQL.Add(quotedstr('C') + ',');
            qryGravaLog.SQL.Add(quotedstr(lblNomeMedico.Caption) + ',');
            qryGravaLog.SQL.Add(copy(lblDescontoValor.Caption, 1, 2) + ',');
            qryGravaLog.SQL.Add(TrocaVirgPPto(floattostr(valordescontovarejo)) + ',');
            qryGravaLog.SQL.Add(quotedstr(trim(codbarras)) + ',');
            qryGravaLog.SQL.Add(inttostr(strtoint(copy(codbarras, 8, 5))) + ',');
            qryGravaLog.SQL.Add(TrocaVirgPPto(FloatToStr(valortotal)) + ')');
            qryGravaLog.Open;
            qryGravaLog.Transaction.CommitRetaining;
            qryGravaLog.Close;

            frmPrincipal.qryTerminalBalcao.Transaction.CommitRetaining;
            frmPrincipal.qryTerminalBalcao.Close;
            frmPrincipal.qryTerminalBalcao.Open;
            frmPrincipal.qryTerminalBalcao.First;
            while not frmPrincipal.qryTerminalBalcao.Eof do
            begin
              qryGravaLog.Close;
              qryGravaLog.SQL.Text := ' INSERT INTO DESCCONCITENS (CDFIL,CDTML,DTOPE,OPERID,NRCPM,ITEMID,TPITM,CDPRO,QUANT,PRUNI,PTDSC,TPDSC,VRDSC,VRLIQ,VRCXA,VRDSCG,VRTXAG,TPPAG,VRTOT,VRTXA,VRDSCV,VRTXAV,DESCRPRD) VALUES ( ';
              qryGravaLog.SQL.Add(IntToStr(frmPrincipal.qryTerminalBalcao.FieldValues['CDFIL']) + ',');
              qryGravaLog.SQL.Add(QuotedStr(frmPrincipal.qryTerminalBalcao.FieldValues['CDTML']));
              qryGravaLog.SQL.Add(',' + QuotedStr(FormatDateTime('dd.mm.yyyy', frmPrincipal.qryTerminalBalcao.FieldValues['DTOPE'])));
              qryGravaLog.SQL.Add(',' + inttostr(frmPrincipal.qryTerminalBalcao.FieldValues['OPERID']));
              qryGravaLog.SQL.Add(',' + inttostr(frmPrincipal.qryTerminalBalcao.FieldValues['NRCPM']));
              qryGravaLog.SQL.Add(',' + inttostr(frmPrincipal.qryTerminalBalcao.FieldValues['ITEMID']));
              qryGravaLog.SQL.Add(',' + quotedstr(frmPrincipal.qryTerminalBalcao.FieldValues['TPITM']));
              qryGravaLog.SQL.Add(',' + inttostr(frmPrincipal.qryTerminalBalcao.FieldValues['CDPRO']));
              qryGravaLog.SQL.Add(',' + inttostr(frmPrincipal.qryTerminalBalcao.FieldValues['QUANT']));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['PRUNI'])));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['PTDSC'])));
              qryGravaLog.SQL.Add(',' + quotedstr('8'));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRDSC'])));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRLIQ'])));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRCXA'])));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRDSCG'])));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRTXAG'])));
              qryGravaLog.SQL.Add(',' + quotedstr(frmPrincipal.qryTerminalBalcao.FieldValues['TPPAG']));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['SEMDESCONTO'])));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRTXA'])));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRDSCV'])));
              qryGravaLog.SQL.Add(',' + TrocaVirgPPto(floattostr(frmPrincipal.qryTerminalBalcao.FieldValues['VRTXAV'])));
              qryGravaLog.SQL.Add(',' + quotedstr(frmPrincipal.qryTerminalBalcao.FieldValues['DESCRPRD']) + ')');

              qryGravaLog.Open;
              qryGravaLog.Transaction.CommitRetaining;
              frmPrincipal.qryTerminalBalcao.Next;
            end;
            frmPrincipal.qryTerminalBalcao.Close;

            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Text := 'update totvsconf set ENV=' + quotedstr('N') + ' where  fil=' + trim(frmPrincipal.edtLoja.Text) + ' and cupom=' + trim(frmPrincipal.edtTerminalBalcao.Text);
            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.Commit;
            qryInsereDesconto.Close;

            ShowMessage('Desconto inserido com sucesso');
            qryAchaMedico.Close;
            frmCartaoDesconto.Close;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmCartaoDesconto.FormShow(Sender: TObject);
begin
  lblTipoCartao.Caption := '';
  lblNomeMedico.Caption := '';
  lblDescontoValor.Caption := '';
  pnlCodBarras.Caption := 'Informe Cartão de Desconto';
end;

end.






