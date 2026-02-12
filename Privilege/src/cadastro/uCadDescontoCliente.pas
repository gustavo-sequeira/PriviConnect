unit uCadDescontoCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,  {clipbrd,}
  Vcl.Buttons, sSpeedButton, Vcl.StdCtrls, sComboBox, sLabel, sEdit,
  IBX.IBCustomDataSet, IBX.IBQuery, Vcl.Menus, sBitBtn, Vcl.Mask,ComObj,
  sMaskEdit, sCustomComboEdit, Vcl.ComCtrls, System.Math ;

type
  TfrmCadDescontoCliente = class(TForm)
    edtCPF: TsEdit;
    sLabelFX1: TsLabelFX;
    cbCampanhaNome: TsComboBox;
    sLabelFX2: TsLabelFX;
    edtNomeCliente: TsEdit;
    sLabelFX3: TsLabelFX;
    btCadCampanha: TsSpeedButton;
    dbCLientes: TDBGrid;
    sLabelFX4: TsLabelFX;
    qryTmp: TIBQuery;
    qryGrid: TIBQuery;
    dsGrid: TDataSource;
    edtDDD: TsEdit;
    sLabelFX5: TsLabelFX;
    edtCelular: TsEdit;
    sLabelFX6: TsLabelFX;
    PopupMenu1: TPopupMenu;
    E1: TMenuItem;
    btCadastrar: TsBitBtn;
    btGerarCupons: TsBitBtn;
    sLabelFX7: TsLabelFX;
    sLabelFX8: TsLabelFX;
    edtValorfor: TEdit;
    edtValorvar: TEdit;
    sBitBtn1: TsBitBtn;
    qryExcel: TIBQuery;
    btnSaldo: TsBitBtn;
    qryFcertaTEMP: TIBQuery;
    procedure FormShow(Sender: TObject);
    procedure cbCampanhaNomeChange(Sender: TObject);
    procedure btCadCampanhaClick(Sender: TObject);
    procedure limpacampos;
    procedure limpacampanhas;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure E1Click(Sender: TObject);
    procedure btCadastrarClick(Sender: TObject);
    procedure btGerarCuponsClick(Sender: TObject);
    procedure edtValorforKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtValorvarKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtValorforClick(Sender: TObject);
    procedure edtValorvarClick(Sender: TObject);
    procedure sBitBtn1Click(Sender: TObject);
    procedure btnSaldoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadDescontoCliente: TfrmCadDescontoCliente;
  idcamp:integer;
implementation

{$R *.dfm}

uses udmDescontos, uCadCampanha, uGerarCupons, System.UITypes;


function mudaponto(valor:double):string;
begin
 result:=StringReplace(formatfloat('0.##',valor), ',', '.',[rfReplaceAll, rfIgnoreCase]);
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


procedure TfrmCadDescontoCliente.btCadCampanhaClick(Sender: TObject);
begin

 frmCadCampanha.ShowModal;

end;

procedure TfrmCadDescontoCliente.btGerarCuponsClick(Sender: TObject);
begin
if qryGrid.IsEmpty then raise Exception.Create('Escolha uma campanha com clientes primeiro');

frmGerarCupons.ShowModal;
end;

procedure TfrmCadDescontoCliente.btnSaldoClick(Sender: TObject);
var LnLinha    :integer;
    planilha : variant;
    mes , ano , tipo :String;
    total , desc , liq , vtotal , vdesc , vliq , ftotal ,fdesc , fliq, credVar , credForm  :Real ;

