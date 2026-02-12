unit uPlanilhaDescontos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Buttons, sSpeedButton,
  Vcl.ComCtrls, Vcl.StdCtrls, sLabel, sGroupBox ,{ clipbrd,} System.Win.ComObj, System.Math,
  IBX.IBCustomDataSet, IBX.IBQuery  ;

type
  TfrmPlanilhaDescontos = class(TForm)
    qryDados: TFDQuery;
    qryTemp: TFDQuery;
    GroupBox1: TsGroupBox;
    Label3D2: TsLabelFX;
    Label3D1: TsLabelFX;
    dtpFim: TDateTimePicker;
    dtpInicio: TDateTimePicker;
    btnGerar: TsSpeedButton;
    ProgressBar: TProgressBar;
    qryParametros: TIBQuery;
    edtFilial: TEdit;
    edtNomeFilial: TEdit;
    qryFilais: TFDQuery;
    sLabelFX1: TsLabelFX;
    procedure btnGerarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtFilialKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPlanilhaDescontos: TfrmPlanilhaDescontos;

implementation
uses udmDescontos , uPrincipal;
{$R *.dfm}

procedure TfrmPlanilhaDescontos.btnGerarClick(Sender: TObject);
var titulo , campanha :string;
  planilha :Variant;
  LnLinha:integer;
  vrUnitario , vrLiquido , vrDesconto, vrPercdesc :Real;
begin

    if dtpFim.Date<dtpInicio.Date then
      raise Exception.Create('CORRIJA A DATA.');


    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.add ('select  a.destnf, ');
    qryDados.SQL.add ('a.useridaut,a.cdfil,f.descrfil,a.dtope,a.operid,a.nrcpm,a.cdcli,c.nomecli,c.nrcnpj,a.cdconre,a.cdfunre,d.nomefun,b.tpitm,b.cdfilr, ');
