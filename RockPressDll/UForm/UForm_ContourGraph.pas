unit UForm_ContourGraph;

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
  UMakeRuleClass, uDrarLineGraph , UICallPstope , RockPressReport ,UIWinFrame
  ;

 type

  // 定义一个线程
  TReportWordThread = class; //此为提前申明
  TOnReported = procedure(Sender: TReportWordThread) of object;
  // 如果不提前申明，Sender 就要定义成 TObject
  // 在事件函数中，要操作 Sender 就需要强制转换
  TReportWordThread = class(TThread)
  protected
    procedure Execute; override;

  public
     iDrawGzm:TDrawGrap;  // 定义的类
     iCallPStope:TDefine_CallPStope; // 采矿算法类
     EiHandle:THandle;
     iKYGE_Report:TWordReport;  // 矿压观测 报告
     OnAccumulated: TOnReported;

  end;

  TForm_ContourGraph = class(TForm)
    StatusBar1: TStatusBar;
    TreePopu: TPopupMenu;
    TreePop_Delete: TMenuItem;
    TreePop_Recall: TMenuItem;
    ImageList1: TImageList;
    Panel_ProcessBar: TPanel;
    FirstPGBar: TProgressBar;
    SecondPGBar: TProgressBar;
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
    contourPop_KYFX_Result: TMenuItem;
    ImageList2: TImageList;
    ContourPop_Shizhi: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    TreePop_Refresh: TMenuItem;
    TreePop_Start: TMenuItem;
    TreePop_Fill: TMenuItem;
    TreePop_save: TMenuItem;
    TreePop_Report: TMenuItem;
    TreePop_Close: TMenuItem;
    N20: TMenuItem;
    SavePictureDialog1: TSavePictureDialog;
    SaveDialog1: TSaveDialog;
    Main_ToolBar: TToolBar;
    AddButton: TToolButton;
    SaveButton: TToolButton;
    But_Start_KYFX: TToolButton;
    ExitButton: TToolButton;
    Open_ToolForm: TToolButton;
    ToolButton4: TToolButton;
    ContourPop_BasicTool: TMenuItem;
    ContourPop_DrawLineGraph: TMenuItem;
    ContourPop_Disp_Result: TMenuItem;
    N7: TMenuItem;
    ContourPop_Disp_step: TMenuItem;
    ContourPop_ED: TMenuItem;
    contourPop_KYFX: TMenuItem;
    MainPanel: TPanel;
    RightPageControl: TPageControl;
    TabSheet12: TTabSheet;
    Splitter1: TSplitter;
    GB_KYFX_Top: TGroupBox;
    TreeView1: TTreeView;
    GB_KYFX_Bottom: TGroupBox;
    GB_KY_Memo1: TMemo;
    ToolBar1: TToolBar;
    But_Kyfx_Start: TToolButton;
    But_Kyfx_FillMap: TToolButton;
    ToolButton3: TToolButton;
    But_Kyfx_SaveBmp: TToolButton;
    But_Kyfx_Report: TToolButton;
    ContourChart: TChart;
    ContSeries: TContourSeries;
    LineSeries: TLineSeries;
    ContourChart_Cursor: TCursorTool;
    DragPoint: TDragPointTool;
    DragMark: TDragMarksTool;
    RightVisiblePanel: TPanel;
    Pop_EditArea: TPopupMenu;
    N4: TMenuItem;
    Pop_Edit_Save: TMenuItem;
    N6: TMenuItem;
    Pop_Edit_ReDo: TMenuItem;
    N12: TMenuItem;
    Pop_Edit_Del: TMenuItem;
    ContourPop_WheelZoom: TMenuItem;
    ContourPop_LeftMouse_panning: TMenuItem;
    ContourPop_ReDo: TMenuItem;
    N3: TMenuItem;
    Pop_Close: TMenuItem;
    But_Cursor: TToolButton;
    But_WheelZoom: TToolButton;
    But_LeftZoom: TToolButton;
    But_Left_Panning: TToolButton;
    But_LineGraph: TToolButton;
    N5: TMenuItem;
    TreePop_DeleteAll: TMenuItem;
    ContourPop_Single_Disp: TMenuItem;
    But_Single_Disp: TToolButton;
    But_selected: TToolButton;
    Pop_Selected: TPopupMenu;
    Pop_Select_DrawGraph: TMenuItem;
    N10: TMenuItem;
    Pop_Select_Bar: TMenuItem;
    N14: TMenuItem;
    Pop_Select_DTFZ: TMenuItem;
    N19: TMenuItem;
    Pop_Select_FyyD: TMenuItem;
    N22: TMenuItem;
    ContourPop_DTFZ: TMenuItem;
    ContourPop_Selected: TMenuItem;
    N9: TMenuItem;
    Pop_Edit_Info: TMenuItem;
    Mark_Memo: TMemo;
    N11: TMenuItem;
    ContourPop_Disp_ForCase: TMenuItem;
    TreePop_B_WordFile: TMenuItem;
    N21: TMenuItem;
    N16: TMenuItem;
    ContourPop_Disp_Tongji: TMenuItem;
    But_SupMove: TToolButton;
    ContourPop_SupMove: TMenuItem;
    KrigContour: TContourSeries;
    CoolBar1: TCoolBar;
    KYFX_toolBar: TToolBar;
    But_DispResult: TToolButton;
    But_DisplayStep: TToolButton;
    But_Disp_ForCase: TToolButton;
    But_Tongji: TToolButton;
    But_ThreeDim: TToolButton;
    But_KY_Report: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure ChartYunGetAxisLabel(Sender: TChartAxis; Series: TChartSeries;
      ValueIndex: Integer; var LabelText: string);

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure Footsteps_LKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);

    procedure ContourChartGetAxisLabel(Sender: TChartAxis; Series: TChartSeries;
      ValueIndex: Integer; var LabelText: string);
    procedure ContourChartMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ContourPop_loadDataClick(Sender: TObject);
    procedure ContourChartMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ContourPop_LeftZoomClick(Sender: TObject);
    procedure ContourPop_refreshchartClick(Sender: TObject);
    procedure ContourPop_Ky_MainClick(Sender: TObject);
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
    procedure contourPop_Disp_StepClick(Sender: TObject);
    procedure ContourPop_DeleteClick(Sender: TObject);
    procedure TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TreePop_DeleteClick(Sender: TObject);
    procedure TreePop_RecallClick(Sender: TObject);
    procedure TreePop_RefreshClick(Sender: TObject);
    procedure TreePop_CloseClick(Sender: TObject);
    procedure TreePop_FillClick(Sender: TObject);
    procedure TreePop_depthClick(Sender: TObject);
    procedure TreePop_ReportClick(Sender: TObject);
    procedure ContourPop_Save_BmpClick(Sender: TObject);
    procedure But_Kyfx_SaveBmpClick(Sender: TObject);
    procedure RG_Yun_CycleClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure But_Start_KYFXClick(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure But_ThreeDimClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure RadioGroup_DownFootageClick(Sender: TObject);
    procedure RadioGroup_UpperFootageClick(Sender: TObject);
    procedure ContourPop_BasicToolClick(Sender: TObject);
    procedure LineGraphPop_toolClick(Sender: TObject);
    procedure ContourPop_DrawLineGraphClick(Sender: TObject);
    procedure ContourPop_ED_SaveClick(Sender: TObject);
    procedure ContourPop_ED_ReCallClick(Sender: TObject);
    procedure ContourPop_ED_DelClick(Sender: TObject);
    procedure ContourPop_ED_EditClick(Sender: TObject);
    procedure ContourPop_Disp_ResultClick(Sender: TObject);
    procedure contourPop_KYFXClick(Sender: TObject);
    procedure ContourPop_RightToolClick(Sender: TObject);
    procedure RightVisiblePanelMouseEnter(Sender: TObject);
    procedure RightPageControlMouseLeave(Sender: TObject);
    procedure RightPageControlMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ContourChartClick(Sender: TObject);
    procedure Pop_Edit_SaveClick(Sender: TObject);
    procedure Pop_Edit_ReDoClick(Sender: TObject);
    procedure Pop_Edit_DelClick(Sender: TObject);
    procedure ContourPop_EDClick(Sender: TObject);
    procedure ContourChartMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure ContourChartMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ContourPop_WheelZoomClick(Sender: TObject);
    procedure ContourPop_LeftMouse_panningClick(Sender: TObject);
    procedure ContourPop_ReDoClick(Sender: TObject);
    procedure Pop_CloseClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure But_CursorClick(Sender: TObject);
    procedure But_WheelZoomClick(Sender: TObject);
    procedure But_LeftZoomClick(Sender: TObject);
    procedure But_Left_PanningClick(Sender: TObject);
    procedure But_LineGraphClick(Sender: TObject);
    procedure TreePop_StartClick(Sender: TObject);
    procedure TreePop_saveClick(Sender: TObject);
    procedure TreePop_DeleteAllClick(Sender: TObject);
    procedure ContourPop_Single_DispClick(Sender: TObject);
    procedure But_Single_DispClick(Sender: TObject);
    procedure Pop_Select_DrawGraphClick(Sender: TObject);
    procedure But_selectedClick(Sender: TObject);
    procedure Pop_Select_BarClick(Sender: TObject);
    procedure ContourChartAfterDraw(Sender: TObject);
    procedure Pop_Select_FyyDClick(Sender: TObject);
    procedure Pop_Select_DTFZClick(Sender: TObject);
    procedure Pop_Edit_InfoClick(Sender: TObject);
    procedure But_DisplayStepClick(Sender: TObject);
    procedure But_DispResultClick(Sender: TObject);
    procedure But_Disp_ForCaseClick(Sender: TObject);
    procedure ContourPop_Disp_ForCaseClick(Sender: TObject);
    procedure But_Kyfx_ReportClick(Sender: TObject);
    procedure TreePop_B_WordFileClick(Sender: TObject);
    procedure But_KY_ReportClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Open_ToolFormClick(Sender: TObject);
    procedure ContourPop_Disp_TongjiClick(Sender: TObject);
    procedure But_TongjiClick(Sender: TObject);
    procedure But_SupMoveClick(Sender: TObject);
    procedure ContourPop_SupMoveClick(Sender: TObject);
  private
    { Private declarations     }

     Mouse_x,Mouse_y:integer;
     MySqlDataSet1:TMyDataSet;
     MySqlDataSet2:TMyDataSet;
     MyCommand1:TMyCommand;

     s_MinName,S_WorkFaceName:string;
     CurrentChart:String;
     BasicJinDao:TBasicJinDao;
     //
     MapSeries:TMapSeries;
     TreeView_Stepid,TreeView_APolid:integer;
     loadRockPress:Boolean;  // 是否提取了矿压数据
     AutoRightPanelOpen:Boolean;// 右侧工具栏是否是自动打开的
     // mouse Button
     MuddleWheelForZoom:Boolean; // 鼠标中间滚轮作为放大缩小的功能
     LeftMousePanning:Boolean;//鼠标左键平移图片
     DraggingRectangle:Boolean;//鼠标拖动矩形选择区域
     Rect_X0,Rect_X1,Rect_Y0,Rect_Y1:integer; //圈定区域的坐标
     bMouseDown:Boolean;// 记录鼠标按下的次数与状态
     MapSeriesDataEdit:Boolean; // 记录数据修改状态
     FChartRefreshFinlly:Boolean;// 记录Chart是否否新完成
     // Dll 引用
     CallPStope:TDefine_CallPStope; // 采矿算法类
     iUserWin:TDefine_WinFrame; {用户DLL类}

     KYGE_Report:TWordReport;  // 矿压观测 报告
     ShowScreen:integer;//屏幕关闭函数
     ForceClose:Boolean;// 强制关闭

    procedure InitDrawGzmClass;//初始化工作面类
    function  SelectRockPressDataNumber(DataType:integer):Boolean;
    procedure OptionTip(index:integer;Str:String);
    procedure AutoLoadcomboBox(MkName,WkName:string);
   //-----------------------
    procedure RefreshContourlegendPalette;
    function  GetBatInputDataMaxGenTime(Support:integer):TDateTime;
    Procedure FillBasicJinDao(B_JinDao:TBasicJinDao;Support:integer);
    //---------------------------

    function  ZoomRect(mRect: TRect; mZoom: Integer): TRect;// 绘制表格线
    //--------------------------
    procedure setRightToolVisible(Value:Boolean);
    procedure DispContourPopMemu(Px,Py:Integer);  //显示云图控制快捷菜单
    procedure DispPopEditArea(Px,Py:Integer);  // 控制编辑菜单的显示
    Procedure DispTreePop(Px,Py:Integer);//显示TreeView控制快捷菜单
    procedure DispSelectEd(Px,py:Integer); // 显示 选中的快捷方式

    //----------------------------
    procedure CopyDataToStringGridFromPaste(StrGrid: TstringGrid; Col,
                  Row, ColNumber: integer);
    procedure ChangePressDataUnit(Flag:integer);  // 更改数据单位
    //---------------------------------------

    procedure ChangeRectangleToDrawSupportLineGraph(x0,y0,x1,y1:integer); // 把进尺送出去
    function  ReturnSelectRectangleSupport(MinSup,MaxSup:integer):string;
    procedure SetContourChartShiziVisible(Value:Boolean);// 云图十字坐标指示

    procedure SetMapSeriesSelected(Value:Boolean);//设置图形为选中的状态
    procedure SetMouseInitValue;  //设置鼠标滚轮初始状态
    procedure SelectReganleToDrawLinGraph(Value:Boolean);// 启动选择区域绘制压力曲线
    procedure ClearRectangle;// 把圈定的区域清空
    procedure SetContourSeriseZoomUsed(Value:Boolean);//启用鼠标左键放大功能
    procedure SetCharWheelZoom(Value:Boolean); //是否启用滚轮推拉缩放
    procedure SetChartRightPanning(Value:Boolean);//是否启用左键平移功能
    procedure SetOldStepVisible(Value:Boolean);//设置是否显示来压步距
    procedure SetMiddleWheelForZoom(Value:Boolean);// 启动 或者进制 中间鼠标作为放大缩小的功能
    procedure SetContourSeriesDisply(Value:Boolean);// 控制云图的显示方式单色还是彩色
    procedure SetDispForCase(Value:Boolean); // 是否显示 预测步距
    //-------------------------------------------------------------
    procedure RecallLoadDataToDataBase(Value:Boolean);//从数据库重新加载数据
    // RockPreeKyfx
    procedure MainTreeView(TreeView: TTreeView;FromWhere:string);
    procedure ExtractDataFormSeries(TreeView: TTreeView;ParantNode:TTreeNode;Series:TContourSeries;
              DataType:integer);
    procedure RockPressDataAnalysis(Series:TContourSeries);
       //control Series Display
       {显示步距标注}
    procedure DisplyMapSeries(series:TMapSeries;OldStep:TOldSteps;TranVis:Boolean;Color:TColor;LineWide:integer);
    procedure SetPolygenProperty(OneStep:TOldOneStep;CeatePoint:Boolean;
                  Apol:TTeePolygon;Tran:Boolean;MC:TColor;LineW,SaveOrFx:integer);
    procedure MapSeriesClick(Sender: TChartSeries; ValueIndex: Integer;
              Button: TMouseButton; Shift: TShiftState; X, Y: Integer) ;
    procedure MapSeriesDoubleClick(Sender: TChartSeries; ValueIndex: Integer;
              Button: TMouseButton; Shift: TShiftState; X, Y: Integer) ;
    procedure DispLabelMarkToMemo(Value:Boolean;Px,Py,Stepid:integer);

     //--------------------------------------------------
    //开始进行矿压数据分析的引导函数
    function  StartRockPressAnslysisBegin(AutoOrManual:Boolean):Boolean;
    function  EditMapSeriesSteps(ApolId,StepClassId:integer):TEditMapSeriesRe;
    function  AutoAnslysis_LevelLine(Ratio:double;var LevelValue,Inv_D:double;
                 var RaiseOrDrop:Boolean;var RaiseCount:integer):Boolean;
//    function  AutoAnslysis_SupDao(Ratio:double;var LevelValue,Con_Sup,Con_Dao:integer;
//                 var RaiseOrDrop:Boolean):Boolean;
    procedure ReModiFyStepOldClass(OldStep:TOldSteps;EditMapRec:TEditMapSeriesRe);
    //刷新来压步距的图层函数
    procedure RefreshOldStepAddToMapSeries(Visible:Boolean);

    function CreateSaveBmpPath:String; //创建保存图片的文件路径
    function GetContOurChartBmpFileName(Value:integer):String;
    function GetSelectRectangleSupport(MinSup, MaxSup: integer): string;  //获取contourChar保存文件的文件名
    //刷新chart
    function ChartRefresh:boolean;
    procedure setChartRefresh(Value:Boolean);
    function GetChartFefresh:Boolean;
    procedure SetBut_KYFX_Enabled(Value:Boolean);
    procedure SetKrigcontour(Value:Boolean);
    procedure SetFromWidthAndHeigth(flag:integer);

    function GetScreenFlag:integer;
    procedure SetScreenFlag(value:integer);
    function  CloseCheckRunThread:Boolean;
    procedure OnAccumulated(Sender:TReportWordThread);

  public
     EXCaption:String; // 外部传过来的标题
     DrawGzm:TDrawGrap;  // 定义的类
    // DrawLineGraph:TDrawLineGraph;
    { Public declarations }

      procedure InitForm;      //初始化界面部分功能
      procedure RefreshMyCloudChart;

      procedure LoadRockPressData(Flag:integer);
      function  GetLoadDate:Boolean;
      procedure SetLoadDate(Value:Boolean);
      function  GetRockPressAnslysis:Boolean;
      function  setContourChartMin_MaxToBmp(Min_X,Max_X:double):String;
      // 保存文件
      function ContourChartSaveIntoBMP(Path:string;Value:integer):Boolean;
      // 给外部打开使用的文件
      procedure OpenLinGraph(inHandle:THandle;wid,hig:integer);
      procedure OpenThreeResult(inHandle:THandle;wid,hig:integer);
      procedure OpenBndBar(inHandle:THandle;wid,hig:integer);
      procedure OpenTongJi(inHandle:THandle;wid,hig:integer);
      procedure MovePointState(inHandle:THandle;wid,hig:integer);
      procedure OpenResultExcel(inHandle:THandle;wid,hig:integer);
      procedure OpenReportWord(inHandle:THandle;wid,hig:integer);
      function CheckExcelThreadClosed:Boolean;
      procedure SetForceClose(Value:Boolean);
      procedure SetMinMaxJinDao(MinD,MaxD:integer);

      property ChartRefreshFinlly:Boolean read GetChartFefresh write setChartRefresh;
      property CloseScreenFlag:integer read GetScreenFlag write SetScreenFlag;
  end;

function Create_ConTourGrap(AHandle:THandle;ACaption:string;Wid,Hi,Flag:integer):THandle;stdcall;
procedure  Open_innFrom(AHandle:THandle;MinD,MaxD,Flag:integer);stdcall;
var
 Form_ContourGraph: TForm_ContourGraph;
 ExHandle:THandle;
implementation

{$R *.dfm}

uses  Lu_Public_BasicModual, PStope_GzmGuidClass, RockPresstool,
  UForm_LineGraph, UForm_StepResult, UForm_Brand_Bar, uMainFun,
  UForm_phaseGraph_Tongji, UForm_MoveSupportGraph, UForm_ThreeDimGraph;

//
{引用  'LibCallPstope.dll'， 为 TuserCallPstope 服务}
function TCallPStope:TClassStateMent_CallPStope; external 'LibCallPStope.dll' ;
{引用  'LibWinFrame.dll'， 为 UserWin:TWinFrame 服务}
function TuseWin:TClassStateMent_WinFrame; external 'LibWinFrame.dll' ;


//==============
procedure  Open_innFrom(AHandle:THandle;MinD,MaxD,Flag:integer);stdcall;
begin
  if Assigned(Form_ContourGraph) then  FreeAndNil(Form_ContourGraph);
        ExHandle:=AHandle;
        Application.Handle :=AHandle;
        Form_ContourGraph:=TForm_ContourGraph.Create(Application);

         try
           with Form_ContourGraph do begin

               ParentWindow:=Ahandle;
               Top :=0;
               Left:=0;
               SetFromWidthAndHeigth(Flag);
               SetMinMaxJinDao(MinD,MaxD);
          end ;
        except
           FreeAndNil(Form_ContourGraph);
        end;

end;

function Create_ConTourGrap(AHandle:THandle;ACaption:string;Wid,Hi,Flag:integer):THandle;stdcall;
{Flag 1 进尺维护  Flag 2 矿压数据维护  3 矿压数据分析}
begin
        if Assigned(Form_ContourGraph) then  FreeAndNil(Form_ContourGraph);
        ExHandle:=AHandle;
        Application.Handle :=AHandle;
        Form_ContourGraph:=TForm_ContourGraph.Create(Application);

         try
           with Form_ContourGraph do begin
               EXCaption:=ACaption;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

               SetFromWidthAndHeigth(Flag);
               CreateRockPressTool(MainPanel.Handle,'云图显示属性设置界面',
                            Form_ContourGraph.Width ,Form_ContourGraph.Height,1);

               Result:=Form_ContourGraph.Handle ;//函数值
          end ;
        except
           FreeAndNil(Form_ContourGraph);
        end;


end;

{ TForm1 }

procedure TForm_ContourGraph.AddButtonClick(Sender: TObject);
begin
   LoadRockPressData(1);
end;

function TForm_ContourGraph.AutoAnslysis_LevelLine(Ratio: double; var LevelValue,Inv_D:double;
                      var RaiseOrDrop:Boolean;var RaiseCount:integer): Boolean;
{
  返回这次是 上行还是下行
  RaiseOrDrop true  上行  false 下行
}

begin
   Result:=False;

    if (Ratio >=25  )  and (Ratio <= 35 )  then begin
       Result:=True ;
       exit;
    end else if (Ratio <20 )  and (not RaiseOrDrop)  then begin
       RaiseOrDrop:=False;
       Inv_D:=4;
    end else  if (Ratio < 30 )  and ( not RaiseOrDrop)  then begin
       RaiseOrDrop:=False;
       if Inv_D < 2 then  begin
           Inv_D:=Inv_D/2;
       end else  begin
          Inv_D:=3/2;
       end;
    end  else if (Ratio > 30 )   then begin
       RaiseOrDrop:=true;
       inc(RaiseCount);
       Inv_D:=Inv_D/2;
    end  else if (Ratio < 30 )  and ( RaiseOrDrop)  then begin
       RaiseOrDrop:=False;
       inc(RaiseCount);
       Inv_D:=Inv_D/2;
    end else begin
       Result:=True ;
       exit;
    end;


    if RaiseOrDrop then begin
        LevelValue:=LevelValue+Inv_D;
    end else begin
        LevelValue:=LevelValue-Inv_D;
    end;
    if Inv_D < 0.2 then    Result:=true;
    if (Ratio <5 ) and (LevelValue < 20)   then  begin
        Result:=true;
    end else  if (Ratio >95 ) and (LevelValue < 20)   then  begin
        Result:=true;
    end else if (LevelValue < 20)   then  begin
        Result:=False;
        LevelValue:=60;
    end;



end;

procedure TForm_ContourGraph.AutoLoadcomboBox(MkName, WkName: string);
var
   s_temp:Str_DT_array;
   i,C1:integer;
begin
   if length(trim(WkName))=0 then  exit;
   if not DrawGzm.SelectMineAndWorkFaceBh(MkName, WkName) then   exit;
   //判断与工作面相关的数据表是否创建，如果没有创建，再此创建
   if not MainDataModule.IsExsitTableName('D_'+inttostr(DrawGzm.FGzm.Gzmbh)+'_BasicData') then begin
       MainDataModule.CreateTable('2',MainDataModule.DataType,inttostr(DrawGzm.FGzm.Gzmbh),'') ;
   end;
   // 在此对FGZM 的支架相关信息进行补充
    if not DrawGzm.Cal_MPaChangeKN_xs then  begin
       //messagebox(Handle,'请补全液压支架立柱的数据','系统提示',mb_iconerror+mb_ok);
    end;
   OptionTip(0,'对【'+DrawGzm.FGzm.S_Name+'】数据进行分析!');

end;



procedure TForm_ContourGraph.MainTreeView(TreeView: TTreeView;FromWhere:string);
 var
  strcon: String;
  RecData: PMyRec;
  xNode,xNodeJing:TTreeNode;
  i,j,k:integer;
begin
        //树图初始化
    TreeView.Items.Clear;
     //
    New(RecData);
    RecData^.BName:='-1';
    RecData^.DName:='ROOT';
    RecData^.XHeight:='-1';
    xNode:=TreeView.Items.AddObject(nil,'已经存储的来压信息',RecData);
    Xnode.ImageIndex:=0;
      ExtractDataFormSeries(TreeView,xNode,ContSeries,1);

    New(RecData);
    RecData^.BName:='-1';
    RecData^.DName:='ROOT';
    RecData^.XHeight:='-1';
    xNode:=TreeView.Items.AddObject(nil,'未存储的来压信息',RecData);
    Xnode.ImageIndex:=0;
       Xnode.Expand(true);
       ExtractDataFormSeries(TreeView,xNode,ContSeries,-1);





end;


procedure TForm_ContourGraph.MapSeriesClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//   if Button =mbLeft then  begin
//     DrawGzm.EditMapPoint.Apol :=ValueIndex;
//     if DrawGzm.Auto_Judge_OldStep.ReturnStepid(ValueIndex) > 0   then
//        DrawGzm.MapSeriesEditState:=2;
//   end;

end;

procedure TForm_ContourGraph.MapSeriesDoubleClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   pt:TPoint;
   Edited:Boolean;
begin
   if Button =mbLeft then  begin
       //更改编辑状态
     DrawGzm.EditMapPoint.Apol :=ValueIndex;
     if DrawGzm.Auto_Judge_OldStep.ReturnStepid(ValueIndex,Edited) > 0   then   begin
        DrawGzm.MapSeriesEditState:=2;
        DrawGzm.EditMapPoint:=EditMapSeriesSteps(ValueIndex,-1);
        DraggingRectangle:=False;
     end;
   end;
end;

procedure TForm_ContourGraph.MovePointState(inHandle: THandle; wid,
  hig: integer);
begin
    CreateSupportMove(inHandle,'',wid,hig,1);
    UForm_MoveSupport.InitForm(DrawGzm) ;
    UForm_MoveSupport.LoadsupportMoveData;
    UForm_MoveSupport.RefreshChartGraph;
end;

procedure TForm_ContourGraph.Pop_Edit_InfoClick(Sender: TObject);
var
  Pt1,pt0:TPoint;
begin
   GetCursorPos(pt1);
   pt0:= ContourChart.ClientToScreen(Point(0,0));
   DispLabelMarkToMemo(true,
                  pt1.X-pt0.x,
                  pt1.Y-pt0.y,
                  DrawGzm.EditMapPoint.StepClassid
                  ) ;
end;

procedure TForm_ContourGraph.ContourPop_Ky_MainClick(Sender: TObject);
begin
//    SetRightKyffVisible(true);
//   SetProcegressBarVisual(true,100,100);
//   StepProcegressBar(10,0);
   RockPressDataAnalysis(ContSeries);


end;

procedure TForm_ContourGraph.ContourPop_LeftMouse_panningClick(Sender: TObject);
begin
    SetChartRightPanning(not LeftMousePanning);
end;

procedure TForm_ContourGraph.ContourPop_LeftZoomClick(Sender: TObject);
begin
  SetContourSeriseZoomUsed( not ContourChart.Zoom.Allow);
end;

procedure TForm_ContourGraph.ContourPop_loadDataClick(Sender: TObject);
begin
   LoadRockPressData(1);
end;

procedure TForm_ContourGraph.ContourPop_ReDoClick(Sender: TObject);
begin
    ContourChart.UndoZoom;
end;

procedure TForm_ContourGraph.ContourPop_refreshchartClick(Sender: TObject);
begin
   RefreshMyCloudChart;
end;

procedure TForm_ContourGraph.ContourPop_RightToolClick(Sender: TObject);
begin
  setRightToolVisible(not RightPageControl.Visible);
end;

procedure TForm_ContourGraph.ContourPop_SaveEditMapClick(Sender: TObject);
begin
    ReModiFyStepOldClass(DrawGzm.Auto_Judge_OldStep,DrawGzm.EditMapPoint);
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TForm_ContourGraph.ContourPop_Save_BmpClick(Sender: TObject);
begin
  SavePictureDialog1.Execute ;
  ContourChartSaveIntoBMP(SavePictureDialog1.FileName,1);
end;

procedure TForm_ContourGraph.ContourPop_ShizhiClick(Sender: TObject);
begin
   SetContourChartShiziVisible(not ContourChart_Cursor.Visible);
end;



procedure TForm_ContourGraph.ContourPop_Single_DispClick(Sender: TObject);
begin
   SetContourSeriesDisply(not DrawGzm.ColorValue.ColorDisply);
end;

procedure TForm_ContourGraph.ContourPop_SupMoveClick(Sender: TObject);
begin
    But_SupMove.Click ;
end;

procedure TForm_ContourGraph.ContourPop_UndoEditClick(Sender: TObject);
begin
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;




procedure TForm_ContourGraph.ContourPop_WheelZoomClick(Sender: TObject);
begin
   SetCharWheelZoom(not MuddleWheelForZoom);
end;

procedure TForm_ContourGraph.ChangePressDataUnit(Flag: integer);
var
  i,j:integer;
  TemValue:Double;
  UnitName:string;
begin
  if Flag=1 then   begin
     UnitName :='当前数据单位为 MPa' ;
     DrawGzm.ColorValue.UnitType :=1;
     DrawGzm.ColorValue.UnitValue:=1;
     DrawGzm.ColorValue.UntiName:='MPa' ;
  end else begin
     UnitName :='当前数据单位为 Bar' ;
     DrawGzm.ColorValue.UnitType:=2;
     DrawGzm.ColorValue.UnitValue:=10;
     DrawGzm.ColorValue.UntiName:='Bar' ;
  end;
     Caption:=EXCaption+'【'+ UnitName+'】';

     RefreshMyCloudChart;
end;

procedure TForm_ContourGraph.ChangeRectangleToDrawSupportLineGraph(x0, y0, x1,
  y1:integer);
var
   SupSt,SupEn:integer;
   DaoSt,DaoEn:integer;

begin
    SupST:=Round(ContSeries.YScreenToValue(Y1));
    SupEn:=Round(ContSeries.YScreenToValue(Y0));
    DaoSt:=Round(ContSeries.XScreenToValue(X0));
    DaoEn:=Round(ContSeries.XScreenToValue(X1)) ;
   // SelectReganleToDrawLinGraph(False);
    ContSeries.Repaint;
    // 打开 绘制曲线图的界面
    CreateLineGraph(ExHandle,'',0,0,0);
    DrawGzm.GraphClass.CycleDataEfficient:=True;//代表从云图中传递数据
    Form_LineGraph.SetOpenFormVar(DrawGzm,
                                  ReturnSelectRectangleSupport(SupST,SupEn),
                                  true,
                                  true// 是否打开工具菜单
                                  );
end;

function TForm_ContourGraph.ChartRefresh: boolean;
begin
    ChartRefreshFinlly:=False;
    MapSeries.Repaint;
    ContSeries.Repaint;
    ContourChart.show;
end;

procedure TForm_ContourGraph.ChartYunGetAxisLabel(Sender: TChartAxis;
  Series: TChartSeries; ValueIndex: Integer; var LabelText: string);
var
  i:integer;
  FSetting : TFormatSettings;  //日期格式转换
begin
     //日期格式转换
       FSetting.ShortDateFormat:='yyyy-mm-ss' ;
       FSetting.DateSeparator :='-';
       FSetting.ShortTimeFormat :='hh:nn:ss';
       FSetting.TimeSeparator :=':';
       FSetting.DecimalSeparator :='.';
      // 更改第二坐标横轴
//     if Sender = ChartYun.Axes.Bottom.SubAxes.Items[0] then
//         LabelText :=  FormatFloat('0.00',DrawGzm.DatetimeToFootage(StrToDateTime(LabelText,FSetting),'Down'));
//     if Sender = ChartYun.Axes.Bottom.SubAxes.Items[1] then
//         LabelText :=  FormatFloat('0.00',DrawGzm.DatetimeToFootage(StrToDateTime(LabelText,FSetting),'Upper'));

end;

function TForm_ContourGraph.CheckExcelThreadClosed: Boolean;
begin
  if Assigned(Form_StepResult) then begin
       if Form_StepResult.GetExitFlag>=2 then  begin
          Form_StepResult.SetThreadStop;
          sleep(500);
       end;
       if  Assigned(Form_StepResult) then
            Form_StepResult.Close ;
    end;

    if ShowScreen >=2 then  begin
       KYGE_Report.SetReportExit(true);
    end;

  Result:=true;
end;

procedure TForm_ContourGraph.ClearRectangle;
begin
  bMouseDown:=false;
  Rect_X0 := -1;
  Rect_X1 := -1;
  Rect_Y0 := -1;
  Rect_Y1 := -1;
end;

function TForm_ContourGraph.CloseCheckRunThread: Boolean;
begin
   Result:=true;
   if Assigned(Form_StepResult) then  exit;
   if ShowScreen>=2  then  begin
      ShowScreen:=3;
      exit;
   end;


   Result:=False;
  // if Assigned(Form_StepResult) then  exit;
    //  CheckExcelThreadClosed
end;

procedure TForm_ContourGraph.ContourChartAfterDraw(Sender: TObject);
begin
   ChartRefreshFinlly:=True;
end;

procedure TForm_ContourGraph.ContourChartClick(Sender: TObject);
begin
    if AutoRightPanelOpen then begin
        setRightToolVisible(False);
        AutoRightPanelOpen:=False;
    end;
end;

procedure TForm_ContourGraph.ContourChartGetAxisLabel(Sender: TChartAxis;
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

procedure TForm_ContourGraph.ContourChartMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt:Tpoint;
begin
  DispLabelMarkToMemo(False,0,0,0);

   if Button=mbRight then begin
      pt:= ContourChart.ClientToScreen(Point(0,0));
      if DrawGzm.MapSeriesEditState =2 then  begin
        {意味着进入图形编辑状态}
        DispPopEditArea(pt.X+x,pt.Y +y) ;
      end else begin
        DispContourPopMemu(pt.X+x,pt.Y +y);
      end;

   end;
   // 记录第一次鼠标按下的位置
    if (Button = mbLeft) and DraggingRectangle then  begin
        Rect_X0 := X;
        Rect_Y0 := Y;
        bMouseDown := TRUE;
    end
end;

procedure TForm_ContourGraph.ContourChartMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    if bMouseDown then    begin
        Rect_X1 := X;
        Rect_Y1 := Y;
      //
        ContourChart.Draw;
    end;
    //
    if DraggingRectangle then   begin
      if (Rect_X0 <> -1) and (Rect_Y0 <> -1) then        begin
          //draw a rectangular square around the selected area
          ContourChart.Canvas.Brush.Style := bsClear;
          ContourChart.Canvas.Pen.Color := clBlack;
          ContourChart.Canvas.Rectangle(Rect_X0,Rect_Y0,Rect_X1,Rect_Y1);
        end;
      end
end;

procedure TForm_ContourGraph.ContourChartMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt:Tpoint;
begin
    if (Button = mbLeft) and DraggingRectangle then   begin
        Rect_X1 := X;
        Rect_Y1 := Y;
        bMouseDown := FALSE;

        if (Rect_X0 <> -1) and (Rect_Y0 <> -1) and
           (abs(Rect_X1-Rect_X0)>=2) and (abs(Rect_Y1-Rect_Y0)>=12 ) then        begin
          //ChangeRectangleToDrawSupportLineGraph(Rect_X0,Rect_Y0,Rect_X1,Rect_Y1);
           pt:= ContourChart.ClientToScreen(Point(0,0));
           DispSelectEd(pt.X+x,pt.Y +y);

        end;
    end;
end;

procedure TForm_ContourGraph.ContourChartMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
     DispLabelMarkToMemo(False,0,0,0);

      if MuddleWheelForZoom then  begin
         if WheelDelta>0 then  begin  //滚轮  前推 放大
             ContourChart.ZoomPercent( 110 );
         end else begin   //滚轮  后滚 缩小
             ContourChart.ZoomPercent( 90);
         end;
      end;
end;


function TForm_ContourGraph.ContourChartSaveIntoBMP(Path: string;Value:integer): Boolean;
{
  Path <> '' 是把 图片保存到 指定的路径中
  path = ''  是吧图片 自动保存到 系统位置
       _0  是代表没有步距云图的 图片
       _1  是代表有步距云图的 图片

}

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
         if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWaterFromFile(FileName)
            else Public_Basic.AddMultTextWaterFormFile(FileName);
   end else begin
     if Value=0 then  begin
        tmp:=GetContOurChartBmpFileName(1);
        FileName:=CreateSaveBmpPath+ tmp +'_'+IntTostr(ord(DrawGzm.CloudClass.Yuntu_CycleData))+'_0.bmp';
        ContourChart.SaveToBitmapFile(FileName);
        if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWaterFromFile(FileName)
               else Public_Basic.AddMultTextWaterFormFile(FileName);

     end else begin
        tmp:=GetContOurChartBmpFileName(Value);
        if not DrawGzm.CloudClass.OldStepDisplay then   begin
             FileName:=CreateSaveBmpPath+ tmp +'_'+IntTostr(ord(DrawGzm.CloudClass.Yuntu_CycleData))+'_1.bmp';
               ContourChart.SaveToBitmapFile(FileName);
               if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWaterFromFile(FileName)
                   else Public_Basic.AddMultTextWaterFormFile(FileName);
        end else begin
            FileName:=CreateSaveBmpPath+ tmp +'_'+IntTostr(ord(DrawGzm.CloudClass.Yuntu_CycleData))+'_2.bmp';
               ContourChart.SaveToBitmapFile(FileName);
               if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWaterFromFile(FileName)
                else Public_Basic.AddMultTextWaterFormFile(FileName);

        end;
     end;
   end;



end;

procedure TForm_ContourGraph.ContourPop_BasicToolClick(Sender: TObject);
begin
     CreateRockPressTool(Application.Handle,'云图显示属性设置界面',
                         Form_ContourGraph.Width ,Form_ContourGraph.Height,1);
end;

procedure TForm_ContourGraph.ContourPop_ChangUnitClick(Sender: TObject);
begin
  if DrawGzm.ColorValue.UnitType=1 then  begin
     DrawGzm.ColorValue.UnitType:=2;
     DrawGzm.ColorValue.UnitValue:=10;
  end else if DrawGzm.ColorValue.UnitType=2 then   begin
     DrawGzm.ColorValue.UnitType:=1;
     DrawGzm.ColorValue.UnitValue:=1;
  end;
     ChangePressDataUnit(DrawGzm.ColorValue.UnitType);
end;

procedure TForm_ContourGraph.ContourPop_DeleteClick(Sender: TObject);
begin
   DrawGzm.Auto_Judge_OldStep.ExSteps[DrawGzm.EditMapPoint.StepClassid].Used :=2;
   RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TForm_ContourGraph.ContourPop_Disp_ForCaseClick(Sender: TObject);
begin
    SetDispForCase(not DrawGzm.CloudClass.DisPlayForcase);
end;

procedure TForm_ContourGraph.ContourPop_Disp_ResultClick(Sender: TObject);
begin
    But_DispResult.Click ;
end;

procedure TForm_ContourGraph.contourPop_Disp_StepClick(Sender: TObject);
begin
   SetOldStepVisible(not DrawGzm.CloudClass.OldStepDisplay);

end;

procedure TForm_ContourGraph.ContourPop_Disp_TongjiClick(Sender: TObject);
begin
   But_Tongji.Click;
end;

procedure TForm_ContourGraph.ContourPop_DrawLineGraphClick(Sender: TObject);
begin
   SelectReganleToDrawLinGraph(true);
end;

procedure TForm_ContourGraph.ContourPop_EDClick(Sender: TObject);
begin
   ContourChart.ScrollMouseButton:=mbMiddle;
       //更改编辑状态
   DrawGzm.EditMapPoint:=EditMapSeriesSteps(DrawGzm.EditMapPoint.Apol,-1);
   ContourChart.ScrollMouseButton:=mbLeft;
end;

procedure TForm_ContourGraph.ContourPop_ED_DelClick(Sender: TObject);
begin
   DrawGzm.Auto_Judge_OldStep.ExSteps[DrawGzm.EditMapPoint.StepClassid].Used :=2;
   RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TForm_ContourGraph.ContourPop_ED_EditClick(Sender: TObject);
begin
   ContourChart.ScrollMouseButton:=mbMiddle;
       //更改编辑状态
   DrawGzm.EditMapPoint:=EditMapSeriesSteps(DrawGzm.EditMapPoint.Apol,-1);
   ContourChart.ScrollMouseButton:=mbLeft;
end;

procedure TForm_ContourGraph.ContourPop_ED_ReCallClick(Sender: TObject);
begin
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TForm_ContourGraph.ContourPop_ED_SaveClick(Sender: TObject);
begin
     ReModiFyStepOldClass(DrawGzm.Auto_Judge_OldStep,DrawGzm.EditMapPoint);
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TForm_ContourGraph.contourPop_KYFXClick(Sender: TObject);
begin
    But_Start_Kyfx.Click ;
end;

procedure TForm_ContourGraph.CopyDataToStringGridFromPaste(StrGrid: TstringGrid; Col,
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

function TForm_ContourGraph.CreateSaveBmpPath: String;
var
 BmpPath:WideString;
begin
    BmpPath:=Public_Basic.Get_MyModulePath+'SaveBmp\KYFX\' +Trim(IntTostr(DrawGzm.FGzm.Gzmbh)) + '\'  ;
    if  not DirectoryExists(BmpPath) then
         ForceDirectories(BmpPath);

    Result:=BmpPath;
end;



procedure TForm_ContourGraph.DispContourPopMemu(Px, Py: Integer);
begin

   ContourPop_refreshchart.Enabled :=false;
   ContourPop_Save_Bmp.Enabled :=false;
   ContourPop_ChangUnit.Enabled :=false;
   ContourPop_ED.Enabled :=False;
   ContourPop_Kyfx.Enabled :=false;

    if DrawGzm.MapSeriesEditState >0 then  begin
       ContourPop_Kyfx.Enabled :=true;       // 矿压深层分析
       ContourPop_refreshchart.Enabled :=true;// 刷新页面
       ContourPop_ChangUnit.Enabled :=true;  //  改变单位
       ContourPop_Save_Bmp.Enabled :=true; //  保存图片
    end;
    if DrawGzm.MapSeriesEditState=2 then  begin
       ContourPop_ED.Enabled :=true;
    end;


    if not GetRockPressAnslysis then begin  //系统 进行了矿压分析
       contourPop_KYFX_Result.Enabled :=False;
    end;


    CurrentChart:='TwoDimChart';
    ContourPop_Main.Popup(px,py);



end;




procedure TForm_ContourGraph.DispLabelMarkToMemo(Value: Boolean; Px, Py,
  Stepid: integer);
begin
  if  not Value then Mark_Memo.Visible :=False;

    if Value  then  begin
       if Py+Mark_Memo.Height+100 > Height  then Mark_Memo.Top :=Height-Mark_Memo.Height -100
         else   Mark_Memo.Top :=py;
       if Px+Mark_Memo.Width +50 > Width   then Mark_Memo.Left :=Width-Mark_Memo.width  -50
         else  Mark_Memo.Left :=Px;
       Mark_Memo.Enabled :=False;
       Mark_Memo.Lines.Text :=DrawGzm.Auto_Judge_OldStep.ExSteps[Stepid].ReturnMarkLabel ;
       Mark_Memo.Visible :=True;
    end;
end;

procedure TForm_ContourGraph.DisplyMapSeries(series:TMapSeries;
    OldStep:TOldSteps;TranVis:Boolean;Color:TColor;LineWide:integer);
    {
      series 云图名称
      OldStep 步距类名
      TranVis 填充是否透明
      Color 填充颜色 如果是透明  线条颜色
      LineWide 线条宽度
    }
var
  i,j:integer;
  APol    : TTeePolygon;
  PointIndex:integer;
begin
    series.Clear ;
        for I := 0 to high(OldStep.ExSteps ) do  begin
            if (OldStep.ExSteps[i].GetMinDao >= DrawGzm.CloudClass.SaveDataMinDao  ) and
                  (OldStep.ExSteps[i].GetMaxDao <= DrawGzm.CloudClass.SaveDataMaxDao )  then
                  {如果该区间在数据库保存的数据空间内  ；判定区域是否进行重新计算   }
                 if not DrawGzm.CloudClass.RecallMidDaoSaveStep  then  begin    // 如果不重新计算
                    // 把自动计算的云图 屏蔽掉  ModifyData=1为 正常压力 ModifyData=5 为 局部压力不可能构成整体来压
                    if (OldStep.ExSteps[i].Used=1) and
                       ((OldStep.ExSteps[i].ModifyData=1)  or (OldStep.ExSteps[i].ModifyData=5) ) then  // 表示 自动云图计算的
                       OldStep.ExSteps[i].Used:=2;
                    if DrawGzm.CloudClass.SaveDate_Edit then   // 如果可以编辑
                       if (OldStep.ExSteps[i].Used=1) and (OldStep.ExSteps[i].ModifyData=4)  then  // 表示 数据库提取的数据
                           OldStep.ExSteps[i].ModifyData:=7;
                 end else  begin
                    // 把数据库保存范围内的云图屏蔽掉   ModifyData=4 表示 数据库中提取的数据
                    if (OldStep.ExSteps[i].Used=1) and (OldStep.ExSteps[i].ModifyData=4)  then  // 表示 数据库提取的数据
                       OldStep.ExSteps[i].Used:=2;
                 end;


            if  OldStep.ExSteps[i].Used <> 1 then   continue;   // 不是正常显示的返回

            APol:=series.Shapes.Add ;
            OldStep.ExSteps[i].MapSeriesIndex :=APol.Index ;
            APol.Points.Clear ;

            //
             if  (OldStep.ExSteps[i].GetMinDao >= DrawGzm.DataTimeAndFootAge.Graph_MinDao ) and
                         (OldStep.ExSteps[i].GetMaxDao <= DrawGzm.DataTimeAndFootAge.Graph_MaxDao ) then  begin
                 { 如果该区域在 正常的 进刀区域内  }
                  if OldStep.ExSteps[i].ModifyData =3  then  begin  // 显示预测数据
                      if DrawGzm.CloudClass.DisPlayForcase then   //如果同意显示预测数据
                         if  OldStep.ExSteps[i].ForcaseId=1 then   begin  //剧烈运动 预测数据
                            SetPolygenProperty(OldStep.ExSteps[i],true,APol,true,ClRed,LineWide,1);
                         end else if OldStep.ExSteps[i].ForcaseId= 2 then begin
                            SetPolygenProperty(OldStep.ExSteps[i],true,APol,true,ClYellow,LineWide,1);
                         end;
                  end else if OldStep.ExSteps[i].ModifyData =1  then begin  // 表示正常数据
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,Color,LineWide,0);
                  end else if OldStep.ExSteps[i].ModifyData =4  then begin  // 代表从数据库中提取的数据
                      {从数据库提取的数据变成灰色 代表 不可编辑}
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,clGray,LineWide,1);
                  end else if OldStep.ExSteps[i].ModifyData =5  then begin  // 表示局部压力急剧
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,ClRed,LineWide,0);
                  end else if OldStep.ExSteps[i].ModifyData =7  then begin  // 表示数据库提取 改变为可以编辑的状态
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,Color,LineWide,1);
                  end else if OldStep.ExSteps[i].ModifyData =8  then begin  // 表示判断直接顶或者 老顶来小压步距
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,ClYellow,LineWide,1);
                  end else if OldStep.ExSteps[i].ModifyData =9  then begin  // 表示判断老顶下位岩梁来压
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,ClBlue,LineWide,1);
                  end else if OldStep.ExSteps[i].ModifyData =10  then begin  // 表示判断老顶上位位岩梁来压
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,clFuchsia,LineWide,1);
                  end;

             end else begin
                {  如果不在这个区域内 判断是显示什么东西   }
                 if DrawGzm.CloudClass.DisPlayProMinDaoSaveStep then  begin // 不在区域是否显示是否 显示  //
                      if (OldStep.ExSteps[i].ModifyData =4) then
                      {
                        如果数据库中存在数据，可以显示
                      }
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,clGray,LineWide,1);
                 end;

                  if OldStep.ExSteps[i].ModifyData =3  then  begin  // 显示预测数据
                     if DrawGzm.CloudClass.DisPlayForcase then   //如果同意显示预测数据
                         if  OldStep.ExSteps[i].ForcaseId=1 then   begin  //剧烈运动 预测数据
                            SetPolygenProperty(OldStep.ExSteps[i],true,APol,False,ClRed,LineWide,1);
                         end else if OldStep.ExSteps[i].ForcaseId= 2 then begin
                            SetPolygenProperty(OldStep.ExSteps[i],true,APol,False,ClYellow,LineWide,1);
                         end;
                  end;


             end;


      end;
   series.RefreshSeries;
