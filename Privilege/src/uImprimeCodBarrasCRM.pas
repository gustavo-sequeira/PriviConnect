unit uImprimeCodBarrasCRM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, frxBarCode,
  Dialogs, Buttons, StdCtrls, ExtCtrls, DB, IBCustomDataSet, IBQuery, frxClass,dateutils,
  frxDBSet;

type
  TfrmImprimeCodBarras = class(TForm)
    gpbTerminalBalcao: TGroupBox;
    edtCupomFiscal: TEdit;
    pnlCodBarras: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblValidade2: TLabel;
    lblNome: TLabel;
    lblCPF: TLabel;
    lblDesconto: TLabel;
    qryConsultaCupom: TIBQuery;
    lblValidade1: TLabel;
    Label5: TLabel;
    edtLojaCupom: TEdit;
    qryInsereBanco: TIBQuery;
    qryConsultaPrivilege: TIBQuery;
    btImprimir: TBitBtn;
    frxrCodCliente: TfrxReport;
    rgTipo: TRadioGroup;
    procedure edtCupomFiscalKeyPress(Sender: TObject; var Key: Char);
    procedure localizarcupom(balcao:string);
    procedure FormShow(Sender: TObject);
    procedure btImprimirClick(Sender: TObject);
    procedure incluibanco;
    procedure edtCupomFiscalChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImprimeCodBarras: TfrmImprimeCodBarras;

implementation

uses udmDescontos, uPrincipal, MaskUtils;

{$R *.dfm}

procedure TfrmImprimeCodBarras.localizarcupom(balcao:string);
var desconto:double;
begin

   lblValidade1.Caption := '';
   lblValidade2.Caption := '';
   lblNome.Caption := '';
   lblCPF.Caption := '';
   lblDesconto.Caption := '';

   qryConsultaCupom.Close;
   qryConsultaCupom.Transaction.Commit;
   if trim(edtCupomFiscal.Text)<>'' then
    begin

       qryConsultaPrivilege.Close;
       qryConsultaPrivilege.Transaction.Commit;
       qryConsultaPrivilege.SQL.Text := 'select * from descclientes where dtemissao>'+quotedstr('01.11.2017')+' and cdfil='+trim(edtLojaCupom.Text)+' and cpfiscal='+trim(edtCupomFiscal.Text)+' and ( (usado='+quotedstr('1')+') or (cancelado='+quotedstr('1')+'))' ;
       qryConsultaPrivilege.Open;

       if not(qryConsultaPrivilege.IsEmpty) then
        begin
          qryConsultaPrivilege.Close;
          if not(dmDescontos.IBTransaction1.Active) then dmDescontos.IBTransaction1.Active := true;
          if not(dmDescontos.IBTransaction2.Active) then dmDescontos.IBTransaction2.Active := true;
          raise Exception.Create('Cupom já foi utilizado');
        end;

       qryConsultaPrivilege.Close;
       qryConsultaCupom.Close;

       if rgTipo.ItemIndex=0 then
        begin
           qryConsultaCupom.SQL.Text:= ' select fc31100.cdfil,fc31100.nrcpmf,fc31100.cdcli, fc07000.nomecli,fc07000.nrcnpj as CPF,fc31100.dtope as DATAEMI, ' +
                                       ' fc31100.dtope+3 as DATAVALIN, fc31100.dtope+33 as DATAVALFIM,fc31100.vrtot, '+
                                       ' (select sum(fc31110.vrliq) from fc31110 where fc31110.cdfil=fc31100.cdfil and fc31110.operid=fc31100.operid and fc31110.tpitm='+quotedstr('V')+' )as VRVAREJO, '+
                                       ' ((select sum(fc31110.vrliq) from fc31110 where fc31110.cdfil=fc31100.cdfil and fc31110.operid=fc31100.operid and fc31110.tpitm='+quotedstr('V')+' )* 0.1 ) as VRDSC '+
                                       ' from fc31100, fc07000 '+
                                       ' where fc07000.cdcli=fc31100.cdcli '+
                                     //  ' and fc31100.dtope='+quotedstr(FormatDateTime('dd.mm.yyyy',now))+
                                       ' and fc31100.cdfil='+(edtLojaCupom.Text)+
                                       ' and fc31100.nrcpmf='+(edtCupomFiscal.Text);
        end
          else
             begin
                 qryConsultaCupom.SQL.Text:= ' select fc31100.cdfil,coalesce(fc31100.nrcpmf,fc31100.nrnfce) as nrcpmf,fc31100.cdcli, fc07000.nomecli,fc07000.nrcnpj as CPF,fc31100.dtope as DATAEMI, ' +
                                             ' fc31100.dtope+3 as DATAVALIN, fc31100.dtope+33 as DATAVALFIM,fc31100.vrtot, '+
                                             ' (select sum(fc31110.vrliq) from fc31110 where fc31110.cdfil=fc31100.cdfil and fc31110.operid=fc31100.operid and fc31110.tpitm='+quotedstr('V')+' )as VRVAREJO, '+
                                             ' ((select sum(fc31110.vrliq) from fc31110 where fc31110.cdfil=fc31100.cdfil and fc31110.operid=fc31100.operid and fc31110.tpitm='+quotedstr('V')+' )* 0.1 ) as VRDSC '+
                                             ' from fc31100, fc07000 '+
                                             ' where fc07000.cdcli=fc31100.cdcli '+
