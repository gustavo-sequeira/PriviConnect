unit uInformaDesconto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, Math, {Vcl.Clipbrd, }
  IBX.IBCustomDataSet, IBX.IBQuery, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmInformaDesconto = class(TForm)
    gbFormula: TGroupBox;
    edtValorTotalForm: TEdit;
    Label2: TLabel;
    edtPerDescFor: TEdit;
    Label1: TLabel;
    edtVrDescontoForm: TEdit;
    Label3: TLabel;
    gbVarejo: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtValorTotalVar: TEdit;
    edtPerDescVar: TEdit;
    edtVrDescontoVar: TEdit;
    GroupBox4: TGroupBox;
    edtVrBrutoForm: TEdit;
    edtVrBrutoVar: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtVrBrutoTot: TEdit;
    Label12: TLabel;
    edtDescForm: TEdit;
    Label13: TLabel;
    edtDesVar: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    edtDescTot: TEdit;
    Label16: TLabel;
    Bevel1: TBevel;
    edtResVrBrutTot: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    edtResVrDesTot: TEdit;
    edtVrCobradoLiq: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    Ok: TButton;
    Label21: TLabel;
    qrySelecionaDesconto: TIBQuery;
    edtResVrTxaTot: TEdit;
    Label22: TLabel;
    Label23: TLabel;
    qryBuscaDesc: TIBQuery;
    qryInsereDesconto: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure OkClick(Sender: TObject);
    procedure edtValorTotalFormExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtPerDescForExit(Sender: TObject);
    procedure recalcula;
    procedure edtPerDescVarExit(Sender: TObject);
    procedure edtValorTotalVarExit(Sender: TObject);
    procedure edtVrDescontoFormExit(Sender: TObject);
    procedure edtVrDescontoVarExit(Sender: TObject);
    procedure edtVrDescontoFormChange(Sender: TObject);
    procedure edtValorTotalFormChange(Sender: TObject);
    procedure edtVrDescontoVarChange(Sender: TObject);
    procedure edtValorTotalVarChange(Sender: TObject);
    procedure edtValorTotalVarKeyPress(Sender: TObject; var Key: Char);
    Procedure FormatarComoMoeda( Componente : TObject; var Key: Char );
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInformaDesconto: TfrmInformaDesconto;

implementation

{$R *.dfm}

uses uPrincipal, uCartaoDescontoGerente, udmDescontos, System.UITypes;

procedure TfrmInformaDesconto.recalcula;
begin
   edtDescTot.Text       := floattostr( StrToFloat(edtDescForm.Text) + StrToFloat(edtDesVar.Text) );
   edtVrBrutoTot.Text    := floattostr( StrToFloat(edtVrBrutoForm.Text) + StrToFloat(edtVrBrutoVar.Text) );
   edtResVrBrutTot.Text  := edtVrBrutoTot.Text;
   edtResVrDesTot.Text   := edtDescTot.Text;
   edtResVrTxaTot.Text   := floattostr(vrtxa);

   edtVrCobradoLiq.Text  := floattostr( StrToFloat(edtResVrBrutTot.Text) + StrToFloat(edtResVrTxaTot.Text)  - StrToFloat(edtResVrDesTot.Text) );


   edtValorTotalForm.Text := FormatFloat('#####0.00',StrToFloat(edtValorTotalForm.Text));
   edtValorTotalVar.Text  := FormatFloat('#####0.00',StrToFloat(edtValorTotalVar.Text));
   edtVrDescontoForm.Text  := FormatFloat('#####0.00',StrToFloat(edtVrDescontoForm.Text));
   edtVrDescontoVar.Text  := FormatFloat('#####0.00',StrToFloat(edtVrDescontoVar.Text));


   edtVrBrutoForm.Text    := FormatFloat('#####0.00',StrToFloat(edtVrBrutoForm.Text));
   edtVrBrutoVar.Text     := FormatFloat('#####0.00',StrToFloat(edtVrBrutoVar.Text));
   edtVrBrutoTot.Text     := FormatFloat('#####0.00',StrToFloat(edtVrBrutoTot.Text));
   edtResVrTxaTot.Text    := FormatFloat('#####0.00',StrToFloat(edtResVrTxaTot.Text));

   edtDescForm.Text := FormatFloat('#####0.00',StrToFloat(edtDescForm.Text));
   edtDesVar.Text   := FormatFloat('#####0.00',StrToFloat(edtDesVar.Text));
   edtDescTot.Text  := FormatFloat('#####0.00',StrToFloat(edtDescTot.Text));


   edtResVrBrutTot.Text := FormatFloat('#####0.00',StrToFloat(edtResVrBrutTot.Text));
   edtResVrDesTot.Text   := FormatFloat('#####0.00',StrToFloat(edtResVrDesTot.Text));
   edtVrCobradoLiq.Text  := FormatFloat('#####0.00',StrToFloat(edtVrCobradoLiq.Text));


