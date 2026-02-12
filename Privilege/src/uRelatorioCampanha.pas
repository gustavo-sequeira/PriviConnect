unit uRelatorioCampanha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, IBX.IBCustomDataSet, excelxp,COMOBJ,
  IBX.IBQuery, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TfrmRelCampanhas = class(TForm)
    rgTipo: TRadioGroup;
    gbIntervalo: TGroupBox;
    Inicial: TLabel;
    Label1: TLabel;
    dtFinal: TDateTimePicker;
    dtInicial: TDateTimePicker;
    StatusBar1: TStatusBar;
    btGerar: TBitBtn;
    brFechar: TBitBtn;
    gbRelatorios: TGroupBox;
    rbParceito: TRadioButton;
    rbCliente: TRadioButton;
    rbFatvsDesc: TRadioButton;
    GroupBox2: TGroupBox;
    cbLoja: TComboBox;
    qryTemp: TIBQuery;
    qryFcerta: TIBQuery;
    qryDescontos: TIBQuery;
    GroupBox1: TGroupBox;
    cbNomeCampanha: TComboBox;
    edtNomeCliente: TEdit;
    edtCPF: TEdit;
    procedure rbParceitoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btGerarClick(Sender: TObject);
    procedure rbClienteClick(Sender: TObject);
    procedure rbFatvsDescClick(Sender: TObject);
    procedure brFecharClick(Sender: TObject);
    procedure GerarExcel(Consulta:TIBQuery );
    procedure GerarExcel2(Consulta:TIBQuery );
    procedure emiteparceiro;
    procedure emitecliente;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCampanhas: TfrmRelCampanhas;
  todasfiliais:string;

implementation

{$R *.dfm}

uses udmDescontos;

procedure TfrmRelCampanhas.brFecharClick(Sender: TObject);
begin
 frmRelCampanhas.Close;
end;



Procedure TfrmRelCampanhas.GerarExcel(Consulta:TIBQuery);
var  cor1,cor2,cor3,coratual:real;
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


