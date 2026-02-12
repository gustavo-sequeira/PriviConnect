unit uCadastroMed;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, DB, IBCustomDataSet, IBQuery,
  IdAntiFreezeBase, IdAntiFreeze, IdMessage, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP,
  IdExplicitTLSClientServerBase, IdSMTPBase;

type
  TfrmCadMedico = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    edtNomeMed: TEdit;
    GroupBox2: TGroupBox;
    edtCR: TEdit;
    GroupBox3: TGroupBox;
    cbEspecialidade: TComboBox;
    GroupBox7: TGroupBox;
    edtNomeCons: TEdit;
    edtCodCons: TEdit;
    cbUFCRM: TComboBox;
    Panel2: TPanel;
    btIncluir: TBitBtn;
    qryTemp: TIBQuery;
    edtCodEsp: TEdit;
    GroupBox12: TGroupBox;
    cbProfissao: TComboBox;
    qryInclui: TIBQuery;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    qryConsultora: TIBQuery;
    rbDois: TRadioButton;
    rbCadastro: TRadioButton;
    edtProfissao: TEdit;
    GroupBox13: TGroupBox;
    GroupBox9: TGroupBox;
    edtTel: TEdit;
    GroupBox8: TGroupBox;
    edtCidade: TEdit;
    GroupBox10: TGroupBox;
    cbUF: TComboBox;
    GroupBox6: TGroupBox;
    edtBairro: TEdit;
    GroupBox4: TGroupBox;
    edtEnd: TEdit;
    GroupBox5: TGroupBox;
    edtNr: TEdit;
    GroupBox11: TGroupBox;
    edtCompl: TEdit;
    GroupBox14: TGroupBox;
    GroupBox15: TGroupBox;
    Edit1: TEdit;
    GroupBox16: TGroupBox;
    Edit2: TEdit;
    GroupBox17: TGroupBox;
    ComboBox1: TComboBox;
    GroupBox18: TGroupBox;
    Edit3: TEdit;
    GroupBox19: TGroupBox;
    Edit4: TEdit;
    GroupBox20: TGroupBox;
    Edit5: TEdit;
    GroupBox21: TGroupBox;
    Edit6: TEdit;
    GroupBox22: TGroupBox;
    edtCEPCons: TEdit;
    procedure FormShow(Sender: TObject);
    procedure edtCRKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodConsKeyPress(Sender: TObject; var Key: Char);
    procedure edtNrKeyPress(Sender: TObject; var Key: Char);
    procedure edtTelKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btIncluirClick(Sender: TObject);
    procedure cbEspecialidadeChange(Sender: TObject);
    procedure cbProfissaoChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtNomeMedKeyPress(Sender: TObject; var Key: Char);
    procedure edtEndKeyPress(Sender: TObject; var Key: Char);
    procedure edtComplKeyPress(Sender: TObject; var Key: Char);
    procedure edtBairroKeyPress(Sender: TObject; var Key: Char);
    procedure edtCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtNomeConsKeyPress(Sender: TObject; var Key: Char);
    procedure cbProfissaoKeyPress(Sender: TObject; var Key: Char);
    procedure edtProfissaoKeyPress(Sender: TObject; var Key: Char);
    procedure cbEspecialidadeKeyPress(Sender: TObject; var Key: Char);
    procedure cbUFCRMKeyPress(Sender: TObject; var Key: Char);
    procedure cbUFKeyPress(Sender: TObject; var Key: Char);
    procedure edtNomeConsChange(Sender: TObject);
    procedure edtCodConsExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadMedico: TfrmCadMedico;

implementation

uses usolicitacao, udmDescontos, uBuscaFuncionarios, uPrincipal, System.UITypes;

{$R *.dfm}

