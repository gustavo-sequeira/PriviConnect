unit uAlertas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, StdCtrls, Buttons, DB, strutils,
  IBCustomDataSet, IBQuery;

type
  TfrmAlertas = class(TForm)
    gbEmail: TGroupBox;
    btIncluir: TBitBtn;
    edtEmail: TEdit;
    GroupBox1: TGroupBox;
    dbEmails: TDBGrid;
    Panel1: TPanel;
    btRemover: TBitBtn;
    qryEmailsCadastrados: TIBQuery;
    dsEmails: TDataSource;
    qryTemp: TIBQuery;
    procedure btIncluirClick(Sender: TObject);
    procedure btRemoverClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAlertas: TfrmAlertas;

implementation

uses udmDescontos;

{$R *.dfm}

procedure TfrmAlertas.btIncluirClick(Sender: TObject);

function IsValidEmail(const Email: string) : Boolean; 
const 
  InvalidChar = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸Ò˝¿¬ ‘€√’¡…Õ”⁄«‹—›*;:/\|#$%&*ß!()][{}<>òà¥™∫+π≤≥'; 
var 
  I: Integer;
  C: Integer; 
begin 
  // N„o existe email com menos de 8 caracteres. 
  if Length(Email) < 8 then 
  begin 
    Result := False; 
    Exit; 
  end; 

  // Verificando se h· somente um @ 
  if ((Pos( '@', Email) = 0) or
  (PosEx( '@', Email, Pos('@', Email) + 1) > 0)) then
  begin 
    Result := False; 
    Exit; 
  end; 

  // Verificando se no m?nimo h· um ponto 
  if (Pos('.', Email) = 0) then 
  begin 
    Result := False; 
    Exit; 
  end;

  // N„o pode comeÁar ou terminar com @ ou ponto
  if CharInSet(Email[1], ['@', '.']) or
  CharInSet(Email[Length(Email)], ['@', '.']) then
  begin 
    Result := False; 
    Exit; 
  end; 

  // O @ e o ponto n„o podem estar juntos 
  if (Email[Pos( '@', Email) + 1] = '.') or
  (Email[Pos( '@', Email) - 1] = '.') then
  begin 
    Result := False; 
    Exit; 
  end; 

  // Testa se tem algum caracter inv·lido. 
  for I := 1 to Length(Email) do 
  begin 
    for C := 0 to Length(InvalidChar) do 
      if (Email[I] = InvalidChar[C]) then 
      begin 
        Result := False; 
        Exit; 
      end; 
  end; 

  // Se n„o encontrou problemas, retorna verdadeiro 
  Result := True; 
end; 

begin

 if IsValidEmail(edtEmail.Text)=false then
  begin
    edtEmail.SelectAll;
    edtEmail.SetFocus;
    raise Exception.Create('Email n„o È v·lido');
  end;

 qryTemp.Close;
 qryTemp.SQL.Text := 'update or insert into EMAILSALERT (EMAIL) values ('+
                                   quotedstr(edtEmail.Text)+')';
 qryTemp.Open;
 qryTemp.Transaction.CommitRetaining;
 qryTemp.Close;

 qryEmailsCadastrados.Close;
 qryEmailsCadastrados.Open;

 edtEmail.Clear;
 edtEmail.SetFocus;

 showmessage('Incluso com sucesso!');


end;

procedure TfrmAlertas.btRemoverClick(Sender: TObject);
var pergunta:string;
begin
  if not(qryEmailsCadastrados.IsEmpty) then
  if Application.MessageBox(pchar(pergunta), 'ConfirmaÁ„o', mb_iconQuestion + mb_YesNo + mb_DefButton2) = mrYes then
   begin
     pergunta:='Deseja excluir email : '+qryEmailsCadastrados.FieldValues['email'];
     qryTemp.Close;
     qryTemp.SQL.Text := 'delete from EMAILSALERT where email='+quotedstr(qryEmailsCadastrados.FieldValues['email']);
     qryTemp.Open;
     qryTemp.Transaction.CommitRetaining;
     qryTemp.Close;

     qryEmailsCadastrados.Close;
     qryEmailsCadastrados.Open;

     showmessage('Excluso com sucesso!');
     
   end;
end;

procedure TfrmAlertas.FormShow(Sender: TObject);
begin
  qryEmailsCadastrados.Close;
  qryEmailsCadastrados.sql.Text := 'select email as Email from emailsalert order by 1';
  qryEmailsCadastrados.Open;
  edtEmail.Clear;
  edtEmail.SetFocus;

end;

end.
