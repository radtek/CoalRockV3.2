unit uDisPoseData;

interface
uses
  Windows, SysUtils, Classes, Messages, Forms, StdCtrls, ExtCtrls,
  ComCtrls ,math,COMobj,ActiveX,Dialogs,StrUtils,UMainDataModule,
  StopWatch, IniFiles;


const
   MinutesD=1/1440;

type



  PFDD = ^TFirstdisdoseData;
  TFirstdisdoseData =packed record
     dTimeD:Tdatetime;
     dMaxValue:double;
     dMinValue:double;
     dAvgValue:double;
     dFrequency:integer;
     dPointNumber:double;
     dDiffPercent:double;
     dMovesuppport:Boolean;
     dInterVal:integer;
  end;

TDisposeData = class (TObject)
   private
     InputData_InsertStr:string;
     InputData_JoinStr:String;
     RealFootage_InsertStr,RealFootage_JoinStr:String;
     SerVerInserCount:Integer;
     Sw1,Sw2:TStopWatch;
     MaxV1,MaxV2,MaxV3,MaxV4:double;
   
   public
     uDisPoseGzmBh:String;
     inputStarttime:Integer; //¼��ѹ���������ݼ�¼ʱ��
     InputTimer:TTimer;
     StopserviceCommand:Integer;
     //¼��ʵʱ�������ݼ�¼
     RealFootageTimeCount:Integer; //¼�����ݼ�¼ʱ��
     RealFootageTimer:TTimer;
     //=====
     FSetting : TFormatSettings;  //���ڸ�ʽת��
     FinDataModule:TDataModule1;
     InputData_elapsedtime:string;
      //��һ�δ�������
     TimeInterValSupportData:integer;//�ж������ж�ʱ�����೤ʱ��Ϊ ���ݲ�����  ��λСʱ
     //DataTimeintVal:double;// ���ݴ��������У����ݴ�������С���ݵ�Ԫ�� ��λ����
    
     MoveSupportPercent:integer; //�ж��ƶ�֧�ܵ� �İٷֱ�
     SupprortPercentPress:integer;//��¼���ֵ����Сֵ����ʱ��İٷֱ�
     FirstProcessStop:Boolean;   //��һ�����ݴ���ֹͣ���
     SecondProcessStop:Boolean;  // �ڶ������ݴ���ֹͣ���
     InputdataProcessing:Boolean;//   ��������¼�����ݿ⣬����������û���
     AppointFootageStop:Boolean;//�������ֹͣ
     ThirdProcessStop:Boolean;//�����δ���ֹͣ���
     FourthProcessStop:Boolean;//���Ĵδ���ֹͣ���
     writeProcessflag:boolean;// �Ƿ��¼�������
     //INPUT DATE TYPE
     FirstValue,SecondValue,ThirdValue,FourthValue:Integer; //���ִ洢��������
     DataIniTimeInterval:integer;//���ݴ���ʱ������
     //20160820
     PressDataConn,RealFootAgeConn:TMySqlConnection;
     PressDataCommand,RealFootAgeCommand:TMyCommand;
     PressDataSet,RealFootDataSet:TMyDataSet;
     PressDataBeginTrans,RealFootAgeBeginTrans :integer;
     InputFootDataConn:TMySqlConnection;
     InputFootDataSet:TMyDataSet;
     InputFootCommand:TMyCommand;
     //2017.8.16
     HistoryResult:AnsiString;   //��ʷ��������ַ���
     inReturnForCase:Ansistring; //Ԥ���������ַ���
     inSupportMoveInfo:Ansistring;//�Ƽ���Ϣ���ؽ���ַ���
     OneStepDisposeTime:double;   // һ�δ���ʱ��  ��Ҫ���� ѹ�����ݴ����� �������ݴ���
     BasicRecordCount,StrokeRecorderCount:integer; // ���ݿ��¼
     //2017.12.1
     OutInputTimeSt,OutInputTimeEd:TdateTime;
     OutInputFootSt,OutInputFootEd:Double;
     //¼�����ݵ���Ч����
     PressDataLowLine,strokeData_LowLine:Double;


     function GetGzmBh(Value:String):String;//���ݹ��������ƻ�ù�������
     function GetGzmNameS:String; //�������ݿ�������ʹ�õĹ���������
     procedure setGzmbm (Bh:string);
     //input data
     function SelectWorkFaceid(Mineid:integer;WorkFaceName:String):integer;
     Function SelKuangjingId(KuangjingName:String):integer;
     function InputData_Begintrans :Boolean;
     function InputData_CommitTrans(var elapsedtime:string) :Boolean;
     function SelectBasicDataCount(Gzmbh:String):Boolean;
     function InPutdata(supportbh:integer;Dt:String;V1,v2,V3,V4:double;var elapsedtime:string):integer;
     procedure ConnectInputDataLink;
     function SelectGzmDataTypeExsit(Gzmid,Dataid,DataType:integer;Stime:TdateTime):Boolean; //���ҹ����������
     function InsertGzmDataTypeValue(Gzmid,Dataid,DataType:integer;lowLine,topLine:Double;
              StartTime:TdateTime):Boolean;  //���빤���������
     function InsertAllWorkFaceTypeData(FirstType: integer; FirstDataTopLine: Double; SecondType: integer;
                     SecondDataTopline: double; ThirdType: integer; ThirdDataTopLine: double;
                     FouthType: integer; FourthDataTopLine: double):Boolean;  //ȫ�����������һ��������
     function SplitWorkFaceDataType(Gzmid,FirstType: integer; FirstDataTopLine: Double; SecondType: integer;
                     SecondDataTopline: double; ThirdType: integer; ThirdDataTopLine: double;
                     FouthType: integer; FourthDataTopLine: double; StartTime:TdateTime):Boolean; //���幤���������
     //______
     procedure SetFirstProcessStop(Value:Boolean);
     procedure SetDateNeverDiscontime(Value:integer);
     Procedure inFinishedE(TotalNumber,supbh:integer;elapsedtime:String;Suc:Boolean);
     
     procedure SetSecondProcessStop(Value:Boolean);
     procedure SetThirdProcessStop(Value:boolean);
     procedure SetFourthProcessStop(Value:boolean);
     procedure SetAppointFootageStop(Value:boolean);
     function  SelectBasicRecordNumber(MyConn:TMySqlConnection;FGzm: String; var MinSupBh,
                                       MaxSupBh, SumTotal: integer): Boolean;  //���������
     function  SelectBasicSupportExsit(FGzm:String;supbh:integer):Boolean; //��ø�֧�ܱ����basic���ݿ��еĴ������
     function  SelectProcessRecorderUsed(FGzm:String;supbh:integer):Boolean; //��ø�֧�ܱ����Record���̴߳������
     procedure SetmaxValuetopLine(V1,V2,V3,V4:double);
     procedure RefreshProcessFlag;//���������� ֧�ܴ������
     procedure InsetSql(Sql:string);
     // timer event
     procedure InputTimeTimer( Sender:Tobject);
     procedure FootageTimeTimer(Sender:Tobject);
     //  ���ڽ��ߵĺ���
     function RealSelectWorkFaceid(Mineid:integer;WorkFaceName:String):integer;
     Function RealSelKuangjingId(KuangjingName:String):integer;
     function SelectStokeData(Gzmbh:String):Boolean;
     function RealFootAge_Begintrans:Boolean;
     function RealFootAge_CommitTrans:Boolean;
     function RealTimeFootAge(gzmid,supportbh: Integer; Generatetime: TdateTime;  RealDataValue:double) :Boolean;
     procedure ConnectRealFootLink;
     //
     function InputFootSelectWorkFaceid(Mineid:integer;WorkFaceName:String):integer;
     Function InputFootSelKuangjingId(KuangjingName:String):integer;
     function InputFootage(uGBh:string;tDay:Tdatetime;DownDayFootage,SumDownFootage,
                UpperDayFootage,SumUpperFootage:double;Flag:integer):Boolean;//¼�빤�������
     procedure  ConnectInputFootageLink;
     function DatetimeToFootage(Gzmbh:integer;Dt: TdateTime;Str:String): double;
     function FootageToDate(Gzmbh:integer;FG: double;Str:string): TDateTime;

     // ��Ҫ�ĺ���
     function CreateIniFile:Boolean;
     function GetForcastResult(GzmList:TStringlist) : string;
     function GetHistoryResult(Gzmid:integer; StartTime : TDateTime; StopTime : TDateTime) : string;
       //
     function GetInputDataMaxDatetime(Mineid,Gzmbh:integer):TDateTime;
     //  �ٽ���
    {
       EnterCriticalSection(Critical1); //�����ٽ��
       AdoCommand.Execute ;
       LeaveCriticalSection(Critical1);//�˳��ٽ��
    }

     constructor Create(uDM:TDataModule1);
     destructor Destroy;override;
  end;