//    qryDados.SQL.add ('b.cdpro, (b.pruni * b.quant) as prUniVarejo, b.vrliq as vrLiqVarejo,receitas.vrtot as prUniReceitas,receitas.vrliq as vrLiqReceitas ');
    qryDados.SQL.add ('b.cdpro, b.quant , (b.pruni * b.quant)  as prUniVarejo, b.vrliq as vrLiqVarejo,receitas.vrtot as prUniReceitas,receitas.vrliq as vrLiqReceitas ');
    qryDados.SQL.add ('from fc32100 a ');
    qryDados.SQL.add ('inner join fc32110 b on ');
    qryDados.SQL.add ('b.cdfil  = a.cdfil and ');
    qryDados.SQL.add ('b.cdtml  = a.cdtml and ');
    qryDados.SQL.add ('b.dtope  = a.dtope and ');
    qryDados.SQL.add ('b.operid = a.operid and ');
    qryDados.SQL.add ('b.nrcpm  = a.nrcpm ');

    qryDados.SQL.add ('left join fc07000 c on ');
    qryDados.SQL.add ('c.cdcli = a.cdcli ');

    qryDados.SQL.add ('left join fc08000 d on ');
    qryDados.SQL.add ('d.cdcon = a.cdconre and ');
    qryDados.SQL.add ('d.cdfun = a.cdfunre ');

    qryDados.SQL.add ('left join fc01000 f on ');
    qryDados.SQL.add ('f.cdfil = a.cdfil ');

    qryDados.SQL.add ('left join fc04000 e on ');
    qryDados.SQL.add ('e.pfcrm = a.pfcrm and ');
    qryDados.SQL.add ('e.ufcrm = a.ufcrm and ');
    qryDados.SQL.add ('e.nrcrm = a.nrcrm ');

    qryDados.SQL.add ('left join fc32200 receitas on ');
    qryDados.SQL.add ('receitas.cdfil  = b.cdfil and ');
    qryDados.SQL.add ('receitas.cdtml  = b.cdtml and ');
    qryDados.SQL.add ('receitas.dtope  = b.dtope and ');
    qryDados.SQL.add ('receitas.operid = b.operid and ');
    qryDados.SQL.add ('receitas.nrcpm  = b.nrcpm and ');
    qryDados.SQL.add ('receitas.itemid = b.itemid ');


    qryDados.SQL.add ('where a.useridaut<>''''  and a.dtope between '+QuotedStr(FormatDateTime('dd.mm.yyyy',dtpInicio.date))+' and '+QuotedStr(FormatDateTime('dd.mm.yyyy',dtpFim.date))+' ');

    if edtNomeFilial.Text  <> '' then
       qryDados.SQL.add (' and a.cdfil  = '+trim(edtFilial.Text)+'');

    qryDados.SQL.add ('order by a.dtope, a.cdfil, a.operid ');

    //clipboard.astext:=qryDados.sql.text;
    qryDados.Open;

    if qryDados.IsEmpty then
       raise Exception.Create('SEM DADOS');

    Screen.Cursor := crHourGlass;
    titulo:= 'Descontos concedidos no período de '+FormatDateTime('dd.mm.yyyy',dtpInicio.date)+' a '+FormatDateTime('dd.mm.yyyy',dtpFim.date);
    if edtNomeFilial.Text  <> '' then
       titulo:=  titulo + ' - Loja '+edtNomeFilial.Text;

    planilha:= CreateoleObject('Excel.Application');
    planilha.WorkBooks.add(1);
    planilha.caption := 'Exportando dados do dia';
    planilha.visible := true;

    planilha.cells[2,1]  := 'CAMPANHA';
    planilha.cells[2,2]  := 'CDFIL';
    planilha.cells[2,3]  := 'FILIAL';
    planilha.cells[2,4]  := 'DATA';
    planilha.cells[2,5]  := 'TERMINAL BALCÃO';
    planilha.cells[2,6]  := 'CÓD.CLIENTE';
    planilha.cells[2,7]  := 'CLIENTE';
    planilha.cells[2,8]  := 'CPF';
    planilha.cells[2,9]  := 'CON';
    planilha.cells[2,10] := 'CDFUN';
    planilha.cells[2,11] := 'NOME FUNC.';
    planilha.cells[2,12] := 'TIPO';
    planilha.cells[2,13] := 'CDFILR';
    planilha.cells[2,14] := 'REQUISIÇÃO';
    planilha.cells[2,15] := 'CÓDIGO';
    planilha.cells[2,16] := 'PRODUTO';
    planilha.cells[2,17] := 'QTD';
    planilha.cells[2,18] := 'PREÇO UNITARIO';
    planilha.cells[2,19] := 'DESCONTO';
    planilha.cells[2,20] := 'VALOR LIQUIDO';
    planilha.cells[2,21] := '%DESCONTO';
    planilha.cells[2,22] := 'PFCRM';
    planilha.cells[2,23] := 'UFCRM';
    planilha.cells[2,24] := 'NRCRM';
    planilha.cells[2,25] := 'NOME MÉDICO';


    LnLinha := 3;
    qryDados.FetchAll;
    qryDados.First;
    ProgressBar.Max := qryDados.RecordCount;
    ProgressBar.Position := 0;

    while not qryDados.Eof do
      begin


        if qryDados.FieldValues['destnf'] = null then
           begin
              campanha := qryDados.FieldByName('useridaut').AsString;
           end
        else
           begin

              qryParametros.Close;
              qryParametros.SQL.Clear;
              qryParametros.SQL.Text:='select nomecampanha from campanhas where idcamp ='+qryDados.FieldByName('destnf').AsString;
              qryParametros.Open;

              campanha := qryDados.FieldByName('useridaut').AsString+' - '+qryParametros.FieldByName('nomecampanha').AsString;
           end;

        planilha.cells[LnLinha,1]  :=  campanha;
        planilha.cells[LnLinha,2]  :=  qryDados.FieldByName('cdfil').AsString ;
        planilha.cells[LnLinha,3]  :=  qryDados.FieldByName('descrfil').AsString ;
        planilha.cells[LnLinha,4]  :=  FormatDateTime('dd.mm.yyyy',qryDados.FieldByName('dtope').AsDateTime);
        planilha.cells[LnLinha,5]  :=  qryDados.FieldByName('nrcpm').AsString ;
        planilha.cells[LnLinha,6]  :=  qryDados.FieldByName('cdcli').AsString ;
        planilha.cells[LnLinha,7]  :=  qryDados.FieldByName('nomecli').AsString ;
        planilha.cells[LnLinha,8]  :=  qryDados.FieldByName('nrcnpj').AsString ;
        planilha.Cells[Lnlinha,8].NumberFormat :=  '00000000000_);(00000000000)';

        planilha.cells[LnLinha,9]  :=  qryDados.FieldByName('cdconre').AsString ;
        planilha.cells[LnLinha,10] :=  qryDados.FieldByName('cdfunre').AsString ;
        planilha.cells[LnLinha,11] :=  qryDados.FieldByName('nomefun').AsString ;
        planilha.cells[LnLinha,12] :=  qryDados.FieldByName('tpitm').AsString ;


        if qryDados.FieldByName('tpitm').AsString = 'R' then
           begin
               planilha.cells[LnLinha,13] :=  qryDados.FieldByName('cdfilr').AsString ;
               planilha.cells[LnLinha,14] :=  qryDados.FieldByName('cdpro').AsString;
               planilha.cells[LnLinha,16] :=  'FÓRMULA MANIPULADA (A VISTA)' ;

               planilha.cells[LnLinha,17] :=  qryDados.FieldByName('QUANT').AsInteger;

               planilha.cells[LnLinha,18] :=  RoundTo(qryDados.FieldByName('prUniReceitas').asFloat,-2);
               planilha.Cells[Lnlinha,18].NumberFormat :=  'R$ #.##0,00_);(R$ #.##0,00)';

               planilha.cells[LnLinha,20] :=  RoundTo(qryDados.FieldByName('vrLiqReceitas').asFloat,-2);
               planilha.Cells[Lnlinha,20].NumberFormat :=  'R$ #.##0,00_);(R$ #.##0,00)';

               qryTemp.Close;
               qryTemp.SQL.Clear;
               qryTemp.SQL.add ('select req.pfcrm , req.ufcrm , req.nrcrm ,medicos.nomemed ');
               qryTemp.SQL.add ('from fc12100 req ');
               qryTemp.SQL.add ('inner join fc04000 medicos on ');
               qryTemp.SQL.add ('medicos.pfcrm = req.pfcrm and ');
               qryTemp.SQL.add ('medicos.ufcrm = req.ufcrm and ');
               qryTemp.SQL.add ('medicos.nrcrm = req.nrcrm ');
               qryTemp.SQL.add ('where req.cdfil = '+qryDados.FieldByName('cdfilr').AsString+' and req.nrrqu = '+qryDados.FieldByName('cdpro').AsString+' ');
               qryTemp.Open;
               qryTemp.First;

               planilha.cells[LnLinha,22] :=  qryTemp.FieldByName('pfcrm').AsString;
               planilha.cells[LnLinha,23] :=  qryTemp.FieldByName('ufcrm').AsString;
               planilha.cells[LnLinha,24] :=  qryTemp.FieldByName('nrcrm').AsString;
               planilha.cells[LnLinha,25] :=  qryTemp.FieldByName('nomemed').AsString;

               vrUnitario := qryDados.FieldByName('prUniReceitas').AsFloat;
               vrLiquido  := qryDados.FieldByName('vrLiqReceitas').AsFloat;

           end
        else
           begin
               qryTemp.Close;
               qryTemp.SQL.Clear;
               qryTemp.SQL.add ('select produtos.descr from fc03000 produtos ');
               qryTemp.SQL.add ('where produtos.cdpro = '+qryDados.FieldByName('cdpro').AsString+' ');
               qryTemp.Open;
               qryTemp.First;
               planilha.cells[LnLinha,15] :=  qryDados.FieldByName('cdpro').AsString ;
               planilha.cells[LnLinha,16] :=  qryTemp.FieldByName('descr').AsString ;

               planilha.cells[LnLinha,17] :=  qryDados.FieldByName('QUANT').AsInteger;

               planilha.cells[LnLinha,18] :=  RoundTo(qryDados.FieldByName('prUniVarejo').AsFloat,-2);
               planilha.Cells[Lnlinha,18].NumberFormat :=  'R$ #.##0,00_);(R$ #.##0,00)';

               planilha.cells[LnLinha,20] :=  RoundTo(qryDados.FieldByName('vrLiqVarejo').AsFloat,-2);
               planilha.Cells[Lnlinha,20].NumberFormat :=  'R$ #.##0,00_);(R$ #.##0,00)';

               vrUnitario := qryDados.FieldByName('prUniVarejo').AsFloat;
               vrLiquido  := qryDados.FieldByName('vrLiqVarejo').AsFloat;


           end;

        vrDesconto := vrUnitario - vrLiquido;
        vrPercdesc := 100 - ( ( vrLiquido * 100 ) / vrUnitario);

        planilha.cells[LnLinha,19] := RoundTo(vrDesconto,-2);
        planilha.Cells[Lnlinha,19].NumberFormat :=  'R$ #.##0,00_);(R$ #.##0,00)';

        planilha.cells[LnLinha,21] := RoundTo(vrPercdesc,-2);
        planilha.Cells[Lnlinha,21].NumberFormat :=  '###,00_);(###,00)';

        ProgressBar.Position := ProgressBar.Position + 1;

        LnLinha := LnLinha +1 ;
        qryDados.Next;
      end;

     planilha.columns.Autofit;

     planilha.cells[1,1] := titulo;
     planilha.ActiveSheet.Range['A1:X1'].Merge;
     planilha.ActiveSheet.Range['A1:X1'].HorizontalAlignment := -4108;
     planilha.ActiveSheet.Range['A1:X1'].Columns.Interior.ColorIndex :=15;
     planilha.ActiveSheet.Range['A2:X2'].Borders.LineStyle := 1;


     planilha.visible := true;
  //   planilha.Quit;

     Screen.Cursor := crDefault;
     ProgressBar.Position := 0;
end;

procedure TfrmPlanilhaDescontos.edtFilialKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not(key in ['0'..'9',#8,#13]) then key := #0;
  if (Key=#13) and (trim(edtFilial.Text)<>'') then
    begin
        qryFilais.Close;
        qryFilais.Open;
        if qryFilais.Locate('cdfil',edtFilial.Text,[])=false
           then ShowMessage('Filial Inexistente')
        else
          begin
            edtNomeFilial.Text := qryFilais.FieldValues['descrfil'];
          end;

  end;

  if edtFilial.Text = '' then
     begin
       edtNomeFilial.Text := '';
     end;


end;

procedure TfrmPlanilhaDescontos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   ProgressBar.Position := 0;
   edtNomeFilial.Text := '';
   edtFilial.Text := '';
end;

procedure TfrmPlanilhaDescontos.FormShow(Sender: TObject);
begin
 dtpInicio.date := now;
 dtpFim.Date := now;

end;

end.
