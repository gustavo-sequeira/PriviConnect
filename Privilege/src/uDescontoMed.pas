unit uDescontoMed;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.DBCtrls,{ clipbrd,}
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.jpeg, Vcl.ExtCtrls, IBX.IBCustomDataSet,
  IBX.IBQuery, Vcl.Buttons, Vcl.Menus;

type
  TfrmDescontoMedico = class(TForm)
    Panel2: TPanel;
    gbPerguntas: TGroupBox;
    Label2: TLabel;
    btOk: TBitBtn;
    edtOrcamento: TEdit;
    btSalvar: TBitBtn;
    edtSerieOrc: TEdit;
    qryBuscaOrcCab: TIBQuery;
    qryBuscaOrcCabNRORC: TIntegerField;
    qryBuscaOrcCabSERIEO: TIBStringField;
    qryBuscaOrcCabTPFORMAFARMA: TIntegerField;
    qryBuscaOrcCabVOLUME: TIBBCDField;
    qryBuscaOrcCabUNIVOL: TIBStringField;
    qryBuscaOrcCabTPCAP: TIBStringField;
    qryBuscaOrcCabCDEMB: TIntegerField;
    qryBuscaOrcCabNOMEEMBALAGEM: TIBStringField;
    qryBuscaOrcCabPOSOL: TIBStringField;
    qryBuscaOrcCabQTFOR: TIntegerField;
    qryBuscaOrcCabQTPRESCR: TIBBCDField;
    qryBuscaOrcCabGRUPOTERAP: TIntegerField;
    qryBuscaOrcCabQTCONT: TIBBCDField;
    qryBuscaOrcCabUNICONT: TIBStringField;
    qryBuscaOrcCabINDQSP: TIBStringField;
    qryBuscaOrcCabINDREVENTERICO: TIBStringField;
    qryBuscaOrcCabINDUSOCONT: TIBStringField;
    qryBuscaOrcCabINDBLISTER: TIBStringField;
    qryBuscaOrcCabINDLIBLENTA: TIBStringField;
    qryBuscaOrcCabCDFIL: TIntegerField;
    qryBuscaOrcDet: TIBQuery;
    qryBuscaOrcDetDESCR: TIBStringField;
    qryBuscaOrcDetQUANT: TFloatField;
    qryBuscaOrcDetUNIDA: TIBStringField;
    qryBuscaOrcDetVRCMP: TIBBCDField;
    qryBuscaOrcDetPORTA: TIBStringField;
    qryBuscaOrcDetCDFIL: TIntegerField;
    qryBuscaOrcDetNRORC: TIntegerField;
    qryBuscaOrcDetSERIEO: TIBStringField;
    qryBuscaOrcDetTPCMP: TIBStringField;
    qryBuscaOrcDetITEMID: TIntegerField;
    qryBuscaOrcDetCDPRIN: TIntegerField;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    qryInserePergunta: TIBQuery;
    edtValor: TEdit;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    cbFormulas: TComboBox;
    Label4: TLabel;
    edtTitulo: TEdit;
    btIncluir: TBitBtn;
    btExcluir: TBitBtn;
    Panel1: TPanel;
    Image1: TImage;
    edtPresc1: TEdit;
    edtPrescUF: TEdit;
    edtUni2: TEdit;
    edtValidade: TEdit;
    edtContem: TEdit;
    edtForma: TEdit;
    edtGrupoTera: TEdit;
    edtUN: TEdit;
    edtCRM: TEdit;
    edtVol: TEdit;
    edtPosologia: TEdit;
    edtQtdPrescr: TEdit;
    edtQtdPotes: TEdit;
    edtNomeMed: TEdit;
    edtNomeEmb: TEdit;
    Edit20: TEdit;
    dbDetOrc: TDBGrid;
    edtCodEmb: TEdit;
    edtContem2: TEdit;
    chkLibPro: TDBCheckBox;
    chkUsoCont: TDBCheckBox;
    chkBlister: TDBCheckBox;
    chkRevEnt: TDBCheckBox;
    chkQSP: TDBCheckBox;
    qryTempPrivilege: TIBQuery;
    btCancelar: TBitBtn;
    qryCodForm: TIBQuery;
    IBStringField1: TIBStringField;
    FloatField1: TFloatField;
    IBStringField2: TIBStringField;
    IBBCDField1: TIBBCDField;
    IBStringField3: TIBStringField;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IBStringField4: TIBStringField;
    IBStringField5: TIBStringField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    cbMedico: TComboBox;
    Label5: TLabel;
    edtNRCRM: TEdit;
    Label6: TLabel;
    cbUFCrM: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    edtPFCRM: TEdit;
    qryMedico: TIBQuery;
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    PorQTDdeComponentes1: TMenuItem;
    LinkDescontoCRM1: TMenuItem;
    btAlteraPreco: TSpeedButton;
    procedure btIncluirClick(Sender: TObject);
    procedure edtOrcamentoChange(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure qryBuscaOrcCabAfterOpen(DataSet: TDataSet);
    procedure qryBuscaOrcCabAfterClose(DataSet: TDataSet);
    procedure btSalvarClick(Sender: TObject);
    procedure limpacampos;
    procedure btExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbFormulasChange(Sender: TObject);
    procedure buscaorcamento;
    procedure btCancelarClick(Sender: TObject);
    procedure renovacombo;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cbMedicoChange(Sender: TObject);
    procedure PorQTDdeComponentes1Click(Sender: TObject);
    procedure LinkDescontoCRM1Click(Sender: TObject);
    procedure btAlteraPrecoClick(Sender: TObject);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDescontoMedico: TfrmDescontoMedico;
  flagaltera:boolean=false;
implementation

{$R *.dfm}

uses udmDescontos, uDescComponente, uLinkCRMDesc, System.UITypes;


procedure TfrmDescontoMedico.limpacampos;
begin

 edtPresc1.Text     :='';
 edtPrescUF.Text    :='';
 edtCRM.Text        :='';
 edtNomeMed.Text    :='';

 edtForma.Text     := '';
 edtVol.Text       := '';
 edtUN.Text        := '';
 edtUni2.Text      := '';
 edtCodEmb.Text    := '';
 edtNomeEmb.Text   := '';
 edtPosologia.Text := '';
 edtQtdPotes.Text  := '';
 edtQtdPrescr.Text := '';
 edtValidade.Text  := '';
 edtGrupoTera.Text := '';
 edtContem.Text    := '';
 edtContem2.Text   := '';
 edtTitulo.Text    := '';
 edtPFCRM.Text     := '';
 edtNRCRM.Text     := '';
 edtValor.Text     := '';
 cbUFCrM.ItemIndex := -1;


 btSalvar.Enabled   := false;
 btOk.Enabled       := false;
 btExcluir.Enabled  := false;
 btAlteraPreco.Enabled:=false;

 qryBuscaOrcCab.Close;

end;

procedure TfrmDescontoMedico.LinkDescontoCRM1Click(Sender: TObject);
begin
 frmLinkCRM.ShowModal;
end;

procedure TfrmDescontoMedico.PorQTDdeComponentes1Click(Sender: TObject);
begin
 frmDescMedQtdCMP.ShowModal;
end;

procedure TfrmDescontoMedico.btAlteraPrecoClick(Sender: TObject);
begin
 if edtOrcamento.Text<>'' then
  begin
   flagaltera:=true;
   edtValor.Enabled := true;
   edtValor.Color := clWindow;
   btSalvar.Enabled := true;
   edtValor.SetFocus;
  end;
end;

procedure TfrmDescontoMedico.btCancelarClick(Sender: TObject);
begin
 if MessageDlg('Deseja mesmo cancelar?',mtconfirmation,[mbYes,MbNo],0)=mryes then
      begin

        edtOrcamento.Clear;
        edtSerieOrc.Clear;
        qryBuscaOrcCab.Close;

         edtOrcamento.Enabled := false;
         edtSerieOrc.Enabled  := false;
         edtValor.Enabled     := false;
         edtTitulo.Enabled    := false;
         edtPFCRM.Enabled     := false;
         edtNRCRM.Enabled     := false;
         edtTitulo.Enabled    := false;
         cbUFCrM.Enabled      := false;

         edtOrcamento.Color := clScrollBar;
         edtSerieOrc.Color  := clScrollBar;
         edtValor.Color     := clScrollBar;
         edtTitulo.Color    := clScrollBar;
         edtPFCRM.Color     := clScrollBar;
         edtNRCRM.Color     := clScrollBar;
         cbUFCrM.Color      := clScrollBar;

         btIncluir.Enabled := true;
         btCancelar.Enabled := false;
         cbFormulas.ItemIndex := -1;
         cbUFCrM.ItemIndex := -1;

      end;
end;

procedure TfrmDescontoMedico.btExcluirClick(Sender: TObject);
begin
 if MessageDlg('Deseja mesmo excluir a fórmula tabelada'+#13+cbFormulas.Text+'?',mtconfirmation,[mbYes,MbNo],0)=mryes then
      begin
        qryInserePergunta.Close;
        qryInserePergunta.SQL.Text := ' delete from FORMTABELADAS WHERE CDFIL=4 AND NRORC='+edtOrcamento.Text+' and SERIEO='+quotedstr(edtSerieOrc.Text);
        qryInserePergunta.Open;
        qryInserePergunta.Transaction.CommitRetaining;

        edtOrcamento.Clear;
        edtSerieOrc.Clear;
        qryBuscaOrcCab.Close;

        edtOrcamento.Enabled := false;
        edtSerieOrc.Enabled  := false;
        edtValor.Enabled     := false;
        edtTitulo.Enabled    := false;
        edtNRCRM.Enabled     := false;
        edtPFCRM.Enabled     := false;
        cbUFCrM.Enabled      := false;

        edtOrcamento.Color := clScrollBar;
        edtSerieOrc.Color  := clScrollBar;
        edtValor.Color     := clScrollBar;
        edtTitulo.Color    := clScrollBar;
        edtPFCRM.Color     := clScrollBar;
        edtNRCRM.Color     := clScrollBar;
        cbUFCrM.Color      := clScrollBar;
        cbUFCrM.ItemIndex    := -1;
        cbFormulas.ItemIndex := -1;
        cbFormulas.Clear;

        btIncluir.Enabled := true;
        btCancelar.Enabled := false;

        renovacombo;
        showmessage('Orçamento excluído');
      end;

end;

procedure TfrmDescontoMedico.renovacombo;
begin


   qryTempPrivilege.Close;
   qryTempPrivilege.SQL.Text := 'select NOMEMED from FORMTABELADAS GROUP BY 1 ORDER BY 1';
   qryTempPrivilege.Open;

   cbMedico.Clear;
   cbFormulas.Clear;

   while not(qryTempPrivilege.Eof) do
     begin
       cbMedico.Items.Add(qryTempPrivilege.FieldValues['NOMEMED']);
       qryTempPrivilege.Next;
     end;


  qryTempPrivilege.Close;

  cbMedico.ItemIndex := -1;

end;


procedure TfrmDescontoMedico.btIncluirClick(Sender: TObject);
begin

 edtOrcamento.Enabled := true;
 edtSerieOrc.Enabled  := true;
 edtValor.Enabled     := true;
 edtTitulo.Enabled    := true;
 edtPFCRM.Enabled     := true;
 edtNRCRM.Enabled     := true;
 cbUFCrM.Enabled      := true;


 edtOrcamento.Clear;
 edtSerieOrc.Clear;
 limpacampos;

 edtOrcamento.Color := clWindow;
 edtSerieOrc.Color  := clWindow;
 edtValor.Color     := clWindow;
 edtTitulo.Color    := clWindow;
 edtPFCRM.Color     := clWindow;
 edtNRCRM.Color     := clWindow;
 cbUFCrM.Color      := clWindow;

 btSalvar.Enabled   := true;
 btExcluir.Enabled  := false;
 btCancelar.Enabled := true;
 btIncluir.Enabled  := false;
 btAlteraPreco.Enabled := false;

 cbFormulas.ItemIndex := -1;
 cbUFCrM.ItemIndex    := -1;
 edtOrcamento.SetFocus;

end;


procedure TfrmDescontoMedico.buscaorcamento;
begin

 qryBuscaOrcCab.Transaction.Commit;
 qryBuscaOrcCab.Transaction.Active:=true;


 qryBuscaOrcCab.Close;
 qryBuscaOrcCab.Params[0].Value := edtOrcamento.Text;
 qryBuscaOrcCab.Params[1].Value := edtSerieOrc.Text;
 qryBuscaOrcCab.Open;

 if qryBuscaOrcCab.IsEmpty then
  begin
   qryBuscaOrcCab.Close;
   raise Exception.Create('Orçamento não encontrado');
  end;

 edtPresc1.Text     :='1';
 edtPrescUF.Text    :='PE';
 edtCRM.Text        :='12345';
 edtNomeMed.Text    :='FULANO DE TAL';

 edtForma.Text     := qryBuscaOrcCab.FieldValues['tpformafarma'];
 edtVol.Text       := floattostr(qryBuscaOrcCab.FieldValues['volume']);
 edtUN.Text        := qryBuscaOrcCab.FieldValues['univol'];
 edtUni2.Text      := qryBuscaOrcCab.FieldValues['tpcap'];
 edtCodEmb.Text    := IntToStr(qryBuscaOrcCab.FieldValues['cdemb']);
 edtNomeEmb.Text   := qryBuscaOrcCab.FieldValues['nomeembalagem'];
 edtPosologia.Text := qryBuscaOrcCab.FieldValues['posol'];
 edtQtdPotes.Text  := inttostr(qryBuscaOrcCab.FieldValues['qtfor']);
 edtQtdPrescr.Text := FloatToStr(qryBuscaOrcCab.FieldValues['qtprescr']);
 edtValidade.Text  := FormatDateTime('dd/mm/yyyy',IncMonth(now,4));
 edtGrupoTera.Text := 'Medicamento';
 edtContem.Text    := FloatToStr(qryBuscaOrcCab.FieldValues['qtcont']);
 if qryBuscaOrcCab.FieldValues['unicont']<>null then  edtContem2.Text   := qryBuscaOrcCab.FieldValues['unicont'];


 btSalvar.Enabled   := true;
 btExcluir.Enabled  := true;

end;

procedure TfrmDescontoMedico.btOkClick(Sender: TObject);
begin
 buscaorcamento;
 edtPFCrM.SetFocus;
end;


function trocapponto(texto:string):string;
begin
 Result := StringReplace(texto,',','.',[rfReplaceAll,rfIgnoreCase]);
end;


procedure TfrmDescontoMedico.btSalvarClick(Sender: TObject);
var codformula,tipocom:string;
    qtcpm:integer;
begin

if ((qryBuscaOrcCab.IsEmpty) or (qryBuscaOrcCab.Active=false)) then raise Exception.Create('Erro! Antes de salvar, abra o orçamento');
if trim(edtValor.Text)='' then raise Exception.Create('Erro! Antes de salvar, informe um valor');
if trim(edtTitulo.Text)='' then raise Exception.Create('Erro! Antes de salvar, informe um título');
if trim(edtPFCRM.Text)='' then raise Exception.Create('Erro! Antes de salvar, informe uma profissão');
if trim(edtCRM.Text)='' then raise Exception.Create('Erro! Antes de salvar, informe um CRM');
if trim(cbUFCrM.Text)='' then raise Exception.Create('Erro! Antes de salvar, informe uma UF');

qryMedico.Close;
qryMedico.SQL.Text := 'select * from fc04000 where pfcrm='+quotedstr(edtPFCRM.Text)+' and ufcrm='+QuotedStr(cbUFCrM.Text)+' and NRCRM='+edtNRCRM.Text;
qryMedico.Open;

if qryMedico.IsEmpty then
 begin
   qryMedico.Close;
   raise Exception.Create('Médico não cadastrado no banco de dados');
 end;

 if flagaltera=true then
    tipocom:='Deseja alterar valor da fórmula?'
     else
    tipocom:='Deseja salvar a fórmula como tabelada?';

 if MessageDlg(tipocom,mtconfirmation,[mbYes,MbNo],0)=mryes then
      begin

        qryBuscaOrcDet.FetchAll;
        qryBuscaOrcDet.First;
        qtcpm:=qryBuscaOrcDet.RecordCount;

        qryInserePergunta.Close;
        qryInserePergunta.SQL.Text := 'delete from fc15100 where nrorc='+inttostr(qryBuscaOrcCabcdfil.value)+' and nrorc='+inttostr(qryBuscaOrcCabnrorc.value)+' and serieo='+quotedstr(qryBuscaOrcCabserieo.value);
        qryInserePergunta.Open;
        qryInserePergunta.Transaction.CommitRetaining;

        qryInserePergunta.Close;
        qryInserePergunta.SQL.Text := 'delete from fc15110 where nrorc='+inttostr(qryBuscaOrcCabcdfil.value)+' and nrorc='+inttostr(qryBuscaOrcCabnrorc.value)+' and serieo='+quotedstr(qryBuscaOrcCabserieo.value);
        qryInserePergunta.Open;
        qryInserePergunta.Transaction.CommitRetaining;

        qryInserePergunta.Close;
        qryInserePergunta.SQL.Text := 'update or insert into fc15100 ( cdfil,nrorc, serieo,tpformafarma,volume,univol,tpcap,cdemb,NOMEEMBALAGEM, '+
                                          ' posol,qtfor,qtprescr,grupoterap,qtcont,unicont,indqsp,indreventerico,indusocont,indblister,indliblenta) '+
                                          '  VALUES ('+
                                           inttostr(qryBuscaOrcCabcdfil.value)+','+inttostr(qryBuscaOrcCabnrorc.value)+','+quotedstr(qryBuscaOrcCabserieo.value)+','+inttostr(qryBuscaOrcCabtpformafarma.value)+','+trocapponto(FloatToStr(qryBuscaOrcCabvolume.value))+','+quotedstr(qryBuscaOrcCabunivol.value)+','+
                                           quotedstr(qryBuscaOrcCabtpcap.value)+','+inttostr(qryBuscaOrcCabcdemb.value)+','+quotedstr(qryBuscaOrcCabnomeembalagem.value)+','+quotedstr(qryBuscaOrcCabposol.value)+','+inttostr(qryBuscaOrcCabqtfor.value)+','+trocapponto(floattostr(qryBuscaOrcCabqtprescr.value))+','+
                                           inttostr(qryBuscaOrcCabgrupoterap.value)+','+trocapponto(floattostr(qryBuscaOrcCabqtcont.value))+','+quotedstr(qryBuscaOrcCabunicont.value)+','+quotedstr(qryBuscaOrcCabindqsp.value)+','+quotedstr(qryBuscaOrcCabindreventerico.value)+','+
                                           quotedstr(qryBuscaOrcCabindusocont.value)+','+quotedstr(qryBuscaOrcCabindblister.value)+','+quotedstr(qryBuscaOrcCabindliblenta.value)+')';
           try
            qryInserePergunta.Open;
            qryInserePergunta.Transaction.CommitRetaining;
           except
            qryInserePergunta.Transaction.RollbackRetaining;
            qryInserePergunta.Close;
            raise Exception.Create('Orçamento já foi utilizado como tabelado');
           end;

            while not (qryBuscaOrcDet.Eof) do
             begin
                   qryInserePergunta.Close;
                   qryInserePergunta.SQL.Text := 'update or insert into fc15110 (CDFIL,NRORC,SERIEO,ITEMID,TPCMP,CDPRIN,DESCR,QUANT,UNIDA,VRCMP,PORTA) '+
                                              '  VALUES ('+
                                               inttostr(qryBuscaOrcDetCDFIL.value)+','+inttostr(qryBuscaOrcDetNRORC.value)+','+quotedstr(qryBuscaOrcDetSERIEO.value)+','+inttostr(qryBuscaOrcDetITEMID.Value)+','+QuotedStr(qryBuscaOrcDetTPCMP.value)+','+
                                               IntToStr(qryBuscaOrcDetCDPRIN.value)+','+quotedstr(qryBuscaOrcDetDESCR.value)+','+trocapponto(FloatToStr(qryBuscaOrcDetQUANT.value))+','+quotedstr(qryBuscaOrcDetUNIDA.value)+','+trocapponto(floattostr(qryBuscaOrcDetVRCMP.Value))+','+
                                               quotedstr(qryBuscaOrcDetPORTA.Value)+')';
                   qryInserePergunta.Open;
                   qryInserePergunta.Transaction.CommitRetaining;
                   qryInserePergunta.Close;

                qryBuscaOrcDet.Next;
             end;


        qryCodForm.First;
        codformula:='';

         while not qryCodForm.eof do
           begin
              if qtcpm>1 then
                 codformula:=codformula+inttostr(qryCodForm.FieldValues['CDPRIN'])+'|'                  //composto
                   else
                 codformula:=codformula+inttostr(qryCodForm.FieldValues['CDPRIN'])+'|'+floattostr(qryCodForm.FieldValues['QUANT'])+'|' ;   //monodroga

              qryCodForm.Next;
           end;


        codformula := trim(edtVol.Text)+'-'+codformula;

        qryBuscaOrcDet.First;
        qryInserePergunta.Close;
        qryInserePergunta.SQL.Text := ' UPDATE OR INSERT INTO FORMTABELADAS (CDFIL, NRORC, SERIEO, TITULOFORM, VALFORM, HASHFORM, PFCRM, UFCRM, NRCRM, NOMEMED ) VALUES (4,'+edtOrcamento.Text+','+edtSerieOrc.Text+','+QuotedStr(edtTitulo.Text)+','+trocapponto(trim(edtValor.Text))+','+QuotedStr(codformula)+','+QuotedStr(edtPFCRM.Text)+','+QuotedStr(cbUFCrM.Text)+','+edtNRCRM.Text+','+quotedstr(qryMedico.FieldValues['nomemed'])+');';
        qryInserePergunta.Open;
        qryInserePergunta.Transaction.CommitRetaining;
        qryInserePergunta.Close;

        renovacombo;

        ShowMessage('Gravada com sucesso!');

        edtOrcamento.Clear;
        edtSerieOrc.Clear;
        qryBuscaOrcCab.Close;


         edtOrcamento.Enabled := false;
         edtSerieOrc.Enabled  := false;
         edtValor.Enabled     := false;
         edtTitulo.Enabled    := false;
         edtPFCRM.Enabled     := false;
         edtNRCRM.Enabled     := false;
         cbUFCrM.Enabled      := false;

         edtOrcamento.Color := clScrollBar;
         edtSerieOrc.Color  := clScrollBar;
         edtValor.Color     := clScrollBar;
         edtTitulo.Color    := clScrollBar;
         edtPFCRM.Color     := clScrollBar;
         edtNRCRM.Color     := clScrollBar;
         cbUFCrM.Color      := clScrollBar;

         btIncluir.Enabled := true;
         btCancelar.Enabled := false;
         cbFormulas.ItemIndex := -1;
         cbUFCrM.ItemIndex    := -1;


        limpacampos;
      end;

end;

procedure TfrmDescontoMedico.cbFormulasChange(Sender: TObject);
begin
 flagaltera:=false;
 qryTempPrivilege.Close;
 qryTempPrivilege.SQL.Text := 'select * from FORMTABELADAS WHERE TITULOFORM='+QuotedStr(cbFormulas.Text)+' and NOMEMED='+QuotedStr(cbMedico.Text) ;
 qryTempPrivilege.Open;

 edtOrcamento.Text := inttostr(qryTempPrivilege.FieldValues['NRORC']);
 edtSerieOrc.Text := inttostr(qryTempPrivilege.FieldValues['SERIEO']);

 buscaorcamento;

 btOk.Enabled      := false;
 btSalvar.Enabled  := false;
 btAlteraPreco.Enabled := true;
 btExcluir.Enabled := true;
 edtValor.Enabled  := false;
 edtValor.Color    := clScrollBar;

 edtValor.Text     := floattostr(qryTempPrivilege.FieldValues['VALFORM']);
 edtTitulo.Text    := qryTempPrivilege.FieldValues['TITULOFORM'];
 edtPFCRM.Text     := qryTempPrivilege.FieldValues['PFCRM'];
 edtNRCrM.Text     := inttostr(qryTempPrivilege.FieldValues['NRCrM']);
 cbUFCrM.ItemIndex := cbUFCrM.Items.IndexOf(qryTempPrivilege.FieldValues['UFCRM']);

 qryTempPrivilege.Close;

end;

procedure TfrmDescontoMedico.cbMedicoChange(Sender: TObject);
begin

   qryTempPrivilege.Close;
   qryTempPrivilege.SQL.Text := 'select * from FORMTABELADAS WHERE NOMEMED='+quotedstr(cbMedico.Text)+' ORDER BY TITULOFORM';
   qryTempPrivilege.Open;

   cbFormulas.Clear;

   if not(qryTempPrivilege.IsEmpty) then
     while not(qryTempPrivilege.Eof) do
       begin
         cbFormulas.Items.Add(qryTempPrivilege.FieldValues['TITULOFORM']);
         qryTempPrivilege.Next;
       end;

   qryTempPrivilege.Close;

 limpacampos;
 edtOrcamento.Text  :='';
 edtSerieOrc.Text   :='';

end;

procedure TfrmDescontoMedico.edtOrcamentoChange(Sender: TObject);
begin
  limpacampos;

  if ( trim(edtOrcamento.Text) <> '' ) and (trim(edtSerieOrc.Text) <> '' ) then
   btOk.Enabled := true
    else
   btOk.Enabled := false;

end;

procedure TfrmDescontoMedico.edtValorKeyPress(Sender: TObject; var Key: Char);

Procedure FormatarComoMoeda( Componente : TObject; var Key: Char );
var
   str_valor  : String;
   dbl_valor  : double;
begin

   { verificando se estamos recebendo o TEdit realmente }
   IF Componente is TEdit THEN
   BEGIN
      { se tecla pressionada e' um numero, backspace ou del deixa passar }
      IF CharInSet( Key, ['0'..'9', #8, #9] ) THEN
      BEGIN
         { guarda valor do TEdit com que vamos trabalhar }
         str_valor := TEdit( Componente ).Text ;
         { verificando se nao esta vazio }
         IF str_valor = EmptyStr THEN str_valor := '0,00' ;
         { se valor numerico ja insere na string temporaria }
         IF CharInSet(Key, ['0'..'9']) THEN str_valor := Concat( str_valor, Key ) ;
         { retira pontos e virgulas se tiver! }
         str_valor := Trim( StringReplace( str_valor, '.', '', [rfReplaceAll, rfIgnoreCase] ) ) ;
         str_valor := Trim( StringReplace( str_valor, ',', '', [rfReplaceAll, rfIgnoreCase] ) ) ;
         {inserindo 2 casas decimais}
         dbl_valor := StrToFloat( str_valor ) ;
         dbl_valor := ( dbl_valor / 100 ) ;

         {reseta posicao do tedit}
         TEdit( Componente ).SelStart := Length( TEdit( Componente ).Text );
         {retornando valor tratado ao TEdit}
         TEdit( Componente ).Text := FormatFloat( '###,##0.00', dbl_valor ) ;
      END;
      {se nao e' key relevante entao reseta}
      IF NOT CharInSet( Key, [#8, #9] ) THEN key := #0;
   END;

end;

begin
     FormatarComoMoeda( sender, Key );
end;

procedure TfrmDescontoMedico.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if key=#13 then
  begin
   Key := #0;
   Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmDescontoMedico.FormShow(Sender: TObject);
begin

limpacampos;
edtOrcamento.Text := '';
edtSerieOrc.Text  := '';
renovacombo;

end;

procedure TfrmDescontoMedico.qryBuscaOrcCabAfterClose(DataSet: TDataSet);
begin
 qryBuscaOrcDet.Close;
end;

procedure TfrmDescontoMedico.qryBuscaOrcCabAfterOpen(DataSet: TDataSet);
begin
 if not(qryBuscaOrcCab.IsEmpty) then
  begin
     qryBuscaOrcDet.Close;
     qryBuscaOrcDet.Params[0].Value := qryBuscaOrcCab.FieldValues['cdfil'];
     qryBuscaOrcDet.Params[1].Value := qryBuscaOrcCab.FieldValues['nrorc'];
     qryBuscaOrcDet.Params[2].Value := qryBuscaOrcCab.FieldValues['serieo'];
     qryBuscaOrcDet.Open;

     qryCodForm.Close;
     qryCodForm.Params[0].Value := qryBuscaOrcCab.FieldValues['cdfil'];
     qryCodForm.Params[1].Value := qryBuscaOrcCab.FieldValues['nrorc'];
     qryCodForm.Params[2].Value := qryBuscaOrcCab.FieldValues['serieo'];
     qryCodForm.Open;


  end else
   begin
        qryBuscaOrcDet.Close;
        qryCodForm.Close;
   end;

end;

end.
