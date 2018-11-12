unit URockPressGraph;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,Vcl.StdCtrls ,
  UMainDataModule,uDrawGraphClass, Vcl.Buttons, Vcl.CheckLst ,System.TypInfo,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart,
  VCLTee.TeeSurfa, Vcl.Menus, System.ImageList, Vcl.ImgList, Vcl.ToolWin,
  Vcl.Grids,Vcl.Clipbrd, VCLTee.TeeLegendPalette, VCLTee.TeePieTool,
  VCLTee.TeeTriSurface, VCLTee.TeePoin3, VCLTee.TeeTools, VCLTee.TeeDragPoint,
  VCLTee.Series,VCLTee.TeeMapSeries, Vcl.ExtDlgs,
  UMakeRuleClass, uDrarLineGraph
  ;

 type

  TRockPressGraph_From = class(TForm)
    StatusBar1: TStatusBar;
    ChartPageControl: TPageControl;
    TabSheet_Contour: TTabSheet;
    LeftVisiblePanel: TPanel;
    TreePopu: TPopupMenu;
    TreePop_Delete: TMenuItem;
    TreePop_Recall: TMenuItem;
    Main_PageControl: TPageControl;
    TabSheet9: TTabSheet;
    ImageList1: TImageList;
    Panel_ProcessBar: TPanel;
    FirstPGBar: TProgressBar;
    SecondPGBar: TProgressBar;
    ContourChart: TChart;
    ContourSeries: TContourSeries;
    ContourChart_Cursor: TCursorTool;
    ContourPop_Main: TPopupMenu;
    ContourPop_LeftZoom: TMenuItem;
    N8: TMenuItem;
    ContourPop_loadData: TMenuItem;
    ContourPop_ChangUnit: TMenuItem;
    ContourPop_refreshchart: TMenuItem;
    N15: TMenuItem;
    ContourPop_Save_Bmp: TMenuItem;
    N13: TMenuItem;
    ContourPop_RightTool: TMenuItem;
    contourPop_KYFX: TMenuItem;
    RightPageControl: TPageControl;
    TabSheet12: TTabSheet;
    GB_KYFX_Top: TGroupBox;
    GB_KYFX_Bottom: TGroupBox;
    GB_KY_Memo1: TMemo;
    ToolBar1: TToolBar;
    But_Kyfx_Start: TToolButton;
    But_Kyfx_FillMap: TToolButton;
    But_Kyfx_Depth_Fx: TToolButton;
    ToolButton3: TToolButton;
    But_Kyfx_Report: TToolButton;
    But_Kyfx_SaveBmp: TToolButton;
    Splitter1: TSplitter;
    DragPoint: TDragPointTool;
    TreeView1: TTreeView;
    ImageList2: TImageList;
    DragMark: TDragMarksTool;
    ContourPop_Shizhi: TMenuItem;
    RightVisiblePanel: TPanel;
    LineSeries: TLineSeries;
    N17: TMenuItem;
    ContourPop_EditMap: TMenuItem;
    ContourPop_SaveEditMap: TMenuItem;
    ContourPop_UndoEdit: TMenuItem;
    N18: TMenuItem;
    contourPop_Disp_Step: TMenuItem;
    TabSheet_Result: TTabSheet;
    ContourPop_Delete: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    TreePop_Refresh: TMenuItem;
    TreePop_Start: TMenuItem;
    TreePop_Fill: TMenuItem;
    TreePop_depth: TMenuItem;
    TreePop_save: TMenuItem;
    TreePop_Report: TMenuItem;
    TreePop_Close: TMenuItem;
    N20: TMenuItem;
    SavePictureDialog1: TSavePictureDialog;
    PageControl_Result: TPageControl;
    TabSheet20: TTabSheet;
    TabSheet21: TTabSheet;
    TabSheet22: TTabSheet;
    TabSheet23: TTabSheet;
    GB_Result_Memo: TGroupBox;
    Memo_Result: TMemo;
    GroupBox13: TGroupBox;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    PopMenu_Result: TPopupMenu;
    ResultPop_SaveTxt: TMenuItem;
    N19: TMenuItem;
    ResultPop_SaveExcel: TMenuItem;
    N21: TMenuItem;
    ResultPop_OpenLefttool: TMenuItem;
    N23: TMenuItem;
    ResultPop_OpenRightTool: TMenuItem;
    StringGrid_Result: TStringGrid;
    Splitter2: TSplitter;
    N22: TMenuItem;
    ResultPop_Print_Phase: TMenuItem;
    ResultPop_Print_whole: TMenuItem;
    SaveDialog1: TSaveDialog;
    TabSheet_Graph: TTabSheet;
    TabSheet_ThreeDim: TTabSheet;
    GraphChart: TChart;
    ToolBar2: TToolBar;
    AddButton: TToolButton;
    SaveButton: TToolButton;
    EditButton: TToolButton;
    ToolButton1: TToolButton;
    ExitButton: TToolButton;
    Open_ToolForm: TToolButton;
    ToolButton4: TToolButton;
    ContourPop_BasicTool: TMenuItem;
    PopupMenu_LineGraph: TPopupMenu;
    LineGraphPop_Cursor: TMenuItem;
    N3: TMenuItem;
    LineGraphPop_NextData: TMenuItem;
    N4: TMenuItem;
    LineGraphPop_SaveBMP: TMenuItem;
    N5: TMenuItem;
    LineGraphPop_tool: TMenuItem;
    N6: TMenuItem;
    LineGraphPop_Refresh: TMenuItem;
    GraphCursorTool: TCursorTool;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure ChartYunGetAxisLabel(Sender: TChartAxis; Series: TChartSeries;
      ValueIndex: Integer; var LabelText: string);

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FootageGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Footsteps_LKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Main_PageControlDrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);

    procedure ContourChartGetAxisLabel(Sender: TChartAxis; Series: TChartSeries;
      ValueIndex: Integer; var LabelText: string);
    procedure ContourChartMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ContourPop_loadDataClick(Sender: TObject);
    procedure ContourChartMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ContourPop_LeftZoomClick(Sender: TObject);
    procedure ContourPop_refreshchartClick(Sender: TObject);
    procedure ContourPop_RightToolClick(Sender: TObject);
    procedure ContourPop_Ky_MainClick(Sender: TObject);
    procedure contourPop_KYFXClick(Sender: TObject);
    procedure ContourPop_ChangUnitClick(Sender: TObject);
    procedure TreeView1Collapsed(Sender: TObject; Node: TTreeNode);
    procedure TreeView1Expanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure But_Kyfx_StartClick(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);

    procedure StartEditKeyPress(Sender: TObject; var Key: Char);
    procedure ContourPop_ShizhiClick(Sender: TObject);

    procedure But_Kyfx_FillMapClick(Sender: TObject);
    procedure RightVisiblePanelClick(Sender: TObject);

    procedure DragPointStartDrag(Sender: TDragPointTool; Index: Integer;
      var Start: Boolean);
    procedure DragPointEndDrag(Sender: TDragPointTool; Index: Integer);
    procedure ContourPop_SaveEditMapClick(Sender: TObject);
    procedure ContourPop_UndoEditClick(Sender: TObject);
    procedure ContourPop_EditMapClick(Sender: TObject);
    procedure contourPop_Disp_StepClick(Sender: TObject);
    procedure But_Kyfx_Depth_FxClick(Sender: TObject);
    procedure Memo_ResultClick(Sender: TObject);
    procedure ContourPop_DeleteClick(Sender: TObject);
    procedure TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TreePop_DeleteClick(Sender: TObject);
    procedure TreePop_RecallClick(Sender: TObject);
    procedure TreePop_RefreshClick(Sender: TObject);
    procedure TreePop_CloseClick(Sender: TObject);
    procedure TreePop_FillClick(Sender: TObject);
    procedure TreePop_depthClick(Sender: TObject);
    procedure TreePop_saveClick(Sender: TObject);
    procedure TreePop_ReportClick(Sender: TObject);
    procedure ContourPop_Save_BmpClick(Sender: TObject);
    procedure But_Kyfx_SaveBmpClick(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Memo_ResultMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid_ResultMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ResultPop_OpenRightToolClick(Sender: TObject);
    procedure ResultPop_SaveExcelClick(Sender: TObject);
    procedure ResultPop_SaveTxtClick(Sender: TObject);
    procedure ResultPop_Print_PhaseClick(Sender: TObject);
    procedure ResultPop_Print_wholeClick(Sender: TObject);
    procedure TabSheet20Resize(Sender: TObject);
    procedure ChartPageControlDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure PageControl_ResultDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure RG_Yun_CycleClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure RadioGroup_DownFootageClick(Sender: TObject);
    procedure RadioGroup_UpperFootageClick(Sender: TObject);
    procedure ContourPop_BasicToolClick(Sender: TObject);
    procedure Open_ToolFormClick(Sender: TObject);
    procedure GraphChartMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LineGraphPop_CursorClick(Sender: TObject);
    procedure LineGraphPop_NextDataClick(Sender: TObject);
    procedure LineGraphPop_toolClick(Sender: TObject);
    procedure LineGraphPop_RefreshClick(Sender: TObject);
  private
    { Private declarations     }
     FootStringGrid_SelectCol,FootStringGrid_SelectRow:integer;
     RockStringGrid_SelectCol,RockStringGrid_SelectRow:integer;
     Mouse_x,Mouse_y:integer;
     MySqlDataSet1:TMyDataSet;
     MySqlDataSet2:TMyDataSet;
     MyCommand1:TMyCommand;

     s_MinName,S_WorkFaceName:string;
     CurrentChart:String;
     SaveBmpPath:String; //ͼƬ�ļ������·��
     BasicJinDao:TBasicJinDao;
     //
     MapSeries:TMapSeries;
     TreeView_Stepid,TreeView_APolid:integer;
     loadRockPress:Boolean;  // �Ƿ���ȡ�˿�ѹ����
     RockPressAnslysis:Boolean; // ��ѹ�Ƿ������������
    procedure InitForm;      //��ʼ�����沿�ֹ���
    procedure InitDrawGzmClass;//��ʼ����������
    function SelectRockPressDataNumber(DataType:integer):Boolean;
    procedure OptionTip(index:integer;Str:String);
    procedure AutoLoadcomboBox(MkName,WkName:string);
   //-----------------------
    procedure RefreshContourlegendPalette;
    function  GetBatInputDataMaxGenTime(Support:integer):TDateTime;
    Procedure FillBasicJinDao(B_JinDao:TBasicJinDao;Support:integer);
    //---------------------------
    procedure InitKyfxResultStringGrid;// ��ʼ����ѹ��ʾ�������
    function  ZoomRect(mRect: TRect; mZoom: Integer): TRect;// ���Ʊ�����
    //--------------------------
   
    procedure DispContourPopMemu(Px,Py:Integer;ChartName:string);  //��ʾ��ͼ���ƿ�ݲ˵�
    Procedure DispTreePop(Px,Py:Integer);//��ʾTreeView���ƿ�ݲ˵�
    procedure DispResultPop(Px,Py:integer;TP:String);// ��ʾResult ���ƵĹ�����
    procedure DispLineGraphPop(Px,Py:Integer);//��ʾGraphChart ���ƵĹ�����
    //----------------------------
    procedure CopyDataToStringGridFromPaste(StrGrid: TstringGrid; Col,
                  Row, ColNumber: integer);
    procedure ChangePressDataUnit(Flag:integer);  // �������ݵ�λ
    //---------------------------------------
    procedure SetRightToolVisible(Value:Boolean);  // �Ҳ๤��������
    procedure SetContourChartShiziVisible(Value:Boolean);// ��ͼʮ������ָʾ
    procedure SetGraphChartShiziVisible(Value:Boolean);// ����ʮ������ָʾ);

    procedure SetContourSeriseZoomUsed(Value:Boolean);//�����������Ŵ���
    procedure SetOldStepVisible(Value:Boolean);//�����Ƿ���ʾ��ѹ����
    //-------------------------------------------------------------
    procedure RecallLoadDataToDataBase(Value:Boolean);//�����ݿ����¼�������
    // RockPreeKyfx
    procedure MainTreeView(TreeView: TTreeView;FromWhere:string);
    procedure ExtractDataFormSeries(TreeView: TTreeView;ParantNode:TTreeNode;Series:TContourSeries;
              DataType:integer);
    procedure RockPressDataAnalysis(Series:TContourSeries);
       //control Series Display
       {��ʾ�����ע}
    procedure DisplyMapSeries(series:TMapSeries;OldStep:TOldSteps;TranVis:Boolean;Color:TColor;LineWide:integer);
    procedure SetPolygenProperty(OneStep:TOldOneStep;CeatePoint:Boolean;
                  Apol:TTeePolygon;Tran:Boolean;MC:TColor;LineW:integer);
    procedure MapSeriesClick(Sender: TChartSeries; ValueIndex: Integer;
              Button: TMouseButton; Shift: TShiftState; X, Y: Integer) ;
    procedure MapSeriesDoubleClick(Sender: TChartSeries; ValueIndex: Integer;
              Button: TMouseButton; Shift: TShiftState; X, Y: Integer) ;
    //--------------------------------------------------
    //��ʼ���п�ѹ���ݷ�������������
    function  StartRockPressAnslysisBegin:Boolean;
    function  EditMapSeriesSteps(ApolId,StepClassId:integer):TEditMapSeriesRe;
    procedure ReModiFyStepOldClass(OldStep:TOldSteps;EditMapRec:TEditMapSeriesRe);
    //ˢ����ѹ�����ͼ�㺯��
    procedure RefreshOldStepAddToMapSeries(Visible:Boolean);
    function ContourChartSaveIntoBMP(Path:string):Boolean;
    function CreateSaveBmpPath:String; //��������ͼƬ���ļ�·��
    function GetContOurChartBmpFileName:String;  //��ȡcontourChar�����ļ����ļ���
    // ���ƿ�ѹ�������
    function SaveResultIntoFile(Memo1:TMemo;FileName:String):Boolean;
    // ���ƿ�ѹ������ʾGraphChart
    
  public
     EXCaption:String; // �ⲿ�������ı���
     DrawGzm:TDrawGrap;  // �������
     DrawLineGraph:TDrawLineGraph;
    { Public declarations }

      procedure RefreshMyCloudChart;
      procedure RefreshMyGraphChart(Display:Boolean);
      procedure RefreshAllFormData;
      procedure LoadRockPressData(Flag:integer);
      function  GetLoadDate:Boolean;
      procedure  SetLoadDate(Value:Boolean);
      function  GetRockPressAnslysis:Boolean;
  end;

function CreateRockPress_Graph(AHandle:THandle;ACaption:string;Wid,Hi,Flag:integer):THandle;stdcall;

var
 RockPressGraph_From: TRockPressGraph_From;

implementation

{$R *.dfm}

uses  Lu_Public_BasicModual, PStope_GzmGuidClass, RockPresstool;

function CreateRockPress_Graph(AHandle:THandle;ACaption:string;Wid,Hi,Flag:integer):THandle;stdcall;
{Flag 1 ����ά��  Flag 2 ��ѹ����ά��  3 ��ѹ���ݷ���}
begin
        if Assigned(RockPressGraph_From) then  FreeAndNil(RockPressGraph_From);
        Application.Handle :=AHandle;
        RockPressGraph_From:=TRockPressGraph_From.Create(Application);

         try
           with RockPressGraph_From do begin
               EXCaption:=ACaption;
               WindowState:= wsMaximized;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

               Show;

               CreateRockPressTool(Main_PageControl.Handle,'��ͼ��ʾ�������ý���',
                            RockPressGraph_From.Width ,RockPressGraph_From.Height,1);

               Result:=RockPressGraph_From.Handle ;//����ֵ
          end ;
        except
           FreeAndNil(RockPressGraph_From);
        end;


end;

{ TForm1 }

procedure TRockPressGraph_From.AddButtonClick(Sender: TObject);
begin
   LoadRockPressData(1);
end;

procedure TRockPressGraph_From.AutoLoadcomboBox(MkName, WkName: string);
var
   s_temp:Str_DT_array;
   i,C1:integer;
begin
   if length(trim(WkName))=0 then  exit;
   if not DrawGzm.SelectMineAndWorkFaceBh(MkName, WkName) then   exit;
   //�ж��빤������ص����ݱ��Ƿ񴴽������û�д������ٴ˴���
   if not MainDataModule.IsExsitTableName('D_'+inttostr(DrawGzm.FGzm.Gzmbh)+'_BasicData') then begin
       MainDataModule.CreateTable('2',MainDataModule.DataType,inttostr(DrawGzm.FGzm.Gzmbh),'') ;
   end;

   OptionTip(0,'�ԡ�'+DrawGzm.FGzm.S_Name+'�����ݽ��з���!');

end;



procedure TRockPressGraph_From.MainTreeView(TreeView: TTreeView;FromWhere:string);
 var
  strcon: String;
  RecData: PMyRec;
  xNode,xNodeJing:TTreeNode;
  i,j,k:integer;
begin
        //��ͼ��ʼ��
    TreeView.Items.Clear;
     //
    New(RecData);
    RecData^.BName:='-1';
    RecData^.DName:='ROOT';
    RecData^.XHeight:='-1';
    xNode:=TreeView.Items.AddObject(nil,'�Ѿ��洢����ѹ��Ϣ',RecData);
    Xnode.ImageIndex:=0;
      ExtractDataFormSeries(TreeView,xNode,ContourSeries,1);

    New(RecData);
    RecData^.BName:='-1';
    RecData^.DName:='ROOT';
    RecData^.XHeight:='-1';
    xNode:=TreeView.Items.AddObject(nil,'δ�洢����ѹ��Ϣ',RecData);
    Xnode.ImageIndex:=0;
       Xnode.Expand(true);
       ExtractDataFormSeries(TreeView,xNode,ContourSeries,-1);





end;


procedure TRockPressGraph_From.MapSeriesClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if Button =mbLeft then  begin
     DrawGzm.EditMapPoint.Apol :=ValueIndex;
     DrawGzm.MapSeriesEditState:=2;
   end;

end;

procedure TRockPressGraph_From.MapSeriesDoubleClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   pt:TPoint;
begin
   if Button =mbLeft then  begin
//      ContourChart.ScrollMouseButton:=mbMiddle;
       //���ı༭״̬
      DrawGzm.EditMapPoint:=EditMapSeriesSteps(ValueIndex,-1);
//      ContourChart.ScrollMouseButton:=mbLeft;
   end;
end;

procedure TRockPressGraph_From.Memo_ResultClick(Sender: TObject);
begin
   Memo_Result.SetFocus;
end;

procedure TRockPressGraph_From.Memo_ResultMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt:Tpoint;
begin
   if Button=mbRight then begin
      pt:= self.Memo_Result.ClientToScreen(Point(0,0));
      DispResultPop (pt.X+x,pt.Y +y,'Memo');
   end;


end;



procedure TRockPressGraph_From.ContourPop_Ky_MainClick(Sender: TObject);
begin
//    SetRightKyffVisible(true);
//   SetProcegressBarVisual(true,100,100);
//   StepProcegressBar(10,0);
   RockPressDataAnalysis(self.ContourSeries);


end;

procedure TRockPressGraph_From.ContourPop_LeftZoomClick(Sender: TObject);
begin
  SetContourSeriseZoomUsed(False);
end;

procedure TRockPressGraph_From.ContourPop_loadDataClick(Sender: TObject);
begin
   LoadRockPressData(1);
end;

procedure TRockPressGraph_From.ContourPop_refreshchartClick(Sender: TObject);
begin
   RefreshMyCloudChart;
//   //RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
//   //����������ͼ
//   if DrawGzm.CloudClass.OldStepDisplay then
//       StartRockPressAnslysisBegin;
//   // ������ѹ���� �ļ���
//   if  DrawGzm.Auto_Judge_OldStep.isCalComeStep  then  begin
//       InitKyfxResultStringGrid;
//       DrawGzm.CalComeStepAndPrintToMemo(Memo_Result,StringGrid_Result);
//   end;
end;

procedure TRockPressGraph_From.ContourPop_RightToolClick(Sender: TObject);
begin
   SetRightToolVisible(not RightPageControl.Visible);

end;

procedure TRockPressGraph_From.ContourPop_SaveEditMapClick(Sender: TObject);
begin
    ReModiFyStepOldClass(DrawGzm.Auto_Judge_OldStep,DrawGzm.EditMapPoint);
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TRockPressGraph_From.ContourPop_Save_BmpClick(Sender: TObject);
begin
  SavePictureDialog1.Execute ;
  ContourChartSaveIntoBMP(SavePictureDialog1.FileName);
end;

procedure TRockPressGraph_From.ContourPop_ShizhiClick(Sender: TObject);
begin
   SetContourChartShiziVisible(not ContourChart_Cursor.Visible);
end;



procedure TRockPressGraph_From.ContourPop_UndoEditClick(Sender: TObject);
begin
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;




procedure TRockPressGraph_From.ChangePressDataUnit(Flag: integer);
var
  i,j:integer;
  TemValue:Double;
  UnitName:string;
begin
  if Flag=1 then   begin
     UnitName :='��ǰ���ݵ�λΪ MPa' ;
     DrawGzm.ColorValue.UnitType :=1;
  end else begin
     UnitName :='��ǰ���ݵ�λΪ Bar' ;
     DrawGzm.ColorValue.UnitType:=2;
  end;
     Caption:=EXCaption+'��'+ UnitName+'��';
end;

procedure TRockPressGraph_From.ChartPageControlDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
   if Active then
    begin
        Control.Canvas.Brush.Color := ClHighLight;
        Control.Canvas.Font.Color := clWhite;
    end;
    Control.Canvas.FillRect(Rect);
    Control.Canvas.TextOut(Rect.Left + 4,Rect.Top + 4,ChartPageControl.Pages[TabIndex].Caption);
end;

procedure TRockPressGraph_From.ChartYunGetAxisLabel(Sender: TChartAxis;
  Series: TChartSeries; ValueIndex: Integer; var LabelText: string);
var
  i:integer;
  FSetting : TFormatSettings;  //���ڸ�ʽת��
begin
     //���ڸ�ʽת��
       FSetting.ShortDateFormat:='yyyy-mm-ss' ;
       FSetting.DateSeparator :='-';
       FSetting.ShortTimeFormat :='hh:nn:ss';
       FSetting.TimeSeparator :=':';
       FSetting.DecimalSeparator :='.';
      // ���ĵڶ��������
//     if Sender = ChartYun.Axes.Bottom.SubAxes.Items[0] then
//         LabelText :=  FormatFloat('0.00',DrawGzm.DatetimeToFootage(StrToDateTime(LabelText,FSetting),'Down'));
//     if Sender = ChartYun.Axes.Bottom.SubAxes.Items[1] then
//         LabelText :=  FormatFloat('0.00',DrawGzm.DatetimeToFootage(StrToDateTime(LabelText,FSetting),'Upper'));

end;

procedure TRockPressGraph_From.ContourChartGetAxisLabel(Sender: TChartAxis;
  Series: TChartSeries; ValueIndex: Integer; var LabelText: string);
var
  LabDaoshu:double;
  Daoshu:integer;
  Text:String;
begin
        if Sender=ContourChart.BottomAxis.SubAxes.Items[0] then   begin
             Text:=StringReplace (LabelText, ',', '', [rfReplaceAll]);
             Daoshu:=Round(Public_Basic.StrToDouble_Lu(Text));
            if (Daoshu>= 0  ) and (Daoshu <DrawGzm.FilledContourDataNumber ) then  begin
                if DrawGzm.ConTourSeriesPar.Display_DownFootage =1 then  begin
                    if (DrawGzm.FilledContourData[Daoshu].Down_footage >0)then   begin
                        LabelText:=FormatFloat('0',DrawGzm.FilledContourData[Daoshu].Down_footage  ) ;
                    end else begin
                        LabelText:='';
                    end;

                end else begin
                    if DrawGzm.FilledContourData[Daoshu].DT>10000 then   begin
                       LabelText:=FormatDateTime('yyyy-mm-dd',DrawGzm.FilledContourData[Daoshu].DT  ) ;
                    end else begin
                       LabelText:='';
                    end;
                end;
            end else begin
               LabelText:='';
            end;

        end;


//
        if Sender=ContourChart.TopAxis then  begin
             Text:=StringReplace (LabelText, ',', '', [rfReplaceAll]);
             Daoshu:=Round(Public_Basic.StrToDouble_Lu(Text));
            if (Daoshu>= 0  ) and (Daoshu <DrawGzm.FilledContourDataNumber ) then  begin
               if DrawGzm.ConTourSeriesPar.Display_UpperFootage =1 then  begin
                   if (DrawGzm.FilledContourData[Daoshu].Upper_Footage>0 )then   begin
                       LabelText:=FormatFloat('0',DrawGzm.FilledContourData[Daoshu].Upper_Footage  ) ;
                    end else begin
                       LabelText:='';
                    end;

               end else begin
                   if DrawGzm.FilledContourData[Daoshu].DT >10000 then   begin
                      LabelText:=FormatDateTime('yyyy-mm-dd',DrawGzm.FilledContourData[Daoshu].DT  ) ;
                   end else begin
                      LabelText:='';
                   end;
               end;
           end else begin
               LabelText:='';
           end;
        end;


end;

procedure TRockPressGraph_From.ContourChartMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt:Tpoint;
begin
   if Button=mbRight then begin
      pt:= ContourChart.ClientToScreen(Point(0,0));
      DispContourPopMemu(pt.X+x,pt.Y +y,'TwoDimChart');
   end;


end;

procedure TRockPressGraph_From.ContourChartMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
    tmp : Integer;
begin
  try
    tmp:=ContourSeries.Clicked(x,y);
    if tmp=-1 then  begin
       OptionTip(1,'') ;
    end else begin
//       OptionTip(1,'����:'+IntToStr(Round((ContourSeries1.XValues[tmp])))+' '+
//                        '֧��:'+IntToStr(Round((ContourSeries1.ZValues[tmp])))+
//                        ' ѹ��: '+FloatToStr(ContourSeries1.YValues[tmp]));
//      OptionTip(1,'����:'+IntToStr(x)+' '+
//                        '֧��:'+IntToStr(y)+
//                        ' ѹ��: '+FloatToStr(ContourSeries1.YValues[tmp]));


    end;
   //artTool1.AxisAnnotation.Text := FloatToStr(Sgrid.YValues[tmp]);
   except

  end;
end;

function TRockPressGraph_From.ContourChartSaveIntoBMP(Path: string): Boolean;
var
  FileName,tmp:string;
begin
   if trim(Path) <> '' then  begin
          if SavePictureDialog1.FilterIndex =2 then  begin
             if ExtractFileExt(SavePictureDialog1.FileName) <> '.jpg' then
                 SavePictureDialog1.FileName := ChangeFileExt(SavePictureDialog1.FileName,'.jpg');
          end else if SavePictureDialog1.FilterIndex =3 then  begin
             if ExtractFileExt(SavePictureDialog1.FileName) <> '.png' then
                 SavePictureDialog1.FileName := ChangeFileExt(SavePictureDialog1.FileName,'.png');
          end else  begin
             if ExtractFileExt(SavePictureDialog1.FileName) <> '.bmp' then
                 SavePictureDialog1.FileName := ChangeFileExt(SavePictureDialog1.FileName,'.bmp');
          end;
          ContourChart.SaveToBitmapFile(SavePictureDialog1.FileName);
          if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWater(SavePictureDialog1.FileName)
            else Public_Basic.AddMultTextWater(SavePictureDialog1.FileName);
   end else begin
      tmp:=GetContOurChartBmpFileName;
      if tmp ='' then  exit;

      if not DrawGzm.CloudClass.OldStepDisplay then   begin
            FileName:=SaveBMpPath+ tmp +'_0.bmp';
            ContourChart.SaveToBitmapFile(FileName);
            if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWater(FileName)
                  else Public_Basic.AddMultTextWater(FileName);
      end else begin
          FileName:=SaveBMpPath+ tmp +'_1.bmp';
          ContourChart.SaveToBitmapFile(FileName);
          if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWater(FileName)
            else Public_Basic.AddMultTextWater(FileName);
      end;
   end;


  
end;

procedure TRockPressGraph_From.ContourPop_BasicToolClick(Sender: TObject);
begin
     CreateRockPressTool(Application.Handle,'��ͼ��ʾ�������ý���',RockPressGraph_From.Width ,RockPressGraph_From.Height,1);
end;

procedure TRockPressGraph_From.ContourPop_ChangUnitClick(Sender: TObject);
begin
  if DrawGzm.ColorValue.UnitType=1 then  begin
     DrawGzm.ColorValue.UnitType:=2;
  end else if DrawGzm.ColorValue.UnitType=2 then   begin
     DrawGzm.ColorValue.UnitType:=1;
  end;
     ChangePressDataUnit(DrawGzm.ColorValue.UnitType);
end;

procedure TRockPressGraph_From.ContourPop_DeleteClick(Sender: TObject);
begin
   DrawGzm.Auto_Judge_OldStep.ExSteps[DrawGzm.EditMapPoint.StepClassid].Used :=2;
   RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TRockPressGraph_From.contourPop_Disp_StepClick(Sender: TObject);
begin
   SetOldStepVisible(not DrawGzm.CloudClass.OldStepDisplay);
   RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TRockPressGraph_From.ContourPop_EditMapClick(Sender: TObject);
begin
      ContourChart.ScrollMouseButton:=mbMiddle;
       //���ı༭״̬
      DrawGzm.EditMapPoint:=EditMapSeriesSteps(DrawGzm.EditMapPoint.Apol,-1);
      ContourChart.ScrollMouseButton:=mbLeft;
end;

procedure TRockPressGraph_From.contourPop_KYFXClick(Sender: TObject);
begin
    SetRightToolVisible(true);
    RockPressAnslysis:=true;
    RefreshMyCloudChart;
end;

procedure TRockPressGraph_From.CopyDataToStringGridFromPaste(StrGrid: TstringGrid; Col,
  Row, ColNumber: integer);
var
  arr: array[0..99999] of Char;
  i,j,inColNumber:Integer;
  s_temp:Str_DT_array;
  C1,ColS:integer;
  List1:TStringList;
begin

  Clipboard.GetTextBuf(arr, Length(arr));
  List1:=TStringList.Create ;
  List1.Text:=arr;
  try
     for I := 0 to List1.Count-1 do  begin
          s_temp:=Public_Basic.split(List1.Strings[i],#9,C1);
          if ColNumber < 1   then inColNumber:=C1
              else  inColNumber:=ColNumber;

          for j := 0 to inColNumber-1 do  begin
             if Col+j>StrGrid.ColCount-1 then   break;

             StrGrid.Cells[Col+j,Row]:=s_temp[j];
          end;

          Row:=Row+1;
          if Row> StrGrid.RowCount -1 then break;

    end;

  finally
     FreeAndNil(List1);
  end;


end;

function TRockPressGraph_From.CreateSaveBmpPath: String;
var
 BmpPath:WideString;
begin
    BmpPath:=Public_Basic.Get_MyModulePath+'SaveBmp\KYFX\';
    if  not DirectoryExists(BmpPath) then
         ForceDirectories(BmpPath);

    Result:=BmpPath;
end;



procedure TRockPressGraph_From.DispContourPopMemu(Px, Py: Integer; ChartName: string);
begin
   //ContourPop_loadData.Enabled :=false;
   ContourPop_refreshchart.Enabled :=false;
//   ContourPop_TwoDim.Enabled :=false;
//   ContourPop_ThreeDim.Enabled :=false;
//   ContourPop_Graph.Enabled :=false;
   ContourPop_Save_Bmp.Enabled :=false;
   ContourPop_ChangUnit.Enabled :=false;
   //ContourPop_LeftZoom.Enabled:=false;
    ContourPop_Kyfx.Enabled :=false;
    ContourPop_EditMap.Enabled :=false;
    ContourPop_SaveEditMap.Enabled :=False;
    ContourPop_UndoEdit.Enabled :=false;
    ContourPop_Delete.Enabled:=false;
    contourPop_Disp_Step.Enabled :=false;
    if DrawGzm.MapSeriesEditState >0 then  begin
       ContourPop_Kyfx.Enabled :=true;       // ��ѹ������
       ContourPop_refreshchart.Enabled :=true;// ˢ��ҳ��
       ContourPop_ChangUnit.Enabled :=true;  //  �ı䵥λ
       ContourPop_Save_Bmp.Enabled :=true; //  ����ͼƬ
       contourPop_Disp_Step.Enabled :=true;//��ʾ��ѹ����

    end;

    if DrawGzm.MapSeriesEditState =2 then  begin
       ContourPop_EditMap.Enabled :=true;   //�༭״̬
       ContourPop_SaveEditMap.Enabled :=true; //����״̬
       ContourPop_UndoEdit.Enabled :=true;   // ����״̬
       ContourPop_Delete.Enabled:=true;//ɾ��ѡ������
    end;




   if ChartName='TwoDimChart' then  begin
      CurrentChart:='TwoDimChart';
      ContourPop_Main.Popup(px,py);
   end else if  ChartName='ThreeDimChart' then  begin
      CurrentChart:='ThreeDimChart';
      ContourPop_Main.Popup(px,py);
   end;


end;





procedure TRockPressGraph_From.DispLineGraphPop(Px, Py: Integer);
begin
    LineGraphPop_Cursor.Enabled :=true;
    LineGraphPop_NextData.Enabled :=false;
    LineGraphPop_SaveBmp.Enabled :=false;

    if DrawGzm.GraphClass.YAxisType =1 then
       if DrawLineGraph.SupportMaxCount  >6 then
          LineGraphPop_NextData.Enabled :=true;
    if GraphChart.SeriesCount >0  then  begin
       LineGraphPop_SaveBmp.Enabled :=True;

    end;
    PopupMenu_LineGraph.Popup(px,py);
end;

procedure TRockPressGraph_From.DisplyMapSeries(series:TMapSeries;
    OldStep:TOldSteps;TranVis:Boolean;Color:TColor;LineWide:integer);
    {
      series ��ͼ����
      OldStep ��������
      TranVis ����Ƿ�͸��
      Color �����ɫ �����͸��  ������ɫ
      LineWide ��������
    }
var
  i,j:integer;
  APol    : TTeePolygon;
  PointIndex:integer;
begin
//    for I := series.Shapes.Count -1 downto 0 do
//        series.Shapes[i].Free ;

    series.Clear ;
//    series.Visible :=Visible;
//    if Visible then   begin
        for I := 0 to length(OldStep.ExSteps ) -1 do  begin

            if (OldStep.ExSteps[i].GetMinDao >= DrawGzm.CloudClass.SaveDataMinDao  ) and
                  (OldStep.ExSteps[i].GetMaxDao <= DrawGzm.CloudClass.SaveDataMaxDao )  then
                  {��������������ݿⱣ������ݿռ���
                   �ж������Ƿ�������¼���
                  }
                 if DrawGzm.CloudClass.RecallMidDaoSaveStep  then  begin    // ������¼���
                    if (OldStep.ExSteps[i].Used=3) then    OldStep.ExSteps[i].Used:=1;
                 end else begin // ��������¼���
                    // ��Ȧ������ͼ��ɲ�����
                    if (OldStep.ExSteps[i].Used=1) and (OldStep.ExSteps[i].ModifyData=1)  then  // ��ʾ ����ֵ����Ԥ��ֵ
                       OldStep.ExSteps[i].Used:=3;
                 end;

            if  OldStep.ExSteps[i].Used <> 1 then   continue;   // ����������ʾ�ķ���
            APol:=series.Shapes.Add ;
            OldStep.ExSteps[i].MapSeriesIndex :=APol.Index ;
            APol.Points.Clear ;

            //
             if  (OldStep.ExSteps[i].GetMinDao > DrawGzm.DataTimeAndFootAge.Graph_MinDao ) and
                         (OldStep.ExSteps[i].GetMaxDao < DrawGzm.DataTimeAndFootAge.Graph_MaxDao ) then  begin
                 {
                   ����������� ������ ����������

                 }
                  if OldStep.ExSteps[i].ModifyData =3  then  begin  // ��ʾԤ������
                      if DrawGzm.CloudClass.DisPlayForcase then    //���ͬ����ʾԤ������
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,FALSE,ClRed,LineWide);

                  end else if OldStep.ExSteps[i].ModifyData =1  then begin
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,Color,LineWide);
                  end else if OldStep.ExSteps[i].ModifyData =4  then begin
                       if not DrawGzm.CloudClass.RecallMidDaoSaveStep  then
                         {
                           ��������½��м��� ��ô�� ����� ��ѹ������ͼ������ʾ
                           ����ؽ����м��� �����������ͼ����ѹ������ͼ������ʾ
                         }
                        SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,Color,LineWide);
                  end;


             end else begin
                {
                   ���������������� �ж�����ʾʲô����

                }
                 if DrawGzm.CloudClass.DisPlayProMinDaoSaveStep then  begin // ���������Ƿ���ʾ�Ƿ� ��ʾ
                     if (DrawGzm.CloudClass.DisplaySaveDate_Quyu_Step) and (OldStep.ExSteps[i].ModifyData =2) then
                      {
                        �����ʾ������ͼ ���Ҵ����ݿ�����ȡ���� ������ͼ ����ʾ
                      }
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,Color,LineWide);
                      if (not DrawGzm.CloudClass.DisplaySaveDate_Quyu_Step) and (OldStep.ExSteps[i].ModifyData =4) then
                      {
                        �����ʾ��ѹ������ͼ ���Ҵ����ݿ�����ȡ���� ��ѹ������ͼ ����ʾ
                      }
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,Color,LineWide);
                 end;

                  if OldStep.ExSteps[i].ModifyData =3  then  begin  // ��ʾԤ������
                      if DrawGzm.CloudClass.DisPlayForcase then    //���ͬ����ʾԤ������
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,FALSE,ClRed,LineWide);
                  end;


             end;


      end;
