unit uBuscaUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, StdCtrls, Buttons;

type
  TfrmBuscaUsuario = class(TForm)
    btnOk: TBitBtn;
    BtnCancelar: TBitBtn;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnCancelarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    function DEcriptografar(wStri: String): String;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBuscaUsuario: TfrmBuscaUsuario;

implementation

uses uSenha;

{$R *.dfm}

function Criptografar(wStri: String): String;
 var simbolos1,simbolos2:string; //Simbolos : array [0..2] of String;
     x,y : Integer;
begin
  RESULT:='';
  Simbolos1:='KLMNOPQRSTUVXWYZ[\]^_`abcd;<=>?@ABC:+J-./²0423i5';
  Simbolos2:='ABCDEFGHIJKLNMOPQRSTUVWXYZ1234567890!@#$%¨&*()_+';
for x := 1 to Length(Trim(wStri)) do
 begin
  for y := 1 to Length(Trim(Simbolos2)) do
   begin
    if wStri[x]=Simbolos2[y] then Result:=Result+simbolos1[y];
   end;
 end;
end;

function DEcriptografar(wStri: String): String;
 var simbolos1,simbolos2:string; //Simbolos : array [0..2] of String;
     x,y : Integer;
begin
Result:='';
Simbolos1:='ABCDEFGHIJKLNMOPQRSTUVWXYZ1234567890!@#$%¨&*()_+';
Simbolos2:='KLMNOPQRSTUVXWYZ[\]^_`abcd;<=>?@ABC:+J-./²0423i5';
for x := 1 to Length(Trim(wStri)) do
 begin
  for y := 1 to Length(Trim(Simbolos2)) do
   begin
    if wStri[x]=Simbolos2[y] then Result:=Result+simbolos1[y];
   end;
 end;
end;


procedure TfrmBuscaUsuario.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
 begin
   FrmSenha.Usuario.Text:=DEcriptografar(trim(frmSenha.QryUsuarios.FieldValues['nome']));
   FrmSenha.Usuario.SelectAll;
   frmBuscaUsuario.Close;
 end;
end;

procedure TfrmBuscaUsuario.btnOkClick(Sender: TObject);
begin
 FrmSenha.Usuario.Text:=DEcriptografar(trim(frmSenha.QryUsuarios.FieldValues['nome']));
 FrmSenha.Usuario.SelectAll;
 frmBuscaUsuario.Close;
end;

procedure TfrmBuscaUsuario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=caFree;
 frmBuscaUsuario:=nil;
end;

procedure TfrmBuscaUsuario.BtnCancelarClick(Sender: TObject);
begin
 frmBuscaUsuario.Close;
end;

procedure TfrmBuscaUsuario.DBGrid1DblClick(Sender: TObject);
begin
 FrmSenha.Usuario.Text:=DEcriptografar(trim(frmSenha.QryUsuarios.FieldValues['nome']));
 FrmSenha.Usuario.SelectAll;
 frmBuscaUsuario.Close;
end;

procedure TfrmBuscaUsuario.FormShow(Sender: TObject);
begin
 DBGrid1.SetFocus;
end;

function TfrmBuscaUsuario.DEcriptografar(wStri: String): String;
 var simbolos1,simbolos2:string; //Simbolos : array [0..2] of String;
     x,y : Integer;
begin

Result:='';
Simbolos1:='ABCDEFGHIJKLNMOPQRSTUVWXYZ1234567890!@#$%¨&*()_+';
Simbolos2:='KLMNOPQRSTUVXWYZ[\]^_`abcd;<=>?@ABC:+J-./²0423i5';
for x := 1 to Length(Trim(wStri)) do
 begin
  for y := 1 to Length(Trim(Simbolos2)) do
   begin
    if wStri[x]=Simbolos2[y] then Result:=Result+Simbolos1[y];
   end;
 end;

end;


procedure TfrmBuscaUsuario.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);



var
        x : integer;
begin
  x := 0;
        if (gdSelected in state) then
        (sender as TDBGrid).canvas.Brush.Color := $00C08000
        else
        if (sender as TDBGrid).datasource.dataset.RecNo mod 2 = 0 then
        (sender as TDBGrid).canvas.Brush.Color := clAqua - $000b0b0b
        else
        (sender as TDBGrid).canvas.Brush.Color := clAqua - $00010101;

        (sender as TDBGrid).canvas.FillRect(Rect);

        if Column.Field <> nil then
        begin
        case  Column.Alignment of
         taCenter : x := (Rect.Right - Rect.Left) div 2 - (sender as TDBGrid).canvas.TextWidth(Column.Field.asstring) div 2;
         taLeftJustify : x := 0;
         taRightJustify : x := Rect.Right - (sender as TDBGrid).canvas.TextWidth(Column.Field.asstring);
         end;

        (sender as TDBGrid).DefaultDrawing := true;
     if Column.Index=0 then   (sender as TDBGrid).canvas.TextOut(Rect.Left + x,Rect.top,DEcriptografar(Column.Field.asstring))
      else    (sender as TDBGrid).canvas.TextOut(Rect.Left + x,Rect.top,Column.Field.asstring);
        end;

end;

end.
