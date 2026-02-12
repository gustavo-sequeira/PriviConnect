unit uEmailCRM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmEmailCRM = class(TForm)
    edtEmail: TEdit;
    procedure edtEmailKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEmailCRM: TfrmEmailCRM;

implementation

{$R *.dfm}

procedure TfrmEmailCRM.edtEmailKeyPress(Sender: TObject; var Key: Char);


function verificaemail(const Value: string): Boolean;

  function CheckAllowed(const s: string): Boolean;
  var i: Integer;
  begin
    Result:= false;
    for i:= 1 to Length(s) do
      if not CharInSet(s[i], ['a'..'z',
                       'A'..'Z', 
                       '0'..'9', 
                       '_', 
                       '-', 
                       '.']) then Exit;
    Result:= true;
  end;

var
  i: Integer;
  NamePart, ServerPart: string;
begin
  Result:= False;
  i:=Pos('@', Value);
  if i=0 then Exit;
  NamePart:=Copy(Value, 1, i-1);
  ServerPart:=Copy(Value, i+1, Length(Value));
  if (Length(NamePart)=0) or ((Length(ServerPart)<5)) then Exit;
  i:=Pos('.', ServerPart);
  if (i=0) or (i>(Length(serverPart)-2)) then Exit;
  Result:= CheckAllowed(NamePart) and CheckAllowed(ServerPart);
end;


begin

 if key=#13 then
   begin
    if trim(edtEmail.Text) <>'' then
     begin
      if verificaemail(edtEmail.Text)=false then raise Exception.Create('Email não é válido')
       else
      frmEmailCRM.Close;
     end;
   end;

end;

procedure TfrmEmailCRM.FormShow(Sender: TObject);
begin
 edtEmail.Clear;
end;

end.
