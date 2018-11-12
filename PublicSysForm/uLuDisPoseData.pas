{
   //�������ݴ����� ��uDisPoseData ת������

}

unit uLuDisPoseData;

interface
uses
  Windows, SysUtils, Classes, Messages, Forms, StdCtrls, ExtCtrls,
  ComCtrls ,math,MySQLDataSet,COMobj,ActiveX,Dialogs,StrUtils,uDataModule,
  StopWatch, IniFiles;


const
   MinutesD=1/1440;

type

  TIni = class(TObject)
    fIniReader: TiniFile;
    fpath: string;
    fIsOpen: boolean;
  public
    //�õ�Config.ini�ļ��е�������Ϣ
    constructor Create(MinPath,FileName: string );
    procedure iniClose(FileName: string  );
    function iniIsOpen(FileName: string ): boolean;               //�Ƿ�Ini �ļ�����
    function iniGetStr(ID: string; secName: string ): string;
    function iniGetInt(ID: string; secName: string ): integer;
    function iniGetFloat(ID: string; secName: string ): Double;
    function iniSetStr(newValue: string; ID: string; secName: string): boolean;
  end;

 
  TIniObj = class(Tini)
    DataType: string;
    SrvIP: string;
    DataBaseName: string;
    UserName: String;
    PassWord: String;
    FilePath: String;
    ServerPause: integer;
    StartTime: String;
    totalNumber: integer;
    SupDTV1:Integer;
    SuPDTV2:integer;
    SupDTV3:integer;
    SupDTv4:integer;
    TimeInterval:integer;
    DataNeverDisCTime:integer;
    ThreadNumber:Integer;

  public
    procedure LoadIni;
    procedure SaveIni(sDatType,sIP,sDName,sUN,sPw,sFP,sPause,sStart,StolN,
                      sV1,sV2,Sv3,Sv4,TIV,TDec: string);
  end;

TLuDisPoseData = class (TObject)
   private
     InputData_InsertStr:string;
     InputData_JoinStr:String;
     RealFootage_InsertStr,RealFootage_JoinStr:String;
     SerVerInserCount:Integer;
     Sw1,Sw2:TStopWatch;
     MaxV1,MaxV2,MaxV3,MaxV4:double;
     FReadIni:TIniObj;

   public



     // control ini
      function SaveIniFile(sData, sIp,sUser, SPw,sPath,Port:string):boolean;  // ���� ini����
      function ReadIniProcess(var sttime:TDateTime;Var Paused,totalNumber:integer):Boolean;  //  ��ȡini��������
      Procedure WriteIniProcess(StTime:TdateTime;Paused:integer); // дini��������
      Procedure WriteiniTotalNumber(TotalN:integer); // дini��������
      procedure ReadServerinfo(var S1, S2, S3,S4,S5,S6: string);  //�� ���ݿ�����
       function ReadIniTimeInterval:integer;   // ��ini����ʱ����
      procedure WriteIniReadIniTimeInterval(Vaule:Integer); //дini����ʱ����
      function ReadiniDataNeverDisCTime:Integer;  //�� iniʱ�䲻��ϼ��
      procedure WriteIniDAtaNeverDisCTime(Value:integer);// дiniʱ�䲻��ϼ��
      function ReadiniThreadNumber:integer;     //   ���̵߳�����
      procedure WriteINiThreadNumber(Value:integer); // д�̵߳�����
      function ReadiniTotalNumber:integer; //����¼
      procedure WriteIniSaveProcesslog(Value:Boolean);// д�Ƿ񱣴洦����¼
      function ReadiniSaveProcesslog:Boolean;// ���Ƿ񱣴洦����¼
      procedure WriteSYStemDataBaseName(Value:string);// д���ݿ�������
      function ReadSYStemDataBaseName:String;// �����ݿ�������
     //

      function Gzm_ReadiniSV(Gzmbh:String;var V1,V2,V3,V4:Integer):Boolean;
      procedure Gzm_WriteiniSV(Gzmbh:string;V1,V2,V3,V4:Integer);
      function ReadiniSV(Setting:string;var V1,V2,V3,V4:Integer):Boolean;  // ��ȡini��si�ĸ�����ֵ
      Procedure WriteiniSV(Setting:string;V1,V2,V3,V4:Integer);//дini��si�ĸ�����ֵ
      function CreateIniFile:Boolean;

       //write log
       procedure WriteLog(const data:Ansistring; FFM : Ansistring='FFQ');
       function Get_DllPath: WideString;


     constructor Create(uDM:TMyDataModule);
     destructor Destroy;override;
  end;



