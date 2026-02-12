object frmInformaDesconto: TfrmInformaDesconto
  Left = 368
  Top = 199
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Valor Desconto'
  ClientHeight = 336
  ClientWidth = 266
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gbFormula: TGroupBox
    Left = 2
    Top = 2
    Width = 128
    Height = 129
    Caption = 'Formula'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 16
      Top = 24
      Width = 51
      Height = 13
      Caption = 'Valor Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 41
      Top = 86
      Width = 16
      Height = 19
      Caption = '%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 14
      Top = 70
      Width = 45
      Height = 13
      Caption = 'Desconto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtValorTotalForm: TEdit
      Left = 14
      Top = 38
      Width = 98
      Height = 24
      TabOrder = 0
      OnChange = edtValorTotalFormChange
      OnExit = edtValorTotalFormExit
      OnKeyPress = edtValorTotalVarKeyPress
    end
    object edtPerDescFor: TEdit
      Left = 14
      Top = 85
      Width = 25
      Height = 24
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 1
      OnExit = edtPerDescForExit
    end
    object edtVrDescontoForm: TEdit
      Left = 65
      Top = 85
      Width = 47
      Height = 24
      TabOrder = 2
      OnChange = edtVrDescontoFormChange
      OnExit = edtVrDescontoFormExit
      OnKeyPress = edtValorTotalVarKeyPress
    end
  end
  object gbVarejo: TGroupBox
    Left = 136
    Top = 2
    Width = 128
    Height = 129
    Caption = 'Varejo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label4: TLabel
      Left = 16
      Top = 24
      Width = 51
      Height = 13
      Caption = 'Valor Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 41
      Top = 86
      Width = 16
      Height = 19
      Caption = '%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 14
      Top = 70
      Width = 45
      Height = 13
      Caption = 'Desconto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtValorTotalVar: TEdit
      Left = 14
      Top = 38
      Width = 98
      Height = 24
      TabOrder = 0
      OnChange = edtValorTotalVarChange
      OnExit = edtValorTotalVarExit
      OnKeyPress = edtValorTotalVarKeyPress
    end
    object edtPerDescVar: TEdit
      Left = 14
      Top = 85
      Width = 25
      Height = 24
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 1
      OnExit = edtPerDescVarExit
    end
    object edtVrDescontoVar: TEdit
      Left = 65
      Top = 85
      Width = 47
      Height = 24
      TabOrder = 2
      OnChange = edtVrDescontoVarChange
      OnExit = edtVrDescontoVarExit
      OnKeyPress = edtValorTotalVarKeyPress
    end
  end
  object GroupBox4: TGroupBox
    Left = 2
    Top = 158
    Width = 262
    Height = 175
    Caption = 'Resumo Descontos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object Label7: TLabel
      Left = 4
      Top = 22
      Width = 66
      Height = 13
      Caption = 'Vr Bruto F'#243'rm'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 93
      Top = 22
      Width = 58
      Height = 13
      Caption = 'Vr Bruto Var'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 80
      Top = 38
      Width = 8
      Height = 13
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 167
      Top = 39
      Width = 8
      Height = 13
      Caption = '='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 178
      Top = 22
      Width = 66
      Height = 13
      Caption = 'Vr Bruto Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 6
      Top = 70
      Width = 72
      Height = 13
      Caption = 'Desconto F'#243'rm'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 82
      Top = 86
      Width = 8
      Height = 13
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 95
      Top = 70
      Width = 64
      Height = 13
      Caption = 'Desconto Var'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 169
      Top = 87
      Width = 8
      Height = 13
      Caption = '='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 180
      Top = 70
      Width = 72
      Height = 13
      Caption = 'Desconto Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 3
      Top = 104
      Width = 256
      Height = 17
      Shape = bsBottomLine
    end
    object Label17: TLabel
      Left = 5
      Top = 126
      Width = 66
      Height = 13
      Caption = 'Vr Bruto Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 139
      Top = 126
      Width = 50
      Height = 13
      Caption = 'Desc Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label19: TLabel
      Left = 131
      Top = 144
      Width = 4
      Height = 13
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel
      Left = 192
      Top = 144
      Width = 8
      Height = 13
      Caption = '='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label21: TLabel
      Left = 204
      Top = 126
      Width = 46
      Height = 13
      Caption = 'Vr L'#237'quido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label22: TLabel
      Left = 85
      Top = 126
      Width = 37
      Height = 13
      Caption = 'Vr Taxa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label23: TLabel
      Left = 70
      Top = 144
      Width = 8
      Height = 13
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtVrBrutoForm: TEdit
      Left = 3
      Top = 36
      Width = 74
      Height = 24
      Color = clActiveCaption
      Enabled = False
      TabOrder = 0
    end
    object edtVrBrutoVar: TEdit
      Left = 91
      Top = 36
      Width = 74
      Height = 24
      Color = clInfoBk
      Enabled = False
      TabOrder = 1
    end
    object edtVrBrutoTot: TEdit
      Left = 176
      Top = 36
      Width = 74
      Height = 24
      Color = clMoneyGreen
      Enabled = False
      TabOrder = 2
    end
    object edtDescForm: TEdit
      Left = 5
      Top = 84
      Width = 74
      Height = 24
      Color = clActiveCaption
      Enabled = False
      TabOrder = 3
    end
    object edtDesVar: TEdit
      Left = 93
      Top = 84
      Width = 74
      Height = 24
      Color = clInfoBk
      Enabled = False
      TabOrder = 4
    end
    object edtDescTot: TEdit
      Left = 178
      Top = 84
      Width = 74
      Height = 24
      Color = clMoneyGreen
      Enabled = False
      TabOrder = 5
    end
    object edtResVrBrutTot: TEdit
      Left = 6
      Top = 140
      Width = 64
      Height = 24
      Color = clActiveCaption
      Enabled = False
      TabOrder = 6
    end
    object edtResVrDesTot: TEdit
      Left = 137
      Top = 140
      Width = 54
      Height = 24
      Color = clInfoBk
      Enabled = False
      TabOrder = 7
    end
    object edtVrCobradoLiq: TEdit
      Left = 200
      Top = 140
      Width = 58
      Height = 24
      BevelKind = bkTile
      BevelOuter = bvNone
      BevelWidth = 2
      Color = clMoneyGreen
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
    end
    object edtResVrTxaTot: TEdit
      Left = 79
      Top = 140
      Width = 51
      Height = 24
      Color = cl3DLight
      Enabled = False
      TabOrder = 9
    end
  end
  object Ok: TButton
    Left = 1
    Top = 128
    Width = 262
    Height = 25
    Caption = 'Ok'
    TabOrder = 2
    OnClick = OkClick
  end
  object qrySelecionaDesconto: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 623
    Top = 72
  end
  object qryBuscaDesc: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 122
    Top = 82
  end
  object qryInsereDesconto: TFDQuery
    Connection = dmDescontos.bdFcerta3
    Left = 104
    Top = 152
  end
end
