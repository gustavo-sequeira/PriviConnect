object frmCodBarrasMedicos: TfrmCodBarrasMedicos
  Left = 406
  Top = 268
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Emiss'#227'o Cod Barras'
  ClientHeight = 108
  ClientWidth = 276
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 276
    Height = 108
    Align = alClient
    TabOrder = 0
    object edtFuncionario: TEdit
      Left = 8
      Top = 53
      Width = 262
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      OnChange = edtFuncionarioChange
      OnKeyPress = edtFuncionarioKeyPress
      OnKeyUp = edtFuncionarioKeyUp
    end
    object btImprimir: TBitBtn
      Left = 96
      Top = 80
      Width = 177
      Height = 25
      Caption = 'Imprimir'
      Glyph.Data = {
        E6000000424DE6000000000000007600000028000000100000000E0000000100
        0400000000007000000000000000000000001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333330000000000003330777777777777033088888888899703308888888888
        870333000000000000333330FCCCCCCF03333330FFFFFFFF03333330FCCCCCCF
        03333330FFFFFFFF03333330FCCCCCCF03333330FFFFFFFF0333333000000000
        03333333333333333333}
      TabOrder = 1
      OnClick = btImprimirClick
      OnKeyUp = btImprimirKeyUp
    end
    object gbCRM: TGroupBox
      Left = 164
      Top = 2
      Width = 109
      Height = 47
      Caption = 'CRM'
      TabOrder = 2
      object edtCRM: TEdit
        Left = 50
        Top = 16
        Width = 52
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 6
        TabOrder = 0
        OnChange = edtCRMChange
        OnKeyPress = edtCRMKeyPress
        OnKeyUp = edtCRMKeyUp
      end
      object cbUF: TComboBox
        Left = 6
        Top = 16
        Width = 41
        Height = 21
        Style = csDropDownList
        ItemIndex = 16
        TabOrder = 1
        Text = 'PE'
        OnChange = cbUFChange
        Items.Strings = (
          'AC'
          'AL'
          'AP'
          'AM'
          'BA'
          'CE'
          'DF'
          'ES'
          'GO'
          'MA'
          'MT'
          'MS'
          'MG'
          'PA'
          'PB'
          'PR'
          'PE'
          'PI'
          'RJ'
          'RN'
          'RS'
          'RO'
          'RR'
          'SC'
          'SP'
          'SE'
          'TO')
      end
    end
    object DBGrid1: TDBGrid
      Left = 24
      Top = 208
      Width = 577
      Height = 233
      DataSource = DataSource1
      TabOrder = 3
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
    object GroupBox12: TGroupBox
      Left = 3
      Top = 2
      Width = 159
      Height = 47
      Caption = 'Profiss'#227'o'
      TabOrder = 4
      object cbProfissao: TComboBox
        Left = 5
        Top = 16
        Width = 34
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = '1'
        OnChange = cbProfissaoChange
        Items.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '0'
          'A'
          'B')
      end
      object edtProfissao: TEdit
        Left = 40
        Top = 16
        Width = 110
        Height = 21
        Color = clScrollBar
        Enabled = False
        TabOrder = 1
      end
    end
    object chkPeeling: TCheckBox
      Left = 17
      Top = 83
      Width = 60
      Height = 17
      Caption = 'Peeling'
      TabOrder = 5
    end
  end
  object qryCodBMedicos: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 368
    Top = 32
  end
  object DataSource1: TDataSource
    DataSet = qryCodBMedicos
    Left = 328
    Top = 280
  end
  object qryTemp: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 835
    Top = 98
  end
  object qryUpPrivilege: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 771
    Top = 106
  end
  object frxEtqMedico: TfrxReport
    Version = '6.7.9'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42464.435691747700000000
    ReportOptions.LastChange = 42523.647231851850000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 659
    Top = 82
    Datasets = <>
    Variables = <
      item
        Name = ' New Category1'
        Value = Null
      end
      item
        Name = 'bar'
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Orientation = poLandscape
      PaperWidth = 80.000000000000000000
      PaperHeight = 30.000000000000000000
      PaperSize = 256
      LeftMargin = 11.000000000000000000
      TopMargin = 11.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object MemoParam1: TfrxMemoView
        Align = baCenter
        AllowVectorExport = True
        Left = 86.929190000000000000
        Top = 7.559060000000000000
        Width = 86.929190000000000000
        Height = 18.897650000000000000
        AutoWidth = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = []
        Memo.UTF8W = (
          'FUNCIONARIO')
        ParentFont = False
      end
      object BarCode1: TfrxBarCodeView
        Align = baCenter
        AllowVectorExport = True
        Left = 6.793785000000014000
        Top = 29.677180000000000000
        Width = 103.000000000000000000
        Height = 49.133890000000000000
        BarType = bcCodeEAN13
        CalcCheckSum = True
        Expression = 'bar'
        Frame.Typ = []
        Rotation = 0
        TestLine = False
        Text = '12345678'
        WideBarRatio = 2.000000000000000000
        Zoom = 2.400000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -5
        Font.Name = 'Arial'
        Font.Style = []
        ColorBar = clBlack
      end
    end
  end
  object IBQuery1: TIBQuery
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 992
    Top = 96
  end
end
