unit UCallPStope;

interface

uses   ActiveX, Mtsobj, Mtx, ComObj, StdVcl,SysUtils, StrUtils,
       Windows,Messages,math,Classes,Vcl.Dialogs,
       UICallPstope;

type
   TCallPStopeBodyClass = class (TDefine_CallPStope)
        private
           IsEffic_CallPStope:Boolean;
           Create_Public_Basic,Create_Public_Modul:Boolean;// �Ƿ����Լ�������ȫ�ֱ���
        protected
            function  TestOK(Str:Pansichar):Pansichar; override;
            procedure SetStatuesCaption(Value:PansiChar); override;
            procedure SetUsetInformation(UserID,UserName:Pansichar;Admin:Boolean);  override;
            function  CallPStope:Boolean;override;
            procedure OpenFyyd(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer);override;
            procedure SetReCallPStope(Value:Boolean);override;
            procedure OpenDTFZ(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer);override;
            procedure OpenZCYL(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer);override;
            procedure SetDTFZ_JinChi(Value:Integer);override;
            procedure OpenEditPstope(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer);override;

            procedure GetReportSupport(AHandle:THandle);override;
            procedure GetReportYKlh(AHandle:THandle);override;

            function  SetFyyd_Bmp(AHandle:THandle):PansiChar;override;
            procedure OpenSupportWeigth(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer);override;
            procedure DispCalEavResult(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer);override;
            procedure OpenSupportSubject(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer);override;
            function  Get_Zcyl(const Version: Pansichar; JinChi: Double): Pansichar;override;
            function  VerFityUserName(Var DWName:Pansichar):Boolean;override;
            procedure SendEmail(address,Password,UType:Pansichar);override;
            // ��ȡͼƬ
            procedure GEtDTFZBMP(AHandle:THandle);override;
            procedure GetZCYLBMP(AHandle:THandle);override;
            function  Get_immediate_roof(Version:Pansichar): Pansichar;override;
            function  Get_Old_roof(Version:Pansichar): Pansichar;override;
            function  Get_judge_KCJSTC:Pansichar;override  ;

            // ��ȡ ������rft �ļ�
            function  GetDrillWord:Pansichar;override;
            // ��������
             function GetWinFormIsExsit(WinName:Pansichar):Boolean;override;
             procedure CloseActiveForm(FormStr:Pansichar); override;


          //ϵͳ����
           constructor Create; override;
           destructor  Destroy;
   end; //


implementation



{ TCallPStope }

uses MainCallUnit, Lu_Public_BasicModual,  SupportWeightClass,
  uWorkSupWeightUnit, SupportSubject, UMainDataModule;

function TCallPStopeBodyClass.CallPStope: Boolean;
begin
    if not Main_CallPStope.GetCreateSuccess then  Main_CallPStope.Create;

    IsEffic_CallPStope:=Main_CallPStope.InitPStope ;
    if IsEffic_CallPStope then begin  //�������������
       Main_CallPStope.SetSupportWeightFillData;

    end;
    Result:=IsEffic_CallPStope;
end;

procedure TCallPStopeBodyClass.CloseActiveForm(FormStr: Pansichar);
begin
  inherited;
   if not IsEffic_CallPStope then  exit;

   if IsEffic_CallPStope then
       Main_CallPStope.UsePStope.CloseActiveForm(FormStr);
end;

constructor TCallPStopeBodyClass.Create;
begin
  inherited;
    IsEffic_CallPStope:=False;
    Create_Public_Basic:=False;
    Create_Public_Modul:=False;//�Լ�û�д���ȫ�ֱ���
   // ���ںö����õ��ú�����Ҫ���������ഴ��ǰ������

    if not Assigned(Public_Basic) then   begin
        Public_Basic:=TLu_BasicClass.Create('','ServerInfo.dll');
        Create_Public_Basic:=True;
    end;

    if not Assigned(MainDataModule )then    begin
          Create_Public_Modul:=true;
          MainDataModule:=TDataModule1.Create(nil) ;
          MainDataModule.ExMainPath :=Public_Basic.Get_MyModulePath ;
          MainDataModule.ConnectSystemDataBase ;
    end;

    if  not Assigned(Main_CallPStope) then
          Main_CallPStope:= TMainCallPStope.Create;

end;

