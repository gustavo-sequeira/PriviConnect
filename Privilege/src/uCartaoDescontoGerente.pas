unit uCartaoDescontoGerente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, IBX.IBCustomDataSet, Math, {clipbrd,}  dateutils,
  IBX.IBQuery, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmCartaoGerente = class(TForm)
    pnlCodBarras: TPanel;
    pnlInformacoes: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblTipoCartao: TLabel;
    lblNomeGerente: TLabel;
    lblDescontoValor: TLabel;
    qryInsereDesconto: TIBQuery;
    qryGravaLog: TIBQuery;
    qryAchaFuncionario: TIBQuery;
    qrySelecionaDesconto: TIBQuery;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCartaoGerente: TfrmCartaoGerente;

implementation

{$R *.dfm}

uses uPrincipal, uCartaoDesconto, uInformaDesconto, System.UITypes;

procedure TfrmCartaoGerente.FormKeyPress(Sender: TObject; var Key: Char);



procedure limpacampos;
begin
   lblTipoCartao.Caption    := '';
   lblNomeGerente.Caption    := '';
   lblDescontoValor.Caption := '';
   pnlCodBarras.Caption:='Informe Cartão de Desconto';
   pnlCodBarras.Visible := true;
end;

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


function CalculaDigEAN13(Cod:String):String;
function Par(Cod:Integer):Boolean;
begin
   Result:= Cod Mod 2 = 0;
end;
var i,SomaPar,SomaImpar:Integer;
begin
  SomaPar:=0;SomaImpar:=0;
  for i:=1 to 12 do
    if Par(i) then
       SomaPar:=SomaPar+StrToInt(Cod[i])
   else
       SomaImpar:=SomaImpar+StrToInt(Cod[i]);
   SomaPar:=SomaPar*3;i:=0;
   while i < (SomaPar+SomaImpar)do
   Inc(i,10);
   Result:=IntToStr(i-(SomaPar+SomaImpar));
end;



var codbarras:string;
    valortotal,valorunitdesc : double;
begin