//   end;
   series.RefreshSeries;
end;



procedure TRockPressGraph_From.DispResultPop(Px, Py: integer;TP:String);
begin
    ResultPop_SaveTxt.Enabled :=false;
    ResultPop_SaveExcel.Enabled :=false;
   // ResultPop_OpenLefttool.Enabled :=false;
   // ResultPop_OpenRightTool.Enabled :=false;
   ResultPop_Print_Phase.Enabled :=false;
   ResultPop_Print_whole.Enabled :=false;
    if TP='Memo' then  begin
       ResultPop_SaveTxt.Enabled :=true;
       ResultPop_Print_Phase.Enabled :=true;
       ResultPop_Print_whole.Enabled :=true;
    end else begin
       ResultPop_SaveExcel.Enabled :=true;
    end;
    PopMenu_Result.Popup(px,py);
end;


procedure TRockPressGraph_From.DispTreePop(Px, Py: Integer);
begin
     if TreeView_Stepid <0 then  begin
        TreePop_Delete.Enabled :=false;
        TreePop_Recall.Enabled :=false;
     end else begin
        TreePop_Delete.Enabled :=true;
        TreePop_Recall.Enabled :=true;
     end;

     TreePopu.Popup(px,py);
end;

procedure TRockPressGraph_From.DragPointEndDrag(Sender: TDragPointTool;
  Index: Integer);
