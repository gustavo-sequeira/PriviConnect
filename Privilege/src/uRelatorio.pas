unit uRelatorio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, IBQuery, dateutils, {clipbrd,}
  StdCtrls, Buttons, ComCtrls, ExtCtrls, excelxp, COMOBJ;

type
  TfrmRelatorioDesconto = class(TForm)
    rgTipo: TRadioGroup;
    gbIntervalo: TGroupBox;
    StatusBar1: TStatusBar;
    btGerar: TBitBtn;
    brFechar: TBitBtn;
    qryTemp: TIBQuery;
    gbMedicos: TGroupBox;
    GroupBox1: TGroupBox;
    cbEspecialidade: TComboBox;
    GroupBox2: TGroupBox;
    edtNomeMed: TEdit;
    edtCR: TEdit;
    cbUFCRM: TComboBox;
    cbProfissao: TComboBox;
    gbProdutos: TGroupBox;
    cbProdutos: TComboBox;
    dtFinal: TDateTimePicker;
    dtInicial: TDateTimePicker;
    Inicial: TLabel;
    Label1: TLabel;
    qryTempPriv: TIBQuery;
    qryPriv2: TIBQuery;
    qryPesqMedicos: TIBQuery;
    procedure brFecharClick(Sender: TObject);
    procedure btGerarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbProfissaoChange(Sender: TObject);
    procedure GerarExcel(Consulta:TIBQuery);
    procedure edtCRKeyPress(Sender: TObject; var Key: Char);
    procedure edtCRChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioDesconto: TfrmRelatorioDesconto;
  cdfil,nrcpm:string;
implementation

uses udmDescontos, uBuscaMedicos;

{$R *.dfm}

Procedure TfrmRelatorioDesconto.GerarExcel(Consulta:TIBQuery);
var
     coluna, linha: integer;
     excel: variant;
     valor,titulo: string;
begin
     try
          excel:=CreateOleObject('Excel.Application');
          excel.Workbooks.add(1);
     except
          Application.MessageBox ('Versão do Ms-Excel'+
          'Incompatível','Erro',MB_OK+MB_ICONEXCLAMATION);
     end;

     Consulta.FetchAll;
     Consulta.First;


    titulo:='Filtros : ';
    if rgTipo.ItemIndex=0 then
      titulo:=titulo+' Sintético'
       else
      titulo:=titulo+' Analítico';