//                                             ' and fc31100.dtope>'+quotedstr(FormatDateTime('dd.mm.yyyy',IncDay(now,-60)))+
                                             ' and fc31100.cdfil='+(edtLojaCupom.Text)+
                                             ' and fc31100.nrnfce='+(edtCupomFiscal.Text);
             end;

 //Clipboard.AsText:= qryConsultaCupom.sql.Text;
 qryConsultaCupom.Open;

 if  qryConsultaCupom.IsEmpty then ShowMessage('Cupom não encontrado no dia de hoje')
  else
     begin

       if qryConsultaCupom.FieldValues['vrdsc']=null then raise exception.create ('Cupom não possui itens de varejo' );

       TNumericField(qryConsultaCupom.FieldByName('vrtot')).DisplayFormat := ',0.00;-,0.00';
       TNumericField(qryConsultaCupom.FieldByName('vrvarejo')).DisplayFormat := ',0.00;-,0.00';
       TNumericField(qryConsultaCupom.FieldByName('vrdsc')).DisplayFormat := ',0.00;-,0.00';

       desconto := qryConsultaCupom.FieldValues['vrdsc'];
       vrtot    := qryConsultaCupom.FieldValues['vrvarejo'];

       lblDesconto.Caption := floattostrf(desconto, ffcurrency, 15, 2);         

       lblValidade1.Caption := FormatDateTime('dd/mm/yy',qryConsultaCupom.FieldValues['datavalin']);
       lblValidade2.Caption := FormatDateTime('dd/mm/yy',qryConsultaCupom.FieldValues['datavalfim']);

       lblNome.Caption := qryConsultaCupom.FieldValues['NOMECLI'];

       if qryConsultaCupom.FieldValues['CPF']=null then
        raise Exception.Create('ERRO! Cliente não possui CPF cadastrado!')
          else
        lblCPF.Caption := FormatMaskText('999.999.999-99;0;_',qryConsultaCupom.FieldValues['CPF']);

       btImprimir.Enabled := true;
       btImprimir.SetFocus;
     end;

    end;

end;

procedure TfrmImprimeCodBarras.edtCupomFiscalKeyPress(Sender: TObject;
  var Key: Char);
