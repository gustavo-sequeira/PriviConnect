unit uEnvioSMS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, sBevel, Vcl.StdCtrls, {CLIPBRD,}
  sEdit, Vcl.Buttons, sSpeedButton, sLabel, sComboBox, Data.DB,
  IBX.IBCustomDataSet, IBX.IBQuery, IPPeerClient, REST.Client,  uRESTObjects,
  REST.Authenticator.Basic, REST.Response.Adapter, Data.Bind.Components,  System.JSON,
  Data.Bind.ObjectScope, REST.Json,  REST.Types,  REST.Utils ,REST.Consts, REST.HttpClient,
  Vcl.ComCtrls, sPageControl, Vcl.Mask, sMaskEdit, sCustomComboEdit , Math  ;

type
  TfrmEnvioSMS = class(TForm)
    btEnvSMS: TsSpeedButton;
    lblCelular: TsLabelFX;
    lblDDD: TsLabelFX;
    qryCampanha: TIBQuery;
    qryConsultaFcerta: TIBQuery;
    RESTResponse: TRESTResponse;
    RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
    HTTPBasicAuthenticator: THTTPBasicAuthenticator;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    memo_RequestBody: TMemo;
    qryPrivilegeTEMP: TIBQuery;
    rbListaClientes: TRadioButton;
    lblNomeCliente: TsLabelFX;
    ProgressBar: TProgressBar;
    procedure btEnvSMSClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EnvioSMS(ddd,telefone,nomeCliente:String);
    procedure rbListaClientesClick(Sender: TObject);
  private
    { Private declarations }

   FRESTParams: TRESTRequestParams;
  public
    { Public declarations }
  end;

var
  frmEnvioSMS: TfrmEnvioSMS;
  percvarcamp,percformcamp,valorcamp:double;


implementation

{$R *.dfm}

uses udmDescontos, uPrincipal, System.Generics.Collections;


function enviazap( NOMECONT,NOMEFUNC,TPMSG,MSG,TELEFONE,TELEFONEDEST,NRCPF:string  ):string;    stdcall;   external 'dllZAP.dll' ;
function checazap( ID :string  ):string;    stdcall;   external 'dllZAP.dll' ;
function checainstancia :string;    stdcall;   external 'dllZAP.dll' ;


function getCamposJsonString(json,value:String): String;
var
   LJSONObject: TJSONObject;
   function TrataObjeto(jObj:TJSONObject):string;
   var i:integer;
       jPar: TJSONPair;
   begin
        result := '';
        for i := 0 to jObj.Size - 1 do
        begin
             jPar := jObj.Get(i);
             if jPar.JsonValue Is TJSONObject then
                result := TrataObjeto((jPar.JsonValue As TJSONObject)) else
             if sametext(trim(jPar.JsonString.Value),value) then
             begin
                  Result := jPar.JsonValue.Value;
                  break;
             end;
             if result <> '' then
                break;
        end;
   end;
begin
   try
      LJSONObject := nil;
      LJSONObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json),0) as TJSONObject;
      result := TrataObjeto(LJSONObject);
   finally
      LJSONObject.Free;
   end;
end;

Function RemoveAcentos(Str:String): String;
{Remove caracteres acentuados de uma string}
Const ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹';
  SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
Var
x : Integer;
Begin
For x := 1 to Length(Str) do
  Begin
  if Pos(Str[x],ComAcento)<>0 Then
  begin
  Str[x] := SemAcento[Pos(Str[x],ComAcento)];
  end;
  end;
Result := Str;
end;

function RandomPassword(PLen: Integer): string;
var
  str: string;
begin
  Randomize;
  //string with all possible chars
  str    := 'ABCDEFGHIJKLMNPQRSTUVWXYZ123456789';
  Result := '';
  repeat
    Result := Result + str[Random(Length(str)) + 1];
  until (Length(Result) = PLen)
end;

