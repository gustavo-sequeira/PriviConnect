unit uCampanhaCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, sBevel, Vcl.StdCtrls,
  sEdit, Vcl.Buttons, sSpeedButton, sLabel, sComboBox, Data.DB,
  IBX.IBCustomDataSet, IBX.IBQuery, IPPeerClient, REST.Client,  uRESTObjects,
  REST.Authenticator.Basic, REST.Response.Adapter, Data.Bind.Components,  System.JSON,
  Data.Bind.ObjectScope, REST.Json,  REST.Types,  REST.Utils ,REST.Consts, REST.HttpClient,
  Vcl.ComCtrls, sPageControl, Vcl.Mask, sMaskEdit, sCustomComboEdit , Math  ;

type
  TfrmCampanhaCliente = class(TForm)
    cbCampanhaNome: TsComboBox;
    sLabelFX2: TsLabelFX;
    btEnvSMS: TsSpeedButton;
    edtAutorizacao: TsEdit;
    sLabelFX1: TsLabelFX;
    edtCelular: TsEdit;
    sLabelFX6: TsLabelFX;
    sLabelFX5: TsLabelFX;
    edtDDD: TsEdit;
    Titulo_lblValAtual: TsLabelFX;
    Titulo_lblValCDesc: TsLabelFX;
    Shape1: TShape;
    lblValAtual: TsLabelFX;
    lblValCDesc: TsLabelFX;
    Shape2: TShape;
    lblAut: TsLabel;
    qryCampanha: TIBQuery;
    qryConsultaFcerta: TIBQuery;
    RESTResponse: TRESTResponse;
    RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
    HTTPBasicAuthenticator: THTTPBasicAuthenticator;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    memo_RequestBody: TMemo;
    lblNomeCli: TsLabel;
    pcTipoDesc: TsPageControl;
    tsPErcentual: TsTabSheet;
    lblDesc: TsLabelFX;
    sBevel1: TsBevel;
    tsValor: TsTabSheet;
    sBevel2: TsBevel;
    lblDescValor: TsLabelFX;
    btEnvZap: TsSpeedButton;
    qryPrivilegeTEMP: TIBQuery;
    procedure cbCampanhaNomeChange(Sender: TObject);
    procedure btEnvSMSClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtAutorizacaoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure lblValAtualDblClick(Sender: TObject);
    procedure btEnvZapClick(Sender: TObject);
  private
    { Private declarations }

   FRESTParams: TRESTRequestParams;
  public
    { Public declarations }
  end;

var
  frmCampanhaCliente: TfrmCampanhaCliente;
  percvarcamp,percformcamp,valorcamp:double;


implementation

{$R *.dfm}

uses
  udmDescontos, uPrincipal, System.Generics.Collections, Desconto.Base,
  Desconto.Constantes.Campanhas, Desconto.Constantes.Usuarios;


function enviazap( NOMECONT,NOMEFUNC,TPMSG,MSG,TELEFONE,TELEFONEDEST,NRCPF:string  ):string;    stdcall;   external 'dllZAP.dll' ;
function checazap( ID :string  ):string;    stdcall;   external 'dllZAP.dll' ;
function checainstancia :string;    stdcall;   external 'dllZAP.dll' ;


function getCamposJsonString(json, value: string): string;
var
  LJSONObject: TJSONObject;

  function TrataObjeto(jObj: TJSONObject): string;
  var
    i: integer;
    jPar: TJSONPair;
  begin
    result := '';
    for i := 0 to jObj.Count - 1 do
    begin
      jPar := jObj.Get(i);
      if jPar.JsonValue is TJSONObject then
        result := TrataObjeto((jPar.JsonValue as TJSONObject))
      else if sametext(trim(jPar.JsonString.Value), value) then
      begin
        Result := jPar.JsonValue.Value;
        break;
      end;
      if result <> '' then
        break;
    end;
  end;

begin
  LJSONObject := nil;

  try
    LJSONObject := nil;
    LJSONObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJSONObject;
    result := TrataObjeto(LJSONObject);
  finally
    LJSONObject.Free;
  end;
end;

function RemoveAcentos(Str: string): string;
{Remove caracteres acentuados de uma string}
const
  ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹';
  SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
var
  x: Integer;
begin
  for x := 1 to Length(Str) do
  begin
    if Pos(Str[x], ComAcento) <> 0 then
    begin
      Str[x] := SemAcento[Pos(Str[x], ComAcento)];
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
  str := 'ABCDEFGHIJKLMNPQRSTUVWXYZ123456789';
  Result := '';
  repeat
    Result := Result + str[Random(Length(str)) + 1];
  until (Length(Result) = PLen)
