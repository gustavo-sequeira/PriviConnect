unit uCodBarrasGerente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, frxBarCode,
  IBX.IBCustomDataSet, IBX.IBQuery, frxClass;

type
  TfrmCodBarrasGerente = class(TForm)
    cbLojas: TComboBox;
    Label1: TLabel;
    btEmitir: TButton;
    qryFcertaTMP: TIBQuery;
    qryPrivilegeTMP: TIBQuery;
    frxCodBarrasGerente: TfrxReport;
    procedure FormShow(Sender: TObject);
    procedure btEmitirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCodBarrasGerente: TfrmCodBarrasGerente;

implementation

{$R *.dfm}

uses udmDescontos;

procedure TfrmCodBarrasGerente.btEmitirClick(Sender: TObject);

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



procedure confeccionacartao;
VAR qtdcont:integer;
    cnpj,cartao,codfil,descrfil:string;
begin

  codfil:=trim(copy(cbLojas.Text,1,3));

  qryFcertaTMP.Close;
  qryFcertaTMP.SQL.Text:=' select cdfil,descrFIL, nrcnpj from fc01000 where cdfil='+codfil;
  qryFcertaTMP.Open;

  descrfil := qryFcertaTMP.FieldValues['DESCRFIL'];
  cnpj := qryFcertaTMP.FieldValues['NRCNPJ'];
  cnpj:=copy(cnpj,11,4);

  qryPrivilegeTMP.Close;
  qryPrivilegeTMP.SQL.Text:=  'UPDATE CARTGERENTES SET DTALT='+quotedstr(FormatDateTime('dd.mm.yyyy',now))+', USUALT='+quotedstr(usu)+', ATIVO='+QUOTEDSTR('N')+' WHERE CDFIL='+codfil+' and ATIVO='+QUOTEDSTR('S');
  qryPrivilegeTMP.Open;
  qryPrivilegeTMP.Transaction.CommitRetaining;

  qryPrivilegeTMP.Close;
  qryPrivilegeTMP.SQL.Text:=  'SELECT COUNT(*)  AS QTD FROM CARTGERENTES WHERE CDFIL='+codfil;
  qryPrivilegeTMP.Open;

  qtdcont := qryPrivilegeTMP.FieldValues['QTD']+1;

  cartao:='870827'+Format('%.2d', [qtdcont])+cnpj;
  cartao := cartao + ean13(cartao);

  qryPrivilegeTMP.Close;
  qryPrivilegeTMP.SQL.Text:=  'INSERT INTO CARTGERENTES ( NRCARTAO, CDFIL, TITULAR, ATIVO, DTCAD, DTALT, USUCAD, USUALT) VALUES ('+
                             quotedstr( cartao )+','+codfil+','+quotedstr('PRIVILEGE - GERÊNCIA '+descrfil )+','+quotedstr('S')+','+quotedstr(FormatDateTime('dd.mm.yyyy',now))+','+quotedstr(FormatDateTime('dd.mm.yyyy',now))+','+quotedstr(usu)+','+QuotedStr(usu)+')';

  qryPrivilegeTMP.Open;
  qryPrivilegeTMP.Transaction.CommitRetaining;
  qryPrivilegeTMP.Close;


end;

var codbarras,funcionario:string;
    Memo1: TfrxMemoView;

begin
     qryPrivilegeTMP.Close;
     qryPrivilegeTMP.SQL.Text := ' select * from CARTGERENTES where cdfil='+trim(copy(cbLojas.Text,1,3));
     qryPrivilegeTMP.Open;

     if not(qryPrivilegeTMP.IsEmpty) then
        if Application.MessageBox('Cartão já confeccionado. Deseja alterar numero de cartão e bloquear anterior?', 'Confirmação', mb_iconQuestion + mb_YesNo + mb_DefButton2) = mrNo then
           begin
             raise Exception.Create('Emissão abortada');
           end;

     confeccionacartao;

     qryPrivilegeTMP.Close;
     qryPrivilegeTMP.SQL.Text := ' select * from CARTGERENTES where cdfil='+trim(copy(cbLojas.Text,1,3))+' and ATIVO='+quotedstr('S') ;
     qryPrivilegeTMP.Open;

     codbarras :=qryPrivilegeTMP.FieldValues['NRCARTAO'];
     funcionario := qryPrivilegeTMP.FieldValues['TITULAR'];

     Memo1 := frxCodBarrasGerente.FindObject('MemoParam1') as TfrxMemoView;
     Memo1.Text := funcionario;
     Memo1.Font.Size := 9;

     frxCodBarrasGerente.Variables['bar']:=codbarras;
     frxCodBarrasGerente.ShowReport;

end;

procedure TfrmCodBarrasGerente.FormShow(Sender: TObject);
begin

 qryFcertaTMP.Close;
 qryFcertaTMP.SQL.Text := '  select CDFIL, DESCRFIL from FC01000 WHERE GRUPOFIL='+quotedstr('03')+' ORDER BY CDFIL ';
 qryFcertaTMP.Open;

 cbLojas.Clear;

  with qryFcertaTMP do
   begin


     if not(IsEmpty) then
      begin
        First;

        while not Eof do
         begin
          cbLojas.Items.Add(inttostr(FieldValues['CDFIL'])+'  - '+FieldValues['DESCRFIL']);
          Next;
        end;

        cbLojas.ItemIndex := 0;
      end;
      Close;

    end;


end;

end.
