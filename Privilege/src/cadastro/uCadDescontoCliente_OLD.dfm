object frmCadDescontoCliente: TfrmCadDescontoCliente
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cliente Campanha'
  ClientHeight = 544
  ClientWidth = 531
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
  object sLabelFX1: TsLabelFX
    Left = 15
    Top = 184
    Width = 35
    Height = 27
    Caption = 'CPF'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Angle = 0
    Shadow.OffsetKeeper.LeftTop = -3
    Shadow.OffsetKeeper.RightBottom = 5
  end
  object sLabelFX2: TsLabelFX
    Left = 14
    Top = 6
    Width = 94
    Height = 27
    Caption = 'CAMPANHA'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Angle = 0
    Shadow.OffsetKeeper.LeftTop = -3
    Shadow.OffsetKeeper.RightBottom = 5
  end
  object sLabelFX3: TsLabelFX
    Left = 15
    Top = 129
    Width = 52
    Height = 27
    Caption = 'NOME'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Angle = 0
    Shadow.OffsetKeeper.LeftTop = -3
    Shadow.OffsetKeeper.RightBottom = 5
  end
  object btCadCampanha: TsSpeedButton
    Left = 497
    Top = 32
    Width = 26
    Height = 25
    Caption = '...'
    OnClick = btCadCampanhaClick
  end
  object sLabelFX4: TsLabelFX
    Left = 15
    Top = 242
    Width = 80
    Height = 27
    Caption = 'CLIENTES'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Angle = 0
    Shadow.OffsetKeeper.LeftTop = -3
    Shadow.OffsetKeeper.RightBottom = 5
  end
  object sLabelFX5: TsLabelFX
    Left = 150
    Top = 184
    Width = 41
    Height = 27
    Caption = 'DDD'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Angle = 0
    Shadow.OffsetKeeper.LeftTop = -3
    Shadow.OffsetKeeper.RightBottom = 5
  end
  object sLabelFX6: TsLabelFX
    Left = 210
    Top = 184
    Width = 75
    Height = 27
    Caption = 'CELULAR'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Angle = 0
    Shadow.OffsetKeeper.LeftTop = -3
    Shadow.OffsetKeeper.RightBottom = 5
  end
  object sLabelFX7: TsLabelFX
    Left = 17
    Top = 62
    Width = 99
    Height = 27
    Caption = 'VALOR FOR.'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Angle = 0
    Shadow.OffsetKeeper.LeftTop = -3
    Shadow.OffsetKeeper.RightBottom = 5
  end
  object sLabelFX8: TsLabelFX
    Left = 431
    Top = 63
    Width = 100
    Height = 27
    Caption = 'VALOR VAR.'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Angle = 0
    Shadow.OffsetKeeper.LeftTop = -3
    Shadow.OffsetKeeper.RightBottom = 5
  end
  object edtCPF: TsEdit
    Left = 17
    Top = 209
    Width = 120
    Height = 27
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 11
    NumbersOnly = True
    ParentFont = False
    TabOrder = 1
  end
  object cbCampanhaNome: TsComboBox
    Left = 17
    Top = 30
    Width = 474
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Color = 16773594
    Style = csDropDownList
    ItemIndex = -1
    TabOrder = 5
    OnChange = cbCampanhaNomeChange
  end
  object edtNomeCliente: TsEdit
    Left = 15
    Top = 151
    Width = 508
    Height = 27
    CharCase = ecUpperCase
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 80
    ParentFont = False
    TabOrder = 0
  end
  object dbCLientes: TDBGrid
    Left = 1
    Top = 272
    Width = 522
    Height = 237
    DataSource = dsGrid
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = PopupMenu1
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'nomecli'
        Title.Caption = 'CLIENTE'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cpfcli'
        Title.Caption = 'CPF'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ddd'
        Title.Caption = 'DDD'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'celular'
        Title.Caption = 'CELULAR'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALORFOR'
        Title.Caption = 'VALOR FOR'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALORVAR'
        Title.Caption = 'VALOR VAR'
        Visible = True
      end>
  end
  object edtDDD: TsEdit
    Left = 150
    Top = 209
    Width = 47
    Height = 27
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 2
    NumbersOnly = True
    ParentFont = False
    TabOrder = 2
  end
  object edtCelular: TsEdit
    Left = 210
    Top = 209
    Width = 136
    Height = 27
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 9
    NumbersOnly = True
    ParentFont = False
    TabOrder = 3
  end
  object btCadastrar: TsBitBtn
    Left = 456
    Top = 212
    Width = 67
    Height = 25
    Caption = 'Cadastrar'
    TabOrder = 4
    OnClick = btCadastrarClick
  end
  object btGerarCupons: TsBitBtn
    Left = 443
    Top = 515
    Width = 80
    Height = 25
    Caption = 'Gerar Cupons'
    TabOrder = 7
    OnClick = btGerarCuponsClick
  end
  object edtValorfor: TEdit
    Left = 17
    Top = 95
    Width = 91
    Height = 27
    Alignment = taRightJustify
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    Text = '0,00'
    OnClick = edtValorforClick
    OnKeyUp = edtValorforKeyUp
  end
  object edtValorvar: TEdit
    Left = 431
    Top = 96
    Width = 91
    Height = 27
    Alignment = taRightJustify
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    Text = '0,00'
    OnClick = edtValorvarClick
    OnKeyUp = edtValorvarKeyUp
  end
  object sBitBtn1: TsBitBtn
    Left = 8
    Top = 515
    Width = 80
    Height = 25
    Caption = 'Exportar'
    TabOrder = 10
    OnClick = sBitBtn1Click
  end
  object qryTmp: TIBQuery
    Database = dmDescontos.bdDescontos2
    Transaction = dmDescontos.IBTransaction4
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 384
    Top = 8
  end
  object qryGrid: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 176
    Top = 336
  end
  object dsGrid: TDataSource
    DataSet = qryGrid
    Left = 256
    Top = 343
  end
  object PopupMenu1: TPopupMenu
    Left = 96
    Top = 375
    object E1: TMenuItem
      Caption = 'Excluir'
      OnClick = E1Click
    end
  end
  object qryExcel: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 112
    Top = 496
  end
end