titulo:= titulo+', De : '+FormatDateTime('dd/mm/yyyy',dtInicial.Date);
titulo:= titulo+' Até : '+FormatDateTime('dd/mm/yyyy',dtFinal.Date);
titulo:= titulo+', Produtos : '+trim(cbProdutos.Text);
titulo:= titulo+', Profissão : '+trim(cbProfissao.Text);
titulo:= titulo+', Profissão : '+trim(cbProfissao.Text);
titulo:= titulo+', Especialidade : '+trim(cbEspecialidade.Text);
if trim(edtNomeMed.Text)<>'' then titulo:= titulo+', Médico : '+trim(edtNomeMed.Text);

    Excel.cells[1,1]:=titulo;
    Excel.cells[1,1].Font.name:='Arial';
    Excel.cells[1,1].Font.Bold:=true;
    Excel.cells[1,1].Font.Size:=10;
  //  Excel.cells[1,1].Borders.Item[$0000000A].Weight := $FFFFEFD6;


         {For VerticalAlignment:

          Top:    -4160
          Center: -4108
          Bottom: -4107
          And HorizontalAlignment:

          Left:    -4131
          Center:  -4108
          Right:   -4152}



  if rgTipo.ItemIndex=0 then
   begin
    Excel.ActiveSheet.Range['A1:N1'].Merge;
    Excel.ActiveSheet.Range['A2:G2'].HorizontalAlignment := -4108;
    Excel.ActiveSheet.Range['A1:G2'].VerticalAlignment := -4108;
    Excel.ActiveSheet.Range['A2:G2'].Columns.Interior.ColorIndex :=15;
    Excel.ActiveSheet.Range['A1:G'+inttostr(Consulta.RecordCount+2)].Borders.LineStyle := xlContinuous;
   end
    else
     begin
      Excel.ActiveSheet.Range['A1:Q1'].Merge;
      Excel.ActiveSheet.Range['A1:Q2'].HorizontalAlignment := -4108;
      Excel.ActiveSheet.Range['A1:Q2'].VerticalAlignment := -4108;
      Excel.ActiveSheet.Range['A2:Q2'].Columns.Interior.ColorIndex :=15;
      Excel.ActiveSheet.Range['A1:Q'+inttostr(Consulta.RecordCount+2)].Borders.LineStyle := xlContinuous;
     end;


     try
        for linha:=0 to Consulta.RecordCount-1 do
        begin
            for coluna:=1 to Consulta.FieldCount do // eliminei a coluna 0 da relação do Excel
            begin
                 valor:= Consulta.Fields[coluna-1].AsString;

                 if (rgTipo.ItemIndex=0) and ((coluna=5) or  (coluna=6) ) then
                    excel.cells [linha+3,coluna]:=StrToCurr(valor)
                    else if (rgTipo.ItemIndex=0) and (coluna=7) then
                      excel.cells [linha+3,coluna]:=StrToInt(valor)
                       else if (rgTipo.ItemIndex=1) and (coluna=7) then
                        excel.cells [linha+3,coluna]:=StrToDate(valor)
                         else if (rgTipo.ItemIndex=1) and ((coluna=14) or  (coluna=15) )  then
                          excel.cells [linha+3,coluna]:=StrToCurr(valor)
                            else excel.cells [linha+3,coluna]:=trim(valor);

            end;
            Consulta.Next;
        end;

        for coluna:=1 to Consulta.FieldCount do // eliminei a coluna 0 da relação do Excel
        begin

          if rgTipo.ItemIndex=0 then
            begin
             case coluna of
               1:excel.cells[2,coluna]:='CRM';
               2:excel.cells[2,coluna]:='MEDICO';
               3:excel.cells[2,coluna]:='PROFISSAO';
               4:excel.cells[2,coluna]:='ESPECIALIDADE';
               5:excel.cells[2,coluna]:='VRTOTAL';
               6:excel.cells[2,coluna]:='VRDESCONTO';
               7:excel.cells[2,coluna]:='QTCOMPRAS';
             end;
            end
              else
               begin
                case coluna of
                  1:excel.cells[2,coluna]:='CRM';
                  2:excel.cells[2,coluna]:='MEDICO';
                  3:excel.cells[2,coluna]:='PROFISSAO';
                  4:excel.cells[2,coluna]:='ESPECIALIDADE';
                  5:excel.cells[2,coluna]:='CLIENTE';
                  6:excel.cells[2,coluna]:='CUPOM';
                  7:excel.cells[2,coluna]:='DATA';
                  8:excel.cells[2,coluna]:='HORA';
                  9:excel.cells[2,coluna]:='PARENTESCO';
                 10:excel.cells[2,coluna]:='TPVENDA';
                  11:excel.cells[2,coluna]:='FIL';
                  12:excel.cells[2,coluna]:='COD';
                  13:excel.cells[2,coluna]:='PRODUTO';
                  14:excel.cells[2,coluna]:='QUANT';
                  15:excel.cells[2,coluna]:='VRTOTAL';
                  16:excel.cells[2,coluna]:='VRDESCONTO';
                  17:excel.cells[2,coluna]:='FUNCIONÁRIO';
                end;
               end;


//             valor:= Consulta.Fields[coluna-1].DisplayLabel;
          //   excel.cells[1,coluna]:=valor;
        end;

        excel.columns.AutoFit; // esta linha é para fazer com que o Excel dimencione as células adequadamente.
        excel.visible:=true;
     except
          Application.MessageBox ('Aconteceu um erro desconhecido durante a conversão'+
          'da tabela para o Ms-Excel','Erro',MB_OK+MB_ICONEXCLAMATION);
     end;
end;



