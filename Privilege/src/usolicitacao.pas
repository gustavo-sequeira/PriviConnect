unit usolicitacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, DB, 
  IBCustomDataSet, IBQuery, IdMessage, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP, IdAntiFreezeBase,
  IdAntiFreeze, IdExplicitTLSClientServerBase, IdSMTPBase;

type
  TfrmSolicitacao = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    dbgMedicos: TDBGrid;
    GroupBox1: TGroupBox;
    btOk: TBitBtn;
    edtMedico: TEdit;
    cbUF: TComboBox;
    cbOpcaoMed: TComboBox;
    dsGrid: TDataSource;
    Panel3: TPanel;
    Label1: TLabel;
    qryPesqMedicos: TIBQuery;
    qrySolicitacoes: TIBQuery;
    cbProfissao: TComboBox;
    qryTemp: TIBQuery;
    qryTempPriv: TIBQuery;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    IdAntiFreeze1: TIdAntiFreeze;
    procedure edtMedicoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btOkClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSolicitacao: TfrmSolicitacao;
  stringanterior:string;

implementation

uses udmDescontos, uBuscaMedicos, uCadastroMed, uPrincipal, System.UITypes;

{$R *.dfm}

procedure TfrmSolicitacao.edtMedicoChange(Sender: TObject);
var flagtipo,i:Smallint;
begin

if edtMedico.Text<>'' then
    begin
      if (edtMedico.Text[1]='0') or
          (edtMedico.Text[1]='1') or
           (edtMedico.Text[1]='2') or
            (edtMedico.Text[1]='3') or
             (edtMedico.Text[1]='4') or
              (edtMedico.Text[1]='5') or
               (edtMedico.Text[1]='6') or
                (edtMedico.Text[1]='7') or
                 (edtMedico.Text[1]='8') or
                  (edtMedico.Text[1]='9') then
             flagtipo:=1
          else
             flagtipo:=2;

         for i:=2 to length(edtMedico.text) do
          begin
             if (flagtipo=1) and (edtMedico.Text[i]<>'0') and (edtMedico.Text[i]<>'1') and (edtMedico.Text[i]<>'2') and (edtMedico.Text[i]<>'3') and (edtMedico.Text[i]<>'4') and (edtMedico.Text[i]<>'5') and (edtMedico.Text[i]<>'6') and (edtMedico.Text[i]<>'7') and (edtMedico.Text[i]<>'8') and (edtMedico.Text[i]<>'9') then
               begin
                showmessage('SÓ NÚMEROS SÃO VÁLIDOS');
                edtMedico.Text:=stringanterior;
               end;
          end;
          case flagtipo of
          1: cbOpcaoMed.ItemIndex:=0;
          2: cbOpcaoMed.ItemIndex:=1;
          end;
          stringanterior:=edtMedico.Text;
    end;
end;

procedure TfrmSolicitacao.FormShow(Sender: TObject);
begin

 edtMedico.Clear;
 cbUF.ItemIndex:=16;
 cbOpcaoMed.ItemIndex:=0;
 edtMedico.SetFocus;
 qrySolicitacoes.Close;
 qrySolicitacoes.SQL.Text := 'select nomemed,nrcrm,especialidade,profissao from solicitpriv where flagenv='+quotedstr('N');
 qrySolicitacoes.Open;

 qryTemp.Close;
 qryTemp.SQL.Text := 'select subargum,parametro from fc99999 where cdpar=14 and argumento='+quotedstr('PFCRM')+' order by 1';
 qryTemp.Open;
 cbProfissao.Clear;

 while not qryTemp.eof do
  begin
   cbProfissao.Items.Add(trim(qryTemp.FieldValues['subargum'])+' - '+qryTemp.FieldValues['parametro']);
   qryTemp.Next;
  end;

 qryTemp.Close;
 cbProfissao.ItemIndex:=0;

end;

procedure TfrmSolicitacao.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin



  if Key = VK_TAB then
    begin

      qryPesqMedicos.Close;

      if cbOpcaoMed.ItemIndex=0 then
         qryPesqMedicos.SQL.Text := 'select * from fc04000 where fc04000.nrcrm like '+QuotedStr(edtMedico.Text+'%')+' and pfcrm='+quotedstr(trim(copy(cbProfissao.Text,1,2)))+' and ufcrm='+QuotedStr(cbUF.Text)
           else
         qryPesqMedicos.SQL.Text := 'select * from fc04000 where fc04000.nomemed like '+QuotedStr(edtMedico.Text+'%')+' and pfcrm='+quotedstr(trim(copy(cbProfissao.Text,1,2)))+' and ufcrm='+QuotedStr(cbUF.Text);

      qryPesqMedicos.Open;
      qryPesqMedicos.First;

      if qryPesqMedicos.IsEmpty then
        begin
          if cbOpcaoMed.ItemIndex=0 then
            ShowMessage('Nenhum médico cadastrado com esse CRM')
            else
              ShowMessage('Nenhum médico cadastrado com esse nome');
        end else  frmBuscaMedicos.ShowModal;

      edtMedico.SetFocus;

    end;

end;

