unit uExtrato;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, {clipbrd,}
  IBX.IBCustomDataSet, IBX.IBQuery, Vcl.ComCtrls;

type
  TfrmExtrato = class(TForm)
    qryExtratoDiasForm: TIBQuery;
    qryAcrescimo: TIBQuery;
    qryExtratoDiasVar: TIBQuery;
    memExtrato: TRichEdit;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExtrato: TfrmExtrato;

implementation

{$R *.dfm}

uses uPrincipal, udmDescontos;

procedure TfrmExtrato.FormShow(Sender: TObject);
var     datainicial,datafinal,datatemp:tdate;
        valoracumulado,valordiario,acrescdia:Double;
begin

          datainicial := strtodate(FormatDateTime('01/mm/yyyy',now));
          datafinal := strtodate(FormatDateTime('dd/mm/yyyy',now));
          datatemp := strtodate(FormatDateTime('dd/mm/yyyy',now));
  memExtrato.Clear;

  {
  memExtrato.SelAttributes.Color:=clBLue; // Cor Azul
  memExtrato.SelAttributes.Style:=[fsBold,fsUnderline]; // Negrito e sublinhado
  memExtrato.Lines.Add('Linha'); // Adiciona linha
  memExtrato.SelAttributes.Style:=[]; // Volta ao estilo normal
  memExtrato.SelAttributes.Color:=clBlack;
   }


  memExtrato.SelAttributes.Color:=clBLue; // Cor Azul
  memExtrato.SelAttributes.Style:=[fsBold,fsUnderline]; // Negrito e sublinhado

  memExtrato.Lines.Add('META DE DESCONTO DO MÊS : '+FormatFloat('#####0.00',META)+' DIAS UTEIS :'+inttostr(diasuteis)  ) ;
  memExtrato.Lines.Add('CRÉDITO DIÁRIO : '+FormatFloat('#####0.00',META)+' / '+inttostr(diasuteis)+' = '+FormatFloat('#####0.00',META / diasuteis)  ) ;

  memExtrato.SelAttributes.Style:=[]; // Volta ao estilo normal
  memExtrato.SelAttributes.Color:=clBlack;

  memExtrato.Lines.Add(' ');
  memExtrato.Lines.Add(' ');

  qryAcrescimo.Close;
  qryAcrescimo.SQL.Text := ' select cdfil,mesrf,anorf,diarf,coalesce(ACRESCIMO,0) as ACRESCIMO from METADESCONTO02 '+
                           '  where cdfil='+frmPrincipal.edtLoja.Text+' and mesrf='+FormatDateTime('mm',now)+' and anorf='+FormatDateTime('yyyy',now);
  qryAcrescimo.Open;

  qryExtratoDiasForm.close;
  qryExtratoDiasForm.SQL.Text := ' SELECT  fc31200.dtope as DATA, fc31200.nrrqu as REQUISICAO,  FC31200.TPDSC As TipoItem, FC31200.TPDSCG As TipoGlobal, '+
                             ' (FC31200.VRDSC+FC31200.VRDSCG)    As ValorItem, '+
                             ' coalesce( (select trim(PARAMETRO) from FC99999 where ARGUMENTO='+quotedstr('DESCONTOR')+' and subargum=FC31200.TPDSC),'+quotedstr('DESCONTO NAO CADASTRADO')+') as  DESCRICAOTIPOITEM '+
                             ' from fc31200 '+
                             ' WHERE (    fc31200.DTOPE >= '+quotedstr(FormatDateTime('dd.mm.yyyy',datainicial)) +')'+
                             '  AND (fc31200.DTOPE <= '+quotedstr(FormatDateTime('dd.mm.yyyy',datafinal))   +')'+
                             '  AND (   ( (FC31200.useridaut<>'+quotedstr('privilegefunc')+') AND (FC31200.useridaut<>'+quotedstr('privilegem')+')  AND  (FC31200.useridaut<>'+quotedstr('privilebag')+')  AND  (FC31200.useridaut<>'+quotedstr('projetocrm')+')  AND (FC31200.useridaut<>'+quotedstr('privcabelos')+') AND (FC31200.useridaut<>'+quotedstr('privcortesia')+' )  AND (FC31200.useridaut<>'+quotedstr('privfranquia')+') AND (FC31200.useridaut<>'+quotedstr('privblackf')+') AND (FC31200.useridaut<>'+quotedstr('privcampanha')+')   ) '+
                             '  or   (FC31200.useridaut is NULL)   ) '+
                             '  AND NOT( FC31200.TPPAG IN ('+quotedstr('5')+','+quotedstr('6' )+' ))   AND (( FC31200.VRDSC + FC31200.VRDSCG ) > 0)   AND (FC31200.CDFIL='+frmPrincipal.edtLoja.Text+')'+
                             ' ORDER BY fc31200.DTOPE,fc31200.nrrqu ';

  //clipboard.astext:=qryExtratoDiasForm.sql.Text;
  qryExtratoDiasForm.Open;

  valordiario := strtofloat(FormatFloat('#####0.00',META / diasuteis));
  valoracumulado := 0;

  while not qryExtratoDiasForm.Eof  do
   begin

     if qryExtratoDiasForm.FieldValues['data']<>datatemp then
       begin

        qryAcrescimo.Close;
        qryAcrescimo.SQL.Text := 'select coalesce(SUM(ACRESCIMO),0) as ACRESCIMO from METADESCONTO02 where cdfil='+frmPrincipal.edtLoja.Text+' and mesrf='+FormatDateTime('mm',qryExtratoDiasForm.FieldValues['data'])+' and anorf='+FormatDateTime('yyyy',qryExtratoDiasForm.FieldValues['data'])+' and diarf='+FormatDateTime('dd',qryExtratoDiasForm.FieldValues['data']);
        qryAcrescimo.Open;

        acrescdia:=qryAcrescimo.FieldValues['ACRESCIMO'];
        qryAcrescimo.Close;

        datatemp:= qryExtratoDiasForm.FieldValues['data'];
        memExtrato.Lines.Add(' ');
        memExtrato.SelAttributes.Style:=[fsBold]; // Negrito e sublinhado

        memExtrato.Lines.Add( 'DIA : '+FormatDateTime('dd/mm/yyyy',qryExtratoDiasForm.FieldValues['data'])+' - Inicio : '+FormatFloat('#####0.00',valordiario)+' + (' +FormatFloat('#####0.00',valoracumulado)+') = ' +FormatFloat('#####0.00',valoracumulado + valordiario) );
        valoracumulado := valoracumulado + valordiario;

        if acrescdia>0 then
         begin
          memExtrato.SelAttributes.Style:=[fsBold]; // Negrito e sublinhado
          memExtrato.Lines.Add( 'ACRÉSCIMO : '+FormatFloat('#####0.00',acrescdia) +' - Acumulado : '+FormatFloat('#####0.00',valoracumulado)+' + (' +FormatFloat('#####0.00',acrescdia)+') = ' +FormatFloat('#####0.00',valoracumulado + acrescdia) );
          valoracumulado := valoracumulado + acrescdia;
         end;

        memExtrato.SelAttributes.Style:=[];
        memExtrato.Lines.Add(' ');

       end;

     valoracumulado := valoracumulado-qryExtratoDiasForm.FieldValues['valoritem'];
     memExtrato.Lines.Add( 'REQUISICAO : '+inttostr(qryExtratoDiasForm.FieldValues['REQUISICAO'])+' - VR :'+FormatFloat('#####0.00',qryExtratoDiasForm.FieldValues['valoritem'])+' - TIPO : '+qryExtratoDiasForm.FieldValues['DESCRICAOTIPOITEM']   );
     memExtrato.SelAttributes.Style:=[fsBold]; // Negrito e sublinhado
     memExtrato.Paragraph.Alignment:=taRightJustify;
     memExtrato.Lines.Add( 'DISPONÍVEL : '+FormatFloat('#####0.00',valoracumulado) );
     memExtrato.SelAttributes.Style:=[];
     memExtrato.Paragraph.Alignment:=taLeftJustify;
     qryExtratoDiasForm.Next;

     if (qryExtratoDiasForm.FieldValues['data']<>datatemp) or (qryExtratoDiasForm.eof)  then
           begin

            if (qryExtratoDiasForm.eof) then
             begin
                datainicial := strtodate(FormatDateTime('dd/mm/yyyy',qryExtratoDiasForm.FieldValues['data']));
                datafinal := strtodate(FormatDateTime('dd/mm/yyyy',qryExtratoDiasForm.FieldValues['data']));
             end
              else
               begin
                datainicial := strtodate(FormatDateTime('dd/mm/yyyy',datatemp));
                datafinal := strtodate(FormatDateTime('dd/mm/yyyy',datatemp));
               end;


          qryExtratoDiasVar.close;
          qryExtratoDiasVar.SQL.Text :=       ' SELECT DISTINCT '+
                                              ' fc31100.DTOPE         As DATA, '+
                                              ' coalesce(fc31100.NRNFCE,fc31100.nrcpm )        As CUPOM, '+
                                              ' fc31100.TPDSC         As TipoItem, '+
                                              ' fc31100.TPDSCG        As TipoGlobal,'+
                                              ' coalesce(fc31100.USERIDAUT,'+quotedstr('semautorizador')+')    As USERIDAUT, '+
                                              '       SUM(fc31110.VRDSC)+SUM(fc31110.VRDSCV)    As ValorItem, '+
                                              '       SUM(fc31110.VRDSCV)   As ValorGlobal, '+
                                              ' coalesce((select trim(PARAMETRO) from FC99999 where ARGUMENTO='+quotedstr('DESCONTOV')+' and subargum=fc31100.TPDSC),'+quotedstr('DESCONTO NAO CADASTRADO')+' ) as  DESCRICAOTIPOITEM,'+
                                              ' coalesce((select trim(PARAMETRO) from FC99999 where ARGUMENTO='+quotedstr('DESCONTOV')+' and subargum=fc31100.TPDSCG),'+quotedstr('DESCONTO NAO CADASTRADO')+' ) as DESCRICAOTIPOGLOBAL'+
                                              '  FROM  fc31100 '+
                                              '  INNER JOIN fc31110 ON '+
                                              '      (fc31110.CDFIL  =  fc31100.CDFIL) '+
                                              '  AND (fc31110.CDTML  =  fc31100.CDTML) '+
                                              '  AND (fc31110.DTOPE  =  fc31100.DTOPE) '+
                                              '  AND (fc31110.OPERID =  fc31100.OPERID) '+
                                              '  AND (fc31110.NRCPM  =  fc31100.NRCPM) '+
                                              '  AND (fc31110.TPITM  = '+quotedstr('V')+')'+

                                              ' WHERE (    fc31100.DTOPE >= '+quotedstr(FormatDateTime('dd.mm.yyyy',datainicial)) +')'+
                                              '        AND (fc31100.DTOPE <= '+quotedstr(FormatDateTime('dd.mm.yyyy',datafinal))   +')'+
                                              '   AND (fc31100.CDFIL='+frmPrincipal.edtLoja.Text+')'+
                                              '  AND (   ( (FC31100.useridaut<>'+quotedstr('privilegefunc')+') AND (FC31100.useridaut<>'+quotedstr('privilegem')+')  AND  (FC31100.useridaut<>'+quotedstr('privilebag')+')  AND  (FC31100.useridaut<>'+quotedstr('projetocrm')+')  AND (FC31100.useridaut<>'+quotedstr('privcabelos')+') AND (FC31100.useridaut<>'+quotedstr('privcortesia')+' )  AND (FC31100.useridaut<>'+quotedstr('privfranquia')+' )  AND (FC31100.useridaut<>'+quotedstr('privblackf')+' ) and (FC31200.useridaut<>'+quotedstr('privcampanha')+') ) '+
                                              '  or   (FC31100.useridaut is NULL)   ) '+
                                              ' GROUP BY fc31100.DTOPE,2,fc31100.TPDSC, fc31100.TPDSCG,fc31100.USERIDAUT'+
                                              ' Having Sum(fc31110.VRDSC + fc31110.VRDSCV) > 0 '+
                                              ' ORDER BY fc31100.DTOPE,2 ';


//            Clipboard.AsText := qryExtratoDiasVar.SQL.Text;
          qryExtratoDiasVar.Open;




            while not qryExtratoDiasVar.eof do
             begin
               valoracumulado := valoracumulado-qryExtratoDiasVar.FieldValues['valoritem'];
               memExtrato.Lines.Add( 'CUPOM VAREJO : '+inttostr(qryExtratoDiasVar.FieldValues['CUPOM'])+' - VR :'+FormatFloat('#####0.00',qryExtratoDiasVar.FieldValues['valoritem'])+' - TIPO : '+qryExtratoDiasVar.FieldValues['DESCRICAOTIPOITEM']   );
               memExtrato.SelAttributes.Style:=[fsBold]; // Negrito e sublinhado
               memExtrato.Paragraph.Alignment:=taRightJustify;
               memExtrato.Lines.Add( 'DISPONÍVEL : '+FormatFloat('#####0.00',valoracumulado) );
               memExtrato.SelAttributes.Style:=[];
               memExtrato.Paragraph.Alignment:=taLeftJustify;
               qryExtratoDiasVar.Next;
             end;

       end;



   end;

 memExtrato.SelStart := 1;
end;

end.
