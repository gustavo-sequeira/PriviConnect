object frmCadCampanha: TfrmCadCampanha
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Campanha'
  ClientHeight = 355
  ClientWidth = 482
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
  object sLabelFX3: TsLabelFX
    Left = 15
    Top = 3
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
  object sLabelFX2: TsLabelFX
    Left = 389
    Top = 3
    Width = 85
    Height = 27
    Caption = 'VALIDADE'
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
  object edtNomeCampanha: TsEdit
    Left = 11
    Top = 24
    Width = 345
    Height = 27
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 119
    Width = 466
    Height = 228
    DataSource = dsGrid
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = PopupMenu1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'CAMPANHA'
        Title.Alignment = taCenter
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VAREJO'
        Title.Caption = 'VAR'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FORMULA'
        Title.Caption = 'FOR'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SALDO'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTVALIDADE'
        Title.Caption = 'VALIDADE'
        Width = 65
        Visible = True
      end>
  end
  object btCadastrar: TsBitBtn
    Left = 410
    Top = 80
    Width = 64
    Height = 33
    Caption = 'Cadastrar'
    TabOrder = 1
    OnClick = btCadastrarClick
  end
  object dtpValidade: TsDateEdit
    Left = 362
    Top = 24
    Width = 112
    Height = 27
    AutoSize = False
    MaxLength = 10
    TabOrder = 3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object gbTipoDesc: TsGroupBox
    Left = 8
    Top = 69
    Width = 385
    Height = 44
    TabOrder = 4
    object sLabelFX6: TsLabelFX
      Left = 159
      Top = 13
      Width = 64
      Height = 24
      Caption = 'FORMULA'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Angle = 0
      Shadow.OffsetKeeper.LeftTop = -3
      Shadow.OffsetKeeper.RightBottom = 5
    end
    object sLabelFX1: TsLabelFX
      Left = 15
      Top = 13
      Width = 53
      Height = 24
      Caption = 'VAREJO'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Angle = 0
      Shadow.OffsetKeeper.LeftTop = -3
      Shadow.OffsetKeeper.RightBottom = 5
    end
    object edtPercVar: TsEdit
      Left = 69
      Top = 13
      Width = 58
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 8
      NumbersOnly = True
      ParentFont = False
      TabOrder = 0
    end
    object edtPercFor: TsEdit
      Left = 226
      Top = 13
      Width = 58
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 8
      NumbersOnly = True
      ParentFont = False
      TabOrder = 1
    end
  end
  object rbPerc: TsRadioButton
    Left = 11
    Top = 56
    Width = 73
    Height = 17
    Caption = 'Percentual'
    Checked = True
    TabOrder = 5
    TabStop = True
  end
  object rbValor: TsRadioButton
    Left = 98
    Top = 56
    Width = 46
    Height = 17
    Caption = 'Valor'
    TabOrder = 6
  end
  object ckVerificaSaldo: TCheckBox
    Left = 377
    Top = 57
    Width = 97
    Height = 17
    Caption = 'Verifica Saldo'
    TabOrder = 7
  end
  object dsGrid: TDataSource
    DataSet = qryGrid
    Left = 216
    Top = 184
  end
  object qryGrid: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select nomecampanha as CAMPANHA,percvar as VAREJO,percfor as FOR' +
        'MULA, cast( saldo as numeric(10,2)) as SALDO  ,idcamp,IMAGEMCART' +
        'AO,DTVALIDADE , tpdesc from campanhas'
      'order by nomecampanha')
    Left = 128
    Top = 184
  end
  object qryInsert: TIBQuery
    Database = dmDescontos.bdDescontos2
    Transaction = dmDescontos.IBTransaction4
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 48
    Top = 224
  end
  object PopupMenu1: TPopupMenu
    Left = 280
    Top = 224
    object E1: TMenuItem
      Caption = 'Excluir'
      OnClick = E1Click
    end
  end
end