if rgTipo.ItemIndex=0 then
      titulo:=titulo+' SINTÉTICO'
       else
      titulo:=titulo+' ANALÍTICO';


    Excel.ActiveWindow.DisplayGridlines := False;
    Excel.ActiveSheet.Name := 'PARCEIRO';

    titulo:= titulo+' - '+trim(cbLoja.Text);

    if rgTipo.ItemIndex=0 then
     begin
        Excel.ActiveSheet.Range['A1:G1'].Merge;
        Excel.ActiveSheet.Range['A1:G1'].HorizontalAlignment := -4108;
     end
      else
       begin
        Excel.ActiveSheet.Range['A1:G1'].Merge;
        Excel.ActiveSheet.Range['A1:G1'].HorizontalAlignment := -4108;
       end;

    Excel.cells[1,1]:='POR PARCEIRO';

    Excel.cells[1,1].Font.name:='Calibri';
    Excel.cells[1,1].Font.Bold:=true;
    Excel.cells[1,1].Font.Size:=14;


    if rgTipo.ItemIndex=0 then
     begin
       Excel.ActiveSheet.Range['A2:D2'].Merge;
       Excel.ActiveSheet.Range['A2:D2'].HorizontalAlignment := -4108;
     end
      else
       begin
        Excel.ActiveSheet.Range['A2:G2'].Merge;
        Excel.ActiveSheet.Range['A2:G2'].HorizontalAlignment := -4108;
       end;


    Excel.cells[2,1]:='PERÍODO : '+FormatDateTime('dd/mm/yyyy',dtInicial.Date)+' - '+FormatDateTime('dd/mm/yyyy',dtFinal.Date);

    Excel.cells[2,1].Font.name:='Arial';
    Excel.cells[2,1].Font.Bold:=true;
    Excel.cells[2,1].Font.Size:=10;


    if rgTipo.ItemIndex=0 then
     begin
       Excel.ActiveSheet.Range['A3:F3'].Merge;
       Excel.ActiveSheet.Range['A3:F3'].HorizontalAlignment := -4108;
     end
      else
        begin
         Excel.ActiveSheet.Range['A3:I3'].Merge;
         Excel.ActiveSheet.Range['A3:I3'].HorizontalAlignment := -4108;
        end;


    Excel.cells[3,1]:= titulo;

    Excel.cells[3,1].Font.name:='Arial';
    Excel.cells[3,1].Font.Bold:=true;
    Excel.cells[3,1].Font.Size:=9;

    cor1:=-0.199977111117893;
    cor2:=0.549977111117893;
    cor3:=0.249977111117893;
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
    Excel.ActiveSheet.Range['A4:G4'].HorizontalAlignment := -4108;
    Excel.ActiveSheet.Range['A4:G4'].VerticalAlignment := -4108;
    Excel.ActiveSheet.Range['A4:G4'].Columns.Interior.ColorIndex :=  37;
    Excel.ActiveSheet.Range['A4:G4'].Columns.Interior.TintAndShade := cor1;
    Excel.ActiveSheet.Range['A4:G4'].Font.Bold:=true;
    Excel.ActiveSheet.Range['A4:G'+inttostr(Consulta.RecordCount+5)].Borders.LineStyle := xlContinuous;
   end
    else
     begin
      Excel.ActiveSheet.Range['A4:I4'].HorizontalAlignment := -4108;
      Excel.ActiveSheet.Range['A4:I4'].VerticalAlignment := -4108;
      Excel.ActiveSheet.Range['A4:I4'].Columns.Interior.ColorIndex :=37;
      Excel.ActiveSheet.Range['A4:I4'].Columns.Interior.TintAndShade := cor1;
      Excel.ActiveSheet.Range['A4:I4'].Font.Bold:=true;
      Excel.ActiveSheet.Range['A4:I'+inttostr(Consulta.RecordCount+5)].Borders.LineStyle := xlContinuous;
     end;


     try
        for linha:=0 to Consulta.RecordCount-1 do
        begin
            for coluna:=1 to Consulta.FieldCount do // eliminei a coluna 0 da relação do Excel
            begin
                 valor:= Consulta.Fields[coluna-1].AsString;

                 if (rgTipo.ItemIndex=0) and ((coluna>1) and (coluna<5) ) then
                    excel.cells [linha+5,coluna]:=StrToCurr(valor)
                    else if (rgTipo.ItemIndex=0) and (coluna>4) then
                        excel.cells [linha+5,coluna]:=StrToInt(valor)
                       else if (rgTipo.ItemIndex=1) and (coluna=3) then
                        excel.cells [linha+5,coluna]:=StrToDate(valor)
                         else if (rgTipo.ItemIndex=1) and ((coluna>4) )  then
                          excel.cells [linha+5,coluna]:=StrToCurr(valor)
                            else excel.cells [linha+5,coluna]:=trim(valor);

            end;

            if coratual=cor2 then
               coratual := cor3
                else
               coratual:=cor2;

           if rgTipo.ItemIndex=0 then
            BEGIN
             Excel.ActiveSheet.Range['A'+inttostr(linha+5)+':G'+inttostr(linha+5)].Columns.Interior.ColorIndex :=37;
             Excel.ActiveSheet.Range['A'+inttostr(linha+5)+':G'+inttostr(linha+5)].Columns.Interior.TintAndShade := coratual;
            END
             else
               begin
                Excel.ActiveSheet.Range['A'+inttostr(linha+5)+':I'+inttostr(linha+5)].Columns.Interior.ColorIndex :=37;
                Excel.ActiveSheet.Range['A'+inttostr(linha+5)+':I'+inttostr(linha+5)].Columns.Interior.TintAndShade := coratual;
               end;
            Consulta.Next;
        end;



       Excel.cells[Consulta.RecordCount+5,1]:='TOTAL';

       if rgTipo.ItemIndex=0 then
          BEGIN
           Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':A'+inttostr(Consulta.RecordCount+5)].Merge;
           Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':A'+inttostr(Consulta.RecordCount+5)].HorizontalAlignment := -4108;
           Excel.cells[Consulta.RecordCount+5,2]:='=SUM(B5:B'+IntToStr(Consulta.RecordCount+4)+')';
           Excel.cells[Consulta.RecordCount+5,3]:='=SUM(C5:C'+IntToStr(Consulta.RecordCount+4)+')';
           Excel.cells[Consulta.RecordCount+5,4]:='=SUM(D5:D'+IntToStr(Consulta.RecordCount+4)+')';
           Excel.cells[Consulta.RecordCount+5,5]:='=SUM(E5:E'+IntToStr(Consulta.RecordCount+4)+')';
           Excel.cells[Consulta.RecordCount+5,6]:='=SUM(F5:F'+IntToStr(Consulta.RecordCount+4)+')';
           Excel.cells[Consulta.RecordCount+5,7]:='=SUM(G5:G'+IntToStr(Consulta.RecordCount+4)+')';
          END
           else
             begin
               Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':D'+inttostr(Consulta.RecordCount+5)].Merge;
               Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':D'+inttostr(Consulta.RecordCount+5)].HorizontalAlignment := -4108;
               Excel.cells[Consulta.RecordCount+5,5]:='=SUM(E5:E'+IntToStr(Consulta.RecordCount+4)+')';
               Excel.cells[Consulta.RecordCount+5,6]:='=SUM(F5:F'+IntToStr(Consulta.RecordCount+4)+')';
               Excel.cells[Consulta.RecordCount+5,7]:='=SUM(G5:G'+IntToStr(Consulta.RecordCount+4)+')';
               Excel.cells[Consulta.RecordCount+5,8]:='=SUM(H5:H'+IntToStr(Consulta.RecordCount+4)+')';
               Excel.cells[Consulta.RecordCount+5,9]:='=SUM(I5:I'+IntToStr(Consulta.RecordCount+4)+')';
             end;


  if rgTipo.ItemIndex=0 then
    BEGIN
       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':G'+inttostr(Consulta.RecordCount+5)].Font.Bold:=true;
       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':G'+inttostr(Consulta.RecordCount+5)].Columns.Interior.ColorIndex :=37;
       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':G'+inttostr(Consulta.RecordCount+5)].Columns.Interior.TintAndShade := cor1;
    END
     else
       begin
        Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':I'+inttostr(Consulta.RecordCount+5)].Font.Bold:=true;
        Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':I'+inttostr(Consulta.RecordCount+5)].Columns.Interior.ColorIndex :=37;
        Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':I'+inttostr(Consulta.RecordCount+5)].Columns.Interior.TintAndShade := cor1;
       end;

        for coluna:=1 to Consulta.FieldCount do // eliminei a coluna 0 da relação do Excel
        begin

          if rgTipo.ItemIndex=0 then
            begin
             case coluna of
               1:excel.cells[4,coluna]:='PARCEIRO';
               2:excel.cells[4,coluna]:='VALOR BRUTO';
               3: begin
                    excel.cells[4,coluna]:='VALOR DESCONTO';
                    excel.cells[4,coluna+1]:='VALOR LIQUIDO';
                    excel.cells[4,coluna+2]:='QTD VAREJO';
                    excel.cells[4,coluna+3]:='QTD FORMULA';
                    excel.cells[4,coluna+4]:='QTD CUPONS';

                   end;
             end;
            end
              else
               begin
                case coluna of
                  1:excel.cells[4,coluna]:='PARCEIRO';
                  2:excel.cells[4,coluna]:='FILIAL';
                  3:excel.cells[4,coluna]:='DT VENDA';
                  4:excel.cells[4,coluna]:='CUPOM';
                  5:excel.cells[4,coluna]:='VR BRUTO';
                  6:excel.cells[4,coluna]:='VR DESCONTO';
                  7:excel.cells[4,coluna]:='VR LIQUIDO';
                  8:excel.cells[4,coluna]:='QTD VAREJO';
                  9:excel.cells[4,coluna]:='QTD FORMULA';
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