end;






procedure TForm_ContourGraph.DispPopEditArea(Px, Py: Integer);
begin

      Pop_EditArea.Popup(px,py);

end;

procedure TForm_ContourGraph.DispSelectEd(Px, py:Integer);
begin
    //Pop_Select_DrawGraph.Enabled :=False;
    //Pop_Select_Bar.Enabled :=false;
   // Pop_Select_StepInfo.Enabled:=False;
   // Pop_Select_FyyD.Enabled:=False;
    Pop_Selected.Popup(px,py);
end;

procedure TForm_ContourGraph.DispTreePop(Px, Py: Integer);
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

procedure TForm_ContourGraph.DragPointEndDrag(Sender: TDragPointTool;
  Index: Integer);
begin
   if (Index>=0) and (index<=7 )  then   begin
      DrawGzm.EditMapPoint.tmpPoints[index].x :=Round(LineSeries.XValues[index]);
      DrawGzm.EditMapPoint.tmpPoints[index].Y :=Round(LineSeries.YValues[index]);
   end;
    //恢复到放大状态
  //  SetContourSeriseZoomUsed(true);
end;

procedure TForm_ContourGraph.DragPointStartDrag(Sender: TDragPointTool;
  Index: Integer; var Start: Boolean);
begin
    // SetContourSeriseZoomUsed(False);
     DrawGzm.EditMapPoint.Pointid :=Index;