begin
    fdesc := 0;
    ftotal := 0;
    fliq := 0;
    if qryGrid.FieldValues['idcamp'] <> 79 then raise Exception.Create('Extrato Exclusivo para a Cortesia Mensal');

    qryExcel.Close;
    qryExcel.SQL.Text := 'select * from CORTESIAMENSAL d where d.idcamp = 79 and d.cpfcli = '+quotedstr(qryGrid.FieldValues['cpfcli'])
    +' ORDER BY extract(YEAR from DTOPE) , extract(month from DTOPE) , d.tpitm ';
    qryExcel.Open;
    qryExcel.FetchAll;

    credVar  := qryGrid.FieldByName('valorVar').AsFloat;
    credForm := qryGrid.FieldByName('valorFor').AsFloat;


    if qryExcel.RecordCount=0 then   raise Exception.Create('SEM DADOS');


    planilha:= CreateoleObject('Excel.Application');
    planilha.WorkBooks.add(1);
    planilha.visible := true;

    planilha.cells[1,1] := 'Extrato Cortesia Mensal do Cliente: '+qryGrid.FieldByName('NOMECLI').AsString+' - Crédito em Fórmula:'+formatfloat('R$ #,##0', credForm)+'  - Varejo:'+formatfloat('R$ #,##0', credVar)+'  - Validade: '+FormatDateTime('dd.mm.yyyy', qryGrid.FieldByName('DTVALIDADE').AsDateTime  );
    planilha.ActiveSheet.Range['A1:l1'].Merge;
    planilha.ActiveSheet.Range['A1:l1'].HorizontalAlignment := -4108;
    planilha.ActiveSheet.Range['A1:l1'].Columns.Interior.ColorIndex :=15;
    planilha.ActiveSheet.Range['A2:l2'].Borders.LineStyle := 1;

    planilha.cells[2,1]  := 'DATA';
    planilha.cells[2,2]  := 'COD.FILIAL';
    planilha.cells[2,3]  := 'TBALCÃO';
    planilha.cells[2,4]  := 'ITEMID';
    planilha.cells[2,5]  := 'TIPO';
    planilha.cells[2,6]  := 'REQ/PROD';
    planilha.cells[2,7]  := 'QUANT';
    planilha.cells[2,8]  := 'DESCRIÇÃO';
    planilha.cells[2,9]  := 'VR.TOTAL';
    planilha.cells[2,10] := 'VR.DESC';
    planilha.cells[2,11] := 'VR.LIQ';
    planilha.cells[2,12] := 'SALDO';

    LnLinha:=3;
    total  :=0;
    liq    :=0;
    desc   :=0;

    vtotal :=0;
    vliq   :=0;
    vdesc  :=0;

    qryExcel.First;
    tipo   := qryExcel.FieldByName('TPITM').AsString;
    Mes    := FormatDateTime('MM', qryExcel.FieldByName('DTOPE').AsDateTime );
    Ano    := FormatDateTime('YYYY', qryExcel.FieldByName('DTOPE').AsDateTime);
    while not qryExcel.Eof  do
      begin

            while (not qryExcel.Eof ) and
               (  FormatDateTime('MM', qryExcel.FieldByName('DTOPE').AsDateTime ) = mes)  and
               (  FormatDateTime('YYYY', qryExcel.FieldByName('DTOPE').AsDateTime) = ano ) and
               (  tipo = qryExcel.FieldByName('TPITM').AsString ) do
            begin
              planilha.cells[LnLinha,1]  := qryExcel.FieldValues['DTOPE'];
              planilha.cells[LnLinha,2]  := qryExcel.FieldValues['CDFIL'];
              planilha.cells[LnLinha,3]  := qryExcel.FieldValues['TBALCAO'];
              planilha.cells[LnLinha,4]  := qryExcel.FieldValues['ITEMID'];
              planilha.cells[LnLinha,5]  := qryExcel.FieldByName('TPITM').AsString;

              planilha.cells[LnLinha,6]  := qryExcel.FieldValues['CDPRO'];
              planilha.cells[LnLinha,7]  := qryExcel.FieldValues['QUANT'];
              if qryExcel.FieldByName('TPITM').AsString = 'V' then
                 begin
                   qryFcertaTEMP.Close;
                   qryFcertaTEMP.SQL.Text := 'select p.DESCR from fc03000 p where p.cdpro = '+qryExcel.FieldByName('cdpro').AsString;
                   qryFcertaTEMP.Open;
                   planilha.cells[LnLinha,8]  := qryFcertaTEMP.FieldByName('DESCR').AsString;
                 end
              else planilha.cells[LnLinha,8]  := 'FÓRMULA MANIPULADA (A VISTA)';


              planilha.cells[LnLinha,9]  := qryExcel.FieldValues['VRBRUT'];
              planilha.cells[LnLinha,10]  := qryExcel.FieldValues['VRDESC'];
              planilha.cells[LnLinha,11] := qryExcel.FieldValues['VRLIQ'];

              total := total + qryExcel.FieldValues['VRBRUT'];
              liq   := liq   + qryExcel.FieldValues['VRLIQ'];
              desc  := desc  + qryExcel.FieldValues['VRDESC'];

              if tipo = 'V'  then
                 begin
                   vtotal := vtotal + qryExcel.FieldValues['VRBRUT'];
                   vliq   := vliq   + qryExcel.FieldValues['VRLIQ'];
                   vdesc  := vdesc  + qryExcel.FieldValues['VRDESC'];
                 end
              else
                 begin
                    ftotal := ftotal + qryExcel.FieldValues['VRBRUT'];
                    fliq   := fliq   + qryExcel.FieldValues['VRLIQ'];
                    fdesc  := fdesc  + qryExcel.FieldValues['VRDESC'];
                end;

              LnLinha := LnLinha +1;
              qryExcel.Next;
            end;

            if tipo ='V'  then
               begin
                 planilha.cells[LnLinha,8]  :=  'Varejo do mês: '+mes+'/'+Ano;
                 planilha.cells[LnLinha,9]  := RoundTo(vtotal,-2);
                 planilha.Cells[LnLinha,9].NumberFormat :=  'R$ #.##0,00_);(R$ #.##0,00)';
                 planilha.cells[LnLinha,10]  := RoundTo(vdesc, -2);
                 planilha.Cells[LnLinha,10].NumberFormat :=  'R$ #.##0,00_);(R$ #.##0,00)';
                 planilha.cells[LnLinha,11] := RoundTo(vliq, -2);
                 planilha.Cells[LnLinha,11].NumberFormat :=  'R$ #.##0,00_);(R$ #.##0,00)';

                 planilha.cells[LnLinha,12] := RoundTo(credVar - vdesc, -2);
                 planilha.Cells[LnLinha,12].NumberFormat :=  'R$ #.##0,00_);(R$ #.##0,00)';
               end;

            if tipo ='R'  then
               begin
                 planilha.cells[LnLinha,8]  :=  'Fórmula do mês: '+mes+'/'+Ano;
                 planilha.cells[LnLinha,9]  := RoundTo(ftotal,-2);
                 planilha.Cells[LnLinha,9].NumberFormat :=  'R$ #.##0,00_);(R$ #.##0,00)';
                 planilha.cells[LnLinha,10]  := RoundTo(fdesc, -2);
                 planilha.Cells[LnLinha,10].NumberFormat :=  'R$ #.##0,00_);(R$ #.##0,00)';
                 planilha.cells[LnLinha,11] := RoundTo(fliq, -2);
                 planilha.Cells[LnLinha,11].NumberFormat :=  'R$ #.##0,00_);(R$ #.##0,00)';

                 planilha.cells[LnLinha,12] := RoundTo(credForm - fdesc, -2);
                 planilha.Cells[LnLinha,12].NumberFormat :=  'R$ #.##0,00_);(R$ #.##0,00)';
               end;


            LnLinha := LnLinha +2;
            tipo := qryExcel.FieldByName('TPITM').AsString;
            Mes  := FormatDateTime('MM', qryExcel.FieldByName('DTOPE').AsDateTime );
            Ano  := FormatDateTime('YYYY', qryExcel.FieldByName('DTOPE').AsDateTime);

            vtotal :=0;
            vliq   :=0;
            vdesc  :=0;

            ftotal :=0;
            fliq   :=0;
            fdesc  :=0;

      end;


     planilha.columns.Autofit;

     planilha.visible := true;
     planilha.Quit;

