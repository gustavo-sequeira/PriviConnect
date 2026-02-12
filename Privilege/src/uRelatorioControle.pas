unit uRelatorioControle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids, DBGrids, Buttons, ExtCtrls, DB,
  IBCustomDataSet, IBQuery, excelxp, comobj;

type
  TfrmRelatorioControle = class(TForm)
    gbIntervalo: TGroupBox;
    Inicial: TLabel;
    Label1: TLabel;
    dtFinal: TDateTimePicker;
    dtInicial: TDateTimePicker;
    gbFiltros: TGroupBox;
    rbEmitidos: TRadioButton;
    rbBloqueados: TRadioButton;
    rbMovimentados: TRadioButton;
    Bevel1: TBevel;
    rbSolicitados: TRadioButton;
    Panel2: TPanel;
    dbControle: TDBGrid;
    qryRelControlePriv: TIBQuery;
    dsGrid: TDataSource;
    GroupBox1: TGroupBox;
    btExcel: TBitBtn;
    btMostrar: TBitBtn;
    StatusBar: TStatusBar;
    procedure FormShow(Sender: TObject);
    procedure btMostrarClick(Sender: TObject);
    procedure rbEmitidosMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure rbSolicitadosMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure rbMovimentadosMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure rbBloqueadosMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btExcelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioControle: TfrmRelatorioControle;

implementation

uses udmDescontos;

{$R *.dfm}



Procedure GerarExcel(Consulta:TibQuery);
var
     coluna, linha: integer;
     excel: variant;
     valor: string;
begin
     try
          excel:=CreateOleObject('Excel.Application');
          excel.Workbooks.add(1);
     except
          Application.MessageBox ('Versão do Ms-Excel'+
          'Incompatível','Erro',MB_OK+MB_ICONEXCLAMATION);
     end;

     Consulta.First;
     try
        for linha:=0 to Consulta.RecordCount-1 do
        begin
            for coluna:=1 to Consulta.FieldCount do // eliminei a coluna 0 da relação do Excel
            begin
                 valor:= Consulta.Fields[coluna-1].AsString;
                 excel.cells [linha+2,coluna]:=valor;
            end;
            Consulta.Next;
        end;

        for coluna:=1 to Consulta.FieldCount do // eliminei a coluna 0 da relação do Excel
        begin
             valor:= Consulta.Fields[coluna-1].DisplayLabel;
             excel.cells[1,coluna]:=valor;
        end;
        excel.columns.AutoFit; // esta linha é para fazer com que o Excel dimencione as células adequadamente.
        excel.visible:=true;
     except
          Application.MessageBox ('Aconteceu um erro desconhecido durante a conversão'+
          'da tabela para o Ms-Excel','Erro',MB_OK+MB_ICONEXCLAMATION);
     end;
end;

procedure TfrmRelatorioControle.FormShow(Sender: TObject);
begin
  qryRelControlePriv.Close;
  dtInicial.Date:=now;
  dtFinal.Date := now;
  rbEmitidos.Checked:=true;
  StatusBar.Panels[1].Text:='';
end;

procedure TfrmRelatorioControle.btMostrarClick(Sender: TObject);
begin

if rbEmitidos.Checked then
  begin
   qryRelControlePriv.Close;
   qryRelControlePriv.SQL.Text := 'select profissao,nrcrm as CRM,ufcrm as UF,nomemed as MEDICO,especialidade,cdfilsolic as FIL from solicitpriv where flagenv='+quotedstr('S')+' and dtalt between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.date))+' order by nomemed';
   qryRelControlePriv.Open;
   qryRelControlePriv.FetchAll;
   dbControle.Columns[0].Width:=65;
   dbControle.Columns[1].Width:=40;
   dbControle.Columns[3].Width:=200;
   dbControle.Columns[4].Width:=115;
   dbControle.Columns[5].Width:=20;
  end;

if rbMovimentados.Checked then
  begin
   qryRelControlePriv.Close;
   qryRelControlePriv.SQL.Text := 'select titularcartao as MEDICO,count(*) as QTD from descconcedidos where data between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.date))+' group by 1 order by 1';
   qryRelControlePriv.Open;
   qryRelControlePriv.FetchAll;
   dbControle.Columns[0].Width:=300;
   dbControle.Columns[1].Width:=40;
  end;

