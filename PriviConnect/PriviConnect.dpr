program PriviConnect;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.GBSwagger,
  GBSwagger.Model.Types,
  Horse.Jhonson,
  Horse.CORS,
  System.JSON,
  Desconto.Controller in 'src\controller\Desconto.Controller.pas',
  Desconto.Model in 'src\model\Desconto.Model.pas',
  Desconto.RequestModel in 'src\model\Desconto.RequestModel.pas',
  Config.Database in 'src\config\Config.Database.pas',
  Desconto.Base in '..\PriviCore\src\Desconto.Base.pas',
  Desconto.Constantes.Campanhas in '..\PriviCore\src\Desconto.Constantes.Campanhas.pas',
  Desconto.Constantes.Datas in '..\PriviCore\src\Desconto.Constantes.Datas.pas',
  Desconto.Constantes.Percentuais in '..\PriviCore\src\Desconto.Constantes.Percentuais.pas',
  Desconto.Constantes.Produtos in '..\PriviCore\src\Desconto.Constantes.Produtos.pas',
  Desconto.Constantes.Usuarios in '..\PriviCore\src\Desconto.Constantes.Usuarios.pas',
  Desconto.Sqls in '..\PriviCore\src\Desconto.Sqls.pas',
  Desconto.Tipos in '..\PriviCore\src\Desconto.Tipos.pas',
  Desconto.Utils in '..\PriviCore\src\Desconto.Utils.pas',
  uCampanha in 'src\class\uCampanha.pas',
  Desconto.Variaveis in '..\PriviCore\src\Desconto.Variaveis.pas',
  System.IniFiles,
  Winapi.Windows,
  Registry,
  Desconto.Constantes.CampanhasMap in '..\PriviCore\src\Desconto.Constantes.CampanhasMap.pas',
  uLogger in 'src\class\uLogger.pas',
  uMiddlewareLogJson in 'src\class\uMiddlewareLogJson.pas',
  Desconto.ResponseModel in 'src\model\Desconto.ResponseModel.pas';

function GetVersao: string;
begin
  result := '1.0.3';
end;

function GetPorta: Integer;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'PriviConnect.ini');
  try
    Result := Ini.ReadInteger('API', 'porta', 9090);
  finally
    Ini.Free;
  end;
end;

function UsaLogApi: Boolean;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'PriviConnect.ini');
  try
    Result := Ini.ReadString('API', 'usaLogApi', 'S') = 'S';
  finally
    Ini.Free;
  end;
end;

function GetURL: String;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'PriviConnect.ini');
  try
    Result := Ini.ReadString('API', 'url', '127.0.0.1');
  finally
    Ini.Free;
  end;
end;

procedure ConsoleColor(Color: Word);
begin
  { 00	Preto                  08	Cinza escuro         }
  { 01	Azul                   09	Azul claro           }
  { 02	Verde                  10	Verde claro          }
  { 03	Ciano                  11	Ciano claro          }
  { 04	Vermelho               12	Vermelho claro       }
  { 05	Magenta                13	Magenta claro        }
  { 06	Amarelo                14	Amarelo claro        }
  { 07	Cinza claro (padrão)   15	Branco               }
  SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), Color);
end;

procedure ResetColor;
begin
  SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 7);
end;

procedure SwaggerConfig;
begin
  Swagger
    .Host(GetURL + ':' + IntToStr(GetPorta))
    .BasePath('/')
    .AddConsumes(gbAppJSON)
    .AddProduces(gbAppJSON)
    .Info
      .Title('PriviConnect - API de Descontos')
      .Description('Consulta descontos por telefone (string com DDD) e produtos opcionais. Retorno pode conter Varejo e/ou Fórmula.')
      .Version('1.0.0')
    .&End
    .Path('/descontos')
      .Tag('Descontos')
      .POST('Consulta descontos (Varejo e/ou Fórmula)')
        .AddParamBody('body', 'Telefone obrigatório e lista opcional de produtos')
          .Required(True)
          .Schema(TDescontoRequest)
        .&End
        .AddResponse(200, 'OK - Retorna campanhas Varejo e/ou Fórmula')
          .Schema(TDescontosResponse)
        .&End
        .AddResponse(400, 'Requisição inválida').&End
        .AddResponse(404, 'Sem campanhas aplicáveis').&End
        .AddResponse(500, 'Erro interno').&End
      .&End
    .&End
    .AddModel(TDescontoRequest)
    .AddModel(TCampanhaRetornoItem)
    .AddModel(TDescontosResponse);
