object frmConsultoriaPremium: TfrmConsultoriaPremium
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Parceria Consultoria Premium'
  ClientHeight = 301
  ClientWidth = 513
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
  object gerarPlanilha: TsSpeedButton
    Left = 18
    Top = 267
    Width = 182
    Height = 25
    Caption = 'Gerar Extrato do M'#233'dico'
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
    OnClick = gerarPlanilhaClick
  end
  object dbgMedicos: TDBGrid
    Left = 17
    Top = 98
    Width = 486
    Height = 163
    DataSource = dsGrid
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = dbgMedicosDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'PFCRM'
        Width = 44
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UFCRM'
        Width = 43
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NRCRM'
        Width = 48
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMEMED'
        Width = 209
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PERFORM'
        Visible = True
      end>
  end
  object btnSair: TBitBtn
    Left = 447
    Top = 267
    Width = 58
    Height = 25
    Caption = 'Sair'
    TabOrder = 1
    OnClick = btnSairClick
  end
  object Panel1: TPanel
    Left = 17
    Top = -9
    Width = 488
    Height = 97
    TabOrder = 2
    object Label8: TLabel
      Left = 9
      Top = 23
      Width = 12
      Height = 13
      Caption = 'PF'
    end
    object Label6: TLabel
      Left = 76
      Top = 22
      Width = 22
      Height = 13
      Caption = 'CRM'
    end
    object Label1: TLabel
      Left = 45
      Top = 22
      Width = 13
      Height = 13
      Caption = 'UF'
    end
    object Label4: TLabel
      Left = 127
      Top = 22
      Width = 33
      Height = 13
      Caption = 'M'#233'dico'
    end
    object Label2: TLabel
      Left = 411
      Top = 22
      Width = 70
      Height = 13
      Caption = 'Perc%F'#243'rmula'
    end
    object edtPFCRM: TEdit
      Left = 9
      Top = 36
      Width = 24
      Height = 21
      TabOrder = 0
      OnExit = edtPFCRMExit
    end
    object edtNRCRM: TEdit
      Left = 74
      Top = 36
      Width = 45
      Height = 21
      MaxLength = 6
      NumbersOnly = True
      TabOrder = 2
      OnExit = edtNRCRMExit
    end
    object edtUFCRM: TEdit
      Left = 43
      Top = 36
      Width = 24
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
      OnExit = edtUFCRMExit
    end
    object edtNomeMed: TEdit
      Left = 128
      Top = 36
      Width = 277
      Height = 21
      MaxLength = 6
      NumbersOnly = True
      TabOrder = 3
    end
    object btnIncluir: TBitBtn
      Left = 125
      Top = 63
      Width = 58
      Height = 25
      Caption = 'Incluir'
      TabOrder = 5
      OnClick = btnIncluirClick
    end
    object btnExcluir: TBitBtn
      Left = 260
      Top = 63
      Width = 58
      Height = 25
      Caption = 'Excluir'
      Enabled = False
      TabOrder = 6
      OnClick = btnExcluirClick
    end
    object edtPerFormula: TMaskEdit
      Left = 424
      Top = 36
      Width = 55
      Height = 21
      TabOrder = 4
      Text = ''
    end
  end
  object dsGrid: TDataSource
    DataSet = qryGrid
    Left = 136
    Top = 142
  end
  object qryTMPFcerta: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 328
    Top = 136
  end
  object qryGrid: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 40
    Top = 143
  end
  object qryGrava: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 88
    Top = 143
  end
  object qryConsulta: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 328
    Top = 215
  end
end
