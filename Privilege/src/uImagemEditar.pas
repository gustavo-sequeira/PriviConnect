unit uImagemEditar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, acImage, sPanel,
  Vcl.StdCtrls, sLabel, sComboBox, Vcl.Buttons, sBitBtn, sGroupBox, sFontCtrls,
  sScrollBox, sCheckBox, Vcl.ComCtrls, sUpDown, sEdit, sSpeedButton,
  sColorSelect, Data.DB, IBX.IBCustomDataSet, IBX.IBQuery, sButton, Vcl.Mask,
  sMaskEdit, sCustomComboEdit;

type
  TfrmEditarCupom = class(TForm)
    sGroupBox1: TsGroupBox;
    btCPF: TsBitBtn;
    btNome: TsBitBtn;
    btCelular: TsBitBtn;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    cbFontes: TsFontComboBox;
    sScrollBox1: TsScrollBox;
    imgCampanha: TsImage;
    edtCPFX: TsEdit;
    sUpDown1: TsUpDown;
    sLabel4: TsLabel;
    edtCPFY: TsEdit;
    sUpDown2: TsUpDown;
    sLabel5: TsLabel;
    edtNomeX: TsEdit;
    sUpDown3: TsUpDown;
    sLabel7: TsLabel;
    edtNomeY: TsEdit;
    sUpDown4: TsUpDown;
    sLabel8: TsLabel;
    edtCelularX: TsEdit;
    sUpDown5: TsUpDown;
    sLabel10: TsLabel;
    edtCelularY: TsEdit;
    sUpDown6: TsUpDown;
    sLabel11: TsLabel;
    chkCPF: TsCheckBox;
    chkNome: TsCheckBox;
    chkCelular: TsCheckBox;
    btGravar: TsBitBtn;
    sLabel3: TsLabel;
    edtTamanho: TsEdit;
    sUpDown7: TsUpDown;
    edtNomeL: TsEdit;
    sUpDown8: TsUpDown;
    sLabel6: TsLabel;
    edtNomeC: TsEdit;
    sUpDown9: TsUpDown;
    sLabel9: TsLabel;
    sColorSelect1: TsColorSelect;
    chkNegrito: TsCheckBox;
    chkItalico: TsCheckBox;
    lblCPF: TLabel;
    lblNome: TLabel;
    lblCelular: TLabel;
    lblNome2: TLabel;
    lblNome3: TLabel;
    edtEspaco: TsEdit;
    sUpDown10: TsUpDown;
    sLabel12: TsLabel;
    qryGravaConfig: TIBQuery;
    procedure imgCampanhaClick(Sender: TObject);
    procedure btCPFClick(Sender: TObject);
    procedure btNomeClick(Sender: TObject);
    procedure btCelularClick(Sender: TObject);
    procedure chkCPFClick(Sender: TObject);
    procedure chkNomeClick(Sender: TObject);
    procedure chkCelularClick(Sender: TObject);
    procedure mudafonte;
    procedure cbFontesChange(Sender: TObject);
    procedure sColorSelect1Change(Sender: TObject);
    procedure chkItalicoClick(Sender: TObject);
    procedure chkNegritoClick(Sender: TObject);
    procedure edtTamanhoChange(Sender: TObject);
    procedure edtNomeXChange(Sender: TObject);
    procedure edtNomeYChange(Sender: TObject);
    procedure edtNomeLChange(Sender: TObject);
    procedure edtNomeCChange(Sender: TObject);
    procedure edtCelularXChange(Sender: TObject);
    procedure edtCelularYChange(Sender: TObject);
    procedure edtEspacoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure edtCPFXChange(Sender: TObject);
    procedure edtCPFYChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEditarCupom: TfrmEditarCupom;
  seleccampo,indprim:integer;

implementation

{$R *.dfm}

uses udmDescontos, uCarregaImagemCampanha, System.UITypes;

procedure TfrmEditarCupom.btCPFClick(Sender: TObject);
begin
  seleccampo:=0;
  btCPF.Enabled:=false;
  btNome.Enabled:=true;
  btCelular.Enabled:=true;

  sColorSelect1.ColorValue := lblCPF.Font.Color;
  edtTamanho.Text := inttostr(lblCPF.Font.Size);
  cbFontes.ItemIndex :=  cbFontes.Items.IndexOf(lblCPF.Font.Name);

  if fsbold in lblCPF.Font.Style then
    chkNegrito.Checked:=true
     else
    chkNegrito.Checked:=false;

  if fsItalic in lblCPF.Font.Style then
    chkItalico.Checked:=true
     else
    chkItalico.Checked:=false;

  seleccampo:=1;