end;


procedure AjustarConsole(Cols, Rows: SmallInt);
var
  H: THandle;
  Rect: SMALL_RECT;
  Size: COORD;
begin
  H := GetStdHandle(STD_OUTPUT_HANDLE);

  // 1) DIMINUI A JANELA AO MÍNIMO
  Rect.Left   := 0;
  Rect.Top    := 0;
  Rect.Right  := 1;
  Rect.Bottom := 1;
  SetConsoleWindowInfo(H, True, Rect);

  // 2) AJUSTA O BUFFER
  Size.X := Cols;
  Size.Y := Rows;
  SetConsoleScreenBufferSize(H, Size);

  // 3) AJUSTA A JANELA PARA O TAMANHO FINAL
  Rect.Left   := 0;
  Rect.Top    := 0;
  Rect.Right  := Cols - 1;
  Rect.Bottom := Rows - 1;
  SetConsoleWindowInfo(H, True, Rect);
end;

procedure CentralizaJanelaConsole;
var
  hwnd: THandle;
  ScreenW, ScreenH, WinW, WinH: Integer;
begin
  hwnd := GetConsoleWindow;  // Obtém o handle da janela do console

  if hwnd <> 0 then
  begin
    // Obtém as dimensões da tela
    ScreenW := GetSystemMetrics(SM_CXSCREEN);
    ScreenH := GetSystemMetrics(SM_CYSCREEN);

    // Define as dimensões desejadas para a janela
    WinW := 1000;  // largura da janela em pixels
    WinH := 700;  // altura da janela em pixels

    // Centraliza a janela na tela
    SetWindowPos(hwnd,
                 0,  // hWndInsertAfter
                 (ScreenW - WinW) div 2,
                 (ScreenH - WinH) div 2,
                 WinW,
                 WinH,
                 SWP_NOZORDER or SWP_NOACTIVATE);
  end;
end;