implementation

uses PStope_GzmGuidClass,DateUtils,NativeXml, uMainFun, Lu_Public_BasicModual;


{ TDisposeData }






function TDisposeData.InputData_Begintrans: Boolean;
begin
      Result:=False;
      Sw1.Start;Sw2.Start;
      //ShowMessage(Gzmbh);
      InputData_insertStr:='';
      if uDisPoseGzmBh= '' then exit;
    //  if not  FinDataModule.JudgeTableIsExists('D_'+Trim(uDisPoseGzmBh)+'_BasicData') then  exit;

      InputData_insertStr:=' insert into D_'+Trim(uDisPoseGzmBh)+'_BasicData  ('
                              +' supportbh,Generatetime,FirstValue,secondvalue,ThirdValue,FouthValue,FirstProcess ) values ' ;
      InputData_JoinStr:='';
      InputdataProcessing:=true;
      //��ʼ�����Բ���
     //  ShowMessage(PressDataConn.ConnectionString);
    try
      try
          ConnectInputDataLink;
      finally
          PressDataConn.BeginTrans;
          PressDataBeginTrans:=1;
          SerVerInserCount:=0;
          Result:=true;
      end;
    except
      on e:exception do begin
           MyMainFun.WriteLog('Eorr: Begintrans ����  '+e.Message,'[InputPressData]');
           PressDataSet.Close;;
     end;
    end;
end;

function TDisposeData.InputData_CommitTrans(var elapsedtime:string): Boolean;
var
  iSqi:string;
  elapsedMilliseconds : cardinal;
begin
      Result:=False;
      if (length(InputData_insertStr)<5 ) or ( length(InputData_Joinstr) <1 ) then begin
         ConnectInputDataLink;
         PressDataconn.RollbackTrans ;
         exit;
      end;

      try
         if (FinDataModule.GetExDataType ='MYSQL' )or (FinDataModule.GetExDataType ='MY SQL') then   begin
              iSqi:=InputData_insertStr+Leftstr(InputData_Joinstr,length(InputData_Joinstr)-1); //ȥ�����Ķ���
              PressDatacommand.CommandText:=iSqi;
              PressDatacommand.Execute ;

         end;
          ConnectInputDataLink;
          PressDataconn.CommitTrans ;
          PressDataBeginTrans:=0;
      finally
          Result:=true;
          InputdataProcessing:=false;
          sw1.Stop;  sw2.Stop;
          elapsedMilliseconds:=sw1.ElapsedMilliseconds;
          elapsedtime:=Format('%f',[elapsedMilliseconds/1000]);
      end;
end;



procedure TDisposeData.ConnectInputDataLink;
begin
   if not PressDataConn.ServerConnected then  begin
              PressDataConn.Open(FinDataModule.EXDataIP,FinDataModule.Port,
                            FinDataModule.ExUser,FinDataModule.EXPassword,FinDataModule.DataBaseName);
   end;
end;

procedure TDisposeData.ConnectInputFootageLink;
begin
   if not InputFootDataConn.ServerConnected then  begin
              InputFootDataConn.Open(FinDataModule.EXDataIP,FinDataModule.Port,
                            FinDataModule.ExUser,FinDataModule.EXPassword,FinDataModule.DataBaseName);
   end;
end;

procedure TDisposeData.ConnectRealFootLink;
begin
   if not RealFootAgeConn.ServerConnected then  begin
             RealFootAgeConn.Open(FinDataModule.EXDataIP,FinDataModule.Port,
                            FinDataModule.ExUser,FinDataModule.EXPassword,FinDataModule.DataBaseName);
   end;

end;

constructor TDisposeData.Create(uDM:TDataModule1);
begin
      inherited  Create;
      FinDataModule:=uDM;
      uDisPoseGzmBh:='';
      Sw1:=TstopWatch.Create();
      Sw2:=TstopWatch.Create();
      //
      PressDataConn:= TMySqlConnection.Create(nil);
      PressDataCommand:=TMyCommand.Create(nil);
      PressDataCommand.MysqlConnection:= PressDataConn;
      PressDataSet:=TMyDataSet.Create(nil);
      PressDataSet.MySqlConnection:= PressDataConn;

      RealFootAgeConn:= TMySqlConnection.Create(nil);
      RealFootAgeCommand:=TMYCommand.Create(nil);
      RealFootAgeCommand.MysqlConnection:= RealFootAgeConn;
      RealFootDataSet:=TMyDataSet.Create(nil);
      RealFootDataSet.MysqlConnection:= RealFootAgeConn;
      //
      InputFootDataConn:= TMysqlConnection.Create(nil);
      InputFootCommand:=TMyCommand.Create(nil);
      InputFootCommand.MysqlConnection:= InputFootDataConn;
      inPutFootDataSet:=TMyDataSet.Create(nil);
      inPutFootDataSet.MysqlConnection:= InputFootDataConn;

      //���ڸ�ʽת��
       FSetting.ShortDateFormat:='yyyy-mm-ss' ;
       FSetting.DateSeparator :='-';
       FSetting.ShortTimeFormat :='hh:nn:ss';
       FSetting.TimeSeparator :=':';
       FSetting.DecimalSeparator :='.';
       //��ֵ
       InputdataProcessing:=False;
       MoveSupportPercent:=40;  ////�ж��ƶ�֧�ܵ� �İٷֱ�   50%
       TimeInterValSupportData:=1; //�����ж�һ��Сʱ �ж����ݱ�����
       SupprortPercentPress:=10;// ��¼���ֵ����Сֵ����ʱ��İٷֱ�  10%
       //
       MaxV1:=50;
       MaxV2:=50;
       MaxV3:=50;
       MaxV4:=50;
       //
       writeProcessflag:=true;
       //Timer init
       InputTimer:=TTimer.Create(nil);
       InputTimer.Interval :=1000;
       InputTimer.Enabled :=false;
       InputTimer.OnTimer:=InputTimeTimer;
       inputStarttime:=0;
       RealFootageTimer:=TTimer.Create(nil);
       RealFootageTimer.Interval :=1000;
       RealFootageTimer.Enabled :=false;
       RealFootageTimer.OnTimer:=FootageTimeTimer;
       RealFootageTimeCount:=0;
       PressDataBeginTrans:=0;
       RealFootAgeBeginTrans:=0;
       { TODO : ֹͣ������ }
      // StopserviceCommand:=0;
       OneStepDisposeTime:=4; //һ�δ���4��Сʱ������
       //��ʼ��������������
       BasicRecordCount:=-1;
       StrokeRecorderCount:=-1;
       OutInputTimeSt:=-1;
       OutInputTimeEd:=-1;
       OutInputFootSt:=0;
       OutInputFootEd:=0;
       // ����10MPA�����ݲ�����
       PressDataLowLine:=10;
       strokeData_LowLine:=100;