end;

procedure TfrmCadDescontoCliente.cbCampanhaNomeChange(Sender: TObject);
begin

 qryTmp.Close;
 qryTmp.SQL.Text := 'select idcamp,nomecampanha from campanhas where nomecampanha='+quotedstr(cbCampanhaNome.Text);
 qryTmp.Open;

 if not qryTmp.IsEmpty then
   begin
     idcamp := qryTmp.FieldValues['idcamp'];
   end;


 qryGrid.Transaction.CommitRetaining;
 qryGrid.Close;
 qryGrid.SQL.Text := 'select a.* from campanhasclientes a,campanhas b where  a.idcamp=b.idcamp and   b.nomecampanha='+quotedstr(cbCampanhaNome.Text)+' order by a.nomecli';
 qryGrid.Open;

 edtNomeCliente.setfocus;

// Clipboard.AsText := qryGrid.SQL.Text;

end;



procedure TfrmCadDescontoCliente.E1Click(Sender: TObject);
var idcamp:integer;
begin

 if not(qryGrid.IsEmpty) then
  begin

   qryTmp.Close;
   qryTmp.SQL.Text :='select * from campanhas  where nomecampanha='+quotedstr(cbCampanhaNome.Text) ;
   qryTmp.open;

   idcamp:=qryTmp.FieldValues['idcamp'];


          if MessageDlg('Deseja confirmar exclusão do cliente '+qryGrid.FieldValues['nomecli']+'#13'+' da campanha '+cbCampanhaNome.Text+'?',mtconfirmation,[mbYes,MbNo],0)=mryes then
           begin

               qryTmp.Close;
               qryTmp.SQL.Text :='delete from campanhasclientes where cpfcli='+quotedstr(qryGrid.FieldValues['cpfcli'])+' and idcamp='+inttostr(idcamp) ;
               qryTmp.ExecSQL;
               qryTmp.Transaction.CommitRetaining;
               qryGrid.Transaction.Commit;
               qryGrid.Transaction.Active:=true;
               qryGrid.Close;
               qryGrid.Open;
               ShowMessage('Cliente excluso com sucesso!');
           end;

   qryTmp.Close;

  end;

