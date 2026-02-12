object frmAlertas: TfrmAlertas
  Left = 283
  Top = 218
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Configura'#231#227'o de alertas'
  ClientHeight = 333
  ClientWidth = 270
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
  object gbEmail: TGroupBox
    Left = 0
    Top = 0
    Width = 270
    Height = 57
    Caption = 'Email'
    TabOrder = 0
    object btIncluir: TBitBtn
      Left = 192
      Top = 16
      Width = 67
      Height = 23
      Caption = 'Incluir'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        0000377777777777777707FFFFFFFFFFFF70773FF33333333F770F77FFFFFFFF
        77F07F773FF3333F77370FFF77FFFF77FFF07F33773FFF7733370FFFFF0000FF
        FFF07F333F77773FF3F70FFF70EEEE07F9F07F3F7733337737F70F707FFFFFF7
        97F07F7733333FFF7737007EEEE3000EE70977FFFFFF777FFF37077777307080
        77907777777737377773307EE307088809033773FF7F7FF37733337030070088
        07333337777F77377FFF33337008080809993333377F7F737777333330080088
        03333333377F77337FF333333308088809333333337373F3773F333333308080
        33933333333737F7337333333333000333393333333377733337}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btIncluirClick
    end
    object edtEmail: TEdit
      Left = 16
      Top = 16
      Width = 169
      Height = 21
      CharCase = ecLowerCase
      MaxLength = 60
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 58
    Width = 270
    Height = 233
    Caption = 'Emails Cadastrados'
    TabOrder = 1
    object dbEmails: TDBGrid
      Left = 6
      Top = 19
      Width = 257
      Height = 206
      DataSource = dsEmails
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 292
    Width = 269
    Height = 41
    TabOrder = 2
    object btRemover: TBitBtn
      Left = 16
      Top = 8
      Width = 241
      Height = 25
      Caption = 'Remover Email'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        000037777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
        FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF7777BBF
        FFF07F333777777F3FF70FFFFFFFB9BF1CC07F3FFF337F7377770F777FFFB99B
        C1C07F7773337F377F370FFFFFFFB9BBC1C07FFFFFFF7F337FF700000077B999
        B000777777777F33777733337377B9999B33333F733373F337FF3377377B99BB
        9BB33377F337F377377F3737377B9B79B9B737F73337F7F7F37F33733777BB7B
        BBB73373333377F37F3737333777BB777B9B3733333377F337F7333333777B77
        77BB3333333337333377333333333777337B3333333333333337}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btRemoverClick
    end
  end
  object qryEmailsCadastrados: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 56
    Top = 114
  end
  object dsEmails: TDataSource
    DataSet = qryEmailsCadastrados
    Left = 168
    Top = 130
  end
  object qryTemp: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 72
    Top = 194
  end
end
