object frmRelCampanhas: TfrmRelCampanhas
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio Campanha'
  ClientHeight = 274
  ClientWidth = 416
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object rgTipo: TRadioGroup
    Left = 0
    Top = -3
    Width = 145
    Height = 49
    Caption = 'Tipo'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Sint'#233'tico'
      'Anal'#237'tico')
    TabOrder = 0
  end
  object gbIntervalo: TGroupBox
    Left = 0
    Top = 48
    Width = 145
    Height = 113
    Caption = 'Intervalo de Datas'
    TabOrder = 1
    object Inicial: TLabel
      Left = 12
      Top = 24
      Width = 27
      Height = 13
      Caption = 'Inicial'
    end
    object Label1: TLabel
      Left = 14
      Top = 67
      Width = 22
      Height = 13
      Caption = 'Final'
    end
    object dtFinal: TDateTimePicker
      Left = 28
      Top = 82
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
      Left = 28
      Top = 40
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
    Top = 255
    Width = 416
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object btGerar: TBitBtn
    Left = 211
    Top = 211
    Width = 203
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
    Left = 0
    Top = 211
    Width = 203
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
  object gbRelatorios: TGroupBox
    Left = 151
    Top = 52
    Width = 265
    Height = 109
    Caption = 'Relat'#243'rios'
    TabOrder = 5
    object rbParceito: TRadioButton
      Left = 17
      Top = 19
      Width = 209
      Height = 17
      Caption = 'Por parceiro'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbParceitoClick
    end
    object rbCliente: TRadioButton
      Left = 17
      Top = 50
      Width = 232
      Height = 17
      Caption = 'Por Cliente'
      TabOrder = 1
      OnClick = rbClienteClick
    end
    object rbFatvsDesc: TRadioButton
      Left = 17
      Top = 81
      Width = 232
      Height = 17
      Caption = 'Faturamento vs Descontos'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clScrollBar
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = rbFatvsDescClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 151
    Top = 0
    Width = 264
    Height = 49
    Caption = 'Loja'
    TabOrder = 6
    object cbLoja: TComboBox
      Left = 27
      Top = 16
      Width = 218
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 162
    Width = 415
    Height = 49
    Caption = 'Filtro'
    TabOrder = 7
    object cbNomeCampanha: TComboBox
      Left = 14
      Top = 19
      Width = 382
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
    object edtNomeCliente: TEdit
      Left = 135
      Top = 19
      Width = 260
      Height = 21
      CharCase = ecUpperCase
      Color = clScrollBar
      Enabled = False
      TabOrder = 1
      Visible = False
    end
    object edtCPF: TEdit
      Left = 14
      Top = 19
      Width = 90
      Height = 21
      CharCase = ecUpperCase
      Color = clScrollBar
      Enabled = False
      MaxLength = 5
      TabOrder = 2
      Visible = False
    end
  end
  object qryTemp: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 373
    Top = 103
  end
  object qryFcerta: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 336
    Top = 80
  end
  object qryDescontos: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 304
    Top = 56
  end
end
