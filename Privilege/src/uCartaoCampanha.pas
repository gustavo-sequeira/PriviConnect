unit uCartaoCampanha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, sBitBtn,
  Data.DB, IBX.IBCustomDataSet, IBX.IBQuery, frxClass;

type
  TfrmCartaoCampanha = class(TForm)
    btImpCartaoCampanha: TsBitBtn;
    btVincularCartCampanha: TsBitBtn;
    frxCodBarrasCampanha: TfrxReport;
    qryPrivilegeTMP: TIBQuery;
    procedure btImpCartaoCampanhaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCartaoCampanha: TfrmCartaoCampanha;

implementation

uses System.UITypes;

{$R *.dfm}

Function EAN13( CodigoDeBarras : String ) : String;
var nX    : Integer;
 nPeso  : Integer;
   nSoma  : Double;
   nMaior  : Double;
   nDigito : Integer;
 Begin
     nPeso := 3;
     nSoma := 0;
    For nX := 12 DownTo 1 do
      Begin
       nSoma := nSoma + StrToFloat( CodigoDeBarras[ nX ] ) * nPeso;
       If nPeso = 3 Then nPeso := 1
      Else
       nPeso := 3;
 End;
   nMaior      := ( ( Trunc( nSoma / 10 ) + 1 ) * 10 );
   nDigito  := Trunc( nMaior ) - Trunc( nSoma );
   If nDigito = 10 Then nDigito := 0;
   Result := IntToStr( nDigito );
End;


procedure TfrmCartaoCampanha.btImpCartaoCampanhaClick(Sender: TObject);
var NRcartao:string;
    cartaoid:integer;
    Memo1: TfrxMemoView;
begin

if MessageDlg('Deseja emitir novo cartão campanha?',mtconfirmation,[mbYes,MbNo],0)=mryes then
      begin
        qryPrivilegeTMP.Close;
        qryPrivilegeTMP.SQL.Text:=  'SELECT COALESCE(MAX(idcart),0) AS MAXIDCART FROM CARTCAMPANHA02';
        qryPrivilegeTMP.Open;

        cartaoid:= qryPrivilegeTMP.FieldValues['MAXIDCART'];

        cartaoid:=cartaoid+1;

        nrcartao:='20182706'+Format('%.4d', [cartaoid]);
        nrcartao := nrcartao + ean13(nrcartao);

        qryPrivilegeTMP.Close;
        qryPrivilegeTMP.SQL.Text:=  'INSERT INTO CARTCAMPANHA02 ( IDCAMP, IDCART,NRCARTAO,CPFHABILITADO) VALUES ('+
                                   '0,'+inttostr(cartaoid)+','+quotedstr(nrcartao)+','+quotedstr('00000000000')+')';

        qryPrivilegeTMP.Open;
        qryPrivilegeTMP.Transaction.CommitRetaining;
        qryPrivilegeTMP.Close;


        Memo1 := frxCodBarrasCampanha.FindObject('MemoParam1') as TfrxMemoView;
        Memo1.Text := Format('%.4d', [cartaoid]);
        Memo1.Font.Size := 9;

        frxCodBarrasCampanha.Variables['bar']:=NRcartao;
        frxCodBarrasCampanha.ShowReport;

      end;

end;

end.