end;

procedure TfrmCampanhaCliente.btEnvSMSClick(Sender: TObject);
var
  LURL: string;
  I, valgen: Integer;
begin
  if (edtDDD.Text = '') or (edtCelular.Text = '') then
    raise Exception.Create('Selecione desconto disponÌvel');

  lblAut.Caption := '';
  lblAut.Caption := RandomPassword(5);

  qryCampanha.Close;
  qryCampanha.SQL.Clear;
  qryCampanha.SQL.Add(' select gen_id(GEN_SMSAUT,1) as VALORGEN ');
  qryCampanha.SQL.Add('   from rdb$database ');
  qryCampanha.Open;

  valgen := qryCampanha.FieldValues['valorgen'];
  qryCampanha.Close;

  memo_RequestBody.Lines.Text :=
    '{ ' +
      ' "sendSmsRequest": { ' +
      '     "from": "Pharmapele", ' +
      '     "to": "55' + edtDDD.Text + edtCelular.Text + '",' +
      '     "schedule": "' + FormatDateTime('yyyy-mm-dd', now) + 'T' + FormatDateTime('hh:nn:ss', now) + '", ' +
      '     "msg": "' + RemoveAcentos(lblNomeCli.Caption) + ', informe o codigo para concluir desconto - ' + lblAut.Caption + '", ' +
      '     "callbackOption": "NONE", ' +
      '     "id": "' + inttostr(valgen) + '", ' +
      '     "aggregateId": "1111", ' +
      '     "flashSms": false  ' +
      ' } ' +
    '  }  ';

  FRESTParams.Method := rmPOST;

  LURL := 'https://api-rest.zenvia360.com.br/services/send-sms';
  I := LURL.IndexOf('+ -->');
  if I > 0 then
    LURL := Trim(LURL.Substring(0, I));

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

  if pos('ERROR', UpperCase(RESTResponse.Content)) > 0 then
    ShowMessage('Erro ao enviar SMS:' + #13 + trim(StringReplace(copy(RESTResponse.Content, pos('"detailDescription" : "', RESTResponse.Content) + 22, length(RESTResponse.Content) - pos('"detailDescription" : "', RESTResponse.Content) + 23), '}', '', [rfReplaceAll])))
  else
  begin
    ShowMessage('Enviado com sucesso');
    edtAutorizacao.SetFocus;
  end;
end;

procedure TfrmCampanhaCliente.cbCampanhaNomeChange(Sender: TObject);
var
  vratualcamp, vrtotalcompra, vrdesccamp, valorusado, vrCrdFormula, vrCredVarejo, vrDispVar, vrDispForm, SaldoCamp: double;
  nomecli, cpfcli, MesSaldo, AnoSaldo: string;
  qtditens: integer;
begin
  qtditens := 0;
  qryCampanha.Close;
  qryCampanha.SQL.Clear;
  qryCampanha.SQL.Add(' select a.idcamp, a.nomecampanha, a.percvar, a.percfor, b.nomecli, b.ddd, b.celular, b.cpfcli, a.dtvalidade, a.tpdesc , a.VerificaSaldo , a.Saldo ');
  qryCampanha.SQL.Add('   from campanhas a, ');
  qryCampanha.SQL.Add('        campanhasclientes b ');
  qryCampanha.SQL.Add('  where a.idcamp=b.idcamp ');
  qryCampanha.SQL.Add('    and cpfcli=' + quotedstr(cpfcliente) );
  qryCampanha.SQL.Add('    and a.nomecampanha=' + quotedstr(cbCampanhaNome.Text));
  qryCampanha.Open;

  Titulo_lblValAtual.Caption := 'VALOR ATUAL ..........................';
  Titulo_lblValCDesc.Caption := 'VALOR COM DESCONTO.............';

 // 79 - cortesia mensal
  if not (qryCampanha.IsEmpty) and (qryCampanha.FieldValues['idcamp'] <> 79) then
  begin
    pcTipoDesc.Visible := true;
    if (qryCampanha.FieldValues['dtvalidade'] < now) and (qryCampanha.FieldValues['VerificaSaldo'] <> 'S') then
    begin
      qryCampanha.Close;
      raise Exception.Create('Validade da campanha ultrapassada');
    end;

    nomecli := qryCampanha.FieldValues['nomecli'] + ' ';
    cpfcli := qryCampanha.FieldValues['cpfcli'];
    cpfcliente := cpfcli;
    idcamp := inttostr(qryCampanha.FieldValues['idcamp']);
    lblNomeCli.Caption := trim(copy(nomecli, 1, pos(' ', nomecli)));

    VerificaSaldoCampanha := qryCampanha.FieldValues['VerificaSaldo'];

    if qryCampanha.FieldValues['tpdesc'] = 'P' then
    begin
      pcTipoDesc.ActivePage := tsPErcentual;
      percvarcamp := qryCampanha.FieldValues['percvar'];
      percformcamp := qryCampanha.FieldValues['percfor'];

      lblDesc.Caption := 'VAR - ' + floattostr(percvarcamp) + '%  FOR - ' + floattostr(percformcamp) + '%';
    end
    else
    begin
      pcTipoDesc.ActivePage := tsValor;

      if verificaSaldoCampanha = 'S' then
      begin
        valorcamp := qryCampanha.FieldValues['percfor'] - qryCampanha.FieldValues['Saldo'];
        SaldoCampanha := qryCampanha.FieldValues['Saldo'];
        lblDescValor.Caption := 'VALOR DISP. - R$ ' + floattostr(valorcamp);

        if valorcamp <= 0 then
          raise Exception.Create('N„o h· mais Saldo disponÌvel na campanha.');
      end
      else
      begin
        qryConsultaFcerta.Close;
        qryConsultaFcerta.SQL.Clear;
        qryConsultaFcerta.SQL.Add(' select sum(a.vrdsc) as DESCONTO ');
        qryConsultaFcerta.SQL.Add('   from fc31200 a, ');
        qryConsultaFcerta.SQL.Add('        fc31100 b, ');
        qryConsultaFcerta.SQL.Add('        fc07000 c ');
        qryConsultaFcerta.SQL.Add('  where a.cdfil=b.cdfil ');
        qryConsultaFcerta.SQL.Add('    and a.cdtml=b.cdtml ');
        qryConsultaFcerta.SQL.Add('    and a.dtope=b.dtope ');
        qryConsultaFcerta.SQL.Add('    and a.operid=b.operid ');
        qryConsultaFcerta.SQL.Add('    and a.nrcpm=b.nrcpm ');
        qryConsultaFcerta.SQL.Add('    and b.cdcli=c.cdcli ');
        qryConsultaFcerta.SQL.Add('    and a.useridaut=' + QuotedStr(USUARIO_PRIV_CAMPANHA) );
        qryConsultaFcerta.SQL.Add('    and c.nrcnpj=' + quotedstr(cpfcli));
        qryConsultaFcerta.SQL.Add('    and a.dtope between ' + quotedstr(FormatDateTime('01.mm.yyyy', now)) + ' and current_date ');

        qryConsultaFcerta.Open;

        if qryConsultaFcerta.FieldValues['desconto'] = NULL then
          valorusado := 0
        else
          valorusado := qryConsultaFcerta.FieldValues['desconto'];

        if qryCampanha.FieldValues['percfor'] > 0 then
          valorcamp := qryCampanha.FieldValues['percfor'] - valorusado
        else
          valorcamp := qryCampanha.FieldValues['percVar'] - valorusado;

        lblDescValor.Caption := 'VALOR DISP. - R$ ' + floattostr(valorcamp);
      end;
    end;

    edtDDD.Text := qryCampanha.FieldValues['DDD'];
    edtCelular.Text := qryCampanha.FieldValues['CELULAR'];

    qryConsultaFcerta.Close;
    qryConsultaFcerta.SQL.Clear;
    qryConsultaFcerta.SQL.Add('   select tpitm,sum(vrtot) as vrtot ');
    qryConsultaFcerta.SQL.Add('     from fc32110 ');
    qryConsultaFcerta.SQL.Add('    where nrcpm=' + frmPrincipal.edtTerminalBalcao.Text );
    qryConsultaFcerta.SQL.Add('      and cdfil=' + frmPrincipal.edtLoja.Text );
    qryConsultaFcerta.SQL.Add(' group by 1 ');
    qryConsultaFcerta.Open;

    vratualcamp := 0;
    vrdesccamp := 0;
    qtditens := 0;
    vrtotalcompra := 0;
    SaldoCamp := valorcamp;

    if qryCampanha.FieldValues['tpdesc'] = 'P' then
    begin
      while not qryConsultaFcerta.Eof do
      begin
        vratualcamp := vratualcamp + qryConsultaFcerta.FieldValues['vrtot'];
        vrtotalcompra := vrtotalcompra + qryConsultaFcerta.FieldValues['vrtot'];

        if qryConsultaFcerta.FieldValues['tpitm'] = 'V' then
        begin
          vrdesccamp := vrdesccamp + ((qryConsultaFcerta.FieldValues['vrtot']) * (percvarcamp / 100));
        end
        else
        begin
          vrdesccamp := vrdesccamp + ((qryConsultaFcerta.FieldValues['vrtot']) * (percformcamp / 100));
        end;

        qryConsultaFcerta.Next;
      end;
    end
    else
    begin
      while not qryConsultaFcerta.Eof do
      begin
        vratualcamp := vratualcamp + qryConsultaFcerta.FieldValues['vrtot'];
        vrtotalcompra := vrtotalcompra + qryConsultaFcerta.FieldValues['vrtot'];
        if verificaSaldoCampanha = 'S' then
        begin
          if SaldoCamp >= (qryConsultaFcerta.FieldValues['vrtot'] - 0.01) then
          begin
            vrdesccamp := vrdesccamp + (qryConsultaFcerta.FieldValues['vrtot'] - 0.01);
            SaldoCamp := SaldoCamp - (qryConsultaFcerta.FieldValues['vrtot'] - 0.01);
            SaldoCampanha := SaldoCampanha + (qryConsultaFcerta.FieldValues['vrtot'] - 0.01);
          end
          else
          begin
            if SaldoCamp > 0 then
            begin
              vrdesccamp := vrdesccamp + (qryConsultaFcerta.FieldValues['vrtot'] - SaldoCamp);
              SaldoCampanha := SaldoCampanha + SaldoCamp;
            end;
            SaldoCamp := 0;
          end;
        end
        else
        begin
          {se o valor disponivel da campanha menos o que j· foi abatido de itens anteriores for maior}
          if ((valorcamp - vrdesccamp) + 0.01 >= vratualcamp) then
            vrdesccamp := vrdesccamp + vratualcamp - 0.01
          else
            vrdesccamp := vrdesccamp + valorcamp;
        end;
        qtditens := qtditens + 1;
        qryConsultaFcerta.Next;
      end;

      if verificaSaldoCampanha = 'S' then
      begin
        if vrtotalcompra > valorcamp then
        begin
          // o valor de desconto ser· exato
          percvarcamp := ((vrdesccamp * 100.00) / vratualcamp);
          percformcamp := ((vrdesccamp * 100.00) / vratualcamp);
        end
        else
        begin
          // o valor do desconto n„o deve ser 100, n„o pode zerar o valor - saldo de 0,01 centavos - retiro 0.005
          percvarcamp := ((vrdesccamp * 100.00) / vratualcamp) - 0.01;
          percformcamp := ((vrdesccamp * 100.00) / vratualcamp) - 0.01;
        end;
      end
      else
      begin
        percvarcamp := ((vrdesccamp * 100.00) / vratualcamp) - 0.01;
        percformcamp := ((vrdesccamp * 100.00) / vratualcamp) - 0.01;
      end;
    end;

    if vrtotalcompra - vrdesccamp < 0 then
      raise Exception.Create('FÛrmula j· possui mais desconto que o concedido na campanha');

    lblValAtual.Caption := floattostrf(vrtotalcompra, ffcurrency, 15, 2);
    lblValCDesc.Caption := floattostrf(vrtotalcompra - vrdesccamp, ffcurrency, 15, 2);
    qryConsultaFcerta.Close;
  end;

  // cortesia mensal
  if qryCampanha.FieldValues['idcamp'] = 79 then
  begin

    nomecli := qryCampanha.FieldValues['nomecli'] + ' ';
    cpfcli := qryCampanha.FieldValues['cpfcli'];
    cpfcliente := cpfcli;
    idcamp := inttostr(qryCampanha.FieldValues['idcamp']);
    lblNomeCli.Caption := trim(copy(nomecli, 1, pos(' ', nomecli)));

    edtDDD.Text := qryCampanha.FieldValues['DDD'];
    edtCelular.Text := qryCampanha.FieldValues['CELULAR'];

    pcTipoDesc.Visible := false;
    Titulo_lblValAtual.Caption := 'VALOR DISP.F”RMULA ............';
    Titulo_lblValCDesc.Caption := 'VALOR DISP.VAREJO..............';

    qryPrivilegeTEMP.Close;
    qryPrivilegeTEMP.SQL.Clear;
    qryPrivilegeTEMP.SQL.Add(' select * ');
    qryPrivilegeTEMP.SQL.Add('   from campanhasclientes ');
    qryPrivilegeTEMP.SQL.Add('  where idcamp=79 ');
    qryPrivilegeTEMP.SQL.Add('    and cpfcli=' + inttostr(frmPrincipal.qryTerminalBalcao.FieldValues['NRCNPJ']));
    qryPrivilegeTEMP.Open;

    if qryPrivilegeTEMP.IsEmpty = true then
      raise Exception.Create('Cliente n„o cadastrado para a campanha Cortesia mensal.');

    if NOW > qryPrivilegeTEMP.FieldByName('DtValidade').AsDateTime then
      raise Exception.Create('Validade da campanha Cortesia Mensal encerrada.');

    vrCrdFormula := qryPrivilegeTEMP.FieldByName('ValorFor').AsCurrency;
    vrCredVarejo := qryPrivilegeTEMP.FieldByName('ValorVar').AsCurrency;

    MesSaldo := FormatDateTime('MM', frmPrincipal.qryTerminalBalcao.FieldByName('DTOPE').AsDateTime);
    AnoSaldo := FormatDateTime('YYYY', frmPrincipal.qryTerminalBalcao.FieldByName('DTOPE').AsDateTime);

    vrDispVar := vrCredVarejo - frmPrincipal.SaldoParceiros(cpfcli, 'V', MesSaldo, AnoSaldo);
    vrDispForm := vrCrdFormula - frmPrincipal.SaldoParceiros(cpfcli, 'R', MesSaldo, AnoSaldo);

    lblValAtual.Caption := 'R$ ' + FloatToStr(vrDispForm);
    lblValCDesc.Caption := 'R$ ' + FloatToStr(vrDispVar);
  end;

  qryCampanha.Close;
end;

procedure TfrmCampanhaCliente.edtAutorizacaoChange(Sender: TObject);
begin
  if edtAutorizacao.Text = lblAut.Caption then
  begin
    if cbCampanhaNome.ItemIndex = -1 then
      raise Exception.Create('Campanha n„o selecionada');
    if trim(idcamp) = '' then
      raise Exception.Create('Campanha n„o selecionada 2');

    frmPrincipal.lblPercForm.Caption := FloatToStr(percformcamp);
    frmPrincipal.lblPercVar.Caption := FloatToStr(percvarcamp);

    if idcamp = '79' then
    begin
      useridaut := 'CortesiaMensal';
      frmPrincipal.CampanhaCortesiaMensal;
    end
    else
    begin
      useridaut := 'privcampanha';
    end;
    frmCampanhaCliente.Close;
  end;
end;

procedure TfrmCampanhaCliente.FormCreate(Sender: TObject);
begin
  FRESTParams := TRESTRequestParams.Create;
end;

procedure TfrmCampanhaCliente.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FRESTParams);
end;

