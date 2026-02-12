object frmConfirmCadastroMed: TfrmConfirmCadastroMed
  Left = 477
  Top = 309
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Confirma'#231#227'o de Cadastro M'#233'dico'
  ClientHeight = 271
  ClientWidth = 398
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 397
    Height = 233
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 160
      Top = 1
      Width = 233
      Height = 57
      Caption = 'Nome'
      TabOrder = 1
      object edtNomeMed: TEdit
        Left = 5
        Top = 20
        Width = 222
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
      end
    end
    object GroupBox2: TGroupBox
      Left = 251
      Top = 59
      Width = 142
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
      Width = 246
      Height = 57
      Caption = 'Especialidade'
      TabOrder = 2
      object cbEspecialidade: TComboBox
        Left = 48
        Top = 20
        Width = 185
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        OnChange = cbEspecialidadeChange
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
    object GroupBox4: TGroupBox
      Left = 4
      Top = 117
      Width = 196
      Height = 54
      Caption = 'Endere'#231'o'
      TabOrder = 4
      object edtEnd: TEdit
        Left = 5
        Top = 20
        Width = 187
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
      end
    end
    object GroupBox5: TGroupBox
      Left = 201
      Top = 117
      Width = 37
      Height = 54
      Caption = 'N'#186
      TabOrder = 5
      object edtNr: TEdit
        Left = 5
        Top = 20
        Width = 29
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 4
        TabOrder = 0
      end
    end
    object GroupBox6: TGroupBox
      Left = 3
      Top = 172
      Width = 110
      Height = 50
      Caption = 'Bairro'
      TabOrder = 7
      object edtBairro: TEdit
        Left = 7
        Top = 20
        Width = 93
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
      end
    end
    object GroupBox8: TGroupBox
      Left = 172
      Top = 172
      Width = 110
      Height = 50
      Caption = 'Cidade'
      TabOrder = 9
      object edtCidade: TEdit
        Left = 7
        Top = 20
        Width = 93
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
      end
    end
    object GroupBox9: TGroupBox
      Left = 288
      Top = 172
      Width = 106
      Height = 50
      Caption = 'Telefone'
      TabOrder = 10
      object edtTel: TEdit
        Left = 6
        Top = 20
        Width = 93
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 0
      end
    end
    object GroupBox10: TGroupBox
      Left = 115
      Top = 172
      Width = 54
      Height = 50
      Caption = 'Estado'
      TabOrder = 8
      object cbUF: TComboBox
        Left = 5
        Top = 20
        Width = 44
        Height = 21
        Style = csDropDownList
        ItemIndex = 16
        TabOrder = 0
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
    end
    object GroupBox11: TGroupBox
      Left = 239
      Top = 117
      Width = 88
      Height = 54
      Caption = 'Complemento'
      TabOrder = 6
      object edtCompl: TEdit
        Left = 6
        Top = 20
        Width = 79
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
      end
    end
    object GroupBox12: TGroupBox
      Left = 3
      Top = 1
      Width = 155
      Height = 57
      Caption = 'Profiss'#227'o'
      TabOrder = 0
      object cbProfissao: TComboBox
        Left = 5
        Top = 20
        Width = 34
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = '1'
        OnChange = cbProfissaoChange
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
      object edtProfissao: TEdit
        Left = 40
        Top = 20
        Width = 110
        Height = 21
        Color = clScrollBar
        Enabled = False
        TabOrder = 1
      end
    end
    object GroupBox7: TGroupBox
      Left = 329
      Top = 117
      Width = 65
      Height = 54
      Caption = 'CEP'
      TabOrder = 11
      object edtCEP: TEdit
        Left = 4
        Top = 20
        Width = 58
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 8
        TabOrder = 0
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 233
    Width = 397
    Height = 38
    TabOrder = 1
    object btAlterar: TBitBtn
      Left = 15
      Top = 7
      Width = 90
      Height = 25
      Caption = 'Alterar'
      TabOrder = 0
      OnClick = btAlterarClick
    end
    object btConfirmar: TBitBtn
      Left = 290
      Top = 7
      Width = 90
      Height = 25
      Caption = 'Confirmar'
      TabOrder = 1
      OnClick = btConfirmarClick
    end
    object btNegar: TBitBtn
      Left = 153
      Top = 7
      Width = 90
      Height = 25
      Caption = 'Negar'
      TabOrder = 2
      OnClick = btNegarClick
    end
  end
  object qryTempFcerta: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 147
    Top = 363
  end
  object qryInclui: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 232
    Top = 360
  end
  object qryTempPrivilege: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 67
    Top = 363
  end
end
