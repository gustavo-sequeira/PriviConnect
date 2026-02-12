unit uCortesiaInclusao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, {clipbrd,}
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Data.DB,
  IBX.IBCustomDataSet, IBX.IBQuery;

type
  TfrmInclusaoCortesia = class(TForm)
    gbFuncionario: TGroupBox;
    edtFuncionario: TEdit;
    edtCOD: TEdit;
    GroupBox1: TGroupBox;
    btOk: TBitBtn;
    edtReq: TEdit;
    edtFil: TEdit;
    qryFuncionarios: TIBQuery;
    qryBuscaReceitas: TIBQuery;
    qryInsereSolicitacao: TIBQuery;
    cbDepto: TComboBox;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtFuncionarioChange(Sender: TObject);
    procedure edtFuncionarioKeyPress(Sender: TObject; var Key: Char);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure habilita;
    procedure desabilita;
    procedure btOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInclusaoCortesia: TfrmInclusaoCortesia;

implementation

{$R *.dfm}

uses uBuscaFunCortesia, udmDescontos, uSolicCortesiasAbertas, System.UITypes;

procedure TfrmInclusaoCortesia.edtFuncionarioChange(Sender: TObject);
begin
 edtCOD.Clear;
end;

procedure TfrmInclusaoCortesia.habilita;
begin
 edtFil.Clear;
 edtReq.Clear;
 edtReq.Enabled:=true;
 edtFil.Enabled:=true;
 edtReq.Color := clWindow;
 edtFil.Color := clWindow;
end;

function TrocaVirgPPto(Valor: string): String;
var i:integer;
begin
if valor=null then valor:='0';
    if Valor <>'' then begin
        for i := 0 to Length(Valor) do begin
            if Valor[i]=',' then Valor[i]:='.';

        end;
     end;
     Result := valor;
end;

procedure TfrmInclusaoCortesia.btOkClick(Sender: TObject);
var valcort,valusa,valform,valdisp:double;
     cpfsolic:string;
begin

 if (trim(edtFil.Text)<>'') and  (trim(edtReq.Text)<>'') then
   begin

      qryBuscaReceitas.Close;
      qryBuscaReceitas.Transaction.Commit;
      qryBuscaReceitas.Transaction.Active:=true;
      qryBuscaReceitas.SQL.Text:='select * from fc12000 where cdfil='+edtFil.Text+' and nrrqu='+edtReq.Text;
      qryBuscaReceitas.Open;

      if qryBuscaReceitas.IsEmpty then raise Exception.Create('Receita não encontrada');

      valform := qryBuscaReceitas.FieldValues['vrrqu'];

      qryFuncionarios.Close;
      qryFuncionarios.SQL.Text :=' select nomefun,nrcpf from fc08000 where '+
                                      ' fc08000.nrcpf in ( select fc07000.nrcnpj from fc07000 where '+
                                      ' fc07000.cdcli='+inttostr( qryBuscaReceitas.fieldvalues['cdcli'])+')';
      qryFuncionarios.Open;

      if qryFuncionarios.IsEmpty then raise Exception.Create('Cliente não está cadastrado como funcionário Pharmapele');

      cpfsolic:=qryFuncionarios.FieldValues['nrcpf'];

      qryFuncionarios.Close;

      qryInsereSolicitacao.Close;
      qryInsereSolicitacao.SQL.Text := 'select * from soliccortesia where CANCELADO=0 and indapr<>2 and CPFFUNCORT='+quotedstr(cpfsolic)+' and dtsol between '+quotedstr(FormatDateTime('01.mm.yyyy',now))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',now));
      qryInsereSolicitacao.Open;

      valusa := 0;

      if not(qryInsereSolicitacao.IsEmpty) then
        while not(qryInsereSolicitacao.Eof)  do
          begin
            valusa := valusa+qryInsereSolicitacao.FieldValues['VALORCORT'];
            qryInsereSolicitacao.Next;
          end;

      if valusa>=120 then raise Exception.Create('Funcionário já usou todo valor de cortesia');

      valcort := 120-valusa;
      valdisp := valcort;

      if valform<=valcort then  valcort := valform - 0.1;


      if MessageDlg('Deseja confirmar solicitação de cortesia?',mtconfirmation,[mbYes,MbNo],0)=mryes then
        begin
         qryInsereSolicitacao.Close;
         qryInsereSolicitacao.SQL.Text := ' INSERT INTO SOLICCORTESIA (DTSOL, HRSOL, USUSOL, CDFUNCORT, NOMEFUNCORT, DEPTOCORT, CDFILR, NRRQUR, SERIERR, VALORFRM, VALORCORT, INDAPR, CANCELADO, INDUSD, CPFFUNCORT) VALUES ('+
         quotedstr(FormatDateTime('dd.mm.yyyy',now))+','+quotedstr(FormatDateTime('hh:nn:ss',now))+','+quotedstr(usu)+','+edtCOD.Text+','+quotedstr(edtFuncionario.Text)+','+quotedstr(cbDepto.Text)+','+edtFil.Text+','+edtReq.Text+','+'0'+','+quotedstr(TrocaVirgPPto(FloatToStr(qryBuscaReceitas.FieldValues['vrrqu'])))+','+quotedstr(TrocaVirgPPto(FloatToStr(valcort)))+',0,0,0,'+quotedstr(cpfsolic)+')';

         try
