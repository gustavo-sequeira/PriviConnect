unit uSenha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,  {clipbrd,}
  Dialogs, DB, IBCustomDataSet, IBQuery, StdCtrls, Buttons, Mask, ExtCtrls,
  jpeg;

type
  TfrmSenha = class(TForm)
    Panel2: TPanel;
    Bevel1: TBevel;
    Image1: TImage;
    Panel1: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Senha: TEdit;
    Usuario: TMaskEdit;
    btnSair: TBitBtn;
    btnEntrar: TBitBtn;
    QryUsuarios: TIBQuery;
    QrySenha: TIBQuery;
    qryUsuario2: TIBQuery;
    qryFilial: TIBQuery;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnEntrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSenha: TfrmSenha;

implementation

uses udmDescontos, uPrincipal, uBuscaUsuario, uSolicCortesiasAbertas;

{$R *.dfm}

function Criptografar(wStri: String): String;
 var simbolos1,simbolos2:string; //Simbolos : array [0..2] of String;
     x,y : Integer;
begin
  RESULT:='';
  Simbolos1:='KLMNOPQRSTUVXWYZ[\]^_`abcd;<=>?@ABC:+J-./²0423i5';
  Simbolos2:='ABCDEFGHIJKLNMOPQRSTUVWXYZ1234567890!@#$%¨&*()_+';
for x := 1 to Length(Trim(wStri)) do
 begin
  for y := 1 to Length(Trim(Simbolos2)) do
   begin
    if wStri[x]=Simbolos2[y] then Result:=Result+simbolos1[y];
   end;
 end;
end;

function DEcriptografar(wStri: String): String;
 var simbolos1,simbolos2:string; //Simbolos : array [0..2] of String;
     x,y : Integer;
begin

Result:='';
Simbolos1:='ABCDEFGHIJKLNMOPQRSTUVWXYZ1234567890!@#$%¨&*()_+';
Simbolos2:='KLMNOPQRSTUVXWYZ[\]^_`abcd;<=>?@ABC:+J-./²0423i5';
for x := 1 to Length(Trim(wStri)) do
 begin
  for y := 1 to Length(Trim(Simbolos2)) do
   begin
    if wStri[x]=Simbolos2[y] then Result:=Result+Simbolos1[y];
   end;
 end;
end;



procedure TfrmSenha.btnEntrarClick(Sender: TObject);
var usuario2,usuencript:string;

