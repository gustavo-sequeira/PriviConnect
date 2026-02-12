unit uRelatCupomDesc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Dateutils, excelxp, COMOBJ,
  IBX.IBCustomDataSet, IBX.IBQuery, Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TfrmRelatCupom = class(TForm)
    rgTipo: TRadioGroup;
    gbIntervalo: TGroupBox;
    Inicial: TLabel;
    Label1: TLabel;
    dtFinal: TDateTimePicker;
    dtInicial: TDateTimePicker;
    StatusBar1: TStatusBar;
    btGerar: TBitBtn;
    brFechar: TBitBtn;
    qryTemp: TIBQuery;
    qryFcerta: TIBQuery;
    gbRelatorios: TGroupBox;
    rbEmitvsFidel: TRadioButton;
    rbFidelvsConv: TRadioButton;
    rbFatvsDesc: TRadioButton;
    rbRanking: TRadioButton;
    rbRetClivsRetCpm: TRadioButton;
    GroupBox2: TGroupBox;
    cbLoja: TComboBox;
    qryDescontos: TIBQuery;
    procedure FormCreate(Sender: TObject);
    procedure brFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btGerarClick(Sender: TObject);
    Procedure GerarExcel(Consulta:TIBQuery;Consulta2:TIBQuery );
    Procedure GerarExcel2(Consulta:TIBQuery);
    Procedure GerarExcel3(Consulta:TIBQuery;Consulta2:TIBQuery );
    Procedure GerarExcel4(Consulta:TIBQuery;Consulta2:TIBQuery );
    Procedure GerarExcel5(Consulta:TIBQuery );
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatCupom: TfrmRelatCupom;
  todasfiliais:string;
implementation

{$R *.dfm}

uses udmDescontos;

procedure TfrmRelatCupom.brFecharClick(Sender: TObject);
begin
 frmRelatCupom.Close;
end;


