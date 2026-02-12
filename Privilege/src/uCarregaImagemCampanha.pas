unit uCarregaImagemCampanha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, sSpeedButton, Vcl.StdCtrls, jpeg, pngimage,
  sButton, sEdit, sLabel, Vcl.ExtDlgs, sDialogs, Data.DB, IBX.IBCustomDataSet,
  IBX.IBQuery, Vcl.ExtCtrls, acImage, Vcl.Mask, sMaskEdit, sCustomComboEdit,
  sToolEdit;

type
  TfrmCarregaImagemCampanha = class(TForm)
    edtImagem: TsEdit;
    btGravaImagem: TsButton;
    btCarregaImagem: TsSpeedButton;
    lblCampanha: TsLabelFX;
    oppd: TsOpenPictureDialog;
    qryImagem: TIBQuery;
    imgCampanha: TsImage;
    edtEditar: TsButton;
    dtpValidade: TsDateEdit;
    edtVar: TsEdit;
    edtFor: TsEdit;
    sLabelFX1: TsLabelFX;
    sLabelFX2: TsLabelFX;
    sLabelFX3: TsLabelFX;
    edtSaldo: TsEdit;
    procedure btCarregaImagemClick(Sender: TObject);
    procedure btGravaImagemClick(Sender: TObject);
    procedure imgCampanhaDblClick(Sender: TObject);
    procedure edtEditarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCarregaImagemCampanha: TfrmCarregaImagemCampanha;
  idcamp:integer;

implementation

{$R *.dfm}

uses udmDescontos, uImagemEditar, uCadCampanha;

procedure TfrmCarregaImagemCampanha.btCarregaImagemClick(Sender: TObject);
var
//loMemoryStream: TMemoryStream;
lsPath : String ;
begin
  inherited;
  try
  if oppd.Execute then
  begin
    lsPath := oppd.FileName;

   if FileExists(lsPath) then
    begin
     edtImagem.Text:=lsPath;
     imgCampanha.Picture.LoadFromFile(edtImagem.Text);
      {
      loMemoryStream := TMemoryStream.Create;
      loMemoryStream.LoadFromFile(lsPath);

     DM.cdsClienteFOTO.LoadFromStream(loMemoryStream);}
    end;
  end;

  except
//  on e: exception do
//  Mensagem.Erro(´Arquivo seleciona inválido!´, e.message);
end;
end;

procedure TfrmCarregaImagemCampanha.btGravaImagemClick(Sender: TObject);

function TrocaVirgPPto(Valor: string): String;
   var i:integer;
begin
if valor=null then valor:='0';
    if Valor <>'' then begin
        for i := 0 to Length(Valor) do begin
            if Valor[i]=',' then Valor[i]:='.';

        end;
     end;
     Result := valor;
end;

var
 BlobStream: tStream;
 jp:TPngImage;
begin
   BlobStream := nil;
  if trim(edtImagem.Text)='' then
   begin
    qryImagem.Close;
    qryImagem.SQL.Text := 'UPDATE CAMPANHAS set DTVALIDADE='+QuotedStr(FormatDateTime('dd.mm.yyyy',dtpValidade.Date))
    +',percvar='+TrocaVirgPPto(edtVar.Text)
   // +',percvar='+edtVar.Text
    +',percfor='+TrocaVirgPPto(edtFor.Text)
    //+',percfor='+edtFor.Text
    +' where idcamp= '+inttostr(idcamp);
    qryImagem.ExecSQL;
    qryImagem.Transaction.Commit;
    ShowMessage('Atualizado com sucesso');
    frmCadCampanha.qryGrid.Close;
    frmCadCampanha.qryGrid.Transaction.Commit;
    frmCadCampanha.qryGrid.Open;
   end
    else
      begin


        jp:=TPngImage.Create;
        try
          qryImagem.Close;
          jp.LoadFromFile(edtImagem.Text);

          if (jp.Height>475) or (jp.Width>448) then raise Exception.Create('Use uma resolução de até 475 x 448');

          BlobStream := TMemoryStream.Create;
          jp.SaveToStream(BlobStream);

          qryImagem.SQL.Text := 'UPDATE OR INSERT INTO CAMPANHAS (IDCAMP,IMAGEMCARTAO,DTVALIDADE)  VALUES (:IDCAMP, :blob,'+QuotedStr(FormatDateTime('dd.mm.yyyy',dtpValidade.Date))+') ';
          qryImagem.Params[0].Value:=idcamp;
          qryImagem.Params[1].LoadFromStream(BlobStream,ftBlob);
          qryImagem.ExecSQL;
          qryImagem.Transaction.Commit;
          ShowMessage('Gravado com sucesso');
        finally
          jp.Free;
          BlobStream.Free;
        end;
      end;

   close;
end;

procedure TfrmCarregaImagemCampanha.edtEditarClick(Sender: TObject);
begin
 frmEditarCupom.imgCampanha.Picture := imgCampanha.Picture;
 frmEditarCupom.ShowModal;
end;

procedure TfrmCarregaImagemCampanha.imgCampanhaDblClick(Sender: TObject);
begin
 frmEditarCupom.imgCampanha.Picture := imgCampanha.Picture;
 frmEditarCupom.ShowModal;
end;

end.
