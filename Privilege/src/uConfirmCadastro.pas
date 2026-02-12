unit uConfirmCadastro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, IBQuery, StdCtrls, Buttons, ExtCtrls;

type
  TfrmConfirmCadastroMed = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    edtNomeMed: TEdit;
    GroupBox2: TGroupBox;
    edtCR: TEdit;
    cbUFCRM: TComboBox;
    GroupBox3: TGroupBox;
    cbEspecialidade: TComboBox;
    edtCodEsp: TEdit;
    GroupBox4: TGroupBox;
    edtEnd: TEdit;
    GroupBox5: TGroupBox;
    edtNr: TEdit;
    GroupBox6: TGroupBox;
    edtBairro: TEdit;
    GroupBox8: TGroupBox;
    edtCidade: TEdit;
    GroupBox9: TGroupBox;
    edtTel: TEdit;
    GroupBox10: TGroupBox;
    cbUF: TComboBox;
    GroupBox11: TGroupBox;
    edtCompl: TEdit;
    GroupBox12: TGroupBox;
    cbProfissao: TComboBox;
    edtProfissao: TEdit;
    Panel2: TPanel;
    btAlterar: TBitBtn;
    qryTempFcerta: TIBQuery;
    qryInclui: TIBQuery;
    btConfirmar: TBitBtn;
    btNegar: TBitBtn;
    qryTempPrivilege: TIBQuery;
    GroupBox7: TGroupBox;
    edtCEP: TEdit;
    procedure FormShow(Sender: TObject);
    procedure cbProfissaoChange(Sender: TObject);
    procedure cbEspecialidadeChange(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure btNegarClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfirmCadastroMed: TfrmConfirmCadastroMed;
  cod,codreg:integer;

implementation

uses uSolicitAbertas, udmDescontos;

{$R *.dfm}

procedure TfrmConfirmCadastroMed.FormShow(Sender: TObject);
var i:integer;
begin
codreg:=0;
 if frmSolicitacaoesAbertas.Visible then
   begin
     with frmSolicitacaoesAbertas.qrySolicitacoesCadM do
      begin
        edtCR.Text:=inttostr(FieldValues['nrcrm']);
        cbProfissao.Text:=FieldValues['codPF'];
        edtProfissao.Text:=FieldValues['profissao'];
        cbUFCRM.Text:=FieldValues['ufcrm'];
        edtNomeMed.Text :=FieldValues['nomemed'];
        edtCodEsp.Text :=FieldValues['codesp'];
        cbEspecialidade.Text :=FieldValues['especialidade'];
        edtEnd.Text :=FieldValues['endereco'];
        edtNr.Text :=inttostr(FieldValues['nrend']);
        edtCompl.Text :=FieldValues['complemento'];
        edtBairro.Text :=FieldValues['bairro'];
        edtCidade.Text :=FieldValues['cidade'];
        edtTel.Text :=FieldValues['telefone'];
        edtCEP.Text :=FieldValues['NRCEP'];
        cbUF.Text :=FieldValues['uf'];
        cod:= FieldValues['cod'];
        if FieldValues['codreg']<>Null then codreg:=FieldValues['codreg'];

      qryTempFcerta.Close;
      qryTempFcerta.SQL.Text := 'select parametro as ESPECIALIDADE from fc99999 where cdpar=14 and argumento='+quotedstr('ESPEC')+' order by 1';
      qryTempFcerta.Open;

      cbEspecialidade.Clear;

      while not qryTempFcerta.eof do
       begin
         cbEspecialidade.Items.Add(qryTempFcerta.FieldValues['ESPECIALIDADE']);
         qryTempFcerta.Next;
       end;

       qryTempFcerta.Close;


       for i:=0 to cbEspecialidade.Items.Count do
          begin
            cbEspecialidade.ItemIndex:=i;
            if cbEspecialidade.Text=FieldValues['especialidade'] then break;
           end;

       for i:=0 to cbUFCRM.Items.Count do
          begin
            cbUFCRM.ItemIndex:=i;
            if cbUFCRM.Text=FieldValues['ufcrm'] then break;
           end;

       for i:=0 to cbUF.Items.Count do
          begin
            cbUF.ItemIndex:=i;
            if cbUF.Text=FieldValues['uf'] then break;
           end;


       for i:=0 to cbProfissao.Items.Count do
          begin
            cbProfissao.ItemIndex:=i;
            if cbProfissao.Text=FieldValues['codpf'] then break;
           end;

      end;


   end;




end;

procedure TfrmConfirmCadastroMed.cbProfissaoChange(Sender: TObject);
begin
  qryTempFcerta.Close;
  qryTempFcerta.SQL.Text := 'select PARAMETRO as PROFISSAO from fc99999 where cdpar=14 and argumento='+quotedstr('PFCRM')+' and subargum='+quotedstr(cbProfissao.Text)+' order by 1';
  qryTempFcerta.Open;

  edtProfissao.Text:=qryTempFcerta.FieldValues['profissao'];

  qryTempFcerta.Close;
end;

procedure TfrmConfirmCadastroMed.cbEspecialidadeChange(Sender: TObject);
begin
  qryTempFcerta.Close;
  qryTempFcerta.SQL.Text := 'select subargum as CODESP from fc99999 where cdpar=14 and argumento='+quotedstr('ESPEC')+' and parametro='+quotedstr(cbEspecialidade.Text)+' order by 1';
  qryTempFcerta.Open;

  edtCodEsp.Text:=qryTempFcerta.FieldValues['codesp'];

  qryTempFcerta.Close;
end;

procedure TfrmConfirmCadastroMed.btAlterarClick(Sender: TObject);
begin

    with frmSolicitacaoesAbertas.qrySolicitacoesCadM do
     begin
       qryTempPrivilege.Close;
       qryTempPrivilege.SQL.Text:='update solicitmed set  codpf='+cbProfissao.Text+', profissao='+quotedstr(edtProfissao.Text)+', nomemed='+quotedstr(edtNomeMed.Text)+',ufcrm='+QuotedStr(cbUFCRM.Text)+',nrcrm='+edtCR.Text+',codesp='+quotedstr(edtCodEsp.Text)+',especialidade='+quotedstr(cbEspecialidade.Text)+',endereco='+QuotedStr(edtEnd.Text)+',nrend='+edtNr.Text+',complemento='+QuotedStr(edtCompl.Text)+',bairro='+quotedstr(edtBairro.Text)+',cidade='+quotedstr(edtCidade.Text)+',uf='+quotedstr(cbUF.Text)+',telefone='+quotedstr(edtTel.Text)+' where cod='+inttostr(cod);
       qryTempPrivilege.Open;
       qryTempPrivilege.Transaction.CommitRetaining;

       qryTempPrivilege.Close;
       qryTempPrivilege.SQL.Text:='update solicitpriv set  codpf='+cbProfissao.Text+', profissao='+quotedstr(edtProfissao.Text)+', nomemed='+quotedstr(edtNomeMed.Text)+',ufcrm='+QuotedStr(cbUFCRM.Text)+',nrcrm='+edtCR.Text+',codesp='+quotedstr(edtCodEsp.Text)+',especialidade='+quotedstr(cbEspecialidade.Text)+' where codreg='+inttostr(codreg);
       qryTempPrivilege.Open;
       qryTempPrivilege.Transaction.CommitRetaining;

       qryTempPrivilege.Close;

       showmessage('Informações alteradas com sucesso!');

     end;

end;

procedure TfrmConfirmCadastroMed.btNegarClick(Sender: TObject);
begin

if Application.MessageBox('Deseja excluir solicitação de cadastro médico?', 'Confirmação', mb_iconQuestion + mb_YesNo + mb_DefButton2) = mrYes then
 begin
   qryTempPrivilege.Close;
   qryTempPrivilege.SQL.Text:='update solicitmed set flagconf='+quotedstr('D')+',dtalt='+quotedstr(FormatDateTime('dd.mm.yyyy',now))+',hralt='+quotedstr(FormatDateTime('hh:nn:ss',now))+',usualt='+quotedstr(usu)+' where cod='+inttostr(cod);
   qryTempPrivilege.Open;
   qryTempPrivilege.Transaction.CommitRetaining;

   qryTempPrivilege.Close;

   showmessage('Solicitação exclusa da lista!');
   frmConfirmCadastroMed.Close;
 end;

end;

procedure TfrmConfirmCadastroMed.btConfirmarClick(Sender: TObject);
begin

   qryTempFcerta.Close;
   qryTempFcerta.SQL.Text:=' select * from fc04000 where PFCRM='+quotedstr(cbProfissao.Text)+' and UFCRM='+QuotedStr(cbUFCRM.Text)+' and NRCRM='+edtCR.Text;
   qryTempFcerta.Open;

   if not(qryTempFcerta.IsEmpty) then Raise Exception.Create('ERRO! CR já cadastrado. Designado no sistema para o profissional :'+#13+'   '+qryTempFcerta.FieldValues['nomemed'] );

if Application.MessageBox('Deseja incluir cadastro médico no Formula Certa?', 'Confirmação', mb_iconQuestion + mb_YesNo + mb_DefButton2) = mrYes then
 begin
   qryTempFcerta.Close;
   qryTempFcerta.SQL.Text:=' insert into fc04000 (PFCRM,UFCRM,NRCRM,NOMEMED) values ('+
                             quotedstr(cbProfissao.Text)+','+quotedstr(cbUFCRM.Text)+','+edtCR.Text+','+quotedstr(edtNomeMed.Text)+')';
   qryTempFcerta.Open;
   qryTempFcerta.Transaction.CommitRetaining;

   qryTempFcerta.Close;
   qryTempFcerta.sql.Text:=' insert into fc04400 (PFCRM,UFCRM,NRCRM,OCENDER,ENDER,ENDNR,ENDCP,BAIRR,MUNIC,UNFED,NRTEL,NRCEP) values ('+
                             quotedstr(cbProfissao.Text)+','+quotedstr(cbUFCRM.Text)+','+edtCR.Text+','+QuotedStr('1')+','+quotedstr(edtEnd.Text)+','+edtNr.Text+','+quotedstr(edtCompl.Text)+','+quotedstr(edtBairro.Text)+','+quotedstr(edtCidade.Text)+','+quotedstr(cbUF.Text)+','+quotedstr(edtTel.Text)+','+quotedstr(edtCEP.Text)+')';
   qryTempFcerta.Open;
   qryTempFcerta.Transaction.CommitRetaining;

   qryTempFcerta.Close;
   qryTempFcerta.sql.Text:=' insert into fc04300 (PFCRM,UFCRM,NRCRM,CDESP,ITEMID) values ('+
                             quotedstr(cbProfissao.Text)+','+quotedstr(cbUFCRM.Text)+','+edtCR.Text+','+QuotedStr(edtCodEsp.text)+',1'+')';
   qryTempFcerta.Open;
   qryTempFcerta.Transaction.CommitRetaining;

   qryTempFcerta.Close;

   qryTempPrivilege.Close;
   qryTempPrivilege.sql.Text:=' update solicitmed set flagconf='+quotedstr('S')+',dtalt='+quotedstr(FormatDateTime('dd.mm.yyyy',now))+',hralt='+quotedstr(FormatDateTime('hh:nn:ss',now))+',usualt='+quotedstr(usu)+' where cod='+inttostr(cod);
   qryTempPrivilege.Open;
   qryTempPrivilege.Transaction.CommitRetaining;

   qryTempPrivilege.Close;

   ShowMessage('Cadastro efetuado com sucesso!');
   frmConfirmCadastroMed.Close;

 end;


end;

end.
