object frmEnvioSMS: TfrmEnvioSMS
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Envio SMS'
  ClientHeight = 146
  ClientWidth = 453
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object btEnvSMS: TsSpeedButton
    Left = 180
    Top = 108
    Width = 93
    Height = 30
    Caption = 'Enviar SMS'
    OnClick = btEnvSMSClick
  end
  object lblCelular: TsLabelFX
    Left = 53
    Top = 52
    Width = 75
    Height = 27
    Caption = 'CELULAR'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Angle = 0
    Shadow.OffsetKeeper.LeftTop = -3
    Shadow.OffsetKeeper.RightBottom = 5
  end
  object lblDDD: TsLabelFX
    Left = 6
    Top = 52
    Width = 41
    Height = 27
    Caption = 'DDD'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Angle = 0
    Shadow.OffsetKeeper.LeftTop = -3
    Shadow.OffsetKeeper.RightBottom = 5
  end
  object lblNomeCliente: TsLabelFX
    Left = 153
    Top = 52
    Width = 120
    Height = 27
    Caption = 'NOME CLIENTE'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Angle = 0
    Shadow.OffsetKeeper.LeftTop = -3
    Shadow.OffsetKeeper.RightBottom = 5
  end
  object memo_RequestBody: TMemo
    Left = 8
    Top = 293
    Width = 265
    Height = 161
    TabOrder = 0
    Visible = False
  end
  object rbListaClientes: TRadioButton
    Left = 8
    Top = 9
    Width = 321
    Height = 17
    Caption = 'Clientes de Olinda - Compras do Ano 2023'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = rbListaClientesClick
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 85
    Width = 430
    Height = 17
    TabOrder = 2
  end
  object qryCampanha: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 40
    Top = 208
  end
  object qryConsultaFcerta: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 40
    Top = 152
  end
  object RESTResponse: TRESTResponse
    Left = 331
    Top = 471
  end
  object RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter
    FieldDefs = <>
    Response = RESTResponse
    Left = 331
    Top = 407
  end
  object HTTPBasicAuthenticator: THTTPBasicAuthenticator
    Left = 323
    Top = 351
  end
  object RESTClient: TRESTClient
    Authenticator = HTTPBasicAuthenticator
    Accept = 'application/json;q=0.9,text/plain;q=0.9,text/html'
    AcceptCharset = 'UTF-8'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 315
    Top = 279
  end
  object RESTRequest: TRESTRequest
    AssignedValues = [rvAccept, rvAcceptCharset]
    Accept = 'application/json;q=0.9,text/plain;q=0.9,text/html'
    AcceptCharset = 'UTF-8'
    AutoCreateParams = False
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 147
    Top = 151
  end
  object qryPrivilegeTEMP: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 256
    Top = 147
  end
end