procedure TfrmRelatorioDesconto.brFecharClick(Sender: TObject);
begin
 frmRelatorioDesconto.Close;
end;

procedure TfrmRelatorioDesconto.btGerarClick(Sender: TObject);
var codesp,tpitm:string;
begin

 if dtInicial.Date>dtFinal.Date then raise Exception.Create('Corrija o intervalo de datas');

 qryTemp.Close;

 codesp:= trim(copy(cbEspecialidade.Text,pos(' - ',cbEspecialidade.Text)+3,length(cbEspecialidade.Text)-pos(' - ',cbEspecialidade.Text)+3));

 case cbProdutos.ItemIndex of
   0: tpitm:= quotedstr('R')+','+quotedstr('V');
   1: tpitm:= quotedstr('R');
   2: tpitm:= quotedstr('V');
 end;

 if rgTipo.ItemIndex=0 then
  begin
    qryTempPriv.SQL.Text:='select NRCRM as CRM,titularcartao as MEDICO,PROFISSAO, ESPECIALIDADE, sum(VRTOT) as VRTOTAL, sum(VRDSC) as VRDESCONTO,count(*) as QTCOMPRAS from descconcedidos,descconcitens where '+
                   ' descconcedidos.cdfil=descconcitens.cdfil and '+
                   ' descconcedidos.tbalcao=descconcitens.nrcpm ';
  end
   else
    begin
      qryTempPriv.SQL.Text:='select NRCRM as CRM,titularcartao as MEDICO,PROFISSAO, ESPECIALIDADE, COALESCE(CLIENTE, '+quotedstr('NAO INFORMADO')+' ) as CLIENTE, descconcedidos.tbalcao as CUPOM,descconcedidos.data,descconcedidos.hora,descconcedidos.parentesco as PARENTESCO, '+
                   ' case descconcitens.tpitm when '+ quotedstr('R')+' then '+quotedstr('FORMULA')+'  when '+ quotedstr('V')+' then  '+quotedstr('VAREJO')+' else '+quotedstr('Campo em branco ou valor incorreto')+' end as TPVENDA,'+
                   ' descconcitens.cdfil as FIL, descconcitens.cdpro as COD,descconcitens.descrprd as PRODUTO, descconcitens.quant, VRTOT as VRTOTAL, VRDSC as VRDESCONTO,  COALESCE(descconcedidos.nomefunc, '+quotedstr('NAO INFORMADO')+' ) as NOMEFUNC  from descconcedidos,descconcitens where '+
                   ' descconcedidos.cdfil=descconcitens.cdfil and '+
                   ' descconcedidos.tbalcao=descconcitens.nrcpm  ';
    end;

if cbProfissao.ItemIndex<>0 then
 begin
   qryTempPriv.SQL.Add(' and descconcedidos.pfcrm='+quotedstr(copy(cbProfissao.Text,1,1)));
   qryTempPriv.SQL.Add('  and descconcedidos.ufcrm='+quotedstr(cbUFCRM.Text));
   if trim(edtCR.Text)<>'' then qryTempPriv.SQL.Add(' and descconcedidos.nrcrm='+edtCR.Text);
 end;

