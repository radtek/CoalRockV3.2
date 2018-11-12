//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//<<      �ļ�����uUWinFormDll.pas                          <<
//<<      luleiʹ�õĸ���Delphi�ļ� ��Ҫ������ά������       <<
//<<      ���ļ���UWinFormDll.dll delphi  �����ļ�           <<
//<<      ���ļ��� dll�ļ�һͬ������dll����Ҫע��ʹ��          <<
//<<      �������ڣ�2016.6.12                                   <<
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


        function GetDllPath:String;override; //���dll �ؼ��ľ���·��
        function GetConnected:Boolean;override;// ������ݿ������Ƿ�ɹ�
        function CreateDataBase(Dtype,IP,User,Pass,path:string):Boolean; override;
        
        function ConnectDataBase(Dtype,sIP,sUser,sPass,spath:string):Boolean; override; //�������ݿ�
        function CreateTable(xl,gzmName:string) :Boolean; override; //ֻ�ܲ�����Ϊ 1 2 ��
        function CreateSupportTable(gzmName:string) :Boolean; override; //������֧����ص����ݱ�   xl ���Ϊ3
        function BackUpDataBase(Part,GzmBh,path:string):Boolean;override;
         ///������
         function GetGzmBh(GzmName:string):String;override;//���ݹ��������ƻ��ϵͳ���ݹ��ڹ�������
         procedure setGzmbm (Bh:string);override;   //���ù�������� �� GetGzmBh(GzmName:string) ���ʹ��
         procedure SetSupportDataType(First,Second,Third,Fouth:integer);override;  //  ¼�����ݴ�����˼
         procedure SetTimeInterval(Value:integer);override;//�������ݼ�����С��� ��λ����
          procedure SetGzmDill(tV:integer;Value:integer); override;//�趨��ױ��
          //��������

         function Begintrans :Boolean; override;   // ����¼������ ��ʼ
         function CommitTrans(var elapsedtime:string) :Boolean;override;   // ����¼�������ύ
         function InputFootage(uGBh:string;tDay:Tdatetime;DownDayFootage,SumDownFootage,
                UpperDayFootage,SumUpperFootage:double):Boolean;override;//¼�빤�������
         function InPutdata(supportbh:integer;Dt:string;V1,v2,V3,V4:double;var elapsedtime:string):integer; override; //  ����¼������
         //���ؽ��
         function GetRockMovement(Gzmid:string;flag:string;supid:integer;starttime,endtime:TdateTime;
                                  var RStr:String):Boolean;override; //���ض����˶�����
         procedure MonitRockMovementEvent;override; // ��ʼ����¼�

        //����
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
var   //��������
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
       //��ȡdllpath
      GetdllPath;

       //��ʼ��   //��������¼����
      //����sqlit���ݿ�
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
        Caption:='ú�������Ϣ';
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
     Caption:='�༭�����ϸ��Ϣ';
    
     CreateZk_inn(AHandle,Caption);
     ZkBasicForm.Close;
     CreateDrillDetail_inn(AHandle,Caption);   //����Ҳ�

end;

procedure TGroundClass.CreateDrillingInfo(AHandle: HResult);
var
  Caption: String ;
begin
  inherited;
       Caption:='�༭��׻�����Ϣ';
       CreateZk_inn(AHandle,Caption);  //��׻�����Ϣ


end;

procedure TGroundClass.CreateGzmBulidDrill(AHandle: HResult);
var
  Caption: String ;
begin
  inherited;
       Caption:='��������������';
       CreateBgz_inn(AHandle,Caption);//������֧�ܰ�
     
end;

procedure TGroundClass.CreateGzmInfo(AHandle: HResult);
var
  Caption: String ;
begin
  inherited;
      Caption:='�༭�����������Ϣ';
      CreateZk_inn(AHandle,Caption);
      ZkBasicForm.Close;
      CreateGzm_inn(AHandle,Caption);
end;

procedure TGroundClass.CreateSupportInfo(AHandle: HResult);
var
  Caption: String ;
begin
  inherited;
       Caption:='�༭֧�ܻ�����Ϣ';
       CreateZk_inn(AHandle,Caption);
       ZkBasicForm.Close;

      CreateZj_inn(AHandle,Caption);  //֧��

end;

function TGroundClass.CreateSupportTable(gzmName: string): Boolean;
var
   i :integer;
   wStr:string;
begin
      if not  judgelegal then  exit;
     wStr:='ȷ��Ҫ���������ݱ�ô�������ݱ������ݽ���ȫ�����ǣ�'+#13#13+'���鱸�ݺ��ٽ��д�����';

     if MessageBox(0, Pchar(wstr),'��ʾ',MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDNO then exit;

       //Ӧ���Ǹù������ж��ٸ�֧�ܣ� �������й��������ά������ ֧����init ���������
       FGzm.SupStartNumber:=1; FGzm.SupEndNumber:=200; // ����ʹ��

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
       ReturnString:='���ۺ�������';
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