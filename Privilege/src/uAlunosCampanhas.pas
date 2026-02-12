unit uAlunosCampanhas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, sButton, FireDAC.Comp.DataSet,   { clipbrd,}
  sSkinProvider, sSkinManager, sLabel, sComboBox, frxClass, frxDBSet,ComObj,math,
  sEdit, //frxExportBaseDialog, frxExportXLSX, frxExportPDF, frxExportXLS, frxExportCSV,
  Vcl.ExtCtrls, Vcl.Buttons, sBitBtn, sGroupBox,
  Datasnap.DBClient, Vcl.Mask, Vcl.DBCtrls, IniFiles, IBX.IBCustomDataSet,
  IBX.IBQuery, Data.DB, sSpeedButton, sMaskEdit, sCustomComboEdit ;

type
  TfrmAlunosCampanha = class(TForm)
    sSkinManager1: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    btnLer: TsButton;
    Panel1: TPanel;
    Panel2: TPanel;
    DigAbrir: TOpenDialog;
    lblArquivo: TLabel;
    lblInforma: TLabel;
    qryInclui: TIBQuery;
    sgPlanilha: TStringGrid;
    qryTemp: TIBQuery;
    sLabelFX2: TsLabelFX;
    cbCampanhaNome: TsComboBox;
    qryTmp: TIBQuery;
    btCadCampanha: TsSpeedButton;
    Label1: TLabel;
    procedure btnLerClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CarregaCampanha;
    procedure btCadCampanhaClick(Sender: TObject);
    function  isCPF(CPF: string): boolean;


  private
    { Private declarations }


  public
    { Public declarations }
    var PRINT : TfrxComponent;

  end;

var
  frmAlunosCampanha: TfrmAlunosCampanha;

implementation

{$R *.dfm}

uses uprincipal, uCadCampanha ;



procedure TfrmAlunosCampanha.btCadCampanhaClick(Sender: TObject);
begin
 frmCadCampanha.ShowModal;
end;

procedure TfrmAlunosCampanha.btnLerClick(Sender: TObject);
var LnLinha, total :integer;
    ExcelEntrada : Variant;
    LcMsg: PAnsiChar;
    LcArquivo , aluno ,  cpf  ,ddd  , telefone , email, mensagem , idNumCamp :String;
    LcArq :TextFile;

