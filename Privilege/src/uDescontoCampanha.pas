unit uDescontoCampanha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, IBX.IBCustomDataSet,
  IBX.IBQuery, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, sSpeedButton, Vcl.ExtCtrls,
  sPanel, sComboBox, sGroupBox, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, sMaskEdit,
  sCustomComboEdit;

type
  TfrmDescontoCampanha = class(TForm)
    dbgAtivosMon: TDBGrid;
    GroupBox1: TsGroupBox;
    edtProduto: TEdit;
    edtCodProd: TEdit;
    GroupBox2: TsGroupBox;
    cbMalotesaFrente: TsComboBox;
    Panel1: TsPanel;
    btExcluir: TsSpeedButton;
    btIncluir: TsBitBtn;
    qryProdMon: TIBQuery;
    qryManutencaoAtivos: TIBQuery;
    dsProdMon: TDataSource;
    qryProdutos: TIBQuery;
    procedure btIncluirClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure edtCodProdKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProdChange(Sender: TObject);
    procedure edtProdutoChange(Sender: TObject);
    procedure edtProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDescontoCampanha: TfrmDescontoCampanha;

implementation

{$R *.dfm}

uses uBuscaProdutos, System.UITypes;

procedure TfrmDescontoCampanha.btExcluirClick(Sender: TObject);
begin
 if not(qryProdMon.IsEmpty) then
  if MessageDlg( 'Deseja excluir a matéria prima '+qryProdMon.FieldValues['produto']+' de Formulas Especiais?',mtconfirmation,[mbYes,MbNo],0)=mryes then
   begin
     qryManutencaoAtivos.Close;
     qryManutencaoAtivos.SQL.Text := 'delete from FORMESPECIAIS where cdpro='+inttostr(qryProdMon.FieldValues['COD']);
     qryManutencaoAtivos.Open;
     qryManutencaoAtivos.Transaction.CommitRetaining;

     qryProdMon.Close;
     qryProdMon.Transaction.CommitRetaining;
     qryProdMon.Close;
     qryProdMon.Open;
     ShowMessage('Matéria prima excluída com sucesso!');
     qryManutencaoAtivos.Close;
   end;

end;

procedure TfrmDescontoCampanha.btIncluirClick(Sender: TObject);
begin
 if (not(qryProdutos.IsEmpty)) then
  begin

   try
     qryManutencaoAtivos.Close;
     qryManutencaoAtivos.SQL.Text := 'insert into FORMESPECIAIS (cdpro,descr,malotesamais) values ('+edtCodProd.Text+','+quotedstr(edtProduto.Text)+','+cbMalotesaFrente.Text+')';
     qryManutencaoAtivos.Open;
     qryManutencaoAtivos.Transaction.CommitRetaining;


     qryProdMon.Close;
     qryProdMon.Transaction.CommitRetaining;
     qryProdMon.Close;
     qryProdMon.Open;

     edtCodProd.Clear;
     edtProduto.Clear;

     edtCodProd.Color := clScrollBar;
     edtProduto.Color := clWindow;

     ShowMessage('Produto marcado como formula especial com sucesso');
    except
     qryManutencaoAtivos.Transaction.RollbackRetaining;
     ShowMessage('Erro! Verifique se o produto já se encontra cadastrado');
    end;

     qryManutencaoAtivos.Close;
  end;
end;

procedure TfrmDescontoCampanha.edtCodProdChange(Sender: TObject);
begin
// edtProduto.Clear;
 edtCodProd.Color := clWindow;
 edtProduto.Color := clScrollBar;
 qryProdutos.Close;
end;

procedure TfrmDescontoCampanha.edtCodProdKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not CharInSet(Key, ['0'..'9', #8, #13]) then
   begin
     edtCodProd.Clear;
     edtCodProd.Color := clScrollBar;
     edtProduto.Color := clWindow;
     edtProduto.Text := edtProduto.Text+Key ;
     edtProduto.SetFocus;
     edtProduto.SelStart := length(edtProduto.text);
     key := #0;
   end;


 if CharInSet(Key, [#13]) then
  begin

   qryProdutos.Close;
   qryProdutos.SQL.Text := 'select * from fc03000 where inddel='+QuotedStr('N')+' and grupo='+QuotedStr('M')+' and cdpro='+edtCodProd.Text;
   qryProdutos.Open;

   if (qryProdutos.IsEmpty) and (trim(edtCodProd.Text)<>'' ) then
     ShowMessage('Nenhuma matéria prima encontrada com esse código')
       else
         begin
           edtProduto.Text := qryProdutos.FieldValues['descr'];
           btIncluir.SetFocus;
           qryProdutos.Open;
         end;


  end;
end;

procedure TfrmDescontoCampanha.edtProdutoChange(Sender: TObject);
begin
// edtCodProd.Clear;
 edtCodProd.Color := clScrollBar;
 edtProduto.Color := clWindow;
 qryProdutos.Close;
end;

procedure TfrmDescontoCampanha.edtProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin

 if CharInSet(Key, [#13]) then
  begin

   qryProdutos.Close;
   qryProdutos.SQL.Text := 'select * from fc03000 where inddel='+QuotedStr('N')+' and grupo='+QuotedStr('M')+' and descr='+quotedstr(edtProduto.Text);
   qryProdutos.Open;

   if (qryProdutos.IsEmpty) and (trim(edtCodProd.Text)<>'' ) then
     ShowMessage('Nenhuma matéria prima encontrada com essa descricao')
       else
        begin
         edtCodProd.Text := inttostr(qryProdutos.FieldValues['cdpro']);
         btIncluir.SetFocus;
         qryProdutos.Open;
        end;
  end;

end;

procedure TfrmDescontoCampanha.edtProdutoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_TAB then
  begin
    qryProdutos.Close;
    qryProdutos.SQL.Text:='select * from fc03000 where inddel='+QuotedStr('N')+' and grupo='+QuotedStr('M')+' and descr like '+QuotedStr(trim(edtProduto.Text)+'%') + ' order by descr';
    qryProdutos.Open;
    qryProdutos.First;
    if qryProdutos.IsEmpty then ShowMessage('Nenhuma matéria prima encontrada com essa descrição') else
    frmBuscaProdutos.ShowModal;
  end;
end;

procedure TfrmDescontoCampanha.FormShow(Sender: TObject);
begin
 edtProduto.Clear;
 edtCodProd.Clear;
 edtCodProd.Color := clWindow;
 edtProduto.Color := clScrollBar;
 edtCodProd.SetFocus;
 qryProdMon.Transaction.CommitRetaining;
 qryProdMon.Close;
 qryProdMon.Open;
end;

end.
