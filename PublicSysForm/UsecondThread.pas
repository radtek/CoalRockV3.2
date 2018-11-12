unit UsecondThread;

interface
uses
    Classes,uDisPoseData, GzmClass,MySQLDataSet,SysUtils,uDataModule,Windows,System.TypInfo,Vcl.Dialogs,
     Winapi.ActiveX  ;

type
  TFinishedEvent = procedure (TotalNumber,Supbh:integer;eTime:String;SuC:Boolean) of object;
  // record
  PFDD = ^TFirstdisdoseData;
  TFirstdisdoseData =packed record
     isRecord :Boolean;   //  是否有数据
     dTimeD:Tdatetime;   //   数据产生时间
     dMaxValuetime:TdateTime;  //  最大数据产生时间
     dMinValuetime:TdateTime;   //  最小数据产生时间
     dMaxValue:double;      //  数据最大值
     dMinValue:double;     //   数据最小值
     dAvgValue:double;     //   数据平均值
     dLastValue:double;     //  最后一条记录
     dLastValueTime:Tdatetime;// 最后一条记录的时间
     dFirstValue:double;      //第一条记录
     dFirstValueTime:tdatetime;//第一条记录的时间
     dFrequency:integer;    //  数据重复次数
     dPointNumber:double;   //  数据总点数
     dDiffPercent:double;    // 数据差异率
     dMovesuppport:integer;  // 是否移架标记
     dInterVal:integer;    //    数据时间间隔
     dTotalGradient:double; // 数据总梯度
     dFirstGradient:double; // 数据第一次梯度 也就是注液完成时的回转梯度
     dLastGradient:double;  // 数据最后一次梯度 也是液压支架受其他支架影响的梯度
     dSupportState:integer; //液压支架的状态
     dSupportStartPress:double;//  支架初撑力
     dSupportBeforeMovePress:double; // 支架末阻力
     dValueType:string;

  end;

  TSecondThread=class(TThread)
   private
      TotalNumber:Integer;
      FGzmbh:String;
      FSupbh:integer;
      succeed:Boolean;
      EspTime:String;
      FDataTimeintVal:double;
      OnFinished:TFinishedEvent;
      FDisPose:TDisposeData;
      FinGzm:TGzm;
      
      //
      dFdd:PFDD;
      dCircleRec:PFDD;
      dFddList:TList;
      FAdoDataSet:TMyDataSet;
      FAdoDataSet2:TMyDataSet;
      FAdoCommand:TMyCommand;
      FADOConn:TMySqlConnection;
       //second process
      StepPressTopPercent:integer;
      StepPressBottomPercent :integer;
      DataBaseType:String;

      procedure ReturnFinished;
   protected

     procedure Execute ;override;

     function SelectToprecord(dGzmbh:string;supportBh:integer;typeValue:string;
                             var Gentime:Tdatetime;Var CurrentId:integer):Boolean;
     function SelectNextRecord(dGzmbh:string;supportBh:integer;typeValue:string;
                             CurrentTime:Tdatetime; var Gentime:Tdatetime;Var CurrentId:integer):Boolean;

     function SelectAVGrecord(dGzmbh:string;supportBh:integer;typeValue:string;
                             Gentime:Tdatetime;CycleTime:integer;Var AVGValue:double):Boolean;
     function secondSelectData(dGzmbh:string;supportBh:integer;typeValue:string;
                             tGeneratetime:TdateTime;FirstOrSencod:integer):boolean;
     function SelectMoveStatePress(dtable_n,typeValue:string;SupportBh:integer;Firsttime,LastTime:TdateTime;
                             Var EndPress,StartPress:double):boolean;
     function SecondDataDisposeProcess(Gzmbh,typeData:string;supbh:integer;
                                      one_hours_V,two_hours_V,four_hours_V,eight_hours_V,
                                      sixteen_hours_V,one_days_V:double;
                                       Var LastTime:Tdatetime):Boolean; //数据处理核心程序
     function InsertSecondDP(FGbh,T_d:string;  //gzmbh,typedate
                             S_N,R_P,D_P,M_P,T_P,   //supportbh,raisepointnumber,droppointnumber,morethantoppoint
                             E_P,C_T,M_S_N,T_C:integer; //effectivePoint,changetimes,MoveSupportNumber,Timecycle
                             st,et,maxD,minD :Tdatetime; //starttime,endtime,max_time,Min_time
                             s_v,E_v,Max_v,Min_v,  // startvalue,endvalue,Max_value,MIn_value,
                             O_D_V,A_C_V,T_L,B_L:double; //Agv_one_days_v,AGv_Cycle_value,topline,bottomLine
                             O_h_v,T_h_v,F_h_V,E_h_V,S_h_V:double; //one_hours_V,two_hours_v,four_hours_v,eight_hours_V,Sixteen_hours_v
                             MZl,CCL:double ):boolean;
    function SecondDisPoseDate(FGzmid:string;uSupBh:integer;TypeValue:string):Boolean;  //数据处理管理程序
    //处理压力数据
    function DisPosePressData(FGzmid: string;  typeValue: string): Boolean;
    //处理位移数据
    function DisPoseDispData(FGzmid: string;   typeValue: string): Boolean;
    //处理钻孔应立即数据
    function DisPoseDrillPress(FGzmid: string; typeValue: string): Boolean;

    procedure InsertSql(Sql:string);
    procedure InidCircleRec(dp:PFDD); // 初始化结构体
    procedure CheckCircleRecord(FixDp,NowDp:PFDD);//计算存储


   public
      destructor Destroy;override;
      constructor  Create(uObjusers:TDisposeData;BaseType:widestring);
      property   FinishedEvent: TFinishedEvent read OnFinished write OnFinished;
  end;