procedure DesenharConsole;
begin
  AjustarConsole(119, 40); // largura x altura
  ConsoleColor(1);
  Writeln;
  Writeln('   ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════╗ ');
  Writeln('   ║                                                                                                               ║ ');
  Writeln('   ║                                         $$$$$$\  $$$$$$$\ $$$$$$\                                             ║ ');
  Writeln('   ║                                         $$  __$$\ $$  __$$\\_$$  _|                                           ║ ');
  Writeln('   ║                                         $$ /  $$ |$$ |  $$ | $$ |                                             ║ ');
  Writeln('   ║                                         $$$$$$$$ |$$$$$$$  | $$ |                                             ║ ');
  Writeln('   ║                                         $$  __$$ |$$  ____/  $$ |                                             ║ ');
  Writeln('   ║                                         $$ |  $$ |$$ |       $$ |                                             ║ ');
  Writeln('   ║                                         $$ |  $$ |$$ |     $$$$$$\                                            ║ ');
  Writeln('   ║                                         \__|  \__|\__|     \______|                                           ║ ');
  Writeln('   ║                                                                                                               ║ ');
  Writeln('   ║  $$\      $$\ $$$$$$$$\ $$$$$$$\         $$$$$$\  $$$$$$$$\ $$$$$$$\  $$\    $$\ $$$$$$\  $$$$$$\  $$$$$$$$\  ║ ');
  Writeln('   ║  $$ | $\  $$ |$$  _____|$$  __$$\       $$  __$$\ $$  _____|$$  __$$\ $$ |   $$ |\_$$  _|$$  __$$\ $$  _____| ║ ');
  Writeln('   ║  $$ |$$$\ $$ |$$ |      $$ |  $$ |      $$ /  \__|$$ |      $$ |  $$ |$$ |   $$ |  $$ |  $$ /  \__|$$ |       ║ ');
  Writeln('   ║  $$ $$ $$\$$ |$$$$$\    $$$$$$$\ |      \$$$$$$\  $$$$$\    $$$$$$$  |\$$\  $$  |  $$ |  $$ |      $$$$$\     ║ ');
  Writeln('   ║  $$$$  _$$$$ |$$  __|   $$  __$$\        \____$$\ $$  __|   $$  __$$<  \$$\$$  /   $$ |  $$ |      $$  __|    ║ ');
  Writeln('   ║  $$$  / \$$$ |$$ |      $$ |  $$ |      $$\   $$ |$$ |      $$ |  $$ |  \$$$  /    $$ |  $$ |  $$\ $$ |       ║ ');
  Writeln('   ║  $$  /   \$$ |$$$$$$$$\ $$$$$$$  |      \$$$$$$  |$$$$$$$$\ $$ |  $$ |   \$  /   $$$$$$\ \$$$$$$  |$$$$$$$$\  ║ ');
  Writeln('   ║  \__/     \__|\________|\_______/        \______/ \________|\__|  \__|    \_/    \______| \______/ \________| ║ ');
  Writeln('   ║                                                                                                               ║ ');
  Writeln('   ║                                                                                                               ║ ');
  Writeln('   ║                                        P R I V I   C O N N E C T                                              ║ ');
  Writeln('   ║                                           P H A R M A P E L E                                                 ║ ');
  Writeln('   ║                                                                                                               ║ ');
  Writeln('   ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════╝ ');
  Writeln;
  ResetColor;
  ConsoleColor(6);
  Write('       VERSÃO         : ');
  ResetColor;
  Writeln(GetVersao);

  ConsoleColor(6);
  Write('       STATUS         :');
  ConsoleColor(10);
  Writeln(' ONLINE ');

  ConsoleColor(6);
  Write('       AMBIENTE       :');
  if GetPorta <> 50785 then
  begin
    ConsoleColor(9);
    Writeln(' DESENVOLVIMENTO ');
  end
  else
  begin
    ConsoleColor(12);
    Writeln(' PRODUÇÃO ');
  end;

  ConsoleColor(6);
  Write('       PORTA          : ');
  ResetColor;
  Writeln(IntToStr(GetPorta));

  ConsoleColor(6);
  Write('       API (POST)     : ');
  ResetColor;
  Writeln('http://'+GetURL+':'+IntToStr(GetPorta)+'/descontos');

  ConsoleColor(6);
  Write('       SWAGGER (DOC)  : ');
  ResetColor;
  Writeln('http://'+GetURL+':'+IntToStr(GetPorta)+'/swagger/doc/html');

  ConsoleColor(6);
  Write('       SWAGGER (JOSN) : ');
  ResetColor;
  Writeln('http://'+GetURL+':'+IntToStr(GetPorta)+'/swagger/doc/json ');

  ConsoleColor(6);
  Write('       LOGS           : ');

  if UsaLogApi then
  begin
    ConsoleColor(10);
    Writeln('Ativo');
  end else
  begin
    ConsoleColor(04);
    Writeln('Inativo');
  end;

  ConsoleColor(6);
  Write('       PASTA DOS LOGS : ');
  ResetColor;
  Writeln(GetLogFolder);

  ConsoleColor(6);
  Write('       INÍCIO         : ');
  ResetColor;
  Writeln(FormatDateTime('dd/mm/yyyy hh:mm:nn ', Now));

  Writeln;
  ConsoleColor(4);
  Writeln(' Pressione CTRL + C para encerrar o serviço');

end;

begin
  if UsaLogApi then
    UseJsonLogger;

  HorseCORS.AllowedOrigin('*').AllowedCredentials(true).AllowedHeaders('*').AllowedMethods('*').ExposedHeaders('*');

  THorse.Use(CORS);
  THorse.Use(Jhonson());
  THorse.Use(HorseSwagger);

  SwaggerConfig;

  Desconto.Controller.Registry;

  THorse.Listen(GetPorta,
    procedure
    begin
      CentralizaJanelaConsole;
      DesenharConsole;
    end);
end.