end;


function TDisposeData.CreateIniFile: Boolean;
begin
     Result:=false;
     Public_Basic.WriteIniDAtaNeverDisCTime(2);
     Public_Basic.WriteINiThreadNumber(10);
     Public_Basic.WriteSYStemDataBaseName('RockPress');
     Public_Basic.WriteIniSaveProcesslog(false);
     Public_Basic.WriteIniTimeInterval(1);
     Result:=true;
end;

function TDisposeData.DatetimeToFootage(Gzmbh: integer; Dt: TdateTime;
  Str: String): double;
var
  sql:string;
  Df,UF,MF:double;
begin
   Result:=0;
   ConnectInputFootageLink;

   if Gzmbh <1  then exit;

   InputFootDataSet.Close;
   Sql:='select sumDownFootage,SumUpperFootage from d_'+IntToStr(Gzmbh)+'_Footage ' +
        ' where FootDay <= '''+FormatDateTime('yyyy-mm-dd hh:nn:ss',dt)+''' order by Footday desc';
   InputFootDataSet.Close ;
   InputFootDataSet.CommandText :=sql;
   if InputFootDataSet.Open  then
       if InputFootDataSet.RecordCount >0 then  begin
          Df:=InputFootDataSet.FieldByName('sumDownFootage').AsFloat;
          Uf:=InputFootDataSet.FieldByName('SumUpperFootage').AsFloat ;
          if Str='Upper' then  begin
             Result:=UF;
          end else if Str='Down' then  begin
             Result:=DF;
          end else begin
             if DF> Uf then  Result:=DF  else Result:=UF;
          end;
          exit;
       end;

   //������ʱ����û�м�¼,����С��һ����¼
   Sql:='select sumDownFootage,SumUpperFootage from d_'+IntToStr(Gzmbh)+'_Footage ' +
        ' order by Footday ';
   InputFootDataSet.Close ;
   InputFootDataSet.CommandText :=sql;
   if InputFootDataSet.Open  then
       if InputFootDataSet.RecordCount >0 then  begin
          Df:=InputFootDataSet.FieldByName('sumDownFootage').AsFloat;
          Uf:=InputFootDataSet.FieldByName('SumUpperFootage').AsFloat ;
          if Str='Upper' then  begin
             Result:=UF;
          end else if Str='Down' then  begin
             Result:=DF;
          end else begin
             if DF> Uf then  Result:=DF  else Result:=UF;
          end;
          exit;
       end;
   InputFootDataSet.Close ;

end;

destructor TDisposeData.Destroy;
var
   i:integer;
begin
     FreeAndNil(sw1);
     FreeAndNil(sw2);
     FreeAndNil(PressDataCommand);
     FreeAndNil(RealFootAgeCommand) ;
     FreeAndNil(InputFootCommand);
     FreeAndNil(RealFootDataSet);
     FreeAndNil(PressDataSet);
     FreeAndNil(inputFootDataSet);

     FreeAndNil(InputTimer) ;
     FreeAndNil(RealFootageTimer);
     FreeAndNil(PressDataConn) ;
     FreeAndNil(RealFootAgeConn) ;
     FreeAndNil(inputFootDataConn);

     inherited Destroy;
end;



procedure TDisposeData.FootageTimeTimer(Sender: Tobject);
begin
     RealFootageTimeCount:=RealFootageTimeCount+1;
     if RealFootageTimeCount>=60 then  begin
         RealFootage_CommitTrans ;
         self.RealFootageTimer.Enabled:=False;
         RealFootageTimeCount:=0;
         RealFootAgeConn.Close ;           //
//         if StopserviceCommand=2 then
//            MyMainFun.startService;
     end;
end;

function TDisposeData.FootageToDate(Gzmbh: integer; FG: double;
  Str: string): TDateTime;
var
  sql:string;
  DD,UD:TdateTime;
begin
   Result:=0;
   ConnectInputFootageLink;
   DD:=-1;UD:=-1;
   if Gzmbh <1  then exit;

   InputFootDataSet.Close;

   Sql:='select Footday from d_'+IntToStr(Gzmbh)+'_Footage ' +
        ' where sumDownFootage <= '+FormatFloat('0.00',FG)+' order by FootDay desc';
   InputFootDataSet.Close ;
   InputFootDataSet.CommandText :=sql;
   if InputFootDataSet.Open  then
       if InputFootDataSet.RecordCount >0 then begin
          DD:=InputFootDataSet.FieldByName('Footday').AsDateTime;
       end;

   Sql:='select Footday from d_'+IntToStr(Gzmbh)+'_Footage ' +
        ' where sumUpperFootage <= '+FormatFloat('0.00',FG)+' order by FootDay desc';
   InputFootDataSet.Close ;
   InputFootDataSet.CommandText :=sql;
   if InputFootDataSet.Open  then
       if InputFootDataSet.RecordCount >0 then begin
          UD:=InputFootDataSet.FieldByName('Footday').AsDateTime;
       end;
   InputFootDataSet.Close ;
   if (UD > 40000 )or ( DD > 40000)  then  begin
       if str='Upper' then begin
          Result:=UD;
       end else if str='Down' then begin
          Result:=DD;
       end else begin
          if (UD < DD ) then  Result:=UD  else Result:=DD;
       end;
       exit;
   end;
   //���û�в鵽��¼   ���ҵ�һ����¼
   Sql:='select Footday from d_'+IntToStr(Gzmbh)+'_Footage ' +
        ' order by FootDay ';
   InputFootDataSet.Close ;
   InputFootDataSet.CommandText :=sql;
   if InputFootDataSet.Open  then
       if InputFootDataSet.RecordCount >0 then begin
          Result:=InputFootDataSet.FieldByName('Footday').AsDateTime;
       end;
   InputFootDataSet.Close ;
end;

function TDisposeData.GetForcastResult(GzmList:TStringlist) : string;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
   ChildChildRoot,ChildChildChildRoot: TXmlNode;
   t,Fgzmid:integer;
   sql:string;
   FinGzm:TGzm;
   maxTime:TdateTime;
   DownfootAge,UpperFootage,jinchi:double;
   I,WarningNumber: Integer;
   WarningS,AVS:double;
   ExDataSet1:TMyDataSet;
   ExCommand1:TMyCommand;
begin
     MyXml:=TNativeXml.CreateName(UTF8String('��ɽѹ��Ԥ����Ϣ���ؽ��')) ;
     //
     FinGzm:=TGzm.Create(FinDataModule.ExConn);
     ExDataSet1:=TMyDataSet.Create(nil);
     ExDataSet1.MySqlConnection:=FinDataModule.ExConn;
     ExCommand1:=TMyCommand.Create(nil) ;
     ExCommand1.MySqlConnection := FinDataModule.ExConn;
     //
     RootNode:= MyXml.root.NodeNew('');
         RootNode.Name:='Custom';
     for t := 0 to GzmList.Count - 1 do  begin
         FGzmid:=StrToInt(GzmList[t]);
         FinGzm.setGzmNumber(FGzmid);
         FinGzm.InputGzmData(FGzmid) ;
         ChildRoot:=RootNode.NodeNew('');
         ChildRoot.Name:=UTF8String('WorkFaceName');   // workfacename
         ChildRoot.Value:= UTF8String(FinGzm.S_Name);
         //
        sql:='select Sumdownfootage, Sumupperfootage  from  D_' +Trim(inTToStr(FGzmid)) +'_footage '+
               ' where  footday <=''' +FormatDateTime('yyyy-mm-dd hh:nn:ss',now) +
               ''' and processage >0 order by footday desc limit 1 ' ;
          ExDataSet1.Close ;
          ExDataSet1.CommandText:=sql;
        if  ExDataSet1.Open  then begin
            if ExDataSet1.RecordCount <1 then  continue;
            DownfootAge:=ExDataSet1.FieldByName('Sumdownfootage').AsFloat;
            UpperFootage:=ExDataSet1.FieldByName('Sumupperfootage').AsFloat;
        end;
          ExDataSet1.Close ;

         //
         sql:=' select * from  D_' +Trim(IntToStr(FGzmid)) +'_Forcase where process <1 order by generatetime desc, phaseNumber ';
        // sql:=' select * from  D_' +Trim(IntToStr(FGzmid)) +'_Forcase  order by generatetime desc, phaseNumber ';
         ExDataSet1.Close;
         ExDataSet1.CommandText:=sql;
       if  ExDataSet1.Open then begin
         maxTime:=ExDataSet1.FieldByName('generatetime').AsDateTime;
          while not  ExDataSet1.Eof do begin
             ChildChildRoot:=ChildRoot.NodeNew('');
             ChildChildRoot.Name:=UTF8String('ForCaseNo:'+ intToStr(ExDataSet1.RecNo));
                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('Ԥ������'); // Ԥ������
                  ChildChildChildRoot.Value :=UTF8String('ѹ�����ݷ���Ԥ��');

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('Ԥ������ʱ��');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('generatetime').AsString);


                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('Ԥ������');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('PhaseNumber').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('֧�ܿ�ʼ���');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('StartSupid').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('֧����ֹ���');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('EndSupid').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('������Ԥ������');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('ForCaseNumber').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('������ѹ���࿪ʼ����');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('Start_Steps').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('������ѹ�����������') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('end_Steps').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('������ѹ����') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('each_steps').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('����ƽ������') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('AGVStep').AsString);


                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('�����˶����ҿ�ʼ') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('OutStandStartTime').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('�����˶�����ʱ��') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('endtime').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('�����˶�����') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('ComePresslevel').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('֧��ѹ�������������') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('OutStandSupport').AsString);
              ExDataSet1.Next;
           end;
       end;


       ExDataSet1.Close;
           //
       sql:=' update  D_' +Trim(IntToStr(FGzmid)) +'_Forcase set process =1   where  generatetime <= ''' +
            FormatDateTime('yyyy-mm-dd hh:nn:ss',maxTime)+  '''';

       ExCommand1.CommandText:=sql;
       ExCommand1.Execute;

        // δ��Ԥ��
          WarningNumber:=0;
         for I := 1 to  7 do  begin
              Jinchi := DownfootAge+(UpperFootAge-DownFootAge)/7 *(i-1);
              sql:=' select * from  D_' +Trim(IntToStr(FGzmid)) +'_Forcase where phaseNumber= ' +intToStr (i) +
                   ' and  end_steps < ' + FormatFloat('0.00',jinchi) +
                   ' order by  endtime desc limit 1';
               ExDataSet1.Close ;
               ExDataSet1.CommandText:=sql;
           if ExDataSet1.Open  then begin
               WarningS:=ExDataSet1.FieldByName('end_steps').AsFloat;
               AVS:=ExDataSet1.FieldByName('each_steps').AsFloat;
               if AVS <=0 then continue ;
            //   if ( WarningS + AVS >= Jinchi) and ((WarningS+ AVS-Jinchi)/AVS <=0.5)  then  begin
                 if ( WarningS + AVS >= Jinchi)   then  begin
                   ChildChildRoot:=ChildRoot.NodeNew('');
                   WarningNumber:=WarningNumber+1;
                   ChildChildRoot.Name:=UTF8String('WarningNo:'+ intToStr(WarningNumber));
                   ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                   ChildChildChildRoot.Name:=UTF8String('Ԥ������');
                   ChildChildChildRoot.Value :=UTF8String('ǰ��Ԥ��');

                   ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                   ChildChildChildRoot.Name:=UTF8String('���ڽ׶�');
                   ChildChildChildRoot.Value :=UTF8String(IntToStr(i));

                   ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                   ChildChildChildRoot.Name:=UTF8String('��ǰ�ô�����');
                   ChildChildChildRoot.Value :=UTF8String(FormatFloat('0.00',jinchi));

                   ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                   ChildChildChildRoot.Name:=UTF8String('֧�ܿ�ʼ���');
                   ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('StartSupid').AsString);

                   ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                   ChildChildChildRoot.Name:=UTF8String('֧����ֹ���');
                   ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('EndSupid').AsString);

                   ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                   ChildChildChildRoot.Name:=UTF8String('Ԥ����ѹ�ƽ�����');
                   ChildChildChildRoot.Value :=UTF8String(FormatFloat('0',WarningS + AVS));

                   ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                   ChildChildChildRoot.Name:=UTF8String('Ԥ�ƹ���������ƽ�');
                   ChildChildChildRoot.Value :=UTF8String(FormatFloat('0',WarningS + AVS-Jinchi));

                   ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                   ChildChildChildRoot.Name:=UTF8String('������ѹ����');
                   ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('ComePresslevel').AsString);

               end;
           end;
         end;
               ExDataSet1.Close ;
     end;
             //   ú�� �ɿ��� �ϲ�Ԥ��
    FinGzm.forcastsafe(ChildRoot);
   //  end; //end t

    MyXml.XmlFormat := xfReadable;
    MyXml.SaveToFile(MymainFun.Get_DllPath+'\ForCase.xml');
    Result:=Myxml.WriteToString ;
    Exdataset1.Free ;
    ExCommand1.Free ;
    FinGzm.Free ;
    MyXml.Free ;
end;

function TDisposeData.GetGzmBh(Value: String): String;
var
  ExDataSet1:TMyDataSet;
begin
      ExDataSet1:=TMyDataSet.Create(nil);
      ExDataSet1.MySqlConnection:=FinDataModule.ExConn;
      ExDataSet1.Close;
      ExDataSet1.CommandText:='select cqid,cqName from cqcsb  where  qyzt=1';
      if ExDataSet1.Open  then begin
        Result:=ExDataSet1.FieldByName('cqid').AsString ;
        while not ExDataSet1.Eof  do begin
               if Value= ExDataSet1.FieldByName('cqName').AsString then
                  Result:=ExDataSet1.FieldByName('cqid').AsString ;
               ExDataSet1.Next ;
        end;
      end;
      ExDataSet1.Close;
      ExDataSet1.Free ;
end;


function TDisposeData.GetGzmNameS: String;
 Var
   NameS:String;
   ExDataSet1:TMyDataSet;
begin
      ExDataSet1:=TMyDataSet.Create(nil);
      ExDataSet1.MySqlConnection:=FinDataModule.ExConn;
      NameS:='';
      ExDataSet1.Close;
      ExDataSet1.CommandText:='select cqid,cqName from cqcsb  where  qyzt=1';
      if ExDataSet1.Open then begin
          Result:='-1';
          while not ExDataSet1.Eof  do begin
                 NameS:= NameS+ ExDataSet1.FieldByName('cqName').AsString +';' ;
                 ExDataSet1.Next ;
          end;
      end;
       ExDataSet1.Close;
       ExDataSet1.Free ;
       Result:=Names;
end;

function TDisposeData.GetHistoryResult(Gzmid:integer; StartTime,  StopTime: TDateTime): string;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
   ChildChildRoot,ChildChildChildRoot: TXmlNode;
   t:integer;
   sql:string;
   FinGzm:TGzm;
   ExDataSet1:TMyDataSet;
begin
      ExDataSet1:=TMyDataSet.Create(nil);
      ExDataSet1.MySqlConnection:=FinDataModule.ExConn;

     MyXml:=TNativeXml.CreateName(UTF8String('��ɽѹ��Ԥ����Ϣ���ؽ��')) ;
     FinGzm:=TGzm.Create(FinDataModule.ExConn);
     RootNode:= MyXml.root.NodeNew('');
     RootNode.Name:='Custom';
     FinGzm.InputGzmData(Gzmid) ;
     ChildRoot:=RootNode.NodeNew('');
     ChildRoot.Name:=UTF8String('WorkFaceName');   // workfacename
     ChildRoot.Value:= UTF8String(FinGzm.S_Name);
     //
       sql:=' select * from  D_' +Trim(IntToStr(Gzmid)) +'_Forcase '+
            ' where  StartTime >=''' +FormatDateTime('yyyy-mm-dd hh:nn:ss',StartTime) + ''' '+
            ' and endtime <=''' +FormatDateTime('yyyy-mm-dd hh:nn:ss',StopTime) + ''' '+
            ' order by generatetime ';
       ExDataSet1.Close;
       ExDataSet1.CommandText:=sql;
       if ExDataSet1.Open then begin
           while not  ExDataSet1.Eof do begin
               ChildChildRoot:=ChildRoot.NodeNew('');
               ChildChildRoot.Name:=UTF8String('ForCaseNo:'+ intToStr(ExDataSet1.RecNo));
                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('Ԥ������');
                  ChildChildChildRoot.Value :=UTF8String('ѹ�����ݷ���Ԥ��');

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('Ԥ������ʱ��');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('generatetime').AsString);


                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('Ԥ������');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('PhaseNumber').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('֧�ܿ�ʼ���');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('StartSupid').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('֧����ֹ���');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('EndSupid').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('������Ԥ������');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('ForCaseNumber').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('������ѹ���࿪ʼ����');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('Start_Steps').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('������ѹ�����������') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('end_Steps').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('������ѹ����') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('each_steps').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('����ƽ������') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('AGVStep').AsString);


                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('�����˶����ҿ�ʼ') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('OutStandStartTime').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('�����˶�����ʱ��') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('endtime').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('�����˶�����') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('ComePresslevel').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('֧��ѹ�������������') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('OutStandSupport').AsString);
                ExDataSet1.Next;
            end;
       end;
       ExDataSet1.Close;
       ExDataSet1.free;

    MyXml.XmlFormat := xfReadable;
    MyXml.SaveToFile('D:\HistoryResult.xml');
    Result:=Myxml.WriteToString ;
    FinGzm.Free ;
    MyXml.Free ;
end;

function TDisposeData.GetInputDataMaxDatetime(Mineid,Gzmbh:integer): TDateTime;
Var
  MaxD1,MaxD2:TdateTime;
  id:integer;
begin
  if not InputFootDataConn.ServerConnected then  begin
        InputFootDataConn.Open(FinDataModule.EXDataIP,FinDataModule.Port,
                            FinDataModule.ExUser,FinDataModule.EXPassword,FinDataModule.DataBaseName);
     end;
   MaxD1:=1; MaxD2:=1;
   InputFootDataSet.Close ;
   InputFootDataSet.CommandText :='select max(generatetime) as MaxD from  D_'+Trim(IntToStr(Gzmbh))+'_BasicData  ';
   if  InputFootDataSet.Open then
       if InputFootDataSet.RecordCount >0 then
           MaxD1:= InputFootDataSet.FieldByName('MaxD').AsDateTime;


   InputFootDataSet.Close ;
   InputFootDataSet.CommandText :='select max(generatetime) as MaxD from  D_'+Trim(IntToStr(Gzmbh))+'_Strokedata  ';
   if InputFootDataSet.Open  then
       if InputFootDataSet.RecordCount >0 then
           MaxD2:= InputFootDataSet.FieldByName('MaxD').AsDateTime;

   InputFootDataSet.Close ;
   if MaxD1> MaxD2 then  Result:=MaxD1 else Result:=MaxD2;


end;




procedure TDisposeData.inFinishedE(TotalNumber, supbh: integer;
  elapsedtime: String; Suc: Boolean);
begin
     if TotalNumber <1 then   exit;
     if (writeProcessflag) then
        FinDataModule.InsertProcessLog(Now(),'FirstProcess',uDisPoseGzmBh,Supbh,
                       TotalNumber, elapsedtime,Suc,0,0);
      //WriteiniTotalNumber(TotalNumber);
      //ShowMessage(elapsedtime);

end;

function  TDisposeData.InPutdata(supportbh: integer; Dt: String; V1, v2, V3,
  V4: double;var elapsedtime:string):integer;
var
   R_i:integer;
   elapsedMilliseconds : cardinal;
begin
   Result:=0;
   if length(InputData_insertStr)<5 then exit;
   if (V1 >maxV1)  then V1:=MaxV1;
   if (V2> maxV2)  then V2:=MaxV2;
   if (V3 >maxV3)  then V3:=MaxV3;
   if (V4> maxV4)  then V4:=MaxV4;
 try
   if (FinDataModule.GetExDataType ='MYSQL' )or (FinDataModule.GetExDataType ='MY SQL') then   begin
          InputData_JoinStr:=InputData_Joinstr+' (' +InttoStr(Supportbh)
                          +',''' +dt
                          +''',' +Formatfloat('0.00',V1)
                          +',' +Formatfloat('0.00',V2)
                          +',' +Formatfloat('0.00',V3)
                          +',' +Formatfloat('0.00',V4)
                          +',' +IntToStr(0)
                          +'),';

             if length(InputData_JoinStr)>9000   then  begin
                  PressDataCommand.CommandText:=InputData_insertStr+
                          Leftstr(InputData_Joinstr,length(InputData_Joinstr)-1); //ȥ�����Ķ���iSqi;
                  PressDatacommand.Execute ;
                  ConnectInputDataLink;
                  PressDataconn.CommitTrans ;
                  PressDataconn.BeginTrans;
                  Result:=1;  InputData_JoinStr:='';
                  sw2.Stop;
                  elapsedMilliseconds:=sw2.ElapsedMilliseconds;
                  elapsedtime:=Format('%f',[elapsedMilliseconds/1000]);
                  sw2.start;
             end;
   end else  if (FinDataModule.GetExDataType ='SQLSERVER' )or (FinDataModule.GetExDataType ='SQL SERVER') then   begin
           InputData_JoinStr:=' (' +InttoStr(Supportbh)
                          +',''' +dt
                          +''',' +Formatfloat('0.00',V1)
                          +',' +Formatfloat('0.00',V2)
                          +',' +Formatfloat('0.00',V3)
                          +',' +Formatfloat('0.00',V4)
                          +',' +IntToStr(0)
                          +' )';
           PressDataCommand.CommandText:=InputData_insertStr+InputData_Joinstr;
          // ShowMessage(ExCommand1.CommandText);
           PressDatacommand.Execute ;
           SerVerInserCount:=SerVerInserCount+1;
           if SerVerInserCount >500 then  begin
                  PressDataconn.CommitTrans ;
                  PressDataconn.BeginTrans;
                  Result:=1;  SerVerInserCount:=0;
                  sw2.Stop;
                  elapsedMilliseconds:=sw2.ElapsedMilliseconds;
                  elapsedtime:=Format('%f',[elapsedMilliseconds/1000]);
                  sw2.start;
           end;
   end;
 except
    on e:exception do begin
           MyMainFun.WriteLog('Eorr: Insert InPut ����  '+e.Message,'[InputPressData]');
           PressDataSet.Close;;
     end;
 end;
end;

function TDisposeData.InputFootage(uGBh:string;tDay: Tdatetime; DownDayFootage,
  SumDownFootage, UpperDayFootage, SumUpperFootage: double;Flag:integer):Boolean;
  //Flag:integer д����  1 Ϊ ���ⲿ¼����ߣ�2 �Զ��������     3 �޶������
Var
   CSql:String;
   DownS,UpperS:double;
begin
    ConnectInputFootageLink;

    Result:=false;
    DownS:=0;UpperS:=0;
     CSql:='select * from D_'+uGBh+'_Footage where footday < '''
           + FormatDateTime( 'yyyy-mm-dd hh:nn',tDay)  +''' and processage=' + IntToStr(Flag)+
           ' order by Footday desc limit 1';
   try
     InputFootDataSet.Close ;
     InputFootDataSet.CommandText :=Csql;

     if InputFootDataSet.Open then
         if InputFootDataSet.RecordCount >0 then  begin
            DownS:=InputFootDataSet.FieldByName('SumDownFootage').AsFloat ;
            UpperS:=InputFootDataSet.FieldByName('SumUpperFootage').AsFloat ;
         end;
      InputFootDataSet.Close ;
     // insert
     if DownDayFootage =0 then   DownDayFootage:= SumDownFootage- DownS;
     if UpperDayFootage =0 then   UpperDayFootage:= SumUpperFootage- UpperS;
     if SumDownFootage=0 then   SumDownFootage:= DownS+DownDayFootage;
     if SumUpperFootage=0 then   SumUpperFootage:= UpperS+UpperDayFootage;

      CSql:='insert into d_'+uGBh+'_footage ( footday,downfootage,sumdownfootage,upperfootage, '+
              'sumupperfootage,processage) values (' +
              ''''+ FormatDateTime( 'yyyy-mm-dd hh:nn',tDay)+''','+
              FormatFloat('0.00',DownDayFootage)+','+ FormatFloat('0.00',SumDownFootage)+','+
              FormatFloat('0.00',UpperDayFootage)+','+ FormatFloat('0.00',SumUpperFootage) +
              ', '+IntToStr(Flag)+')';
      InputFootCommand.CommandText:=Csql;
      InputFootCommand.Execute ;
      Result:=true;
   except
     on e:exception do begin
        MyMainFun.WriteLog('Eorr:d_'+uGBh+','+e.Message,'[InputFootage]');
     end;
   end;