if not CharInSet(key, ['0'..'9',#8,#13]) then key := #0
  else
    begin
     if (pnlCodBarras.Caption='Informe Cartão de Desconto') then
      begin
        pnlCodBarras.Caption := '';
        pnlCodBarras.Visible := false;
      end;

     pnlCodBarras.Caption := pnlCodBarras.Caption + (key);
     if key=#13 then
      begin
        if (length(trim(pnlCodBarras.Caption))<>13) then
          begin
            ShowMessage('ERRO! Código inválido ou leitor desconfigurado');
            pnlCodBarras.Caption:='Informe Cartão de Desconto';
            pnlCodBarras.Visible := true;
          end
            else if (copy(pnlCodBarras.Caption,1,6) <> '870827') then
               begin
                  ShowMessage('ERRO! Cartão inválido');
                  pnlCodBarras.Caption:='Informe Cartão de Desconto';
                  pnlCodBarras.Visible := true;
               end
                else
                  begin
                    codbarras:=pnlCodBarras.Caption;
                    qryGravaLog.Close;
                    qryGravaLog.SQL.Text := 'select * from CARTGERENTES WHERE ATIVO='+quotedstr('N')+' and NRCARTAO='+QuotedStr(codbarras);
                    qryGravaLog.Open;

                     if not(qryGravaLog.IsEmpty) then
                      begin
                        lblTipoCartao.Caption    := '';
                        lblNomeGerente.Caption    := '';
                        lblDescontoValor.Caption := '';
                        pnlCodBarras.Caption:='Informe Cartão de Desconto';
                        pnlCodBarras.Visible := true;
                        raise Exception.Create('Cartão está bloqueado, favor entrar em contato com o Depto Comercial');
                      end;



                     qryGravaLog.Close;



                     qryGravaLog.Close;
                     qryGravaLog.SQL.Text := 'select * from CARTGERENTES WHERE ATIVO='+quotedstr('S')+' AND NRCARTAO='+QuotedStr( trim(codbarras));
                     qryGravaLog.Open;
//                     Clipboard.AsText := qryGravaLog.sql.text;

                     if qryGravaLog.IsEmpty then
                       begin
                        lblTipoCartao.Caption    := '';
                        lblNomeGerente.Caption    := '';
                        lblDescontoValor.Caption := '';
                        pnlCodBarras.Caption:='Informe Cartão de Desconto';
                        pnlCodBarras.Visible := true;
                        raise Exception.Create('Cartão não existe/Inválido');
                       end;


                     if qryGravaLog.FieldValues['CDFIL']<> StrToInt(frmPrincipal.edtLoja.Text)  then
                       begin
                        lblTipoCartao.Caption    := '';
                        lblNomeGerente.Caption    := '';
                        lblDescontoValor.Caption := '';
                        pnlCodBarras.Caption:='Informe Cartão de Desconto';
                        pnlCodBarras.Visible := true;
                        raise Exception.Create('Cartão pertence a outra loja');
                       end;

                     lblTipoCartao.Caption := 'Cartão Privilege - Gerente';
                     lblNomeGerente.Caption := qryGravaLog.FieldValues['TITULAR'];
                     lblDescontoValor.Caption := frmInformaDesconto.edtDescTot.Text;

                     qryGravaLog.Close;

                     if MessageDlg('Deseja confirmar desconto de '+lblDescontoValor.Caption+'?',mtconfirmation,[mbYes,MbNo],0)=mryes then
                        begin
                          qrySelecionaDesconto.Close;
                          qrySelecionaDesconto.sql.Text := 'select * from fc32110 where cdfil='+trim(frmPrincipal.edtLoja.Text)+' and nrcpm='+trim(frmPrincipal.edtTerminalBalcao.Text)+' and dtope>='+QuotedStr(FormatDateTime('dd.mm.yyyy',IncDay(now,-1)))+' order by VRTOT DESC' ;
                          qrySelecionaDesconto.Open;

                          while not qrySelecionaDesconto.Eof do
                            begin

                              if qrySelecionaDesconto.FieldValues['TPITM']='R' then
                                 valorunitdesc := (qrySelecionaDesconto.FieldValues['VRTOT'] * desc1form)/100
                                   else
                                 valorunitdesc := (qrySelecionaDesconto.FieldValues['VRTOT'] * desc2var)/100;

                              valorunitdesc := RoundTo (valorunitdesc, -2);

                              tpdescvar:='C';
                              tpdescform:='C';

                              qryInsereDesconto.Close;
                              qryInsereDesconto.SQL.Text := 'update fc32200 set tpdsc='+quotedstr(tpdescform)+', vrliq=vrliq-'+TrocaVirgPPto( floattostr(valorunitdesc)  )+', vrcxa=vrcxa-'+TrocaVirgPPto( floattostr(valorunitdesc)  )+', vrsdo=vrsdo-'+TrocaVirgPPto( floattostr(valorunitdesc)  )+', vrdsc='+TrocaVirgPPto( floattostr(valorunitdesc)  )+', useridaut='+quotedstr('privilegegerente') +
                              ' where cdfil='+inttostr(qrySelecionaDesconto.FieldValues['cdfil'])+' and cdtml='+quotedstr(qrySelecionaDesconto.FieldValues['cdtml'])+' and dtope='+quotedstr(FormatDateTime('dd.mm.yyyy',qrySelecionaDesconto.FieldValues['dtope']))+' and operid='+inttostr(qrySelecionaDesconto.FieldValues['operid'])+' and nrcpm='+inttostr(qrySelecionaDesconto.FieldValues['nrcpm'])+' and itemid='+inttostr(qrySelecionaDesconto.FieldValues['itemid']);

//                              Clipboard.AsText := qryInsereDesconto.sql.text;
                              qryInsereDesconto.Open;
                              qryInsereDesconto.Transaction.CommitRetaining;
                              qryInsereDesconto.Close;

                              qryInsereDesconto.Close;

                              if qrySelecionaDesconto.FieldValues['TPITM']='R' then
                               begin
                                  qryInsereDesconto.SQL.Text := 'update fc32110 set tpdsc='+quotedstr(tpdescform)+', vrtot=vrtot-'+TrocaVirgPPto( floattostr(valorunitdesc)  )+', pruni=pruni-'+TrocaVirgPPto( floattostr(valorunitdesc)  )+', pruniliq=pruniliq-('+TrocaVirgPPto( floattostr(valorunitdesc)  )+'/QUANT), vrcxa=vrcxa-'+TrocaVirgPPto( floattostr(valorunitdesc)  )+', vrliq=vrliq-'+TrocaVirgPPto( floattostr(valorunitdesc)  )+', '+
                                  ' BCICM=VRTXAV+vrliq-'+TrocaVirgPPto( floattostr(valorunitdesc)  )+' where cdfil='+inttostr(qrySelecionaDesconto.FieldValues['cdfil'])+' and cdtml='+quotedstr(qrySelecionaDesconto.FieldValues['cdtml'])+' and dtope='+quotedstr(FormatDateTime('dd.mm.yyyy',qrySelecionaDesconto.FieldValues['dtope']))+' and operid='+inttostr(qrySelecionaDesconto.FieldValues['operid'])+' and nrcpm='+inttostr(qrySelecionaDesconto.FieldValues['nrcpm'])+' and itemid='+inttostr(qrySelecionaDesconto.FieldValues['itemid']);
                               end
                                else
                                  begin
                                    qryInsereDesconto.SQL.Text := 'update fc32110 set tpdsc='+quotedstr(tpdescform)+', ptdsc='+TrocaVirgPPto( floattostr(desc2var) )+' , pruniliq=pruniliq-('+TrocaVirgPPto( floattostr(valorunitdesc)  )+'/QUANT), vrcxa=vrcxa-'+TrocaVirgPPto( floattostr(valorunitdesc)  )+', vrliq=vrliq-'+TrocaVirgPPto( floattostr(valorunitdesc)  )+', vrdsc='+TrocaVirgPPto( floattostr(valorunitdesc)  )+', '+
                                    ' BCICM=VRTXAV+vrliq-'+TrocaVirgPPto( floattostr(valorunitdesc)  )+' where cdfil='+inttostr(qrySelecionaDesconto.FieldValues['cdfil'])+' and cdtml='+quotedstr(qrySelecionaDesconto.FieldValues['cdtml'])+' and dtope='+quotedstr(FormatDateTime('dd.mm.yyyy',qrySelecionaDesconto.FieldValues['dtope']))+' and operid='+inttostr(qrySelecionaDesconto.FieldValues['operid'])+' and nrcpm='+inttostr(qrySelecionaDesconto.FieldValues['nrcpm'])+' and itemid='+inttostr(qrySelecionaDesconto.FieldValues['itemid']);
                                  end;

//                              Clipboard.AsText := qryInsereDesconto.sql.text;
                              qryInsereDesconto.Open;
                              qryInsereDesconto.Transaction.CommitRetaining;
                              qryInsereDesconto.Close;

                              qrySelecionaDesconto.Next;
                            end;



                            qryInsereDesconto.Close;
                            //qryInsereDesconto.SQL.Text := 'select sum(vrliq) as VALOR from fc32110 where  cdfil='+trim(frmPrincipal.edtLoja.Text)+' and nrcpm='+trim(frmPrincipal.edtTerminalBalcao.Text)+' and dtope='+QuotedStr(FormatDateTime('dd.mm.yyyy',now)) ;
                            qryInsereDesconto.SQL.Text := 'select sum(vrliq) as VALOR from fc32110 where  cdfil='+trim(frmPrincipal.edtLoja.Text)+' and nrcpm='+trim(frmPrincipal.edtTerminalBalcao.Text)+' and dtope  between '+QuotedStr(FormatDateTime('dd.mm.yyyy',now-15))+' and  '+QuotedStr(FormatDateTime('dd.mm.yyyy',now));
                            qryInsereDesconto.Open;
                            valortotal := qryInsereDesconto.FieldValues['VALOR'];
                            qryInsereDesconto.Close;

                            qryInsereDesconto.Close;
                            //qryInsereDesconto.SQL.Text := 'update fc32100 set useridaut='+quotedstr('privilegegerente')+', vrtot='+TrocaVirgPPto(FloatToStr(valortotal))+', vrliq=VRTXAG+'+TrocaVirgPPto(FloatToStr(valortotal))+',vrcxa=VRTXAG+'+TrocaVirgPPto(FloatToStr(valortotal))+', vrarc=VRTXAG+'+TrocaVirgPPto(FloatToStr(valortotal))+' where  cdfil='+trim(frmPrincipal.edtLoja.Text)+' and nrcpm='+trim(frmPrincipal.edtTerminalBalcao.Text)+' and dtope='+QuotedStr(FormatDateTime('dd.mm.yyyy',now)) ;
                            qryInsereDesconto.SQL.Text := 'update fc32100 set useridaut='+quotedstr('privilegegerente')+', vrtot='+TrocaVirgPPto(FloatToStr(valortotal))+', vrliq=VRTXAG+'+TrocaVirgPPto(FloatToStr(valortotal))+',vrcxa=VRTXAG+'+TrocaVirgPPto(FloatToStr(valortotal))+', vrarc=VRTXAG+'+TrocaVirgPPto(FloatToStr(valortotal))+' where  cdfil='+trim(frmPrincipal.edtLoja.Text)+' and nrcpm='+trim(frmPrincipal.edtTerminalBalcao.Text)+' and dtope  between '+QuotedStr(FormatDateTime('dd.mm.yyyy',now-15))+' and  '+QuotedStr(FormatDateTime('dd.mm.yyyy',now));
//                            Clipboard.AsText := qryInsereDesconto.sql.text;
                            qryInsereDesconto.Open;
                            qryInsereDesconto.Transaction.CommitRetaining;
                            qryInsereDesconto.Close;
                            showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
                            qrySelecionaDesconto.Close;
                            limpacampos;
                            frmCartaoGerente.Close;
                        end
                          else
                            begin
                              limpacampos;
                            end;



                  end;
      end;
    end;
end;

procedure TfrmCartaoGerente.FormShow(Sender: TObject);
begin
  lblTipoCartao.Caption    := '';
  lblNomeGerente.Caption    := '';
  lblDescontoValor.Caption := '';
  pnlCodBarras.Caption:='Informe Cartão de Desconto';
  pnlCodBarras.Visible := true;
end;

end.