end;

procedure TForm_ContourGraph.But_Single_DispClick(Sender: TObject);
begin
   SetContourSeriesDisply(not DrawGzm.ColorValue.ColorDisply);

end;

procedure TForm_ContourGraph.But_Start_KYFXClick(Sender: TObject);
var
 Auto:Boolean;
begin
    DrawGzm.CloudClass. RockPressAnslysis:=true;
    if DrawGzm.Fgzm.RockPressAnalysis.AnalysisSenstive=3 then
       Auto:=true else Auto:=False;
    if StartRockPressAnslysisBegin(Auto) then begin
        // 分区计算来压步距情况
        DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
        DrawGzm.CaluateStepToPrint ;
         // 控制按钮
        But_Kyfx_FillMap.Enabled:=True;
        contourPop_KYFX_Result.Enabled :=true;
    end else begin
        DrawGzm.CloudClass.RockPressAnslysis:=False;
        SetOldStepVisible(FALSE);// 不显示来压步距
    end;

    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
    RefreshContourlegendPalette;

     //保存图片前 要把图形刷新了
      ChartRefresh;
      ContourChartSaveIntoBMP ('',1);
    //三个按钮的图标状态
     SetBut_KYFX_Enabled(true);
end;

procedure TForm_ContourGraph.But_SupMoveClick(Sender: TObject);
begin
    CreateSupportMove(ExHandle,'',0,0,0);
    UForm_MoveSupport.WindowState:=wsMaximized;
    UForm_MoveSupport.InitForm(DrawGzm) ;
    UForm_MoveSupport.LoadsupportMoveData;
    UForm_MoveSupport.RefreshChartGraph;