end;

procedure TfrmInformaDesconto.edtPerDescForExit(Sender: TObject);
var perc:string;
begin
perc:='';

if trim(edtPerDescFor.Text)<>'' then
 begin
   perc:= edtPerDescFor.Text;
   edtVrDescontoForm.Text := floattostr(StrToFloat(edtVrBrutoForm.Text) * (StrToFloat(edtPerDescFor.Text)/100)  );
   edtValorTotalForm.Text := floattostr(StrToFloat(edtVrBrutoForm.Text) - StrToFloat(edtVrDescontoForm.Text));
   edtDescForm.Text :=  edtVrDescontoForm.Text;
 end;

   recalcula;
   edtPerDescFor.Text := perc;
end;

procedure TfrmInformaDesconto.edtPerDescVarExit(Sender: TObject);
var perc:string;
begin
perc:='';
if trim(edtPerDescVar.Text)<>'' then
 begin
   perc:= edtPerDescVar.Text;
   edtVrDescontoVar.Text := floattostr(StrToFloat(edtVrBrutoVar.Text) * (StrToFloat(edtPerDescVar.Text)/100)  );
   edtValorTotalVar.Text := floattostr(StrToFloat(edtVrBrutoVar.Text) - StrToFloat(edtVrDescontoVar.Text));
   edtDesVar.Text :=  edtVrDescontoVar.Text;
 end;

   recalcula;
   edtPerDescVar.Text := perc;
end;

procedure TfrmInformaDesconto.edtValorTotalFormChange(Sender: TObject);
begin
edtPerDescFor.Clear;
end;

procedure TfrmInformaDesconto.edtValorTotalFormExit(Sender: TObject);
begin

if strtofloat(edtValorTotalForm.Text)>strtofloat(edtVrBrutoForm.Text) then
 begin
   edtValorTotalForm.Text := edtVrBrutoForm.Text;
 end;

edtVrDescontoForm.Text := floattostr(StrToFloat(edtVrBrutoForm.Text) - StrToFloat(edtValorTotalForm.Text));
edtDescForm.Text := edtVrDescontoForm.Text;
edtPerDescFor.Clear;

(Sender as TEdit).Text := FormatFloat('#####0.00',StrToFloat((Sender as TEdit).Text));

recalcula;
end;

procedure TfrmInformaDesconto.edtValorTotalVarChange(Sender: TObject);
begin
edtPerDescVar.Clear;
end;

procedure TfrmInformaDesconto.edtValorTotalVarExit(Sender: TObject);
begin

if strtofloat(edtValorTotalVar.Text)>strtofloat(edtVrBrutoVar.Text) then
 begin
   edtValorTotalVar.Text := edtVrBrutoVar.Text;
 end;

edtVrDescontoVar.Text := floattostr(StrToFloat(edtVrBrutoVar.Text) - StrToFloat(edtValorTotalVar.Text));
edtDesVar.Text := edtVrDescontoVar.Text;
edtPerDescVar.Clear;

(Sender as TEdit).Text := FormatFloat('#####0.00',StrToFloat((Sender as TEdit).Text));

recalcula;

end;

