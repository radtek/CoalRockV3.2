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

  // ����һ���߳�
  TReportWordThread = class; //��Ϊ��ǰ����
  TOnReported = procedure(Sender: TReportWordThread) of object;
  // �������ǰ������Sender ��Ҫ����� TObject
  // ���¼������У�Ҫ���� Sender ����Ҫǿ��ת��
  TReportWordThread = class(TThread)
  protected
    procedure Execute; override;

  public
     iDrawGzm:TDrawGrap;  // �������
     iCallPStope:TDefine_CallPStope; // �ɿ��㷨��
     EiHandle:THandle;
     iKYGE_Report:TWordReport;  // ��ѹ�۲� ����
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
     loadRockPress:Boolean;  // �Ƿ���ȡ�˿�ѹ����
     AutoRightPanelOpen:Boolean;// �Ҳ๤�����Ƿ����Զ��򿪵�
     // mouse Button
     MuddleWheelForZoom:Boolean; // ����м������Ϊ�Ŵ���С�Ĺ���
     LeftMousePanning:Boolean;//������ƽ��ͼƬ
     DraggingRectangle:Boolean;//����϶�����ѡ������
     Rect_X0,Rect_X1,Rect_Y0,Rect_Y1:integer; //Ȧ�����������
     bMouseDown:Boolean;// ��¼��갴�µĴ�����״̬
     MapSeriesDataEdit:Boolean; // ��¼�����޸�״̬
     FChartRefreshFinlly:Boolean;// ��¼Chart�Ƿ�������
     // Dll ����
     CallPStope:TDefine_CallPStope; // �ɿ��㷨��
     iUserWin:TDefine_WinFrame; {�û�DLL��}

     KYGE_Report:TWordReport;  // ��ѹ�۲� ����
     ShowScreen:integer;//��Ļ�رպ���
     ForceClose:Boolean;// ǿ�ƹر�

    procedure InitDrawGzmClass;//��ʼ����������
    function  SelectRockPressDataNumber(DataType:integer):Boolean;
    procedure OptionTip(index:integer;Str:String);
    procedure AutoLoadcomboBox(MkName,WkName:string);
   //-----------------------
    procedure RefreshContourlegendPalette;
    function  GetBatInputDataMaxGenTime(Support:integer):TDateTime;
    Procedure FillBasicJinDao(B_JinDao:TBasicJinDao;Support:integer);
    //---------------------------

    function  ZoomRect(mRect: TRect; mZoom: Integer): TRect;// ���Ʊ�����
    //--------------------------
    procedure setRightToolVisible(Value:Boolean);
    procedure DispContourPopMemu(Px,Py:Integer);  //��ʾ��ͼ���ƿ�ݲ˵�
    procedure DispPopEditArea(Px,Py:Integer);  // ���Ʊ༭�˵�����ʾ
    Procedure DispTreePop(Px,Py:Integer);//��ʾTreeView���ƿ�ݲ˵�
    procedure DispSelectEd(Px,py:Integer); // ��ʾ ѡ�еĿ�ݷ�ʽ

    //----------------------------
    procedure CopyDataToStringGridFromPaste(StrGrid: TstringGrid; Col,
                  Row, ColNumber: integer);
    procedure ChangePressDataUnit(Flag:integer);  // �������ݵ�λ
    //---------------------------------------

    procedure ChangeRectangleToDrawSupportLineGraph(x0,y0,x1,y1:integer); // �ѽ����ͳ�ȥ
    function  ReturnSelectRectangleSupport(MinSup,MaxSup:integer):string;
    procedure SetContourChartShiziVisible(Value:Boolean);// ��ͼʮ������ָʾ

    procedure SetMapSeriesSelected(Value:Boolean);//����ͼ��Ϊѡ�е�״̬
    procedure SetMouseInitValue;  //���������ֳ�ʼ״̬
    procedure SelectReganleToDrawLinGraph(Value:Boolean);// ����ѡ���������ѹ������
    procedure ClearRectangle;// ��Ȧ�����������
    procedure SetContourSeriseZoomUsed(Value:Boolean);//�����������Ŵ���
    procedure SetCharWheelZoom(Value:Boolean); //�Ƿ����ù�����������
    procedure SetChartRightPanning(Value:Boolean);//�Ƿ��������ƽ�ƹ���
    procedure SetOldStepVisible(Value:Boolean);//�����Ƿ���ʾ��ѹ����
    procedure SetMiddleWheelForZoom(Value:Boolean);// ���� ���߽��� �м������Ϊ�Ŵ���С�Ĺ���
    procedure SetContourSeriesDisply(Value:Boolean);// ������ͼ����ʾ��ʽ��ɫ���ǲ�ɫ
    procedure SetDispForCase(Value:Boolean); // �Ƿ���ʾ Ԥ�ⲽ��
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
                  Apol:TTeePolygon;Tran:Boolean;MC:TColor;LineW,SaveOrFx:integer);
    procedure MapSeriesClick(Sender: TChartSeries; ValueIndex: Integer;
              Button: TMouseButton; Shift: TShiftState; X, Y: Integer) ;
    procedure MapSeriesDoubleClick(Sender: TChartSeries; ValueIndex: Integer;
              Button: TMouseButton; Shift: TShiftState; X, Y: Integer) ;
    procedure DispLabelMarkToMemo(Value:Boolean;Px,Py,Stepid:integer);

     //--------------------------------------------------
    //��ʼ���п�ѹ���ݷ�������������
    function  StartRockPressAnslysisBegin(AutoOrManual:Boolean):Boolean;
    function  EditMapSeriesSteps(ApolId,StepClassId:integer):TEditMapSeriesRe;
    function  AutoAnslysis_LevelLine(Ratio:double;var LevelValue,Inv_D:double;
                 var RaiseOrDrop:Boolean;var RaiseCount:integer):Boolean;
