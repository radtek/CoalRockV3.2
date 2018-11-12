unit RockPresstool;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.ComCtrls, Vcl.Buttons
  ,UMainDataModule,uDrawGraphClass,UForm_ContourGraph, System.ImageList,
  Vcl.ImgList, Vcl.ToolWin,gifimg, Vcl.Imaging.pngimage
  ;

type
  TFormPressTool = class(TForm)
    MainPage: TPageControl;
    Tab_Main_YunTu: TTabSheet;
    Tab_Main_PressAnlysis: TTabSheet;
    SecondPage_0: TPageControl;
    Tab_SelectJinDao: TTabSheet;
    GroupBox10: TGroupBox;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Edit_StartDao: TEdit;
    Edit_EndDao: TEdit;
    GB_DateTime: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    StartDateTime: TDateTimePicker;
    StartEdit: TEdit;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    EndDateTime: TDateTimePicker;
    EndEdit: TEdit;
    BitBtn4: TBitBtn;
    BitBtn2: TBitBtn;
    RG_DaoOrFootage: TRadioGroup;
    Tab_Yuntu: TTabSheet;
    GB_Contour_Color: TGroupBox;
    Label19: TLabel;
    CB_Box_ColorGroup: TComboBox;
    StringGridColorGroup: TStringGrid;
    Tab_Axis: TTabSheet;
    RG_Yun_Cycle: TRadioGroup;
    RadioGroup_DownFootage: TRadioGroup;
    RadioGroup_UpperFootage: TRadioGroup;
    GB_ContourAxis: TGroupBox;
    Lab_Axis: TLabel;
    Label38: TLabel;
    RG_XAxis: TRadioGroup;
    Edit_Axis: TEdit;
    Tab_Main_LineGraph: TTabSheet;
    StatusBar1: TStatusBar;
    secondPage_1: TPageControl;
    Tab_Phase: TTabSheet;
    GroupBox11: TGroupBox;
    Label37: TLabel;
    CB_PhaseNumber: TComboBox;
    StringGridPhase: TStringGrid;
    Tab_ComeStep: TTabSheet;
    Tab_ComeDisp: TTabSheet;
    GB_KY_Basic: TGroupBox;
    GB_KY_Detal: TGroupBox;
    Label20: TLabel;
    Edit_StartPt: TEdit;
    Lab_Unit1: TLabel;
    Label21: TLabel;
    Edit_EndPt: TEdit;
    Lab_Unit2: TLabel;
    Label22: TLabel;
    ComboBox_KY_Lmd: TComboBox;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label36: TLabel;
    Edit_MinQd: TEdit;
    Edit_Min_Pt: TEdit;
    Edit_Foot_Con: TEdit;
    Edit_Sup_Con: TEdit;
    Label28: TLabel;
    Label23: TLabel;
    Lab_Unit3: TLabel;
    RG_Option_DispSave_MidDao: TRadioGroup;
    RG_Option_SaveEdit: TRadioGroup;
    RG_Option_DispProDao: TRadioGroup;
    RG_Option_Forcase: TRadioGroup;
    RG_Step_Fill: TRadioGroup;
    RG_Step_Ground_Fill: TRadioGroup;
    GroupBox2: TGroupBox;
    Label_FillColor: TLabel;
    StepColorBox: TColorBox;
    Label31: TLabel;
    Edit_Fill_Line_Wide: TEdit;
    Label27: TLabel;
    SelectedColorBox: TColorBox;
    Label29: TLabel;
    Edit_Step_TranC: TEdit;
    RG_Print_Option: TRadioGroup;
    RG_Print_Disp: TRadioGroup;
    ColorDialog1: TColorDialog;
    Cancle_Button: TButton;
    But_Application: TButton;
    Tab_Wait: TTabSheet;
    WaitLabel: TLabel;
    RG_YunColorType: TRadioGroup;
    SecondPage_2: TPageControl;
    Tab_SupSelect: TTabSheet;
    Tab_SupDisp: TTabSheet;
    GroupBox1: TGroupBox;
    CheckListBox_Support: TCheckListBox;
    RG_LineGraph_Axis: TRadioGroup;
    GroupBox4: TGroupBox;
    CheckListBox_LineGraph_DataType: TCheckListBox;
    ToolBar2: TToolBar;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    RG_LineGraph_LineType: TRadioGroup;
    RG_LineGraph_PenWide: TRadioGroup;
    RG_LineGraph_ColorType: TRadioGroup;
    Button2: TButton;
    RG_SCroll_PageSize: TRadioGroup;
    Image1: TImage;
    Tab_SupBar: TTabSheet;
    RG_Bar_DispData: TRadioGroup;
    RG_Bar_B_D: TRadioGroup;
    RG_Bar_Marks: TRadioGroup;
    GroupBox3: TGroupBox;
    Memo1: TMemo;
    Label1: TLabel;
    Label3: TLabel;
    Edit_Sup_Lz_Count: TEdit;
    Edit_Sup_LZ_Dim: TEdit;
    procedure Edit_StartDaoKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_EndDaoKeyPress(Sender: TObject; var Key: Char);
    procedure StartEditKeyPress(Sender: TObject; var Key: Char);
    procedure EndEditKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_AxisKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_AxisClick(Sender: TObject);
    procedure Edit_StartDaoClick(Sender: TObject);
    procedure Edit_EndDaoClick(Sender: TObject);
    procedure StartEditClick(Sender: TObject);
    procedure EndEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit_StartPtKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_EndPtKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_Min_PtKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_MinQdKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_Fill_Line_WideKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_Step_TranCKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_Sup_ConKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_Foot_ConKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_StartPtClick(Sender: TObject);
    procedure Edit_EndPtClick(Sender: TObject);
    procedure Edit_Sup_ConClick(Sender: TObject);
    procedure Edit_Foot_ConClick(Sender: TObject);
    procedure Edit_Min_PtClick(Sender: TObject);
    procedure Edit_MinQdClick(Sender: TObject);
    procedure Edit_Fill_Line_WideClick(Sender: TObject);
    procedure Edit_Step_TranCClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Edit_StartDaoExit(Sender: TObject);
    procedure Edit_EndDaoExit(Sender: TObject);
    procedure RG_XAxisClick(Sender: TObject);
    procedure RG_Step_FillClick(Sender: TObject);
    procedure StringGridColorGroupDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure CB_Box_ColorGroupChange(Sender: TObject);
    procedure CB_PhaseNumberChange(Sender: TObject);
    procedure ComboBox_KY_LmdChange(Sender: TObject);
    procedure StringGridColorGroupSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure SecondPage_0DrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure MainPageDrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
    procedure Cancle_ButtonClick(Sender: TObject);
    procedure RG_DaoOrFootageClick(Sender: TObject);
    procedure But_ApplicationClick(Sender: TObject);
    procedure CheckListBox_SupportClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure RG_LineGraph_AxisClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Memo1Click(Sender: TObject);
    procedure Edit_Sup_Lz_CountClick(Sender: TObject);
    procedure Edit_Sup_LZ_DimClick(Sender: TObject);
  private
    { Private declarations }
     MySqlDataSet1:TMyDataSet;
     DrawToolGzm:TDrawGrap;
     StringGroupColor:String;
     RockPressJinDao,UpdatedYuntu:Boolean;
     ReturnFlag:integer;
     ReCallData:Boolean;
     ApplicData:Boolean;// 数据是否使用
     SupportCheckList:TStringList;
     AutoOption:boolean;
     //
     procedure EditSetFoces(Ed:Tedit);

     function SelectRockPressDataNumber(DataType:integer):Boolean;
     procedure OptionTip(index:integer;Str:String);
     // refresh
     procedure GetDataClass;
     procedure SetDrawToolGZMValue;
     function  MakecheckListBoxsuppotString:String;
     function  SplitcheckListBoxsuppotString(Value:String):integer;
     procedure selectCheckListBoxSupport(Value:string);  // 系统自动选择支架
     function SplitOutInputSupportList(Value:string):Boolean;// 自动拆分外部传过来的支架
     function  GetTimeAndFootage:Boolean; // 获取开始时间与进尺的 选择结果
     //---
     procedure JinDaoSelectJinChi(value:integer);
     //
     //----------------
    procedure InitStringGridGroupColor;//初始化颜色分组表格
    procedure InitStringGridPhase;//初始化颜色分组表格
    function  isExsitRockPressFile(SupportBh:Integer):Boolean;// 判断文件是否存在
    procedure InitSupportGraphCheck;// 初始化支架曲线选项
    function  ZoomRect(mRect: TRect; mZoom: Integer): TRect;// 绘制表格线
    //-------
    procedure ChangePressDataUnit(Flag:integer);  // 更改数据单位
    function  SetAnalysisSenstive(Index:integer):Boolean;//通过选择灵敏度来改变判定数值
    procedure GetMyContourGroupColor(NumLevel:integer);
    procedure FillStringGridColorGroup(NumLevel:integer);
    procedure FillStringGridPhase(Number:integer);
    procedure SplitWorkFaceColorString;
    procedure SplitWorkFaceMemo1Text;
    procedure SplitWorkFaceMemo2Text;
    procedure SaveWorkFaceColorString ;
    procedure SaveWorkFaceMemo2Text(lx:String) ; // 应用或者保存
    procedure splitStringGroupColor;
    procedure SplitStringGridPhase;
    function  MakeStringGroupColorToString:String;
    function  MakeStringGridPhaseToString:String;
    procedure DisPoseContourGroupColor;
    //
    procedure SetWaitLabel(Value:Boolean);
    // 显示控制页面
    function CreateBasicValue(Value:integer):Boolean;
    function SetMainPageVisible(Value:integer):integer;
    procedure ReturnClassAndColse(Value:integer);
    //

  public
    { Public declarations }
     procedure SetDrawClass(iDW:TDrawGrap);
     procedure InitForm;
     procedure CloseFormRetrunValue;
     procedure RecallDataSet;
  end;

  function CreateRockPressTool(AHandle:THandle;ACaption:string;Wid,Hi,Flag:integer):THandle;stdcall;
var
  FormPressTool: TFormPressTool;

implementation

{$R *.dfm}

uses Lu_Public_BasicModual, UForm_LineGraph, UForm_Brand_Bar, UFormWait;

//===========================
 function CreateRockPressTool(AHandle:THandle;ACaption:string;Wid,Hi,Flag:integer):THandle;stdcall;
 begin
      if Assigned(FormPressTool) then  FreeAndNil(FormPressTool);
        Application.Handle :=AHandle;
        FormPressTool:=TFormPressTool.Create(Application);

         try
           with FormPressTool do begin
               CreateBasicValue(Flag);

               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/4)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

               Show;
               SetFocus;
               ReturnFlag:=SetMainPageVisible(Flag);
               Result:=FormPressTool.Handle ;//函数值
          end ;
        except
           FreeAndNil(FormPressTool);
        end;
 end;

//================================  TFormPressTool