//           Clipboard.AsText := qryInsereSolicitacao.SQL.Text;
           qryInsereSolicitacao.Open;

           qryInsereSolicitacao.Transaction.CommitRetaining;
         except
           qryInsereSolicitacao.Transaction.RollbackRetaining;
           raise Exception.Create('Erro ao solicitar cortesia. Verifique se cortesia já foi solicitada');
         end;

         qryBuscaReceitas.Close;
         qryBuscaReceitas.Transaction.Commit;
         qryBuscaReceitas.Transaction.Active:=true;
         qryBuscaReceitas.SQL.Text:='UPDATE fc12000 set condp='+quotedstr('*CORTESIAPRIV*')+' where cdfil='+edtFil.Text+' and nrrqu='+edtReq.Text;
         qryBuscaReceitas.Open;
         qryBuscaReceitas.Transaction.Commit;
         qryBuscaReceitas.Transaction.Active:=true;

         ShowMessage('Solicitação de cortesia inclusa com sucesso');

         with frmCortesiasAbertas do
           begin
             qrySolicitacoes.Transaction.CommitRetaining;
             qrySolicitacoes.Close;
             qrySolicitacoes.Open;

             lblValorDisp.Caption := FormatFloat('R$ ###,###,##0.00',valdisp-valcort);
           end;

         frmInclusaoCortesia.Close;
        end;

   end;

end;

procedure TfrmInclusaoCortesia.desabilita;
begin
 edtFil.Clear;
 edtReq.Clear;
 edtReq.Enabled:=false;
 edtFil.Enabled:=false;
 edtReq.Color := clScrollBar;
 edtFil.Color := clScrollBar;
end;

procedure TfrmInclusaoCortesia.edtFuncionarioKeyPress(Sender: TObject;
  var Key: Char);
begin


if Key = #9 then
  begin
      qryFuncionarios.Close;
      qryFuncionarios.Transaction.CommitRetaining;
      qryFuncionarios.SQL.Text:='select * from fc08000 where cdcon=110 and nomefun like '+QuotedStr(trim(edtFuncionario.Text)+'%') +' order by nomefun';
      qryFuncionarios.Open;
      qryFuncionarios.First;
      if qryFuncionarios.IsEmpty then ShowMessage('Nenhum funcionário encontrado com esse nome. Verifique os filtros.') else
      frmBuscaFuncCortesia.ShowModal;
      if trim(edtCOD.Text)<>'' then
        begin
          habilita;
          edtFil.SetFocus;
        end
        else
      desabilita;
  end;


if Key = #13 then
  begin
    if trim(edtFuncionario.Text)<>'' then
     begin
          qryFuncionarios.Close;
          qryFuncionarios.Transaction.CommitRetaining;
          qryFuncionarios.SQL.Text:='select * from fc08000 where cdcon=110 and nomefun = '+QuotedStr(trim(edtFuncionario.Text)) +' order by nomefun';
          qryFuncionarios.Open;
          if qryFuncionarios.IsEmpty then
            begin
             ShowMessage('Nenhum funcionário encontrado com esse nome.');
             desabilita;
            end else
            begin
              edtFuncionario.Text:= qryFuncionarios.FieldValues['nomefun'];
              edtCOD.Text:= inttostr(qryFuncionarios.FieldValues['cdfun']);
              edtFuncionario.SelectAll;
              habilita;
              edtFil.SetFocus;
            end;

          qryFuncionarios.Close;
     end;
  end;
end;

procedure TfrmInclusaoCortesia.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;
end;

procedure TfrmInclusaoCortesia.FormShortCut(var Msg: TWMKey;
  var Handled: Boolean);
begin
if (ActiveControl = edtFuncionario) and (Msg.CharCode=9) then
 begin
//  ShowMessage('Tab via Kut');
  Msg.CharCode := 0;
 end;
end;

procedure TfrmInclusaoCortesia.FormShow(Sender: TObject);
begin
 edtFuncionario.Clear;
 edtCOD.Clear;
 edtReq.Clear;
 edtFil.Clear;
 cbDepto.ItemIndex:=0;
end;

end.