//    function  AutoAnslysis_SupDao(Ratio:double;var LevelValue,Con_Sup,Con_Dao:integer;
//                 var RaiseOrDrop:Boolean):Boolean;
    procedure ReModiFyStepOldClass(OldStep:TOldSteps;EditMapRec:TEditMapSeriesRe);
    //ˢ����ѹ�����ͼ�㺯��
    procedure RefreshOldStepAddToMapSeries(Visible:Boolean);

    function CreateSaveBmpPath:String; //��������ͼƬ���ļ�·��
    function GetContOurChartBmpFileName(Value:integer):String;
    function GetSelectRectangleSupport(MinSup, MaxSup: integer): string;  //��ȡcontourChar�����ļ����ļ���
    //ˢ��chart
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
     EXCaption:String; // �ⲿ�������ı���
     DrawGzm:TDrawGrap;  // �������
    // DrawLineGraph:TDrawLineGraph;
    { Public declarations }

      procedure InitForm;      //��ʼ�����沿�ֹ���
      procedure RefreshMyCloudChart;

      procedure LoadRockPressData(Flag:integer);
      function  GetLoadDate:Boolean;
      procedure SetLoadDate(Value:Boolean);
      function  GetRockPressAnslysis:Boolean;
      function  setContourChartMin_MaxToBmp(Min_X,Max_X:double):String;
      // �����ļ�
      function ContourChartSaveIntoBMP(Path:string;Value:integer):Boolean;
      // ���ⲿ��ʹ�õ��ļ�
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
{����  'LibCallPstope.dll'�� Ϊ TuserCallPstope ����}
function TCallPStope:TClassStateMent_CallPStope; external 'LibCallPStope.dll' ;
{����  'LibWinFrame.dll'�� Ϊ UserWin:TWinFrame ����}
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
{Flag 1 ����ά��  Flag 2 ��ѹ����ά��  3 ��ѹ���ݷ���}
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
               CreateRockPressTool(MainPanel.Handle,'��ͼ��ʾ�������ý���',
                            Form_ContourGraph.Width ,Form_ContourGraph.Height,1);

               Result:=Form_ContourGraph.Handle ;//����ֵ
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
  ��������� ���л�������
  RaiseOrDrop true  ����  false ����
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
   //�ж��빤������ص����ݱ��Ƿ񴴽������û�д������ٴ˴���
   if not MainDataModule.IsExsitTableName('D_'+inttostr(DrawGzm.FGzm.Gzmbh)+'_BasicData') then begin
       MainDataModule.CreateTable('2',MainDataModule.DataType,inttostr(DrawGzm.FGzm.Gzmbh),'') ;
   end;
   // �ڴ˶�FGZM ��֧�������Ϣ���в���
    if not DrawGzm.Cal_MPaChangeKN_xs then  begin
       //messagebox(Handle,'�벹ȫҺѹ֧������������','ϵͳ��ʾ',mb_iconerror+mb_ok);
    end;
   OptionTip(0,'�ԡ�'+DrawGzm.FGzm.S_Name+'�����ݽ��з���!');

end;