end;

procedure TfrmCadDescontoCliente.edtValorforClick(Sender: TObject);
begin
  edtValorFor.SelectAll;
end;

procedure TfrmCadDescontoCliente.edtValorforKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 { if (Key in [96..107]) or (Key in [48..57]) then
     begin
      S := edtValorFor.Text;
      S := StringReplace(S,',','',[rfReplaceAll]);
      S := StringReplace(S,'.','',[rfReplaceAll]);
      if Length(s) = 3 then
        begin
          s := Copy(s,1,1)+','+Copy(S,2,15);
          edtValorFor.Text := S;
          edtValorFor.SelStart := Length(S);
        end
      else
        if (Length(s) > 3) and (Length(s) < 6) then
          begin
            s := Copy(s,1,length(s)-2)+','+Copy(S,length(s)-1,15);
            edtValorFor.Text := s;
            edtValorFor.SelStart := Length(S);
          end
        else
          if (Length(s) >= 6) and (Length(s) < 9) then
            begin
              s := Copy(s,1,length(s)-5)+'.'+Copy(s,length(s)-4,3)+','+Copy(S,length(s)-1,15);
              edtValorFor.Text := s;
              edtValorFor.SelStart := Length(S);
            end
          else
            if (Length(s) >= 9) and (Length(s) < 12) then
              begin
                s := Copy(s,1,length(s)-8)+'.'+Copy(s,length(s)-7,3)+'.'+
                       Copy(s,length(s)-4,3)+','+Copy(S,length(s)-1,15);
                edtValorFor.Text := s;
                edtValorFor.SelStart := Length(S);
              end
            else
              if (Length(s) >= 12) and (Length(s) < 15)  then
                begin
                  s := Copy(s,1,length(s)-11)+'.'+Copy(s,length(s)-10,3)+'.'+
                          Copy(s,length(s)-7,3)+'.'+Copy(s,length(s)-4,3)+','+Copy(S,length(s)-1,15);
                  edtValorFor.Text := s;
                  edtValorFor.SelStart := Length(S);
                end;
      end; }


      if (pos('.',edtValorFor.Text)>0) then

        BEGIN

          edtValorFor.Text:= stringreplace(edtValorFor.Text,'.','', [rfReplaceAll, rfIgnoreCase]);
          edtValorFor.SelStart := Length( edtValorFor.Text );

        END;
end;

