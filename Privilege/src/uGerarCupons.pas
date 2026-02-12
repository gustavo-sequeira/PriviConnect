unit uGerarCupons;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons, Math, PNGImage,{clipbrd,}
  sBitBtn, sEdit, sLabel, Vcl.Grids, Vcl.DBGrids, IBX.IBCustomDataSet,
  IBX.IBQuery, IBX.IBUpdateSQL, sSpeedButton;

type
  TfrmGerarCupons = class(TForm)
    dbCLientes: TDBGrid;
    sLabelFX4: TsLabelFX;
    edtPasta: TsEdit;
    btGerar: TsBitBtn;
    qryGrid: TIBQuery;
    dsGrid: TDataSource;
    qryGridCPFCLI: TIBStringField;
    qryGridNOMECLI: TIBStringField;
    qryGridINDSELEC: TIntegerField;
    qryGridINDEMITIDO: TIntegerField;
    IBUpdateSQL1: TIBUpdateSQL;
    qryGridIDCAMP: TIntegerField;
    qryGridDDD: TIBStringField;
    qryGridCELULAR: TIBStringField;
    qryTmp: TIBQuery;
    sLabelFX1: TsLabelFX;
    OpenDialog1: TOpenDialog;
    btEscolhePasta: TsSpeedButton;
    procedure dbCLientesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure dbCLientesCellClick(Column: TColumn);
    procedure dbCLientesTitleClick(Column: TColumn);
    procedure dbCLientesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dbCLientesDblClick(Sender: TObject);
    procedure btGerarClick(Sender: TObject);
    procedure btEscolhePastaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGerarCupons: TfrmGerarCupons;
   IsTitleClick : Boolean;
   checatudo:boolean;

implementation

{$R *.dfm}

uses uCadDescontoCliente, udmDescontos, System.UITypes;

procedure TfrmGerarCupons.btEscolhePastaClick(Sender: TObject);
begin
with TFileOpenDialog.Create(nil) do
  try
    Options := [fdoPickFolders];
    if Execute then
      edtPasta.Text:=FileName;
  finally
    Free;
  end;
end;

procedure TfrmGerarCupons.btGerarClick(Sender: TObject);
var
  PNGImage: TPNGImage;
  PNGImageAlterado: TPNGImage;
  BlobStream: TStream;
  i,p:integer;
  nomecliente,nometemp1,nometemp2,nometemp3:string;
begin
 PNGImageAlterado := nil;
 PNGImage := nil;
 BlobStream := nil;
 p := 0;