procedure TForm_ContourGraph.MainTreeView(TreeView: TTreeView;FromWhere:string);
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
      ExtractDataFormSeries(TreeView,xNode,ContSeries,1);

    New(RecData);
    RecData^.BName:='-1';
    RecData^.DName:='ROOT';
    RecData^.XHeight:='-1';
    xNode:=TreeView.Items.AddObject(nil,'δ�洢����ѹ��Ϣ',RecData);
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
       //���ı༭״̬
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
     UnitName :='��ǰ���ݵ�λΪ MPa' ;
     DrawGzm.ColorValue.UnitType :=1;
     DrawGzm.ColorValue.UnitValue:=1;
     DrawGzm.ColorValue.UntiName:='MPa' ;
  end else begin
     UnitName :='��ǰ���ݵ�λΪ Bar' ;
     DrawGzm.ColorValue.UnitType:=2;
     DrawGzm.ColorValue.UnitValue:=10;
     DrawGzm.ColorValue.UntiName:='Bar' ;
  end;
     Caption:=EXCaption+'��'+ UnitName+'��';

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
    // �� ��������ͼ�Ľ���
    CreateLineGraph(ExHandle,'',0,0,0);
    DrawGzm.GraphClass.CycleDataEfficient:=True;//��������ͼ�д�������
    Form_LineGraph.SetOpenFormVar(DrawGzm,
                                  ReturnSelectRectangleSupport(SupST,SupEn),
                                  true,
                                  true// �Ƿ�򿪹��߲˵�
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
        {��ζ�Ž���ͼ�α༭״̬}
        DispPopEditArea(pt.X+x,pt.Y +y) ;
      end else begin
        DispContourPopMemu(pt.X+x,pt.Y +y);
      end;

   end;
   // ��¼��һ����갴�µ�λ��
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
         if WheelDelta>0 then  begin  //����  ǰ�� �Ŵ�
             ContourChart.ZoomPercent( 110 );
         end else begin   //����  ��� ��С
             ContourChart.ZoomPercent( 90);
         end;
      end;
end;


function TForm_ContourGraph.ContourChartSaveIntoBMP(Path: string;Value:integer): Boolean;
{
  Path <> '' �ǰ� ͼƬ���浽 ָ����·����
  path = ''  �ǰ�ͼƬ �Զ����浽 ϵͳλ��
       _0  �Ǵ���û�в�����ͼ�� ͼƬ
       _1  �Ǵ����в�����ͼ�� ͼƬ

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
     CreateRockPressTool(Application.Handle,'��ͼ��ʾ�������ý���',
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
       //���ı༭״̬
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
       //���ı༭״̬
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
       ContourPop_Kyfx.Enabled :=true;       // ��ѹ������
       ContourPop_refreshchart.Enabled :=true;// ˢ��ҳ��
       ContourPop_ChangUnit.Enabled :=true;  //  �ı䵥λ
       ContourPop_Save_Bmp.Enabled :=true; //  ����ͼƬ
    end;
    if DrawGzm.MapSeriesEditState=2 then  begin
       ContourPop_ED.Enabled :=true;
    end;


    if not GetRockPressAnslysis then begin  //ϵͳ �����˿�ѹ����
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
    series.Clear ;
        for I := 0 to high(OldStep.ExSteps ) do  begin
            if (OldStep.ExSteps[i].GetMinDao >= DrawGzm.CloudClass.SaveDataMinDao  ) and
                  (OldStep.ExSteps[i].GetMaxDao <= DrawGzm.CloudClass.SaveDataMaxDao )  then
                  {��������������ݿⱣ������ݿռ���  ���ж������Ƿ�������¼���   }
                 if not DrawGzm.CloudClass.RecallMidDaoSaveStep  then  begin    // ��������¼���
                    // ���Զ��������ͼ ���ε�  ModifyData=1Ϊ ����ѹ�� ModifyData=5 Ϊ �ֲ�ѹ�������ܹ���������ѹ
                    if (OldStep.ExSteps[i].Used=1) and
                       ((OldStep.ExSteps[i].ModifyData=1)  or (OldStep.ExSteps[i].ModifyData=5) ) then  // ��ʾ �Զ���ͼ�����
                       OldStep.ExSteps[i].Used:=2;
                    if DrawGzm.CloudClass.SaveDate_Edit then   // ������Ա༭
                       if (OldStep.ExSteps[i].Used=1) and (OldStep.ExSteps[i].ModifyData=4)  then  // ��ʾ ���ݿ���ȡ������
                           OldStep.ExSteps[i].ModifyData:=7;
                 end else  begin
                    // �����ݿⱣ�淶Χ�ڵ���ͼ���ε�   ModifyData=4 ��ʾ ���ݿ�����ȡ������
                    if (OldStep.ExSteps[i].Used=1) and (OldStep.ExSteps[i].ModifyData=4)  then  // ��ʾ ���ݿ���ȡ������
                       OldStep.ExSteps[i].Used:=2;
                 end;


            if  OldStep.ExSteps[i].Used <> 1 then   continue;   // ����������ʾ�ķ���

            APol:=series.Shapes.Add ;
            OldStep.ExSteps[i].MapSeriesIndex :=APol.Index ;
            APol.Points.Clear ;

            //
             if  (OldStep.ExSteps[i].GetMinDao >= DrawGzm.DataTimeAndFootAge.Graph_MinDao ) and
                         (OldStep.ExSteps[i].GetMaxDao <= DrawGzm.DataTimeAndFootAge.Graph_MaxDao ) then  begin
                 { ����������� ������ ����������  }
                  if OldStep.ExSteps[i].ModifyData =3  then  begin  // ��ʾԤ������
                      if DrawGzm.CloudClass.DisPlayForcase then   //���ͬ����ʾԤ������
                         if  OldStep.ExSteps[i].ForcaseId=1 then   begin  //�����˶� Ԥ������
                            SetPolygenProperty(OldStep.ExSteps[i],true,APol,true,ClRed,LineWide,1);
                         end else if OldStep.ExSteps[i].ForcaseId= 2 then begin
                            SetPolygenProperty(OldStep.ExSteps[i],true,APol,true,ClYellow,LineWide,1);
                         end;
                  end else if OldStep.ExSteps[i].ModifyData =1  then begin  // ��ʾ��������
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,Color,LineWide,0);
                  end else if OldStep.ExSteps[i].ModifyData =4  then begin  // ���������ݿ�����ȡ������
                      {�����ݿ���ȡ�����ݱ�ɻ�ɫ ���� ���ɱ༭}
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,clGray,LineWide,1);
                  end else if OldStep.ExSteps[i].ModifyData =5  then begin  // ��ʾ�ֲ�ѹ������
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,ClRed,LineWide,0);
                  end else if OldStep.ExSteps[i].ModifyData =7  then begin  // ��ʾ���ݿ���ȡ �ı�Ϊ���Ա༭��״̬
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,Color,LineWide,1);
                  end else if OldStep.ExSteps[i].ModifyData =8  then begin  // ��ʾ�ж�ֱ�Ӷ����� �϶���Сѹ����
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,ClYellow,LineWide,1);
                  end else if OldStep.ExSteps[i].ModifyData =9  then begin  // ��ʾ�ж��϶���λ������ѹ
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,ClBlue,LineWide,1);
                  end else if OldStep.ExSteps[i].ModifyData =10  then begin  // ��ʾ�ж��϶���λλ������ѹ
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,clFuchsia,LineWide,1);
                  end;

             end else begin
                {  ���������������� �ж�����ʾʲô����   }
                 if DrawGzm.CloudClass.DisPlayProMinDaoSaveStep then  begin // ���������Ƿ���ʾ�Ƿ� ��ʾ  //
                      if (OldStep.ExSteps[i].ModifyData =4) then
                      {
                        ������ݿ��д������ݣ�������ʾ
                      }
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,clGray,LineWide,1);
                 end;

                  if OldStep.ExSteps[i].ModifyData =3  then  begin  // ��ʾԤ������
                     if DrawGzm.CloudClass.DisPlayForcase then   //���ͬ����ʾԤ������
                         if  OldStep.ExSteps[i].ForcaseId=1 then   begin  //�����˶� Ԥ������
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
    //�ָ����Ŵ�״̬
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
        // ����������ѹ�������
        DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
        DrawGzm.CaluateStepToPrint ;
         // ���ư�ť
        But_Kyfx_FillMap.Enabled:=True;
        contourPop_KYFX_Result.Enabled :=true;
    end else begin
        DrawGzm.CloudClass.RockPressAnslysis:=False;
        SetOldStepVisible(FALSE);// ����ʾ��ѹ����
    end;

    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
    RefreshContourlegendPalette;

     //����ͼƬǰ Ҫ��ͼ��ˢ����
      ChartRefresh;
      ContourChartSaveIntoBMP ('',1);
    //������ť��ͼ��״̬
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
    // ��������ͼ
    LineSeries.Clear ;

    for I := 0 to 7 do  begin
      LineSeries.AddXY(DrawGzm.Auto_Judge_OldStep.ExSteps[StepClassid].MyOutLinePoint[i].Point.x,
                        DrawGzm.Auto_Judge_OldStep.ExSteps[StepClassid].MyOutLinePoint[i].Point.y
                        );
      //���������
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
    // �����Ŵ������Ϊ�Ŵ�ģʽ
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

                 if DrawGzm.Auto_Judge_OldStep.ExSteps[i].ModifyData =1  then  begin // δ�����ֵ
                      if  DrawGzm.Auto_Judge_OldStep.ExSteps[i].Used =1 then   begin  // ��Ч������
                            New(RecData);
                            RecData^.BName:='1';
                            RecData^.DName:=IntToStr(i);
                            RecData^.XHeight:=intTostr(DrawGzm.Auto_Judge_OldStep.ExSteps[i].MapSeriesIndex);
                            xChild3:=TreeView.Items.AddChildObject(xChilld11,DrawGzm.Auto_Judge_OldStep.ExSteps[i].GetDispTitle ,  RecData);
                            xChild3.ImageIndex:=2;
                      end else if  DrawGzm.Auto_Judge_OldStep.ExSteps[i].Used =2 then begin  //��ɾ��������
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
        xChilld12:=TreeView.Items.AddChildObject(ParantNode,'��ѹ��������',RecData);
        xChilld12.ImageIndex:=0;

         for I := 0 to length(DrawGzm.Auto_Judge_OldStep.ExSteps)-1 do   begin
             if  DrawGzm.Auto_Judge_OldStep.ExSteps[i].Used <>1 then continue;

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
       {�رմ��壬������Ҫ����Close����}
          if CloseCheckRunThread then  begin
             if Application.MessageBox(pchar('excel��Word��������ǿ���˳�ô��'), '��ʾ', MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDYES then begin
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
     //Ĭ�ϻ�β��ʾ ʱ��
     DrawGzm.ConTourSeriesPar.Display_UpperFootage:=0;
     DrawGzm.ConTourSeriesPar.Display_DownFootage:=1;
    // SetMinMaxJinDao(30,50);

     // �ر�ʮ�ֹ����
     SetContourChartShiziVisible(False);


     //��ѹ��������״̬   Ĭ��û�н���������
     SetOldStepVisible(false);
     //����û�н����������İ�ť
     SetBut_KYFX_Enabled(False);
     //����ͼƬ�����ļ���

    //
     BasicJinDao:=TBasicJinDao.Create ;
      //       {'LibCallPstope.dll' ���ⲿ��}
       if not Assigned(CallPStope) then  begin
           CallPStope:=TCallPstope.Create ;
           CallPStope.SetStatuesCaption(PansiChar(Ansistring(
                            self.StatusBar1.Panels[2].text)));
           
       end;
        {'LibWinFrame.dll' ���ⲿ��}
       if not Assigned(iUserWin) then begin
          iUserWin:=TuseWin.Create ;
          iUserWin.SetStatuesCaption(PansiChar(Ansistring(
                            self.StatusBar1.Panels[2].text)));
          iUserWin.RecallConnectDataBase ;
       end;

      KYGE_Report:=TWordReport.Create;  // ��ѹ�۲� ����
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
       CreateRockPressTool(MainPanel.Handle,'��ͼ��ʾ�������ý���',
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
  Value =0  ����ȡ ���� ͼ�� �������� ��С������ �ļ���
         1  ����ȥ ����ͼ�� ��ǰ ���� ��Ϊ�ļ���

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
    // ��������
    DrawGzm.GraphClass.Out_input_Data :=False;
    DrawGzm.GraphClass.Graph_DataCalss:=single;
    DrawGzm.GraphClass.SupportList :='';
    DrawGzm.GraphClass.Support_Select_List:='';
    DrawGzm.GraphClass.ScrollPageSize :=2; //3��

    // ��һ��ʾʱ ׷������
    for I := 0 to 2 do
         DrawGzm.GraphClass.Disp_DataType[i]:=true;

     DrawGzm.GraphClass.YAxisType:=4;  // �ĸ�������
     // ���� ������ ��ʾ
     DrawGzm.GraphClass.Line_Tpye:=1;// ���������Ƿ� �ò�ͬ���ͱ�ʾ  0 ͳһ���� 1 ��ͬ����
     DrawGzm.GraphClass.Line_Color:=1; //�������� �Ƿ� ͳһ��ɫ��ʾ  0 ��ɫ  1 ��ɫ �� ��  ��  ��
     DrawGzm.GraphClass.Line_Width:=0;  // �ߵĿ���Ϊ1
    //
    DrawGzm.ConTourSeriesPar.Display_UpperFootage:=1;;
    DrawGzm.ConTourSeriesPar.Display_DownFootage:=0;
  //��ȡ��������ʾ�����÷�ʽ

    DrawGzm.CloudClass.X_Axis_Disp_Type:=1;
    DrawGzm.CloudClass.X_Axis_Disp_Dao:=100;

  //��ȡ�Ƿ���ʾԤ��������Ϣ
     DrawGzm.CloudClass.DisPlayForcase:=true;


    //��ȡ�Ƿ���ʾ��С����֮ǰ����ѹ����
    DrawGzm.CloudClass.DisPlayProMinDaoSaveStep:=true;

     //��ȡ�Ƿ�������·���  ���ڽ���֮�ڵ����򱣴������
     DrawGzm.CloudClass.RecallMidDaoSaveStep:=False;

   //��ȡ�洢�������Ƿ���Ա༭
     DrawGzm.CloudClass.SaveDate_Edit:=true;


     //��ȡ������Χ֮�����ѹ��Ϣ�Ƿ����
     DrawGzm.CloudClass.PrintOutDaoStepInto:=False;

       //��ȡ��ѹ���ݷֶ���ʾ��ʽ
     DrawGzm.CloudClass.PrintDispPhaseVisual:=False;
      // Tabpage ����ʾ ��ʽ
     DrawGzm.GraphClass.FisrtPageId:=0;
     DrawGzm.GraphClass.SecondPageid:=0;
     // ��ͼ�ǵ�ɫ��ʾ���Ƕ�ɫ��ʾ
     SetContourSeriesDisply(true);
     // ���ݷ���������
     DrawGzm.FGzm.RockPressAnalysis.AnalysisSenstive:=3;
     DrawGzm.FGzm.RockPressAnalysis.Min_Pt:=55;
     DrawGzm.FGzm.RockPressAnalysis.Continue_SupNumber:=6 ;
     DrawGzm.FGzm.RockPressAnalysis.conTinue_DaoNumber:=3;
     // bar
     DrawGzm.BarMarks.Disp_0 :=0;
     DrawGzm.BarMarks.Disp_B_D:=0;
     DrawGzm.BarMarks.Disp_Mark:=1;
     // ��ͼĬ����ʾ����
     DrawGzm.CloudClass.Yuntu_CycleData :=Mzl_CData  ;
     // ���ƴ�ӡ������½�
     DrawGzm.GraphClass.Reportfirst :=true;
     DrawGzm.GraphClass.ReportSecond :=true;
end;

procedure TForm_ContourGraph.InitForm;
var
  i:integer;
begin
    MainPanel.Align :=alClient;
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
    ContSeries.Selected.Hover.Visible :=False;
    DrawGZm.MapSeriesEditState :=-1;  // Ĭ��û�м�������
    DrawGzm.CloudClass.OldStepDisplay :=False; //��ͼ����ʾ��ѹ����
    //Ĭ�����ݵ�λΪBar
    ChangePressDataUnit(2);
    loadRockPress:=False; // �Ƿ���ؿ�ѹ����
    DrawGzm.CloudClass.RockPressAnslysis:=False;//��ѹ����������
    // ��ʼ��DrawGzmClass
    InitDrawGzmClass;
    SetDispForCase(true);// ����ʾԤ�ⲽ����ͼ����Ϊ��
   // ��ʼ��������
    SetMouseInitValue;
    // �����޸�״̬
    MapSeriesDataEdit:=False;
    //
    DispLabelMarkToMemo(False,0,0,0);
     //���� ���㲽�����
    DrawGzm.Auto_Judge_OldStep:=DrawGzm.ChangeJudgeStepClass(DrawGzm.CloudClass.Yuntu_CycleData);

    
end;


procedure TForm_ContourGraph.OnAccumulated(Sender: TReportWordThread);
begin
   OptionTip(1,'Excel�������');

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
    DrawGzm.BarMarks.Fromcontour:=true;;//��������ͼ�д�������
     if Assigned(Form_Band_Bar) then  begin
        Form_Band_Bar.InitForm(DrawGzm) ;
        Form_Band_Bar.SetOpenFormVar( ReturnSelectRectangleSupport(SupST,SupEn),
                                  true,
                                  true// �Ƿ�򿪹��߲˵�
                                  );

     end;
end;

procedure TForm_ContourGraph.OpenLinGraph(inHandle: THandle;wid,hig:integer);
begin
      // �� ��������ͼ�Ľ���
    CreateLineGraph(inHandle,'��ؽ����������ͼ',wid,hig,1);
    DrawGzm.GraphClass.CycleDataEfficient:=True;//��������ͼ�д�������
    Form_LineGraph.SetOpenFormVar(DrawGzm,
                                  '',
                                  true,
                                  true// �Ƿ�򿪹��߲˵�
                                  );
end;

procedure TForm_ContourGraph.OpenReportWord(inHandle: THandle; wid,
  hig: integer);
var
 t_s:widestring;
 thd:TReportWordThread;
begin
    t_s:='��ӡ������ͨ������ϵͳOFFICE��ʵ�����'+#13#10 +
         '����OFFICE ��ķ�һ���ʱ�䣬��ȷ��ô?';
    if Application.MessageBox(Pwidechar(t_s),'�ر���ʾ',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

   OptionTip(1,'���������ļ������ĵȴ�');
   ShowScreen:=2; // ϵͳ���ڽ��е���
   // �˴�Ϊ���߳�ʱ�ա�
   thd:=TReportWordThread.Create(true);
   thd.OnAccumulated:=self.OnAccumulated; // Self ָ�� FrmMain.
   thd.iDrawGzm:=DrawGzm;
   thd.iCallPStope:=self.CallPStope ;
   thd.iKYGE_Report:=KYGE_Report;
   thd.EiHandle:=inHandle;
   thd.Start; //�����߳�,���߳�ʱ����ִ�� Execute �еĴ��롣


end;

procedure TForm_ContourGraph.OpenResultExcel(inHandle: THandle; wid,
  hig: integer);
begin
     CreateStepResult(inHandle,'��ѹ����ж������ʾ',wid,hig,1);
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
    // �� ��������ͼ�Ľ���
    CreateBand_Bar(ExHandle,'',0,0,0);
    DrawGzm.BarMarks.Fromcontour:=true;;//��������ͼ�д�������
     if Assigned(Form_Band_Bar) then  begin
        Form_Band_Bar.InitForm(DrawGzm) ;
        Form_Band_Bar.SetOpenFormVar( ReturnSelectRectangleSupport(SupST,SupEn),
                                  true,
                                  true// �Ƿ�򿪹��߲˵�
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
               '�����˶�����չʾ',Width,Height,1);
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
               '�ɳ��ϸ��Ҳ��˶�ģ�����',Width,Height,1);
    CallPStope.SetDTFZ_JinChi(Trunc(JinChi));
end;

procedure TForm_ContourGraph.LineGraphPop_toolClick(Sender: TObject);
begin
  CreateRockPressTool(Application.Handle,'��ͼ��ʾ�������ý���',
             Form_ContourGraph.Width ,Form_ContourGraph.Height,1);
end;

procedure TForm_ContourGraph.LoadRockPressData(Flag: integer);
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
    // �����������ƽ��ֵ��Ϣ��������
    DrawGzm.SelectPressDataFromSupportMoveInfo(FirstPGBar,SecondPGBar,0);
    // �����ݵ������ֵ������
    DrawGzm.CalAGV_AGV_WholeData;
    // ������ͼ
    DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,False,0,0);

    // ���ư�ť
    ContourPop_loadData.Enabled:=False;
    DrawGzm.MapSeriesEditState:=1;

    // ��¼�����Ƿ����
    LoadRockPress:=true;
     //��֪��Ϊʲô����Ҫˢ������
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
   if not LoadRockPress then   exit; //���û�м������� ����

   t_s:='��ѹ����������޸ģ�����û�б��浽���ݿ⣡'+#13#10+'��ȷ�ϰѸô��޸����ñ���ô��';
   if MapSeriesDataEdit then
     if Application.MessageBox(Pwidechar(t_s),'��ʾ',MB_OKCANCEL+MB_ICONQUESTION) =1 then
        if DrawGzm.Auto_Judge_OldStep.isCalComeStep then  begin
             DrawGzm.SaveContourSeriesIntoDataBase(DrawGzm.Auto_Judge_OldStep,4 ) ;
             MapSeriesDataEdit:=False;
        end;

   // �ѿ����ͼ����Ϊ��
   SetKrigcontour(False);
    // ������ͼ
   DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,true,100,100);
   DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
   //�������ݵ�λ�Ļ���
   DrawGzm.Cal_MPaChangeKN_xs;
   //�ѿ�������ͼ�����
   DrawGzm.RefreshChart_ConTourSeries(ContourChart,KrigContour,FirstPGBAr,SecondPGBar,1);
   // �����ͼ��Ϣ   ContSeries
   DrawGzm.RefreshChart_ConTourSeries(ContourChart,ContSeries,FirstPGBAr,SecondPGBar,0);

   //���� ���㲽�����
   DrawGzm.Auto_Judge_OldStep:=DrawGzm.ChangeJudgeStepClass(DrawGzm.CloudClass.Yuntu_CycleData);

   if GetRockPressAnslysis then  begin
      //���ư�ť
        SetBut_KYFX_Enabled(true);
       {AnalysisSenstive=3 ϵͳ�Զ��ж�����}
      if DrawGzm.Fgzm.RockPressAnalysis.AnalysisSenstive=3 then   begin
          if StartRockPressAnslysisBegin(true) then begin
              // ����������ѹ�������
              DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
              DrawGzm.CaluateStepToPrint ;
               // ���ư�ť
              But_Kyfx_FillMap.Enabled:=True;
          end else begin
              DrawGzm.CloudClass.RockPressAnslysis:=False;
              SetOldStepVisible(FALSE);// ����ʾ��ѹ����
          end;
      end else begin   {AnalysisSenstive  ϵͳͨ���趨�Ĳ����������}
          if StartRockPressAnslysisBegin(False) then begin
              // ����������ѹ�������
              DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
              DrawGzm.CaluateStepToPrint ;
               // ���ư�ť
              But_Kyfx_FillMap.Enabled:=True;
          end else begin
              DrawGzm.CloudClass.RockPressAnslysis:=False;
              SetOldStepVisible(FALSE);// ����ʾ��ѹ����
          end;
      end;
   end else  begin
     SetBut_KYFX_Enabled(False);
   end;
     // ֱ��ˢ�� ���ദ�� ͼ��
     RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
     RefreshContourlegendPalette;

     DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,False,0,0);

      //����ͼƬǰ Ҫ��ͼ��ˢ����
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
      //�����������ˢ��
    // DrawGzm.Auto_Judge_OldStep.Refresh;
     if Visible then  begin    // ������ͼ�Ƿ���ʾ
        // �жϵ���ѹ����
        DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);
        DisplyMapSeries(MapSeries,DrawGzm.Auto_Judge_OldStep,
                     Vis,
                     DrawGzm.FGzm.RockPressAnalysis.StepFillColor,
                     DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide
                     );
     end else begin
        MapSeries.Clear ;

     end;

     // ������ͼ��ʾ��ʽ
      if DrawGzm.ColorValue.ColorDisply then begin
         DrawGzm.ContourSeries1_Basic_GroupLevle(DrawGzm.ColorValue ,Series);
      end else begin
         if DrawGzm.FGzm.RockPressAnalysis.Min_Pt >54 then
            DrawGzm.FGzm.RockPressAnalysis.Min_Pt :=40;
         DrawGzm.ContourSeries1_Extract_GroupLevel(DrawGzm.FGzm.RockPressAnalysis.Min_Pt,
                                DrawGzm.ColorValue ,Series);
      end;

     // MainTreeView(TreeView1,'Series');
      // ��ͼ�εı༭״̬�ָ������״̬
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
    OldStep.ExSteps[EditMapRec.StepClassid].ModifyData :=1; // �޶�����󣬻ص�ԭʼ״̬
    OldStep.ExSteps[EditMapRec.StepClassid].Used :=1;
   //ˢ��һ������
   OldStep.ExSteps[EditMapRec.StepClassid].Refresh ;
   Optiontip(1,'���ݴ洢�ɹ���');
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
    //�������֧������С֧�ܵı��
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

