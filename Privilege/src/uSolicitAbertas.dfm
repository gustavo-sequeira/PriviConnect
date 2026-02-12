object frmSolicitacaoesAbertas: TfrmSolicitacaoesAbertas
  Left = 328
  Top = 254
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Solicitac'#245'es em Aberto'
  ClientHeight = 390
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = -1
    Top = 0
    Width = 482
    Height = 193
    TabOrder = 0
    object dbgMedicos: TDBGrid
      Left = 3
      Top = 40
      Width = 473
      Height = 145
      DataSource = dsGridPrivilege
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = dbgMedicosDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'NOMEMED'
          Title.Caption = 'NOME'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NRCRM'
          Title.Caption = 'CRM'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ESPECIALIDADE'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PROFISSAO'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CDFILSOLIC'
          Title.Caption = 'FIL'
          Width = 25
          Visible = True
        end>
    end
    object Panel3: TPanel
      Left = 2
      Top = 3
      Width = 477
      Height = 33
      TabOrder = 1
      object Label1: TLabel
        Left = 112
        Top = -1
        Width = 243
        Height = 33
        Caption = 'Solicita'#231#245'es Privilege'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
    end
  end
  object Panel4: TPanel
    Left = -1
    Top = 195
    Width = 482
    Height = 193
    TabOrder = 1
    object dbgCadMed: TDBGrid
      Left = 3
      Top = 40
      Width = 473
      Height = 145
      DataSource = dsGridCadMedico
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = dbgCadMedDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'NOMEMED'
          Title.Caption = 'NOME'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NRCRM'
          Title.Caption = 'CRM'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ESPECIALIDADE'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PROFISSAO'
          Width = 90
          Visible = True
        end>
    end
    object Panel5: TPanel
      Left = 2
      Top = 3
      Width = 477
      Height = 33
      TabOrder = 1
      object Label2: TLabel
        Left = 60
        Top = -1
        Width = 340
        Height = 33
        Caption = 'Solicita'#231#245'es Cadastro M'#233'dico'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
    end
  end
  object dsGridPrivilege: TDataSource
    DataSet = qrySolicitacoesPriv
    Left = 71
    Top = 114
  end
  object qryPesqMedicos: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 295
    Top = 106
  end
  object qrySolicitacoesPriv: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from solicitpriv where flagenv='#39'N'#39)
    Left = 399
    Top = 106
  end
  object dsGridCadMedico: TDataSource
    DataSet = qrySolicitacoesCadM
    Left = 39
    Top = 299
  end
  object qrySolicitacoesCadM: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select nomemed,nrcrm,especialidade,profissao from solicitmed whe' +
        're flagconf='#39'N'#39)
    Left = 343
    Top = 274
  end
  object PopupMenu1: TPopupMenu
    Left = 143
    Top = 115
    object Negar1: TMenuItem
      Caption = 'Negar'
      OnClick = Negar1Click
    end
  end
  object qryTmp: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 215
    Top = 160
  end
end
