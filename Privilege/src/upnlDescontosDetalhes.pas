unit upnlDescontosDetalhes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, jpeg, {clipbrd ,}
  Data.DB, IBX.IBCustomDataSet, IBX.IBQuery { RotImg} ;

type
  TfrmCortesiaDetalhes = class(TForm)
    gbSolic: TGroupBox;
    Panel2: TPanel;
    Shape3: TShape;
    lblMes: TLabel;
    Panel1: TPanel;
    Shape1: TShape;
    lblTotal: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Panel4: TPanel;
    gbReq: TGroupBox;
    edtSer: TEdit;
    edtReq: TEdit;
    edtFil: TEdit;
    GroupBox1: TGroupBox;
    Panel5: TPanel;
    Shape4: TShape;
    lblAvaliador: TLabel;
    GroupBox2: TGroupBox;
    edtdtSol: TEdit;
    GroupBox3: TGroupBox;
    edthrSol: TEdit;
    GroupBox4: TGroupBox;
    Panel3: TPanel;
    Shape2: TShape;
    lblFunc: TLabel;
    GroupBox5: TGroupBox;
    Panel6: TPanel;
    Shape5: TShape;
    lblDepto: TLabel;
    GroupBox6: TGroupBox;
    edtvrRec: TEdit;
    GroupBox7: TGroupBox;
    edtvrCort: TEdit;
    GroupBox8: TGroupBox;
    Panel7: TPanel;
    Shape6: TShape;
    lblStatus: TLabel;
    GroupBox9: TGroupBox;
    edtHrAva: TEdit;
    GroupBox10: TGroupBox;
    edtDtAva: TEdit;
    edtReceita: TSpeedButton;
    qryBuscaImagem: TIBQuery;
    GroupBox11: TGroupBox;
    Panel8: TPanel;
    Shape7: TShape;
    lblJustificativa: TLabel;
    qrypedidoimagem: TIBQuery;
    procedure edtReceitaClick(Sender: TObject);
    procedure lblJustificativaDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    imagemmoby:boolean;
  end;

var
  frmCortesiaDetalhes: TfrmCortesiaDetalhes;

implementation

{$R *.dfm}

uses uImagemReceita, udmDescontos, ufrmJustificativaDetalhe,
  uSolicCortesiasAbertas;



procedure TfrmCortesiaDetalhes.edtReceitaClick(Sender: TObject);
begin

 // removida em 01/12/2022 - mobyfarma não existe mais
{
  frmCortesiasAbertas.qryTemp.close;
  frmCortesiasAbertas.qryTemp.SQL.Text :='select a.idpedidoomnichannel from fc12100  a  where cdfil='+edtFil.Text+' and nrrqu='+edtReq.Text;
  clipboard.astext := frmCortesiasAbertas.qryTemp.SQL.Text;
  frmCortesiasAbertas.qryTemp.Open;
  }


 qryBuscaImagem.Transaction.Commit;
 qryBuscaImagem.Transaction.Active:=true;

 qryBuscaImagem.Close;
 qryBuscaImagem.SQL.Text := 'select * from FCIMAGEM12000 where cdfil='+edtFil.Text+' and nrrqu='+edtReq.Text;
 //clipboard.astext := qryBuscaImagem.SQL.Text;
 qryBuscaImagem.Open;

{ if qryBuscaImagem.IsEmpty then
    begin
           qryBuscaImagem.Close;
           qryBuscaImagem.SQL.Text :='select * from fcimagem0m000 a  where a.idpedido='+intToStr(frmCortesiasAbertas.qryTemp.FieldValues['idpedidoomnichannel']);
           clipboard.astext := qryBuscaImagem.SQL.Text;
           qryBuscaImagem.Open;
           imagemmoby:=true;
    end
  else if qryBuscaImagem.IsEmpty then raise Exception.Create('Não foi encontrada imagem desta receita');
  }

 if qryBuscaImagem.IsEmpty then raise Exception.Create('Não foi encontrada imagem desta receita');
 qryBuscaImagem.fetchall;
 frmImagemReceita.ShowModal;
 qryBuscaImagem.Close;
end;

procedure TfrmCortesiaDetalhes.lblJustificativaDblClick(Sender: TObject);
begin
 frmJustificativaDetalhe.memoJustificativa.Text := lblJustificativa.Caption;
 frmJustificativaDetalhe.ShowModal;
end;

end.