end;

procedure TfrmEditarCupom.btGravarClick(Sender: TObject);
var INDCPF, FONTECPF, INDNEGRITOCPF, INDITALICOCPF,INDNOME, FONTENOME, INDNEGRITONOME, INDITALICONOME, INDCELULAR, FONTECELULAR, INDNEGRITOCELULAR, INDITALICOCELULAR,FONTECORCPF,FONTECORNOME,FONTECORCELULAR  :string;
    FONTETAMANHOCPF, POSXCPF, POSYCPF,  FONTETAMANHONOME, POSXNOME,POSXNOME2,POSXNOME3, POSYNOME,POSYNOME2,POSYNOME3, LINHANOME, CARACTERQTDNOME, ESPACAMENTOQTDNOME, FONTETAMANHOCELULAR, POSXCELULAR, POSYCELULAR :integer;
begin

if chkCPF.Checked=true then
  INDCPF:='S'
   else
  INDCPF:='N';

if chkNome.Checked=true then
 INDNOME:='S'
  else
 INDNOME:='N';

if chkCelular.Checked=true then
 INDCELULAR:='S'
  else
 INDCELULAR:='N';

 FONTECPF := lblCPF.Font.Name;
 FONTENOME := lblNome.Font.Name;
 FONTECELULAR := lblCelular.Font.Name;

 FONTECORCPF:= ColorToString(lblCPF.Font.Color);
 FONTECORNOME:= ColorToString(lblNome.Font.Color);
 FONTECORCELULAR:= ColorToString(lblCelular.Font.Color);

 if fsBold in lblCPF.Font.Style then
  INDNEGRITOCPF:='S'
   else
  INDNEGRITOCPF:='N';

 if fsBold in lblNome.Font.Style then
  INDNEGRITONOME:='S'
   else
  INDNEGRITONOME:='N';

 if fsBold in lblCelular.Font.Style then
  INDNEGRITOCELULAR:='S'
   else
  INDNEGRITOCELULAR:='N';

 if fsItalic in lblCPF.Font.Style then
  INDITALICOCPF:='S'
   else
  INDITALICOCPF:='N';

 if fsItalic in lblNome.Font.Style then
  INDITALICONOME:='S'
   else
  INDITALICONOME:='N';

 if fsItalic in lblCelular.Font.Style then
  INDITALICOCELULAR:='S'
   else
  INDITALICOCELULAR:='N';

  FONTETAMANHOCPF     := lblCPF.Font.Size;
  FONTETAMANHONOME    := lblNome.Font.Size;
  FONTETAMANHOCELULAR := lblCelular.Font.Size;

  POSXCPF     := strtoint(edtCPFX.Text);
  POSXNOME    := strtoint(edtNomeX.Text);
  POSXNOME2   := lblNome2.Left;
  POSXNOME3   := lblNome3.Left;
  POSXCELULAR := strtoint(edtCelularX.Text);
  POSYCPF     := strtoint(edtCPFY.Text);
  POSYNOME    := strtoint(edtNomeY.Text);
  POSYNOME2   := lblNome2.Top;
  POSYNOME3   := lblNome3.Top;
  POSYCELULAR := strtoint(edtCelularY.Text);

  LINHANOME := strtoint(edtNomeL.Text);
  CARACTERQTDNOME    := strtoint(edtNomeC.Text);
  ESPACAMENTOQTDNOME := strtoint(edtEspaco.Text);

 qryGravaConfig.Close;
 qryGravaConfig.SQL.Text := 'UPDATE CAMPANHAS '+
