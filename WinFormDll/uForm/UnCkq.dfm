object Cqk: TCqk
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #26032#22686#37319#31354#21306
  ClientHeight = 361
  ClientWidth = 652
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    652
    361)
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 0
    Width = 652
    Height = 3
    Cursor = crVSplit
    Align = alTop
    Color = clActiveCaption
    ParentColor = False
    ExplicitLeft = -7
    ExplicitWidth = 601
  end
  object Label12: TLabel
    Left = 301
    Top = 101
    Width = 3
    Height = 13
    Margins.Bottom = 0
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 3
    Width = 652
    Height = 41
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 36
        Width = 651
      end>
    object ToolBar1: TToolBar
      Left = 11
      Top = 0
      Width = 637
      Height = 36
      AutoSize = True
      ButtonHeight = 36
      ButtonWidth = 58
      Caption = 'ToolBar1'
      Images = ImageList1
      ParentShowHint = False
      ShowCaptions = True
      ShowHint = True
      TabOrder = 0
      object AddButton: TToolButton
        Left = 0
        Top = 0
        Caption = #28155#21152
        ImageIndex = 0
        OnClick = AddButtonClick
      end
      object EditButton: TToolButton
        Left = 58
        Top = 0
        Caption = #32534#36753
        Enabled = False
        ImageIndex = 2
        OnClick = EditButtonClick
      end
      object SaveButton: TToolButton
        Left = 116
        Top = 0
        Caption = '     '#20445#23384'    '
        Enabled = False
        ImageIndex = 4
        OnClick = SaveButtonClick
      end
      object DeleteButton: TToolButton
        Left = 174
        Top = 0
        Caption = #21024#38500
        Enabled = False
        ImageIndex = 6
        OnClick = DeleteButtonClick
      end
      object ExitButton: TToolButton
        Left = 232
        Top = 0
        Caption = #36864#20986
        ImageIndex = 7
        OnClick = ExitButtonClick
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 264
    Width = 652
    Height = 99
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvLowered
    TabOrder = 1
    object StringGrid1: TStringGrid
      Left = 1
      Top = 1
      Width = 650
      Height = 97
      Align = alClient
      DefaultRowHeight = 20
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
      TabOrder = 0
      OnSelectCell = StringGrid1SelectCell
      ColWidths = (
        64
        64
        64
        64
        64)
      RowHeights = (
        20
        20
        20
        20
        20)
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 43
    Width = 651
    Height = 216
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvLowered
    TabOrder = 2
    object Label1: TLabel
      Left = 17
      Top = 20
      Width = 60
      Height = 13
      Margins.Bottom = 0
      Caption = #37319#31354#21306#21517#31216
    end
    object Label3: TLabel
      Left = 17
      Top = 74
      Width = 48
      Height = 13
      Margins.Bottom = 0
      Caption = #36208#21521#38271#24230
    end
    object Label2: TLabel
      Left = 17
      Top = 47
      Width = 48
      Height = 13
      Margins.Bottom = 0
      Caption = #20542#26012#38271#24230
    end
    object Label5: TLabel
      Left = 17
      Top = 155
      Width = 48
      Height = 13
      Margins.Bottom = 0
      Caption = #31354#38388#20301#32622
    end
    object Label11: TLabel
      Left = 17
      Top = 130
      Width = 48
      Height = 13
      Margins.Bottom = 0
      Caption = #39044#35686#36317#31163
    end
    object Label15: TLabel
      Left = 252
      Top = 128
      Width = 12
      Height = 13
      Margins.Bottom = 0
      Caption = #31859
    end
    object Label22: TLabel
      Left = 251
      Top = 74
      Width = 12
      Height = 13
      Margins.Bottom = 0
      Caption = #31859
    end
    object Label4: TLabel
      Left = 14
      Top = 101
      Width = 48
      Height = 13
      Margins.Bottom = 0
      Caption = #24320#37319#39640#24230
    end
    object Label8: TLabel
      Left = 251
      Top = 101
      Width = 12
      Height = 13
      Margins.Bottom = 0
      Caption = #31859
    end
    object Label6: TLabel
      Left = 341
      Top = 20
      Width = 84
      Height = 13
      Margins.Bottom = 0
      Caption = #36317#31163#24037#20316#38754#24038#20391
    end
    object Label7: TLabel
      Left = 342
      Top = 47
      Width = 84
      Height = 13
      Margins.Bottom = 0
      Caption = #36317#31163#24037#20316#38754#21491#20391
    end
    object Label10: TLabel
      Left = 341
      Top = 101
      Width = 84
      Height = 13
      Margins.Bottom = 0
      Caption = #36317#31163#24037#20316#38754#21518#38754
    end
    object Label9: TLabel
      Left = 342
      Top = 74
      Width = 84
      Height = 13
      Margins.Bottom = 0
      Caption = #36317#31163#24037#20316#38754#21069#38754
    end
    object Label13: TLabel
      Left = 341
      Top = 130
      Width = 84
      Height = 13
      Margins.Bottom = 0
      Caption = #36317#31163#24037#20316#38754#39030#37096
    end
    object Label14: TLabel
      Left = 342
      Top = 155
      Width = 84
      Height = 13
      Margins.Bottom = 0
      Caption = #36317#31163#24037#20316#38754#24213#37096
    end
    object Label16: TLabel
      Left = 251
      Top = 47
      Width = 12
      Height = 13
      Margins.Bottom = 0
      Caption = #31859
    end
    object Label17: TLabel
      Left = 603
      Top = 20
      Width = 12
      Height = 13
      Margins.Bottom = 0
      Caption = #31859
    end
    object Label18: TLabel
      Left = 603
      Top = 44
      Width = 12
      Height = 13
      Margins.Bottom = 0
      Caption = #31859
    end
    object Label19: TLabel
      Left = 603
      Top = 74
      Width = 12
      Height = 13
      Margins.Bottom = 0
      Caption = #31859
    end
    object Label20: TLabel
      Left = 603
      Top = 101
      Width = 12
      Height = 13
      Margins.Bottom = 0
      Caption = #31859
    end
    object Label21: TLabel
      Left = 603
      Top = 128
      Width = 12
      Height = 13
      Margins.Bottom = 0
      Caption = #31859
    end
    object Label23: TLabel
      Left = 603
      Top = 155
      Width = 12
      Height = 13
      Margins.Bottom = 0
      Caption = #31859
    end
    object Label24: TLabel
      Left = 17
      Top = 186
      Width = 48
      Height = 13
      Margins.Bottom = 0
      Caption = #20572#37319#26102#38388
    end
    object EditCkqcd: TEdit
      Left = 114
      Top = 71
      Width = 131
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 0
      OnClick = EditCkqcdClick
      OnKeyPress = EditCkqkdKeyPress
    end
    object EditYjaqjl: TEdit
      Left = 115
      Top = 125
      Width = 131
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 1
      OnClick = EditYjaqjlClick
      OnKeyPress = EditCkqkdKeyPress
    end
    object EditCkqName: TEdit
      Left = 114
      Top = 17
      Width = 131
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 2
      OnClick = EditCkqNameClick
    end
    object CboWzfs: TComboBox
      Left = 114
      Top = 152
      Width = 131
      Height = 21
      Style = csDropDownList
      DropDownCount = 24
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 3
      OnChange = CboWzfsChange
      OnClick = CboWzfsClick
      Items.Strings = (
        'nLeft'
        'nRight'
        'nFront'
        'nBehind'
        'nTop'
        'nBottom')
    end
    object EditCkqkd: TEdit
      Left = 114
      Top = 44
      Width = 131
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 4
      OnClick = EditCkqkdClick
      OnKeyPress = EditCkqkdKeyPress
    end
    object EditCkqkcgd: TEdit
      Left = 114
      Top = 98
      Width = 131
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 5
      OnClick = EditCkqkcgdClick
      OnKeyPress = EditCkqkdKeyPress
    end
    object EditDis_left: TEdit
      Left = 466
      Top = 17
      Width = 131
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 6
      OnClick = EditDis_leftClick
      OnKeyPress = EditCkqkdKeyPress
    end
    object EditDis_right: TEdit
      Left = 466
      Top = 44
      Width = 131
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 7
      OnClick = EditDis_rightClick
      OnKeyPress = EditCkqkdKeyPress
    end
    object EditDis_front: TEdit
      Left = 466
      Top = 71
      Width = 131
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 8
      OnClick = EditDis_frontClick
      OnKeyPress = EditCkqkdKeyPress
    end
    object EditDis_behind: TEdit
      Left = 466
      Top = 98
      Width = 131
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 9
      OnClick = EditDis_behindClick
      OnKeyPress = EditCkqkdKeyPress
    end
    object EditDis_top: TEdit
      Left = 466
      Top = 125
      Width = 131
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 10
      OnClick = EditDis_topClick
      OnKeyPress = EditCkqkdKeyPress
    end
    object EditDis_bottom: TEdit
      Left = 466
      Top = 152
      Width = 131
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 11
      OnClick = EditDis_bottomClick
      OnKeyPress = EditCkqkdKeyPress
    end
    object DateTimePicker1: TDateTimePicker
      Left = 113
      Top = 179
      Width = 132
      Height = 20
      Date = 41044.478567337960000000
      Format = 'yyyy-MM-dd'
      Time = 41044.478567337960000000
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 12
      OnClick = DateTimePicker1Click
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 342
    Width = 652
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 50
      end
      item
        Width = 50
      end>
  end
  object ImageList1: TImageList
    Left = 320
    Top = 8
    Bitmap = {
      494C010109000E007C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000F2F2F200959595005C5C5C003434340034343400616161009A9A9A00F0F0
      F000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C6004D4D4D004B4B4B00585858006060600060606000585858004C4C4C004343
      4300C4C4C4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B3B3B3004E4E
      4E00595959006666660066666600666666006666660066666600666666005A5A
      5A003E3E3E00C3C3C30000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E6E6E600464646006565
      65006D6D6D006D6D6D0095959500B8B8B800B8B8B800959595006C6C6C006C6C
      6C00606060004C4C4C00F1F1F100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000949494008A8A8A00C2C2
      C200C2C2C200C2C2C20085858500525252005252520085858500999999007272
      720072727200636363009F9F9F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000616161004C4C4C004C4C
      4C004C4C4C004C4C4C007E7E7E00EDEDED00EDEDED007E7E7E00878787007979
      790079797900727272006D6D6D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ECECEC005E5E5E008080
      8000808080008282820055555500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F8F8F8009292920000000000EEEEEE00606060008787
      870087878700939393005D5D5D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E7E7E7007A7A7A006D6D6D00DCDCDC0085858500767676008E8E
      8E008E8E8E009E9E9E007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CFCFCF006C6C6C007F7F7F00828282006E6E6E0082828200959595009595
      9500A2A2A2009D9D9D00ACACAC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FCFCFC00B1B1
      B1007A7A7A008D8D8D009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C00A7A7
      A700AEAEAE006C6C6C00EDEDED00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FCFCFC009A9A9A009A9A
      9A00BABABA00A6A6A600A2A2A200A2A2A200A2A2A200A7A7A700BABABA00C4C4
      C40096969600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E9E9E9008B8B
      8B00A0A0A000D2D2D200B9B9B900C4C4C400D8D8D800D2D2D200ACACAC007676
      7600C4C4C4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FBFB
      FB00B8B8B80079797900BABABA00A4A4A4007B7B7B0080808000ABABAB00EBEB
      EB00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DEDEDE008C8C8C007F7F7F00F9F9F90000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F8F8F800AEAEAE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BB8E80008C3F
      2600BA958800BA958800BA958800BA958800BA958800BA958800BA958800BA95
      88008C3F26008C3F26008C3F2600BB8E800000000000000000009D9D9D005959
      5900A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A1005959590059595900595959009D9D9D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F0F5F30082A99B003E7A64000F5A3E000F5A3E00447E690088AD9F00EEF3
      F1000000000000000000000000000000000000000000BD9081008F422800C069
      2900EAECEC00EAECEC00EAECEC00EAECEC00EAECEC00EAECEC00EAECEC00EAEC
      EC008C3F2700C0692900C06929008F422800000000009F9F9F005B5B5B007474
      7400EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEB
      EB005959590074747400747474005B5B5B000000000000000000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000000000000000000000000000000000000000BCD1
      C9002B6F5600217654002A87600030916800309168002A866000217754002067
      4D00B9CFC700000000000000000000000000BE92820091452B00C26D2D00C26D
      2D00EAECEC00A2512900A2512900EAECEC00EAECEC00EAECEC00EAECEC00EAEC
      EC008C3F2700C26D2D00C26D2D0091452B00A0A0A0005E5E5E00777777007777
      7700EBEBEB006565650065656500EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEB
      EB005959590077777700777777005E5E5E00000000000000FF000000FF000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A4C2B7002775
      56002D86620037956E0037956E0037956E0037956E0037956E0037956E002E86
      620019644800B8CFC600000000000000000095492F00C4713200C4713200C471
      3200EAECEC00A2532B00A2532B00EAECEC00EAECEC00EAECEC00EAECEC00EAEC
      EC008C3F2700C4713200C471320095492F00626262007B7B7B007B7B7B007B7B
      7B00EBEBEB006666660066666600EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEB
      EB00595959007B7B7B007B7B7B0062626200000000000000FF0000FFFF000000
      FF00000080000000000000000000000000000000000000000000000000000000
      00000000FF0000000000000000000000000000000000E1EBE700216B4E003991
      6C00409B7500409B750074B79B00A2CEBC00A2CEBC0074B79B003E9A74003E9A
      7400348C680029705400EEF4F20000000000994E3200C7763800C7763800C776
      3800EAECEC00A4552E00A4552E00EAECEC00EAECEC00EAECEC00EAECEC00EAEC
      EC008C3F2700C7763800C7763800994E3200656565007F7F7F007F7F7F007F7F
      7F00EBEBEB006969690069696900EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEB
      EB00595959007F7F7F007F7F7F006565650000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000000000000000000000007FAA99006EA68F00AFD6
      C600AFD6C600AFD6C60069A28B002E775A002E775A0069A28B0079BAA000459F
      7B00459F7B003C8A6B008CB3A300000000009D533500CA7B3E00CA7B3E00CA7B
      3E00E4D5C900EAECEC00EAECEC00EAECEC00EAECEC00EAECEC00EAECEC00E4D5
      C9008C3F2700CA7B3E00CA7B3E009D5335006969690084848400848484008484
      8400D6D6D600EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00D6D6
      D600595959008484840084848400696969000000000000000000000000000000
      FF000000FF0000008000000000000000000000000000000000000000FF000000
      800000000000000000000000000000000000000000003F836800267354002673
      54002673540026735400639A8400EAF1EE00EAF1EE00639A840069A58D004DA5
      83004DA58300489D7C004E8D740000000000A1583900CD814400CD814400CD81
      4400CD814400CD814400CD814400CD814400CD814400CD814400CD814400CD81
      4400CD814400CD814400CD814400A15839006D6D6D0088888800888888008888
      8800888888008888880088888800888888008888880088888800888888008888
      88008888880088888800888888006D6D6D000000000000000000000000000000
      00000000FF000000FF000000800000000000000000000000FF00000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E8F0ED003983650056AA
      8A0056AA8A0059AB8C002F7C5C0000000000A45D3D00D0874B00D0874B00D087
      4B00D0874B00D0874B00D0874B00D0874B00D0874B00D0874B00D0874B00D087
      4B00D0874B00D0874B00D0874B00A45D3D00707070008D8D8D008D8D8D008D8D
      8D008D8D8D008D8D8D008D8D8D008D8D8D008D8D8D008D8D8D008D8D8D008D8D
      8D008D8D8D008D8D8D008D8D8D00707070000000000000000000000000000000
      0000000000000000FF000000FF00000080000000FF0000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F7FAF90079AC960000000000EBF2EF003A8666005FB0
      92005FB092006FB79C003883630000000000A9624100D48D5200D48D5200EED1
      BA00000000000000000000000000000000000000000000000000000000000000
      0000EED1BA00D48D5200D48D5200A9624100757575009393930093939300D4D4
      D400000000000000000000000000000000000000000000000000000000000000
      0000D4D4D4009393930093939300757575000000000000000000000000000000
      000000000000000000000000FF000000FF000000800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E2EDE8005A9A7E0048937300D4E5DD0068A389004F9E7F0067B6
      9A0067B69A0080BDA6005C9B800000000000AD684400D7935800D79358000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D7935800D7935800AD6844007878780097979700979797000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009797970097979700787878000000000000000000000000000000
      0000000000000000FF000000FF00000080000000FF0000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C3DBD0004791700059A688005CA98C00479574005CA98C0070BBA10070BB
      A10081C3AC0082B9A20097C1AF0000000000B16C4800DA985E00DA985E000000
      0000F8EADC00F1D4B800F1D4B800F1D4B800F1D4B800F1D4B800F1D4B800F8EA
      DC0000000000DA985E00DA985E00B16C48007C7C7C009C9C9C009C9C9C000000
      0000EAEAEA00D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400EAEA
      EA00000000009C9C9C009C9C9C007C7C7C000000000000000000000000000000
      00000000FF000000FF000000800000000000000000000000FF00000080000000
      0000000000000000000000000000000000000000000000000000FCFDFD009CC6
      B30054A1810068B3980078C1A90078C1A90078C1A90078C1A90078C1A90086C8
      B20093C9B50045937000E8F2ED0000000000B4714B00DD9D6400DD9D64000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DD9D6400DD9D6400B4714B007F7F7F00A0A0A000A0A0A0000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A0A0A000A0A0A0007F7F7F0000000000000000000000FF000000
      FF000000FF0000008000000000000000000000000000000000000000FF000000
      80000000000000000000000000000000000000000000FCFDFD007EB69D007DB8
      9F00A1D3C30085C8B3007FC6B0007FC6B0007FC6B00085C9B400A0D5C400B1D8
      CA0078B59C00B7D6C8000000000000000000B8754F00DFA16900DFA169000000
      0000F8EADC00F1D4B800F1D4B800F1D4B800F1D4B800F1D4B800F1D4B800F8EA
      DC0000000000DFA16900DFA16900B8754F0083838300A4A4A400A4A4A4000000
      0000EAEAEA00D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400EAEA
      EA0000000000A4A4A400A4A4A40083838300000000000000FF0000FFFF000000
      FF00000080000000000000000000000000000000000000000000000000000000
      FF00000080000000000000000000000000000000000000000000E3EFEA006AAC
      8E0083BDA400C2E3D9009ED5C500ACDCCD00C9E8DF00C2E3D90092C6B1004F9D
      7900B4D5C600000000000000000000000000BB795200E1A56D00E1A56D000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E1A56D00E1A56D00BB79520086868600A7A7A700A7A7A7000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A7A7A700A7A7A7008686860000000000808080000000FF008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000000000000000000000000000000000000000FAFC
      FB00A3CDBA0051A17B00A3D1BF0087C1A80053A37E005BA6830093C4AD00E6F1
      EC0000000000000000000000000000000000BE7C5400E1A56D00E1A56D000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E1A56D00E1A56D00BE7C540089898900A7A7A700A7A7A7000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A7A7A700A7A7A700898989000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D4E8DF0069AF8E0057A78200F8FBFA0000000000000000000000
      000000000000000000000000000000000000DAB39B00C07E5600C07E5600D3A5
      8900D3A58900D3A58900D3A58900D3A58900D3A58900D3A58900D3A58900D3A5
      8900D3A58900C07E5600C07E5600DAB39B00BABABA008B8B8B008B8B8B00AEAE
      AE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAE
      AE00AEAEAE008B8B8B008B8B8B00BABABA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F7FAF90095C8B0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000709C8C000C573C000C573C000C573C000C573C00709C8C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008686860031313100313131003131310031313100868686000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FCFDFE00265F9C004F80BB006D96C600ACC3DF00E8EFF600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFDFD00616161008484840099999900C5C5C500EFEFEF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000105B3F002C8E64002C8E64002C8E64002C8E6400105B3F000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000353535005D5D5D005D5D5D005D5D5D005D5D5D00353535000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005383BC00C0E1F600A6D4F00083B8DF003A79B700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000088888800DBDBDB00CBCBCB00B1B1B10078787800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001460430032926A0032926A0032926A0032926A00146043000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003A3A3A00626262006262620062626200626262003A3A3A000000
      00000000000000000000000000000000000036755E000E593D000E593D000E59
      3D000E593D0023647B00D5E6F500D7E9FA00CBE3F9009FD9F400468BC300E8EF
      F6000E593D000E593D0036755E00000000005555550033333300333333003333
      3300333333004F4F4F00E5E5E500E8E8E800E2E2E200C9C9C90084848400EFEF
      EF00333333003333330055555500000000000000000000000000000000000000
      0000000000001965480039977100399771003997710039977100196548000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003F3F3F00686868006868680068686800686868003F3F3F000000
      000000000000000000000000000000000000146043000000000000000000FDFE
      FE00FBFEFD00D4E1ED007FA7D200F9FCFE00BCE3F90038BDE800519ACC00498D
      C500E8EFF600E1F4EF0014604300000000003A3A3A000000000000000000FDFD
      FD00FCFCFC00E0E0E000A8A8A800FBFBFB00DADADA00909090008E8E8E008787
      8700EFEFEF00EAEAEA003A3A3A00000000000000000000000000000000000000
      0000000000001F6B4D00429D7800429D7800429D7800429D78001F6B4D000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000454545006F6F6F006F6F6F006F6F6F006F6F6F00454545000000
      0000000000000000000000000000000000001B684A00FCFDFD00FCFEFE00F9FD
      FC00F6FBFA00F1FAF7006390C200C8E4F50044D0F40000C3F20025B8E6005198
      CB004D91C600E8EFF6001B684A000000000041414100FCFCFC00FDFDFD00FBFB
      FB00F8F8F800F5F5F50092929200DEDEDE009C9C9C0079797900858585008E8E
      8E0089898900EFEFEF0041414100000000007EAC990025725300257253002572
      530025725300257253004BA380004BA380004BA380004BA38000257253002572
      53002572530025725300257253007EAC9900959595004B4B4B004B4B4B004B4B
      4B004B4B4B004B4B4B00777777007777770077777700777777004B4B4B004B4B
      4B004B4B4B004B4B4B004B4B4B009595950024715200FAFCFB00F9FDFC00F6FB
      FA00F1FAF700EDF8F500E8EFF600608FC400C2EAF80028CBF30000C3F20025B8
      E6005198CB005193C800E8EFF600000000004A4A4A00FBFBFB00FBFBFB00F8F8
      F800F5F5F500F2F2F200EFEFEF0092929200DDDDDD008D8D8D00797979008585
      85008E8E8E008C8C8C00EFEFEF00000000002B78580055A9890055A9890055A9
      890055A9890055A9890055A9890055A9890055A9890055A9890055A9890055A9
      890055A9890055A9890055A989002B785800515151007F7F7F007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F00515151002C7A5A00F8FCFA00F6FBFA00F1FA
      F700EDF8F500E8F6F200E3F4EF00E8EFF6006594C500C2EBF80028CBF30000C3
      F20025B8E6005198CB005696CA000000000053535300FAFAFA00F8F8F800F5F5
      F500F2F2F200EFEFEF00EBEBEB00EFEFEF0095959500DDDDDD008D8D8D007979
      7900858585008E8E8E009090900000000000317F5E005FB092005FB092005FB0
      92005FB092005FB092005FB092005FB092005FB092005FB092005FB092005FB0
      92005FB092005FB092005FB09200317F5E005858580087878700878787008787
      8700878787008787870087878700878787008787870087878700878787008787
      87008787870087878700878787005858580036846200F7FBFA00F1FAF700EDF8
      F500E8F6F200E3F4EF00DDF2EC00D8F0E900E8EFF6006B97C700C2EBF80028CB
      F30000C3F20027B8E6005299CC006C9DCB005D5D5D00F9F9F900F5F5F500F2F2
      F200EFEFEF00EBEBEB00E7E7E700E4E4E400EFEFEF0099999900DDDDDD008D8D
      8D0079797900868686008F8F8F009B9B9B003786640068B79B0068B79B0068B7
      9B0068B79B0068B79B0068B79B0068B79B0068B79B0068B79B0068B79B0068B7
      9B0068B79B0068B79B0068B79B00378664005E5E5E008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F005E5E5E003E8D6A00F4FAF800EDF8F500E8F6
      F200E3F4EF00DDF2EC00D8F0E900D2EEE600CDECE400E8EFF600709BCA00C2EB
      F80028CBF30000C3F2003FBBE6005693C70065656500F7F7F700F2F2F200EFEF
      EF00EBEBEB00E7E7E700E4E4E400E0E0E000DCDCDC00EFEFEF009D9D9D00DDDD
      DD008D8D8D0079797900929292008E8E8E003D8C6900C2E3D800C2E3D800C2E3
      D800C2E3D800C2E3D80072BDA40072BDA40072BDA40072BDA400C2E3D800C2E3
      D800C2E3D800C2E3D800C2E3D8003D8C690064646400D2D2D200D2D2D200D2D2
      D200D2D2D200D2D2D20097979700979797009797970097979700D2D2D200D2D2
      D200D2D2D200D2D2D200D2D2D2006464640047967200F1F9F700E9F6F200E3F4
      EF00DDF2EC00D8F0E900D2EEE600CDECE400C8EAE100C3E8DE00E8EFF600759E
      CC00C2EBF80042D0F3005E9FCE00B9CCE4006E6E6E00F5F5F500EFEFEF00EBEB
      EB00E7E7E700E4E4E400E0E0E000DCDCDC00D9D9D900D5D5D500EFEFEF00A0A0
      A000DDDDDD009A9A9A0096969600CECECE0090BFAA0043936F0043936F004393
      6F0043936F0043936F007BC3AC007BC3AC007BC3AC007BC3AC0043936F004393
      6F0043936F0043936F0043936F0090BFAA00A7A7A7006B6B6B006B6B6B006B6B
      6B006B6B6B006B6B6B009F9F9F009F9F9F009F9F9F009F9F9F006B6B6B006B6B
      6B006B6B6B006B6B6B006B6B6B00A7A7A7004E9E7900EEF9F500E4F4EF00DDF2
      EC00D8F0E900D2EEE600CDECE400C8EAE100C3E8DE00BFE6DB00BBE5D900E8EF
      F60079A1CE007CA4CE0059989B000000000076767600F3F3F300ECECEC00E7E7
      E700E4E4E400E0E0E000DCDCDC00D9D9D900D5D5D500D2D2D200D0D0D000EFEF
      EF00A3A3A300A5A5A5007A7A7A00000000000000000000000000000000000000
      0000000000004999740084C9B30084C9B30084C9B30084C9B300499974000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000071717100A6A6A600A6A6A600A6A6A600A6A6A600717171000000
      00000000000000000000000000000000000054A57F00EEF8F500EBF7F400E8F6
      F200E4F5F000E1F4EF00DEF2ED00DBF1EB00D8F0E900D6EFE800D3EEE700D1EE
      E600C8E6E200C5E3E20054A57F00000000007C7C7C00F3F3F300F1F1F100EFEF
      EF00ECECEC00EAEAEA00E8E8E800E6E6E600E4E4E400E2E2E200E0E0E000DFDF
      DF00D7D7D700D4D4D4007C7C7C00000000000000000000000000000000000000
      0000000000004E9E79008BCEBA008BCEBA008BCEBA008BCEBA004E9E79000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000076767600ACACAC00ACACAC00ACACAC00ACACAC00767676000000
      00000000000000000000000000000000000055A57F0059AA830059AA830059AA
      830059AA830059AA830059AA830059AA830059AA830059AA830059AA830059AA
      830059AA830059AA830054A47E00000000007D7D7D0081818100818181008181
      8100818181008181810081818100818181008181810081818100818181008181
      810081818100818181007C7C7C00000000000000000000000000000000000000
      00000000000052A37D0091D2C00091D2C00091D2C00091D2C00052A37D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007A7A7A00B1B1B100B1B1B100B1B1B100B1B1B1007A7A7A000000
      00000000000000000000000000000000000054A27E0099C9B2009ACAB3009ACA
      B3009ACAB3009ACAB3009ACAB3009ACAB3009ACAB3009ACAB3009ACAB3009ACA
      B3009ACAB3009ACAB30051A17C00000000007B7B7B00B1B1B100B2B2B200B2B2
      B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2
      B200B2B2B200B2B2B20079797900000000000000000000000000000000000000
      00000000000056A78000D2EDE600D2EDE600D2EDE600D2EDE60056A780000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007E7E7E00DFDFDF00DFDFDF00DFDFDF00DFDFDF007E7E7E000000
      0000000000000000000000000000000000005BA9840098C9B10099C9B20099C9
      B20099C9B20099C9B20099C9B20099C9B20099C9B20099C9B20099C9B20099C9
      B20099C9B20099C9B20059A782000000000082828200B0B0B000B1B1B100B1B1
      B100B1B1B100B1B1B100B1B1B100B1B1B100B1B1B100B1B1B100B1B1B100B1B1
      B100B1B1B100B1B1B10080808000000000000000000000000000000000000000
      0000000000009DCDB60059AA830059AA830059AA830059AA83009DCDB6000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B5B5B50081818100818181008181810081818100B5B5B5000000
      000000000000000000000000000000000000A3D0BA005EAD87005CAB85005CAB
      85005CAB85005CAB85005CAB85005CAB85005CAB85005CAB85005CAB85005CAB
      85005CAB85005CAB8500A0CEB80000000000B9B9B90085858500838383008383
      8300838383008383830083838300838383008383830083838300838383008383
      83008383830083838300B7B7B70000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF00F00F000000000000E007000000000000
      C003000000000000800100000000000080010000000000008001000000000000
      FF81000000000000FC81000000000000F801000000000000F001000000000000
      C0010000000000008003000000000000C007000000000000E00F000000000000
      F87F000000000000FCFF000000000000C000C000FFFFF00F80008000DFFBE007
      000000008FFFC0030000000087F7800100000000C7EF800100000000E3CF8001
      00000000F19FFF8100000000F83FFC810FF00FF0FC7FF8011FF81FF8F83FF001
      10081008F19FC0011FF81FF8C3CF80031008100887E7C0071FF81FF88FFBE00F
      1FF81FF8FFFFF87F00000000FFFFFCFFF81FF81FF03FF03FF81FF81FF83FF83F
      F81FF81F00010001F81FF81F60016001F81FF81F000100010000000000010001
      0000000000010001000000000000000000000000000000000000000000000000
      0000000000010001F81FF81F00010001F81FF81F00010001F81FF81F00010001
      F81FF81F00010001F81FF81F0001000100000000000000000000000000000000
      000000000000}
  end
end