procedure TFormPressTool.BitBtn1Click(Sender: TObject);
begin
    StartEdit.Text:=FormatFloat('0.00',DrawToolGzm.DatetimeToFootage(StartDateTime.DateTime,'Null') );
    RockPressJinDao:=true;
end;

procedure TFormPressTool.BitBtn2Click(Sender: TObject);
begin
    if length(trim(EndEdit.Text )) <1 then  exit;
     EndDateTime.DateTime := DrawToolGzm.FootageToDatetime(Public_Basic.StrTodouble_lu(EndEdit.Text),'NUll');
     RockPressJinDao:=true;
end;

procedure TFormPressTool.BitBtn3Click(Sender: TObject);
begin
   if length(trim(StartEdit.Text )) <1 then  exit;
     startDateTime.DateTime := DrawToolGzm.FootageToDatetime(Public_Basic.StrTodouble_lu(StartEdit.Text),'NUll');
   RockPressJinDao:=true;
end;

procedure TFormPressTool.BitBtn4Click(Sender: TObject);
begin
   EndEdit.Text:=FormatFloat('0.00',DrawToolGzm.DatetimeToFootage(EndDateTime.DateTime ,'NUll' ));
   RockPressJinDao:=true;
end;

procedure TFormPressTool.Cancle_ButtonClick(Sender: TObject);
begin
   Close;
end;

procedure TFormPressTool.Button2Click(Sender: TObject);
begin
    ApplicData:=true;
    Close;
end;

procedure TFormPressTool.But_ApplicationClick(Sender: TObject);
begin
    GetTimeAndFootage;
    GetDataClass;
    // 保存 矿压分析设置 包括阶段数据
    SaveWorkFaceMemo2Text('save');
    // 保存 颜色数据
    SaveWorkFaceColorString;
    splitStringGroupColor;
    //刷新云图页面

    ReturnClassAndColse(ReturnFlag);
    UpdatedYuntu:=true;
end;

procedure TFormPressTool.CB_Box_ColorGroupChange(Sender: TObject);
begin
   FillStringGridColorGroup(CB_Box_ColorGroup.ItemIndex+3);
   StringGridColorGroup.Repaint;
end;

procedure TFormPressTool.CB_PhaseNumberChange(Sender: TObject);
begin
   FillStringGridPhase(3+2*CB_PhaseNumber.ItemIndex );
   StringGridPhase.Repaint;
end;

procedure TFormPressTool.ChangePressDataUnit(Flag: integer);
begin
  if Flag=1 then   begin
     Lab_Unit1.Caption :='MPa';
     Lab_Unit2.Caption :='MPa';
     Lab_Unit3.Caption :='MPa';
  end else begin
     Lab_Unit1.Caption :='Bar';
     Lab_Unit2.Caption :='Bar';
     Lab_Unit3.Caption :='Bar';
  end;
end;

procedure TFormPressTool.CheckListBox_SupportClick(Sender: TObject);
begin
    Memo1.Clear;
    Memo1.Lines.Add(MakecheckListBoxsuppotString);
end;

procedure TFormPressTool.CloseFormRetrunValue;
begin
    if not UpdatedYuntu then  begin
        GetTimeAndFootage;
        GetDataClass;
        // 保存 矿压分析设置 包括阶段数据
        SaveWorkFaceMemo2Text('save');
        // 保存 颜色数据
        SaveWorkFaceColorString;
        // 分解颜色字符串
        splitStringGroupColor;
         // 控制显示界面
        UpdatedYuntu:=False;

        if not AutoOption then      // 如果是自动的 系统进行处理
           ReturnClassAndColse(ReturnFlag);
    end;
end;

procedure TFormPressTool.ComboBox_KY_LmdChange(Sender: TObject);
begin
    SetAnalysisSenstive(ComboBox_KY_Lmd.ItemIndex);
end;

function TFormPressTool.CreateBasicValue(Value: integer): Boolean;
 {
    Value 1 意思是 是绘制压力云图页面打开它
    Value 2 意思是 是绘制曲线图的页面打开它
 }
begin
    Result:=true;
    if Value=1 then    begin
       DrawToolGzm:=Form_ContourGraph.DrawGzm;
       But_Application.Enabled:=Form_ContourGraph.GetLoadDate ;
       ReCallData:=Form_ContourGraph.GetLoadDate;
    end else  if Value=2 then    begin
       DrawToolGzm:=Form_LineGraph.Main_Line_DrawClass;
       But_Application.Enabled:=true ;
       ReCallData:=Form_LineGraph.GetReCallFrom;
    end  else if Value=3 then    begin
       DrawToolGzm:=Form_ContourGraph.DrawGzm;
       But_Application.Enabled:=Form_ContourGraph.GetLoadDate ;
       ReCallData:=Form_ContourGraph.GetLoadDate;
    end;

end;

procedure TFormPressTool.DisPoseContourGroupColor;
begin
 {处理应力云图的颜色管理}
     if StringGroupColor<>'' then  begin
         {分解字符串}
         splitStringGroupColor;
      end else begin
         // 默认颜色为六种颜色
          DrawToolGzm.YunColorType :=0; //等距离设置
          DrawToolGzm.MyContourColor_NumLevel:=6;
      end;
      RG_YunColorType.ItemIndex := DrawToolGzm.YunColorType;
      if DrawToolGzm.MyContourColor_NumLevel>=3 then
         CB_Box_ColorGroup.ItemIndex := DrawToolGzm.MyContourColor_NumLevel-3;
           {填充}
      FillStringGridColorGroup(DrawToolGzm.MyContourColor_NumLevel);
end;

procedure TFormPressTool.EditSetFoces(Ed: Tedit);
begin
    Ed.SetFocus;
end;

procedure TFormPressTool.Edit_AxisClick(Sender: TObject);
begin
   EditSetFoces(Edit_Axis);
end;

procedure TFormPressTool.Edit_AxisKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9',#8]) then key:=#0  ;
end;

procedure TFormPressTool.Edit_EndDaoClick(Sender: TObject);
begin
     EditSetFoces(Edit_EndDao);
end;

procedure TFormPressTool.Edit_EndDaoExit(Sender: TObject);
begin
   JinDaoSelectJinChi(1);
end;

procedure TFormPressTool.Edit_EndDaoKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9',#8]) then key:=#0  ;
end;

procedure TFormPressTool.Edit_EndPtClick(Sender: TObject);
begin
      EditSetFoces(Edit_EndPt);
end;

procedure TFormPressTool.Edit_EndPtKeyPress(Sender: TObject; var Key: Char);
begin
      if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TFormPressTool.Edit_Fill_Line_WideClick(Sender: TObject);
begin
    EditSetFoces(Edit_Fill_Line_Wide);
end;

procedure TFormPressTool.Edit_Fill_Line_WideKeyPress(Sender: TObject;
  var Key: Char);
