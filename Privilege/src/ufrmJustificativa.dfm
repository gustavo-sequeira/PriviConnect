object frmJustificativa: TfrmJustificativa
  Left = 395
  Top = 305
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Justificativa Rejei'#231#227'o'
  ClientHeight = 68
  ClientWidth = 303
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
  object GroupBox1: TGroupBox
    Left = 2
    Top = 0
    Width = 302
    Height = 65
    Caption = 'Insira a justificativa'
    TabOrder = 0
    object edtJustificativa: TEdit
      Left = 9
      Top = 19
      Width = 287
      Height = 21
      MaxLength = 100
      TabOrder = 0
    end
    object btOk: TButton
      Left = 8
      Top = 44
      Width = 289
      Height = 21
      Caption = 'Ok'
      TabOrder = 1
      OnClick = btOkClick
    end
  end
end
