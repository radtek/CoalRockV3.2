﻿unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,Vcl.Forms,Winapi.ActiveX,System.Win.ComObj,
 // Vcl.Controls,  Vcl.Dialogs, Data.Win.ADODB, Data.DB, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList, Vcl.Menus
 {个人定义接口}
 , UIWinFrame,UICallPstope, UIGuideMapDll,uIRockPress
 , Vcl.ExtCtrls, Vcl.Controls, Vcl.AppEvnts

  ;
 const
  WM_DPICHANGED = 736; // 0x02E0

type
  pUserRecord =^TUsedDataBase;
  TUsedDataBase=packed record
    UserName: string;
    UserId:String;
    Admin:Boolean;
    Coal_id:string;
    Coal_Name:String;
    Workface_id:String;
    WorkFace_Name:String;
    Drill_id:String;
    Drill_Name:String;
  end;
  TUserRecord=packed record
    Ip  :String;
    UserName: string;
    Port: String;
    Password:string;
    DataBaseName:String;
    DataType:string;
    DataBaseString:String;
  end;

  TMainCForm = class(TForm)
    MainMemu: TMainMenu;
    M_Basic: TMenuItem;
    M_Basic_CallModule: TMenuItem;
    M_Basic_UserManager: TMenuItem;
    M_Basic_UserInfo: TMenuItem;
    M_INput: TMenuItem;
    M_Input_CoalName: TMenuItem;
    M_Input_DrillInfo: TMenuItem;
    M_Input_Drill_DetailInfo: TMenuItem;
    M_Input_WorkFaceInfo: TMenuItem;
    M_Input_SuooprtInfo: TMenuItem;
    M_Input_HangDaoInfo: TMenuItem;
    M_Input_DrillLinkGzm: TMenuItem;
    M_FYYD: TMenuItem;
    M_MN_Fyyd: TMenuItem;
    M_MN_MNKC: TMenuItem;
    M_CDMN: TMenuItem;
    M_MN_SanWei: TMenuItem;
    N6: TMenuItem;
    M_Support: TMenuItem;
    M_Support_Can: TMenuItem;
    M_Support_Cal: TMenuItem;
    N3: TMenuItem;
    M_Support_Report: TMenuItem;
    M_Suuport_Input: TMenuItem;
    M_Support_Expert: TMenuItem;
    M_HELP: TMenuItem;
    M_HELP_Version: TMenuItem;
    M_HELP_HELP1: TMenuItem;
    StatusBar1: TStatusBar;
    MainWindows: TPanel;
    Label1: TLabel;
    BackImage: TImage;
    ImageList1: TImageList;
    M_Basic_UserManager_TopLine: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    Memu_Support_UsedInfo: TMenuItem;
    N15: TMenuItem;
    M_Basic_Data_tranfer: TMenuItem;
    N7: TMenuItem;
    M_Input_CADUsed: TMenuItem;
    M_KYFX: TMenuItem;
    N2: TMenuItem;
    YkLh_Input: TMenuItem;
    YKLH_Report: TMenuItem;
    KY_Footage: TMenuItem;
    KY_EditData: TMenuItem;
    N8: TMenuItem;
    KY_ConTour: TMenuItem;
    KY_Report: TMenuItem;
    KY_BatInputData: TMenuItem;
    N5: TMenuItem;
    Main_CoolBar: TCoolBar;
    ToolBar_Basic: TToolBar;
    TB_Coal: TToolButton;
    TB_Gzm: TToolButton;
    TB_Zk: TToolButton;
    TB_ChangeData: TToolButton;
    ToolBar_Fyyd: TToolBar;
    TB_FYYD: TToolButton;
    TB_CDMN: TToolButton;
    ToolBar_KY: TToolBar;
    TB_Bat_Input: TToolButton;
    TB_Edit_Footage: TToolButton;
    TB_EditData: TToolButton;
    TB_KYFX: TToolButton;
    ToolBar_ZJ: TToolBar;
    ToolButton41: TToolButton;
    ToolButton42: TToolButton;
    ToolBar_System: TToolBar;
    ToolButton17: TToolButton;
    OpenUserWindow_Timer: TTimer;
    TB_CSWT: TToolButton;
    TB_ZJ_REport: TToolButton;
    TB_LH_REport: TToolButton;
    N1: TMenuItem;
    N4: TMenuItem;
    N12: TMenuItem;
    KY_LineGraph: TMenuItem;
    N13: TMenuItem;
    M_Basic_WholeScreen: TMenuItem;
    M_Basic_WebDataBase: TMenuItem;
    M_Basic_UpdateCoalBmp: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure M_Input_CoalNameClick(Sender: TObject);
    procedure M_Input_DrillInfoClick(Sender: TObject);
    procedure M_Input_Drill_DetailInfoClick(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure M_Input_WorkFaceInfoClick(Sender: TObject);
    procedure M_Input_SuooprtInfoClick(Sender: TObject);
    procedure M_Input_DrillLinkGzmClick(Sender: TObject);
    procedure M_Basic_UserManagerClick(Sender: TObject);
    procedure M_Basic_UserInfoClick(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure M_Basic_CallModuleClick(Sender: TObject);
    procedure TB_ChangeDataClick(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure TB_FYYDClick(Sender: TObject);
    procedure OpenUserWindow_TimerTimer(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure M_MN_FyydClick(Sender: TObject);
    procedure M_MN_MNKCClick(Sender: TObject);
    procedure TB_DTFZClick(Sender: TObject);
    procedure M_Support_ReportClick(Sender: TObject);
    procedure M_Suuport_InputClick(Sender: TObject);
    procedure M_Support_CanClick(Sender: TObject);
    procedure M_Support_ExpertClick(Sender: TObject);
    procedure M_Support_CalClick(Sender: TObject);
    procedure Memu_Support_UsedInfoClick(Sender: TObject);
    procedure M_YKLH_InputClick(Sender: TObject);
    procedure M_YKLH_ReportClick(Sender: TObject);
    procedure TB_GzmClick(Sender: TObject);
    procedure TB_ZkClick(Sender: TObject);
    procedure TB_CSWTClick(Sender: TObject);
    procedure TB_BCJYClick(Sender: TObject);
    procedure TB_BCZJClick(Sender: TObject);
    procedure TB_ZHPJClick(Sender: TObject);
    procedure TB_ZJReportClick(Sender: TObject);
    procedure M_HELP_VersionClick(Sender: TObject);
    procedure M_Basic_SystemCanshuClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure M_Basic_Data_tranferClick(Sender: TObject);
    procedure M_HELP_HELP1Click(Sender: TObject);

    procedure M_YKLH_SanWeiClick(Sender: TObject);
    procedure M_MN_SanWeiClick(Sender: TObject);
    procedure M_Input_CADUsedClick(Sender: TObject);
    procedure YKLH_ReportClick(Sender: TObject);
    procedure YkLh_InputClick(Sender: TObject);
    procedure KY_ConTourClick(Sender: TObject);
    procedure KY_FootageClick(Sender: TObject);
    procedure KY_EditDataClick(Sender: TObject);
    procedure TB_InputFootageClick(Sender: TObject);
    procedure TB_CoalClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure KY_BatInputDataClick(Sender: TObject);
    procedure TB_Bat_InputDataClick(Sender: TObject);
    procedure TB_Edit_KYDataClick(Sender: TObject);
    procedure TB_ZJ_REportClick(Sender: TObject);
    procedure TB_LH_REportClick(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure KY_LineGraphClick(Sender: TObject);
    procedure M_Basic_WholeScreenClick(Sender: TObject);
    procedure M_Basic_WebDataBaseClick(Sender: TObject);
    procedure M_Basic_UpdateCoalBmpClick(Sender: TObject);
  private
    { Private declarations }
    DllFormHandle:THandle;
    ExePath:AnsiString;
    StatusCaption:string;
    pUser:pUserRecord;
    ConnectedDataBase:Boolean;
    SendEmail_Type:string;
    WetherTest:Boolean;

    function GetVersion:String;
    function SetWindowsBlack(CaptionId:integer):string;
    function  CreateDLLClass:Boolean;
    procedure FreeDLLClass;
    procedure MemuItemClick(MemuName:String);
    procedure SetMuemIsNotVisUal(Value:Boolean);
    procedure SetStatusBarDisplay;
    procedure CreateSaveBmpDirectory;
    procedure ReportEvent(ReportName:string);
    procedure LicensingOpenWindows(OpenString:String);
    function  TestVersionLicensing:Boolean;
    function  TestVersion(Lic:Boolean):Boolean;

    procedure SetSnapData(Value:Boolean;SnapIP:String);
    procedure SetUpdatCoalBmp(Value:Boolean);
    // 调整DPI显示
    procedure WMDpiChanged(var Message: TMessage); message WM_DPICHANGED;
  public
      UserWin:TDefine_WinFrame; {用户DLL类}
      CallPStope:TDefine_CallPStope;
      Call_MapDll:TDefine_MapDll;
      Call_RockPress:TDefine_RockPress;
      Longin_i,sqlTag:integer;
      SystemVersion:String;
      WholeScreen:integer;
      function ConnectDataBase:Boolean;
      function OpenUserInfoWin(WinName:String;AHandle:THandle):Boolean;
      Procedure SetUserInfo(User_Id,User_Name: string;Admin:Boolean);
      function ReturnUserList(DataType:Integer):AnsiString;
      function  UserPasswordVifty(User_ID,UserName:String):Boolean;
      function GetWinFormIsExsit(WinForm:String):Boolean;
      function GetCaptionAndVersion(var Cap:string):String;
      function GetTestState:Boolean;
      procedure PrevRunWholeForm;
      procedure RefreshUsedInformation;
      procedure SetWholeScreen(Value:integer);
  end;

var
  MainCForm: TMainCForm;

implementation

{$R *.dfm}

uses   Lu_Public_BasicModual, BanBen_Wf,ShellApi, VerFityDataComm, FormMonitor;
{引用  'LibWinFrame.dll'， 为 UserWin:TWinFrame 服务}
function TuseWin:TClassStateMent_WinFrame; external 'LibWinFrame.dll' ;
{引用  'LibCallPstope.dll'， 为 TuserCallPstope 服务}
function TCallPStope:TClassStateMent_CallPStope; external 'LibCallPStope.dll' ;
{引用  'LibMapDll.dll'， 为 TCallMmapDll 服务}
function TCallMapDll:TClassStateMent_MapDll; external 'LibMapDll.dll' ;
{引用  'LibRockPress.dll'， 为 TCallRockPress 服务}
function TCallRockPress:TClassStateMent_RockPress; external 'LibRockPress.dll' ;

//
procedure SendMuliEmail;   //启动服务
var
   UT:Pansichar;
begin
    try
        UT:=Pansichar(AnsiString(MainCForm.SendEmail_Type));
      //  MainCForm.CallPStope.SendEmail('CoalRockPress@163.com','sdust2018',UT);
    finally

    end;
end;

//============TMainCForm




procedure TMainCForm.M_HELP_VersionClick(Sender: TObject);
begin

    if Assigned(BanBen) then    FreeandNil(BanBen);
      BanBen:=TBanBen.Create(nil);
      BanBen.ParentWindow:=MainCForm.Handle;
      BanBen.Show;

end;

function TMainCForm.ConnectDataBase: Boolean;
var
  DataType,IP,Password,Port,User,DataBase:String;
  intPort:Integer;
begin
   Result:=False;
   if not Public_Basic.ReadDataBaseType(DataType) then exit;
   if not Public_Basic.ReadMySqlDataBase(DataType,IP,User,Password,Port,DAtaBase)  then
           exit;
   if Port<> '' then   begin
      intPort:=StrToInt(Port);
   end else begin
      intPort:=0;
   end;

   if  not Assigned(UserWin)  then exit;
   if  UserWin.ConnectDataBase(     PansiChar(AnsiString(DataType)),
                                         PansiChar(AnsiString(DataBase)),
                                         PansiChar(AnsiString(Ip)),
                                         intPort,
                                         PansiChar(AnsiString(User)),
                                         PansiChar(AnsiString(Password))
                                      ) then  begin
                 Result:=True;
                 ConnectedDataBase:=True;
    end;

end;


function TMainCForm.CreateDLLClass: Boolean;
var
  UN:PansiChar;
begin
   Result:=true;
   try
       if not Assigned(Public_Basic) then begin
          Public_Basic:=TLu_BasicClass.Create('','serverinfo.dll');
          Public_Basic.SetStatusCaption(StatusCaption);
          Public_Basic.InitStatusBar(self.StatusBar1);
       end;
       {'LibWinFrame.dll' 的外部类}
       if not Assigned(UserWin) then begin
          UserWin:=TuseWin.Create ;
          UserWin.SetStatuesCaption(PansiChar(Ansistring(StatusCaption)));
       end;
//       {'LibCallPstope.dll' 的外部类}
       if not Assigned(CallPStope) then  begin
           CallPStope:=TCallPstope.Create ;
           CallPStope.SetStatuesCaption(PansiChar(Ansistring(StatusCaption)));
           Public_Basic.Licensing :=CallPStope.VerFityUserName(UN);
           Public_Basic.UseUnitName :=strPas(UN);
       end;
       {LibMapDll.dll的外部类  Call_MapDll}
        if not Assigned(Call_MapDll) then  begin
           Call_MapDll:=TCallMapDll.Create ;
          // Call_MapDll.SetStatuesCaption(PansiChar(Ansistring(StatusCaption)));
       end;
       {LibRockPress.dll 的 外部类 Call_RockPress}
       if not Assigned(Call_RockPress) then  begin
           Call_RockPress:=TCallRockPress.Create ;
           Call_RockPress.SetStatuesCaption(PansiChar(Ansistring(StatusCaption)));
           Call_RockPress.SetPublic_BasicLicending(Public_Basic.Licensing,
                                   PansiChar(Ansistring(Public_Basic.UseUnitName))  );
       end;
       //系统初始化
       RefreshUsedInformation;
       Public_Basic.InitStatusBar(self.StatusBar1);
       SetStatusBarDisplay;
       CreateSaveBmpDirectory;//创建临时保存的文件夹
   except
       Result:=FaLse;
   end;
end;

procedure TMainCForm.CreateSaveBmpDirectory;
var
  path:Ansistring;
begin
   path:=Public_Basic.Get_MyModulePath+'SaveBMP\FYYD\';
   if not DirectoryExists(path) then begin
       ForceDirectories(path);
    end;

   path:=Public_Basic.Get_MyModulePath+'SaveBMP\KYJG\';
   if not DirectoryExists(path) then begin
       ForceDirectories(path);
    end;
   path:=Public_Basic.Get_MyModulePath+'SaveBMP\KYFX\';

   if not DirectoryExists(path) then begin
       ForceDirectories(path);
    end;

end;


procedure TMainCForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  try
    if Application.MessageBox(pchar('确定退出模拟系统么？'), '提示', MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDYES then begin
         if Assigned(MonitorForm) then begin
            //MonitorForm.SetCloseQuery;
            MonitorForm.Close ;
         end;
        CanClose:=true;
    end else begin
        CanClose:=False;
    end;
  finally

  end;
end;

procedure TMainCForm.FormCreate(Sender: TObject);
var
  SnapIp,SnapPort:string;
begin
    Set8087CW($133f); { Disable all fpu exceptions }
    MainCForm.Longin_i:=2;
    New(PUser);
     { MainCForm.Longin_i:=2;  用户登录界面
      MainCForm.Longin_i:=1;  没有用户登录界面
     }
    StatusCaption:='山东科技大学宋振骐院士团队研发 CopyRight (2004-2020)';
    ExePath:=ExtractFilePath(Application.Exename);
    if not CreateDLLClass then      exit;
    //获取背景与标题
    SystemVersion:=GetVersion;
    ConnectedDataBase:=False;
    WholeScreen:=0;
    SetWholeScreen(Public_Basic.ReadDisplayWholeScreen) ;

    SetSnapData(Public_Basic.ReadSnapData(SnapIp,SnapPort),SnapIp);
    SetUpdatCoalBmp(False);
    //

end;



procedure TMainCForm.FormDestroy(Sender: TObject);
begin
try
   FreeDLLClass;
   Dispose(PUser);
finally

end;
end;

procedure TMainCForm.FormResize(Sender: TObject);
begin
     SetStatusBarDisplay;
     PrevRunWholeForm ;
end;

procedure TMainCForm.FormShow(Sender: TObject);
var
   ID: DWORD;
   Test_Str:String;
begin
   WindowState := wsMaximized;
  
   //软件的测试版本
   if Public_Basic.GetTestInfomation ='0' then  begin
      Public_Basic.WriteTestAndOriginal('test');
      TestVersion(true);
   end else if Public_Basic.GetTestInfomation ='Origlani' then  begin
      TestVersion(false);
   end else begin
      TestVersion(true);
   end;

   if not  ConnectedDataBase  then   ConnectDataBase;
 // 系统测试版本的 限制
   if not TestVersionLicensing then  begin
       //发送Email
       SendEmail_Type:='OutTest';
       CreateThread(nil, 0, @SendMuliEmail, nil, 0, ID);
       SystemVersion:=self.SetWindowsBlack(2);
   end ;
   // 控制菜单条显示
   SetMuemIsNotVisUal(False);
   //
   Call_RockPress.SetPublic_BasicLicending(Public_Basic.Licensing,
                                   PansiChar(Ansistring(Public_Basic.UseUnitName))  );



end;

procedure TMainCForm.FreeDLLClass;
begin

    if Assigned(CallPStope) then  FreeAndNil(CallPStope);
    if Assigned(Call_MapDll) then FreeAndNil(Call_MapDll);
    if Assigned(Call_RockPress) then FreeAndNil(Call_RockPress);
    if Assigned(UserWin) then  FreeAndNil(UserWin);
//    if Assigned(Public_Basic) then  FreeAndNil(Public_Basic);
//    if Assigned(UserWin) then  UserWin.Destroy ;
//    if Assigned(Public_Basic) then  Public_Basic.Destroy;
//    if Assigned(CallPStope) then  CallPStope.Destroy;
//    if Assigned(Call_MapDll) then Call_MapDll.Destroy;
//    if Assigned(Call_RockPress) then Call_RockPress.Destroy;

end;



function TMainCForm.GetCaptionAndVersion(var Cap: string): String;
var
  BmpFile,Capt,Version:string;
  Captionid:integer;
begin
   Captionid:=Public_basic.ReadMainFormVersion(Captionid,Version);
   Cap:=Caption;
   if Version='' then  Version:='3.1';

   Result:=Version;
end;

function TMainCForm.GetTestState: Boolean;
begin
   Result:=WetherTest;
end;

function TMainCForm.GetVersion: String;
var
  Version:string;
  Captionid:integer;
begin
   Captionid:=Public_basic.ReadMainFormVersion(Captionid,Version);
   if Captionid=0 then begin
      Captionid:=4;
      Public_basic.WriteMainFormVersion('4','3');
   end;
   Result:=SetWindowsBlack(Captionid);

end;

function TMainCForm.GetWinFormIsExsit(WinForm: String): Boolean;
begin
   Result:=UserWin.GetWinFormIsExsit(PansiChar(AnsiString(WinForm)));
end;



procedure TMainCForm.KY_BatInputDataClick(Sender: TObject);
begin
   MemuItemClick('BatInputData');
end;

procedure TMainCForm.KY_EditDataClick(Sender: TObject);
begin
  MemuItemClick('InputRockData');
end;

procedure TMainCForm.KY_FootageClick(Sender: TObject);
begin
   MemuItemClick('InputFootage');
end;

procedure TMainCForm.KY_LineGraphClick(Sender: TObject);
begin
    MemuItemClick('RockLineGraph');
end;

procedure TMainCForm.KY_ConTourClick(Sender: TObject);
begin
   MemuItemClick('RockPressGraph');
end;

procedure TMainCForm.LicensingOpenWindows(OpenString: String);
begin
   if not Public_Basic.Licensing then   begin
        Application.MessageBox(pwidechar('为了保护知识产权，请您获取正版授权！'), '提示',MB_OK +MB_ICONINFORMATION);
        exit;
   end;

   if OpenString='SupportWeigth' then
      MemuItemClick('SupportWeigth');
   if OpenString='CallMapWindows' then
      MemuItemClick('CallMapWindows');


end;

procedure TMainCForm.MemuItemClick(MemuName: String);
begin
  try
   {CoalName}
   if MemuName='CoalName' then begin
      DllFormHandle:=UserWin.CreateCoalName(MainWindows.Handle,
                '煤矿基本信息维护',BackImage.Width,BackImage.Height);
   end;
   {DrillBasicInfo}
   if MemuName='DrillBasicInfo' then begin
      DllFormHandle:=UserWin.CreateZkBasic(MainWindows.Handle,
                '钻孔基本信息维护',BackImage.Width,BackImage.Height);
   end;
   {DrillDetailInfo}
   if MemuName='DrillDetailInfo' then begin
      DllFormHandle:=UserWin.CreateZkDetail(MainWindows.Handle,
                '钻孔详细信息维护',BackImage.Width,BackImage.Height);
   end;
   {WorkFaceInfo}
   if MemuName='WorkFaceInfo' then begin
      DllFormHandle:=UserWin.CreateWorkFace(MainWindows.Handle,
                '工作面基本信息维护',BackImage.Width,BackImage.Height);
   end;
   {SupportInfo}
   if MemuName='SupportInfo' then begin
      DllFormHandle:=UserWin.CreateSupport(MainWindows.Handle,
                ' 支架基本信息维护',BackImage.Width,BackImage.Height);
   end;
   {WorkFaceLinkDrill}

   if MemuName='WorkFaceLinkDrill' then begin
      UserWin.CreateGzmLinkZk(MainWindows.Handle,
                '工作面与钻孔信息绑定',BackImage.Width,BackImage.Height);
   end;
   {UserManager}
   if MemuName='UserManager' then begin
      UserWin.CreateUserAdmin(MainWindows.Handle,
               '用户信息管理',BackImage.Width,BackImage.Height);
   end;
   {UserINFoDisPlay}
   if MemuName='UserINFoDisPlay' then begin
      DllFormHandle:=UserWin.CreateUserINFO(MainWindows.Handle,'用户信息展示',
              PansiChar(Ansistring(Puser.UserName)),BackImage.Width,BackImage.Height);
   end;
   {CallMechanicalModel}
   if MemuName='CallMechanicalModel' then begin
      UserWin.CreateSelectedWorkFaceINFo(MainWindows.Handle,
              '调用力学模型进行工作面选择',BackImage.Width,BackImage.Height,0);
   end;
   {BmpToSqliteDataBase}
   if MemuName='BmpToSqliteDataBase' then begin
      UserWin.CreateBmpToSqlite(MainWindows.Handle,
               '系统使用基本图例维护',BackImage.Width,BackImage.Height);
   end;
    {YKLH_jingji_Input}
   if MemuName='YKLH_jingji_Input' then begin
      DllFormHandle:=UserWin.CreatYklh_Form(MainWindows.Handle,
               '沿空留巷经济参数录入',BackImage.Width,BackImage.Height);
   end;
   {DataTableTranfer}
    if MemuName='DataTableTranfer' then begin
      DllFormHandle:=UserWin.CreateConfiDataBase(MainWindows.Handle,
               '数据表数据转移',BackImage.Width,BackImage.Height,0);
   end;
   {WorkFACECAD}
   if MemuName='WorkFACECAD' then begin
      DllFormHandle:=UserWin.CreateCADImage(MainWindows.Handle,
               '采煤工作面空间关系矢量化制作',BackImage.Width,BackImage.Height);
   end;



   //==============================================
    {ReportSupport}
   if MemuName='ReportSupport' then begin
      ReportEvent('ReportSupport'); //打印液压支架选型报告
   end;
   {ReportYklhInfo}
   if MemuName='ReportYklhInfo' then begin
      ReportEvent('ReportYklhInfo'); //打印液压支架选型报告
   end;

   //=================================================
   {CallPStope_OpenFyyd}
   if MemuName='OpenFyyd' then begin
      CallPStope.OpenFyyd(MainWindows.Handle,
               '覆岩运动规律展示',BackImage.Width,BackImage.Height,0);
   end;
   {OpenDTFZ}
   if MemuName='OpenDTFZ' then begin
      CallPStope.OpenDTFZ(MainWindows.Handle,
               '采场上覆岩层运动模拟仿真',BackImage.Width,BackImage.Height,0);
   end;
   {OpenZCYL}
   if MemuName='OpenZCYL' then begin
      CallPStope.OpenZCYL(MainWindows.Handle,
               '采场支承压力三维仿真模拟',BackImage.Width,BackImage.Height,0);
   end;

   {SupportWeigth}
   if MemuName='SupportWeigth' then begin
      CallPStope.OpenSupportWeigth(MainWindows.Handle,
               '液压支架选型参数修订界面',BackImage.Width,BackImage.Height);
   end;
   {DispCalEavResult}
    if MemuName='DispCalEavResult' then begin
      CallPStope.DispCalEavResult(MainWindows.Handle,
               '液压支架结构件专家评议结果',BackImage.Width,BackImage.Height);
   end;
  {SupportSubject}
   if MemuName='SupportSubject' then begin
      CallPStope.OpenSupportSubject(MainWindows.Handle,
               '液压支架结构件补充措施维护界面',BackImage.Width,BackImage.Height);
   end;
   {EditPStopeWindows}
    if MemuName='EditPStopeWindows' then begin
      CallPStope.OpenEditPstope(MainWindows.Handle,
               '液压支架计算参数微调界面',BackImage.Width,BackImage.Height,0);
   end;
   
  //=========================
   {CallMapWindows}
   if MemuName='CallMapWindows' then begin
      Call_MapDll.OpenMapWindows(MainWindows.Handle,
               '液压支架使用情况维护',BackImage.Width,BackImage.Height);
   end;
  //---------------------------------
  {BatInputData}
   if MemuName='BatInputData' then begin
      Call_RockPress.CreateBatInputD(MainWindows.Handle,
               '批量导入矿山压力数据',BackImage.Width,BackImage.Height,0);
   end;
  {InputFootage}
   if MemuName='InputFootage' then begin
      DllFormHandle:=Call_RockPress.CreateEditJinDao(MainWindows.Handle,
               '工作面进刀信息维护',BackImage.Width,BackImage.Height,1);

   end;
    {InputRockData}
   if MemuName='InputRockData' then begin
      DllFormHandle:=Call_RockPress.CreateEditFootage_Data(MainWindows.Handle,
               '工作面进尺与矿压数据录入',BackImage.Width,BackImage.Height,2);
   end;
    {RockPressGraph}
   if MemuName='RockPressGraph' then begin
      DllFormHandle:=Call_RockPress.CreateRockPressGraph(MainWindows.Handle,
               '矿山压力综合分析界面',BackImage.Width,BackImage.Height,3);
   end;
   {RockLineGraph}
   if MemuName='RockLineGraph' then begin
      DllFormHandle:=Call_RockPress.CreateRockLineGraph(MainWindows.Handle,
               '液压支架压力曲线图显示界面',BackImage.Width,BackImage.Height,0);
   end;
  except
     //利用本身界面冲击一下
     {DataTableTranfer}
    if MemuName='DataTableTranfer' then begin
      DllFormHandle:=UserWin.CreateConfiDataBase(MainWindows.Handle,
               '数据表数据转移',BackImage.Width,BackImage.Height,0);
   end;

  end;

end;

procedure TMainCForm.M_Basic_CallModuleClick(Sender: TObject);
begin
    OpenUserWindow_Timer.Enabled :=true;
    MemuItemClick('CallMechanicalModel');
end;

procedure TMainCForm.M_Basic_Data_tranferClick(Sender: TObject);
begin
  MemuItemClick('DataTableTranfer');
end;

procedure TMainCForm.M_Basic_SystemCanshuClick(Sender: TObject);
begin
   MemuItemClick('showSystemCanCanshu');
end;

procedure TMainCForm.M_Basic_UpdateCoalBmpClick(Sender: TObject);
begin
   SetUpdatCoalBmp(true);
end;

procedure TMainCForm.M_Basic_UserInfoClick(Sender: TObject);
begin
   MemuItemClick('UserINFoDisPlay');
end;

procedure TMainCForm.M_Basic_UserManagerClick(Sender: TObject);
begin
     MemuItemClick('UserManager');
end;

procedure TMainCForm.M_Basic_WebDataBaseClick(Sender: TObject);
var
  snapIP,snapPort:String;
begin
   SetSnapData(not Public_Basic.ReadSnapData(snapIP,snapPort),snapIP);
end;

procedure TMainCForm.M_Basic_WholeScreenClick(Sender: TObject);
begin
   WholeScreen:=Public_Basic.ReadDisplayWholeScreen;
   if WholeScreen< 1 then begin
      WholeScreen:=1;
      Public_Basic.WriteDisplayWholeScreen(WholeScreen);
   end;

   if WholeScreen >0 then begin
      CreateMonitorForm(MainWindows.Handle,
                '基本监控界面',BackImage.Width,BackImage.Height,1);
   end else begin
     if Assigned(MonitorForm) then
         MonitorForm.Close;
   end;


end;

procedure TMainCForm.M_Input_CADUsedClick(Sender: TObject);
begin
  MemuItemClick('WorkFACECAD');
end;

procedure TMainCForm.M_Input_CoalNameClick(Sender: TObject);
begin
    MemuItemClick('CoalName');
end;

procedure TMainCForm.M_Input_DrillInfoClick(Sender: TObject);
begin
   MemuItemClick('DrillBasicInfo');
end;

procedure TMainCForm.M_Input_DrillLinkGzmClick(Sender: TObject);
begin
   MemuItemClick('WorkFaceLinkDrill');
end;

procedure TMainCForm.M_Input_Drill_DetailInfoClick(Sender: TObject);
begin
   OpenUserWindow_Timer.Enabled :=true;
   MemuItemClick('DrillDetailInfo');
end;

procedure TMainCForm.M_Input_SuooprtInfoClick(Sender: TObject);
begin
   MemuItemClick('SupportInfo');
end;

procedure TMainCForm.M_Input_WorkFaceInfoClick(Sender: TObject);
begin
  OpenUserWindow_Timer.Enabled :=true;
  MemuItemClick('WorkFaceInfo');
end;


Procedure TMainCForm.M_MN_FyydClick(Sender: TObject);
begin
    MemuItemClick('OpenFyyd');
end;

procedure TMainCForm.M_MN_MNKCClick(Sender: TObject);
begin
  MemuItemClick('OpenDTFZ');
end;

procedure TMainCForm.M_MN_SanWeiClick(Sender: TObject);
begin
   MemuItemClick('OpenZCYL');
end;

procedure TMainCForm.M_Support_CalClick(Sender: TObject);
begin
   MemuItemClick('EditPStopeWindows');
end;

procedure TMainCForm.M_Support_CanClick(Sender: TObject);
begin
   MemuItemClick('DispCalEavResult');
end;

procedure TMainCForm.M_Support_ExpertClick(Sender: TObject);
begin
  MemuItemClick('SupportSubject');
end;

procedure TMainCForm.M_Support_ReportClick(Sender: TObject);
begin
  MemuItemClick('ReportSupport');
end;

procedure TMainCForm.M_Suuport_InputClick(Sender: TObject);
begin
   LicensingOpenWindows('SupportWeigth');

end;

procedure TMainCForm.M_YKLH_InputClick(Sender: TObject);
begin
   MemuItemClick('YKLH_jingji_Input');
end;

procedure TMainCForm.M_YKLH_ReportClick(Sender: TObject);
begin
   MemuItemClick('ReportYklhInfo');
end;

procedure TMainCForm.M_YKLH_SanWeiClick(Sender: TObject);
begin
  Application.MessageBox(pwidechar('该功能即将推出，请持续关注！'), '提示',MB_OK +MB_ICONINFORMATION);
end;

procedure TMainCForm.N11Click(Sender: TObject);
begin
   MemuItemClick('BmpToSqliteDataBase');
end;

procedure TMainCForm.N12Click(Sender: TObject);
begin
  ShellExecute(0, 'Open', Pchar('RockPressAnsyis.chm'), nil, nil, SW_SHOWNORMAL);
end;

procedure TMainCForm.YkLh_InputClick(Sender: TObject);
begin
  MemuItemClick('YKLH_jingji_Input');
end;

procedure TMainCForm.YKLH_ReportClick(Sender: TObject);
begin
   MemuItemClick('ReportYklhInfo');
end;

procedure TMainCForm.Memu_Support_UsedInfoClick(Sender: TObject);
begin
  LicensingOpenWindows('CallMapWindows');

end;

procedure TMainCForm.N9Click(Sender: TObject);
begin
  Close;
end;

function TMainCForm.OpenUserInfoWin(WinName:String;AHandle: THandle): Boolean;
begin
   Result:=False;

   if WinName='NewUser' then begin
      if not ConnectDataBase then exit;
      UserWin.CreateUserINFO(AHandle,'新用户注册界面','',0,0);
   end;
   if WinName='ConfigDateBase' then
      UserWin.CreateConfiDataBase(AHandle,'远程数据库配置界面',0,0,1);

   Result:=True;
end;

procedure TMainCForm.OpenUserWindow_TimerTimer(Sender: TObject);
begin
    if  (not UserWin.GetWinFormIsExsit('CallMechanicalModel') )
       and (not UserWin.GetWinFormIsExsit('WorkFaceInfo'))
       and (not UserWin.GetWinFormIsExsit('DrillDetailInfo'))
     then  begin
        OpenUserWindow_Timer.Enabled :=False;
        self.CallPStope.SetReCallPStope(true);
        self.RefreshUsedInformation ;
     end;

end;

procedure TMainCForm.PrevRunWholeForm;
begin
    // 监控界面的显示
   WholeScreen:=Public_Basic.ReadDisplayWholeScreen ;
   if WholeScreen >0 then   begin
          if not Assigned(MonitorForm) then
          CreateMonitorForm(MainWindows.Handle,
                '基本监控界面',BackImage.Width,BackImage.Height,1);

       Main_CoolBar.Visible:=False;
   end else begin
      if  Assigned(MonitorForm) then MonitorForm.Close ;
   end;

end;

procedure TMainCForm.RefreshUsedInformation;
VAr
  AdminB:String;
begin
   Public_Basic.ReadLoginInfo('UserInFormation',PUser.UserName,PUser.UserId,AdminB);
   if AdminB='1' then PUser.Admin :=true else PUser.Admin :=False;
   Public_Basic.ReadUsedMeiKuangInfo('UsedCoalInfo',PUser.Coal_id,PUser.Coal_Name,
            PUser.Workface_id,PUser.WorkFace_Name,PUser.Drill_id,PUser.Drill_Name);
   if Trim(PUser.Coal_Name)<>'' then
       StatusBar1.Panels[1].Text:='你现在模拟的是【'+PUser.Coal_Name+'煤矿内_'+PUser.WorkFace_Name+'】采煤工作面';
end;

procedure TMainCForm.ReportEvent(ReportName: string);
var
 t_s:widestring;
begin
    t_s:='打印报告是通过调用系统OFFICE来实现输出'+#13#10 +
         '启动OFFICE 会耗费一点的时间，你确认么?';
    if Application.MessageBox(Pwidechar(t_s),'特别提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;
   {ReportSupport}
   if ReportName='ReportSupport' then begin
      CallPStope.GetReportSupport(MainWindows.Handle);
   end;
   {ReportYklhInfo}
  if ReportName='ReportYklhInfo' then begin
      CallPStope.GetReportYKlh(MainWindows.Handle);
  end;

end;

function TMainCForm.ReturnUserList(DataType: Integer): AnsiString;
begin
   Result:=StrPas(UserWin.ReturnUserList(DataType));
end;


procedure TMainCForm.SetMuemIsNotVisUal(Value: Boolean);
var
  ID: DWORD;
begin
   // 巷道基本信息维护
    M_Input_HangDaoInfo.Visible :=Value;
   // 为完成封堵的菜单
    KY_Report.Visible :=false;         //   矿压报告

   if PUser.Admin then begin  //如果是管理员
      //    用户管理
       M_Basic_UserManager_TopLine.Visible :=not Value;
       M_Basic_UserManager.Visible :=not Value;
       M_Basic_Data_tranfer.Visible :=not Value;
   end else begin //如果是普通用户
      //    用户管理
       M_Basic_UserManager_TopLine.Visible := Value;
       M_Basic_UserManager.Visible := Value;
       M_Basic_Data_tranfer.Visible := Value;
   end;
   {   5 Result:='SHENDONG';
       4 Result:='SONGZHENGQI';
       3 Result:='KYFX';
       2 Result:='FYYD';
       1 Result:='ZMJ';
   }
   if SystemVersion='ZMJ' then  begin
      // 一级菜单
      M_KYFx.Visible :=False;
      // 工具栏
      Main_CoolBar.Bands[2].Visible :=False; //矿压分析

   end else  if SystemVersion='FYYD' then  begin
       // 一级菜单
      M_KYFx.Visible :=False;
      M_Support.Visible :=False;
      // 工具栏
      Main_CoolBar.Bands[2].Visible :=False; //矿压分析
      Main_CoolBar.Bands[3].Visible :=False; //矿压分析

   end else  if SystemVersion='KYFX' then  begin
       // 一级菜单
      M_KYFx.Visible :=False;
      // 工具栏
      Main_CoolBar.Bands[2].Visible :=False; //矿压分析
   end else  if SystemVersion='SONGZHENGQI' then  begin
      WholeScreen:=Public_Basic.ReadDisplayWholeScreen;
      // DispLayAll
   end else  if SystemVersion='SHENDONG' then  begin
       //一级菜单
       M_Basic.Visible :=False;          // 系统基本参数
       M_Support.Visible :=False;    // 安全参数设计
       M_Fyyd.Visible :=False;              //      矿压规律展示
       // 二级菜单
       M_Input_DrillInfo.Enabled :=false;  //  钻孔信息
      // M_Input_Drill_DetailInfo.Enabled :=False; //  钻孔详细信息
      // M_Input_HangDaoInfo.Enabled :=false;  //    巷道信息
       M_Input_CADUsed.Enabled :=False;     //     CAD 界面
      // M_Input_DrillLinkGzm.Enabled :=False; //    钻孔绑定工作面
        // 工具栏
       Main_CoolBar.Bands[1].Visible :=False; //覆岩运动
       Main_CoolBar.Bands[3].Visible :=False; //液压支架
       TB_ZK.Visible :=False; //钻孔信息
       //发送Email
       SendEmail_Type:='UseShenDong';
       CreateThread(nil, 0, @SendMuliEmail, nil, 0, ID);
   end;

end;

procedure TMainCForm.SetSnapData(Value: Boolean;SnapIP:String);
begin

   if Value then begin
      M_Basic_WebDataBase.Caption:='禁用网络数据库';
      public_Basic.WriteSnapData(Value,SnapIP,'211');
   end else begin
      M_Basic_WebDataBase.Caption:='启用网络数据库';
   end;

end;

procedure TMainCForm.SetStatusBarDisplay;
begin

    StatusBar1.Panels[0].Text:='欢迎你【'+PUser.UserName+'】光临';
    if Trim(PUser.Coal_Name)<>'' then
       StatusBar1.Panels[1].Text:='你现在模拟的是【'+PUser.Coal_Name+'煤矿内_'+PUser.WorkFace_Name+'】采煤工作面';

    StatusBar1.Panels[2].Text:= StatusCaption  ;

end;

procedure TMainCForm.SetUpdatCoalBmp(Value: Boolean);
begin
    {M_Basic_UpdateCoalBmp}
   public_Basic.WriteUpdateCoalBmp(Value);
   if Value then begin
      M_Basic_UpdateCoalBmp.Caption:='不更新本地煤矿图片';
   end else begin
      M_Basic_UpdateCoalBmp.Caption:='更新本地煤矿图片';
   end;
end;

procedure TMainCForm.SetUserInfo(User_Id, User_Name: string;Admin:Boolean);
begin
    pUser.UserName:=User_Name;
    pUser.UserId :=User_id;
    pUser.Admin :=Admin;
    UserWin.SetUsetInformation(PansiChar(AnsiString(User_Id)),PansiChar(AnsiString(User_Name)),Admin );
    CallPStope.SetUsetInformation(PansiChar(AnsiString(User_Id)),PansiChar(AnsiString(User_Name)),Admin );
    Call_MapDll.SetUsetInformation(PansiChar(AnsiString(User_Id)),PansiChar(AnsiString(User_Name)),Admin );
    //

end;


procedure TMainCForm.SetWholeScreen(Value: integer);
begin
   WholeScreen:=Value;
   public_Basic.WriteDisplayWholeScreen(WholeScreen) ;

   if Value >0 then begin
      M_Basic_WholeScreen.Caption:='禁用监控全屏显示';
   end else begin
      M_Basic_WholeScreen.Caption:='启用监控全屏显示';
      if Assigned(MonitorForm) then    MonitorForm.Close ;
   end;

end;

function TMainCForm.SetWindowsBlack(CaptionId:integer):string;
var
  BmpFile,Capt:PansiChar;
begin
  Capt:=UserWin.GetMainFormVersion(Captionid,BmpFile);
  BackImage.Picture.LoadFromFile(Public_basic.Get_MyModulePath +'BJTP/'+strPas(BmpFile));
  Caption :=strpas(Capt);

   if Captionid =5 then   begin
      Result:='SHENDONG';
   end else if Captionid =4 then begin
      Result:='SONGZHENGQI';
   end else if Captionid =3 then begin
      Result:='KYFX';
   end else if Captionid =2 then begin
      Result:='FYYD';
   end else if  Captionid =1 then begin
      Result:='ZMJ';
   end;


end;

procedure TMainCForm.M_HELP_HELP1Click(Sender: TObject);
begin
   ShellExecute(0, 'Open', Pchar('CoalRockDescription.chm'), nil, nil, SW_SHOWNORMAL);
end;

procedure TMainCForm.TB_FYYDClick(Sender: TObject);
begin
   M_MN_Fyyd.Click;

end;

procedure TMainCForm.TB_GzmClick(Sender: TObject);
begin
  M_Input_WorkFaceInfo.Click;
end;

procedure TMainCForm.TB_InputFootageClick(Sender: TObject);
begin
   KY_Footage.Click ;
end;

procedure TMainCForm.TB_LH_REportClick(Sender: TObject);
begin
 YKLH_Report.Click ;
end;

procedure TMainCForm.TB_ZHPJClick(Sender: TObject);
begin
  M_Support_Can.Click;
end;

procedure TMainCForm.TB_ZkClick(Sender: TObject);
begin
  M_Input_Drill_DetailInfo.Click ;
end;

function TMainCForm.TestVersion(Lic: Boolean): Boolean;
{ 是不是测试版本}
var
  uName,Permission:string;
begin
   uName:='山东科技大学宋振骐院士技术团队';
   Permission:='00BA-A593-0276-2B59-028E-5FDB-E5E2-49C3';
   if (Lic) and (not Public_Basic.Licensing) then  begin
      public_Basic.WriteVirFityPassword(uName,Permission);
      WetherTest:=true;
      public_Basic.Licensing:=true; {如果是测试版本，把权限付了}
   end else if  (Lic) and (Public_Basic.Licensing) then begin
      WetherTest:=true;
      public_Basic.Licensing:=true; {如果是测试版本，把权限付了}
   end else begin  // 不是测试版本
      WetherTest:=False;
   end;
   Result:=WetherTest;
end;

function TMainCForm.TestVersionLicensing:Boolean;
 var
    VFQ:TMyVerFity;
    LastData:string;
    UN:PansiChar;
    uName,Permission:string;
begin
   { 20180630      MjAxODA2MzA=
     20181231      MjAxODEyMzE=
     20190630      MjAxOTA2MzA=
     20191231      MjAxOTEyMzE=
     20201231      MjAyMDEyMzE=
     }
     Result:=true;
     VFQ:=TMyVerFity.Create;
     VFQ.MYDECode('MjAxODEyMzE=',LastData);
      if (FormatDatetime('yyyymmdd',date())> LastData ) and (WetherTest ) then  begin
         {
           如果时间过了测试期，还是测试版本
         }
         uName:='山东科技大学宋振骐院士技术团队';
         Permission:='00BA-A593-0276-2B59-028E-5FDB-E5E2-49C3';
         public_Basic.WriteVirFityPassword(uName,Permission);
         Application.MessageBox(pwidechar('软件有升级，请你及时更新新版本！'), '提示',MB_OK +MB_ICONINFORMATION);
         Result:=False;

      end;
     VFQ.Free ;
end;

procedure TMainCForm.TB_Bat_InputDataClick(Sender: TObject);
begin
  KY_BatInputData.Click;
end;

procedure TMainCForm.TB_BCJYClick(Sender: TObject);
begin
    self.KY_ConTour.Click ;
end;

procedure TMainCForm.TB_BCZJClick(Sender: TObject);
begin
   Memu_Support_UsedInfo.Click;
end;

Procedure TMainCForm.TB_ChangeDataClick(Sender: TObject);
begin
   M_Basic_CallModule.Click ;
end;

procedure TMainCForm.TB_CoalClick(Sender: TObject);
begin
   M_Input_CoalName.Click ;
end;

procedure TMainCForm.TB_CSWTClick(Sender: TObject);
begin
  M_Support_Cal.Click;
end;

procedure TMainCForm.TB_ZJReportClick(Sender: TObject);
begin
  M_Support_Report.Click;
end;

procedure TMainCForm.TB_ZJ_REportClick(Sender: TObject);
begin
  M_Support_Report.Click;
end;

procedure TMainCForm.ToolButton5Click(Sender: TObject);
begin
   Close;

end;

procedure TMainCForm.TB_DTFZClick(Sender: TObject);
begin
   M_MN_MNKC.Click ;
end;

procedure TMainCForm.TB_Edit_KYDataClick(Sender: TObject);
begin
   KY_EditData.Click ;
end;

function TMainCForm.UserPasswordVifty(User_ID, UserName: String): Boolean;
begin
   Result:=UserWin.UserPasswordVifty(PansiChar(Ansistring(User_ID)),
                                     PansiChar(Ansistring(UserName)));
end;

procedure TMainCForm.WMDpiChanged(var Message: TMessage);

  {$IFDEF DELPHI_STYLE_SCALING}
  function FontHeightAtDpi(aDPI, aFontSize: integer): integer;
  var
    tmpCanvas: TCanvas;
  begin
    tmpCanvas := TCanvas.Create;
    try
      tmpCanvas.Handle := GetDC(0);
      tmpCanvas.Font.Assign(self.Font);
      tmpCanvas.Font.PixelsPerInch := aDPI; //must be set BEFORE size
      tmpCanvas.Font.size := aFontSize;
      result := tmpCanvas.TextHeight('0');
    finally
      tmpCanvas.free;
    end;
  end;
  {$ENDIF}

begin
  inherited;
  {$IFDEF DELPHI_STYLE_SCALING}
  ChangeScale(FontHeightAtDpi(LOWORD(Message.wParam), self.Font.Size), FontHeightAtDpi(self.PixelsPerInch, self.Font.Size));
  {$ELSE}
  ChangeScale(LOWORD(Message.wParam), self.PixelsPerInch);
  {$ENDIF}
  self.PixelsPerInch := LOWORD(Message.wParam);
end;

// 初始化
initialization  {单元初始化代码}
  //创建临界区


finalization    {单元退出时的代码}
//    删除临界区
  


end.
