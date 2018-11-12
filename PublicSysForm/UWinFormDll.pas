//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//<<      文件名：uUWinFormDll.pas                          <<
//<<      lulei使用的个人Delphi文件 主要是数据维护界面       <<
//<<      该文件是UWinFormDll.dll delphi  引用文件           <<
//<<      该文件与 dll文件一同发布，dll不需要注册使用          <<
//<<      创建日期：2016.6.12                                   <<
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


unit UWinFormDll;

interface


uses   ActiveX, Mtsobj, Mtx, ComObj, StdVcl,SysUtils,StrUtils,
       Windows,Messages,Classes,UIWinFormDll,uDataModule,GzmClass,
       Forms,uDisPoseData;

type

   TGroundClass = class(TIGroundClass)
   private
       judgelegal: Boolean ;
       procedure ReturnFinished;
   public

       constructor Create(App:TApplication);override;
       destructor  Destroy;override;


        function GetDllPath:String;override; //获得dll 控件的绝对路径
        function GetConnected:Boolean;override;// 获得数据库连接是否成功
        function CreateDataBase(Dtype,IP,User,Pass,path:string):Boolean; override;
        
        function ConnectDataBase(Dtype,sIP,sUser,sPass,spath:string):Boolean; override; //连接数据库
        function CreateTable(xl,gzmName:string) :Boolean; override; //只能插入编号为 1 2 的
        function CreateSupportTable(gzmName:string) :Boolean; override; //插入与支架相关的数据表   xl 标号为3
        function BackUpDataBase(Part,GzmBh,path:string):Boolean;override;
         ///工作面
         function GetGzmBh(GzmName:string):String;override;//根据工作面名称获得系统数据国内工作面编号
         procedure setGzmbm (Bh:string);override;   //设置工作面编码 与 GetGzmBh(GzmName:string) 组合使用
         procedure SetSupportDataType(First,Second,Third,Fouth:integer);override;  //  录入数据代表意思
         procedure SetTimeInterval(Value:integer);override;//设置数据计算最小间隔 单位分钟
          procedure SetGzmDill(tV:integer;Value:integer); override;//设定钻孔编号
          //处理数据

         function Begintrans :Boolean; override;   // 批量录入数据 开始
         function CommitTrans(var elapsedtime:string) :Boolean;override;   // 批量录入数据提交
         function InputFootage(uGBh:string;tDay:Tdatetime;DownDayFootage,SumDownFootage,
                UpperDayFootage,SumUpperFootage:double):Boolean;override;//录入工作面进尺
         function InPutdata(supportbh:integer;Dt:string;V1,v2,V3,V4:double;var elapsedtime:string):integer; override; //  批量录入数据
         //返回结果
         function GetRockMovement(Gzmid:string;flag:string;supid:integer;starttime,endtime:TdateTime;
                                  var RStr:String):Boolean;override; //返回顶板运动规律
         procedure MonitRockMovementEvent;override; // 开始监测事件

        //界面
        procedure CreateGzmInfo(AHandle: HResult);override;
        procedure CreateCoalInFo(AHandle: HResult);override;
        procedure CreateSupportInfo(AHandle: HResult);override;
        procedure CreateDrillingInfo(AHandle: HResult);override;
        procedure CreateDrillDetailInfo(AHandle: HResult);override;
        procedure CreateGzmBulidDrill(AHandle: HResult);override;
        // init dll
        procedure FreeDll;
   end;

{ TGroundClass }
var   //公共变量
        dllPath :string;
        uMyDataModule:TMyDataModule;
        uDisposeData:TDisPoseData;
        FGzm:TGzm;
        DllApp:TApplication;


implementation
uses   UnEditGzk,UnTxMc,UnDetail,UnZkBasic,UnEditZJ,UnZkGzmLink,UncoalName;



// TGroundClass
function TGroundClass.BackUpDataBase(Part, GzmBh, path: string): Boolean;
begin

end;

function TGroundClass.Begintrans: Boolean;
begin
     if uDisposeData.Begintrans then Result:=true else  Result:=false;
end;

function TGroundClass.CommitTrans(var elapsedtime: string): Boolean;
begin
     if uDisposeData.CommitTrans(elapsedtime) then Result:=true else  Result:=false;
end;

function TGroundClass.ConnectDataBase(Dtype, sIP, sUser, sPass,
  spath: string): Boolean;