destructor TCallPStopeBodyClass.Destroy;
begin
  { �Լ�������ȫ�ֱ����Լ��ͷ�}
 
  if Assigned(Main_CallPStope ) then FreeAndNil(Main_CallPStope);


  if Create_Public_Modul then
     if Assigned(MainDataModule ) then FreeAndNil(MainDataModule);

  if Create_Public_Basic then
     if Assigned(Public_Basic) then FreeAndNil(Public_Basic);

  inherited;
end;


procedure TCallPStopeBodyClass.DispCalEavResult(AHandle: THandle;
  Caption: Pansichar; Width, Heigth: integer);
begin
  inherited;
//
  if not IsEffic_CallPStope then begin
     IsEffic_CallPStope:=self.CallPStope;
  end;
  if IsEffic_CallPStope then  begin

     Show_DCE_Result(AHandle,StrPas(Caption),Width, Heigth);
  end;

end;

function TCallPStopeBodyClass.GetDrillWord: Pansichar;
begin
    if not IsEffic_CallPStope then begin
        IsEffic_CallPStope:=self.CallPStope;
    end;
    if IsEffic_CallPStope then  begin
        Result:=PansiChar(AnsiString(Main_CallPStope.GetDrillWordRtf));
    end;
end;

procedure TCallPStopeBodyClass.GEtDTFZBMP(AHandle: THandle);
begin
  inherited;
  Main_CallPStope.UsePStope.GetDTFZBmp(AHandle);
end;



procedure TCallPStopeBodyClass.GetReportSupport(AHandle:THandle);
begin
  inherited;
  if not IsEffic_CallPStope then
     IsEffic_CallPStope:=CallPStope;
  if IsEffic_CallPStope then  begin
      Main_CallPStope.RecallSupportSubject;
      Main_CallPStope.ReportSupportInfo(AHandle) ;
  end;

end;


procedure TCallPStopeBodyClass.GetReportYKlh(AHandle: THandle);
begin
  inherited;
  if not IsEffic_CallPStope then
     IsEffic_CallPStope:=CallPStope;
  if IsEffic_CallPStope then  begin
      Main_CallPStope.RecallSupportSubject;
      Main_CallPStope.ReportYklhInfo(AHandle);
  end;
end;

function TCallPStopeBodyClass.GetWinFormIsExsit(WinName: Pansichar): Boolean;
begin
  Result:=False ;
  if not IsEffic_CallPStope then  exit;

  if IsEffic_CallPStope then
    Result:= Main_CallPStope.UsePStope.GetWinFormIsExsit(WinName) ;
end;

procedure TCallPStopeBodyClass.GetZCYLBMP(AHandle: THandle);
begin
  inherited;
  Main_CallPStope.UsePStope.GetZCYLBmp(AHandle);
end;

function TCallPStopeBodyClass.Get_immediate_roof(Version: Pansichar): Pansichar;
begin
    Result:=Main_CallPStope.UsePStope.Get_immediate_roof(Version);
end;

function TCallPStopeBodyClass.Get_judge_KCJSTC: Pansichar;
begin
  Result:='';
  if not IsEffic_CallPStope then
     IsEffic_CallPStope:=self.CallPStope;
  if IsEffic_CallPStope then
     Result:=PansiChar(AnsiString(Main_CallPStope.Return_WorkFace_kcjstj));
end;

function TCallPStopeBodyClass.Get_Old_roof(Version: Pansichar): Pansichar;
begin
   Result:=Main_CallPStope.UsePStope.Get_Old_roof(Version) ;
end;

function TCallPStopeBodyClass.Get_Zcyl(const Version: Pansichar;
  JinChi: Double): Pansichar;
begin
  Result:='';
  if not IsEffic_CallPStope then
     IsEffic_CallPStope:=self.CallPStope;
  if IsEffic_CallPStope then
     Result:=Main_CallPStope.UsePStope.Get_Zcyl(Version,JinChi);
end;
procedure TCallPStopeBodyClass.OpenDTFZ(AHandle: THandle; Caption: Pansichar;
  Width, Heigth,Flag: integer);
begin
  inherited;
  if not IsEffic_CallPStope then
     IsEffic_CallPStope:=self.CallPStope;
  if IsEffic_CallPStope then
     Main_CallPStope.UsePStope.OpenDTFZ(AHandle,Caption,Width, Heigth,Flag);
end;

