object frmRelatorioDesconto: TfrmRelatorioDesconto
  Left = 263
  Top = 163
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio M'#233'dico'
  ClientHeight = 262
  ClientWidth = 466
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object rgTipo: TRadioGroup
    Left = 0
    Top = 0
    Width = 192
    Height = 44
    Caption = 'Tipo'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Sint'#233'tico'
      'Anal'#237'tico')
    TabOrder = 0
  end
  object gbIntervalo: TGroupBox
    Left = 192
    Top = 0
    Width = 273
    Height = 44
    Caption = 'Intervalo de Datas'
    TabOrder = 1
    object Inicial: TLabel
      Left = 8
      Top = 21
      Width = 27
      Height = 13
      Caption = 'Inicial'
    end
    object Label1: TLabel
      Left = 149
      Top = 21
      Width = 22
      Height = 13
      Caption = 'Final'
    end
    object dtFinal: TDateTimePicker
      Left = 176
      Top = 15
      Width = 86
      Height = 24
      Date = 40802.000000000000000000
      Time = 0.426179826390580300
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object dtInicial: TDateTimePicker
      Left = 41
      Top = 15
      Width = 86
      Height = 24
      Date = 40802.000000000000000000
      Time = 0.426179826390580300
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 243
    Width = 466
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object btGerar: TBitBtn
    Left = 233
    Top = 200
    Width = 232
    Height = 43
    Caption = 'Gerar'
    Glyph.Data = {
      0E030000424D0E030000000000003600000028000000110000000E0000000100
      180000000000D802000000000000000000000000000000000000BFBFBFBFBFBF
      BFBFBF0000000000000000000000000000000000000000000000000000000000
      00000000BFBFBFBFBFBFBFBFBF00BFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBF000000BFBFBFBFBF
      BF00BFBFBF000000000000000000000000000000000000000000000000000000
      000000000000000000000000BFBFBF000000BFBFBF00BFBFBF000000BFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBF00FFFF00FFFF00FFFFBFBFBFBFBFBF000000
      000000000000BFBFBF00BFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBF7F7F7F7F7F7F7F7F7FBFBFBFBFBFBF000000BFBFBF000000BFBFBF00BFBF
      BF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000BFBFBFBFBFBF00000000BFBFBF000000BFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBF000000BF
      BFBF00000000BFBFBFBFBFBF0000000000000000000000000000000000000000
      00000000000000000000BFBFBF000000BFBFBF00000000000000BFBFBFBFBFBF
      BFBFBF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
      00BFBFBF000000BFBFBF00000000BFBFBFBFBFBFBFBFBFBFBFBF000000FFFFFF
      000000000000000000000000000000FFFFFF000000000000000000000000BFBF
      BF00BFBFBFBFBFBFBFBFBFBFBFBF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF000000BFBFBFBFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBF000000FFFFFF000000000000000000000000000000FFFFFF000000
      BFBFBFBFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000FFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000BFBFBFBFBFBF00BFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00000000000000000000000000000000
      0000000000000000000000BFBFBFBFBFBF00}
    TabOrder = 3
    OnClick = btGerarClick
  end
  object brFechar: TBitBtn
    Left = 1
    Top = 200
    Width = 232
    Height = 43
    Caption = 'Fechar'
    Glyph.Data = {
      42010000424D4201000000000000760000002800000011000000110000000100
      040000000000CC000000CE0E0000C40E00001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777778888887
      777770000000777885555558877770000000778555DDDD555877700000007D55
      DD7777555587700000007D5577777855558770000000D55877778555D5587000
      0000D5877778555D7D5870000000D587778555D77D5870000000D58778555D77
      7D5870000000D5878555D7777D5870000000D558555D7777D558700000007D55
      55D77777D587700000007D555877778555877000000077D55588885558777000
      0000777DD555555DD7777000000077777DDDDDD7777770000000777777777777
      777770000000}
    TabOrder = 4
    OnClick = brFecharClick
  end
  object gbMedicos: TGroupBox
    Left = 0
    Top = 90
    Width = 465
    Height = 110
    Caption = 'M'#233'dicos'
    TabOrder = 5
    object GroupBox1: TGroupBox
      Left = 4
      Top = 60
      Width = 458
      Height = 46
      Caption = 'Especialidade'
      TabOrder = 0
      object cbEspecialidade: TComboBox
        Left = 15
        Top = 18
        Width = 434
        Height = 21
        Style = csDropDownList
        TabOrder = 0
      end
    end
    object GroupBox2: TGroupBox
      Left = 4
      Top = 15
      Width = 458
      Height = 42
      Caption = 'CRM'
      TabOrder = 1
      object edtNomeMed: TEdit
        Left = 240
        Top = 14
        Width = 207
        Height = 21
        CharCase = ecUpperCase
        Color = clScrollBar
        Enabled = False
        TabOrder = 3
      end
      object edtCR: TEdit
        Left = 186
        Top = 14
        Width = 52
        Height = 21
        CharCase = ecUpperCase
        Color = clScrollBar
        Enabled = False
        MaxLength = 5
        TabOrder = 2
        OnChange = edtCRChange
        OnKeyPress = edtCRKeyPress
      end
      object cbUFCRM: TComboBox
        Left = 141
        Top = 14
        Width = 44
        Height = 21
        Style = csDropDownList
        ItemIndex = 16
        TabOrder = 1
        Text = 'PE'
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
      object cbProfissao: TComboBox
        Left = 16
        Top = 14
        Width = 123
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
    end
  end
  object gbProdutos: TGroupBox
    Left = 0
    Top = 45
    Width = 465
    Height = 44
    Caption = 'Produtos'
    TabOrder = 6
    object cbProdutos: TComboBox
      Left = 22
      Top = 16
      Width = 427
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = '0 - TODOS'
      Items.Strings = (
        '0 - TODOS'
        '1 - FORMULAS'
        '2 - VAREJOS')
    end
  end
  object qryTemp: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 85
    Top = 328
  end
  object qryTempPriv: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 184
    Top = 77
  end
  object qryPriv2: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 304
    Top = 85
  end
  object qryPesqMedicos: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 176
    Top = 32
  end
end