'SET INDCPF = '+quotedstr(INDCPF)+','+
'    FONTECPF = '+quotedstr(FONTECPF)+','+
'    INDNEGRITOCPF = '+quotedstr(INDNEGRITOCPF)+','+
'    INDITALICOCPF = '+quotedstr(INDITALICOCPF)+','+
'    FONTETAMANHOCPF = '+inttostr(FONTETAMANHOCPF)+','+
'    POSXCPF = '+inttostr(POSXCPF)+','+
'    POSYCPF = '+inttostr(POSYCPF)+','+
'    INDNOME = '+quotedstr(INDNOME)+','+
'    FONTENOME = '+quotedstr(FONTENOME)+','+
'    INDNEGRITONOME = '+quotedstr(INDNEGRITONOME)+','+
'    INDITALICONOME = '+quotedstr(INDITALICONOME)+','+
'    FONTETAMANHONOME = '+inttostr(FONTETAMANHONOME)+','+
'    POSXNOME = '+inttostr(POSXNOME)+','+
'    POSYNOME = '+inttostr(POSYNOME)+','+
'    POSXNOME2 = '+inttostr(POSXNOME2)+','+
'    POSYNOME2 = '+inttostr(POSYNOME2)+','+
'    POSXNOME3 = '+inttostr(POSXNOME3)+','+
'    POSYNOME3 = '+inttostr(POSYNOME3)+','+
'    LINHANOME = '+inttostr(LINHANOME)+','+
'    CARACTERQTDNOME = '+inttostr(CARACTERQTDNOME)+','+
'    ESPACAMENTOQTDNOME = '+inttostr(ESPACAMENTOQTDNOME)+','+
'    INDCELULAR = '+quotedstr(INDCELULAR)+','+
'    FONTECELULAR = '+quotedstr(FONTECELULAR)+','+
'    INDNEGRITOCELULAR = '+quotedstr(INDNEGRITONOME)+','+
'    INDITALICOCELULAR = '+quotedstr(INDITALICOCELULAR)+','+
'    FONTETAMANHOCELULAR = '+inttostr(FONTETAMANHOCELULAR)+','+
'    POSXCELULAR = '+inttostr(POSXCELULAR)+','+
'    POSYCELULAR = '+inttostr(POSYCELULAR)+','+
'    FONTECORCPF = '+QuotedStr(FONTECORCPF)+','+
'    FONTECORNOME = '+QuotedStr(FONTECORNOME)+','+
'    FONTECORCELULAR = '+QuotedStr(FONTECORCELULAR)+
' WHERE NOMECAMPANHA ='+quotedstr(frmCarregaImagemCampanha.lblCampanha.Caption);

try
 qryGravaConfig.ExecSQL;
 qryGravaConfig.Transaction.CommitRetaining;

 ShowMessage('Gravado com sucesso');

except
 qryGravaConfig.Transaction.RollbackRetaining;
 ShowMessage('Erro ao tentar gravar informações de cupom');

end;
 qryGravaConfig.Close;
end;

procedure TfrmEditarCupom.imgCampanhaClick(Sender: TObject);
var
  Pos: TPoint;
begin
  GetCursorPos(Pos);
  Pos := sScrollBox1.ScreenToClient(Pos);

  if seleccampo=1 then
    begin
     lblCPF.Caption := Format('999.999.999-99', [Pos.x,Pos.y]);
     lblCPF.Top:=Pos.y;
     lblCPF.Left:=Pos.x;
     edtCPFX.Text:= inttostr(Pos.x);
     edtCPFY.Text:= inttostr(Pos.y);
     chkCPF.Checked:=true;
     lblCPF.Visible:=true;
    end;

  if seleccampo=2 then
    begin
     lblNome.Caption := Format('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', [Pos.x,Pos.y]);
     lblNome.Top:=Pos.y;
     lblNome.Left:=Pos.x;
     edtNomeX.Text:= inttostr(Pos.x);
     edtNomeY.Text:= inttostr(Pos.y);
     chkNome.Checked:=true;
     lblNome.Visible:=true;
    end;

  if seleccampo=3 then
    begin
     lblCelular.Caption := Format('(99)99999-9999', [Pos.x,Pos.y]);
     lblCelular.Top:=Pos.y;
     lblCelular.Left:=Pos.x;
     edtCelularX.Text:= inttostr(Pos.x);
     edtCelularY.Text:= inttostr(Pos.y);
     chkCelular.Checked:=true;
     lblCelular.Visible:=true;
    end;

  mudafonte;

end;