begin
   if (Index>=0) and (index<=7 )  then   begin
      DrawGzm.EditMapPoint.tmpPoints[index].x :=Round(LineSeries.XValues[index]);
      DrawGzm.EditMapPoint.tmpPoints[index].Y :=Round(LineSeries.YValues[index]);
   end;
    //�ָ����Ŵ�״̬
  //  SetContourSeriseZoomUsed(true);
end;

procedure TRockPressGraph_From.DragPointStartDrag(Sender: TDragPointTool;
  Index: Integer; var Start: Boolean);
begin
    // SetContourSeriseZoomUsed(False);
     DrawGzm.EditMapPoint.Pointid :=Index;
end;

procedure TRockPressGraph_From.EditButtonClick(Sender: TObject);
begin
    contourPop_KYFX.Click ;
end;

function TRockPressGraph_From.EditMapSeriesSteps(ApolId,
  StepClassId: integer): TEditMapSeriesRe;
var
  tmp:TEditMapSeriesRe;
  i:integer;
begin
    if StepClassId <0 then   begin
       StepClassId:=DrawGzm.Auto_Judge_OldStep.ReturnStepid(ApolId) ;
    end;
    if StepClassId <0 then   exit;

    DrawGzm.MapSeriesEditState:=2;
    tmp.Apol :=Apolid;
    tmp.StepClassid:=StepClassid;
    Result:=tmp;
    // ��������ͼ
    LineSeries.Clear ;

    for I := 0 to 7 do  begin
      LineSeries.AddXY(DrawGzm.Auto_Judge_OldStep.ExSteps[StepClassid].MyOutLinePoint[i].x,
                        DrawGzm.Auto_Judge_OldStep.ExSteps[StepClassid].MyOutLinePoint[i].y
                        );
      //���������
      tmp.tmpPoints[i].X:=DrawGzm.Auto_Judge_OldStep.ExSteps[StepClassid].MyOutLinePoint[i].x;
      tmp.tmpPoints[i].Y:=DrawGzm.Auto_Judge_OldStep.ExSteps[StepClassid].MyOutLinePoint[i].Y;
    end;
     LineSeries.AddXY(DrawGzm.Auto_Judge_OldStep.ExSteps[StepClassid].MyOutLinePoint[0].x,
                        DrawGzm.Auto_Judge_OldStep.ExSteps[StepClassid].MyOutLinePoint[0].y
                        );

    LineSeries.XValues.Order:=loNone;
    LineSeries.Pen.Width :=DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide;
    LineSeries.Pen.Color :=ClBlue;
    LineSeries.OutLine.Visible :=true;
    LineSeries.Pointer.Size:=LineSeries.Pen.Width+4;
    MapSeries.Selected.Hover.Visible :=false;
    ContourSeries.Selected.Hover.Visible :=False;
    // �����Ŵ������Ϊ�Ŵ�ģʽ
    SetContourSeriseZoomUsed(true);
    Result:=tmp;
