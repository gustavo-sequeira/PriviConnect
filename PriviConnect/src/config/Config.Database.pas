unit Config.Database;

interface

uses
  FireDAC.DApt, FireDAC.Stan.Option, FireDAC.Stan.Intf, FireDAC.UI.Intf,
  FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, System.Classes, System.IniFiles,
  System.SysUtils, IBX.IBDatabase;

type TTipoConexao = (tcFC, tcPRV);

var
  ConnectionFC: TFDConnection;
  ConnectionPRV: TFDConnection;

function SetupConnection(AConnection: TCustomConnection; ATipo: TTipoConexao): string;

procedure Connect;

procedure Disconect;

implementation

function SetupConnection(AConnection: TCustomConnection; ATipo: TTipoConexao): string;
var
  arq_ini: string;
  ini: TIniFile;
begin
  arq_ini := GetCurrentDir + '\PriviConnect.ini';
  ini := TIniFile.Create(arq_ini);
  try
    try
      // Verifica se INI existe...
      if not FileExists(arq_ini) then
      begin
        Result := 'Arquivo INI não encontrado: ' + arq_ini;
        exit;
      end;


      ini := TIniFile.Create(arq_ini);

      AConnection.LoginPrompt := False;

      if ATipo = tcFC then
      begin
        TFDConnection(AConnection).Params.Add('DriverID=FB');
        TFDConnection(AConnection).Params.Add('User_Name=sysdba');
        TFDConnection(AConnection).Params.Add('Password=masterkey');
        TFDConnection(AConnection).Params.Add('Server='+ini.ReadString('FC', 'server', ''));
        TFDConnection(AConnection).Params.Add('Database='+ini.ReadString('FC', 'database', ''));
      end else
      begin
        TFDConnection(AConnection).Params.Add('DriverID=FB');
        TFDConnection(AConnection).Params.Add('User_Name=sysdba');
        TFDConnection(AConnection).Params.Add('Password=masterkey');
        TFDConnection(AConnection).Params.Add('Server='+ini.ReadString('PRV', 'server', ''));
        TFDConnection(AConnection).Params.Add('Database='+ini.ReadString('PRV', 'database', ''));
      end;

      Result := 'OK';
    except
      on ex: exception do
        Result := 'Erro ao configurar banco: ' + ex.Message;
    end;

  finally
    if Assigned(ini) then
      ini.DisposeOf;
  end;
end;

procedure Connect;
begin
  ConnectionFC := TFDConnection.Create(nil);
  ConnectionPRV := TFDConnection.Create(nil);

  try
    ConnectionFC.DriverName := 'FB';

    SetupConnection(ConnectionFC, tcFC);
    SetupConnection(ConnectionPRV, tcPRV);

    ConnectionFC.Connected := true;
    ConnectionPRV.Connected := true;
  except
    on e:Exception do
    begin
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure Disconect;
begin
  if Assigned(ConnectionFC) then
  begin
    if ConnectionFC.Connected then
      ConnectionFC.Connected := false;

    ConnectionFC.Free;
  end;

  if Assigned(ConnectionPRV) then
  begin
    if ConnectionPRV.Connected then
      ConnectionPRV.Connected := false;

    ConnectionPRV.Free;
  end;

end;

end.