procedure TfrmEnvioSMS.btEnvSMSClick(Sender: TObject);
var aux_ddd , aux_Telefone, aux_nomeCliente :String;
begin

      // a pedido de Brena

      if qryConsultaFcerta.IsEmpty then raise Exception.Create('… necess·rio gerar a Lista de Clientes');

      qryConsultaFcerta.FetchAll;
      qryConsultaFcerta.First;
      ProgressBar.Max := qryConsultaFcerta.RecordCount;
      ProgressBar.Position:=0;

      while not qryConsultaFcerta.eof do
        begin

           aux_Nomecliente := qryConsultaFcerta.FieldByName('nomecli').AsString;
           aux_ddd := qryConsultaFcerta.FieldByName('nrdddfax').AsString;

           if qryConsultaFcerta.FieldByName('nrdddfax').AsString = '' then  aux_ddd := '81';

           aux_Telefone := qryConsultaFcerta.FieldByName('nrfax').AsString;
           if  Length(aux_Telefone) = 8  then  aux_Telefone := '9'+aux_Telefone;

          // aux_ddd := '81';
          // aux_Telefone := '99111770';

           if( aux_ddd <> '') and (aux_Telefone <> '') then
              EnvioSMS( aux_ddd , aux_Telefone , aux_Nomecliente   );

           ProgressBar.Position := ProgressBar.Position +1;
           ProgressBar.Refresh;


           qryConsultaFcerta.Next;
        end;

end;

procedure TfrmEnvioSMS.EnvioSMS(ddd,telefone,nomeCliente:String);
var
  LURL: string;
  I,valgen: Integer;

begin

   lblDDD.Caption := ddd;
   lblCelular.Caption := telefone;
   lblNomeCliente.Caption := nomeCliente;


   qryCampanha.Close;
   qryCampanha.SQL.Text := 'select gen_id(GEN_SMSAUT,1) as VALORGEN from rdb$database ';
   qryCampanha.Open;

   valgen := qryCampanha.FieldValues['valorgen'];
   qryCampanha.Close;


memo_RequestBody.Lines.Text := '{ '+
       ' "sendSmsRequest": { '+
       '     "from": "Pharmapele", ' +
       '     "to": "55'+lblDDD.Caption+lblCelular.Caption+'",' +
       '     "schedule": "'+FormatDateTime('yyyy-mm-dd',now)+'T'+FormatDateTime('hh:nn:ss',now)+'", ' +
       '     "msg": "A loja de Olinda mudou de local, agora esta no lado oposto da avenida. Se precisar falar conosco, nosso Whatsapp 81 98649-3065. Esperamos voce.", ' +
       '     "callbackOption": "NONE", ' +
       '     "id": "'+inttostr(valgen)+'", ' +
       '     "aggregateId": "1111", ' +
       '     "flashSms": false  '+
       ' } '+
  '  }  ';


  FRESTParams.Method := rmPOST;


  LURL := 'https://api-rest.zenvia360.com.br/services/send-sms';
  I := LURL.IndexOf('+ -->');
  if I > 0 then
    LURL := Trim(LURL.Substring(0, I));


//  LURL := TRESTHTTP.FixupURL('', LURL);
  FRESTParams.URL := LURL;

  FRESTParams.Resource := '';
  FRESTParams.ContentType := 'application/json';

  FRESTParams.CustomParams.CreateURLSegmentsFromString(FRESTParams.Resource);

  FRESTParams.AuthMethod := amBASIC;

  FRESTParams.AuthUsername := 'gradar';
  FRESTParams.AuthPassword := 'Qvmb3MPSRL';

  FRESTParams.CustomBody.Clear;
  memo_RequestBody.Lines.SaveToStream(FRESTParams.CustomBody);

  RESTResponseDataSetAdapter.FieldDefs.Clear;


  RESTRequest.ResetToDefaults;
  RESTResponse.ResetToDefaults;