procedure TForm_ContourGraph.SaveButtonClick(Sender: TObject);
begin
   ContourPop_refreshchart.Click ;
end;



procedure TForm_ContourGraph.SelectReganleToDrawLinGraph(Value:Boolean);
begin
   if Value then   begin
       SetChartRightPanning(False);
       // ��ֹ�Ŵ���
       ContourChart.Zoom.Allow :=FALSE;
       ContourPop_LeftZoom.Caption :='��������Ŵ���';

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
     CoolBar1.Bands[1].Visible :=Value; //��ѹ����
end;

procedure TForm_ContourGraph.setChartRefresh(Value: Boolean);
begin
    FChartRefreshFinlly:=Value;
end;

procedure TForm_ContourGraph.SetContourSeriesDisply(Value: Boolean);
begin
    if Value then  begin
        DrawGzm.ColorValue.ColorDisply :=true;
        ContourPop_Single_Disp.Caption :='��ͼ��ɫ��ʾ';
        But_Single_Disp.Caption:='��ɫ��ʾ';
        But_Single_Disp.ImageIndex :=58;
        ContourPop_Single_Disp.ImageIndex:=58;
    end else begin
         DrawGzm.ColorValue.ColorDisply :=False;
        ContourPop_Single_Disp.Caption :='��ͼ��ɫ��ʾ';
        But_Single_Disp.Caption:='��ɫ��ʾ';
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
        ContourPop_LeftZoom.Caption :='��������Ŵ���';
        But_LeftZoom.Caption :='���÷Ŵ�';
        //
        DraggingRectangle:=False;
        But_Selected.Caption :='����ѡ��';
        ContourPop_Selected.Caption:='�������ѡ�й���';
    end else begin
        ContourChart.Zoom.Allow :=FALSE;
        ContourPop_LeftZoom.Caption :='��������Ŵ���';
        But_LeftZoom.Caption :='����Ŵ�';
        ContourChart.UndoZoom ;
        //
        DraggingRectangle:=true;
        But_Selected.Caption :='����ѡ��';
        ContourPop_Selected.Caption:='�������ѡ�й���';
    end;