Procedure TfrmRelCampanhas.GerarExcel2(Consulta:TIBQuery);
var  cor1,cor2,cor3,coratual:real;
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


if rgTipo.ItemIndex=0 then
      titulo:=titulo+' SINTÉTICO'
       else
      titulo:=titulo+' ANALÍTICO';


    Excel.ActiveWindow.DisplayGridlines := False;
    Excel.ActiveSheet.Name := 'CLIENTE';

    titulo:= titulo+' - '+trim(cbLoja.Text);

    if rgTipo.ItemIndex=0 then
     begin
        Excel.ActiveSheet.Range['A1:D1'].Merge;
        Excel.ActiveSheet.Range['A1:D1'].HorizontalAlignment := -4108;
     end
      else
       begin
        Excel.ActiveSheet.Range['A1:H1'].Merge;
        Excel.ActiveSheet.Range['A1:H1'].HorizontalAlignment := -4108;
       end;

    Excel.cells[1,1]:='POR CLIENTE';

    Excel.cells[1,1].Font.name:='Calibri';
    Excel.cells[1,1].Font.Bold:=true;
    Excel.cells[1,1].Font.Size:=14;


    if rgTipo.ItemIndex=0 then
     begin
       Excel.ActiveSheet.Range['A2:D2'].Merge;
       Excel.ActiveSheet.Range['A2:D2'].HorizontalAlignment := -4108;
     end
      else
       begin
        Excel.ActiveSheet.Range['A2:H2'].Merge;
        Excel.ActiveSheet.Range['A2:H2'].HorizontalAlignment := -4108;
       end;


    Excel.cells[2,1]:='PERÍODO : '+FormatDateTime('dd/mm/yyyy',dtInicial.Date)+' - '+FormatDateTime('dd/mm/yyyy',dtFinal.Date);

    Excel.cells[2,1].Font.name:='Arial';
    Excel.cells[2,1].Font.Bold:=true;
    Excel.cells[2,1].Font.Size:=10;


    if rgTipo.ItemIndex=0 then
     begin
       Excel.ActiveSheet.Range['A3:D3'].Merge;
       Excel.ActiveSheet.Range['A3:D3'].HorizontalAlignment := -4108;
     end
      else
        begin
         Excel.ActiveSheet.Range['A3:H3'].Merge;
         Excel.ActiveSheet.Range['A3:H3'].HorizontalAlignment := -4108;
        end;


    Excel.cells[3,1]:= titulo;

    Excel.cells[3,1].Font.name:='Arial';
    Excel.cells[3,1].Font.Bold:=true;
    Excel.cells[3,1].Font.Size:=9;

    cor1:=-0.199977111117893;
    cor2:=0.549977111117893;
    cor3:=0.249977111117893;
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
    Excel.ActiveSheet.Range['A4:D4'].HorizontalAlignment := -4108;
    Excel.ActiveSheet.Range['A4:D4'].VerticalAlignment := -4108;
    Excel.ActiveSheet.Range['A4:D4'].Columns.Interior.ColorIndex :=  37;
    Excel.ActiveSheet.Range['A4:D4'].Columns.Interior.TintAndShade := cor1;
    Excel.ActiveSheet.Range['A4:D4'].Font.Bold:=true;
    Excel.ActiveSheet.Range['A4:D'+inttostr(Consulta.RecordCount+5)].Borders.LineStyle := xlContinuous;
   end
    else
     begin
      Excel.ActiveSheet.Range['A4:H4'].HorizontalAlignment := -4108;
      Excel.ActiveSheet.Range['A4:H4'].VerticalAlignment := -4108;
      Excel.ActiveSheet.Range['A4:H4'].Columns.Interior.ColorIndex :=37;
      Excel.ActiveSheet.Range['A4:H4'].Columns.Interior.TintAndShade := cor1;
      Excel.ActiveSheet.Range['A4:H4'].Font.Bold:=true;
      Excel.ActiveSheet.Range['A4:H'+inttostr(Consulta.RecordCount+5)].Borders.LineStyle := xlContinuous;
     end;


     try
        for linha:=0 to Consulta.RecordCount-1 do
        begin
            for coluna:=1 to Consulta.FieldCount do // eliminei a coluna 0 da relação do Excel
            begin
                 valor:= Consulta.Fields[coluna-1].AsString;

                 if (rgTipo.ItemIndex=0) and ((coluna>1) ) then
                    excel.cells [linha+5,coluna]:=StrToCurr(valor)
                       else if (rgTipo.ItemIndex=1) and (coluna=4) then
                        excel.cells [linha+5,coluna]:=StrToDate(valor)
                         else if (rgTipo.ItemIndex=1) and ((coluna>5 ))  then
                          excel.cells [linha+5,coluna]:=StrToCurr(valor)
                            else excel.cells [linha+5,coluna]:=trim(valor);

            end;

            if coratual=cor2 then
               coratual := cor3
                else
               coratual:=cor2;

           if rgTipo.ItemIndex=0 then
            BEGIN
             Excel.ActiveSheet.Range['A'+inttostr(linha+5)+':D'+inttostr(linha+5)].Columns.Interior.ColorIndex :=37;
             Excel.ActiveSheet.Range['A'+inttostr(linha+5)+':D'+inttostr(linha+5)].Columns.Interior.TintAndShade := coratual;
            END
             else
               begin
                Excel.ActiveSheet.Range['A'+inttostr(linha+5)+':H'+inttostr(linha+5)].Columns.Interior.ColorIndex :=37;
                Excel.ActiveSheet.Range['A'+inttostr(linha+5)+':H'+inttostr(linha+5)].Columns.Interior.TintAndShade := coratual;
               end;
            Consulta.Next;
        end;



       Excel.cells[Consulta.RecordCount+5,1]:='TOTAL';

       if rgTipo.ItemIndex=0 then
          BEGIN
           Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':A'+inttostr(Consulta.RecordCount+5)].Merge;
           Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':A'+inttostr(Consulta.RecordCount+5)].HorizontalAlignment := -4108;
           Excel.cells[Consulta.RecordCount+5,2]:='=SUM(B5:B'+IntToStr(Consulta.RecordCount+4)+')';
           Excel.cells[Consulta.RecordCount+5,3]:='=SUM(C5:C'+IntToStr(Consulta.RecordCount+4)+')';
           Excel.cells[Consulta.RecordCount+5,4]:='=SUM(D5:D'+IntToStr(Consulta.RecordCount+4)+')';
          END
           else
             begin
               Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':E'+inttostr(Consulta.RecordCount+5)].Merge;
               Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':E'+inttostr(Consulta.RecordCount+5)].HorizontalAlignment := -4108;
               Excel.cells[Consulta.RecordCount+5,6]:='=SUM(F5:F'+IntToStr(Consulta.RecordCount+4)+')';
               Excel.cells[Consulta.RecordCount+5,7]:='=SUM(G5:G'+IntToStr(Consulta.RecordCount+4)+')';
               Excel.cells[Consulta.RecordCount+5,8]:='=SUM(H5:H'+IntToStr(Consulta.RecordCount+4)+')';
             end;


  if rgTipo.ItemIndex=0 then
    BEGIN
       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':D'+inttostr(Consulta.RecordCount+5)].Font.Bold:=true;
       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':D'+inttostr(Consulta.RecordCount+5)].Columns.Interior.ColorIndex :=37;
       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':D'+inttostr(Consulta.RecordCount+5)].Columns.Interior.TintAndShade := cor1;
    END
     else
       begin
        Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':H'+inttostr(Consulta.RecordCount+5)].Font.Bold:=true;
        Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':H'+inttostr(Consulta.RecordCount+5)].Columns.Interior.ColorIndex :=37;
        Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':H'+inttostr(Consulta.RecordCount+5)].Columns.Interior.TintAndShade := cor1;
       end;

        for coluna:=1 to Consulta.FieldCount do // eliminei a coluna 0 da relação do Excel
        begin

          if rgTipo.ItemIndex=0 then
            begin
             case coluna of
               1:excel.cells[4,coluna]:='CLIENTE';
               2:excel.cells[4,coluna]:='VALOR BRUTO';
               3: begin
                    excel.cells[4,coluna]:='VALOR DESCONTO';
                    excel.cells[4,coluna+1]:='VALOR LIQUIDO';
                   end;
             end;
            end
              else
               begin
                case coluna of
                  1:excel.cells[4,coluna]:='CLIENTE';
                  2:excel.cells[4,coluna]:='PARCEIRO';
                  3:excel.cells[4,coluna]:='FILIAL';
                  4:excel.cells[4,coluna]:='DT VENDA';
                  5:excel.cells[4,coluna]:='CUPOM';
                  6:excel.cells[4,coluna]:='VR BRUTO';
                  7:excel.cells[4,coluna]:='VR DESCONTO';
                  8:excel.cells[4,coluna]:='VR LIQUIDO';
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

