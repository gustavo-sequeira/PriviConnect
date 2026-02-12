unit udmDescontos;

interface

uses
  SysUtils, Classes, IBDatabase, DB, Inifiles, Windows, Forms, dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client;

type
  TdmDescontos = class(TDataModule)
    bdFcerta: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBTransaction2: TIBTransaction;
    bdDescontos: TIBDatabase;
    bdFcerta2: TIBDatabase;
    IBTransaction3: TIBTransaction;
    IBTransaction4: TIBTransaction;
    bdDescontos2: TIBDatabase;
    bdImagens: TIBDatabase;
    IBTransaction5: TIBTransaction;
    bdFcerta3: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
    Procedure LeIni;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDescontos: TdmDescontos;
  autenticado:boolean=false;
  p,s,o,u,usu,nomecli,nomefun,cpffun:string;
  cdusu,cdcon,cdfun,flagfechar,lojap:integer;
  valoratual:double;

implementation

{$R *.dfm}


Procedure TdmDescontos.LeIni;
var
  ArqIni : tIniFile;
begin
  ArqIni := tIniFile.Create(ExtractFilePath(ParamStr(0))+'descontos.ini');
Try
  s := ArqIni.Readstring('Dados', 'ipfc', s );
  p := ArqIni.ReadString('Dados', 'pastafc', p );
  o := ArqIni.Readstring('Dados', 'ippv', o );
  u := ArqIni.ReadString('Dados', 'pastapv', u );
Finally
ArqIni.Free;
end;
end;

procedure TdmDescontos.DataModuleCreate(Sender: TObject);
var  HprevHist : HWND;
begin
If (fileexists(ExtractFilePath(ParamStr(0))+'descontos.ini')) then
 begin
   HprevHist := FindWindow('TApplication', 'Privilege - Pharmapele');
   if HprevHist = 0 then begin
   Application.Title := 'Privilege - Pharmapele';
     // ShowMessage('tudo ok, programa não achado');
        end
         else
          begin
            //MessageDlg('Você não pode executar outra cópia do aplicativo', mtInformation, [mbOK], 0); //Com esse código o usuário pode iniciar uma nova copia do aplicativo somente se não houver outra anterior. Caso contrario é exibido uma mensagem para o usuário.
            ShowWindow(HprevHist, SW_RESTORE);
            BringWindowToTop(HprevHist);
            SetForegroundWindow(HprevHist);
         //   Application.Terminate; // REMOVER O COMENTARIO
          end;
      LeIni;

      BDFCERTA.DatabaseName:=s+':'+p;
      bdDescontos.DatabaseName:=o+':'+u;

      bdImagens.DatabaseName:= StringReplace( BDFCERTA.DatabaseName, 'alterdb', 'alterim', [rfReplaceAll, rfIgnoreCase]);

      bdFcerta2.DatabaseName := BDFCERTA.DatabaseName;
      bdDescontos2.DatabaseName := bdDescontos.DatabaseName;

      BDFCERTA.Connected  := true;
      bdImagens.Connected := true;
      bdDescontos.Connected := true;

      BDFCERTA2.Connected:=true;
      bdDescontos2.Connected := true;

      IBTransaction1.Active:=true;
      IBTransaction2.Active:=True;

      IBTransaction3.Active:=true;
      IBTransaction4.Active:=True;
      IBTransaction5.Active:=True;

      BDFcerta3.Params.Add('Server='+s);
      BDFcerta3.Params.Add('Database='+p);
      BDFcerta3.Connected:=true;

//      QryFiliais.Open;

   end
    else
     begin
      ShowMessage('INI não encontrado');
      flagfechar:=1;
      Application.Terminate;
     end;
end;

end.
