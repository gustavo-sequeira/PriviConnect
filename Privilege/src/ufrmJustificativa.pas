unit ufrmJustificativa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmJustificativa = class(TForm)
    GroupBox1: TGroupBox;
    edtJustificativa: TEdit;
    btOk: TButton;
    procedure btOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmJustificativa: TfrmJustificativa;

implementation

{$R *.dfm}

uses uSolicCortesiasAbertas;

procedure TfrmJustificativa.btOkClick(Sender: TObject);
begin

 if trim(edtJustificativa.Text)='' then raise Exception.Create('Insira alguma justificativa');
 justificativa:=edtJustificativa.Text;
 frmJustificativa.Close;

end;

end.
