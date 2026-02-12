unit uBuscaClienteDesconto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, sSpeedButton,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, sEdit, sLabel, IBX.IBCustomDataSet,   clipbrd,
  IBX.IBQuery;

type
  TfrmBuscaClienteDesconto = class(TForm)
    sLabelFX1: TsLabelFX;
    edtCPF: TsEdit;
    dbCLientes: TDBGrid;
    sLabelFX4: TsLabelFX;
    btCadCampanha: TsSpeedButton;
    dsGrid: TDataSource;
    qryGrid: TIBQuery;
    Button1: TButton;
    procedure btCadCampanhaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCPFChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBuscaClienteDesconto: TfrmBuscaClienteDesconto;

implementation
 uses uAlunosCampanhas;
{$R *.dfm}

procedure TfrmBuscaClienteDesconto.btCadCampanhaClick(Sender: TObject);
begin
qryGrid.Close;
qryGrid.SQL.Text :=' select a.nomecli,a.ddd,a.celular,b.nomecampanha as campanha, '+
                   ' case when a.dtvalidade is null then b.dtvalidade else a.dtvalidade end as dtvalidade, '+
                   ' b.percvar as percv,b.percfor as percf,COALESCE(a.valorfor,0) SALDO'+
                   ' from campanhasclientes a,campanhas b where '+
                   ' a.idcamp=b.idcamp  and '+
                   ' a.cpfcli='+quotedstr(edtCPF.Text);
//clipboard.astext :=qryGrid.SQL.Text;
qryGrid.Open;


if qryGrid.IsEmpty then ShowMessage('Nenhum desconto encontrado para esse CPF');

end;

procedure TfrmBuscaClienteDesconto.Button1Click(Sender: TObject);
begin
  frmAlunosCampanha.showModal;
end;

procedure TfrmBuscaClienteDesconto.edtCPFChange(Sender: TObject);
begin
qryGrid.Close;
end;

procedure TfrmBuscaClienteDesconto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
qryGrid.Close;
end;

procedure TfrmBuscaClienteDesconto.FormShow(Sender: TObject);
begin
edtCPF.Clear;
qryGrid.Close;
end;

end.