end;

procedure TForm_ContourGraph.But_TongjiClick(Sender: TObject);
begin
    CreateTongJiXueGraph(ExHandle,'',0,0,0);
    Form_TongJIGraph.WindowState:=wsMaximized;
    Form_TongJIGraph.InitForm(DrawGzm) ;
    Form_TongJIGraph.RefreshChartGraph;
end;

function TForm_ContourGraph.EditMapSeriesSteps(ApolId,
  StepClassId: integer): TEditMapSeriesRe;
var
  tmp:TEditMapSeriesRe;
  i:integer;
  Edited:Boolean;
begin
    if StepClassId <0 then   begin
       StepClassId:=DrawGzm.Auto_Judge_OldStep.ReturnStepid(ApolId,Edited) ;
    end;
    if StepClassId <0 then   exit;
    if not Edited then   begin
        DrawGzm.MapSeriesEditState:=2;
        tmp.Apol :=Apolid;
        tmp.StepClassid:=StepClassid;
        Result:=tmp;
        exit;
    end;

    DrawGzm.MapSeriesEditState:=2;
    tmp.Apol :=Apolid;
    tmp.StepClassid:=StepClassid;
    Result:=tmp;
    // 处理与云图
    LineSeries.Clear ;

    for I := 0 to 7 do  begin
      LineSeries.AddXY(DrawGzm.Auto_Judge_OldStep.ExSteps[StepClassid].MyOutLinePoint[i].Point.x,
                        DrawGzm.Auto_Judge_OldStep.ExSteps[StepClassid].MyOutLinePoint[i].Point.y
                        );
      //把数组清空
      tmp.tmpPoints[i].X:=DrawGzm.Auto_Judge_OldStep.ExSteps[StepClassid].MyOutLinePoint[i].Point.x;
      tmp.tmpPoints[i].Y:=DrawGzm.Auto_Judge_OldStep.ExSteps[StepClassid].MyOutLinePoint[i].Point.Y;
    end;
     LineSeries.AddXY(DrawGzm.Auto_Judge_OldStep.ExSteps[StepClassid].MyOutLinePoint[0].Point.x,
                        DrawGzm.Auto_Judge_OldStep.ExSteps[StepClassid].MyOutLinePoint[0].Point.y
                        );

    LineSeries.XValues.Order:=loNone;
    LineSeries.Pen.Width :=DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide;
    LineSeries.Pen.Color :=ClBlue;
    LineSeries.OutLine.Visible :=true;
    LineSeries.Pointer.Size:=LineSeries.Pen.Width+4;
    MapSeries.Selected.Hover.Visible :=false;
    ContSeries.Selected.Hover.Visible :=False;
    // 把鼠标放大键更改为放大模式
    SetContourSeriseZoomUsed(true);
    Result:=tmp;
end;

procedure TForm_ContourGraph.ExitButtonClick(Sender: TObject);
begin
    Close;
end;

