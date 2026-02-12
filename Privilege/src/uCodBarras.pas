unit uCodBarras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, frxBarCode,
  Dialogs, StdCtrls, Buttons, DB, IBCustomDataSet, IBQuery, ExtCtrls, strutils,
  Grids, DBGrids, frxClass;

type
  TfrmCodBarrasMedicos = class(TForm)
    qryCodBMedicos: TIBQuery;
    Panel1: TPanel;
    edtFuncionario: TEdit;
    btImprimir: TBitBtn;
    gbCRM: TGroupBox;
    edtCRM: TEdit;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    cbUF: TComboBox;
    GroupBox12: TGroupBox;
    cbProfissao: TComboBox;
    edtProfissao: TEdit;
    qryTemp: TIBQuery;
    qryUpPrivilege: TIBQuery;
    frxEtqMedico: TfrxReport;
    IBQuery1: TIBQuery;
    chkPeeling: TCheckBox;
    procedure edtCRMKeyPress(Sender: TObject; var Key: Char);
    procedure btImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtFuncionarioChange(Sender: TObject);
    procedure edtCRMChange(Sender: TObject);
    procedure edtFuncionarioKeyPress(Sender: TObject; var Key: Char);
    procedure edtFuncionarioKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCRMKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btImprimirKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function codestado2(estado:string):string;
    procedure cbProfissaoChange(Sender: TObject);
    procedure cbUFChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCodBarrasMedicos: TfrmCodBarrasMedicos;
  mat,especialidade,codesp:string;
  cod2:integer;

implementation

uses udmDescontos, uBuscaFuncionario, uSolicitAbertas;

{$R *.dfm}


function TfrmCodBarrasMedicos.codestado2(estado:string):string;
begin

case AnsiIndexStr(estado, ['MT','AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SP','SE','TO']) of

  0:result:='00';
  1:result:='01';
  2:result:='02';
  3:result:='03';
  4:result:='04';
  5:result:='05';
  6:result:='06';
  7:result:='07';
  8:result:='08';
  9:result:='09';
  10:result:='10';
  11:result:='11';
  12:result:='12';
  13:result:='13';
  14:result:='14';
  15:result:='15';
  16:result:='16';
  17:result:='17';
  18:result:='18';
  19:result:='19';
  20:result:='20';
  21:result:='21';
  22:result:='22';
  23:result:='23';
  24:result:='24';
  25:result:='25';
end;
end;

procedure TfrmCodBarrasMedicos.edtCRMKeyPress(Sender: TObject;
  var Key: Char);
  VAR NRCRM:INTEGER;