end;

procedure TRockPressGraph_From.ExitButtonClick(Sender: TObject);
begin
    Close;
end;

procedure TRockPressGraph_From.ExtractDataFormSeries(TreeView: TTreeView; ParantNode:TTreeNode;
  Series: TContourSeries ; DataType:integer);
 var
  strcon: String;
  RecData: PMyRec;
  xChilld11,xChilld12,xChilld13:TTreeNode;
  xChild3:TTreeNode;
  i, j, m: Integer;
  lvl: TContourLevel;
  seg: TLevelSegment;
  //pt:TPoint;
  KK:integer;

begin

   if  DrawGzm.ColorValue.UnitType=1 then   begin
      KK:=1;
   end else begin
      KK:=10;
   end;

//   DrawGzm.Auto_Judge_OldStep.SetJudgeBasicParameters(DrawGzm.FGzm.RockPressAnalysis.Continue_SupNumber,
//                    DrawGzm.FGzm.RockPressAnalysis.conTinue_Footage/DrawGzm.FGzm.RockPressAnalysis.OneDao_step,
//                    DrawGzm.FGzm.RockPressAnalysis.AnalysisSenstive
//                    ) ;

   DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,true,100,100);

   if DataType=-1 then   begin // ���� ��Ϊδ�������Ϣ

        New(RecData);
        RecData^.BName:='-1';
        RecData^.DName:='ROOT';
        RecData^.XHeight:='-1';
        xChilld11:=TreeView.Items.AddChildObject(ParantNode,'��Ч��������Ϣ',RecData);
        xChilld11.ImageIndex:=0;
        //�ڵ㱻ѡ��չ��


        New(RecData);
        RecData^.BName:='-1';
        RecData^.DName:='ROOT';
        RecData^.XHeight:='-1';
        xChilld12:=TreeView.Items.AddChildObject(ParantNode,'��ɾ����������Ϣ',RecData);
        xChilld12.ImageIndex:=0;



        New(RecData);
        RecData^.BName:='-1';
        RecData^.DName:='ROOT';
        RecData^.XHeight:='-1';
        xChilld13:=TreeView.Items.AddChildObject(ParantNode,'��ѹ����Ԥ����Ϣ',RecData);
        xChilld13.ImageIndex:=0;
           for I := 0 to length(DrawGzm.Auto_Judge_OldStep.ExSteps)-1 do   begin
                 if  DrawGzm.Auto_Judge_OldStep.ExSteps[i].Used =0 then continue;
                 if DrawGzm.Auto_Judge_OldStep.ExSteps[i].ModifyData =1  then  begin // ����ֵ
                      if  DrawGzm.Auto_Judge_OldStep.ExSteps[i].Used =1 then   begin
                            New(RecData);
                            RecData^.BName:='1';
                            RecData^.DName:=IntToStr(i);
                            RecData^.XHeight:=intTostr(DrawGzm.Auto_Judge_OldStep.ExSteps[i].MapSeriesIndex);
                            xChild3:=TreeView.Items.AddChildObject(xChilld11,DrawGzm.Auto_Judge_OldStep.ExSteps[i].GetDispTitle ,  RecData);
                            xChild3.ImageIndex:=2;
                      end else if  DrawGzm.Auto_Judge_OldStep.ExSteps[i].Used =2 then begin
                            New(RecData);
                            RecData^.BName:='2';
                            RecData^.DName:=IntToStr(i);
                            RecData^.XHeight:='0';
                            xChild3:=TreeView.Items.AddChildObject(xChilld12,DrawGzm.Auto_Judge_OldStep.ExSteps[i].GetDispTitle ,  RecData);
                            xChild3.ImageIndex:=6;
                      end;
                 end else if DrawGzm.Auto_Judge_OldStep.ExSteps[i].ModifyData =3  then  begin // Ԥ��ֵ
                       New(RecData);
                        RecData^.BName:='2';
                        RecData^.DName:=IntToStr(i);
                        RecData^.XHeight:='0';
                        xChild3:=TreeView.Items.AddChildObject(xChilld13,DrawGzm.Auto_Judge_OldStep.ExSteps[i].GetDispTitle ,  RecData);
                        xChild3.ImageIndex:=5;
                 end;

           end;

         // xChilld11.Expand(true);
   end else if  DataType= 1 then   begin // ���� ��Ϊ�Ѿ��������Ϣ
        New(RecData);
        RecData^.BName:='-1';
        RecData^.DName:='ROOT';
        RecData^.XHeight:='-1';
        xChilld11:=TreeView.Items.AddChildObject(ParantNode,'��Ҫ��ͼ����',RecData);
        xChilld11.ImageIndex:=0;
        //�ڵ㱻ѡ��չ��


        New(RecData);
        RecData^.BName:='-1';
        RecData^.DName:='ROOT';
        RecData^.XHeight:='-1';
        xChilld12:=TreeView.Items.AddChildObject(ParantNode,'��ѹ��������',RecData);
        xChilld12.ImageIndex:=0;

         for I := 0 to length(DrawGzm.Auto_Judge_OldStep.ExSteps)-1 do   begin
             if  DrawGzm.Auto_Judge_OldStep.ExSteps[i].Used <>1 then continue;
             if (DrawGzm.Auto_Judge_OldStep.ExSteps[i].Used =1) and  (DrawGzm.Auto_Judge_OldStep.ExSteps[i].ModifyData =2) then  begin
                // ���������ݿ�����ȡ�� ��ͼ��Ϣ Ҳ���� ���ݿⱣ��dataType = 2 �� ����
                New(RecData);
                RecData^.BName:='2';
                RecData^.DName:=IntToStr(i);
                RecData^.XHeight:=intTostr(DrawGzm.Auto_Judge_OldStep.ExSteps[i].MapSeriesIndex);
                xChild3:=TreeView.Items.AddChildObject(xChilld11,DrawGzm.Auto_Judge_OldStep.ExSteps[i].GetDispTitle ,  RecData);
                xChild3.ImageIndex:=2;
             end;

             if (DrawGzm.Auto_Judge_OldStep.ExSteps[i].Used =1) and  (DrawGzm.Auto_Judge_OldStep.ExSteps[i].ModifyData =4) then  begin
                // ���������ݿ�����ȡ�� ��ѹ������Ϣ Ҳ���� ���ݿⱣ��dataType = 4 �� ����
                New(RecData);
                RecData^.BName:='2';
                RecData^.DName:=IntToStr(i);
                RecData^.XHeight:=intTostr(DrawGzm.Auto_Judge_OldStep.ExSteps[i].MapSeriesIndex);
                xChild3:=TreeView.Items.AddChildObject(xChilld12,DrawGzm.Auto_Judge_OldStep.ExSteps[i].GetDispTitle ,  RecData);
                xChild3.ImageIndex:=2;
             end;

       end;

   end;



      DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,False,0,0);

