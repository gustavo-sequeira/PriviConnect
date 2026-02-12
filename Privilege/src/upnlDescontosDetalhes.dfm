object frmCortesiaDetalhes: TfrmCortesiaDetalhes
  Left = 486
  Top = 199
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Painel de Cortesias - Detalhes'
  ClientHeight = 239
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object gbSolic: TGroupBox
    Left = 0
    Top = 0
    Width = 441
    Height = 81
    TabOrder = 0
    object Label3: TLabel
      Left = 224
      Top = 22
      Width = 96
      Height = 13
      Caption = 'Valor Mensal.........'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 226
      Top = 60
      Width = 95
      Height = 13
      Caption = 'Valor Total...........'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Panel2: TPanel
      Left = 323
      Top = 12
      Width = 112
      Height = 26
      Color = clMoneyGreen
      TabOrder = 0
      object Shape3: TShape
        Left = 1
        Top = 1
        Width = 110
        Height = 24
        Align = alClient
        Brush.Color = clMoneyGreen
        Pen.Style = psClear
        ExplicitLeft = 41
        ExplicitTop = -16
        ExplicitWidth = 125
      end
      object lblMes: TLabel
        Left = 18
        Top = 5
        Width = 56
        Height = 19
        Alignment = taCenter
        Caption = 'R$ 0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
    end
    object Panel1: TPanel
      Left = 323
      Top = 50
      Width = 112
      Height = 26
      Color = clMoneyGreen
      TabOrder = 1
      object Shape1: TShape
        Left = 1
        Top = 1
        Width = 110
        Height = 24
        Align = alClient
        Brush.Color = clInfoBk
        Pen.Style = psClear
        ExplicitLeft = 41
        ExplicitTop = -16
        ExplicitWidth = 125
      end
      object lblTotal: TLabel
        Left = 18
        Top = 5
        Width = 56
        Height = 19
        Alignment = taCenter
        Caption = 'R$ 0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
    end
    object GroupBox4: TGroupBox
      Left = 6
      Top = 2
      Width = 212
      Height = 40
      Caption = 'Funcion'#225'rio'
      TabOrder = 2
      object Panel3: TPanel
        Left = 8
        Top = 13
        Width = 199
        Height = 21
        Color = clMoneyGreen
        TabOrder = 0
        object Shape2: TShape
          Left = 1
          Top = 1
          Width = 197
          Height = 19
          Align = alClient
          Brush.Color = clGradientInactiveCaption
          Pen.Style = psClear
          ExplicitHeight = 21
        end
        object lblFunc: TLabel
          Left = 4
          Top = 3
          Width = 4
          Height = 16
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
      end
    end
    object GroupBox5: TGroupBox
      Left = 6
      Top = 37
      Width = 212
      Height = 40
      Caption = 'Depto'
      TabOrder = 3
      object Panel6: TPanel
        Left = 8
        Top = 13
        Width = 199
        Height = 21
        Color = clMoneyGreen
        TabOrder = 0
        object Shape5: TShape
          Left = 1
          Top = 1
          Width = 197
          Height = 19
          Align = alClient
          Brush.Color = clGradientInactiveCaption
          Pen.Style = psClear
          ExplicitHeight = 21
        end
        object lblDepto: TLabel
          Left = 4
          Top = 3
          Width = 4
          Height = 16
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 83
    Width = 441
    Height = 159
    BevelOuter = bvLowered
    TabOrder = 1
    object edtReceita: TSpeedButton
      Left = 365
      Top = 108
      Width = 75
      Height = 43
      Caption = 'Receita'
      OnClick = edtReceitaClick
    end
    object gbReq: TGroupBox
      Left = 8
      Top = 5
      Width = 167
      Height = 49
      Caption = 'Requisi'#231#227'o'
      TabOrder = 0
      object edtSer: TEdit
        Left = 120
        Top = 16
        Width = 33
        Height = 21
        Color = clScrollBar
        Enabled = False
        TabOrder = 0
      end
      object edtReq: TEdit
        Left = 48
        Top = 16
        Width = 66
        Height = 21
        Color = clScrollBar
        Enabled = False
        TabOrder = 1
      end
      object edtFil: TEdit
        Left = 9
        Top = 16
        Width = 33
        Height = 21
        Color = clScrollBar
        Enabled = False
        TabOrder = 2
      end
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 54
      Width = 167
      Height = 49
      Caption = 'Avaliado por'
      TabOrder = 1
      object Panel5: TPanel
        Left = 8
        Top = 16
        Width = 154
        Height = 26
        Color = clMoneyGreen
        TabOrder = 0
        object Shape4: TShape
          Left = 1
          Top = 1
          Width = 152
          Height = 24
          Align = alClient
          Brush.Color = clGradientInactiveCaption
          Pen.Style = psClear
          ExplicitWidth = 147
        end
        object lblAvaliador: TLabel
          Left = 4
          Top = 5
          Width = 4
          Height = 16
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 176
      Top = 5
      Width = 91
      Height = 49
      Caption = 'Data Solicita'#231#227'o'
      TabOrder = 2
      object edtdtSol: TEdit
        Left = 16
        Top = 16
        Width = 64
        Height = 21
        Color = clScrollBar
        Enabled = False
        TabOrder = 0
      end
    end
    object GroupBox3: TGroupBox
      Left = 268
      Top = 5
      Width = 91
      Height = 49
      Caption = 'Hora Solicita'#231#227'o'
      TabOrder = 3
      object edthrSol: TEdit
        Left = 17
        Top = 16
        Width = 55
        Height = 21
        Color = clScrollBar
        Enabled = False
        TabOrder = 0
      end
    end
    object GroupBox6: TGroupBox
      Left = 360
      Top = 4
      Width = 80
      Height = 49
      Caption = 'Vr Receita'
      TabOrder = 4
      object edtvrRec: TEdit
        Left = 10
        Top = 16
        Width = 63
        Height = 21
        Color = clScrollBar
        Enabled = False
        TabOrder = 0
      end
    end
    object GroupBox7: TGroupBox
      Left = 361
      Top = 54
      Width = 80
      Height = 49
      Caption = 'Vr Cortesia'
      TabOrder = 5
      object edtvrCort: TEdit
        Left = 10
        Top = 16
        Width = 63
        Height = 21
        Color = clScrollBar
        Enabled = False
        TabOrder = 0
      end
    end
    object GroupBox8: TGroupBox
      Left = 8
      Top = 102
      Width = 105
      Height = 49
      Caption = 'Status'
      TabOrder = 6
      object Panel7: TPanel
        Left = 8
        Top = 16
        Width = 91
        Height = 26
        Color = clMoneyGreen
        TabOrder = 0
        object Shape6: TShape
          Left = 1
          Top = 1
          Width = 89
          Height = 24
          Align = alClient
          Brush.Color = clGradientInactiveCaption
          Pen.Style = psClear
          ExplicitWidth = 201
        end
        object lblStatus: TLabel
          Left = 4
          Top = 5
          Width = 4
          Height = 16
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
      end
    end
    object GroupBox9: TGroupBox
      Left = 268
      Top = 54
      Width = 91
      Height = 49
      Caption = 'Hora Avalia'#231#227'o'
      TabOrder = 7
      object edtHrAva: TEdit
        Left = 17
        Top = 16
        Width = 55
        Height = 21
        Color = clScrollBar
        Enabled = False
        TabOrder = 0
      end
    end
    object GroupBox10: TGroupBox
      Left = 176
      Top = 54
      Width = 91
      Height = 49
      Caption = 'Data Avalia'#231#227'o'
      TabOrder = 8
      object edtDtAva: TEdit
        Left = 16
        Top = 16
        Width = 64
        Height = 21
        Color = clScrollBar
        Enabled = False
        TabOrder = 0
      end
    end
    object GroupBox11: TGroupBox
      Left = 114
      Top = 102
      Width = 245
      Height = 49
      Caption = 'Justificativa'
      TabOrder = 9
      object Panel8: TPanel
        Left = 8
        Top = 16
        Width = 233
        Height = 26
        Color = clMoneyGreen
        TabOrder = 0
        object Shape7: TShape
          Left = 1
          Top = 1
          Width = 231
          Height = 24
          Align = alClient
          Brush.Color = clGradientInactiveCaption
          Pen.Style = psClear
          ExplicitLeft = -3
          ExplicitTop = 2
          ExplicitWidth = 135
        end
        object lblJustificativa: TLabel
          Left = 4
          Top = 5
          Width = 4
          Height = 16
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
          OnDblClick = lblJustificativaDblClick
        end
      end
    end
  end
  object qryBuscaImagem: TIBQuery
    Database = dmDescontos.bdImagens
    Transaction = dmDescontos.IBTransaction5
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 504
    Top = 72
  end
  object qrypedidoimagem: TIBQuery
    Database = dmDescontos.bdImagens
    Transaction = dmDescontos.IBTransaction5
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 520
    Top = 152
  end
end
