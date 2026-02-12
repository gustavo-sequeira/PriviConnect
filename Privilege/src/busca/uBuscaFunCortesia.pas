unit uBuscaFunCortesia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TfrmBuscaFuncCortesia = class(TForm)
    DBGrid1: TDBGrid;
    ds_grid: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBuscaFuncCortesia: TfrmBuscaFuncCortesia;
  cdfun,nomefun:string;
implementation

{$R *.dfm}

uses uCortesiaInclusao;

procedure TfrmBuscaFuncCortesia.DBGrid1DblClick(Sender: TObject);
begin
     cdfun   :=inttostr(frmInclusaoCortesia.qryFuncionarios.FieldValues['cdfun']);
     nomefun :=frmInclusaoCortesia.qryFuncionarios.FieldValues['nomefun'];
     frmInclusaoCortesia.edtFuncionario.Text:= nomefun;
     frmInclusaoCortesia.edtCOD.Text:= cdfun;
     frmInclusaoCortesia.edtFuncionario.SelectAll;
     frmInclusaoCortesia.habilita;
     frmBuscaFuncCortesia.Close;
end;

procedure TfrmBuscaFuncCortesia.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then begin
    frmBuscaFuncCortesia.Close;
  end;
end;

procedure TfrmBuscaFuncCortesia.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
   begin

    with  frmInclusaoCortesia do
     begin
      cdfun    := inttostr(qryFuncionarios.FieldValues['cdfun']);
      nomefun := qryFuncionarios.FieldValues['nomefun'];
      edtFuncionario.Text:= nomefun;
      edtCOD.Text:= cdfun;
      edtFuncionario.SelectAll;
      habilita;
      frmBuscaFuncCortesia.Close;
     end;
   end;
end;

procedure TfrmBuscaFuncCortesia.FormShow(Sender: TObject);
begin
 DBGrid1.Columns.Items[0].Width:=65;
 DBGrid1.Columns.Items[1].Width:=300;
end;

end.
