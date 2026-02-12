object frmSolicitacao: TfrmSolicitacao
  Left = 394
  Top = 238
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Solicita'#231#227'o Privilege'
  ClientHeight = 260
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 481
    Height = 65
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 6
      Top = 1
      Width = 468
      Height = 56
      Caption = 'Medico'
      TabOrder = 0
      object btOk: TBitBtn
        Left = 408
        Top = 13
        Width = 52
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
        TabOrder = 3
        OnClick = btOkClick
      end
      object edtMedico: TEdit
        Left = 208
        Top = 16
        Width = 195
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 2
        OnChange = edtMedicoChange
      end
      object cbUF: TComboBox
        Left = 166
        Top = 16
        Width = 41
        Height = 21
        Style = csDropDownList
        ItemIndex = 16
        TabOrder = 1
        Text = 'PE'
        Items.Strings = (
          'AC'
          'AL'
          'AP'
          'AM'
          'BA'
          'CE'
          'DF'
          'ES'
          'GO'
          'MA'
          'MT'
          'MS'
          'MG'
          'PA'
          'PB'
          'PR'
          'PE'
          'PI'
          'RJ'
          'RN'
          'RS'
          'RO'
          'RR'
          'SC'
          'SP'
          'SE'
          'TO')
      end
      object cbOpcaoMed: TComboBox
        Left = 4
        Top = 16
        Width = 66
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = 'CRM'
        Items.Strings = (
          'CRM'
          'Nome')
      end
      object cbProfissao: TComboBox
        Left = 72
        Top = 16
        Width = 91
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 4
        Text = '1'
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
          '0'
          'A'
          'B')
      end
    end
  end
  object Panel2: TPanel
    Left = -1
    Top = 66
    Width = 482
    Height = 193
    TabOrder = 1
    object dbgMedicos: TDBGrid
      Left = 3
      Top = 40
      Width = 473
      Height = 145
      DataSource = dsGrid
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
    object Panel3: TPanel
      Left = 2
      Top = 3
      Width = 477
      Height = 33
      TabOrder = 1
      object Label1: TLabel
        Left = 92
        Top = -1
        Width = 268
        Height = 33
        Caption = 'Solicita'#231#245'es em Aberto'
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
  object dsGrid: TDataSource
    DataSet = qrySolicitacoes
    Left = 87
    Top = 146
  end
  object qryPesqMedicos: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 263
    Top = 10
  end
  object qrySolicitacoes: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select nomemed,nrcrm,especialidade,profissao from solicitpriv wh' +
        'ere flagenv='#39'N'#39)
    Left = 167
    Top = 146
  end
  object qryTemp: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 15
    Top = 146
  end
  object qryTempPriv: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 319
    Top = 146
  end
  object IdSMTP1: TIdSMTP
    Host = 'smtp.pharmapele.com.br'
    Password = 'l6495tmp'
    Port = 587
    SASLMechanisms = <>
    Username = 'programa@pharmapele.com.br'
    Left = 247
    Top = 194
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    FromList = <
      item
        Address = 'programa@pharmapele.com.br'
        Name = 'Privilege'
        Text = 'Privilege <programa@pharmapele.com.br>'
        Domain = 'pharmapele.com.br'
        User = 'programa'
      end>
    From.Address = 'programa@pharmapele.com.br'
    From.Name = 'Privilege'
    From.Text = 'Privilege <programa@pharmapele.com.br>'
    From.Domain = 'pharmapele.com.br'
    From.User = 'programa'
    Recipients = <>
    ReplyTo = <
      item
        Address = 'programa@pharmapele.com.br'
        Name = 'Privilege'
        Text = 'Privilege <programa@pharmapele.com.br>'
        Domain = 'pharmapele.com.br'
        User = 'programa'
      end>
    Sender.Address = 'programa@pharmapele.com.br'
    Sender.Name = 'Privilege'
    Sender.Text = 'Privilege <programa@pharmapele.com.br>'
    Sender.Domain = 'pharmapele.com.br'
    Sender.User = 'programa'
    ConvertPreamble = True
    Left = 175
    Top = 194
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 111
    Top = 194
  end
end