procedure TForm_ContourGraph.ExtractDataFormSeries(TreeView: TTreeView; ParantNode:TTreeNode;
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

begin


//   DrawGzm.Auto_Judge_OldStep.SetJudgeBasicParameters(DrawGzm.FGzm.RockPressAnalysis.Continue_SupNumber,
//                    DrawGzm.FGzm.RockPressAnalysis.conTinue_Footage/DrawGzm.FGzm.RockPressAnalysis.OneDao_step,
//                    DrawGzm.FGzm.RockPressAnalysis.AnalysisSenstive
//                    ) ;

   DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,true,100,100);

   if DataType=-1 then   begin // 代表 是为未保存的信息

        New(RecData);
        RecData^.BName:='-1';
        RecData^.DName:='ROOT';
        RecData^.XHeight:='-1';
        xChilld11:=TreeView.Items.AddChildObject(ParantNode,'有效的区域信息',RecData);
        xChilld11.ImageIndex:=0;
        //节点被选中展开


        New(RecData);
        RecData^.BName:='-1';
        RecData^.DName:='ROOT';
        RecData^.XHeight:='-1';
        xChilld12:=TreeView.Items.AddChildObject(ParantNode,'被删除的区域信息',RecData);
        xChilld12.ImageIndex:=0;



        New(RecData);
        RecData^.BName:='-1';
        RecData^.DName:='ROOT';
        RecData^.XHeight:='-1';
        xChilld13:=TreeView.Items.AddChildObject(ParantNode,'来压步距预测信息',RecData);
        xChilld13.ImageIndex:=0;
           for I := 0 to length(DrawGzm.Auto_Judge_OldStep.ExSteps)-1 do   begin
                 if  DrawGzm.Auto_Judge_OldStep.ExSteps[i].Used =0 then continue;

                 if DrawGzm.Auto_Judge_OldStep.ExSteps[i].ModifyData =1  then  begin // 未保存的值
                      if  DrawGzm.Auto_Judge_OldStep.ExSteps[i].Used =1 then   begin  // 有效的数据
                            New(RecData);
                            RecData^.BName:='1';
                            RecData^.DName:=IntToStr(i);
                            RecData^.XHeight:=intTostr(DrawGzm.Auto_Judge_OldStep.ExSteps[i].MapSeriesIndex);
                            xChild3:=TreeView.Items.AddChildObject(xChilld11,DrawGzm.Auto_Judge_OldStep.ExSteps[i].GetDispTitle ,  RecData);
                            xChild3.ImageIndex:=2;
                      end else if  DrawGzm.Auto_Judge_OldStep.ExSteps[i].Used =2 then begin  //被删除的数据
                            New(RecData);
                            RecData^.BName:='2';
                            RecData^.DName:=IntToStr(i);
                            RecData^.XHeight:='0';
                            xChild3:=TreeView.Items.AddChildObject(xChilld12,DrawGzm.Auto_Judge_OldStep.ExSteps[i].GetDispTitle ,  RecData);
                            xChild3.ImageIndex:=6;
                      end;
                 end else if DrawGzm.Auto_Judge_OldStep.ExSteps[i].ModifyData =3  then  begin // 预测值
                       New(RecData);
                        RecData^.BName:='2';
                        RecData^.DName:=IntToStr(i);
                        RecData^.XHeight:='0';
                        xChild3:=TreeView.Items.AddChildObject(xChilld13,DrawGzm.Auto_Judge_OldStep.ExSteps[i].GetDispTitle ,  RecData);
                        xChild3.ImageIndex:=5;
                 end;

           end;

         // xChilld11.Expand(true);
   end else if  DataType= 1 then   begin // 代表 是为已经保存的信息

        New(RecData);
        RecData^.BName:='-1';
        RecData^.DName:='ROOT';
        RecData^.XHeight:='-1';
        xChilld12:=TreeView.Items.AddChildObject(ParantNode,'来压步距数据',RecData);
        xChilld12.ImageIndex:=0;

         for I := 0 to length(DrawGzm.Auto_Judge_OldStep.ExSteps)-1 do   begin
             if  DrawGzm.Auto_Judge_OldStep.ExSteps[i].Used <>1 then continue;

             if (DrawGzm.Auto_Judge_OldStep.ExSteps[i].Used =1) and  (DrawGzm.Auto_Judge_OldStep.ExSteps[i].ModifyData =4) then  begin
                // 代表从数据库中提取的 来压步距信息 也就是 数据库保存dataType = 4 的 数据
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

procedure TForm_ContourGraph.FillBasicJinDao(B_JinDao: TBasicJinDao;Support:integer);
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



procedure TForm_ContourGraph.Footsteps_LKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TForm_ContourGraph.FormActivate(Sender: TObject);
begin
    self.SetBut_KYFX_Enabled(DrawGzm.CloudClass. RockPressAnslysis );

end;

procedure TForm_ContourGraph.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
   pic_Path:string;
   pt1,pt2:TPoint;
begin
  try
       if (CloseScreenFlag=1) and (LoadRockPress) then  begin
          Visible :=False;
          CanClose:=False;
          Pic_Path  :=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\OneCoal'+'_12_1.BMP';
          Form_ContourGraph.ContourChart.SaveToBitmapFile(Pic_Path);

       end else begin
       {关闭窗体，还得需要发出Close命令}
          if CloseCheckRunThread then  begin
             if Application.MessageBox(pchar('excel及Word正在运行强制退出么？'), '提示', MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDYES then begin
                  CheckExcelThreadClosed;
                  CanClose:=true;
              end else begin
                  CanClose:=False;
                  exit;
              end;

          end;
          if Assigned(Form_ContourGraph) then  FreeAndNil(Form_ContourGraph);
       end;
  finally

  end;
end;

procedure TForm_ContourGraph.FormCreate(Sender: TObject);
var
  UN:PansiChar;
begin
    MySqlDataSet1:=TMyDataSet.Create(nil);
    MySqlDataSet1.MySqlConnection :=MainDataModule.ExConn;
    MySqlDataSet2:=TMyDataSet.Create(nil);
    MySqlDataSet2.MySqlConnection :=MainDataModule.ExConn;
    MyCommand1:=TMyCommand.Create (nil);
    MyCommand1.MySqlConnection :=MainDataModule.ExConn;
    DrawGzm:=TDrawGrap.Create(MainDataModule.ExConn);
   // DrawLineGraph:=TDrawLineGraph.Create ;
    //create
     MapSeries:=TMapSeries.Create(contourchart);
     MapSeries.ParentChart:= contourchart;
     MapSeries.OnClick:=MapSeriesClick;
     MapSeries.OnDblClick:=MapSeriesDoubleClick;


     MainDataModule.ReadPublicUsedMkInfoFromFile;
     s_MinName :=MainDataModule.Coal_Name;
     S_WorkFaceName :=MainDataModule.WorkFace_Name;

     SetRightToolVisible(false);
     //默认机尾显示 时间
     DrawGzm.ConTourSeriesPar.Display_UpperFootage:=0;
     DrawGzm.ConTourSeriesPar.Display_DownFootage:=1;
    // SetMinMaxJinDao(30,50);

     // 关闭十字光标线
     SetContourChartShiziVisible(False);


     //矿压深层分析的状态   默认没有进行深层分析
     SetOldStepVisible(false);
     //控制没有进行深层分析的按钮
     SetBut_KYFX_Enabled(False);
     //创建图片保存文件夹

    //
     BasicJinDao:=TBasicJinDao.Create ;
      //       {'LibCallPstope.dll' 的外部类}
       if not Assigned(CallPStope) then  begin
           CallPStope:=TCallPstope.Create ;
           CallPStope.SetStatuesCaption(PansiChar(Ansistring(
                            self.StatusBar1.Panels[2].text)));
           
       end;
        {'LibWinFrame.dll' 的外部类}
       if not Assigned(iUserWin) then begin
          iUserWin:=TuseWin.Create ;
          iUserWin.SetStatuesCaption(PansiChar(Ansistring(
                            self.StatusBar1.Panels[2].text)));
          iUserWin.RecallConnectDataBase ;
       end;

      KYGE_Report:=TWordReport.Create;  // 矿压观测 报告
      ForceClose:=False;
end;

procedure TForm_ContourGraph.FormDestroy(Sender: TObject);
begin
     FreeAndNil(MySqlDataSet1);
     FreeAndNil(MyCommand1);
     FreeAndNil(MySqlDataSet2);
     FreeAndNil(DrawGzm);
    // FreeAndNil(DrawLineGraph);
     FreeAndNil(KYGE_Report);

     FreeAndNil(MapSeries);
     FreeAndNil(BasicJinDao);


    if Assigned(iUserWin) then  FreeAndNil(iUserWin);
    if Assigned(CallPStope) then  FreeAndNil(CallPStope);
end;

procedure TForm_ContourGraph.FormResize(Sender: TObject);
begin
    if WindowState=wsMaximized  then  begin
       StatusBar1.Visible :=False;
    end else begin
       StatusBar1.Visible :=true;
    end;

end;

procedure TForm_ContourGraph.FormShow(Sender: TObject);
begin
   InitForm;
   if not LoadRockPress then  begin
       CreateRockPressTool(MainPanel.Handle,'云图显示属性设置界面',
                            Form_ContourGraph.Width ,Form_ContourGraph.Height,1);
   end;

end;

function TForm_ContourGraph.GetBatInputDataMaxGenTime(Support:integer): TDateTime;
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

function TForm_ContourGraph.GetChartFefresh: Boolean;
begin
   Result:=FChartRefreshFinlly;
end;

function TForm_ContourGraph.GetContOurChartBmpFileName(Value:integer): String;
{
  Value =0  代表取 整个 图形 最大进刀与 最小进刀的 文件名
         1  代表去 整个图形 当前 坐标 作为文件名

}
var
  MinLab,MaxLab:integer;
begin
  // ContourChart
   Result:='';
   if DrawGzm.FGzm.Gzmbh <1 then  exit;
   if (Value=1) or (VAlue=0) then  begin
       MinLab:=Round(DrawGzm.DataTimeAndFootAge.Graph_MinDao);
       MaxLab:=Round(DrawGzm.DataTimeAndFootAge.Graph_MaxDao);
       Result:='YT_'+Trim(IntTostr(MinLab))+ '_'+Trim(IntTostr(MaxLab)) ;
   end else begin
       MinLab:=Round(ContourChart.BottomAxis.Minimum);
       MaxLab:=Round(ContourChart.BottomAxis.Maximum);
       Result:='YB_'+Trim(IntTostr(MinLab))+ '_'+Trim(IntTostr(MaxLab)) ;
   end;


end;

function TForm_ContourGraph.GetLoadDate: Boolean;
begin
   Result:=loadRockPress;
end;



function TForm_ContourGraph.GetRockPressAnslysis: Boolean;
begin
    Result:=DrawGzm.CloudClass.RockPressAnslysis;
end;

function TForm_ContourGraph.GetScreenFlag: integer;
begin
    Result:=ShowScreen;
end;

function TForm_ContourGraph.GetSelectRectangleSupport(MinSup,
  MaxSup: integer): string;
begin

end;

procedure TForm_ContourGraph.InitDrawGzmClass;
var
  i:integer;
begin
     DrawGzm.CloudClass.YunTu_DataClass:=ManualInput;
    // 曲线数据
    DrawGzm.GraphClass.Out_input_Data :=False;
    DrawGzm.GraphClass.Graph_DataCalss:=single;
    DrawGzm.GraphClass.SupportList :='';
    DrawGzm.GraphClass.Support_Select_List:='';
    DrawGzm.GraphClass.ScrollPageSize :=2; //3天

    // 单一显示时 追加曲线
    for I := 0 to 2 do
         DrawGzm.GraphClass.Disp_DataType[i]:=true;

     DrawGzm.GraphClass.YAxisType:=4;  // 四个坐标轴
     // 曲线 的线型 表示
     DrawGzm.GraphClass.Line_Tpye:=1;// 多条曲线是否 用不同线型表示  0 统一线型 1 不同线型
     DrawGzm.GraphClass.Line_Color:=1; //多条曲线 是否 统一颜色显示  0 黑色  1 彩色 黑 蓝  黄  紫
     DrawGzm.GraphClass.Line_Width:=0;  // 线的宽度为1
    //
    DrawGzm.ConTourSeriesPar.Display_UpperFootage:=1;;
    DrawGzm.ConTourSeriesPar.Display_DownFootage:=0;
  //读取横坐标显示的设置方式

    DrawGzm.CloudClass.X_Axis_Disp_Type:=1;
    DrawGzm.CloudClass.X_Axis_Disp_Dao:=100;

  //读取是否显示预测数据信息
     DrawGzm.CloudClass.DisPlayForcase:=true;


    //读取是否显示最小进刀之前的来压步距
    DrawGzm.CloudClass.DisPlayProMinDaoSaveStep:=true;

     //读取是否进行重新分析  对于进刀之内的区域保存的数据
     DrawGzm.CloudClass.RecallMidDaoSaveStep:=False;

   //获取存储的数据是否可以编辑
     DrawGzm.CloudClass.SaveDate_Edit:=true;


     //获取进刀范围之外的来压信息是否输出
     DrawGzm.CloudClass.PrintOutDaoStepInto:=False;

       //获取矿压数据分段显示方式
     DrawGzm.CloudClass.PrintDispPhaseVisual:=False;
      // Tabpage 的显示 方式
     DrawGzm.GraphClass.FisrtPageId:=0;
     DrawGzm.GraphClass.SecondPageid:=0;
     // 云图是单色显示还是多色显示
     SetContourSeriesDisply(true);
     // 数据分析灵敏度
     DrawGzm.FGzm.RockPressAnalysis.AnalysisSenstive:=3;
     DrawGzm.FGzm.RockPressAnalysis.Min_Pt:=55;
     DrawGzm.FGzm.RockPressAnalysis.Continue_SupNumber:=6 ;
     DrawGzm.FGzm.RockPressAnalysis.conTinue_DaoNumber:=3;
     // bar
     DrawGzm.BarMarks.Disp_0 :=0;
     DrawGzm.BarMarks.Disp_B_D:=0;
     DrawGzm.BarMarks.Disp_Mark:=1;
     // 云图默认显示数据
     DrawGzm.CloudClass.Yuntu_CycleData :=Mzl_CData  ;
     // 控制打印报告的章节
     DrawGzm.GraphClass.Reportfirst :=true;
     DrawGzm.GraphClass.ReportSecond :=true;
end;

procedure TForm_ContourGraph.InitForm;
var
  i:integer;
begin
    MainPanel.Align :=alClient;
    Public_basic.InitStatusBar(StatusBar1);
    // 自动给 工作面赋值 并检查数据表创建情况
    AutoLoadcomboBox(s_MinName,S_WorkFaceName);
   
       // 初始化 图形相关参数
    LineSeries.XValues.Order:=loNone;
    LineSeries.Pen.Width :=DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide;
    LineSeries.Pen.Color :=ClBlue;
    LineSeries.OutLine.Visible :=true;
    LineSeries.Pointer.Size:=LineSeries.Pen.Width+4;
    // MapSeries.Selected.Hover.Visible :=false;
    ContSeries.Selected.Hover.Visible :=False;
    DrawGZm.MapSeriesEditState :=-1;  // 默认没有加载数据
    DrawGzm.CloudClass.OldStepDisplay :=False; //云图不显示来压步距
    //默认数据单位为Bar
    ChangePressDataUnit(2);
    loadRockPress:=False; // 是否加载矿压数据
    DrawGzm.CloudClass.RockPressAnslysis:=False;//矿压数据深层分析
    // 初始化DrawGzmClass
    InitDrawGzmClass;
    SetDispForCase(true);// 把显示预测步距云图设置为真
   // 初始化鼠标变量
    SetMouseInitValue;
    // 数据修改状态
    MapSeriesDataEdit:=False;
    //
    DispLabelMarkToMemo(False,0,0,0);
     //更换 计算步距的类
    DrawGzm.Auto_Judge_OldStep:=DrawGzm.ChangeJudgeStepClass(DrawGzm.CloudClass.Yuntu_CycleData);

    
end;


procedure TForm_ContourGraph.OnAccumulated(Sender: TReportWordThread);
begin
   OptionTip(1,'Excel导出完成');

   if ShowScreen=3 then  begin
      ShowScreen:=1;
      Close;
   end else if ShowScreen=2 then  begin
      ShowScreen:=1;
   end;

end;

procedure TForm_ContourGraph.OpenBndBar(inHandle: THandle; wid, hig: integer);
var
  SupST,SupEn:integer;
begin
    SupST:= DrawGzm.FGzm.SupStartNumber;
    SupEn:= DrawGzm.FGzm.SupEndNumber;

    CreateBand_Bar(inHandle,'',wid,hig,1);
    DrawGzm.BarMarks.Fromcontour:=true;;//代表从云图中传递数据
     if Assigned(Form_Band_Bar) then  begin
        Form_Band_Bar.InitForm(DrawGzm) ;
        Form_Band_Bar.SetOpenFormVar( ReturnSelectRectangleSupport(SupST,SupEn),
                                  true,
                                  true// 是否打开工具菜单
                                  );

     end;
end;

procedure TForm_ContourGraph.OpenLinGraph(inHandle: THandle;wid,hig:integer);
begin
      // 打开 绘制曲线图的界面
    CreateLineGraph(inHandle,'监控界面绘制曲线图',wid,hig,1);
    DrawGzm.GraphClass.CycleDataEfficient:=True;//代表从云图中传递数据
    Form_LineGraph.SetOpenFormVar(DrawGzm,
                                  '',
                                  true,
                                  true// 是否打开工具菜单
                                  );
end;

procedure TForm_ContourGraph.OpenReportWord(inHandle: THandle; wid,
  hig: integer);
var
 t_s:widestring;
 thd:TReportWordThread;
begin
    t_s:='打印报告是通过调用系统OFFICE来实现输出'+#13#10 +
         '启动OFFICE 会耗费一点的时间，你确认么?';
    if Application.MessageBox(Pwidechar(t_s),'特别提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

   OptionTip(1,'正在生成文件，耐心等待');
   ShowScreen:=2; // 系统正在进行导出
   // 此处为主线程时空。
   thd:=TReportWordThread.Create(true);
   thd.OnAccumulated:=self.OnAccumulated; // Self 指是 FrmMain.
   thd.iDrawGzm:=DrawGzm;
   thd.iCallPStope:=self.CallPStope ;
   thd.iKYGE_Report:=KYGE_Report;
   thd.EiHandle:=inHandle;
   thd.Start; //启动线程,在线程时空中执行 Execute 中的代码。


end;

procedure TForm_ContourGraph.OpenResultExcel(inHandle: THandle; wid,
  hig: integer);
begin
     CreateStepResult(inHandle,'矿压结果判定结果显示',wid,hig,1);
     if Assigned(Form_StepResult) then  begin
        Form_StepResult.InitForm(DrawGzm) ;
     end;
end;

procedure TForm_ContourGraph.OpenThreeResult(inHandle: THandle; wid,
  hig: integer);
begin
    CreateThreeGraph(inHandle,'',wid,hig,1);
    Form_ThreeGraph.InitForm(DrawGzm) ;
    Form_ThreeGraph.SmoothThreeDimPointValue(DrawGzm.DataTimeAndFootAge.Graph_MinDao,
                                             DrawGzm.DataTimeAndFootAge.Graph_MaxDao,
                                             1,DrawGzm.FGzm.SupEndNumber );
    Form_ThreeGraph.RefreshChartGraph;
end;

procedure TForm_ContourGraph.OpenTongJi(inHandle: THandle; wid, hig: integer);
begin
    CreateTongJiXueGraph(inHandle,'',wid,hig,1);
    Form_TongJIGraph.InitForm(DrawGzm) ;
    Form_TongJIGraph.RefreshChartGraph;
end;

procedure TForm_ContourGraph.Open_ToolFormClick(Sender: TObject);
begin
    ContourPop_BasicTool.Click ;
end;

procedure TForm_ContourGraph.OptionTip(index:integer;Str:String);
begin
   self.StatusBar1.Panels[index].Text :=str;
end;



procedure TForm_ContourGraph.Pop_CloseClick(Sender: TObject);
begin
    Close;
end;

procedure TForm_ContourGraph.Pop_Edit_DelClick(Sender: TObject);
begin
   DrawGzm.Auto_Judge_OldStep.ExSteps[DrawGzm.EditMapPoint.StepClassid].Used :=2;
   RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
   DraggingRectangle:=true;
end;

procedure TForm_ContourGraph.Pop_Edit_ReDoClick(Sender: TObject);
begin
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
    DraggingRectangle:=true;
end;

procedure TForm_ContourGraph.Pop_Edit_SaveClick(Sender: TObject);
begin
    ReModiFyStepOldClass(DrawGzm.Auto_Judge_OldStep,DrawGzm.EditMapPoint);
    MapSeriesDataEdit:=true;
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
    DraggingRectangle:=true;
end;

procedure TForm_ContourGraph.Pop_Select_BarClick(Sender: TObject);
var
   SupSt,SupEn:integer;
   DaoSt,DaoEn:integer;

begin
    SupST:=Round(ContSeries.YScreenToValue(Rect_Y1));
    SupEn:=Round(ContSeries.YScreenToValue(Rect_Y0));
    DaoSt:=Round(ContSeries.XScreenToValue(Rect_X0));
    DaoEn:=Round(ContSeries.XScreenToValue(Rect_X1)) ;
   // SelectReganleToDrawLinGraph(False);
    ContSeries.Repaint;
    // 打开 绘制曲线图的界面
    CreateBand_Bar(ExHandle,'',0,0,0);
    DrawGzm.BarMarks.Fromcontour:=true;;//代表从云图中传递数据
     if Assigned(Form_Band_Bar) then  begin
        Form_Band_Bar.InitForm(DrawGzm) ;
        Form_Band_Bar.SetOpenFormVar( ReturnSelectRectangleSupport(SupST,SupEn),
                                  true,
                                  true// 是否打开工具菜单
                                  );

     end;
end;

procedure TForm_ContourGraph.Pop_Select_DrawGraphClick(Sender: TObject);
begin
    ChangeRectangleToDrawSupportLineGraph(Rect_X0,Rect_Y0,Rect_X1,Rect_Y1);
end;

procedure TForm_ContourGraph.Pop_Select_FyyDClick(Sender: TObject);
begin
   CallPStope.OpenFyyd(ExHandle,
               '覆岩运动规律展示',Width,Height,1);
end;

procedure TForm_ContourGraph.Pop_Select_DTFZClick(Sender: TObject);
var
   SupSt,SupEn:integer;
   DaoSt,DaoEn:integer;
   JinChi:Double;
begin
    SupST:=Round(ContSeries.YScreenToValue(Rect_Y1));
    SupEn:=Round(ContSeries.YScreenToValue(Rect_Y0));
    DaoSt:=Round(ContSeries.XScreenToValue(Rect_X0));
    DaoEn:=Round(ContSeries.XScreenToValue(Rect_X1)) ;
    JinChi:=DrawGzm.DatetimeToFootage(
                           DrawGzm.FGzm.ReturnDataTimeFromDao(DaoEn),
                           'Down') ;

    CallPStope.OpenDTFZ(ExHandle,
               '采场上覆岩层运动模拟仿真',Width,Height,1);
    CallPStope.SetDTFZ_JinChi(Trunc(JinChi));
end;

procedure TForm_ContourGraph.LineGraphPop_toolClick(Sender: TObject);
begin
  CreateRockPressTool(Application.Handle,'云图显示属性设置界面',
             Form_ContourGraph.Width ,Form_ContourGraph.Height,1);
end;

procedure TForm_ContourGraph.LoadRockPressData(Flag: integer);
begin
   //读取手工录入数据
   DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,true,100,100);
   DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
   if DrawGzm.SelectDataBasic_DaoOrFootage  =0 then  begin //以进刀为主进行查询
      if not  DrawGzm.GetManualInputPressData(intToStr(DrawGzm.FGzm.Gzmbh),
                   DrawGzm.DataTimeAndFootAge.Graph_MinDao, DrawGzm.DataTimeAndFootAge.Graph_MaxDao,SecondPGBar) then
           exit;
   end else begin
      if not  DrawGzm.GetManualInputPressData(intToStr(DrawGzm.FGzm.Gzmbh),
                   DrawGzm.DataTimeAndFootAge.StartTime, DrawGzm.DataTimeAndFootAge.EndTime,SecondPGBar) then
           exit;
   end;
    // 把其他步距的平均值信息给加载了
    DrawGzm.SelectPressDataFromSupportMoveInfo(FirstPGBar,SecondPGBar,0);
    // 把数据的整体均值计算了
    DrawGzm.CalAGV_AGV_WholeData;
    // 更新云图
    DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,False,0,0);

    // 控制按钮
    ContourPop_loadData.Enabled:=False;
    DrawGzm.MapSeriesEditState:=1;

    // 记录数据是否加载
    LoadRockPress:=true;
     //不知道为什么，需要刷新两次
    RefreshMyCloudChart ;

