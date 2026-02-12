unit uConsultoriaPremium;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, IBX.IBCustomDataSet,
  IBX.IBQuery, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, clipbrd,
  Vcl.ExtCtrls, sSpeedButton, System.Win.ComObj ;

type
  TfrmConsultoriaPremium = class(TForm)
    dbgMedicos: TDBGrid;
    dsGrid: TDataSource;
    qryTMPFcerta: TIBQuery;
    btnSair: TBitBtn;
    qryGrid: TIBQuery;
    qryGrava: TIBQuery;
    Panel1: TPanel;
    edtPFCRM: TEdit;
    Label8: TLabel;
    Label6: TLabel;
    edtNRCRM: TEdit;
    edtUFCRM: TEdit;
    Label1: TLabel;
    Label4: TLabel;
    edtNomeMed: TEdit;
    btnIncluir: TBitBtn;
    btnExcluir: TBitBtn;
    Label2: TLabel;
    edtPerFormula: TMaskEdit;
    gerarPlanilha: TsSpeedButton;
    qryConsulta: TIBQuery;
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BuscarMedico;
    procedure edtPFCRMExit(Sender: TObject);
    procedure edtUFCRMExit(Sender: TObject);
    procedure edtNRCRMExit(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure limpaCampos;
    procedure btnExcluirClick(Sender: TObject);
    procedure MontaConsulta;
    procedure dbgMedicosDblClick(Sender: TObject);
    procedure btnAplicarDescontoClick(Sender: TObject);
    procedure gerarPlanilhaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultoriaPremium: TfrmConsultoriaPremium;

implementation
uses udmDescontos , uPrincipal ;

{$R *.dfm}

procedure TfrmConsultoriaPremium.btnExcluirClick(Sender: TObject);
begin

     qryGrava.Close;
     qryGrava.SQL.Clear;
     qryGrava.SQL.Add('select * FROM CONSULTORIA WHERE  ');
     qryGrava.SQL.Add(' PFCRM = '+QuotedStr(qryGrid.FieldByName('PFCRM').asString)+' AND ');
     qryGrava.SQL.Add(' UFCRM = '+QuotedStr(qryGrid.FieldByName('UFCRM').asString)+' AND ');
     qryGrava.SQL.Add(' NRCRM = '+qryGrid.FieldByName('NRCRM').asString);
     qryGrava.Open;

     if NOT qryGrava.IsEmpty then
        begin
          ShowMessage('Atenção! Há pacientes com descontos lançados com a consultoria do Médico.');
          limpaCampos;
          MontaConsulta;
          exit;
        end;


     qryGrava.Close;
     qryGrava.SQL.Clear;
     qryGrava.SQL.Add('DELETE FROM PARCERIA WHERE  ');
     qryGrava.SQL.Add(' PFCRM = '+QuotedStr(qryGrid.FieldByName('PFCRM').asString)+' AND ');
     qryGrava.SQL.Add(' UFCRM = '+QuotedStr(qryGrid.FieldByName('UFCRM').asString)+' AND ');
     qryGrava.SQL.Add(' NRCRM = '+qryGrid.FieldByName('NRCRM').asString);
  //  CLIPBOARD.AsText := qryGrava.SQL.Text;
     qryGrava.ExecSQL;
     qryGrava.Close;

     limpaCampos;
     MontaConsulta;

end;

procedure TfrmConsultoriaPremium.btnAplicarDescontoClick(Sender: TObject);
begin
  {
  if ( frmPrincipal.edtLoja.Text  = '') or (frmPrincipal.edtTerminalBalcao.text = '')  then raise Exception.Create('É necessário digitar o numero do Terminal balcão');

  frmConsultoriaPremium.Close;

  frmPrincipal.ConsultoriaPremium;
   }

end;

procedure TfrmConsultoriaPremium.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TfrmConsultoriaPremium.MontaConsulta;
begin
   qryGrid.Close;
   qryGrid.SQL.Clear;
   qryGrid.SQL.Add('select * from Parceria ');
   qryGrid.SQL.Add('order by nomemed');
   qryGrid.Open;

end;


procedure TfrmConsultoriaPremium.btnIncluirClick(Sender: TObject);
begin

     qryGrava.Close;
     qryGrava.SQL.Clear;
     qryGrava.SQL.Add(' UPDATE OR INSERT INTO PARCERIA ( PFCRM , UFCRM , NRCRM , NOMEMED , PERFORM ) ');
     qryGrava.SQL.Add(' VALUES ('+QuotedStr(edtPFCRM.Text)+', '+QuotedStr(edtUFCRM.text)+', '+edtNRCRM.Text+', ');
     qryGrava.SQL.Add(' '+QuotedStr( edtNomeMed.text  )+' , '+edtPerFormula.Text +' ) ');
  //  CLIPBOARD.AsText := qryGrava.SQL.Text;
     qryGrava.ExecSQL;
     qryGrava.Close;

     limpaCampos;
     MontaConsulta;

end;

procedure TfrmConsultoriaPremium.limpaCampos;
begin
   edtPFCRM.Text   := '';
   edtUFCRM.text   := '';
   edtNRCRM.Text   := '';
   edtNomeMed.text := '';
   edtPerFormula.Text := '0';

   btnIncluir.Enabled := true;
   btnExcluir.Enabled := false;

end;

procedure TfrmConsultoriaPremium.BuscarMedico;
begin
 if (trim(edtPFCRM.Text)<>'') and(trim(edtNRCRM.Text)<>'') and(trim(edtUFCRM.Text)<>'')   then
   begin

      qryTMPFcerta.Close;
      qryTMPFcerta.SQL.Text := 'select * from fc04000 where pfcrm='+quotedstr(edtPFCRM.Text)+' and ufcrm='+QuotedStr(edtUFCRM.Text)+' and NRCRM='+edtNRCRM.Text;
      qryTMPFcerta.Open;

      if not(qryTMPFcerta.IsEmpty) then  edtNomeMed.Text:=qryTMPFcerta.FieldValues['NOMEMED']
       else
      edtNomeMed.Text := '';

   end else edtNomeMed.Text := '';

   qryTMPFcerta.Close;
end;

procedure TfrmConsultoriaPremium.dbgMedicosDblClick(Sender: TObject);
begin

    edtPFCRM.Text      := qryGrid.FieldByName('pfcrm').AsString;
    edtUFCRM.Text      := qryGrid.FieldByName('ufcrm').AsString;
    edtNRCRM.Text      := qryGrid.FieldByName('nrcrm').AsString;
    edtNomeMed.Text    := qryGrid.FieldByName('nomeMed').AsString;
    edtPerFormula.Text := qryGrid.FieldByName('PerForm').AsString;

    btnExcluir.Enabled := true;
    btnIncluir.Enabled := false;

end;

procedure TfrmConsultoriaPremium.edtNRCRMExit(Sender: TObject);
begin
 buscarMedico;
end;

procedure TfrmConsultoriaPremium.edtPFCRMExit(Sender: TObject);
begin
  BuscarMedico;
end;

procedure TfrmConsultoriaPremium.edtUFCRMExit(Sender: TObject);
begin
    BuscarMedico;
end;

procedure TfrmConsultoriaPremium.FormKeyPress(Sender: TObject; var Key: Char);
begin

 if key=#13 then
  begin
   Key := #0;
   Perform(WM_NEXTDLGCTL, 0, 0);
  end;

  if key=#27 then
  begin
     limpaCampos;
     MontaConsulta;
  end;


end;

procedure TfrmConsultoriaPremium.FormShow(Sender: TObject);
begin
     limpaCampos;
     MontaConsulta;
end;

procedure TfrmConsultoriaPremium.gerarPlanilhaClick(Sender: TObject);
var titulo:string;
planilha :Variant;
LnLinha:integer;
begin

   screen.cursor := crHourglass;



   qryConsulta.Close;
   qryConsulta.SQL.Clear;
   qryConsulta.SQL.add ('select * from consultoria C ');
   qryConsulta.SQL.Add(' WHERE PFCRM = '+QuotedStr(qryGrid.FieldByName('PFCRM').asString)+' AND ');
   qryConsulta.SQL.Add('       UFCRM = '+QuotedStr(qryGrid.FieldByName('UFCRM').asString)+' AND ');
   qryConsulta.SQL.Add('       NRCRM = '+qryGrid.FieldByName('NRCRM').asString);
   qryConsulta.SQL.Add(' order by c.nomecli , c.dtope ');
   qryConsulta.Open;

   //clipboard.astext:=qryDados.sql.text;
   qryConsulta.Open;

   if qryConsulta.IsEmpty then
      raise Exception.Create('SEM DADOS');

   titulo:='Pacientes do Projeto Consultoria Premium -  Profissão:'+qryGrid.FieldByName('PFCRM').asString+' UF:'+qryGrid.FieldByName('UFCRM').asString+' CRM:'+qryGrid.FieldByName('NRCRM').asString+' Médico: '+qryGrid.FieldByName('NOMEMED').asString;

   planilha:= CreateoleObject('Excel.Application');
   planilha.WorkBooks.add(1);
   planilha.caption := 'Exportando dados do dia';
   planilha.visible := true;

   planilha.cells[2,1]   := 'CDCLI';
   planilha.cells[2,2]   := 'NOMECLI';
   planilha.cells[2,3]   := 'CPF';
   planilha.cells[2,4]   := 'CDFIL';
   planilha.cells[2,5]   := 'T.BALCAO';
   planilha.cells[2,6]   := 'DTOPE';
   planilha.cells[2,7]   := 'HORA';
   planilha.cells[2,8]   := 'ITEMID';
   planilha.cells[2,9]   := 'CDFILR';
   planilha.cells[2,10]  := 'REQUISICAO';
   planilha.cells[2,11]  := 'QUANT';
   planilha.cells[2,12]  := 'VRBRUTO';
   planilha.cells[2,13]  := 'VRDESC';
   planilha.cells[2,14]  := 'VRLIQ';
   planilha.cells[2,15]  := 'USUARIO';


   LnLinha := 3;
   qryConsulta.FetchAll;
   qryConsulta.First;
   while not qryConsulta.Eof do
     begin

       planilha.cells[LnLinha,1]  :=  qryConsulta.FieldByName('CDCLI').AsString;
       planilha.cells[LnLinha,2]  :=  qryConsulta.FieldByName('NOMECLI').AsString;
       planilha.cells[LnLinha,3]  :=  qryConsulta.FieldByName('CPF').AsString;
       planilha.cells[LnLinha,4]  :=  qryConsulta.FieldByName('CDFIL').AsString;
       planilha.cells[LnLinha,5]  :=  qryConsulta.FieldByName('TBALCAO').AsString;
       planilha.cells[LnLinha,6]  :=  FormatDateTime('dd.mm.yyyy',qryConsulta.FieldByName('DTOPE').AsDateTime);
       planilha.cells[LnLinha,7]  :=  qryConsulta.FieldByName('HORA').AsString;
       planilha.cells[LnLinha,8]  :=  qryConsulta.FieldByName('ITEMID').AsString;
       planilha.cells[LnLinha,9]  :=  qryConsulta.FieldByName('CDFILR').AsString;
       planilha.cells[LnLinha,10] :=  qryConsulta.FieldByName('CDPRO').AsString;
       planilha.cells[LnLinha,11] :=  qryConsulta.FieldByName('QUANT').AsString;
       planilha.cells[LnLinha,12] :=  qryConsulta.FieldByName('VRBRUTO').AsCurrency;
       planilha.cells[LnLinha,13] :=  qryConsulta.FieldByName('VRDESC').AsCurrency;
       planilha.cells[LnLinha,14] :=  qryConsulta.FieldByName('VRLIQ').AsCurrency;
       planilha.cells[LnLinha,15] :=  qryConsulta.FieldByName('USUID').AsString;

       LnLinha := LnLinha +1;
       qryConsulta.Next;
     end;


     planilha.columns.Autofit;

     planilha.cells[1,1] := titulo;
     planilha.ActiveSheet.Range['A1:O1'].Merge;
     planilha.ActiveSheet.Range['A1:O1'].HorizontalAlignment := -4108;
     planilha.ActiveSheet.Range['A1:O1'].Columns.Interior.ColorIndex :=15;
     planilha.ActiveSheet.Range['A2:O2'].Borders.LineStyle := 1;

     planilha.visible := true;
     planilha.Quit;

     screen.cursor := crDefault;



end;

end.