//UpdateComponentProperties1;


  FRESTParams.Method := rmPOST;
  FRESTParams.URL := LURL;


  FRESTParams.Resource := '';
  FRESTParams.ContentType := 'application/json';

  FRESTParams.CustomParams.CreateURLSegmentsFromString(FRESTParams.Resource);

  FRESTParams.AuthMethod := amBASIC;

  FRESTParams.AuthUsername := 'gradar';
  FRESTParams.AuthPassword := 'Qvmb3MPSRL';

  FRESTParams.CustomBody.Clear;
  memo_RequestBody.Lines.SaveToStream(FRESTParams.CustomBody);

  RESTClient.BaseURL := LURL;
  RESTRequest.Resource := FRESTParams.Resource;

  RESTRequest.Params.Clear;
  RESTRequest.Params.Assign(FRESTParams.CustomParams);

  if FRESTParams.CustomBody.Size > 0 then
  begin
    RESTRequest.AddBody(FRESTParams.CustomBody, ContentTypeFromString(FRESTParams.ContentType));
  end;

  RESTRequest.Method := rmPOST;


   RESTClient.Authenticator := HTTPBasicAuthenticator;
   HTTPBasicAuthenticator.Username := FRESTParams.AuthUsername;
   HTTPBasicAuthenticator.Password := FRESTParams.AuthPassword;

  RESTRequest.Client := RESTClient;


 try
    RESTRequest.Execute;
  except
    on E: TRESTResponseDataSetAdapter.EJSONValueError do
    begin
      // Ignore
    end;
    on E: TRESTResponse.EJSONValueError do
    begin
      // Ignore
    end
    else
      raise;
  end;

//  Clipboard.AsText := memo_RequestBody.Lines.Text;

//   ShowMessage( UpperCase(RESTResponse.Content));
  if  pos('ERROR',UpperCase(RESTResponse.Content))>0 then
      ShowMessage('Erro ao enviar SMS:'+#13+  trim(StringReplace(copy(RESTResponse.Content,pos('"detailDescription" : "',RESTResponse.Content)+22, length(RESTResponse.Content) -   pos('"detailDescription" : "',RESTResponse.Content)+23 ),'}','',[rfReplaceAll]  ) )   );

end;

procedure TfrmEnvioSMS.FormCreate(Sender: TObject);
begin
  FRESTParams := TRESTRequestParams.Create;
end;

procedure TfrmEnvioSMS.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FRESTParams);
end;

procedure TfrmEnvioSMS.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key =#13 then
   begin
      Key:=#0; // tira o ruÌdo qndo pressiona o enter.
      Perform(WM_NEXTDLGCTL,0,0);
   end;
end;

procedure TfrmEnvioSMS.rbListaClientesClick(Sender: TObject);
begin
      if rbListaClientes.Checked = true then
      begin

         qryConsultaFcerta.Close;
         qryConsultaFcerta.SQL.Clear;
         qryConsultaFcerta.SQL.Add('select  distinct cli.cdfil,  cli.cdcli, cli.nomecli, tel.nrdddfax, tel.nrfax, tel.nrddd, tel.nrtel');
         qryConsultaFcerta.SQL.Add('from fc32100 tb');
         qryConsultaFcerta.SQL.Add('inner join fc07000 cli on');
         qryConsultaFcerta.SQL.Add('cli.cdfil = tb.cdfil and');
         qryConsultaFcerta.SQL.Add('cli.cdcli = tb.cdcli');
         qryConsultaFcerta.SQL.Add('inner join fc07200 tel on');
         qryConsultaFcerta.SQL.Add('tel.cdcli = cli.cdcli');
         qryConsultaFcerta.SQL.Add('where  tb.cdfil = 5 and tb.dtope between ''01.01.2023'' and ''31.12.2023'' and tel.nrfax is not null');
         qryConsultaFcerta.SQL.Add('order by  cli.nomecli');
         qryConsultaFcerta.Open;
         qryConsultaFcerta.FetchAll;

      end;

end;

end.