Procedure TfrmRelatCupom.GerarExcel(Consulta:TIBQuery;Consulta2:TIBQuery );
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
    Excel.ActiveSheet.Name := 'FAT VS DESC';

    titulo:= titulo+' - '+trim(cbLoja.Text);

    Excel.ActiveSheet.Range['A1:D1'].Merge;
    Excel.ActiveSheet.Range['A1:D1'].HorizontalAlignment := -4108;

    Excel.cells[1,1]:='CUPONS EMITIDOS VS CUPONS FIDELIDADE';

    Excel.cells[1,1].Font.name:='Calibri';
    Excel.cells[1,1].Font.Bold:=true;
    Excel.cells[1,1].Font.Size:=14;

    Excel.ActiveSheet.Range['A2:D2'].Merge;
    Excel.ActiveSheet.Range['A2:D2'].HorizontalAlignment := -4108;


    Excel.cells[2,1]:='PERÍODO : '+FormatDateTime('dd/mm/yyyy',dtInicial.Date)+' - '+FormatDateTime('dd/mm/yyyy',dtFinal.Date);

    Excel.cells[2,1].Font.name:='Arial';
    Excel.cells[2,1].Font.Bold:=true;
    Excel.cells[2,1].Font.Size:=10;

    Excel.ActiveSheet.Range['A3:D3'].Merge;
    Excel.ActiveSheet.Range['A3:D3'].HorizontalAlignment := -4108;


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
      Excel.ActiveSheet.Range['A1:L1'].Merge;
      Excel.ActiveSheet.Range['A1:L2'].HorizontalAlignment := -4108;
      Excel.ActiveSheet.Range['A1:L2'].VerticalAlignment := -4108;
      Excel.ActiveSheet.Range['A2:L2'].Columns.Interior.ColorIndex :=15;
      Excel.ActiveSheet.Range['A1:L'+inttostr(Consulta.RecordCount+2)].Borders.LineStyle := xlContinuous;
     end;


     try
        for linha:=0 to Consulta.RecordCount-1 do
        begin
            for coluna:=1 to Consulta.FieldCount do // eliminei a coluna 0 da relação do Excel
            begin
                 valor:= Consulta.Fields[coluna-1].AsString;

                 if (rgTipo.ItemIndex=0) and ((coluna=5) or  (coluna=6) ) then
                    excel.cells [linha+5,coluna]:=StrToCurr(valor)
                    else if (rgTipo.ItemIndex=0) and (coluna=7) then
                      excel.cells [linha+5,coluna]:=StrToInt(valor)
                       else if (rgTipo.ItemIndex=1) and (coluna=6) then
                        excel.cells [linha+5,coluna]:=StrToDate(valor)
                         else if (rgTipo.ItemIndex=1) and ((coluna=13) or  (coluna=14) )  then
                          excel.cells [linha+5,coluna]:=StrToCurr(valor)
                            else excel.cells [linha+5,coluna]:=trim(valor);

               if coluna=Consulta.FieldCount then
                begin
                  if Consulta2.Locate('CDFIL',Consulta.FieldValues['CDFIL'],[])=true then
                    excel.cells [linha+5,coluna+1]:=Consulta2.FieldValues['QTD']
                     else
                    excel.cells [linha+5,coluna+1]:='0';
                end;


            end;

            if coratual=cor2 then
               coratual := cor3
                else
               coratual:=cor2;

            Excel.ActiveSheet.Range['A'+inttostr(linha+5)+':D'+inttostr(linha+5)].Columns.Interior.ColorIndex :=37;

            Excel.ActiveSheet.Range['A'+inttostr(linha+5)+':D'+inttostr(linha+5)].Columns.Interior.TintAndShade := coratual;
            Consulta.Next;
        end;



       Excel.cells[Consulta.RecordCount+5,1]:='TOTAL';

       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':B'+inttostr(Consulta.RecordCount+5)].Merge;
       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':B'+inttostr(Consulta.RecordCount+5)].HorizontalAlignment := -4108;

       Excel.cells[Consulta.RecordCount+5,3]:='=SUM(C5:C'+IntToStr(Consulta.RecordCount+4)+')';
       Excel.cells[Consulta.RecordCount+5,4]:='=SUM(D5:D'+IntToStr(Consulta.RecordCount+4)+')';

       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':D'+inttostr(Consulta.RecordCount+5)].Font.Bold:=true;
       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':D'+inttostr(Consulta.RecordCount+5)].Columns.Interior.ColorIndex :=37;
       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':D'+inttostr(Consulta.RecordCount+5)].Columns.Interior.TintAndShade := cor1;


        for coluna:=1 to Consulta.FieldCount do // eliminei a coluna 0 da relação do Excel
        begin

          if rgTipo.ItemIndex=0 then
            begin
             case coluna of
               1:excel.cells[4,coluna]:='COD';
               2:excel.cells[4,coluna]:='FILIAL';
               3: begin
                    excel.cells[4,coluna]:='CUPONS EMI';
                    excel.cells[4,coluna+1]:='CUPONS DESC';
                   end;
             end;
            end
              else
               begin
                case coluna of
                  1:excel.cells[2,coluna]:='CRM';
                  2:excel.cells[2,coluna]:='MEDICO';
                  3:excel.cells[2,coluna]:='PROFISSAO';
                  4:excel.cells[2,coluna]:='ESPECIALIDADE';
                  5:excel.cells[2,coluna]:='CUPOM';
                  6:excel.cells[2,coluna]:='DATA';
                  7:excel.cells[2,coluna]:='HORA';
                  8:excel.cells[2,coluna]:='PARENTESCO';
                  9:excel.cells[2,coluna]:='TPVENDA';
                  10:excel.cells[2,coluna]:='COD';
                  11:excel.cells[2,coluna]:='PRODUTO';
                  12:excel.cells[2,coluna]:='QUANT';
                  13:excel.cells[2,coluna]:='VRTOTAL';
                  14:excel.cells[2,coluna]:='VRDESCONTO';
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


