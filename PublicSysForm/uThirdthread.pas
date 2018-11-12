//    该函数是使用步距为循环变量的统计方法,由于工作面可能上下顺槽的进尺不一致
// 造成同一个计算区域步距具有较大的差异,
//    该计算方法对于没有较大调角工作面具有一定的适应性
// 该函数的姊妹函数是uFourththread ,该文件主要是使用 时间作为循环的方式
//
//
unit uThirdthread;

interface
uses
    Classes,uDisPoseData, GzmClass,MySQLDataSet,SysUtils,uDataModule,math,System.TypInfo,
     Winapi.ActiveX;

type
  dFourRec =^TTime_FourthPD;
  TTime_FourthPD= packed record
      generatetime:Tdatetime;   // 数据产生时间
      Phasenumber:integer;     //阶段数目
      ForcaseNumber:integer;   //预测编号
      eachsteps:double;        // 当前步距的进尺
      startfootage:double;    // 来压开始步距
      endfootage:double;      //来压结束步距
      startSupid:integer;     //开始支架编号
      EndSupid:integer;       //结束支架编号
      ComePressStarttime:tdatetime; // 来压开始时间
      EndPresstime:tdatetime;      //来压结束时间
      OutStandComePressStartTime:tdatetime;  // 显著来压时刻
      OutStandSupport:String;  // 支架来压序列
      AGVStep:double;     // 平均步距
      dayJinchi:double;    //每天进尺
      ComePressLevel:integer;  // 来压强度 五种状态
      AGVSecondJudge:double;  //第二次判断均值
      CycleSecondJudge:double;  // 当前第二次判断均值
      thirdJ_AGV:double;      //第三次判断均值
      thirdJ_Max:double;      // 第三次判断最大值
      AGVData:double;   //本次来压的均值
      SupportBeforeMoveData:double;//  本次来压的末阻力
      OldToPressure:integer;//老顶来压标记
      OldToPressureStep:double;//老顶来压步距
  end;


  PRec_Three = ^TTime_ThirdDPD;
  TTime_ThirdDPD =packed record
     dSupStartBh:integer;
     dSupEndBh:integer;
     dSupNumber:integer;
     did:integer;
     dRecordNumber:integer;
     dMinData:double;
     dMaxData:double;
     dAGvData:double;
     dAGvDataFangCha:double;
     dAGVSupportMovePress:double;
     dPressWeigth:double;
     dString:String;
     dmaxWightSupbh:integer;
     MaxWeightValue:double;
     dFootage:double;
     dFootageInterval:double;
     dStartTime:Tdatetime;
     dEndTime:TdateTime;
     stepStartTime:TdateTime;
     firstjudge:integer; //顶板来压状态
     ForeCase_step:double;//预测步距
     ForeCase_Pass_l:double; // 预测走过的距离
     ForeCase_Front_l:double; // 预测下一个步距的距离
     judgeLeval:double;//判断标准
     DsystemMinfootage:double;
     secondJudge,thirdjudge:integer;
  end;

   TThirdThread=class(TThread)
   private
      TotalNumber:Integer;
      FGzmbh:String;
      FSupbh:integer;
      succeed:Boolean;
      EspTime:String;
      FDataTimeintVal:double;

      FDisPose:TDisposeData;
      FinGzm:TGzm;
     // Fsconn:String;
      ProcessTime:integer;
      ForCaseFlag:String;
      //

      dRecArry:array [0..8] of PRec_Three;
      RecArryNumber:integer;
      //dRecList:TList;
      dFourRec:dFourRec;
      FAdoconn:TMySqlConnection;
      FAdoDataSet1:TMyDataSet;
      FAdoDataSet2:TMyDataSet;
      FAdoCommand:TMyCommand;
      DataBaseType:String;
      Pub_judgeLeval:double;
      RebalanceNumber:integer;
      OldStep:Integer;
      // 停止线程服务
      uThirdProcessStop:Boolean;
   protected

     procedure Execute ;override;

     function SelectMinFootAge(dGzmid:string;typeValue:string;Minsupid,Maxsupid:integer;
                               Var Minsupid_Minfootage,Minsupid_Maxfootage,MaxSupid_MinFootage,
                               MaxSupid_MaxFootage: double ):Boolean;
     function SelectCountData(sql,Field1:string;Var Value:double):Boolean;
     procedure insertOrUpdateData(Sql:string);
     function ThirdDisPosePressDate(FGzmid:string;var TotalCount:integer;
                          var elapsedtime:string):Boolean;  //数据处理核心程序
     function SelectEachPhase(FGzmid,typeValue:string;PhaseNumber:integer;FootageInterval:double):Boolean;
     function selectPhaseComplete(dGzmid,typeValue:string;PhaseStartSupNo,PhaseEndSupNo:integer):Boolean;
     function FillDRec(FGzmid,typeValue:string;var DRec:PRec_Three;FootStep,FootageInterval:double): Boolean;
     function InsertDatabase( FGzmid,typeValue:string;DRec:PRec_Three):Boolean;
     function RebalanceDataBase(FGzmid,typeValue:string;var DRec:PRec_Three):boolean;
     function EditOldStep(FGzmid,typeValue:string;PhaseNumber:integer;Footage:double):Boolean;
     function JudgeMAXFootageFalg(FGzmid,typeValue:string;PhaseNumber:integer;
                               StartFootage,endFootage,FootageInterval:double):double;
     function IntiArrayDrec:Boolean;
     function SelectProcessTime(FGzmid,typeValue:string;PhaseNumber:integer;
                     Var ProcessNumber:integer):Boolean;
     function SelectJudgeLevel(FGzmid,typeValue:string;PhaseNumber:integer;
                     Var JudgeLevel,UsedOldstep:double):Boolean;
     //-------
     function ForCaseRockPress(FGzmid:string;var TotalCount:integer;
                          var elapsedtime:string):Boolean;  //数据处理核心程序;
     Function ForcaseThirdTable(FGzmid,typeValue:string;PhaseNumber:integer;FootageInterval:double):Boolean;
     function ForcaseSelectData(FGzmid,typeValue:string;PhaseNumber:integer;FootageInterval:double):Boolean;
     function ForCaseSelectCycleSecond(FGzmid,typeValue:string;PhaseNumber:integer;FootS,FootE:double):Boolean;
     function ForcaseDayJinChi(FGzmid,typeValue:string;PhaseNumber:integer):Boolean;
     function SaveFourthProcessData(FGzmid,typeValue:string;PhaseNumber:integer):Boolean;
     function ReturnPressStartTime(secondJudge:double;OST:integer;DT:Tdatetime):Integer;
     function ForcasePressIntensity(secondJudge,thirdJudge:double;OST:integer):Integer;
     procedure initPFourRec(pd:dFourRec);
     function ForcaseOldPressure(FGzmid,typeValue:string;PhaseNumber:integer):Boolean;
     function UpdataForcaseData(FGzmid:string ; id:integer;ComeFlag:integer;
              ComeStep,ForaseNextStep:double):Boolean;
     function selectMaxFootAge(FGzmid:string):double;
     procedure RefreshThreadState;
     function MakeForCaseNextStep(FGzmid,typeValue:string;PhaseNumber:integer;
              NowFootage,FirstStep:double):Double;

   public
      destructor Destroy; override;
      constructor  Create(uObjusers:TDisposeData;BaseType,Flag:string);

  end;

implementation

{ TThridhread }
//uses ;

constructor TThirdThread.Create(uObjusers:TDisposeData;BaseType,Flag:string);
var
   v1,v2,v3,v4,j:integer;
begin
     Inherited  Create(true) ; //继承 创建后 不启动 只有发出Resum采启动
     CoInitialize(Nil);
     FreeOnTerminate := True;

     ForCaseFlag:=Flag;
     FDisPose:=uObjusers;
     FAdoconn:=TMySqlConnection.Create(nil);
     FAdoconn.Open(uObjusers.FinDataModule.EXDataIP,uObjusers.FinDataModule.Port,uObjusers.FinDataModule.ExUser,
                    uObjusers.FinDataModule.EXPassword,uObjusers.FinDataModule.DataBaseName);

     FAdoDataSet1:=TMyDataSet.Create(nil);
     FAdoDataSet2:=TMyDataSet.Create(nil);
     FAdoCommand:=TMyCommand.Create(nil);
     FAdoDataSet1.MySqlConnection:=FAdoconn;
     FAdoDataSet2.MySqlConnection:=FAdoconn;
     FAdoCommand.MySqlConnection:=FAdoconn;

     FinGzm:=TGzm.Create(FAdoconn) ;
     DataBaseType:=BaseType;     //

     for j := 0 to 7 do  new(dRecArry[j]);
     //
     new(dFourRec);
     initPFourRec(dFourRec);
     //
     ProcessTime:=1;
     Pub_judgeLeval:=0.2;
     RebalanceNumber:=0;
end;

destructor TThirdThread.Destroy;
var
  j:integer;
 begin
    for j := 0 to 7 do
         Dispose(dRecArry[j]);
     DisPose(dFourRec);

     FreeAndNil(FAdoDataSet1);
     FreeAndNil(FAdoDataSet2);
     FreeAndNil(FAdoCommand);
     FreeAndNil(FinGzm) ;
     FAdoconn.Free ;
     CoUninitialize;
     inherited Destroy;
end;  
function TThirdThread.EditOldStep(FGzmid, typeValue: string;PhaseNumber:integer;Footage:double): Boolean;
var
  sql:string;
   AdjustCount:integer;
   Adjust_MinStep,Adjust_MaxStep,Adjust_AGVvstep:double;
