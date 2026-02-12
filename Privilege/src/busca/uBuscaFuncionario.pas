unit uBuscaFuncionario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids;

type
  TfrmBuscaFuncionario = class(TForm)
    DBGrid1: TDBGrid;
    ds_grid: TDataSource;
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
  frmBuscaFuncionario: TfrmBuscaFuncionario;
  matr,nomefun:string;


implementation

uses uCodBarras;

{$R *.dfm}

procedure TfrmBuscaFuncionario.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
var nrcrm:integer;
begin
  if (Key = #13) then
   begin

    with  frmCodBarrasMedicos do
     begin
      matr    := qryCodBMedicos.FieldValues['nrmat'];
      nrcrm := qryCodBMedicos.FieldValues['nrmat'];
      nomefun := qryCodBMedicos.FieldValues['nomefun'];
      qryCodBMedicos.Open;
      mat := '00'+codestado2(UpperCase(trim(qryCodBMedicos.FieldValues['UFCRM'])))+'0'+qryCodBMedicos.FieldValues['PFCRM']+Format('%.6d', [nrcrm]);
      edtCRM.Text:= matr;
      edtFuncionario.Text:= nomefun;
      edtFuncionario.SelectAll;
      frmBuscaFuncionario.Close;
     end;
   end;
end;

procedure TfrmBuscaFuncionario.DBGrid1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then begin
    frmBuscaFuncionario.Close;
  end;
end;

procedure TfrmBuscaFuncionario.DBGrid1DblClick(Sender: TObject);
begin
     matr :=frmCodBarrasMedicos.qryCodBMedicos.FieldValues['nrmat'];
     nomefun :=frmCodBarrasMedicos.qryCodBMedicos.FieldValues['nomefun'];
     frmCodBarrasMedicos.edtCRM.Text:= matr;
     frmCodBarrasMedicos.edtFuncionario.Text:= nomefun;
     frmCodBarrasMedicos.edtFuncionario.SelectAll;
     frmCodBarrasMedicos.qryCodBMedicos.Open;
     frmBuscaFuncionario.Close;
end;

end.