implementation

uses DateUtils;


{ TLuDisPoseData }




procedure TLuDisPoseData.WriteIniDAtaNeverDisCTime(Value: integer);
begin
  EnterCriticalSection(FSYNCWriteIni);
  try
      if  not  assigned(fReadini) then
             fReadini.Create(FinDataModule.MainPath,'ServerInfo.dll') ;

           fReadini.iniSetStr(trim(IntToStr(Value)), 'DataNeverDisCTime','setting');
  finally
    leavecriticalsection(FSYNCWriteIni);
  end;
end;

procedure TLuDisPoseData.WriteIniProcess(StTime: TdateTime; Paused: integer);
begin
   EnterCriticalSection(FSYNCWriteIni);
  try
     if  not assigned(fReadini) then
             fReadini.Create(FinDataModule.MainPath,'ServerInfo.dll') ;
        if( StTime > 1000)  then
           fReadini.iniSetStr(FormatDateTime('yyyy-mm-dd hh:nn:ss',StTime),'StartTime','Processing');
     fReadini.iniSetStr(Trim(IntToStr(Paused)),'ServerPause','Processing');
  finally
    leavecriticalsection(FSYNCWriteIni);
  end;

end;

procedure TLuDisPoseData.WriteIniReadIniTimeInterval(Vaule: Integer);
begin
  EnterCriticalSection(FSYNCWriteIni);
  try
      if  not assigned(fReadini) then
             fReadini.Create(FinDataModule.MainPath,'ServerInfo.dll') ;
       fReadini.iniSetStr(trim(InttoStr(Vaule)), 'TimeInterval','setting');

  finally
    leavecriticalsection(FSYNCWriteIni);
  end;


end;

procedure TLuDisPoseData.WriteIniSaveProcesslog(Value: Boolean);
var
  KK:integer;
begin
  if Value then  KK:=1 else KK:=0;

  EnterCriticalSection(FSYNCWriteIni);
  try
      if  not assigned(fReadini) then
             fReadini.Create(FinDataModule.MainPath,'ServerInfo.dll') ;
       fReadini.iniSetStr(trim(InttoStr(KK)), 'WriteProcessflag','setting');

  finally
    leavecriticalsection(FSYNCWriteIni);
  end;

end;

procedure TLuDisPoseData.WriteiniSV(Setting:string;V1, V2, V3, V4: Integer);
begin
  EnterCriticalSection(FSYNCWriteIni);
  try
    if  not assigned(fReadini) then
             fReadini.Create(FinDataModule.MainPath,'ServerInfo.dll') ;
    fReadini.iniSetStr(trim(intToStr(V1)), 'SupDTV1',Setting);
    fReadini.iniSetStr(trim(inttostr(V2)), 'SupDTV2',Setting);
    fReadini.iniSetStr(trim(inttostr(V3)), 'SupDTV3',Setting);
    fReadini.iniSetStr(trim(inttostr(V4)), 'SupDTV4',Setting);

  finally
    leavecriticalsection(FSYNCWriteIni);
  end;
   
end;

procedure TLuDisPoseData.WriteINiThreadNumber(Value: integer);
begin
  EnterCriticalSection(FSYNCWriteIni);
  try
     if  not  assigned(fReadini) then
             fReadini.Create(FinDataModule.MainPath,'ServerInfo.dll') ;

           fReadini.iniSetStr(trim(IntToStr(Value)), 'ThreadNumber','setting');

  finally
    leavecriticalsection(FSYNCWriteIni);
  end;
      

end;

procedure TLuDisPoseData.WriteiniTotalNumber(TotalN: integer);
begin
    EnterCriticalSection(FSYNCWriteIni);
  try
      if  not assigned(fReadini) then
             fReadini.Create(FinDataModule.MainPath,'ServerInfo.dll') ;
       fReadini.iniSetStr(Trim(IntToStr(TotalN)),'TotalNumber','Processing');

  finally
    leavecriticalsection(FSYNCWriteIni);
  end;
    
end;


procedure TLuDisPoseData.WriteLog(const data: Ansistring; FFM: Ansistring);
var
  fileName,textString:Ansistring;
  DirName:Ansistring;
  hFile,logFile:integer;