end;


procedure TForm_ContourGraph.SetDispForCase(Value: Boolean);
begin
   if Value then  begin    // ��ʾԤ�ⲽ��
      DrawGzm.CloudClass.DisPlayForcase:=True;
      ContourPop_Disp_ForCase.Caption:='����Ԥ�ⲽ����ͼ';
      But_Disp_ForCase.Caption :='����Ԥ��';
   end else begin //����ʾԤ�ⲽ��
      DrawGzm.CloudClass.DisPlayForcase:=False;
      ContourPop_Disp_ForCase.Caption:='��ʾԤ�ⲽ����ͼ';
      But_Disp_ForCase.Caption :='��ʾԤ��';
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
      ContourPop_LeftMouse_panning.Caption :='�������ƽ��ͼƬ' ;
      But_Left_Panning.Caption :='����ƽ��';
      DraggingRectangle:=False;
      But_Selected.Caption :='����ѡ��';
      ContourPop_Selected.Caption:='�������ѡ�й���';

   end else begin
      LeftMousePanning:=False;
      ContourChart.Panning.Active :=False;
      ContourChart.AllowPanning := pmNone;
      ContourPop_LeftMouse_panning.Caption :='�������ƽ��ͼƬ' ;
      But_Left_Panning.Caption :='���ƽ��';
      //
      DraggingRectangle:=true;
      But_Selected.Caption :='����ѡ��';
      ContourPop_Selected.Caption:='�������ѡ�й���';

   end;