end;

function TDisposeData.InputFootSelectWorkFaceid(Mineid: integer;
  WorkFaceName: String): integer;
begin
  Result:=-1;
  try
      WorkFaceName:=UpperCase(WorkFaceName);
      ConnectInputFootageLink;
      InputFootDataSet.Close;
      InputFootDataSet.CommandText:='select kid,cqid,cqName from cqcsb  where cqName='''+WorkFaceName +'''' +
                                ' and  kid =' +IntToStr(Mineid);
     if  InputFootDataSet.Open then
        if InputFootDataSet.RecordCount>0 then  Result:=InputFootDataSet.FieldByName('cqid').AsInteger;

      InputFootDataSet.Close;
    except
     on e:exception do begin
        MyMainFun.WriteLog('Eorr:select kid,cqid,cqName ,'+e.Message,'[InputFootage]');
     end;
    end;

end;

function TDisposeData.InputFootSelKuangjingId(KuangjingName: String): integer;
begin
   KuangjingName:=UpperCase(KuangjingName);
   Result:=-1;
   try
      ConnectInputFootageLink;
      InputFootDataSet.Close;
      InputFootDataSet.CommandText:='select id,Meikuangming from Kuangjingxinxibiao  where MeikuangMing='''+KuangjingName +'''';
      if InputFootDataSet.Open then
        if InputFootDataSet.RecordCount>0 then
           Result:=InputFootDataSet.FieldByName('id').AsInteger;
    except
        Result:=-1;
        InputFootDataSet.Close;
    end;
     InputFootDataSet.Close;
end;

procedure TDisposeData.InputTimeTimer(Sender: Tobject);
var
  elp:string;
begin
     inputStarttime:=inputStarttime+1;
     if inputStarttime=60 then  begin
         InputData_CommitTrans(elp);
         inputStarttime:=0;
         self.InputTimer.Enabled:=false;
         PressDataconn.Close ;
         //
        // if StopserviceCommand=2 then     MyMainFun.startService;
    end;

end;

function TDisposeData.InsertAllWorkFaceTypeData(FirstType: integer; FirstDataTopLine: Double;
       SecondType: integer;SecondDataTopline: double; ThirdType: integer; ThirdDataTopLine: double;
       FouthType: integer; FourthDataTopLine: double): Boolean;
var
  ListGzm:TStringList;
  t,gzmbh:Integer;
begin
  ListGzm:= TStringList.Create ;
  Result:=False;
 try
  try
    ConnectInputDataLink;
    PressDataSet.Close;
    PressDataSet.CommandText:='select cqid from cqcsb where qyzt=1';
    if PressDataSet.Open then
       while not PressDataSet.Eof  do  begin
          ListGzm.Add(Trim(IntToStr(PressDataSet.FieldByName('cqid').AsInteger)));
          PressDataSet.Next ;
       end;
  finally
    PressDataSet.Close ;
  end;

  for t := 0 to ListGzm.Count-1 do begin
     gzmbh:=StrToInt(ListGzm[t]);
        SplitWorkFaceDataType(gzmbh,FirstType,FirstDataTopLine,SecondType,SecondDataTopline,
          ThirdType,ThirdDataTopLine,FouthType,FourthDataTopLine,1000);
  end;
    Result:=true;
 finally
   FreeAndNil(ListGzm) ;
 end;


end;

function TDisposeData.InsertGzmDataTypeValue(Gzmid, Dataid, DataType: integer;
  lowLine, topLine: Double; StartTime: TdateTime): Boolean;
var
  Csql:String;
begin
  Result:=false;
  try
      //����Inputdata �����ӿ��ܴ���BeginTrans״̬���������� InputFootage ����
      ConnectInputFootageLink;   //����Inputdata �����ӿ��ܴ���BeginTrans״̬���������� InputFootage ����
      Csql:='insert into GzmDataType (cqid,dataid,datatype,DatalowLine,DataTopLine,StartTime ' +
             ') values ( '+ IntToStr(Gzmid)+ ',' +IntToStr(Dataid)+ ',' +IntToStr(DataType)+ ','+
             FormatFloat('0.00',lowLine) +',' + FormatFloat('0.00',topLine)  + ',''' +
             FormatDateTime('yyyy-mm-dd hh:nn:ss',StartTime) +''')';
      InputFootCommand.CommandText:=Csql;
      InputFootCommand.Execute ;

  finally
    Result:=true;
  end;
end;

procedure TDisposeData.InsetSql(Sql: string);
var
 ExCommand1:TMyCommand;
begin
      ExCommand1:=TMyCommand.Create(nil);
      ExCommand1.MySqlConnection:=FinDataModule.ExConn ;
      ExCommand1.CommandText :=sql;
      ExCommand1.Execute ;
      ExCommand1.Free ;

end;




function TDisposeData.RealFootAge_Begintrans: Boolean;
begin
      Result:=False;
      RealFootage_insertStr:='';
      if uDisPoseGzmBh= '' then exit;
      RealFootage_insertStr:=' insert into D_'+Trim(uDisPoseGzmBh)+'_StrokeData  (' +
        ' supportbh,Generatetime,DataValue,Process,MoveState ) values ' ;

      RealFootage_JoinStr:='';
      //��ʼ�����Բ���
    try
      try
           ConnectRealFootLink;
      finally
           RealFootAgeConn.BeginTrans ;
           RealFootAgeBeginTrans:=1;
           RealFootageTimeCount:=0;
           Result:=true;
      end;
    except
      on e:exception do begin
           MyMainFun.WriteLog('Eorr: Begintrans ����  '+e.Message,'[RealTimeFootAge]');
           RealFootDataSet.Close;;
     end;
    end;


end;

function TDisposeData.RealFootAge_CommitTrans: Boolean;
var
  iSqi:string;
begin
      Result:=False;
      if (length(RealFootage_insertStr)<5 ) or ( length(RealFootage_Joinstr) <1 ) then begin
         ConnectRealFootLink;
         RealFootageconn.RollbackTrans ;
         exit;
      end;

      try
         if (FinDataModule.GetExDataType ='MYSQL' )or (FinDataModule.GetExDataType ='MY SQL') then   begin
              iSqi:=RealFootage_insertStr+Leftstr(RealFootage_Joinstr,length(RealFootage_Joinstr)-1); //ȥ�����Ķ���
              RealFootagecommand.CommandText:=iSqi;
              RealFootagecommand.Execute ;
         end;
          ConnectRealFootLink;
          RealFootageconn.CommitTrans ;
          RealFootageBeginTrans:=0;
          RealFootageTimeCount:=0;
      finally
          Result:=true;
      end;


end;

function TDisposeData.RealSelectWorkFaceid(Mineid: integer;
  WorkFaceName: String): integer;
begin
    Result:=-1;
    try
      ConnectRealFootLink;

      RealFootDataSet.Close;
      RealFootDataSet.CommandText:='select kid,cqid,cqName from cqcsb  where cqName='''+WorkFaceName +'''' +
                                ' and  kid =' +IntToStr(Mineid);
     if  RealFootDataSet.Open then
      if RealFootDataSet.RecordCount>0 then
         Result:=RealFootDataSet.FieldByName('cqid').AsInteger;

      RealFootDataSet.Close;
    except
       on e:exception do begin
        MyMainFun.WriteLog('Eorr:select kid,cqid,cqName ,'+e.Message,'[RealTimeFootAge]');
       end;

    end;

end;

function TDisposeData.RealSelKuangjingId(KuangjingName: String): integer;
begin
    KuangjingName:=UpperCase(KuangjingName);
    Result:=-1;
    try
      ConnectRealFootLink;
      RealFootDataSet.Close;
      RealFootDataSet.CommandText:='select id,Meikuangming from Kuangjingxinxibiao  where MeikuangMing='''+KuangjingName +'''';
     if  RealFootDataSet.Open then
      if RealFootDataSet.RecordCount>0 then
        Result:=RealFootDataSet.FieldByName('id').AsInteger;
    finally
      RealFootDataSet.Close;
    end;


end;

function TDisposeData.RealTimeFootAge(gzmid, supportbh: Integer;
  Generatetime: TdateTime; RealDataValue: double): Boolean;
var
   sql:string;
begin
 Result:=False;
 if length(RealFootage_insertStr)<5 then exit;
 try
   if (FinDataModule.GetExDataType ='MYSQL' )or (FinDataModule.GetExDataType ='MY SQL') then   begin
          RealFootage_JoinStr:=RealFootage_Joinstr+'(' + IntToStr(supportbh)+','''+
                              FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Generatetime)+''','  +
                              Formatfloat('0.0',RealDataValue)+
                               ',0,0),';
             if length(RealFootage_JoinStr)>9000   then  begin
                  RealFootageCommand.CommandText:=RealFootage_insertStr+
                          Leftstr(RealFootage_Joinstr,length(RealFootage_Joinstr)-1); //ȥ�����Ķ���iSqi;
                  ConnectRealFootLink;
                  RealFootagecommand.Execute ;
                  RealFootageconn.CommitTrans ;
                  RealFootageconn.BeginTrans;
                  RealFootage_JoinStr:='';
                  RealFootageTimeCount:=0;
             end;
      Result:=True;
   end;
 except
    on e:exception do begin
           MyMainFun.WriteLog('Eorr: Insert Footage ����  '+e.Message,'[RealTimeFootAge]');
    end;
 end;

end;

procedure TDisposeData.RefreshProcessFlag;
var
  FGzm:String;
  ExDataSet1:TMyDataSet;
  ExCommand1:TMyCommand;
begin
    ExDataSet1:=TMyDataSet.Create(nil);
    ExDataSet1.MySqlConnection:=FinDataModule.ExConn;
    ExCommand1:=TMyCommand.Create(nil);
    ExCommand1.MySqlConnection :=FinDataModule.ExConn;
   ExDataSet1.Close ;
   ExDataSet1.CommandText:='select cqid from cqcsb where qyzt=1';
  if  ExDataSet1.Open then
       while not ExDataSet1.Eof  do  begin
          FGzm:=Trim(IntToStr(ExDataSet1.FieldByName('cqid').AsInteger));
          ExCommand1.CommandText :='update D_'+FGZM+'_ProcessRecord  set used=0';
          ExCommand1.Execute;
          ExDataSet1.Next ;
       end;
   ExDataSet1.Close ;
   ExDataSet1.Free ;
   ExCommand1.Free ;
end;

// end function



function TDisposeData.SelectBasicRecordNumber(MyConn:TMySqlConnection;FGzm: String; var MinSupBh,
  MaxSupBh, SumTotal: integer): Boolean;
var
   Sql:string;
   inn_Dataset:TMyDataSet;
begin
     Result:=false;
     try
         inn_Dataset:=TMyDataSet.Create(nil);
         inn_Dataset.MysqlConnection:=MyConn;
         Sql:=' select  min(supportbh) as Minbh,max(supportbh) as maxbh, count(id) as SumT from D_'+Trim(FGzm)+'_BasicData ' +
               ' where  FirstProcess=0 ';
         inn_Dataset.Close;
         inn_Dataset.CommandText :=sql;
         if inn_Dataset.Open  then begin
             MinSupbh:=inn_Dataset.FieldByName('Minbh').AsInteger;
             MaxSupbh:=inn_Dataset.FieldByName('Maxbh').AsInteger;
             SumTotal:=inn_Dataset.FieldByName('sumT').AsInteger;
         end;
         sql:='select min(supportbh) as Minbh,max(supportbh) as Maxbh from D_'+Trim(FGzm)+'_Strokedata';

         inn_Dataset.Close;
         inn_Dataset.CommandText :=sql;
         if inn_Dataset.Open then begin
             if MinSupbh> inn_Dataset.FieldByName('Minbh').AsInteger then
                MinSupbh:=inn_Dataset.FieldByName('Minbh').AsInteger;
             if MaxSupbh< inn_Dataset.FieldByName('Maxbh').AsInteger then
                MaxSupbh:=inn_Dataset.FieldByName('Maxbh').AsInteger;
         end;
         inn_Dataset.Close;
     finally
         Result:=true;
     end;
     inn_Dataset.Close;
     inn_Dataset.Free;

end;

function TDisposeData.SelectBasicSupportExsit(FGzm: String;
  supbh: integer): Boolean;
var
  sql:string;
  ExDataSet1:TMyDataSet;

begin
    Result:=false;
    ExDataSet1:=TMyDataSet.Create(nil);
    ExDataSet1.MySqlConnection:=FinDataModule.ExConn;

    Sql:=' select  id  from D_'+Trim(FGzm)+'_BasicData  where  FirstProcess=0  and supportbh ='+intTostr(supbh);
     ExDataSet1.Close;
     ExDataSet1.CommandText :=sql;
     if ExDataSet1.Open then
         if ExDataSet1.RecordCount>10  then Result:=true else Result:=false;
     ExDataSet1.Close;
     ExDataSet1.Free ;

end;

function TDisposeData.SelectGzmDataTypeExsit(Gzmid, Dataid, DataType:Integer;Stime:TdateTime): Boolean;
var
  Minus:Double;
  sql:String;
begin
  Result:=false;
  Minus:=1/21/60;
  try
      ConnectInputDataLink;
      PressDataSet.Close;
      sql:='select count(id) as Sid from GzmDataType where cqid='+IntTostr(Gzmid) +
                 ' and dataid = '+ intToStr(Dataid)  +' and DataType =' +IntTostr( DataType) +
                 ' and StartTime >='''+FormatDateTime('yyyy-mm-dd hh:nn',Stime-Minus) +':00''' +
                 ' and StartTime <='''+FormatDateTime('yyyy-mm-dd hh:nn',Stime+Minus*2) +':00''';
      PressDataSet.CommandText:=sql;
     if  PressDataSet.Open then
       if PressDataSet.FieldByName('Sid').AsInteger >0 then
           Result:=true;

  finally
     PressDataSet.Close;
  end;