end;

function TForm_ContourGraph.ZoomRect(mRect: TRect; mZoom: Integer): TRect;
begin
  Result.Left := mRect.Left - mZoom;
  Result.Right := mRect.Right + mZoom;
  Result.Top := mRect.Top;// - mZoom;
  Result.Bottom := mRect.Bottom- mZoom;
end;



procedure TForm_ContourGraph.RadioGroup_DownFootageClick(Sender: TObject);
begin
   ContourPop_refreshchart.Click ;
end;

procedure TForm_ContourGraph.RadioGroup_UpperFootageClick(Sender: TObject);
begin
  ContourPop_refreshchart.Click ;
end;

procedure TForm_ContourGraph.RecallLoadDataToDataBase(Value:Boolean);
begin
     ContourPop_loadData.Enabled :=Value;
     if not  Value then
        contourPop_KYFX.Enabled :=Value;
end;



procedure TForm_ContourGraph.RefreshContourlegendPalette;
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



procedure TForm_ContourGraph.RefreshMyCloudChart;
var
  t_s:string;
begin
   if not LoadRockPress then   exit; //如果没有加载数据 返回

   t_s:='来压区域进行了修改，但是没有保存到数据库！'+#13#10+'你确认把该次修改永久保存么？';
   if MapSeriesDataEdit then
     if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =1 then
        if DrawGzm.Auto_Judge_OldStep.isCalComeStep then  begin
             DrawGzm.SaveContourSeriesIntoDataBase(DrawGzm.Auto_Judge_OldStep,4 ) ;
             MapSeriesDataEdit:=False;
        end;

   // 把克里金图层设为假
   SetKrigcontour(False);
    // 更新云图
   DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,true,100,100);
   DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
   //更新数据单位的换算
   DrawGzm.Cal_MPaChangeKN_xs;
   //把克里金的云图填充了
   DrawGzm.RefreshChart_ConTourSeries(ContourChart,KrigContour,FirstPGBAr,SecondPGBar,1);
   // 填充云图信息   ContSeries
   DrawGzm.RefreshChart_ConTourSeries(ContourChart,ContSeries,FirstPGBAr,SecondPGBar,0);

   //更换 计算步距的类
   DrawGzm.Auto_Judge_OldStep:=DrawGzm.ChangeJudgeStepClass(DrawGzm.CloudClass.Yuntu_CycleData);

   if GetRockPressAnslysis then  begin
      //控制按钮
        SetBut_KYFX_Enabled(true);
       {AnalysisSenstive=3 系统自动判定参数}
      if DrawGzm.Fgzm.RockPressAnalysis.AnalysisSenstive=3 then   begin
          if StartRockPressAnslysisBegin(true) then begin
              // 分区计算来压步距情况
              DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
              DrawGzm.CaluateStepToPrint ;
               // 控制按钮
              But_Kyfx_FillMap.Enabled:=True;
          end else begin
              DrawGzm.CloudClass.RockPressAnslysis:=False;
              SetOldStepVisible(FALSE);// 不显示来压步距
          end;
      end else begin   {AnalysisSenstive  系统通过设定的参数进行求解}
          if StartRockPressAnslysisBegin(False) then begin
              // 分区计算来压步距情况
              DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
              DrawGzm.CaluateStepToPrint ;
               // 控制按钮
              But_Kyfx_FillMap.Enabled:=True;
          end else begin
              DrawGzm.CloudClass.RockPressAnslysis:=False;
              SetOldStepVisible(FALSE);// 不显示来压步距
          end;
      end;
   end else  begin
     SetBut_KYFX_Enabled(False);
   end;
     // 直接刷新 步距处理 图形
     RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
     RefreshContourlegendPalette;

     DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,False,0,0);

      //保存图片前 要把图形刷新了
      ChartRefresh;
      ContourChartSaveIntoBMP ('',1);
end;



procedure TForm_ContourGraph.RefreshOldStepAddToMapSeries(Visible: Boolean);
var
  Vis:Boolean;
  Series:TContourSeries;
begin
    if DrawGzm.FGzm.RockPressAnalysis.StepFillIsTran =0  then
              Vis:=true else Vis:=False;

    Series:=ContSeries;
      //把数据类进行刷新
    // DrawGzm.Auto_Judge_OldStep.Refresh;
     if Visible then  begin    // 步距云图是否显示
        // 判断的来压步距
        DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);
        DisplyMapSeries(MapSeries,DrawGzm.Auto_Judge_OldStep,
                     Vis,
                     DrawGzm.FGzm.RockPressAnalysis.StepFillColor,
                     DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide
                     );
     end else begin
        MapSeries.Clear ;

     end;

     // 控制云图显示方式
      if DrawGzm.ColorValue.ColorDisply then begin
         DrawGzm.ContourSeries1_Basic_GroupLevle(DrawGzm.ColorValue ,Series);
      end else begin
         if DrawGzm.FGzm.RockPressAnalysis.Min_Pt >54 then
            DrawGzm.FGzm.RockPressAnalysis.Min_Pt :=40;
         DrawGzm.ContourSeries1_Extract_GroupLevel(DrawGzm.FGzm.RockPressAnalysis.Min_Pt,
                                DrawGzm.ColorValue ,Series);
      end;

     // MainTreeView(TreeView1,'Series');
      // 把图形的编辑状态恢复到浏览状态
      DrawGzm.MapSeriesEditState:=1;
      LineSeries.Clear ;