end;

procedure TForm_ContourGraph.SetCharWheelZoom(Value: Boolean);
begin
    if Value then  begin   // ����
       MuddleWheelForZoom:=True;
       ContourPop_WheelZoom.Caption :='���ù�������ͼ��';
       But_WheelZoom.Caption :='���ù���';
    end else begin    // ��ֹ
       MuddleWheelForZoom:=False;
       ContourPop_WheelZoom.Caption :='���ù�������ͼ��';
       But_WheelZoom.Caption :='���ù���';
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
  // ����Ϊ�ļ�
   ContourChartSaveIntoBMP('',2);
end;

procedure TForm_ContourGraph.SetContourChartShiziVisible(Value: Boolean);
begin
    if Value then    begin
        ContourPop_Shizhi.Caption :='�ر�ʮ�ֹ����';
        ContourChart_Cursor.Visible :=true;
        But_Cursor.Caption:='�رչ��';
    end else  begin
        ContourPop_Shizhi.Caption :='��ʮ�ֹ����';
        ContourChart_Cursor.Visible :=FALSE;
        But_Cursor.Caption:='ʮ�ֹ��';
    end;
end;



procedure TForm_ContourGraph.SetLoadDate(Value: Boolean);
begin
    loadRockPress:=Value;
end;

procedure TForm_ContourGraph.SetMapSeriesSelected(Value: Boolean);
begin
    if Value then begin    //����
       SelectReganleToDrawLinGraph(true);
       But_Selected.Caption :='����ѡ��';
       ContourPop_Selected.Caption:='�������ѡ������';
    end else begin // ����
       SelectReganleToDrawLinGraph(FALSE);
       But_Selected.Caption :='����ѡ��';
       ContourPop_Selected.Caption:='�������ѡ�й���';
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
    SetCharWheelZoom(true); //���� ����ʹ�÷Ŵ���С����
    SetChartRightPanning(false);//����ʹ�����ƽ��
    DraggingRectangle:=FALSE; // ��ֹʹ�� Ȧ��������
    ClearRectangle;// ���Rectangle �ĳ�ʼ״̬
      //�������״̬
    SetMapSeriesSelected(true);