end;

function TDisposeData.SelectBasicDataCount(GzmBh:string): Boolean;
begin
   Result:=true;
   if BasicRecordCount=-1 then   begin
      ConnectInputDataLink;
      PressDataSet.Close;
      PressDataSet.CommandText:='select count(id) as Su from D_'+Gzmbh+'_BasicData ';
      if PressDataSet.Open then
         BasicRecordCount:=PressDataSet.FieldByName('Su').AsInteger;
      PressDataSet.Close;

   end else begin
      BasicRecordCount:=BasicRecordCount+1;
   end;

   if BasicRecordCount>150000 then  begin
     Result:=false;
     BasicRecordCount:=-1;
     StrokeRecorderCount:=-1;
   end;

end;

function TDisposeData.SelectProcessRecorderUsed(FGzm: String;
  supbh: integer): Boolean;
Var
  sql:string;
   ExDataSet1:TMyDataSet;

begin
    Result:=false;
    ExDataSet1:=TMyDataSet.Create(nil);
    ExDataSet1.MySqlConnection:=FinDataModule.ExConn;

     try
         sql:='select  Used from D_'+FGzm+'_ProcessRecord where SupportBh =' +intToStr(supbh);
         ExDataSet1.Close;
         ExDataSet1.CommandText:=Sql;
         if ExDataSet1.Open then
            if ExDataSet1.RecordCount>0 then
                if ExDataSet1.FieldByName('Used').AsInteger =1 then  result:=true;
         ExDataSet1.Close;
     except
          Result:=false;
     end;
     ExDataSet1.Free ;

