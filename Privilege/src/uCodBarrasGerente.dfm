object frmCodBarrasGerente: TfrmCodBarrasGerente
  Left = 354
  Top = 266
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Emiss'#227'o Cod Barras - Gerente'
  ClientHeight = 74
  ClientWidth = 281
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
  object Label1: TLabel
    Left = 11
    Top = 2
    Width = 20
    Height = 13
    Caption = 'Loja'
  end
  object cbLojas: TComboBox
    Left = 8
    Top = 16
    Width = 265
    Height = 21
    Style = csDropDownList
    TabOrder = 0
  end
  object btEmitir: TButton
    Left = 8
    Top = 43
    Width = 265
    Height = 25
    Caption = 'Emitir'
    TabOrder = 1
    OnClick = btEmitirClick
  end
  object qryFcertaTMP: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 112
    Top = 136
  end
  object qryPrivilegeTMP: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 192
    Top = 136
  end
  object frxCodBarrasGerente: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42467.942447928240000000
    ReportOptions.LastChange = 43235.563350312500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 224
    Top = 24
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
      object MemoParam1: TfrxMemoView
        Align = baCenter
        Left = 3.779530000000000000
        Top = 7.559060000000000000
        Width = 291.023810000000000000
        Height = 18.897650000000000000
        AutoWidth = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          'FUNCIONARIO')
        ParentFont = False
      end
      object BarCode1: TfrxBarCodeView
        Align = baCenter
        Left = 97.791435000000000000
        Top = 41.015770000000000000
        Width = 103.000000000000000000
        Height = 49.133890000000000000
        BarType = bcCodeEAN13
        Expression = 'bar'
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
      end
    end
  end
end