begin

 if not CharInSet(Key, ['0'..'9',#8,#13]) then
   begin
     edtCRM.Clear;
     edtCRM.Color := clScrollBar;
     edtFuncionario.Color := clWindow;
     edtFuncionario.Text := edtFuncionario.Text+Key ;
     edtFuncionario.SetFocus;
     edtFuncionario.SelStart := length(edtFuncionario.text);
     key := #0;

   end;


 if  CharInSet(Key, [#13]) then
  begin
           qryCodBMedicos.Close;
           qryCodBMedicos.Transaction.CommitRetaining;
           qryCodBMedicos.SQL.Text := 'select * from fc04000 where nrcrm='+trim(edtCRM.Text)+' and UFCRM='+quotedstr(cbUF.Text)+' and PFCRM='+quotedstr(cbProfissao.Text);
           qryCodBMedicos.Open;

          if (qryCodBMedicos.IsEmpty) and (trim(edtCRM.Text)<>'' ) then
             ShowMessage('Nenhum médico encontrado com esses filtros')
               else
                 begin

                   NRCRM := qryCodBMedicos.FieldValues['NRCRM'] ;
                   if chkPeeling.Checked then
                     mat := '10'+codestado2(UpperCase(trim(qryCodBMedicos.FieldValues['UFCRM'])))+'0'+qryCodBMedicos.FieldValues['PFCRM']+Format('%.6d', [NRCRM])
                        else
                     mat := '00'+codestado2(UpperCase(trim(qryCodBMedicos.FieldValues['UFCRM'])))+'0'+qryCodBMedicos.FieldValues['PFCRM']+Format('%.6d', [NRCRM]);
                   edtFuncionario.Text :=qryCodBMedicos.FieldValues['nomemed'];
                   btImprimir.SetFocus;
                 end;
  end;

end;

procedure TfrmCodBarrasMedicos.btImprimirClick(Sender: TObject);
var codbarras,funcionario,proxcar,jafez,nomemedico:string;
    datacri:tdate;
    Memo1: TfrxMemoView;

Function EAN13( CodigoDeBarras : String ) : String;
var nX    : Integer;
 nPeso  : Integer;
   nSoma  : Double;
   nMaior  : Double;
   nDigito : Integer;
 Begin
     nPeso := 3;
     nSoma := 0;
    For nX := 12 DownTo 1 do
      Begin
       nSoma := nSoma + StrToFloat( CodigoDeBarras[ nX ] ) * nPeso;
       If nPeso = 3 Then nPeso := 1
      Else
       nPeso := 3;
 End;
   nMaior      := ( ( Trunc( nSoma / 10 ) + 1 ) * 10 );
   nDigito  := Trunc( nMaior ) - Trunc( nSoma );
   If nDigito = 10 Then nDigito := 0;
   Result := IntToStr( nDigito );
End;



procedure confeccionacartao;
var tpcart:string;
begin

  if chkPeeling.Checked=true then
     tpcart:='1'
       else
     tpcart:='0';

  qryTemp.Close;
  qryTemp.SQL.Text:=' select cdesp,parametro from fc04300,fc99999 where cdesp=fc99999.subargum and fc99999.cdpar=14 and argumento='+quotedstr('ESPEC')+
                      ' and pfcrm='+quotedstr(cbProfissao.Text)+' and ufcrm='+quotedstr(cbUF.Text)+' and nrcrm='+edtCRM.Text;
   qryTemp.Open;

  qryUpPrivilege.Close;

  qryUpPrivilege.SQL.Text:=  'UPDATE OR INSERT INTO SOLICITPRIV (NOMEMED,UFCRM,NRCRM,CODESP,ESPECIALIDADE,CODPF,PROFISSAO,FLAGENV,USUALT,DTALT,HRALT,NRCARTAO,TPCART) values ('+
                             quotedstr(edtFuncionario.Text)+','+quotedstr(cbUF.Text)+','+edtCRM.Text+','+quotedstr(qryTemp.FieldValues['cdesp'])+','+quotedstr(qryTemp.FieldValues['parametro'])+','+quotedstr(cbProfissao.Text)+','+quotedstr(edtProfissao.Text)+','+quotedstr('S')+','+quotedstr(usu)+','+quotedstr(FormatDateTime('dd.mm.yyyy',now))+','+quotedstr(FormatDateTime('hh:nn:ss',now))+','+quotedstr(trim(codbarras+EAN13(codbarras)))+','+tpcart+')';

  qryUpPrivilege.Open;
  qryUpPrivilege.Transaction.CommitRetaining;
  qryUpPrivilege.Close;
  qryTemp.Close;
  frmSolicitacaoesAbertas.qrySolicitacoesPriv.Close;
  frmSolicitacaoesAbertas.qrySolicitacoesPriv.Open;
end;


begin

 if Length(mat)<4 then ShowMessage( 'CONSELHO REGIONAL PRECISA TER NO MÍNIMO 4 DIGITOS' )
  else
   begin

     qryUpPrivilege.Close;
     qryUpPrivilege.SQL.Text := ' select * from solicitpriv where codpf='+quotedstr(cbProfissao.Text)+' and ufcrm='+quotedstr(cbUF.Text)+' and nrcrm='+edtCRM.Text+' and flagenv='+quotedstr('S');
     qryUpPrivilege.Open;

     if chkPeeling.Checked=false then     
     if not(qryUpPrivilege.IsEmpty) then
        if Application.MessageBox('Cartão já confeccionado. Deseja alterar numero de cartão e bloquear anterior?', 'Confirmação', mb_iconQuestion + mb_YesNo + mb_DefButton2) = mrYes then
           begin

             codbarras :=qryUpPrivilege.FieldValues['nrcartao'];
             datacri:=qryUpPrivilege.FieldValues['dtalt'];
             nomemedico:=qryUpPrivilege.FieldValues['nomemed'];

             qryUpPrivilege.Close;
             qryUpPrivilege.SQL.Text := 'UPDATE OR INSERT INTO CARTBLOQUEADOS (NRCARTAO,USU,DATA,HORA,DATACRI,NOMEMED,FLAGENV) values ('+quotedstr(trim(codbarras))+','+quotedstr(usu)+','+quotedstr(FormatDateTime('dd.mm.yyyy',now))+','+quotedstr(FormatDateTime('hh:nn:ss',now))+','+quotedstr(FormatDateTime('dd.mm.yyyy',datacri))+','+quotedstr(nomemedico)+','+quotedstr('S')+')';//usando codbarras antigo
             qryUpPrivilege.Open;
             qryUpPrivilege.Transaction.CommitRetaining;
             qryUpPrivilege.Close;


             proxcar:=Format('%.2d', [strtoint(copy(codbarras,2,1)+copy(codbarras,5,1))+1]);
             mat:=copy(mat,1,1)+copy(proxcar,1,1)+copy(mat,3,2)+copy(proxcar,2,1)+copy(mat,6,7);
             codbarras :='0'+copy(mat,2,3)+copy(mat,5,2)+copy(mat,7,6); //atualizando codbarras
             confeccionacartao;
             jafez:='SIM';

           end;

     if chkPeeling.Checked then
         codbarras :='1'+copy(mat,2,3)+copy(mat,5,2)+copy(mat,7,6)
          else
         codbarras :='0'+copy(mat,2,3)+copy(mat,5,2)+copy(mat,7,6);

     funcionario := edtFuncionario.Text;

     Memo1 := frxEtqMedico.FindObject('MemoParam1') as TfrxMemoView;
     Memo1.Text := funcionario;
     Memo1.Font.Size := 9;


     frxEtqMedico.Variables['bar']:=codbarras;
     frxEtqMedico.ShowReport;

        if jafez<>'SIM' then
        if Application.MessageBox('Deseja marcar cartão como confeccionado?', 'Confirmação', mb_iconQuestion + mb_YesNo + mb_DefButton2) = mrYes then
           begin
             confeccionacartao;
           end;

      qryCodBMedicos.Close;

   end;

 edtCRM.Color := clWindow;
 edtFuncionario.Color := clScrollBar;
 edtFuncionario.Clear;
 edtCRM.Clear;
 edtCRM.SetFocus;

end;

procedure TfrmCodBarrasMedicos.FormShow(Sender: TObject);
begin
 edtFuncionario.Clear;
 edtCRM.Clear;
 edtCRM.Color := clWindow;
 edtFuncionario.Color := clScrollBar;
 edtCRM.SetFocus;
 qryCodBMedicos.Transaction.CommitRetaining;
 qryCodBMedicos.Close;
 cbProfissao.ItemIndex:=0;
 edtProfissao.Text:='MEDICO';
 if frmSolicitacaoesAbertas.Visible then
   begin
    edtCRM.Text:=inttostr(frmSolicitacaoesAbertas.qrySolicitacoesPriv.FieldValues['nrcrm']);
    cbProfissao.Text:=frmSolicitacaoesAbertas.qrySolicitacoesPriv.FieldValues['codPF'];
    edtProfissao.Text:=frmSolicitacaoesAbertas.qrySolicitacoesPriv.FieldValues['profissao'];
    cbUF.Text:=frmSolicitacaoesAbertas.qrySolicitacoesPriv.FieldValues['ufcrm'];
    cod2:=frmSolicitacaoesAbertas.qrySolicitacoesPriv.FieldValues['cod'];
   end;
end;

procedure TfrmCodBarrasMedicos.edtFuncionarioChange(Sender: TObject);
begin
// edtCodProd.Clear;
 edtCRM.Color := clScrollBar;
 edtFuncionario.Color := clWindow;
 qryCodBMedicos.Close;
end;

procedure TfrmCodBarrasMedicos.edtCRMChange(Sender: TObject);
begin
 edtFuncionario.Clear;
 edtCRM.Color := clWindow;
 edtFuncionario.Color := clScrollBar;
 qryCodBMedicos.Close;
 mat:='';
end;

procedure TfrmCodBarrasMedicos.edtFuncionarioKeyPress(Sender: TObject;
  var Key: Char);
begin

 if  CharInSet(Key, [#13]) then
  begin
    qryCodBMedicos.Close;
    qryCodBMedicos.Transaction.CommitRetaining;
    qryCodBMedicos.SQL.Text:='select nrcrm as nrmat,nomemed as nomefun,pfcrm,ufcrm from fc04000 where nrcrm='+QuotedStr(trim(edtCRM.Text))+' and UFCRM='+quotedstr(cbUF.Text)+' and PFCRM='+quotedstr(cbProfissao.Text)+' order by nomemed';
    qryCodBMedicos.Open;
    qryCodBMedicos.First;
    if qryCodBMedicos.IsEmpty then ShowMessage('Nenhum médico encontrado com esse CRM') else
     begin
       edtFuncionario.Text := qryCodBMedicos.FieldValues['nomefun'];
       btImprimir.SetFocus;
       qryCodBMedicos.Open;
     end;
  END;

end;

procedure TfrmCodBarrasMedicos.edtFuncionarioKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

if Key = VK_TAB then
  begin
      qryCodBMedicos.Close;
      qryCodBMedicos.Transaction.CommitRetaining;
      qryCodBMedicos.SQL.Text:='select nrcrm as nrmat,nomemed as nomefun,pfcrm,ufcrm from fc04000 where nomemed like '+QuotedStr(trim(edtFuncionario.Text)+'%') +' and UFCRM='+quotedstr(cbUF.Text)+' and PFCRM='+quotedstr(cbProfissao.Text)+' order by nomemed';
      qryCodBMedicos.Open;
      qryCodBMedicos.First;
      if qryCodBMedicos.IsEmpty then ShowMessage('Nenhum profissional encontrado com esse nome. Verifique os filtros.') else
      frmBuscaFuncionario.ShowModal;
  end;

end;

procedure TfrmCodBarrasMedicos.edtCRMKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

if Key = VK_TAB then
  begin
          qryCodBMedicos.Close;
          qryCodBMedicos.Transaction.CommitRetaining;
      qryCodBMedicos.SQL.Text:='select nrcrm as nrmat,nomemed as nomefun,pfcrm,ufcrm from fc04000 where nomemed like '+QuotedStr(trim(edtFuncionario.Text)+'%') +' and UFCRM='+quotedstr(cbUF.Text)+' and PFCRM='+quotedstr(cbProfissao.Text)+' order by nomemed';
      qryCodBMedicos.Open;
      qryCodBMedicos.First;
      if qryCodBMedicos.IsEmpty then ShowMessage('Nenhum profissional encontrado com esse nome. Verifique os filtros.') else
          frmBuscaFuncionario.ShowModal;
  end;

end;

procedure TfrmCodBarrasMedicos.btImprimirKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if Key = VK_TAB then
  begin
          qryCodBMedicos.Close;
          qryCodBMedicos.Transaction.CommitRetaining;
      qryCodBMedicos.SQL.Text:='select nrcrm as nrmat,nomemed as nomefun,pfcrm,ufcrm from fc04000 where nomemed like '+QuotedStr(trim(edtFuncionario.Text)+'%') +' and UFCRM='+quotedstr(cbUF.Text)+' and PFCRM='+quotedstr(cbProfissao.Text)+' order by nomemed';
      qryCodBMedicos.Open;
      qryCodBMedicos.First;
      if qryCodBMedicos.IsEmpty then ShowMessage('Nenhum profissional encontrado com esse nome. Verifique os filtros.') else
          frmBuscaFuncionario.ShowModal;
  end;
end;

procedure TfrmCodBarrasMedicos.cbProfissaoChange(Sender: TObject);
begin
  qryTemp.Close;
  qryTemp.SQL.Text := 'select PARAMETRO as PROFISSAO from fc99999 where cdpar=14 and argumento='+quotedstr('PFCRM')+' and subargum='+quotedstr(cbProfissao.Text)+' order by 1';
  qryTemp.Open;

  edtProfissao.Text:=qryTemp.FieldValues['profissao'];
  qryTemp.Close;

 edtFuncionario.Clear;
 edtCRM.Color := clWindow;
 edtFuncionario.Color := clScrollBar;
 qryCodBMedicos.Close;


   case cbProfissao.ItemIndex of
    0:gbCRM.Caption:='CRM';
    1:gbCRM.Caption:='CRO';
    2:gbCRM.Caption:='CRMV';
    3:gbCRM.Caption:='CRM';
    4:gbCRM.Caption:='CRP';
    5:gbCRM.Caption:='CRF';
    6:gbCRM.Caption:='CRM';
    7:gbCRM.Caption:='CRM';
    8:gbCRM.Caption:='CRN';
    9:gbCRM.Caption:='CRM';
  end;

end;

procedure TfrmCodBarrasMedicos.cbUFChange(Sender: TObject);
begin
 edtFuncionario.Clear;
 edtCRM.Clear;
 edtCRM.Color := clWindow;
 edtFuncionario.Color := clScrollBar;
 qryCodBMedicos.Close;
end;

end.