begin
   DirName:=Get_DllPath+'\Err\'+FormatDateTime('yyyy-mm-dd',Now())+'\';
    if not DirectoryExists(DirName) then begin
       ForceDirectories(DirName);
    end;
   fileName:=Ansistring(FormatDateTime('yyyy-mm-dd',Now())) + FFM +'.txt';
   fileName:=DirName+fileName;
   if not(FileExists(fileName)) then begin
       hFile:=FileCreate(fileName,fmOutput);
       FileClose(hFile);
   end;
   logFile:=FileOpen(filename,fmOpenwrite or fmShareDenyWrite);
   FileSeek(logfile,0,2);
   textString:=formatdateTime('hh:mm:ss:zzz',Now())+'  ' +data + #13 +#10 ;
   fileWrite(logFile,Pchar(textString)^,length(textString));
   fileclose(logfile);
end;

procedure TLuDisPoseData.WriteSYStemDataBaseName(Value: string);
begin
  EnterCriticalSection(FSYNCWriteIni);
  try
      if  not assigned(fReadini) then
             fReadini.Create(FinDataModule.MainPath,'ServerInfo.dll') ;
       fReadini.iniSetStr(Value, 'DataBaseName','DataBase');

  finally
    leavecriticalsection(FSYNCWriteIni);
  end;

end;



function TLuDisPoseData.CreateIniFile: Boolean;
begin
     Result:=false;
     self.WriteIniDAtaNeverDisCTime(2);
     self.WriteINiThreadNumber(10);
     self.WriteSYStemDataBaseName('RockPress');
     self.WriteIniSaveProcesslog(false);
     self.WriteIniReadIniTimeInterval(1);
     Result:=true;
end;

destructor TLuDisPoseData.Destroy;
var
   i:integer;
begin
     FreeAndNil(sw1);
     FreeAndNil(sw2);
     FreeAndNil(FReadIni) ;



     inherited Destroy;
end;



function TLuDisPoseData.Get_DllPath: WideString;
var
   ModuleName:WideString;
   i:integer;
   dllPath:Ansistring;