procedure TCallPStopeBodyClass.OpenEditPstope(AHandle: THandle;
  Caption: Pansichar; Width, Heigth,Flag: integer);
begin
  inherited;
   if not IsEffic_CallPStope then
     IsEffic_CallPStope:=self.CallPStope;
  if IsEffic_CallPStope then
     Main_CallPStope.UsePStope.OpenEditPStopindows(AHandle,Caption,Width, Heigth,Flag);
end;

procedure TCallPStopeBodyClass.OpenFyyd(AHandle: THandle; Caption: Pansichar;
  Width, Heigth,Flag: integer);
begin
  inherited;
  if not IsEffic_CallPStope then
     IsEffic_CallPStope:=self.CallPStope;
  if IsEffic_CallPStope then
     Main_CallPStope.UsePStope.OpenFyyd(AHandle,Caption,Width, Heigth,Flag);
end;

procedure TCallPStopeBodyClass.OpenSupportSubject(AHandle: THandle;
  Caption: Pansichar; Width, Heigth: integer);
begin
 inherited;
  if not IsEffic_CallPStope then
     IsEffic_CallPStope:=self.CallPStope;
  if IsEffic_CallPStope then  begin
      inn_OpenSupportSubject(AHandle,StrPas(Caption),Width, Heigth);
  end;

end;

procedure TCallPStopeBodyClass.OpenSupportWeigth(AHandle: THandle;
  Caption: Pansichar; Width, Heigth: integer);
begin
  inherited;
  if not IsEffic_CallPStope then
     IsEffic_CallPStope:=self.CallPStope;
  if IsEffic_CallPStope then  begin
      ShowSupportWeight(AHandle,StrPas(Caption),Width, Heigth);
  end;

end;

procedure TCallPStopeBodyClass.OpenZCYL(AHandle: THandle; Caption: Pansichar;
  Width, Heigth,Flag: integer);
begin
  inherited;
   if not IsEffic_CallPStope then
     IsEffic_CallPStope:=self.CallPStope;
  if IsEffic_CallPStope then
     Main_CallPStope.UsePStope.OpenZCYL(AHandle,Caption,Width, Heigth,Flag);
end;

procedure TCallPStopeBodyClass.SendEmail(address, Password,UType: Pansichar);
begin
  inherited;
  Main_CallPStope.SendEmail(strPas(address),strPas(Password),strPas(UType));
end;

procedure TCallPStopeBodyClass.SetDTFZ_JinChi(Value: Integer);
begin
  inherited;
  if not IsEffic_CallPStope then
     IsEffic_CallPStope:=self.CallPStope;
  if IsEffic_CallPStope then
       Main_CallPStope.UsePStope.SetDTFZ_JinChi(Value);
end;

function TCallPStopeBodyClass.SetFyyd_Bmp(AHandle: THandle): PansiChar;
begin
    if not IsEffic_CallPStope then
     IsEffic_CallPStope:=self.CallPStope;
    if IsEffic_CallPStope then
       Main_CallPStope.UsePStope.GetFyydBmp(AHandle);
    Result:=PansiChar(AnsiString(Public_Basic.Get_MyModulePath+'SaveBMP\FYYD\'));
end;


procedure TCallPStopeBodyClass.SetReCallPStope(Value: Boolean);
begin
  inherited;
  {if Value is means ��Ҫ���³�ʼ��ģ��}
  IsEffic_CallPStope:=not Value;
end;

procedure TCallPStopeBodyClass.SetStatuesCaption(Value: PansiChar);
begin
  inherited;
   Public_Basic.SetStatusCaption(StrPas(Value));
end;

procedure TCallPStopeBodyClass.SetUsetInformation(UserID, UserName: Pansichar;
  Admin: Boolean);
begin
  inherited;
    MainDataModule.ExUserName :=strPas(UserName);
    MainDataModule.ExUserID:=StrPas(UserID);
    MainDataModule.ExAdminBool:=Admin;
end;


function TCallPStopeBodyClass.TestOK(Str: Pansichar): Pansichar;
begin
   Result:=Str;
end;

function TCallPStopeBodyClass.VerFityUserName(var DWName: Pansichar): Boolean;
begin
   Public_Basic.Licensing:=Main_CallPStope.UsePStope.VerFityUserName(DWName);
   Public_Basic.UseUnitName := StrPas(DWName);
   Result:= Public_Basic.Licensing;
end;

end.