Procedure TfrmRelatCupom.GerarExcel2(Consulta:TIBQuery );
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
    Excel.ActiveSheet.Name := 'FAT VS DESC';

    titulo:= titulo+' - '+trim(cbLoja.Text);

    Excel.ActiveSheet.Range['A1:D1'].Merge;
    Excel.ActiveSheet.Range['A1:D1'].HorizontalAlignment := -4108;

    Excel.cells[1,1]:='FATUTAMENTO VC DESCONTOS CUPOM';

    Excel.cells[1,1].Font.name:='Calibri';
    Excel.cells[1,1].Font.Bold:=true;
    Excel.cells[1,1].Font.Size:=14;

    Excel.ActiveSheet.Range['A2:D2'].Merge;
    Excel.ActiveSheet.Range['A2:D2'].HorizontalAlignment := -4108;


    Excel.cells[2,1]:='PERÍODO : '+FormatDateTime('dd/mm/yyyy',dtInicial.Date)+' - '+FormatDateTime('dd/mm/yyyy',dtFinal.Date);

    Excel.cells[2,1].Font.name:='Arial';
    Excel.cells[2,1].Font.Bold:=true;
    Excel.cells[2,1].Font.Size:=10;



    Excel.ActiveSheet.Range['A3:D3'].Merge;
    Excel.ActiveSheet.Range['A3:D3'].HorizontalAlignment := -4108;


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
      Excel.ActiveSheet.Range['A1:L1'].Merge;
      Excel.ActiveSheet.Range['A1:L2'].HorizontalAlignment := -4108;
      Excel.ActiveSheet.Range['A1:L2'].VerticalAlignment := -4108;
      Excel.ActiveSheet.Range['A2:L2'].Columns.Interior.ColorIndex :=15;
      Excel.ActiveSheet.Range['A1:L'+inttostr(Consulta.RecordCount+2)].Borders.LineStyle := xlContinuous;
     end;


     try
        for linha:=0 to Consulta.RecordCount-1 do
        begin
            for coluna:=1 to Consulta.FieldCount do // eliminei a coluna 0 da relação do Excel
            begin
                 valor:= Consulta.Fields[coluna-1].AsString;

                 if (rgTipo.ItemIndex=0) and ((coluna=5) or  (coluna=6) ) then
                    excel.cells [linha+5,coluna]:=StrToCurr(valor)
                    else if (rgTipo.ItemIndex=0) and (coluna=7) then
                      excel.cells [linha+5,coluna]:=StrToInt(valor)
                       else if (rgTipo.ItemIndex=1) and (coluna=6) then
                        excel.cells [linha+5,coluna]:=StrToDate(valor)
                         else if (rgTipo.ItemIndex=1) and ((coluna=13) or  (coluna=14) )  then
                          excel.cells [linha+5,coluna]:=StrToCurr(valor)
                            else excel.cells [linha+5,coluna]:=trim(valor);

            end;
            if coratual=cor2 then
               coratual := cor3
                else
               coratual:=cor2;

            Excel.ActiveSheet.Range['A'+inttostr(linha+5)+':D'+inttostr(linha+5)].Columns.Interior.ColorIndex :=37;

            Excel.ActiveSheet.Range['A'+inttostr(linha+5)+':D'+inttostr(linha+5)].Columns.Interior.TintAndShade := coratual;
            Consulta.Next;

        end;



       Excel.cells[Consulta.RecordCount+5,1]:='TOTAL';

       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':B'+inttostr(Consulta.RecordCount+5)].Merge;
       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':B'+inttostr(Consulta.RecordCount+5)].HorizontalAlignment := -4108;

       Excel.cells[Consulta.RecordCount+5,3]:='=SUM(C5:C'+IntToStr(Consulta.RecordCount+4)+')';
       Excel.cells[Consulta.RecordCount+5,4]:='=SUM(D5:D'+IntToStr(Consulta.RecordCount+4)+')';

       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':D'+inttostr(Consulta.RecordCount+5)].Font.Bold:=true;
       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':D'+inttostr(Consulta.RecordCount+5)].Columns.Interior.ColorIndex :=37;
       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':D'+inttostr(Consulta.RecordCount+5)].Columns.Interior.TintAndShade := cor1;


        for coluna:=1 to Consulta.FieldCount do // eliminei a coluna 0 da relação do Excel
        begin

          if rgTipo.ItemIndex=0 then
            begin
             case coluna of
               1:excel.cells[4,coluna]:='COD';
               2:excel.cells[4,coluna]:='FILIAL';
               3:excel.cells[4,coluna]:='CPM FIDELIDADE';
               4:excel.cells[4,coluna]:='CPM CONVERTIDOS';
             end;
            end
              else
               begin
                case coluna of
                  1:excel.cells[2,coluna]:='CRM';
                  2:excel.cells[2,coluna]:='MEDICO';
                  3:excel.cells[2,coluna]:='PROFISSAO';
                  4:excel.cells[2,coluna]:='ESPECIALIDADE';
                  5:excel.cells[2,coluna]:='CUPOM';
                  6:excel.cells[2,coluna]:='DATA';
                  7:excel.cells[2,coluna]:='HORA';
                  8:excel.cells[2,coluna]:='PARENTESCO';
                  9:excel.cells[2,coluna]:='TPVENDA';
                  10:excel.cells[2,coluna]:='COD';
                  11:excel.cells[2,coluna]:='PRODUTO';
                  12:excel.cells[2,coluna]:='QUANT';
                  13:excel.cells[2,coluna]:='VRTOTAL';
                  14:excel.cells[2,coluna]:='VRDESCONTO';
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