procedure TfrmEditarCupom.mudafonte;
var i:integer;
begin

 if seleccampo=1 then
    begin

     lblCPF.Font.Name  := cbFontes.Text;
     lblCPF.Font.Size  := StrToInt(edtTamanho.Text);


     lblCPF.Font.Style:=[];

     if chkNegrito.Checked=true then
        lblCPF.Font.Style := [fsbold];

     if chkItalico.Checked=true then
        lblCPF.Font.Style := lblCPF.Font.Style + [fsitalic];

     lblCPF.Font.Color := sColorSelect1.ColorValue;

    end;


 if seleccampo=2 then
    begin
     lblNome.Font.Name:= cbFontes.Text;
     lblNome.Font.Size:= StrToInt(edtTamanho.Text);

     lblNome.Font.Style:=[];

     if chkNegrito.Checked=true then
        lblNome.Font.Style := [fsbold];

     if chkItalico.Checked=true then
        lblNome.Font.Style := lblNome.Font.Style + [fsitalic];

     lblNome.Font.Color := sColorSelect1.ColorValue;

    end;


 if seleccampo=3 then
    begin
     lblCelular.Font.Name:= cbFontes.Text;
     lblCelular.Font.Size:= StrToInt(edtTamanho.Text);

     lblCelular.Font.Style:=[];

     if chkNegrito.Checked=true then
        lblCelular.Font.Style := [fsbold];

     if chkItalico.Checked=true then
        lblCelular.Font.Style := lblCelular.Font.Style + [fsitalic];

     lblCelular.Font.Color := sColorSelect1.ColorValue;
    end;


     lblNome.Caption := '';
     for i:=1 to strtoint(edtNomeC.Text) do
         lblNome.Caption := lblNome.Caption+'X';

     lblNome2.Caption:=lblNome.Caption;
     lblNome2.Font.Name:= lblNome.Font.Name;
     lblNome2.Font.Size:= lblNome.Font.Size;
     lblNome2.Font.Style:=lblNome.Font.Style;
     lblNome2.Font.Color := lblNome.font.Color;
     lblNome2.Top:=lblNome.Top+lblNome.Height+strtoint(edtEspaco.Text) ;
     lblNome2.Left:=lblNome.Left;

     lblNome3.Caption:=lblNome.Caption;
     lblNome3.Font.Name:= lblNome.Font.Name;
     lblNome3.Font.Size:= lblNome.Font.Size;
     lblNome3.Font.Style:=lblNome.Font.Style;
     lblNome3.Font.Color := lblNome.font.Color;
     lblNome3.Top:=lblNome2.Top+lblNome2.Height+strtoint(edtEspaco.Text) ;
     lblNome3.Left:=lblNome2.Left;


end;

procedure TfrmEditarCupom.edtCelularXChange(Sender: TObject);
begin
     lblCelular.Left := strtoint(edtCelularX.Text);
     lblCelular.Top  := strtoint(edtCelularY.Text);
end;

procedure TfrmEditarCupom.edtCelularYChange(Sender: TObject);
begin
     lblCelular.Left := strtoint(edtCelularX.Text);
     lblCelular.Top  := strtoint(edtCelularY.Text);
end;

procedure TfrmEditarCupom.edtCPFXChange(Sender: TObject);
begin
     lblCPF.Left := strtoint(edtCPFX.Text);
     lblCPF.Top  := strtoint(edtCPFY.Text);
end;

procedure TfrmEditarCupom.edtCPFYChange(Sender: TObject);
begin
     lblCPF.Left := strtoint(edtCPFX.Text);
     lblCPF.Top  := strtoint(edtCPFY.Text);
end;

procedure TfrmEditarCupom.edtEspacoChange(Sender: TObject);
begin
 mudafonte;
end;

procedure TfrmEditarCupom.cbFontesChange(Sender: TObject);
begin
  mudafonte;
end;

procedure TfrmEditarCupom.edtNomeCChange(Sender: TObject);
begin
 mudafonte;
end;

procedure TfrmEditarCupom.edtNomeLChange(Sender: TObject);
begin

if chkNome.Checked=true then
   if edtNomeL.Text='1' then
    begin
      lblNome.Visible:=true;
      lblNome2.Visible:=false;
      lblNome3.Visible:=false;
      sUpDown10.Enabled:=false;
      edtEspaco.Enabled:=false;
      edtEspaco.Color:=clScrollBar;
    end
     else
       if edtNomeL.Text='2' then
          begin
            lblNome.Visible:=true;
            lblNome2.Visible:=true;
            lblNome3.Visible:=false;
            sUpDown10.Enabled:=true;
            edtEspaco.Enabled:=true;
            edtEspaco.Color:=clWindow;
          end
           else
             if edtNomeL.Text='3' then
                begin
                  lblNome.Visible:=true;
                  lblNome2.Visible:=true;
                  lblNome3.Visible:=true;
                  sUpDown10.Enabled:=true;
                  edtEspaco.Enabled:=true;
                  edtEspaco.Color:=clWindow;
                end;

  mudafonte;

