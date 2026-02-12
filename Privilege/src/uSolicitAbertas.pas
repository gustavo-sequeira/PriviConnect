unit uSolicitAbertas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, IBQuery, StdCtrls, Grids, DBGrids, Buttons,
  ExtCtrls, Menus;

type
  TfrmSolicitacaoesAbertas = class(TForm)
    Panel2: TPanel;
    dbgMedicos: TDBGrid;
    Panel3: TPanel;
    Label1: TLabel;
    dsGridPrivilege: TDataSource;
    qryPesqMedicos: TIBQuery;
    qrySolicitacoesPriv: TIBQuery;
    Panel4: TPanel;
    dbgCadMed: TDBGrid;
    Panel5: TPanel;
    Label2: TLabel;
    dsGridCadMedico: TDataSource;
    qrySolicitacoesCadM: TIBQuery;
    PopupMenu1: TPopupMenu;
    Negar1: TMenuItem;
    qryTmp: TIBQuery;
    procedure FormShow(Sender: TObject);
    procedure dbgMedicosDblClick(Sender: TObject);
    procedure dbgCadMedDblClick(Sender: TObject);
    procedure Negar1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSolicitacaoesAbertas: TfrmSolicitacaoesAbertas;

implementation

uses udmDescontos, uCodBarras, uConfirmCadastro, System.UITypes;

{$R *.dfm}

procedure TfrmSolicitacaoesAbertas.FormShow(Sender: TObject);
begin
 qrySolicitacoesPriv.Close;
 qrySolicitacoesPriv.SQL.Text := 'select * from solicitpriv where flagenv='+quotedstr('N');
 qrySolicitacoesPriv.Open;

 qrySolicitacoesCadM.Close;
 qrySolicitacoesCadM.SQL.Text := 'select * from solicitmed where flagconf='+quotedstr('N');
 qrySolicitacoesCadM.Open;
end;

procedure TfrmSolicitacaoesAbertas.dbgMedicosDblClick(Sender: TObject);
begin
 if not(qrySolicitacoesPriv.IsEmpty) then
  begin
   frmCodBarrasMedicos.ShowModal;
   qrySolicitacoesPriv.Close;
   qrySolicitacoesPriv.Open;
  end; 
end;

procedure TfrmSolicitacaoesAbertas.dbgCadMedDblClick(Sender: TObject);
begin
 if not(qrySolicitacoesCadM.IsEmpty) then
  begin
   frmConfirmCadastroMed.ShowModal;
   qrySolicitacoesCadM.Close;
   qrySolicitacoesCadM.Open;
   qrySolicitacoesPriv.Close;
   qrySolicitacoesPriv.Open;
  end;
end;

procedure TfrmSolicitacaoesAbertas.Negar1Click(Sender: TObject);
begin
 if not(qrySolicitacoesPriv.IsEmpty) then
 if MessageDlg('Negar solicitação para '+qrySolicitacoesPriv.FieldValues['NOMEMED']+'?',mtconfirmation,[mbYes,MbNo],0)=mryes then
  begin
    qryTmp.Close;
    qryTmp.SQL.Text := 'update solicitpriv set flagenv='+quotedstr('D')+' where PROFISSAO='+quotedstr(qrySolicitacoesPriv.FieldValues['profissao'])+' and NRCRM='+inttostr(qrySolicitacoesPriv.FieldValues['NRCRM'])+' and flagenv='+quotedstr('N');
    qryTmp.Open;
    qryTmp.Transaction.CommitRetaining;
    qrySolicitacoesPriv.Close;
    qrySolicitacoesPriv.Open;
    ShowMessage('Solicitação negada com sucesso');
  end;

end;

end.