Procedure TfrmRelatCupom.GerarExcel3(Consulta:TIBQuery;Consulta2:TIBQuery );
var
     coluna, linha: integer;
     cor1,cor2,cor3,coratual:real;
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
    Excel.ActiveSheet.Name := 'FAT VS DESC';

    titulo:= titulo+' - '+trim(cbLoja.Text);

    Excel.ActiveSheet.Range['A1:D1'].Merge;
    Excel.ActiveSheet.Range['A1:D1'].HorizontalAlignment := -4108;

    Excel.cells[1,1]:='FATURAMENTO VC DESCONTOS CUPOM';

    Excel.cells[1,1].Font.name:='Calibri';
    Excel.cells[1,1].Font.Bold:=true;
    Excel.cells[1,1].Font.Size:=14;

    Excel.ActiveSheet.Range['A2:D2'].Merge;
    Excel.ActiveSheet.Range['A2:D2'].HorizontalAlignment := -4108;


    Excel.cells[2,1]:='PERÍODO : '+FormatDateTime('dd/mm/yyyy',dtInicial.Date)+' - '+FormatDateTime('dd/mm/yyyy',dtFinal.Date);

    Excel.cells[2,1].Font.name:='Arial';
    Excel.cells[2,1].Font.Bold:=true;
    Excel.cells[2,1].Font.Size:=10;



    Excel.ActiveSheet.Range['A3:D3'].Merge;
    Excel.ActiveSheet.Range['A3:D3'].HorizontalAlignment := -4108;


    Excel.cells[3,1]:= titulo;

    Excel.cells[3,1].Font.name:='Arial';
    Excel.cells[3,1].Font.Bold:=true;
    Excel.cells[3,1].Font.Size:=9;


  //  Excel.cells[1,1].Borders.Item[$0000000A].Weight := $FFFFEFD6;


         {For VerticalAlignment:

          Top:    -4160
          Center: -4108
          Bottom: -4107
          And HorizontalAlignment:

          Left:    -4131
          Center:  -4108
          Right:   -4152}



    cor1:=-0.199977111117893;
    cor2:=0.549977111117893;
    cor3:=0.249977111117893;



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
      Excel.ActiveSheet.Range['A1:L1'].Merge;
      Excel.ActiveSheet.Range['A1:L2'].HorizontalAlignment := -4108;
      Excel.ActiveSheet.Range['A1:L2'].VerticalAlignment := -4108;
      Excel.ActiveSheet.Range['A2:L2'].Columns.Interior.ColorIndex :=15;
      Excel.ActiveSheet.Range['A1:L'+inttostr(Consulta.RecordCount+2)].Borders.LineStyle := xlContinuous;
     end;


     try
        for linha:=0 to Consulta.RecordCount-1 do
        begin
            for coluna:=1 to Consulta.FieldCount do // eliminei a coluna 0 da relação do Excel
            begin
                 valor:= Consulta.Fields[coluna-1].AsString;

                 if (rgTipo.ItemIndex=0) and ((coluna=5) or  (coluna=3) ) then
                    excel.cells [linha+5,coluna]:=StrToCurr(valor)
                    else if (rgTipo.ItemIndex=0) and (coluna=7) then
                      excel.cells [linha+5,coluna]:=StrToInt(valor)
                       else if (rgTipo.ItemIndex=1) and (coluna=6) then
                        excel.cells [linha+5,coluna]:=StrToDate(valor)
                         else if (rgTipo.ItemIndex=1) and ((coluna=13) or  (coluna=14) )  then
                          excel.cells [linha+5,coluna]:=StrToCurr(valor)
                            else excel.cells [linha+5,coluna]:=trim(valor);

               if coluna=Consulta.FieldCount then
                begin
                  if Consulta2.Locate('CDFIL',Consulta.FieldValues['CDFIL'],[])=true then
                    excel.cells [linha+5,coluna+1]:=Consulta2.FieldValues['DESC']
                     else
                    excel.cells [linha+5,coluna+1]:='0';
                end;


            end;

            if coratual=cor2 then
               coratual := cor3
                else
               coratual:=cor2;

            Excel.ActiveSheet.Range['A'+inttostr(linha+5)+':D'+inttostr(linha+5)].Columns.Interior.ColorIndex :=37;

            Excel.ActiveSheet.Range['A'+inttostr(linha+5)+':D'+inttostr(linha+5)].Columns.Interior.TintAndShade := coratual;
            Consulta.Next;
        end;



       Excel.cells[Consulta.RecordCount+5,1]:='TOTAL';

       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':B'+inttostr(Consulta.RecordCount+5)].Merge;
       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':B'+inttostr(Consulta.RecordCount+5)].HorizontalAlignment := -4108;

       Excel.cells[Consulta.RecordCount+5,3]:='=SUM(C5:C'+IntToStr(Consulta.RecordCount+4)+')';
       Excel.cells[Consulta.RecordCount+5,4]:='=SUM(D5:D'+IntToStr(Consulta.RecordCount+4)+')';

       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':D'+inttostr(Consulta.RecordCount+5)].Font.Bold:=true;
       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':D'+inttostr(Consulta.RecordCount+5)].Columns.Interior.ColorIndex :=37;
       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':D'+inttostr(Consulta.RecordCount+5)].Columns.Interior.TintAndShade := cor1;

        for coluna:=1 to Consulta.FieldCount do // eliminei a coluna 0 da relação do Excel
        begin

          if rgTipo.ItemIndex=0 then
            begin
             case coluna of
               1:excel.cells[4,coluna]:='COD';
               2:excel.cells[4,coluna]:='FILIAL';
               3: begin
                    excel.cells[4,coluna]:='FAT VAREJO';
                    excel.cells[4,coluna+1]:='DESCONTOS CUPOM';
                   end;
             end;
            end
              else
               begin
                case coluna of
                  1:excel.cells[2,coluna]:='CRM';
                  2:excel.cells[2,coluna]:='MEDICO';
                  3:excel.cells[2,coluna]:='PROFISSAO';
                  4:excel.cells[2,coluna]:='ESPECIALIDADE';
                  5:excel.cells[2,coluna]:='CUPOM';
                  6:excel.cells[2,coluna]:='DATA';
                  7:excel.cells[2,coluna]:='HORA';
                  8:excel.cells[2,coluna]:='PARENTESCO';
                  9:excel.cells[2,coluna]:='TPVENDA';
                  10:excel.cells[2,coluna]:='COD';
                  11:excel.cells[2,coluna]:='PRODUTO';
                  12:excel.cells[2,coluna]:='QUANT';
                  13:excel.cells[2,coluna]:='VRTOTAL';
                  14:excel.cells[2,coluna]:='VRDESCONTO';
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