procedure TfrmCampanhaCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0; // tira o ruÌdo qndo pressiona o enter.
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmCampanhaCliente.FormShow(Sender: TObject);
begin
  cbCampanhaNome.ItemIndex := -1;
  edtDDD.Clear;
  edtCelular.Clear;
  edtAutorizacao.Clear;

  pcTipoDesc.ActivePage := tsPErcentual;
  lblValAtual.Caption := 'R$ 0000,00';
  lblValCDesc.Caption := 'R$ 0000,00';
  lblAut.Caption := '00oo0';
  lblDesc.Caption := 'VAR -   0%    FOR - 0 %';
  lblDescValor.Caption := 'VALOR DISP. - R$ 0000,00';
end;

procedure TfrmCampanhaCliente.lblValAtualDblClick(Sender: TObject);
begin
  if COPY(usu, 1, 2) = 'TI' then
    SHOWMESSAGE(lblAut.Caption);
end;

procedure TfrmCampanhaCliente.btEnvZapClick(Sender: TObject);
var
  resultado: string;
begin
  if (edtDDD.Text = '') or (edtCelular.Text = '') then
    raise Exception.Create('Selecione desconto disponÌvel');

  lblAut.Caption := '';
  lblAut.Caption := RandomPassword(5);

  resultado := enviazap('Pharmapele ', lblnomecli.caption + ' ', 'CONFIRMACAO', 'Ol· ' + lblNomeCli.caption + '!!' + #13 + #13 +
                        'Informe o cÛdigo para concluir desconto - *' + lblAut.Caption + '*', '81986493053', edtDDD.Text + edtCelular.Text, cpfcliente);

  if pos('Sucesso', getCamposJsonString(resultado, 'sts')) > 0 then
    showmessage('Enviado com sucesso')
  else
    showmessage('Erro ao enviar ZAP!');
end;

end.



