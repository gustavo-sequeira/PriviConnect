unit uSolicCortesiasAbertas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, IdAntiFreezeBase, dateutils,
  Vcl.IdAntiFreeze, IdMessage, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,
  IdSMTP, IBX.IBCustomDataSet, IBX.IBQuery, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, sLabel;

type
  TfrmCortesiasAbertas = class(TForm)
    Panel2: TPanel;
    dbgCortesias: TDBGrid;
    dsGrid: TDataSource;
    qrySolicitacoes: TIBQuery;
    qryTemp: TIBQuery;
    qryTempPriv: TIBQuery;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    JvGradientHeaderPanel1: TPanel;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Shape2: TShape;
    GroupBox2: TGroupBox;
    lblValorDisp: TLabel;
    sLabelFX1: TsLabelFX;
    btIncluir: TButton;
    btCancelar: TButton;
    btAprovar: TButton;
    btRejeitar: TButton;
    procedure FormShow(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btAprovarClick(Sender: TObject);
    procedure btRejeitarClick(Sender: TObject);
    procedure dbgCortesiasDrawColumnCell(Sender: TObject; const [Ref] Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgCortesiasDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCortesiasAbertas: TfrmCortesiasAbertas;
  justificativa:string;

implementation

{$R *.dfm}

uses udmDescontos, uCortesiaInclusao, upnlDescontosDetalhes, ufrmJustificativa, System.UITypes;

procedure TfrmCortesiasAbertas.FormShow(Sender: TObject);
var valusa : double;
begin
 frmCortesiasAbertas.Caption := 'Solicitações de Cortesia - '+nomefun;
 valusa:=0;
 if cdfun<>0 then
  begin
      qrySolicitacoes.Close;
      qrySolicitacoes.SQL.Text := 'select coalesce(sum(VALORCORT),0 ) as VALORCORT from soliccortesia where CANCELADO=0 and indapr<>2 and CPFFUNCORT='+quotedstr(cpffun)+' and dtsol between '+quotedstr(FormatDateTime('01.mm.yyyy',now))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',now));
      qrySolicitacoes.Open;
      valusa := qrySolicitacoes.FieldValues['VALORCORT'];
      if valusa>120  then valusa:=120;
  end;

 if cdfun=0 then
   lblValorDisp.Caption := FormatFloat('R$ ###,###,##0.00',0)
     else
   lblValorDisp.Caption := FormatFloat('R$ ###,###,##0.00',120-valusa);

 qrySolicitacoes.Close;
 qrySolicitacoes.Transaction.Commit;
 qrySolicitacoes.Transaction.Active:=true;

 if (copy(usu,1,2)<>'RH') and (copy(usu,1,2)<>'TI') then
  qrySolicitacoes.SQL.Text := 'select * from SOLICCORTESIA WHERE CANCELADO=0 AND INDUSD=0 AND CPFFUNCORT='+quotedstr(cpffun)
   else
  qrySolicitacoes.SQL.Text := 'select * from SOLICCORTESIA WHERE CANCELADO=0 AND INDUSD=0 ';

 qrySolicitacoes.SQL.Add (' and dtsol between '+quotedstr(FormatDateTime('dd.mm.yyyy',IncDay(now,-31)))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',now))    );
 qrySolicitacoes.SQL.Add (' order by CODSOL ');
 qrySolicitacoes.Open;

 dbgCortesias.Columns[0].Width := 250;
 dbgCortesias.Columns[1].Width := 60;
 dbgCortesias.Columns[2].Width := 60;
 dbgCortesias.Columns[3].Width := 70;
end;

procedure TfrmCortesiasAbertas.btIncluirClick(Sender: TObject);
begin
 frmInclusaoCortesia.ShowModal;
end;

procedure TfrmCortesiasAbertas.btRejeitarClick(Sender: TObject);
begin
      if not(qrySolicitacoes.IsEmpty) then
      if MessageDlg('Deseja REJEITAR a solicitação de cortesia de '+qrySolicitacoes.FieldValues['nomefuncort']+'?',mtconfirmation,[mbYes,MbNo],0)=mryes then
        begin
          justificativa:='';
          frmJustificativa.edtJustificativa.Text:='';
          frmJustificativa.ShowModal;
          if justificativa='' then raise Exception.Create('Nenhuma Justificativa foi inserida'+#13+'     Rejeição abortada');

          qryTempPriv.Close;
          qryTempPriv.SQL.Text := 'update soliccortesia set indapr=2, dtaprov='+quotedstr(FormatDateTime('dd.mm.yyyy',now))+', hraprov='+quotedstr(FormatDateTime('hh:nn:ss',now))+',usuapro='+quotedstr(usu)+',justificativa='+quotedstr(justificativa)+'  where codsol='+inttostr(qrySolicitacoes.FieldValues['CODSOL']);
          qryTempPriv.Open;
          qryTempPriv.Transaction.CommitRetaining;

          qryTemp.Close;
          qryTemp.SQL.Text := 'update fc12000 set CONDP=null where cdfil='+inttostr(qrySolicitacoes.FieldValues['cdfilr'])+' and nrrqu='+inttostr(qrySolicitacoes.FieldValues['nrrqur']);
          qryTemp.Open;
          qryTemp.Transaction.CommitRetaining;

          qrySolicitacoes.Close;
          qrySolicitacoes.Open;
        end;
end;

procedure TfrmCortesiasAbertas.dbgCortesiasDblClick(Sender: TObject);
begin


if (not(qrySolicitacoes.IsEmpty)) THEN
 with frmCortesiaDetalhes do
  begin

   lblMes.Caption       := FormatFloat('#####0.00',0.0);
   lblTotal.Caption       := FormatFloat('#####0.00',0.0);
   lblFunc.Caption:='';
   lblDepto.Caption:='';
   edtFil.Clear;
   edtReq.Clear;
   edtSer.Clear;
   edtdtSol.Clear;
   edthrSol.Clear;
   edtDtAva.Clear;
   edtHrAva.Clear;
   edtvrRec.Clear;
   edtvrCort.Clear;
   lblAvaliador.Caption:='';
   lblStatus.Caption:='';
   lblJustificativa.Caption:='';

   qryTempPriv.Close;
   qryTempPriv.SQL.Text := 'select sum(valorcort) as VRTOTAL from soliccortesia where indapr<>2 and cancelado=0  and CPFFUNCORT='+quotedstr(qrySolicitacoes.FieldValues['CPFFUNCORT']) ;
   qryTempPriv.Open;


   if not(qryTempPriv.IsEmpty) then
    begin
     lblTotal.Caption := FormatFloat('#####0.00',qryTempPriv.FieldValues['vrtotal']);
     qryTempPriv.Close;
     qryTempPriv.SQL.Add (' and dtsol between '+quotedstr(FormatDateTime('01.mm.yyyy',now))+' and '+quotedstr(FormatDateTime('dd.mm.yyyy',now))    );
//   Clipboard.AsText := qryTempPriv.SQL.Text;
     qryTempPriv.Open;
     if (not(qryTempPriv.IsEmpty) and (qryTempPriv.FieldValues['vrtotal']<>null)  ) then
      begin
        lblMes.Caption := FormatFloat('#####0.00',qryTempPriv.FieldValues['vrtotal']);
      end;
    end;

   lblFunc.Caption  := qrySolicitacoes.FieldValues['nomefuncort'];
   lblDepto.Caption := qrySolicitacoes.FieldValues['deptocort'];

   edtFil.Text      := inttostr(qrySolicitacoes.FieldValues['cdfilr']);
   edtReq.Text      := inttostr(qrySolicitacoes.FieldValues['nrrqur']);
   edtSer.Text      := inttostr(qrySolicitacoes.FieldValues['serierr']);
   edtdtSol.Text    := FormatDateTime('dd/mm/yyyy', qrySolicitacoes.FieldValues['dtsol']);
   edthrSol.Text    := FormatDateTime('hh:nn:ss', qrySolicitacoes.FieldValues['hrsol']);
   if (qrySolicitacoes.FieldValues['dtaprov'])     <> null  then edtDtAva.Text    := FormatDateTime('dd/mm/yyyy', qrySolicitacoes.FieldValues['dtaprov']);
   if (qrySolicitacoes.FieldValues['hraprov'])     <> null  then edtHrAva.Text    := FormatDateTime('hh:nn:ss', qrySolicitacoes.FieldValues['hraprov']);
   if (qrySolicitacoes.FieldValues['usuapro'])     <> null  then lblAvaliador.Caption := qrySolicitacoes.FieldValues['usuapro'];
   if qrySolicitacoes.FieldValues['justificativa'] <> null  then lblJustificativa.Caption := qrySolicitacoes.FieldValues['justificativa'];
   edtvrRec.Text        := FormatFloat('#####0.00',qrySolicitacoes.FieldValues['valorfrm']);
   edtvrCort.Text       := FormatFloat('#####0.00',qrySolicitacoes.FieldValues['valorcort']);

   if qrySolicitacoes.FieldValues['indapr']=0 then
     begin
       lblStatus.Caption := 'NÃO AVALIADO';
       Shape6.Brush.Color := clWhite;
     end
       else
   if qrySolicitacoes.FieldValues['indapr']=1 then
      begin
        lblStatus.Caption := 'APROVADO';
         Shape6.Brush.Color := clSkyBlue;
      end
        else
          begin
           lblStatus.Caption := 'REJEITADO';
           Shape6.Brush.Color := clRed;
          end;


   ShowModal;
  end;
end;

procedure TfrmCortesiasAbertas.dbgCortesiasDrawColumnCell(Sender: TObject;
  const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
  var cod : string ;
begin
  cod := dbgCortesias.Fields[4].AsString ;

  if (cod = '1' ) then
    begin
      dbgCortesias.Canvas.Brush.Color := clSkyBlue ; { Altere a cor do fundo }
      dbgCortesias.Canvas.Font.Color  := ClBlack ; { Altere a cor da fonte }
      dbgCortesias.DefaultDrawDataCell(Rect, dbgCortesias.columns[datacol].field, State);
    end;

  if (cod = '2' ) then
    begin
      dbgCortesias.Canvas.Brush.Color := clRed ; { Altere a cor do fundo }
      dbgCortesias.Canvas.Font.Color  := ClBlack ; { Altere a cor da fonte }
      dbgCortesias.DefaultDrawDataCell(Rect, dbgCortesias.columns[datacol].field, State);
    end;

  if (cod = '0' ) then
    begin
      dbgCortesias.Canvas.Brush.Color := clWindow ; { Altere a cor do fundo }
      dbgCortesias.Canvas.Font.Color  := ClBlack ; { Altere a cor da fonte }
      dbgCortesias.DefaultDrawDataCell(Rect, dbgCortesias.columns[datacol].field, State);
    end;

end;

procedure TfrmCortesiasAbertas.btAprovarClick(Sender: TObject);
begin
      if not(qrySolicitacoes.IsEmpty) then
      if MessageDlg('Deseja aprovar a solicitação de cortesia de '+qrySolicitacoes.FieldValues['nomefuncort']+'?',mtconfirmation,[mbYes,MbNo],0)=mryes then
        begin
          qryTempPriv.Close;
          qryTempPriv.SQL.Text := 'update soliccortesia set indusd=0, dtusd=null,hrusd=null, indapr=1, dtaprov='+quotedstr(FormatDateTime('dd.mm.yyyy',now))+', hraprov='+quotedstr(FormatDateTime('hh:nn:ss',now))+',usuapro='+quotedstr(usu)+'  where codsol='+inttostr(qrySolicitacoes.FieldValues['CODSOL']);
          qryTempPriv.Open;
          qryTempPriv.Transaction.CommitRetaining;

          qryTemp.Close;
          qryTemp.SQL.Text := 'update fc12000 set CONDP='+quotedstr('CORTESIAPRIV')+' where cdfil='+inttostr(qrySolicitacoes.FieldValues['cdfilr'])+' and nrrqu='+inttostr(qrySolicitacoes.FieldValues['nrrqur']) ;
          qryTemp.Open;
          qryTemp.Transaction.CommitRetaining;

          qrySolicitacoes.Close;
          qrySolicitacoes.Open;
        end;
end;

procedure TfrmCortesiasAbertas.btCancelarClick(Sender: TObject);
begin

      if not(qrySolicitacoes.IsEmpty) then
      if MessageDlg('Deseja confirmar o cancelamento da solicitação de cortesia de '+qrySolicitacoes.FieldValues['nomefuncort']+'?',mtconfirmation,[mbYes,MbNo],0)=mryes then
        begin

          if qrySolicitacoes.FieldValues['INDUSD']<>0 then raise Exception.Create('Não é possível cancelar uma cortesia já usada');


          qryTemp.Close;
          qryTemp.SQL.Text     := 'update fc12000 set CONDP=null where cdfil='+inttostr(qrySolicitacoes.FieldValues['cdfilr'])+' and nrrqu='+inttostr(qrySolicitacoes.FieldValues['nrrqur']) ;
          qryTemp.Open;
          qryTemp.Transaction.CommitRetaining;


          qryTempPriv.Close;
          qryTempPriv.SQL.Text := 'delete from soliccortesia where codsol='+inttostr(qrySolicitacoes.FieldValues['CODSOL']);
//          qryTempPriv.SQL.Text := 'delete from soliccortesia set cancelado=1, dtcancel='+quotedstr(FormatDateTime('dd.mm.yyyy',now))+', hrcancel='+quotedstr(FormatDateTime('hh:nn:ss',now))+',usucancel='+quotedstr(usu)+'  where codsol='+inttostr(qrySolicitacoes.FieldValues['CODSOL']);
          qryTempPriv.Open;
          qryTempPriv.Transaction.CommitRetaining;



          qrySolicitacoes.Close;
          qrySolicitacoes.Open;

          showmessage('Cortesia cancelada com sucesso');
        end;

end;

end.