end;

procedure TRockPressGraph_From.FillBasicJinDao(B_JinDao: TBasicJinDao;Support:integer);
var
  sql,Strdt:string;
  MaxTime:TDateTime;
  Rd:TJinDaoRecord;
begin
   MaxTime:=GetBatInputDataMaxGenTime(Support);
   MySqlDataSet2.Close ;

   Strdt:=Public_Basic.ReturnDateTimeString(MainDataModule.DataType ,MaxTime);

   Sql:=' select * from  D_'+IntToStr(DrawGzm.FGzm.Gzmbh)+'_footage ' +
        ' where  footday > ' + Strdt +
        ' order by Daoshu  ' ;
   B_JinDao.ClearArray;
   MySqlDataSet2.CommandText :=sql;
   try
      if MySqlDataSet2.Open then
       while not MySqlDataSet2.Eof  do  begin
          Rd.ShotTime :=MySqlDataSet2.FieldByName('FootDay').AsDateTime;
          Rd.Daoshu:=MySqlDataSet2.FieldByName('DaoShu').AsInteger;
          B_JinDao.Add(RD);
          MySqlDataSet2.Next;
       end;
   finally
      MySqlDataSet2.Close ;
   end;
end;



procedure TRockPressGraph_From.FootageGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
   FootStringGrid_SelectCol:=ACol;
   FootStringGrid_SelectRow:=ARow;
end;

procedure TRockPressGraph_From.Footsteps_LKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TRockPressGraph_From.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   {�رմ��壬������Ҫ����Close����}
   if Assigned(RockPressGraph_From) then  FreeAndNil(RockPressGraph_From);
end;

procedure TRockPressGraph_From.FormCreate(Sender: TObject);
begin
    MySqlDataSet1:=TMyDataSet.Create(nil);
    MySqlDataSet1.MySqlConnection :=MainDataModule.ExConn;
    MySqlDataSet2:=TMyDataSet.Create(nil);
    MySqlDataSet2.MySqlConnection :=MainDataModule.ExConn;
    MyCommand1:=TMyCommand.Create (nil);
    MyCommand1.MySqlConnection :=MainDataModule.ExConn;
    DrawGzm:=TDrawGrap.Create(MainDataModule.ExConn);
    DrawLineGraph:=TDrawLineGraph.Create ;
    //create
     MapSeries:=TMapSeries.Create(contourchart);
     MapSeries.ParentChart:= contourchart;
     MapSeries.OnClick:=MapSeriesClick;
     MapSeries.OnDblClick:=MapSeriesDoubleClick;


    MainDataModule.ReadPublicUsedMkInfoFromFile;
    s_MinName :=MainDataModule.Coal_Name;
    S_WorkFaceName :=MainDataModule.WorkFace_Name;
   
     SetRightToolVisible(false);
     //Ĭ�ϻ�β��ʾ ʱ��
     DrawGzm.ConTourSeriesPar.Display_UpperFootage:=0;
     DrawGzm.ConTourSeriesPar.Display_DownFootage:=1;

     // �ر�ʮ�ֹ����
     SetContourChartShiziVisible(False);
     SetGraphChartShiziVisible(False);

     ChartPageControl.ActivePage :=ChartPageControl.Pages[0];

     //��ѹ��������״̬   Ĭ��û�н���������
     SetOldStepVisible(false);
     //����ͼƬ�����ļ���
     SaveBmpPath:=CreateSaveBmpPath;
    //
     BasicJinDao:=TBasicJinDao.Create ;
end;

procedure TRockPressGraph_From.FormDestroy(Sender: TObject);
begin
     FreeAndNil(MySqlDataSet1);
     FreeAndNil(MyCommand1);
     FreeAndNil(MySqlDataSet2);
     FreeAndNil(DrawGzm);
     FreeAndNil(DrawLineGraph);

     FreeAndNil(MapSeries);
     FreeAndNil(BasicJinDao);

end;

procedure TRockPressGraph_From.FormShow(Sender: TObject);
begin
   InitForm;
   // ���û�п����Ĺ���
   self.PageControl_Result.Pages[1].TabVisible :=False;
   self.PageControl_Result.Pages[2].TabVisible :=False;
   self.PageControl_Result.Pages[3].TabVisible :=False;
end;

function TRockPressGraph_From.GetBatInputDataMaxGenTime(Support:integer): TDateTime;
var
  sql:String;
begin
   Result:=-1;
   MySqlDataSet2.Close ;
   Sql:=' select Max(generatetime) as MAXTime from  D_'+IntToStr(DrawGzm.FGzm.Gzmbh)+'_ManualInputPressData  '  +
        ' where supportbh = ' +IntTostr(Support) ;
   MySqlDataSet2.CommandText :=sql;
   try
       if MySqlDataSet2.Open then
        Result:= MySqlDataSet2.FieldByName('MAXTime').AsDateTime

   finally
       MySqlDataSet2.Close ;
   end;
end;

function TRockPressGraph_From.GetContOurChartBmpFileName: String;
var
  MinLab,MaxLab:integer;
begin
   Result:='';
   if DrawGzm.FGzm.Gzmbh <1 then  exit;
   MinLab:=Round(ContourChart.BottomAxis.Minimum);
   MaxLab:=Round(ContourChart.BottomAxis.Maximum);
   Result:='YT_'+Trim(IntTostr(DrawGzm.FGzm.Gzmbh)) +'_'+
           Trim(IntTostr(MinLab))+ '_'+Trim(IntTostr(MaxLab)) ;
end;










function TRockPressGraph_From.GetLoadDate: Boolean;
begin
   Result:=loadRockPress;
end;

function TRockPressGraph_From.GetRockPressAnslysis: Boolean;
begin
    Result:=RockPressAnslysis;
end;

procedure TRockPressGraph_From.GraphChartMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt:Tpoint;
begin
   if Button=mbRight then begin
      pt:= GraphChart.ClientToScreen(Point(0,0));
      DispLineGraphPop(pt.X+x,pt.Y +y);
   end;



end;

procedure TRockPressGraph_From.InitDrawGzmClass;
var
  i:integer;
begin

    // ��������
    DrawGzm.GraphClass.Graph_DataCalss:=single;
    DrawGzm.GraphClass.SupportList :='';
    // ��һ��ʾʱ ׷������
    for I := 0 to 2 do
         DrawGzm.GraphClass.Disp_DataType[i]:=true;

     DrawGzm.GraphClass.YAxisType:=4;  // �ĸ�������
     // ���� ������ ��ʾ
     DrawGzm.GraphClass.Line_Tpye:=1;// ���������Ƿ� �ò�ͬ���ͱ�ʾ  0 ͳһ���� 1 ��ͬ����
     DrawGzm.GraphClass.Line_Color:=1; //�������� �Ƿ� ͳһ��ɫ��ʾ  0 ��ɫ  1 ��ɫ �� ��  ��  ��
     DrawGzm.GraphClass.Line_Width:=0;  // �ߵĿ���Ϊ1
    //
    DrawGzm.ConTourSeriesPar.Display_UpperFootage:=0;;
    DrawGzm.ConTourSeriesPar.Display_DownFootage:=1;
  //��ȡ��������ʾ�����÷�ʽ

    DrawGzm.CloudClass.X_Axis_Disp_Type:=1;
    DrawGzm.CloudClass.X_Axis_Disp_Dao:=100;

  //��ȡ�Ƿ���ʾԤ��������Ϣ
    DrawGzm.CloudClass.DisPlayForcase:=true;


    //��ȡ�Ƿ���ʾ��С����֮ǰ����ѹ����
    DrawGzm.CloudClass.DisPlayProMinDaoSaveStep:=true;

     //��ȡ�Ƿ�������·���  ���ڽ���֮�ڵ����򱣴������
     DrawGzm.CloudClass.RecallMidDaoSaveStep:=False;

   //��ȡ�洢����������ʾ������ͼ������ʾ��ѹ����
     DrawGzm.CloudClass.DisplaySaveDate_Quyu_Step:=False;


     //��ȡ������Χ֮�����ѹ��Ϣ�Ƿ����
     DrawGzm.CloudClass.PrintOutDaoStepInto:=False;

       //��ȡ��ѹ���ݷֶ���ʾ��ʽ
     DrawGzm.CloudClass.PrintDispPhaseVisual:=False;

