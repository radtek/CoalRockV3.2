object CheckForm: TCheckForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #35206#23721#36816#21160#35268#24459#21442#25968#20462#35746#21345
  ClientHeight = 260
  ClientWidth = 491
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 20
    Top = 8
    Width = 72
    Height = 13
    Margins.Bottom = 0
    Caption = #29028#23618#25918#22823#27604#20363
  end
  object Label2: TLabel
    Left = 20
    Top = 35
    Width = 84
    Height = 13
    Margins.Bottom = 0
    Caption = #21333#27493#25191#34892#30340#27493#38271
  end
  object Label3: TLabel
    Left = 20
    Top = 62
    Width = 96
    Height = 13
    Margins.Bottom = 0
    Caption = #22270#24418#25918#22823#26368#22823#20493#25968
  end
  object Label4: TLabel
    Left = 20
    Top = 100
    Width = 96
    Height = 13
    Margins.Bottom = 0
    Caption = #22270#24418#32553#23567#26368#23567#20493#25968
  end
  object Label5: TLabel
    Left = 20
    Top = 140
    Width = 108
    Height = 13
    Margins.Bottom = 0
    Caption = #24490#29615#25191#34892#30340#24320#22987#36827#23610
  end
  object Label6: TLabel
    Left = 20
    Top = 176
    Width = 108
    Height = 13
    Margins.Bottom = 0
    Caption = #24490#29615#25191#34892#30340#32456#27490#36827#23610
  end
  object Label7: TLabel
    Left = 264
    Top = 40
    Width = 12
    Height = 13
    Margins.Bottom = 0
    Caption = #31859
  end
  object Label8: TLabel
    Left = 262
    Top = 140
    Width = 12
    Height = 13
    Margins.Bottom = 0
    Caption = #31859
  end
  object Label9: TLabel
    Left = 262
    Top = 180
    Width = 12
    Height = 13
    Margins.Bottom = 0
    Caption = #31859
  end
  object Label10: TLabel
    Left = 324
    Top = 116
    Width = 84
    Height = 13
    Margins.Bottom = 0
    Caption = #27169#25311#24555#36895#23450#20301#21040
  end
  object Label11: TLabel
    Left = 453
    Top = 140
    Width = 12
    Height = 13
    Margins.Bottom = 0
    Caption = #31859
  end
  object Label12: TLabel
    Left = 328
    Top = 8
    Width = 84
    Height = 13
    Margins.Bottom = 0
    Caption = #27169#25311#23721#23618#30340#19978#30028
  end
  object Label13: TLabel
    Left = 328
    Top = 59
    Width = 84
    Height = 13
    Margins.Bottom = 0
    Caption = #32531#27785#24102#26174#31034#27604#20363
  end
  object Button4: TButton
    Left = 96
    Top = 216
    Width = 120
    Height = 25
    Caption = #24212#29992
    TabOrder = 0
    OnClick = Button4Click
  end
  object E_Mc: TEdit
    Left = 151
    Top = 8
    Width = 105
    Height = 21
    TabOrder = 1
    Text = 'E_Mc'
    OnClick = E_McClick
    OnExit = E_McExit
    OnKeyPress = E_McKeyPress
  end
  object E_step: TEdit
    Left = 152
    Top = 35
    Width = 105
    Height = 21
    TabOrder = 2
    Text = 'E_Mc'
    OnClick = E_stepClick
    OnExit = E_stepExit
    OnKeyPress = E_stepKeyPress
  end
  object E_Max: TEdit
    Left = 151
    Top = 62
    Width = 105
    Height = 21
    TabOrder = 3
    Text = 'E_Mc'
    OnClick = E_MaxClick
    OnExit = E_MaxExit
    OnKeyPress = E_MaxKeyPress
  end
  object E_Min: TEdit
    Left = 151
    Top = 100
    Width = 105
    Height = 21
    TabOrder = 4
    Text = 'E_Mc'
    OnClick = E_MinClick
    OnExit = E_MinExit
    OnKeyPress = E_MinKeyPress
  end
  object E_S_min: TEdit
    Left = 151
    Top = 140
    Width = 105
    Height = 21
    TabOrder = 5
    Text = 'E_Mc'
    OnClick = E_S_minClick
    OnExit = E_S_minExit
    OnKeyPress = E_S_minKeyPress
  end
  object E_S_Max: TEdit
    Left = 151
    Top = 176
    Width = 105
    Height = 21
    TabOrder = 6
    Text = 'E_Mc'
    OnClick = E_S_MaxClick
    OnExit = E_S_MaxExit
    OnKeyPress = E_S_MaxKeyPress
  end
  object Button1: TButton
    Left = 288
    Top = 216
    Width = 105
    Height = 25
    Caption = #21462#28040
    TabOrder = 7
    OnClick = Button1Click
  end
  object E_JinChi: TEdit
    Left = 328
    Top = 140
    Width = 105
    Height = 21
    TabOrder = 8
    Text = 'E_Mc'
    OnClick = E_JinChiClick
    OnExit = E_JinChiExit
    OnKeyPress = E_JinChiKeyPress
  end
  object ComboBox1: TComboBox
    Left = 328
    Top = 32
    Width = 137
    Height = 21
    Style = csDropDownList
    TabOrder = 9
    OnChange = ComboBox1Change
    Items.Strings = (
      #20840#37096#23721#23618
      #32531#27785#24102#30340#19979#37096
      #32769#39030'1-2'#20010#23721#26753)
  end
  object ComboBox2: TComboBox
    Left = 328
    Top = 80
    Width = 137
    Height = 21
    Style = csDropDownList
    Enabled = False
    TabOrder = 10
    Items.Strings = (
      '0.2'
      '0.5'
      '0.8'
      '1')
  end
end