implementation

{ TManageThread }

procedure TSecondThread.CheckCircleRecord(FixDp, NowDp: PFDD);
begin
     if not NowDP.isRecord  then exit;
     if NowDp.dDiffPercent >FDisPose.SupprortPercentPress then  begin
         if NowDp.dMaxValue> FixDp.dMaxValue  then   begin
            FixDp.dMaxValuetime:=NowDp.dMaxValuetime;
            FixDp.dMaxValue:=NowDp.dMaxValue;
         end;

         if NowDp.dMinValue < FixDp.dMinValue  then   begin
            FixDp.dMinValuetime:=NowDp.dMinValuetime;
            FixDp.dMinValue:=NowDp.dMinValue;
         end;
     end;


end;

constructor TSecondThread.Create(uObjusers: TDisposeData;BaseType: widestring);
var
   v1,v2,v3,v4:integer;
begin
    Inherited  Create(true);
    CoInitialize(Nil);
    FreeOnTerminate:=True;

     FDisPose:=uObjusers;
     DataBaseType:= BaseType;     //
     FAdoconn:=TMySqlConnection.Create(nil);
     FAdoconn.Open(uObjusers.FinDataModule.EXDataIP,uObjusers.FinDataModule.Port,uObjusers.FinDataModule.ExUser,
                    uObjusers.FinDataModule.EXPassword,uObjusers.FinDataModule.DataBaseName);
     FAdoDataSet:=TMyDataSet.Create(nil) ;
     FAdoDataSet2:=TMyDataSet.Create(nil) ;
     FAdoCommand:=TMyCommand.Create(nil);
     FAdoDataSet.MySqlConnection:=FAdoconn;
     FAdoDataSet2.MySqlConnection:=FAdoconn;
     FAdoCommand.MySqlConnection:=FAdoconn;
     FinGzm:=TGzm.Create(FAdoconn) ;
     //init Tlist
     dFddList:=Tlist.Create;
     //second Process
     StepPressTopPercent:=10;
     StepPressBottomPercent:=50;
     //init dPriorRec
     new(dCircleRec);
     //

//     FDisPose.ReadiniSV(v1,v2,v3,v4);
//     if(V1=0) and (V2=0) and (v3=0) and (v4=0) then     FinGzm.setSupportType(1,0,0,0)
//        else  FinGzm.setSupportType(V1,v2,v3,v4) ;

     FDataTimeintVal:=FinGzm.GetDateintervalTime*MinutesD;


end;

destructor TSecondThread.Destroy;
var
 i:integer;
begin

     FreeAndNil(FAdoDataSet);
     FreeAndNil(FAdoDataSet2);
     FreeAndNil(FAdoCommand);
     FreeAndNil(FinGzm);
     FreeAndNil(FAdoconn);
     for I := 0 to dFddList.Count - 1 do
         if Assigned(dFddList[i]) then  Dispose(PFDD(dFddList[i]));
     dFddList.free;

     DisPose(dCircleRec); //清除dPriorRec
     //
     //if Assigned(dFDD) then Dispose(dFDD);
      CoUninitialize;
     inherited Destroy;
end;

function TSecondThread.DisPoseDrillPress(FGzmid: string;   typeValue: string): Boolean;
begin

end;

function TSecondThread.DisPoseDispData(FGzmid: string;  typeValue: string): Boolean;
begin

end;

function TSecondThread.DisPosePressData(FGzmid: string;   typeValue: string): Boolean;
var
  i:integer;
