unit UServiceForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtCtrls,ShellApi,ImgList, ComCtrls, uIRockPress,
  DataCurve,ADODB;

  const
    WM_TrayIcon = WM_USER + 1234;

type
  TServiceForm = class(TForm)
    ImageList1: TImageList;
    Panel1: TPanel;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Label5: TLabel;
    Panel2: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Timer1: TTimer;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N4: TMenuItem;
    N2: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N3: TMenuItem;
    TrayIcon1: TTrayIcon;
    N11: TMenuItem;
    ImageList2: TImageList;
    Button4: TButton;
    Button5: TButton;
    Button2: TButton;
    Button6: TButton;
    Button7: TButton;
    Button3: TButton;
    Button8: TButton;
    N7: TMenuItem;
    Label1: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    ComboBox3: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
    ComboBox4: TComboBox;
    Label12: TLabel;
    ComboBox5: TComboBox;
    Label13: TLabel;
    ComboBox6: TComboBox;
    Label14: TLabel;
    ComboBox7: TComboBox;
    Button1: TButton;
    TabSheet3: TTabSheet;
    Label15: TLabel;
    EditIP: TEdit;
    Label16: TLabel;
    EditUserName: TEdit;
    Label17: TLabel;
    ComboBox8: TComboBox;
    Label18: TLabel;
    EditPw: TEdit;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Timer2: TTimer;
    TabSheet4: TTabSheet;
    Image1: TImage;
    Timer3: TTimer;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
  private
    { Private declarations }
     Recallflag:integer;
     LastTime:TdateTime;
     Scount,PausedCount:integer;
     Adoquery:TADOQuery;
     AdoConn:TADOConnection;
     Objusers:TIRockPress;
     Fcur:DWORD;
     bRestart:Boolean;
     procedure Freshedit;
     procedure FillComboX;
     function ConnectDataBase:Boolean;
     procedure  AddThread;
  public
    { Public declarations }
      IconData: TNotifyIconData;
      procedure AddIconToTray;
      procedure DelIconFromTray;
      procedure AutoRun(Flag: BOOLEAN);
      procedure TrayIconMessage(var Msg: TMessage); message WM_TrayIcon;
      procedure SysButtonMsg(var Msg: TMessage); message WM_SYSCOMMAND;
      procedure WMQueryEndSession(var uMessage:TMessage);message WM_QUERYENDSESSION;
  end;

var
  ServiceForm: TServiceForm;
  gbCanClose: Boolean;
  dowork:tdatacurve;
  V:double;

implementation

uses  winntService,DateUtils,Registry;

{$R *.dfm}


//注意外部引用 dll文件
function TObjUsers:TIRockPressClass; external 'RockPressClass.dll' ;
//
procedure RecallServer;
begin
   Sleep(5000);
   RunServies('RockPressureS');
end;

procedure CallcontrolServer;stdcall;
begin
   Sleep(10000);
   ShellExecute(0, 'open', PChar('ControlServer.exe'), nil, nil, SW_SHOWNORMAL);
  // ShellExecute(0,'open','TestPDll.exe','',nil, SW_SHOWNORMAL);
end;

procedure StopServer;
begin
   StopServies('StopServies');
end;

{ TForm1 }
procedure TServiceForm.AddIconToTray;
begin
        ZeroMemory(@IconData, SizeOf(TNotifyIconData));
        IconData.cbSize := SizeOf(TNotifyIconData);
        IconData.Wnd := Handle;
        IconData.uID := 1;
        IconData.uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
        IconData.uCallbackMessage := WM_TrayIcon;
        IconData.hIcon := Application.Icon.Handle;
        IconData.szTip := '矿压数据分析服务';
        Shell_NotifyIcon(NIM_ADD, @IconData);
       
end;
//为创建线程服务的外部函数
procedure SendHokKey;stdcall;
var
    HDesk_WL: HDESK;
begin
        HDesk_WL := OpenDesktop ('Winlogon', 0, False, DESKTOP_JOURNALPLAYBACK);
        if (HDesk_WL <> 0) then
            if  (SetThreadDesktop (HDesk_WL) = True) then
                  PostMessage(HWND_BROADCAST, WM_HOTKEY, 0, MAKELONG (MOD_ALT or MOD_CONTROL, VK_DELETE));