end;

procedure TRockPressGraph_From.InitForm;
var
  i:integer;
begin
    ChartPageControl.Align :=alClient;
    Public_basic.InitStatusBar(StatusBar1);
    // �Զ��� �����渳ֵ ��������ݱ��������
    AutoLoadcomboBox(s_MinName,S_WorkFaceName);
   
       // ��ʼ�� ͼ����ز���
    LineSeries.XValues.Order:=loNone;
    LineSeries.Pen.Width :=DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide;
    LineSeries.Pen.Color :=ClBlue;
    LineSeries.OutLine.Visible :=true;
    LineSeries.Pointer.Size:=LineSeries.Pen.Width+4;
    // MapSeries.Selected.Hover.Visible :=false;
    ContourSeries.Selected.Hover.Visible :=False;
    DrawGZm.MapSeriesEditState :=-1;  // Ĭ��û�м�������
    DrawGzm.CloudClass.OldStepDisplay :=False; //��ͼ����ʾ��ѹ����
    //Ĭ�����ݵ�λΪBar
    ChangePressDataUnit(2);
    loadRockPress:=False; // �Ƿ���ؿ�ѹ����
    RockPressAnslysis:=False;//��ѹ����������
    // ��ʼ��DrawGzmClass
    InitDrawGzmClass;
end;


procedure TRockPressGraph_From.InitKyfxResultStringGrid;
var
   i:integer;
begin
    for i := 1 to  StringGrid_Result.RowCount - 1 do
          StringGrid_Result.Rows[i].Clear ;

      StringGrid_Result.ColCount :=24;
      StringGrid_Result.RowCount :=3;
      StringGrid_Result.Font.Size:=9;
      StringGrid_Result.FixedRows :=2;
      StringGrid_Result.FixedCols :=1;

      StringGrid_Result.Cells [0,0]:='  ��';
      StringGrid_Result.Cells [0,1]:='  ��';
        StringGrid_Result.ColWidths[0]:=30;
      StringGrid_Result.Cells [1,0]:='Ԥ��';
      StringGrid_Result.Cells [1,1]:='��ʽ';
        StringGrid_Result.ColWidths[1]:=50;

      StringGrid_Result.Cells [2,0]:='��ѹ';
      StringGrid_Result.Cells [2,1]:='�׶�';
        StringGrid_Result.ColWidths[2]:=50;

      StringGrid_Result.Cells [3,0]:='�׶�֧';
      StringGrid_Result.Cells [4,0]:='�ܷ�Χ';
        StringGrid_Result.Cells [3,1]:=' ��ʼ';
        StringGrid_Result.Cells [4,1]:=' ����';
        StringGrid_Result.ColWidths[3]:=50;
        StringGrid_Result.ColWidths[4]:=50;

      StringGrid_Result.Cells [5,0]:='Ԥ��';
      StringGrid_Result.Cells [5,1]:='����';
        StringGrid_Result.ColWidths[5]:=50;

      StringGrid_Result.Cells [6,0]:='��ѹ��';
      StringGrid_Result.Cells [7,0]:='ʼ����';
        StringGrid_Result.Cells [6,1]:='��Сֵ';
        StringGrid_Result.Cells [7,1]:='���ֵ';
        StringGrid_Result.ColWidths[6]:=50;
        StringGrid_Result.ColWidths[7]:=50;
      StringGrid_Result.Cells [8,0]:='��ѹ��';
      StringGrid_Result.Cells [9,0]:='������';
        StringGrid_Result.Cells [8,1]:='��Сֵ';
        StringGrid_Result.Cells [9,1]:='���ֵ';
        StringGrid_Result.ColWidths[8]:=50;
        StringGrid_Result.ColWidths[9]:=50;

      StringGrid_Result.Cells [10,0]:='Һѹ֧';
      StringGrid_Result.Cells [11,0]:='�ܷ�Χ';
        StringGrid_Result.Cells [10,1]:=' ��ʼ';
        StringGrid_Result.Cells [11,1]:=' ����';
        StringGrid_Result.ColWidths[10]:=50;
        StringGrid_Result.ColWidths[11]:=50;

     StringGrid_Result.Cells [12,0]:='��С';
     StringGrid_Result.Cells [12,1]:='ѹ��';
        StringGrid_Result.ColWidths[12]:=50;

     StringGrid_Result.Cells [13,0]:='���';
     StringGrid_Result.Cells [13,1]:='ѹ��';
        StringGrid_Result.ColWidths[13]:=50;
     StringGrid_Result.Cells [14,0]:='ƽ��';
     StringGrid_Result.Cells [14,1]:='ѹ��';
        StringGrid_Result.ColWidths[14]:=50;

     StringGrid_Result.Cells [15,0]:='ƽ��ѹ';
     StringGrid_Result.Cells [15,1]:='��ϵ��';
        StringGrid_Result.ColWidths[15]:=50;

     StringGrid_Result.Cells [16,0]:='��ѹǿ';
     StringGrid_Result.Cells [16,1]:='��ϵ��';
        StringGrid_Result.ColWidths[16]:=50;

     StringGrid_Result.Cells [17,0]:=' ��ѹ';
     StringGrid_Result.Cells [18,0]:=' ����';
        StringGrid_Result.Cells [17,1]:=' ��С';
        StringGrid_Result.Cells [18,1]:=' ���';
        StringGrid_Result.ColWidths[17]:=50;
        StringGrid_Result.ColWidths[18]:=50;

     StringGrid_Result.Cells [19,0]:='������';
     StringGrid_Result.Cells [20,0]:='������';
        StringGrid_Result.Cells [19,1]:=' ��С';
        StringGrid_Result.Cells [20,1]:=' ���';
        StringGrid_Result.ColWidths[19]:=50;
        StringGrid_Result.ColWidths[20]:=50;

     StringGrid_Result.Cells [21,0]:='�ȶ���';
     StringGrid_Result.Cells [21,1]:='������';
        StringGrid_Result.ColWidths[21]:=50;

     StringGrid_Result.Cells [22,0]:='ѹ���������Ե�֧��';
        StringGrid_Result.ColWidths[22]:=200;

end;










procedure TRockPressGraph_From.OptionTip(index:integer;Str:String);
begin
   self.StatusBar1.Panels[index].Text :=str;
end;



procedure TRockPressGraph_From.Main_PageControlDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
    if Active then
    begin
        Control.Canvas.Brush.Color := ClGreen;
        Control.Canvas.Font.Color := clWhite;
    end;
    Control.Canvas.FillRect(Rect);
    Control.Canvas.TextOut(Rect.Left + 4,Rect.Top + 4,Main_PageControl.Pages[TabIndex].Caption);
end;

procedure TRockPressGraph_From.PageControl_ResultDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
   if Active then
    begin
        Control.Canvas.Brush.Color := ClHighLight;
        Control.Canvas.Font.Color := clWhite;
    end;
    Control.Canvas.FillRect(Rect);
    Control.Canvas.TextOut(Rect.Left + 4,Rect.Top + 4,PageControl_Result.Pages[TabIndex].Caption)
end;

procedure TRockPressGraph_From.Panel1Click(Sender: TObject);
begin
    DrawGzm.CloudClass.OldStepDisplay :=true;
    //ˢ�����ͼ��
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
   if  DrawGzm.Auto_Judge_OldStep.isCalComeStep  then  begin
       InitKyfxResultStringGrid;
       DrawGzm.CalComeStepAndPrintToMemo(Memo_Result,StringGrid_Result);
   end;
end;

procedure TRockPressGraph_From.LineGraphPop_CursorClick(Sender: TObject);
begin
    SetGraphChartShiziVisible(not GraphCursorTool.Visible);
end;

procedure TRockPressGraph_From.LineGraphPop_NextDataClick(Sender: TObject);
begin
    DrawLineGraph.NextDataDisp :=not  DrawLineGraph.NextDataDisp;
    RefreshMyGraphChart(true);
end;

procedure TRockPressGraph_From.LineGraphPop_RefreshClick(Sender: TObject);
begin
    RefreshMyGraphChart(False);
end;

procedure TRockPressGraph_From.LineGraphPop_toolClick(Sender: TObject);
begin
  CreateRockPressTool(Application.Handle,'��ͼ��ʾ�������ý���',
             RockPressGraph_From.Width ,RockPressGraph_From.Height,2);
end;

procedure TRockPressGraph_From.LoadRockPressData(Flag: integer);
begin
   //��ȡ�ֹ�¼������
   DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,true,100,100);
   DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
   if DrawGzm.SelectDataBasic_DaoOrFootage  =0 then  begin //�Խ���Ϊ�����в�ѯ
      if not  DrawGzm.GetManualInputPressData(intToStr(DrawGzm.FGzm.Gzmbh),
                   DrawGzm.DataTimeAndFootAge.Graph_MinDao, DrawGzm.DataTimeAndFootAge.Graph_MaxDao,SecondPGBar) then
           exit;
   end else begin
      if not  DrawGzm.GetManualInputPressData(intToStr(DrawGzm.FGzm.Gzmbh),
                   DrawGzm.DataTimeAndFootAge.StartTime, DrawGzm.DataTimeAndFootAge.EndTime,SecondPGBar) then
           exit;
   end;

   // ������ͼ
    DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,False,0,0);

    //��֪��Ϊʲô����Ҫˢ������
    RefreshMyCloudChart ;

    // ���ư�ť
    ContourPop_loadData.Enabled:=False;
    DrawGzm.MapSeriesEditState:=1;
    ChartPageControl.ActivePage:=ChartPageControl.Pages[0];
    // ��¼�����Ƿ����
    LoadRockPress:=true;
end;

function TRockPressGraph_From.ZoomRect(mRect: TRect; mZoom: Integer): TRect;
begin
  Result.Left := mRect.Left - mZoom;
  Result.Right := mRect.Right + mZoom;
  Result.Top := mRect.Top;// - mZoom;
  Result.Bottom := mRect.Bottom- mZoom;
end;



procedure TRockPressGraph_From.RadioGroup_DownFootageClick(Sender: TObject);
begin
   ContourPop_refreshchart.Click ;
end;

procedure TRockPressGraph_From.RadioGroup_UpperFootageClick(Sender: TObject);
begin
  ContourPop_refreshchart.Click ;
end;

procedure TRockPressGraph_From.RecallLoadDataToDataBase(Value:Boolean);
begin
     ContourPop_loadData.Enabled :=Value;
     if not  Value then
        contourPop_KYFX.Enabled :=Value;
end;

procedure TRockPressGraph_From.RefreshAllFormData;
begin
    RefreshMyCloudChart;
    RefreshMyGraphChart(false);
end;

procedure TRockPressGraph_From.RefreshContourlegendPalette;
begin
    ContourChart.Legend.Visible :=true;
    if DrawGzm.ColorValue.UnitType=1 then  begin
       ContourChart.Legend.Title.Text.Text :='MPa';
    end else begin
       ContourChart.Legend.Title.Text.Text :='Bar';
    end;
    ContourChart.Legend.Transparent:=true;
    ContourChart.AutoRepaint :=true;
    ContourChart.Refresh;
    


end;



procedure TRockPressGraph_From.RefreshMyCloudChart;
var
 tmpBoolena:Boolean;