begin

  qryTmp.Close;
  qryTmp.SQL.Text := 'select idcamp,nomecampanha from campanhas where nomecampanha='+quotedstr(cbCampanhaNome.Text);
  qryTmp.Open;

  if not qryTmp.IsEmpty then
    begin
      idNumCamp := qryTmp.FieldByName('idcamp').AsString;
    end;

   if idNumCamp = ''  then
      raise Exception.Create('Selecione a Campanha');

   screen.Cursor := crHourGlass;

   lblArquivo.Visible := true;
   lblInforma.Visible := true;

   DigAbrir.Title   := 'Selecione o arquivo para tratamento';
   DigAbrir.Filter := 'Arquivo Excel *.xlsx';
   if DigAbrir.execute then
      lblArquivo.caption := digAbrir.FileName
   else
      lblArquivo.caption := '';


   if  lblArquivo.caption = '' then   raise Exception.Create('Selecione o arquivo.');


   ExcelEntrada := CreateOleObject('Excel.Application');
   ExcelEntrada.Workbooks.Open( lblArquivo.caption );


   lblInforma.Caption := '';
   lblInforma.Visible := true;


   sgPlanilha.Cells[0,0] := 'idcamp';
   sgPlanilha.Cells[1,0] := 'aluno';
   sgPlanilha.Cells[2,0] := 'cpf';
   sgPlanilha.Cells[3,0] := 'ddd';
   sgPlanilha.Cells[4,0] := 'Telefone';
   sgPlanilha.Cells[5,0] := 'email';
   sgPlanilha.Cells[6,0] := 'mensagem';


   //********************************************************************************************
   // ATENÇÃO OBSERVER A ORDEM DA PLANILHA
   //********************************************************************************************

   aluno     := trim(ExcelEntrada.Workbooks[1].Sheets[1].Cells[2,1]);
   cpf       := trim(ExcelEntrada.Workbooks[1].Sheets[1].Cells[2,2]);
   if Length(cpf) = 9  then   cpf := '00'+cpf;
   if Length(cpf) = 10 then   cpf := '0'+cpf;
   ddd       := ExcelEntrada.Workbooks[1].Sheets[1].Cells[2,3];
   telefone  := trim(ExcelEntrada.Workbooks[1].Sheets[1].Cells[2,4]);
   email     := ExcelEntrada.Workbooks[1].Sheets[1].Cells[2,5];

   if POS('(',TELEFONE) > 0 then
      telefone :=trim( copy(telefone,5,100));

   telefone := TRIM(StringReplace(telefone, '-', '', [rfReplaceAll]));

   if length(telefone) > 9 then  telefone :=trim( copy(telefone,2,100));


   LnLinha:= 2;
   total :=0 ;
   while (aluno <> '') do
      begin

          mensagem:= '';
          lblInforma.caption := 'Aguarde Analisando registro nº '+inttostr(LnLinha)+' idNumCamp:'+idNumCamp+
                                 'aluno: '+aluno+
                                 'cpf: '+cpf;
          lblInforma.refresh;


           if isCPF(cpf) then
               begin

                 cpf := cpf;
                 qryTemp.Close;
                 qryTemp.SQL.Text := 'select a.* from campanhasclientes a  where a.idcamp= '+quotedstr(idNumCamp)+' and  a.cpfcli = '+quotedstr(cpf);
                 qryTemp.Open;


                if not qryTemp.IsEmpty  then
                   begin
                     mensagem := 'aluno: '+qryTemp.FieldByName('nomecli').AsString+' - '+cpf+ ' JÁ EXISTE NO CADASTRO!';
                   end
                else
                  begin


                    qryInclui.Close;
                    qryInclui.SQL.Text := 'UPDATE OR INSERT INTO CAMPANHASCLIENTES (IDCAMP, CPFCLI,NOMECLI,DDD,CELULAR,INDSELEC ) values ('+
                    idNumCamp+','+quotedstr(cpf)+','+quotedstr(aluno)+','+quotedstr(ddd)+','+quotedstr(telefone)+',0)';

                    //clipboard.AsText := qryInclui.SQL.Text;
                    qryInclui.Open;
                    qryInclui.Transaction.CommitRetaining;


                    mensagem:= 'INCLUSÃO COM SUCESSO.';


                  end;

                  total := total +1 ;

              end
              else
              begin
                 mensagem := 'aluno: '+aluno+' - cpf: '+cpf+ 'invalido !';
              end;


        sgPlanilha.Cells[0,LnLinha-1] := idNumCamp;
        sgPlanilha.Cells[1,LnLinha-1] := aluno;
        sgPlanilha.Cells[2,LnLinha-1] := cpf;
        sgPlanilha.Cells[3,LnLinha-1] := ddd;
        sgPlanilha.Cells[4,LnLinha-1] := Telefone;
        sgPlanilha.Cells[5,LnLinha-1] := email;
        sgPlanilha.Cells[6,LnLinha-1] := mensagem;


        sgPlanilha.RowCount := sgPlanilha.RowCount+1;
        LnLinha  := LnLinha +1;


        aluno    := trim(ExcelEntrada.Workbooks[1].Sheets[1].Cells[LnLinha,1]);
        cpf      := trim(ExcelEntrada.Workbooks[1].Sheets[1].Cells[LnLinha,2]);
        if Length(cpf) = 9  then   cpf := '00'+cpf;
        if Length(cpf) = 10 then   cpf := '0'+cpf;
        ddd      := ExcelEntrada.Workbooks[1].Sheets[1].Cells[LnLinha,3];
        telefone := trim(ExcelEntrada.Workbooks[1].Sheets[1].Cells[LnLinha,4]);
        email    := ExcelEntrada.Workbooks[1].Sheets[1].Cells[LnLinha,5];

        if POS('(',telefone) > 0 then
           telefone :=trim( copy(telefone,5,100));

        telefone := TRIM(StringReplace(telefone, '-', '', [rfReplaceAll]));

        if length(telefone) > 9 then  telefone :=trim( copy(telefone,2,100));

   end;

   showMessage('total é de '+inttostr(total));

   ExcelEntrada.workbooks.close;
   ExcelEntrada.Quit;

   screen.Cursor := crDefault;

   lblArquivo.Visible := false;
   lblInforma.Visible := false;


end;

procedure TfrmAlunosCampanha.FormShow(Sender: TObject);
begin
 CarregaCampanha;
end;

procedure TfrmAlunosCampanha.CarregaCampanha;
begin
 cbCampanhaNome.ItemIndex:=-1;

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



function TfrmAlunosCampanha.isCPF(CPF: string): boolean;
var  dig10, dig11: string;
    s, i, r, peso: integer;
begin
// length - retorna o tamanho da string (CPF é um número formado por 11 dígitos)
  if ((CPF = '00000000000') or (CPF = '11111111111') or
      (CPF = '22222222222') or (CPF = '33333333333') or
      (CPF = '44444444444') or (CPF = '55555555555') or
      (CPF = '66666666666') or (CPF = '77777777777') or
      (CPF = '88888888888') or (CPF = '99999999999') or
      (length(CPF) <> 11))
     then begin
              isCPF := false;
              exit;
            end;

// try - protege o código para eventuais erros de conversão de tipo na função StrToInt
  try
{ *-- Cálculo do 1o. Digito Verificador --* }
    s := 0;
    peso := 10;
    for i := 1 to 9 do
    begin
       // StrToInt converte o i-ésimo caractere do CPF em um número
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))  then dig10 := '0'  else str(r:1, dig10); // converte um número no respectivo caractere numérico

{ *-- Cálculo do 2o. Digito Verificador --* }
    s := 0;
    peso := 11;
    for i := 1 to 10 do
    begin
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11)) then dig11 := '0'  else str(r:1, dig11);

{ Verifica se os digitos calculados conferem com os digitos informados. }
    if ((dig10 = CPF[10]) and (dig11 = CPF[11]))  then  isCPF := true   else isCPF := false;


  except
      isCPF := false
  end;
end;


end.
