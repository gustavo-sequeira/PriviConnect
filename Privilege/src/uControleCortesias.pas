unit uControleCortesias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, IBX.IBCustomDataSet, excelxp,
  comobj,
  IBX.IBQuery, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls;

type
  TfrmControleCortesias = class(TForm)
    gbIntervalo: TGroupBox;
    Inicial: TLabel;
    Label1: TLabel;
    dtFinal: TDateTimePicker;
    dtInicial: TDateTimePicker;
    gbFiltros: TGroupBox;
    Bevel1: TBevel;
    rbTodas: TRadioButton;
    rbRejeitadas: TRadioButton;
    rbAprovadas: TRadioButton;
    Panel2: TPanel;
    dbControle: TDBGrid;
    GroupBox1: TGroupBox;
    btExcel: TBitBtn;
    btMostrar: TBitBtn;
    StatusBar: TStatusBar;
    qryRelControleCort: TIBQuery;
    dsGrid: TDataSource;
    rbPendentes: TRadioButton;
    procedure FormShow(Sender: TObject);
    procedure rbPendentesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btMostrarClick(Sender: TObject);
    procedure btExcelClick(Sender: TObject);
    procedure gerarelat;
    Procedure GerarExcel(Consulta: TIBQuery);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmControleCortesias: TfrmControleCortesias;

implementation

{$R *.dfm}

Procedure TfrmControleCortesias.GerarExcel(Consulta: TIBQuery);
var
  coluna, linha: Integer;
  excel: variant;
  valor, filtro: string;
