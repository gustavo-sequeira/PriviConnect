object frmBuscaCupom: TfrmBuscaCupom
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Digite o Cupom'
  ClientHeight = 127
  ClientWidth = 159
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 62
    Top = 53
    Width = 53
    Height = 13
    Caption = 'NR CUPOM'
  end
  object Label2: TLabel
    Left = 11
    Top = 53
    Width = 25
    Height = 13
    Caption = 'LOJA'
  end
  object Bevel1: TBevel
    Left = 2
    Top = 4
    Width = 154
    Height = 43
    Shape = bsFrame
  end
  object lblCliente: TLabel
    Left = 8
    Top = 8
    Width = 33
    Height = 13
    Caption = 'Cliente'
  end
  object lblValor: TLabel
    Left = 8
    Top = 26
    Width = 24
    Height = 13
    Caption = 'Valor'
  end
  object edtCupom: TEdit
    Left = 63
    Top = 69
    Width = 88
    Height = 21
    NumbersOnly = True
    TabOrder = 1
    OnExit = edtCupomExit
    OnKeyPress = edtCupomKeyPress
  end
  object edtLoja: TEdit
    Left = 11
    Top = 69
    Width = 37
    Height = 21
    NumbersOnly = True
    TabOrder = 0
    OnKeyPress = edtLojaKeyPress
  end
  object btOk: TButton
    Left = 8
    Top = 96
    Width = 140
    Height = 25
    Caption = 'Ok'
    TabOrder = 2
    OnClick = btOkClick
  end
end
