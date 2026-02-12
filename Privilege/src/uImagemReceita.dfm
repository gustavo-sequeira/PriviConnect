object frmImagemReceita: TfrmImagemReceita
  Left = 253
  Top = 184
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Imagem Receita'
  ClientHeight = 705
  ClientWidth = 1366
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 1366
    Height = 705
    Align = alClient
    Color = clInactiveCaption
    ParentColor = False
    TabOrder = 0
    object Image1: TImage
      Left = 3
      Top = 39
      Width = 1062
      Height = 596
      AutoSize = True
    end
    object CoolBar1: TCoolBar
      Left = 0
      Top = 0
      Width = 1362
      Height = 33
      Bands = <>
      object btProximo: TSpeedButton
        Left = 71
        Top = -1
        Width = 75
        Height = 33
        Caption = 'Prox>>'
        OnClick = btProximoClick
      end
      object btAnterior: TSpeedButton
        Left = -2
        Top = -1
        Width = 75
        Height = 33
        Caption = '<<Ant'
        OnClick = btAnteriorClick
      end
      object lblImg: TsLabelFX
        Left = 158
        Top = 0
        Width = 137
        Height = 31
        Caption = '1 de 1 Imagem'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        Angle = 0
        Shadow.OffsetKeeper.LeftTop = -3
        Shadow.OffsetKeeper.RightBottom = 5
      end
    end
  end
end
