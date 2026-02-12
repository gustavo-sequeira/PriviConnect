object frmDescontosAplicados: TfrmDescontosAplicados
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Descontos Aplicados'
  ClientHeight = 250
  ClientWidth = 525
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblVrTOT: TsLabelFX
    Left = 330
    Top = 221
    Width = 181
    Height = 23
    Caption = 'Valor Total - R$ 0000,00'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Angle = 0
    Shadow.OffsetKeeper.LeftTop = -1
    Shadow.OffsetKeeper.RightBottom = 3
  end
  object DBGrid1: TDBGrid
    Left = 4
    Top = 7
    Width = 513
    Height = 208
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NRREQ'
        Title.Alignment = taCenter
        Title.Caption = 'REQ'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRFORM'
        Title.Alignment = taCenter
        Title.Caption = 'F'#211'RMULA'
        Width = 180
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VRTAB'
        Title.Alignment = taCenter
        Title.Caption = 'VR TABELA'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VRREQ'
        Title.Alignment = taCenter
        Title.Caption = 'VR REQ'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VRDESC'
        Title.Alignment = taCenter
        Title.Caption = 'VR DESC'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VRLIQ'
        Title.Alignment = taCenter
        Title.Caption = 'VR LIQ'
        Width = 60
        Visible = True
      end>
  end
  object CDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 120
    object CDSNRREQ: TIntegerField
      FieldName = 'NRREQ'
    end
    object CDSDESCRFORM: TStringField
      FieldName = 'DESCRFORM'
      Size = 70
    end
    object CDSVRREQ: TCurrencyField
      FieldName = 'VRREQ'
    end
    object CDSVRDESC: TCurrencyField
      FieldName = 'VRDESC'
    end
    object CDSVRLIQ: TCurrencyField
      FieldName = 'VRLIQ'
    end
    object CDSVRTAB: TCurrencyField
      FieldName = 'VRTAB'
    end
  end
  object DataSource1: TDataSource
    DataSet = CDS
    Left = 128
    Top = 112
  end
end
