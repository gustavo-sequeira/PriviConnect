object frmEmailCRM: TfrmEmailCRM
  Left = 332
  Top = 324
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Informe Email'
  ClientHeight = 28
  ClientWidth = 240
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object edtEmail: TEdit
    Left = 1
    Top = 0
    Width = 238
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 50
    ParentFont = False
    TabOrder = 0
    OnKeyPress = edtEmailKeyPress
  end
end