end;



procedure TForm_ContourGraph.ReModiFyStepOldClass(OldStep: TOldSteps;
  EditMapRec: TEditMapSeriesRe);
var
  i:integer;
begin
   for I := 0 to 7 do
     OldStep.ExSteps[EditMapRec.StepClassid].SetMyOutLinePoint(
              i,
              EditMapRec.tmpPoints[i]
              );
    OldStep.ExSteps[EditMapRec.StepClassid].ModifyData :=1; // 修订保存后，回到原始状态
    OldStep.ExSteps[EditMapRec.StepClassid].Used :=1;
   //刷新一下数据
   OldStep.ExSteps[EditMapRec.StepClassid].Refresh ;
   Optiontip(1,'数据存储成功！');
end;

function TForm_ContourGraph.ReturnSelectRectangleSupport(MinSup,
  MaxSup: integer): string;
var
  St_sup,t,sup_cou,i:integer;
  s_Str:String;
begin
    Result:='';
    s_Str:='';
    if (MinSup=0) or (MaxSup=0) then   exit;
    //更换最大支架与最小支架的编号
    if MaxSup< MinSup then begin
       t:= MinSup;
       MinSup:=MaxSup ;
       MaxSup:= t;
    end;
    sup_cou:=2;
    s_Str:= IntToStr(MinSup) +',';

    t:=(MaxSup-MinSup ) div 10;
    if t< 1 then   t:=1;

    St_sup:= MinSup+t;
    while  St_sup < MaxSup do  begin
       s_Str:=s_Str+IntToStr(St_sup)+',';
       inc(sup_cou);
       St_sup:= St_sup+t;
       if sup_cou>=12 then   break;

    end;

    for  i:= sup_cou+1 to 12 do  begin
       inc(St_sup);
       s_Str:=s_Str+IntToStr(St_sup)+',';

    end;

    s_Str:=s_Str+IntToStr(MaxSup);
    Result:=s_Str;
end;

procedure TForm_ContourGraph.RG_Yun_CycleClick(Sender: TObject);
begin
    ContourPop_refreshchart.Click ;
end;


procedure TForm_ContourGraph.RightPageControlMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
      AutoRightPanelOpen:=False;
end;

procedure TForm_ContourGraph.RightPageControlMouseLeave(Sender: TObject);
begin
    if AutoRightPanelOpen then begin
        setRightToolVisible(False);
        AutoRightPanelOpen:=False;
    end;
end;

procedure TForm_ContourGraph.RightVisiblePanelClick(Sender: TObject);
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

procedure TForm_ContourGraph.RightVisiblePanelMouseEnter(Sender: TObject);
begin
     if  not RightPageControl.Visible  then  begin
         setRightToolVisible(true);
         AutoRightPanelOpen:=true;
     end;
end;

procedure TForm_ContourGraph.RockPressDataAnalysis(Series: TContourSeries);
{
  矿压数据分析模块
  主要分析思路 从 Series 云图中提取数据
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

procedure TForm_ContourGraph.SaveButtonClick(Sender: TObject);
begin
   ContourPop_refreshchart.Click ;
end;



procedure TForm_ContourGraph.SelectReganleToDrawLinGraph(Value:Boolean);
begin
   if Value then   begin
       SetChartRightPanning(False);
       // 禁止放大功能
       ContourChart.Zoom.Allow :=FALSE;
       ContourPop_LeftZoom.Caption :='启用左键放大功能';

       ClearRectangle ;
       DraggingRectangle:=true;
   end else begin
       DraggingRectangle:=False;
       SetChartRightPanning(true);
   end;


   

end;

function TForm_ContourGraph.SelectRockPressDataNumber(DataType:integer):Boolean;
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

procedure TForm_ContourGraph.SetBut_KYFX_Enabled(Value: Boolean);
begin
     But_DispResult.Enabled :=Value;
     But_DisplayStep.Enabled :=Value;
     But_Disp_ForCase.Enabled :=Value;
     But_KY_Report.Enabled:=Value;
     But_Kyfx_Report.Enabled:=Value;
     But_Tongji.Enabled :=Value;
     TreePop_Report.Enabled :=Value;
     But_ThreeDim.Enabled:=Value;
     if Value then
        CoolBar1.Bands[0].Width:=  CoolBar1.Bands[0].Width-round(CoolBar1.Bands[0].Width/3);
     CoolBar1.Bands[1].Visible :=Value; //矿压分析
end;

procedure TForm_ContourGraph.setChartRefresh(Value: Boolean);
begin
    FChartRefreshFinlly:=Value;
end;

procedure TForm_ContourGraph.SetContourSeriesDisply(Value: Boolean);
begin
    if Value then  begin
        DrawGzm.ColorValue.ColorDisply :=true;
        ContourPop_Single_Disp.Caption :='云图单色显示';
        But_Single_Disp.Caption:='单色显示';
        But_Single_Disp.ImageIndex :=58;
        ContourPop_Single_Disp.ImageIndex:=58;
    end else begin
         DrawGzm.ColorValue.ColorDisply :=False;
        ContourPop_Single_Disp.Caption :='云图多色显示';
        But_Single_Disp.Caption:='多色显示';
        But_Single_Disp.ImageIndex :=30;
        ContourPop_Single_Disp.ImageIndex:=30;
    end;
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TForm_ContourGraph.SetContourSeriseZoomUsed(Value: Boolean);
begin

    if Value then  begin
        ContourChart.Zoom.Allow :=true;
        ContourChart.Zoom.MouseButton := mbLeft;
        ContourPop_LeftZoom.Caption :='禁用左键放大功能';
        But_LeftZoom.Caption :='禁用放大';
        //
        DraggingRectangle:=False;
        But_Selected.Caption :='启用选择';
        ContourPop_Selected.Caption:='启用鼠标选中功能';
    end else begin
        ContourChart.Zoom.Allow :=FALSE;
        ContourPop_LeftZoom.Caption :='启用左键放大功能';
        But_LeftZoom.Caption :='左键放大';
        ContourChart.UndoZoom ;
        //
        DraggingRectangle:=true;
        But_Selected.Caption :='禁用选择';
        ContourPop_Selected.Caption:='禁用鼠标选中功能';
    end;

end;


procedure TForm_ContourGraph.SetDispForCase(Value: Boolean);
begin
   if Value then  begin    // 显示预测步距
      DrawGzm.CloudClass.DisPlayForcase:=True;
      ContourPop_Disp_ForCase.Caption:='隐藏预测步距云图';
      But_Disp_ForCase.Caption :='隐藏预测';
   end else begin //不显示预测步距
      DrawGzm.CloudClass.DisPlayForcase:=False;
      ContourPop_Disp_ForCase.Caption:='显示预测步距云图';
      But_Disp_ForCase.Caption :='显示预测';
   end;

   RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TForm_ContourGraph.SetForceClose(Value: Boolean);
begin

end;

procedure TForm_ContourGraph.SetFromWidthAndHeigth(flag: integer);
begin
   if Flag=1  then  begin
       WindowState:= wsNormal;
       ShowScreen:=1;
       Show;
   end else begin
       ShowScreen:=0;
       WindowState:= wsMaximized;
       Show;
   end;
end;

procedure TForm_ContourGraph.SetKrigcontour(Value: Boolean);
begin
     KrigContour.Visible:=Value;
     ContSeries.Visible:=not Value;

end;

procedure TForm_ContourGraph.SetChartRightPanning(Value: Boolean);
begin
   if Value then  begin
      LeftMousePanning:=True;
      ContourChart.Zoom.Allow :=FALSE;
      ContourChart.ScrollMouseButton:=mbleft;
      ContourChart.AllowPanning := pmHorizontal ;
      ContourPop_LeftMouse_panning.Caption :='禁用左键平移图片' ;
      But_Left_Panning.Caption :='禁用平移';
      DraggingRectangle:=False;
      But_Selected.Caption :='启用选择';
      ContourPop_Selected.Caption:='启用鼠标选中功能';

   end else begin
      LeftMousePanning:=False;
      ContourChart.Panning.Active :=False;
      ContourChart.AllowPanning := pmNone;
      ContourPop_LeftMouse_panning.Caption :='启用左键平移图片' ;
      But_Left_Panning.Caption :='左键平移';
      //
      DraggingRectangle:=true;
      But_Selected.Caption :='禁用选择';
      ContourPop_Selected.Caption:='禁用鼠标选中功能';

   end;
end;

procedure TForm_ContourGraph.SetCharWheelZoom(Value: Boolean);
begin
    if Value then  begin   // 启用
       MuddleWheelForZoom:=True;
       ContourPop_WheelZoom.Caption :='禁用滚轮推拉图形';
       But_WheelZoom.Caption :='禁用滚轮';
    end else begin    // 禁止
       MuddleWheelForZoom:=False;
       ContourPop_WheelZoom.Caption :='启用滚轮推拉图形';
       But_WheelZoom.Caption :='启用滚轮';
       ContourChart.UndoZoom ;
    end;
end;

function TForm_ContourGraph.setContourChartMin_MaxToBmp(Min_X,
  Max_X: double): String;
begin
   ContourChart.BottomAxis.Automatic :=FAlse;
   ContourChart.BottomAxis.Minimum :=0;
   ContourChart.BottomAxis.Maximum :=Max_x;
   if Min_X< Max_x then   begin
      ContourChart.BottomAxis.Minimum :=Min_X;
   end;
   ContourChart.Refresh ;
  // 保存为文件
   ContourChartSaveIntoBMP('',2);
end;

procedure TForm_ContourGraph.SetContourChartShiziVisible(Value: Boolean);
begin
    if Value then    begin
        ContourPop_Shizhi.Caption :='关闭十字光标线';
        ContourChart_Cursor.Visible :=true;
        But_Cursor.Caption:='关闭光标';
    end else  begin
        ContourPop_Shizhi.Caption :='打开十字光标线';
        ContourChart_Cursor.Visible :=FALSE;
        But_Cursor.Caption:='十字光标';
    end;
end;



procedure TForm_ContourGraph.SetLoadDate(Value: Boolean);
begin
    loadRockPress:=Value;
end;

procedure TForm_ContourGraph.SetMapSeriesSelected(Value: Boolean);
begin
    if Value then begin    //启用
       SelectReganleToDrawLinGraph(true);
       But_Selected.Caption :='禁用选中';
       ContourPop_Selected.Caption:='禁用鼠标选中区域';
    end else begin // 禁用
       SelectReganleToDrawLinGraph(FALSE);
       But_Selected.Caption :='启用选择';
       ContourPop_Selected.Caption:='启用鼠标选中功能';
    end;


end;



procedure TForm_ContourGraph.SetMiddleWheelForZoom(Value: Boolean);
begin

end;

procedure TForm_ContourGraph.SetMinMaxJinDao(MinD, MaxD: integer);
begin
    DrawGzm.DataTimeAndFootAge.Graph_MinDao:=MinD;
    DrawGzm.DataTimeAndFootAge.Graph_MaxDao:=MaxD;
end;

procedure TForm_ContourGraph.SetMouseInitValue;
begin
    AutoRightPanelOpen:=False;
    SetCharWheelZoom(true); //允许 滚轮使用放大缩小功能
    SetChartRightPanning(false);//允许使用左键平移
    DraggingRectangle:=FALSE; // 禁止使用 圈定区域功能
    ClearRectangle;// 清空Rectangle 的初始状态
      //控制鼠标状态
    SetMapSeriesSelected(true);
end;

procedure TForm_ContourGraph.SetOldStepVisible(Value: Boolean);
begin
     {contourPop_Disp_Step}
    if Value then    begin
        contourPop_Disp_Step.Caption :='隐藏来压标志云图';
        DrawGzm.CloudClass.OldStepDisplay:=true;
        But_DisplayStep.Caption :='隐藏来压';
    end else  begin
        contourPop_Disp_Step.Caption :='添加来压标志云图';
        DrawGzm.CloudClass.OldStepDisplay:=False;
        But_DisplayStep.Caption :='显示来压';
    end;
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TForm_ContourGraph.SetPolygenProperty(OneStep:TOldOneStep;CeatePoint:Boolean;
     Apol:TTeePolygon;Tran:Boolean; MC:TColor;LineW,SaveOrFx:integer);
{
  SaveOrFx =0 是从云图里面分析出来的 步距  即  ModifyData=1  5  6
  SaveOrFx =1 是从数据库中调出来的步距   或者预测的数据   即  ModifyData=4  3

}
var
  i,PointIndex:integer;
begin
   Apol.Transparency:=DrawGzm.FGzm.RockPressAnalysis.SetpFillTran;
   Apol.Transparent:=Tran;
   Apol.Color :=Mc;
   Apol.Pen.Color :=MC;
   Apol.Pen.Width :=LineW;
   if CeatePoint then
       if SaveOrFx=0 then   begin
         for I := 0 to high(OneStep.Points) do  begin
            PointIndex:=APol.Points.AddXY(Round(OneStep.Points[i].x) ,Round(OneStep.Points[i].Y));
            OneStep.Points[i].PointId := PointIndex;
         end;
       end else begin
         for i := 0 to 7 do  begin
             PointIndex:=APol.Points.AddXY(OneStep.MyOutLinePoint[i].Point.x ,
                                           OneStep.MyOutLinePoint[i].Point.y);
             OneStep.MyOutLinePoint[i].PointId := PointIndex;
         end;
       end;




end;



procedure TForm_ContourGraph.SetRightToolVisible(Value: Boolean);
begin
   //ContourPop_RightTool
    if Value then    begin
        ContourPop_RightTool.Caption :='关闭右侧工具栏';
        RightPageControl.Visible :=true;

    end else  begin
        ContourPop_RightTool.Caption :='打开右侧工具栏';
        RightPageControl.Visible :=False;
    end;
end;




procedure TForm_ContourGraph.SetScreenFlag(value: integer);
begin
   ShowScreen:=Value;
end;

procedure TForm_ContourGraph.StartEditKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

function TForm_ContourGraph.StartRockPressAnslysisBegin(AutoOrManual:Boolean): Boolean;
var
 StepAreaRatio,tmpRatio:Double;
 LevelLineValue,Inv_Value:double;
 RaiseOrDrop:Boolean;
 RaiseCount:integer;
begin
    Result:=False;
    SetOldStepVisible(true);// 默认显示来压步距
    // 校订查询参数
    DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,true,100,100);
    if DrawGzm.GetMyCoutOurColorUpToValue (DrawGzm.MyContourColor_NumLevel,
                      DrawGzm.FGzm.RockPressAnalysis.Min_Pt ,
                      DrawGzm.FGzm.RockPressAnalysis.NearColorLineUp_DownValue
                      )=-1 then    Exit;
    //把系统参数送进 Auto_Judge_OldStep 类中
     DrawGzm.Auto_Judge_OldStep.SetMaxFootage(DrawGzm.DataTimeAndFootAge.MaxFootage);
     DrawGzm.Auto_Judge_OldStep.SetMax_Min_Jindao(DrawGzm.DataTimeAndFootAge.Graph_MinDao,
                                                  DrawGzm.DataTimeAndFootAge.Graph_MaxDao
                                                  );
     DrawGzm.Auto_Judge_OldStep.SetMax_Supportbh(DrawGzm.FGzm.SupEndNumber);

      {清理数据分析的类}
     DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);


     // 把区域最小值进行相关的圈定     //把边界数据保存了
     DrawGzm.SaveExtractDataFormSeries_SideData(ContourChart,ContSeries,
                 FirstPGBar,SecondPGBar,DrawGzm.FGzm.Usedsupport.initLoad);

     // 给区域线付初值
     if AutoOrManual then   begin
         LevelLineValue:= 55;
     end else  begin
         LevelLineValue:= DrawGzm.FGzm.RockPressAnalysis.Min_Pt;
     end;

     RaiseOrDrop:=False;//数据下行
     StepAreaRatio:=-1;  RaiseCount:=0;
     //从克里金云图中提取压力数据
     SetKrigcontour(true);
     Repeat
          DrawGzm.Auto_Judge_OldStep.ClearSteps ;
          if not DrawGzm.CloudClass.RecallMidDaoSaveStep  then  begin    // 如果不重新计算
               //从数据库中提取 基本云图数据
               {2018年 把 优化过的系统云图不保存}
               // 从数据中 提取 已经 计算好的的来压步距 数据
               DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);
               DrawGzm.ReadContoueSeriesToClass(DrawGzm.Auto_Judge_OldStep,4);
          end;
         // 提取数据进类
         DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);

         DrawGzm.ExtractDataFormSeries(ContourChart,KrigContour,FirstPGBar,SecondPGBar,LevelLineValue);
         // 把压力下限进行赋值
         DrawGzm.Auto_Judge_OldStep.SetJudgeLevelLineDat(LevelLineValue);
         // 数据类排序
         DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);
         DrawGzm.Auto_Judge_OldStep.Sort;
         // 数据类刷新    主要功能是实现区域的合并
         DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);
         DrawGzm.Auto_Judge_OldStep.Refresh;


         if AutoOrManual then  begin  // 如果是自动计算
             tmpRatio:=DrawGzm.Auto_Judge_OldStep.ReturnStepArea_Ratio;
             if StepAreaRatio <= tmpRatio+1 then begin
                StepAreaRatio:=tmpRatio;
             end else begin
                RaiseOrDrop:=true;
                StepAreaRatio:=tmpRatio;
             end;

             if (RaiseCount>2)  then begin
                 MapSeries.Visible :=False;
                 ContourChartSaveIntoBMP ('',0);
                 SetKrigcontour(False);
                 MapSeries.Visible :=true;
                 DrawGzm.FGzm.RockPressAnalysis.Min_Pt:= LevelLineValue;
                 DrawGzm.Auto_Judge_OldStep.UsedLevelLineValue:=LevelLineValue;
                 break;
             end else begin
                  if AutoAnslysis_LevelLine(StepAreaRatio,
                                        LevelLineValue,
                                        Inv_Value,
                                        RaiseOrDrop,RaiseCount) then  begin
                         MapSeries.Visible :=False;
                         ContourChartSaveIntoBMP ('',0);
                         SetKrigcontour(False);
                         MapSeries.Visible :=true;
                         DrawGzm.FGzm.RockPressAnalysis.Min_Pt:= LevelLineValue;
                         DrawGzm.Auto_Judge_OldStep.UsedLevelLineValue:=LevelLineValue;

                         break;
                    end;
             end;
         end else begin // 如果是收手动计算
             break;
         end;

     Until ( false ) ;

     // 把区域显示云图的分类在改回来
     if DrawGzm.ColorValue.ColorDisply then
        DrawGzm.ContourSeries1_Basic_GroupLevle(DrawGzm.ColorValue ,ContSeries);
     DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);
     DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,False,0,0);
     MainTreeView(TreeView1,'Series');
     DrawGzm.CloudClass.RockPressAnslysis:=true;
     Result:=True;