procedure TfrmInformaDesconto.edtValorTotalVarKeyPress(Sender: TObject;
  var Key: Char);
begin

//  FormatarComoMoeda( (Sender as TEdit), Key );


if ((Key = ',') and (Pos(',', TEdit(Sender).Text) < 1)) // vírgula, apenas uma
or CharInSet(Key, ['0'..'9']) // números
or (Key = Char(VK_BACK)) // backspace
then
Exit;

Key := #0;

end;

procedure TfrmInformaDesconto.edtVrDescontoFormChange(Sender: TObject);
begin
edtPerDescFor.Clear;
end;

procedure TfrmInformaDesconto.edtVrDescontoFormExit(Sender: TObject);
begin

if trim(edtVrDescontoForm.Text)='' then edtVrDescontoForm.Text := '0';

if strtofloat(edtVrDescontoForm.Text)>strtofloat(edtVrBrutoForm.Text) then
 begin
   edtValorTotalForm.Text := edtVrBrutoForm.Text;
   edtVrDescontoForm.Text := '0';
 end;


edtValorTotalForm.Text := floattostr(StrToFloat(edtVrBrutoForm.Text) - StrToFloat(edtVrDescontoForm.Text));
edtDescForm.Text := edtVrDescontoForm.Text;

(Sender as TEdit).Text := FormatFloat('#####0.00',StrToFloat((Sender as TEdit).Text));

recalcula;

end;

procedure TfrmInformaDesconto.edtVrDescontoVarChange(Sender: TObject);
begin
edtPerDescVar.Clear;
end;

procedure TfrmInformaDesconto.edtVrDescontoVarExit(Sender: TObject);
begin

 if trim(edtVrDescontoVar.Text)='' then edtVrDescontoVar.Text := '0';

if strtofloat(edtVrDescontoVar.Text)>strtofloat(edtVrBrutoVar.Text) then
 begin
   edtValorTotalVar.Text := edtVrBrutoVar.Text;
   edtVrDescontoVar.Text := '0';
 end;


edtValorTotalVar.Text := floattostr(StrToFloat(edtVrBrutoVar.Text) - StrToFloat(edtVrDescontoVar.Text));
edtDesVar.Text := edtVrDescontoVar.Text;

(Sender as TEdit).Text := FormatFloat('#####0.00',StrToFloat((Sender as TEdit).Text));

recalcula;
end;

procedure TfrmInformaDesconto.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if key=#13 then
  begin
   Key := #0;
   Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmInformaDesconto.FormShow(Sender: TObject);
begin

     edtValorTotalVar.Text := floattostr(vrtotvarejo);
     edtVrBrutoVar.Text    := floattostr(vrtotvarejo);
     edtVrDescontoVar.Text := floattostr(vrdescVarejo);
     edtDesVar.Text        := floattostr(vrdescVarejo);

     edtValorTotalForm.Text := floattostr(vrtotform);
     edtVrBrutoForm.Text    := floattostr(vrtotform);
     edtVrDescontoForm.Text := floattostr(vrdescFormula);
     edtDescForm.Text       := floattostr(vrdescFormula);

     edtVrBrutoTot.Text   := floattostr(vrtot);
     edtDescTot.Text      := floattostr(desconto);
     edtVrCobradoLiq.Text := floattostr(vrtot-desconto);

     frmInformaDesconto.Caption := 'MAX VAR- '+floattostr(vrnegocvar)+'% - MAX FOR- '+floattostr(vrnegocfrm)+'%';

     recalcula;

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


procedure TfrmInformaDesconto.OkClick(Sender: TObject);
var    valortotal,valorunitdesc,vrcxa : double;
       dvar,dfor,vfor,vvar:double;
