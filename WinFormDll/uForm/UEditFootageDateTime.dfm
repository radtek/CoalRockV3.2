object uEditFootageDate: TuEditFootageDate
  Left = 0
  Top = 0
  Caption = #26102#38388#32534#36753#30028#38754
  ClientHeight = 137
  ClientWidth = 274
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object GB_DateTimePicker: TGroupBox
    Left = 8
    Top = 8
    Width = 257
    Height = 113
    TabOrder = 0
    Visible = False
    object DatePicker: TDateTimePicker
      Left = 16
      Top = 16
      Width = 225
      Height = 21
      Date = 43165.351992546300000000
      Time = 43165.351992546300000000
      TabOrder = 0
    end
    object TimePicker: TDateTimePicker
      Left = 16
      Top = 51
      Width = 225
      Height = 21
      Date = 43165.351992546300000000
      Format = 'HH:mm:ss'
      Time = 43165.351992546300000000
      Kind = dtkTime
      TabOrder = 1
    end
    object Button1: TButton
      Left = 144
      Top = 78
      Width = 97
      Height = 27
      Caption = #30830#23450
      TabOrder = 2
      OnClick = Button1Click
    end
  end
end
