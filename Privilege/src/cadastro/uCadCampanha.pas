unit uCadCampanha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, IBX.IBCustomDataSet,  pngimage,
  IBX.IBQuery, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, sSpeedButton, Vcl.StdCtrls,
  sEdit, sLabel, Vcl.Menus, sBitBtn, Vcl.Mask, sMaskEdit, sCustomComboEdit,
  sToolEdit, sRadioButton, sGroupBox;

type
  TfrmCadCampanha = class(TForm)
    sLabelFX3: TsLabelFX;
    edtNomeCampanha: TsEdit;
    dsGrid: TDataSource;
    DBGrid1: TDBGrid;
    qryGrid: TIBQuery;
    qryInsert: TIBQuery;
    PopupMenu1: TPopupMenu;
    E1: TMenuItem;
    btCadastrar: TsBitBtn;
    sLabelFX2: TsLabelFX;
    dtpValidade: TsDateEdit;
    gbTipoDesc: TsGroupBox;
    sLabelFX6: TsLabelFX;
    sLabelFX1: TsLabelFX;
    edtPercVar: TsEdit;
    edtPercFor: TsEdit;
    rbPerc: TsRadioButton;
    rbValor: TsRadioButton;
    ckVerificaSaldo: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure E1Click(Sender: TObject);
    procedure btCadastrarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadCampanha: TfrmCadCampanha;

implementation

{$R *.dfm}

uses udmDescontos, uCadDescontoCliente, uCarregaImagemCampanha, System.UITypes;

procedure TfrmCadCampanha.DBGrid1DblClick(Sender: TObject);
var
  BlobStream: TStream;
   jp:TPngImage;
begin
 if  (not(qryGrid.IsEmpty)  and (qryGrid.active=true))  then
   begin
     idcamp:=qryGrid.FieldValues['idcamp'];
     frmCarregaImagemCampanha.lblcampanha.caption:=qryGrid.FieldValues['CAMPANHA'];

     frmCarregaImagemCampanha.edtVar.Text   := qryGrid.FieldValues['varejo'];
     frmCarregaImagemCampanha.edtFor.Text   := qryGrid.FieldValues['formula'];

     if qryGrid.FieldValues['Saldo'] = null then
        frmCarregaImagemCampanha.edtSaldo.Text := '0,00'
     else
     frmCarregaImagemCampanha.edtSaldo.Text := floattostrf( qryGrid.FieldValues['Saldo'] , ffcurrency, 15, 2);

     frmCarregaImagemCampanha.dtpValidade.Date := qryGrid.FieldValues['dtvalidade'];
     frmCarregaImagemCampanha.imgCampanha.Picture.Assign(nil);

     if qryGrid.FieldValues['imagemcartao']<>null then
       begin
         jp:=TPngImage.Create;
        // BlobStream := TMemoryStream.Create;

         try
          BlobStream := qryGrid.CreateBlobStream(qryGrid.FieldByName('IMAGEMCARTAO'), bmRead);
            try
              jp.LoadFromStream(BlobStream);
              frmCarregaImagemCampanha.imgCampanha.Picture.Assign(Jp);
            finally
              BlobStream.Free;
            end;
          finally
            jp.Free;
         end;
       end;

     frmCarregaImagemCampanha.ShowModal;
   end;
end;