end;

procedure TfrmEditarCupom.edtNomeXChange(Sender: TObject);
begin
     lblNome.Left := strtoint(edtNomeX.Text);
     lblNome.Top  := strtoint(edtNomeY.Text);
end;

procedure TfrmEditarCupom.edtNomeYChange(Sender: TObject);
begin
     lblNome.Left := strtoint(edtNomeX.Text);
     lblNome.Top  := strtoint(edtNomeY.Text);
end;

procedure TfrmEditarCupom.edtTamanhoChange(Sender: TObject);
begin
 mudafonte;
end;

procedure TfrmEditarCupom.FormActivate(Sender: TObject);
begin

 if indprim=1 then
   begin
    if qryGravaConfig.FieldValues['fontecorcpf']<>null then lblCPF.font.Color:=StringToColor(qryGravaConfig.FieldValues['fontecorcpf']);
    if qryGravaConfig.FieldValues['fontecornome']<>null then lblNome.font.Color:=StringToColor(qryGravaConfig.FieldValues['fontecornome']);
    if qryGravaConfig.FieldValues['fontecorcelular']<>null then lblCelular.font.Color:=StringToColor(qryGravaConfig.FieldValues['fontecorcelular']);
    qryGravaConfig.Close;
    indprim:=2;
   end;

end;

procedure TfrmEditarCupom.FormCreate(Sender: TObject);
begin
     lblCelular.Caption := '(99)99999-9999';
     lblNome.Caption    := 'XXXXXXXXXXXXXXXXXXXX';
     lblCPF.Caption     := '999.999.999-99';

     lblCPF.Visible:=false;
     lblCelular.Visible:=false;
     lblNome.Visible:=false;

end;

procedure TfrmEditarCupom.FormShow(Sender: TObject);
begin
 indprim:=1;
 qryGravaConfig.Close;
 qryGravaConfig.SQL.Text := 'select * from campanhas where nomecampanha='+quotedstr(frmCarregaImagemCampanha.lblCampanha.Caption);
 qryGravaConfig.Open;

 btCPF.Enabled := true;
 btNome.Enabled := true;
 btCelular.Enabled := true;

 seleccampo:=0;

 if not(qryGravaConfig.IsEmpty) then
  begin

   if qryGravaConfig.FieldValues['indcpf']='S' then chkCPF.Checked:=true;
   if qryGravaConfig.FieldValues['indnome']='S' then chkNome.Checked:=true;
   if qryGravaConfig.FieldValues['indcelular']='S' then chkCelular.Checked:=true;

   if qryGravaConfig.FieldValues['posxcpf']<>null then edtCPFX.Text:=qryGravaConfig.FieldValues['posxcpf'];
   if qryGravaConfig.FieldValues['posycpf']<>null then edtCPFY.Text:=qryGravaConfig.FieldValues['posycpf'];
   if qryGravaConfig.FieldValues['posxnome']<>null then edtNomeX.Text:=qryGravaConfig.FieldValues['posxnome'];
   if qryGravaConfig.FieldValues['posynome']<>null then edtNomeY.Text:=qryGravaConfig.FieldValues['posynome'];
   if qryGravaConfig.FieldValues['posxcelular']<>null then edtCelularX.Text:=qryGravaConfig.FieldValues['posxcelular'];
   if qryGravaConfig.FieldValues['posycelular']<>null then edtCelularY.Text:=qryGravaConfig.FieldValues['posycelular'];

   if qryGravaConfig.FieldValues['espacamentoqtdnome']<>null then edtEspaco.Text:=qryGravaConfig.FieldValues['espacamentoqtdnome'];
   if qryGravaConfig.FieldValues['linhanome']<>null then edtNomeL.Text:=qryGravaConfig.FieldValues['linhanome'];
   if qryGravaConfig.FieldValues['caracterqtdnome']<>null then edtNomeC.Text:=qryGravaConfig.FieldValues['caracterqtdnome'];


   if qryGravaConfig.FieldValues['fontecpf']<>null then lblCPF.font.Name:=trim(qryGravaConfig.FieldValues['fontecpf']);
   if qryGravaConfig.FieldValues['fontenome']<>null then lblNome.font.Name:=trim(qryGravaConfig.FieldValues['fontenome']);
   if qryGravaConfig.FieldValues['fontecelular']<>null then lblCelular.font.Name:=trim(qryGravaConfig.FieldValues['fontecelular']);

   if qryGravaConfig.FieldValues['fontetamanhocpf']<>null then lblCPF.font.Size         := qryGravaConfig.FieldValues['fontetamanhocpf'];
   if qryGravaConfig.FieldValues['fontetamanhonome']<>null then lblNome.font.Size       := qryGravaConfig.FieldValues['fontetamanhonome'];
   if qryGravaConfig.FieldValues['fontetamanhocelular']<>null then lblCelular.font.Size := qryGravaConfig.FieldValues['fontetamanhocelular'];


   if qryGravaConfig.FieldValues['indnegritocpf']='S' then lblCPF.font.Style := [fsbold];
   if qryGravaConfig.FieldValues['indnegritonome']='S' then lblNome.font.Style := [fsbold];
   if qryGravaConfig.FieldValues['indnegritocelular']='S' then lblCelular.font.Style := [fsbold];

   if qryGravaConfig.FieldValues['inditalicocpf']='S' then lblCPF.font.Style := lblCPF.font.Style+[fsitalic] ;
   if qryGravaConfig.FieldValues['inditaliconome']='S' then lblNome.font.Style :=  lblNome.font.Style+[fsitalic] ;
   if qryGravaConfig.FieldValues['inditalicocelular']='S' then lblCelular.font.Style :=  lblCelular.font.Style+[fsitalic] ;


   mudafonte;
  end;