end;

procedure TForm_ContourGraph.SetOldStepVisible(Value: Boolean);
begin
     {contourPop_Disp_Step}
    if Value then    begin
        contourPop_Disp_Step.Caption :='������ѹ��־��ͼ';
        DrawGzm.CloudClass.OldStepDisplay:=true;
        But_DisplayStep.Caption :='������ѹ';
    end else  begin
        contourPop_Disp_Step.Caption :='������ѹ��־��ͼ';
        DrawGzm.CloudClass.OldStepDisplay:=False;
        But_DisplayStep.Caption :='��ʾ��ѹ';
    end;
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TForm_ContourGraph.SetPolygenProperty(OneStep:TOldOneStep;CeatePoint:Boolean;
     Apol:TTeePolygon;Tran:Boolean; MC:TColor;LineW,SaveOrFx:integer);
{
  SaveOrFx =0 �Ǵ���ͼ������������� ����  ��  ModifyData=1  5  6
  SaveOrFx =1 �Ǵ����ݿ��е������Ĳ���   ����Ԥ�������   ��  ModifyData=4  3

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
        ContourPop_RightTool.Caption :='�ر��Ҳ๤����';
        RightPageControl.Visible :=true;

    end else  begin
        ContourPop_RightTool.Caption :='���Ҳ๤����';
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
    SetOldStepVisible(true);// Ĭ����ʾ��ѹ����
    // У����ѯ����
    DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,true,100,100);
    if DrawGzm.GetMyCoutOurColorUpToValue (DrawGzm.MyContourColor_NumLevel,
                      DrawGzm.FGzm.RockPressAnalysis.Min_Pt ,
                      DrawGzm.FGzm.RockPressAnalysis.NearColorLineUp_DownValue
                      )=-1 then    Exit;
    //��ϵͳ�����ͽ� Auto_Judge_OldStep ����
     DrawGzm.Auto_Judge_OldStep.SetMaxFootage(DrawGzm.DataTimeAndFootAge.MaxFootage);
     DrawGzm.Auto_Judge_OldStep.SetMax_Min_Jindao(DrawGzm.DataTimeAndFootAge.Graph_MinDao,
                                                  DrawGzm.DataTimeAndFootAge.Graph_MaxDao
                                                  );
     DrawGzm.Auto_Judge_OldStep.SetMax_Supportbh(DrawGzm.FGzm.SupEndNumber);

      {�������ݷ�������}
     DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);


     // ��������Сֵ������ص�Ȧ��     //�ѱ߽����ݱ�����
     DrawGzm.SaveExtractDataFormSeries_SideData(ContourChart,ContSeries,
                 FirstPGBar,SecondPGBar,DrawGzm.FGzm.Usedsupport.initLoad);

     // �������߸���ֵ
     if AutoOrManual then   begin
         LevelLineValue:= 55;
     end else  begin
         LevelLineValue:= DrawGzm.FGzm.RockPressAnalysis.Min_Pt;
     end;

     RaiseOrDrop:=False;//��������
     StepAreaRatio:=-1;  RaiseCount:=0;
     //�ӿ������ͼ����ȡѹ������
     SetKrigcontour(true);
     Repeat
          DrawGzm.Auto_Judge_OldStep.ClearSteps ;
          if not DrawGzm.CloudClass.RecallMidDaoSaveStep  then  begin    // ��������¼���
               //�����ݿ�����ȡ ������ͼ����
               {2018�� �� �Ż�����ϵͳ��ͼ������}
               // �������� ��ȡ �Ѿ� ����õĵ���ѹ���� ����
               DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);
               DrawGzm.ReadContoueSeriesToClass(DrawGzm.Auto_Judge_OldStep,4);
          end;
         // ��ȡ���ݽ���
         DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);

         DrawGzm.ExtractDataFormSeries(ContourChart,KrigContour,FirstPGBar,SecondPGBar,LevelLineValue);
         // ��ѹ�����޽��и�ֵ
         DrawGzm.Auto_Judge_OldStep.SetJudgeLevelLineDat(LevelLineValue);
         // ����������
         DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);
         DrawGzm.Auto_Judge_OldStep.Sort;
         // ������ˢ��    ��Ҫ������ʵ������ĺϲ�
         DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);
         DrawGzm.Auto_Judge_OldStep.Refresh;


         if AutoOrManual then  begin  // ������Զ�����
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
         end else begin // ��������ֶ�����
             break;
         end;

     Until ( false ) ;

     // ��������ʾ��ͼ�ķ����ڸĻ���
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
   OptionTip(1,'���ݱ���ɹ�!');
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
     // �� ��������ͼ�Ľ���
    CreateLineGraph(ExHandle,'',0,0,0);
    DrawGzm.GraphClass.CycleDataEfficient:=True;//��������ͼ�д�������
    Form_LineGraph.SetOpenFormVar(DrawGzm,
                                  '',
                                  true,
                                  true// �Ƿ�򿪹��߲˵�
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
    //ˢ�����ͼ��
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);