begin
     if not (key in ['0'..'9',#8]) then key:=#0  ;
end;

procedure TFormPressTool.Edit_Foot_ConClick(Sender: TObject);
begin
     EditSetFoces(Edit_Foot_Con);
end;

procedure TFormPressTool.Edit_Foot_ConKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9',#8]) then key:=#0  ;
end;

procedure TFormPressTool.Edit_MinQdClick(Sender: TObject);
begin
     EditSetFoces(Edit_MinQd);
end;

procedure TFormPressTool.Edit_MinQdKeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TFormPressTool.Edit_Min_PtClick(Sender: TObject);
begin
    EditSetFoces(Edit_Min_Pt);
end;

procedure TFormPressTool.Edit_Min_PtKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TFormPressTool.Edit_StartDaoClick(Sender: TObject);
begin
   EditSetFoces(Edit_StartDao);
end;

procedure TFormPressTool.Edit_StartDaoExit(Sender: TObject);
begin
    JinDaoSelectJinChi(0);
end;

procedure TFormPressTool.Edit_StartDaoKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9',#8]) then key:=#0  ;
end;

procedure TFormPressTool.Edit_StartPtClick(Sender: TObject);
begin
    EditSetFoces(Edit_StartPt);
end;

procedure TFormPressTool.Edit_StartPtKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TFormPressTool.Edit_Step_TranCClick(Sender: TObject);
begin
     EditSetFoces(Edit_Step_TranC);
end;

procedure TFormPressTool.Edit_Step_TranCKeyPress(Sender: TObject;
  var Key: Char);
begin
     if not (key in ['0'..'9',#8]) then key:=#0  ;
end;

procedure TFormPressTool.Edit_Sup_ConClick(Sender: TObject);
begin
    EditSetFoces(Edit_Sup_Con);
end;

procedure TFormPressTool.Edit_Sup_ConKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9',#8]) then key:=#0  ;
end;

procedure TFormPressTool.Edit_Sup_Lz_CountClick(Sender: TObject);
begin
   Edit_Sup_Lz_Count.SetFocus;
end;

procedure TFormPressTool.Edit_Sup_LZ_DimClick(Sender: TObject);
begin
   Edit_Sup_LZ_Dim.SetFocus;
end;

procedure TFormPressTool.EndEditClick(Sender: TObject);
begin
     EditSetFoces(EndEdit);
end;

procedure TFormPressTool.EndEditKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TFormPressTool.FillStringGridColorGroup(NumLevel: integer);
var
  i:integer;
  UpValue:Integer;
  PerValue:integer;
begin
    InitStringGridGroupColor;
    PerValue:=0;
    if (StringGroupColor='') or (NumLevel <> DrawToolGzm.MyContourColor_NumLevel ) then  begin
       DrawToolGzm.YunColorType :=RG_YunColorType.ItemIndex;
       DrawToolGzm.MyContourColor_NumLevel:=NumLevel;
       GetMyContourGroupColor(NumLevel);
    end else begin
       splitStringGroupColor;// 剖切字符串
    end;

    //填充到grid
    for I := 1 to DrawToolGzm.MyContourColor_NumLevel do   begin
         if DrawToolGzm.ColorValue.UnitType=1 then begin
             UpValue:=DrawToolGzm.MyContourColor[i-1].UpToValue ;
         end else begin
             UpValue:=DrawToolGzm.MyContourColor[i-1].UpToValue*10 ;
         end;

        if i<=10 then  begin
           StringGridColorGroup.Cells[0,i]:=IntTostr(i);
           StringGridColorGroup.Cells[1,i]:=IntTostr(PerValue+1);
           StringGridColorGroup.Cells[2,i]:=IntTostr(UpValue);
        end;
        PerValue:=UpValue;
    end;

end;

procedure TFormPressTool.FillStringGridPhase(Number: integer);
var
  i:integer;
begin
    InitStringGridPhase;
    if (DrawToolGzm.FGzm.RockPressAnalysis.OldStepPhaseString = '' ) or
       ( DrawToolGzm.Auto_Judge_OldStep.PhaseNumber<> Number )then  begin
         DrawToolGzm.Auto_Judge_OldStep.InitPhaseSteps(Number,DrawToolGzm.FGzm);
    end;

    //填充到grid
    for I := 0 to DrawToolGzm.Auto_Judge_OldStep.PhaseNumber -1 do   begin

        if i<=7 then  begin
           StringGridPhase.Cells[0,i+1]:=IntTostr(i+1);
           StringGridPhase.Cells[1,i+1]:=IntTostr(DrawToolGzm.Auto_Judge_OldStep.PhaseSteps[i].StartsupBh);
           StringGridPhase.Cells[2,i+1]:=IntTostr(DrawToolGzm.Auto_Judge_OldStep.PhaseSteps[i].EndSupBh);
        end;
    end;

end;

procedure TFormPressTool.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if not  ApplicData then
       CloseFormRetrunValue;
   if Assigned(FormPressTool) then  FreeAndNil(FormPressTool);
end;

procedure TFormPressTool.FormCreate(Sender: TObject);
begin
    Public_basic.InitStatusBar(StatusBar1);
    MySqlDataSet1:=TMyDataSet.Create(nil);
    MySqlDataSet1.MySqlConnection :=MainDataModule.ExConn;
    SetWaitLabel(False);
    ApplicData:=False;
    SupportCheckList:=TStringList.Create ;

end;

procedure TFormPressTool.FormDestroy(Sender: TObject);
begin
   FreeAndNil(SupportCheckList);
   FreeAndNil(MySqlDataSet1);
end;

procedure TFormPressTool.FormShow(Sender: TObject);
begin
    InitForm;
end;

procedure TFormPressTool.GetDataClass;
var
 i:integer;
 Str:string;
begin
    //云图数据类型   手动录入数据
     DrawToolGzm.CloudClass .YUntu_DataClass:=ManualInput;
   // 数据类型选择
    if ord(DrawToolGzm.CloudClass .Yuntu_CycleData)<> RG_YUN_Cycle.ItemIndex then begin
          // 去改变变量 让重新 计算
         RecallDataSet;
    end;

    if RG_YUN_Cycle.ItemIndex=0 then  begin
        DrawToolGzm.CloudClass .Yuntu_CycleData :=MAX_CData;
        DrawToolGzm.CloudClass.Yuntu_Data_Name:='最大值';
    end else if RG_YUN_Cycle.ItemIndex=1 then  begin
        DrawToolGzm.CloudClass .Yuntu_CycleData :=AVG_CData;
        DrawToolGzm.CloudClass.Yuntu_Data_Name:='平均值';
    end else if RG_YUN_Cycle.ItemIndex =2 then begin
       DrawToolGzm.CloudClass .Yuntu_CycleData :=CCL_CData;
       DrawToolGzm.CloudClass.Yuntu_Data_Name:='初撑力';
    end else if RG_YUN_Cycle.ItemIndex =3 then begin
       DrawToolGzm.CloudClass .Yuntu_CycleData :=Mzl_CData;
       DrawToolGzm.CloudClass.Yuntu_Data_Name:='末阻力';
    end else if RG_YUN_Cycle.ItemIndex =4 then begin
       DrawToolGzm.CloudClass .Yuntu_CycleData :=Sametime_CData;
        DrawToolGzm.CloudClass.Yuntu_Data_Name:='同一时刻抓取值';
    end else begin
       DrawToolGzm.CloudClass .Yuntu_CycleData :=Manual_CData;
       DrawToolGzm.CloudClass. Yuntu_Data_Name:='手动录入值';
    end;
     //更换数据类
     DrawToolGzm.Auto_Judge_OldStep := DrawToolGzm.ChangeJudgeStepClass(DrawToolGzm.CloudClass .Yuntu_CycleData) ;
     //把外部传过来的参数修改为假
     DrawToolGzm.GraphClass.Out_input_Data:=False;
   // CheckListBox_Support
     DrawToolGzm.GraphClass.SupportList:=MakecheckListBoxsuppotString;
   // Line_Graph
     DrawToolGzm.GraphClass.YAxisType :=RG_LineGraph_Axis.ItemIndex ;

     for I := 0 to CheckListBox_LineGraph_DataType.Count-1 do
       DrawToolGzm.GraphClass.Disp_DataType[i]:=CheckListBox_LineGraph_DataType.Checked[i];

     DrawToolGzm.GraphClass.Line_Tpye:=RG_LineGraph_LineType.ItemIndex ;
     DrawToolGzm.GraphClass.Line_Width:=RG_LineGraph_PenWide.ItemIndex;
     DrawToolGzm.GraphClass.Line_Color:=RG_LineGraph_ColorType.ItemIndex;

  // RadidFootage_Upper Down
    DrawToolGzm.ConTourSeriesPar.Display_UpperFootage:=self.RadioGroup_UpperFootage.ItemIndex;
    DrawToolGzm.ConTourSeriesPar.Display_DownFootage:=self.RadioGroup_DownFootage.ItemIndex;
  //读取横坐标显示的设置方式
   if self.RG_XAxis.ItemIndex =0 then  begin
      DrawToolGzm.CloudClass.X_Axis_Disp_Type:=0;

   end else begin
      DrawToolGzm.CloudClass.X_Axis_Disp_Type:=1;
      DrawToolGzm.CloudClass.X_Axis_Disp_Dao :=Public_Basic.StrToInt_lu(Self.Edit_Axis.Text );
   end;
  //读取是否显示预测数据信息
  if self.RG_Option_ForCase.ItemIndex =0 then  begin
     DrawToolGzm.CloudClass.DisPlayForcase:=true;
  end else begin
     DrawToolGzm.CloudClass.DisPlayForcase:=false;
  end;
    //读取是否显示最小进刀之前的来压步距
  if self.RG_Option_DispProDao.ItemIndex =0 then  begin
     DrawToolGzm.CloudClass.DisPlayProMinDaoSaveStep:=true;
  end else begin
     DrawToolGzm.CloudClass.DisPlayProMinDaoSaveStep:=false;
  end;

     //读取是否进行重新分析  对于进刀之内的区域保存的数据
  if self.RG_Option_DispSave_MidDao.ItemIndex =0 then  begin
     DrawToolGzm.CloudClass.RecallMidDaoSaveStep:=true;
  end else begin
     DrawToolGzm.CloudClass.RecallMidDaoSaveStep:=false;
  end;
   // 获取数据库中最大与最小进刀数
   DrawToolGzm.ReturnDataBaseMin_MaxDao(DrawToolGzm.CloudClass.SaveDataMinDao,
                                    DrawToolGzm.CloudClass.SaveDataMaxDao );
   //获取存储的数据是显示区域云图还是显示来压步距
  if self.RG_Option_SaveEdit.ItemIndex =0 then  begin
     DrawToolGzm.CloudClass.SaveDate_Edit:=False;
  end else begin
     DrawToolGzm.CloudClass.SaveDate_Edit:=true;
  end;
     //获取进刀范围之外的来压信息是否输出
  if self.RG_Print_Option.ItemIndex =0 then  begin
     DrawToolGzm.CloudClass.PrintOutDaoStepInto:=true;
  end else begin
     DrawToolGzm.CloudClass.PrintOutDaoStepInto:=false;
  end;
       //获取矿压数据分段显示方式
  if self.RG_Print_Disp.ItemIndex =0 then  begin
     DrawToolGzm.CloudClass.PrintDispPhaseVisual:=true;
  end else begin
     DrawToolGzm.CloudClass.PrintDispPhaseVisual:=false;
  end;
  // 收集 page页
  DrawToolGzm.GraphClass.FisrtPageId :=MainPage.ActivePageIndex ;
  if DrawToolGzm.GraphClass.FisrtPageId=0 then  begin
     DrawToolGzm.GraphClass.SecondPageid :=secondPage_0.ActivePageIndex;
  end else if DrawToolGzm.GraphClass.FisrtPageId=1 then  begin
     DrawToolGzm.GraphClass.SecondPageid :=secondPage_1.ActivePageIndex;
  end else if DrawToolGzm.GraphClass.FisrtPageId=2 then  begin
     DrawToolGzm.GraphClass.SecondPageid :=secondPage_2.ActivePageIndex;
  end else begin
     DrawToolGzm.GraphClass.SecondPageid:=0;
  end;
  // 收集RG_Scroll_pageSizw
   DrawToolGzm.GraphClass.ScrollPageSize :=self.RG_SCroll_PageSize.ItemIndex;
  //收集BarSeries
   DrawToolGzm.BarMarks.Disp_0:=self.RG_Bar_DispData.ItemIndex ;
   DrawToolGzm.BarMarks.Disp_B_D:=self.RG_Bar_B_D.ItemIndex ;
   DrawToolGzm.BarMarks.Disp_Mark:=self.RG_Bar_Marks.ItemIndex ;
end;

procedure TFormPressTool.GetMyContourGroupColor(NumLevel: integer);
var
  i:integer;
begin
    if NumLevel >10 then  exit;
    for I := 0 to NumLevel-1 do  begin
       DrawToolGzm.MyContourColor[i].ContourColor:=DrawToolGzm.GetContourColor(DrawToolGzm.YunColorType ,NumLevel,
        i,DrawToolGzm.MyContourColor[i].UpToValue );
       DrawToolGzm.MyContourColor[i].xh :=i;
    end;

end;

function TFormPressTool.GetTimeAndFootage: Boolean;
var
  MaxDao,MInDao:integer;
begin
    Result:=False;

    //获得查询数据
    if RG_DaoOrFootage.ItemIndex =0 then  begin //以进刀为主进行查询
         maxDao:=Public_Basic.StrToInt_lu(Trim(Edit_EndDao.Text ));
         MinDao:=Public_Basic.StrToInt_lu(Trim(Edit_StartDao.Text ));
         if maxDao>0 then  DrawToolGzm.DataTimeAndFootAge.Graph_MaxDao:=MaxDao;
         if MinDao>=0 then  DrawToolGzm.DataTimeAndFootAge.Graph_MinDao:=MinDao;
         StartDateTime.DateTime :=DrawToolGzm.FGzm.ReturnDataTimeFromDao(DrawToolGzm.DataTimeAndFootAge.Graph_MinDao);
         EndDateTime.DateTime:= DrawToolGzm.FGzm.ReturnDataTimeFromDao(DrawToolGzm.DataTimeAndFootAge.Graph_MaxDao);
          {把进尺信息进行填充}
         StartEdit.Text:=FormatFloat('0.00',DrawToolGzm.DatetimeToFootage(StartDateTime.DateTime,'NUll' ) );
         EndEdit.Text:=FormatFloat('0.00',DrawToolGzm.DatetimeToFootage(EndDateTime.DateTime,'NUll' ) );

    end else begin    //以进尺为主进行查询
          if Public_Basic.StrTodouble_lu(EndEdit.Text)>0 then
           EndDateTime.DateTime := DrawToolGzm.FootageToDatetime(Public_Basic.StrTodouble_lu(EndEdit.Text),'NUll');

          if Public_Basic.StrTodouble_lu(StartEdit.Text)> 0 then
           startDateTime.DateTime := DrawToolGzm.FootageToDatetime(Public_Basic.StrTodouble_lu(StartEdit.Text),'NUll');
          DrawToolGzm.DataTimeAndFootAge.Graph_MaxDao:=DrawToolGzm.FGzm.ReturnDaoShuBasicTime(EndDateTime.DateTime);
          Edit_endDao.Text :=IntTostr(DrawToolGzm.DataTimeAndFootAge.Graph_MaxDao);
          DrawToolGzm.DataTimeAndFootAge.Graph_MinDao:=DrawToolGzm.FGzm.ReturnDaoShuBasicTime(startDateTime.DateTime);
          Edit_StartDao.Text :=IntTostr(DrawToolGzm.DataTimeAndFootAge.Graph_MinDao);
    end;

    DrawToolGzm.DataTimeAndFootAge.StartTime :=StartDateTime.DateTime ;
    DrawToolGzm.DataTimeAndFootAge.EndTime :=EndDateTime.DateTime ;
    DrawToolGzm.DataTimeAndFootAge.Minfootage :=Public_Basic.StrToDouble_lu(StartEdit.Text );
    DrawToolGzm.DataTimeAndFootAge.MaxFootage :=Public_Basic.StrToDouble_lu(EndEdit.Text );
    DrawToolGzm.DataTimeAndFootAge.UpperStartfootage:=DrawToolGzm.DatetimeToFootage(StartDateTime.DateTime,'Upper');
    DrawToolGzm.DataTimeAndFootAge.UpperEndfootage:=DrawToolGzm.DatetimeToFootage(EndDateTime.DateTime,'Upper');
    DrawToolGzm.DataTimeAndFootAge.DownStartfootage:=DrawToolGzm.DatetimeToFootage(StartDateTime.DateTime,'Down');
    DrawToolGzm.DataTimeAndFootAge.DownEndfootage:=DrawToolGzm.DatetimeToFootage(EndDateTime.DateTime,'Down');

    DrawToolGzm.DataTimeAndFootAge.TimeLength:= DrawToolGzm.DataTimeAndFootAge.EndTime
                              - DrawToolGzm.DataTimeAndFootAge.StartTime;
    if DrawToolGzm.DataTimeAndFootAge.TimeLength <1 then  begin
       DrawToolGzm.DataTimeAndFootAge.TimeLength:=1;
    end;
    // 步距预测天数
    DrawToolGzm.DataTimeAndFootAge.ForCaseDay :=20;
    DrawToolGzm.SelectDataBasic_DaoOrFootage:=RG_DaoOrFootage.ItemIndex;

    Result:=true;

end;



procedure TFormPressTool.InitForm;
var
 i:integer;
 str:string;
begin

    // 剖分字符串
    SplitWorkFaceMemo2Text;
    //初始化颜色管理
    DisPoseContourGroupColor;
    //初始化支架参数
    InitSupportGraphCheck;
    // 把 DrawToolGzm 中数据带回
    SetDrawToolGZMValue;
    {填充刀数}
    if not DrawToolGzm.GraphClass.Out_input_Data then   begin // 如果外部传来了支架参数
        if not ReCallData then  begin
            if DrawToolGzm.DataTimeAndFootAge.Graph_MaxDao =0 then
               DrawToolGzm.DataTimeAndFootAge.Graph_MaxDao:=DrawToolGzm.FGzm.ReturnMaxDao ;

            if DrawToolGzm.DataTimeAndFootAge.Graph_MinDao =0  then  begin
              if DrawToolGzm.DataTimeAndFootAge.Graph_MaxDao >120 then
                   DrawToolGzm.DataTimeAndFootAge.Graph_MinDao :=DrawToolGzm.DataTimeAndFootAge.Graph_MaxDao -120
              else   DrawToolGzm.DataTimeAndFootAge.Graph_MinDao :=1;
            end;
            {Todo  便于测试}
//             DrawToolGzm.DataTimeAndFootAge.Graph_MinDao :=1;
//             DrawToolGzm.DataTimeAndFootAge.Graph_MaxDao :=40;
        end;
    end;

    Edit_endDao.Text :=IntTostr(DrawToolGzm.DataTimeAndFootAge.Graph_MaxDao);
    Edit_StartDao.Text :=IntTostr(DrawToolGzm.DataTimeAndFootAge.Graph_MinDao);
    // 把进尺数据填充了
    JinDaoSelectJinChi(0); // 开始进刀
    JinDaoSelectJinChi(1); // 结束进刀

    //初始化曲线图 部分列表
    if DrawToolGzm.FGzm.Gzmbh <1  then  exit;

    if not DrawToolGzm.FGzm.InputGzmData(DrawToolGzm.FGzm.Gzmbh)  then  begin
          OptionTip(0,'工作面初始化错误，请仔细检查!');
          self.Enabled:=false;
          exit;
    end;
   //初始化云图的颜色类
    DrawToolGzm.ColorValue.MinValue :=2;
    DrawToolGzm.ColorValue.MaxValue:=Round(DrawToolGzm.FGzm.Usedsupport.EndOpenLoad);
    //初步定义遍历间隔
    DrawToolGzm.ThreeDimCloud.Support_interval:=5;// 支架以 1架的间隔 遍历
    DrawToolGzm.ThreeDimCloud.Time_InterVal :=0.5;//时间以半天的间隔遍历
   //  通过数据库内容确定 数据类型显示
    if not SelectRockPressDataNumber(1) then begin    // 看自动抽取的数据是否有
        RG_Yun_Cycle.ItemIndex :=5;
    end;

    // 改变数据单位
    ChangePressDataUnit(DrawToolGzm.ColorValue.UnitType);
    // 刷新Memo
    Memo1.Clear ;
    Memo1.Lines.Add(MakecheckListBoxsuppotString);

    RockPressJinDao:=False;
    UpdatedYuntu:=False;
    AutoOption:=False;
end;

procedure TFormPressTool.InitStringGridGroupColor;
var
   i:integer;
begin
    StringGridColorGroup.ColCount :=5;
    StringGridColorGroup.RowCount :=12;

    for i := 0 to  StringGridColorGroup.RowCount - 1 do begin
          StringGridColorGroup.Rows[i].Clear ;
          StringGridColorGroup.RowHeights[i]:=20;
    end;
      
      StringGridColorGroup.Font.Size:=8;
      StringGridColorGroup.FixedRows :=1;

      StringGridColorGroup.Cells [0,0]:='序号';

          StringGridColorGroup.ColWidths[0]:=40;

      StringGridColorGroup.Cells [1,0]:='下限';
      StringGridColorGroup.Cells [2,0]:='上限';
      StringGridColorGroup.ColWidths[1]:=80;
      StringGridColorGroup.ColWidths[2]:=80;


      StringGridColorGroup.Cells [3,0]:='颜色';
        StringGridColorGroup.ColWidths[3]:=100;
       StringGridColorGroup.ColWidths[4]:=30;
end;

procedure TFormPressTool.InitStringGridPhase;
var
   i:integer;
begin
     StringGridPhase.ColCount :=5;
     StringGridPhase.RowCount :=9;
    for i := 0 to  StringGridPhase.RowCount - 1 do begin
          StringGridPhase.Rows[i].Clear ;
          StringGridPhase.RowHeights[i]:=20;
    end;
     
      StringGridPhase.Font.Size:=8;
      StringGridPhase.FixedRows :=1;

      StringGridPhase.Cells [0,0]:='区域';
          StringGridPhase.ColWidths[0]:=50;
      StringGridPhase.Cells [1,0]:='起支架';
          StringGridPhase.ColWidths[1]:=150;

      StringGridPhase.Cells [2,0]:='止支架';
          StringGridPhase.ColWidths[2]:=150;
      StringGridPhase.ColWidths[3]:=80;
end;

procedure TFormPressTool.InitSupportGraphCheck;
var
  Suptem:integer;
  str:String;
begin

   { 初始化leftPanel 曲线图形的 部分选项}
     CheckListBox_Support.Items.Clear ;
     SupportCheckList.Clear ;
     Suptem:=1;
     while Suptem <= DrawToolGzm.FGzm.SupEndUsedNumber do begin
        if  isExsitRockPressFile(Suptem) then begin
            str:='第['+IntToStr(Suptem)+']架';
            CheckListBox_Support.Items.Add(str) ;
            SupportCheckList.Add(IntToStr(Suptem));
        end;
        inc(Suptem);
     end;


end;

function TFormPressTool.isExsitRockPressFile(SupportBh: Integer): Boolean;
var
  fileName,textString:Ansistring;
  DirName:Ansistring;
  Dll_Path:AnsiString;
  tmp_Data:TdateTime;
begin
   Result:=False;
     if DrawToolGzm.FGzm.Gzmbh  <0 then exit;
     if SupportBh<0 then   exit;

     Dll_Path:=Public_Basic.Get_MyModulePath;
     DirName:=DLL_path+'\InputData\WorkDace_'+IntTostr(DrawToolGzm.FGzm.Gzmbh)+'\';

     fileName:=IntToStr(SupportBh) +'.Out';
     fileName:=DirName+fileName;
     if not(FileExists(fileName)) then exit;
   Result:=True;

end;

procedure TFormPressTool.JinDaoSelectJinChi(value: integer);
var
  maxD,MinD:integer;
begin
   if Value=0  then  begin//  开始
         MinD:=Public_Basic.StrToInt_lu(Trim(Edit_StartDao.Text ));

         if MinD>=0 then  DrawToolGzm.DataTimeAndFootAge.Graph_MinDao:=MinD;
          StartDateTime.DateTime :=DrawToolGzm.FGzm.ReturnDataTimeFromDao(DrawToolGzm.DataTimeAndFootAge.Graph_MinDao);
          {把进尺信息进行填充}
          StartEdit.Text:=FormatFloat('0.00',DrawToolGzm.DatetimeToFootage(StartDateTime.DateTime,'NUll' ) );

   end else begin  // 结束
         maxD:=Public_Basic.StrToInt_lu(Trim(Edit_EndDao.Text ));

         if maxD>0 then  DrawToolGzm.DataTimeAndFootAge.Graph_MaxDao:=MaxD;
          EndDateTime.DateTime:= DrawToolGzm.FGzm.ReturnDataTimeFromDao(DrawToolGzm.DataTimeAndFootAge.Graph_MaxDao);
          {把进尺信息进行填充}
          EndEdit.Text:=FormatFloat('0.00',DrawToolGzm.DatetimeToFootage(EndDateTime.DateTime,'NUll' ) );
   end;

   RockPressJinDao:=true;

end;

procedure TFormPressTool.MainPageDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
   if Active then
    begin
        Control.Canvas.Brush.Color := ClHighLight;
        Control.Canvas.Font.Color := clWhite;
    end;
    Control.Canvas.FillRect(Rect);
    Control.Canvas.TextOut(Rect.Left + 4,Rect.Top + 4,MainPage.Pages[TabIndex].Caption);
end;

function TFormPressTool.MakecheckListBoxsuppotString: String;
var
  str_t:string;
  i,j,Count_N:integer;
  inv_sup:double;
begin
   str_t:='';
   Count_N:=0;
   for I := 0  to CheckListBox_Support.Count -1 do
       if CheckListBox_Support.Checked[i]  then begin
         inc(Count_N);
         if Count_N > 12 then   begin
            Memo1.Lines.Add('系统一次只能制作12个支架的曲线！超过部分，不绘制');
            break;
         end;
         str_t:=str_t+IntToStr(i)+',' +
           intToStr( SplitcheckListBoxsuppotString(CheckListBox_Support.Items[i]))+';' ;

       end;

   if length(str_t) >1  then  begin
      str_t:=copy(str_t,0,length(str_t)-1);
   end else begin
      str_t:='';
   end;
   Result:= str_t;
end;

function TFormPressTool.MakeStringGridPhaseToString: String;
var
  s_Value:string;
  i,Col,Row:integer;
begin
    if DrawToolGzm.Auto_Judge_OldStep.PhaseNumber  < 3 then begin
      Result:='';
      exit;
    end;

    s_Value:='';
    s_Value:=s_Value+IntTostr(DrawToolGzm.Auto_Judge_OldStep.PhaseNumber) +';';
    for I := 0 to DrawToolGzm.Auto_Judge_OldStep.PhaseNumber -1 do begin
        if i<10 then begin
           Row:=i+1  ;
           Col:=1;

        end;
        if (Public_Basic.StrToInt_lu(StringGridPhase.Cells[Col,Row]) =0   )  or
           (Public_Basic.StrToInt_lu(StringGridPhase.Cells[Col+1,Row]) =0   )
        then  begin
            Result:='';  exit;
        end;
        s_Value:=s_Value+StringGridPhase.Cells[Col,Row]+ ',' +
                    StringGridPhase.Cells[Col+1,Row]+ ';';
    end;
    Result:=S_Value;
end;

function TFormPressTool.MakeStringGroupColorToString: String;
var
  s_Value:string;
  i,UPValue,temp_Int:integer;
  proValue:integer;
begin
    if DrawToolGzm.MyContourColor_NumLevel<3  then  begin
       Result:='';
       exit;
    end;

    s_Value:=IntToStr(RG_YunColorType.ItemIndex ) +',';  //
    s_Value:=s_Value+IntTostr(DrawToolGzm.MyContourColor_NumLevel) +';';
    proValue:=0;
    for I := 0 to DrawToolGzm.MyContourColor_NumLevel -1 do begin
        //防止数据出错   ，如果出错有一个初值在此
        if DrawToolGzm.ColorValue.UnitType =2 then
             UPValue:=DrawToolGzm.MyContourColor[i].UpToValue*10;

        if i<11 then  begin
          temp_Int:=Public_Basic.StrToInt_lu(StringGridColorGroup.Cells[2,i+1]);
          if temp_Int>0 then UPValue:= temp_Int;
        end;

        if DrawToolGzm.ColorValue.UnitType =2 then  begin
           UPValue:=trunc(UPValue/10);
        end;
        //防止出现逻辑型错误
        if UPValue<proValue then  UPValue:=ProValue+5;

        s_Value:=s_Value+IntToStr(UPValue)+ ',' +
                 IntToStr(DrawToolGzm.MyContourColor[i].ContourColor)+ ';';
         //防止出现逻辑型错误
        ProValue:=UPValue;
    end;

    Result:=S_Value;

end;

procedure TFormPressTool.Memo1Click(Sender: TObject);
begin
  Memo1.SetFocus;
end;

procedure TFormPressTool.OptionTip(index: integer; Str: String);
begin
   self.StatusBar1.Panels[index].Text :=str;
end;



procedure TFormPressTool.RecallDataSet;
var
   Kid:integer;
begin
   if DrawToolGzm.ColorValue.UnitType =1 then   begin
      Kid:=1;
   end else begin
      Kid:=10;
   end;
   Edit_Min_Pt.Text:=IntTostr(55*kid);
   Edit_Sup_Con.Text  :='6';
   Edit_Foot_con.Text :='3';

   DrawToolGzm.CloudClass. RockPressAnslysis:=False;
   DrawToolGzm.CloudClass.OldStepDisplay:=False;
end;

procedure TFormPressTool.ReturnClassAndColse(Value: integer);
begin
   if Value=1 then  begin
        if (RockPressJinDao) or (not ReCallData) then   begin
            //SetWaitLabel(true);
            hide;
            Repaint;
            Form_ContourGraph.LoadRockPressData(1);
        end else begin
            Form_ContourGraph.RefreshMyCloudChart;
        end;


    end else if Value=2 then  begin
           // SetWaitLabel(true);
         hide;
         Repaint;
         Form_LineGraph.RefreshMyGraphChart(true);
    end else if Value=3 then  begin
          //SetWaitLabel(true);
          hide;
          Repaint;
          Form_Band_Bar.RefreshBarSeries(-1);
    end;

end;

procedure TFormPressTool.RG_DaoOrFootageClick(Sender: TObject);
begin
   RockPressJinDao:=true;
end;

procedure TFormPressTool.RG_LineGraph_AxisClick(Sender: TObject);
begin
    if RG_LineGraph_Axis.ItemIndex=1 then  begin
       CheckListBox_LineGraph_DataType.Enabled :=true;
    end else begin
        CheckListBox_LineGraph_DataType.Enabled :=False;
    end;

end;

procedure TFormPressTool.RG_Step_FillClick(Sender: TObject);
begin
    if RG_Step_Fill.ItemIndex =0 then   begin
       Label_FillColor.Caption :='外框线条颜色';
       self.Edit_Fill_Line_Wide.Enabled :=true;
       self.Edit_Step_TranC.Enabled :=false;
   end else begin
       Label_FillColor.Caption :='填充颜色';
       self.Edit_Fill_Line_Wide.Enabled :=False;
       self.Edit_Step_TranC.Enabled :=true;
   end;
end;

procedure TFormPressTool.RG_XAxisClick(Sender: TObject);
begin
    if RG_XAxis.ItemIndex =0 then begin
       Edit_Axis.Enabled :=False;
    end else begin
       Edit_Axis.Enabled :=true;
    end;
end;

procedure TFormPressTool.SaveWorkFaceColorString;
var
  StrValue:string;
begin
     StrValue:='';
     if DrawToolGzm.FGzm.Gzmbh <1 then exit;

     if DrawToolGzm.ColorValue.UnitType >2 then  exit;

    // 合成颜色字符串
    StringGroupColor:=MakeStringGroupColorToString;

    if  length(Trim(StringGroupColor)) >0 then    begin
        StrValue:=StringGroupColor;
    end;

    if DrawToolGzm.FGzm.UpdateColorString(StrValue) then
       OptionTip(0,'数据更新成功!') else   OptionTip(0,'数据更新失败!')

end;

procedure TFormPressTool.SaveWorkFaceMemo2Text(lx: String);
var
  StrValue:String;

begin
   StrValue:='';

   if DrawToolGzm.FGzm.Gzmbh <1 then exit;

    DrawToolGzm.FGzm.Usedsupport.initLoad:=Public_Basic.StrTodouble_lu(Trim(Edit_startpt.Text))/
                        DrawToolGzm.ColorValue.UnitValue;
    DrawToolGzm.FGzm.Usedsupport.EndOpenLoad:=Public_Basic.StrTodouble_lu(Trim(Edit_Endpt.Text))/
                        DrawToolGzm.ColorValue.UnitValue;
    DrawToolGzm.FGzm.Usedsupport.Zj_Lizhu_count:=Public_Basic.StrToInt_lu(Trim(Edit_Sup_LZ_Count.Text));
    DrawToolGzm.FGzm.Usedsupport.Lz_Diameter:=Public_Basic.StrTodouble_lu(Trim(Edit_Sup_LZ_DIm.Text));

    DrawToolGzm.FGzm.RockPressAnalysis.AnalysisSenstive:=self.ComboBox_KY_Lmd.ItemIndex ;
    DrawToolGzm.FGzm.RockPressAnalysis.Continue_SupNumber:=Public_Basic.StrToInt_lu(Trim(Edit_sup_con.Text));
    DrawToolGzm.FGzm.RockPressAnalysis.conTinue_DaoNumber:=Public_Basic.StrToInt_lu(Trim(Edit_Foot_con.Text));
    DrawToolGzm.FGzm.RockPressAnalysis.Min_Pt:=Public_Basic.StrTodouble_lu(Trim(Edit_Min_pt.Text))/
                         DrawToolGzm.ColorValue.UnitValue;
    DrawToolGzm.FGzm.RockPressAnalysis.StepGroundFilled:=self.RG_Step_Ground_Fill.ItemIndex;
    DrawToolGzm.FGzm.RockPressAnalysis.StepFillIsTran:=self.RG_Step_Fill.ItemIndex;
    DrawToolGzm.FGzm.RockPressAnalysis.StepFillLineWide:=Public_Basic.StrToInt_lu(Trim(Edit_Fill_Line_Wide.Text));
    DrawToolGzm.FGzm.RockPressAnalysis.StepFillColor:=StepColorBox.Selected ;
    DrawToolGzm.FGzm.RockPressAnalysis.SetpFillTran:= Public_Basic.StrToInt_lu(Trim(Edit_Step_TranC.Text));
    DrawToolGzm.FGzm.RockPressAnalysis.JudgeMInQD :=Public_Basic.StrTodouble_lu(Trim(Edit_MinQd.Text));
    // 其他几个选项


    if lx='save' then begin
        StrValue:=FormatFloat('0.0',DrawToolGzm.FGzm.Usedsupport.initLoad) +',';        //0
        StrValue:=StrValue+FormatFloat('0.0',DrawToolGzm.FGzm.Usedsupport.EndOpenLoad)+',';  // 1
        StrValue:=StrValue+IntTostr(ComboBox_KY_Lmd.ItemIndex) +',';                       //2
        StrValue:=StrValue+intToStr(DrawToolGzm.FGzm.RockPressAnalysis.Continue_SupNumber) +','; //3
        StrValue:=StrValue+intToStr(DrawToolGzm.FGzm.RockPressAnalysis.conTinue_DaoNumber) +',' ;  //4
        StrValue:=StrValue+FormatFloat('0.0',DrawToolGzm.FGzm.RockPressAnalysis.Min_Pt)+',';    //5
        StrValue:=StrValue+intToStr(DrawToolGzm.FGzm.RockPressAnalysis.StepGroundFilled) +',';  //6
        StrValue:=StrValue+intToStr(DrawToolGzm.FGzm.RockPressAnalysis.StepFillIsTran) +',' ;   //7
        StrValue:=StrValue+intToStr(DrawToolGzm.FGzm.RockPressAnalysis.StepFillLineWide) +',';  //8
        StrValue:=StrValue+intToStr(DrawToolGzm.FGzm.RockPressAnalysis.StepFillColor) +',' ;    //9
        StrValue:=StrValue+intToStr(DrawToolGzm.FGzm.RockPressAnalysis.SetpFillTran)+ ',' ;          //10
        StrValue:=StrValue+intToStr(DrawToolGzm.FGzm.RockPressAnalysis.SelectedFillColor) +',' ;         //11
        StrValue:=StrValue+FormatFloat('0.0',DrawToolGzm.FGzm.RockPressAnalysis.JudgeMInQD)+',' ;         //12
        StrValue:=StrValue+intToStr(DrawToolGzm.FGzm.Usedsupport.Zj_Lizhu_count) +',' ;         //13
        StrValue:=StrValue+FormatFloat('0.0',DrawToolGzm.FGzm.Usedsupport.Lz_Diameter );           //14
        //
        DrawToolGzm.Auto_Judge_OldStep.InitPhaseSteps(3+2*CB_PhaseNumber.ItemIndex,DrawToolGzm.FGzm);

        StrValue:=StrValue+ '&' + self.MakeStringGridPhaseToString;

        if DrawToolGzm.FGzm.UpdateRockPressParameters(StrValue) then
            OptionTip(0,'数据更新成功!') else   OptionTip(0,'数据更新失败!')
    end;


end;

procedure TFormPressTool.selectCheckListBoxSupport(Value: string);
var
  i,Mid_P,Mid_C,j:integer;
  Count_Sup,inv_sup,tmp_sup:integer;
  tt_C:integer;
begin
     for I := 0 to self.CheckListBox_Support.Count-1 do
         CheckListBox_Support.Checked[i]:=False;

    if Value='' then exit;

     Count_Sup:=0;
     Mid_P:=DrawToolGzm.Auto_Judge_OldStep.PhaseNumber div 2;
     if Value='1' then  begin
         Mid_P:=Mid_P;
     end else if Value='2' then  begin
        if Mid_P >0  then  Mid_P:=Mid_P-1;
     end else if Value='3' then  begin
        if Mid_P< DrawToolGzm.Auto_Judge_OldStep.PhaseNumber-1  then  Mid_P:=Mid_P+1;
     end;
    // 把每个阶段的中间支架选中
    for i:=0 to  DrawToolGzm.Auto_Judge_OldStep.PhaseNumber-1  do begin
          if i= Mid_P then continue;
          Mid_C:=(DrawToolGzm.Auto_Judge_OldStep.PhaseSteps[i].EndSupBh+ DrawToolGzm.Auto_Judge_OldStep.PhaseSteps[i].StartsupBh ) div 2;
         // Mid_C:=trunc(Mid_c/DrawToolGzm.FGzm.RockPressAnalysis.ManulInput_Interval_support);
          for j := 0 to SupportCheckList.Count-1 do  begin
              tmp_sup:=Public_Basic.StrToInt_lu(SupportCheckList[j]);
              if (tmp_sup>0 ) and(tmp_sup = Mid_C )then  begin
                 CheckListBox_Support.Checked[j]:=true;
                 inc( Count_Sup);
              end;

          end;

    end;
    //选中的区域 进行选择支架
      inv_sup:= (DrawToolGzm.Auto_Judge_OldStep.PhaseSteps[Mid_P].EndSupBh- DrawToolGzm.Auto_Judge_OldStep.PhaseSteps[Mid_P].StartsupBh )
               div (12-Count_Sup);
      tt_C:= Count_Sup;
      for I := tt_C to 12 do  begin
          Mid_C:=DrawToolGzm.Auto_Judge_OldStep.PhaseSteps[Mid_P].StartsupBh + (inv_sup*(i-tt_C ));
          //Mid_C:=trunc(Mid_c/DrawToolGzm.FGzm.RockPressAnalysis.ManulInput_Interval_support);

          for j := 0 to SupportCheckList.Count-1 do  begin
              if Count_Sup>12 then  break;
              tmp_sup:=Public_Basic.StrToInt_lu(SupportCheckList[j]);
              if (tmp_sup>0 ) and(tmp_sup = Mid_C ) and ( not CheckListBox_Support.Checked[j] )then  begin
                 CheckListBox_Support.Checked[j]:=true;
                 inc( Count_Sup);
              end;
          end;
      end;

     //
    Memo1.Clear;
    Memo1.Lines.Add(MakecheckListBoxsuppotString);
end;

function TFormPressTool.SelectRockPressDataNumber(DataType: integer): Boolean;
var
  sql,FieldStr:String;
begin
   Result:=False;
   MySqlDataSet1.Close ;

   if DataType< 5 then begin
      FieldStr:='MZL_Value';
   end else   begin
      FieldStr:='PressData';
   end;

   Sql:=' select Sum('+FieldStr+') as MCN from  D_'+IntToStr(DrawtoolGzm.FGzm.Gzmbh)+'_ManualInputPressData  ';

   MySqlDataSet1.CommandText :=sql;
   try
       if MySqlDataSet1.Open then
        if MySqlDataSet1.FieldByName('MCN').AsFloat >100 then
           Result:=true;

   finally
       MySqlDataSet1.Close ;
   end;

end;

function TFormPressTool.SetAnalysisSenstive(Index: integer): Boolean;
var
  kk:integer;
begin
   ReSult:=False;
   if DrawToolGzm.ColorValue.UnitType=2 then  KK:=10 else kk:=1;

   DrawToolGzm.FGzm.RockPressAnalysis.AnalysisSenstive:=Index;
   if index=0 then  begin // 灵敏度高
      DrawToolGzm.FGzm.RockPressAnalysis.Continue_SupNumber:=3;
      DrawToolGzm.FGzm.RockPressAnalysis.conTinue_DaoNumber:=2;
      DrawToolGzm.FGzm.RockPressAnalysis.JudgeMInQD :=0.4;
      DrawToolGzm.FGzm.RockPressAnalysis.NearColorLineUp_DownValue :=1;
      DrawToolGzm.FGzm.RockPressAnalysis.NearTwoStepDaoValue :=3;
      DrawToolGzm.FGzm.RockPressAnalysis.NearTwoStepAGvData_BS :=1;
      DrawToolGzm.FGzm.RockPressAnalysis.Min_Pt:=DrawToolGzm.FGzm.Usedsupport.EndOpenLoad*0.9;
   end else if  index=1 then  begin // 灵敏度一般 then
      DrawToolGzm.FGzm.RockPressAnalysis.Continue_SupNumber:=6;
      DrawToolGzm.FGzm.RockPressAnalysis.conTinue_DaoNumber:=3;
      DrawToolGzm.FGzm.RockPressAnalysis.JudgeMInQD :=0.6;
      DrawToolGzm.FGzm.RockPressAnalysis.NearColorLineUp_DownValue :=1;
      DrawToolGzm.FGzm.RockPressAnalysis.NearTwoStepDaoValue :=5;
      DrawToolGzm.FGzm.RockPressAnalysis.NearTwoStepAGvData_BS :=1.1;
      DrawToolGzm.FGzm.RockPressAnalysis.Min_Pt:=DrawToolGzm.FGzm.Usedsupport.EndOpenLoad*0.85;
   end else if  index=2 then  begin // 灵敏度低 then
      DrawToolGzm.FGzm.RockPressAnalysis.Continue_SupNumber:=10;
      DrawToolGzm.FGzm.RockPressAnalysis.conTinue_DaoNumber:=5;
      DrawToolGzm.FGzm.RockPressAnalysis.JudgeMInQD :=0.8;
      DrawToolGzm.FGzm.RockPressAnalysis.NearColorLineUp_DownValue :=1;
      DrawToolGzm.FGzm.RockPressAnalysis.NearTwoStepDaoValue :=6;
      DrawToolGzm.FGzm.RockPressAnalysis.NearTwoStepAGvData_BS :=1.1;
      DrawToolGzm.FGzm.RockPressAnalysis.Min_Pt:=DrawToolGzm.FGzm.Usedsupport.EndOpenLoad*0.85-1;
   end else if  index=3 then  begin // 灵敏度自动计算
      DrawToolGzm.FGzm.RockPressAnalysis.Continue_SupNumber:=6;
      DrawToolGzm.FGzm.RockPressAnalysis.conTinue_DaoNumber:=3;
      DrawToolGzm.FGzm.RockPressAnalysis.JudgeMInQD :=0.6;
      DrawToolGzm.FGzm.RockPressAnalysis.NearColorLineUp_DownValue :=1;
      DrawToolGzm.FGzm.RockPressAnalysis.NearTwoStepDaoValue :=5;
      DrawToolGzm.FGzm.RockPressAnalysis.NearTwoStepAGvData_BS :=1.1;
      DrawToolGzm.FGzm.RockPressAnalysis.Min_Pt:=55;
   end;


   // 更改相关数值
   Edit_MinQd.Text := FormatFloat('0.00',DrawToolGzm.FGzm.RockPressAnalysis.JudgeMInQD);
   Edit_Sup_Con.Text:=IntTostr(DrawToolGzm.FGzm.RockPressAnalysis.Continue_SupNumber);
   Edit_Foot_Con.Text :=IntTostr(DrawToolGzm.FGzm.RockPressAnalysis.conTinue_DaoNumber);
   self.Edit_Min_Pt.Text :=FormatFloat('0.00',DrawToolGzm.FGzm.RockPressAnalysis.Min_Pt*KK);
   Result:=True;

end;

procedure TFormPressTool.SetDrawClass(iDW: TDrawGrap);
begin
     DrawToolGzm:=iDW;
     AutoOption:=True;
end;

procedure TFormPressTool.SetDrawToolGZMValue;
var
   s1,s2:Str_DT_array;
   C1,C2,i,KK:integer;
   Splitsuccess:Boolean;
begin
   if DrawToolGzm.ColorValue.UnitType =1 then   begin
      KK:=1;
   end else begin
      KK:=10;
   end;

    //数据查询类型
   RG_DaoOrFootage.ItemIndex:=DrawToolGzm.SelectDataBasic_DaoOrFootage;
   // 数据类型选择
   RG_YUN_Cycle.ItemIndex:=ord(DrawToolGzm.CloudClass .Yuntu_CycleData);
    // 曲线数据
   if DrawToolGzm.GraphClass.Out_input_Data then   // 如果外部传来了支架参数
      Splitsuccess:=SplitOutInputSupportList(DrawToolGzm.GraphClass.Support_Select_List); // 自动拆分外部传过来的支架
   //如果外传过来为空或者 没有外传参数
   if (not DrawToolGzm.GraphClass.Out_input_Data) or (not Splitsuccess) then  begin
       if length(DrawToolGzm.GraphClass.SupportList) <1  then  begin
            selectCheckListBoxSupport('1');
       end else begin
             S1:=public_Basic.split(DrawToolGzm.GraphClass.SupportList,';',C1);
             for I := 0 to High(S1) do  begin
                  S2:=public_Basic.split(S1[i],',',C2);
                  if C2>1 then
                     if (Public_Basic.StrToInt_lu(S2[0])>=0 ) and
                         (Public_Basic.StrToInt_lu(S2[0]) < CheckListBox_Support.Count) then
                            CheckListBox_Support.Checked[Public_Basic.StrToInt_lu(S2[0])]:=true;

             end;
       end;
   end;


   // Line_Graph
    RG_LineGraph_Axis.ItemIndex:= DrawToolGzm.GraphClass.YAxisType; ;
    for I := 0 to CheckListBox_LineGraph_DataType.Count-1 do
       CheckListBox_LineGraph_DataType.Checked[i]:=DrawToolGzm.GraphClass.Disp_DataType[i];
    RG_LineGraph_LineType.ItemIndex :=DrawToolGzm.GraphClass.Line_Tpye;
    RG_LineGraph_PenWide.ItemIndex :=DrawToolGzm.GraphClass.Line_Width;
    RG_LineGraph_ColorType.ItemIndex :=DrawToolGzm.GraphClass.Line_Color;

    //把自动分析的灵敏度传递过来
    ComboBox_KY_Lmd.ItemIndex:= DrawToolGzm.FGzm.RockPressAnalysis.AnalysisSenstive;
    Edit_sup_con.Text:=InttoStr(DrawToolGzm.FGzm.RockPressAnalysis.Continue_SupNumber);
    Edit_foot_con.Text:=InttoStr(DrawToolGzm.FGzm.RockPressAnalysis.conTinue_DaoNumber);
    Edit_Min_pt.Text  :=FormatFloat('0.0',DrawToolGzm.FGzm.RockPressAnalysis.Min_Pt*KK);

  // RadidFootage_Upper Down
    RadioGroup_UpperFootage.ItemIndex:=DrawToolGzm.ConTourSeriesPar.Display_UpperFootage;
    RadioGroup_DownFootage.ItemIndex:=DrawToolGzm.ConTourSeriesPar.Display_DownFootage;
  //读取横坐标显示的设置方式

    RG_XAxis.ItemIndex :=DrawToolGzm.CloudClass.X_Axis_Disp_Type;
    Edit_Axis.Text:=IntTostr(DrawToolGzm.CloudClass.X_Axis_Disp_Dao);



  //读取是否显示预测数据信息
  if DrawToolGzm.CloudClass.DisPlayForcase then RG_Option_ForCase.ItemIndex :=0
      else   RG_Option_ForCase.ItemIndex :=1;


    //读取是否显示最小进刀之前的来压步距
  if DrawToolGzm.CloudClass.DisPlayProMinDaoSaveStep then RG_Option_DispProDao.ItemIndex :=0
      else   RG_Option_DispProDao.ItemIndex :=1;


     //读取是否进行重新分析  对于进刀之内的区域保存的数据
   if DrawToolGzm.CloudClass.RecallMidDaoSaveStep then RG_Option_DispSave_MidDao.ItemIndex :=0
      else   RG_Option_DispSave_MidDao.ItemIndex :=1;


   //获取存储的数据是显示区域云图还是显示来压步距
    if DrawToolGzm.CloudClass.SaveDate_Edit then RG_Option_SaveEdit.ItemIndex :=1
      else   RG_Option_SaveEdit.ItemIndex :=0;


     //获取进刀范围之外的来压信息是否输出
    if DrawToolGzm.CloudClass.PrintOutDaoStepInto then RG_Print_Option.ItemIndex :=0
      else   RG_Print_Option.ItemIndex :=1;


       //获取矿压数据分段显示方式
    if DrawToolGzm.CloudClass.PrintDispPhaseVisual then RG_Print_Disp.ItemIndex :=0
      else   RG_Print_Disp.ItemIndex :=1;
    // 控制TabSheet的显示

    if (DrawToolGzm.GraphClass.FisrtPageId >=0) and (DrawToolGzm.GraphClass.FisrtPageId < 3) then begin
       MainPage.ActivePageIndex :=DrawToolGzm.GraphClass.FisrtPageId;
       if DrawToolGzm.GraphClass.FisrtPageId=0 then  begin
          SecondPage_0.ActivePageIndex:=DrawToolGzm.GraphClass.SecondPageid;
       end else if DrawToolGzm.GraphClass.FisrtPageId=1 then  begin
          SecondPage_1.ActivePageIndex:=DrawToolGzm.GraphClass.SecondPageid;
       end else  if DrawToolGzm.GraphClass.FisrtPageId=2 then  begin
          SecondPage_2.ActivePageIndex:=DrawToolGzm.GraphClass.SecondPageid;
       end;
//
//       TPageControl('secondPage_'+IntTostr(DrawToolGzm.GraphClass.FisrtPageId)).ActivePageIndex :=
//                 DrawToolGzm.GraphClass.SecondPageid;
    end;
   // 控制ScrollPageSize
    RG_SCroll_PageSize.ItemIndex :=DrawToolGzm.GraphClass.ScrollPageSize;

   // bar
   RG_Bar_DispData.ItemIndex := DrawToolGzm.BarMarks.Disp_0 ;
   RG_Bar_B_D.ItemIndex := DrawToolGzm.BarMarks.Disp_B_D ;
   RG_Bar_Marks.ItemIndex := DrawToolGzm.BarMarks.Disp_Mark ;

end;

function TFormPressTool.SetMainPageVisible(Value: integer):integer ;
 {
    Value 1 意思是 是绘制压力云图页面打开它
    Value 2 意思是 是绘制曲线图的页面打开它
 }
begin
    Result:=Value;
    if Value=1 then    begin
         Tab_Main_LineGraph.TabVisible :=False;
    end else  if Value=2 then    begin
         Tab_Main_PressAnlysis.TabVisible :=False;
         secondpage_0.Pages[1].TabVisible :=False;
         Tab_SupDisp.TabVisible :=true;
         Tab_SupBar.TabVisible:=FAlse;
    end else  if Value=3  then    begin
         Tab_Main_PressAnlysis.TabVisible :=False;
         secondpage_0.Pages[1].TabVisible :=False;
         secondpage_2.Pages[1].TabVisible :=False;
         secondpage_2.Pages[2].TabVisible :=true;
    end;
end;

procedure TFormPressTool.SetWaitLabel(Value: Boolean);
begin
   if Value then  begin
      MainPage.Pages[0].TabVisible :=False;
      MainPage.Pages[1].TabVisible :=False;
      MainPage.Pages[2].TabVisible :=False;
      MainPage.Pages[3].TabVisible :=true;
      Tab_Wait.Visible :=true;
      MainPage.ActivePage :=Tab_Wait;
//      TGIFImage(Image1.Picture.Graphic).AnimationSpeed := 200;
//      TGIFImage(Image1.Picture.Graphic).Animate := True;
//      FormPressTool.DoubleBuffered := True;

   end else begin
      MainPage.Pages[0].TabVisible :=true;
      MainPage.Pages[1].TabVisible :=true;
      MainPage.Pages[2].TabVisible :=true;
      MainPage.Pages[3].TabVisible :=False;
      MainPage.ActivePage :=MainPage.Pages[0];
   end;

end;

function TFormPressTool.SplitcheckListBoxsuppotString(Value: String): integer;
var
  Start,End_pos:integer;
  t_str:string;
begin
   Result:=-1;
   Start:=pos('[',Value);
   if Start <0  then  exit;
   End_pos:=pos(']',Value);
   if End_pos <1  then  exit;
   t_str:=copy(Value,Start+1,End_pos-Start-1);
   if Public_Basic.StrToInt_lu(t_str)>0  then   begin
      Result:=Public_Basic.StrToInt_lu(t_str);
   end;

end;

function TFormPressTool.SplitOutInputSupportList(Value: string):Boolean;
var
   s1:Str_DT_array;
   C1,i,j,Sup,tmp_sup:integer;
   Sup_Count,tmp:integer;
   Sup_Iv:double;
begin
   Result:=False;
   if length(Value) <1 then   exit;

   s1:=Public_Basic.split(Value,',',C1);
   if C1<1 then  exit;

   for I := 0 to self.CheckListBox_Support.Count-1 do
         CheckListBox_Support.Checked[i]:=False;
   Sup_Count:=0;
   for I := 0 to High(S1) do  begin
        Sup:=Public_Basic.StrToInt_lu(S1[i]);
        for j := 0 to SupportCheckList.Count-1 do  begin
              tmp_sup:=Public_Basic.StrToInt_lu(SupportCheckList[j]);
              if (Sup = tmp_sup ) and (not CheckListBox_Support.Checked[j] )then  begin
                 CheckListBox_Support.Checked[j]:=true;
                 inc(Sup_Count);
                 break;
              end;
          end;

   end;
   //
   if Sup_Count>12 then  Sup_Iv:=Sup_Count/13
      else   Sup_Iv:=1;

//   Sup_Count:=0; tmp:=0;
//   for j := 0 to SupportCheckList.Count-1 do  begin
//       if CheckListBox_Support.Checked[j] then  begin
//           inc(tmp);
//           if Sup_Count >0  then  begin
//               if  tmp > Sup_Iv then  begin
//                   tmp:=0;
//                   inc( Sup_Count);
//               end else begin
//                   CheckListBox_Support.Checked[j]:=False;
//               end;
//           end else begin
//              inc( Sup_Count);
//           end;
//
//           if Sup_Count> 12 then
//              CheckListBox_Support.Checked[j]:=False;
//       end;
//
//   end;
   // 组建字符串
   DrawToolGzm.GraphClass.SupportList:=MakecheckListBoxsuppotString;
    Result:=true;
end;

procedure TFormPressTool.SplitStringGridPhase;
begin
    if not DrawToolGzm.Auto_Judge_OldStep.SplitPhaseString(DrawToolGzm.FGzm.RockPressAnalysis.OldStepPhaseString)  then exit;
    if DrawToolGzm.Auto_Judge_OldStep.PhaseNumber >2 then
        CB_PhaseNumber.ItemIndex:= DrawToolGzm.Auto_Judge_OldStep.PhaseNumber div 2 -1 ;
end;

procedure TFormPressTool.splitStringGroupColor;
var
   s_temp,s2:Str_DT_array;
   C1,C2,i:integer;
begin
   if length(trim(StringGroupColor))>0 then   begin
         s_temp:=Public_Basic.split(StringGroupColor,';',C1);
         if C1> 1 then  begin
            S2:=Public_Basic.split(s_temp[0],',',C2);
            DrawToolGzm.YunColorType:=Public_Basic.StrToInt_lu(S2[0]) ;
            DrawToolGzm.MyContourColor_NumLevel:=Public_Basic.StrToInt_lu(S2[1]) ;
         end else begin
            exit;
         end;

          for I := 0 to DrawToolGzm.MyContourColor_NumLevel-1 do  begin
              S2:=Public_Basic.split(s_temp[i+1],',',C2);
              if C2>0  then  begin
                 DrawToolGzm.MyContourColor[i].UpToValue :=Public_Basic.StrToInt_lu(S2[0]) ;
                 DrawToolGzm.MyContourColor[i].ContourColor :=Public_Basic.StrToInt_lu(S2[1]) ;
                 DrawToolGzm.MyContourColor[i].xh :=i+1;
              end;
          end;
   end;
end;

procedure TFormPressTool.SplitWorkFaceColorString;
begin
  if DrawToolGzm.FGzm.Gzmbh <1 then exit;
   // 进尺表的维护
   DrawToolGzm.FGzm.ClearMemo2Parameters ;
   DrawToolGzm.FGzm.InputGzmData(DrawToolGzm.FGzm.Gzmbh);
   if not DrawToolGzm.FGzm.SplitColorString then begin
      StringGroupColor:=DrawToolGzm.FGzm.RockPressAnalysis.ColorString;
      splitStringGroupColor;
   end;
end;

procedure TFormPressTool.SplitWorkFaceMemo1Text;
begin
   if DrawToolGzm.FGzm.Gzmbh <1 then exit;
   // 进尺表的维护
   DrawToolGzm.FGzm.InputGzmData(DrawToolGzm.FGzm.Gzmbh);
   if not DrawToolGzm.FGzm.splitFootStepParameters then begin
       DrawToolGzm.FGzm.RockPressAnalysis.Oneday_daoshu:=10;
       DrawToolGzm.FGzm.RockPressAnalysis.TwoDao_IntervalTime:=90;
       DrawToolGzm.FGzm.RockPressAnalysis.OneDao_step:=0.865;
       DrawToolGzm.FGzm.RockPressAnalysis.ManulInput_Interval_support:=5;
       if DrawToolGzm.FGzm.SupEndNumber < 1 then
          DrawToolGzm.FGzm.SupEndNumber:=200;
       DrawToolGzm.FGzm.RockPressAnalysis.JinDao_Basic:=1;
       DrawToolGzm.FGzm.RockPressAnalysis.JinDao_Support:=100;
       DrawToolGzm.FGzm.RockPressAnalysis.JinDao_Time:=0;
       DrawToolGzm.FGzm.RockPressAnalysis.Jindao_DataType:=1;
   end;

end;

procedure TFormPressTool.SplitWorkFaceMemo2Text;
begin
   if DrawToolGzm.FGzm.Gzmbh <1 then exit;
   // 进尺表的维护
   DrawToolGzm.FGzm.ClearMemo2Parameters ;
   DrawToolGzm.FGzm.InputGzmData(DrawToolGzm.FGzm.Gzmbh);
   DrawToolGzm.FGzm.WorkFaceBulidSupport ;
   //填充颜色字符串
   StringGroupColor:= DrawToolGzm.FGzm.ColorString ;
   if not DrawToolGzm.FGzm.SplitRockPressParameters then begin
       if DrawToolGzm.FGzm.Usedsupport.Lz_Diameter <=0 then  begin
          DrawToolGzm.FGzm.Usedsupport.Lz_Diameter:=350;
       end;

       if DrawToolGzm.FGzm.Usedsupport.initLoad <=0 then  begin
          DrawToolGzm.FGzm.Usedsupport.initLoad:=25;
       end;

       if DrawToolGzm.FGzm.Usedsupport.EndOpenLoad <=0 then  begin
          DrawToolGzm.FGzm.Usedsupport.EndOpenLoad:=49;
       end;

       if DrawToolGzm.FGzm.Usedsupport.Zj_Lizhu_count <=0 then  begin
          DrawToolGzm.FGzm.Usedsupport.Zj_Lizhu_count:=2;
       end;
       DrawToolGzm.FGzm.RockPressAnalysis.AnalysisSenstive:=3;
       DrawToolGzm.FGzm.RockPressAnalysis.Continue_SupNumber:=4;
       DrawToolGzm.FGzm.RockPressAnalysis.conTinue_DaoNumber:=2;
       DrawToolGzm.FGzm.RockPressAnalysis.Min_Pt:=40;
       DrawToolGzm.FGzm.RockPressAnalysis.StepFillColor:=ClYellow;
       DrawToolGzm.FGzm.RockPressAnalysis.SetpFillTran:=50;
       DrawToolGzm.FGzm.RockPressAnalysis.StepGroundFilled:=0;
       DrawToolGzm.FGzm.RockPressAnalysis.StepFillIsTran :=1;
       DrawToolGzm.FGzm.RockPressAnalysis.StepFillLineWide:=5;
       DrawToolGzm.FGzm.RockPressAnalysis.SelectedFillColor:=ClRed;
       DrawToolGzm.FGzm.RockPressAnalysis.JudgeMInQD :=0.5;
       // 划分矿压分析阶段
       DrawToolGzm.Auto_Judge_OldStep.InitPhaseSteps(5,DrawToolGzm.FGzm ) ;
   end;

   if DrawToolGzm.FGzm.RockPressAnalysis.OldStepPhaseString <> '' then  begin
       SplitStringGridPhase;
   end else begin
       if DrawToolGzm.FGzm.SupEndNumber <=100 then  begin
           DrawToolGzm.Auto_Judge_OldStep.InitPhaseSteps(3,DrawToolGzm.FGzm ) ;
           CB_PhaseNumber.ItemIndex:=0 ;
       end else if DrawToolGzm.FGzm.SupEndNumber<= 180 then  begin
           DrawToolGzm.Auto_Judge_OldStep.InitPhaseSteps(5,DrawToolGzm.FGzm ) ;
           CB_PhaseNumber.ItemIndex:=1 ;
       end else begin
           DrawToolGzm.Auto_Judge_OldStep.InitPhaseSteps(7,DrawToolGzm.FGzm ) ;
           CB_PhaseNumber.ItemIndex:=2;
       end;

   end;


   Edit_StartPt.Text  :=FormatFloat('0.0',DrawToolGzm.FGzm.Usedsupport.initLoad*DrawToolGzm.ColorValue.UnitValue);
   Edit_EndPt.Text  :=FormatFloat('0.0',DrawToolGzm.FGzm.Usedsupport.EndOpenLoad  *DrawToolGzm.ColorValue.UnitValue);
   Edit_Sup_Lz_Count.Text:=IntTostr(DrawToolGzm.FGzm.Usedsupport.Zj_Lizhu_count);
   Edit_Sup_LZ_Dim.Text:=FormatFloat('0.0',DrawToolGzm.FGzm.Usedsupport.Lz_Diameter);

   ComboBox_KY_Lmd.ItemIndex :=DrawToolGzm.FGzm.RockPressAnalysis.AnalysisSenstive ;

   Edit_sup_con.Text:=InttoStr(DrawToolGzm.FGzm.RockPressAnalysis.Continue_SupNumber);
   Edit_foot_con.Text:=InttoStr(DrawToolGzm.FGzm.RockPressAnalysis.conTinue_DaoNumber);
   Edit_Min_pt.Text  :=FormatFloat('0.0',DrawToolGzm.FGzm.RockPressAnalysis.Min_Pt*DrawToolGzm.ColorValue.UnitValue);
   StepColorBox.Selected  :=DrawToolGzm.FGzm.RockPressAnalysis.StepFillColor;
   Edit_Step_TranC.Text:=InttoStr(DrawToolGzm.FGzm.RockPressAnalysis.SetpFillTran);
   RG_Step_Ground_Fill.ItemIndex:=DrawToolGzm.FGzm.RockPressAnalysis.StepGroundFilled;
   RG_Step_Fill.ItemIndex :=DrawToolGzm.FGzm.RockPressAnalysis.StepFillIsTran;
   Edit_Fill_Line_Wide.Text:=InttoStr(DrawToolGzm.FGzm.RockPressAnalysis.StepFillLineWide);
   Edit_MinQd.Text:=FormatFloat('0.00', DrawToolGzm.FGzm.RockPressAnalysis.JudgeMInQD);
   SelectedColorBox.Selected  :=DrawToolGzm.FGzm.RockPressAnalysis.SelectedFillColor;
   // 把区域划分进行剖分并进行填充
  if DrawToolGzm.Auto_Judge_OldStep.PhaseNumber > 2 then
        FillStringGridPhase(DrawToolGzm.Auto_Judge_OldStep.PhaseNumber)
     else FillStringGridPhase(5);
  // 把One_Step 批出来

   SplitWorkFaceMemo1Text;

end;

procedure TFormPressTool.StartEditClick(Sender: TObject);
begin
    EditSetFoces(StartEdit);
end;

procedure TFormPressTool.StartEditKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TFormPressTool.StringGridColorGroupDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  iRect:TRect;
begin
     with StringGridColorGroup do  begin
         if (ACol =3) and (ARow <= DrawToolGzm.MyContourColor_NumLevel)
            and (ARow >0 )  and (ARow <=10 )then       begin
            iRect:=ZoomRect(Rect, 1);
            Canvas.Brush.color:=DrawToolGzm.MyContourColor[ARow-1].ContourColor ;
            Canvas.FillRect(iRect);
         end;

      end;

end;

procedure TFormPressTool.StringGridColorGroupSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
   i:Integer;
begin
   if (ARow>0) and (Acol=3) then begin
       if (Acol=3) then    begin
          i:=ARow-1;
       end;
       if i+1 <=DrawToolgzm.MyContourColor_NumLevel then begin
           ColorDialog1.Color:=DrawToolgzm.MyContourColor[i].ContourColor;
           ColorDialog1.Execute;
           DrawToolgzm.MyContourColor[i].ContourColor:=ColorDialog1.Color;
           StringGridColorGroup.Repaint;
       end;
   end;

end;

procedure TFormPressTool.ToolButton1Click(Sender: TObject);
begin
    selectCheckListBoxSupport('');
end;

procedure TFormPressTool.ToolButton2Click(Sender: TObject);
begin
   selectCheckListBoxSupport('1');
end;

procedure TFormPressTool.ToolButton3Click(Sender: TObject);
begin
   selectCheckListBoxSupport('2');
end;

procedure TFormPressTool.ToolButton4Click(Sender: TObject);
begin
    selectCheckListBoxSupport('3');
end;

procedure TFormPressTool.SecondPage_0DrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
 if Active then
    begin
        Control.Canvas.Brush.Color := ClHighLight;
        Control.Canvas.Font.Color := clWhite;
    end;
    Control.Canvas.FillRect(Rect);
    Control.Canvas.TextOut(Rect.Left + 4,Rect.Top + 4,SecondPage_0.Pages[TabIndex].Caption);
end;

function TFormPressTool.ZoomRect(mRect: TRect; mZoom: Integer): TRect;
begin
  Result.Left := mRect.Left - mZoom;
  Result.Right := mRect.Right + mZoom;
  Result.Top := mRect.Top;// - mZoom;
  Result.Bottom := mRect.Bottom- mZoom;
end;

end.
