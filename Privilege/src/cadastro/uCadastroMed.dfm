object frmCadMedico: TfrmCadMedico
  Left = 390
  Top = 107
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro M'#233'dico'
  ClientHeight = 489
  ClientWidth = 412
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
    Width = 405
    Height = 441
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 160
      Top = 1
      Width = 238
      Height = 57
      Caption = 'Nome'
      TabOrder = 1
      object edtNomeMed: TEdit
        Left = 5
        Top = 20
        Width = 227
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
        OnKeyPress = edtNomeMedKeyPress
      end
    end
    object GroupBox2: TGroupBox
      Left = 258
      Top = 59
      Width = 140
      Height = 57
      Caption = 'CRM/CRO/CRN'
      TabOrder = 3
      object edtCR: TEdit
        Left = 53
        Top = 20
        Width = 77
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 5
        TabOrder = 1
        OnKeyPress = edtCRKeyPress
      end
      object cbUFCRM: TComboBox
        Left = 5
        Top = 20
        Width = 44
        Height = 21
        Style = csDropDownList
        ItemIndex = 16
        TabOrder = 0
        Text = 'PE'
        OnKeyPress = cbUFCRMKeyPress
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
    end
    object GroupBox3: TGroupBox
      Left = 3
      Top = 59
      Width = 253
      Height = 57
      Caption = 'Especialidade'
      TabOrder = 2
      object cbEspecialidade: TComboBox
        Left = 48
        Top = 20
        Width = 196
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        OnChange = cbEspecialidadeChange
        OnKeyPress = cbEspecialidadeKeyPress
      end
      object edtCodEsp: TEdit
        Left = 8
        Top = 20
        Width = 33
        Height = 21
        Color = clScrollBar
        Enabled = False
        TabOrder = 1
      end
    end
    object GroupBox7: TGroupBox
      Left = 3
      Top = 389
      Width = 395
      Height = 48
      Caption = 'Consultor'
      TabOrder = 4
      object edtNomeCons: TEdit
        Left = 72
        Top = 16
        Width = 315
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 1
        OnChange = edtNomeConsChange
        OnKeyPress = edtNomeConsKeyPress
      end
      object edtCodCons: TEdit
        Left = 8
        Top = 16
        Width = 57
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 5
        TabOrder = 0
        OnExit = edtCodConsExit
        OnKeyPress = edtCodConsKeyPress
      end
    end
    object GroupBox12: TGroupBox
      Left = 3
      Top = 1
      Width = 155
      Height = 57
      Caption = 'Profiss'#227'o'
      TabOrder = 0
      object edtProfissao: TEdit
        Left = 30
        Top = 20
        Width = 110
        Height = 21
        Color = clScrollBar
        Enabled = False
        TabOrder = 1
        Visible = False
        OnKeyPress = edtProfissaoKeyPress
      end
      object cbProfissao: TComboBox
        Left = 5
        Top = 20
        Width = 143
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = '0'
        OnChange = cbProfissaoChange
        OnKeyPress = cbProfissaoKeyPress
        Items.Strings = (
          '0'
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
    object GroupBox13: TGroupBox
      Left = 3
      Top = 120
      Width = 395
      Height = 129
      Caption = 'Endere'#231'o Consult'#243'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      object GroupBox9: TGroupBox
        Left = 284
        Top = 71
        Width = 106
        Height = 50
        Caption = 'Telefone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object edtTel: TEdit
          Left = 6
          Top = 20
          Width = 93
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 10
          TabOrder = 0
          OnKeyPress = edtTelKeyPress
        end
      end
      object GroupBox8: TGroupBox
        Left = 172
        Top = 71
        Width = 110
        Height = 50
        Caption = 'Cidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object edtCidade: TEdit
          Left = 7
          Top = 20
          Width = 93
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 0
          OnKeyPress = edtCidadeKeyPress
        end
      end
      object GroupBox10: TGroupBox
        Left = 115
        Top = 71
        Width = 54
        Height = 50
        Caption = 'Estado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object cbUF: TComboBox
          Left = 5
          Top = 17
          Width = 44
          Height = 21
          Style = csDropDownList
          ItemIndex = 16
          TabOrder = 0
          Text = 'PE'
          OnKeyPress = cbUFKeyPress
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
      end
      object GroupBox6: TGroupBox
        Left = 3
        Top = 71
        Width = 110
        Height = 50
        Caption = 'Bairro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        object edtBairro: TEdit
          Left = 7
          Top = 20
          Width = 93
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 0
          OnKeyPress = edtBairroKeyPress
        end
      end
      object GroupBox4: TGroupBox
        Left = 3
        Top = 19
        Width = 182
        Height = 54
        Caption = 'Rua/Avenida/Lougradouro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        object edtEnd: TEdit
          Left = 5
          Top = 20
          Width = 172
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 0
          OnKeyPress = edtEndKeyPress
        end
      end
      object GroupBox5: TGroupBox
        Left = 186
        Top = 19
        Width = 46
        Height = 54
        Caption = 'N'#186
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        object edtNr: TEdit
          Left = 5
          Top = 20
          Width = 35
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 4
          TabOrder = 0
          OnKeyPress = edtNrKeyPress
        end
      end
      object GroupBox11: TGroupBox
        Left = 232
        Top = 19
        Width = 90
        Height = 54
        Caption = 'Complemento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        object edtCompl: TEdit
          Left = 6
          Top = 20
          Width = 79
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 0
          OnKeyPress = edtComplKeyPress
        end
      end
      object GroupBox22: TGroupBox
        Left = 325
        Top = 19
        Width = 66
        Height = 54
        Caption = 'CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        object edtCEPCons: TEdit
          Left = 5
          Top = 20
          Width = 58
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 8
          NumbersOnly = True
          TabOrder = 0
          OnKeyPress = edtNrKeyPress
        end
      end
    end
    object GroupBox14: TGroupBox
      Left = 3
      Top = 257
      Width = 395
      Height = 129
      Caption = 'Endere'#231'o Residencial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      object GroupBox15: TGroupBox
        Left = 284
        Top = 71
        Width = 106
        Height = 50
        Caption = 'Telefone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Edit1: TEdit
          Left = 6
          Top = 20
          Width = 93
          Height = 21
          CharCase = ecUpperCase
          Color = clScrollBar
          Enabled = False
          MaxLength = 10
          TabOrder = 0
          OnKeyPress = edtTelKeyPress
        end
      end
      object GroupBox16: TGroupBox
        Left = 172
        Top = 71
        Width = 110
        Height = 50
        Caption = 'Cidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Edit2: TEdit
          Left = 7
          Top = 20
          Width = 93
          Height = 21
          CharCase = ecUpperCase
          Color = clScrollBar
          Enabled = False
          TabOrder = 0
          OnKeyPress = edtCidadeKeyPress
        end
      end
      object GroupBox17: TGroupBox
        Left = 115
        Top = 71
        Width = 54
        Height = 50
        Caption = 'Estado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object ComboBox1: TComboBox
          Left = 5
          Top = 17
          Width = 44
          Height = 21
          Style = csDropDownList
          Color = clScrollBar
          Enabled = False
          ItemIndex = 16
          TabOrder = 0
          Text = 'PE'
          OnKeyPress = cbUFKeyPress
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
      end
      object GroupBox18: TGroupBox
        Left = 3
        Top = 71
        Width = 110
        Height = 50
        Caption = 'Bairro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        object Edit3: TEdit
          Left = 7
          Top = 20
          Width = 93
          Height = 21
          CharCase = ecUpperCase
          Color = clScrollBar
          Enabled = False
          TabOrder = 0
          OnKeyPress = edtBairroKeyPress
        end
      end
      object GroupBox19: TGroupBox
        Left = 3
        Top = 19
        Width = 230
        Height = 54
        Caption = 'Rua/Avenida/Lougradouro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        object Edit4: TEdit
          Left = 5
          Top = 20
          Width = 218
          Height = 21
          CharCase = ecUpperCase
          Color = clScrollBar
          Enabled = False
          TabOrder = 0
          OnKeyPress = edtEndKeyPress
        end
      end
      object GroupBox20: TGroupBox
        Left = 235
        Top = 19
        Width = 46
        Height = 54
        Caption = 'N'#186
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        object Edit5: TEdit
          Left = 5
          Top = 20
          Width = 35
          Height = 21
          CharCase = ecUpperCase
          Color = clScrollBar
          Enabled = False
          MaxLength = 4
          TabOrder = 0
          OnKeyPress = edtNrKeyPress
        end
      end
      object GroupBox21: TGroupBox
        Left = 283
        Top = 19
        Width = 107
        Height = 54
        Caption = 'Complemento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        object Edit6: TEdit
          Left = 6
          Top = 20
          Width = 93
          Height = 21
          CharCase = ecUpperCase
          Color = clScrollBar
          Enabled = False
          TabOrder = 0
          OnKeyPress = edtComplKeyPress
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 441
    Width = 405
    Height = 38
    TabOrder = 1
    object btIncluir: TBitBtn
      Left = 255
      Top = 6
      Width = 131
      Height = 25
      Caption = 'Incluir'
      Glyph.Data = {
        1E060000424D1E06000000000000360000002800000018000000150000000100
        180000000000E8050000CA0E0000C30E00000000000000000000BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F7F7F60302F60302F7F7F
        7FCF6760BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F7F7F60302FFF9790
        FF979000FFFF60302F60302FCF67607F7F7FBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F7F7F60302FFF
        9790FFC8CFFFC8CFFFC8CF00FFFFFFC8CF60302FCF6760CF6760CF67607F7F7F
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F7F7F6030
        2FFF9790FFC8CF00FFFFCFFFFFFFC8CFFFC8CFCFFFFFFFC8CFCF676060302FCF
        6760CF6760CF67607F7F7FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        7F7F7FCF6760FFC8CF00FFFFFFC8CFFFC8CF7F7F7F7F7F7FCFFFFFFFC8CFCFFF
        FFFFC8CF60302FFF0000CF6760CF6760CF67607F7F7F7F7F7FBFBFBFBFBFBFBF
        BFBFBFBFBF7F7F7FFF9790FFC8CF00FFFFCFFFFF7F7F7F7F7F7FFFC8CF00FFFF
        FFC8CF00FFFFFFC8CFCFFFFFCF67600000FFFF0000FF00007F7F7F7F7F7F7F7F
        7F7F7F7FBFBFBFBFBFBFBFBFBFBFBFBF00FFFFFFC8CFFFC8CF7F7F7FFFC8CFCF
        FFFFFFC8CF7F7F7F7F7F7FCFFFFFCFFFFFFFC8CFCFFFFF60302F0000FFFF0000
        CF67607F7F7F7F7F7F7F7F7FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFFFFFFFFFFF
        FFFFFFFF00FFFF7F7F7F7F7F7FCFFFFFCFFFFFCFFFFFFFC8CFCFFFFFFFC8CFCF
        6760FF97900000FFFF0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFFFC8CFFFFFFFFFFFFF1F201F7F7F7FCFFFFFCFFFFF7F7F7F7F7F7FCFFF
        FFFFC8CFCFFFFFFFC8CF60302FFFC8CF0000FFFF0000BFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFFFC8CFCF6760CF67601F201F7F7F7F7F7F7F
        CFFFFFCFFFFFFFC8CFCFFFFFFFC8CFCFFFFFCF6760CFFFFFFF97900000FFFF00
        00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFCF6760FFC8CFFF9790CF
        67601F201F7F7F7F7F7F7F7F7F7F7F7F7FFFFFFFFFFFFFFFC8CFFFFFFF60302F
        CFFFFFFF97900000FFCF6760BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFCF6760FFC8
        CFFFC8CFFF9790FF9790CF67601F201F7F7F7FCFFFFFFFFFFFCFFFFFFFFFFFCF
        FFFFFFC8CFCF6760FFFFFFFFFFFFFF00000000FFCF6760BFBFBFBFBFBFBFBFBF
        CF6760FFC8CFFFC8CFFFC8CFFF9790FF9790FF9790CF67601F201F7F7F7FFFFF
        FFFFFFFFFFFFFFFFC8CFCFFFFFFFC8CFFFFFFFFFFFFFFFFFFFCF6760CF6760BF
        BFBFBFBFBFCF6760FFC8CFFFFFFFFFC8CFFFC8CFFF9790CF6760CF6760CF6760
        CF67601F201F7F7F7FFFFFFF3F3700CFFFFFCF6760FFFFFF0000FF0000FF0000
        FFCF6760BFBFBFBFBFBFBFBFBF60302F60302F60302FFFC8CFFFC8CFFF9790CF
        67601F201F1F201F1F201F1F201F1F201FFFFFFFFFFFFFFFC8CFFFFFFFFFFFFF
        FFFFFFFFC8CFCF6760BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFFFC8
        CFFFC8CFFF9790CF67601F201F60302F60302F60302F60302FFFC8CFFFC8CFFF
        FFFFFF0000FF0000CF6760BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        FF9790FFC8CFFFC8CFFFFFFFFF9790CF67601F201F60302F0000FF0000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFCF6760FFFFFFFFFFFFFFC8CFFF9790CF67601F201F60302F
        BFBFBFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFCF6760FF9790FF9790FF9790FF9790CF
        67601F201F60302FBFBFBFBFBFBFFF0000FF0000BFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFCF6760CF6760CF67
        60CF6760CF67601F201F60302F7F7F7FFFC8CFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBF}
      TabOrder = 0
      OnClick = btIncluirClick
    end
    object rbDois: TRadioButton
      Left = 16
      Top = 13
      Width = 113
      Height = 17
      Caption = 'Cadastro + Privilege'
      TabOrder = 1
    end
    object rbCadastro: TRadioButton
      Left = 144
      Top = 13
      Width = 81
      Height = 17
      Caption = 'S'#243' Cadastro'
      TabOrder = 2
    end
  end
  object qryTemp: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 443
    Top = 11
  end
  object qryInclui: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 496
    Top = 16
  end
  object IdSMTP1: TIdSMTP
    Host = 'smtp.pharmapele.com.br'
    Password = 'l6495tmp'
    Port = 587
    SASLMechanisms = <>
    Username = 'programa@pharmapele.com.br'
    Left = 519
    Top = 66
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 519
    Top = 130
  end
  object qryConsultora: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 515
    Top = 198
  end
end