begin

 if (edtValorTotalForm.Text<>edtVrBrutoForm.Text) or (edtValorTotalVar.Text<>edtVrBrutoVar.Text) then
   begin

     if StrToFloat(edtVrBrutoForm.Text)<>0 then
          desc1form := ( strtofloat(edtDescForm.Text) * 100  ) / StrToFloat(edtVrBrutoForm.Text)
            else
          desc1form := 0;

     if StrToFloat(edtVrBrutoVar.Text)<>0 then
          desc2var := ( strtofloat(edtDesVar.Text) * 100  ) / StrToFloat(edtVrBrutoVar.Text)
            else
          desc2var := 0;


     dfor := strtofloat(edtDescForm.Text);
     vfor := StrToFloat(edtVrBrutoForm.Text);
     dvar := strtofloat(edtDesVar.Text);
     vvar := StrToFloat(edtVrBrutoVar.Text);

     if dfor>0 then
     if  (    (( dfor * 100  ) / vfor)    > vrnegocfrm+0.006)   then
         raise Exception.Create('Valor de desconto negociado de fórmula acima do permitido' );

     if dvar>0 then
     if  (    (( dvar * 100  ) / vvar)    > vrnegocvar+0.006)   then
         raise Exception.Create('Valor de desconto negociado de varejo acima do permitido' );

     if ( (edtDescForm.Text=edtVrBrutoForm.Text) and (StrToFloat(edtVrBrutoForm.Text)>0  )  )  or
        ( (edtDesVar.Text=edtVrBrutoVar.Text) and (StrToFloat(edtVrBrutoVar.Text)>0  )  )  then raise Exception.Create('Não é permitido dar 100% de desconto');