procedure TfrmCadDescontoCliente.edtValorvarClick(Sender: TObject);
begin
  edtValorVar.SelectAll;
end;

procedure TfrmCadDescontoCliente.edtValorvarKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  { if (Key in [96..107]) or (Key in [48..57]) then
     begin
      S := edtValorVar.Text;
      S := StringReplace(S,',','',[rfReplaceAll]);
      S := StringReplace(S,'.','',[rfReplaceAll]);
      if Length(s) = 3 then
        begin
          s := Copy(s,1,1)+','+Copy(S,2,15);
          edtValorVar.Text := S;
          edtValorVar.SelStart := Length(S);
        end
      else
        if (Length(s) > 3) and (Length(s) < 6) then
          begin
            s := Copy(s,1,length(s)-2)+','+Copy(S,length(s)-1,15);
            edtValorVar.Text := s;
            edtValorVar.SelStart := Length(S);
          end
        else
          if (Length(s) >= 6) and (Length(s) < 9) then
            begin
              s := Copy(s,1,length(s)-5)+'.'+Copy(s,length(s)-4,3)+','+Copy(S,length(s)-1,15);
              edtValorVar.Text := s;
              edtValorVar.SelStart := Length(S);
            end
          else
            if (Length(s) >= 9) and (Length(s) < 12) then
              begin
                s := Copy(s,1,length(s)-8)+'.'+Copy(s,length(s)-7,3)+'.'+
                       Copy(s,length(s)-4,3)+','+Copy(S,length(s)-1,15);
                edtValorVar.Text := s;
                edtValorVar.SelStart := Length(S);
              end
            else
              if (Length(s) >= 12) and (Length(s) < 15)  then
                begin
                  s := Copy(s,1,length(s)-11)+'.'+Copy(s,length(s)-10,3)+'.'+
                          Copy(s,length(s)-7,3)+'.'+Copy(s,length(s)-4,3)+','+Copy(S,length(s)-1,15);
                  edtValorVar.Text := s;
                  edtValorVar.SelStart := Length(S);
                end;
      end; }


      if (pos('.',edtValorVar.Text)>0) then

        BEGIN

          edtValorVar.Text:= stringreplace(edtValorVar.Text,'.','', [rfReplaceAll, rfIgnoreCase]);
          edtValorVar.SelStart := Length( edtValorVar.Text );

        END;
end;

procedure TfrmCadDescontoCliente.limpacampos;
begin
 edtCPF.Clear;
 edtNomeCliente.Clear;
 edtDDD.Clear;
 edtCelular.Clear;
 edtValorFor.Text:='0,00';
 edtValorVar.Text:='0,00';
end;


procedure TfrmCadDescontoCliente.sBitBtn1Click(Sender: TObject);

var linha, coluna,{valorcampo2,}idcamp: integer;
 planilha : variant;
 valorcampo : string;
//var valorcampo3 :string;
//var filialestoque :string;
 consulta   : TIBQuery;


begin

qryExcel.Close;
qryExcel.SQL.Text := 'select idcamp,nomecampanha from campanhas where nomecampanha='+quotedstr(cbCampanhaNome.Text);
qryExcel.Open;

idcamp := qryExcel.FieldValues['idcamp'];

qryExcel.Close;
qryExcel.SQL.Text := 'select a.nomecli CLIENTE,a.cpfcli CPF, A.ddd, A.celular, coalesce(A.valorfor,0)valorfor, coalesce(A.valorvar,0)valorvar , dtvalidade from campanhasclientes a where idcamp='+IntToStr(idcamp)+' ORDER BY 1';
qryExcel.Open;

if qryExcel.IsEmpty then  raise Exception.Create('Campanha Vazia');


consulta:=qryExcel;