Procedure TfrmRelatCupom.GerarExcel4(Consulta:TIBQuery;Consulta2:TIBQuery );
var  cor1{,cor2,cor3},coratual:real;
     coluna{, linha}: integer;
     excel: variant;
     {valor,}titulo: string;
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
    Excel.ActiveSheet.Name := 'RETORNO CLI';

    titulo:= titulo+' - '+trim(cbLoja.Text);

    Excel.ActiveSheet.Range['A1:B1'].Merge;
    Excel.ActiveSheet.Range['A1:B1'].HorizontalAlignment := -4108;

    Excel.cells[1,1]:='RETORNO CLIENTES VS RETORNO CUPONS';

    Excel.cells[1,1].Font.name:='Calibri';
    Excel.cells[1,1].Font.Bold:=true;
    Excel.cells[1,1].Font.Size:=14;

    Excel.ActiveSheet.Range['A2:B2'].Merge;
    Excel.ActiveSheet.Range['A2:B2'].HorizontalAlignment := -4108;


    Excel.cells[2,1]:='PERÍODO : '+FormatDateTime('dd/mm/yyyy',dtInicial.Date)+' - '+FormatDateTime('dd/mm/yyyy',dtFinal.Date);

    Excel.cells[2,1].Font.name:='Arial';
    Excel.cells[2,1].Font.Bold:=true;
    Excel.cells[2,1].Font.Size:=10;



    Excel.ActiveSheet.Range['A3:B3'].Merge;
    Excel.ActiveSheet.Range['A3:B3'].HorizontalAlignment := -4108;


    Excel.cells[3,1]:= titulo;

    Excel.cells[3,1].Font.name:='Arial';
    Excel.cells[3,1].Font.Bold:=true;
    Excel.cells[3,1].Font.Size:=9;

    cor1:=-0.199977111117893;
