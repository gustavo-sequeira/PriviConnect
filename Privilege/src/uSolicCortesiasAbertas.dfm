object frmCortesiasAbertas: TfrmCortesiasAbertas
  Left = 413
  Top = 228
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Solicita'#231#245'es de Cortesia'
  ClientHeight = 244
  ClientWidth = 486
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 2
    Width = 482
    Height = 239
    TabOrder = 0
    object dbgCortesias: TDBGrid
      Left = 3
      Top = 55
      Width = 473
      Height = 145
      DataSource = dsGrid
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = dbgCortesiasDrawColumnCell
      OnDblClick = dbgCortesiasDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'NOMEFUNCORT'
          Title.Alignment = taCenter
          Title.Caption = 'NOME'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALORFRM'
          Title.Alignment = taCenter
          Title.Caption = 'VR FORM'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALORCORT'
          Title.Alignment = taCenter
          Title.Caption = 'VR CORT'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DTSOL'
          Title.Alignment = taCenter
          Title.Caption = 'DATA'
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INDAPR'
          Visible = False
        end>
    end
    object JvGradientHeaderPanel1: TPanel
      Left = 4
      Top = 1
      Width = 475
      Height = 48
      TabOrder = 1
      object sLabelFX1: TsLabelFX
        Left = 112
        Top = 9
        Width = 227
        Height = 33
        Caption = 'PAINEL DE CORTESIAS'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = []
        Angle = 0
        Shadow.OffsetKeeper.LeftTop = -3
        Shadow.OffsetKeeper.RightBottom = 5
      end
      object GroupBox1: TGroupBox
        Left = 394
        Top = 2
        Width = 78
        Height = 44
        Caption = 'Status'
        TabOrder = 0
        object Shape1: TShape
          Left = 4
          Top = 15
          Width = 11
          Height = 11
          Brush.Color = clSkyBlue
        end
        object Label1: TLabel
          Left = 19
          Top = 13
          Width = 47
          Height = 13
          Caption = 'Aprovada'
        end
        object Label2: TLabel
          Left = 19
          Top = 28
          Width = 53
          Height = 13
          Caption = 'Reprovada'
        end
        object Shape2: TShape
          Left = 4
          Top = 29
          Width = 11
          Height = 11
          Brush.Color = clRed
        end
      end
      object GroupBox2: TGroupBox
        Left = 3
        Top = 4
        Width = 78
        Height = 44
        Caption = 'Vr Dispon'#237'vel'
        TabOrder = 1
        object lblValorDisp: TLabel
          Left = 3
          Top = 22
          Width = 73
          Height = 19
          Caption = 'R$ 120,00'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
      end
    end
    object btIncluir: TButton
      Left = 7
      Top = 206
      Width = 75
      Height = 25
      Caption = 'Incluir'
      TabOrder = 2
      OnClick = btIncluirClick
    end
    object btCancelar: TButton
      Left = 97
      Top = 206
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 3
      OnClick = btCancelarClick
    end
    object btAprovar: TButton
      Left = 312
      Top = 206
      Width = 75
      Height = 25
      Caption = 'Aprovar'
      TabOrder = 4
      OnClick = btAprovarClick
    end
    object btRejeitar: TButton
      Left = 401
      Top = 206
      Width = 75
      Height = 25
      Caption = 'Rejeitar'
      TabOrder = 5
      OnClick = btRejeitarClick
    end
  end
  object dsGrid: TDataSource
    DataSet = qrySolicitacoes
    Left = 87
    Top = 82
  end
  object qrySolicitacoes: TIBQuery
    Database = dmDescontos.bdDescontos2
    Transaction = dmDescontos.IBTransaction4
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select nomemed,nrcrm,especialidade,profissao from solicitpriv wh' +
        'ere flagenv='#39'N'#39)
    Left = 167
    Top = 82
  end
  object qryTemp: TIBQuery
    Database = dmDescontos.bdFcerta2
    Transaction = dmDescontos.IBTransaction3
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 15
    Top = 82
  end
  object qryTempPriv: TIBQuery
    Database = dmDescontos.bdDescontos2
    Transaction = dmDescontos.IBTransaction4
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 247
    Top = 82
  end
  object IdSMTP1: TIdSMTP
    Host = 'smtp.pharmapele.com.br'
    Password = 'l6495tmp'
    Port = 587
    SASLMechanisms = <>
    Username = 'programa@pharmapele.com.br'
    Left = 151
    Top = 146
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    FromList = <
      item
        Address = 'programa@pharmapele.com.br'
        Name = 'Privilege'
        Text = 'Privilege <programa@pharmapele.com.br>'
        Domain = 'pharmapele.com.br'
        User = 'programa'
      end>
    From.Address = 'programa@pharmapele.com.br'
    From.Name = 'Privilege'
    From.Text = 'Privilege <programa@pharmapele.com.br>'
    From.Domain = 'pharmapele.com.br'
    From.User = 'programa'
    Recipients = <>
    ReplyTo = <
      item
        Address = 'programa@pharmapele.com.br'
        Name = 'Privilege'
        Text = 'Privilege <programa@pharmapele.com.br>'
        Domain = 'pharmapele.com.br'
        User = 'programa'
      end>
    Sender.Address = 'programa@pharmapele.com.br'
    Sender.Name = 'Privilege'
    Sender.Text = 'Privilege <programa@pharmapele.com.br>'
    Sender.Domain = 'pharmapele.com.br'
    Sender.User = 'programa'
    ConvertPreamble = True
    Left = 31
    Top = 146
  end
end