begin
  try
    excel := CreateOleObject('Excel.Application');
    excel.Workbooks.add(1);
  except
    Application.MessageBox('Versão do Ms-Excel' + 'Incompatível', 'Erro',
      MB_OK + MB_ICONEXCLAMATION);
  end;

  if rbTodas.Checked then
    filtro := 'TODAS';
  if rbRejeitadas.Checked then
    filtro := 'REJEITADAS';
  if rbAprovadas.Checked then
    filtro := 'APROVADAS';
  if rbPendentes.Checked then
    filtro := 'PENDENTES';

  excel.cells[1, 1] := 'CONTROLE DE CORTESIAS';
  excel.cells[2, 1] := 'FILTRO :' + filtro + ' - INTERVALO : ' +
    FormatDateTime('dd/mm/yyyy', dtInicial.Date) + ' - ' +
    FormatDateTime('dd/mm/yyyy', dtFinal.Date);

  excel.ActiveSheet.Range['A1:F1'].HorizontalAlignment := -4108;
  excel.ActiveSheet.Range['A2:F2'].HorizontalAlignment := -4108;
  excel.ActiveSheet.Range['A4:F4'].HorizontalAlignment := -4108;

  excel.ActiveSheet.Range['A1:F1'].Merge;
  excel.ActiveSheet.Range['A2:F2'].Merge;
  excel.ActiveSheet.Range['A3:F3'].Merge;

  excel.cells[1, 1].Font.name := 'Calibri';
  excel.cells[1, 1].Font.Bold := TRUE;
  excel.cells[1, 1].Font.Size := 18;

  excel.cells[2, 1].Font.name := 'Calibri';
  excel.cells[2, 1].Font.Bold := TRUE;
  excel.cells[2, 1].Font.Size := 11;

  excel.cells[3, 1].Font.name := 'Calibri';
  excel.cells[3, 1].Font.Bold := TRUE;
  excel.cells[3, 1].Font.Size := 11;

  Consulta.First;

  try
    for linha := 3 to Consulta.RecordCount + 2 do
    begin
      for coluna := 1 to Consulta.FieldCount do
      // eliminei a coluna 0 da relação do Excel
      begin
        if coluna = 1 then
        begin
          excel.cells[linha + 2, coluna] := Consulta.Fields[coluna - 1].AsDateTime;
        end
          else
        if coluna < 5 then
        begin
          valor := Consulta.Fields[coluna - 1].AsString;
          excel.cells[linha + 2, coluna] := valor;
        end
        else
          excel.cells[linha + 2, coluna] := Consulta.Fields[coluna - 1].AsFloat;
      end;
      Consulta.Next;
    end;

    for coluna := 1 to Consulta.FieldCount do
    // eliminei a coluna 0 da relação do Excel
    begin
      valor := Consulta.Fields[coluna - 1].DisplayLabel;
      excel.cells[4, coluna] := valor;
    end;

    excel.ActiveSheet.Range['A4:F4'].Font.Bold := TRUE;
    excel.ActiveSheet.Range['A4:F' + inttostr(Consulta.RecordCount + 5)
      ].Borders.LineStyle := xlContinuous; // 3;
    excel.ActiveSheet.Range['A4:F4'].Columns.Interior.ColorIndex := 24;
    excel.cells[Consulta.RecordCount + 5, 3] := 'TOTAL';

    excel.cells[Consulta.RecordCount + 5, 3].Font.name := 'Calibri';
    excel.cells[Consulta.RecordCount + 5, 3].Font.Bold := TRUE;
    excel.cells[Consulta.RecordCount + 5, 5].Font.Bold := TRUE;
    excel.cells[Consulta.RecordCount + 5, 6].Font.Bold := TRUE;

    excel.ActiveSheet.Range['A' + inttostr(Consulta.RecordCount + 5) + ':F' +
      inttostr(Consulta.RecordCount + 5)].Columns.Interior.ColorIndex := 36;
    excel.ActiveSheet.Range['A' + inttostr(Consulta.RecordCount + 5) + ':D' +
      inttostr(Consulta.RecordCount + 5)].Merge;
    excel.ActiveSheet.Range['A' + inttostr(Consulta.RecordCount + 5) + ':D' +
      inttostr(Consulta.RecordCount + 5)].HorizontalAlignment := -4108;
    excel.cells[Consulta.RecordCount + 5, 5] := '=SUM(E5:E' +
      inttostr(Consulta.RecordCount + 4) + ')';
    excel.cells[Consulta.RecordCount + 5, 6] := '=SUM(F5:F' +
      inttostr(Consulta.RecordCount + 4) + ')';

    excel.ActiveSheet.Range['A4:F' + inttostr(Consulta.RecordCount + 4)].Select;

    // Excel.ActiveSheet.Range['A10'].formula := '=SUBTOTAL(9,A5:A6)';

    // Excel.ActiveSheet.Range['A4:F'+inttostr(Consulta.RecordCount+4)].Subtotal(1,1,7,0,0,1);
    excel.ActiveSheet.Outline.ShowLevels(2, 1);

    excel.Columns.AutoFit;
    // esta linha é para fazer com que o Excel dimencione as células adequadamente.

    excel.ActiveWindow.DisplayGridlines := False;
    excel.Visible := TRUE;
  except
    Application.MessageBox('Aconteceu um erro desconhecido durante a conversão'
      + 'da tabela para o Ms-Excel', 'Erro', MB_OK + MB_ICONEXCLAMATION);
  end;
end;

procedure TfrmControleCortesias.btExcelClick(Sender: TObject);
begin
  gerarelat;

  dbControle.Columns[0].Width := 65;
  dbControle.Columns[1].Width := 60;
  dbControle.Columns[2].Width := 90;
  dbControle.Columns[3].Width := 200;
  dbControle.Columns[4].Width := 60;
  dbControle.Columns[5].Width := 60;

  if not(qryRelControleCort.IsEmpty) then
    GerarExcel(qryRelControleCort)
  else
    ShowMessage('Busca não retornou resultados');
end;

