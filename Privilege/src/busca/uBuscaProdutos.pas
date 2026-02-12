unit uBuscaProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TfrmBuscaProdutos = class(TForm)
    DBGrid1: TDBGrid;
    ds_grid: TDataSource;
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBuscaProdutos: TfrmBuscaProdutos;
    cdpro,descr:string;

implementation

{$R *.dfm}

uses uDescontoCampanha;

procedure TfrmBuscaProdutos.DBGrid1DblClick(Sender: TObject);
begin
     if Owner=frmDescontoCampanha then
      begin
       cdpro :=inttostr(frmDescontoCampanha.qryProdutos.FieldValues['cdpro']);
       descr :=frmDescontoCampanha.qryProdutos.FieldValues['descr'];
       frmDescontoCampanha.edtCodProd.Text:= cdpro;
       frmDescontoCampanha.EdtProduto.Text:= descr;
       frmDescontoCampanha.EdtProduto.SelectAll;
       frmDescontoCampanha.qryProdutos.Open;
      end;

     frmBuscaProdutos.Close;
end;

procedure TfrmBuscaProdutos.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
   begin
    frmBuscaProdutos.Close;
   end;
end;

procedure TfrmBuscaProdutos.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
   begin

     if Owner=frmDescontoCampanha then
      begin
       cdpro :=inttostr(frmDescontoCampanha.qryProdutos.FieldValues['cdpro']);
       descr :=frmDescontoCampanha.qryProdutos.FieldValues['descr'];
       frmDescontoCampanha.edtCodProd.Text:= cdpro;
       frmDescontoCampanha.EdtProduto.Text:= descr;
       frmDescontoCampanha.EdtProduto.SelectAll;
       frmDescontoCampanha.qryProdutos.Open;
      end;

     frmBuscaProdutos.Close;
   end;
end;

procedure TfrmBuscaProdutos.FormShow(Sender: TObject);
begin

if Owner=frmDescontoCampanha then
  ds_grid.DataSet := frmDescontoCampanha.qryProdutos
   else
  ds_grid.DataSet := frmDescontoCampanha.qryProdutos;

end;

end.