end;

procedure TForm_ContourGraph.But_Kyfx_ReportClick(Sender: TObject);
var
 t_s:widestring;
 thd:TReportWordThread;
begin
    t_s:='��ӡ������ͨ������ϵͳOFFICE��ʵ�����'+#13#10 +
         '����OFFICE ��ķ�һ���ʱ�䣬��ȷ��ô?';
    if Application.MessageBox(Pwidechar(t_s),'�ر���ʾ',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;


   But_Kyfx_Report.Enabled :=False;

   OptionTip(1,'���������ļ������ĵȴ�');
//   ShowScreen:=2; // ϵͳ���ڽ��е���
//   // �˴�Ϊ���߳�ʱ�ա�
//   thd:=TReportWordThread.Create(true);
//   thd.OnAccumulated:=self.OnAccumulated; // Self ָ�� FrmMain.
//   thd.iDrawGzm:=DrawGzm;
//   thd.iCallPStope:=self.CallPStope ;
//   thd.iKYGE_Report:=KYGE_Report;
//   thd.EiHandle:=ExHandle;
//   thd.Start; //�����߳�,���߳�ʱ����ִ�� Execute �еĴ��롣

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
               '��ѹ��������������ϲ�¼����',Width,Height);
end;

procedure TForm_ContourGraph.TreePop_CloseClick(Sender: TObject);
begin
   SetRightToolVisible(FALSE);
end;

procedure TForm_ContourGraph.TreePop_DeleteAllClick(Sender: TObject);
var
  t_s:string;
begin
   t_s:='��ȷ��Ҫɾ�����ݿ�����������ô?';
   if Application.MessageBox(Pwidechar(t_s),'��ʾ',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

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
       OptionTip(1,'���ݱ���ɹ�!');
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
        //���ı༭״̬
    //  DrawGzm.EditMapPoint:=EditMapSeriesSteps(APolid,Stepid);
    end else begin
        SetPolygenProperty( DrawGzm.Auto_Judge_OldStep.ExSteps[0],false,
                   MapSeries.Shapes[i],
                   Vis,
                   DrawGzm.FGzm.RockPressAnalysis.StepFillColor,
                   DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide,1);
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