{
     //ACRESCENTEI  DESCONTO MAXDESCCARUARU PARA O USUARIO
     qryBuscaDesc.Close;
     qryBuscaDesc.SQL.Text := 'select * from parametros where parametro ='+quotedstr('MAXDESCCARUARU')+' and argumento='+quotedstr(usu) ;
     qryBuscaDesc.Open;
     if not(qryBuscaDesc.IsEmpty)  and (trim(frmPrincipal.edtLoja.Text) ='159') then
        begin
          if StrToFloat(qryBuscaDesc.FieldValues['subargum'])>maxdesc  then maxdesc:=StrToFloat(qryBuscaDesc.FieldValues['subargum']);
        end;
 }

        if MessageDlg('Deseja confirmar desconto de '+edtDescTot.Text+'?',mtconfirmation,[mbYes,MbNo],0)=mryes then
          begin

            qrySelecionaDesconto.Close;
            qrySelecionaDesconto.SQL.Text := 'select a.CDFIL, a.CDTML, a.DTOPE, a.OPERID, a.NRCPM, a.ITEMID, a.TPITM, a.CDFILR, a.QUANT, a.PRUNI, a.PTDSC, a.TPDSC, a.VRDSC, a.VRLIQ, a.VRCXA, a.TPDSCG, a.VRDSCG, a.CDTXAG, a.VRTXAG, a.TPPAG, '+
                                             ' coalesce( b.vrtot, a.VRTOT) as VRTOT, a.CDTXA, a.VRTXA, a.VRDSCV, a.VRTXAV,a.BCICM, a.VRICM, a.PRUNILIQ '+
                                             ' from fc32110 a left join fc32200 b on ( a.cdfil=b.cdfil and a.cdtml=b.cdtml and a.dtope = b.dtope and a.operid=b.operid and a.nrcpm=b.nrcpm and a.itemid=b.itemid ) '+
                                             ' where a.cdfil='+trim(frmPrincipal.edtLoja.Text)+' and a.nrcpm='+trim(frmPrincipal.edtTerminalBalcao.Text)+' order by a.VRTOT DESC' ;

            qrySelecionaDesconto.Open;
            qrySelecionaDesconto.FetchAll;
            qrySelecionaDesconto.First;

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
                qryInsereDesconto.SQL.Text := 'update fc32200 set vrcxa=(iif(tppag='+quotedstr('1')+',vrtot+vrtxa-'+TrocaVirgPPto( floattostr(valorunitdesc) )+',vrrcb)), tpdsc='+quotedstr(tpdescform)+', vrliq= vrtot+vrtxa-'+TrocaVirgPPto( floattostr(valorunitdesc)  )+', vrsdo=vrtot+vrtxa-vrrcb-'+TrocaVirgPPto( floattostr(valorunitdesc)  )+', vrdsc='+TrocaVirgPPto( floattostr(valorunitdesc)  )+', useridaut='+quotedstr('privilegeloja') +
                ' where cdfil='+inttostr(qrySelecionaDesconto.FieldValues['cdfil'])+' and cdtml='+quotedstr(qrySelecionaDesconto.FieldValues['cdtml'])+' and dtope='+quotedstr(FormatDateTime('dd.mm.yyyy',qrySelecionaDesconto.FieldValues['dtope']))+' and operid='+inttostr(qrySelecionaDesconto.FieldValues['operid'])+' and nrcpm='+inttostr(qrySelecionaDesconto.FieldValues['nrcpm'])+' and itemid='+inttostr(qrySelecionaDesconto.FieldValues['itemid']);

         //       Clipboard.AsText := qryInsereDesconto.SQL.Text;
                qryInsereDesconto.ExecSQL;
                qryInsereDesconto.Connection.CommitRetaining;
                qryInsereDesconto.Close;

           {
                if qrySelecionaDesconto.FieldValues['tppag']='1' then
                 begin
                    qryInsereDesconto.Close;
                    qryInsereDesconto.SQL.Text := 'update fc32200 set vrcxa = vrtot+vrtxa-'+TrocaVirgPPto( floattostr(valorunitdesc) )+
                    ' where cdfil='+inttostr(qrySelecionaDesconto.FieldValues['cdfil'])+' and cdtml='+quotedstr(qrySelecionaDesconto.FieldValues['cdtml'])+' and dtope='+quotedstr(FormatDateTime('dd.mm.yyyy',qrySelecionaDesconto.FieldValues['dtope']))+' and operid='+inttostr(qrySelecionaDesconto.FieldValues['operid'])+' and nrcpm='+inttostr(qrySelecionaDesconto.FieldValues['nrcpm'])+' and itemid='+inttostr(qrySelecionaDesconto.FieldValues['itemid']);
                    qryInsereDesconto.Open;
                    qryInsereDesconto.Connection.CommitRetaining;
                    qryInsereDesconto.Close;
                 end else
                    begin
                      qryInsereDesconto.Close;
                      qryInsereDesconto.SQL.Text := 'update fc32200 set vrcxa= vrrcb '+
                      ' where cdfil='+inttostr(qrySelecionaDesconto.FieldValues['cdfil'])+' and cdtml='+quotedstr(qrySelecionaDesconto.FieldValues['cdtml'])+' and dtope='+quotedstr(FormatDateTime('dd.mm.yyyy',qrySelecionaDesconto.FieldValues['dtope']))+' and operid='+inttostr(qrySelecionaDesconto.FieldValues['operid'])+' and nrcpm='+inttostr(qrySelecionaDesconto.FieldValues['nrcpm'])+' and itemid='+inttostr(qrySelecionaDesconto.FieldValues['itemid']);
                      qryInsereDesconto.Open;
                      qryInsereDesconto.Connection.CommitRetaining;
                      qryInsereDesconto.Close;
                    end;
                                 }

                   if qrySelecionaDesconto.FieldValues['TPITM']='R' then
                       begin
                            qryInsereDesconto.Close;
                            qryInsereDesconto.SQL.Text := 'select vrcxa from fc32200 '+
                            ' where cdfil='+inttostr(qrySelecionaDesconto.FieldValues['cdfil'])+' and cdtml='+quotedstr(qrySelecionaDesconto.FieldValues['cdtml'])+' and dtope='+quotedstr(FormatDateTime('dd.mm.yyyy',qrySelecionaDesconto.FieldValues['dtope']))+' and operid='+inttostr(qrySelecionaDesconto.FieldValues['operid'])+' and nrcpm='+inttostr(qrySelecionaDesconto.FieldValues['nrcpm'])+' and itemid='+inttostr(qrySelecionaDesconto.FieldValues['itemid']);
                            qryInsereDesconto.Open;
                            vrcxa := qryInsereDesconto.FieldValues['VRCXA'];
                            qryInsereDesconto.Close;

                          qryInsereDesconto.SQL.Text := 'update fc32110 set tpdsc='+quotedstr(tpdescform)+', vrtot='+TrocaVirgPPto( floattostr(vrcxa)  )+', pruni='+TrocaVirgPPto( floattostr(vrcxa) )+', pruniliq='+TrocaVirgPPto( floattostr(vrcxa)  )+'/QUANT, vrcxa='+TrocaVirgPPto( floattostr(vrcxa)  )+', vrliq='+TrocaVirgPPto( floattostr(vrcxa)  )+', '+
                          ' BCICM='+TrocaVirgPPto( floattostr(vrcxa)  )+' where cdfil='+inttostr(qrySelecionaDesconto.FieldValues['cdfil'])+' and cdtml='+quotedstr(qrySelecionaDesconto.FieldValues['cdtml'])+' and dtope='+quotedstr(FormatDateTime('dd.mm.yyyy',qrySelecionaDesconto.FieldValues['dtope']))+' and operid='+inttostr(qrySelecionaDesconto.FieldValues['operid'])+' and nrcpm='+inttostr(qrySelecionaDesconto.FieldValues['nrcpm'])+' and itemid='+inttostr(qrySelecionaDesconto.FieldValues['itemid']);
                       end
                        else
                          begin
                            qryInsereDesconto.SQL.Text := 'update fc32110 set tpdsc='+quotedstr(tpdescform)+', ptdsc='+TrocaVirgPPto( floattostr(desc2var) )+' , pruniliq=pruniliq-('+TrocaVirgPPto( floattostr(valorunitdesc)  )+'/QUANT), vrcxa=vrcxa-'+TrocaVirgPPto( floattostr(valorunitdesc)  )+', vrliq=vrliq-'+TrocaVirgPPto( floattostr(valorunitdesc)  )+', vrdsc='+TrocaVirgPPto( floattostr(valorunitdesc)  )+', '+
                            ' BCICM=VRTXAV+vrliq-'+TrocaVirgPPto( floattostr(valorunitdesc)  )+' where cdfil='+inttostr(qrySelecionaDesconto.FieldValues['cdfil'])+' and cdtml='+quotedstr(qrySelecionaDesconto.FieldValues['cdtml'])+' and dtope='+quotedstr(FormatDateTime('dd.mm.yyyy',qrySelecionaDesconto.FieldValues['dtope']))+' and operid='+inttostr(qrySelecionaDesconto.FieldValues['operid'])+' and nrcpm='+inttostr(qrySelecionaDesconto.FieldValues['nrcpm'])+' and itemid='+inttostr(qrySelecionaDesconto.FieldValues['itemid']);
                          end;

                qryInsereDesconto.ExecSQL;
                qryInsereDesconto.Connection.CommitRetaining;
                qryInsereDesconto.Close;

                qrySelecionaDesconto.Next;
              end;


            qryInsereDesconto.Close;
           // qryInsereDesconto.SQL.Text := 'select sum(vrliq) as VALOR from fc32110 where  cdfil='+trim(frmPrincipal.edtLoja.Text)+' and nrcpm='+trim(frmPrincipal.edtTerminalBalcao.Text)+' and dtope='+QuotedStr(FormatDateTime('dd.mm.yyyy',now)) ;

            qryInsereDesconto.SQL.Text := 'select sum(vrliq) as VALOR from fc32110 where  cdfil='+trim(frmPrincipal.edtLoja.Text)+' and nrcpm='+trim(frmPrincipal.edtTerminalBalcao.Text)+' and dtope  between '+QuotedStr(FormatDateTime('dd.mm.yyyy',now-15))+' and  '+QuotedStr(FormatDateTime('dd.mm.yyyy',now));

            qryInsereDesconto.Open;
            valortotal := qryInsereDesconto.FieldValues['VALOR'];
            qryInsereDesconto.Close;

            qryInsereDesconto.Close;
          //qryInsereDesconto.SQL.Text := 'update fc32100 set  tpdsc='+quotedstr(tpdescform)+',useridaut='+quotedstr('privilegeloja')+', vrtot='+TrocaVirgPPto(FloatToStr(valortotal))+', vrliq=VRTXAG+'+TrocaVirgPPto(FloatToStr(valortotal))+',vrcxa=VRTXAG+'+TrocaVirgPPto(FloatToStr(valortotal))+', vrarc=VRTXAG+'+TrocaVirgPPto(FloatToStr(valortotal))+' where  cdfil='+trim(frmPrincipal.edtLoja.Text)+' and nrcpm='+trim(frmPrincipal.edtTerminalBalcao.Text)+' and dtope='+QuotedStr(FormatDateTime('dd.mm.yyyy',now)) ;
            qryInsereDesconto.SQL.Text := 'update fc32100 set  tpdsc='+quotedstr(tpdescform)+',useridaut='+quotedstr('privilegeloja')+', vrtot='+TrocaVirgPPto(FloatToStr(valortotal))+', vrliq=VRTXAG+'+TrocaVirgPPto(FloatToStr(valortotal))+',vrcxa=VRTXAG+'+TrocaVirgPPto(FloatToStr(valortotal))+', vrarc=VRTXAG+'+TrocaVirgPPto(FloatToStr(valortotal))+' where  cdfil='+trim(frmPrincipal.edtLoja.Text)+' and nrcpm='+trim(frmPrincipal.edtTerminalBalcao.Text)+' and dtope  between '+QuotedStr(FormatDateTime('dd.mm.yyyy',now-15))+' and  '+QuotedStr(FormatDateTime('dd.mm.yyyy',now));
            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.CommitRetaining;
            qryInsereDesconto.Close;


            qryInsereDesconto.Close;
            qryInsereDesconto.SQL.Text := 'update totvsconf set ENV='+quotedstr('N') +' where  fil='+trim(frmPrincipal.edtLoja.Text)+' and cupom='+trim(frmPrincipal.edtTerminalBalcao.Text) ;
            qryInsereDesconto.ExecSQL;
            qryInsereDesconto.Connection.Commit;
            qryInsereDesconto.Close;


            showmessage('DESCONTO CONCEDIDO COM SUCESSO!');
            qrySelecionaDesconto.Close;
          end;



     frmInformaDesconto.Close;
   end;
