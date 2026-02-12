unit uBuscaFuncionarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons;

type
  TfrmBuscaFuncionarios = class(TForm)
    btnOk: TBitBtn;
    BtnCancelar: TBitBtn;
    StrGFuncionarios: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure StrGFuncionariosDblClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBuscaFuncionarios: TfrmBuscaFuncionarios;

implementation

uses uCadastroMed;

{$R *.dfm}

procedure TfrmBuscaFuncionarios.FormShow(Sender: TObject);
begin
   StrGFuncionarios.RowCount:=2;
   StrGFuncionarios.Cells[1,0]:='COD';
   StrGFuncionarios.Cells[2,0]:='FUNCIONARIO';
   StrGFuncionarios.Cells[1,1]:='';

   if frmCadMedico.Visible=true then
    begin
      with frmCadMedico.qryConsultora do
       While not Eof do
        begin
          if StrGFuncionarios.Cells[1,1]<>'' then StrGFuncionarios.RowCount:=StrGFuncionarios.RowCount+1;
          StrGFuncionarios.Cells[2,RecNo]:= FieldValues['NOMEfun'];
          StrGFuncionarios.Cells[1,RecNo]:= inttostr(FieldValues['cdfun']);
          Next;
        end;
    end;

  if frmCadMedico.Visible=true then
   begin
     with frmCadMedico.qryConsultora do
       While not Eof do
        begin
          if StrGFuncionarios.Cells[1,1]<>'' then StrGFuncionarios.RowCount:=StrGFuncionarios.RowCount+1;
          StrGFuncionarios.Cells[2,RecNo]:= FieldValues['NOMEfun'];
          StrGFuncionarios.Cells[1,RecNo]:= inttostr(FieldValues['cdfun']);          
          Next;
        end;
   end;

   StrGFuncionarios.SetFocus;

end;

procedure TfrmBuscaFuncionarios.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=VK_ESCAPE then frmBuscaFuncionarios.Close;
end;

procedure TfrmBuscaFuncionarios.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) then
   begin
       if frmCadMedico.Visible=true then
        begin
         frmCadMedico.edtNomeCons.Text:=StrGFuncionarios.Cells[2,StrGFuncionarios.Row];
         frmCadMedico.edtCodCons.Text:=StrGFuncionarios.Cells[1,StrGFuncionarios.Row];
         frmCadMedico.edtNomeCons.SelectAll;
         frmBuscaFuncionarios.Close;
        end;
   end;
end;

procedure TfrmBuscaFuncionarios.StrGFuncionariosDblClick(Sender: TObject);
begin
   if frmCadMedico.Visible=true then
    begin
     frmCadMedico.edtNomeCons.Text:=StrGFuncionarios.Cells[2,StrGFuncionarios.Row];
     frmCadMedico.edtCodCons.Text:=StrGFuncionarios.Cells[1,StrGFuncionarios.Row];
     frmCadMedico.edtNomeCons.SelectAll;
     frmBuscaFuncionarios.Close;
    end;
end;

procedure TfrmBuscaFuncionarios.btnOkClick(Sender: TObject);
begin
   if frmCadMedico.Visible=true then
    begin
     frmCadMedico.edtNomeCons.Text:=StrGFuncionarios.Cells[2,StrGFuncionarios.Row];
     frmCadMedico.edtCodCons.Text:=StrGFuncionarios.Cells[1,StrGFuncionarios.Row];
     frmCadMedico.edtNomeCons.SelectAll;
     frmBuscaFuncionarios.Close;
    end;
end;

procedure TfrmBuscaFuncionarios.BtnCancelarClick(Sender: TObject);
begin
 frmBuscaFuncionarios.Close;
end;

end.
