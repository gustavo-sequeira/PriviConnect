unit uDescComponente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, IBX.IBCustomDataSet, IBX.IBQuery;

type
  TfrmDescMedQtdCMP = class(TForm)
    GroupBox1: TGroupBox;
    edtValor: TEdit;
    Label3: TLabel;
    edtQTDComp: TEdit;
    Label2: TLabel;
    edtPFCRM: TEdit;
    Label8: TLabel;
    Label7: TLabel;
    edtNRCRM: TEdit;
    Label6: TLabel;
    Label1: TLabel;
    edtNomeMed: TEdit;
    Label4: TLabel;
    cbUFCrM: TComboBox;
    Panel1: TPanel;
    dbgMedicos: TDBGrid;
    Panel2: TPanel;
    btIncluir: TBitBtn;
    btExcluir: TSpeedButton;
    qryGrid: TIBQuery;
    dsGrid: TDataSource;
    qryTMPDescontos: TIBQuery;
    qryTMPFcerta: TIBQuery;
    procedure FormShow(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtNRCRMExit(Sender: TObject);
    procedure edtValorExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDescMedQtdCMP: TfrmDescMedQtdCMP;

implementation

{$R *.dfm}

uses udmDescontos, System.UITypes;

function trocapponto(texto:string):string;
begin
 Result := StringReplace(texto,',','.',[rfReplaceAll,rfIgnoreCase]);
end;

procedure TfrmDescMedQtdCMP.btExcluirClick(Sender: TObject);
begin

if not(qryGrid.IsEmpty)  then
if MessageDlg('Deseja excluir configuração de desconto do médico(a) '+qryGrid.FieldValues['nomemed'] +'?',mtconfirmation,[mbYes,MbNo],0)=mryes then
      begin

        qryTMPDescontos.Close;
        qryTMPDescontos.SQL.Text := ' DELETE FROM FORMTABELADAS2 WHERE PFCRM='+QUOTEDSTR(qryGrid.FieldValues['PFCRM'])+' AND UFCRM='+QUOTEDSTR(qryGrid.FieldValues['UFCRM'])+' AND NRCRM='+INTTOSTR(qryGrid.FieldValues['NRCRM']);
        qryTMPDescontos.Open;

        qryTMPDescontos.Transaction.CommitRetaining;
        qryTMPDescontos.Close;

        qryGrid.Close;
        qryGrid.Open;

        ShowMessage('Excluso com sucesso');

      end;

end;

procedure TfrmDescMedQtdCMP.btIncluirClick(Sender: TObject);
begin

 if (trim(edtPFCRM.Text)='') or (trim(edtNRCRM.Text)='') or (trim(edtValor.Text)='') or
    (trim(edtQTDComp.Text)='') or  (trim(edtNomeMed.Text)='') or (cbUFCrM.ItemIndex=-1) then
    raise Exception.Create('Por favor preencha todos os campos');

  qryTMPFcerta.Close;
  qryTMPFcerta.SQL.Text := 'select * from fc04000 where pfcrm='+quotedstr(edtPFCRM.Text)+' and ufcrm='+QuotedStr(cbUFCrM.Text)+' and NRCRM='+edtNRCRM.Text;
  qryTMPFcerta.Open;

  if qryTMPFcerta.IsEmpty then raise Exception.Create('Médico não encontrado no banco de dados');

  qryTMPFcerta.Close;

  qryTMPDescontos.Close;
  qryTMPDescontos.SQL.Text := ' UPDATE OR INSERT INTO FORMTABELADAS2 (PFCRM, UFCRM, NRCRM, NOMEMED, QTDCPM, VALFORM) VALUES ('+
                               quotedstr(edtPFCRM.Text)+','+quotedstr(cbUFCrM.Text)+','+edtNRCRM.Text+','+quotedstr(edtNomeMed.Text)+','+edtQTDComp.Text+','+trocapponto(edtValor.Text)+');';
  qryTMPDescontos.Open;
  qryTMPDescontos.Transaction.CommitRetaining;
  qryTMPDescontos.Close;

  qryGrid.Close;
  qryGrid.Open;

  ShowMessage('Efetuado com sucesso');

  edtValor.Clear;
  edtQTDComp.Clear;
  edtPFCRM.Clear;
  edtNRCRM.Clear;
  edtNomeMed.Clear;
  cbUFCrM.ItemIndex := -1;

end;


procedure TfrmDescMedQtdCMP.edtNRCRMExit(Sender: TObject);
begin

 if (trim(edtPFCRM.Text)<>'') and(trim(edtNRCRM.Text)<>'') and(trim(cbUFCrM.Text)<>'')   then
   begin

      qryTMPFcerta.Close;
      qryTMPFcerta.SQL.Text := 'select * from fc04000 where pfcrm='+quotedstr(edtPFCRM.Text)+' and ufcrm='+QuotedStr(cbUFCrM.Text)+' and NRCRM='+edtNRCRM.Text;
      qryTMPFcerta.Open;

      if not(qryTMPFcerta.IsEmpty) then  edtNomeMed.Text:=qryTMPFcerta.FieldValues['NOMEMED']
       else
      edtNomeMed.Text := '';

   end else edtNomeMed.Text := '';

   qryTMPFcerta.Close;

end;

procedure TfrmDescMedQtdCMP.edtValorExit(Sender: TObject);
begin
 btIncluir.SetFocus;
end;

procedure TfrmDescMedQtdCMP.FormKeyPress(Sender: TObject; var Key: Char);
begin

 if key=#13 then
  begin
   Key := #0;
   Perform(WM_NEXTDLGCTL, 0, 0);
  end;

end;

procedure TfrmDescMedQtdCMP.FormShow(Sender: TObject);
begin

 qryGrid.Close;
 qryGrid.SQL.Text := ' select * from FORMTABELADAS2';
 qryGrid.Open;

 dbgMedicos.Columns[0].Width := 180;
 dbgMedicos.Columns[1].Width := 30;
 dbgMedicos.Columns[2].Width := 60;

 edtPFCRM.SetFocus;
end;

end.