if cbEspecialidade.ItemIndex<>0 then qryTempPriv.SQL.Add(' and descconcedidos.codesp='+quotedstr(codesp));
qryTempPriv.SQL.Add(' and descconcedidos.tipocartao = '+quotedstr('P'));
qryTempPriv.SQL.Add(' and descconcitens.tpitm in ('+tpitm+')');
qryTempPriv.SQL.Add(' and data between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.Date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.Date)) );


if rgTipo.ItemIndex=0 then qryTempPriv.SQL.Add(' group by 1,2,3,4');

//Clipboard.AsText := qryTempPriv.SQL.Text;

qryTempPriv.Open;

if qryTempPriv.IsEmpty then showmessage ( 'Busca não encontrou resultados')
 else
 GerarExcel(qryTempPriv);

qryTempPriv.Close;

end;

procedure TfrmRelatorioDesconto.FormShow(Sender: TObject);
begin

  qryTemp.Close;
  qryTemp.SQL.Text := 'select subargum,parametro from fc99999 where cdpar=14 and argumento='+quotedstr('PFCRM')+' order by 1';
  qryTemp.Open;
  cbProfissao.Clear;

  cbProfissao.Items.Add('0 - TODOS');

 while not qryTemp.eof do
  begin
   cbProfissao.Items.Add(trim(qryTemp.FieldValues['subargum'])+' - '+qryTemp.FieldValues['parametro']);
   qryTemp.Next;
  end;

  qryTemp.Close;

  cbProfissao.ItemIndex:=0;

  qryTemp.Close;
  qryTemp.SQL.Text := 'select parametro as ESPECIALIDADE,subargum as CDESP from fc99999 where cdpar=14 and argumento='+quotedstr('ESPEC')+' order by 1';
  qryTemp.Open;

  cbEspecialidade.Clear;

  cbEspecialidade.Items.Add('TODOS - 0');

  while not qryTemp.eof do
   begin
     cbEspecialidade.Items.Add(qryTemp.FieldValues['ESPECIALIDADE']+' - '+qryTemp.FieldValues['CDESP'] );
     qryTemp.Next;
   end;

   qryTemp.Close;

   cbEspecialidade.ItemIndex:=0;


   dtFinal.Date:=now;
   dtInicial.Date:=IncDay(now,-30);


end;

procedure TfrmRelatorioDesconto.cbProfissaoChange(Sender: TObject);
begin

 if cbProfissao.ItemIndex=0 then
  begin
   edtCR.Enabled:=false;
   edtNomeMed.Enabled:=false;
   edtcr.Color:=clScrollBar;
   edtNomeMed.Color:=clScrollBar;
   edtCR.Clear;
   edtNomeMed.Clear;
  end
    else
      begin
       edtCR.Enabled:=true;
       edtNomeMed.Enabled:=true;
       edtcr.Color:=clWindow;
       edtNomeMed.Color:=clWindow;
       edtCR.SetFocus;
      end;

end;

procedure TfrmRelatorioDesconto.edtCRKeyPress(Sender: TObject;
  var Key: Char);
begin

 if not CharInSet(Key, ['0'..'9',#8,#13]) then
  begin
   if trim(edtCR.Text)='' then
     begin
      edtNomeMed.Text:=key;
      edtNomeMed.SetFocus;
      edtNomeMed.SelStart:=2;
     end;

   if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;

    key := #0;
  end;



end;

procedure TfrmRelatorioDesconto.edtCRChange(Sender: TObject);
begin
 edtNomeMed.Clear;
end;

procedure TfrmRelatorioDesconto.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if (Key = VK_TAB) and ((trim(edtCR.Text)<>'') or (trim(edtNomeMed.Text)<>'')  ) then
    begin

      qryPesqMedicos.Close;

      if trim(edtCR.Text)<>'' then
         qryPesqMedicos.SQL.Text := 'select * from fc04000 where fc04000.nrcrm like '+QuotedStr(edtCR.Text+'%')+' and pfcrm='+quotedstr(trim(copy(cbProfissao.Text,1,2)))+' and ufcrm='+QuotedStr(cbUFCRM.Text)
           else
         qryPesqMedicos.SQL.Text := 'select * from fc04000 where fc04000.nomemed like '+QuotedStr(edtNomeMed.Text+'%')+' and pfcrm='+quotedstr(trim(copy(cbProfissao.Text,1,2)))+' and ufcrm='+QuotedStr(cbUFCRM.Text);

      qryPesqMedicos.Open;
      qryPesqMedicos.First;

      if qryPesqMedicos.IsEmpty then
        begin
          if trim(edtCR.Text)<>'' then
            ShowMessage('Nenhum médico cadastrado com esse CRM')
            else
              ShowMessage('Nenhum médico cadastrado com esse nome');
        end else  frmBuscaMedicos.ShowModal;

      edtNomeMed.SetFocus;

    end;

end;

end.
