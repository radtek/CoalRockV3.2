object FormProg: TFormProg
  Left = 0
  Top = 0
  BorderIcons = [biHelp]
  BorderStyle = bsToolWindow
  Caption = #23548#20837'Excel'#25991#20214#36827#24230#26465
  ClientHeight = 123
  ClientWidth = 597
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 280
    Top = 86
    Width = 30
    Height = 19
    Margins.Bottom = 0
    Caption = 'ggg'
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = #26999#20307'_GB2312'
    Font.Style = []
    ParentFont = False
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 56
    Width = 561
    Height = 16
    Smooth = True
    TabOrder = 0
  end
  object ProgressBar2: TProgressBar
    Left = 8
    Top = 8
    Width = 561
    Height = 17
    Smooth = True
    TabOrder = 1
  end
end