begin
     for i :=FinGzm.SupStartNumber to FinGzm.SupEndUsedNumber do  begin
         if FDisPose.SecondProcessStop  then  break;
         FSupbh:=i;
         SecondDisPoseDate(FGzmbh,FSupbh,typeValue);
     end; // end for i
    if (FDisPose.writeProcessflag) then
      insertSql(' insert into processlog (generatetime,gzmname, threadid,Processtype) values (''' +
              FormatDaTeTime('yyyy-mm-dd hh:nn:ss',now())+''',''' +
              Trim(FGzmid)+''','+IntToStr(self.Handle)+',''SPStop'')' );

end;

procedure TSecondThread.Execute;
 var
   t,Field_i:integer;
   ListGzm:TStringList;
   UsedField:TSupportDataType;
   V1,V2,V3,V4:Integer;
begin
  inherited;
   ListGzm:= TStringList.Create ;
   FAdoDataSet.Close ;
   FAdoDataSet.CommandText:='select cqid from cqcsb where qyzt=1';
   if FAdoDataSet.Open then
       while not FAdoDataSet.Eof  do  begin
          ListGzm.Add(Trim(IntToStr(FAdoDataSet.FieldByName('cqid').AsInteger)));
          FAdoDataSet.Next ;
       end;
    FAdoDataSet.Close ;
   //
  try
    for t := 0 to ListGzm.Count - 1 do begin
        if FDisPose.SecondProcessStop  then  break;
        FGzmbh:=ListGzm[t];
        //FDisPose.setGzmbm(FGzmbh);
        // 读取 FinGzm的数据
        //FinGzm.setGzmNumber(StrToint(FGzmbh)) ;
        if not FinGzm.InputGzmData(StrToint(FGzmbh)) then   continue;
        // 读取可用的字段数据类型
        if not FinGzm.FillDataType_SupportType(StrToint(FGzmbh)) then  break;

        for Field_i := 0 to FinGzm.IsUesedsupFieldcount-1 do  begin
           UsedField:=TSupportDataType(GetEnumValue(TypeInfo(TSupportDataType),FinGzm.IsUesedsupFieldName[Field_i]));
           if  (UsedField= FrontPressData) or  ( UsedField =BehindPressData ) or (UsedField =LeftPressData)
                     or (UsedField  =RightPressData ) then
                 DisPosePressData(FGzmbh, FinGzm.IsUesedsupFieldName[Field_i]);
           if  (UsedField= FrontDisp) or  ( UsedField =BehindDisp ) or (UsedField =LeftDisp)
                     or (UsedField  =RightDisp) then
                 DisPoseDispData(FGzmbh, FinGzm.IsUesedsupFieldName[Field_i]);
//           if  (UsedField= FirstDrillPress) or  ( UsedField =SecondDrillPress ) or (UsedField =ThirdDrillPress)
//                     or (UsedField  =FourthDrillPress )then
//                DisPoseDrillPress(FGzmbh, FinGzm.IsUesedsupFieldName[Field_i]);
        end;

    end; //end t

  finally
    FreeAndNil(ListGzm) ;
  end;

end;


procedure TSecondThread.InidCircleRec(dp: PFDD);
begin
  dp.isRecord :=false;
  dp.dTimeD :=-1;
  dp.dMaxValuetime :=-1;
  dp.dMinValuetime :=-1;
  dp.dMaxValue :=0;
  dp.dMinValue :=1000;
  dp.dAvgValue:=0;
  dp.dLastValue:=0;
  dp.dFrequency:=0;
  dp.dPointNumber:=0;
  dp.dDiffPercent :=0;
  dp.dMovesuppport :=0;
  dp.dInterVal :=0;
  dp.dTotalGradient :=0;
  dp.dFirstGradient :=0;
  dp.dLastGradient :=0;

end;

function TSecondThread.InsertSecondDP(FGbh, T_d: string; S_N, R_P, D_P, M_P,
  T_P, E_P, C_T, M_S_N, T_C: integer; st, et, maxD, minD: Tdatetime; s_v, E_v,
  Max_v, Min_v,O_D_V,A_C_V, T_L, B_L: double;
  O_h_v,T_h_v,F_h_V,E_h_V,S_h_V:double; //one_hours_V,two_hours_v,four_hours_v,eight_hours_V,Sixteen_hours_v
  MZl,CCL:double  ): boolean;
var
  sql:string;
  workingstate:integer;
  ComePressFlag:integer;
  cycle_length,Max_length,Min_length:double;
begin
  
{  参数说明
   FGbh,T_d:string;  //gzmbh,typedate
  S_N,R_P,D_P,M_P,T_P,   //supportbh,raisepointnumber,droppointnumber,morethantoppoint,totalPointNumber
   E_P,C_T,M_S_N,T_C:integer; //effectivePoint,changetimes,MoveSupportNumber,Timecycle
   st,et,maxD,minD :Tdatetime; //starttime,endtime,max_time,Min_time
   s_v,E_v,Max_v,Min_v,  // startvalue,endvalue,Max_value,MIn_value,
   O_D_V,A_C_V,T_L,B_L:double; //Agv_one_days_v,AGv_Day_value,topline,bottomLine
   E_h_v,S_h_v,T_D_V,S_D_V,F_D_V,O_M_V:double //eight_hours_V,Sixteen_hours_v,Agv_three_days_v
                      //Agv_seven_days_v, Agv_fifteen_days_v ,Agv_one_months_v
   MZl,CCL //supportbeforemovepress,supportstartpress
}
   cycle_length:= (et-st) /MinutesD ;
   Max_length:= (MaxD-st)/MinutesD;
   Min_length:=(MinD-st)/MinutesD;
   // First
   if Max_length/cycle_length <0.1 then begin  // workingstate:=1; 支架初撑力就是最大压力，支架整体工作压力处于下降趋势
       workingstate:=1;
   end else if (Max_length/cycle_length >0.9) and(MinD>=MaxD) then  begin   // workingstate:=2; 支架最大压力是末阻力，支架工作正常，切极有可能处于来压状态
       workingstate:=2;
   end else  begin //  workingstate:=0; 支架最工作状态不好判断
       workingstate:=0;
   end;
   // second  循环中间出现移架现象，但是不符合我对一次真正移架周期的判断
   if (M_S_N>1) and (workingstate=0) and (MinD>MaxD) and (Min_length/cycle_length <0.9) then  begin
       workingstate:=2;
   end else  if (M_S_N>1) and (workingstate=0) and (MinD>MaxD) and (Min_length/cycle_length >=0.9) then  begin
       workingstate:=1;
   end else  if (M_S_N>1) and (workingstate=0) and (MinD<MaxD) then  begin
       workingstate:=1;
   end;
   //
    if S_V=Max_V then  workingstate:=1;  // 第一个值就是最大值
    if (workingstate <>1) and (R_P/T_P >0.8) then  workingstate:=2;

   ComePressFlag:=0;
  if A_C_V>O_h_V then  ComePressFlag:=4;  // 本期均大于1小时均值
  if A_C_V>T_h_V then  ComePressFlag:=ComePressFlag+8;  // 本期均大于2小时均值
  if A_C_V>F_h_V then  ComePressFlag:=ComePressFlag+16;  // 本期均大于4小时均值
  if A_C_V>E_h_V then  ComePressFlag:=ComePressFlag+32;  // 本期均大于8小时均值
  if A_C_V>S_h_V then  ComePressFlag:=ComePressFlag+64;  // 本期均大于16小时均值
  if A_C_V>O_D_V then  ComePressFlag:=ComePressFlag+128;  // 本期均大于一天的均值
  Result:=false;
  {R_P raisepointnumber，T_P totalPointNumber,M_P， morethantoppoint}
  if (workingstate =2) and (R_P/T_P >=0.5) and (M_P/T_P >=0.1) and (ComePressFlag>=32)
       then  workingstate:=3;
  if ComePressFlag>=64  then workingstate:=workingstate+1;   //如果均值较大
  //末阻力判断
  if MZl> A_C_V then  workingstate:=workingstate+1;


try
  FAdoCommand.MySqlConnection.BeginTrans ;
  sql:=' insert into D_'+FGbh+'_SEcondDP ( supportbh,typedata,starttime,start_value,endtime,end_value,' +
       ' Max_time,Max_value,Min_time,Min_value,changtimes,totalpointnumber,RaisepointNumber,RaisePointpercent,'+
       ' DropPointnumber,DropPointPercent,AGV_Cycle_Value,AVGcyclePercentDay,topline,bottomLine,Morethantoppoint,'+
       ' MorethantopPercent,supportworkingstate,effectivePoint,effectivePercent,TimeCycle,Process,footage, '+
       ' AGV_one_hours_V,AGV_two_hours_V,AGV_four_hours_V,AGV_eight_hours_V, AGV_sixteen_hours_V,AGV_one_days_V,' +
       ' comepressflag,FootageFlag,SupportBeforeMovePress,SupportStartPress) values ('+
       intToStr(S_N)+','''+T_D+''','''+FormatDateTime('yyyy-mm-dd hh:nn:ss',st)+''','+floatTostr(s_v)+','''+
       FormatDateTime('yyyy-mm-dd hh:nn:ss',et)+''','+FloattoStr(E_v)+','''+ FormatDateTime('yyyy-mm-dd hh:nn:ss',maxD) +
       ''','+ FloattoStr(Max_v)+','''+  FormatDateTime('yyyy-mm-dd hh:nn:ss',minD) +  ''','+ FloattoStr(Min_v)+',' +
       IntToStr(C_T)+','+ IntToStr(T_P)+','+IntToStr(R_P)+','+FloatToStr(R_P/T_P*100)+',' +IntToStr(D_P)+','+FloatToStr(D_P/T_P*100)+
       ','+floatToStr(A_C_V)+','+FloatToStr(A_C_V/O_D_V*100)+','+FloatToStr(T_L)+','+FloatToStr(B_L)+','+IntToStr(M_P)+','+
       FloatToStr(M_P/T_P*100)+',' +intToStr(workingstate)+',' +intToStr(E_P)+','+ FloatToStr(E_P/T_P*100)+
       ','+IntToStr(T_C)+',0,0,'+floatToStr(O_h_v)+','+floatToStr(t_h_v)+','+floatToStr(f_h_v)+','+floatToStr(E_h_v)+
       ','+floatToStr(S_h_v)+','+floatToStr(O_D_v)+','+IntToStr(ComePressFlag)+',0,'+floatToStr(mzl) + ','+floatToStr(ccl) +
       ') ' ;
   FAdoCommand.CommandText :=sql;
   FAdoCommand.Execute ;
   sql:='update D_'+FGbh+'_'+intToStr(S_N)+'_FirstDP set Process=1 where generatetime between '''+FormatDateTime('yyyy-mm-dd hh:nn:ss',st)+
      ''' and ''' +FormatDateTime('yyyy-mm-dd hh:nn:ss',et) +''' and ValueType=''' +T_D +'''' ;
   FAdoCommand.CommandText :=sql;
   FAdoCommand.Execute ;
except
   FAdoCommand.MySqlConnection.RollbackTrans;
   exit;
end;
   FAdoCommand.MySqlConnection.CommitTrans ;
   Result:=true
end;

procedure TSecondThread.InsertSql(Sql: string);
begin
     FAdoCommand.CommandText :=sql;
     FAdoCommand.Execute ;
end;

procedure TSecondThread.ReturnFinished;
begin
     if Assigned(OnFinished) then
         OnFinished(TotalNumber,Fsupbh,EspTime,Succeed);
end;

function TSecondThread.SecondDataDisposeProcess
       (Gzmbh,typeData:string;supbh:integer;
         one_hours_V,two_hours_V,four_hours_V,eight_hours_V,
         sixteen_hours_V,one_days_V:double;
         Var LastTime:Tdatetime):Boolean; //数据处理核心程序: Boolean;
var
   i:integer;
   TopLine,BottomLine:double;
   Starttime,Endtime,MaxTime,MinTime:TdateTime;
   startValue,EndValue,MaxValue,MinValue:double;
   RaiseNumber,DropNumber:integer; // 上升点数 下降点数
   RaiseOrDrop:Boolean;//支架压力上升还是下降状态  true  上升  false 下降
   RaiseChangeDropNumber:integer;//支架压力上升 下降 转换次数
   totalPointNumber,effectivePointNumber:integer;//
   Stopfootage:boolean; //是否是检修标记
   MoveSupportNumber,MoveSupportFlag:integer;//一个循环内移架的次数
   AVG_Sum_V,AVG_Temp_v:double;
   MorethantopLinePoint:integer;//超过topline数量
   UseSupOpen,Usesupload:double; //使用支架的初撑力与液压阀开启值
   temp_dFdd:PFDD; //
   insertFlag:boolean;
   SupportBeforeMovePress:Double; //末阻力
   SupportStartPress:double; //初撑力
 begin
      Result:=false;
      insertFlag:=False;
      MoveSupportNumber:=0;MoveSupportFlag:=0;
      //根据支架的初撑力与液压阀开启值来初始化 判断使用值
      UseSupOpen:=FinGzm.Usedsupport.EndOpenLoad*1.1;
      UsesupLoad:=FinGzm.Usedsupport.initLoad *0.8;
       //计算初值为零
     AVG_temp_V:=0;
     MorethantopLinePoint:=0;
     DropNumber:=0;
     startValue:=0;EndValue:=0;
     MaxValue:=0;MinValue:=0;
     RaiseChangeDropNumber:=0;
     MorethantopLinePoint:=0;
     effectivePointNumber:=0;
     SupportStartPress:=0;
     SupportBeforeMovePress:=0;
     //  第一个数值
       temp_dFdd:=PFDD(dFDDList.Items[0]);
       MaxValue:=temp_dFdd.dMaxValue;
       MaxTime:= temp_dFdd.dTimeD ;
       AVG_temp_V:=temp_dFdd.dAvgValue; //数据临时均值
       AVG_Sum_V:=temp_dFdd.dAvgValue; //数据整体均值
       totalPointNumber:=temp_dFdd.dFrequency;
       MinValue:=temp_dFdd.dMinValue;
       MinTime:= temp_dFdd.dTimeD ;

       StartValue:=temp_dFdd.dAvgValue;
       RaiseOrdrop:=true;
       DropNumber:=0;
       RaiseNumber:=temp_dFdd.dFrequency;
       Starttime:= temp_dFdd.dTimeD-(DropNumber-1)*FDataTimeintVal*MinutesD ;
       TopLine:= two_hours_V*(1+StepPressTopPercent/100);
       BottomLine:=two_hours_V*(1-StepPressBottomPercent/100);
     //循环判断
     for I := 1 to dFDDList.Count  - 1 do  begin
         temp_dFdd:=PFDD(dFDDList.Items[i]);
         if totalPointNumber+temp_dFdd.dFrequency<1 then   continue;
         //判断移架次数
         if temp_dFdd.dMovesuppport >= 1 then  begin
              MoveSupportFlag:=1;
              MoveSupportNumber:=MoveSupportNumber+1;
              if SupportStartPress < temp_dFdd.dSupportStartPress then
                 SupportStartPress:=temp_dFdd.dSupportStartPress;
              if SupportBeforeMovePress <temp_dFdd.dSupportBeforeMovePress then
                SupportBeforeMovePress:=temp_dFdd.dSupportBeforeMovePress ;
         end;
         if temp_dFdd.dMovesuppport=2 then
                MoveSupportFlag:=2;
         //计算循环内平均值
         AVG_Sum_V:=(AVG_Sum_V*totalPointNumber+temp_dFdd.dAvgValue*temp_dFdd.dFrequency)
                      /(totalPointNumber+temp_dFdd.dFrequency);
         totalPointNumber:=totalPointNumber+temp_dFdd.dFrequency;
         //上升下降次数
         if RaiseOrdrop and (AVG_temp_V > temp_dFdd.dAvgValue)  then begin
               RaiseOrdrop:=false ;
               RaiseChangeDropNumber:=RaiseChangeDropNumber+1;

         end else if not RaiseOrdrop and  (AVG_temp_V < temp_dFdd.dAvgValue) then  begin
               RaiseOrdrop:=true;
               RaiseChangeDropNumber:=RaiseChangeDropNumber+1;
         end;
          //本分钟内的平均值
          AVG_temp_V:= temp_dFdd.dAvgValue;

          if RaiseOrdrop then begin
               RaiseNumber:=RaiseNumber+temp_dFdd.dFrequency  ;
               if MaxValue < temp_dFdd.dMaxValue then  begin
                    MaxValue := temp_dFdd.dMaxValue;
                    MaxTime:=temp_dFdd.dTimeD ;
               end;
           end else begin
               DropNumber:=DropNumber+temp_dFdd.dFrequency ;
               if MinValue > temp_dFdd.dMinValue then begin
                  MinValue := temp_dFdd.dMinValue;
                  MinTime:= temp_dFdd.dTimeD ;
               end;
           end;


      //计数开始      //
       if temp_dFdd.dMaxValue>=BottomLine then  effectivePointNumber:=effectivePointNumber+temp_dFdd.dFrequency;
       if temp_dFdd.dMaxValue>=TopLine then  MorethantopLinePoint:=MorethantopLinePoint+temp_dFdd.dFrequency;

     end; // end for i

     if SupportBeforeMovePress < AVG_Sum_V then   SupportBeforeMovePress := AVG_Sum_V ;

     if  (MaxValue > AVG_Sum_V*(1+StepPressTopPercent/100)) and   (MinValue<AVG_Sum_V*(1-StepPressBottomPercent/100))
         and (RaiseChangeDropNumber >1)  and ((totalPointNumber*temp_dFdd.dInterVal>=20) or (MoveSupportFlag=2)) then begin
//       if   ((totalPointNumber*temp_dFdd.dInterVal>=5) or (MoveSupportFlag=2)) then begin
//
           EndTime:=temp_dFdd.dTimeD; EndValue:=temp_dFdd.dAvgValue ;
            // 写入数据库
           if InsertSecondDP(gzmbh,typeData,    // FGbh,T_d:string;  //gzmbh,typedate
                   supbh,RaiseNumber,DropNumber,MorethantopLinePoint,totalPointNumber, // S_N, R_P, D_P, M_P T_p
                                                             // upportbh,raisepointnumber,droppointnumber,morethantoppoint ,totalnumberPoint
                   effectivePointNumber,RaiseChangeDropNumber,MoveSupportNumber,temp_dFdd.dInterVal, // E_P,C_T,W_S,T_C:integer;
                                                            // effectivePoint,changetimes,supportworkingstate,Timecycle
                   starttime,endtime,MaxTime,Mintime,             // st,et,maxD,minD :Tdatetime; //starttime,endtime,max_time,Min_time
                   startValue,endvalue,Maxvalue,MinValue,         //s_v,E_v,Max_v,Min_v,   //   // startvalue,endvalue,Max_value,MIn_value
                   One_days_V,AVG_Sum_V,topline,Bottomline,    //  O_D_V,A_C_V,T_L,B_L:double // //Agv_sum_value,AGv_Day_value,topline,bottomLine
                   one_hours_v,two_hours_v,four_hours_v,   // o_h_v,t_h_v,f_h_V,
                   eight_hours_v,sixteen_hours_v,       //e_h_v,s_h_v:double //eight_hours_V,Sixteen_hours_v
                   SupportBeforeMovePress,SupportStartPress)  //SupportBeforeMovePress,SupportStartPress

           then   insertFlag:=true;
      end;  //end if
      // 开始赋值 lastTime
     LastTime:= temp_dFdd.dTimeD;
     if insertFlag then  begin
         Result:=true; LastTime:=1;
     end;

end;

function TSecondThread.SecondDisPoseDate(FGzmid: string; uSupBh: integer; TypeValue:string): Boolean;
var
  i,j:integer;
  CurrnetTime:Tdatetime;
  CurrentId:integer;
  one_hours_v,two_hours_v,four_hours_v,eight_hours_v,sixteen_hours_V,one_days_V:double;
  WhileCount:Integer;//循环次数
begin
    // 支架数据初始化。程序正常运行 该处注册掉
//       FinGzm.Usedsupport.initLoad:=25.0;
//       FinGzm.Usedsupport.EndOpenLoad :=42;
//       FinGzm.SupStartNumber :=1;
//       FinGzm.SupEndNumber:=122;
//       FinGzm.SupNumberDirection:=0;

    //=====
    Result:=true;
    WhileCount:=0;
 try
       CurrnetTime:=1;
       while SelectToprecord(FGzmid,uSupBh,TypeValue, CurrnetTime, CurrentId )do  begin
           if FDisPose.SecondProcessstop then  break; //  循环退出机制
           WhileCount:=WhileCount+1;
           if (FDisPose.writeProcessflag) and ( whilecount mod 10 =0 ) then
           insertSql(' insert into processlog (generatetime,DataNumber,gzmname,supportbh, threadid,Processtype) values (''' +
                      FormatDaTeTime('yyyy-mm-dd hh:nn:ss',now())+''','+IntToStr(WhileCount)+',''' +
                      Trim(FGzmid)+''','+ IntToStr(uSupBh) +','+IntToStr(self.Handle)+',''SecondProcess'')' );

           //如果连续多条具有来压标志的记录,处理到最后一条
           while self.SelectNextRecord(FGzmid,uSupBh,TypeValue, CurrnetTime,CurrnetTime, CurrentId ) do  ;

           // 计算平均值
           SelectAVGrecord(FGzmid,uSupBh,TypeValue,CurrnetTime,1,one_hours_V);
           SelectAVGrecord(FGzmid,uSupBh,TypeValue,CurrnetTime,2,two_hours_V);
           SelectAVGrecord(FGzmid,uSupBh,TypeValue,CurrnetTime,4,four_hours_V);
           SelectAVGrecord(FGzmid,uSupBh,TypeValue,CurrnetTime,8,eight_hours_V);
           SelectAVGrecord(FGzmid,uSupBh,TypeValue,CurrnetTime,16,sixteen_hours_V);
           SelectAVGrecord(FGzmid,uSupBh,TypeValue,CurrnetTime,24,one_days_V);


           // 填充数据
           secondSelectData(FGzmid,uSupBh,TypeValue,CurrnetTime,0);
           // 计算数据
           SecondDataDisposeProcess(FGZmid,TypeValue,uSupBh,one_hours_V,two_hours_V,four_hours_V,
                                eight_hours_V, sixteen_hours_V,one_days_V,CurrnetTime);

       end; //end while


 except
    Result:=false;
 end;
end;

function TSecondThread.secondSelectData(dGzmbh: string; supportBh: integer;
  typeValue: string; tGeneratetime: TdateTime; FirstOrSencod: integer): boolean;
var
  sql:string;
  i:integer;
  Max_value,Min_value:double;
  FirstTime:TdateTime;
  FirstValue:double;
begin
    Result:=False;
     //清理内存
   for I := 0 to dFddList.Count - 1 do
       if Assigned(dFddList[i]) then  Dispose(PFDD(dFddList[i]));
        dFDDList.Clear ;

     //-----
 try
    sql:=' select * from D_'+trim(dGzmbh)+'_'+Trim(intToStr(supportbh))+'_FirstDP' +
          ' where process=0 and  valueType= '''+typeValue+''' and generatetime <='''+
          FormatDateTime('yyyy-mm-dd hh:nn:ss',tGeneratetime)+ '''  order by generatetime ';
    FAdoDataSet.Close ;
    FAdoDataSet.CommandText :=sql;
    if FAdoDataSet.Open then  begin
        FAdoDataSet.First;
        InidCircleRec(dCircleRec);
        if FAdoDataSet.RecordCount >0 then  begin
           FirstValue:=FAdoDataSet.FieldByName('AGV_Value').AsFloat;
           FirstTime:=FAdoDataSet.FieldByName('GenerateTime').AsDateTime;
        end;
        while not FAdoDataSet.Eof  do  begin
           new(dFDD);
           dFDD.dValueType:=typeValue;
           dFDD.dTimeD:=FAdoDataSet.FieldByName('GenerateTime').AsDateTime;
           dFDD.dMaxValue:=FAdoDataSet.FieldByName('Max_Value').AsFloat;
           dFDD.dMinValue:=FAdoDataSet.FieldByName('Min_Value').AsFloat;
           dFDD.dAvgValue:=FAdoDataSet.FieldByName('AGV_Value').AsFloat;
           dFDD.dFrequency:=FAdoDataSet.FieldByName('frequency').AsInteger;
           dFDD.dPointNumber:=FAdoDataSet.FieldByName('PointNumber').AsInteger;
           dFDD.dDiffPercent:=FAdoDataSet.FieldByName('DiffPercent').AsFloat;
           dFDD.dInterVal:=FAdoDataSet.FieldByName('TimeInterVal').AsInteger;
           dFDD.dMovesuppport:= FAdoDataSet.FieldByName('MoveSupport').AsInteger;
           if dFDD.dMovesuppport >0 then begin
              self.SelectMoveStatePress('D_'+trim(dGzmbh),dFDD.dValueType,supportbh,FirstTime,dFDD.dTimeD,
                      dFDD.dSupportBeforeMovePress,dFDD.dSupportStartPress );
              if dFDD.dSupportStartPress < FirstValue*0.5 then
                 dFDD.dSupportStartPress :=FirstValue;
           end;
           dFDDList.Add(dFDD);
           //
           FAdoDataSet.Next;
        end;
    end;
 finally
    FAdoDataSet.Close ;
    Result:=true;
 end;
end;

function TSecondThread.SelectAVGrecord(dGzmbh: string; supportBh: integer;
  typeValue: string; Gentime: Tdatetime;CycleTime:integer; var AVGValue: double): Boolean;
Var
  sql:string;
  StartTime,EndTime:String;
begin
  Result:=False;
  StartTime:=FormatDateTime('yyyy-mm-dd hh:nn:ss', Gentime-CycleTime/3);
  EndTime:=FormatDateTime('yyyy-mm-dd hh:nn:ss', Gentime);

  sql:=' select Sum(AGV_Value*Frequency)/sum(Frequency) as A_V from D_'+trim(dGzmbh)+'_'+Trim(intToStr(supportbh))+'_FirstDP' +
          ' where valueType= '''+typeValue+''' and ( generatetime between '''+StartTime +
          ' '' and ''' +  EndTime +''' )';
     FAdoDataSet.Close ;
     FAdoDataSet.CommandText :=sql;
     if FAdoDataSet.Open then
       if  FAdoDataSet.RecordCount>0  then  begin
          AVGValue:= FAdoDataSet.FieldByName('A_V').Asfloat;
          result:=true;
       end;
     FAdoDataSet.Close ;
end;

function TSecondThread.SelectMoveStatePress(dtable_n,typeValue: string;
  SupportBh: integer; Firsttime,LastTime: TdateTime; var EndPress,
  StartPress: double): boolean;
{
   通过传入的参数，查找本次循环的末阻力与初撑力是否标注。

}
var
   inFDataSet:TMyDataSet;
   sql:string;
   //:TdateTime;
   SPRess,EPress:Double;
begin
  Result:=False;
  try
     inFDataSet:=TMyDataSet.Create(nil);
     inFDataSet.MySqlConnection:=FAdoconn;
     SPress:=0;EPress:=0;
     sql:=' select generatetime,SupportStartPress,BeforeMoveValue from ' +dtable_n +'_supportMoveInfo ' +
         ' where  supportbh= '+ IntTostr(supportbh) + ' and ValueType = ''' +  typeValue +''''+
         ' and starttime >= '''+  FormatDateTime('yyyy-mm-dd hh:nn:ss',LastTime)  +'''' +
         ' order by starttime limit 1 ' ;
     inFDataSet.CommandText :=sql;
     if inFDataSet.Open then
         if inFDataSet.RecordCount >0 then  begin
             //本次循环的末阻力
             EPress:=  inFDataSet.FieldByName('BeforeMoveValue').AsFloat ;
             //GTime:= inFDataSet.FieldByName('generatetime').AsDateTime;
         end else begin

         end;

     inFDataSet.Close;
     sql:=' select generatetime,SupportStartPress from ' +dtable_n +'_supportMoveInfo ' + ' where  supportbh= '+ IntTostr(supportbh) +
          ' and Endtime <= '''+  FormatDateTime('yyyy-mm-dd hh:nn:ss',FirstTime)  +''' and ValueType = ''' +  typeValue +''''+
         '  order by Endtime desc limit 1';

     inFDataSet.CommandText :=sql;
     if inFDataSet.Open then
         if inFDataSet.RecordCount >0 then
            SPress:=  inFDataSet.FieldByName('SupportStartPress').AsFloat ;

     inFDataSet.Close;

  finally
     inFDataSet.Free;
     StartPress:=SPress;
     EndPress:=EPress;
     Result:=True;
  end;
end;

function TSecondThread.SelectNextRecord(dGzmbh: string; supportBh: integer;
  typeValue: string; CurrentTime: Tdatetime; var Gentime: Tdatetime;
  var CurrentId: integer): Boolean;
{ 如果连续多条具有来压标志的记录,处理到最后一条
  数据处理的原则是：
  （1）当前处理时间标记了来压情况
  （2）下一个处理时间间隔也标记了来压情况
   比较的情况就是， 以 1分钟处理周期为例， 来压发生在 处理节点 的前面与后面
   结果造成 前面的1分钟 标记了 来压 标记，后面的一分钟也标记了来压标记 。
   这种情况的处理方案是，处理到最后一条标记来压步距的地方，把他们看成是一次来压方式。

   }
Var
  sql:string;
begin
     Result:=False;
     Gentime:= CurrentTime;
     sql:=' select id,generatetime from D_'+trim(dGzmbh)+'_'+Trim(intToStr(supportbh))+'_FirstDP' +
          ' where process=0 and  valueType= '''+typeValue+'''  and movesupport >=1 '+
          ' and generatetime= '''+FormatDateTime('yyyy-mm-dd hh:nn:ss',CurrentTime+FDataTimeintVal)+''' ';
     FAdoDataSet.Close ;
     FAdoDataSet.CommandText :=sql;
     if FAdoDataSet.Open then
         if  FAdoDataSet.RecordCount>0  then  begin
            CurrentId:= FAdoDataSet.FieldByName('id').AsInteger;
            Gentime:=   FAdoDataSet.FieldByName('generatetime').AsDateTime;
            result:=true;
         end;
     FAdoDataSet.Close ;

end;

function TSecondThread.SelectToprecord(dGzmbh: string; supportBh: integer;
  typeValue: string; var Gentime: Tdatetime; var CurrentId: integer): Boolean;
Var
  sql:string;
begin
     Result:=False;
     if Gentime<1000 then  begin
          if (DataBaseType= 'SQLSERVER') or(DataBaseType= 'SQL SERVER') then  begin
             sql:=' select top 1 id,generatetime from D_'+trim(dGzmbh)+'_'+Trim(intToStr(supportbh))+'_FirstDP' +
                    ' where process=0 and  valueType= '''+typeValue+''''+
                    ' and movesupport=1 order by generatetime ';
          end else if (DataBaseType= 'MYSQL') or(DataBaseType= 'MY SQL') then  begin
             sql:=' select id,generatetime from D_'+trim(dGzmbh)+'_'+Trim(intToStr(supportbh))+'_FirstDP' +
                    ' where process=0 and  valueType= '''+typeValue+''''+
                    ' and movesupport=1 order by generatetime limit 1 ';
          end;


     end else begin

        if (DataBaseType= 'SQLSERVER') or(DataBaseType= 'SQL SERVER') then  begin
              sql:=' select top 1 id,generatetime from D_'+trim(dGzmbh)+'_'+Trim(intToStr(supportbh))+'_FirstDP' +
                    ' where process=0 and generatetime > '''+FormatDateTime('yyyy-mm-dd hh:nn:ss',Gentime)+''' and  valueType= '''+typeValue+''''+
                    ' and movesupport=1 order by generatetime  ';
          end else if (DataBaseType= 'MYSQL') or(DataBaseType= 'MY SQL') then  begin
               sql:=' select id,generatetime from D_'+trim(dGzmbh)+'_'+Trim(intToStr(supportbh))+'_FirstDP' +
                    ' where process=0 and generatetime > '''+FormatDateTime('yyyy-mm-dd hh:nn:ss',Gentime)+''' and  valueType= '''+typeValue+''''+
                    ' and movesupport=1 order by generatetime limit 1 ';
          end;
     end;
     FAdoDataSet.Close ;
     FAdoDataSet.CommandText :=sql;
     if FAdoDataSet.Open then
           if  FAdoDataSet.RecordCount>0  then  begin
              CurrentId:= FAdoDataSet.FieldByName('id').AsInteger;
              Gentime:=   FAdoDataSet.FieldByName('generatetime').AsDateTime;
              result:=true;
           end;
     FAdoDataSet.Close ;
end;

end.  //end unit
