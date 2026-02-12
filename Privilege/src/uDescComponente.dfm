object frmDescMedQtdCMP: TfrmDescMedQtdCMP
  Left = 377
  Top = 210
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Desconto por QTD de componentes'
  ClientHeight = 293
  ClientWidth = 306
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = -1
    Width = 305
    Height = 113
    Caption = 'Painel Configura'#231#227'o'
    TabOrder = 0
    object Label3: TLabel
      Left = 169
      Top = 21
      Width = 36
      Height = 13
      Caption = '(Acima)'
    end
    object Label2: TLabel
      Left = 158
      Top = 10
      Width = 55
      Height = 13
      Caption = 'QTD Comp.'
    end
    object Label8: TLabel
      Left = 22
      Top = 23
      Width = 12
      Height = 13
      Caption = 'PF'
    end
    object Label7: TLabel
      Left = 51
      Top = 22
      Width = 13
      Height = 13
      Caption = 'UF'
    end
    object Label6: TLabel
      Left = 108
      Top = 22
      Width = 22
      Height = 13
      Caption = 'CRM'
    end
    object Label1: TLabel
      Left = 229
      Top = 20
      Width = 24
      Height = 13
      Caption = 'Valor'
    end
    object Label4: TLabel
      Left = 22
      Top = 61
      Width = 33
      Height = 13
      Caption = 'M'#233'dico'
    end
    object edtValor: TEdit
      Left = 229
      Top = 36
      Width = 65
      Height = 21
      TabOrder = 4
      OnExit = edtValorExit
    end
    object edtQTDComp: TEdit
      Left = 157
      Top = 36
      Width = 65
      Height = 21
      MaxLength = 2
      NumbersOnly = True
      TabOrder = 3
    end
    object edtPFCRM: TEdit
      Left = 20
      Top = 36
      Width = 24
      Height = 21
      TabOrder = 0
      OnExit = edtNRCRMExit
    end
    object edtNRCRM: TEdit
      Left = 106
      Top = 36
      Width = 45
      Height = 21
      MaxLength = 6
      NumbersOnly = True
      TabOrder = 2
      OnExit = edtNRCRMExit
    end
    object edtNomeMed: TEdit
      Left = 22
      Top = 75
      Width = 272
      Height = 21
      CharCase = ecUpperCase
      Color = clScrollBar
      Enabled = False
      TabOrder = 5
    end
    object cbUFCrM: TComboBox
      Left = 49
      Top = 36
      Width = 53
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      OnExit = edtNRCRMExit
      Items.Strings = (
        'PE')
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 150
    Width = 305
    Height = 140
    TabOrder = 1
    object dbgMedicos: TDBGrid
      Left = 2
      Top = 0
      Width = 300
      Height = 140
      DataSource = dsGrid
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'NOMEMED'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'MEDICO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QTDCPM'
          Title.Alignment = taCenter
          Title.Caption = 'QTD'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALFORM'
          Title.Alignment = taCenter
          Title.Caption = 'VALOR'
          Width = 60
          Visible = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 112
    Width = 305
    Height = 33
    TabOrder = 2
    object btExcluir: TSpeedButton
      Left = 153
      Top = 6
      Width = 139
      Height = 22
      Caption = 'Excluir'
      OnClick = btExcluirClick
    end
    object btIncluir: TBitBtn
      Left = 8
      Top = 5
      Width = 139
      Height = 22
      Caption = 'Incluir'
      TabOrder = 0
      OnClick = btIncluirClick
    end
  end
  object qryGrid: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 64
    Top = 182
  end
  object dsGrid: TDataSource
    DataSet = qryGrid
    Left = 200
    Top = 182
  end
  object qryTMPDescontos: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 80
    Top = 238
  end
  object qryTMPFcerta: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 208
    Top = 238
  end
end