begin
       if Trim(Dtype)='' then  begin
          uDisposeData.ReadServerinfo(Dtype,sIp,sUser,sPass,sPath);
          if Trim(Dtype)='' then  begin
             Result:=False;
             Exit;
          end;
       end;

        Dtype:=UpperCase(Dtype);
        uMyDataModule.SetExDataType(Dtype);
        uMyDataModule.SetExDBaseInfo(sIp,sUser,sPass);

        if uMyDataModule.ConnectedData(Dtype,ExDataBase) then begin
           judgelegal:=true;
           uDisposeData.SaveIniFile(Dtype,sIP,sUser,sPass,sPath);
        end;
       Result:= judgelegal;
end;

constructor TGroundClass.Create(App:TApplication);
begin 
      CoInitialize(nil);
       //获取dllpath
      GetdllPath;

       //初始化   //创建数据录入类
      //连接sqlit数据库
      uMyDataModule:=TMyDataModule.Create ;
      uMyDataModule.initsqliteData;
      uDisposeData:=TDisPoseData.Create(uMyDataModule);
      FGzm:=TGzm.Create(uMyDataModule) ;
      judgelegal:=False;

      //init dll
       DllApp:=Application;
       Application:=App;
      
   inherited;
end;

procedure TGroundClass.CreateCoalInFo(AHandle: HResult);
var
  Caption: String ;
  DllHandle : THandle;
begin
  inherited;
        Caption:='煤矿基本信息';
        CreateCoalname_inn(Ahandle,'');

end;

function TGroundClass.CreateDataBase(Dtype, IP, User, Pass,
  path: string): Boolean;
var
   uPass:Boolean;
begin
      Dtype:=UpperCase(Dtype);
      uMyDataModule.SetExDataType(Dtype);
      uMyDataModule.SetExDBaseInfo(Ip,User,Pass);
     if (Dtype= 'SQLSERVER') or(Dtype= 'SQL SERVER') then  begin
         uPass:= uMyDataModule.TestServer(Dtype) ;
     end else if (Dtype= 'MYSQL') or (Dtype= 'MY SQL') then  begin
         uPass:= uMyDataModule.TestMySql(Dtype) ;
     end;

     if uPass then begin
        Result:=true;
     end else begin
        Result:=false;
        exit;
     end;
     uMyDataModule.CreateDatabase(Dtype,Ip,user,pass,path) ;
end;

procedure TGroundClass.CreateDrillDetailInfo(AHandle: HResult);
var
  Caption: String ;
begin
  inherited;
     Caption:='编辑钻孔详细信息';
    
     CreateZk_inn(AHandle,Caption);
     ZkBasicForm.Close;
     CreateDrillDetail_inn(AHandle,Caption);   //钻孔岩层

end;

procedure TGroundClass.CreateDrillingInfo(AHandle: HResult);
var
  Caption: String ;
begin
  inherited;
       Caption:='编辑钻孔基本信息';
       CreateZk_inn(AHandle,Caption);  //钻孔基本信息


end;

procedure TGroundClass.CreateGzmBulidDrill(AHandle: HResult);
var
  Caption: String ;
begin
  inherited;
       Caption:='工作面绑定钻孔数据';
       CreateBgz_inn(AHandle,Caption);//工作面支架绑定
     
end;

procedure TGroundClass.CreateGzmInfo(AHandle: HResult);
var
  Caption: String ;
begin
  inherited;
      Caption:='编辑工作面基本信息';
      CreateZk_inn(AHandle,Caption);
      ZkBasicForm.Close;
      CreateGzm_inn(AHandle,Caption);
end;

procedure TGroundClass.CreateSupportInfo(AHandle: HResult);
var
  Caption: String ;
begin
  inherited;
       Caption:='编辑支架基本信息';
       CreateZk_inn(AHandle,Caption);
       ZkBasicForm.Close;

      CreateZj_inn(AHandle,Caption);  //支架

end;

function TGroundClass.CreateSupportTable(gzmName: string): Boolean;
var
   i :integer;
   wStr:string;
