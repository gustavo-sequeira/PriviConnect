unit uBuscaCupom;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmBuscaCupom = class(TForm)
    edtCupom: TEdit;
    Label1: TLabel;
    edtLoja: TEdit;
    Label2: TLabel;
    btOk: TButton;
    Bevel1: TBevel;
    lblCliente: TLabel;
    lblValor: TLabel;
    procedure btOkClick(Sender: TObject);
    procedure edtLojaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCupomKeyPress(Sender: TObject; var Key: Char);
    procedure edtCupomExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBuscaCupom: TfrmBuscaCupom;

implementation

{$R *.dfm}

uses uDescontoCRM, Data.DB;

procedure TfrmBuscaCupom.btOkClick(Sender: TObject);
var msg:string;

function StrZero(Zeros:string;Quant:integer):String;
var
I,Tamanho:integer;
aux: string;
begin
  aux     := zeros;
  Tamanho := length(ZEROS);
  ZEROS   := '';
  for I:=1 to quant-tamanho do ZEROS := ZEROS + '0';
  aux     := zeros + aux;
  StrZero := aux;
end;


begin

 msg := 'Deseja incluir '+pchar(lblValor.Caption)+' ?';
 if Application.MessageBox( pchar(msg), 'Confirmação', mb_iconQuestion + mb_YesNo + mb_DefButton2) = mrYes then
   begin

       with frmDescontoCRM do
        begin

         qryAchaCupom.Close;
         qryAchaCupom.SQL.Text := ' select * from DESCCLIENTES where cdfil='+inttostr(strtoint(edtLoja.Text)) +' and cpfiscal='+inttostr(strtoint(edtCupom.Text));
         qryAchaCupom.Open;

         if not(qryAchaCupom.IsEmpty) then
          begin
            cdfilatual := qryAchaCupom.FieldValues['cdfil'];
            codbarras :=FormatDateTime('nn',now)+strzero(inttostr(qryAchaCupom.FieldValues['cdfil']),2)+strzero(inttostr( strtoint(edtCupom.Text)  ),6)+'27';
            incluicupom;
            frmBuscaCupom.Close;
          end;


        end;

   end;

end;

procedure TfrmBuscaCupom.edtCupomExit(Sender: TObject);
begin
 if ( (trim(edtCupom.Text)<>'') and (trim(edtLoja.Text)<>'') ) then
   begin

    with frmDescontoCRM do
     begin

         qryAchaCupom.Close;
         qryAchaCupom.SQL.Text := ' select * from DESCCLIENTES where cdfil='+inttostr(strtoint(edtLoja.Text)) +' and cpfiscal='+inttostr(strtoint(edtCupom.Text));

           //                             qryAchaCupom.SQL.Text := ' select * from DESCCLIENTES where CDFIL='+frmPrincipal.edtLoja.Text+' and cpfiscal='+inttostr(strtoint(copy(codbarras,5,6)));
         qryAchaCupom.Open;

         if not(qryAchaCupom.IsEmpty) then
          begin
            lblCliente.Caption := qryAchaCupom.FieldValues['nomecli'];
            lblValor.Caption   := 'Valor Desconto R$ '+floattostr(qryAchaCupom.FieldValues['vrdesc']);
          end
           else
             begin
                lblCliente.Caption := 'Cliente';
                lblValor.Caption   := 'Valor';
             end;

     end;


   end;

end;

procedure TfrmBuscaCupom.edtCupomKeyPress(Sender: TObject; var Key: Char);
begin
  if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;

end;

procedure TfrmBuscaCupom.edtLojaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;

end;

procedure TfrmBuscaCupom.FormShow(Sender: TObject);
begin
    lblCliente.Caption := 'Cliente';
    lblValor.Caption   := 'Valor';
end;

end.