end;



function TDisposeData.SelectStokeData(Gzmbh: String): Boolean;
begin
    Result:=true;
    if StrokeRecorderCount=-1 then  begin
       ConnectRealFootLink;
       RealFootDataSet.Close;
       RealFootDataSet.CommandText :='select count(id) as Su from D_'+GzmBh+'_Strokedata ';
      if  RealFootDataSet.Open then
          StrokeRecorderCount:=RealFootDataSet.FieldByName('Su').AsInteger;
       RealFootDataSet.Close;
    end else begin
       StrokeRecorderCount:=StrokeRecorderCount+1;
    end;

    if StrokeRecorderCount >200000 then  begin
       Result:=false;
       StrokeRecorderCount:=-1;
       BasicRecordCount:=-1;
    end;




end;

function TDisposeData.SelectWorkFaceid(Mineid: integer;
  WorkFaceName: String): integer;
begin
    Result:=-1;
    try
      ConnectInputDataLink;
      PressDataSet.Close;
      PressDataSet.CommandText:='select kid,cqid,cqName from cqcsb  where cqName='''+WorkFaceName +'''' +
                                ' and  kid =' +IntToStr(Mineid);
      if PressDataSet.Open then
         if PressDataSet.RecordCount>0 then
            Result:=PressDataSet.FieldByName('cqid').AsInteger;
      PressDataSet.Close;
    except
        on e:exception do begin
           MyMainFun.WriteLog('Eorr: Select GzmID  '+e.Message,'[InputPressData]');
           PressDataSet.Close;;
        end;

    end;

end;

function TDisposeData.SelKuangjingId(KuangjingName: String): integer;
begin
  Result:=-1;
   KuangjingName:=UpperCase(KuangjingName);
  try
      ConnectInputDataLink;

      PressDataSet.Close;
      PressDataSet.CommandText:='select id,Meikuangming from Kuangjingxinxibiao  where MeikuangMing='''+KuangjingName +'''';
     if  PressDataSet.Open then
       if PressDataSet.RecordCount>0 then
        Result:=PressDataSet.FieldByName('id').AsInteger;

     PressDataSet.Close;
    except
     on e:exception do begin
           MyMainFun.WriteLog('Eorr: SelectKuangjingId  '+e.Message,'[InputPressData]');
           PressDataSet.Close;;
     end;

    end;

end;

procedure TDisposeData.SetAppointFootageStop(Value: boolean);
begin
      AppointFootageStop:=Value;
end;


procedure TDisposeData.SetDateNeverDiscontime(Value: integer);
begin

end;

procedure TDisposeData.SetFirstProcessStop(Value: Boolean);
begin
      FirstProcessStop:=Value;
end;

procedure TDisposeData.SetFourthProcessStop(Value: boolean);
begin
      FourthProcessStop:=Value;
end;

procedure TDisposeData.setGzmbm(Bh: String);
begin
       uDisPoseGzmBh:=bh;
end;


procedure TDisposeData.SetmaxValuetopLine(V1, V2, V3, V4: double);
begin
    if (V1>10 )  then    MaxV1:=V1
         else  MaxV1:=50;
    if (V1>10 )  then    MaxV2:=V2
         else  MaxV2:=50;
    if (V1>10 )  then    MaxV3:=V3
         else  MaxV3:=50;
    if (V1>10 )  then    MaxV4:=V4
         else  MaxV4:=50;
     
end;

procedure TDisposeData.SetSecondProcessStop(Value: Boolean);
begin
        SecondProcessStop:=Value;
end;


procedure TDisposeData.SetThirdProcessStop(Value: boolean);
begin
       ThirdProcessStop:=Value;
end;

function TDisposeData.SplitWorkFaceDataType(Gzmid,FirstType: integer;
     FirstDataTopLine: Double; SecondType: integer; SecondDataTopline: double;
     ThirdType: integer; ThirdDataTopLine: double;  FouthType: integer;
     FourthDataTopLine: double; StartTime:TdateTime): Boolean;
var
  DataType:Array [1..4] of Integer;
  DataValue:Array [1..4,0..1] of double;
  i:integer;
begin
  Result:=true;
  try
   DataType[1]:= FirstType;
         DataValue[1][1]:=FirstDataTopLine;
   DataType[2]:= SecondType;
         DataValue[2][1]:=SecondDataTopline;
   DataType[3]:= ThirdType;
         DataValue[3][1]:=ThirdDataTopLine;
   DataType[4]:= FouthType;
         DataValue[4][1]:=FourthDataTopLine;

   for I := 1 to 4 do  begin
      if DataType[i] > 0 then
        if not  SelectGzmDataTypeExsit(Gzmid,i,DataType[i],StartTime) then
            InsertGzmDataTypeValue(Gzmid,i,DataType[i],0,DataValue[i][1],StartTime)  ;
   end;
     SetmaxValuetopLine(FirstDataTopLine, SecondDataTopline, ThirdDataTopLine, FourthDataTopLine);
  except
    Result:=False;
  end;
end;

end.