object frmCampanhaCliente: TfrmCampanhaCliente
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Dados Campanha'
  ClientHeight = 279
  ClientWidth = 353
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Shape2: TShape
    Left = 258
    Top = 160
    Width = 90
    Height = 30
    Brush.Color = clMoneyGreen
    Pen.Color = clMedGray
    Pen.Width = 0
  end
  object sLabelFX2: TsLabelFX
    Left = 14
    Top = 6
    Width = 94
    Height = 27
    Caption = 'CAMPANHA'
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
  object btEnvSMS: TsSpeedButton
    Left = 206
    Top = 79
    Width = 93
    Height = 16
    Caption = 'Enviar SMS'
    OnClick = btEnvSMSClick
  end
  object sLabelFX1: TsLabelFX
    Left = 79
    Top = 207
    Width = 194
    Height = 27
    Caption = 'INFORME AUTORIZA'#199#195'O'
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
  object sLabelFX6: TsLabelFX
    Left = 66
    Top = 57
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
  object sLabelFX5: TsLabelFX
    Left = 13
    Top = 57
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
  object Titulo_lblValAtual: TsLabelFX
    Left = 6
    Top = 134
    Width = 250
    Height = 27
    Caption = 'VALOR ATUAL ..........................'
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
  object Titulo_lblValCDesc: TsLabelFX
    Left = 6
    Top = 171
    Width = 252
    Height = 27
    Caption = 'VALOR COM DESCONTO.............'
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
  object Shape1: TShape
    Left = 258
    Top = 124
    Width = 90
    Height = 30
    Brush.Color = clActiveCaption
    Pen.Color = clMedGray
    Pen.Width = 0
  end
  object lblValAtual: TsLabelFX
    Left = 259
    Top = 128
    Width = 91
    Height = 27
    Caption = 'R$ 0000,00'
    ParentFont = False
    OnDblClick = lblValAtualDblClick
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Angle = 0
    Shadow.OffsetKeeper.LeftTop = -3
    Shadow.OffsetKeeper.RightBottom = 5
  end
  object lblValCDesc: TsLabelFX
    Left = 259
    Top = 164
    Width = 91
    Height = 27
    Caption = 'R$ 0000,00'
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
  object lblAut: TsLabel
    Left = 248
    Top = 240
    Width = 27
    Height = 13
    Caption = 'lblAut'
    Visible = False
  end
  object lblNomeCli: TsLabel
    Left = 244
    Top = 255
    Width = 48
    Height = 13
    Caption = 'lblNomeCli'
    Visible = False
  end
  object btEnvZap: TsSpeedButton
    Left = 206
    Top = 96
    Width = 93
    Height = 16
    Caption = 'Enviar WhatsApp'
    OnClick = btEnvZapClick
  end
  object cbCampanhaNome: TsComboBox
    Left = 20
    Top = 33
    Width = 321
    Height = 27
    TabOrder = 0
    OnChange = cbCampanhaNomeChange
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Style = csDropDownList
  end
  object edtAutorizacao: TsEdit
    Left = 126
    Top = 235
    Width = 87
    Height = 37
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 5
    ParentFont = False
    TabOrder = 1
    OnChange = edtAutorizacaoChange
  end
  object edtCelular: TsEdit
    Left = 68
    Top = 82
    Width = 136
    Height = 27
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 9
    NumbersOnly = True
    ParentFont = False
    TabOrder = 2
  end
  object edtDDD: TsEdit
    Left = 15
    Top = 82
    Width = 47
    Height = 27
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 2
    NumbersOnly = True
    ParentFont = False
    TabOrder = 3
  end
  object memo_RequestBody: TMemo
    Left = 8
    Top = 293
    Width = 265
    Height = 161
    TabOrder = 4
    Visible = False
  end
  object pcTipoDesc: TsPageControl
    Left = 160
    Top = -31
    Width = 181
    Height = 63
    ActivePage = tsValor
    TabOrder = 5
    object tsPErcentual: TsTabSheet
      Caption = 'tsPErcentual'
      object lblDesc: TsLabelFX
        Left = 11
        Top = 8
        Width = 196
        Height = 24
        Caption = 'VAR -   0%    FOR - 0 %            '
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Angle = 0
        Shadow.OffsetKeeper.LeftTop = -3
        Shadow.OffsetKeeper.RightBottom = 5
      end
      object sBevel1: TsBevel
        Left = 3
        Top = 9
        Width = 166
        Height = 20
      end
    end
    object tsValor: TsTabSheet
      Caption = 'tsValor'
      object sBevel2: TsBevel
        Left = 5
        Top = 10
        Width = 166
        Height = 20
      end
      object lblDescValor: TsLabelFX
        Left = 10
        Top = 12
        Width = 160
        Height = 24
        Caption = 'VALOR DISP. - R$ 0000,00'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Angle = 0
        Shadow.OffsetKeeper.LeftTop = -3
        Shadow.OffsetKeeper.RightBottom = 5
      end
    end
  end
  object qryCampanha: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 279
    Top = 175
  end
  object qryConsultaFcerta: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 309
    Top = 175
  end
  object RESTResponse: TRESTResponse
    Left = 249
    Top = 235
  end
  object RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter
    FieldDefs = <>
    Response = RESTResponse
    Left = 279
    Top = 235
  end
  object HTTPBasicAuthenticator: THTTPBasicAuthenticator
    Left = 249
    Top = 175
  end
  object RESTClient: TRESTClient
    Authenticator = HTTPBasicAuthenticator
    Accept = 'application/json;q=0.9,text/plain;q=0.9,text/html'
    AcceptCharset = 'UTF-8'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 279
    Top = 205
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
    Left = 309
    Top = 205
  end
  object qryPrivilegeTEMP: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 249
    Top = 205
  end
end