begin
      if not  judgelegal then  exit;
     wStr:='确定要创建新数据表么？老数据表中数据将完全被覆盖！'+#13#13+'建议备份后再进行创建！';

     if MessageBox(0, Pchar(wstr),'提示',MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDNO then exit;

       //应该是该工作面有多少个支架， 该数据有工作面界面维护，在 支架类init 函数中填充
       FGzm.SupStartNumber:=1; FGzm.SupEndNumber:=200; // 测试使用

       for I := FGzm.SupStartNumber to FGzm.SupEndNumber do
           if (uMyDataModule.GetExDataType= 'SQLSERVER') or(uMyDataModule.GetExDataType= 'SQL SERVER') then  begin
               result :=uMyDataModule.CreateSerVerTable('3',gzmName,intToStr(i));
           end else if (uMyDataModule.GetExDataType= 'MYSQL') or (uMyDataModule.GetExDataType= 'MY SQL') then  begin
               result :=uMyDataModule.CreateMySqlTable('3',gzmName,intToStr(i));
           end;

end;

function TGroundClass.CreateTable(xl, gzmName: string): Boolean;
begin
      Result:=false;
     if not  judgelegal then  exit;
     if (uMyDataModule.GetExDataType= 'SQLSERVER') or(uMyDataModule.GetExDataType= 'SQL SERVER') then  begin
         result :=uMyDataModule.CreateSerVerTable(xl,gzmName,'');
     end else if (uMyDataModule.GetExDataType= 'MYSQL') or (uMyDataModule.GetExDataType= 'MY SQL') then  begin
         result :=uMyDataModule.CreateMySqlTable(xl,gzmName,'');
     end;

end;

destructor TGroundClass.Destroy;
begin
     Freedll;
     FGzm.Free;
     uDisposeData.Free ;
     uMyDataModule.Free ;
     Application:=DllApp;

     inherited; 
end;



procedure TGroundClass.FreeDll;
begin
      CreateZk_inn(Dllapp.Handle ,'');
      ZkBasicForm.Close;

     if assigned(innGzmForm) then begin   //GzmForm
         innGzmForm.Close ;
         FreeAndnil(innGzmForm);
     end;
     if assigned(innCoalName) then begin   //CoalForm
         innCoalName.Close ;
         FreeAndnil(innCoalName);
     end;
     if assigned(ZkBasicForm) then begin   //Zkinfo
         ZkBasicForm.Close ;
         FreeAndnil(ZkBasicForm);
     end;
      if assigned(ZkDetail_inn) then begin   //TZkDetailForm
         ZkDetail_inn.Close ;
         FreeAndnil(ZkDetail_inn);
     end;
     if assigned(ZkGzmLink) then begin   //ZkGzmLink
         ZkGzmLink.Close ;
         FreeAndnil(ZkGzmLink);
     end;
     if assigned(ZkZJ_inn) then begin   //ZkZJ_inn
         ZkZJ_inn.Close ;
         FreeAndnil(ZkZJ_inn);
     end;

end;

function TGroundClass.GetConnected: Boolean;
begin
    Result:=uMyDataModule.Connected;
end;

function TGroundClass.GetDllPath: String;
var
   ModuleName:WideString;
   i:integer;
begin
          SetLength(ModuleName, 255);
          GetModuleFileName(HInstance, PChar(ModuleName), Length(ModuleName));
          dllPath:=Trim(PChar(ModuleName)) ;
          i:=Pos('\',ReverseString(dllPath));

          dllPath:=Copy(dllPath,1,Length(dllPath)-i+1);
          Result:=dllPath;
end;

function TGroundClass.GetGzmBh(GzmName: string): String;
begin
    Result:= uDisposeData.GetGzmBh(GzmName);
end;



function TGroundClass.GetRockMovement(Gzmid, flag: string; supid: integer;
  starttime, endtime: TdateTime; var RStr: String): Boolean;
begin

end;

function TGroundClass.InPutdata(supportbh: integer; Dt: string; V1, v2, V3,
  V4: double; var elapsedtime: string): integer;
begin
   Result:=uDisposeData.InPutdata(Supportbh,dt,v1,v2,v3,v4,elapsedtime);
end;

function TGroundClass.InputFootage(uGBh: string; tDay: Tdatetime; DownDayFootage,
  SumDownFootage, UpperDayFootage, SumUpperFootage: double): Boolean;
begin
   Result:= uDisposeData.InputFootage(uGbh,tday,downdayfootage,sumdownfootage,upperdayfootage,sumupperfootage);

end;

procedure TGroundClass.MonitRockMovementEvent;
begin
  inherited;
       ReturnString:='结论后续补充';
       ReturnString:=ReturnString+'_'+FormatDateTime( 'yyyy-mm-dd hh:nn:ss',now) ;

       ReturnFinished;
end;

procedure TGroundClass.ReturnFinished;
begin
    if Assigned(OnReturned) then
         Onreturned(ReturnString);
end;

procedure TGroundClass.setGzmbm(Bh: string);
begin
  inherited;
      uDisposeData.setGzmbm(bh);
end;

procedure TGroundClass.SetGzmDill(tV, Value: integer);
begin
  inherited;
     FGzm.setGzmNumber(tV);
     FGzm.SetDillNumber(value);
end;

procedure TGroundClass.SetSupportDataType(First, Second, Third, Fouth: integer);
begin
  inherited;
    FGzm.setSupportType(First, Second, Third, Fouth);
end;

procedure TGroundClass.SetTimeInterval(Value: integer);
begin
  inherited;
      FGzm.SetDateintervalTime(Value);
end;



end.