if qryGrid.RecordCount=0 then
raise Exception.Create('SEM DADOS');


  planilha:= CreateoleObject('Excel.Application');
  planilha.WorkBooks.add(1);
  planilha.caption := 'Exportando dados do dbGrid, dataset ou query para o Excel';
  planilha.visible := true;
  consulta.FetchAll;

  consulta.First;

  for linha := 0 to consulta.RecordCount - 1 do
  begin
    for coluna := 1 to consulta.FieldCount do
    begin


             {   if (coluna=1) or (coluna=2) or (coluna=3 )or (coluna=4) or (coluna=5) or (coluna=6)  or (coluna=7) or (coluna=8) then


                begin
                 valorcampo := consulta.Fields[coluna - 1].AsString;
                 planilha.cells[linha + 2,coluna] := valorCampo;
                 end

                 else

                 if (coluna=9) or  (coluna=10) or (coluna=11) or (coluna=12) or (coluna=13) or (coluna=14) or (coluna=15)  or (coluna=16) or (coluna=17) or (coluna=18)  or (coluna=19)   or (coluna=23)  or (coluna=24) then


               begin
                 planilha.cells[linha+2,coluna]:=RoundTo(Consulta.Fields[coluna-1].AsFloat,-6);
                 planilha.Cells[linha+2,coluna].NumberFormat := '#.##0,000';


               end

               else

               if (coluna=20)  then

               begin
                planilha.cells[linha+2,coluna]:=RoundTo(Consulta.Fields[coluna-1].AsFloat,-2);
                planilha.Cells[linha+2,coluna].NumberFormat :=  'R$ #.##0,00_);(R$ #.##0,00)';
               end



                else

               if (coluna=21) then

               begin
                planilha.cells[linha+2,coluna]:=RoundTo(Consulta.Fields[coluna-1].AsFloat,-2);
                planilha.Cells[linha+2,coluna].NumberFormat :=  'R$ #.##0,00000_);(R$ #.##0,00000)';
               end


             else }

               begin
                 valorcampo := consulta.Fields[coluna - 1].AsString;
                 planilha.cells[linha + 2,coluna] := valorCampo;
                 //planilha.Cells[linha+2,coluna].HorizontalAlignment := 4;
                 //planilha.Cells[linha+2,coluna].NumberFormat := '#.##0,000000';

               end;

    end;
    consulta.Next;
  end;



 for coluna := 1 to qryGrid.FieldCount do

 begin
                        case coluna of

                          1:planilha.cells[1,coluna]:='CLIENTE';
                          2:planilha.cells[1,coluna]:='CPF';
                          3:planilha.cells[1,coluna]:='DDD';
                          4:planilha.cells[1,coluna]:='CELULAR';
                          5:planilha.cells[1,coluna]:='CRÉDITO FÓRMULA';
                          6:planilha.cells[1,coluna]:='CRÉDITO VAREJO';
                          7:planilha.cells[1,coluna]:='VALIDADE';

       end;
  end;


  planilha.ActiveWindow.DisplayGridlines := False;
  planilha.columns.Autofit;

  planilha.DisplayAlerts := False;  // Discard unsaved files....
 // planilha.Quit;
  //planilha:=Unassigned;

  showmessage ('EXPORTAÇÃO REALIZADA COM SUCESSO');

end;

function isCPF(CPF: string): boolean;
var  dig10, dig11: string;
    s, i, r, peso: integer;
begin
// length - retorna o tamanho da string (CPF é um número formado por 11 dígitos)
  if ((CPF = '00000000000') or (CPF = '11111111111') or
      (CPF = '22222222222') or (CPF = '33333333333') or
      (CPF = '44444444444') or (CPF = '55555555555') or
      (CPF = '66666666666') or (CPF = '77777777777') or
      (CPF = '88888888888') or (CPF = '99999999999') or
      (length(CPF) <> 11))
     then begin
              isCPF := false;
              exit;
            end;

// try - protege o código para eventuais erros de conversão de tipo na função StrToInt
  try
{ *-- Cálculo do 1o. Digito Verificador --* }
    s := 0;
    peso := 10;
    for i := 1 to 9 do
    begin
// StrToInt converte o i-ésimo caractere do CPF em um número
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig10 := '0'
    else str(r:1, dig10); // converte um número no respectivo caractere numérico

{ *-- Cálculo do 2o. Digito Verificador --* }
    s := 0;
    peso := 11;
    for i := 1 to 10 do
    begin
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig11 := '0'
    else str(r:1, dig11);