//    cor2:=0.549977111117893;
//    cor3:=0.249977111117893;
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

    Excel.ActiveSheet.Range['A4:B4'].HorizontalAlignment := -4108;
    Excel.ActiveSheet.Range['A4:B4'].VerticalAlignment := -4108;
    Excel.ActiveSheet.Range['A4:B4'].Columns.Interior.ColorIndex :=  37;
    Excel.ActiveSheet.Range['A4:B4'].Columns.Interior.TintAndShade := cor1;
    Excel.ActiveSheet.Range['A4:B4'].Font.Bold:=true;
    Excel.ActiveSheet.Range['A4:B5'].Borders.LineStyle := xlContinuous;
   end
    else
     begin
      Excel.ActiveSheet.Range['A1:L1'].Merge;
      Excel.ActiveSheet.Range['A1:L2'].HorizontalAlignment := -4108;
      Excel.ActiveSheet.Range['A1:L2'].VerticalAlignment := -4108;
      Excel.ActiveSheet.Range['A2:L2'].Columns.Interior.ColorIndex :=15;
      Excel.ActiveSheet.Range['A1:L'+inttostr(Consulta.RecordCount+2)].Borders.LineStyle := xlContinuous;
     end;


     try
      Consulta.FetchAll;
      Consulta2.FetchAll;
      excel.cells [5,1]:= Consulta.RecordCount;
      excel.cells [5,2]:= Consulta2.RecordCount;

      Excel.ActiveSheet.Range['A5:B5'].Columns.Interior.ColorIndex :=37;

      Excel.ActiveSheet.Range['A5:B5'].Columns.Interior.TintAndShade := coratual;


        for coluna:=1 to Consulta.FieldCount do // eliminei a coluna 0 da relação do Excel
        begin

          if rgTipo.ItemIndex=0 then
            begin
             case coluna of
               1:excel.cells[4,coluna]:='QTD CLIENTES RETORNO';
               2:excel.cells[4,coluna]:='QTD CLIENTES CUPOM FIDELIDADE';
             end;
            end
              else
               begin
                case coluna of
                  1:excel.cells[2,coluna]:='CRM';
                  2:excel.cells[2,coluna]:='MEDICO';
                  3:excel.cells[2,coluna]:='PROFISSAO';
                  4:excel.cells[2,coluna]:='ESPECIALIDADE';
                  5:excel.cells[2,coluna]:='CUPOM';
                  6:excel.cells[2,coluna]:='DATA';
                  7:excel.cells[2,coluna]:='HORA';
                  8:excel.cells[2,coluna]:='PARENTESCO';
                  9:excel.cells[2,coluna]:='TPVENDA';
                  10:excel.cells[2,coluna]:='COD';
                  11:excel.cells[2,coluna]:='PRODUTO';
                  12:excel.cells[2,coluna]:='QUANT';
                  13:excel.cells[2,coluna]:='VRTOTAL';
                  14:excel.cells[2,coluna]:='VRDESCONTO';
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



