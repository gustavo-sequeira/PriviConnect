object frmEditarCupom: TfrmEditarCupom
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Editar Cupom'
  ClientHeight = 495
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel1: TsLabel
    Left = 466
    Top = 112
    Width = 28
    Height = 13
    Caption = 'Fonte'
  end
  object sLabel2: TsLabel
    Left = 534
    Top = 173
    Width = 17
    Height = 13
    Caption = 'Cor'
  end
  object sLabel4: TsLabel
    Left = 468
    Top = 260
    Width = 6
    Height = 13
    Caption = 'X'
  end
  object sLabel5: TsLabel
    Left = 529
    Top = 259
    Width = 6
    Height = 13
    Caption = 'Y'
  end
  object sLabel7: TsLabel
    Left = 468
    Top = 318
    Width = 6
    Height = 13
    Caption = 'X'
  end
  object sLabel8: TsLabel
    Left = 529
    Top = 317
    Width = 6
    Height = 13
    Caption = 'Y'
  end
  object sLabel10: TsLabel
    Left = 468
    Top = 429
    Width = 6
    Height = 13
    Caption = 'X'
  end
  object sLabel11: TsLabel
    Left = 529
    Top = 428
    Width = 6
    Height = 13
    Caption = 'Y'
  end
  object sLabel3: TsLabel
    Left = 468
    Top = 173
    Width = 44
    Height = 13
    Caption = 'Tamanho'
  end
  object sLabel6: TsLabel
    Left = 468
    Top = 344
    Width = 5
    Height = 13
    Caption = 'L'
  end
  object sLabel9: TsLabel
    Left = 528
    Top = 344
    Width = 7
    Height = 13
    Caption = 'C'
  end
  object sColorSelect1: TsColorSelect
    Left = 534
    Top = 189
    Width = 23
    Height = 22
    Glyph.Data = {
      BA030000424DBA0300000000000036000000280000000F0000000F0000000100
      2000000000008403000000000000000000000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    OnChange = sColorSelect1Change
    ColorValue = clBlack
  end
  object sLabel12: TsLabel
    Left = 468
    Top = 372
    Width = 6
    Height = 13
    Caption = 'E'
  end
  object sGroupBox1: TsGroupBox
    Left = 465
    Top = -4
    Width = 123
    Height = 113
    Caption = 'Campos'
    TabOrder = 0
    object btCPF: TsBitBtn
      Left = 7
      Top = 23
      Width = 111
      Height = 25
      Caption = 'CPF'
      TabOrder = 0
      OnClick = btCPFClick
    end
    object btNome: TsBitBtn
      Left = 7
      Top = 52
      Width = 111
      Height = 25
      Caption = 'NOME'
      TabOrder = 1
      OnClick = btNomeClick
    end
    object btCelular: TsBitBtn
      Left = 7
      Top = 82
      Width = 111
      Height = 25
      Caption = 'CELULAR'
      TabOrder = 2
      OnClick = btCelularClick
    end
  end
  object cbFontes: TsFontComboBox
    Left = 468
    Top = 126
    Width = 121
    Height = 22
    TabOrder = 1
    OnChange = cbFontesChange
    Color = clHotLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    SkinData.CustomColor = True
    SkinData.CustomFont = True
  end
  object sScrollBox1: TsScrollBox
    Left = 8
    Top = 11
    Width = 452
    Height = 479
    TabOrder = 2
    object imgCampanha: TsImage
      Left = 0
      Top = 0
      Width = 448
      Height = 475
      Align = alClient
      AutoSize = True
      Picture.Data = {07544269746D617000000000}
      OnClick = imgCampanhaClick
      SkinData.SkinSection = 'CHECKBOX'
      ExplicitLeft = 1
      ExplicitTop = -2
    end
    object lblCPF: TLabel
      Left = 360
      Top = 266
      Width = 29
      Height = 13
      Caption = 'lblCPF'
      Visible = False
    end
    object lblNome: TLabel
      Left = 360
      Top = 285
      Width = 37
      Height = 13
      Caption = 'lblNome'
      Visible = False
    end
    object lblCelular: TLabel
      Left = 360
      Top = 310
      Width = 43
      Height = 13
      Caption = 'lblCelular'
      Visible = False
    end
    object lblNome2: TLabel
      Left = 352
      Top = 376
      Width = 43
      Height = 13
      Caption = 'lblNome2'
      Visible = False
    end
    object lblNome3: TLabel
      Left = 354
      Top = 400
      Width = 43
      Height = 13
      Caption = 'lblNome3'
      Visible = False
    end
  end
  object edtCPFX: TsEdit
    Left = 480
    Top = 255
    Width = 25
    Height = 21
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 4
    NumbersOnly = True
    ParentFont = False
    TabOrder = 3
    Text = '0'
    OnChange = edtCPFXChange
  end
  object sUpDown1: TsUpDown
    Left = 505
    Top = 255
    Width = 16
    Height = 21
    Associate = edtCPFX
    Max = 448
    TabOrder = 4
  end
  object edtCPFY: TsEdit
    Left = 541
    Top = 255
    Width = 25
    Height = 21
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 4
    NumbersOnly = True
    ParentFont = False
    TabOrder = 5
    Text = '0'
    OnChange = edtCPFYChange
  end
  object sUpDown2: TsUpDown
    Left = 566
    Top = 255
    Width = 16
    Height = 21
    Associate = edtCPFY
    Max = 475
    TabOrder = 6
  end
  object edtNomeX: TsEdit
    Left = 480
    Top = 313
    Width = 25
    Height = 21
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 4
    NumbersOnly = True
    ParentFont = False
    TabOrder = 7
    Text = '0'
    OnChange = edtNomeXChange
  end
  object sUpDown3: TsUpDown
    Left = 505
    Top = 313
    Width = 16
    Height = 21
    Associate = edtNomeX
    Max = 448
    TabOrder = 8
  end
  object edtNomeY: TsEdit
    Left = 541
    Top = 313
    Width = 25
    Height = 21
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 4
    NumbersOnly = True
    ParentFont = False
    TabOrder = 9
    Text = '0'
    OnChange = edtNomeYChange
  end
  object sUpDown4: TsUpDown
    Left = 566
    Top = 313
    Width = 16
    Height = 21
    Associate = edtNomeY
    Max = 475
    TabOrder = 10
  end
  object edtCelularX: TsEdit
    Left = 480
    Top = 424
    Width = 25
    Height = 21
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 4
    NumbersOnly = True
    ParentFont = False
    TabOrder = 11
    Text = '0'
    OnChange = edtCelularXChange
  end
  object sUpDown5: TsUpDown
    Left = 505
    Top = 424
    Width = 16
    Height = 21
    Associate = edtCelularX
    Max = 448
    TabOrder = 12
  end
  object edtCelularY: TsEdit
    Left = 541
    Top = 424
    Width = 25
    Height = 21
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 4
    NumbersOnly = True
    ParentFont = False
    TabOrder = 13
    Text = '0'
    OnChange = edtCelularYChange
  end
  object sUpDown6: TsUpDown
    Left = 566
    Top = 424
    Width = 16
    Height = 21
    Associate = edtCelularY
    Max = 475
    TabOrder = 14
  end
  object chkCPF: TsCheckBox
    Left = 505
    Top = 231
    Width = 46
    Height = 17
    Caption = 'CPF'
    TabOrder = 15
    OnClick = chkCPFClick
  end
  object chkNome: TsCheckBox
    Left = 505
    Top = 290
    Width = 56
    Height = 17
    Caption = 'NOME'
    TabOrder = 16
    OnClick = chkNomeClick
  end
  object chkCelular: TsCheckBox
    Left = 505
    Top = 402
    Width = 71
    Height = 17
    Caption = 'CELULAR'
    TabOrder = 17
    OnClick = chkCelularClick
  end
  object btGravar: TsBitBtn
    Left = 471
    Top = 457
    Width = 111
    Height = 25
    Caption = 'GRAVAR'
    TabOrder = 18
    OnClick = btGravarClick
  end
  object edtTamanho: TsEdit
    Left = 470
    Top = 189
    Width = 25
    Height = 21
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 4
    NumbersOnly = True
    ParentFont = False
    TabOrder = 19
    Text = '10'
    OnChange = edtTamanhoChange
  end
  object sUpDown7: TsUpDown
    Left = 495
    Top = 189
    Width = 16
    Height = 21
    Associate = edtTamanho
    Position = 10
    TabOrder = 20
  end
  object edtNomeL: TsEdit
    Left = 479
    Top = 340
    Width = 25
    Height = 21
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 1
    NumbersOnly = True
    ParentFont = False
    TabOrder = 21
    Text = '1'
    OnChange = edtNomeLChange
  end
  object sUpDown8: TsUpDown
    Left = 504
    Top = 340
    Width = 16
    Height = 21
    Associate = edtNomeL
    Min = 1
    Max = 3
    Position = 1
    TabOrder = 22
  end
  object edtNomeC: TsEdit
    Left = 540
    Top = 340
    Width = 25
    Height = 21
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 4
    NumbersOnly = True
    ParentFont = False
    TabOrder = 23
    Text = '40'
    OnChange = edtNomeCChange
  end
  object sUpDown9: TsUpDown
    Left = 565
    Top = 340
    Width = 16
    Height = 21
    Associate = edtNomeC
    Min = 1
    Position = 40
    TabOrder = 24
  end
  object chkNegrito: TsCheckBox
    Left = 466
    Top = 153
    Width = 62
    Height = 17
    Caption = 'Negrito'
    TabOrder = 25
    OnClick = chkNegritoClick
  end
  object chkItalico: TsCheckBox
    Left = 534
    Top = 153
    Width = 56
    Height = 17
    Caption = 'It'#225'lico'
    TabOrder = 26
    OnClick = chkItalicoClick
  end
  object edtEspaco: TsEdit
    Left = 480
    Top = 367
    Width = 25
    Height = 21
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 1
    NumbersOnly = True
    ParentFont = False
    TabOrder = 27
    Text = '0'
    OnChange = edtEspacoChange
  end
  object sUpDown10: TsUpDown
    Left = 505
    Top = 367
    Width = 16
    Height = 21
    Associate = edtEspaco
    Min = -5
    Max = 10
    TabOrder = 28
  end
  object qryGravaConfig: TIBQuery
    Database = dmDescontos.bdDescontos2
    Transaction = dmDescontos.IBTransaction4
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 160
    Top = 131
  end
end
