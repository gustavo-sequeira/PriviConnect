object frmCartaoCampanha: TfrmCartaoCampanha
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cart'#227'o Campanha'
  ClientHeight = 130
  ClientWidth = 458
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btImpCartaoCampanha: TsBitBtn
    Left = 2
    Top = 1
    Width = 455
    Height = 64
    Caption = 'Emiss'#227'o de Cart'#227'o-Campanha'
    TabOrder = 0
    OnClick = btImpCartaoCampanhaClick
  end
  object btVincularCartCampanha: TsBitBtn
    Left = 2
    Top = 65
    Width = 455
    Height = 64
    Caption = 'Vincular Cart'#227'o-Campanha'
    TabOrder = 1
  end
  object frxCodBarrasCampanha: TfrxReport
    Version = '6.7.9'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42467.942447928240000000
    ReportOptions.LastChange = 42472.495433449080000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 216
    Top = 48
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
      Orientation = poLandscape
      PaperWidth = 80.000000000000000000
      PaperHeight = 30.000000000000000000
      PaperSize = 256
      LeftMargin = 1.000000000000000000
      TopMargin = 1.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object MemoParam1: TfrxMemoView
        Align = baCenter
        AllowVectorExport = True
        Left = 105.826840000000000000
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
          'NRCARTAO')
        ParentFont = False
      end
      object BarCode1: TfrxBarCodeView
        Align = baCenter
        AllowVectorExport = True
        Left = 97.791435000000000000
        Top = 29.677180000000000000
        Width = 103.000000000000000000
        Height = 49.133890000000000000
        BarType = bcCodeEAN13
        Expression = 'bar'
        Frame.Typ = []
        HAlign = haCenter
        Rotation = 0
        ShowText = False
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
  object qryPrivilegeTMP: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 80
    Top = 22
  end
end