end;


Procedure TfrmInformaDesconto.FormatarComoMoeda( Componente : TObject; var Key: Char );
var
   str_valor  : String;
   dbl_valor  : double;
begin

   { verificando se estamos recebendo o TEdit realmente }
   IF Componente is TEdit THEN
   BEGIN
      { se tecla pressionada e' um numero, backspace ou del deixa passar }
      IF CharInSet( Key, ['0'..'9', #8, #9] ) THEN
      BEGIN
         { guarda valor do TEdit com que vamos trabalhar }
         str_valor := TEdit( Componente ).Text ;
         { verificando se nao esta vazio }
         IF str_valor = EmptyStr THEN str_valor := '0,00' ;
         { se valor numerico ja insere na string temporaria }
         IF CharInSet(Key, ['0'..'9']) THEN str_valor := Concat( str_valor, Key ) ;
         { retira pontos e virgulas se tiver! }
         str_valor := Trim( StringReplace( str_valor, '.', '', [rfReplaceAll, rfIgnoreCase] ) ) ;
         str_valor := Trim( StringReplace( str_valor, ',', '', [rfReplaceAll, rfIgnoreCase] ) ) ;
         {inserindo 2 casas decimais}
         dbl_valor := StrToFloat( str_valor ) ;
         dbl_valor := ( dbl_valor / 100 ) ;

         {reseta posicao do tedit}
         TEdit( Componente ).SelStart := Length( TEdit( Componente ).Text );
         {retornando valor tratado ao TEdit}
         TEdit( Componente ).Text := FormatFloat( '###,##0.00', dbl_valor ) ;
      END;
      {se nao e' key relevante entao reseta}
      IF NOT CharInSet( Key, [#8, #9] ) THEN key := #0;
   END;

end;


end.