procedure   TfrmRelCampanhas.emiteparceiro;
var query:string;
begin

 query:= 'select b.nomecampanha, c.descrfil,a.dtvend,a.cupomoficial,a.vrbruto,a.vrdesc,a.vrliq, iif(d.tpitm='+quotedstr('V')+',quant,0 ) as QTDVAREJO, iif(d.tpitm='+quotedstr('R')+',quant,0 ) as QTDFORMULA '+
                              ' from campanhasvendas01 a,campanhas B, Filiais C, campanhasvendas02 d '+
                              ' where '+
                              ' a.cdfil=d.cdfil and a.cupomint=d.nrcpm and a.dtvend=d.dtvend and '+
                              ' a.idcamp=b.idcamp and '+
                              ' a.cdfil=c.cdfil and '+
                              ' a.dtvend between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.Date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.Date));

     if trim(copy(cbLoja.Text,1,3))<>'0' then
       begin
        query:=query+' and a.cdfil='+trim(copy(cbLoja.Text,1,3));
       end;
        query:=query+' order by  b.nomecampanha,a.dtvend,C.DESCRFIL';

  qryDescontos.Close;

if rgtipo.ItemIndex=0  then
 begin
  query := ' SELECT NOMECAMPANHA, SUM(VRBRUTO) AS VRBRUTO, SUM(VRDESC) AS VRDESC, SUM(VRLIQ) AS VRLIQ, sum(QTDVAREJO) as QTDVAREJO, sum(QTDFORMULA) as QTDFORMULA, sum(QTDCUPOM) AS QTDCUPOM FROM ( '+#13+
           '  SELECT NOMECAMPANHA, VRBRUTO, VRDESC, VRLIQ, sum(QTDVAREJO) as QTDVAREJO, sum(QTDFORMULA) as QTDFORMULA, COUNT(DISTINCT CUPOMOFICIAL) AS QTDCUPOM  from ( '+#13+query+#13+') group by 1,2,3,4 ) GROUP BY 1';
 end;

 qryDescontos.SQL.Text := query;
 qryDescontos.Open;

 GerarExcel(qryDescontos);