end;

procedure TForm_ContourGraph.But_Kyfx_SaveBmpClick(Sender: TObject);
begin
 // DrawGzm.SaveContourSeriesIntoDataBase(DrawGzm.Auto_Judge_OldStep,2 ) ;
  if DrawGzm.Auto_Judge_OldStep.isCalComeStep then
     DrawGzm.SaveContourSeriesIntoDataBase(DrawGzm.Auto_Judge_OldStep,4 ) ;
     MapSeriesDataEdit:=False;
   OptionTip(1,'数据保存成功!');
end;

procedure TForm_ContourGraph.But_Kyfx_StartClick(Sender: TObject);
begin
   But_Start_KYFX.Click ;
end;



procedure TForm_ContourGraph.But_KY_ReportClick(Sender: TObject);
begin
   But_Kyfx_Report.Click ;
end;

procedure TForm_ContourGraph.But_LeftZoomClick(Sender: TObject);
begin
   SetContourSeriseZoomUsed( not ContourChart.Zoom.Allow);
end;

procedure TForm_ContourGraph.But_Left_PanningClick(Sender: TObject);
begin
   SetChartRightPanning(not LeftMousePanning);
end;

procedure TForm_ContourGraph.But_LineGraphClick(Sender: TObject);
begin
     // 打开 绘制曲线图的界面
    CreateLineGraph(ExHandle,'',0,0,0);
    DrawGzm.GraphClass.CycleDataEfficient:=True;//代表从云图中传递数据
    Form_LineGraph.SetOpenFormVar(DrawGzm,
                                  '',
                                  true,
                                  true// 是否打开工具菜单
                                  );
end;

procedure TForm_ContourGraph.But_selectedClick(Sender: TObject);
begin
    SetMapSeriesSelected(not DraggingRectangle);
end;

procedure TForm_ContourGraph.But_WheelZoomClick(Sender: TObject);
begin
   SetCharWheelZoom(not MuddleWheelForZoom);
end;

procedure TForm_ContourGraph.But_CursorClick(Sender: TObject);
begin
    SetContourChartShiziVisible(not ContourChart_Cursor.Visible);
end;

procedure TForm_ContourGraph.But_DisplayStepClick(Sender: TObject);
begin
   SetOldStepVisible(not DrawGzm.CloudClass.OldStepDisplay);

end;

procedure TForm_ContourGraph.But_DispResultClick(Sender: TObject);
begin
     CreateStepResult(Application.Handle,'',self.Width,self.Height,0);
     if Assigned(Form_StepResult) then  begin
        Form_StepResult.InitForm(DrawGzm) ;
     end;
end;

procedure TForm_ContourGraph.But_Disp_ForCaseClick(Sender: TObject);
begin
   SetDispForCase(not DrawGzm.CloudClass.DisPlayForcase);

end;

procedure TForm_ContourGraph.But_Kyfx_FillMapClick(Sender: TObject);

begin
    DrawGzm.CloudClass.OldStepDisplay :=true;
    //刷新填充图形
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);

end;

procedure TForm_ContourGraph.But_Kyfx_ReportClick(Sender: TObject);
var
 t_s:widestring;
 thd:TReportWordThread;
begin
    t_s:='打印报告是通过调用系统OFFICE来实现输出'+#13#10 +
         '启动OFFICE 会耗费一点的时间，你确认么?';
    if Application.MessageBox(Pwidechar(t_s),'特别提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;


   But_Kyfx_Report.Enabled :=False;

   OptionTip(1,'正在生成文件，耐心等待');
//   ShowScreen:=2; // 系统正在进行导出
//   // 此处为主线程时空。
//   thd:=TReportWordThread.Create(true);
//   thd.OnAccumulated:=self.OnAccumulated; // Self 指是 FrmMain.
//   thd.iDrawGzm:=DrawGzm;
//   thd.iCallPStope:=self.CallPStope ;
//   thd.iKYGE_Report:=KYGE_Report;
//   thd.EiHandle:=ExHandle;
//   thd.Start; //启动线程,在线程时空中执行 Execute 中的代码。

    KYGE_Report.SetDrawGraph(DrawGzm,CallPStope);
    KYGE_Report.ReportAnsysisRockPress(EXHandle,DrawGzm.FGzm,False );

   But_Kyfx_Report.Enabled :=true;
end;

procedure TForm_ContourGraph.But_ThreeDimClick(Sender: TObject);
begin
    CreateThreeGraph(ExHandle,'',0,0,0);
    Form_ThreeGraph.WindowState:=wsMaximized;
    Form_ThreeGraph.InitForm(DrawGzm) ;
    Form_ThreeGraph.SmoothThreeDimPointValue(DrawGzm.DataTimeAndFootAge.Graph_MinDao,
                                             DrawGzm.DataTimeAndFootAge.Graph_MaxDao,
                                             1,DrawGzm.FGzm.SupEndNumber );
    Form_ThreeGraph.RefreshChartGraph;
end;

procedure TForm_ContourGraph.ToolButton4Click(Sender: TObject);
begin
 ContourPop_RightTool.Click ;
end;

procedure TForm_ContourGraph.TreePop_B_WordFileClick(Sender: TObject);
begin
  iUserWin.CreateGZmFileName (ExHandle,
               '矿压分析报告地质资料补录界面',Width,Height);
end;

procedure TForm_ContourGraph.TreePop_CloseClick(Sender: TObject);
begin
   SetRightToolVisible(FALSE);
end;

procedure TForm_ContourGraph.TreePop_DeleteAllClick(Sender: TObject);
var
  t_s:string;
begin
   t_s:='你确定要删除数据库中所有数据么?';
   if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

   DrawGzm.DeleteContourSeriesFromDataBase(0);
end;

procedure TForm_ContourGraph.TreePop_DeleteClick(Sender: TObject);
begin
   if (TreeView_Stepid >=0) and (TreeView_Stepid < length(DrawGzm.Auto_Judge_OldStep.ExSteps) ) then
      DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].Used :=2;
      RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TForm_ContourGraph.TreePop_depthClick(Sender: TObject);
begin
   But_Kyfx_FillMap.Click ;
end;

procedure TForm_ContourGraph.TreePop_FillClick(Sender: TObject);
begin
   But_Kyfx_FillMap.Click;
end;

procedure TForm_ContourGraph.TreePop_RecallClick(Sender: TObject);
begin
  if (TreeView_Stepid >=0) and (TreeView_Stepid < length(DrawGzm.Auto_Judge_OldStep.ExSteps) ) then
      DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].Used :=1;
     RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TForm_ContourGraph.TreePop_RefreshClick(Sender: TObject);
begin
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TForm_ContourGraph.TreePop_ReportClick(Sender: TObject);
begin
   But_Kyfx_Report.Click;
end;

procedure TForm_ContourGraph.TreePop_saveClick(Sender: TObject);
begin
   if DrawGzm.Auto_Judge_OldStep.isCalComeStep then  begin
       DrawGzm.SaveContourSeriesIntoDataBase(DrawGzm.Auto_Judge_OldStep,4 ) ;
       MapSeriesDataEdit:=False;
       OptionTip(1,'数据保存成功!');
   end;
end;

procedure TForm_ContourGraph.TreePop_StartClick(Sender: TObject);
begin
     But_Start_KYFX.Click ;
end;

procedure TForm_ContourGraph.TreeView1Click(Sender: TObject);
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
                   DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide,1);
        //更改编辑状态
    //  DrawGzm.EditMapPoint:=EditMapSeriesSteps(APolid,Stepid);
    end else begin
        SetPolygenProperty( DrawGzm.Auto_Judge_OldStep.ExSteps[0],false,
                   MapSeries.Shapes[i],
                   Vis,
                   DrawGzm.FGzm.RockPressAnalysis.StepFillColor,
                   DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide,1);
    end;

  // 改变坐标轴的位置
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
//          for i := 0 to 7 do
//           GB_Ky_Memo1.Lines.Add('OutPoint[' + IntToStr(i) + ']: (' + FormatFloat('0',DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].MyOutLinePoint[i].x) +
//                       ',' +  FormatFloat('0',DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].MyOutLinePoint[i].y) + ')');

          for i := 0 to DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].Pointcount -1 do
           GB_Ky_Memo1.Lines.Add('OutPoint[' + IntToStr(i) + ']: (' + FormatFloat('0',DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].Point_Int[i].x) +
                       ',' +  FormatFloat('0',DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].Point_Int[i].Y) + ')');
       end;



end;

procedure TForm_ContourGraph.TreeView1Collapsed(Sender: TObject; Node: TTreeNode);
begin
   Node.ImageIndex:=0;
   Node.SelectedIndex:=0;
end;

procedure TForm_ContourGraph.TreeView1Expanding(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
begin
     Node.ImageIndex:=1;
    Node.SelectedIndex:=1;
end;

procedure TForm_ContourGraph.TreeView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt:Tpoint;
begin
   if Button=mbRight then begin
      pt:= TreeView1.ClientToScreen(Point(0,0));
      DispTreePop (pt.X+x,pt.Y +y);
   end;


end;



{ TReportWordThread }


procedure TReportWordThread.Execute;
begin
  inherited;
   iKYGE_Report.SetDrawGraph(iDrawGzm,iCallPStope);
   iKYGE_Report.ReportAnsysisRockPress(EiHandle,iDrawGzm.FGzm,false );
   if Assigned(OnAccumulated) then
            OnAccumulated(self);
end;

end.  //end Unit