begin
    Result:=false;
    sql:='select count(id) as StepCount,Min(ForCaseStep) as MinStep ,Max(ForCaseStep) as MaxStep '+
              ' , AVG(ForCaseStep) as AGVStep from D_' + Trim(FGzmid) +'_ThirdDP where Footage <' +  FormatFloat('0.00',Footage) +
               ' and phaseNumber =' +IntTostr(PhaseNumber) +  ' and EditOldStep =0  and '+' ThirdJudge >0 ' +
               ' and ForCaseStep > '+FormatFloat('0.00',FinGzm.Old_Step[2]*0.5) +' and TypeData= ''' +typeValue +'''';

     FAdoDataSet1.Close ;
     FAdoDataSet1.CommandText :=sql;
   if FAdoDataSet1.Open then begin
         AdJustCount:= FAdoDataSet1.FieldByName('StepCount').AsInteger;
         AdJust_MaxStep:= FAdoDataSet1.FieldByName('MaxStep').AsFloat;
         AdJust_MinStep:= FAdoDataSet1.FieldByName('MinStep').AsFloat;
         Adjust_AGVvstep:= FAdoDataSet1.FieldByName('AGVStep').AsFloat;
         FAdoDataSet1.Close ;

         if AdJustCount >=5 then  begin
              if FinGzm.Old_Step[2]=0 then FinGzm.Old_Step[2]:=15;
              if ((100*abs(Adjust_AGVvstep -FinGzm.Old_Step[2])/FinGzm.Old_Step[2])>=10)
                 and (RebalanceNumber<3)  then  begin
                  FinGzm.EditOldstep( AdJust_MaxStep,AdJust_MinStep,Adjust_AGVvstep);
                  FinGzm.UpdateEditZkzinfo;
                  FinGzm.Get_PStope_OldInfo;
                  FinGzm.UpdatedataBaseToZkInfo;
              end;                     //

             sql:=' update D_' +Trim(FGzmid) +'_ThirdDP  set EditOldStep=1,UsedOldStep=' + FormatFloat('0.00',FinGzm.Old_Step[2]) +
                  ' where Footage <' +  FormatFloat('0.00',Footage) +
                  ' and phaseNumber =' +IntTostr(PhaseNumber) +  ' and EditOldStep =0  ' +' and TypeData= ''' +typeValue +'''';
             FAdoCommand.CommandText:=sql;
             FAdoCommand.Execute ;
             Result:=true;
         end;
   end;
   FAdoDataSet1.Close ;
end;

procedure TThirdThread.Execute;
var
   t,TCount:integer;
   ListGzm:TStringList;
   sql:string;
   Gzm_Simple,Gzm_Difficult,Zk_str,SEorr:string;
   GetPStopeStr:String;
begin
  inherited;
   ListGzm:= TStringList.Create ;
   FAdoDataSet1.Close ;
   FAdoDataSet1.CommandText:='select cqid from cqcsb where qyzt=1';
   if FAdoDataSet1.Open then
       while not FAdoDataSet1.Eof  do  begin
          ListGzm.Add(Trim(IntToStr(FAdoDataSet1.FieldByName('cqid').AsInteger)));
          FAdoDataSet1.Next ;
       end;
   FAdoDataSet1.Close ;

   //
   totalnumber:=0;
   if ForCaseFlag='ThirdThread' then  begin  // 'ThirdThread'
       for t := 0 to ListGzm.Count - 1 do begin
            if FDisPose.ThirdProcessStop   then  break;
            FGzmbh:=ListGzm[t];
            // 读取 FinGzm的数据
            FinGzm.setGzmNumber(StrToint(FGzmbh)) ;
            if FinGzm.ReadData then   begin
               FinGzm.RefreshFootage(100);
               FinGzm.GetGzmZkStr(Gzm_Simple,Gzm_Difficult,Zk_str);
               FinGzm.MyP_stope.InitModel(Gzm_Simple,Zk_str,SEorr);
               GetPStopeStr:=FinGzm.Get_PStope_OldInfo ;
               OldStep:=Round(FinGzm.Old_Step[2]);
               ThirdDisPosePressDate(FGzmbh,TCount,EspTime);
            end else begin
              FinGzm.MakeGzmIsVail(0);
            end;
       end; //end t
   end else if ForCaseFlag='Forcase' then  begin  //  'ForCase'
      for t := 0 to ListGzm.Count - 1 do begin
            if FDisPose.FourthProcessStop   then  break;
            FGzmbh:=ListGzm[t];
            FinGzm.setGzmNumber(StrToint(FGzmbh)) ;
            if FinGzm.ReadData then   begin
               FinGzm.RefreshFootage(100);
               FinGzm.GetGzmZkStr(Gzm_Simple,Gzm_Difficult,Zk_str);
               FinGzm.MyP_stope.InitModel(Gzm_Simple,Zk_str,SEorr);
               GetPStopeStr:=FinGzm.Get_PStope_OldInfo ;
               ForCaseRockPress(FGzmbh,TCount,EspTime);
            end else begin
               FinGzm.MakeGzmIsVail(0) ;
            end;
      end; //end t
   end;


   FreeAndNil(ListGzm) ;
   //
   if (FDisPose.writeProcessflag) then
      sql:=' insert into processlog (generatetime,DataNumber,threadid,Processtype) values (''' +
        FormatDaTeTime('yyyy-mm-dd hh:nn:ss',now())+''','+IntToStr(TCount)+',' +
        IntToStr(self.Handle)+','''+ForCaseFlag+'Stop'')' ;

   FAdoCommand.CommandText:=sql;
   FAdoCommand.Execute ;


end;

function TThirdThread.FillDRec(FGzmid, typeValue: string; var DRec: PRec_Three;
         FootStep,FootageInterval:double): Boolean;
var
  sql:string;
  MaxWeightSupbh:integer;
  RetVaule:double;
  Max_V,Min_V,Agv_V,Fangcha,Group_AGV:double;
  maxWeight, Weight:double;
  DownMinFootage,DownMaxFootage,UpperMinFootage,UpperMaxFootage:integer;
  MinFage,MaxFage:integer;
  MaxTime,MinTime:TdateTime;
  temp_w:double;