begin
 if trim(Usuario.Text)<>'' then
  begin
   QrySenha.Close;
   QrySenha.SQL.Text:='select CDUSU,USERID,SENHA, fc99999.parametro as LOJAP from FC0B000,FC99999 where fc99999.argumento='+QuotedStr('FSENHA')+' and grupousu=SUBARGUM and USERID like '+QuotedStr('¸¹º'+Criptografar(trim(Usuario.Text)));
 //  Clipboard.AsText :='select CDUSU,USERID,SENHA, fc99999.parametro as LOJAP from FC0B000,FC99999 where fc99999.argumento='+QuotedStr('FSENHA')+' and grupousu=SUBARGUM and USERID like '+QuotedStr('¸¹º'+Criptografar(trim(Usuario.Text)));
   QrySenha.Open;
   if QrySenha.IsEmpty then
     begin
       ShowMessage('Nenhum usuário cadastrado com esse nome');
       Usuario.SelectAll;
       Usuario.SetFocus;
     end
      else
     begin
       usuario2:=QrySenha.FieldValues['USERID'];
       if (usuario2[4]+usuario2[5]<>'^S' ) and (usuario2[4]+usuario2[5]<>'M]' ) and (usuario2[4]+usuario2[5]<>'Q^') and (usuario2[4]+usuario2[5]<>'PM' ) and (usuario2[4]+usuario2[5]<>'Mb' ) and (usuario2[4]+usuario2[5]<>'\^' ) and (usuario2[4]+usuario2[5]<>'^M' ) and (usuario2[4]+usuario2[5]<>'KN' )  and (usuario2[4]+usuario2[5]<>'Kb' ) and (usuario2[4]+usuario2[5]<>'\R' )  and (usuario2[4]+usuario2[5]<>'MK' ) then showmessage ( 'Usuário não tem acesso ao Privilege Pharmapele')
        else
          if Criptografar(Senha.Text)=QrySenha.FieldValues['SENHA'] then
           begin
            cdusu:=QrySenha.FieldValues['CDUSU'];

            cdcon:=0;
            cdfun:=0;
            nomefun:='';

            qryUsuario2.Close;
            qryUsuario2.SQL.Text := 'select fc0b000.userid from fc0b000 where fc0b000.cdusu='+inttostr(cdusu);
            qryUsuario2.Open;

            usuencript := qryUsuario2.FieldValues['userid'];


            qryUsuario2.Close;
            qryUsuario2.SQL.Text := 'select cdcon,cdfun,nomefun,nrcpf from fc08000 where fc08000.userid='+QuotedStr(DEcriptografar(usuencript));
            qryUsuario2.Open;

            if not(qryUsuario2.IsEmpty) then
             begin
               cdcon   := qryUsuario2.FieldValues['cdcon'];
               cdfun   := qryUsuario2.FieldValues['cdfun'];
               nomefun := qryUsuario2.FieldValues['nomefun'];

               if (qryUsuario2.FieldValues['nrcpf']=null) then
                 cpffun := '00000000000'
                      else
                 cpffun := qryUsuario2.FieldValues['nrcpf'];
             end;

            qryUsuario2.Close;

            usu:=Usuario.Text;
            autenticado:=true;
            FrmPrincipal.TimerHorario.Enabled:=true;

            FrmPrincipal.StatusBar1.Panels[2].Text:=usu;
            lojap:=strtoint(copy(QrySenha.FieldValues['LOJAP'],1,4));
            if lojap=995 then lojap:=1;

            qryFilial.Close;
            qryFilial.SQL.Text := 'Select * from fc01000 where cdfil='+inttostr(lojap);
            qryFilial.Open;
            frmPrincipal.edtLoja.Text:=inttostr(lojap);
            qryFilial.Close;
            if (copy(usu,1,2)='TI') or (copy(usu,1,3)='ADM') or (copy(usu,1,2)='GT') or (copy(usu,1,2)='RH')  or (usu='NELSON')  then frmPrincipal.Administrao1.Visible := true;
            if (copy(usu,1,2)='TI') or (copy(usu,1,3)='ADM') or (copy(usu,1,2)='GT') or (copy(usu,1,2)='RH')  or (usu='NELSON')  then frmPrincipal.P1.Visible := true;
            if (copy(usu,1,2)='TI') or (copy(usu,1,3)='ADM') or (usu='NELSON')  then frmPrincipal.DescontoMdico1.Visible := true;
            if (copy(usu,1,2)='TI') or (copy(usu,1,3)='ADM') or (usu='NELSON')  then frmPrincipal.D1.Visible := true;
            frmPrincipal.edtLoja.Enabled := true;

             if ( copy(usu,1,2) = 'GT' )  or
                ( copy(usu,1,3) = 'ADM' ) OR
                ( copy(usu,1,2) = 'TI' )  then
                frmPrincipal.menu_ConsultoriaPremium.Visible := TRUE
             else
                frmPrincipal.menu_ConsultoriaPremium.Visible := false;

            if (copy(usu,1,2)='GT') then
              begin
                With frmPrincipal do
                 begin
                    CodBarrasFuncionarios1.Visible:=false;
                    EmissoCodBarrasGerentes1.Visible:=false;
                    SolicitaesAbertas1.Visible:=false;
                    ConfigAlertas1.Visible:=false;
                    DescontoMdico1.Visible:=false;
                 end;
              end;

            if (copy(usu,1,2)='RH') then
              begin
                 frmCortesiasAbertas.btAprovar.Visible:=true;
                 frmCortesiasAbertas.btRejeitar.Visible:=true;
                 With frmPrincipal do
                  begin
                   CodBarrasFuncionarios1.Visible:=false;
                   EmissoCodBarrasGerentes1.Visible:=false;
                   SolicitaesAbertas1.Visible:=false;
                   ConfigAlertas1.Visible:=false;
                   DescontoMdico1.Visible:=false;
                  end;
              end else
                begin
                 frmCortesiasAbertas.btAprovar.Visible:=false;
                 frmCortesiasAbertas.btRejeitar.Visible:=false;
                end;

             if usu='TIELIOMAR' then frmPrincipal.menu_EnvioSMSClientes.Visible := TRUE;


            frmPrincipal.alimentacombo;
            frmPrincipal.atualizameta;
            frmSenha.Close;
           end else
            begin
              ShowMessage('Senha incorreta');
              Senha.SelectAll;
              Senha.SetFocus;

            end;
      end;
  end;
end;

procedure TfrmSenha.FormCreate(Sender: TObject);
begin
   QryUsuarios.Close;
   QryUsuarios.SQL.Text:='select CDUSU,USERID,USERID AS NOME from FC0B000 where USERID like '+QuotedStr('¸¹º%');
   QryUsuarios.Open;
   QryUsuarios.First;
end;

procedure TfrmSenha.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key = VK_TAB) or ((Shift = [ssShift]) and (key = VK_TAB))
  then
   begin
      Perform(WM_NEXTDLGCTL, 1, 0);
      QryUsuarios.Close;
      QryUsuarios.SQL.Text:='select CDUSU,USERID,USERID AS NOME  from FC0B000 where USERID like '+QuotedStr('¸¹º'+Criptografar(trim(Usuario.Text))+'%') + ' order by USERID';
      QryUsuarios.Open;
      QryUsuarios.First;
      if QryUsuarios.IsEmpty then ShowMessage('Nenhum usuário cadastrado com esse nome') else
      if frmBuscaUsuario=nil then
       begin
        frmBuscaUsuario:=TfrmBuscaUsuario.Create(Self);
        frmBuscaUsuario.ShowModal;
       end;
   end;
end;

procedure TfrmSenha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if autenticado=false then flagfechar:=1;
end;

procedure TfrmSenha.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if key=#13 then
  begin
   Key := #0;
   Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmSenha.btnSairClick(Sender: TObject);
begin
 frmSenha.Close;
end;

end.