Procedure TfrmRelatCupom.GerarExcel5(Consulta:TIBQuery );
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
    Excel.ActiveSheet.Name := 'RANKING';

    titulo:= titulo+' - '+trim(cbLoja.Text);

    Excel.ActiveSheet.Range['A1:B1'].Merge;
    Excel.ActiveSheet.Range['A1:B1'].HorizontalAlignment := -4108;

    Excel.cells[1,1]:='RANKING';

    Excel.cells[1,1].Font.name:='Calibri';
    Excel.cells[1,1].Font.Bold:=true;
    Excel.cells[1,1].Font.Size:=14;

    Excel.ActiveSheet.Range['A2:B2'].Merge;
    Excel.ActiveSheet.Range['A2:B2'].HorizontalAlignment := -4108;


    Excel.cells[2,1]:='PERÍODO : '+FormatDateTime('dd/mm/yyyy',dtInicial.Date)+' - '+FormatDateTime('dd/mm/yyyy',dtFinal.Date);

    Excel.cells[2,1].Font.name:='Arial';
    Excel.cells[2,1].Font.Bold:=true;
    Excel.cells[2,1].Font.Size:=10;



    Excel.ActiveSheet.Range['A3:B3'].Merge;
    Excel.ActiveSheet.Range['A3:B3'].HorizontalAlignment := -4108;


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

    Excel.ActiveSheet.Range['A4:B4'].HorizontalAlignment := -4108;
    Excel.ActiveSheet.Range['A4:B4'].VerticalAlignment := -4108;
    Excel.ActiveSheet.Range['A4:B4'].Columns.Interior.ColorIndex :=  37;
    Excel.ActiveSheet.Range['A4:B4'].Columns.Interior.TintAndShade := cor1;
    Excel.ActiveSheet.Range['A4:B4'].Font.Bold:=true;
    Excel.ActiveSheet.Range['A4:B'+inttostr(Consulta.RecordCount+5)].Borders.LineStyle := xlContinuous;
   end
    else
     begin
      Excel.ActiveSheet.Range['A1:L1'].Merge;
      Excel.ActiveSheet.Range['A1:L2'].HorizontalAlignment := -4108;
      Excel.ActiveSheet.Range['A1:L2'].VerticalAlignment := -4108;
      Excel.ActiveSheet.Range['A2:L2'].Columns.Interior.ColorIndex :=15;
      Excel.ActiveSheet.Range['A1:L'+inttostr(Consulta.RecordCount+2)].Borders.LineStyle := xlContinuous;
     end;


     try

        for linha:=0 to Consulta.RecordCount-1 do
        begin

            for coluna:=1 to Consulta.FieldCount do // eliminei a coluna 0 da relação do Excel
            begin
                 valor:= Consulta.Fields[coluna-1].AsString;

                 if (rgTipo.ItemIndex=0) and ((coluna=5) or  (coluna=6) ) then
                    excel.cells [linha+5,coluna]:=StrToCurr(valor)
                    else if (rgTipo.ItemIndex=0) and (coluna=2) then
                      excel.cells [linha+5,coluna]:=StrToInt(valor)
                       else if (rgTipo.ItemIndex=1) and (coluna=6) then
                        excel.cells [linha+5,coluna]:=StrToDate(valor)
                         else if (rgTipo.ItemIndex=1) and ((coluna=13) or  (coluna=14) )  then
                          excel.cells [linha+5,coluna]:=StrToCurr(valor)
                            else excel.cells [linha+5,coluna]:=trim(valor);

            end;


            if coratual=cor2 then
               coratual := cor3
                else
               coratual:=cor2;

            Excel.ActiveSheet.Range['A'+inttostr(linha+5)+':B'+inttostr(linha+5)].Columns.Interior.ColorIndex :=37;

            Excel.ActiveSheet.Range['A'+inttostr(linha+5)+':B'+inttostr(linha+5)].Columns.Interior.TintAndShade := coratual;
            Consulta.Next;

        end;


       Excel.cells[Consulta.RecordCount+5,1]:='TOTAL';

       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':A'+inttostr(Consulta.RecordCount+5)].HorizontalAlignment := -4108;

       Excel.cells[Consulta.RecordCount+5,2]:='=SUM(B5:B'+IntToStr(Consulta.RecordCount+4)+')';

       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':B'+inttostr(Consulta.RecordCount+5)].Font.Bold:=true;
       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':B'+inttostr(Consulta.RecordCount+5)].Columns.Interior.ColorIndex :=37;
       Excel.ActiveSheet.Range['A'+inttostr(Consulta.RecordCount+5)+':B'+inttostr(Consulta.RecordCount+5)].Columns.Interior.TintAndShade := cor1;


        for coluna:=1 to Consulta.FieldCount do // eliminei a coluna 0 da relação do Excel
        begin

          if rgTipo.ItemIndex=0 then
            begin
             case coluna of
               1:excel.cells[4,coluna]:='FUNCIONARIO';
               2:excel.cells[4,coluna]:='CONVERSOES';

             end;
            end
              else
               begin
                case coluna of
                  1:excel.cells[2,coluna]:='CRM';
                  2:excel.cells[2,coluna]:='MEDICO';
                  3:excel.cells[2,coluna]:='PROFISSAO';
                  4:excel.cells[2,coluna]:='ESPECIALIDADE';
                  5:excel.cells[2,coluna]:='CUPOM';
                  6:excel.cells[2,coluna]:='DATA';
                  7:excel.cells[2,coluna]:='HORA';
                  8:excel.cells[2,coluna]:='PARENTESCO';
                  9:excel.cells[2,coluna]:='TPVENDA';
                  10:excel.cells[2,coluna]:='COD';
                  11:excel.cells[2,coluna]:='PRODUTO';
                  12:excel.cells[2,coluna]:='QUANT';
                  13:excel.cells[2,coluna]:='VRTOTAL';
                  14:excel.cells[2,coluna]:='VRDESCONTO';
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


procedure TfrmRelatCupom.btGerarClick(Sender: TObject);
var filiais:string;
    HprevHist : HWND;
begin

 if dtInicial.Date>dtFinal.Date then raise Exception.Create('Corrija o intervalo de datas');

 if cbLoja.ItemIndex=0 then
   filiais := todasfiliais
     else
   filiais := trim( copy( cbLoja.Text,1,3));


if rbEmitvsFidel.Checked then
 begin


     qryFcerta.Close;
     qryFcerta.SQL.Text := ' select b.cdfil,b.descrfil as FILIAL,  count( distinct a.nrcpm) as "CUPONS EMI" from fc31110 a, fc01000 b '+
                           ' where a.cdfil=b.cdfil and a.tpitm='+QuotedStr('V')+
                           ' and a.dtope between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.Date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.Date))+
                           ' and a.cdfil in ('+filiais+')'+
                           ' group by 1,2 order by b.cdfil';
     qryFcerta.Open;


     qryDescontos.Close;
     qryDescontos.SQL.Text := 'select a.cdfil, count(distinct a.cpfiscal) as QTD from descclientes a '+
                              ' where a.dtemissao between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.Date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.Date))+
                              ' and a.cdfil in ('+filiais+')'+
                              ' group by 1';
     qryDescontos.Open;

     GerarExcel(qryFcerta,qryDescontos);
 end;