end;

procedure TfrmEditarCupom.sColorSelect1Change(Sender: TObject);
begin
 mudafonte;
end;

procedure TfrmEditarCupom.btNomeClick(Sender: TObject);
begin
  seleccampo:=0;
  btCPF.Enabled:=true;
  btNome.Enabled:=false;
  btCelular.Enabled:=true;

  edtTamanho.Text := inttostr(lblNome.Font.Size);
  sColorSelect1.ColorValue := lblNome.Font.Color;
  cbFontes.ItemIndex :=    cbFontes.Items.IndexOf(lblNome.Font.Name);

  if fsbold in lblNome.Font.Style then
    chkNegrito.Checked:=true
     else
    chkNegrito.Checked:=false;

  if fsItalic in lblNome.Font.Style then
    chkItalico.Checked:=true
     else
    chkItalico.Checked:=false;

  seleccampo:=2;
end;

procedure TfrmEditarCupom.chkCelularClick(Sender: TObject);
begin
if chkCelular.Checked=true then
  lblCelular.Visible:=true
    else
  lblCelular.Visible:=false;
end;

procedure TfrmEditarCupom.chkCPFClick(Sender: TObject);
begin
if chkCPF.Checked=true then
  lblCPF.Visible:=true
    else
  lblCPF.Visible:=false;
end;


procedure TfrmEditarCupom.chkNegritoClick(Sender: TObject);
begin
 mudafonte;
end;

Procedure TfrmEditarCupom.chkNomeClick(Sender: TObject);
begin
if chkNome.Checked=true then
  lblNome.Visible:=true
    else
  lblNome.Visible:=false;
end;

procedure TfrmEditarCupom.btCelularClick(Sender: TObject);
begin
 seleccampo:=0;
 btCPF.Enabled:=true;
 btNome.Enabled:=true;
 btCelular.Enabled:=false;

 edtTamanho.Text := inttostr(lblCelular.Font.Size);
 sColorSelect1.ColorValue := lblCelular.Font.Color;
 cbFontes.ItemIndex :=   cbFontes.Items.IndexOf(lblCelular.Font.Name);

 if fsbold in lblCelular.Font.Style then
  chkNegrito.Checked:=true
   else
  chkNegrito.Checked:=false;

 if fsItalic in lblCelular.Font.Style then
  chkItalico.Checked:=true
   else
  chkItalico.Checked:=false;
 seleccampo:=3;
end;

procedure TfrmEditarCupom.chkItalicoClick(Sender: TObject);
begin
 mudafonte;
end;

end.