procedure TfrmCadMedico.FormShow(Sender: TObject);
begin

  if frmSolicitacao.cbOpcaoMed.ItemIndex=1 then
    edtNomeMed.Text := frmSolicitacao.edtMedico.Text
      else
    edtCR.Text := frmSolicitacao.edtMedico.Text;

  edtNomeMed.SetFocus;

  qryTemp.Close;
  qryTemp.SQL.Text := 'select subargum as PROFISSAO, parametro as DESCRPROFISSAO from fc99999 where cdpar=14 and argumento='+quotedstr('PFCRM')+' order by 1';
  qryTemp.Open;

  cbProfissao.Clear;
  cbProfissao.Items.Add('0 - ESCOLHA PROFISSÃO');
  while not qryTemp.eof do
   begin
     cbProfissao.Items.Add(qryTemp.FieldValues['PROFISSAO']+' - '+qryTemp.FieldValues['DESCRPROFISSAO']);
     qryTemp.Next;
   end;

   qryTemp.Close;

   cbProfissao.ItemIndex:=0;
   edtProfissao.Text := 'ESCOLHA A PROFISSÃO';


  qryTemp.Close;
  qryTemp.SQL.Text := 'select parametro as ESPECIALIDADE from fc99999 where cdpar=14 and argumento='+quotedstr('ESPEC')+' order by 1';
  qryTemp.Open;

  cbEspecialidade.Clear;

  while not qryTemp.eof do
   begin
     cbEspecialidade.Items.Add(qryTemp.FieldValues['ESPECIALIDADE']);
     qryTemp.Next;
   end;

   qryTemp.Close;

   cbEspecialidade.ItemIndex:=15;
   edtCodEsp.Text := '002';

   edtCR.Clear;
   edtEnd.Clear;
   edtNr.Clear;
   edtBairro.Clear;
   edtCidade.Clear;
   edtNomeCons.Clear;
   edtCodCons.Clear;
   edtTel.Clear;
   edtCompl.Clear;
   cbUF.ItemIndex:=16;
   cbUFCRM.ItemIndex:=16;
   rbDois.Checked:=false;
   rbCadastro.Checked:=false;   

end;

