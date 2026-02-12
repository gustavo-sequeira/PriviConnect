object frmPlanilhaDescontos: TfrmPlanilhaDescontos
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Planilha de Descontos'
  ClientHeight = 199
  ClientWidth = 371
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnGerar: TsSpeedButton
    Left = 133
    Top = 125
    Width = 121
    Height = 29
    Caption = 'Gerar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      08000000000000010000000000000000000000010000000100002C6642007CB5
      8A00E6F0E6001E53310057825A009DD0A70071AA81006CA67C00AAD6B200EBF3
      EB00F9FBFA0081BC900076AF85004B964D00417B5700DCEADB00328735003D8C
      5700EDF5ED00E4EFE400F1F7F1001A4D2A00F6FAF6004D876200EFF6EF00F4F9
      F40004690400F3F8F300DFECDF00E2EEE300FCFDFB00D8E7D800FDFEFD00358C
      4F00DEEBDE008AB7950064AC6900F5F9F500F8FAF800FFFFFF0068B06F00558E
      670073BB7C005CAA6500DAE9DA00FEFEFE001D781E00DCEADD00E8F1E80081AA
      8D006DB67500E9F2E9006199640047815D00F6F9F600FEFFFE00579A5E004093
      4700FCFDFC00E1EDE10063B2760042874900D9E8D900EAF1E9007CC1850094C7
      9C0058966B00336D470066A077005F9B720055A45A002C5230003A734C00265D
      380049935F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000484848434343
      0000004949490303031548074444454542424A4A4A11112121150E0709300213
      1D1C222F0F3E1F1F21150E0612093F02131D1C220F0F2C1F1103350C18120933
      301331474747472C110317011B46474747472E324A0D490F4A49290B1914463C
      462E404A0D49312F4A49422316251B46100B4A0D4934341C4A4945410A162510
      412B46431A021D3B420044411E0A3905322B3D46101A0213420007053A0D082A
      2A4A042846101A02454306052D28242438361B040404043345430C082D20201E
      0A2636191418120944480108272737201E0A2616191418124448010808050541
      4141230B010C060607480B010C0607444542291717350E0E4848}
    ParentFont = False
    OnClick = btnGerarClick
  end
  object sLabelFX1: TsLabelFX
    Left = 12
    Top = 69
    Width = 41
    Height = 26
    Caption = 'Filial'
    Color = clWhite
    ParentColor = False
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    Angle = 0
    Shadow.OffsetKeeper.LeftTop = -3
    Shadow.OffsetKeeper.RightBottom = 5
  end
  object GroupBox1: TsGroupBox
    Left = 8
    Top = -2
    Width = 357
    Height = 59
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label3D2: TsLabelFX
      Left = 211
      Top = 23
      Width = 35
      Height = 26
      Caption = 'Fim'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      Angle = 0
      Shadow.OffsetKeeper.LeftTop = -3
      Shadow.OffsetKeeper.RightBottom = 5
    end
    object Label3D1: TsLabelFX
      Left = 4
      Top = 23
      Width = 44
      Height = 26
      Caption = 'Inicio'
      Color = clWhite
      ParentColor = False
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      Angle = 0
      Shadow.OffsetKeeper.LeftTop = -3
      Shadow.OffsetKeeper.RightBottom = 5
    end
    object dtpFim: TDateTimePicker
      Left = 252
      Top = 23
      Width = 91
      Height = 24
      Date = 40234.000000000000000000
      Time = 0.426179826390580300
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object dtpInicio: TDateTimePicker
      Left = 52
      Top = 26
      Width = 91
      Height = 24
      Date = 40234.000000000000000000
      Time = 0.426179826390580300
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 168
    Width = 357
    Height = 17
    TabOrder = 1
  end
  object edtFilial: TEdit
    Left = 59
    Top = 68
    Width = 44
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnKeyPress = edtFilialKeyPress
  end
  object edtNomeFilial: TEdit
    Left = 109
    Top = 68
    Width = 256
    Height = 27
    Color = clScrollBar
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object qryDados: TFDQuery
    Connection = dmDescontos.bdFcerta3
    Left = 17
    Top = 111
  end
  object qryTemp: TFDQuery
    Connection = dmDescontos.bdFcerta3
    Left = 64
    Top = 111
  end
  object qryParametros: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 317
    Top = 99
  end
  object qryFilais: TFDQuery
    Connection = dmDescontos.bdFcerta3
    SQL.Strings = (
      
        'select fc01000.cdfil , fc01000.descrfil   from FC01000 where gru' +
        'pofil='#39'03'#39' ORDER BY CDFIL')
    Left = 120
    Top = 95
  end
end
