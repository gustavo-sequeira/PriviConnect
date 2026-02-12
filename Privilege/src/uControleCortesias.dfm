object frmControleCortesias: TfrmControleCortesias
  Left = 469
  Top = 199
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Controle de Cortesias'
  ClientHeight = 314
  ClientWidth = 599
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
  object gbIntervalo: TGroupBox
    Left = 208
    Top = 0
    Width = 167
    Height = 73
    Caption = 'Intervalo de Datas'
    TabOrder = 0
    object Inicial: TLabel
      Left = 24
      Top = 21
      Width = 27
      Height = 13
      Caption = 'Inicial'
    end
    object Label1: TLabel
      Left = 29
      Top = 47
      Width = 22
      Height = 13
      Caption = 'Final'
    end
    object dtFinal: TDateTimePicker
      Left = 57
      Top = 41
      Width = 86
      Height = 24
      Date = 40802.426179826390000000
      Time = 40802.426179826390000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object dtInicial: TDateTimePicker
      Left = 57
      Top = 15
      Width = 86
      Height = 24
      Date = 40802.426179826390000000
      Time = 40802.426179826390000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object gbFiltros: TGroupBox
    Left = 0
    Top = 0
    Width = 207
    Height = 73
    Caption = 'Relat'#243'rio'
    TabOrder = 1
    object Bevel1: TBevel
      Left = 104
      Top = 13
      Width = 2
      Height = 52
      Shape = bsRightLine
    end
    object rbTodas: TRadioButton
      Left = 8
      Top = 16
      Width = 65
      Height = 17
      Caption = 'Todas'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnMouseUp = rbPendentesMouseUp
    end
    object rbRejeitadas: TRadioButton
      Left = 112
      Top = 43
      Width = 77
      Height = 17
      Caption = 'Rejeitadas'
      TabOrder = 1
      OnMouseUp = rbPendentesMouseUp
    end
    object rbAprovadas: TRadioButton
      Left = 112
      Top = 16
      Width = 73
      Height = 17
      Caption = 'Aprovadas'
      TabOrder = 2
      OnMouseUp = rbPendentesMouseUp
    end
    object rbPendentes: TRadioButton
      Left = 8
      Top = 43
      Width = 73
      Height = 17
      Caption = 'Pendentes'
      TabOrder = 3
      OnMouseUp = rbPendentesMouseUp
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 74
    Width = 598
    Height = 223
    TabOrder = 2
    object dbControle: TDBGrid
      Left = 4
      Top = 8
      Width = 590
      Height = 197
      DataSource = dsGrid
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object GroupBox1: TGroupBox
    Left = 376
    Top = 6
    Width = 218
    Height = 67
    TabOrder = 3
    object btExcel: TBitBtn
      Left = 37
      Top = 39
      Width = 152
      Height = 25
      Caption = 'Excel'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000000000000000000000000000000000002E7749266E43
        357B532367443070531B594137725D205B4725624E23634D195B3E004622256E
        460351220F612D0A5C2739734A73AC856BA17C679C7B61927664947C58867072
        A08D5A887552836D53896C558E6D48855F4283565394660B501E5F7D5A7D9A79
        E8FFE4E5FEE2F3FFF0C7DDC5E7FAE5C9DCC7D8EBD6D6ECD4E1FAE0DAF6D8B7D6
        B5D6F8D34C71492E562C6F8568778D70D1E7CAF6FFEDD0E3C8E2F3D8F8FFEEE6
        F7DCDEEFD4E5F9DCD6ECCFCEE6C6ECFFE5CEECC96889642E4F2A49715595BDA1
        E4FFEEDFFFE6D7FCDAE4FFE7D5FBD7CDF3CF8FB690365F39244D2726522B2150
        2AC9FAD44A7B552356304E7E6481B296CBFBDE5082602C5D371C4B2432633719
        4A1C265A2B6B9F704C81556BA1762C643BB0E9C256916B29634057876F86B69C
        DDFFF0CEFFDE6C9E766DA0745789595386548FC49273A8765D946319502375AD
        84C0F9D357916E17533162927A7AAA90D9FFECD5FFE3D4FFDE75A97A4679477E
        B27D5D945D4A804B20582570A7785C946BBEF7D1589170215C3D6D9B8487B69C
        DFFFF0DAFFE6C7F6CF5081539ED19F699D686397614379441D5522BDF4C5C5FD
        D4C1FAD45A93722E674867957E94C3A9D6FFE7DCFFEA61906996C79B7BAD7D6F
        A270518452639664497D4D24592DC6FBD3CCFFDD5B93701E57367CA98F99C6AB
        D6FFE5588564AFDBB681AE8785B388578658507F5175A678649569396B412A5F
        37BAF1CA578D6851896676997EB1D4B9EAFFEE80A28368896789AA886A8A67EC
        FFEAE1FFDE648963648963668D675A8560D0FCD77DA98424532D95A78AB7C9AC
        EAF9DDFAFFEDF9FFECECF9DFFDFFEEE9F4DAFDFFEED1DFC3F1FFE4DBEDCEF1FF
        E5D3EBC98FA9854F6B47ABC3A1B9D0B0F6FFEDF6FFECEDFDE5FAFFF1FAFFF2FA
        FFF2EAF6E2F8FFF1EDFFE7F2FFEBE4FCDCE8FFE088A78056784F659971A7DAB4
        A8D8B495C4A4B1DCC190B7A193BAA590B6A488AE9C85AE9990BDA276A7876B9F
        7A7CB489639E71306E3E85C89B78BA9071B0896AA785659C8176AC955287735E
        92805F93813D7560528C703C7C593C7D563E86582F784635804C}
      TabOrder = 0
      OnClick = btExcelClick
    end
    object btMostrar: TBitBtn
      Left = 37
      Top = 8
      Width = 152
      Height = 25
      Caption = 'Mostrar'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333333333333333333333FFFFF3333333333CCCCC33
        33333FFFF77777FFFFFFCCCCCC808CCCCCC377777737F777777F008888070888
        8003773FFF7773FFF77F0F0770F7F0770F037F777737F777737F70FFFFF7FFFF
        F07373F3FFF7F3FFF37F70F000F7F000F07337F77737F777373330FFFFF7FFFF
        F03337FF3FF7F3FF37F3370F00F7F00F0733373F7737F77337F3370FFFF7FFFF
        0733337F33373F337333330FFF030FFF03333373FF7373FF7333333000333000
        3333333777333777333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btMostrarClick
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 295
    Width = 599
    Height = 19
    Panels = <
      item
        Width = 400
      end
      item
        Alignment = taCenter
        Width = 50
      end>
  end
  object qryRelControleCort: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 152
    Top = 161
  end
  object dsGrid: TDataSource
    DataSet = qryRelControleCort
    Left = 384
    Top = 161
  end
end
