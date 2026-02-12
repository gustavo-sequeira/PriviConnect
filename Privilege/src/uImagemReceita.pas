unit uImagemReceita;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, RotImg, Vcl.StdCtrls, jpeg,  Data.DB,
  sLabel, Vcl.Buttons, Vcl.ToolWin, Vcl.ComCtrls;

type
  TfrmImagemReceita = class(TForm)
    ScrollBox1: TScrollBox;
    CoolBar1: TCoolBar;
    btProximo: TSpeedButton;
    btAnterior: TSpeedButton;
    lblImg: TsLabelFX;
    Image1: TImage;
    procedure captura;
    procedure ObtemImagemDoBanco(Campo:TBlobField; imgDestino: TRotateImage);
    procedure FormShow(Sender: TObject);
    procedure btAnteriorClick(Sender: TObject);
    procedure btProximoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImagemReceita: TfrmImagemReceita;

implementation

uses upnlDescontosDetalhes, uSolicCortesiasAbertas;


procedure TfrmImagemReceita.ObtemImagemDoBanco(Campo:TBlobField; imgDestino: TRotateImage);
Var  jpgImg: TJPEGImage;
     stMem: TMemoryStream;
 begin
   if Campo.IsNull then exit;
   jpgImg := TJPEGImage.Create;
   stMem  := TMemoryStream.Create;
   Try
          Campo.SaveToStream(stMem);
          stMem.Position := 0;
          jpgImg.LoadFromStream(stMem);
          imgDestino.Picture.Assign(jpgImg);
   Finally
          stMem.Free;
          jpgImg.Free;
   End;
end;

procedure TfrmImagemReceita.btAnteriorClick(Sender: TObject);
begin

 frmCortesiaDetalhes.qryBuscaImagem.Prior;
 lblImg.Caption := 'IMAGEM '+inttostr(frmCortesiaDetalhes.qryBuscaImagem.RecNo)+' de '+inttostr(frmCortesiaDetalhes.qryBuscaImagem.RecordCount);

 captura;


end;

procedure TfrmImagemReceita.btProximoClick(Sender: TObject);
begin
 frmCortesiaDetalhes.qryBuscaImagem.Next;
 lblImg.Caption := 'IMAGEM '+inttostr(frmCortesiaDetalhes.qryBuscaImagem.RecNo)+' de '+inttostr(frmCortesiaDetalhes.qryBuscaImagem.RecordCount);
 captura;


end;

procedure TfrmImagemReceita.captura;
begin
 { ObtemImagemDoBanco(frmCortesiaDetalhes.qryBuscaImagem.fieldbyname('imagem') as TBlobField ,frmImagemReceita.RotateImage1);
  RotateImage1.Top  := 0;
  RotateImage1.Left := 0;
  ScrollBox1.Top := 0;
  ScrollBox1.Left := 0;}
   if frmCortesiaDetalhes.imagemmoby=false then Image1.Picture.Assign( TGraphicField(frmCortesiaDetalhes.qrybuscaImagem.FieldByName('Imagem'))) else Image1.Picture.Assign( TGraphicField(frmCortesiaDetalhes.qrybuscaImagem.FieldByName('CONTEUDOARQWEB')));
//  Image1.Picture.Assign( TGraphicField(frmCortesiaDetalhes.qrybuscaImagem.FieldByName('Imagem')))
end;

{$R *.dfm}

procedure TfrmImagemReceita.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmCortesiasAbertas.qryTemp.close;
  frmCortesiaDetalhes.qryBuscaImagem.Close;
end;

procedure TfrmImagemReceita.FormShow(Sender: TObject);
begin
 lblImg.Caption := 'IMAGEM '+inttostr(frmCortesiaDetalhes.qryBuscaImagem.RecNo)+' de '+inttostr(frmCortesiaDetalhes.qryBuscaImagem.RecordCount);
 captura;
end;

end.