{ Verifica se os digitos calculados conferem com os digitos informados. }
    if ((dig10 = CPF[10]) and (dig11 = CPF[11]))
       then isCPF := true
    else isCPF := false;
  except
    isCPF := false
  end;
end;



procedure TfrmCadDescontoCliente.btCadastrarClick(Sender: TObject);
begin

 if (edtNomeCliente.Text='') or (edtCPF.Text='') or (edtDDD.Text='') or (edtCelular.Text='') or (cbCampanhaNome.ItemIndex=-1) or (edtValorFor.Text='') or (edtValorVar.Text='')  then
  raise Exception.Create('Preencha todos os campos');

  if edtValorFor.Text='' then edtValorFor.Text:='0,00';
  if edtValorVar.Text='' then edtValorFor.Text:='0,00';


  if isCPF(edtCPF.Text)=false then  raise Exception.Create('CPF INVÁLIDO');

 qryTmp.Close;
 qryTmp.SQL.Text := 'select * from campanhasclientes where idcamp='+inttostr(idcamp)+' and cpfcli='+quotedstr(edtCPF.Text);
 //clipboard.AsText := qryTmp.SQL.Text ;
 qryTmp.Open;


 if not qryTmp.IsEmpty then
  begin
    raise Exception.Create('Cliente já cadastrado nesta campanha');
    qryTmp.Close;
    limpacampos;
  end;


 qryTmp.Close;
 qryTmp.SQL.Text := 'insert into campanhasclientes (idcamp,nomecli,cpfcli,ddd,celular,valorfor,valorvar) values('+inttostr(idcamp)+','+quotedstr(edtNomeCliente.Text)+','+quotedstr(edtCPF.Text)+','+quotedstr(edtDDD.Text)+','+quotedstr(edtCelular.Text)+','+stringreplace(edtvalorfor.Text,',','.', [rfReplaceAll, rfIgnoreCase])+','+stringreplace(edtvalorVar.Text,',','.', [rfReplaceAll, rfIgnoreCase])+')';
// qryTmp.SQL.Text := 'insert into campanhasclientes (idcamp,nomecli,cpfcli,ddd,celular,valorfor,valorvar, dtValidade ) values('+inttostr(idcamp)+','+quotedstr(edtNomeCliente.Text)+','+quotedstr(edtCPF.Text)+','+quotedstr(edtDDD.Text)+','+quotedstr(edtCelular.Text)+','+stringreplace(edtvalorfor.Text,',','.', [rfReplaceAll, rfIgnoreCase])+','+stringreplace(edtvalorVar.Text,',','.', [rfReplaceAll, rfIgnoreCase])+','+QuotedStr(FormatDateTime('dd.mm.yyyy',dtpValidade.date))+')';
 //clipboard.AsText := qryTmp.SQL.Text ;
 qryTmp.ExecSQL;
 qryTmp.Transaction.CommitRetaining;



 limpacampos;

 qryGrid.Transaction.Commit;
 qryGrid.Transaction.Active:=true;
 qryGrid.Close;
 qryGrid.SQL.Text := 'select a.nomecli, a.cpfcli, a.ddd, a.celular,b.idcamp from campanhasclientes a,campanhas b where  a.idcamp=b.idcamp and   b.nomecampanha='+quotedstr(cbCampanhaNome.Text);
 qryGrid.Open;

 ShowMessage('Cadastrado com sucesso');
end;

procedure TfrmCadDescontoCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;
end;


procedure TfrmCadDescontoCliente.limpacampanhas;
begin
 cbCampanhaNome.ItemIndex:=-1;

 qryTmp.Close;
 qryTmp.SQL.Text := 'select nomecampanha from campanhas order by nomecampanha ';
 qryTmp.Open;

 if not(qryTmp.IsEmpty) then
  begin

    cbCampanhaNome.Clear;
    while not qryTmp.Eof do
     begin
      cbCampanhaNome.Items.Add(qryTmp.FieldValues['nomecampanha']);
      qryTmp.Next;
     end;

  end;

end;

procedure TfrmCadDescontoCliente.FormShow(Sender: TObject);
begin

 qryGrid.Close;

 limpacampanhas;
 limpacampos;

end;

end.