procedure TfrmCadMedico.edtCRKeyPress(Sender: TObject; var Key: Char);
begin
 if not CharInSet(Key, ['0'..'9',#8,#13]) then key := #0;

   if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;
   
end;

procedure TfrmCadMedico.edtCodConsKeyPress(Sender: TObject; var Key: Char);
var codcons:string;
begin

 if not CharInSet(Key, ['0'..'9',#8,#13]) then
  begin
   if trim(edtCodCons.Text)='' then
     begin
      edtNomeCons.Text:=key;
      edtNomeCons.SetFocus;
      edtNomeCons.SelStart:=2;
     end;
  end;

   if Key =#13 then
   begin
    if trim(edtCodCons.Text)<>'' then
     begin
      qryConsultora.Close;
      qryConsultora.SQL.Text := 'select cdfun,nomefun from fc08000 where cdfun='+edtCodCons.Text+' and cdcon in (1,2,4,5,8,12,13,14,20,23,60)';
      qryConsultora.Open;
      codcons:=edtCodCons.Text;
      if not(qryConsultora.IsEmpty) then
        begin
          edtNomeCons.Text:=qryConsultora.FieldValues['nomefun'];
          edtCodCons.Text:=codcons;//pq ao receber o edtnomecons o edtcodcons vai apagar
        end
        else
          showmessage('Não existe funcionário cadastrado com esse código');

      qryConsultora.Close;

      end;

      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;


end;

procedure TfrmCadMedico.edtNrKeyPress(Sender: TObject; var Key: Char);
begin
 if not CharInSet(Key, ['0'..'9',#8,#13]) then key := #0;

  if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end; 

end;

procedure TfrmCadMedico.edtTelKeyPress(Sender: TObject; var Key: Char);
begin
 if not CharInSet(Key, ['0'..'9',#8,#13]) then key := #0;

  if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;
    
end;

procedure TfrmCadMedico.FormKeyPress(Sender: TObject; var Key: Char);
begin
{   if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;    }
end;

procedure TfrmCadMedico.btIncluirClick(Sender: TObject);
var tpCR,msg,emails:string;
    ultreg:integer;
begin

if (rbDois.Checked=false)and (rbCadastro.Checked=false) then raise exception.Create('Escolha o modo da solicitação');
if (cbProfissao.ItemIndex=0) then raise exception.Create('ESCOLHA A PROFISSÃO');

if trim(edtNomeMed.Text)=''  then raise Exception.Create('Preencha o nome');
if trim(edtCR.Text)=''       then raise Exception.Create('Preencha o CRM');
if trim(edtEnd.Text)=''      then raise Exception.Create('Preencha o endereço');
if trim(edtNr.Text)=''       then raise Exception.Create('Preencha o numero');
if trim(edtBairro.Text)=''   then raise Exception.Create('Preencha o bairro');
if trim(edtCidade.Text)=''   then raise Exception.Create('Preencha a cidade');
if trim(edtTel.Text)=''      then raise Exception.Create('Preencha o telefone');
if trim(edtNomeCons.Text)='' then raise Exception.Create('Informe o consultor');
if trim(edtCEPCons.Text)='' then raise Exception.Create('Informe o CEP');

qryConsultora.Close;
qryConsultora.SQL.Text := 'select cdfun,nomefun from fc08000 where cdfun='+edtCodCons.Text+' and cdcon in (1,2,4,5,8,12,13,14,20,23,60)';
qryConsultora.Open;

if qryConsultora.IsEmpty then raise Exception.Create('Consultora inválida, informe código');

//--------------VERIFICA SE Já EXISTE CADASTRO---------------------------//
  case cbProfissao.ItemIndex of
    1:tpCR:='CRM';
    2:tpCR:='CRO';
    3:tpCR:='CRMV';
    4:tpCR:='CRM';
    5:tpCR:='CRP';
    6:tpCR:='CRF';
    7:tpCR:='CRM';
    8:tpCR:='CRM';
    9:tpCR:='CRN';
   10:tpCR:='CRM';
  end;

  qryTemp.Close;
  qryTemp.SQL.Text := 'select * from fc04000 where PFCRM='+quotedstr(cbProfissao.Text[1])+' and UFCRM='+quotedstr(cbUFCRM.Text)+' and NRCRM='+edtCR.Text;
  qryTemp.Open;

  if not (qryTemp.IsEmpty) then  Raise Exception.Create('ERRO! '+tpCR+' já cadastrado. Designado no sistema para o profissional :'+#13+'   '+qryTemp.FieldValues['nomemed'] );

  qryInclui.Close;
  qryInclui.SQL.Text:='select * from solicitmed where CODPF='+quotedstr(cbProfissao.Text[1])+' and UFCRM='+quotedstr(cbUFCRM.Text)+' and NRCRM='+edtCR.Text;
  qryInclui.Open;

  if not (qryInclui.IsEmpty) then  Raise Exception.Create('ERRO! Solicitação para '+tpCR+' já cadastrada no dia '+FormatDateTime('dd/mm/yyyy',qryInclui.FieldValues['dtsolic'])+' por:'+#13+'         '+qryInclui.FieldValues['nomecons']);

//--------------VERIFICA SE Já EXISTE CADASTRO---------------------------//

//--------------------COMEÇA A INCLUSÃO---------------------------------//

  qryInclui.Close;
  qryInclui.SQL.Text:='select first 1 codreg+1 as valoratual from solicitmed order by 1 desc';
  qryInclui.Open;
  if qryInclui.IsEmpty then
   ultreg:=0
    else
  ultreg:=qryInclui.FieldValues['valoratual'];


  qryInclui.Close;
  qryInclui.SQL.Text := 'INSERT INTO SOLICITMED (NOMEMED,UFCRM,NRCRM,CODESP,ESPECIALIDADE,ENDERECO,NREND,COMPLEMENTO,BAIRRO,UF,CIDADE,TELEFONE,NRCONS,NOMECONS,CODPF,PROFISSAO,FLAGCONF,CODREG,DTSOLIC,CDFILSOLIC,NRCEP) values ('+
   quotedstr(edtNomeMed.Text)+','+quotedstr(cbUFCRM.Text)+','+edtCR.Text+','+quotedstr(edtCodEsp.Text)+','+quotedstr(cbEspecialidade.Text)+','+quotedstr(edtEnd.Text)+','+quotedstr(edtNr.Text)+','+quotedstr(edtCompl.Text)+','+quotedstr(edtBairro.Text)+','+quotedstr(cbUF.Text)+','+quotedstr(edtCidade.Text)+','+quotedstr(edtTel.Text)+','+quotedstr(edtCodCons.Text)+','+quotedstr(edtNomeCons.Text)+','+quotedstr(cbProfissao.Text[1])+','+quotedstr(edtProfissao.Text)+','+quotedstr('N')+','+inttostr(ultreg)+','+quotedstr(FormatDateTime('dd.mm.yyyy',now))+','+frmPrincipal.edtLoja.text+','+quotedstr(edtCEPCons.Text)+')';

  qryInclui.Open;
  qryInclui.Transaction.CommitRetaining;


  if rbDois.Checked=true then
   begin

      qryInclui.Close;
      qryInclui.SQL.Text := 'INSERT INTO SOLICITPRIV (NOMEMED,UFCRM,NRCRM,CODESP,ESPECIALIDADE,CODPF,PROFISSAO,FLAGENV,CODREG,DTSOLIC,CDFILSOLIC,TPCART) values ('+
         quotedstr(edtNomeMed.Text)+','+quotedstr(cbUFCRM.Text)+','+edtCR.Text+','+quotedstr(edtCodEsp.Text)+','+quotedstr(cbEspecialidade.Text)+','+quotedstr(cbProfissao.Text[1])+','+quotedstr(edtProfissao.Text)+','+quotedstr('N')+','+inttostr(ultreg)+','+quotedstr(FormatDateTime('dd.mm.yyyy',now))+','+frmPrincipal.edtLoja.text+',0)';

      qryInclui.Open;
      qryInclui.Transaction.CommitRetaining;

   end;

  qryInclui.Close;



         qryInclui.Close;
         qryInclui.SQL.Text:='select EMAIL from EMAILSALERT';
         qryInclui.Open;
         emails:='';
         if not(qryInclui.IsEmpty) then
           begin
              qryInclui.First;
             while not qryInclui.Eof do
               begin
                emails:=emails+qryInclui.FieldValues['email']+';';
                qryInclui.Next;
               end;

  if rbDois.Checked=true then
   msg:='Um cadastro médico e cartão foi solicitado para o profissional '+edtNomeMed.Text+' através do Privilege Pharmapele '
    else
   msg:='Um cadastro médico foi solicitado para o profissional '+edtNomeMed.Text+' através do Privilege Pharmapele ';


              //Enviando a mensagem
              Try
              //Conencta se ao host
              IdSMTP1.Connect;// Timeout 10000

              //e-mail do remetente
              IdMessage1.From.Name:='Privilege';
              //Assunto
              IdMessage1.Subject:='Solicitação cadastro médico';
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





  ShowMessage('Solicitação de cadastro médico e cartão privilege incluso com sucesso!');

  frmCadMedico.Close;

//--------------------TERMINA INCLUSÃO---------------------------------//



end;

procedure TfrmCadMedico.cbEspecialidadeChange(Sender: TObject);
begin

  qryTemp.Close;
  qryTemp.SQL.Text := 'select subargum as CODESP from fc99999 where cdpar=14 and argumento='+quotedstr('ESPEC')+' and parametro='+quotedstr(cbEspecialidade.Text)+' order by 1';
  qryTemp.Open;

  edtCodEsp.Text:=qryTemp.FieldValues['codesp'];

  qryTemp.Close;

end;

procedure TfrmCadMedico.cbProfissaoChange(Sender: TObject);
begin

if cbProfissao.ItemIndex=0 then edtProfissao.Text := 'ESCOLHA A PROFISSÃO'
 else
  begin
      qryTemp.Close;
      qryTemp.SQL.Text := 'select PARAMETRO as PROFISSAO from fc99999 where cdpar=14 and argumento='+quotedstr('PFCRM')+' and subargum='+quotedstr(cbProfissao.Text[1])+' order by 1';
      qryTemp.Open;

      edtProfissao.Text:=qryTemp.FieldValues['profissao'];

      qryTemp.Close;
  end;


end;

procedure TfrmCadMedico.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if (Key = VK_TAB) and ((trim(edtCodCons.Text)<>'') or (trim(edtNomeCons.Text)<>'')  ) then
    begin
      qryConsultora.Close;
      if trim(edtCodCons.Text)<>'' then
         qryConsultora.SQL.Text := 'select cdfun,nomefun from fc08000 where fc08000.cdfun like '+QuotedStr(edtCodCons.Text+'%')+' and cdcon in (1,2,4,5,8,12,13,14,20,23,60) group by 1,2'
           else
         qryConsultora.SQL.Text := 'select cdfun,nomefun from fc08000 where fc08000.nomefun like '+QuotedStr(edtNomeCons.Text+'%')+' and cdcon in (1,2,4,5,8,12,13,14,20,23,60) group by 1,2';

      qryConsultora.Open;
      qryConsultora.First;

      if qryConsultora.IsEmpty then
        begin
          if trim(edtCR.Text)<>'' then
            ShowMessage('Nenhum funcionário cadastrado com esse código')
            else
              ShowMessage('Nenhum funcionário cadastrado com esse nome');
        end else  frmBuscaFuncionarios.ShowModal;

      edtNomeMed.SetFocus;
    end;

end;

procedure TfrmCadMedico.edtNomeMedKeyPress(Sender: TObject; var Key: Char);
begin
  if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;
end;

procedure TfrmCadMedico.edtEndKeyPress(Sender: TObject; var Key: Char);
begin
  if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;
end;

procedure TfrmCadMedico.edtComplKeyPress(Sender: TObject; var Key: Char);
begin
  if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;
end;

procedure TfrmCadMedico.edtBairroKeyPress(Sender: TObject; var Key: Char);
begin
  if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;
end;

procedure TfrmCadMedico.edtCidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;
end;

procedure TfrmCadMedico.edtNomeConsKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;
end;

procedure TfrmCadMedico.cbProfissaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;
end;

procedure TfrmCadMedico.edtProfissaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;
end;

procedure TfrmCadMedico.cbEspecialidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;
end;

procedure TfrmCadMedico.cbUFCRMKeyPress(Sender: TObject; var Key: Char);
begin
  if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;
end;

procedure TfrmCadMedico.cbUFKeyPress(Sender: TObject; var Key: Char);
begin
  if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;
end;

procedure TfrmCadMedico.edtNomeConsChange(Sender: TObject);
begin
 edtCodCons.Text:='';
end;

procedure TfrmCadMedico.edtCodConsExit(Sender: TObject);
var codcons:string;
begin

    if trim(edtCodCons.Text)<>'' then
     begin
        qryConsultora.Close;
        qryConsultora.SQL.Text := 'select cdfun,nomefun from fc08000 where cdfun='+edtCodCons.Text+' and cdcon in (1,2,4,5,8,12,13,14,20,23,60)';
        qryConsultora.Open;
        codcons:=edtCodCons.Text;
        if not(qryConsultora.IsEmpty) then
          begin
            edtNomeCons.Text:=qryConsultora.FieldValues['nomefun'];
            edtCodCons.Text:=codcons;//pq ao receber o edtnomecons o edtcodcons vai apagar
          end
          else
            begin
              showmessage('Não existe funcionário cadastrado com esse código');
              edtCodCons.SetFocus;
            end;
        qryConsultora.Close;
     end;
     
end;

end.