procedure TfrmControleCortesias.gerarelat;
begin

  if rbTodas.Checked then
  begin
    qryRelControleCort.Close;
    qryRelControleCort.SQL.Text :=
      'select DTSOL as DATA, HRSOL as HORA, DEPTOCORT as DEPTO,NOMEFUNCORT as FUNCIONARIO, VALORCORT as VR_CORT, VALORFRM as VR_FORM from  soliccortesia a where a.cancelado=0 and a.dtsol between '
      + quotedstr(FormatDateTime('dd.mm.yyyy', dtInicial.Date)) + ' and ' +
      quotedstr(FormatDateTime('dd.mm.yyyy', dtFinal.Date)) +
      ' order by dtsol,nomefuncort';
    qryRelControleCort.Open;
    qryRelControleCort.FetchAll;
  end;

  if rbRejeitadas.Checked then
  begin
    qryRelControleCort.Close;
    qryRelControleCort.SQL.Text :=
      'select DTSOL as DATA, HRSOL as HORA, DEPTOCORT as DEPTO, NOMEFUNCORT as FUNCIONARIO, VALORCORT as VR_CORT, VALORFRM as VR_FORM from  soliccortesia a where a.indapr=2 and a.cancelado=0 and a.dtsol between '
      + quotedstr(FormatDateTime('dd.mm.yyyy', dtInicial.Date)) + ' and ' +
      quotedstr(FormatDateTime('dd.mm.yyyy', dtFinal.Date)) +
      ' order by dtsol,nomefuncort';
    qryRelControleCort.Open;
    qryRelControleCort.FetchAll;
  end;

  if rbAprovadas.Checked then
  begin
    qryRelControleCort.Close;
    qryRelControleCort.SQL.Text :=
      'select DTSOL as DATA, HRSOL as HORA, DEPTOCORT as DEPTO, NOMEFUNCORT as FUNCIONARIO, VALORCORT as VR_CORT, VALORFRM as VR_FORM from  soliccortesia a where a.indapr=1 and a.cancelado=0 and a.dtsol between '
      + quotedstr(FormatDateTime('dd.mm.yyyy', dtInicial.Date)) + ' and ' +
      quotedstr(FormatDateTime('dd.mm.yyyy', dtFinal.Date)) +
      ' order by dtsol,nomefuncort';
    qryRelControleCort.Open;
    qryRelControleCort.FetchAll;
  end;

  if rbPendentes.Checked then
  begin
    qryRelControleCort.Close;
    qryRelControleCort.SQL.Text :=
      'select DTSOL as DATA, HRSOL as HORA, DEPTOCORT as DEPTO, NOMEFUNCORT as FUNCIONARIO, VALORCORT as VR_CORT, VALORFRM as VR_FORM from  soliccortesia a where a.indapr=0 and a.cancelado=0 and a.dtsol between '
      + quotedstr(FormatDateTime('dd.mm.yyyy', dtInicial.Date)) + ' and ' +
      quotedstr(FormatDateTime('dd.mm.yyyy', dtFinal.Date)) +
      ' order by dtsol,nomefuncort';
    qryRelControleCort.Open;
    qryRelControleCort.FetchAll;
  end;

end;

procedure TfrmControleCortesias.btMostrarClick(Sender: TObject);
begin

  gerarelat;

  dbControle.Columns[0].Width := 65;
  dbControle.Columns[1].Width := 60;
  dbControle.Columns[2].Width := 90;
  dbControle.Columns[3].Width := 200;
  dbControle.Columns[4].Width := 60;
  dbControle.Columns[5].Width := 60;

  StatusBar.Panels[1].Text := inttostr(qryRelControleCort.RecordCount) +
    ' registros';
end;

procedure TfrmControleCortesias.FormShow(Sender: TObject);
begin
  qryRelControleCort.Close;
  dtInicial.Date := strtodate(FormatDateTime('01/mm/yyyy', now));
  dtFinal.Date := now;
  rbTodas.Checked := TRUE;
  StatusBar.Panels[1].Text := '';
end;

procedure TfrmControleCortesias.rbPendentesMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  qryRelControleCort.Close;
  StatusBar.Panels[1].Text := '';
end;

end.
