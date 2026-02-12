object frmDescontoCampanha: TfrmDescontoCampanha
  Left = 0
  Top = 0
  Caption = 'Desconto Campanha'
  ClientHeight = 419
  ClientWidth = 404
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
  object dbgAtivosMon: TDBGrid
    Left = 2
    Top = 88
    Width = 375
    Height = 289
    DataSource = dsProdMon
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'COD'
        Title.Alignment = taCenter
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRODUTO'
        Title.Alignment = taCenter
        Width = 240
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MALOTESAMAIS'
        Title.Alignment = taCenter
        Title.Caption = '%'
        Width = 40
        Visible = True
      end>
  end
  object GroupBox1: TsGroupBox
    Left = 0
    Top = 0
    Width = 263
    Height = 53
    Caption = 'Produto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object edtProduto: TEdit
      Left = 59
      Top = 21
      Width = 198
      Height = 21
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = edtProdutoChange
      OnKeyPress = edtProdutoKeyPress
      OnKeyUp = edtProdutoKeyUp
    end
    object edtCodProd: TEdit
      Left = 6
      Top = 21
      Width = 49
      Height = 21
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = edtCodProdChange
      OnKeyPress = edtCodProdKeyPress
    end
  end
  object GroupBox2: TsGroupBox
    Left = 264
    Top = 0
    Width = 113
    Height = 53
    Caption = 'Malotes a frente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object cbMalotesaFrente: TsComboBox
      Left = 28
      Top = 21
      Width = 64
      Height = 21
      TabOrder = 0
      Color = 15921906
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'MS Sans Serif'
      BoundLabel.Font.Style = []
      BoundLabel.ParentFont = False
      SkinData.SkinSection = 'COMBOBOX'
      DropDownCount = 8
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
        '10'
        '11'
        '12')
      Style = csDropDownList
    end
  end
  object Panel1: TsPanel
    Left = 0
    Top = 54
    Width = 377
    Height = 34
    TabOrder = 3
    object btExcluir: TsSpeedButton
      Left = 190
      Top = 5
      Width = 175
      Height = 22
      Caption = 'Excluir'
      OnClick = btExcluirClick
    end
    object btIncluir: TsBitBtn
      Left = 9
      Top = 5
      Width = 175
      Height = 22
      Caption = 'Incluir'
      TabOrder = 0
      WordWrap = False
      OnClick = btIncluirClick
    end
  end
  object qryProdMon: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select cdpro as COD, descr as PRODUTO,malotesamais from FORMESPE' +
        'CIAIS'
      'order by 2,1')
    Left = 32
    Top = 248
  end
  object qryManutencaoAtivos: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 88
    Top = 192
  end
  object dsProdMon: TDataSource
    DataSet = qryProdMon
    Left = 264
    Top = 248
  end
  object qryProdutos: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 176
    Top = 216
  end
end
