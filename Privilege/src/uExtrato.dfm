object frmExtrato: TfrmExtrato
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Extrato Privilege'
  ClientHeight = 336
  ClientWidth = 472
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
  object memExtrato: TRichEdit
    Left = 0
    Top = 0
    Width = 472
    Height = 336
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    Zoom = 100
  end
  object qryExtratoDiasForm: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 48
    Top = 16
  end
  object qryAcrescimo: TIBQuery
    Database = dmDescontos.bdDescontos
    Transaction = dmDescontos.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 40
    Top = 120
  end
  object qryExtratoDiasVar: TIBQuery
    Database = dmDescontos.bdFcerta
    Transaction = dmDescontos.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 168
    Top = 24
  end
end
