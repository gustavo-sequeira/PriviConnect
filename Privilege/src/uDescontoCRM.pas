unit uDescontoCRM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, IBQuery, StdCtrls, ExtCtrls, Grids, Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmDescontoCRM = class(TForm)
    pnlCodBarras: TPanel;
    pnlInformacoes: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblCupomFiscal: TLabel;
    lblNomecliente: TLabel;
    lblDescontoPreco: TLabel;
    qryGravaLog: TIBQuery;
    qryAchaCupom: TIBQuery;
    lblDescontoValor: TLabel;
    qryTemp: TIBQuery;
    stgDescClientes: TStringGrid;
    btConclui: TSpeedButton;
    btDigitacao: TSpeedButton;
    qryConsultaCliDesconto: TIBQuery;
    qryInsereDesconto: TFDQuery;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure limpacupom;
    procedure btConcluiClick(Sender: TObject);
    procedure btDigitacaoClick(Sender: TObject);
    procedure incluicupom;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDescontoCRM: TfrmDescontoCRM;
  codbarras,email:string;
  valortotal,usvrcpfiscal,valordesconto : double;
  cdfilatual,uscpfiscal,cdcli:integer;

implementation

uses uPrincipal, uCartaoDesconto, uEmailCRM, udmDescontos, uBuscaCupom, System.UITypes;

{$R *.dfm}

function TrocaVirgPPto(Valor: string): String;
   var i:integer;
begin
if valor=null then valor:='0';
    if Valor <>'' then begin
        for i := 0 to Length(Valor) do begin
            if Valor[i]=',' then Valor[i]:='.';

        end;
     end;
     Result := valor;
end;