end;


procedure  TfrmRelCampanhas.emitecliente;
var query:string;
begin

 query:= 'select d.nomecli,b.nomecampanha, c.descrfil,a.dtvend,a.cupomoficial,a.vrbruto,a.vrdesc,a.vrliq '+
                              ' from campanhasvendas01 a,campanhas B, Filiais C,campanhasclientes D '+
                              ' where '+
                              ' a.idcamp=b.idcamp and '+
                              ' a.cdfil=c.cdfil and '+
                              ' a.cpfcli=d.cpfcli and '+
                              ' a.idcamp=d.idcamp and '+
                              ' a.dtvend between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.Date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.Date));

     if trim(copy(cbLoja.Text,1,3))<>'0' then
       begin
        query:=query+' and a.cdfil='+trim(copy(cbLoja.Text,1,3));
       end;
        query:=query+' order by  D.nomecli,a.dtvend,C.DESCRFIL';

  qryDescontos.Close;

if rgtipo.ItemIndex=0  then
 begin
  query := 'SELECT NOMECLI,SUM(VRBRUTO) AS VRBRUTO,SUM(VRDESC) AS VRDESC,SUM(VRLIQ) AS VRLIQ from ( '+#13+query+#13+') group by 1';
 end;

 qryDescontos.SQL.Text := query;
 qryDescontos.Open;

 GerarExcel2(qryDescontos);