if rbSolicitados.Checked then
  begin
   qryRelControlePriv.Close;
   qryRelControlePriv.SQL.Text := 'select profissao,nrcrm as CRM,ufcrm as UF,nomemed as MEDICO,especialidade from solicitpriv where dtsolic between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.date))+' order by nomemed';
   qryRelControlePriv.Open;
   qryRelControlePriv.FetchAll;
   dbControle.Columns[0].Width:=95;
   dbControle.Columns[1].Width:=40;
   dbControle.Columns[3].Width:=200;
   dbControle.Columns[4].Width:=110;
  end;

if rbBloqueados.Checked then
  begin
   qryRelControlePriv.Close;
   qryRelControlePriv.SQL.Text := 'select nomemed as MEDICO,nrcartao as CARTAO,data,hora from cartbloqueados where data between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.date))+' order by nomemed, data, hora';
   qryRelControlePriv.Open;
   qryRelControlePriv.FetchAll;
   dbControle.Columns[0].Width:=200;
  end;

   StatusBar.Panels[1].Text:=inttostr(qryRelControlePriv.RecordCount)+' registros';

end;

procedure TfrmRelatorioControle.rbEmitidosMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 qryRelControlePriv.Close;
 StatusBar.Panels[1].Text:='';
end;

procedure TfrmRelatorioControle.rbSolicitadosMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 qryRelControlePriv.Close;
 StatusBar.Panels[1].Text:='';
end;

procedure TfrmRelatorioControle.rbMovimentadosMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 qryRelControlePriv.Close;
 StatusBar.Panels[1].Text:='';
end;

procedure TfrmRelatorioControle.rbBloqueadosMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 qryRelControlePriv.Close;
 StatusBar.Panels[1].Text:='';
end;

procedure TfrmRelatorioControle.btExcelClick(Sender: TObject);
begin

if rbEmitidos.Checked then
  begin
   qryRelControlePriv.Close;
   qryRelControlePriv.SQL.Text := 'select profissao,nrcrm as CRM,ufcrm as UF,nomemed as MEDICO,especialidade,cdfilsolic as FIL from solicitpriv where flagenv='+quotedstr('S')+' and dtalt between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.date))+' order by nomemed';
   qryRelControlePriv.Open;
   qryRelControlePriv.FetchAll;
   dbControle.Columns[0].Width:=65;
   dbControle.Columns[1].Width:=40;
   dbControle.Columns[3].Width:=200;
   dbControle.Columns[4].Width:=115;
   dbControle.Columns[5].Width:=20;   
  end;

if rbMovimentados.Checked then
  begin
   qryRelControlePriv.Close;
   qryRelControlePriv.SQL.Text := 'select titularcartao as MEDICO,count(*) as QTD from descconcedidos where data between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.date))+' group by 1 order by 1';
   qryRelControlePriv.Open;
   qryRelControlePriv.FetchAll;
   dbControle.Columns[0].Width:=300;
   dbControle.Columns[1].Width:=40;
  end;

if rbSolicitados.Checked then
  begin
   qryRelControlePriv.Close;
   qryRelControlePriv.SQL.Text := 'select profissao,nrcrm as CRM,ufcrm as UF,nomemed as MEDICO,especialidade from solicitpriv where dtsolic between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.date))+' order by nomemed';
   qryRelControlePriv.Open;
   qryRelControlePriv.FetchAll;
   dbControle.Columns[0].Width:=95;
   dbControle.Columns[1].Width:=40;
   dbControle.Columns[3].Width:=200;
   dbControle.Columns[4].Width:=110;
  end;

if rbBloqueados.Checked then
  begin
   qryRelControlePriv.Close;
   qryRelControlePriv.SQL.Text := 'select nomemed as MEDICO,nrcartao as CARTAO,data,hora from cartbloqueados where data between '+quotedstr(FormatDateTime('dd.mm.yyyy',dtInicial.date))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',dtFinal.date))+' order by nomemed, data, hora';
   qryRelControlePriv.Open;
   qryRelControlePriv.FetchAll;
   dbControle.Columns[0].Width:=200;
  end;

   StatusBar.Panels[1].Text:=inttostr(qryRelControlePriv.RecordCount)+' registros';


 if not(qryRelControlePriv.IsEmpty) then GerarExcel(qryRelControlePriv)
  else ShowMessage('Busca não retornou resultados');

end;

end.
