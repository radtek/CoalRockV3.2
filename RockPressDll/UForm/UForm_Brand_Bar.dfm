object Form_Band_Bar: TForm_Band_Bar
  Left = 0
  Top = 0
  Caption = 'Form_Band_Bar'
  ClientHeight = 777
  ClientWidth = 1290
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar2: TToolBar
    Left = 0
    Top = 0
    Width = 1290
    Height = 36
    AutoSize = True
    ButtonHeight = 36
    ButtonWidth = 55
    Caption = 'ToolBar1'
    Images = ImageList1
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = True
    TabOrder = 0
    object SaveButton: TToolButton
      Left = 0
      Top = 0
      Caption = #21047#26032#22270#24418
      ImageIndex = 60
      OnClick = SaveButtonClick
    end
    object Open_ToolForm: TToolButton
      Left = 55
      Top = 0
      Caption = #23646#24615#35774#32622
      ImageIndex = 32
      OnClick = Open_ToolFormClick
    end
    object ToolButton1: TToolButton
      Left = 110
      Top = 0
      Caption = #20445#23384#22270#29255
      ImageIndex = 10
      OnClick = ToolButton1Click
    end
    object ExitButton: TToolButton
      Left = 165
      Top = 0
      Caption = #36864#20986#30028#38754
      ImageIndex = 65
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 758
    Width = 1290
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end>
  end
  object Panel_ProcessBar: TPanel
    Left = 0
    Top = 719
    Width = 1290
    Height = 39
    Align = alBottom
    TabOrder = 2
    Visible = False
    object FirstPGBar: TProgressBar
      Left = 1
      Top = 1
      Width = 1288
      Height = 18
      Align = alTop
      Orientation = pbVertical
      Smooth = True
      TabOrder = 0
    end
    object SecondPGBar: TProgressBar
      Left = 1
      Top = 19
      Width = 1288
      Height = 18
      Align = alTop
      Orientation = pbVertical
      Smooth = True
      TabOrder = 1
    end
  end
  object Main_panel: TPanel
    Left = 24
    Top = 72
    Width = 817
    Height = 561
    Caption = 'Main_panel'
    TabOrder = 3
    object Chart1: TChart
      Tag = 1
      Left = 16
      Top = 56
      Width = 353
      Height = 281
      BackWall.Brush.Gradient.Direction = gdBottomTop
      BackWall.Brush.Gradient.EndColor = clWhite
      BackWall.Brush.Gradient.StartColor = 15395562
      BackWall.Brush.Gradient.Visible = True
      BackWall.Transparent = False
      Foot.Font.Color = clBlue
      Foot.Font.Name = 'Verdana'
      Gradient.Direction = gdBottomTop
      Gradient.EndColor = clWhite
      Gradient.MidColor = 15395562
      Gradient.StartColor = 15395562
      Gradient.Visible = True
      LeftWall.Color = 14745599
      Legend.Font.Name = 'Verdana'
      Legend.Shadow.Transparency = 0
      RightWall.Color = 14745599
      Title.Font.Name = 'Verdana'
      Title.Text.Strings = (
        'TChart')
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = 11119017
      BottomAxis.LabelsFormat.Font.Name = 'Verdana'
      BottomAxis.TicksInner.Color = 11119017
      BottomAxis.Title.Font.Name = 'Verdana'
      DepthAxis.Axis.Color = 4210752
      DepthAxis.Grid.Color = 11119017
      DepthAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthAxis.TicksInner.Color = 11119017
      DepthAxis.Title.Font.Name = 'Verdana'
      DepthTopAxis.Axis.Color = 4210752
      DepthTopAxis.Grid.Color = 11119017
      DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthTopAxis.TicksInner.Color = 11119017
      DepthTopAxis.Title.Font.Name = 'Verdana'
      LeftAxis.Axis.Color = 4210752
      LeftAxis.Grid.Color = 11119017
      LeftAxis.LabelsFormat.Font.Name = 'Verdana'
      LeftAxis.TicksInner.Color = 11119017
      LeftAxis.Title.Font.Name = 'Verdana'
      RightAxis.Axis.Color = 4210752
      RightAxis.Grid.Color = 11119017
      RightAxis.LabelsFormat.Font.Name = 'Verdana'
      RightAxis.TicksInner.Color = 11119017
      RightAxis.Title.Font.Name = 'Verdana'
      TopAxis.Axis.Color = 4210752
      TopAxis.Grid.Color = 11119017
      TopAxis.LabelsFormat.Font.Name = 'Verdana'
      TopAxis.TicksInner.Color = 11119017
      TopAxis.Title.Font.Name = 'Verdana'
      TabOrder = 0
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
    end
    object Chart2: TChart
      Tag = 2
      Left = 63
      Top = 88
      Width = 353
      Height = 281
      BackWall.Brush.Gradient.Direction = gdBottomTop
      BackWall.Brush.Gradient.EndColor = clWhite
      BackWall.Brush.Gradient.StartColor = 15395562
      BackWall.Brush.Gradient.Visible = True
      BackWall.Transparent = False
      Foot.Font.Color = clBlue
      Foot.Font.Name = 'Verdana'
      Gradient.Direction = gdBottomTop
      Gradient.EndColor = clWhite
      Gradient.MidColor = 15395562
      Gradient.StartColor = 15395562
      Gradient.Visible = True
      LeftWall.Color = 14745599
      Legend.Font.Name = 'Verdana'
      Legend.Shadow.Transparency = 0
      RightWall.Color = 14745599
      Title.Font.Name = 'Verdana'
      Title.Text.Strings = (
        'TChart')
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = 11119017
      BottomAxis.LabelsFormat.Font.Name = 'Verdana'
      BottomAxis.TicksInner.Color = 11119017
      BottomAxis.Title.Font.Name = 'Verdana'
      DepthAxis.Axis.Color = 4210752
      DepthAxis.Grid.Color = 11119017
      DepthAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthAxis.TicksInner.Color = 11119017
      DepthAxis.Title.Font.Name = 'Verdana'
      DepthTopAxis.Axis.Color = 4210752
      DepthTopAxis.Grid.Color = 11119017
      DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthTopAxis.TicksInner.Color = 11119017
      DepthTopAxis.Title.Font.Name = 'Verdana'
      LeftAxis.Axis.Color = 4210752
      LeftAxis.Grid.Color = 11119017
      LeftAxis.LabelsFormat.Font.Name = 'Verdana'
      LeftAxis.TicksInner.Color = 11119017
      LeftAxis.Title.Font.Name = 'Verdana'
      RightAxis.Axis.Color = 4210752
      RightAxis.Grid.Color = 11119017
      RightAxis.LabelsFormat.Font.Name = 'Verdana'
      RightAxis.TicksInner.Color = 11119017
      RightAxis.Title.Font.Name = 'Verdana'
      TopAxis.Axis.Color = 4210752
      TopAxis.Grid.Color = 11119017
      TopAxis.LabelsFormat.Font.Name = 'Verdana'
      TopAxis.TicksInner.Color = 11119017
      TopAxis.Title.Font.Name = 'Verdana'
      TabOrder = 1
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
    end
    object Chart3: TChart
      Tag = 3
      Left = 128
      Top = 136
      Width = 353
      Height = 281
      BackWall.Brush.Gradient.Direction = gdBottomTop
      BackWall.Brush.Gradient.EndColor = clWhite
      BackWall.Brush.Gradient.StartColor = 15395562
      BackWall.Brush.Gradient.Visible = True
      BackWall.Transparent = False
      Foot.Font.Color = clBlue
      Foot.Font.Name = 'Verdana'
      Gradient.Direction = gdBottomTop
      Gradient.EndColor = clWhite
      Gradient.MidColor = 15395562
      Gradient.StartColor = 15395562
      Gradient.Visible = True
      LeftWall.Color = 14745599
      Legend.Font.Name = 'Verdana'
      Legend.Shadow.Transparency = 0
      RightWall.Color = 14745599
      Title.Font.Name = 'Verdana'
      Title.Text.Strings = (
        'TChart')
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = 11119017
      BottomAxis.LabelsFormat.Font.Name = 'Verdana'
      BottomAxis.TicksInner.Color = 11119017
      BottomAxis.Title.Font.Name = 'Verdana'
      DepthAxis.Axis.Color = 4210752
      DepthAxis.Grid.Color = 11119017
      DepthAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthAxis.TicksInner.Color = 11119017
      DepthAxis.Title.Font.Name = 'Verdana'
      DepthTopAxis.Axis.Color = 4210752
      DepthTopAxis.Grid.Color = 11119017
      DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthTopAxis.TicksInner.Color = 11119017
      DepthTopAxis.Title.Font.Name = 'Verdana'
      LeftAxis.Axis.Color = 4210752
      LeftAxis.Grid.Color = 11119017
      LeftAxis.LabelsFormat.Font.Name = 'Verdana'
      LeftAxis.TicksInner.Color = 11119017
      LeftAxis.Title.Font.Name = 'Verdana'
      RightAxis.Axis.Color = 4210752
      RightAxis.Grid.Color = 11119017
      RightAxis.LabelsFormat.Font.Name = 'Verdana'
      RightAxis.TicksInner.Color = 11119017
      RightAxis.Title.Font.Name = 'Verdana'
      TopAxis.Axis.Color = 4210752
      TopAxis.Grid.Color = 11119017
      TopAxis.LabelsFormat.Font.Name = 'Verdana'
      TopAxis.TicksInner.Color = 11119017
      TopAxis.Title.Font.Name = 'Verdana'
      TabOrder = 2
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
    end
    object Chart4: TChart
      Tag = 4
      Left = 464
      Top = 42
      Width = 353
      Height = 281
      BackWall.Brush.Gradient.Direction = gdBottomTop
      BackWall.Brush.Gradient.EndColor = clWhite
      BackWall.Brush.Gradient.StartColor = 15395562
      BackWall.Brush.Gradient.Visible = True
      BackWall.Transparent = False
      Foot.Font.Color = clBlue
      Foot.Font.Name = 'Verdana'
      Gradient.Direction = gdBottomTop
      Gradient.EndColor = clWhite
      Gradient.MidColor = 15395562
      Gradient.StartColor = 15395562
      Gradient.Visible = True
      LeftWall.Color = 14745599
      Legend.Font.Name = 'Verdana'
      Legend.Shadow.Transparency = 0
      RightWall.Color = 14745599
      Title.Font.Name = 'Verdana'
      Title.Text.Strings = (
        'TChart')
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = 11119017
      BottomAxis.LabelsFormat.Font.Name = 'Verdana'
      BottomAxis.TicksInner.Color = 11119017
      BottomAxis.Title.Font.Name = 'Verdana'
      DepthAxis.Axis.Color = 4210752
      DepthAxis.Grid.Color = 11119017
      DepthAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthAxis.TicksInner.Color = 11119017
      DepthAxis.Title.Font.Name = 'Verdana'
      DepthTopAxis.Axis.Color = 4210752
      DepthTopAxis.Grid.Color = 11119017
      DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthTopAxis.TicksInner.Color = 11119017
      DepthTopAxis.Title.Font.Name = 'Verdana'
      LeftAxis.Axis.Color = 4210752
      LeftAxis.Grid.Color = 11119017
      LeftAxis.LabelsFormat.Font.Name = 'Verdana'
      LeftAxis.TicksInner.Color = 11119017
      LeftAxis.Title.Font.Name = 'Verdana'
      RightAxis.Axis.Color = 4210752
      RightAxis.Grid.Color = 11119017
      RightAxis.LabelsFormat.Font.Name = 'Verdana'
      RightAxis.TicksInner.Color = 11119017
      RightAxis.Title.Font.Name = 'Verdana'
      TopAxis.Axis.Color = 4210752
      TopAxis.Grid.Color = 11119017
      TopAxis.LabelsFormat.Font.Name = 'Verdana'
      TopAxis.TicksInner.Color = 11119017
      TopAxis.Title.Font.Name = 'Verdana'
      TabOrder = 3
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
    end
    object Chart5: TChart
      Tag = 5
      Left = 464
      Top = 72
      Width = 353
      Height = 281
      BackWall.Brush.Gradient.Direction = gdBottomTop
      BackWall.Brush.Gradient.EndColor = clWhite
      BackWall.Brush.Gradient.StartColor = 15395562
      BackWall.Brush.Gradient.Visible = True
      BackWall.Transparent = False
      Foot.Font.Color = clBlue
      Foot.Font.Name = 'Verdana'
      Gradient.Direction = gdBottomTop
      Gradient.EndColor = clWhite
      Gradient.MidColor = 15395562
      Gradient.StartColor = 15395562
      Gradient.Visible = True
      LeftWall.Color = 14745599
      Legend.Font.Name = 'Verdana'
      Legend.Shadow.Transparency = 0
      RightWall.Color = 14745599
      Title.Font.Name = 'Verdana'
      Title.Text.Strings = (
        'TChart')
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = 11119017
      BottomAxis.LabelsFormat.Font.Name = 'Verdana'
      BottomAxis.TicksInner.Color = 11119017
      BottomAxis.Title.Font.Name = 'Verdana'
      DepthAxis.Axis.Color = 4210752
      DepthAxis.Grid.Color = 11119017
      DepthAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthAxis.TicksInner.Color = 11119017
      DepthAxis.Title.Font.Name = 'Verdana'
      DepthTopAxis.Axis.Color = 4210752
      DepthTopAxis.Grid.Color = 11119017
      DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthTopAxis.TicksInner.Color = 11119017
      DepthTopAxis.Title.Font.Name = 'Verdana'
      LeftAxis.Axis.Color = 4210752
      LeftAxis.Grid.Color = 11119017
      LeftAxis.LabelsFormat.Font.Name = 'Verdana'
      LeftAxis.TicksInner.Color = 11119017
      LeftAxis.Title.Font.Name = 'Verdana'
      RightAxis.Axis.Color = 4210752
      RightAxis.Grid.Color = 11119017
      RightAxis.LabelsFormat.Font.Name = 'Verdana'
      RightAxis.TicksInner.Color = 11119017
      RightAxis.Title.Font.Name = 'Verdana'
      TopAxis.Axis.Color = 4210752
      TopAxis.Grid.Color = 11119017
      TopAxis.LabelsFormat.Font.Name = 'Verdana'
      TopAxis.TicksInner.Color = 11119017
      TopAxis.Title.Font.Name = 'Verdana'
      TabOrder = 4
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
    end
    object Chart6: TChart
      Tag = 6
      Left = 464
      Top = 136
      Width = 353
      Height = 281
      BackWall.Brush.Gradient.Direction = gdBottomTop
      BackWall.Brush.Gradient.EndColor = clWhite
      BackWall.Brush.Gradient.StartColor = 15395562
      BackWall.Brush.Gradient.Visible = True
      BackWall.Transparent = False
      Foot.Font.Color = clBlue
      Foot.Font.Name = 'Verdana'
      Gradient.Direction = gdBottomTop
      Gradient.EndColor = clWhite
      Gradient.MidColor = 15395562
      Gradient.StartColor = 15395562
      Gradient.Visible = True
      LeftWall.Color = 14745599
      Legend.Font.Name = 'Verdana'
      Legend.Shadow.Transparency = 0
      RightWall.Color = 14745599
      Title.Font.Name = 'Verdana'
      Title.Text.Strings = (
        'TChart')
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = 11119017
      BottomAxis.LabelsFormat.Font.Name = 'Verdana'
      BottomAxis.TicksInner.Color = 11119017
      BottomAxis.Title.Font.Name = 'Verdana'
      DepthAxis.Axis.Color = 4210752
      DepthAxis.Grid.Color = 11119017
      DepthAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthAxis.TicksInner.Color = 11119017
      DepthAxis.Title.Font.Name = 'Verdana'
      DepthTopAxis.Axis.Color = 4210752
      DepthTopAxis.Grid.Color = 11119017
      DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthTopAxis.TicksInner.Color = 11119017
      DepthTopAxis.Title.Font.Name = 'Verdana'
      LeftAxis.Axis.Color = 4210752
      LeftAxis.Grid.Color = 11119017
      LeftAxis.LabelsFormat.Font.Name = 'Verdana'
      LeftAxis.TicksInner.Color = 11119017
      LeftAxis.Title.Font.Name = 'Verdana'
      RightAxis.Axis.Color = 4210752
      RightAxis.Grid.Color = 11119017
      RightAxis.LabelsFormat.Font.Name = 'Verdana'
      RightAxis.TicksInner.Color = 11119017
      RightAxis.Title.Font.Name = 'Verdana'
      TopAxis.Axis.Color = 4210752
      TopAxis.Grid.Color = 11119017
      TopAxis.LabelsFormat.Font.Name = 'Verdana'
      TopAxis.TicksInner.Color = 11119017
      TopAxis.Title.Font.Name = 'Verdana'
      TabOrder = 5
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
    end
    object Chart7: TChart
      Tag = 7
      Left = 40
      Top = 249
      Width = 353
      Height = 281
      BackWall.Brush.Gradient.Direction = gdBottomTop
      BackWall.Brush.Gradient.EndColor = clWhite
      BackWall.Brush.Gradient.StartColor = 15395562
      BackWall.Brush.Gradient.Visible = True
      BackWall.Transparent = False
      Foot.Font.Color = clBlue
      Foot.Font.Name = 'Verdana'
      Gradient.Direction = gdBottomTop
      Gradient.EndColor = clWhite
      Gradient.MidColor = 15395562
      Gradient.StartColor = 15395562
      Gradient.Visible = True
      LeftWall.Color = 14745599
      Legend.Font.Name = 'Verdana'
      Legend.Shadow.Transparency = 0
      RightWall.Color = 14745599
      Title.Font.Name = 'Verdana'
      Title.Text.Strings = (
        'TChart')
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = 11119017
      BottomAxis.LabelsFormat.Font.Name = 'Verdana'
      BottomAxis.TicksInner.Color = 11119017
      BottomAxis.Title.Font.Name = 'Verdana'
      DepthAxis.Axis.Color = 4210752
      DepthAxis.Grid.Color = 11119017
      DepthAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthAxis.TicksInner.Color = 11119017
      DepthAxis.Title.Font.Name = 'Verdana'
      DepthTopAxis.Axis.Color = 4210752
      DepthTopAxis.Grid.Color = 11119017
      DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthTopAxis.TicksInner.Color = 11119017
      DepthTopAxis.Title.Font.Name = 'Verdana'
      LeftAxis.Axis.Color = 4210752
      LeftAxis.Grid.Color = 11119017
      LeftAxis.LabelsFormat.Font.Name = 'Verdana'
      LeftAxis.TicksInner.Color = 11119017
      LeftAxis.Title.Font.Name = 'Verdana'
      RightAxis.Axis.Color = 4210752
      RightAxis.Grid.Color = 11119017
      RightAxis.LabelsFormat.Font.Name = 'Verdana'
      RightAxis.TicksInner.Color = 11119017
      RightAxis.Title.Font.Name = 'Verdana'
      TopAxis.Axis.Color = 4210752
      TopAxis.Grid.Color = 11119017
      TopAxis.LabelsFormat.Font.Name = 'Verdana'
      TopAxis.TicksInner.Color = 11119017
      TopAxis.Title.Font.Name = 'Verdana'
      TabOrder = 6
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
    end
    object Chart8: TChart
      Tag = 8
      Left = 87
      Top = 280
      Width = 353
      Height = 281
      BackWall.Brush.Gradient.Direction = gdBottomTop
      BackWall.Brush.Gradient.EndColor = clWhite
      BackWall.Brush.Gradient.StartColor = 15395562
      BackWall.Brush.Gradient.Visible = True
      BackWall.Transparent = False
      Foot.Font.Color = clBlue
      Foot.Font.Name = 'Verdana'
      Gradient.Direction = gdBottomTop
      Gradient.EndColor = clWhite
      Gradient.MidColor = 15395562
      Gradient.StartColor = 15395562
      Gradient.Visible = True
      LeftWall.Color = 14745599
      Legend.Font.Name = 'Verdana'
      Legend.Shadow.Transparency = 0
      RightWall.Color = 14745599
      Title.Font.Name = 'Verdana'
      Title.Text.Strings = (
        'TChart')
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = 11119017
      BottomAxis.LabelsFormat.Font.Name = 'Verdana'
      BottomAxis.TicksInner.Color = 11119017
      BottomAxis.Title.Font.Name = 'Verdana'
      DepthAxis.Axis.Color = 4210752
      DepthAxis.Grid.Color = 11119017
      DepthAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthAxis.TicksInner.Color = 11119017
      DepthAxis.Title.Font.Name = 'Verdana'
      DepthTopAxis.Axis.Color = 4210752
      DepthTopAxis.Grid.Color = 11119017
      DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthTopAxis.TicksInner.Color = 11119017
      DepthTopAxis.Title.Font.Name = 'Verdana'
      LeftAxis.Axis.Color = 4210752
      LeftAxis.Grid.Color = 11119017
      LeftAxis.LabelsFormat.Font.Name = 'Verdana'
      LeftAxis.TicksInner.Color = 11119017
      LeftAxis.Title.Font.Name = 'Verdana'
      RightAxis.Axis.Color = 4210752
      RightAxis.Grid.Color = 11119017
      RightAxis.LabelsFormat.Font.Name = 'Verdana'
      RightAxis.TicksInner.Color = 11119017
      RightAxis.Title.Font.Name = 'Verdana'
      TopAxis.Axis.Color = 4210752
      TopAxis.Grid.Color = 11119017
      TopAxis.LabelsFormat.Font.Name = 'Verdana'
      TopAxis.TicksInner.Color = 11119017
      TopAxis.Title.Font.Name = 'Verdana'
      TabOrder = 7
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
    end
    object Chart9: TChart
      Tag = 9
      Left = 152
      Top = 280
      Width = 353
      Height = 281
      BackWall.Brush.Gradient.Direction = gdBottomTop
      BackWall.Brush.Gradient.EndColor = clWhite
      BackWall.Brush.Gradient.StartColor = 15395562
      BackWall.Brush.Gradient.Visible = True
      BackWall.Transparent = False
      Foot.Font.Color = clBlue
      Foot.Font.Name = 'Verdana'
      Gradient.Direction = gdBottomTop
      Gradient.EndColor = clWhite
      Gradient.MidColor = 15395562
      Gradient.StartColor = 15395562
      Gradient.Visible = True
      LeftWall.Color = 14745599
      Legend.Font.Name = 'Verdana'
      Legend.Shadow.Transparency = 0
      RightWall.Color = 14745599
      Title.Font.Name = 'Verdana'
      Title.Text.Strings = (
        'TChart')
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = 11119017
      BottomAxis.LabelsFormat.Font.Name = 'Verdana'
      BottomAxis.TicksInner.Color = 11119017
      BottomAxis.Title.Font.Name = 'Verdana'
      DepthAxis.Axis.Color = 4210752
      DepthAxis.Grid.Color = 11119017
      DepthAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthAxis.TicksInner.Color = 11119017
      DepthAxis.Title.Font.Name = 'Verdana'
      DepthTopAxis.Axis.Color = 4210752
      DepthTopAxis.Grid.Color = 11119017
      DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthTopAxis.TicksInner.Color = 11119017
      DepthTopAxis.Title.Font.Name = 'Verdana'
      LeftAxis.Axis.Color = 4210752
      LeftAxis.Grid.Color = 11119017
      LeftAxis.LabelsFormat.Font.Name = 'Verdana'
      LeftAxis.TicksInner.Color = 11119017
      LeftAxis.Title.Font.Name = 'Verdana'
      RightAxis.Axis.Color = 4210752
      RightAxis.Grid.Color = 11119017
      RightAxis.LabelsFormat.Font.Name = 'Verdana'
      RightAxis.TicksInner.Color = 11119017
      RightAxis.Title.Font.Name = 'Verdana'
      TopAxis.Axis.Color = 4210752
      TopAxis.Grid.Color = 11119017
      TopAxis.LabelsFormat.Font.Name = 'Verdana'
      TopAxis.TicksInner.Color = 11119017
      TopAxis.Title.Font.Name = 'Verdana'
      TabOrder = 8
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
    end
    object Chart10: TChart
      Tag = 10
      Left = 464
      Top = 235
      Width = 353
      Height = 281
      BackWall.Brush.Gradient.Direction = gdBottomTop
      BackWall.Brush.Gradient.EndColor = clWhite
      BackWall.Brush.Gradient.StartColor = 15395562
      BackWall.Brush.Gradient.Visible = True
      BackWall.Transparent = False
      Foot.Font.Color = clBlue
      Foot.Font.Name = 'Verdana'
      Gradient.Direction = gdBottomTop
      Gradient.EndColor = clWhite
      Gradient.MidColor = 15395562
      Gradient.StartColor = 15395562
      Gradient.Visible = True
      LeftWall.Color = 14745599
      Legend.Font.Name = 'Verdana'
      Legend.Shadow.Transparency = 0
      RightWall.Color = 14745599
      Title.Font.Name = 'Verdana'
      Title.Text.Strings = (
        'TChart')
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = 11119017
      BottomAxis.LabelsFormat.Font.Name = 'Verdana'
      BottomAxis.TicksInner.Color = 11119017
      BottomAxis.Title.Font.Name = 'Verdana'
      DepthAxis.Axis.Color = 4210752
      DepthAxis.Grid.Color = 11119017
      DepthAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthAxis.TicksInner.Color = 11119017
      DepthAxis.Title.Font.Name = 'Verdana'
      DepthTopAxis.Axis.Color = 4210752
      DepthTopAxis.Grid.Color = 11119017
      DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthTopAxis.TicksInner.Color = 11119017
      DepthTopAxis.Title.Font.Name = 'Verdana'
      LeftAxis.Axis.Color = 4210752
      LeftAxis.Grid.Color = 11119017
      LeftAxis.LabelsFormat.Font.Name = 'Verdana'
      LeftAxis.TicksInner.Color = 11119017
      LeftAxis.Title.Font.Name = 'Verdana'
      RightAxis.Axis.Color = 4210752
      RightAxis.Grid.Color = 11119017
      RightAxis.LabelsFormat.Font.Name = 'Verdana'
      RightAxis.TicksInner.Color = 11119017
      RightAxis.Title.Font.Name = 'Verdana'
      TopAxis.Axis.Color = 4210752
      TopAxis.Grid.Color = 11119017
      TopAxis.LabelsFormat.Font.Name = 'Verdana'
      TopAxis.TicksInner.Color = 11119017
      TopAxis.Title.Font.Name = 'Verdana'
      TabOrder = 9
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
    end
    object Chart11: TChart
      Tag = 11
      Left = 464
      Top = 265
      Width = 353
      Height = 281
      BackWall.Brush.Gradient.Direction = gdBottomTop
      BackWall.Brush.Gradient.EndColor = clWhite
      BackWall.Brush.Gradient.StartColor = 15395562
      BackWall.Brush.Gradient.Visible = True
      BackWall.Transparent = False
      Foot.Font.Color = clBlue
      Foot.Font.Name = 'Verdana'
      Gradient.Direction = gdBottomTop
      Gradient.EndColor = clWhite
      Gradient.MidColor = 15395562
      Gradient.StartColor = 15395562
      Gradient.Visible = True
      LeftWall.Color = 14745599
      Legend.Font.Name = 'Verdana'
      Legend.Shadow.Transparency = 0
      RightWall.Color = 14745599
      Title.Font.Name = 'Verdana'
      Title.Text.Strings = (
        'TChart')
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = 11119017
      BottomAxis.LabelsFormat.Font.Name = 'Verdana'
      BottomAxis.TicksInner.Color = 11119017
      BottomAxis.Title.Font.Name = 'Verdana'
      DepthAxis.Axis.Color = 4210752
      DepthAxis.Grid.Color = 11119017
      DepthAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthAxis.TicksInner.Color = 11119017
      DepthAxis.Title.Font.Name = 'Verdana'
      DepthTopAxis.Axis.Color = 4210752
      DepthTopAxis.Grid.Color = 11119017
      DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthTopAxis.TicksInner.Color = 11119017
      DepthTopAxis.Title.Font.Name = 'Verdana'
      LeftAxis.Axis.Color = 4210752
      LeftAxis.Grid.Color = 11119017
      LeftAxis.LabelsFormat.Font.Name = 'Verdana'
      LeftAxis.TicksInner.Color = 11119017
      LeftAxis.Title.Font.Name = 'Verdana'
      RightAxis.Axis.Color = 4210752
      RightAxis.Grid.Color = 11119017
      RightAxis.LabelsFormat.Font.Name = 'Verdana'
      RightAxis.TicksInner.Color = 11119017
      RightAxis.Title.Font.Name = 'Verdana'
      TopAxis.Axis.Color = 4210752
      TopAxis.Grid.Color = 11119017
      TopAxis.LabelsFormat.Font.Name = 'Verdana'
      TopAxis.TicksInner.Color = 11119017
      TopAxis.Title.Font.Name = 'Verdana'
      TabOrder = 10
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
    end
    object Chart12: TChart
      Tag = 12
      Left = 464
      Top = 280
      Width = 353
      Height = 281
      BackWall.Brush.Gradient.Direction = gdBottomTop
      BackWall.Brush.Gradient.EndColor = clWhite
      BackWall.Brush.Gradient.StartColor = 15395562
      BackWall.Brush.Gradient.Visible = True
      BackWall.Transparent = False
      Foot.Font.Color = clBlue
      Foot.Font.Name = 'Verdana'
      Gradient.Direction = gdBottomTop
      Gradient.EndColor = clWhite
      Gradient.MidColor = 15395562
      Gradient.StartColor = 15395562
      Gradient.Visible = True
      LeftWall.Color = 14745599
      Legend.Font.Name = 'Verdana'
      Legend.Shadow.Transparency = 0
      RightWall.Color = 14745599
      Title.Font.Name = 'Verdana'
      Title.Text.Strings = (
        'TChart')
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = 11119017
      BottomAxis.LabelsFormat.Font.Name = 'Verdana'
      BottomAxis.TicksInner.Color = 11119017
      BottomAxis.Title.Font.Name = 'Verdana'
      DepthAxis.Axis.Color = 4210752
      DepthAxis.Grid.Color = 11119017
      DepthAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthAxis.TicksInner.Color = 11119017
      DepthAxis.Title.Font.Name = 'Verdana'
      DepthTopAxis.Axis.Color = 4210752
      DepthTopAxis.Grid.Color = 11119017
      DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthTopAxis.TicksInner.Color = 11119017
      DepthTopAxis.Title.Font.Name = 'Verdana'
      LeftAxis.Axis.Color = 4210752
      LeftAxis.Grid.Color = 11119017
      LeftAxis.LabelsFormat.Font.Name = 'Verdana'
      LeftAxis.TicksInner.Color = 11119017
      LeftAxis.Title.Font.Name = 'Verdana'
      RightAxis.Axis.Color = 4210752
      RightAxis.Grid.Color = 11119017
      RightAxis.LabelsFormat.Font.Name = 'Verdana'
      RightAxis.TicksInner.Color = 11119017
      RightAxis.Title.Font.Name = 'Verdana'
      TopAxis.Axis.Color = 4210752
      TopAxis.Grid.Color = 11119017
      TopAxis.LabelsFormat.Font.Name = 'Verdana'
      TopAxis.TicksInner.Color = 11119017
      TopAxis.Title.Font.Name = 'Verdana'
      TabOrder = 11
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
    end
    object Chart13: TChart
      Tag = 13
      Left = 296
      Top = 280
      Width = 353
      Height = 281
      BackWall.Brush.Gradient.Direction = gdBottomTop
      BackWall.Brush.Gradient.EndColor = clWhite
      BackWall.Brush.Gradient.StartColor = 15395562
      BackWall.Brush.Gradient.Visible = True
      BackWall.Transparent = False
      Foot.Font.Color = clBlue
      Foot.Font.Name = 'Verdana'
      Gradient.Direction = gdBottomTop
      Gradient.EndColor = clWhite
      Gradient.MidColor = 15395562
      Gradient.StartColor = 15395562
      Gradient.Visible = True
      LeftWall.Color = 14745599
      Legend.Font.Name = 'Verdana'
      Legend.Shadow.Transparency = 0
      RightWall.Color = 14745599
      Title.Font.Name = 'Verdana'
      Title.Text.Strings = (
        'TChart')
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = 11119017
      BottomAxis.LabelsFormat.Font.Name = 'Verdana'
      BottomAxis.TicksInner.Color = 11119017
      BottomAxis.Title.Font.Name = 'Verdana'
      DepthAxis.Axis.Color = 4210752
      DepthAxis.Grid.Color = 11119017
      DepthAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthAxis.TicksInner.Color = 11119017
      DepthAxis.Title.Font.Name = 'Verdana'
      DepthTopAxis.Axis.Color = 4210752
      DepthTopAxis.Grid.Color = 11119017
      DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthTopAxis.TicksInner.Color = 11119017
      DepthTopAxis.Title.Font.Name = 'Verdana'
      LeftAxis.Axis.Color = 4210752
      LeftAxis.Grid.Color = 11119017
      LeftAxis.LabelsFormat.Font.Name = 'Verdana'
      LeftAxis.TicksInner.Color = 11119017
      LeftAxis.Title.Font.Name = 'Verdana'
      RightAxis.Axis.Color = 4210752
      RightAxis.Grid.Color = 11119017
      RightAxis.LabelsFormat.Font.Name = 'Verdana'
      RightAxis.TicksInner.Color = 11119017
      RightAxis.Title.Font.Name = 'Verdana'
      TopAxis.Axis.Color = 4210752
      TopAxis.Grid.Color = 11119017
      TopAxis.LabelsFormat.Font.Name = 'Verdana'
      TopAxis.TicksInner.Color = 11119017
      TopAxis.Title.Font.Name = 'Verdana'
      OnAfterDraw = Chart13AfterDraw
      TabOrder = 12
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
    end
  end
  object ImageList1: TImageList
    BlendColor = clWindow
    BkColor = clSilver
    DrawingStyle = dsTransparent
    Left = 548
    Bitmap = {
      494C01014600E003B00410001000C0C0C000FF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002001000001002000000000000020
      0100000000000000000000000000000000000A588E9F1090E9FF1090E9FF1090
      E9FF1090E9FF1090E9FF1090E9FF1090E9FF1090E9FF1090E9FF1090E9FF1090
      E9FF1090E9FF1090E9FF1090E9FF1090E9FF000000004F6676FF304F65BF0C13
      19480000001E0000001B0000001700000013000000100000000C000000090000
      0006000000030000000100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001395EBFF059CF4FF029BF4FF069C
      F5FF0A9EF5FF0DA0F5FF10A1F5FF13A9F7FF14B4F8FF12A2F6FF10A1F5FF0DA0
      F5FF0A9EF5FF069CF5FF029BF4FF4BB6F6FF00000000416178E7E9F7FDFF8ABE
      DAFF6592B8FF4E7997FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001799ECFF7CCCF9FF0A9EF5FF10A1
      F5FF14A3F6FF19A5F6FF1CA6F7FF23A0C3FF0E1C1DFF21AFF8FF1CA6F7FF19A5
      F6FF14A3F6FF10A1F5FF0C9FF5FF7EC7F5FF000000000E161D33E3F2F8FFBAE0
      EEFF84B4D4FF327CAFFF0034578C000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000D4A70783BABF0FF1AA5F6FF1BA6
      F7FF21A9F7FF27ABF8FF2BADF8FF309DD7FF293439FF2FAFF8FF2BADF8FF27AB
      F8FF21A9F7FF1BA6F7FF6FC7F9FF1C9EEEFF00000000000000008EADC1FFE3F5
      FCFF4C94BAFF41ACE6FF1F89D0FF0034578C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000020A2F0FFB1E0FCFF28AB
      F8FF30AFF9FF36B1F9FF3BB4FAFF45BDFBFF51CBFBFF3EB5FAFF3BB4FAFF36B1
      F9FF30AFF9FF2BACF8FF52B7F4FF125B88900000000000000000284254964773
      91FF5DC9F9FF5ECBFAFF4EB5EAFF1F89D0FF0034578C00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000071D2B2D28A8F1FF45B7
      F9FF3EB5FAFF46B8FBFF4CBAFBFF63CDFCFF22373CFF4FBCFBFF4CBAFBFF46B8
      FBFF3EB5FAFFB0E1FDFF25A7F1FF000000000000000000000000000000000773
      BBFF319BE2FF67D0F9FF65D0FAFF5ABDEDFF1F89D0FF0034578C000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002498D6E1ABDF
      FBFF4EBBFBFF55BFFCFF5CC1FCFF78D0F8FF222B2DFF60C3FDFF5CC1FCFF55BF
      FCFF57BFFBFF33B0F4FF0C33474B000000000000000000000000000000000000
      00000772BAFF319CE2FF70D6FBFF6CD5FBFF64C4EFFF1F89D0FF0034578C0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002DB1
      F5FF7DCFFDFF64C5FDFF6BC8FEFF84C3E3FF1F2223FF6FCAFEFF6BC8FEFF64C5
      FDFFBCE7FCFF2DB1F5FF00000000000000000000000000000000000000000000
      0000000000000773BBFF329CE2FF7BDBFDFF74D9FDFF71CAF1FF1F89D0FF0034
      578C000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000237E
      ABB18AD6FAFF72CBFEFF78CEFFFF92BDD7FF1C1C1CFF7FD1FFFF78CEFFFF87D3
      FEFF32B5F6FF0000000000000000000000000000000000000000000000000000
      000000000000000000000773BBFF339DE3FF87E0FDFF7DDEFDFF7CD0F2FF1F89
      D0FF0034578C0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000036B9F8FFB5E4FFFF88D4FFFF94B2C3FF232323FF98DAFFFF88D4FFFF99DC
      FCFF2889B8BD0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000773BBFF339DE3FF90E5FEFF84E3FEFF82D3
      F1FF1F89D0FF20435DBB00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001D607E815ECAFAFFA0DDFFFF90A7B3FF292929FFB1E3FFFFC0E8FFFF3ABD
      F9FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000773BBFF349EE3FF96E9FDFF8CE8
      FEFF5F5F5FFF7A7A7AFF2C2E3386000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003DC1FBFFDDF3FFFFC2E9FFFFCCEDFFFFC3E9FFFF75D4FCFF2574
      9799000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000773BBFF37A0E4FF6868
      68FFBABABAFF959595FF929292FF00030D150000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000F2E3B3C45C7FCFFCFEEFFFFDCF2FFFFE8F7FFFF41C5FCFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000336789FFBBBB
      BBFFFFFFFFFFC3C3C3FF2A3A8FFF002AA4FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003DB8E8EACEF0FFFFDDF3FFFF50CDFDFF1847595A0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006262
      62FFC7C7C7FF8391AFFF3E6DF1FF002AA1FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000046CCFEFF4FCEFEFF41BEECED000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000F205195063AC0FF0330AAFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000040B0D0D00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C0006060B4FF5E5EB1FFC0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      00030000000A4E240077B65A08FFBD6516FFBF681AFFBC6517FF894000C70603
      0017000000050000000300000000000000000000000000000000000000FF0000
      00FF000000FF7B391BFF7B391BFF7B391BFF7B391BFF7B391BFF7B391BFF7B39
      1BFF7B391BFF7B391BFF7B391BFF00000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0006363CBFF0B0BA8FF0C0CA4FF02029EFF02029EFF0C0CA4FF0B0BA9FF6363
      CBFFC0C0C000C0C0C000C0C0C000C0C0C000000000000000000000000000391B
      0051BD671AFFBD5A03FFBC5800FFBD5901FFBD5901FFBC5800FFBC5800FFC064
      13FF833D00BA0000000000000000000000000000000000000000060606FF0000
      00FF060606FF9E5736FF9E5736FF9E5736FF9E5736FF9E5736FF9E5736FF9E57
      36FF9E5736FF9E5736FFBD8D76FF00000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0002C2C
      B7FF0808A4FF0000A4FF0000A6FF0000A8FF0000A8FF0000A7FF0000A5FF0808
      A5FF2C2CB7FFC0C0C000C0C0C000C0C0C00000000000000000004A230069C46E
      22FFBF5B03FFC05D04FFC15E05FFC25F05FFC25F05FFC15E05FFC05D04FFBF5B
      03FFBE5C05FFB75C0CFF00000000000000000000000000000000080808FF0000
      00FF080808FF9E5736FF9E5736FF9E5736FF9F5838FF9F5938FFA05939FF9F59
      38FF9F5838FF9E5736FFBD8D76FFEDEDEDFFC0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0003232BAFF0404
      A8FF0000ACFF3333BFFF0000B4FF0000B5FF0000B6FF0A0AB8FF5050C9FF0000
      AEFF0404ABFF3232BBFFC0C0C000C0C0C0000000000000000000C97B35FFC25F
      05FFC56207FFC86409FFC9660AFFFFFFFFFFFFFFFFFFFFFFFFFFC86409FFC562
      07FFC25F05FFC1620CFF763700A80000000000000000000000000A0A0AFF0000
      00FF0A0A0AFF9F5838FFA15B3AFFA35D3CFFA55F3EFFA7603FFFA7603FFFA760
      3FFFA55F3EFFA35D3CFFBF8F79FFF4F4F4FFC0C0C000E7D7AD00E7D7CE00DEA6
      4200EFCF6B00FFF7EF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C0006060CCFF1010B1FF0000
      B3FF6161D3FFFBFBFEFF7979DEFF0000C5FF0C0CC8FFB6B6EEFFFEFEFEFF7070
      D9FF0000B6FF1010B4FF6060CCFFC0C0C000000000008D4200C9C7660DFFC966
      0AFFCD6A0CFFCF6D0EFFD16F10FFFFFFFFFFFFFFFFFFFFFFFFFFCF6D0EFFCD6A
      0CFFC9660AFFC56207FFCD823EFF0000000000000000000000000C0C0CFF0000
      00FF0C0C0CFFA55E3DFFA86140FFAB6443FFAD6646FFC38D75FFBE846AFFAF67
      47FFAD6646FFAB6443FFC4937DFFFCFCFCFFE7CFA500B57100006B491000C679
      0000E79E0000E7A61800F7E7BD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C0002828BCFF0000B7FF4848
      D1FFFCFCFEFFFFFFFFFFFFFFFFFF7B7BE8FFB3B3F2FFFFFFFFFFFFFFFFFFFEFE
      FEFF3C3CD1FF0000BCFF2828BDFFC0C0C00000000000CE8542FFCC6A0CFFD16F
      0FFFD57312FFD87714FFDA7916FFFFFFFFFFFFFFFFFFFFFFFFFFD87714FFD573
      12FFD16F0FFFCC6A0CFFCB6E17FF6E33009C00000000000000000F0F0FFF0000
      00FF0F0F0FFFAC6444FFB06848FFB97557FFDBB6A6FFB97151FFB97251FFB971
      51FFB76F4FFFB46C4CFFCA9883FF00000000E7C79C00C67900007B590000BD71
      0000E79E0000DE960000EFCF8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C0002B2BC5FF0000C3FF0C0C
      D0FFBABAF4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7A
      ECFF0000D2FF0000C9FF2B2BC9FFC0C0C0000D060012DD9856FFD37111FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFD37111FFCE6B0DFFB75C0BFF0000000000000000111111FF0000
      00FF111111FFB36C4BFFB97151FFF7EEEAFFD4A38DFFD7A48EFFF8EFEBFFC37B
      5BFFD8AB97FFBD7655FFD09E89FFEDEDEDFFF7E7CE00CE860000AD790000AD69
      0000DE9E0000DE960000EFC76300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007979D5FF2828CDFF0000CFFF0000
      DAFF0B0BE4FFB8B8F9FFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFFFF7878F5FF0000
      E6FF0000DFFF0000D5FF2727D2FF7A7AD7FF2A14003CE19C57FFDA7916FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFDA7916FFD47211FFC37127FF0000000000000000131313FF0000
      00FF131313FFBA7453FFC17A59FFE3BEAEFFF2E0D8FFCD8564FFE6C2B1FFCD85
      64FFF2E0D8FFC77F5FFFD6A48EFFF4F4F4FFFFFFFF00D69E3100D68E0000AD71
      0000D6960000DE9E0000E7AE2900FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007A7AD8FF2E2ED7FF0000DAFF0000
      E5FF0A0AEEFFB2B2FBFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFFFF7777F9FF0000
      F1FF0000E9FF0000E0FF2E2EDCFF7C7CD9FF180B0021E8AD6FFFE0811CFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFE0811CFFDC7F1FFFC46C1CFF0000000000000000151515FF0000
      00FF151515FFC37B5BFFCA8262FFF6E9E3FFE1B09AFFDEA489FFF0D6C9FFD68F
      6EFFECCDBEFFD08867FFDBAA94FFFCFCFCFFFFFFFF00E7C78C00D68E0000CE8E
      0000CE8E0000DE9E0000DE9E0000E7CF9C00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C0004D4DE2FF0000E3FF0A0A
      EEFFB7B7FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7979
      FAFF0000F1FF0000E8FF4D4DE7FFC0C0C00000000000E4AA70FFE68924FFEC91
      2AFFF09833FFF49E3BFFF6A546FFFFFFFFFFFFFFFFFFFFFFFFFFF49E3BFFF098
      33FFEC912AFFE68822FFE79E52FF8B480AB40000000000000000171717FF0000
      00FF171717FFCA8262FFD28969FFE1AC93FFE2A88FFFDD9778FFDE9879FFF2D8
      CDFFDB9475FFD7906FFFE0AF99FF00000000FFFFFF00FFF7EF00DE9E2100DE96
      0000D6960000DE9E0000DE9E0000CE9E2100C6BEBD00DEDFDE00E7E7E700E7E7
      E700E7E7E700DED7CE00DEB65A00F7E7BD00C0C0C0005E5EE2FF0C0CEAFF6C6C
      F7FFFFFFFFFFFFFFFFFFFEFEFFFFA8A8FFFFD1D1FFFFFFFFFFFFFFFFFFFFFFFF
      FFFF6767FAFF0C0CF0FF6060E6FFC0C0C00000000000D0731BFFEFA95AFFF097
      32FFF4A03DFFF8AC51FFFBB765FFFFFFFFFFFFFFFFFFFFFFFFFFF8AC51FFF4A0
      3DFFF09732FFEA902AFFF0C18EFF0C06010F00000000000000001A1A1AFF0000
      00FF1A1A1AFFD08867FFD7906FFFDC9677FFE5A487FFF9E9E1FFF7DFD4FFE8A5
      87FFE39E7FFFDC9677FFE4B39DFFEDEDEDFFFFFFFF00FFFFFF00F7DFAD00DE9E
      0000DE960000DE9E0000E7A60000DE960000DEB66300CECFD600C6C7C600BDBE
      C600C6AE8C00CE962900C6790000EFCF9400C0C0C0007575E2FF5050F3FF0909
      F7FFB2B2FEFFFEFEFFFFB1B1FFFF7A7AFFFF8787FFFFDBDBFFFFFFFFFFFFC4C4
      FFFF1818FBFF5050F7FF7878E5FFC0C0C0000000000007040109F5C795FFF4A4
      48FFF8AA4DFFFBBA6BFFFDC888FFFFFFFFFFFFFFFFFFFFFFFFFFFBBA6BFFF8AA
      4DFFF39C38FFF4BA79FFE18224FF0000000000000000000000001C1C1CFF0000
      00FF1C1C1CFFD38C6CFFDB9475FFE39E7FFFECAB8EFFF1B49AFFF3B89EFFF1B4
      9AFFECAB8EFFE39E7FFFE7B6A1FFF4F4F4FFFFFFFF00FFFFFF00FFFFFF00EFD7
      8400DE9E0000DE960000DE9E0000E7A61000DE960000D6AE5A00E7E7E700F7F7
      FF00D6AE6B00C6710000CE860000F7E7C600C0C0C000C0C0C0006A6AECFF4444
      FBFF2929FFFF8E8EFFFF7A7AFFFFA0A0FFFFAAAAFFFF9595FFFFBABAFFFF4242
      FFFF4D4DFEFF6D6DEFFFC0C0C000C0C0C0000000000000000000824C1590FAD6
      ABFFFABC73FFFCC480FFFED5A4FFFEE1BDFFFEE1BDFFFED5A4FFFCC480FFF9B3
      5FFFF8C487FFF4A859FF000000000000000000000000000000001E1E1EFF0000
      00FF1E1E1EFFD68F6EFFDD9778FFE8A587FFF1B49AFFF8C1A8FFFAC5AEFFF8C1
      A8FFF1B49AFFE8A587FFE8B8A3FFFCFCFCFFFFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F7D78C00E7A60800DE960000DEA62100E7BE4A00E7A61800E7B64200F7D7
      9C00CE8E2100C6790000E7C77300FFFFFF00C0C0C000C0C0C000C0C0C0007777
      F4FF7A7AFFFF6767FFFF8383FFFFAAAAFFFFB7B7FFFF9999FFFF7C7CFFFF8888
      FFFF7D7DF6FFC0C0C000C0C0C000C0C0C0000000000000000000000000008552
      1D8AFDD3A3FFFEE1BEFFFEE3C1FFFFEBD4FFFFEAD3FFFEE0BAFFFEDAAFFFFDDF
      BAFFFEAC55FF0000000000000000000000000000000000000000202020FF0000
      00FF202020FFD99676FFE09D80FFEBAC91FFF4BCA3FFFAC9B2FFFFD1BCFFFAC9
      B2FFF4BCA3FFEBAC91FFE9BAA5FF00000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7EFBD00EFBE4200DE9E0000DEA62100EFC76B00E7B65200CE86
      0000CE8E0000EFCF8C00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C0009090F7FFA3A3FDFFB8B8FFFFC2C2FFFFC7C7FFFFC2C2FFFFACACFDFF9797
      F8FFC0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      000000000000CF934ECFFFDAADFFFFEDD9FFFFF1E0FFFFE6CAFFFFCB8CFF6648
      2666000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF7B391BFF7B391BFF7B391BFF7B391BFF7B391BFF7B391BFF7B39
      1BFF7B391BFF7B391BFF7B391BFF00000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFF700F7E7BD00EFCF7300E7BE5200E7BE6300E7BE
      6300F7DFB500FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000BFBFFCFFC0C0FDFFC2C2FDFFC4C4FDFFC0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000BF0000
      00FF000000FF7B391BFF7B391BFF7B391BFF7B391BFF7B391BFF7B391BFF7B39
      1BFF7B391BFF7B391BFF4822109600000000C0C0C000C0C0C000C0C0C000C0C0
      C000F7F7F700D6D7D600B5BEBD00ADBEB500CECFCE00EFEFEF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000DEE7
      DE0073A68C003196630021965A00108E4A00108642004A9E7300B5CFBD00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FF000000FF000000FF000000FF000000FF000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C7C600C6C7C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF00C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000EFEFEF00F7F7F700EFEFEF00F7FFFF00C0C0C000C0C0C000F7F7F700EFEF
      EF00EFF7F700F7F7F700C0C0C000C0C0C000C0C0C000C0C0C000B5DFC60039AE
      73004AB67B004AB684004AB684004AB6840031AE7300089E520000964A0073BE
      9400F7FFFF00C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000F7FFFF00EFF7F700F7F7F700C0C0C000C0C0C000C0C0C000C0C0C000EFF7
      F700EFF7F700F7FFFF00C0C0C000C0C0C000C0C0C000C6E7D60029A66B0042B6
      7B007BC7A500A5D7BD009CD7B50073C79C004AB6840042B6840010A66300009E
      52007BC79C00C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FF000000FF00
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6C7C60000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000FF000000
      FF000000FF0000FFFF0000000000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000CEC7BD00D6CFC600C0C0C000C0C0C000FFFFFF00C0C0C000E7E7
      DE00BDB6AD00F7F7EF00C0C0C000C0C0C000F7FFF70042AE7B006BC79C00F7FF
      F700C0C0C000C0C0C000C0C0C000C0C0C000DEEFE70063BE8C0039BE840000AE
      6B00009E5A00C6E7D600C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF00FF000000FF00
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000840000FFFF000000FF000000FF000000
      FF0000FFFF000086840000000000C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C0009C968C008471630084695A00BDB6AD00C0C0C000C0C0C000E7E7E7007361
      52008C796B008C797300C0C0C000C0C0C000B5DFC60073C79C00C0C0C000F7EF
      E700C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000F7FFF70052BE8C0010BE
      7B0000B66B0063C79400C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C7C60000000000C6C7C60000FF
      FF0000FFFF0000FFFF0000FFFF00008684000000FF000000FF000000FF0000FF
      FF0000FFFF0000000000FFFFFF00C6C7C600C0C0C000C0C0C000DEDFD600C6C7
      BD0073615A00B5A69C00A5968C0084796B00CEC7BD00C6BEB500A59E94006B61
      5200DECFC60073695A00C6BEB500D6D7CE00A5DFBD00E7F7EF00F7EFE700BD61
      2900E7CFB500C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00094D7B50000B6
      730000C7840021B67300D6EFE700C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C7C600FFFFFF000000000000FF
      FF0000FFFF0000FFFF0000FFFF000000FF000000FF000000FF000000FF0000FF
      FF000086840000000000C6C7C600C6C7C600C0C0C000E7DFDE005A4131005238
      2100AD9694006B5142007359520094797B00523018004A301800735952008C71
      6B00524131009C8E7B006B51390063493900DEF7EF00FFFFFF00CE794A00B551
      0800BD693100FFEFEF00C0C0C000C0C0C000C0C0C000E7F7EF0039BE7B0029CF
      9C0010D7940029CF940052C78400F7FFF700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C7C600C6C7C600FFFFFF000000
      000000FFFF00000084000000FF000000FF000000FF000000FF000000000000FF
      FF0000000000C6C7C600C6C7C600C6C7C600C0C0C000D6D7D600423021004220
      08004A38210063514200634942004A30180042281800422810004A3018006B59
      42006B594A005A4939004230100063493900C0C0C000DEA68400C6612100BD61
      1000BD611800D6966300FFFFF700C0C0C000C0C0C000C0C0C000ADE7C60052D7
      A5006BEFCE0042D79400CEEFDE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C7C600C6C7C600C6C7C6000000
      0000C6C7C6000000FF000000FF000000FF000000FF0000FFFF0000FFFF000000
      0000FFFFFF00C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000BDB6AD008471
      5A008C71630084715A0084715A008C7963008C79630084796B005A4931003928
      1000422810004A3018004A28100084716300FFF7F700DEA67B00CE713100C669
      2100C6692100D6966300F7EFE700C0C0C000C0C0C000C0C0C000C0C0C00073D7
      A5006BDFAD0094E7C600C0C0C000F7D7C600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FF000000FF000000FF000000FF000000FFFFFF00FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C7C600C6C7C600C6C7C600FFFF
      FF000000FF000000FF000000FF000000FF0000FFFF0000FFFF00008684000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000F7F7DE00E7B6
      2900E7BE2900E7B63100E7BE2900EFB62900E7B62900F7D78C00A5A69C00B5B6
      AD00C6C7C600C6C7BD006B514A00CEC7BD00C0C0C000C0C0C000DE8E5A00D686
      3900CE692100E7B69400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000E7F7
      EF0084DFB500C0C0C000EFD7BD00EFBEA500FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C7C600C6C7C600C6C7C600C6C7
      C6000000FF000000FF000000FF0000FFFF000000000000FFFF0000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000F7F7EF00E7C7
      6B00E7AE0800E7AE2100E7AE2100E7AE1800E7AE1000F7C76B00BDB6B500C0C0
      C000C0C0C000948E8400AD9E9400C0C0C000C0C0C000C0C0C000EFBE9400DE96
      5200D6864200D6793100F7CFB500C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000F7E7D600E78E5200F7E7D600FFFF0000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C7C600C6C7C600C6C7C6000000
      FF000000FF000000FF00C6C7C60000FFFF0000FFFF0000000000FFFFFF00C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000F7EFD600E7D7
      A500EFC75A00E7AE1800E7AE2100E7AE2100E7A61800F7CF7300ADA6A500B5AE
      A500A59E94009C968C00C0C0C000C0C0C000C0C0C000C0C0C000FFF7EF00E796
      5A00EFAE7300E7965200E7863900EFB68400FFEFDE00FFFFF700FFFFF700FFEF
      E700F7C7A500E7864200EFAE7B00C0C0C000FFFF0000FFFF0000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFF0000FFFF0000C6C7C600C6C7C6000000FF000000
      FF000000FF00FFFFFF000000000000FFFF000086840000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600F7FFF700C0C0C000EFEFBD00DEAE
      1000F7DFB500E7C75200E7AE0800E7AE1800D6A60800EFCF6300E7DFDE00B5B6
      AD00CEC7C600FFFFF700C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFDF
      C600F7A66B00F7BE9400F7B68400EFA66B00EF9E5A00EF9E6300EFA66B00EFA6
      6B00EFA66B00F7A67300FFFFF700C0C0C000FFFF0000FFFF0000FFFF0000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFF0000FFFF0000FFFF0000C6C7C6000000FF000000FF000000
      FF00C6C7C600C6C7C600FFFFFF000000000000000000C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000F7EFD600EFBE
      5200EFC75A00F7E7C600E7CF8400EFBE4A00E7BE4A00EFD79400C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000FFE7D600F7AE7300FFB68400FFCFA500FFCFA500FFCFA500FFC79C00F7AE
      7300F7BE8C00FFFFF700C0C0C000C0C0C00000FFFF0000FFFF00FFFF0000FFFF
      0000FFFFFF00FFFF0000FFFF0000FFFF0000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFF0000FFFF0000FFFF0000FFFF0000C6C7C600C6C7C6000000FF00C6C7
      C600C6C7C600C6C7C600C6C7C600FFFFFF00C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000FFD7BD00FFBE8C00FFB68400FFBE8C00FFC79C00FFE7
      D600C0C0C000C0C0C000C0C0C000C0C0C000FFFF000000FFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFFFF00FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0006B696B00424142004A49
      4A00B5B6B500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C0006361630052515200A5A6A5006B69
      6B0042414200DEDFDE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C00042414200A5A6A500FFFFFF00C0C0
      C00042414200BDBEBD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000000
      000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      00000000000000000000C0C0C000C0C0C0004A494A006B696B00DEDFDE009C9E
      9C0042414200C6C7C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00052515200525152005251
      5200525152005251520052515200525152005251520052515200525152005251
      5200525152005251520052515200C0C0C000C0C0C00000000000000000000000
      840000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      00000000840000008400C0C0C000C0C0C000B5B6B5004A494A00424142004241
      420084868400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000CECFCE00ADAEAD00ADAEAD00ADAE
      AD00ADAEAD00ADAEAD00ADAEAD00ADAEAD00ADAEAD00ADAEAD00ADAEAD00ADAE
      AD00ADAEAD00ADAEAD00ADAEAD00CECFCE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00C6C7C60042414200A5A6
      A500FFFFFF00FFFFFF00C6C7C6007371730073717300C6C7C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000424142005A595A00DEDF
      DE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A5A6A5004A494A004A494A004A49
      4A004A494A004A494A004A494A004A494A004A494A004A494A004A494A004A49
      4A004A494A004A494A004A494A00A5A6A500C6C7C6000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600FFFFFF00FFFFFF0042414200D6D7
      D600FFFFFF00C6C7C60042414200525152005251520042414200C6C7C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004A494A0042414200424142009496
      9400FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEDFDE006B696B0063616300CECF
      CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF004A494A009C9E9C00C6C7C600BDBE
      BD00BDBEBD00BDBEBD00BDBEBD00BDBEBD00BDBEBD00BDBEBD00BDBEBD00BDBE
      BD00BDBEBD00C6C7C6009C9E9C004A494A00C6C7C6000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600FFFFFF00FFFFFF00424142006361
      630073717300525152005A595A00EFEFEF00EFEFEF005A595A00525152007371
      73007B797B00B5B6B500FFFFFF00FFFFFF00636163004241420042414200C0C0
      C000FFFFFF00FFFFFF00FFFFFF00FFFFFF007B797B0042414200424142006361
      6300FFFFFF00FFFFFF00FFFFFF00FFFFFF004A494A00ADAEAD00DEDFDE00D6D7
      D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7
      D600D6D7D600DEDFDE00ADAEAD004A494A00C0C0C0000000000000000000C0C0
      C00000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000C0C0C00000008400C0C0C000C0C0C000FFFFFF00FFFFFF00B5B6B5007B79
      7B0073717300525152005A595A00EFEFEF00EFEFEF005A595A00525152007371
      73006361630042414200FFFFFF00FFFFFF00E7E7E700ADAEAD007B797B005A59
      5A00E7E7E700FFFFFF00FFFFFF00FFFFFF007B797B0042414200424142007371
      7300FFFFFF00FFFFFF00FFFFFF00FFFFFF004A494A00ADAEAD00D6D7D600D6D7
      D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7
      D600D6D7D600D6D7D600ADAEAD004A494A00C0C0C0000000000000000000C0C0
      C00000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000C0C0C00000008400C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C7C60042414200525152005251520042414200C6C7C600FFFF
      FF00D6D7D60042414200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007371
      73006B696B00FFFFFF00FFFFFF00ADAEAD00525152008C8E8C006B696B006361
      6300F7F7F700FFFFFF00FFFFFF00FFFFFF004A494A00ADAEAD00D6D7D600D6D7
      D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7
      D600D6D7D600D6D7D600ADAEAD004A494A00C0C0C0000000000000000000C0C0
      C00000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000C0C0C00000008400C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C6007B797B007B797B00C6C7C600FFFFFF00FFFF
      FF00A5A6A50042414200D6D7D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E7
      E700525152005A595A006B696B0052515200C6C7C600FFFFFF00EFEFEF005251
      52009C9E9C00FFFFFF00FFFFFF00FFFFFF004A494A00ADAEAD00D6D7D600D6D7
      D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7
      D600D6D7D600D6D7D600ADAEAD004A494A00C0C0C0000000000000000000C0C0
      C00000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000C0C0C00000008400C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008486
      840042414200424142004A494A00B5B6B500FFFFFF00FFFFFF00FFFFFF00FFFF
      FF006B696B0042414200424142007B797B00FFFFFF00FFFFFF00FFFFFF00BDBE
      BD0042414200D6D7D600FFFFFF00FFFFFF004A494A00ADAEAD00D6D7D600D6D7
      D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7
      D600D6D7D600D6D7D600ADAEAD004A494A00C0C0C00000000000000000000000
      840000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      00000000840000008400C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECFCE004241
      42009C9E9C00DEDFDE006B696B004A494A00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF006B696B00424142004241420084868400FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848684005A595A00ADAEAD00E7E7E7004A494A00ADAEAD00D6D7D600D6D7
      D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7
      D600D6D7D600D6D7D600ADAEAD004A494A00C0C0C000C0C0C000C0C0C0000000
      000000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BDBEBD004241
      4200C0C0C000FFFFFF00A5A6A50042414200FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00DEDFDE007B797B0084868400EFEFEF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A5A6A5004241420042414200636163004A494A00B5B6B500DEDFDE00DEDF
      DE00DEDFDE00DEDFDE00DEDFDE00DEDFDE00DEDFDE00DEDFDE00DEDFDE00DEDF
      DE00DEDFDE00DEDFDE00B5B6B5004A494A00C0C0C000C0C0C000C0C0C000C0C0
      C0000000FF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000FF00C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEDFDE004241
      42006B696B00A5A6A5005251520063616300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF009496940042414200424142004A494A004A494A008C8E8C00B5B6B500ADAE
      AD00ADAEAD00ADAEAD00ADAEAD00ADAEAD00ADAEAD00ADAEAD00ADAEAD00ADAE
      AD00ADAEAD00B5B6B5008C8E8C004A494A00C0C0C000C0C0C000C0C0C000C0C0
      C00000868400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000868400C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B5B6
      B5004A494A00424142006B696B00C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00DEDFDE005A595A0042414200C0C0C000ADAEAD004A494A004A494A004A49
      4A004A494A004A494A004A494A004A494A004A494A004A494A004A494A004A49
      4A004A494A004A494A004A494A00ADAEAD00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFF7F700CEC7AD00FFFFFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF004A494A00CECFCE00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000808080008080800C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C0008486420084864200C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000F7F7F700D6C78C00BDA65200F7EFEF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF0042414200C6C7C600C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00008080800BD790000734900000808
      0800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00084862100F7CFA50084864200C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000F7F7F700CEBE8C00F7CF6300CEB64A00F7EFEF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000A5A6A500A5A6A500A5A6A500A5A6
      A500B5B6B500F7F7F700C0C0C000FFFFFF0042414200C6C7C600C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00008080800BD790000DE96000052300000BD79
      000008080800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00084862100C6C74200F7CFA50084864200C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000F7F7F700CEBE8400E7C75A00F7C74A00CEAE4A00F7F7FF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00073717300525152005A595A004A49
      4A0042414200C6C7C600C0C0C000E7E7E70042414200C6C7C600C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C0000808080073007300DE960000DE960000523000009461
      0000080808007B797B00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00084862100C6C74200C6C74200C6C763008486
      4200C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000F7F7
      FF00CEBE8400E7C75200EFB64200EFB64200CEA64200C6BEA500CEC7AD00CEC7
      AD00CEC7AD00CEC7AD00C6BEA500E7DFD600C0C0C000C0C0C000C0C0C000A5A6
      A50042414200C6C7C600F7F7F7007B797B0042414200D6D7D600C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000080808003900BD0073007300DE960000DE960000523000009461
      0000080808006B696B007B797B00C0C0C000C0C0C000F7CFA500F7CFA500F7CF
      A500F7CFA500F7CFA500F7CFA500F7CFA500C6A64200C6A64200C6C74200C6C7
      630084864200C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000F7F7FF00CEBE
      8400E7BE5200EFB64A00E7AE4200E7AE4200EFB65200E7BE6300E7C76B00E7C7
      6B00E7C76B00E7C76B00DEBE5A00C6BE9400C0C0C000C0C0C000C0C0C000ADAE
      AD004241420094969400636163004A494A00BDBEBD00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000080808003900BD000000DE0073007300DE960000DE960000523000009461
      0000080808006B696B007B797B00C0C0C000C0C0C000F7CFA500C6C76300C6C7
      4200C6C74200C6C74200C6C74200C6C74200C6A64200C6A64200C6A64200C6C7
      4200C6C7630084864200C0C0C000C0C0C000C0C0C000F7F7FF00CEB68400E7BE
      5200EFBE5200E7AE4200E7AE4200E7AE4200E7AE4200E7B64200E7B64200E7B6
      4A00E7B64A00E7B64A00E7BE4A00CEC79C00C0C0C000C0C0C000C0C0C000ADAE
      AD0042414200424142005A595A00DEDFDE00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000808
      0800180052000000DE000000DE0073007300DE960000DE960000523000009461
      0000080808007B797B00C0C0C000C0C0C000C0C0C000F7CFA500C6C74200C6C7
      4200C6C74200C6C74200C6C74200C6C74200C6C74200C6C74200C6C74200C6C7
      4200C6C76300C6C7630084864200C0C0C000F7F7F700CEB68400E7C75A00EFBE
      5A00E7B64A00EFB64A00EFB64A00EFB64A00EFB64A00EFB64A00EFB64A00EFB6
      4A00EFB64A00EFB64A00E7BE5200CEC79C00C0C0C000C0C0C000C0C0C000D6D7
      D60042414200424142005A595A00E7E7E700DEDFDE00BDBEBD00BDBEBD00CECF
      CE00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000808080000DF
      DE00180052000000DE000000DE0073007300DE960000DE960000523000009461
      000008080800C0C0C000C0C0C000C0C0C000C0C0C000F7CFA500C6C76300C6C7
      6300C6C76300C6C76300C6C76300C6C76300C6C76300C6C76300C6C76300C6C7
      6300C6C76300F7CFA500F7CFA500C0C0C000F7F7F700CEB67B00F7D76B00FFD7
      6300FFC75A00FFC75200FFC75200FFC75200FFC75200FFC75200FFC75200FFC7
      5200FFC75200FFCF5A00EFC75A00CEC79C00C0C0C000D6D7D600E7E7E700C0C0
      C0009496940042414200424142007B797B00525152004A494A004A494A006361
      6300C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000808080000DFDE0000FF
      FF00180052000000DE000000DE0073007300DE960000DE960000523000009461
      000008080800C0C0C000C0C0C000C0C0C000C0C0C000F7CFA500C6C76300C6C7
      6300C6C76300C6C76300C6C76300C6C76300C6C76300C6C76300C6C76300C6C7
      6300F7CFA500F7CFA500C0C0C000C0C0C000C0C0C000F7F7F700CEBE8400F7D7
      6B00FFD76B00FFCF5A00FFCF5A00FFCF5A00FFCF6300FFCF6300FFD76300FFD7
      6300FFD76300FFD76300F7CF6300CEC7A500C0C0C000737173006B696B00FFFF
      FF00F7F7F70063616300424142004241420042414200C6C7C600C0C0C000F7F7
      F700C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000808080000FFFF000071
      7300180052000000DE000020730073007300DE960000BD790000523000009461
      000008080800C0C0C000C0C0C000C0C0C000C0C0C000F7CFA500F7CFA500F7CF
      A500F7CFA500F7CFA500F7CFA500F7CFA500C6C76300C6C76300C6C76300F7CF
      A500F7CFA500C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000F7F7F700CEBE
      8400F7D77300FFDF7300FFCF6300FFD76300FFD77300F7D77B00F7D77B00F7D7
      8400F7D78400F7D78400E7CF7B00C6BE9C00C0C0C000D6D7D600424142009496
      9400C0C0C000ADAEAD00424142004241420042414200CECFCE00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000080808000096940000DF
      DE0018005200002073000000BD0073007300BD79000094610000734900009461
      000008080800C0C0C000C0C0C000C0C0C000C0C0C00084864200848642008486
      420084864200848642008486420084864200F7CFA500F7CFA500F7CFA500F7CF
      A500C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000F7F7
      F700CEBE8400F7D77B00FFDF7B00FFDF7300CEB66300C6B69C00CEC7AD00CEC7
      AD00CEC7AD00CEC7AD00C6BEA500E7DFCE00C0C0C000C0C0C000ADAEAD004241
      42006361630063616300424142004241420042414200CECFCE00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000808080000DF
      DE00080808000000BD00003094007300730094610000BD790000BD7900007349
      000008080800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00084864200F7CFA500F7CFA500F7CFA500C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000F7F7F700CEBE8400F7DF8400FFEF9400CEB67300F7F7FF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00ADAE
      AD0063616300636163006B696B006B696B006B696B00BDBEBD00F7F7F700C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000808
      080008080800080808000000BD0008080800BD790000DE960000DE960000BD79
      000008080800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00084864200F7CFA500F7CFA500C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000F7F7F700CEBE8400F7E79400CEBE8C00F7EFEF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000949694004241420063616300E7E7
      E700C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000080808000808080008080800BD790000BD7900000808
      0800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00084864200F7CFA500C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000F7F7F700D6BE8C00BDA66300F7EFEF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF00525152004241420042414200C6C7
      C600C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000808080008080800C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00084864200C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFF7F700CEC7A500FFFFFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000ADAEAD005251520084868400F7F7
      F700C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7C600C6BEC600C6C7
      C600C6BEC600C6C7C600BDC7C600BDC7C600BDC7C600C6BEC600C6C7BD00C6C7
      C600BDC7C600BDBEC600BDC7C600C0C0C0000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000000
      0000000000000000000000000000000000000000080000000000000000000000
      0800080000000000000000000000C0C0C000C6C7C60008081000080008000800
      0800000000000000000000000000000000000808080000000000080000000800
      0000080800000800080010081000C0C0C0008486840000860000008600000086
      0000008600000086000000860000008600000086000000860000008600000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000BDBEBD0000000000EFEFEF00EFEF
      EF0000000000EFEFEF0000000000EFEFEF0000000000E7EFF70000000000EFEF
      EF0000000000EFF7EF00BDBEC600C0C0C000CECFD60000000800EFE7F700EFE7
      EF0000000000EFEFE70000000000EFEFEF0000000800E7E7EF0008080000E7E7
      EF0000080800E7E7F700E7E7EF00C0C0C0008486840000860000008600000086
      0000008600000086000000860000008600000086000000860000008600000086
      000000000000C6C7C600C6C7C600C6C7C600C0C0C00000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000BDB6BD0000000000F7EFF700EFEF
      EF0008080800D6D7D60000000800EFEFEF0008100800EFEFF70000080800E7EF
      EF0000080000E7EFEF00B5BEBD00C0C0C000CECFCE0008000800F7F7F700F7F7
      F70008080800D6CFD60000080800E7E7E70018101800EFE7EF0010080800FFEF
      F70008000800F7E7FF00F7EFF700C0C0C000C6C7C60084868400008600000086
      0000008600000086000000860000008600000086000000860000008600000086
      00000086000000000000C6C7C600C6C7C60000000000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDBEBD0000000000FFFFFF00EFEF
      F700EFEFEF00EFEFF70000000000EFEFF700EFEFEF00EFEFE70008081000F7EF
      EF00EFEFEF00F7F7F700C6CFB500C0C0C000CECFCE0000080000FFFFEF00EFEF
      E700EFEFEF00EFEFEF0000080000E7FFEF00F7EFEF00F7F7EF0008080000EFEF
      EF00E7EFE700EFEFF700F7F7EF00C0C0C000C6C7C60084868400008600000086
      0000008600000086000000860000008600000086000000860000008600000086
      0000008600000086000000000000C6C7C60000000000C0C0C000C0C0C000C0C0
      C0000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000000000B5B6B50000000000FFFFFF00EFEF
      EF00E7EFEF00EFF7EF00EFEFEF00FFFFFF00EFF7F700FFFFF700F7F7EF00F7EF
      F700EFEFFF00EFEFF700C6C7BD00C0C0C000C6CFD60000000800FFF7F700FFF7
      F700F7E7F700EFEFFF00D6DFE700EFFFFF00FFF7F700FFF7FF00FFEFF700F7EF
      FF00EFEFF700F7EFFF00EFEFEF00C0C0C0008486840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000086
      00000086000000860000008600000000000000000000C0C0C000C0C0C0000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000000000B5BEBD0000000000F7FFF700FFFF
      FF00FFFFFF00EFFFF700DEE7DE00F7F7F700F7FFEF00F7EFE700EFE7D600E7DF
      DE00F7F7FF00EFF7FF00B5B6B500C0C0C000D6CFCE0008000800F7F7FF00F7FF
      FF00FFFFFF00FFF7EF00DEEFDE00DEF7E700FFFFEF00EFEFDE00E7E7DE00DEDF
      D600FFFFFF00F7F7FF00EFEFEF00C0C0C000C6C7C60084868400008684000086
      8400008684000086840000868400008684000086840000868400008684000000
      0000848684008486840084868400C6C7C600C0C0C00000000000C0C0C0000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000000000B5BEB50008000000FFFFFF00F7FF
      F700FFFFF700E7CFC60008080000FFF7FF00FFFFEF0018080000211000001808
      0800F7EFF700EFEFF700EFF7EF00C0C0C000D6D7D60000000000F7FFFF00F7FF
      FF00FFFFFF00D6C7C60000100800EFFFF700FFFFE70021100000291000002108
      0000FFF7F700F7EFF700F7F7EF00C0C0C000C6C7C60084868400008684000086
      8400008684000086840000868400008684000086840000868400008684000086
      840000000000C6C7C600C6C7C600C6C7C600C0C0C000000000000000000000FF
      FF000000000000FFFF0000FFFF00008684000086840000FFFF000086840000FF
      FF000086840000FFFF0000FFFF0000000000B5BEB50000000000E7FFFF00E7F7
      EF00FFEFEF001008080000000000FFF7FF00FFFFEF00FFFFF700F7EFE7001000
      0000FFF7FF00EFEFF700C6C7C600C0C0C000C6CFCE0008100800F7FFFF00EFEF
      EF00F7E7E7001808100000000000F7F7FF00F7FFF700F7F7EF00F7E7EF000800
      0800F7F7FF00E7EFFF00E7EFF700C0C0C000C6C7C600C6C7C600848684000086
      8400008684000086840000868400008684000086840000868400008684000086
      84000086840000000000C6C7C600C6C7C600C0C0C000C0C0C000C0C0C0000000
      000000FFFF0000FFFF0000FFFF00008684000086840000FFFF00008684000086
      84000086840000FFFF0000FFFF0000000000B5B6B50008000800EFF7FF00F7FF
      FF00FFFFF700C69EA50000000000FFF7FF00F7F7F70000000000080808000000
      0800F7EFF700F7EFFF00BDBEBD00C0C0C000C6CFCE003130310000000000F7FF
      F700FFF7F700B5A6AD0008000800FFF7FF00EFFFEF0008080800100808001000
      0000F7EFF700F7EFFF00EFEFF700C0C0C000C6C7C600C6C7C600848684000086
      8400008684000086840000868400008684000086840000868400008684000086
      8400008684000086840000000000C6C7C600C0C0C000C0C0C000C0C0C0000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000000000ADBEBD0000000800EFF7FF00EFFF
      FF00FFF7FF00E7EFEF00F7F7F700FFF7FF00F7F7FF00EFEFFF00E7EFF700EFEF
      FF00FFF7FF00F7EFF700BDB6BD00C0C0C000CECFD600CECFD600313839000000
      0000FFF7F700FFEFF700E7E7EF00FFFFFF00EFFFF700E7F7F700E7EFEF00F7FF
      FF00F7F7FF00F7EFFF00EFF7F700C0C0C0008486840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000086
      840000868400008684000086840000000000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000000000B5BEBD0000000000F7EFF700EFEF
      EF00EFEFEF00F7EFEF00EFEFF700F7EFF700F7F7F700EFEFEF00EFEFF700EFEF
      F700EFEFEF00F7EFEF00EFEFEF00C0C0C000D6CFD600D6CFD600C6CFCE003130
      310008000000F7EFEF00EFF7F700E7E7EF00F7F7F700E7E7F700E7EFF700E7E7
      F700EFE7EF00FFEFFF00F7E7F700C0C0C000C6C7C60084868400C6C7C600C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000848684008486840084868400C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDB6B50000000000000000000000
      0000000000000000000000000000000000000000000008000000000000000000
      0000000000000000000000000000C0C0C000CECFD600D6CFD600CECFD600CECF
      D600393039000000000000000000000008000800000008000000000000000000
      0000080000000800000018101000C0C0C000C6C7C6008486840084868400C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000BDC7BD00C6C7C600C6CFCE00CED7
      D600D6CFCE00D6CFD600CECFCE00D6CFD600D6CFCE00CECFD600CECFD600CECF
      D600CED7D600CECFD600C6CFCE00C0C0C000C6C7C600C6C7C60084868400C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7C600C6C7C600C6C7C6008486
      8400848684008486840084868400848684008486840084868400848684008486
      8400848684008486840000000000C6C7C600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF00FFFFFF00C0C0
      C000FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000C6C7C6000000
      000000000000C6C7C6000000000000000000C6C7C600C6C7C600000000000000
      0000C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7C600000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C60000000000080808008C8E8C000000
      000000000000080808008C8E8C0000000000000000008C8E8C00080808000808
      08008C8E8C00080808000000000008080800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60084868400000000000000
      0000C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C600C6C7C6000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60084868400000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C6008C8E8C00C6C7C600C6C7C600C6C7
      C600C6C7C600BDBEBD00BDBEBD00C6C7C600C6C7C60084868400000000000000
      0000C6C7C600C6C7C60008080800BDBEBD00C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000000000008486
      8400C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C60000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000000000008486
      8400C6C7C60000000000C6C7C600C6C7C60008080800C6C7C600C6C7C600BDBE
      BD00BDBEBD00C6C7C600BDBEBD00BDBEBD00C6C7C60000000000000000007B79
      7B00BDBEBD00BDBEBD008C8E8C00BDBEBD00C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C000C0C0C000C0C0C000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600848684000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600848684000000000000000000C6C7
      C600C6C7C600C6C7C60000000000C6C7C60000000000C6C7C600BDBEBD00CECF
      CE00C6C7C600BDBEBD00C6C7C600C6C7C600848684000000000000000000C6C7
      C600CECFCE00BDBEBD0000000000CECFCE00C0C0C000C0C0C000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7
      C600C6C7C60000000000C6C7C600C6C7C600000000000000000084868400C6C7
      C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C60000000000C6C7C600C6C7C600000000000000000084868400C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C6009C9E9C00BDBEBD00C6C7C600BDBE
      BD00C6C7C60000000000BDBEBD00C6C7C60000000000000000007B797B00BDBE
      BD00BDBEBD00C6C7C60008080800C6C7C600C0C0C000C0C0C000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000848684000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000848684000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C6000000000008080800BDBEBD00C6C7C600BDBE
      BD00BDBEBD0000000000000000007B797B000000000000000000B5B6B500CECF
      CE00BDBEBD00C6C7C6008C8E8C00C6C7C600C0C0C00000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000C0C0C000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000000000000000000084868400C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000000000000000000084868400C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C6000000000008080800BDBEBD00BDBEBD00C6C7
      C600C6C7C6000000000000000000000000000000000084868400BDBEBD00BDBE
      BD00C6C7C600C6C7C60008080800C6C7C600C0C0C00000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000C0C0C00000000000C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000000000000000000000000000000000000000
      0000C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000000000000000000000000000000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C6008C8E8C00C6C7C600BDBEBD00C6C7
      C600BDBEBD000000000000000000000000000000000000000000000000000000
      0000C6C7C600BDBEBD0008080800BDBEBD00C0C0C00000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000C0C0C00000000000C6C7C600C6C7C600C6C7
      C600C6C7C600000000000000000000000000000000000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7
      C600C6C7C600000000000000000000000000000000000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C6000000000008080800BDBEBD00C6C7C600BDBE
      BD00C6C7C600000000000000000000000000000000000000000000000000BDBE
      BD00BDBEBD00CECFCE008C8E8C00C6C7C600C0C0C00000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000C0C0C000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C6000000000008080800C6C7C600BDBEBD00C6C7
      C600C6C7C6000000000000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600BDBEBD0000000800C6BEC600C0C0C000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7
      C600C6C7C60000000000000000000000000000000000C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C60000000000000000000000000000000000C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C60000000000C6C7C6009C969C00B5B6BD00C6C7C600BDBE
      BD00BDBEBD0000000000000000000000000000000000C6C7C600BDBEBD00C6C7
      C600BDBEBD0008080800B5B6B500C6C7C600C0C0C000C0C0C000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7
      C600C6C7C600000000000000000000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C60000000000C6C7C60000000000C6C7C600C6C7
      C600C6C7C600000000000000000000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000800B5B6B500C6C7
      C600B5B6B500000000000000000000000000C6C7C600B5B6B500C6C7C600BDBE
      BD0008080800B5B6B500B5B6B500BDBEC600C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      000000000000C0C0C000C0C0C000C0C0C000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7
      C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C60000000000C6C7C600C6C7C600BDBEBD00C6C7C60008000800BDBE
      BD00C6C7C6000000000000000000C6C7C600BDBEBD00CECFCE00BDBEBD000000
      0000B5B6B500BDBEBD00BDBEBD00BDBEC600C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7
      C600C6C7C60000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C600C6C7C6000000
      0000C6C7C60000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C60000000000C6C7C600C6C7C600C6C7C600C6C7CE00BDBEC600BDBEBD000808
      0800C6C7C60000000000BDBEBD00BDBEBD00C6C7C600BDBEBD0000000000B5B6
      B500CECFCE00BDBEBD00B5B6B500C6BEC600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00000000000C6C7C600000000000000
      0000C6C7C6000000000000000000C6C7C6000000000000000000C6C7C6000000
      000000000000C6C7C6000000000000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C6000000000000000000C6C7C6000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6BEC600BDBEBD00C6C7C600BDBE
      C6000800080000000000080808008C8E8C000000000008080800B5B6B500BDBE
      BD00C6C7C600C6BEC600BDBEBD00BDBEC600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600000000000000000000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600000000000000000000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000000000000000000000000000000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600000000008486
      8400C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600000000000000000000000000000000000000000000000000C6C7C600C6C7
      C600000000000000000000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600000000000000000000000000000000000000000000000000C6C7C600C6C7
      C600000000000000000000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C60000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60084868400000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600000000000000
      000084868400C6C7C600C0C0C000C6C7C600C0C0C00084868400000000000000
      00000000000000000000C6C7C600C6C7C600C6C7C600C6C7C600000000000000
      000084868400C6C7C600C0C0C000C6C7C600C0C0C00084868400000000000000
      00000000000000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C6000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000000000008486
      8400C6C7C600C6C7C600C6C7C600C6C7C600C6C7C6000000000084868400C6C7
      C600C6C7C600C0C0C000C6C7C600C0C0C000C6C7C600C0C0C000C6C7C6008486
      840000000000C6C7C600C6C7C600C6C7C600C6C7C6000000000084868400C6C7
      C600C6C7C600C0C0C000C6C7C600C0C0C000C6C7C600C0C0C000C6C7C6008486
      840000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600848684000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7
      C600C6C7C600C6C7C6000000000000000000C0C0C000C6C7C600C0C0C000C6C7
      C60000000000C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C6C7C600C0C0C000C6C7
      C60000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C60000000000C6C7C600C6C7C600000000000000000084868400C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C6000000000084868400C6C7C600C6C7
      C600C6C7C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7C600C0C0
      C0008486840000000000C6C7C600C6C7C6000000000084868400C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0
      C0008486840000000000C6C7C600C6C7C600C6C7C60000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000848684000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C6000000000000000000C6C7C600C6C7C600C0C0C000C6C7
      C600C0C0C00000000000C6C7C600C6C7C60000000000C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C6C7
      C600C0C0C00000000000C6C7C600C6C7C60000000000C0C0C000C0C0C000C0C0
      C00000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000000000000000000084868400C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C6000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C6C7C60000000000C6C7C600C6C7C60000000000C6C7C600C6C7C6000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C6C7C60000000000C6C7C600C6C7C60000000000C0C0C000C0C0C0000000
      000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000000000000000000000000000000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C6000000
      000000000000000000000000000000000000000000000000000000000000C6C7
      C600C0C0C00000000000C6C7C600C6C7C60000000000C6C7C600C6C7C6000000
      000000000000000000000000000000000000000000000000000000000000C6C7
      C600C0C0C00000000000C6C7C600C6C7C600C6C7C6000000000000000000C6C7
      C60000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600000000000000000000000000000000000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C0C0C000C6C7
      C600C6C7C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7C600C0C0
      C000C6C7C60000000000C6C7C600C6C7C60000000000C6C7C600C0C0C000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0
      C000C6C7C60000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C6000000
      0000C0C0C000C0C0C00000000000C0C0C000C0C0C00000000000C0C0C000C0C0
      C00000000000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C6000000000084868400C0C0C000C0C0
      C000C6C7C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7C600C6C7
      C6008486840000000000C6C7C600C6C7C6000000000084868400C0C0C000C0C0
      C000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C6008486840000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C6000000
      0000C0C0C000C0C0C00000000000C0C0C000C0C0C00000000000C0C0C000C0C0
      C0000000000000000000C0C0C00000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C60000000000000000000000000000000000C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C0C0
      C000C0C0C000C0C0C0000000000000000000C6C7C600C6C7C600C6C7C600C6C7
      C60000000000C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C0C0
      C000C0C0C000C0C0C000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C60000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C0C0
      C000C0C0C0000000000000000000C0C0C000C0C0C00000000000C0C0C000C0C0
      C00000000000C6C7C60000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600000000000000000000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C6000000000084868400C6C7
      C600C0C0C000C0C0C000C0C0C000C0C0C000C6C7C600C6C7C600C6C7C6008486
      840000000000C6C7C600C6C7C600C6C7C600C6C7C6000000000084868400C6C7
      C600C0C0C000C0C0C000C0C0C000C0C0C000C6C7C600C6C7C600C6C7C6008486
      840000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C0C0
      C000C0C0C0000000000000000000C0C0C000C0C0C00000000000C0C0C000C0C0
      C00000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600000000000000
      000084868400C6C7C600C6C7C600C6C7C600C6C7C60084868400000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600000000000000
      000084868400C6C7C600C6C7C600C6C7C600C6C7C60084868400000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C6000000
      000000000000C6C7C60000000000C0C0C000C0C0C00000000000000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C60000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600000000000000000000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600000000000000000000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00018516B00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00042084200C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000844142004A1818004A1818004A181800C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C0004A2818004A281800C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00018516B0018516B00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0004208
      420042084200C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000734142004A18
      18004A1818008C383100944139008C4139004A1818004A1818004A1818004A18
      18004A1818004A1818004A1818004A181800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C0004A281800EFE7E700EFE7E7004A281800C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00018516B003186AD0029618C00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000420842009C38
      8C0042084200420842004208420042084200C0C0C000734142008C383100AD49
      4200A5494200A54142009C414200944139004A181800EF797300EF797300EF79
      7300EF797300EF797300EF7973004A181800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0004A281800EFE7E7008418000084180000EFE7E7004A281800C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00029618C0018516B0018516B0018516B001879BD0018516B00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000B59E8C004A2818004A2818004A28
      18004A2818004A2818004A2818004A28180094694A0042084200B549AD00AD41
      A5009C388C008C307B007B28730042084200C0C0C00073414200B5494A00B549
      4A00AD494200AD494200A5414200944139004A18180000300000003000000030
      00000030000010410800EF7973004A181800C0C0C000C0C0C000C0C0C000C0C0
      C0004A281800EFE7E70084180000F7693100F761290084180000EFE7E7004A28
      1800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0002961
      8C0018516B003186AD003186AD003186AD003186AD001886C6003186AD001851
      6B00C0C0C000C0C0C000C0C0C000C0C0C000B59E8C00CEB6AD00A58E7B00A58E
      7B00A58E7B00A58E7B00A58E7B00D6BEAD0042084200C68EBD00B549AD00B549
      AD00AD41A5009C388C009430840042084200C0C0C00073414200BD514A00B549
      4A00B5494A00A54142009C413900944139004A18180000300000003000000030
      00000049000018511000EF7973004A181800C0C0C000C0C0C000C0C0C0004A28
      1800EFE7E70084180000B5795A00B5795A00B5795A00B5795A0084180000EFE7
      E7004A281800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00018516B003186
      AD003196CE0031A6E70031A6EF002996DE002196DE002196E700218ED6001886
      C60018516B00C0C0C000C0C0C000C0C0C000B59E8C00A58E7B00D6BEAD00D6BE
      AD00D6BEAD00D6BEAD00D6BEAD00D6BEAD00D6BEAD008C287B00C68EBD00B549
      AD00BD61AD00BD61AD00BD61AD0042084200C0C0C00073414200BD514A00BD51
      4A00B5515200D6A69C00844142008C3839004A18180000410000003000000041
      00000061080018591000EF7973004A181800C0C0C000C0C0C0004A281800EFEF
      E70084180000F7865200FFFFFF00FFFFFF00FFFFFF00FFFFFF00944929008418
      0000EFE7E7004A281800C0C0C000C0C0C000C0C0C00018516B003186AD004AB6
      EF004AB6EF004AB6EF0042B6EF000818210000102100299EEF002196E700218E
      DE001886C60018516B00C0C0C000C0C0C000B59E8C00E7D7CE00A58E7B00E7D7
      CE00E7D7CE00E7D7CE00E7D7CE00E7D7CE00E7D7CE00E7D7CE008C287B00C68E
      BD008C287B008C287B008C287B008C287B00C0C0C00073414200C6515200C651
      4A00D6A69C00FFEFEF00D6A69C008C4139004A18180000490000004100001051
      08000071100018511000EF7973004A181800C0C0C0004A281800EFE7E7008418
      0000F79E6B00F7966300F7865200FFFFFF00FFFFFF0094492900F7693100F761
      290084180000EFE7E7004A281800C0C0C00029618C003186AD0052C7EF005AC7
      EF005AC7EF0052C7EF0052BEEF0018495A0018415A0031A6EF00299EEF002196
      E700218EDE001879C60018516B00C0C0C000B59E8C00E7DFD600E7DFD600A58E
      7B00F7F7EF00F7F7EF00F7F7EF00F7F7EF00F7F7EF00F7F7EF00F7F7EF008C28
      7B008C287B0094694A00C0C0C000C0C0C000C0C0C00073414200CE515200C651
      5200C6595200D6A69C00B55152009C4142004A1818000049000073611000C68E
      290018590800C68E2900EF7973004A18180084180000F7F7F700BD410000FFB6
      8C00FFA67B00F79E6B00F7966300FFFFFF00FFFFFF0094492900F7713900F769
      3100F761290084180000EFE7E7004A28180018516B0052B6DE0063CFEF006BCF
      EF006BCFEF0063CFEF005AC7EF0052B6E70042AEE70039AEEF0031A6EF00219E
      EF002196E700218ED60018619C0029618C00B59E8C00F7F7EF00F7F7EF00A58E
      7B00A58E7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF0094694A00A58E7B00F7F7
      EF008C287B0094694A00C0C0C000C0C0C000C0C0C00073414200CE595200CE59
      5200C6515200C6515200BD514A009C4942004A18180052611000F7AE6300F7AE
      6300F7AE6300F7AE6300EF7973004A18180084180000FFFFFF00BD410000FFB6
      8C00FFB68C00FFA67B00F79E6B00FFFFFF00FFFFFF0094492900F7794200F771
      3900F769310084180000EFE7E7004A28180018516B006BCFE70073DFEF007BDF
      EF007BDFEF0073DFEF006BD7EF003986940021516B0042B6EF0031AEEF00299E
      EF002196E700218EDE001871AD0018516B00B59E8C00FFFFFF00A58E7B00BDE7
      FF00A5DFFF00A58E7B00A58E7B00A58E7B00A58E7B004AB6FF0039AEFF009469
      4A00F7F7EF004A281800C0C0C000C0C0C000C0C0C00073414200D6595A00D659
      5200CE595200C6515200C6515200A54942004A181800F7AE6300F7AE6300F7AE
      6300F7AE6300F7AE6300EF7973004A181800C0C0C00084180000FFFFF700BD41
      0000FFB68C00FFB68C00FFFFFF00FFFFFF00FFFFFF0094492900F7865200F779
      420084180000EFE7E7004A281800C0C0C00018516B0073D7E70084E7EF008CE7
      EF008CE7EF0084E7EF0073DFEF005AB6D6001028310021516B0039A6E70029A6
      EF002196E700218EDE001886C60018516B00B59E8C00A58E7B00D6EFFF00D6EF
      FF00BDE7FF00A5DFFF0094D7FF0084CFFF006BC7FF005ABEFF004AB6FF0039AE
      FF0094694A004A281800C0C0C000C0C0C000C0C0C00073414200DE595A00D659
      5A00D6595200CE595200C6515200A54942004A181800F7AE6300F7AE6300F7AE
      63009C9E8C00108EF700EF7973004A181800C0C0C000C0C0C00084180000FFFF
      FF00BD410000FFB68C00FFB68C00B5795A00B5795A00F7966300F78652008418
      0000EFE7E7004A281800C0C0C000C0C0C00018516B006BCFDE008CE7EF008CEF
      EF008CE7EF007BD7D60063B6C6006BCFE70039799400000000001851730031A6
      EF002196E700218EDE001871AD0018516B00B59E8C00D6EFFF00D6EFFF00D6EF
      FF00D6EFFF00BDE7FF00A5DFFF0094D7FF0084CFFF006BC7FF005ABEFF004AB6
      FF0039AEFF004A281800C0C0C000C0C0C000C0C0C00073414200DE595A00DE59
      5A00D6595A00D6595A00CE595200A54942004A181800F7AE6300F7AE63009C9E
      8C0010A6F700108EF700EF7973004A181800C0C0C000C0C0C000C0C0C0008418
      0000FFFFFF00BD410000FFB68C00FFFFFF00FFFFFF009449290084180000EFE7
      E7004A281800C0C0C000C0C0C000C0C0C00029618C004296AD008CE7EF008CEF
      EF008CEFEF0029494A00000000005AB6CE004AA6BD00000000000828390031A6
      EF002196E700218ED60018619C0029618C00C0C0C000B59E9400D6EFFF00D6EF
      FF00D6EFFF00D6EFFF00BDE7FF00A5DFFF0094D7FF0084CFFF006BC7FF005ABE
      FF005A382900C0C0C000C0C0C000C0C0C000C0C0C00073414200D6595A00DE59
      5A00DE595A00D6595A00D6595A00AD4942004A181800F7AE63009C9E8C0008B6
      F70008B6F70010A6F700EF7973004A181800C0C0C000C0C0C000C0C0C000C0C0
      C00084180000FFFFFF00BD410000FFFFFF00FFFFFF0084180000EFE7E7004A28
      1800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00018516B004A96AD0084DF
      E7008CE7EF00529694001020210031616B00082021000008100029719C0031A6
      EF00218EDE001879C60018516B00C0C0C000C0C0C000C0C0C000B5A69400D6EF
      FF00D6EFFF00D6EFFF00D6EFFF00BDE7FF00A5DFFF0094D7FF0084CFFF004A28
      1800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0009C514A007341
      4200B5514A00B5514A00C6515200A54942004A18180073414200734142007341
      420073414200734142007341420073414200C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00084180000FFFFF700BD410000BD410000EFE7E7004A281800C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00029618C001851
      6B0063B6C6006BCFDE0052A6BD004296AD00398EAD003996BD00319ED6002179
      BD0018516B0029618C00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000B59E
      8C00D6EFFF00D6EFFF00D6EFFF00D6EFFF00BDE7FF00A5DFFF004A281800C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0009C514A0073414200B5514A00B5514A004A181800C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00084180000FFFFFF00F7F7F7004A281800C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00029618C0018516B0018516B0018516B0018516B0018516B0018516B002961
      8C00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000B59E8C00B59E8C00B59E8C00B59E8C00B59E8C00B59E8C00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C0009C514A007341420073414200C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C0008418000084180000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00010181800C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00084868400848684008486840084868400848684008486
      840084868400848684008486840084868400C0C0C000C0C0C000C0C0C0008486
      8400848684008486840084868400848684008486840084868400848684008486
      840084868400848684008486840084868400C0C0C00010181800004973001018
      1800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0007341
      420073414200C0C0C000C0C0C000C0C0C000946142008C5942007B4129007338
      21006328100063281000C0C0C000C0C0C000C0C0C000946142008C5942007B41
      2900733821006328100063281000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00084868400C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C60084868400C0C0C000C0C0C000C0C0C000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600848684000049730042BEF7001896C6000049
      730010181800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00073414200CE96
      9400EFD7D600C6616300C0C0C000C0C0C00094614200FFFFFF00DEBEA500BD8E
      73009459390063281000C0C0C000C0C0C000C0C0C00094614200FFFFFF00DEBE
      A500BD8E73009459390063281000C0C0C000C0C0C000C0C0C000C0C0C0008486
      840084868400FF000000C6C7C600FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFF
      FF0000FFFF00FFFFFF00C6C7C60084868400C0C0C000C0C0C000C0C0C000C6C7
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C60084868400C0C0C0000049730042BEF7001896
      C6000049730010181800C0C0C000C0C0C000C0C0C00073414200CE969400F7EF
      EF00C6616300C0C0C000C0C0C000C0C0C00094614200FFFFFF00DEBEA500BD8E
      7300A561420063281000C0C0C000C0C0C000C0C0C00094614200FFFFFF00DEBE
      A500BD8E7300A561420063281000C0C0C000C0C0C000C0C0C00084868400FF00
      0000FF000000FF000000C6C7C600FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C60084868400C0C0C000C0C0C000FF000000C6C7
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C60084868400C0C0C000C0C0C0000049730042BE
      F7001896C6000049730010181800C0C0C00073414200CE969400F7EFEF00C661
      6300C0C0C000C0C0C000C0C0C000C0C0C00094614200FFFFFF00DEBEA500BD8E
      7300A561420063281000C0C0C000C0C0C000C0C0C00094614200FFFFFF00DEBE
      A500BD8E7300A561420063281000C0C0C000C0C0C00084868400FF000000FF00
      0000FF000000FF000000C6C7C600FFFFFF0000FFFF0084868400848684008486
      8400C6C7C600FFFFFF00C6C7C60084868400C0C0C000FF000000848684008486
      8400848684008486840084868400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C60084868400C0C0C000C0C0C000C0C0C0000049
      730042BEF7001896C6000049730073414200CE969400F7EFEF00C6616300C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00094614200FFFFFF00DEBEA500BD8E
      7300A561420063281000C0C0C000C0C0C000C0C0C00094614200FFFFFF00DEBE
      A500BD8E7300A561420063281000C0C0C000C0C0C00084868400FF000000FF00
      0000FF000000FF000000C6C7C600FFFFFF0084868400FF000000FF000000FF00
      000084868400FFFFFF00C6C7C6008486840084868400FF000000848684008486
      8400FF000000FF000000FF000000FF00000084868400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C60084868400C0C0C000C0C0C000C0C0C000C0C0
      C0000049730042BEF70073414200CE969400F7EFEF00C6616300C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000946142008C5131008C5131007B38
      18007B381800632810006328100052281000946142008C5131008C5131007B38
      18007B3818006328100063281000C0C0C00084868400FF000000FF000000FF00
      0000FF000000FF000000C6C7C600FFFFFF0084868400C6C7C60084868400FF00
      000084868400FFFFFF00C6C7C60084868400848684008486840084868400FF00
      0000FF000000C6C7C600C6C7C60084868400FF00000084868400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C60084868400C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00073414200CE969400F7EFEF00C661630010181800C0C0C000C0C0
      C000C0C0C000C661630073414200C0C0C000D6B6940094614200E7CFBD00E7CF
      BD00BD8E6B0094593900632810008C51310094614200E7CFBD00E7CFBD00BD8E
      6B00945939006328100073414200C0C0C00084868400FF000000FF000000FF00
      00008486840084868400C6C7C600FFFFFF0084868400FFFFFF00C6C7C6008486
      840084868400FFFFFF00C6C7C6008486840084868400C6C7C60084868400FF00
      000084868400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C60084868400C0C0C000C0C0C000C0C0C000C0C0
      C00073414200CE969400F7EFEF00C66163001896C6000049730010181800C0C0
      C000C0C0C000C6616300FFFFFF0073414200C0C0C00094614200FFFFFF00EFE7
      DE00EFC7B5009459390063281000BD86730094614200FFFFFF00EFE7DE00EFC7
      B5009459390073414200C0C0C000C0C0C00084868400FF000000FF0000008486
      84008486840084868400C6C7C600FFFFFF0000FFFF0084868400848684008486
      8400C6C7C600FFFFFF00C6C7C60084868400C0C0C0008486840000FFFF00FF00
      0000FF000000FF000000FF000000FF000000FF00000084868400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C60084868400C0C0C00073414200734142007341
      4200CE969400F7EFEF00C66163000049730042BEF7001896C600734142007341
      42006B4931006B594A00C6616300C6616300C0C0C000C0C0C000946142008C51
      31007B41290063281000632810008C513100946142008C5131007B4129006328
      100063281000C0C0C000C0C0C000C0C0C00084868400FF000000FF0000008486
      84008486840084868400C6C7C600FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFF
      FF0084868400848684008486840084868400C0C0C000C0C0C0008486840000FF
      FF00FF000000FFFFFF00FFFFFF0084868400FF00000084868400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C6008486840073414200F7EFEF00E7C7C600CE96
      9400EFD7D600C6616300C0C0C000C0C0C00000497300C6616300E7C7C600D6A6
      A500CE9694006B594A00C0C0C000C0C0C000C0C0C000C0C0C00094614200FFFF
      FF00D6B69C009459390063281000C0C0C00094614200FFFFFF00D6B69C009459
      390063281000C0C0C000C0C0C000C0C0C00084868400FF000000FF000000C6C7
      C6008486840084868400C6C7C600FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C7C600FFFFFF00C6C7C600C0C0C000C0C0C000C0C0C000C0C0C0008486
      840000FFFF00FF000000FF000000FF00000084868400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C6008486840073414200C6616300C6616300C661
      6300E7C7C600C6616300C0C0C000C0C0C000C0C0C000C6616300F7EFEF00E7C7
      C600D6A6A500C6616300C0C0C000C0C0C000C0C0C000C0C0C000946142008C51
      31007B412900632810008C513100C0C0C000946142008C5131007B4129006328
      10008C513100C0C0C000C0C0C000C0C0C000C0C0C000C6C7C600FF000000FF00
      0000FFFFFF00C6C7C600C6C7C600FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFF
      FF00C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7
      C600FF000000FF000000FF00000084868400FFFFFF00FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C6008486840073414200C0C0C000C0C0C000C661
      6300E7C7C600C6616300C0C0C000C0C0C000C0C0C000C6616300FFFFFF00F7EF
      EF00C6616300C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0009461
      4200FFFFFF0063281000C0C0C000C0C0C000C0C0C00094614200FFFFFF006328
      1000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7C600FF000000FFFF
      FF00C6C7C600FFFFFF00C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C60084868400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7
      C600FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FFFFFF00FFFFFF00FFFF
      FF0084868400848684008486840084868400C0C0C000C0C0C000C0C0C0007341
      4200F7EFEF00C6616300C0C0C0007341420073414200EFD7D600FFFFFF00C661
      6300C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0009461
      4200946142008C513100C0C0C000C0C0C000C0C0C00094614200946142008C51
      3100C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7C600FF00
      0000FF000000C6C7C600FFFFFF00C6C7C6008486840084868400848684008486
      840084868400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C7C600FFFFFF00C6C7C600C0C0C000C0C0C000C0C0C000C6616300C661
      6300C6616300C0C0C000C6616300C6616300C6616300C6616300C6616300C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7
      C600C6C7C600FF000000FF000000FFFFFF00C6C7C60084868400848684008486
      8400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B004A28
      18004A2818004A2818004A2818004A2818004A2818004A2818004A2818004A28
      18004A2818004A2818004A281800C0C0C000C0C0C000C0C0C000BD9E8C004A28
      18004A2818004A2818004A2818004A2818004A2818004A2818004A2818004A28
      18004A2818004A2818004A281800C0C0C000C0C0C00031417B0008204200A58E
      7B004A2818004A2818004A2818004A2818004A2818004A2818004A2818004A28
      18004A2818004A2818004A2818004A281800C0C0C0001896C600004173000041
      7300004173000041730000417300004173000041730000417300004173000041
      730000417300004173000041730000417300C0C0C000C0C0C000A58E7B00EFDF
      DE00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E
      7B00A58E7B00A58E7B004A281800C0C0C000C0C0C000C0C0C000BD9E8C00EFDF
      DE00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E
      7B00A58E7B00A58E7B004A281800C0C0C00031417B003179DE0031417B000820
      4200EFDFDE00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E
      7B00A58E7B00A58E7B00A58E7B004A281800C0C0C0001896C600A5DFFF00A5DF
      FF00A5DFFF00A5DFFF00A5DFFF0094D7F7007BC7EF0063BEE70052B6DE0042AE
      D60031A6CE002196C6001896C60000417300C0C0C000C0C0C000A58E7B00EFE7
      DE00EFDFDE00E7DFD600E7D7CE00DECFC600DECFC600D6C7BD00D6BEB500D6BE
      AD00D6BEAD00A58E7B004A281800C0C0C000C0C0C000C0C0C000BD9E8C00EFE7
      DE00EFDFDE00E7DFD600E7D7CE00DECFC600DECFC600D6C7BD00D6BEB500D6BE
      AD00D6BEAD00A58E7B004A281800C0C0C0002186DE0084CFF7002971D6003141
      7B0008204200EFDFDE00E7DFD600E7D7CE00DECFC600DECFC600D6C7BD00D6BE
      B500D6BEAD00D6BEAD00A58E7B004A281800C0C0C0001896C600A5DFFF000049
      7300A5DFFF0000497300A5DFFF000049730094D7F7000049730063BEE7000049
      730042AED600004973002196C60000417300C0C0C000C0C0C000A58E7B00F7EF
      E700EFE7DE00EFDFDE00E7DFD600E7D7CE00DECFC600DECFC600D6865200D686
      5200D6BEAD00A58E7B004A281800C0C0C000C0C0C000C0C0C000BD9E8C00F7EF
      E700EFE7DE004A2818004A2818004A2818004A2818004A281800D6C7BD00D6BE
      B500D6BEAD00A58E7B004A281800C0C0C000C0C0C0002186DE0084CFF7004A79
      BD008479840094696B0094696B0094696B0094696B00DECFC600DECFC60000A6
      10000041000000410000A58E7B004A281800C0C0C0001896C6001896C6000061
      94001896C600006194001896C600006194001896C600006194001896C6000061
      94001896C600006194001896C6001896C600C0C0C000C0C0C000A58E7B00F7EF
      EF00F7EFE700EFE7DE00EFDFDE00E7DFD600E7D7CE00DECFC600DECFC600D6C7
      BD00D6BEB500A58E7B004A281800C0C0C000C0C0C000C0C0C000BD9E8C00F7EF
      EF00F7EFE7004A281800FFFFFF005269FF005269FF004A281800DECFC600D6C7
      BD00D6BEB500A58E7B004A281800C0C0C000C0C0C000C0C0C0002186DE009C9E
      A50094696B006BD794009CE7BD006BD79400FFF7D60094696B00DECFC60000A6
      10004AF7840000410000A58E7B004A281800BD4942007B2000007B2000007B20
      00007B2000007B2000007B2000007B2000007B2000007B2000007B200000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00F7F7
      F700DE966B00DE966300DE966300DE8E5A00DE8E5A00E7D7CE00D6865200D686
      5200D6C7BD00A58E7B004A281800C0C0C000C0C0C000C0C0C000BD9E8C00F7F7
      F700F7EFEF004A2818005269FF000018F7003141FF004A281800DECFC600DECF
      C600D6C7BD00A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0C0009469
      6B00EFD7AD006BD794006BD794006BD79400FFFFF700FFFFEF0094696B0000A6
      100000A6100000A61000A58E7B004A281800BD494200EF9E5A00EF8E4A00E786
      4200E7793900E7712900080808008441420084414200BD494200C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00F7F7F700F7EFEF00F7EFE700EFE7DE00EFDFDE00E7DFD600E7D7CE00DECF
      C600DECFC600A58E7B004A281800C0C0C000C0C0C000C0C0C000BD9E8C00FFFF
      FF00F7F7F7004A2818000018F700FFFFFF000018F7003141FF00E7D7CE00DECF
      C600DECFC600A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0C0009469
      6B00FFE7B500FFD79400FFBE8C00FFEFCE00FFF7DE00FFEFCE0094696B00E7D7
      CE009C300000DECFC600A58E7B004A281800BD494200F7A66B007B2000007B20
      00007B2000007B200000BD868400FFFFF7000086BD0008080800C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00DE9E6B00DE966B00DE966B00DE966300DE966300EFDFDE00DE8E5A00D68E
      5A00DECFC600A58E7B004A281800C0C0C000C0C0C000C0C0C000BD9E8C00FFFF
      FF00FFFFFF004A2818004A2818004A2818004A2818000018F7003141FF00E7D7
      CE00DECFC600A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0C0009469
      6B00F7EFBD00FFDFB500FFBE8C00FFBE8C00FFBE8C00FFBE8C0094696B009C30
      00009C300000DECFC600A58E7B004A281800BD494200F7B67B007B200000C0C0
      C000BD494200EF8E4200BD8684000086BD0031AED6000086BD0008080800C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFF7F700F7F7EF00F7EFEF00EFE7E700EFE7DE00E7DF
      D600E7D7CE00A58E7B004A281800C0C0C000C0C0C000C0C0C000BD9E8C00FFFF
      FF00FFFFFF00FFFFFF00FFF7F700F7F7EF00F7EFEF00EFE7E7000018F700E7DF
      D600E7D7CE00A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0C0009469
      6B00E7D7BD00FFFFFF00FFE7B500FFCF8C00FFBE8C00F7E7B50094696B00EFE7
      DE00E7DFD600E7D7CE00A58E7B004A281800BD494200F7B67B007B200000BD49
      4200EF9E6300EF965200BD4942000086BD007BDFF70031AED6000086BD000808
      0800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00DE9E6B00DE9E6B00DE9E6B00DE966B00DE966B00F7EFEF00DE966300DE8E
      5A00E7DFD600A58E7B004A281800C0C0C000C0C0C000C0C0C000BD9E8C00FFFF
      FF00FFFFFF004A2818004A2818004A2818004A2818004A281800EFE7E700EFE7
      DE00E7DFD600A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0C000A58E
      7B0094696B00E7D7C600FFEFBD00FFE7B500EFD7AD0094696B00F7EFEF00EFE7
      E700EFE7DE00E7DFD600A58E7B004A281800BD494200F7B67B00BD494200F7B6
      7B00F7AE6B00BD494200C0C0C000C0C0C0000086BD007BDFF70031AED6000086
      BD0008080800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7F7EF00F7EFEF00EFE7
      E700A58E7B00A58E7B004A281800C0C0C000C0C0C000C0C0C000BD9E8C00FFFF
      FF00FFFFFF004A281800FFFFFF005269FF005269FF004A281800F7EFEF00EFE7
      E700CEAE9C00A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0C000A58E
      7B00FFFFFF0094696B0094696B0094696B0094696B001030FF0000087300F7EF
      EF00EFE7E700A58E7B00A58E7B004A281800BD494200F7B67B00F7B67B00F7B6
      7B00BD494200C0C0C000C0C0C000C0C0C000C0C0C0000086BD007BDFF70031AE
      D6000086BD0008080800C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00DE9E6B00DE9E6B00DE9E6B00DE9E6B00DE9E6B00FFF7F700F7F7EF00A58E
      7B004A2818004A2818004A281800C0C0C000C0C0C000C0C0C000BD9E8C00FFFF
      FF00FFFFFF004A2818005269FF000018F7003141FF004A281800F7F7EF00BD9E
      8C004A2818004A2818004A281800C0C0C000C0C0C000C0C0C000C0C0C000A58E
      7B00FFFFFF00FFFFFF00FFFFFF000010AD006371FF003959FF001030FF000008
      7300A58E7B004A2818004A2818004A281800BD494200F7B67B00F7B67B00BD49
      4200C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000086BD007BDF
      F70031AED6006361630000008400C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700A58E
      7B00EFE7DE00D6BEAD004A281800C0C0C000C0C0C000C0C0C000BD9E8C00FFFF
      FF00FFFFFF004A2818000018F700FFFFFF000018F7003141FF00FFF7F700BD9E
      8C00EFE7DE00D6BEAD004A281800C0C0C000C0C0C000C0C0C000C0C0C000A58E
      7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF000010AD006371FF000010AD00FFF7
      F700A58E7B00EFE7DE00D6BEAD004A281800BD494200F7B67B00BD494200C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000086
      BD00C6A694005A7184000000840000008400C0C0C000C0C0C000A58E7B00FFFF
      FF00DE9E6B00DE9E6B00FFFFFF00DE9E6B00DE9E6B00FFFFFF00DE9E6B00A58E
      7B00D6BEAD004A281800C0C0C000C0C0C000C0C0C000C0C0C000BD9E8C00FFFF
      FF00FFFFFF004A2818004A2818004A2818004A2818000018F7003141FF00BD9E
      8C00D6BEAD004A281800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E
      7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000010AD00FFFFFF00FFFF
      FF00A58E7B00D6BEAD004A281800C0C0C000BD494200BD494200C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000018F7005271FF000018F70000008400C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A58E
      7B004A281800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000BD9E8C00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000018F700BD9E
      8C004A281800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E
      7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A58E7B004A281800C0C0C000C0C0C000BD494200C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000018F7000018F700C0C0C000C0C0C000C0C0C000A58E7B00A58E
      7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E
      7B00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000BD9E8C00BD9E
      8C00BD9E8C00BD9E8C00BD9E8C00BD9E8C00BD9E8C00BD9E8C00BD9E8C00BD9E
      8C00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E
      7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E
      7B00A58E7B00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0004A2818004A28
      18004A2818004A2818004A2818004A2818004A2818004A2818004A2818004A28
      18004A2818004A2818004A281800C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000B54918008C2000008C2000008C2000008C2000008C20
      00008C2000008C200000C0C0C000C0C0C000C0C0C000B59E8C00F7EFE700A58E
      7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E
      7B00A58E7B00A58E7B00A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000840000008400000084000000840000008400000084000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008C1800008C18
      00008C1800008C180000B5491800FFC78C00FFC78C00FFC78C00FFBE7B00FFAE
      6300FF9E39008C200000C0C0C000C0C0C000C0C0C000B59E8C00F7F7EF00F7EF
      E700EFE7E700EFE7DE00E7DFD600E7D7CE00E7D7CE00DECFC600DEC7BD00D6C7
      B500D6BEB500D6BEAD00A58E7B004A2818000000000000000000000000000000
      000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008C180000C0C0
      C000C0C0C000C0C0C000B5491800B5491800B5491800B5491800B5491800B549
      1800B5491800B5491800C0C0C000C0C0C000C0C0C000B59E8C00FFF7F700F7F7
      EF00F7EFE700841800008418000084180000E7D7CE00E7D7CE00841800008418
      000084180000D6BEB500A58E7B004A28180000000000FFFFFF00000000000000
      000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FFFF
      FF00000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008C180000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000B59E8C00FFFFFF00FFF7
      F700F7F7EF00F7EFE70084180000EFE7DE00E7DFD600E7D7CE00E7D7CE008418
      0000DEC7BD00D6C7B500A58E7B004A28180000000000FFFFFF00000000000000
      000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FFFF
      FF00000000000000000000000000C0C0C0000000000000000000000000008486
      840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000848684000000000000000000C0C0C000C0C0C000C0C0C0008C180000C0C0
      C000C0C0C000C0C0C000B54918008C2000008C2000008C2000008C2000008C20
      00008C2000008C200000C0C0C000C0C0C000C0C0C000B59E8C00108610000071
      000010860800F7F7F70042A64200841800008418000084180000841800008418
      0000DECFC600DEC7BD00A58E7B004A2818000000000000000000000000000000
      0000000000000000000000000000C0C0C0000000000000000000000000000000
      0000000000000000000000000000C0C0C00084868400FFFFFF00FFFFFF000000
      0000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0C0008C1800008C18
      00008C1800008C180000B5491800FFC78C00FFC78C00FFC78C00FFBE7B00FFAE
      6300FF9E39008C200000C0C0C000C0C0C000C0C0C000B59E8C00C6E7C6000079
      0000EFF7EF00FFFFF700F7F7F70008860800841800009CC79400EFDFDE008418
      0000E7D7CE00DECFC600A58E7B004A2818000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000C0C0C00084868400FFFFFF0000000000FFFF
      FF000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0C0008C180000C0C0
      C000C0C0C000C0C0C000B5491800B5491800B5491800B5491800B5491800B549
      1800B5491800B5491800C0C0C000C0C0C000C0C0C000B59E8C00FFFFFF0052B6
      52008CCF8C00FFFFFF00B5DFAD00007100002996290084180000EFE7DE008418
      0000E7DFD600E7D7CE00A58E7B004A2818000000000000000000FFFFFF000000
      00000000000000000000C0C0C0000000000000000000FFFFFF00000000000000
      0000000000000000000000000000C0C0C00084868400FFFFFF00000000000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0C0008C180000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000B59E8C00FFFFFF00CEEF
      CE00007100000071000000710000007100008CC78400F7EFEF00841800008418
      0000EFDFDE00E7DFD600A58E7B004A2818000000000000000000FFFFFF000000
      00000000000000000000C0C0C0000000000000000000FFFFFF00000000000000
      0000000000000000000000000000C0C0C00084868400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0C0008C180000C0C0
      C000C0C0C000C0C0C000B54918008C2000008C2000008C2000008C2000008C20
      00008C2000008C200000C0C0C000C0C0C000C0C0C000B59E8C00FFFFFF00FFFF
      FF0029962900C6E7C6000079000000790000EFF7EF00F7F7F700F7EFEF008418
      0000EFE7DE00EFDFDE00A58E7B004A281800C0C0C00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C00084868400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0C0008C1800008C18
      00008C1800008C180000B5491800FFC78C00FFC78C00FFC78C00FFBE7B00FFAE
      6300FF9E39008C200000C0C0C000C0C0C000C0C0C000B59E8C00FFFFFF00FFFF
      FF0094D79400188E18000071000042A64200FFFFFF00FFFFF700F7F7F700F7EF
      EF00EFEFE700EFE7DE00A58E7B004A281800C0C0C000C0C0C00000000000FFFF
      FF00000000000000000000000000C0C0C00000000000FFFFFF00000000000000
      000000000000C0C0C000C0C0C000C0C0C00084868400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF0000000000FFFFFF000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0C0008C180000C0C0
      C000C0C0C000C0C0C000B5491800B5491800B5491800B5491800B5491800B549
      1800B5491800B5491800C0C0C000C0C0C000C0C0C000B59E8C00FFFFFF00FFFF
      FF00FFFFFF000886080000710000ADDFAD00FFFFFF00FFFFFF00FFFFF700F7F7
      F700F7EFEF00EFEFE700A58E7B004A281800C0C0C000C0C0C000000000000000
      0000000000000000000000000000C0C0C0000000000000000000000000000000
      000000000000C0C0C000C0C0C000C0C0C00084868400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0C0008C180000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000B59E8C00FFFFFF00FFFF
      FF00FFFFFF005AB65A0008860800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFF7F700F7F7EF00A58E7B004A281800C0C0C000C0C0C000C0C0C0000000
      00000000000000000000C0C0C000C0C0C000C0C0C00000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C00084868400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C0C0C000B54918008C1800008C1800008C18
      00008C1800008C1800008C1800008C180800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000B59E8C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFF7F700F7F7EF004A281800C0C0C000C0C0C000C0C0C0000000
      0000FFFFFF0000000000C0C0C000C0C0C000C0C0C00000000000FFFFFF000000
      0000C0C0C000C0C0C000C0C0C000C0C0C00084868400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C0C0C000B5491800FFC78C00FFC78C00FFC7
      8C00FFBE7B00FFAE6300FF9E39008C180000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000B59E8C00B59E
      8C00B59E8C00B59E8C00B59E8C00B59E8C00B59E8C00B59E8C00B59E8C00B59E
      8C00B59E8C00B59E8C00B59E8C00C0C0C000C0C0C000C0C0C000C0C0C0000000
      00000000000000000000C0C0C000C0C0C000C0C0C00000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C0008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000840000008400000084000000C0C0C000B5491800B5491800B5491800B549
      1800B5491800B5491800B5491800B5491800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000840000008400000084000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      000000000000C0C0C000C0C0C0000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000840000008400
      000084000000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00084000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008400
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00084000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      000000000000C0C0C000C0C0C0000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      000000000000C0C0C000C0C0C0000000000000000000C0C0C000840000008400
      0000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000084000000
      840000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000008400C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      8400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      000000000000C0C0C000C0C0C0000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000084000000
      8400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      00000000000000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000000000000000000084868400C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000084868400C0C0C000848684000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000848684000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000000000000000000084868400C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000848684000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000084868400C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000848684000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000000084868400C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000C0C0C0000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000084868400848684008486840084868400848684008486
      840084868400848684008486840000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C000C0C0C00084000000C0C0
      C00084000000C0C0C000C0C0C000C0C0C000840000008400000084000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      000000000000FF00000084868400FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFF
      FF0000FFFF00FFFFFF008486840000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00084000000C0C0
      C00084000000C0C0C000C0C0C000C0C0C000840000008400000084000000C0C0
      C000C0C0C0000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C00000000000FF00
      0000FF000000FF00000084868400FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFF
      FF00FFFFFF00FFFFFF008486840000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00084000000C0C0
      C00084000000C0C0C000C0C0C000C0C0C000840000008400000084000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FF000000FF00
      0000FF000000FF00000084868400FFFFFF0000FFFF0084000000840000008400
      000084868400FFFFFF008486840000000000C0C0C000C0C0C000C0C0C0000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C000C0C0C00084000000C0C0
      C00084000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FF000000FF00
      0000FF000000FF00000084868400FFFFFF0084860000FF000000FF000000FF00
      000084000000FFFFFF008486840000000000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000C0C0C000C0C0C00000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000848684008400000084000000C0C0
      C00084000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FF000000FF000000FF00
      0000FF000000FF00000084868400FFFFFF00848600008486840000860000FF00
      000084000000FFFFFF008486840000000000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000C0C0C000C0C0C00000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000840000008400000084000000C0C0
      C00084000000C0C0C000C0C0C000C0C0C000840000008400000084000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FF000000FF000000FF00
      0000008600000086000084868400FFFFFF0084860000FFFFFF00848684000086
      000084000000FFFFFF008486840000000000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000C0C0C000C0C0C00000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000000
      0000000000000000000000000000C0C0C000840000008400000084000000C0C0
      C00084000000C0C0C000C0C0C000C0C0C000840000008400000084000000C0C0
      C000C0C0C0000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C00000000000FF000000FF0000000086
      0000008600000086000084868400FFFFFF0000FFFF0084860000848600008486
      000084868400FFFFFF008486840000000000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008486840084000000840000008400
      00008400000084000000C0C0C000C0C0C000840000008400000084000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FF000000FF0000000086
      0000008600000086000084868400FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFF
      FF0000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000C0C0C000C0C0C00000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FF000000FF000000C0C0
      C000008600000086000084868400FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFF
      FF0084868400FFFFFF0084868400C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000C0C0C000C0C0C00000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00084868400FF000000FF00
      0000FFFFFF00C0C0C00084868400FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFF
      FF008486840084868400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000C0C0C000C0C0C00000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000840000008400000084000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00084868400FF000000FFFF
      FF00C0C0C000FFFFFF0084868400848684008486840084868400848684008486
      84008486840000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000840000008400000084000000C0C0
      C000C0C0C0000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C00084868400FF00
      0000FF000000C0C0C000FFFFFF00C0C0C0000086000000860000008600000086
      000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000840000008400000084000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008486
      840084868400FF000000FF000000FFFFFF00C0C0C00000860000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0008486840084868400848684008486840084868400C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0004A2818004A28
      18004A2818004A2818004A2818004A2818004A2818004A2818004A2818004A28
      18004A2818004A2818004A281800C0C0C000C0C0C00000410000004100000041
      0000004100000041000000410000004100000041000000410000004100000041
      00000041000000410000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000BD280000A5381000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000B59E8C00F7EFE700A58E
      7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E
      7B00A58E7B00A58E7B00A58E7B004A281800C0C0C000C0C0C000299E29004AEF
      4A0031D7310029CF290018B6180010AE1000109E1000088E080000860000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000BD280000CE4918009C411800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000C0C0
      C00000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00000000000C0C0C000B59E8C00F7F7EF00F7EF
      E700EFE7E700EFE7DE00E7DFD600E7D7CE00E7D7CE00DECFC600DEC7BD00D6C7
      B500D6BEB500D6BEAD00A58E7B004A281800C0C0C000C0C0C000C0C0C0000041
      000000410000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000BD280000CE4918009C411800C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000C0C0
      C000C0C0C000C0C0C000000000008486000000000000C0C0C000000000000000
      000000000000C0C0C0000000000000000000C0C0C000B59E8C00FFF7F700F7F7
      EF00F7EFE700841800008418000084180000E7D7CE00E7D7CE00841800008418
      000084180000D6BEB500A58E7B004A281800C0C0C000C0C0C000C0C0C0000041
      000008A6100000410000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000BD28
      0000CE4918009C411800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000C0C0
      C000C0C0C000C0C0C000000000008486000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00000000000C0C0C000B59E8C00FFFFFF00FFF7
      F700F7F7EF00F7EFE70084180000EFE7DE00E7DFD600E7D7CE00E7D7CE008418
      0000DEC7BD00D6C7B500A58E7B004A281800C0C0C000C0C0C000C0C0C0009C69
      4A0021C7210008A6100000410000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6411800C641
      1800EF713900D6592900C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000000000000000000000000000848600008486000000000000000000000000
      000000000000000000000000000000000000C0C0C000B59E8C00108610000071
      000010860800F7F7F70042A64200841800008418000084180000841800008418
      0000DECFC600DEC7BD00A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0
      C0009C694A0021C7210008A6100000410000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000BD280000EF71
      39009C411800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000C0C0
      C000C0C0C000000000008486000084860000000000008486000000000000C0C0
      C000C0C0C000C0C0C000C0C0C00000000000C0C0C000B59E8C00C6E7C6000079
      0000EFF7EF00FFFFF700F7F7F70008860800841800009CC79400EFDFDE008418
      0000E7D7CE00DECFC600A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0009C694A0021C7210008A6100010860000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6411800F79E7300EF71
      39009C411800C0C0C000C0C0C000C0C0C0008418000084180000841800008418
      00008418000084180000B5491800C0C0C00000000000C0C0C000C0C0C000C0C0
      C00000000000848600000000000084860000000000008486000000000000C0C0
      C0000000000000000000C0C0C00000000000C0C0C000B59E8C00FFFFFF0052B6
      52008CCF8C00FFFFFF00B5DFAD00007100002996290084180000EFE7DE008418
      0000E7DFD600E7D7CE00A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C0009C694A00CEE7C600FFDF840084414200C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000BD280000F79E7300EF71
      39009C411800C0C0C000C0C0C000C0C0C000C0C0C00084180000F79E7300EF71
      3900EF713900EF713900B5491800C0C0C0000000000000000000C0C0C000C0C0
      C000000000008486000000000000848600000000000000000000C0C0C0000000
      000000FFFF0000FFFF000000000000000000C0C0C000B59E8C00FFFFFF00CEEF
      CE00007100000071000000710000007100008CC78400F7EFEF00841800008418
      0000EFDFDE00E7DFD600A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C0009C694A00FFFFB500FFDF840084414200C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000BD280000F79E7300EF71
      39009C411800C0C0C000C0C0C000C0C0C000C0C0C00084180000DE693900DE71
      4200DE714A00EF713900B5491800C0C0C000000000000000000000000000C0C0
      C000C0C0C00000000000000000008486000000000000C0C0C000C0C0C0000000
      000000FFFF0000FFFF000000000000000000C0C0C000B59E8C00FFFFFF00FFFF
      FF0029962900C6E7C6000079000000790000EFF7EF00F7F7F700F7EFEF008418
      0000EFE7DE00EFDFDE00A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0009C694A00FFFFB500FFDF84008441
      42001010100010081000C0C0C000C0C0C000C0C0C000C6411800F79E7300EF71
      3900C651290084180000C0C0C000C0C0C00084180000C6512900DE714200DE71
      4A00F79E7300EF713900B5491800C0C0C0000000000000000000000000000000
      0000C0C0C000C0C0C000000000008486000000000000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C00000000000C0C0C000B59E8C00FFFFFF00FFFF
      FF0094D79400188E18000071000042A64200FFFFFF00FFFFF700F7F7F700F7EF
      EF00EFEFE700EFE7DE00A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0009C694A00FFFFB5001810
      18002928290018101800C0C0C000C0C0C000C0C0C000D6592900F7864A00F79E
      7300EF713900C65129008418000084180000C6512900DE714200DE714A00C651
      2900B5491800F79E7300B5491800C0C0C000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00000000000C0C0C000B59E8C00FFFFFF00FFFF
      FF00FFFFFF000886080000710000ADDFAD00FFFFFF00FFFFFF00FFFFF700F7F7
      F700F7EFEF00EFEFE700A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000292829004238
      420042384200292829001810180010081000C0C0C000C0C0C000C6411800F786
      4A00F79E7300DE613100DE693900DE694200DE714200DE714A00C6512900B549
      1800C0C0C000B5491800B5491800C0C0C0000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00000000000C0C0C000B59E8C00FFFFFF00FFFF
      FF00FFFFFF005AB65A0008860800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFF7F700F7F7EF00A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000292829002928
      290042384200423842002928290010101000C0C0C000C0C0C000C0C0C000D659
      2900C6411800F79E7300F79E7300F79E7300F79E7300F79E7300B5491800C0C0
      C000C0C0C000C0C0C000B5491800C0C0C00000000000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000B59E8C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFF7F700F7F7EF004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00029282900423842002928290010101000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000F7511800B5491800B5491800B5491800F7511800C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000B59E8C00B59E
      8C00B59E8C00B59E8C00B59E8C00B59E8C00B59E8C00B59E8C00B59E8C00B59E
      8C00B59E8C00B59E8C00B59E8C00C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000292829002928290018101800C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000BD3808008418000084180000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000D69673007B2808007B2808007B2808007B28
      08007B2808007B2808007B2808007B280800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C69694004A2818004A2818004A2818004A2818004A28
      18004A2818004A2818004A2818004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000E7612900BD380800BD380800BD38080084180000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000D6967300F7DFCE00F7D7C600EFCFBD00EFC7
      AD00EFBEA500E7B69400E7B694007B280800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C6969400EFE7DE00B5968400B5968400B5968400B596
      8400B5968400B5968400B59684004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000A5381000BD280000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000E7612900BD380800E7612900EF8E5A0084180000C0C0C000C0C0C000BD38
      0800BD3808008C300000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000D6967300F7E7DE00F7DFCE00F7D7C600EFCF
      BD00EFCFB500EFC7A500EFBE9C007B280800C0C0C00000285200002852000028
      52000028520000285200C6969400F7EFE700EFE7DE00E7DFD600E7D7CE00DECF
      C600DEC7BD00D6BEB500B59684004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0009C411800CE491800BD280000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000E7612900BD380800C0C0C000EF8E5A0084180000C0C0C000BD380800BD38
      08008C3000008C3000008C300000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000D6967300FFF7EF00C6693900C6693900C669
      3900C6693900C6693900EFC7A5007B2808000071BD005ACFEF000071BD000071
      BD000071BD000071BD00C6969400F7F7EF00CE862900CE862900CE862900CE86
      2900CE862900DEC7BD00B59684004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0009C411800CE491800BD28
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000E7612900EF8E5A008C3000008C30000084180000C0C0C000BD380800E761
      2900EF8E5A008C30000084180000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000D6967300FFFFFF00FFF7F700FFEFE700F7E7
      D600F7DFCE00F7D7BD00EFCFB5007B2808000071BD006BD7EF005ACFEF0052C7
      E7004ABEE70042BEE700C6969400FFFFFF00FFF7F700F7EFEF00EFE7E700E7DF
      D600E7D7CE00DECFC600B59684004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0009C411800CE49
      1800BD280000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000E7612900EF8E5A008C3000008418000084180000BD380800C0C0
      C000E76129008C30000084180000C0C0C000C6A694005A4129005A4129005A41
      29005A4129005A4129005A412900D6967300FFFFFF00C6693900C6693900C669
      3900C6693900C6693900F7D7BD007B2808000071BD0073DFF7006BD7EF005ACF
      EF0052C7E7004ABEE700C6969400FFFFFF00CE862900CE862900CE862900CE86
      2900CE862900E7D7CE00B59684004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000D6592900EF71
      3900C6411800C6411800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000E7612900842800008C30100084180000BD3808008C30
      00008418000084180000C0C0C000C0C0C000C6A69400EFE7DE00E7DFD600E7D7
      CE00DECFBD00D6C7B500D6BEAD00D6967300FFFFFF00FFFFFF00FFFFFF00FFF7
      F700FFEFE700F7E7D600F7DFCE007B2808000071BD007BE7F70073DFF7006BD7
      EF005ACFEF0052C7E700C6969400FFFFFF00FFFFFF00FFFFFF00FFF7F700F7EF
      EF00EFE7E700E7DFD600B59684004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0009C41
      1800EF713900BD280000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00052413900A58E7B008C412100841800008418
      0000BD380800C0C0C000C0C0C000C0C0C000C6A69400F7EFE700EFE7DE00E7DF
      D600E7D7CE00DECFC600DEC7BD00D6967300FFFFFF00C6693900C6693900FFFF
      FF00D69673009438100094381000943810000071BD007BE7F7007BE7F70073DF
      F7006BD7EF005ACFEF00C6969400FFFFFF00CE862900CE862900CE862900FFF7
      F700F7EFEF00C69694004A2818004A281800C0C0C000B5491800841800008418
      000084180000841800008418000084180000C0C0C000C0C0C000C0C0C0009C41
      1800EF713900D6592900C6512900C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00052413900C6B6AD00BD9E8C0052413900C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6A69400F7F7EF00D6966B00D696
      6B00D6966B00D6966B00D6966B00D6967300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D6967300EFE7DE0094381000C0C0C0000071BD007BE7F7007BE7F7007BE7
      F70073DFF7006BD7EF00C6969400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFF7F700C6969400FFFFFF004A281800C0C0C000B5491800EF713900EF71
      3900EF713900EF71390084180000C0C0C000C0C0C000C0C0C000C0C0C0009C41
      1800EF713900D6592900BD280000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00052413900D6C7BD0052413900D6BEAD0052413900C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6A69400FFFFFF00FFF7F700F7EF
      EF00EFE7E700E7DFD600E7D7CE00D6967300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E7967300B5491800C0C0C000C0C0C0000071BD007BE7F7007BE7F7007BE7
      F7007BE7F70073DFF700C6969400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C69694004A281800C0C0C000C0C0C000B5491800EF713900DE71
      4A00DE714200DE69390084180000C0C0C000C0C0C000C0C0C000C0C0C0009C41
      1800EF713900D6592900BD280000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00052413900E7DFD6005241390094796300E7D7CE0052413900C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6A69400FFFFFF00D6966B00D696
      6B00D6966B00D6966B00D6966B00D6967300D6967300D6967300D6967300D696
      7300D6967300C0C0C000C0C0C000C0C0C0000071BD007BE7F7007BE7F7007BE7
      F7007BE7F7007BE7F700C6969400C6969400C6969400C6969400C6969400C696
      9400C6969400C6969400C0C0C000C0C0C000C0C0C000B5491800EF713900F79E
      7300DE714A00DE714200C651290084180000C0C0C000C0C0C00084180000F79E
      7300EF713900D6592900C6411800C0C0C000C0C0C000C0C0C000C0C0C0009479
      6300FFFFFF0052413900C0C0C00094796300E7DFD60052413900C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6A69400FFFFFF00FFFFFF00FFFF
      FF00FFF7F700F7EFEF00EFE7E700E7DFD6004A281800C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000071BD007BE7F7007BE7F7000041
      8400002852000028520000285200002852000028520000285200002852000071
      BD0000285200C0C0C000C0C0C000C0C0C000C0C0C000B5491800F79E7300B549
      1800F79E7300DE714A00DE714200C65129008418000084180000F79E7300EF71
      3900EF713900D6592900C6512900C0C0C000C0C0C000C0C0C000C0C0C0009479
      630052413900C0C0C000C0C0C00094796300F7EFE70052413900C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6A69400FFFFFF00D6966B00D696
      6B00FFFFFF00C6A694004A2818004A2818004A281800C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000071BD007BE7F7007BE7F7000041
      84007BE7F70052C7E7000028520052C7E70031AEDE000079BD00002852000071
      BD0000285200C0C0C000C0C0C000C0C0C000C0C0C000B5491800B5491800C0C0
      C000B5491800F79E7300DE714A00DE714200DE694200DE693900DE613100EF71
      3900D6592900C6411800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0009479
      6300C0C0C000C0C0C000C0C0C00094796300FFFFFF0052413900C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6A69400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6A69400EFE7DE004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000071BD007BE7F7007BE7F7007BE7
      F700004184007BE7F700002852000028520052C7E700002852004ABEE7004ABE
      E70000285200C0C0C000C0C0C000C0C0C000C0C0C000B5491800C0C0C000C0C0
      C000C0C0C000B5491800F79E7300F79E7300F79E7300F79E7300EF713900C641
      1800C6512900C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C0009479630052413900C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6A69400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6A694004A281800C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000071BD000071BD000071
      BD000071BD00004184007BE7F7007BE7F700002852000071BD000071BD000071
      BD00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000F7511800B5491800B5491800B5491800F7511800C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00094796300C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6A69400C6A69400C6A69400C6A6
      9400C6A69400C6A69400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000418400004184000041840000418400C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B004A28
      18004A2818004A2818004A2818004A2818004A2818004A2818004A2818004A28
      18004A2818004A2818004A281800C0C0C000C0C0C000C0C0C000522818005228
      1800522818005228180052281800522818005228180052281800522818005228
      180052281800522818005228180052281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00EFDF
      DE00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E
      7B00A58E7B00A58E7B004A281800C0C0C000C0C0C000C6515200C6797B00BD71
      730052412900AD9E9400B5AEA500BDB6AD00BDB6AD00BDB6AD00BDB6AD007359
      4A007B2829007B2829007B28290052281800C0C0C0006B4131006B4131006B41
      31006B4131006B4131006B4131006B4131006B4131006B4131006B4131006B41
      3100C0C0C000C0C0C000C0C0C000C0C0C0006B79840000417300004173000041
      7300004173000041730000417300004173000041730000417300004173000041
      7300C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00EFE7
      DE00EFDFDE00E7DFD600E7D7CE00DECFC600DECFC600D6C7BD00D6BEB500D6BE
      AD00D6BEAD00A58E7B004A281800C0C0C000C0C0C000C6515200CE8E8400C679
      7B00524129001808080042302900FFFFFF00FFFFFF00FFFFFF00EFDFD6007359
      4A007B2829007B2829007B282900522818008C716300FFFFFF00A58E7B00A58E
      7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E
      7B006B413100C0C0C000C0C0C000C0C0C0006B7984006B798400108EC6000079
      BD000079BD000079BD000079BD000079BD000079BD000079BD000079BD000041
      7300C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00F7EF
      E700EFE7DE00EFDFDE00E7DFD600E7D7CE00DECFC600DECFC600D6C7BD00D6BE
      B500D6BEAD00A58E7B004A281800C0C0C000C0C0C000C6515200D6968C00CE8E
      8400524129000000000021100800FFFFFF00F7EFEF00EFDFD600DEBEAD007359
      4A00843031007B2829007B282900522818008C716300FFFFFF00FFFFFF00FFFF
      FF00FFF7EF00F7EFDE00F7DFCE00F7D7BD00EFCFB50010204200E7BE9400A58E
      7B006B4131006B413100C0C0C000C0C0C0006B7984006B7984005AAEC60042CF
      F70042CFF70039C7EF0031BEEF0029B6EF0021B6E70021AEE70018A6E7000079
      BD0000417300C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00F7EF
      EF00F7EFE700EFE7DE00EFDFDE00E7DFD600E7D7CE00DECFC600DECFC600D6C7
      BD00D6BEB500A58E7B004A281800C0C0C000C0C0C000C6515200DE9E9400D696
      8C00524129005241290052412900524129005241290052412900524129005241
      29008C383900843031007B282900522818008C716300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFF7EF00F7EFDE00F7DFCE00F7D7BD00299E3100EFC7A500A58E
      7B008C716300946142006B413100C0C0C0006B7984004AD7F7006B79840052C7
      E7004ACFF70042CFF70039C7EF0031BEEF0029BEEF0029B6E70021AEE70010A6
      E70000417300C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00F7F7
      F700F7EFEF00F7EFE700EFE7DE00EFDFDE00E7DFD600E7D7CE00DECFC600DECF
      C600D6C7BD00A58E7B004A281800C0C0C000C0C0C000C6515200E7AEA500E7A6
      9C00D6969400CE8E8C00C6867B00BD717300B5696B00AD615A00A55952009C51
      4A00944142008C38390084303100522818008C716300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFF7EF00F7EFDE00F7DFCE00F7D7BD00EFCFB500EFC7
      A5008C716300A5795A006B413100C0C0C0006B79840063E7F7006B7984005AB6
      CE004AD7F7004AD7F70042CFF70039C7EF0031BEEF0029BEEF0029B6E70021AE
      E7000079BD0000417300C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00F7F7F700F7EFEF00F7EFE700EFE7DE00EFDFDE00E7DFD600E7D7CE00DECF
      C600DECFC600A58E7B004A281800C0C0C000C0C0C000C6515200EFB6AD00E7AE
      A500E7A69C00D6969400CE8E8C00C6867B00C6797300BD716B00B5696300AD59
      5A009C514A00944142008C383900522818008C7163008C7163008C7163008C71
      63008C7163008C7163008C7163008C7163008C7163008C7163006B4131006B41
      31008C716300B5866B006B413100C0C0C0006B7984006BEFF7004AD7F7006B79
      840052C7E7004AD7F7004AD7F70042CFF70039C7EF0031BEEF0029BEEF0029B6
      E70018A6DE0000417300C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00F7F7F700F7EFEF00F7EFE700EFE7DE00EFDFDE00E7DFD600E7D7
      CE00DECFC600A58E7B004A281800C0C0C000C0C0C000C6515200EFB6AD00EFB6
      AD00BD494200BD494200BD494200BD494200BD494200BD494200BD494200BD49
      4200BD494200A55152009C494A00522818008C716300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7EF00F7EFDE00F7DFCE00F7D7
      BD008C716300C69E7B006B413100C0C0C0006B79840073F7F7006BEFF7006B79
      84005AB6CE004AD7F7004AD7F7004AD7F70042CFF70039C7F70031BEEF0029BE
      EF0021B6E7000079BD0000417300C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFF7F700F7F7EF00F7EFEF00EFE7E700EFE7DE00E7DF
      D600E7D7CE00A58E7B004A281800C0C0C000C0C0C000C6515200EFB6AD00BD49
      4200FFF7EF00F7EFE700EFE7DE00EFDFCE00E7D7C600E7CFBD00DEC7B500DEBE
      AD00DEBEAD00BD494200A551520052281800C0C0C0008C7163008C7163008C71
      63008C7163008C7163008C7163008C7163008C7163008C7163008C7163008C71
      6300CEA684007B695A006B413100C0C0C0006B7984007BF7F70073F7F7004AD7
      F7006B7984006B7984006B7984006B7984006B7984006B7984006B7984006B79
      84006B7984006B7984006B798400C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7F7EF00F7EFEF00EFE7E700EFE7
      DE00E7DFD600A58E7B004A281800C0C0C000C0C0C000C6515200EFB6AD00BD49
      4200FFFFFF00FFF7F700F7EFEF00F7E7DE00EFDFD600E7D7CE00E7CFC600DEC7
      BD00DEBEAD00BD494200AD595A0052281800C0C0C000C6969400C6969400FFFF
      FF00FFFFFF00FFFFFF00FFF7F700F7F7EF00F7EFEF00EFEFE700EFE7DE006B41
      310094796300CEA684006B413100C0C0C0006B7984007BF7F7007BF7F70073F7
      F7004AD7F7004AD7F7004AD7F7004AD7F7004AD7F7004AD7F7004AD7F7004AD7
      F7006B798400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7F7EF00F7EFEF00EFE7
      E700A58E7B00A58E7B004A281800C0C0C000C0C0C000C6515200EFB6AD00BD49
      4200FFFFFF00FFFFFF00FFF7F700F7EFEF00F7E7DE00EFDFD600E7D7CE00E7CF
      C600DEC7BD00BD494200B569630052281800C0C0C000C0C0C000C0C0C000C696
      9400FFFFFF00C6A69400C6A69400C6A69400C6A69400C6A69400EFEFE7006B41
      31006B4131006B4131006B413100C0C0C0006B7984007BF7F7007BF7F7007BF7
      F70073F7F7004AD7F7006B7984006B7984006B7984006B7984006B7984006B79
      840084180000841800008418000084180000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7F7EF00A58E
      7B004A2818004A2818004A281800C0C0C000C0C0C000C6515200EFB6AD00BD49
      4200FFFFFF00FFFFFF00FFFFFF00FFF7F700F7EFEF00F7E7DE00EFDFD600E7D7
      CE00E7CFC600BD494200BD716B0052281800C0C0C000C0C0C000C0C0C000C696
      9400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7F7EF00F7EFEF00EFEF
      E7006B413100C0C0C000C0C0C000C0C0C0006B7984007BF7F7007BF7F7007BF7
      F7007BF7F7006B798400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00084180000DE8E6B0084180000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700A58E
      7B00EFE7DE00D6BEAD004A281800C0C0C000C0C0C000C6515200EFB6AD00BD49
      4200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7EFEF00F7E7DE00EFDF
      D600E7D7CE00BD494200C6797B0052281800C0C0C000C0C0C000C0C0C000C0C0
      C000C6969400FFFFFF00C6A69400C6A69400C6A69400C6A69400C6A69400F7EF
      EF006B4131006B413100C0C0C000C0C0C000C0C0C0006B7984006B7984006B79
      84006B798400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000AD5121008418000084180000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A58E
      7B00D6BEAD004A281800C0C0C000C0C0C000C0C0C000C6515200EFB6AD00BD49
      4200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7EFEF00F7E7
      DE00EFDFD600BD4942000000000052281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C6969400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7F7
      EF00F7EFEF006B413100C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00084180000AD512100C0C0
      C000AD51210084180000C0C0C00084180000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A58E
      7B004A281800C0C0C000C0C0C000C0C0C000C0C0C000C6515200EFB6AD00BD49
      4200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7EF
      EF00F7E7DE00BD494200BD716B0052281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C6969400C6969400C6969400C6969400C6969400C6969400C696
      9400C6969400C6969400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000841800008418
      000084180000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00A58E
      7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E
      7B00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6515200C6515200C651
      5200C6515200C6515200C6515200C6515200C6515200C6515200C6515200C651
      5200C6515200C6515200C6515200C6515200C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000424D3E000000000000003E000000
      2800000040000000200100000100010000000000000900000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFE7F00000000FFFFF00F00000000
      FFFFE00700000000FFFFC0030000000080008001000000000000800100000000
      0000800100000000000000000000000000000000000000000000800100000000
      000080010000000000008001000000000000C003000000000000E00700000000
      0000F00F000000000000FC3F00000000F03F00000000FFFFE01F00000000F0C3
      C00700000000F1E3800700000000F9A30F0300000000F0C32F8300000000C000
      07C1000000008000038000000000800081C000000000C00001E200000000C000
      C3E400000000C019C1F800000000C003C001000000004003E00100000000C03F
      F00300000000FFFFFC0F00000000FFFF8000FFFFFFFF9FCF0000FFFFFFFF9FCF
      1000FFFFFFFF87C30000FFFF800187C30000FFFF000000000000800000000000
      000000000000000000001000000097CB00000000000097CB00000000000097CB
      00000000000097CB00000000000087C3000000000000E7F3000800000000F7FB
      000000000000F7FB000100010000FFFFFFFFFFFFFE3FFE3FFF9FFE7FFC3FFE3F
      FF0FFE3FF83F023FFE07FE1FF03F023FFC03FE0FE000E03FF8018007C000E07F
      F00180038000E0FFE00380010000E00FC00780010000900F800780038000802F
      80078007C000883F8007800FE000C03FC007FE1FF03FC01FE007FE3FF83FFF0F
      FC0FFE7FFC3FFE0FFF9FFEFFFE3FFF0FFFFFFFFFFFFF0000FFFFFFFF80010000
      FFFF800100010000FFFF000100010000BFFF0001000100007000000100010000
      70000001000100006000000100010000A0000001000100008000000100010000
      E000000100010000E000000100010000F000000100011FE0F000000100011FF0
      FFFFFFFF00011FF8FFFFFFFFFFFF0000000000009182FFFF000000000000FC3F
      000000000000F00F000000000000E007000000000000C003000000000000C003
      0000000000008001000000000000800100000000000080010000000000008001
      000000000000C003000000000000C003000000000000E007000000000000F00F
      000000000000FC3F000000000000FFFF00000000000000000000000000000000
      0000000007F00000028002800FF80000054005401FF8000000A000A01FFC0000
      001000103FFC00000028002877FC00000010001067FE00000008000807F60000
      201020100DB60000300030000DB200001C001C0019B000000F000F0019B00000
      00000000018000000000000000000000FF7FFFF7F87FFE7FFF3FFFE7C000FC3F
      FF1FFFC08000F81FF81F00008000F00FE00F00008000E007C00700008000C003
      8003000080008001000100038000000000000003800000000000000380008001
      000000038000C003000000038000E007000080078000F00F8001C00FC000F81F
      C003E01FF07FFC3FF00FF03FFC7FFE7FDFFFFFFFFC00E0008FE70381F800E000
      07C30381E000E00083870381C000C000C10F038180008000E01F038180000000
      F03F000100000000F839000100000000F0188003000080008000C0070000C000
      0303C1070001E0000383C1078003E0006387E38F8003E000E20FE38FC007E001
      C41FFFFFE00FE003FFFFFFFFF83FE007FFFFC001C00180008000C001C0010000
      8000C001C00100008000C001C00180008000C001C001C000001FC001C001E000
      003FC001C001E000003FC001C001E000101FC001C001E000000FC001C001E000
      0307C001C001E0000783C001C001E0000FC1C001C001E0001FE0C003C003E001
      3FF0C007C007E0037FF9C00FC00FE007C001FFFFFFFFFC038000FFFFF81FC003
      800007C1F81FDC03800007C1F00FDFFF800007C10001DC03800001010001C003
      800000010001DC03800002010001DFFF800002010001DC03800080030001C003
      8000C1070001DC038000C1070001DFFF8000E38F000100FF8000E38F000100FF
      C001E38F000100FFFFFFFFFF0001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFF0030003FFFFFFFFFFFFFFFFE67FFFC700030003F0FFFFDF
      FFFFFFFFF9FFFFEFF0030003F0FFFFF7FFFFFFFFE67FE64F00030003FFC7F0FF
      FFFFFFFFFFDFF9FFF0030003FFEFF0FFFFFFFFFFFFF7E67F00030003FFCFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFE00FFFFFFFFFFFFFFFFF003FC00FE07FF83FFFFFFFFFF8FFF11F00030003
      F8FFF39FFFFFFFFFFC7FF39F003FC00FFC7FF39FFFFFFFFFFE3FF39F00030003
      FE3FF39FFFFFFFFFFF1FF39F003FC00FFE0FE10FFFFFFFFFFFFFFFFF00030003
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC00FFFFFFFFFFFFF800FFFF
      81D71FFFE000FFFFFFD71803C000FFFFFFD71FFF8000E01F81D7FFFF8000F18F
      FF17FFFF0000F18FFF171FFF0000F18F811718030000F01FFF031FFF0000F18F
      FFFFFFFF1001F18F8003FFFF8403F18FFFFF1FFF8803E01FFFFF1803C507FFFF
      F8031FFFE08FFFFFFFFFFFFFF83FFFFFFFFFFFFFC0018003FCFFC0008000C01F
      F8FFD0FE8000E7FFF1FFDC448000E3FFE3FFDC7E8000E1FFC3FFC0008000F0FF
      C7FFD81E8000F87F870170128000FC3F878130208000FE1F878118608000FF03
      83010C728000FF8380011EFE8000FFC0C0093FFE8000FFC0E01D60008000FFF0
      F83FFFFFC001FFF1FFFFFFFFFFFFFFFFF8FFFE00FC00FFFFF07FFE00FC00FF3F
      F063FE008000FF1FF241FE000000FF8FF041FE000000FFC7F81100000000FFC3
      FC0300000000FFE3FE070000000080E1FC3F0001000081E1F83F0003000181E1
      F03F0007000380C1E23F007F00078001E63F007F00079003EE3F00FF0007B807
      FE7F01FF800FFC1FFEFF03FFF87FFFFFFFFFC001C000FFFFFFFFC0018000800F
      000FC00180000007000FC001800000030007C001800000010007C00180000001
      0003C001800000010003C001800000010001C001800080010001C00180008001
      0007C0018000E0010000C0018000E00703F8C0018000F00387F8C0038000F803
      FF92C0078000F803FFC7C00F8000FFFF00000000000000000000000000000000
      000000000000}
  end
  object SavePictureDialog1: TSavePictureDialog
    DefaultExt = 'bmp'
    Filter = '.bmp|*.bmp'
    Left = 712
    Top = 8
  end
  object Pop_BarChart: TPopupMenu
    Images = ImageList1
    Left = 856
    Top = 320
    object Pop_refresh: TMenuItem
      Caption = ' '#21047#26032#22270#24418#26174#31034
      ImageIndex = 60
      OnClick = Pop_refreshClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Pop_Edit: TMenuItem
      Caption = #23646#24615#26174#31034#35774#32622
      ImageIndex = 32
      OnClick = Pop_EditClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Pop_SaveOneBMP: TMenuItem
      Caption = #20445#23384#25972#24133#22270#29255
      ImageIndex = 2
      OnClick = Pop_SaveOneBMPClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Pop_Savechart: TMenuItem
      Caption = #21333#24133#22270#29255#20445#23384
      ImageIndex = 9
      OnClick = Pop_SavechartClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object Pop_BatSave: TMenuItem
      Caption = #25209#37327#20445#23384#22270#29255
      ImageIndex = 6
      OnClick = Pop_BatSaveClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Caption = #36864#20986#30028#38754
      ImageIndex = 65
      OnClick = N5Click
    end
  end
end