procedure TfrmCadCampanha.E1Click(Sender: TObject);
var idcamp2:integer;
begin

 if not(qryGrid.IsEmpty) then
  begin
   qryInsert.Close;
   qryInsert.SQL.Text :='select a.idcamp,count(a.cpfcli) as QTD from campanhasclientes a,campanhas b where a.idcamp=b.idcamp and b.nomecampanha='+quotedstr(qryGrid.FieldValues['campanha'])+' group by 1' ;
   qryInsert.open;

   if not(qryInsert.IsEmpty) then
    begin
     idcamp2:=qryInsert.FieldValues['idcamp'];
          if MessageDlg('Existem '+inttostr(qryInsert.FieldValues['qtd'])+' clientes cadastrados nessa campanha.'+#13+' Deseja confirmar exclusão da campanha '+qryGrid.FieldValues['campanha']+'?',mtconfirmation,[mbYes,MbNo],0)=mryes then
           begin

               qryInsert.Close;
               qryInsert.SQL.Text :='delete from campanhas where idcamp='+inttostr(idcamp2) ;
               qryInsert.ExecSQL;
               qryInsert.Transaction.CommitRetaining;
               qryGrid.Transaction.Commit;
               qryGrid.Transaction.Active:=true;
               qryGrid.Close;
               qryGrid.Open;

               frmCadDescontoCliente.qryGrid.Close;
               frmCadDescontoCliente.limpacampanhas;
               frmCadDescontoCliente.limpacampos;

               ShowMessage('Campanha exclusa com sucesso!');
           end;
    end
     else
      begin

           qryInsert.Close;
           qryInsert.SQL.Text :='select * from campanhas  where nomecampanha='+quotedstr(qryGrid.FieldValues['campanha']) ;
           qryInsert.open;
           idcamp2:=qryInsert.FieldValues['idcamp'];

          if MessageDlg('Deseja confirmar exclusão da campanha '+qryGrid.FieldValues['campanha']+'?',mtconfirmation,[mbYes,MbNo],0)=mryes then
           begin

               qryInsert.Close;
               qryInsert.SQL.Text :='delete from campanhas where idcamp='+inttostr(idcamp2) ;
               qryInsert.ExecSQL;
               qryInsert.Transaction.CommitRetaining;
               qryGrid.Transaction.Commit;
               qryGrid.Transaction.Active:=true;
               qryGrid.Close;
               qryGrid.Open;

               frmCadDescontoCliente.qryGrid.Close;
               frmCadDescontoCliente.limpacampanhas;
               frmCadDescontoCliente.limpacampos;

               ShowMessage('Campanha exclusa com sucesso!');
           end;
      end;

    qryInsert.Close;
  end;

end;

procedure TfrmCadCampanha.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key =#13 then
   begin
      Key:=#0; // tira o ruído qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;
end;

procedure TfrmCadCampanha.FormShow(Sender: TObject);
begin
   edtNomeCampanha.Clear;
   edtPercVar.Clear;
   edtPercFor.Clear;
   ckVerificaSaldo.Checked := false;
   dtpValidade.Date:=now;

   qryGrid.Transaction.CommitRetaining;
   qryGrid.Close;
   qryGrid.Open;
end;

procedure TfrmCadCampanha.btCadastrarClick(Sender: TObject);
var tpdesc , VerSaldo :string;
begin
if (trim(edtNomeCampanha.Text)<>'')  and (trim(edtPercVar.Text)<>'') and (trim(edtPercFor.Text)<>'')  then
 begin


   if rbPerc.Checked then
     tpdesc:='P'
   else
     tpdesc:='V';

     if trim(edtPercVar.Text)='' then edtPercVar.Text := '0';
     if trim(edtPercFor.Text)='' then edtPercFor.Text := '0';

   if (tpdesc='P') and ( (strtoint(edtPercFor.Text)>99) or ( strtoint(edtPercVar.Text)>99) ) then raise Exception.Create('Não é permitido dar mais de 100% de desconto');

   if ( tpdesc = 'P' ) and ( ckVerificaSaldo.Checked)  then raise Exception.Create('Desconto Percentual, não permite controle de saldo.');

   if ckVerificaSaldo.Checked then  VerSaldo := 'S' else VerSaldo := 'N';

   qryInsert.Close;
   qryInsert.SQL.Text := 'insert into campanhas (nomecampanha,dtcria,percvar,percfor,dtvalidade,tpdesc,saldo,verificaSaldo ) values ('+quotedstr(trim(edtNomeCampanha.Text))+',current_date,'+edtPercVar.Text+','+edtPercFor.Text+','+quotedstr(FormatDateTime('dd.mm.yyyy',dtpValidade.Date))+','+quotedstr(tpdesc)+',0,'+quotedstr(VerSaldo)+')';
   qryInsert.ExecSQL;
   qryInsert.Transaction.CommitRetaining;

   qryGrid.Transaction.Commit;
   qryGrid.Transaction.Active:=true;
   qryGrid.Close;
   qryGrid.Open;

   edtNomeCampanha.Clear;
   edtPercVar.Clear;
   edtPercFor.Clear;
   ckVerificaSaldo.Checked := false;

   with frmCadDescontoCliente do
    begin

       qryTmp.Close;
       qryTmp.SQL.Text := 'select nomecampanha from campanhas';
       qryTmp.Open;

       if not(qryTmp.IsEmpty) then
        begin

          cbCampanhaNome.Clear;
          while not qryTmp.Eof do
           begin
            cbCampanhaNome.Items.Add(qryTmp.FieldValues['nomecampanha']);
            qryTmp.Next;
           end;

        end;

    end;

    ShowMessage('Cadastrado com sucesso');

 end
  else
    ShowMessage('Preencha todos os campos');
end;

end.