procedure TfrmDescontoCRM.incluicupom;
var i:integer;
begin

   cdcli:=qryAchaCupom.FieldValues['cdcli'];

   if (strtodate(formatdatetime('dd/mm/yyyy',now)) < qryAchaCupom.FieldValues['dtvalinicio']) or ( strtodate(formatdatetime('dd/mm/yyyy',now)) > qryAchaCupom.FieldValues['dtvalfim']) then
    begin
     limpacupom;
     raise Exception.Create('Cupom fora do período de validade :'+#13+'Data Inicial : '+FormatDateTime('dd/mm/yyyy',qryAchaCupom.FieldValues['dtvalinicio'] )+' - Data Final : '+FormatDateTime('dd/mm/yyyy',qryAchaCupom.FieldValues['dtvalfim'] ));
    end;

   if (qryAchaCupom.FieldValues['usado'] = '1' ) then
    begin
      limpacupom;
      raise Exception.Create('Esse cupom já foi utilizado dia '+FormatDateTime('dd/mm/yyyy',qryAchaCupom.FieldValues['dtuso'])+#13+' pelo cliente : '+qryAchaCupom.FieldValues['usnomecli'] );
    end;

    qryTemp.Close;
    qryTemp.SQL.Text := 'select count(*) as qtdvezes from descclientes where nrcpf='+quotedstr(qryAchaCupom.FieldValues['nrcpf'])+' and dtemissao ='+quotedstr(FormatDateTime('dd.mm.yyyy',now ));
//                              clipboard.astext := qrytemp.SQL.Text;
    qryTemp.Open;


   if (qryTemp.FieldValues['qtdvezes'] > 2 ) then
    begin
      limpacupom;
      qryTemp.Close;
      raise Exception.Create('Limite máximo diário para emissão de cupons já alcançado para este CPF - 2' );
    end;

   qryTemp.Close;

   for i:=0  to stgDescClientes.RowCount-1 do
    begin
     if (inttostr(strtoint(copy(codbarras,5,6))) = stgDescClientes.Cells[1,i]) then
       raise Exception.Create('Cupom já incluso para desconto' );
    end;



   lblCupomFiscal.Caption   := inttostr(qryAchaCupom.FieldValues['CPFISCAL']);
   lblNomecliente.Caption   := qryAchaCupom.FieldValues['nomecli'];
   lblDescontoPreco.Caption := FloatToStr(qryAchaCupom.FieldValues['vrdesc']);


   if trim(stgDescClientes.Cells[1,stgDescClientes.RowCount-1])<>'' then
      begin
       stgDescClientes.RowCount := stgDescClientes.RowCount+1;
      end;

   stgDescClientes.Cells[0,stgDescClientes.RowCount-1] := inttostr(cdfilatual);
   stgDescClientes.Cells[1,stgDescClientes.RowCount-1] := inttostr(strtoint(copy(codbarras,5,6)));
   stgDescClientes.Cells[2,stgDescClientes.RowCount-1] := lblNomecliente.Caption;
   stgDescClientes.Cells[3,stgDescClientes.RowCount-1] := StringReplace(lblDescontoPreco.Caption,'R$ ','',[rfReplaceAll, rfIgnoreCase]);

   valordesconto := 0;
   for i:=1 to stgDescClientes.RowCount-1 do
     begin
       valordesconto := valordesconto+strtofloat(stgDescClientes.Cells[3,i]);
     end;

   if valordesconto > strtofloat( trim(StringReplace(frmPrincipal.lblFinal.Caption,'R$','',[rfReplaceAll, rfIgnoreCase]))) then
      lblDescontoPreco.Caption :=  trim(StringReplace(frmPrincipal.lblFinal.Caption,'R$','',[rfReplaceAll, rfIgnoreCase])) // Se desconto dado for maior que o valor da compra o valor do desconto diminui pro valor da compra
        else
      lblDescontoPreco.caption :=  floattostr(valordesconto);

   valordesconto := strtofloat(lblDescontoPreco.caption);

   cdfilatual := qryAchaCupom.FieldValues['cdfil'];
   lblDescontoValor.Caption := FloatToStr( (StrToFloat(lblDescontoPreco.Caption) * 100) / strtofloat(frmPrincipal.lblValorVarejo.Caption) );
end;


procedure TfrmDescontoCRM.btDigitacaoClick(Sender: TObject);
begin
 frmBuscaCupom.ShowModal;
end;

procedure TfrmDescontoCRM.FormKeyPress(Sender: TObject; var Key: Char);
var i:integer;
    cpfcliatual,cpfclidesconto:string;

begin
if not CharInSet(Key, ['0'..'9',#8,#13]) then key := #0
  else
    begin
     if (pnlCodBarras.Caption='Informe Cupom de Desconto') then pnlCodBarras.Caption := '';
     pnlCodBarras.Caption := pnlCodBarras.Caption + (key);
     if key=#13 then
      begin
        codbarras:= pnlCodBarras.Caption;
        if ((copy(codbarras,12,2) = '27')  and (copy(codbarras,1,1) = '0')   )then codbarras:=copy(codbarras,2,12)+'0';
        if (length(trim(codbarras))<>13) then
          begin

            if trim(codbarras)='' then ShowMessage('Informe algum código')
             else
            ShowMessage('ERRO! Código inválido ou leitor desconfigurado');

            pnlCodBarras.Caption:='Informe Cupom de Desconto';

          end
            else
             if (copy(codbarras,11,2) <> '27') then
               begin
                  ShowMessage('ERRO! Cupom inválido');
                  pnlCodBarras.Caption:='Informe Cupom de Desconto';
               end
                else
                  begin
                             uscpfiscal   := StrToInt(trim(frmPrincipal.edtTerminalBalcao.Text));
                             usvrcpfiscal := strtofloat( StringReplace(frmPrincipal.lblFinal.Caption,'R$ ','',[rfReplaceAll, rfIgnoreCase]));


                             for i:=0 to stgDescClientes.RowCount-1 do
                               begin
                                 if inttostr(strtoint(copy(codbarras,5,6)))=stgDescClientes.Cells[1,i] then
                                   begin
                                     limpacupom;
                                     raise Exception.Create('Cupom já incluso');
                                   end;
                               end;


                             qryAchaCupom.Close;
                             qryAchaCupom.SQL.Text := ' select * from DESCCLIENTES where cdfil='+inttostr(strtoint(copy(codbarras,3,2))) +' and cpfiscal='+inttostr(strtoint(copy(codbarras,5,6)));

                               //                             qryAchaCupom.SQL.Text := ' select * from DESCCLIENTES where CDFIL='+frmPrincipal.edtLoja.Text+' and cpfiscal='+inttostr(strtoint(copy(codbarras,5,6)));
                             qryAchaCupom.Open;

                             if qryAchaCupom.IsEmpty then
                              begin
                                 qryAchaCupom.Close;
                                 qryAchaCupom.SQL.Text := ' select * from DESCCLIENTES where cpfiscal='+inttostr(strtoint(copy(codbarras,5,6)));

                                   //                             qryAchaCupom.SQL.Text := ' select * from DESCCLIENTES where CDFIL='+frmPrincipal.edtLoja.Text+' and cpfiscal='+inttostr(strtoint(copy(codbarras,5,6)));
                                 qryAchaCupom.Open;
                              end;

//                             Clipboard.AsText := qryAchaCupom.SQL.Text;

                             if qryAchaCupom.IsEmpty then
                              begin
                               limpacupom;
                               raise Exception.Create('Cupom não cadastrado no sistema');
                              end;



                            qryConsultaCliDesconto.Close;
                            qryConsultaCliDesconto.SQL.Text := 'select cdcli from fc32100 where cdfil='+frmPrincipal.edtLoja.Text+' and nrcpm='+frmPrincipal.edtTerminalBalcao.Text;
                            qryConsultaCliDesconto.Open;

                            cpfcliatual    := qryConsultaCliDesconto.FieldValues['cdcli'];
                            cpfclidesconto := qryAchaCupom.FieldValues['cdcli'];

                             if cpfcliatual<>cpfclidesconto then raise Exception.Create('Cliente desta compra não é o mesmo do desconto');


                             incluicupom;

                             limpacupom;
                  end;
      end;
    end;
end;

procedure TfrmDescontoCRM.FormShow(Sender: TObject);
begin
 limpacupom;
 lblDescontoValor.Caption := '';
 stgDescClientes.RowCount := 2;
 stgDescClientes.Cells[0,0] := 'FIL';
 stgDescClientes.Cells[1,0] := 'CUPOM FISCAL';
 stgDescClientes.Cells[2,0] := 'CLIENTE';
 stgDescClientes.Cells[3,0] := 'DESC';
 stgDescClientes.Cells[0,1] := '';
 stgDescClientes.Cells[1,1] := '';
 stgDescClientes.Cells[2,1] := '';
 stgDescClientes.Cells[3,1] := '';
end;


procedure TfrmDescontoCRM.limpacupom;
begin
  lblCupomFiscal.Caption    := '';
  lblNomecliente.Caption    := '';
  lblDescontoPreco.Caption := '';
  pnlCodBarras.Caption:='Informe Cupom de Desconto';

end;

procedure TfrmDescontoCRM.btConcluiClick(Sender: TObject);
var i:integer;
begin

    if trim(stgDescClientes.Cells[1,1])='' then showmessage ('Informe algum cupom válido antes de prosseguir')
     else
    if MessageDlg('Deseja confirmar desconto de R$ '+floattostr(valordesconto)+' para o(a) cliente'+#13+nomecli+'?',mtconfirmation,[mbYes,MbNo],0)=mryes then
        begin

          frmEmailCRM.ShowModal;

          email:=trim(frmEmailCRM.edtEmail.Text);

          qryInsereDesconto.Close;
                                  
          qryInsereDesconto.SQL.Text := 'update fc32110 set tpdsc='+quotedstr('3')+', pruniliq=(pruni)-(pruni*('+TrocaVirgPPto(FloatToStr(StrTofloat(lblDescontoValor.Caption)/100))+')), vrcxa=(vrtot)-(vrtot*('+TrocaVirgPPto(FloatToStr(StrToFloat(lblDescontoValor.Caption)/100))+')), vrliq=(vrtot)-(vrtot*('+TrocaVirgPPto(FloatToStr(StrTofloat(lblDescontoValor.Caption)/100))+')), vrdsc=vrdsc+(pruni*quant*('+TrocaVirgPPto(FloatToStr(StrTofloat(lblDescontoValor.Caption)/100))+')), PTDSC='+TrocaVirgPPto(lblDescontoValor.Caption)+', BCPIS=(VRCXA-(pruni*quant*('+TrocaVirgPPto(FloatToStr(StrTofloat(lblDescontoValor.Caption)/100))+'))), VRPIS=(((VRCXA-(pruni*quant*('+TrocaVirgPPto(FloatToStr(StrTofloat(lblDescontoValor.Caption)/100))+'))))*ALPIS)/100,BCCOFINS=(VRCXA-(pruni*quant*('+TrocaVirgPPto(FloatToStr(StrTofloat(lblDescontoValor.Caption)/100))+'))),'+
          ' BCICM=(VRCXA-(pruni*quant*('+TrocaVirgPPto(FloatToStr(StrToFloat(lblDescontoValor.Caption)/100))+'))),VRCOFINS=(((VRCXA-(pruni*quant*('+TrocaVirgPPto(FloatToStr(StrTofloat(lblDescontoValor.Caption)/100))+'))))*ALCOFINS)/100 where tpitm='+quotedstr('V')+' and cdfil='+trim(frmPrincipal.edtLoja.Text)+' and nrcpm='+trim(frmPrincipal.edtTerminalBalcao.Text)+' and dtope='+QuotedStr(FormatDateTime('dd.mm.yyyy',now)) ;
          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
          qryInsereDesconto.Close;


          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Text := 'select sum(vrliq) as VALOR from fc32110 where  cdfil='+trim(frmPrincipal.edtLoja.Text)+' and nrcpm='+trim(frmPrincipal.edtTerminalBalcao.Text)+' and dtope='+QuotedStr(FormatDateTime('dd.mm.yyyy',now)) ;
          qryInsereDesconto.Open;
          valortotal := qryInsereDesconto.FieldValues['VALOR'];
          qryInsereDesconto.Close;

          qryInsereDesconto.Close;
          qryInsereDesconto.SQL.Text := 'update fc32100 set tpdsc='+quotedstr('3')+', useridaut='+quotedstr('projetocrm')+', vrtot='+quotedstr(TrocaVirgPPto(FloatToStr(valortotal)))+', vrliq='+quotedstr(TrocaVirgPPto(FloatToStr(valortotal)))+',vrcxa='+quotedstr(TrocaVirgPPto(FloatToStr(valortotal)))+', vrarc='+quotedstr(TrocaVirgPPto(FloatToStr(valortotal)))+' where  cdfil='+trim(frmPrincipal.edtLoja.Text)+' and nrcpm='+trim(frmPrincipal.edtTerminalBalcao.Text)+' and dtope='+QuotedStr(FormatDateTime('dd.mm.yyyy',now)) ;
          qryInsereDesconto.ExecSQL;
          qryInsereDesconto.Connection.CommitRetaining;
          qryInsereDesconto.Close;


          for i:=1 to stgDescClientes.RowCount-1 do
           begin
              qryAchaCupom.Close;
              qryAchaCupom.SQL.Text := 'update descclientes set email='+quotedstr(email)+',usado='+quotedstr('1')+',dtuso='+quotedstr(FormatDateTime('dd.mm.yyyy',now))+',uscpfiscal='+inttostr(uscpfiscal)+',usvrcpfiscal='+TrocaVirgPPto(FloatToStr(usvrcpfiscal-valordesconto))+',funcionario='+quotedstr(FrmPrincipal.StatusBar1.Panels[2].Text)+',usnomecli='+quotedstr(nomecli)+' where cpfiscal='+stgDescClientes.Cells[1,i]+' and cdfil='+inttostr(cdfilatual) ;
              qryAchaCupom.ExecSQL;
              qryAchaCupom.Transaction.Commit;
           end;

          qryAchaCupom.Close;
          qryAchaCupom.Database.Close;
          qryAchaCupom.Database.Open;
          qryAchaCupom.Transaction.Active:=true;
                                  
          qryAchaCupom.Close;
          qryAchaCupom.SQL.Text := 'select * from descclientes where cdcli='+inttostr(cdcli)+' and  usado='+quotedstr('0')+' and dtvalfim>='+quotedstr(FormatDateTime('dd.mm.yyyy',now));
          qryAchaCupom.Open;

          if qryAchaCupom.IsEmpty then
           begin
            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Text := 'update fc07000 set clcli=null where cdcli='+inttostr(cdcli);
            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.CommitRetaining;
            qryInsereDesconto.Close;
           end;

          qryAchaCupom.Close;



            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Text := 'update totvsconf set ENV='+quotedstr('N') +' where  fil='+trim(frmPrincipal.edtLoja.Text)+' and cupom='+trim(frmPrincipal.edtTerminalBalcao.Text) ;
            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.Commit;
            qryInsereDesconto.Close;

          showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
          frmDescontoCRM.Close;
        end
          else
            begin
             lblCupomFiscal.Caption    := '';
             lblNomecliente.Caption    := '';
             lblDescontoValor.Caption  := '';
             lblDescontoPreco.Caption  := '';
             pnlCodBarras.Caption:='Informe Cupom de Desconto';
            end;

end;

end.