procedure TfrmSolicitacao.btOkClick(Sender: TObject);
var nomemed,msg,emails:string;
begin

 if trim(edtMedico.Text)='' then
  begin
   edtMedico.SetFocus;
   raise Exception.Create('Preencha os campos corretamente.');
  end;

  qryPesqMedicos.Close;

  if cbOpcaoMed.ItemIndex=0 then
     qryPesqMedicos.SQL.Text := 'select * from fc04000 where fc04000.nrcrm = '+edtMedico.Text+' and pfcrm='+quotedstr(trim(copy(cbProfissao.Text,1,2)))+' and ufcrm='+QuotedStr(cbUF.Text)
       else
     qryPesqMedicos.SQL.Text := 'select * from fc04000 where fc04000.nomemed ='+QuotedStr(edtMedico.Text)+' and pfcrm='+quotedstr(trim(copy(cbProfissao.Text,1,2)))+' and ufcrm='+QuotedStr(cbUF.Text);

  qryPesqMedicos.Open;
  qryPesqMedicos.First;

  if qryPesqMedicos.IsEmpty then
    begin
      if Application.MessageBox('Médico não está cadastrado no sistema. Deseja solicitar cadastro?', 'Confirmação', mb_iconQuestion + mb_YesNo + mb_DefButton2) = mrYes then
       begin
         frmCadMedico.ShowModal;
         qrySolicitacoes.Close;
         qrySolicitacoes.Open;
       end;
    end else
     begin
       nomemed:='Deseja solicitar cartão privilege para o profissional : '+qryPesqMedicos.FieldValues['nomemed']+' ?';
      if Application.MessageBox(pchar(nomemed), 'Confirmação', mb_iconQuestion + mb_YesNo + mb_DefButton2) = mrYes then
       begin

         qryTempPriv.Close;
         qryTempPriv.SQL.Text := ' select * from solicitpriv where codpf='+quotedstr(trim(copy(cbProfissao.Text,1,2)))+' and ufcrm='+quotedstr(cbUF.Text)+' and nrcrm='+inttostr(qryPesqMedicos.FieldValues['nrcrm']);
         qryTempPriv.Open;

         if not(qryTempPriv.IsEmpty) then Raise Exception.Create('ERRO! O cartão para esse profissional já foi solicitado');

         qryTemp.Close;
         qryTemp.SQL.Text:=' select cdesp,parametro from fc04300,fc99999 where cdesp=fc99999.subargum and fc99999.cdpar=14 and argumento='+quotedstr('ESPEC')+
                                ' and pfcrm='+quotedstr(trim(copy(cbProfissao.Text,1,2)))+' and ufcrm='+quotedstr(cbUF.Text)+' and nrcrm='+inttostr(qryPesqMedicos.FieldValues['nrcrm']);
         qryTemp.Open;

         if qryTemp.IsEmpty then Raise Exception.Create('ERRO! Médico cadastrado sem especialidade');

         qryTempPriv.Close;
         qryTempPriv.SQL.Text := 'INSERT INTO SOLICITPRIV (NOMEMED,UFCRM,NRCRM,CODESP,ESPECIALIDADE,CODPF,PROFISSAO,FLAGENV,DTSOLIC,CDFILSOLIC,TPCART) values ('+
         quotedstr(qryPesqMedicos.FieldValues['nomemed'])+','+quotedstr(cbUF.Text)+','+inttostr(qryPesqMedicos.FieldValues['nrcrm'])+','+quotedstr(qryTemp.FieldValues['cdesp'])+','+quotedstr(qryTemp.FieldValues['parametro'])+','+quotedstr(trim(copy(cbProfissao.Text,1,2)))+','+quotedstr(trim(copy(cbProfissao.Text,4,length(cbProfissao.Text))))+','+quotedstr('N')+','+quotedstr(FormatDateTime('dd.mm.yyyy',now))+','+frmPrincipal.edtLoja.text+',0'+')';

         qryTempPriv.Open;
         qryTempPriv.Transaction.CommitRetaining;
         qryTempPriv.Close;
         qryTemp.Close;

         qryTempPriv.Close;
         qryTempPriv.SQL.Text:='select EMAIL from EMAILSALERT';
         qryTempPriv.Open;
         emails:='';
         if not(qryTempPriv.IsEmpty) then
           begin
              qryTempPriv.First;
             while not qryTempPriv.Eof do
               begin
                emails:=emails+qryTempPriv.FieldValues['email']+';';
                qryTempPriv.Next;
               end;

              msg:='Um cartão foi solicitado para o profissional '+qryPesqMedicos.FieldValues['nomemed']+' no Privilege Pharmapele ';



              //Enviando a mensagem
              Try
              //Conencta se ao host
              IdSMTP1.Connect;// Timeout 10000

              //e-mail do remetente
              IdMessage1.From.Name:='Privilege';
              //Assunto
              IdMessage1.Subject:='Solicitação Cartão Privilege';
              //Body da mensagem
              IdMessage1.Body.SetText(pchar(msg));
              //E-mail para onde a mensagem será enviada
              IdMessage1.Recipients.EMailAddresses := emails;
              //envia a mensagem
              IdSMTP1.Send(IdMessage1);
              finally
              //Desconnecta do host
              IdSMTP1.Disconnect;
              end;
              //confirma o envio
              MessageDlg('Mensagem enviada para o administrador do privilege com sucesso!',mtConfirmation,[mbOK],0);

           end;

         qryTempPriv.Close;
         qrySolicitacoes.Close;
         qrySolicitacoes.Open;
       end;
     end;
  qryPesqMedicos.Close;
end;

procedure TfrmSolicitacao.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;
end;

end.
