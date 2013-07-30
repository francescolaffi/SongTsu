object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Pressure matrix monitor'
  ClientHeight = 400
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GridPanel: TGridPanel
    Left = 0
    Top = 41
    Width = 400
    Height = 359
    Align = alClient
    BevelOuter = bvNone
    ColumnCollection = <
      item
        SizeStyle = ssAbsolute
        Value = 50.000000000000000000
      end
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <>
    RowCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Button1: TButton
      Left = 290
      Top = 5
      Width = 102
      Height = 25
      Caption = 'TestColors'
      TabOrder = 0
      OnClick = Button1Click
    end
    object ComboPorts: TComboBox
      Left = 9
      Top = 7
      Width = 105
      Height = 21
      Style = csDropDownList
      TabOrder = 1
    end
    object Button2: TButton
      Left = 124
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Open'
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 206
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Close'
      TabOrder = 3
      OnClick = Button3Click
    end
  end
end
