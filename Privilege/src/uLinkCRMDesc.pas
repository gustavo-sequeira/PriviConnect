unit uLinkCRMDesc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, IBX.IBCustomDataSet,
  IBX.IBQuery, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TfrmLinkCRM = class(TForm)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    edtPFCRM: TEdit;
    edtNRCRM: TEdit;
    edtNomeMed: TEdit;
    cbUFCrM: TComboBox;
    Panel1: TPanel;
    dbgMedicos: TDBGrid;
    Panel2: TPanel;
    btExcluir: TSpeedButton;
    btIncluir: TBitBtn;
    qryGrid: TIBQuery;
    dsGrid: TDataSource;
    qryFcertaTMP: TIBQuery;
    cbDesc: TComboBox;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtNRCRMExit(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLinkCRM: TfrmLinkCRM;

implementation

{$R *.dfm}

uses udmDescontos, System.UITypes;

procedure TfrmLinkCRM.btExcluirClick(Sender: TObject);
begin

if not(qryGrid.IsEmpty)  then
if MessageDlg('Deseja excluir configuração de link por CRM do desconto '+qryGrid.FieldValues['desconto'] +'?',mtconfirmation,[mbYes,MbNo],0)=mryes then
      begin


        qryFcertaTMP.Close;

        qryFcertaTMP.Close;
        qryFcertaTMP.SQL.Text := ' UPDATE FC99999 SET PARAMETRO2=null WHERE ARGUMENTO LIKE '+QUOTEDSTR('DESCONTO%')+' AND CDPAR='+QUOTEDSTR('63')+' AND PARAMETRO LIKE '+QUOTEDSTR(qryGrid.FieldValues['DESCONTO']+'%');
        qryFcertaTMP.Open;
        qryFcertaTMP.Transaction.CommitRetaining;
        qryFcertaTMP.Close;

        qryGrid.Close;
        qryGrid.Open;

        ShowMessage('Excluso com sucesso');

      end;


end;

procedure TfrmLinkCRM.btIncluirClick(Sender: TObject);
begin

 if (trim(edtPFCRM.Text)='') or (trim(edtNRCRM.Text)='') or  (trim(cbDesc.Text)='') or  (trim(edtNomeMed.Text)='')
  or (cbUFCrM.ItemIndex=-1) then
    raise Exception.Create('Por favor preencha todos os campos');

  qryFcertaTMP.Close;
  qryFcertaTMP.SQL.Text := 'select * from fc04000 where pfcrm='+quotedstr(edtPFCRM.Text)+' and ufcrm='+QuotedStr(cbUFCrM.Text)+' and NRCRM='+edtNRCRM.Text;
  qryFcertaTMP.Open;

  if qryFcertaTMP.IsEmpty then raise Exception.Create('Médico não encontrado no banco de dados');

  qryFcertaTMP.Close;

  qryFcertaTMP.Close;
  qryFcertaTMP.SQL.Text := ' UPDATE FC99999 SET PARAMETRO2='+edtNRCRM.Text+' WHERE ARGUMENTO LIKE '+QUOTEDSTR('DESCONTO%')+' AND CDPAR='+QUOTEDSTR('63')+' AND PARAMETRO LIKE '+QUOTEDSTR(cbDesc.Text+'%');
  qryFcertaTMP.Open;
  qryFcertaTMP.Transaction.CommitRetaining;
  qryFcertaTMP.Close;

  qryGrid.Close;
  qryGrid.Open;

  ShowMessage('Efetuado com sucesso');

  edtPFCRM.Clear;
  edtNRCRM.Clear;
  edtNomeMed.Clear;
  cbUFCrM.ItemIndex := -1;
  cbDesc.ItemIndex := -1;

end;

procedure TfrmLinkCRM.edtNRCRMExit(Sender: TObject);
begin

 if (trim(edtPFCRM.Text)<>'') and(trim(edtNRCRM.Text)<>'') and(trim(cbUFCrM.Text)<>'')   then
   begin

      qryFcertaTMP.Close;
      qryFcertaTMP.SQL.Text := 'select * from fc04000 where pfcrm='+quotedstr(edtPFCRM.Text)+' and ufcrm='+QuotedStr(cbUFCrM.Text)+' and NRCRM='+edtNRCRM.Text;
      qryFcertaTMP.Open;

      if not(qryFcertaTMP.IsEmpty) then
        edtNomeMed.Text:=qryFcertaTMP.FieldValues['NOMEMED']
          else
        edtNomeMed.Text := '';

   end else edtNomeMed.Text := '';

   qryFcertaTMP.Close;

end;

procedure TfrmLinkCRM.FormKeyPress(Sender: TObject; var Key: Char);
begin

 if key=#13 then
  begin
   Key := #0;
   Perform(WM_NEXTDLGCTL, 0, 0);
  end;

end;

procedure TfrmLinkCRM.FormShow(Sender: TObject);
begin

    qryFcertaTMP.SQL.Text := ' SELECT substring(trim(PARAMETRO) from 1 for  position ( '+quotedstr('-')+' in parametro)-1    )  as DESCRICAO '+
                              ' FROM fc99999 '+
                              ' WHERE  '+
                              ' (argumento = '+quotedstr('DESCONTOV')+'    or    argumento = '+QuotedStr('DESCONTOR')+' ) and  PARAMETRO like '+quotedstr('%-%')+' group by 1 order by 1 ';
 //   Clipboard.AsText := qryFcertaTEMP.SQL.Text;
    qryFcertaTMP.Open;

    cbDesc.Clear;
    while not qryFcertaTMP.eof do
      begin
       cbDesc.Items.Add( qryFcertaTMP.FieldValues['DESCRICAO'] );
       qryFcertaTMP.next;
      end;

    qryFcertaTMP.Close;


 qryGrid.Close;
 qryGrid.SQL.Text := ' SELECT substring(trim(PARAMETRO) from 1 for  position ( '+quotedstr('-')+' in parametro)-1    )  as DESCONTO,  PARAMETRO2 as NRCRM from FC99999 where  PARAMETRO2 is not null and ARGUMENTO like ('+ QuotedStr( 'DESCONTO%' ) +') group by 1,2 order by 1';
 qryGrid.Open;

 dbgMedicos.Columns[0].Width := 65;
 dbgMedicos.Columns[1].Width := 180;

 edtPFCRM.SetFocus;
end;

end.