end;

//-------
procedure TServiceForm.AddThread;
var
   threadid,i:integer;
   mycurve:tcurveinfo;
   r,g,b:byte;
begin
    {threadid:=0;
    ADoQuery.Close ;
    ADoQuery.SQL.Clear ;
    ADoQuery.SQL.Add('select generatetime,threadid,MinNumber from processlog where  generatetime >= '''+
             FormatDateTime('yyyy-mm-dd hh:nn:ss',LastTime)+ ''' order by threadid');
    ADoQuery.Open;
    while not ADoQuery.eof do  begin
        if ADoQuery.FieldByName('threadid').AsInteger <> threadid then   begin
           threadid:=ADoQuery.FieldByName('threadid').AsInteger;
           randomize;
            r:=random(255);
            randomize;
            g:=random(255);
            randomize;
            b:=random(255);
            mycurve.color:=rgb(r,g,b);
            mycurve.width:=1;
            mycurve.id := threadid;
            dowork.AddCurve(mycurve);
        end;
          for i:=0 to dowork.CurveNum- 1 do
            begin
                if dowork.Curveinfo[i].id=threadid then
                   dowork.SetValue(ADoQuery.FieldByName('MinNumber').AsInteger,i);
            end;
        ADoQuery.Next ;
        
    end;
      LastTime:= ADoQuery.FieldByName('generatetime').AsDateTime;
    ADoQuery.Close ;
    }

       for i := 0 to 1 do  begin
            randomize;
            r:=random(255);
            randomize;
            g:=random(255);
            randomize;
            b:=random(255);
            mycurve.color:=rgb(r,g,b);
            mycurve.width:=1;
            dowork.AddCurve(mycurve);
       end;

end;

procedure TServiceForm.AutoRun(Flag: BOOLEAN);
var
    tempreg: TRegistry;
begin
try
      tempreg := TRegistry.Create;
      tempreg.RootKey := HKEY_CURRENT_USER;
      tempreg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run', True);
      if Flag then
          tempreg.WriteString('矿压服务启动', '"' + ParamStr(0) + '"')
      else   begin
          tempreg.DeleteValue('矿压服务启动');
      end;
finally
  tempreg.Closekey;
  tempreg.Free;
end;

end;

procedure TServiceForm.Button10Click(Sender: TObject);
Var
   wstr:string;
begin
   Objusers.SetSerViceInfo(ComboBox8.Text,EditIP.Text,
          EditUserName.Text ,EditPw.Text);
   wstr:='保存成功！';
   MessageBox(ServiceForm.Handle, Pchar(wstr),'提示',MB_OK+ MB_ICONASTERISK);

end;

procedure TServiceForm.Button11Click(Sender: TObject);
begin
     AutoRun(false);
end;

procedure TServiceForm.Button12Click(Sender: TObject);
begin
     AutoRun(True);
end;

procedure TServiceForm.Button1Click(Sender: TObject);
Var
  V1,V2,V3,V4:integer;
  dwThreadID:DWord;
begin
    Objusers.SetTimeInterval(StrToInt(ComboBox1.Text));
    Objusers.SetDataNeverDisCTime(StrToInt(ComboBox2.Text));
    Objusers.SetThreadNumber(StrToInt(ComboBox3.Text));

    V1:=ComboBox4.ItemIndex;
    V2:=ComboBox5.ItemIndex;
    V3:=ComboBox6.ItemIndex;
    V4:=ComboBox7.ItemIndex;
    Objusers.SetSupportDataType(v1,v2,v3,v4);
    
    Objusers.SetiniProcStop(2);
    CreateThread(nil, 0, @StopServer, nil, 0, dwThreadID);
    CreateThread(nil, 0, @RecallServer, nil, 0, dwThreadID);
    FillComboX ;

end;

procedure TServiceForm.Button2Click(Sender: TObject);
begin
   Objusers.SetiniProcStop(1);
   Button6.Enabled :=true;
end;

procedure TServiceForm.Button3Click(Sender: TObject);
var
   dwThreadID : DWORD;
   sOut:boolean;
   WStr:ansiString;
begin
    sOut:=true;
    wStr:='要关闭矿压分析服务与监控么？'+#13#13;
    if MessageBox(ServiceForm.Handle, Pchar(wstr),'提示',MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDNO then exit;
    Objusers.SetiniProcStop(2);
    CreateThread(nil, 0, @StopServer, nil, 0, dwThreadID);
    Close;


end;

procedure TServiceForm.Button4Click(Sender: TObject);
begin
    Objusers.uInstallService;
end;

procedure TServiceForm.Button5Click(Sender: TObject);
begin
    Objusers.uUnInstallService;
end;

procedure TServiceForm.Button6Click(Sender: TObject);
begin 
   Objusers.SetiniProcStop(0);
   Button6.Enabled :=false;
end;

procedure TServiceForm.Button7Click(Sender: TObject);
var
   WStr:ansiString;
begin
    wStr:='要退出矿压分析服务么？'+#13#13+'如重启该项服务，请到客户端启动！';
    if MessageBox(ServiceForm.Handle, Pchar(wstr),'提示',MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDNO then exit;
    Objusers.SetiniProcStop(2);
   
end;

procedure TServiceForm.Button8Click(Sender: TObject);
var
   dwThreadID:DWORD;
begin
    CreateThread(nil, 0, @RecallServer, nil, 0, dwThreadID);
end;

procedure TServiceForm.Button9Click(Sender: TObject);
var
  wStr:String;
begin
     if Objusers.ConnectDataBase(ComboBox8.Text,
          EditIP.Text,EditUserName.Text,EditPw.Text,'')  then  begin
          wStr:='数据库连接成功！';
     end  else begin
          wStr:='数据库连接失败！';
     end;
     MessageBox(ServiceForm.Handle, Pchar(wstr),'提示',MB_OK+ MB_ICONASTERISK);

end;

function TServiceForm.ConnectDataBase: Boolean;
var
  uDtype,Sconn:String;
begin
     uDtype:=ComBoBox8.Text ;
     if (uDtype= 'SQLSERVER') or(uDtype= 'SQL SERVER') then  begin
          sConn    := 'Provider=SQLOLEDB.1;Persist Security Info=True;Connect   Timeout=30 '
                    + ';Data Source='+EditIP.Text
                    + ';Initial Catalog=ROCKPRESS'
                    + ';User ID =' +EditUserName.Text
                    + ';Password='+EditPw.Text
                    + ';Packet Size='+InttoStr(4096)   //一个Integer值，一般是4096
                    + ';';
      end else if (uDtype= 'MYSQL') or (uDtype= 'MY SQL') then  begin
           sConn   :='DRIVER={MySQL ODBC 3.51 Driver}'
                    + ';SERVER='+EditIP.Text
                    + ';DATABASE=ROCKPRESS'
                    + ';USER='+EditUserName.Text
                    + ';PASSWORD='+EditPw.Text
                    + ';OPTION=3'
                    + ';' ;
      end;

         AdoConn.ConnectionString:= sConn;
         AdoConn.Open; 
         Result:=true;
end;

procedure TServiceForm.DelIconFromTray;
begin
     Shell_NotifyIcon(NIM_DELETE, @IconData);
end;

procedure TServiceForm.FillComboX;
Var
 V1,V2,V3,V4,temp:integer;
 Dt,uIP,sUser,uPw:string;
begin
     //
     ComboBox1.Text:=IntToStr(Objusers.GetTimeInterval);
     temp:=Objusers.GetDataNeverDisCTime;
     if (temp>1) and (temp<11 ) then  ComboBox2.ItemIndex:=temp-1
                else ComboBox2.ItemIndex:=0;
     temp:=Objusers.GetThreadNumber;
     if (temp>1)  and (temp <11) then
        ComboBox3.ItemIndex:=temp-1  else ComboBox3.ItemIndex:=0;

     Objusers.GetSupportDt(V1,V2,V3,V4);
     if V1>6  then    V1:=6; if V2>6  then    V2:=6;
     if V3>6  then    V3:=6; if V4>6  then    V4:=6;
     
     ComboBox4.ItemIndex:=V1;
     ComboBox5.ItemIndex:=V2;
     ComboBox6.ItemIndex:=V3;
     ComboBox7.ItemIndex:=V4;

     Objusers.GetServiceInfo(dt,uIP,sUser,uPw);
     if Uppercase(dt)='SQLSERVER' then  ComboBox8.ItemIndex:=0
        else ComboBox8.ItemIndex:=1;
     EditIp.Text :=uIP;
     EditUserName.Text:=sUser;
     EditPw.Text :=uPw;
end;

procedure TServiceForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ID:DWORD;
begin
   Action:=cafree;
   if bRestart then
    //   CreateThread(nil, 0, @CallcontrolServer, nil, 0, ID);
     ShellExecute(0, 'open', PChar('ControlServer.exe'), nil, nil, SW_SHOWNORMAL);
   
end;

procedure TServiceForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
 sOut:Boolean;
begin
   
end;

procedure TServiceForm.FormCreate(Sender: TObject);
begin
    FormStyle := fsStayOnTop; {窗口最前}
    SetWindowLong(Application.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW); {不在任务栏显示} 
    TrayIcon1.ShowBalloonHint ;
    Objusers:=TObjUsers.Create;
    Timer1.Interval := 500;
    Timer1.Enabled := True;
    Recallflag:=0;
    sCount:=0;
    AdoConn:=TADOConnection.Create(nil);
    AdoQuery:=TAdoQuery.Create(nil);
    dowork:=tdatacurve.Create(image1,timer3);
    dowork.Vmax:=15.25;
    dowork.Vmin:=0.405;
    dowork.Speed:=10;
    dowork.GridN:=5;
    dowork.TimeRange:=15;
    dowork.Resume;
    AddThread;
    FillComboX;
    Fcur := Gettickcount;
    bRestart:=false;
    PausedCount:=0;
end;

procedure TServiceForm.FormDestroy(Sender: TObject);
begin

      Timer1.Enabled := False;
      DelIconFromTray;
     // Objusers.Free;
      dowork.Free;
end;

procedure TServiceForm.FormShow(Sender: TObject);
var
  Style: Integer;
begin
  Style := GetWindowLong(Handle, GWL_EXSTYLE);
  SetWindowLong(Handle, GWL_EXSTYLE, Style and (not WS_EX_APPWINDOW));
  ShowWindow(Application.Handle, SW_HIDE);
  gbCanClose := False;

    timer3.Interval:=round(1000/dowork.Speed);
   // timer3.Enabled:=true;
    FillComboX;
   //ConnectDataBase;
  // AdoQuery.Connection:=AdoConn;
  //
   TrayIcon1.AnimateInterval:=500;


end;

procedure TServiceForm.Freshedit;
Var
  CurrTime,StartTime:TdateTime;
  Paused,TotalNumber:integer;
  day,hour,Min,Sec:integer;
  dwThreadID:DWORD;
begin
      CurrTime:=Now();
      Objusers.ReadProcessData(StartTime,Paused,totalNumber);
      if LastTime<StartTime then  LastTime:=StartTime;
      // 判定服务停止时间
      if Paused>0 then PausedCount:=PausedCount+1
      else PausedCount:=0;
      if PausedCount>240  then begin // 如果停止超过两分钟，重启服务。
        Button8.Click ;
        PausedCount:=0;
      end;

      
      Edit1.Text :=FormatDateTime('YYYY-MM-DD HH:NN:SS',StartTime);
      day:=DaysBetween(CurrTime,startTime);
      Hour:=HourSBetween(CurrTime,startTime)-(Day*24);
      Min:=MinutesBetween( CurrTime,startTime)-((Day*24+Hour)*60);
      Sec:=SecondsBetween( CurrTime,startTime)-(((Day*24+Hour)*60+Min)*60);  

//      // if round((Gettickcount - Fcur) / 1000) > 86400 then   begin
//       if round((Gettickcount - Fcur) / 1000) > 20 then   begin
//          Objusers.SetiniProcStop(2);
//          StopServer; 
//          bRestart:=true;
//          Fcur:=Gettickcount;
//          close;
//       end;

     // if (hour>0) and (hour mod 2 =0)and (min < 1 ) and(sec <0.1) then   begin
       if round((Gettickcount - Fcur) / 1000) mod 7200 =7199  then begin
          Objusers.SetiniProcStop(1);
          Recallflag:=-1;
      end;
            
        Edit2.Text:=IntToStr(Day)+' 天' + IntToStr(hour)+' 小时' +
                              IntToStr(Min)+'分钟'+IntToStr(Sec)+' 秒';
      if Paused=-1 then  begin
         Edit3.Text:='矿压分析平台后台关闭！'
      end else if Paused=1   then begin
         Edit3.Text:='矿压分析平台已暂停！'
      end else begin
         Edit3.Text:='矿压分析平台工作正常！'
      end;
         Edit4.Text:=inttoStr(totalNumber);

      if ServiceIsInstalled('RockPressureS') then begin
           Button4.Enabled :=false; Button5.Enabled :=true;
      end else begin
           Button4.Enabled :=true; Button5.Enabled :=false;
      end;

      if ServiceIsRunning('RockPressureS') then begin
           Button8.Enabled :=false;
           Button2.Enabled :=true;
           Button7.Enabled :=true;
      end else begin
           Button8.Enabled :=true;
           Button2.Enabled :=false;
           Button7.Enabled :=false;
           Objusers.SetiniProcStop(2);
      end;

end;

procedure TServiceForm.N11Click(Sender: TObject);
begin
    Timer2.Enabled :=false;
    DelIconFromTray;
    self.TrayIcon1.Visible :=true;
    if TrayIcon1.Animate then  begin
       TrayIcon1.Animate :=false;
       N11.Caption :='动画显示图标';
    end else begin
       TrayIcon1.Animate :=true;
       N11.Caption :='停止动画图标';
       TrayIcon1.IconIndex:=0;
    end;

    
end;

procedure TServiceForm.N2Click(Sender: TObject);
begin
     Show;
end;

procedure TServiceForm.N3Click(Sender: TObject);
begin
   Button7.Click;
end;

procedure TServiceForm.N6Click(Sender: TObject);

begin
   Button2.Click;
end;

procedure TServiceForm.N7Click(Sender: TObject);
begin
   Button3.Click ;
end;

procedure TServiceForm.N8Click(Sender: TObject);
begin
   Button6.Click ;
end;

procedure TServiceForm.SysButtonMsg(var Msg: TMessage);
begin
      if (Msg.wParam = SC_CLOSE) or
         (Msg.wParam = SC_MINIMIZE) or
         (Msg.WParam =  SC_MAXIMIZE)  then  begin
             Hide;
             exit;
         end;

      inherited; // 执行默认动作
end;


procedure TServiceForm.Timer1Timer(Sender: TObject);
begin
     Freshedit;
     if RecallFlag=-1 then  sCount:=Scount+1;
     if Scount=20 then  begin
        Objusers.SetiniProcStop(0);
        RecallFlag:=0;
        sCount:=0;
     end;
     
end;

procedure TServiceForm.Timer2Timer(Sender: TObject);
begin
      AddIconToTray;
end;

procedure TServiceForm.Timer3Timer(Sender: TObject);
var
 i:integer;
begin
//  for i:=0 to dowork.CurveNum- 1 do
//  begin
//      randomize;
//      v:=random(531*(i+1))/1000+11.2-6+2*i;
//      dowork.SetValue(V,i);
//  end;
end;

procedure TServiceForm.TrayIcon1Click(Sender: TObject);
 var
   APoint:Tpoint;
begin
    GetCursorPos(APoint);
  //  if (Msg.LParam =  WM_RBUTTONDOWN) or (Msg.LParam =  WM_LBUTTONDOWN)then  begin
         popupMenu1.Popup (APoint.X ,APoint.y);
  //  end;
end;

procedure TServiceForm.TrayIconMessage(var Msg: TMessage);
 var
   APoint:Tpoint;
begin
    GetCursorPos(APoint);
    if (Msg.LParam =  WM_RBUTTONDOWN) or (Msg.LParam =  WM_LBUTTONDOWN)then  begin
         popupMenu1.Popup (APoint.X ,APoint.y);
    end;
end;

procedure TServiceForm.WMQueryEndSession(var uMessage: TMessage);
begin
    gbCanClose:=true;
    uMessage.Result :=1;
end;

end.