if DirectoryExists(edtPasta.Text)=false then raise Exception.Create('Escolha uma pasta válida para salvar os cupons');

 qryGrid.First;

 qryTmp.Close;
 qryTmp.SQL.Text:='select * from campanhas where idcamp='+inttostr(qryGrid.FieldValues['idcamp']);
 qryTmp.Open;

 if qryTmp.IsEmpty then raise Exception.Create('Sem imagem relacionada a campanha');

 try
   BlobStream := qryTmp.CreateBlobStream(qryTmp.FieldByName('IMAGEMCARTAO'), bmRead);
   PNGImage := TPNGImage.Create;
   PNGImage.LoadFromStream(BlobStream);
   PNGImageAlterado := TPNGImage.Create;
   PNGImageAlterado.Canvas.Brush.Style := bsClear;


       while not qryGrid.Eof do
        begin
          if qryGrid.FieldValues['indselec']=1 then
           begin

                 PNGImageAlterado.Assign(PNGImage);
                 if qryTmp.FieldValues['indcpf']='S' then
                  begin

                    PNGImageAlterado.Canvas.Font.Name := qryTmp.FieldValues['fontecpf'];
                    PNGImageAlterado.Canvas.Font.Color := StringToColor(qryTmp.FieldValues['fontecorcpf']);
                    PNGImageAlterado.Canvas.Font.Size := qryTmp.FieldValues['fontetamanhocpf'];
                    if qryTmp.FieldValues['indnegritocpf']='S' then PNGImageAlterado.Canvas.Font.Style := [fsbold];
                    if qryTmp.FieldValues['inditalicocpf']='S' then PNGImageAlterado.Canvas.Font.Style := PNGImageAlterado.Canvas.Font.Style+[fsitalic];
                    //PNGImage.Canvas.Font.Color := qryTmp.FieldValues['fontetamanhocpf'];
                     PNGImageAlterado.Canvas.TextOut(qryTmp.FieldValues['posxcpf'],qryTmp.FieldValues['posycpf'], qryGrid.FieldValues['cpfcli']);

                  end;


                 if qryTmp.FieldValues['indnome']='S' then
                  begin

                    PNGImageAlterado.Canvas.Font.Name := qryTmp.FieldValues['fontenome'];
                    PNGImageAlterado.Canvas.Font.Color := StringToColor(qryTmp.FieldValues['fontecornome']);
                    PNGImageAlterado.Canvas.Font.Size := qryTmp.FieldValues['fontetamanhonome'];
                    if qryTmp.FieldValues['indnegritonome']='S' then PNGImageAlterado.Canvas.Font.Style := [fsbold];
                    if qryTmp.FieldValues['inditaliconome']='S' then PNGImageAlterado.Canvas.Font.Style := PNGImageAlterado.Canvas.Font.Style+[fsitalic];

                    if length(qryGrid.FieldValues['nomecli'])<=qryTmp.FieldValues['caracterqtdnome'] then
                       PNGImageAlterado.Canvas.TextOut(qryTmp.FieldValues['posxnome'], qryTmp.FieldValues['posynome'], qryGrid.FieldValues['nomecli'])
                         else
                           begin
                            nomecliente:=qryGrid.FieldValues['nomecli'];
                            nometemp1:='';
                            nometemp2:='';
                            nometemp3:='';

                            for i:=1 to qryTmp.FieldValues['caracterqtdnome'] do
                              begin
                               if i<=length(nomecliente) then   nometemp1:=nometemp1+nomecliente[i];
                               p:=i;
                              end;

                            if nomecliente[p+1]=' ' then
                             begin
                                for i:=p+1 to qryTmp.FieldValues['caracterqtdnome']+p+1 do
                                  begin
                                   if i<=length(nomecliente) then   nometemp2:=nometemp2+nomecliente[i];
                                   p:=i;
                                  end;

                             end
                              else
                                begin
                                  for i:=p downto 1 do
                                    begin
                                     p:=i;
                                     if nomecliente[i]=' ' then
                                       begin
                                        break;
                                       end
                                        else
                                          begin
                                            delete(nometemp1,length(nometemp1),1);
                                          end;
                                    end;

                                for i:=p+1 to qryTmp.FieldValues['caracterqtdnome']+p+1 do
                                  begin
                                   if i<=length(nomecliente) then   nometemp2:=nometemp2+nomecliente[i];
                                   p:=i;
                                  end;


                                end;


                           if p<length(trim(nomecliente)) then
                            if nomecliente[p+1]=' ' then
                             begin
                                for i:=p+1 to qryTmp.FieldValues['caracterqtdnome']+p+1 do
                                  begin
                                   if i<=length(nomecliente) then   nometemp3:=nometemp3+nomecliente[i];
                                   p:=i;
                                  end;

                             end
                              else
                                begin

                                  for i:=p downto 1 do
                                    begin
                                     p:=i;
                                     if nomecliente[i]=' ' then
                                       begin
                                        break;
                                       end
                                        else
                                          begin
                                            delete(nometemp2,length(nometemp2),1);
                                          end;
                                    end;

                                for i:=p+1 to qryTmp.FieldValues['caracterqtdnome']+p+1 do
                                  begin
                                   if i<=length(nomecliente) then   nometemp3:=nometemp3+nomecliente[i];
                                   p:=i;
                                  end;


                                end;

                            case qryTmp.FieldValues['linhanome'] of
                              1: PNGImageAlterado.Canvas.TextOut(qryTmp.FieldValues['posxnome'], qryTmp.FieldValues['posynome'], qryGrid.FieldValues['nomecli']);

                              2: begin
                                   PNGImageAlterado.Canvas.TextOut(qryTmp.FieldValues['posxnome'], qryTmp.FieldValues['posynome'], nometemp1);
                                   PNGImageAlterado.Canvas.TextOut(qryTmp.FieldValues['posxnome2'], qryTmp.FieldValues['posynome2'], nometemp2);
                                 end;

                              3: begin
                                   PNGImageAlterado.Canvas.TextOut(qryTmp.FieldValues['posxnome'], qryTmp.FieldValues['posynome'], nometemp1);
                                   PNGImageAlterado.Canvas.TextOut(qryTmp.FieldValues['posxnome2'], qryTmp.FieldValues['posynome2'], nometemp2);
                                   PNGImageAlterado.Canvas.TextOut(qryTmp.FieldValues['posxnome3'], qryTmp.FieldValues['posynome3'], nometemp3);
                                 end;

                             end;

                           end;

                  end;



                 if qryTmp.FieldValues['indcelular']='S' then
                  begin

                    PNGImageAlterado.Canvas.Font.Name := qryTmp.FieldValues['fontecelular'];
                    PNGImageAlterado.Canvas.Font.Color := StringToColor(qryTmp.FieldValues['fontecorcelular']);
                    PNGImageAlterado.Canvas.Font.Size := qryTmp.FieldValues['fontetamanhocelular'];
                    if qryTmp.FieldValues['indnegritocelular']='S' then PNGImageAlterado.Canvas.Font.Style := [fsbold];
                    if qryTmp.FieldValues['inditalicocelular']='S' then PNGImageAlterado.Canvas.Font.Style := PNGImageAlterado.Canvas.Font.Style+[fsitalic];
                    PNGImageAlterado.Canvas.TextOut(qryTmp.FieldValues['posxcelular'],qryTmp.FieldValues['posycelular'], '('+qryGrid.FieldValues['DDD']+') '+qryGrid.FieldValues['CELULAR']);

                  end;



                  PNGImageAlterado.SaveToFile(edtPasta.Text+'\'+qryGrid.FieldValues['nomecli']+'.png');

           end;

           qryGrid.Next;
        end;

    showmessage('Cupons salvos com sucesso!');
   finally
     qryTmp.Close;
     BlobStream.Free;
     PNGImageAlterado.Free;
     PNGImage.Free;
    end;
end;

procedure TfrmGerarCupons.dbCLientesCellClick(Column: TColumn);
var
  Pt: TPoint;
  Coord: TGridCoord;
  ClickCol: Integer;
begin

  Pt := dbCLientes.ScreenToClient(Mouse.CursorPos);
  Coord := dbCLientes.MouseCoord(Pt.X, Pt.Y);
  ClickCol := Coord.X;

  if not(qryGrid.IsEmpty) and (qryGrid.Active=true) then

  if ClickCol=3 then
   begin

      dsGrid.Dataset.Edit;

      dsGrid.Dataset.FieldByName('INDSELEC').AsInteger :=
        IfThen(dsGrid.Dataset.FieldByName('INDSELEC').AsInteger = 1, 0, 1);

      dsGrid.Dataset.Post;

   end;

end;

procedure TfrmGerarCupons.dbCLientesDblClick(Sender: TObject);
var
  Pt: TPoint;
  Coord: TGridCoord;
  ClickCol: Integer;
begin

  Pt := dbCLientes.ScreenToClient(Mouse.CursorPos);
  Coord := dbCLientes.MouseCoord(Pt.X, Pt.Y);
  ClickCol := Coord.X;


 if IsTitleClick then
   begin

    if ClickCol=3 then
     begin
       checatudo:=not(checatudo);

       if checatudo=true then
        begin
           qryTmp.Close;
           qryTmp.SQL.Text:='update campanhasclientes set indselec=1 where idcamp='+inttostr(qryGrid.FieldValues['idcamp']);
           qryTmp.ExecSQL;
           qryTmp.Transaction.CommitRetaining;
        end else
          begin
           qryTmp.Close;
           qryTmp.SQL.Text:='update campanhasclientes set indselec=0 where idcamp='+inttostr(qryGrid.FieldValues['idcamp']);
           qryTmp.ExecSQL;
           qryTmp.Transaction.CommitRetaining;
          end;

       qryGrid.Close;
       qryGrid.Open;
     end;

   end ;

end;

procedure TfrmGerarCupons.dbCLientesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Check: Integer;
  R: TRect;
begin
  inherited;

  if ((Sender as TDBGrid).DataSource.Dataset.IsEmpty) then
    Exit;

  // Desenha um checkbox no dbgrid
  if Column.FieldName = 'INDSELEC' then
  begin
    TDBGrid(Sender).Canvas.FillRect(Rect);

    if ((Sender as TDBGrid).DataSource.Dataset.FieldByName('INDSELEC').AsInteger = 1) then
      Check := DFCS_CHECKED
    else
      Check := 0;

    R := Rect;
    InflateRect(R, -2, -2); { Diminue o tamanho do CheckBox }
    DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON,
      DFCS_BUTTONCHECK or Check);
  end;

end;

procedure TfrmGerarCupons.dbCLientesMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 IsTitleClick := False;
end;

procedure TfrmGerarCupons.dbCLientesTitleClick(Column: TColumn);
begin
 IsTitleclick := True ;
end;

procedure TfrmGerarCupons.FormShow(Sender: TObject);
begin
 checatudo:=false;

 qryTmp.Close;
 qryTmp.SQL.Text:='update campanhasclientes set indselec=0 where idcamp='+inttostr(frmCadDescontoCliente.qryGrid.FieldValues['idcamp']);
 qryTmp.ExecSQL;
 qryTmp.Transaction.Commit;
 qryTmp.Transaction.Active:=true;
 qryTmp.Close;

 qryGrid.Close;
 qryGrid.SQL.Text := frmCadDescontoCliente.qryGrid.SQL.Text;
 qryGrid.Open;

end;

end.
