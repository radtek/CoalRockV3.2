object FormEditRockDataMemo: TFormEditRockDataMemo
  Left = 0
  Top = 0
  Caption = #30719#21387#26174#29616#32500#25252#30028#38754
  ClientHeight = 392
  ClientWidth = 650
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 230
    Top = 0
    Width = 304
    Height = 392
    Align = alLeft
    Caption = 'GroupBox1'
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 2
      Top = 15
      Height = 375
      ExplicitLeft = 8
      ExplicitTop = 240
      ExplicitHeight = 100
    end
    object Memo1: TMemo
      Left = 5
      Top = 15
      Width = 297
      Height = 375
      Align = alClient
      Lines.Strings = (
        'Memo1')
      TabOrder = 0
      OnClick = Memo1Click
    end
  end
  object SaveMemoButton: TButton
    Left = 552
    Top = 240
    Width = 80
    Height = 25
    Caption = #24212#29992#20445#23384
    TabOrder = 1
    OnClick = SaveMemoButtonClick
  end
  object Button1: TButton
    Left = 552
    Top = 127
    Width = 80
    Height = 25
    Caption = #28165#38500#20840#37096
    TabOrder = 2
    OnClick = Button1Click
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 230
    Height = 392
    Align = alLeft
    Caption = #24120#29992#30340#30719#21387#26174#29616#34920#36798
    TabOrder = 3
    object Memo2: TMemo
      Left = 2
      Top = 15
      Width = 226
      Height = 375
      Align = alClient
      Lines.Strings = (
        'Memo2')
      TabOrder = 0
      OnClick = Memo2Click
      OnDblClick = Memo2DblClick
      ExplicitLeft = 3
    end
  end
  object Button2: TButton
    Left = 552
    Top = 78
    Width = 80
    Height = 25
    Caption = #21024#38500#26465#30446
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 552
    Top = 183
    Width = 80
    Height = 25
    Caption = #23384#20026#24120#29992#30701#35821
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 552
    Top = 303
    Width = 80
    Height = 25
    Caption = #21024#38500#24403#21069#30701#35821
    TabOrder = 6
    OnClick = Button4Click
  end
end