begin
    SetLength(ModuleName, 255);
    GetModuleFileName(HInstance, PwideChar(ModuleName), Length(ModuleName));
    dllPath:=Trim(PwideChar(ModuleName)) ;
    i:=Pos('\',ReverseString(dllPath));

    dllPath:=Copy(dllPath,1,Length(dllPath)-i+1);
    Result:=dllPath;
end;

function TLuDisPoseData.Gzm_ReadiniSV(Gzmbh: String; var V1, V2, V3,
  V4: Integer): Boolean;
var
 Setting:String;
begin
  Result:=False;
   if Trim(Gzmbh)<>'' then  begin
      Setting:='SupDataType['+Trim(Gzmbh) +']';
      if not  ReadiniSV(setting,V1,V2,V3,V4) then begin
          if ReadiniSV('SupDataType[0]',V1,V2,V3,V4) then  Result:=true;
      end else begin
         Result:=true;
      end;
   end else begin
      Setting:='SupDataType[0]';
      if  ReadiniSV(setting,V1,V2,V3,V4)  then  Result:=true;
   end;

end;

procedure TLuDisPoseData.Gzm_WriteiniSV(Gzmbh: string; V1, V2, V3, V4: Integer);
var
 Setting:String;
begin
   if Trim(Gzmbh)<>'' then  begin
      Setting:='SupDataType['+Trim(Gzmbh) +']';
   end else begin
      Setting:='SupDataType[0]';
   end;
   WriteiniSV(setting,V1,V2,V3,V4);
end;


function TLuDisPoseData.ReadIniProcess(var sttime: TDateTime; var Paused,
  totalNumber: integer): Boolean;
var
   FSetting : TFormatSettings;
begin
      {DataType: string;
    SrvIP: string;
    DataBaseName: string;
    UserName: String;
    PassWord: String;
    FilePath: String;
    ServerPause: integer;
    StartTime: String;
    totalNumber: integer;}
    //���ڸ�ʽת��
       FSetting.ShortDateFormat:='yyyy-mm-ss' ;
       FSetting.DateSeparator :='-';
       FSetting.ShortTimeFormat :='hh:nn:ss';
       FSetting.TimeSeparator :=':';
       FSetting.DecimalSeparator :='.';
    //-----
  EnterCriticalSection(FSYNCWriteIni);
  try
       if  not assigned(fReadini) then
             fReadini.Create(FinDataModule.MainPath,'ServerInfo.dll') ;
     sttime:=StrToDateTime(fReadini.iniGetStr('StartTime','Processing'),FSetting);
     Paused:=fReadini.iniGetInt('ServerPause','Processing');
     totalNumber:=fReadini.iniGetInt('totalNumber','Processing');

     Result:=true;
  finally
    leavecriticalsection(FSYNCWriteIni);
  end;

    

end;

function TLuDisPoseData.ReadiniSaveProcesslog: Boolean;
var
  Value:integer;
begin
  Result:=false;
  EnterCriticalSection(FSYNCWriteIni);
  try
       if  not assigned(fReadini) then
             fReadini.Create(FinDataModule.MainPath,'ServerInfo.dll') ;
       Value:= fReadini.iniGetint('WriteProcessflag','Setting');
       if Value =1 then   Result:=true;

  finally
    leavecriticalsection(FSYNCWriteIni);
  end;
end;

function TLuDisPoseData.ReadiniSV(Setting:string;var V1, V2, V3, V4: Integer): Boolean;
begin
  Result:=FALSE;
  EnterCriticalSection(FSYNCWriteIni);
  try
      if  not assigned(fReadini) then
             fReadini.Create(FinDataModule.MainPath,'ServerInfo.dll') ;
      V1:= fReadini.iniGetint('SupDTV1',Setting);
      V2:= fReadini.iniGetint('SuPDTV2',Setting);
      V3:= fReadini.iniGetint('SupDTV3',Setting);
      V4:= fReadini.iniGetint('SupDTV4',Setting);
  finally
    leavecriticalsection(FSYNCWriteIni);
  end;

  if V1+V2+V3+V4 >0  then   Result:=true;

end;

function TLuDisPoseData.ReadiniThreadNumber: integer;
begin
     EnterCriticalSection(FSYNCWriteIni);
  try
     if  not assigned(fReadini) then
             fReadini.Create(FinDataModule.MainPath,'ServerInfo.dll') ;
      Result:= fReadini.iniGetint('ThreadNumber','Setting');

  finally
    leavecriticalsection(FSYNCWriteIni);
  end;
      
end;

function TLuDisPoseData.ReadIniTimeInterval: integer;
begin
   EnterCriticalSection(FSYNCWriteIni);
  try
     if  not assigned(fReadini) then
             fReadini.Create(FinDataModule.MainPath,'ServerInfo.dll') ;
      Result:= fReadini.iniGetint('TimeInterval','Setting');


  finally
    leavecriticalsection(FSYNCWriteIni);
  end;
        
end;

function TLuDisPoseData.ReadiniTotalNumber: integer;
begin
    EnterCriticalSection(FSYNCWriteIni);
  try
       if  not assigned(fReadini) then
             fReadini.Create(FinDataModule.MainPath,'ServerInfo.dll') ;
      Result:= fReadini.iniGetint('TotalNumber','Setting');

  finally
    leavecriticalsection(FSYNCWriteIni);
  end;
   
end;

procedure TLuDisPoseData.ReadServerinfo(var S1, S2, S3, S4, S5,S6: string);
begin
     {DataType: string;
    SrvIP: string;
    DataBaseName: string;
    UserName: String;
    PassWord: String;
    FilePath: String;
    ServerPause: integer;
    StartTime: String;
    totalNumber: integer;}
   EnterCriticalSection(FSYNCWriteIni);
  try
     if  not assigned(fReadini) then
             fReadini.Create(FinDataModule.MainPath,'ServerInfo.dll') ;
     s1:=Trim(fReadini.iniGetStr('DataType','DataBase'));
     s2:=Trim(fReadini.iniGetStr('SrvIP','DataBase'));
     s3:=Trim(fReadini.iniGetStr('UserName','DataBase'));
     s4:=Trim(fReadini.iniGetStr('PassWord','DataBase'));
     s5:=Trim(fReadini.iniGetStr('FilePath','DataBase'));
     s6:=Trim(fReadini.iniGetStr('Port','DataBase'));
  finally
    leavecriticalsection(FSYNCWriteIni);
  end;

end;

function TLuDisPoseData.ReadSYStemDataBaseName: String;
begin
  Result:='';
  EnterCriticalSection(FSYNCWriteIni);
  try
       if  not assigned(fReadini) then
             fReadini.Create(FinDataModule.MainPath,'ServerInfo.dll') ;
       Result:=Trim(fReadini.iniGetStr('DataBaseName','DataBase'));

  finally
    leavecriticalsection(FSYNCWriteIni);
  end;
end;


{ TInRec }






{ TIniObj }

procedure TIniObj.LoadIni;
begin
       try
  {
    DataType: string;
    SrvIP: string;
    DataBaseName: string;
    UserName: String;
    PassWord: String;
    FilePath: String;
    ServerPause: integer;
    StartTime: String;
    totalNumber: integer;
    SupDTV1:Integer;
    SuPDTV2:integer;
    SupDTV3:integer;
    SupDTv4:integer;
    TimeInterval:integer;
    DataNeverDisCTime:integer;
    }
    DataType:= iniGetStr('DataType','Setting');
    SrvIP:= iniGetStr('SrvIP','Setting');
    DataBaseName:= iniGetStr('DataBaseName','Setting');
    UserName:= iniGetStr('UserName','Setting');
    PassWord:= iniGetStr('PassWord','Setting');
    FilePath:= iniGetStr('FilePath','Setting');
    SupDTV1:= iniGetint('SupDTV1','Setting');
    SuPDTV2:= iniGetint('SuPDTV2','Setting');
    SupDTV3:= iniGetint('SupDTV3','Setting');
    SupDTV4:= iniGetint('SupDTV4','Setting');
    TimeInterval:= iniGetint('TimeInterval','Setting');
    DataNeverDisCTime:= iniGetint('DataNeverDisCTime','Setting');

    ServerPause:= iniGetint('Port','Processing');
    StartTime:= iniGetStr('StartTime','Processing');
    totalNumber:= iniGetint('totalNumber','Processing');

  except
    on E: exception do
    begin
      //
    end;
  end;
end;

procedure TIniObj.SaveIni(sDatType, sIP, sDName, sUN, sPw, sFP, sPause, sStart,
  StolN, sV1, sV2, Sv3, Sv4, TIV, TDec: string);
begin
     try
   {
    DataType: string;
    SrvIP: string;
    DataBaseName: string;
    UserName: String;
    PassWord: String;
    FilePath: String;
    ServerPause: integer;
    StartTime: String;
    totalNumber: integer;
    SupDTV1:Integer;
    SuPDTV2:integer;
    SupDTV3:integer;
    SupDTv4:integer;
    TimeInterval:integer;
    DataNeverDisCTime:integer;
    }

    iniSetStr(trim(sDatType), 'DataType','Setting');
    iniSetStr(trim(sIP), 'SrvIP','Setting');
    iniSetStr(trim(sDName), 'DataBaseName','Setting');
    iniSetStr(trim(sUN), 'UserName','Setting');
    iniSetStr(trim(sPw), 'PassWord','Setting');
    iniSetStr(trim(sFP), 'FilePath','Setting');
    iniSetStr(trim(sV1), 'SupDTV1','Setting');
    iniSetStr(trim(sV2), 'SupDTV2','setting');
    iniSetStr(trim(sV3), 'SupDTV3','setting');
    iniSetStr(trim(sV4), 'SupDTV4','setting');
    iniSetStr(trim(TIV), 'TimeInterval','setting');
    iniSetStr(trim(TDec), 'DataNeverDisCTime','setting');


    iniSetStr(trim(sPause), 'ServerPause','Processing');
    iniSetStr(trim(sStart), 'StartTime','Processing');
    iniSetStr(trim(StolN), 'totalNumber','Processing');

  except
  end;
end;


constructor TIni.Create(MinPath,FileName: string );
begin
  try
    fpath := MinPath;
    fIniReader := TiniFile.Create(fpath + FileName);
    fIsOpen := true;
  except
    fIsOpen := false;
  end;
end;


procedure TIni.iniClose(FileName: string );
begin
  finiReader.Free;
  fIsOpen := false;
end;

function TIni.iniIsOpen(FileName: string ): boolean;
begin
  if finiReader.FileName = FileName then
    Result := fIsOpen
  else
    Result := false;
end;

function TIni.iniGetStr(ID: string; secName: string ): string;
begin
  Result := finiReader.ReadString(secName, ID, '0');
end;

function TIni.iniGetInt(ID: string; secName: string ): integer;
begin
  Result := strtoint(finiReader.ReadString(secName, ID, '0'));
end;

function TIni.iniGetFloat(ID: string; secName: string): Double;
begin
  Result := strtoFloat(finiReader.ReadString(secName, ID, '0'));
end;

function TIni.iniSetStr(newValue: string; ID: string; secName: string ): boolean;
begin
  try
    finiReader.WriteString(secName, ID, NewValue);
    Result := true;
  except
    Result := false;
  end;
end;
end.