end;

procedure TfrmRelCampanhas.btGerarClick(Sender: TObject);
begin

 if rbParceito.Checked then
  begin
    emiteparceiro;
  end;

 if rbCliente.Checked then
  begin
    emitecliente;
  end;

end;

procedure TfrmRelCampanhas.FormCreate(Sender: TObject);
begin

  cbLoja.Clear;
  qryTemp.Close;
  qryTemp.SQL.Text := 'select CDFIL, DESCRFIL from FC01000 WHERE GRUPOFIL='+QuotedStr('03')+' ORDER BY CDFIL';
  qryTemp.Open;
  todasfiliais:='0';
  with qryTemp do
   begin
     if not(IsEmpty) then
      begin
        First;
        cbLoja.Items.Add('0  - TODAS');
        while not Eof do
         begin
          cbLoja.Items.Add(inttostr(FieldValues['CDFIL'])+'  - '+FieldValues['DESCRFIL']);
          todasfiliais:= todasfiliais+','+inttostr(FieldValues['CDFIL']);
          Next;
        end;
        cbLoja.ItemIndex := 0;
      end;
    end;

  dtInicial.Date := strtodate(FormatDateTime('01/mm/yyyy',now));
  dtFinal.Date   := now;

end;

procedure TfrmRelCampanhas.rbClienteClick(Sender: TObject);
begin
  if rbCliente.Checked then
    begin
     edtCPF.Visible:=true;
     edtNomeCliente.Visible:=true;
     cbNomeCampanha.Visible:=false;
    end;
end;

procedure TfrmRelCampanhas.rbFatvsDescClick(Sender: TObject);
begin
  if rbFatvsDesc.Checked then
    begin
     edtCPF.Visible:=false;
     edtNomeCliente.Visible:=false;
     cbNomeCampanha.Visible:=false;
    end;
end;

procedure TfrmRelCampanhas.rbParceitoClick(Sender: TObject);
begin
 if rbParceito.Checked then
  begin
    edtCPF.Visible:=false;
    edtNomeCliente.Visible:=false;
    cbNomeCampanha.Visible:=true;
    qryDescontos.Close;
    qryDescontos.SQL.Text := 'select nomecampanha from campanhas';
    qryDescontos.Open;
    cbNomeCampanha.Clear;
    while not(qryDescontos.Eof) do
     begin
       cbNomeCampanha.Items.Add(qryDescontos.FieldValues['nomecampanha']);
       qryDescontos.Next;
     end;
    cbNomeCampanha.Items.Add('TODOS');
  end;




end;

end.