begin
      Result:=false;

       sql:= ' select AVG(AGV_Cycle_Value) as AGV_V  from  D_'+trim(FGzmid)+'_Seconddp' +
             ' where Footage > ' +FormatFloat('0.00',FootStep) +
             ' and Footage <= ' +  FormatFloat('0.00',FootStep+FootageInterval) +
             ' and supportworkingstate >1 and TypeData= '''+typeValue+'''  '+
             ' and supportbh >= ' +IntTostr(DRec.dSupStartBh) +
             ' and supportbh <= ' +IntToStr(DRec.dSupEndBh);

         SelectCountData(sql,'AGV_V',AGV_V);
         sql:= ' select sum(power(2,supportworkingstate)) as weight,count(id) as CN,supportbh,AVG(AGV_Cycle_Value) as AGV_V, ' +
             ' Max(Max_Value) as Max_v ,Min(Min_Value) as Min_V,Min(starttime) as Min_T,Max(Endtime) as Max_t,SupportBeforeMovePress ' +
             ' from  D_'+trim(FGzmid)+'_Seconddp' +
             ' where Footage > ' +FormatFloat('0.00',FootStep) +
             ' and Footage <= ' +  FormatFloat('0.00',FootStep+FootageInterval) +
             ' and supportworkingstate >1 and TypeData= '''+typeValue+'''  '+
             ' and supportbh >= ' +IntTostr(DRec.dSupStartBh) +
             ' and supportbh <= ' +IntToStr(DRec.dSupEndBh) +
             ' group by supportbh order by supportbh';

        FAdoDataSet1.Close ;
        FAdoDataSet1.CommandText :=sql;
     if  FAdoDataSet1.Open then begin
        if FAdoDataSet1.RecordCount<1 then  begin
           DRec.dRecordNumber:=0;
           exit;
        end;

        FAdoDataSet1.First;
        Min_V:= FAdoDataSet1.FieldByName('Min_V').AsFloat;
        Group_AGV:= FAdoDataSet1.FieldByName('AGV_V').AsFloat;
        Fangcha:= power(Group_AGV-AGV_V,2);
        Max_V:= FAdoDataSet1.FieldByName('Max_V').AsFloat;
        temp_w:=FAdoDataSet1.FieldByName('weight').AsFloat/FAdoDataSet1.FieldByName('cn').AsFloat;
        maxWeight:= temp_w;
        MaxWeightSupbh:=FAdoDataSet1.FieldByName('supportbh').AsInteger;
        weight:=temp_w;;
        Mintime:= FAdoDataSet1.FieldByName('Min_t').AsDateTime;
        Maxtime:= FAdoDataSet1.FieldByName('Max_t').AsDateTime;

       // dRecArry[PhaseNUmber].did:=PhaseNUmber;
        DRec.dRecordNumber:=FAdoDataSet1.RecordCount;
        DRec.dAGVSupportMovePress:= FAdoDataSet1.FieldByName('SupportBeforeMovePress').AsFloat;
        if Group_AGV>(AGV_V) then   begin
            DRec.dString:= FAdoDataSet1.FieldByName('supportbh').AsString+',';
        end else begin
            DRec.dString:= '';
        end;


        //-----
        FAdoDataSet1.Next ;
        while not FAdoDataSet1.Eof do begin
            temp_w:=FAdoDataSet1.FieldByName('weight').AsFloat
                   /FAdoDataSet1.FieldByName('cn').AsFloat;

           if Min_V > FAdoDataSet1.FieldByName('Min_V').AsFloat then
                Min_V:= FAdoDataSet1.FieldByName('Min_V').AsFloat;
           if Max_V< FAdoDataSet1.FieldByName('Max_V').AsFloat then
                Max_V:= FAdoDataSet1.FieldByName('Max_V').AsFloat;
           if maxWeight< temp_w then  begin
               maxWeight:=temp_w;
               MaxWeightSupbh:=FAdoDataSet1.FieldByName('supportbh').AsInteger;
           end;
           if Mintime > FAdoDataSet1.FieldByName('Min_t').AsDateTime then
                Mintime:= FAdoDataSet1.FieldByName('Min_t').AsDateTime;
           if Maxtime < FAdoDataSet1.FieldByName('Max_t').AsDateTime then
                Maxtime:= FAdoDataSet1.FieldByName('Max_t').AsDateTime;


           Group_AGV:= FAdoDataSet1.FieldByName('AGV_V').AsFloat;
           Fangcha:= Fangcha+power(Group_AGV-AGV_V,2);
           weight:=weight+temp_w;
           if Group_AGV>(AGV_V) then    // 可以增加yield系数
              DRec.dString:= DRec.dString
                          + FAdoDataSet1.FieldByName('supportbh').AsString+',';
           //
           DRec.dAGVSupportMovePress:=DRec.dAGVSupportMovePress+
                                    FAdoDataSet1.FieldByName('SupportBeforeMovePress').AsFloat;
           FAdoDataSet1.Next ;
        end;
     end;
        FAdoDataSet1.close;

         DRec.dMinData:= Min_V;
         DRec.dMaxData:= Max_V;
         DRec.dAGVData:= AGV_V;
         DRec.dAGvDataFangCha:=sqrt(Fangcha/DRec.dRecordNumber);
         DRec.dmaxWightSupbh:=Maxweightsupbh;
         DRec.dPressWeigth :=weight/DRec.dRecordNumber;
         DRec.MaxWeightValue :=maxWeight;
         DRec.dFootage:=FootStep;
         DRec.dFootageInterval:=FootageinterVal;
         DRec.dStartTime:=MinTime;
         DRec.dEndTime:=Maxtime;
         DRec.dAGVSupportMovePress:=DRec.dAGVSupportMovePress/DRec.dRecordNumber;

         Result:=true;
end;

function TThirdThread.ForcaseDayJinChi(FGzmid, typeValue: string;
  PhaseNumber: integer): Boolean;
var
  sql:string;
  Downstep,upperStep:double;
begin
    Result:=false;
    sql:='select Sum(downfootage) as down_Step, Sum(upperfootage) as upper_Step  ' +
                 ' from  D_' +Trim(FGzmid) +'_footage '+
                 ' where  footday >=''' +FormatDateTime('yyyy-mm-dd hh:nn:ss',dFourRec.EndPresstime-1) +
                 ''' and  footday <=''' +FormatDateTime('yyyy-mm-dd hh:nn:ss',dFourRec.EndPresstime) +
                 ''' and processage >0 ' ;
      FAdoDataSet2.Close ;
      FAdoDataSet2.CommandText:=sql;
      if  FAdoDataSet2.Open  then begin
         Downstep  := FAdoDataSet2.FieldByName('down_Step').AsFloat;
         upperStep := FAdoDataSet2.FieldByName('upper_Step').AsFloat;
      end;
      FAdoDataSet2.Close ;
      dFourRec.dayJinchi := Downstep+(UpperStep-Downstep)/RecArryNumber *(PhaseNumber-1);
      Result:=true;
end;

function TThirdThread.ForcaseOldPressure(FGzmid, typeValue: string;
  PhaseNumber: integer): Boolean;
var
  sql:string;
  ComPress_AGV,Steps_min,Steps_max:double;
  StartStep,EndStep,ComePressStep:double;
  CompFlag,Max_Data_id,Max_before_id:integer;
  BottomLine,Standardline,TopLine,Max_data,CompTemp:double;
  OldJudgeFlag:Boolean;
  CountComPress:integer;
begin
    Result:=false;
    Standardline:=300; //FinGzm.Old_Step[2]*3;
    BottomLine:=Standardline*(100-10)/100;  // 50
    TopLine:=Standardline*(100+10)/100;    //50
    //
    sql:='select max(ComePressLevel) as Max_C,AVG(ComePressLevel) as AGV_C,Count(id) as CN,min(end_steps) as Min_steps , ' +
       ' max(end_steps) as Max_steps  from   D_' +Trim(FGzmid) +'_forcase ' +
       '  where  process =0   and phaseNumber =' +  IntTostr(PhaseNumber) +' and typedata = '''+typeValue+ '''  ' ;
    FAdoDataSet1.Close;
    FAdoDataSet1.CommandText:=sql;
    if FAdoDataSet1.Open then begin
        if FAdoDataSet1.FieldByName('CN').AsInteger< 2 then  begin
          Result:=true;     FAdoDataSet1.Close ;     exit;  //退出计算
        end;

        ComPress_AGV:= FAdoDataSet1.FieldByName('AGV_C').AsFloat;
        Steps_min:= FAdoDataSet1.FieldByName('Min_steps').AsFloat;
        Steps_max:= FAdoDataSet1.FieldByName('Max_steps').AsFloat;
    end;
        // 查找已经计算过的平均值
    sql:='select AVG(ComePressLevel) as AGV_C,Count(id) as CN  from   D_' +Trim(FGzmid) +'_forcase ' +
           '  where  process >0    and phaseNumber =' +  IntTostr(PhaseNumber) +' and typedata = '''+typeValue+ '''  ' ;
    FAdoDataSet1.Close;
    FAdoDataSet1.CommandText:=sql;
    if FAdoDataSet1.Open then begin
        ComPress_AGV:= FAdoDataSet1.FieldByName('AGV_C').AsFloat;
        CountComPress:=FAdoDataSet1.FieldByName('CN').AsInteger;

        if (Steps_min > TopLine +FinGzm.Old_Step[2]*3 )  or
         ((Steps_min  < BottomLine) and (Steps_max < BottomLine))  then      OldJudgeFlag:=false
           else    OldJudgeFlag:=true;


        if (OldJudgeFlag) then   begin
            sql:='select * from   D_' +Trim(FGzmid) +'_forcase  where  end_steps>=  ' + FormatFloat('0.00',0) +
               ' and phaseNumber =' +  IntTostr(PhaseNumber) +' and typedata = '''+typeValue+
               ''' order by end_steps  ' ;
        end else begin
            sql:='select * from   D_' +Trim(FGzmid) +'_forcase  where  end_steps>=  ' + FormatFloat('0.00',Steps_min-FinGzm.Old_Step[2]*3) +
               ' and phaseNumber =' +  IntTostr(PhaseNumber) +' and typedata = '''+typeValue+
               ''' order by end_steps  ' ;
        end;
    end;

    FAdoDataSet1.Close;
    FAdoDataSet1.CommandText:=sql;

    if FAdoDataSet1.Open then  begin
          if FAdoDataSet1.RecordCount< 4 then  begin
            Result:=true;
            FAdoDataSet1.Close ;
            exit;;  //退出循环
          end;
          FAdoDataSet1.First ;
          StartStep:=FAdoDataSet1.FieldByName('start_steps').AsFloat;
          Max_data:=0; Max_Data_id:=0;Max_before_id:=0;
          while not FAdoDataSet1.Eof  do begin
            if FDisPose.FourthProcessStop then  break; //  循环退出机制 then
            EndStep:=FAdoDataSet1.FieldByName('end_steps').AsFloat;
            CompTemp:=FAdoDataSet1.FieldByName('ComePressLevel').AsFloat;
            // 把原来初次来压清除
            if (FAdoDataSet1.FieldByName('OldToPressure').AsInteger >1) and (OldJudgeFlag) then begin
                 Max_Data_id:=FAdoDataSet1.FieldByName('id').AsInteger;
                 Max_data:= FAdoDataSet1.FieldByName('AGVData').AsFloat;
                 ComePressStep:=EndStep;
                 self.UpdataForcaseData(FGzmid,Max_Data_id,0,0,0);
            end else if FAdoDataSet1.FieldByName('OldToPressure').AsInteger =1 then begin
                 StartStep:=FAdoDataSet1.FieldByName('end_steps').AsFloat;
            end;

            // 标记普通或者周期来压
            if (EndStep-Startstep > FinGzm.Old_Step[2] *0.8)  and (CompTemp >= ComPress_AGV)
               and (FAdoDataSet1.FieldByName('OldToPressure').AsInteger < 1) then  begin
               ComePressStep:=EndStep-Startstep;
               CompFlag:=1;
               self.UpdataForcaseData(FGzmid,FAdoDataSet1.FieldByName('id').AsInteger,CompFlag,ComePressStep,
                  MakeForCaseNextStep(FGzmid,typeValue,PhaseNumber,EndStep,ComePressStep));
               StartStep:=FAdoDataSet1.FieldByName('end_steps').AsFloat;
            end;
            //重新标注初次来压
            if (EndStep>=BottomLine )  and  (EndStep<=TopLine )   and (OldJudgeFlag)// and  (CompTemp >= ComPress_AGV)
                and (FAdoDataSet1.FieldByName('AGVData').AsFloat > Max_data)  then begin
                   Max_data:= FAdoDataSet1.FieldByName('AGVData').AsFloat;
                   Max_Data_id:=FAdoDataSet1.FieldByName('id').AsInteger;
                   ComePressStep:=EndStep;
            end;
            if (Max_Data_id >0) and (OldJudgeFlag)  then   begin
                if Max_before_id>0  then
                   self.UpdataForcaseData(FGzmid,Max_before_id,0,0,0);
                self.UpdataForcaseData(FGzmid,Max_Data_id,2,ComePressStep,0);
                Max_before_id:=Max_Data_id;
                Max_Data_id:=0;
                StartStep:=FAdoDataSet1.FieldByName('end_steps').AsFloat;
            end;
            // 更新 平均值
            ComPress_AGV:=(ComPress_AGV*CountComPress+FAdoDataSet1.FieldByName('ComePressLevel').AsInteger)/(CountComPress+1);
            CountComPress:=CountComPress+1;

            FAdoDataSet1.Next ;
          end;
    end;
    FAdoDataSet1.Close ;

     sql:='update D_' +Trim(FGzmid) +'_Forcase  set  process = 1' +
          ' where end_steps < ' +FormatFloat('0.00', EndStep)+ ' and process=0 ' +
          ' and phaseNumber =' +  IntTostr(PhaseNumber) +' and typedata = '''+typeValue+ '''  ' ;

     FAdoCommand.CommandText:=sql;
     FAdoCommand.Execute;

    Result:=true;

end;

function TThirdThread.ForcasePressIntensity(secondJudge, thirdJudge: double;
  OST: integer): Integer;
var
  PressIntenSity :integer;
  St,Et:double;
begin

  PressIntenSity:=0;
  if (dFourRec.eachsteps> dFourRec.AGVStep ) then  PressIntenSity:=PressIntenSity+1;
  if (dFourRec.CycleSecondJudge> dFourRec.AGVSecondJudge)then  PressIntenSity:=PressIntenSity+1;

    st:= dFourRec.thirdJ_AGV-(dFourRec.thirdJ_AGV-1)/3;
    et:= dFourRec.thirdJ_AGV+(dFourRec.thirdJ_Max-dFourRec.thirdJ_AGV)/3;
    if thirdJudge < st then   begin
       PressIntenSity:=PressIntenSity+1;
    end else if thirdJudge < et then  begin
       PressIntenSity:=PressIntenSity+2;
    end else begin
       PressIntenSity:=PressIntenSity+3;
    end;

   Result:= PressIntenSity;
end;

function TThirdThread.ReturnPressStartTime(secondJudge: double;OST:integer;DT:Tdatetime): Integer;
begin
   //判断返回值, 标注 来压显著阶段开始
    if (secondJudge > dFourRec.CycleSecondJudge) and (OST=0) then  begin
        Result:=1;   dFourRec.OutStandComePressStartTime:=DT;
    end else if (secondJudge < dFourRec.CycleSecondJudge) and (OST=1) then begin
        Result:=0;
    end else begin
        Result:=OST;
    end;
end;

function TThirdThread.ForCaseRockPress(FGzmid: string; var TotalCount: integer;
  var elapsedtime: string): Boolean;
var
  i,FootStep:integer;
  elapsedMilliseconds : cardinal;
  sql:string;
  UsedField:TSupportDataType;
begin
    // 支架 预测数据
    //=====
    Result:=true;
    FDisPose.SetFourthProcessStop(false);

 try
    totalnumber:=0;
    self.IntiArrayDrec;
      // 读取可用的字段数据类型
    if not FinGzm.FillDataType_SupportType(StrToint(FGzmbh)) then  exit;

    for i := 0 to FinGzm.IsUesedsupFieldcount-1 do  begin
        if FDisPose.FourthProcessStop then  break; //  循环退出机制
        UsedField:=TSupportDataType(GetEnumValue(TypeInfo(TSupportDataType),FinGzm.IsUesedsupFieldName[i]));
       if  (UsedField= FrontPressData) or  ( UsedField =BehindPressData ) or (UsedField =LeftPressData)
                   or (UsedField  =RightPressData ) then   begin
               //循环遍历 工作面划分的区域
               for FootStep := 1 to RecArryNumber do   begin
                    if FDisPose.FourthProcessStop then  break; //  循环退出机制
                     //分区段查找记录
                     ForcaseThirdTable(FGzmid,FinGzm.IsUesedsupFieldName[i],FootStep,0.8);
                     //分区段标记来压情况
                     ForcaseOldPressure(FGzmid,FinGzm.IsUesedsupFieldName[i],FootStep);
               end;
         end;
     end; //end for
 except
    Result:=false;
 end;
end;

function TThirdThread.ForCAseSelectCycleSecond(FGzmid, typeValue: string;
  PhaseNumber: integer; FootS, FootE:double): Boolean;
begin
     FAdoDataSet2.Close ;
     FAdoDataSet2.CommandText :=' select AVG(SecondJudge) as SCJ from  D_' +Trim(FGzmid) +'_ThirdDP '+
         ' where phaseNumber =' +  IntTostr(PhaseNumber) + '  and TypeData=''' + typeValue +'''' +
         ' and footage >=' +FormatFloat('0.00',FootS) + ' and   footage <='  +
         FormatFloat('0.00',FootE) ;
     if  FAdoDataSet2.Open  then
        dFourRec.CycleSecondJudge:= FAdoDataSet2.FieldByName('SCJ').AsFloat;

     FAdoDataSet2.Close ;
     FAdoDataSet2.CommandText :=' select max(ForcaseNumber) as FN from  D_' +Trim(FGzmid) +'_ForCase '+
         ' where phaseNumber =' +  IntTostr(PhaseNumber);
     if FAdoDataSet2.Open then
        dFourRec.ForcaseNumber:= FAdoDataSet2.FieldByName('FN').AsInteger+1;
     FAdoDataSet2.Close ;
end;

function TThirdThread.ForcaseSelectData(FGzmid, typeValue: string;
  PhaseNumber: integer; FootageInterval: double): Boolean;
var
   sql:string;
begin
    Result:=false;
    sql:='select AVG(SecondJudge) as SCJ  from  D_' +Trim(FGzmid) +'_ThirdDP '+
        ' where phaseNumber =' +  IntTostr(PhaseNumber) + '  and TypeData=''' + typeValue +'''' +
        ' and SecondJudge > 0  ';
    FAdoDataSet1.Close ;
    FAdoDataSet1.CommandText:=sql;
    if FAdoDataSet1.Open then
       dFourRec.AGVSecondJudge:= FAdoDataSet1.FieldByName('SCJ').AsFloat;
    FAdoDataSet1.Close ;

    sql:='select AVG(ThirdJudge) as AVG_T, Max(ThirdJudge) As MAX_T from  D_' +Trim(FGzmid) +'_ThirdDP '+
        ' where phaseNumber =' +  IntTostr(PhaseNumber) + '  and TypeData=''' + typeValue +'''' +
        ' and ThirdJudge > 0  ';
    FAdoDataSet1.Close ;
    FAdoDataSet1.CommandText:=sql;
    if FAdoDataSet1.Open then begin
        dFourRec.thirdJ_AGV:=FAdoDataSet1.FieldByName('AVG_T').AsFloat;
        dFourRec.thirdJ_Max:=FAdoDataSet1.FieldByName('MAX_T').AsFloat;
    end;
    FAdoDataSet1.Close ;
    Result:=true;
end;

function TThirdThread.ForcaseThirdTable(FGzmid, typeValue: string;
         PhaseNumber:integer;FootageInterval:double): Boolean;
var
  sql:string;
  AGV_Step_All,Max_step,Min_step:double;

  Start,OutStandComePressState:integer;
begin
    Result:=false;
    //   查找 第二次与第三次判断数据
    ForcaseSelectData(FGzmid, typeValue, PhaseNumber,FootageInterval);

    sql:='select *  from   D_' +Trim(FGzmid) +'_ThirdDP  where  process <2 and ' +
       ' forCase_info_ed <1  and  footage > 0 and phaseNumber =' +  IntTostr(PhaseNumber) +
       ' and typedata = '''+typeValue+''' order by footage  ' ;
    FAdoDataSet1.CommandText:=sql;
  if FAdoDataSet1.Open then  begin
        if FAdoDataSet1.RecordCount< 1 then  begin
          Result:=true;
          FAdoDataSet1.Close ;
          exit;;  //退出循环
        end;

        FAdoDataSet1.First;
        Start:=0;
        OutStandComePressState:=0;

       while not  FAdoDataSet1.Eof do begin
            if FDisPose.FourthProcessStop then  break; //  循环退出机制 then
            if start=0 then  begin       // 开始
               Start:=1;
               dFourRec.startfootage:=FAdoDataSet1.FieldByName('Footage').AsFloat;
               dFourRec.ComePressStarttime:=FAdoDataSet1.FieldByName('phase_startTime').AsDateTime;
               dFourRec.startSupid:=FAdoDataSet1.FieldByName('Startbh').AsInteger ;
               dFourRec.EndSupid:=FAdoDataSet1.FieldByName('endbh').AsInteger ;
            end;

            if  FAdoDataSet1.FieldByName('thirdjudge').AsInteger>0  then begin  //结束标记
               dFourRec.endfootage:=FAdoDataSet1.FieldByName('Footage').AsFloat;
               dFourRec.EndPresstime:=FAdoDataSet1.FieldByName('phase_EndTime').AsDateTime ;
               dFourRec.eachsteps:=dFourRec.endfootage- dFourRec.startfootage+FootageInterval;
               dFourRec.AGVStep:=FAdoDataSet1.FieldByName('UsedOLdStep').AsFloat;
               dFourRec.OutStandSupport:=FAdoDataSet1.FieldByName('SupString').AsString;
               dFourRec.AGVData:=FAdoDataSet1.FieldByName('AGVData').AsFloat;
               dFourRec.SupportBeforeMoveData:=FAdoDataSet1.FieldByName('AGVMovePress').AsFloat;
               dFourRec.generatetime :=now();
               Start:=0;
               //查找记录
               ForCAseSelectCycleSecond(FGzmid, typeValue,PhaseNumber, dFourRec.startfootage, dFourRec.endfootage);
               // 查找当天在该区域的进尺
               ForcaseDayJinChi(FGzmid,typeValue,PhaseNumber); //

               if  OutStandComePressState=0  then
                   dFourRec.OutStandComePressStartTime:=FAdoDataSet1.FieldByName('phase_startTime').AsDateTime;
               // 判断本次来压的强度
                dFourRec.ComePressLevel:=ForcasePressIntensity (FAdoDataSet1.FieldByName('SecondJudge').AsInteger,
                    FAdoDataSet1.FieldByName('ThirdJudge').AsInteger,OutStandComePressState );
               //  保存数据
               SaveFourthProcessData(FGzmid, typeValue,PhaseNumber);
               //把来压状态清空
               OutStandComePressState:=0;
            end;

            //判断显著来压时刻
            OutStandComePressState:=ReturnPressStartTime(FAdoDataSet1.FieldByName('SecondJudge').AsInteger,
              OutStandComePressState, FAdoDataSet1.FieldByName('phase_startTime').AsDateTime);

           FAdoDataSet1.Next ;
        end; //end while
  end;
   FAdoDataSet1.Close;
   Result:=True;

end;

procedure TThirdThread.initPFourRec(pd:dFourRec);
begin
  pd.generatetime :=-1;
  pd.Phasenumber :=0;
  pd.ForcaseNumber :=0;
  pd.eachsteps :=0;
  pd.startfootage :=0;
  pd.endfootage :=0;
  pd.startSupid :=0;
  pd.EndSupid :=0;
  pd.ComePressStarttime :=-1;
  pd.EndPresstime :=-1;
  pd.OutStandComePressStartTime :=-1;
  pd.OutStandSupport :='';
  pd.AGVStep :=0;
  pd.dayJinchi :=0;
  pd.ComePressLevel :=0;
  pd.AGVSecondJudge :=0;
  pd.CycleSecondJudge :=0;
  pd.thirdJ_AGV :=0;
  pd.AGVData :=0;
  pd.SupportBeforeMoveData :=0;
  pd.OldToPressure :=0;
  pd.OldToPressureStep :=0;

end;

function TThirdThread.InsertDatabase(FGzmid, typeValue: string;
  DRec: PRec_Three): Boolean;
var
  sql:string;
begin
   Result:=false;

   try
    FAdoCommand.MySqlConnection.BeginTrans ;
       //insert database
    sql:='insert into D_' +Trim(FGzmid) +'_ThirdDP  (footage,phaseNumber,startbh,endbh,' +
         'supNumber,Mindata,Maxdata,AGVdata,Fangcha,Maxweightsup,Pressweight,Firstjudge, '+
         'supString,typedata,RecordNumber,Phase_starttime,Phase_Endtime,maxweightValue,'+
         'forcasestep,forcasestep_st,forcasestep_et,Judgelevel,SecondJudge,thirdJudge,AGVMovePress,  '+
         'process,forCase_info_ed,UsedOldStep,EditOldStep ) values ( '+FormatFloat('0.00',DRec.dFootage )+' ,' +
         Inttostr(DRec.did )+' ,' + Inttostr(DRec.dSupStartBh )+' ,' +
         Inttostr(DRec.dSupEndBh )+' ,' +Inttostr(DRec.dSupNumber )+' ,' +
         Floattostr(DRec.dMinData )+' ,' + Floattostr(DRec.dMaxData )+' ,' +
         Floattostr(DRec.dAGvData )+' ,' + Floattostr(DRec.dAGvDataFangCha )+' ,' +
         intToStr(DRec.dmaxWightSupbh )+' ,' + Floattostr(DRec.dPressWeigth )+' ,' +
         intToStr(DRec.Firstjudge )+' ,''' +DRec.dString+''' ,''' +
         typeValue+''', '+intToStr(DRec.dRecordNumber)+ ',''' +
         FormatDateTime('yyyy-mm-dd hh:nn:ss',DRec.dStartTime)+''','''+
         FormatDateTime('yyyy-mm-dd hh:nn:ss',DRec.dEndTime)+''','+
         FloatToStr(DRec.MaxWeightValue)+','+ FloatToStr(DRec.ForeCase_step)+','''+
         FormatDateTime('yyyy-mm-dd hh:nn:ss',DRec.stepStartTime)+''','''+
         FormatDateTime('yyyy-mm-dd hh:nn:ss',DRec.dEndTime)+''','+
         Floattostr(DRec.judgeLeval  )+','+intToStr(DRec.secondJudge )+' ,' +
         intToStr(DRec.thirdjudge )+' ,' +  Floattostr(DRec.dAGVSupportMovePress )+','+
         IntToStr(ProcessTime)+',0,'+Floattostr(FinGzm.Old_Step[2])+',0)';
      FAdoCommand.CommandText:=sql;
      FAdoCommand.Execute ;
      //
       //更新处理记录
      sql:=    ' update  D_'+trim(FGzmid)+'_Seconddp  set process= 1' +
               ' where  Footage <= '   + FormatFloat('0.00',DRec.dFootage+DRec.dFootageInterval) +
               ' and supportbh >= ' + IntTostr(DRec.dSupStartBh) +
               ' and supportbh <= ' + IntToStr(DRec.dSupEndBh) +
               ' and TypeData= '''+typeValue+'''' ;
      FAdoCommand.CommandText:=sql;
      FAdoCommand.Execute ;
       //----
      totalnumber:=totalnumber+1;
      FAdoCommand.MySqlConnection.CommitTrans;
   finally
     Result:=true;
   end;
end;

procedure TThirdThread.insertOrUpdateData(Sql: string);
begin
      FAdoCommand.CommandText:=sql;
      FAdoCommand.Execute ;
end;

function TThirdThread.IntiArrayDrec: Boolean;
var
  SumSupportNumber:integer;
  MinSupBh,MaxSupbh,MidSupbh:integer;
  i,j:integer;

begin
      RecArryNumber:=FinGzm.RecArryNumber;
      for j := 1 to RecArryNumber do   begin
        dRecArry[j].dSupStartBh :=FinGzm.dRecArry[j][0] ;
        dRecArry[j].dSupEndBh  :=FinGzm.dRecArry[j][1];
        dRecArry[j].did :=j;
        dRecArry[j].dSupNumber :=dRecArry[j].dSupEndBh-dRecArry[j].dSupStartBh +1;
      end;
//
//          //init Minsupbh,maxsupbh
//          MinSupbh:=FinGzm.SupStartNumber ;
//          MaxSupbh:=FinGzm.SupEndUsedNumber;
//          SumSupportNumber:=Maxsupbh-MinSupbh+1;
//          MidSupbh:=trunc((Maxsupbh-Minsupbh+1)/2);
//         //划分支架区域
//          dRecArry[1].dSupStartBh :=MinSupbh;
//          dRecArry[1].dSupEndBh :=dRecArry[1].dSupStartBh+ Trunc(2*OldStep/FinGzm.Usedsupport.Zj_zhongxinju);
//
//          if RecArryNumber=5 then      begin
//               dRecArry[3].dSupStartBh :=MidSupbh-Round(2* OldStep/FinGzm.Usedsupport.Zj_zhongxinju);
//               dRecArry[3].dSupEndBh   :=MidSupbh+Round(2* OldStep/FinGzm.Usedsupport.Zj_zhongxinju);
//
//               dRecArry[2].dSupStartBh :=dRecArry[1].dSupEndBh+1;
//               dRecArry[2].dSupEndBh :=dRecArry[3].dSupStartBh-1;
//
//               dRecArry[5].dSupEndBh :=MaxSupbh;
//               dRecArry[5].dSupStartBh :=dRecArry[5].dSupEndBh-Trunc(2*OldStep/FinGzm.Usedsupport.Zj_zhongxinju);
//
//               dRecArry[4].dSupStartBh :=dRecArry[3].dSupEndBh+1;
//               dRecArry[4].dSupEndBh :=dRecArry[5].dSupStartBh-1;
//
//          end   else if RecArryNumber=7 then    begin
//
//               dRecArry[4].dSupStartBh :=MidSupbh-Round(2* OldStep/FinGzm.Usedsupport.Zj_zhongxinju);
//               dRecArry[4].dSupEndBh   :=MidSupbh+Round(2* OldStep/FinGzm.Usedsupport.Zj_zhongxinju);
//
//               dRecArry[2].dSupStartBh :=dRecArry[1].dSupEndBh+1;
//               dRecArry[2].dSupEndBh :=dRecArry[2].dSupStartBh++Round(2* OldStep/FinGzm.Usedsupport.Zj_zhongxinju);
//
//               dRecArry[7].dSupEndBh :=MaxSupbh;
//               dRecArry[7].dSupStartBh :=dRecArry[7].dSupEndBh-Trunc(OldStep/FinGzm.Usedsupport.Zj_zhongxinju);
//
//               dRecArry[6].dSupEndBh :=dRecArry[7].dSupStartBh-1;
//               dRecArry[6].dSupStartBh :=dRecArry[6].dSupEndBh-Round(2* OldStep/FinGzm.Usedsupport.Zj_zhongxinju);
//
//               dRecArry[3].dSupStartBh :=dRecArry[2].dSupEndBh+1;
//               dRecArry[3].dSupEndBh :=dRecArry[4].dSupStartBh-1;
//
//               dRecArry[5].dSupStartBh :=dRecArry[4].dSupEndBh+1;
//               dRecArry[5].dSupEndBh :=dRecArry[6].dSupStartBh-1;
//          end;
//
//
//          for j := 1 to RecArryNumber do  begin
//             dRecArry[j].did :=j;
//             dRecArry[j].dSupNumber :=dRecArry[j].dSupEndBh-dRecArry[j].dSupStartBh +1;
//          end;
end;


function TThirdThread.JudgeMAXFootageFalg(FGzmid, typeValue: string;
      PhaseNumber:integer;StartFootage,endFootage,FootageInterval:double): double;
var
  Sql:string ;
  tempfootage:double;
  inid:integer;
begin
    Result:=-1;
    Sql:=  'select id,AGVData,footage,SecondJudge,Forcasestep,AGVMovePress,ThirdJudge from D_' +Trim(FGzmid) +'_ThirdDP where Footage > ' +
              FormatFloat('0.00',StartFootage) + ' and Footage <='+  FormatFloat('0.00',endFootage) +
              ' and phaseNumber =' +IntTostr(PhaseNumber) + ' and TypeData= ''' +typeValue +
              ''' and secondjudge>0 order by AGVData desc ,AGVMovePress desc limit 5 ';
    FAdoDataSet2.Close ;
    FAdoDataSet2.CommandText:=sql;
    if FAdoDataSet2.Open  then
        while not FAdoDataSet2.eof do begin
           tempfootage:=FAdoDataSet2.FieldByName('footage').AsFloat;
           inid:= FAdoDataSet2.FieldByName('id').AsInteger;
           if (tempfootage-StartFootage) > FootageInterval*3 then  begin  // FinGzm.Old_Step[2]*0.4
             sql:=' update D_' +Trim(FGzmid) +'_ThirdDP  set ThirdJudge= 1 ' +
                 ' ,forcasestep= '+ FormatFloat('0.00',tempfootage-StartFootage+FootageInterval)+
                 ' where id =' +intToStr(inid);

             FAdoCommand.CommandText:=sql;
             FAdoCommand.Execute ;
             Result:=tempfootage;
             break;
           end;
           FAdoDataSet2.Next;
        end;
    FAdoDataSet2.Close ;
end;

function TThirdThread.MakeForCaseNextStep(FGzmid, typeValue: string;
  PhaseNumber: integer; NowFootage,FirstStep: double): Double;
var
  SecondStep,ThirdStep:double;
  K_1,K_2,K_3: double;
  sql:string;
begin
   SecondStep:=0;ThirdStep:=0;
    sql:='select OldToPressureStep  from   D_' +Trim(FGzmid) +'_forcase  where  end_steps <  ' + FormatFloat('0.00',NowFootage) +
   ' and phaseNumber =' +  IntTostr(PhaseNumber) +' and typedata = '''+typeValue+
   '''  and OldToPressure=1  order by end_steps desc   ' ;
    FAdoDataSet2.Close ;
    FAdoDataSet2.CommandText:=sql;
    if FAdoDataSet2.Open then  begin
        if FAdoDataSet2.RecordCount <1 then  begin
            K_1:=1;K_2:=0;K_3:=0;
        end else if FAdoDataSet2.RecordCount =1 then begin
            K_1:=0.6;K_2:=0.4;K_3:=0;
        end else begin
            K_1:=0.5;K_2:=0.3;K_3:=0.2;
        end;
        while not FAdoDataSet2.eof do begin
           if FAdoDataSet2.RecNo =1 then  SecondStep:=FAdoDataSet2.FieldByName('OldToPressureStep').AsFloat;
           if FAdoDataSet2.RecNo =2 then  ThirdStep:=FAdoDataSet2.FieldByName('OldToPressureStep').AsFloat;
           if FAdoDataSet2.RecNo =3 then  break;
           FAdoDataSet2.Next;
        end;
    end;
    FAdoDataSet2.Close ;
    Result:=K_1* FirstStep+K_2* SecondStep+K_3*ThirdStep;
end;

function TThirdThread.RebalanceDataBase(FGzmid,typeValue: string;
  var DRec: PRec_Three): boolean;
var
  sql,ReturnS:string;
  AGVD,AGVF,AGVW,AGVSJ,AGVMZL:double;
  PrevAgv,PrevFangcha,FirstJudge:double;
  PressState,previd,prevSecondJudge:integer;
  PrevStepFootage,PreVForeCaseStep:double;
  prevFootage,prevBeforeMovePress:double;
  PrevStepEndTime:Tdatetime;
  MaxData:double;
  //
  RetuenFootage:double;
  ThirdJudgeCount:integer;
  Jdl,OLS:double;
begin
    Result:=False;
    ReturnS:=FinGzm.Get_PStope_OldInfo;
    SelectJudgeLevel(FGzmid,typeValue,Drec.did,Jdl,OLS ) ;
    if Jdl=0 then Drec.judgeLeval:=Pub_judgeLeval;
    if OLS>0  then  FinGzm.Old_Step[2]:= OLS;
     sql:='select AVG(AGVData) as AGVData,AVG(FangCha) as AGVFangcha, AVG(Pressweight) as ' +
          ' AGVWeight ,AVG(Firstjudge) as FJ , AVG(secondJudge)as SF,AVG(AGVMovePress) as AVGMZL '+
          '  from D_' +  Trim(FGzmid) +'_ThirdDP where Footage >=' +
          FloatToStr(DRec.dFootage-FinGzm.Old_Step[2]*2) + ' and phaseNumber =' +IntTostr(DRec.did) +
          ' and TypeData= ''' +typeValue +'''';
     FAdoDataSet1.Close ;
     FAdoDataSet1.CommandText :=sql;
    if  FAdoDataSet1.Open then
        if  FAdoDataSet1.RecordCount>0  then  begin
            AGVD:= FAdoDataSet1.FieldByName('AGVData').Asfloat;
            AGVF:= FAdoDataSet1.FieldByName('AGVFangcha').Asfloat;
            AGVW:= FAdoDataSet1.FieldByName('AGVWeight').Asfloat;
            FirstJudge:=FAdoDataSet1.FieldByName('FJ').Asfloat;
            AGVSJ:=FAdoDataSet1.FieldByName('SF').Asfloat;
            AGVMZL:= FAdoDataSet1.FieldByName('AVGMZL').Asfloat;
         end;
     FAdoDataSet1.Close ;
     //
     sql:='select id,AGVData,FangCha,footage,SecondJudge,Forcasestep,AGVMovePress from D_' +Trim(FGzmid) +
           '_ThirdDP where Footage <' +   FormatFloat('0.00',DRec.dFootage) +  ' and TypeData= ''' +typeValue +'''' +
           ' and phaseNumber =' +IntTostr(DRec.did) +  ' and secondJudge >0 '+
           ' order by footage desc limit 1 ';
     FAdoDataSet1.Close ;
     FAdoDataSet1.CommandText :=sql;
     PrevAGV:=0; PrevFangcha:=0;prevSecondJudge:=0; prevBeforeMovePress:=0;
      if  FAdoDataSet1.Open then
        if  FAdoDataSet1.RecordCount>0  then  begin
            previd:=   FAdoDataSet1.FieldByName('id').AsInteger;
            PrevAGV:= FAdoDataSet1.FieldByName('AGVData').Asfloat;
            PrevFangcha:= FAdoDataSet1.FieldByName('Fangcha').Asfloat;
            prevSecondJudge:=FAdoDataSet1.FieldByName('SecondJudge').AsInteger;
            PreVForeCaseStep:=FAdoDataSet1.FieldByName('Forcasestep').AsFloat;
            prevFootage:= FAdoDataSet1.FieldByName('Footage').Asfloat;
            prevBeforeMovePress:=FAdoDataSet1.FieldByName('AGVMovePress').Asfloat;
         end;
     FAdoDataSet1.Close ;
     //判断周期来压状态
     PressState:=0;
     if (DRec.dAGvData>= AGVD)  then  PressState:=PressState+1;
     if (DRec.dAGvData>=PrevAGV)  then PressState:=PressState+1;
     if (DRec.dAGVSupportMovePress>DRec.dAGvData)  then PressState:=PressState+1;

     //权重判断
     if Drec.dPressWeigth > AGVW then  PressState:=PressState+1;
     if Drec.dPressWeigth/DRec.MaxWeightValue > (1-DRec.judgeLeval) then
         PressState:=PressState+1;
     //方差判断
     if (DRec.dAGvDataFangCha< AGVF) and (PressState>0 )  then
          Pressstate:= PressState+1;
     // 均值与老顶来压值
     if DRec.dAGvData >=FinGzm.Old_MPa[2]*(1-DRec.judgeLeval ) then
          Pressstate:= PressState+3;
     // 均值与直接顶来压值比较
     if Drec.dAGvData<=FinGzm.imm_MPa* (1+DRec.judgeLeval) then
          Pressstate:= PressState-1;

      DRec.firstjudge :=Pressstate;

      //第二次判断
         DRec.secondJudge:= 0;
        if DRec.firstjudge >= FirstJudge     // 当前判断值大于前两个周期的判断均值
            then   DRec.secondJudge:=1 ;

        if (DRec.dAGVSupportMovePress > AGVMZL*(1+DRec.judgeLeval))  //当前末阻力大于前两个周期的 平均末阻力
            then   DRec.secondJudge:=DRec.secondJudge+1;

        if DRec.dAGvData >= AGVD * (1+DRec.judgeLeval)  //当前均值大于前两个周期均值的判断倍数
            then   DRec.secondJudge:=DRec.secondJudge+1;

        if (DRec.dMaxData>=Fingzm.Usedsupport.EndOpenLoad *(1-DRec.judgeLeval)) and    // 最大值大于支架液压阀开启 的判断倍数
           (DRec.secondJudge>0)   then   DRec.secondJudge:=DRec.secondJudge+1;

        if (DRec.dAGvData>=Fingzm.Usedsupport.initLoad *(1+DRec.judgeLeval))   and    // 均值大于支架初撑力的倍数
           (DRec.secondJudge>0)  then  DRec.secondJudge:=DRec.secondJudge+2;

        if (DRec.dAGVSupportMovePress > Fingzm.Usedsupport.initLoad*(1+DRec.judgeLeval))  and  //末阻力大于支架初撑力的倍数
           (DRec.secondJudge>0)   then  DRec.secondJudge:=DRec.secondJudge+1;

                    //

      // 第三次判断  通过均值系列判断 表明曲线出现翻转  忠实标注数据曲线拐点

    ThirdJudgeCount:=0;
 if ((prevSecondJudge >0) and
     // 如果前一个周期的第二次判断 系数大于零 前一个周期的平均值大于当前平均  // 前一个周期的末阻力大于当前末阻力
       ((PrevAGV>=DRec.dAGvData) or (prevBeforeMovePress > DRec.dAGVSupportMovePress))
         ) then  begin   //把前面的一条记录变成拐点
         //继续判断   查找 当前数据库中 前一条判断 是来压步距的 记录
        sql:='select id,AGVData,footage,SecondJudge,Forcasestep,AGVMovePress,ThirdJudge from D_' +Trim(FGzmid) +'_ThirdDP where Footage <' +
              FormatFloat('0.00',DRec.dFootage) + ' and phaseNumber =' +IntTostr(DRec.did) +  ' and ThirdJudge >0 '+
              ' and TypeData= ''' +typeValue +''' order by footage desc limit 5 ';
         FAdoDataSet1.Close ;
         FAdoDataSet1.CommandText :=sql;
     if FAdoDataSet1.Open then begin
         FAdoDataSet1.First;
         if FAdoDataSet1.RecordCount>0  then   begin   // 与数据库中最后一条记录比较, 确定 来压情况
              if ( (PrevAGV > FAdoDataSet1.FieldByName('AGVData').Asfloat )
                   or (prevBeforeMovePress >FAdoDataSet1.FieldByName('AGVMovePress').Asfloat) )  then begin
                  if prevFootage- FAdoDataSet1.FieldByName('Footage').Asfloat >= DRec.dFootageInterval*3  then   begin    //FinGzm.Old_Step[2]*0.6
                     // 把前一条记录标记为来压记录
                     ThirdJudgeCount:=FAdoDataSet1.FieldByName('ThirdJudge').AsInteger +1;
                  end else  if (prevFootage-FAdoDataSet1.FieldByName('Footage').Asfloat +FAdoDataSet1.FieldByName('Forcasestep').Asfloat <=
                   FinGzm.Old_Step[2]*1.5 ) then begin
                     // 如果确实数据大,而且如果标注来压,会显示两个来压步距过小,这样把前一个来压步距标记清除
                     ThirdJudgeCount:=FAdoDataSet1.FieldByName('ThirdJudge').AsInteger;
                     sql:=' update D_' +Trim(FGzmid) +'_ThirdDP  set ThirdJudge= '+IntToStr( ThirdJudgeCount) +
                          ' ,forcasestep= '+ FormatFloat('0.00',prevFootage-FAdoDataSet1.FieldByName('Footage').Asfloat +
                              FAdoDataSet1.FieldByName('Forcasestep').Asfloat+DRec.dFootageInterval)+
                           ' where id =' +intToStr(previd);
                     FAdoCommand.CommandText:=sql;
                     FAdoCommand.Execute ;
                     sql:=' update D_' +Trim(FGzmid) +'_ThirdDP  set ThirdJudge= 0  where id =' +FAdoDataSet1.FieldByName('id').AsString;
                     FAdoCommand.CommandText:=sql;
                     FAdoCommand.Execute ;
                  end else begin
                     // 如果数据比较大,两者比较近,而且 合并大于1.5 倍的数据 // 添加一条记录
                     RetuenFootage:=JudgeMAXFootageFalg(FGzmid,typeValue,DRec.did,FAdoDataSet1.FieldByName('Footage').Asfloat
                             -FAdoDataSet1.FieldByName('Forcasestep').Asfloat+DRec.dFootageInterval,
                             FAdoDataSet1.FieldByName('Footage').Asfloat,DRec.dFootageInterval);
                     if RetuenFootage  <>FAdoDataSet1.FieldByName('Footage').Asfloat  then   begin
                           sql:=' update D_' +Trim(FGzmid) +'_ThirdDP  set ThirdJudge= 0  where id =' +FAdoDataSet1.FieldByName('id').AsString;
                           FAdoCommand.CommandText:=sql;
                           FAdoCommand.Execute ;
                           ThirdJudgeCount:=FAdoDataSet1.FieldByName('ThirdJudge').AsInteger;
                           sql:=' update D_' +Trim(FGzmid) +'_ThirdDP  set ThirdJudge= '+IntToStr( ThirdJudgeCount) +
                                ' ,forcasestep= '+ FormatFloat('0.00',prevFootage-RetuenFootage+DRec.dFootageInterval)+
                                ' where id =' +intToStr(previd);
                     end else begin
                           ThirdJudgeCount:=FAdoDataSet1.FieldByName('ThirdJudge').AsInteger;
                           sql:=' update D_' +Trim(FGzmid) +'_ThirdDP  set ThirdJudge= '+IntToStr( ThirdJudgeCount) +
                                    ' ,forcasestep= '+ FormatFloat('0.00',prevFootage-FAdoDataSet1.FieldByName('Footage').Asfloat +
                                    DRec.dFootageInterval)+ ' where id =' +intToStr(previd);
                     end;
                     // 合并 更新
                     FAdoCommand.CommandText:=sql;
                     FAdoCommand.Execute ;

                  end;
              end else if (prevFootage- FAdoDataSet1.FieldByName('Footage').Asfloat>FinGzm.Old_Step[2]*1.5) then begin
                    if   JudgeMAXFootageFalg(FGzmid,typeValue,DRec.did, FAdoDataSet1.FieldByName('Footage').Asfloat,
                            prevFootage,DRec.dFootageInterval)=-1 then     ThirdJudgeCount:=1;  //
              end;

         end else begin
              ThirdJudgeCount:=1;
         end;
        FAdoDataSet1.Next ;
        //通过 前面的四次来压情况,对当前的 来压记录进行标记
         while not FAdoDataSet1.eof  do  begin
           if ( ((PrevAGV > FAdoDataSet1.FieldByName('AGVData').Asfloat ) or (prevBeforeMovePress >FAdoDataSet1.FieldByName('AGVMovePress').Asfloat))
                and (ThirdJudgeCount <= FAdoDataSet1.FieldByName('ThirdJudge').AsInteger ) and (ThirdJudgeCount>0)  )  then  begin
                     ThirdJudgeCount:= FAdoDataSet1.FieldByName('ThirdJudge').AsInteger+1;
                end;
           FAdoDataSet1.Next ;
         end;
     end;
       FAdoDataSet1.Close ;
       // 统一更新记录
       if ThirdJudgeCount >0  then   begin
           sql:=' update D_' +Trim(FGzmid) +'_ThirdDP  set ThirdJudge= '+ IntToStr( ThirdJudgeCount)+
                ' where id =' +intToStr(previd);    // 这是判断放入第一条来压记录 标记
           FAdoCommand.CommandText:=sql;
           FAdoCommand.Execute ;
       end;
     //系统通过前面十个来压步距的均值来调整使用的来压步距
      self.EditOldStep(FGzmid,typeValue,DRec.did,DRec.dFootage);
   end;

       //本次 赋值为0
     DRec.thirdjudge :=0;
       //如果没有标记，不用计算
       if DRec.secondJudge >0 then begin
          // 计算如果本次是来压步距，需要计算的数值
            sql:='select Footage,phase_endTime from D_' +Trim(FGzmid) +'_ThirdDP where ThirdJudge > 0' +
                 ' and phaseNumber =' +IntTostr(DRec.did) + ' and TypeData= ''' +typeValue +'''' +
                 ' order by footage desc limit 1 ';
           FAdoDataSet1.Close ;
           FAdoDataSet1.CommandText :=sql;
           if (FAdoDataSet1.Open) and (FAdoDataSet1.RecordCount>0 ) then  begin    //如果前面有来压标记
              PrevStepFootage:= FAdoDataSet1.FieldByName('Footage').AsFloat;
              PrevStepEndTime:= FAdoDataSet1.FieldByName('phase_endTime').AsDateTime;
              FAdoDataSet1.Close ;
           end else begin  // 如果没有来压标记，取第一条记录
              sql:='select Footage from D_' +Trim(FGzmid) +'_ThirdDP   where  TypeData= ''' +typeValue +''''+
                   ' and phaseNumber =' +IntTostr(DRec.did) + ' order by footage  limit 1 ';
              FAdoDataSet1.Close ;
              FAdoDataSet1.CommandText :=sql;
              if FAdoDataSet1.Open then begin
                 DRec.DsystemMinfootage:=  FAdoDataSet1.FieldByName('Footage').Asfloat;
              end else begin
                 DRec.DsystemMinfootage:=0;
              end;
              FAdoDataSet1.Close ;
              if (DRec.dFootage-DRec.DsystemMinfootage+1 > finGzm.Old_Step[2]) and   // 把当前记录中最大的均值标记为来压
                    ( DRec.DsystemMinfootage >0 )then  begin
                sql:='select Max(AGVDATA) as mx from D_' +Trim(FGzmid) +'_ThirdDP  where  phaseNumber =' +
                      IntTostr(DRec.did)+' and TypeData= ''' +typeValue +'''';
                FAdoDataSet1.CommandText :=sql;
                if FAdoDataSet1.Open then begin
                    MaxData:= FAdoDataSet1.FieldByName('mx').Asfloat;
                end else begin
                    MaxData:=0;
                end;
                FAdoDataSet1.Close ;
                   //
                sql:='select id, phase_Endtime,footage from D_' +Trim(FGzmid) +'_ThirdDP  where  phaseNumber =' +IntTostr(DRec.did) +
                     ' and  AGVData >=' +floatToStr(MaxData) +' and TypeData= ''' +typeValue +'''';
                FAdoDataSet1.CommandText :=sql;
                if FAdoDataSet1.Open then begin
                    PrevStepEndTime:=FAdoDataSet1.FieldByName('phase_Endtime').AsDateTime;
                    PrevStepFootage:=FAdoDataSet1.FieldByName('footage').AsInteger;
                    sql:=' update D_' +Trim(FGzmid) +'_ThirdDP  set ThirdJudge=1,forcasestep=1 '+
                         ' where id=' +FAdoDataSet1.FieldByName('id').AsString;
                    FAdoCommand.CommandText:=sql;
                    FAdoCommand.Execute ;
                end;
                FAdoDataSet1.Close ;
              end else begin
                 PrevStepFootage:=0; PrevStepEndTime:=Drec.dEndTime;
              end;
           end;

           //
           if PrevStepFootage >0 then begin
              DRec.ForeCase_step:=Drec.dFootage-PrevStepFootage+DRec.dFootageInterval;
              // 如果在很长的时间内内有标记，把预测步距标记为-1 这种情况一般发生在 数据长时间无数的情况下
              if(DRec.ForeCase_step>FinGzm.Old_Step[2]*3) then DRec.ForeCase_step:=-1;

              DRec.stepStartTime:=PrevStepEndTime;

           end else begin
              DRec.ForeCase_step:=0;
              DRec.stepStartTime:=Drec.dEndTime;
           end;
    end else begin
           DRec.ForeCase_step:=0;
           DRec.stepStartTime:=0;
    end;
    Result:=true;
end;



procedure TThirdThread.RefreshThreadState;
begin
    uThirdProcessStop:=FDisPose.ThirdProcessStop;
end;

function TThirdThread.SaveFourthProcessData(FGzmid, typeValue: string;PhaseNumber:integer): Boolean;
var
 sql:string;
begin
   Result:=true;
   try
     FAdoCommand.MySqlConnection.BeginTrans ;
     sql:='insert into D_' +Trim(FGzmid) +'_Forcase  (phaseNumber,start_steps,end_steps,' +
           ' starttime,endtime,generatetime,each_steps,forcasenumber,dayfootage,process, '+
           ' OutStandStartTime,AgvStep,AGVSecondJudge,CycleSecondJudge,ComePressLevel,Startsupid,' +
           ' endsupid,OutStandSupport,typedata,AGVData,SupportBeforeMoveData,OldToPressure,OldToPressureStep ) '+
           ' values ( '+
           Inttostr(Phasenumber )+' ,' + FormatFloat('0.00',dFourRec.startfootage )+' ,' +
           FormatFloat('0.00',dFourRec.endfootage )+' ,''' + FormatDateTime('yyyy-mm-dd hh:nn:ss',dFourRec.ComePressStarttime)+
           ''','''+ FormatDateTime('yyyy-mm-dd hh:nn:ss',dFourRec.EndPresstime)+''','''+
           FormatDateTime('yyyy-mm-dd hh:nn:ss',dFourRec.generatetime)+''','+
           FormatFloat('0.00',dFourRec.eachsteps )+' ,' + Inttostr(dFourRec.ForcaseNumber )+ ',' +
           FormatFloat('0.00',dFourRec.dayJinchi) +',0,'''+FormatDateTime('yyyy-mm-dd hh:nn:ss',dFourRec.OutStandComePressStartTime)+
            ''','+ FloatToStr(dFourRec.AGVStep)+','+ FloatToStr(dFourRec.AGVSecondJudge)+','+
           FloatToStr(dFourRec.CycleSecondJudge)+','+intToStr(dFourRec.ComePressLevel)+','+
           IntToStr(dFourRec.startSupid)+','+ IntToStr(dFourRec.EndSupid)+','''+
           dFourRec.OutStandSupport +''','''+typeValue+''',' +
           FormatFloat('0.00',dFourRec.AGVdata) +',' + FormatFloat('0.00',dFourRec.SupportBeforeMoveData)+ ',' +
           IntToStr(dFourRec.OldToPressure)+',' + FormatFloat('0.00',dFourRec.OldToPressureStep) +
           ')';
     FAdoCommand.CommandText:=sql;
     FAdoCommand.Execute;
                 //
     sql:='update  D_' +Trim(FGzmid) +'_ThirdDP set   forCase_info_ed = 1 ,process=2'+
        ' where phaseNumber =' +  IntTostr(PhaseNumber) +  ' and footage <='+ FormatFloat('0.00',dFourRec.endfootage ) +
        ' and typedata = '''+typeValue+''' ' ;
     FAdoCommand.CommandText:=sql;
     FAdoCommand.Execute;
     FAdoCommand.MysqlConnection.CommitTrans;
   except
     Result:=false;
   end;
end;

function TThirdThread.SelectCountData(sql,Field1: string; var Value: double): Boolean;
begin
    Result:=False;
    FAdoDataSet1.Close ;
    FAdoDataSet1.CommandText :=sql;
    if FAdoDataSet1.Open then
      if  FAdoDataSet1.RecordCount>0  then  begin
          Value:= FAdoDataSet1.FieldByName(Field1).Asfloat;
          Result:=true;
       end;
     FAdoDataSet1.Close ;
end;

function TThirdThread.SelectEachPhase(FGzmid, typeValue: string; PhaseNumber:integer;FootageInterval: double): Boolean;
var
  sql:string;
  MaxWeightSupbh:integer;
  RetVaule,iFootStep:double;
  Max_V,Min_V,Agv_V,Fangcha,Group_AGV:double;
  maxWeight, Weight:double;
  DownMinFootage,DownMaxFootage,UpperMinFootage,UpperMaxFootage:double;
  MinFage,MaxFage:double;
  MaxTime,MinTime:TdateTime;
  temp_w:double;
  Gzm_Simple,Gzm_Difficult,Zk_str,SEorr:string;
  GetPStopeStr:String;
begin
       Result:=false;
       //init processtime
      // if not SelectProcessTime(FGzmid, typeValue,PhaseNUmber,ProcessTime)  then
       ProcessTime:=1;
       //判断该工作面支架是否都有数据
       if not selectPhaseComplete(FGzmid,typevalue,dRecArry[PhaseNUmber].dSupStartBh,
           dRecArry[PhaseNUmber].dSupEndBh) then  exit;
       //-----
       if not  SelectMinFootAge(FGzmid,typevalue,dRecArry[PhaseNUmber].dSupStartBh,
           dRecArry[PhaseNUmber].dSupEndBh,DownMinFootage,DownMaxFootage,
           UpperMinFootage,UpperMaxFootage)  then  exit;
       //-----
       //取进尺的最小值的最小值，最大值的最小值，保证所有支架都有数据
       if DownMinFootage>UpperMinFootage then  MinFage:= UpperMinFootage
                   else MinFage:=DownMinFootage;
       if DownMaxFootage>UpperMaxFootage then  MaxFage:=UpperMaxFootage
                   else Maxfage:=DownMaxFootage;
       // 如果最大进尺 不大于最小进尺， 退出
       if maxFage<MinFage+1 then  exit;
      //   把 小于最小值最大值的部分无效记录干掉
//       insertOrUpdateData('update  D_'+trim(FGzmid)+'_Seconddp  set process= 1 ' +
//             ' where Footage < ' +IntTostr(MinFage) +' and Footage >0 ' +
//             ' and TypeData= '''+typeValue+''' and  supportbh >= ' +intToStr(dRecArry[PhaseNUmber].dSupStartBh) +
//             ' and supportbh <= ' +intToStr(dRecArry[PhaseNUmber].dSupEndBh)
//             );
     iFootStep:=MinFage;
     while iFootStep <= MaxFage do begin

         if FDisPose.ThirdProcessStop   then  break;
         //更新步距
         FinGzm.RefreshFootage(iFootStep);
         FinGzm.GetGzmZkStr(Gzm_Simple,Gzm_Difficult,Zk_str);
         FinGzm.MyP_stope.InitModel(Gzm_Simple,Zk_str,SEorr);
         GetPStopeStr:=FinGzm.Get_PStope_OldInfo ;
         // insert processlog
         if (FDisPose.writeProcessflag) and (totalnumber mod 10 =1) then  begin
              sql:=' insert into processlog (generatetime,DataNumber,gzmname,supportbh, threadid,Processtype) values (''' +
                    FormatDaTeTime('yyyy-mm-dd hh:nn:ss',now())+''','+IntToStr(totalnumber)+',''' +
                    Trim(FGzmid)+''','+ IntToStr(PhaseNUmber) +','+IntToStr(self.Handle)+',''ThirdProcess'')' ;
              FAdoCommand.CommandText:=sql;
              FAdoCommand.Execute;
         end;
          dRecArry[PhaseNUmber].did:=PhaseNUmber;
          //填充数据
         if  FillDRec(FGzmid, typeValue, dRecArry[PhaseNUmber], iFootStep,FootageInterval) then begin
           //数据平衡
             RebalanceDataBase(FGzmid,typeValue,dRecArry[PhaseNUmber]) ;
                 //写入数据库
             InsertDatabase(FGzmid,typeValue,dRecArry[PhaseNUmber]);
         end;
        iFootStep:=iFootStep+ FootageInterval;
      end; //end while
     Result:=true;
end;

function TThirdThread.SelectJudgeLevel(FGzmid, typeValue: string;
  PhaseNumber: integer; var JudgeLevel,UsedOldstep:double): Boolean;
var
 Sql:string;

begin
    Result:=False;
    Sql:='select Judgelevel,UsedOldStep  from D_'+trim(FGzmid)+'_thirddp' +
         ' where phasenumber='+IntTostr(PhaseNumber)+' and TypeData= '''+typeValue+'''' +
         ' order by  footage desc limit 1 ';

    FAdoDataSet1.Close ;
    FAdoDataSet1.CommandText :=sql;
    JudgeLevel:=0;UsedOldstep:=0;
    if FAdoDataSet1.Open then
      if  FAdoDataSet1.RecordCount>0  then  begin
           JudgeLevel:= FAdoDataSet1.FieldByName('JudgeLevel').Asfloat;
           UsedOldstep := FAdoDataSet1.FieldByName('UsedOldStep').Asfloat;
          Result:=true;
      end;
     FAdoDataSet1.Close ;
end;

function TThirdThread.selectMaxFootAge(FGzmid: string): double;
 var
   sql:string;
begin

end;

//end procedure

function TThirdThread.SelectMinFootAge(dGzmid:string;typeValue:string;Minsupid,Maxsupid:integer;
                               Var Minsupid_Minfootage,Minsupid_Maxfootage,MaxSupid_MinFootage,
                               MaxSupid_MaxFootage: double ):Boolean;
var
  Sql:string;
  FG:double;
  Minbh,Maxbh:integer;
begin
   Result:=False;
   //ProcessTime
   Minsupid_MinFootAge:=0; Minsupid_MaxFootAge:=0;
   Maxsupid_MinFootAge:=0; Maxsupid_MaxFootAge:=0;
   //Min ***
   for Minbh := MinSupid to Maxsupid do  begin
       sql:='select Min(Footage) as MinFootage, max(footage) as MaxFootage from D_'+trim(dGzmid)+'_Seconddp' +
           ' where process=0  and  Footage >0 and TypeData= '''+
            typeValue+''' and supportbh='+ IntToStr(Minbh);
        FAdoDataSet1.Close ;
        FAdoDataSet1.CommandText :=sql;
        if FAdoDataSet1.Open then
          if  FAdoDataSet1.RecordCount>0  then  begin
            FG:= FAdoDataSet1.FieldByName('MinFootage').Asfloat;
            Minsupid_MinFootAge:=trunc(FG);
            FG:=  FAdoDataSet1.FieldByName('MaxFootage').Asfloat;
            Minsupid_MaxFootage:=trunc(FG);

           end;
         FAdoDataSet1.Close ;
         if (Minsupid_MinFootAge >1) and  (Minsupid_MaxFootAge >1 )  and
            (Minsupid_MaxFootAge -Minsupid_MinFootAge >=1) then  break;

   end;
       if (Minsupid_MinFootAge <1 ) or  (Minsupid_MaxFootAge <1 )  or
            (Minsupid_MaxFootAge -Minsupid_MinFootAge <1) then exit;

   /// Max***
    Maxbh:= Maxsupid;
    while Maxbh >=Minsupid  do  begin
       sql:='select Min(Footage) as MinFootage, max(footage) as MaxFootage from D_'+trim(dGzmid)+'_Seconddp' +
           ' where process=0 and Footage >0 and TypeData= '''+typeValue+''' and supportbh='+ IntToStr(Maxbh);
        FAdoDataSet1.Close ;
        FAdoDataSet1.CommandText :=sql;
        if FAdoDataSet1.Open then
          if  FAdoDataSet1.RecordCount>0  then  begin
            FG:= FAdoDataSet1.FieldByName('MinFootage').Asfloat;
            Maxsupid_MinFootAge:=trunc(FG);
            FG:=  FAdoDataSet1.FieldByName('MaxFootage').Asfloat;
            Maxsupid_MaxFootage:=trunc(FG);

           end;
         FAdoDataSet1.Close ;
         if (Maxsupid_MinFootAge >1) and  (Maxsupid_MaxFootAge >1 )  and
            (Maxsupid_MaxFootAge -Maxsupid_MinFootAge >=1) then  break;
        Maxbh:=maxbh-1;
   end;
       if (Maxsupid_MinFootAge <1 ) or  (Maxsupid_MaxFootAge <1 )  or
            (Maxsupid_MaxFootAge -Maxsupid_MinFootAge <1) or
            (Maxbh<Minbh )    then exit;

    Result:=true;
end;



function TThirdThread.selectPhaseComplete(dGzmid,typeValue:string;
      PhaseStartSupNo,PhaseEndSupNo: integer): Boolean;
var
  sql:string;
begin
   Result:=False;
   if PhaseStartSupNo<FinGzm.SupStartNumber then  exit;
   if PhaseEndSupNo>FinGzm.SupEndUsedNumber then  exit;

       sql:='select count(id) as NoCunt from D_'+trim(dGzmid)+'_Seconddp' +
           ' where process=0  and  Footage >0 and TypeData= '''+
            typeValue+''' and supportbh >='+ IntToStr(PhaseEndSupNo);
        FAdoDataSet1.Close ;
        FAdoDataSet1.CommandText :=sql;
       if  FAdoDataSet1.Open then
          if FAdoDataSet1.FieldByName('NoCunt').AsInteger >0 then  begin
              Result:=true;
          end else if PhaseEndSupNo=FinGzm.SupEndUsedNumber then  begin
              FAdoDataSet1.Close ;
              sql:='select count(id) as NoCunt from D_'+trim(dGzmid)+'_Seconddp' +
                   ' where process=0  and  Footage >0 and TypeData= '''+
                    typeValue+''' and supportbh <'+ IntToStr(PhaseEndSupNo) +' and supportbh >=' +
                    IntToStr(PhaseStartSupNo) ;
                FAdoDataSet1.CommandText :=sql;
               if  FAdoDataSet1.Open then
                 if FAdoDataSet1.FieldByName('NoCunt').AsInteger >100 then    Result:=true;
          end;
       FAdoDataSet1.Close ;
end;

function TThirdThread.SelectProcessTime(FGzmid, typeValue: string;
  PhaseNumber: integer; var ProcessNumber: integer): Boolean;
var
 Sql:string;

begin
    Result:=False;
    Sql:='select Max(Process) as Procestimes  from D_'+trim(FGzmid)+'_thirddp' +
         ' where phasenumber='+IntTostr(PhaseNumber)+' and TypeData= '''+typeValue+'''';

    FAdoDataSet1.Close ;
    FAdoDataSet1.CommandText :=sql;
    if FAdoDataSet1.Open then
        if  FAdoDataSet1.RecordCount>0  then  begin
            ProcessNumber:= FAdoDataSet1.FieldByName('Procestimes').Asinteger;
            if ProcessNumber=0 then  ProcessNumber:=1;
            Result:=true;
         end;
     FAdoDataSet1.Close ;
end;

function TThirdThread.ThirdDisPosePressDate(FGzmid: string; var TotalCount: integer;
                  var elapsedtime:string): Boolean;   //数据核心处理程序
var
  FootStep,Field_i:integer;
  sql:string;
  UsedField:TSupportDataType;
begin
     //=====
    Result:=true;
try
    totalnumber:=0;
    self.IntiArrayDrec;  //初始化分区数组
      // 读取可用的字段数据类型
    if not FinGzm.FillDataType_SupportType(StrToint(FGzmbh)) then  exit;

    for Field_i := 0 to FinGzm.IsUesedsupFieldcount-1 do  begin

         if FDisPose.ThirdProcessStop then  break; //  循环退出机制
         UsedField:=TSupportDataType(GetEnumValue(TypeInfo(TSupportDataType),FinGzm.IsUesedsupFieldName[Field_i]));
         if  (UsedField= FrontPressData) or  ( UsedField =BehindPressData ) or (UsedField =LeftPressData)
                   or (UsedField  =RightPressData ) then   begin
               //循环遍历 工作面划分的区域
               for FootStep := 1 to RecArryNumber do   begin

                    if FDisPose.ThirdProcessStop then  break; //  循环退出机制
                    //填充数据
                    SelectEachPhase(FGzmid,FinGzm.IsUesedsupFieldName[Field_i],FootStep,0.8) ;
               end;
         end;
//           if  (UsedField= FrontDisp) or  ( UsedField =BehindDisp ) or (UsedField =LeftDisp)
//                     or (UsedField  =RightDisp) then
//                 DisPoseDispData(FGzmbh, FinGzm.IsUesedsupFieldName[i]);
//           if  (UsedField= FirstDrillPress) or  ( UsedField =SecondDrillPress ) or (UsedField =ThirdDrillPress)
//                     or (UsedField  =FourthDrillPress )then
//                DisPoseDrillPress(FGzmbh, FinGzm.IsUesedsupFieldName[i]);
      end;


 except
    Result:=false;
 end;


end;

function TThirdThread.UpdataForcaseData(FGzmid: string; id, ComeFlag: integer;
  ComeStep,ForaseNextStep: double): Boolean;
var
 sql:string;
begin
    Result:=true;
   try
     sql:='update D_' +Trim(FGzmid) +'_Forcase  set  OldToPressure = ' + IntToStr(ComeFlag) +  ',' +
          ' OldToPressureStep = '+ FormatFloat('0.00',ComeStep) +  ',' +
          ' ForCaseNextStep= '+ FormatFloat('0.00',ForaseNextStep) +
          ' where  id= ' +IntToStr(id);

     FAdoCommand.CommandText:=sql;
     FAdoCommand.Execute;
   except
     Result:=false;
   end;
end;

end. // end unit