begin
   ChartPageControl.ActivePage :=TabSheet_Contour;
    // ������ͼ
   DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,true,100,100);
   DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);


   DrawGzm.RefreshChart_ConTourSeries(ContourChart,self.ContourSeries,FirstPGBAr,SecondPGBar);

   RefreshContourlegendPalette;
   DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,False,0,0);
   // ����û����ѹ�������ͼ
   tmpBoolena:=DrawGzm.CloudClass.OldStepDisplay ;
   DrawGzm.CloudClass.OldStepDisplay :=False;
   ContourChartSaveIntoBMP('');
   DrawGzm.CloudClass.OldStepDisplay:=tmpBoolena;

   if GetRockPressAnslysis then  begin
      if StartRockPressAnslysisBegin then begin
          DrawGzm.CloudClass.OldStepDisplay :=true;
          // ��ȷ������
          InitKyfxResultStringGrid;
          DrawGzm.CalComeStepAndPrintToMemo(Memo_Result,StringGrid_Result);
           //����ѹ����ͼ��
          if  DrawGzm.CloudClass.DisPlayForcase  then
              RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
      end else begin
         RockPressAnslysis:=False;
      end;
   end;
end;

procedure TRockPressGraph_From.RefreshMyGraphChart(Display:Boolean);
begin
   if Display then
      ChartPageControl.ActivePage :=TabSheet_Graph;
   {iChart:TChart;iDTF:TDataTimeAndFootAge;
                           iClourClass:TCloudClass;
                           iGzm:TGzm;
                           iLineClass:TGraphDataClass}
   DrawLineGraph.UnitType := DrawGzm.ColorValue.UnitType;
   DrawLineGraph.InitClass(GraphChart,
                           DrawGzm.DataTimeAndFootAge,
                           DrawGzm.CloudClass,
                           DrawGzm.FGzm,
                           DrawGzm.GraphClass  ) ;

end;

procedure TRockPressGraph_From.RefreshOldStepAddToMapSeries(Visible: Boolean);
var
  Vis:Boolean;
begin
     if DrawGzm.FGzm.RockPressAnalysis.StepFillIsTran =0  then
              Vis:=true else Vis:=False;
      //�����������ˢ��
     DrawGzm.Auto_Judge_OldStep.Refresh;
     if Visible then  begin    // ������ͼ�Ƿ���ʾ
        // �жϵ���ѹ����
        DisplyMapSeries(MapSeries,DrawGzm.Auto_Judge_OldStep,
                     Vis,
                     DrawGzm.FGzm.RockPressAnalysis.StepFillColor,
                     DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide
                     );
        // ����Ԥ��Ԥ��

     end else begin
         MapSeries.Visible :=False;
     end;

      MainTreeView(TreeView1,'Series');

      LineSeries.Clear ;

     // �ı����ģʽ
     DrawGzm.MapSeriesEditState:=1;
     But_Kyfx_Depth_Fx.Enabled :=true;
    // SetMapSeriesIndexIntoOldStep(MapSeries,DrawGzm.Auto_Judge_OldStep);
end;



procedure TRockPressGraph_From.ReModiFyStepOldClass(OldStep: TOldSteps;
  EditMapRec: TEditMapSeriesRe);
var
  i:integer;
begin
   for I := 0 to 7 do
     OldStep.ExSteps[EditMapRec.StepClassid].SetMyOutLinePoint(
              i,
              EditMapRec.tmpPoints[i]
              );
    OldStep.ExSteps[EditMapRec.StepClassid].ModifyData :=1; // ��ʾ���ݱ��޶�
    OldStep.ExSteps[EditMapRec.StepClassid].Used :=1;
   //ˢ��һ������
   OldStep.ExSteps[EditMapRec.StepClassid].Refresh ;
   Optiontip(1,'���ݴ洢�ɹ���');
end;

procedure TRockPressGraph_From.ResultPop_OpenRightToolClick(Sender: TObject);
begin
  SetRightToolVisible(not RightPageControl.Visible);
end;

procedure TRockPressGraph_From.ResultPop_Print_PhaseClick(Sender: TObject);
begin
  DrawGzm.CloudClass.PrintDispPhaseVisual:=false;
    if  DrawGzm.Auto_Judge_OldStep.isCalComeStep  then  begin
       InitKyfxResultStringGrid;
       DrawGzm.CalComeStepAndPrintToMemo(Memo_Result,StringGrid_Result);
   end;
end;

procedure TRockPressGraph_From.ResultPop_Print_wholeClick(Sender: TObject);
begin
    DrawGzm.CloudClass.PrintDispPhaseVisual:=true;
   if  DrawGzm.Auto_Judge_OldStep.isCalComeStep  then  begin
       InitKyfxResultStringGrid;
       DrawGzm.CalComeStepAndPrintToMemo(Memo_Result,StringGrid_Result);
   end;
end;

procedure TRockPressGraph_From.ResultPop_SaveExcelClick(Sender: TObject);
begin
   Public_Basic.StringGridtoExcel('��ѹ�������',self.StringGrid_Result,14 );
end;

procedure TRockPressGraph_From.ResultPop_SaveTxtClick(Sender: TObject);
begin
       SaveDialog1.Filter :='���ı��ļ�(*.txt)|*.txt';
       SaveDialog1.Title :='*.txt';
       if SaveDialog1.Execute =true then  begin
          if ExtractFileExt(SaveDialog1.FileName) <> '.txt' then
                 SaveDialog1.FileName := ChangeFileExt(SaveDialog1.FileName,'.txt');
          SaveResultIntoFile(self.Memo_Result,SaveDialog1.FileName);
       end;

end;



procedure TRockPressGraph_From.RG_Yun_CycleClick(Sender: TObject);
begin
    ContourPop_refreshchart.Click ;
end;


procedure TRockPressGraph_From.RightVisiblePanelClick(Sender: TObject);
begin
    if RightPageControl.Visible  then   begin
       RightPageControl.Visible :=false;
       RightVisiblePanel.Caption :='<<';
       RightVisiblePanel.Width:=10;
       RightVisiblePanel.Color:=clYellow;
    end else begin
       RightPageControl.Visible :=true;
       RightVisiblePanel.Caption :='>>';
       RightVisiblePanel.Width:=10;
       RightVisiblePanel.Color:=clBtnFace;
    end;
     setRightToolVisible(RightPageControl.Visible);
end;

procedure TRockPressGraph_From.RockPressDataAnalysis(Series: TContourSeries);
{
  ��ѹ���ݷ���ģ��
  ��Ҫ����˼· �� Series ��ͼ����ȡ����
}
var
    i, j, m: Integer;
    lvl: TContourLevel;
    seg: TLevelSegment;

begin
      GB_Ky_Memo1.Clear ;
      for I := Series.Levels.Count-1 downto 0 do  begin
          lvl:=series.Levels.Items[i];
          GB_Ky_Memo1.Lines.Add('Level: ' + IntToStr(i) + ', UpToValue: ' + FormatFloat('#,##0.###', lvl.UpToValue));
          DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
          for j:=0 to length(lvl.Segments)-1 do
          begin
            DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
            seg:=lvl.Segments[j];
            GB_Ky_Memo1.Lines.Add('Segment: ' + IntToStr(j));

            for m:=0 to length(seg.Points)-1 do
            begin
               DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);
              GB_Ky_Memo1.Lines.Add('Point[' + IntToStr(m) + ']: (' + FormatFloat('#,##0.###', seg.Points[m].X) +
                     ',' + FormatFloat('#,##0.###', seg.Points[m].Y) + ')');
            end;

            GB_Ky_Memo1.Lines.Add('');
          end;

          GB_Ky_Memo1.Lines.Add('');

      end;

end;

procedure TRockPressGraph_From.SaveButtonClick(Sender: TObject);
begin
   ContourPop_refreshchart.Click ;
end;

function TRockPressGraph_From.SaveResultIntoFile(Memo1: TMemo;
  FileName: String): Boolean;
begin
   Memo1.Lines.SaveToFile(FileName);
end;




function TRockPressGraph_From.SelectRockPressDataNumber(DataType:integer):Boolean;
var
  sql,FieldStr:String;
begin
   Result:=False;
   MySqlDataSet2.Close ;

   if DataType< 5 then begin
      FieldStr:='MZL_Value';
   end else   begin
      FieldStr:='PressData';
   end;

   Sql:=' select Sum('+FieldStr+') as MCN from  D_'+IntToStr(DrawGzm.FGzm.Gzmbh)+'_ManualInputPressData  ';

   MySqlDataSet2.CommandText :=sql;
   try
       if MySqlDataSet2.Open then
        if MySqlDataSet2.FieldByName('MCN').AsFloat >100 then
           Result:=true;

   finally
       MySqlDataSet2.Close ;
   end;

end;

procedure TRockPressGraph_From.SetContourSeriseZoomUsed(Value: Boolean);
begin
     // ContourPop_LeftZoom
   if CurrentChart='TwoDimChart'  then    begin
      if Value then  begin
          ContourChart.Zoom.MouseButton := mbLeft;
          ContourPop_LeftZoom.Caption :='ֹͣ����Ŵ���';
        //  self.ContourChart_Cursor.Active:=false;
      end else begin
          if ContourChart.Zoom.MouseButton=mbLeft then  begin
              ContourChart.Zoom.MouseButton := mbMiddle;
              ContourPop_LeftZoom.Caption :='��������Ŵ���';
            //  self.ContourChart_Cursor.Active:=true;
          end else begin
              ContourChart.Zoom.MouseButton := mbLeft;
              ContourPop_LeftZoom.Caption :='ֹͣ����Ŵ���';
             // self.ContourChart_Cursor.Active:=false;
          end;
      end;
   end;
end;

procedure TRockPressGraph_From.SetGraphChartShiziVisible(Value: Boolean);
begin
    if Value then    begin
        LineGraphPop_Cursor.Caption :='�ر�ʮ�ֹ����';
        GraphCursorTool.Visible :=true;
    end else  begin
        LineGraphPop_Cursor.Caption :='��ʮ�ֹ����';
        GraphCursorTool.Visible :=FALSE;
    end;
end;

procedure TRockPressGraph_From.SetContourChartShiziVisible(Value: Boolean);
begin
    if Value then    begin
        ContourPop_Shizhi.Caption :='�ر�ʮ�ֹ����';
        ContourChart_Cursor.Visible :=true;
    end else  begin
        ContourPop_Shizhi.Caption :='��ʮ�ֹ����';
        ContourChart_Cursor.Visible :=FALSE;
    end;
end;



procedure TRockPressGraph_From.SetLoadDate(Value: Boolean);
begin
    loadRockPress:=Value;
end;

procedure TRockPressGraph_From.SetOldStepVisible(Value: Boolean);
begin
     {contourPop_Disp_Step}
    if Value then    begin
        contourPop_Disp_Step.Caption :='������ѹ��־��ͼ';
        DrawGzm.CloudClass.OldStepDisplay:=true;

    end else  begin
        contourPop_Disp_Step.Caption :='������ѹ��־��ͼ';
        DrawGzm.CloudClass.OldStepDisplay:=False;

    end;
end;

procedure TRockPressGraph_From.SetPolygenProperty(OneStep:TOldOneStep;CeatePoint:Boolean;
     Apol:TTeePolygon;Tran:Boolean; MC:TColor;LineW:integer);
var
  i,PointIndex:integer;