if rbFidelvsConv.Checked then
 begin


     qryDescontos.Close;
     qryDescontos.SQL.Text := 'select c.cdfil,d.descrfil, (select  count(distinct a.cpfiscal) from descclientes a where a.dtemissao between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.Date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.Date))+' and a.cdfil=c.cdfil ) as QTDFIDEL, '+
                              ' (select  count(distinct b.cpfiscal) from descclientes b where b.dtemissao between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.Date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.Date))+' and b.usado='+quotedstr('1')+' and b.cdfil=c.cdfil) as QTDCONV '+
                              ' from descclientes c, filiais d where c.cdfil=d.cdfil and '+
                              ' c.dtemissao between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.Date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.Date))+
                              ' and c.cdfil in ('+filiais+')'+
                              ' group by 1,2 ';
     qryDescontos.Open;

     GerarExcel2(qryDescontos);
 end;



if rbFatvsDesc.Checked then
 begin


     qryFcerta.Close;
     qryFcerta.SQL.Text := ' select b.cdfil, b.descrfil, Sum(A.VRLIQ - A.VRDSCV + A.VRTXAV) as REALIZADO from fc31110 a, fc01000 b '+
                           '  where  a.cdfil=b.cdfil and '+
                           ' a.dtope between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.Date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.Date))+
                           ' and a.tpitm='+QuotedStr('V')+
                           ' and a.cdfil in ('+filiais+')'+
                           ' group by 1,2 order by 1 ';
     qryFcerta.Open;


     qryDescontos.Close;
     qryDescontos.SQL.Text := ' select  b.cdfil,sum(vrdesc) as DESC from descclientes b where '+
                              ' b.dtuso between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.Date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.Date))+
                              ' and b.usado='+quotedstr('1')+
                              ' and b.cdfil in ('+filiais+')'+
                              ' group by 1 order by 1 ';
     qryDescontos.Open;

     GerarExcel3(qryFcerta,qryDescontos);
 end;


if rbRetClivsRetCpm.Checked then
 begin


     qryFcerta.Close;
     qryFcerta.SQL.Text := ' select b.cdcli, c.nomecli,count(distinct b.dtope) as DIAS from fc31110 a, fc31100 b, fc07000 c where   '+
                           ' a.cdfil=b.cdfil and a.cdtml=b.cdtml and a.dtope=b.dtope and a.operid=b.operid and a.nrcpm=b.nrcpm and  '+
                           ' c.cdcli=b.cdcli and a.dtope between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.Date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.Date))+
                           ' and a.tpitm='+quotedstr('V')+
                            ' group by 1,2 having count(distinct b.dtope)>1 order by 3 desc';
     qryFcerta.Open;

     qryDescontos.Close;
     qryDescontos.SQL.Text := ' select  b.cdcli,b.nomecli,count(b.cpfiscal) as QTD from descclientes b where '+
                              ' b.dtuso between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.Date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.Date))+
                              ' and b.usado='+quotedstr('1')+
                              ' group by 1,2 order by 1';
     qryDescontos.Open;
     GerarExcel4(qryFcerta,qryDescontos);
 end;


if rbRanking.Checked then
 begin


     qryDescontos.Close;
     qryDescontos.SQL.Text := ' select a.funcionario,count(a.cpfiscal) from descclientes a '+
                              ' where a.dtuso between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.Date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.Date))+
                              ' and a.cdfil in ('+filiais+')'+
                              ' group by 1 order by 2 desc ';
     qryDescontos.Open;

     GerarExcel5(qryDescontos);
 end;



 qryDescontos.Close;
 qryFcerta.Close;
 HprevHist := FindWindow('XLMAIN', nil);
 if HprevHist <> 0 then
      begin
        ShowWindow(HprevHist, SW_MAXIMIZE);
        BringWindowToTop(HprevHist);
        SetForegroundWindow(HprevHist);
      end;


end;

procedure TfrmRelatCupom.FormCreate(Sender: TObject);
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


end;

procedure TfrmRelatCupom.FormShow(Sender: TObject);
begin
 cbLoja.ItemIndex:=0;
 rgTipo.ItemIndex:=0;

 dtInicial.Date:=IncDay(now,-7);
 dtFinal.Date:=now;

 rbEmitvsFidel.Checked:=true;
end;

end.