begin

 if not CharInSet(Key, ['0'..'9',#8,#13]) then key := #0
  else
    qryConsultaCupom.Close;

 if key=#13 then
   begin
    if trim(edtCupomFiscal.Text) <>'' then
     begin
      localizarcupom(edtCupomFiscal.Text);
     end;
   end;

end;

procedure TfrmImprimeCodBarras.FormShow(Sender: TObject);
begin



 edtLojaCupom.Text:= frmPrincipal.edtLoja.Text;
 edtLojaCupom.Enabled := frmPrincipal.edtLoja.Enabled;
 edtLojaCupom.Color := frmPrincipal.edtLoja.Color;
 btImprimir.Enabled := false;

 edtLojaCupom.Enabled := true;

end;

procedure TfrmImprimeCodBarras.btImprimirClick(Sender: TObject);

function StrZero(Zeros:string;Quant:integer):String;
var
I,Tamanho:integer;
aux: string;
begin
  aux     := zeros;
  Tamanho := length(ZEROS);
  ZEROS   := '';
  for I:=1 to quant-tamanho do ZEROS := ZEROS + '0';
  aux     := zeros + aux;
  StrZero := aux;
end;


var codbarras:string;
    Memo1,Memo2,Memo3,Memo4: TfrxMemoView;

begin

  raise Exception.Create('Temporariamente não imprimiremos mais cupons de desconto.');

         codbarras :=FormatDateTime('nn',now)+strzero(edtLojaCupom.Text,2)+strzero(edtCupomFiscal.Text,6)+'27';

         Memo1 := frxrCodCliente.FindObject('MemoParam1') as TfrxMemoView;
         Memo1.Text := StringReplace(lblDesconto.Caption, 'R$', '', [rfReplaceAll, rfIgnoreCase]);
         Memo1.Font.Size := 23;

         Memo2 := frxrCodCliente.FindObject('MemoParam2') as TfrxMemoView;
         Memo2.Text := lblValidade1.Caption;
         Memo2.Font.Size := 6;

         Memo3 := frxrCodCliente.FindObject('MemoParam3') as TfrxMemoView;
         Memo3.Text := lblValidade2.Caption;
         Memo3.Font.Size := 6;

         Memo4 := frxrCodCliente.FindObject('MemoParam4') as TfrxMemoView;
         Memo4.Text := edtLojaCupom.Text+'-'+edtCupomFiscal.Text;
         Memo4.Font.Size := 7;

         frxrCodCliente.Variables['bar']:=codbarras;
         frxrCodCliente.ShowReport;

         incluibanco;

     //    if MessageDlg('O cupom foi emitido corretamente?',mtconfirmation,[mbYes,MbNo],0)=mryes then

    { with dmDescontos.rvRelatorios do
      begin
        SetParam('codbarras',FormatDateTime('nn',now)+edtLojaCupom.Text+strzero(edtCupomFiscal.Text,6)+'27');
        SetParam('VRDSC',lblDesconto.Caption);
        SetParam('DTINI',lblValidade1.Caption);
        SetParam('DTFIM',lblValidade2.Caption);
        SetParam('CUPOM',edtCupomFiscal.Text);
        selectreport('rptCodBarrasClientes', false);
        execute;
        if MessageDlg('O cupom foi emitido corretamente?',mtconfirmation,[mbYes,MbNo],0)=mryes then incluibanco;
      end;}


 edtCupomFiscal.Clear;
 btImprimir.Enabled := false;
 lblValidade1.Caption := '';
 lblValidade2.Caption := '';
 lblNome.Caption := '';
 lblCPF.Caption := '';
 lblDesconto.Caption := '';
 edtCupomFiscal.SetFocus;

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

procedure TfrmImprimeCodBarras.incluibanco;
var cdcli:integer;
begin
 cdcli := qryConsultaCupom.FieldValues['cdcli'];
 qryInsereBanco.Close;
 qryInsereBanco.SQL.Text := ' INSERT INTO DESCCLIENTES (CDFIL,CPFISCAL,DTEMISSAO,DTVALINICIO,DTVALFIM,VRTOTAL,VRVAREJO,VRDESC,CDCLI,NOMECLI,NRCPF,USADO,CANCELADO) '+
                            '  VALUES ( '+
                              inttostr(qryConsultaCupom.FieldValues['cdfil'])+','+
                              inttostr(qryConsultaCupom.FieldValues['nrcpmf'])+','+
                              quotedstr(FormatDateTime('dd.mm.yyyy',qryConsultaCupom.FieldValues['dataemi']))+','+
                              quotedstr(FormatDateTime('dd.mm.yyyy',qryConsultaCupom.FieldValues['datavalin']))+','+
                              quotedstr(FormatDateTime('dd.mm.yyyy',qryConsultaCupom.FieldValues['datavalfim']))+','+
                              TrocaVirgPPto(FloatToStr(qryConsultaCupom.FieldValues['vrtot']))+','+
                              TrocaVirgPPto(FloatToStr(qryConsultaCupom.FieldValues['vrvarejo']))+','+
                              TrocaVirgPPto(FloatToStr(qryConsultaCupom.FieldValues['vrdsc']))+','+
                              inttostr(qryConsultaCupom.FieldValues['cdcli'])+','+
                              quotedstr(qryConsultaCupom.FieldValues['nomecli'])+','+
                              quotedstr(qryConsultaCupom.FieldValues['CPF'])+','+
                              quotedstr('0')+','+
                              quotedstr('0')+')';

 try
//  Clipboard.AsText := qryInsereBanco.SQL.Text;
  qryInsereBanco.Open;
  qryInsereBanco.Transaction.CommitRetaining;
 except
  qryInsereBanco.Transaction.RollbackRetaining;
  showmessage('Ocorreu um erro ao criar o cartão no sistema, verificar com o TI');
 end;
 qryInsereBanco.Close;


 try
  qryConsultaCupom.Close;
  qryConsultaCupom.SQL.Text := 'update fc07000 set clcli='+quotedstr('1')+' where cdcli='+inttostr(cdcli);
  qryConsultaCupom.Open;
  qryConsultaCupom.Transaction.CommitRetaining;
  qryConsultaCupom.Close;
 except
  qryConsultaCupom.Transaction.RollbackRetaining;
  showmessage('Ocorreu um erro ao marcar desconto no formula certa , verificar com o TI');
 end;


end;




procedure TfrmImprimeCodBarras.edtCupomFiscalChange(Sender: TObject);
begin
 btImprimir.Enabled := false;
 lblValidade1.Caption := '';
 lblValidade2.Caption := '';
 lblNome.Caption := '';
 lblCPF.Caption := '';
 lblDesconto.Caption := '';
end;

end.