begin
   Apol.Transparency:=DrawGzm.FGzm.RockPressAnalysis.SetpFillTran;
   Apol.Transparent:=Tran;
   Apol.Color :=Mc;
   Apol.Pen.Color :=MC;
   Apol.Pen.Width :=LineW;
   if CeatePoint then
      for i := 0 to 7 do  begin
           PointIndex:=APol.Points.AddXY(OneStep.MyOutLinePoint[i].x ,OneStep.MyOutLinePoint[i].Y);
           OneStep.MyOutLinePoint[i].PointId := PointIndex;
      end;
end;



procedure TRockPressGraph_From.SetRightToolVisible(Value: Boolean);
begin
   //ContourPop_RightTool
    if Value then    begin
        ContourPop_RightTool.Caption :='�ر��Ҳ๤����';
        ResultPop_OpenRightTool.Caption:= '�ر��Ҳ๤����';
        RightPageControl.Visible :=true;
        ChartPageControl.ActivePageIndex :=0;
    end else  begin
        ContourPop_RightTool.Caption :='���Ҳ๤����';
        ResultPop_OpenRightTool.Caption:= '���Ҳ๤����';
        RightPageControl.Visible :=False;
    end;
end;




procedure TRockPressGraph_From.StartEditKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

function TRockPressGraph_From.StartRockPressAnslysisBegin: Boolean;
begin
    Result:=False;
    SetOldStepVisible(true);// ����������
    // У����ѯ����
    if DrawGzm.GetMyCoutOurColorUpToValue (DrawGzm.MyContourColor_NumLevel,
                      DrawGzm.FGzm.RockPressAnalysis.Min_Pt ,
                      DrawGzm.FGzm.RockPressAnalysis.NearColorLineUp_DownValue
                      )=-1 then    Exit;

      {�������ݷ�������}
     DrawGzm.Auto_Judge_OldStep.ClearSteps ;
     //�����ݿ�����ȡ ������ͼ����
     DrawGzm.ReadContoueSeriesToClass(DrawGzm.Auto_Judge_OldStep,2);
     // �������� ��ȡ �Ѿ� ����õĵ���ѹ���� ����
     DrawGzm.ReadContoueSeriesToClass(DrawGzm.Auto_Judge_OldStep,4);
    // ��ȡ���ݽ���
     DrawGzm.ExtractDataFormSeries(ContourSeries,Panel_ProcessBar,FirstPGBar,SecondPGBar);
 // ����������
     DrawGzm.Auto_Judge_OldStep.Sort;
 // ������ˢ��
     DrawGzm.Auto_Judge_OldStep.Refresh;
     MainTreeView(TreeView1,'Series');
     ChartPageControl.ActivePage :=ChartPageControl.Pages[0];
     // ���ư�ť
     But_Kyfx_FillMap.Enabled:=True;
     // ֱ��ˢ�� ���ദ�� ͼ��
     RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
     // ��������ͼ��ͼƬ
     if DrawGzm.CloudClass.OldStepDisplay then   ContourChartSaveIntoBMP('');;
     Result:=True;
end;

procedure TRockPressGraph_From.But_Kyfx_SaveBmpClick(Sender: TObject);
begin
  DrawGzm.SaveContourSeriesIntoDataBase(DrawGzm.Auto_Judge_OldStep,2 ) ;
  if DrawGzm.Auto_Judge_OldStep.isCalComeStep then
     DrawGzm.SaveContourSeriesIntoDataBase(DrawGzm.Auto_Judge_OldStep,4 ) ;
   OptionTip(1,'���ݱ���ɹ�!');
end;

procedure TRockPressGraph_From.But_Kyfx_StartClick(Sender: TObject);
begin
   StartRockPressAnslysisBegin;
end;



procedure TRockPressGraph_From.StringGrid_ResultMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt:Tpoint;
begin
   if Button=mbRight then begin
      pt:= self.StringGrid_Result.ClientToScreen(Point(0,0));
      DispResultPop (pt.X+x,pt.Y +y,'StringGrid');
   end;


end;

procedure TRockPressGraph_From.But_Kyfx_FillMapClick(Sender: TObject);

begin
    DrawGzm.CloudClass.OldStepDisplay :=true;
    //ˢ�����ͼ��
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
    ChartPageControl.ActivePage :=ChartPageControl.Pages[0];
end;

procedure TRockPressGraph_From.But_Kyfx_Depth_FxClick(Sender: TObject);
begin

   InitKyfxResultStringGrid;
   DrawGzm.CalComeStepAndPrintToMemo(Memo_Result,StringGrid_Result);
   ChartPageControl.ActivePage :=TabSheet_Result;
end;

procedure TRockPressGraph_From.TabSheet20Resize(Sender: TObject);
begin
    GB_Result_Memo.Height := TabSheet20.Height div 2;
end;

procedure TRockPressGraph_From.ToolButton1Click(Sender: TObject);
begin
   ContourPop_Save_Bmp.Click ;
end;

procedure TRockPressGraph_From.Open_ToolFormClick(Sender: TObject);
begin
   if ChartPageControl.ActivePage= TabSheet_Graph then   begin
      LineGraphPop_tool.Click;
   end else begin
      ContourPop_BasicTool.Click ;
   end;


end;

procedure TRockPressGraph_From.ToolButton4Click(Sender: TObject);
begin
 ContourPop_RightTool.Click ;
end;

procedure TRockPressGraph_From.TreePop_CloseClick(Sender: TObject);
begin
   SetRightToolVisible(FALSE);
end;

procedure TRockPressGraph_From.TreePop_DeleteClick(Sender: TObject);
begin
   if (TreeView_Stepid >=0) and (TreeView_Stepid < length(DrawGzm.Auto_Judge_OldStep.ExSteps) ) then
      DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].Used :=2;
     RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TRockPressGraph_From.TreePop_depthClick(Sender: TObject);
begin
  self.But_Kyfx_FillMap.Click ;
end;

procedure TRockPressGraph_From.TreePop_FillClick(Sender: TObject);
begin
   self.But_Kyfx_Start.Click ;
end;

procedure TRockPressGraph_From.TreePop_RecallClick(Sender: TObject);
begin
  if (TreeView_Stepid >=0) and (TreeView_Stepid < length(DrawGzm.Auto_Judge_OldStep.ExSteps) ) then
      DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].Used :=1;
     RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TRockPressGraph_From.TreePop_RefreshClick(Sender: TObject);
begin
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TRockPressGraph_From.TreePop_ReportClick(Sender: TObject);
begin
   But_Kyfx_Report.Click;
end;

procedure TRockPressGraph_From.TreePop_saveClick(Sender: TObject);
begin
  But_Kyfx_Depth_Fx.Click ;
end;

procedure TRockPressGraph_From.TreeView1Click(Sender: TObject);
var
  XNode: TTreeNode;
  i:integer;
  VIS:Boolean;
  MoveDis:double;
begin
  TreeView_Stepid:=-1;
  TreeView_APolid:=-1;
   if (TreeView1.Selected = nil) or (PMyRec(TreeView1.Selected.Data)^.DName = 'ROOT')   then
        Exit;

   if  Public_Basic.StrToInt_lu(PMyRec(TreeView1.Selected.Data)^.BName) <0  then   exit;

   XNode:=TreeView1.Selected;

   if (XNode=nil) then        exit;

   TreeView_Stepid:=Public_Basic.StrToInt_lu(PMyRec(XNode.Data )^.DName);
   TreeView_APolid:=Public_Basic.StrToInt_lu(PMyRec(XNode.Data )^.XHeight);

  if DrawGzm.FGzm.RockPressAnalysis.StepFillIsTran =0  then
              Vis:=true else Vis:=False;

  for I := 0 to self.MapSeries.Shapes.Count -1 do
    if i= TreeView_APolid then  begin
        SetPolygenProperty(DrawGzm.Auto_Judge_OldStep.ExSteps[0],false,
                   MapSeries.Shapes[i],
                   false,
                   DrawGzm.FGzm.RockPressAnalysis.SelectedFillColor,
                   DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide);
        //���ı༭״̬
    //  DrawGzm.EditMapPoint:=EditMapSeriesSteps(APolid,Stepid);
    end else begin
        SetPolygenProperty( DrawGzm.Auto_Judge_OldStep.ExSteps[0],false,
                   MapSeries.Shapes[i],
                   Vis,
                   DrawGzm.FGzm.RockPressAnalysis.StepFillColor,
                   DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide);
    end;

  // �ı��������λ��
     if ContourChart.BottomAxis.Minimum >=DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].GetMinDao   then    begin
         MoveDis:= DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].GetMinDao;
         if MoveDis-+DrawGzm.CloudClass.X_Axis_Disp_Dao/2 < DrawGzm.DataTimeAndFootAge.Graph_MinDao  then begin
            ContourChart.BottomAxis.SetMinMax(DrawGzm.DataTimeAndFootAge.Graph_MinDao,
                              DrawGzm.DataTimeAndFootAge.Graph_MinDao+DrawGzm.CloudClass.X_Axis_Disp_Dao);
         end else begin
            ContourChart.BottomAxis.SetMinMax(MoveDis-DrawGzm.CloudClass.X_Axis_Disp_Dao/2,MoveDis+DrawGzm.CloudClass.X_Axis_Disp_Dao/2);
         end;



     end;

     if ContourChart.BottomAxis.Maximum <=DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].GetMaxDao  then   begin
         MoveDis:= DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].GetMaxDao ;
         if MoveDis+DrawGzm.CloudClass.X_Axis_Disp_Dao /2  >DrawGzm.DataTimeAndFootAge.Graph_MaxDao  then begin
             ContourChart.BottomAxis.SetMinMax(DrawGzm.DataTimeAndFootAge.Graph_MaxDao-DrawGzm.CloudClass.X_Axis_Disp_Dao  ,
                            DrawGzm.DataTimeAndFootAge.Graph_MaxDao );
         end else begin
             ContourChart.BottomAxis.SetMinMax(MoveDis-DrawGzm.CloudClass.X_Axis_Disp_Dao /2 ,
                           MoveDis+DrawGzm.CloudClass.X_Axis_Disp_Dao /2 );
         end;


     end;



    if TreeView_Stepid>=0 then
       if TreeView_Stepid< length(DrawGzm.Auto_Judge_OldStep.ExSteps) then   begin
//         for i := 0 to DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].Pointcount -1 do   begin
//              GB_Ky_Memo1.Lines.Add('Point[' + IntToStr(i) + ']: (' + FormatFloat('0.00',DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].Points[i].x) +
//                       ',' +  FormatFloat('0.00',DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].Points[i].y) + ')');
//         end;
         GB_Ky_Memo1.Lines.add ('');
          for i := 0 to 7 do
           GB_Ky_Memo1.Lines.Add('OutPoint[' + IntToStr(i) + ']: (' + FormatFloat('0',DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].MyOutLinePoint[i].x) +
                       ',' +  FormatFloat('0',DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].MyOutLinePoint[i].y) + ')');
       end;



end;

procedure TRockPressGraph_From.TreeView1Collapsed(Sender: TObject; Node: TTreeNode);
begin
   Node.ImageIndex:=0;
   Node.SelectedIndex:=0;
end;

procedure TRockPressGraph_From.TreeView1Expanding(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
begin
     Node.ImageIndex:=1;
    Node.SelectedIndex:=1;
end;

procedure TRockPressGraph_From.TreeView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt:Tpoint;
begin
   if Button=mbRight then begin
      pt:= TreeView1.ClientToScreen(Point(0,0));
      DispTreePop (pt.X+x,pt.Y +y);
   end;


end;



end.  //end Unit