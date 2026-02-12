object frmInclusaoCortesia: TfrmInclusaoCortesia
  Left = 532
  Top = 260
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Inclus'#227'o Cortesia'
  ClientHeight = 148
  ClientWidth = 235
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
  OnShortCut = FormShortCut
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gbFuncionario: TGroupBox
    Left = 0
    Top = 0
    Width = 233
    Height = 91
    Caption = 'Funcion'#225'rio'
    TabOrder = 0
    object edtFuncionario: TEdit
      Left = 3
      Top = 48
      Width = 213
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 1
      OnChange = edtFuncionarioChange
      OnKeyPress = edtFuncionarioKeyPress
    end
    object edtCOD: TEdit
      Left = 4
      Top = 21
      Width = 45
      Height = 21
      CharCase = ecUpperCase
      Color = clScrollBar
      Enabled = False
      MaxLength = 6
      NumbersOnly = True
      TabOrder = 0
    end
    object cbDepto: TComboBox
      Left = 71
      Top = 21
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      Items.Strings = (
        'ADMINISTRATIVO'
        'LABORATORIO'
        'ENTRONCAMENTO'
        'SH RECIFE 1'
        'GUARARAPES'
        'OLINDA'
        'BOA VISTA'
        'SH RECIFE 2'
        'TACARUNA'
        'PLAZA'
        'RIO MAR'
        'CABO'
        'CONSELHEIRO AGUIAR'
        'DELIVERY'
        'CARUARU'
        'NATUSENSE')
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 90
    Width = 233
    Height = 56
    Caption = 'Receita'
    TabOrder = 1
    object btOk: TBitBtn
      Left = 155
      Top = 18
      Width = 71
      Height = 28
      Caption = 'Ok'
      Glyph.Data = {
        02030000424D0203000000000000360100002800000013000000170000000100
        080000000000CC010000C30E0000C30E000040000000000000001C3404002434
        1C00242424001C3C0400243C0C00244404002C5C04003C5C240044543C005C5C
        54005C5C5C00646464006C6C6C0054743C007474740044840400747C74007C7C
        7C0084848400449404006C8C540054AC0400000000008C8C8C008C948C009494
        94009C9C9C00A4A4A400ACACAC00B4B4B4006CD404006CDC040074F404007CFC
        040084FC0C0084FC14007CDC24008CFC1C008CFC240094FC240094EC3C0094FC
        2C009CFC3C0094D45C009CF44C009CFC4400A4FC4C00A4FC5400ACFC6400B4FC
        6C00B4F47400BCF48400BCFC7C00B4C4A400ACCC9400BCCCAC00BCC4B400BCCC
        B400B4E48C00BCE49400BCDCA400C4F49400C4FC8C00C0C0C0003F3F3F3F3F3F
        191717193F3F3F3F3F3F3F3F3F003F3F3F3F3F1712111112193F3F3F3F3F3F3F
        3F003F3F3F3F19120E0C0C0E123F3F3F3F3F3F3F3F003F3F3F3F120E0C0B0B0C
        11173F3F3F3F3F3F3F003F3F3F17110C0B0A0A0B0E123F3F3F3F3F3F3F003F3F
        3F12140702010B0B0C11173F3F3F3F3F3F003F3F3F181E1E0F03100C0C0E1219
        3F3F3F3F3F003F3F3F2422231F06080C0C0C11173F3F3F3F3F003F3F2B212223
        221305170C0C0E11173F3F3F3F003F3521222323231E06090E0C0C0E12193F3F
        3F003F2B2223272726221304180E0C0C0E123F3F3F003F2926252A2F2F261F06
        08110E0C0E11173F3F0038302D232C39332E23150311110E0C0E11173F003F39
        2E28383F37312A220F0117110E0E0E1219003F3F373F3F3F3F3A30261E060917
        110E0E1117003F3F3F3F3F3F3F3F322E2315030C1712111217003F3F3F3F3F3F
        3F3F37342D2313001819171719003F3F3F3F3F3F3F3F3F3B342E231300193F3F
        3F003F3F3F3F3F3F3F3F3F3F3C3330230F011D3F3F003F3F3F3F3F3F3F3F3F3F
        3F393E31250F0D3F3F003F3F3F3F3F3F3F3F3F3F3F3F383D312320353F003F3F
        3F3F3F3F3F3F3F3F3F3F3F3F3C2A23363F003F3F3F3F3F3F3F3F3F3F3F3F3F3F
        3F3F373F3F00}
      TabOrder = 2
      OnClick = btOkClick
    end
    object edtReq: TEdit
      Left = 73
      Top = 21
      Width = 65
      Height = 21
      Color = clScrollBar
      Enabled = False
      MaxLength = 6
      NumbersOnly = True
      TabOrder = 1
    end
    object edtFil: TEdit
      Left = 28
      Top = 21
      Width = 39
      Height = 21
      Color = clScrollBar
      Enabled = False
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 0
    end
  end
  object qryFuncionarios: TIBQuery
    Database = dmDescontos.bdFcerta2
    Transaction = dmDescontos.IBTransaction3
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 336
    Top = 24
  end
  object qryBuscaReceitas: TIBQuery
    Database = dmDescontos.bdFcerta2
    Transaction = dmDescontos.IBTransaction3
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 336
    Top = 160
  end
  object qryInsereSolicitacao: TIBQuery
    Database = dmDescontos.bdDescontos2
    Transaction = dmDescontos.IBTransaction4
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 480
    Top = 160
  end
end
