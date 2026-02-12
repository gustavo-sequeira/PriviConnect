unit uBuscaMedicos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons;

type
  TfrmBuscaMedicos = class(TForm)
    btnOk: TBitBtn;
    BtnCancelar: TBitBtn;
    StrGMedicos: TStringGrid;
    procedure StrGMedicosDblClick(Sender: TObject);
    procedure StrGMedicosKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnOkClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBuscaMedicos: TfrmBuscaMedicos;

implementation

uses usolicitacao, uRelatorio;

{$R *.dfm}

procedure TfrmBuscaMedicos.StrGMedicosDblClick(Sender: TObject);
begin

   if frmRelatorioDesconto.Visible=true then
    begin
     frmRelatorioDesconto.edtCR.Text:=StrGMedicos.Cells[1,StrGMedicos.Row];
     frmRelatorioDesconto.edtNomeMed.Text:=StrGMedicos.Cells[2,StrGMedicos.Row];
     frmRelatorioDesconto.edtNomeMed.SelectAll;
     frmBuscaMedicos.Close;
    end;

  if frmSolicitacao.Visible=true then
   begin
     frmSolicitacao.edtMedico.Text:=StrGMedicos.Cells[1,StrGMedicos.Row];
     frmSolicitacao.edtMedico.SelectAll;
     frmBuscaMedicos.Close;
   end;

end;

procedure TfrmBuscaMedicos.StrGMedicosKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) then
   begin
       if frmRelatorioDesconto.Visible=true then
        begin
         frmRelatorioDesconto.edtCR.Text:=StrGMedicos.Cells[1,StrGMedicos.Row];
         frmRelatorioDesconto.edtNomeMed.Text:=StrGMedicos.Cells[2,StrGMedicos.Row];
         frmRelatorioDesconto.edtNomeMed.SelectAll;
         frmBuscaMedicos.Close;
        end;

      if frmSolicitacao.Visible=true then
       begin
         frmSolicitacao.edtMedico.Text:=StrGMedicos.Cells[1,StrGMedicos.Row];
         frmSolicitacao.edtMedico.SelectAll;
         frmBuscaMedicos.Close;
       end;
   end;
end;

procedure TfrmBuscaMedicos.FormShow(Sender: TObject);
begin
   StrGMedicos.RowCount:=2;
   StrGMedicos.Cells[1,0]:='CRM';
   StrGMedicos.Cells[2,0]:='MEDICOS';
   StrGMedicos.Cells[1,1]:='';

   if frmRelatorioDesconto.Visible=true then
    begin
      with frmRelatorioDesconto.qryPesqMedicos do
       While not Eof do
        begin
          if StrGMedicos.Cells[1,1]<>'' then StrGMedicos.RowCount:=StrGMedicos.RowCount+1;
          StrGMedicos.Cells[1,RecNo]:= inttostr(FieldValues['NRCRM']);
          StrGMedicos.Cells[2,RecNo]:= FieldValues['NOMEMED'];
          Next;
        end;
    end;

  if frmSolicitacao.Visible=true then
   begin
     with frmSolicitacao.qryPesqMedicos do
       While not Eof do
        begin
          if StrGMedicos.Cells[1,1]<>'' then StrGMedicos.RowCount:=StrGMedicos.RowCount+1;
          StrGMedicos.Cells[1,RecNo]:= inttostr(FieldValues['NRCRM']);
          StrGMedicos.Cells[2,RecNo]:= FieldValues['NOMEMED'];
          Next;
        end;
   end;

end;

procedure TfrmBuscaMedicos.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=VK_ESCAPE then frmBuscaMedicos.Close;
end;

procedure TfrmBuscaMedicos.btnOkClick(Sender: TObject);
begin


   if frmRelatorioDesconto.Visible=true then
    begin
     frmRelatorioDesconto.edtCR.Text:=StrGMedicos.Cells[1,StrGMedicos.Row];
     frmRelatorioDesconto.edtNomeMed.Text:=StrGMedicos.Cells[2,StrGMedicos.Row];
     frmRelatorioDesconto.edtNomeMed.SelectAll;
     frmBuscaMedicos.Close;
    end;

  if frmSolicitacao.Visible=true then
   begin
     frmSolicitacao.edtMedico.Text:=StrGMedicos.Cells[1,StrGMedicos.Row];
     frmSolicitacao.edtMedico.SelectAll;
     frmBuscaMedicos.Close;
   end;


end;

procedure TfrmBuscaMedicos.BtnCancelarClick(Sender: TObject);
begin
 frmBuscaMedicos.Close;
end;

end.
