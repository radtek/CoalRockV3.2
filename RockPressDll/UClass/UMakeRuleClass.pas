unit UMakeRuleClass;


interface
uses
  Winapi.Windows, SysUtils, Classes, Messages, Controls, Forms, StdCtrls, ExtCtrls,
  ComCtrls ,math,Grids,WordXP,COMobj,SQLiteTable3,StrUtils,Vcl.Dialogs,
  PStope_GzmGuidClass , UMainDataModule,System.TypInfo

  ;

type

  TReadRecord =record
    FileName:String;
    elapsedMilliseconds : cardinal;
    RecordNumber:integer;
    Processing:double;
    PrintProc:integer;
    ReadFin:Boolean;
    printed:Boolean;
    CloseThread:Boolean;
  end;

  TDataTimeString=Class(TObject)
    private
        DTlength:integer;
        DTString:String;
        YearStart:integer;
        YearEnd:integer;
        YearSplitMonth:char;
        MonthStart:integer;
        MonthEnd:Integer;
        MonthSplitDay:char;
        DayStart:Integer;
        Dayend:integer;
        DaySplitHour:char;
        HourStart:Integer;
        HourEnd:Integer;
        HourSplitMin:char;
        MinStart:integer;
        MinEnd:Integer;
        MinSplitSec:Char;
        SecStart:integer;
        SecEnd:integer;
        //
         FSetting : TFormatSettings;  //日期格式转换
    public



        function SplitDTString(DTS:String):Boolean;
        function isVailDT(DTS:String):Boolean;
        function DTStrChangeToDateTime(DTS:String):TdateTime;

        constructor Create;
        destructor Destroy;override;
  end;

  TFirstData = record
     isRecord :Boolean;   //  是否有数据
     dTimeD:Tdatetime;   //   数据产生时间
     dStartTime:TdateTime;  //循环开始时间
     dStartValue:Double;   // 循环开始数值
     dEndTime:TdateTime; // 循环结束时间
     dEndValue:Double;//  循环结束数值

     dMaxValuetime:TdateTime;  //  最大数据产生时间
     dMinValuetime:TdateTime;   //  最小数据产生时间

     dMaxValue:double;      //  数据最大值
     dMinValue:double;     //   数据最小值
     dAvgValue:double;     //   数据平均值

     dFirstValue:double;      //第一条记录
     dFirstValueTime:tdatetime;//第一条记录的时间
     dFrequency:integer;    //  数据重复次数
     dPointNumber:double;   //  数据总点数
     dDiffPercent:double;    // 数据差异率
     dMovesuppport:Boolean;  // 是否移架标记
     dInterVal:integer;    //    数据时间间隔
     dTotalGradient:double; // 数据总梯度
     dSupportState:integer; //液压支架的状态
     dStartPressure:double;//液压支架的初撑力

     dMoveEndTime:TdateTime;// 液压支架移架结束时间
     dMoveStartTime:TdateTime;// 液压支架移架开始时间

     dZhuYeGradient:double;//注液梯度
     dZhuYeTimes:integer; //注液经历的时间
     dzhuyeEndTime:TdateTime;//注液完成的时间
     dzhuYeValue:double;//注液完成时压力
     dZhuyeHuZhuanTimes:integer;//注液回转 的时间
     dZhuYeHuzhuanGradient:double; // 数据第一次梯度 也就是注液完成时的回转梯度

     dBeforeLastValue:double;     //  异动前最后一条记录
     dBeforeLastValueTime:Tdatetime;// 异动前最后一条记录的时间
     dbeforeLastGradient:double;  // 异动的梯度 也是液压支架受其他支架影响的梯度
     dbeforeLastMaxValue:double; //异动后最大的数值
     dBeforeLastMaxValueTime:Double;//异动后最大的数值的时间 
     dbeforeLastTimes:integer;// 异动经历的时间

    
  end;

  TBasicDataParm= Record
      DataName:string;   // 数据名称
      DataBh:integer;   // 数据标号
      DataUnit:String ;//数据单位
      DataType:TSupportDataType;// 液压支架数据的类型
      TagStr:String;    // 前导识标符
      UpperCase:Integer; // 0 不区分 1 大写 2 小写
      Data:double;// 具体数据
  End;

 TInputData=Record
     support:integer;
     GenerateTime:TdateTime;
     MoveSupportTag:Boolean;  // true 表示 数据开始移架， false 表示 没有移架
     DataCount:integer;
     InputDataS:Array of TBasicDataParm;
     UsedDataType:integer; // 0 最大值 1 最小值 2 平均值
     Useddata:Double;
     SupportState:Integer;// 1 正常工作状态  0 移架状态  -1 不正常工作状态
     
 end;

TArrayInputData= Array of TInputData;

TJinDaoRecord=record
   ShotTime:TdateTime;
   DataVAlue:Double;
   Daoshu:integer;

end;
TBasicJinDao=Class(TObject)
   private

   public
     BasicSupport:integer;
     CurrSupport:integer;
     Count:integer;
     ArrayBasicJinDao:Array of TJinDaoRecord;
     CurrDataValue:double;
     StartTime:TDateTime;
     BasciState:Boolean; // 支架编号的判定状态 true 是判定进刀的支架
     ItemIndex:integer;

     procedure Add(JDR:TJinDaoRecord) ;
     procedure ClearArray;

     constructor Create;
     destructor Destroy;override;

End;

TDFrequRecord=Record
  BottomLine:Double;
  TopLine:Double;
  Count:integer;
  Percent:double;
End;


TDataFrequency=Class(TObject)
   private
      // Data_Intval
      Interval :double;
      StartLine:double;
      TopLine:Double;
      MyChildCount:Integer;


      procedure ClearChild;
   public
      TotalCount :integer;
      MyChild:Array of  TDFrequRecord;

      Procedure InitArrayChild;
      Procedure AddChild(Data:double;Frequency:integer);
      procedure AddOneData(Data:double;Frequency:integer);
      function MakeString:String;
      procedure SplitString(Value:string);
      procedure AddNextClassToSelf(Next:TDataFrequency);
      function FillDataFromDataBase(Gzmbh,Sup_st,Sup_end: integer; Str_time, En_Time: TDateTime):Boolean;
      function ReturnNotEffiectBl:double;   //无效比例
      function ReturnNotEddirctCount:Integer; // 无效数字
      function ReturnEddirctCount:Integer; // 有效量
      function ReturnEffiectBl:double;   //有效比例
   constructor Create;
   destructor Destroy;override;

end;

TDisposeCycleData=Class(TObject)
   private
      MyDataConnect:TMySqlConnection;
      Supportbh:integer;
      Phase_St_id:Integer;
      Phase_Ed_id:Integer;
      tmp_Use_InputData :TArrayInputData;
      Min_ST_id:integer;
      Min_ED_id:integer;

      WorkFace_id:string;
      ProCycle:TFirstData;
      tmp_Cal: TFirstData;


      MyDataSet:TMyDataSet;
      MyCommand:TMyCommand;

      function GetMaxValue(Stid,EnId:integer;Var tmp:TFirstData ):Double;
      function GetMinValue(Stid,Enid:integer;Var tmp:TFirstData):Double;
      function GetAGVValue(Stid,Enid:integer;Var tmp:TFirstData):Double;
      function GetMaxValueFromUsedData(Stid,EnId:integer;Var tmp:TFirstData):Double;
      function GetMinValueFromUsedData(Stid,EnId:integer;Var tmp:TFirstData):Double;

      function SaveSupportMoveData(table_b:string;supportbh:integer;
                          ValueType:string;GeTime:Tdatetime;dp:TFirstData):Boolean;
      function ChangeSuppotDataTypeToString(Value:Integer):String; overload;
      function ChangeSuppotDataTypeToString(Value:TSupportDataType):String; overload;
      function ChangeSupportDataTypeToInteger(Value:string):Integer;
      function NoExsitMoveSupportInfor(Curr_id:integer):integer;
      function GetMultDataType(id:Integer):string;
      function SelectCClAndMzl(var tpCal: TFirstData):Boolean;
      function  Cal_Variance(var tpCal: TFirstData):Boolean;
      function  ReturnTwoDateTimeDiff(D1,D2:TdateTime):Integer;
      function  GetLastTime(SupportBh:Integer):TdateTime;
      function  ReadWorkFaceJinDaoInformation(WorkFace_id:String):string;
      function  SaveWorkFaceJinDaoInformation(WorkFace_id,StrValue:String):Boolean;
      function  splitFootStepParameters:Boolean;

   public
      BasicJindao:TBasicJinDao; // 基本进刀的类
      BasicData:TBasicDataParm;
      LastTime:TdateTime;
      MyWokFace_Info:TRockPressAnalysis;
      Data_Frequency:TDataFrequency;

      function Guide_DeepAnaly(Curr_id:integer;isExsitMoveSupport:Boolean):Boolean;
      function Judge_MoveSupport(Currid:integer;var tmp:TFirstData):Boolean;
      function Tag_MoveSupport:Boolean;
      function FillProCycle(var tm:TFirstData):Boolean;
      procedure Set_WorkFaceId(Value:string);
      procedure InitBasicV;
      procedure ClearFirstData(var tm:TFirstData);
      procedure SetInputDataArrayValue(tm:TArrayInputData);
      function ReadWorkFaceInforMation:Boolean;
      function SaveWorkFaceInforMation:Boolean;
      function GetJinDaoBasicSupport:String;
      // makeJinDaoShumu
      function  MakeJinDaoBasic(Support:integer):Boolean;
      function  GetFGzmEndSupNumber(WorkFace_id:String):Integer;

      constructor Create(ADOConn:TMySqlConnection);
      destructor  Destroy;override;
end;



TMakeRuleClass =Class(TObject)

    private
      SupprortPercentPress:double;
      MyDataConnect:TMySqlConnection;
      WorkFace_id:string;
      LastTime: TdateTime;


      function Return_Pro_Flag(Flag:string;id:Integer;U_L:Boolean):String;
      function ReturnMoveSupportState(Equal:string;C0,C1:Integer):Boolean;
      function DisPoseMult_Data(tm:TInputData): TInputData;
      function ReturnMin_AGV_Vlaue(id:integer;D1,D2:Double):Double;
   public
      Ruleid:Integer;
      RuleName:string;   //规则名称
      FileSuffix:String; // 文件后缀
      LineSplitTag:String;  //行分隔符
      MoveSuppFlag:Boolean; //是否有移架的标记

      DataTimeClass:TDataTimeString;//格式字符串 的类
      DataTimeStr:String ;//制定的格式字符串
      DTProRec:TBasicDataParm; // 日期时间的前导
      SupProRec:TBasicDataParm; // 液压支架的前导
      MoveProRec:TBasicDataParm;// 液压支架移架的前导
      MoveSupp_Equal:String; // 移架数值的运算符号
      MoveSupp_Value:integer; //移架标记的数值
      MuleData_MAX_AGV:Integer;// 多个同质数据的运算规则  0 最大值 1 最小值 2 平均值


      Basic_DataNumber:integer; //数据的数量
      BasicDataS:Array of  TBasicDataParm; // 数据的一维数组
      DisPoseCycleDataS: TDisposeCycleData;// 处理循环数据的类

      Anal_DataNumber:Integer; // 分析得来的基本数据 数量
      Anal_DataS:TArrayInputData;  //分析得来的 基本数组


      procedure AddBasicDataS(Data:TBasicDataParm);
      procedure DeleteBasicDataS(id:integer);
      procedure FillDataToStrGrid(ST:TStringGrid);
      procedure ClearDataS;
      Procedure ClearAnal_DataS;

      function  Add_Anal_DataS(data:TInputData):Integer;
      Procedure Delete_Anal_DataS(Id:integer);
      procedure SetUsed_WorkFaceId(Value:string);
      //
      function  AnalySisData(LineStr:String):TInputData;
      function  LoadDataFromFlie(var ReadClass:TReadRecord;FileName:string;
                     BasicSupport:integer):Integer;
      function SaveInputDataToFile(WorkFace_id,SupportBh:integer):Boolean;
      //calCycle
      function  DeepAnalyCycle(Data:TInputData;LastId:integer;isExsitMoveSupport:Boolean):Boolean;

      function  GetLastTime(SupportBh:Integer):TdateTime;
      //查找统一时间内的数据
      function  SelectDataRelySameTime(Cuur_id,Curr_sup:integer):Boolean;
      // 数据的备份与恢复
      function MakeString:String;
      function FillSelfClassFromSring(Value:string):Boolean;
      //

      constructor Create(ADOC: TMySqlConnection);
      destructor Destroy;override;

end;


implementation

{ TDataTimeString }

uses Lu_Public_BasicModual;

constructor TDataTimeString.Create;
begin
      //日期格式转换
       FSetting.ShortDateFormat:='YYYY-mm-dd' ;
       FSetting.DateSeparator :='-';
       FSetting.ShortTimeFormat :='hh:nn:ss';
       FSetting.TimeSeparator :=':';
       FSetting.DecimalSeparator :='.';
end;

destructor TDataTimeString.Destroy;
begin

  inherited;
end;

function TDataTimeString.DTStrChangeToDateTime(DTS: String): TdateTime;
 var
   d_tmp:TdateTime;
   R_Str:String;
   Year:String;
   Mon,NM:integer;
begin
    Result:=0;
    // 处理月份
    if MonthStart> 0 then   begin
       Mon:=StrToInt(Midstr( DTS,MonthStart,2) );
       NM:=StrToInt(FormatDateTime('MM',Now()));
       if Mon > NM then  begin
          Year:=IntTostr(StrToInt(FormatDateTime('YYYY',Now()))-1);
       end else begin
          Year:='-1';
       end;
    end else begin
      Mon:=0;
    end;
    // 处理年份

    if YearStart>0  then    begin
        R_Str:=Midstr( DTS,YearStart,4);
    end else begin
        if Year='-1' then
            R_Str:=FormatDateTime('YYYY',Now())
        else   R_Str:=Year;
    end;
   // 月份与年份合并
   R_Str:=R_Str+'-'+IntTostr(Mon);
   //处理天
    if DayStart>0  then    begin
        R_Str:= R_Str+'-'+ Midstr( DTS,DayStart,2);
    end else  begin
        exit;
    end;

     //处理小时
    if HourStart>0  then    begin
        R_Str:= R_Str+' '+ Midstr( DTS,HourStart,2);
    end else  begin
        exit;
    end;
       //处理分钟
    if MinStart>0  then    begin
        R_Str:= R_Str+':'+ Midstr( DTS,MinStart,2);
    end else  begin
        exit;
    end;

       //处理秒
    if SecStart>0  then    begin
        R_Str:= R_Str+':'+ Midstr( DTS,SecStart,2);
    end else  begin
        exit;
    end;

    Result:=StrToDateTime(R_Str,FSetting);

end;

function TDataTimeString.isVailDT(DTS: String): Boolean;
begin
    if length(Trim(DTS))= DTLength then  Result :=true
      else Result:=False;
end;

function TDataTimeString.SplitDTString(DTS: String): Boolean;
var
  Startid,Endid:integer;

begin
    DTString:=Uppercase(Trim(DTS));
    DTlength:=length(DTString);
    YearStart:=pos('YYYY', DTString);
    // split year
    if YearStart >0 then   begin
       YearEnd:=YearStart+4;
       if YearEnd< DTlength then
                 YearSplitMonth:=DTString[YearEnd]
          else   YearSplitMonth:=#32;
    end else begin
       YearEnd:=0;
    end;

    // split Month
     MonthStart:=pos('MM', DTString);
     if MonthStart >0 then   begin
       MonthEnd:=MonthStart+2;
       if MonthEnd< DTlength then   MonthSplitDay:=DTString[MonthEnd]
          else  MonthSplitDay:=#32;
    end else begin
       MonthEnd:=0;
    end;

     // split Day
     DayStart:=pos('DD', DTString);
    if DayStart >0 then   begin
       DayEnd:=DayStart+2;
       if DayEnd< DTlength then  DaySplitHour:=DTString[DayEnd]
          else  DaySplitHour:=#32;
    end else begin
       DayEnd:=0;
    end;


     // split Hour
     HourStart:=pos('HH', DTString);
    if HourStart >0 then   begin
       HourEnd:=HourStart+2;
       if HourEnd< DTlength then  HourSplitMIn:=DTString[HourEnd]
          else  HourSplitMIn:=#32;
    end else begin
       HourEnd:=0;
    end;

     // split Min
     MinStart:=pos('NN', DTString);
    if MinStart >0 then   begin
       MinEnd:=MinStart+2;
       if MinEnd< DTlength then  MinSplitSec:=DTString[MinEnd]
          else  MinSplitSec:=#32;
    end else begin
       MinEnd:=0;
    end;

     // split Hour
     SecStart:=pos('SS', DTString);
    if SecStart >0 then   begin
       SecEnd:=SecStart+2;
       if SecEnd< DTlength then  DaySplitHour:=DTString[SecEnd]
          else  DaySplitHour:=#32;
    end else begin
       SecEnd:=0;
    end;

end;

{ TMakeRuleClass }

procedure TMakeRuleClass.AddBasicDataS(Data: TBasicDataParm);
begin
   inc(Basic_DataNumber);
   setlength(BasicDataS,Basic_DataNumber);
   BasicDataS[Basic_DataNumber-1]:=Data;
   //

end;

function TMakeRuleClass.Add_Anal_DataS(data: TInputData):Integer;
begin
   inc(Anal_DataNumber);
   setlength(Anal_DataS,Anal_DataNumber);
   Anal_DataS[Anal_DataNumber-1]:=Data;
   Result:=Anal_DataNumber;
end;

function TMakeRuleClass.AnalySisData(LineStr: String):TInputData;
var
   Lin_s:Str_DT_array;
   C1,i,j:integer;
   Split_Char:Char;
   tmp: TInputData;
begin
   if UpperCase(LineSplitTag)= 'SPACE' then  begin
      Split_Char:=#32;
   end else begin
      Split_Char:= LineSplitTag[1];
   end;

   Lin_s:=Public_Basic.split(LineStr,Split_Char,C1);
   tmp.DataCount :=0;
   tmp.UsedDataType:=MuleData_MAX_AGV;
   for I := 0 to C1-1 do  begin
       // 判断支架编号
       if (Lin_s[i] =  Return_Pro_Flag(SupProRec.TagStr,SupProRec.UpperCase,true)) or
          (Lin_s[i] =  Return_Pro_Flag(SupProRec.TagStr,SupProRec.UpperCase,false))  then
            if i+1<= C1-1 then
              tmp.support :=Public_Basic.StrToInt_lu(Lin_s[i+1]);
        // 判断u时间
       if ( Lin_s[i] =  Return_Pro_Flag(DTProRec.TagStr,DTProRec.UpperCase,true)) or
          ( Lin_s[i] =  Return_Pro_Flag(DTProRec.TagStr,DTProRec.UpperCase,false))  then
            if i+1<= C1-1 then begin
               DataTimeClass.SplitDTString(self.DataTimeStr);
               if DataTimeClass.isVailDT(Lin_s[i+1])  then   tmp.GenerateTime :=DataTimeClass.DTStrChangeToDateTime (Lin_s[i+1])
                     else tmp.GenerateTime :=-1;
            end;
       // 判断移架的前导字符
       if self.MoveSuppFlag  then  begin
            if ( Lin_s[i] =  Return_Pro_Flag(MoveProRec.TagStr,MoveProRec.UpperCase,true)) or
               ( Lin_s[i] =  Return_Pro_Flag(MoveProRec.TagStr,MoveProRec.UpperCase,false))  then
                 if i+1<= C1-1 then begin
                     if ReturnMoveSupportState(MoveSupp_Equal, self.MoveSupp_Value ,
                                      Public_Basic.StrToInt_lu(Lin_s[i+1])  ) then
                          tmp.MoveSupportTag:=true
                     else tmp.MoveSupportTag:=False;

                 end;
       end else begin
           tmp.MoveSupportTag:=False;
       end;
       

       // 判断数据

       for j := 0 to self.Basic_DataNumber -1 do  begin
           if ( Lin_s[i] =  Return_Pro_Flag(BasicDataS[j].TagStr,BasicDataS[j].UpperCase,true)) or
              ( Lin_s[i] =  Return_Pro_Flag(BasicDataS[j].TagStr,BasicDataS[j].UpperCase,false))  then
               if i+1<= C1-1 then begin
                  if Public_Basic.StrToDouble_Lu(Lin_s[i+1]) < 1 then continue;
                  inc(tmp.DataCount);
                  SetLength(tmp.InputDataS ,tmp.DataCount) ;
                  tmp.InputDataS[tmp.DataCount-1 ].TagStr:= BasicDataS[j].TagStr;
                  tmp.InputDataS[tmp.DataCount-1 ].UpperCase:= BasicDataS[j].UpperCase;
                  tmp.InputDataS[tmp.DataCount-1 ].DataUnit:=BasicDataS[j].DataUnit;
                  if Uppercase(tmp.InputDataS[tmp.DataCount-1 ].DataUnit)='BAR' then  begin
                     tmp.InputDataS[tmp.DataCount-1 ].Data :=Public_Basic.StrToDouble_Lu(Lin_s[i+1])/10 ;
                  end else if Uppercase(tmp.InputDataS[tmp.DataCount-1 ].DataUnit)='M' then  begin
                     tmp.InputDataS[tmp.DataCount-1 ].Data :=Public_Basic.StrToDouble_Lu(Lin_s[i+1])*1000 ;
                  end else begin
                     tmp.InputDataS[tmp.DataCount-1 ].Data :=Public_Basic.StrToDouble_Lu(Lin_s[i+1]) ;
                  end;
                  tmp.InputDataS[tmp.DataCount-1 ].DataType :=BasicDataS[j].DataType;
               end;
       end;

   end;
   // 处理一下 使用的数据
   Result:=DisPoseMult_Data(tmp);
end;

procedure TMakeRuleClass.ClearAnal_DataS;
var
  i:integer;
begin
    // 把分析变量情况
   DisPoseCycleDataS.InitBasicV ;
    //把 填充数据 数组清空
   Anal_DataNumber:=0;
   setlength(Anal_DataS,0);
end;

procedure TMakeRuleClass.ClearDataS;
begin

   Basic_DataNumber:=0;
   setlength(BasicDataS,0);
end;


constructor TMakeRuleClass.Create(ADOC: TMySqlConnection);
begin
   MyDataConnect:=ADoc;

   DataTimeClass:=TDataTimeString.Create ;
   Basic_DataNumber:=0;
   Anal_DataNumber:=0;
   WorkFace_id:='-1';
   LastTime:=-1;

   DisPoseCycleDataS:=TDisposeCycleData.Create(MyDataConnect) ;

end;

function TMakeRuleClass.DeepAnalyCycle(Data: TInputData;LastId:integer;
                                      isExsitMoveSupport:Boolean): Boolean;
{
     isExsitMoveSupport  表示数据中是否存在 移架表示信息
                         true  存在  False  不存在
    }
begin

    DisPoseCycleDataS.SetInputDataArrayValue(self.Anal_DataS );
    Result:=DisPoseCycleDataS.Guide_DeepAnaly(LastId,isExsitMoveSupport);
end;


procedure TMakeRuleClass.DeleteBasicDataS(id: integer);
var
  i:integer;
begin
   if id > Basic_DataNumber -1 then    exit;
   for I := id to Basic_DataNumber -2 do  begin
      BasicDataS[i]:=BasicDataS[i+1];

   end;

   Basic_DataNumber:=Basic_DataNumber-1;
   Setlength(BasicDataS,Basic_DataNumber);

end;

procedure TMakeRuleClass.Delete_Anal_DataS(Id: integer);
begin

end;

destructor TMakeRuleClass.Destroy;
var
  i:integer;
begin
  FreeAndNil(DataTimeClass);
  if Assigned(DisPoseCycleDataS ) then
         FreeAndNil(DisPoseCycleDataS);


  inherited;
end;

function TMakeRuleClass.DisPoseMult_Data(tm: TInputData): TInputData;
var
  Data_F,Data_R:double;
  i:integer;
begin
   if tm.UsedDataType=0 then begin   // 最大值
      Data_F:=0; Data_R:=0;
   end else if tm.UsedDataType=1 then begin   // 最小值
      Data_F:=1000; Data_R:=1000;
   end else if tm.UsedDataType=2 then begin   // 平均值
       Data_F:=-1; Data_R:=-1;
   end;



   for I := 0 to tm.DataCount-1 do  begin
       if (tm.InputDataS[i].DataType = FrontPressData ) or (tm.InputDataS[i].DataType= BehindPressData ) then begin
             if (tm.UsedDataType=2) and (Data_F<0) then  Data_F:=tm.InputDataS[i].Data;
             Data_F:=ReturnMin_AGV_Vlaue(tm.UsedDataType,Data_F,tm.InputDataS[i].Data);


       end;

       if (tm.InputDataS[i].DataType = LeftPressData ) or (tm.InputDataS[i].DataType= RightPressData ) then begin
           if (tm.UsedDataType=2) and (Data_R<0) then   Data_R:=tm.InputDataS[i].Data;
            Data_R:=ReturnMin_AGV_Vlaue(tm.UsedDataType,Data_R,tm.InputDataS[i].Data);
       end;


   end;
   if (Data_F >0) and (Data_F < 10000) then  tm.Useddata := Data_F;
   if (Data_R >0) and  (Data_R < 10000) then  tm.Useddata := Data_R;

   if tm.Useddata < 20  then   tm.SupportState:=0
      else tm.SupportState:=1;


   Result:=tm;

end;

procedure TMakeRuleClass.FillDataToStrGrid(ST: TStringGrid);
var
  i:integer;
begin
   for i := 0 to Basic_DataNumber -1 do  begin
      if i+1 >=St.RowCount  then
         St.RowCount := St.RowCount+1;
      ST.Cells[0,i+1]:=IntTostr(i+1);
      ST.Cells[1,i+1]:=BasicDataS[i].DataName ;
      ST.Cells[2,i+1]:=BasicDataS[i].TagStr ;
      ST.Cells[3,i+1]:=BasicDataS[i].DataUnit  ;

      if BasicDataS[i].UpperCase =0 then   begin
         ST.Cells[4,i+1]:='不区分';
      end else  if BasicDataS[i].UpperCase =1 then   begin
         ST.Cells[4,i+1]:='大写';
      end else if BasicDataS[i].UpperCase =2 then   begin
         ST.Cells[4,i+1]:='小写';
      end;

   end;
end;


function TMakeRuleClass.FillSelfClassFromSring(Value: string): Boolean;
var
   S1,S2,S3:Str_DT_array;
   C1,C2,C3,i:integer;
   tmp:TBasicDataParm;
begin
  Result:=False;
  try
       S1:=Public_Basic.split(Value,'^',C1);
       if C1< 1   then exit;
       if S1[0]<> 'R' then  exit;
       S2:=Public_Basic.split(S1[1],';',C2);
       if C2<2 then  exit;
       S3:=Public_Basic.split(S2[0],',',C3);
       if C3<15  then   exit;

        Ruleid:=Public_Basic.StrToInt_lu(S3[0]);    RuleName:=S3[1];       FileSuffix:=S3[2];
        LineSplitTag:=S3[3];   SupProRec.TagStr:=S3[4];       SupProRec.UpperCase:=Public_Basic.StrToInt_lu(S3[5]);
        DTProRec.TagStr:=S3[6];      DTProRec.UpperCase:=Public_Basic.StrToInt_lu(S3[7]);   DataTimeStr:=S3[8];
        if S3[9]='1' then  MoveSuppFlag:=true else MoveSuppFlag:=False;
        MoveProRec.UpperCase:=Public_Basic.StrToInt_lu(S3[10]);

        MoveSupp_Equal:=S3[11];       MoveProRec.TagStr:=S3[12];
        MoveSupp_Value:=Public_Basic.StrToInt_lu(S3[13]);
        MuleData_MAX_AGV:=Public_Basic.StrToInt_lu(S3[14]);
           FileSuffix:=S3[2];
        RuleName:=S3[1];       FileSuffix:=S3[2];    FileSuffix:=S3[2];

        for I := 1 to C2-1 do  begin
             S3:=Public_Basic.split(S2[i],',',C3);
             if C3>5  then   begin
               tmp.DataBh :=Public_Basic.StrToInt_lu(S3[0]) ;
               tmp.DataName :=S3[1];
               tmp.DataType:=TSupportDataType(GetEnumValue(TypeInfo(TSupportDataType),S3[2]));
               tmp.TagStr :=S3[3];
               tmp.UpperCase :=Public_Basic.StrToInt_lu(S3[4]) ;
               tmp.DataUnit:=S3[5];
               AddBasicDataS(tmp);
             end;
        end;
       Result:=true;
  finally

  end;

end;

function TMakeRuleClass.GetLastTime(SupportBh: Integer): TdateTime;
var
  FDataSet:TMyDataSet;
  sql:string;
begin
   Result:=-1;
   FDataSet:=TMyDataSet.Create(nil);
   FDataSet.MySqlConnection:=self.MyDataConnect;
   try
      FDataSet.Close ;
      sql:=' select Max( endtime) as DT from  D_'+WorkFace_id+'_SupportMoveInfo ' +
           ' where Supportbh = ' +IntTostr(Supportbh) + ' and MoveState  >0 ' ;
      FDataSet.CommandText :=sql;
      if FDataSet.Open   then
         Result:= FDataSet.FieldByName('DT').AsDateTime ;

   finally
      FDataSet.Close ;
      FreeAndNil(FDataSet);
   end;

end;

function TMakeRuleClass.LoadDataFromFlie(var ReadClass:TReadRecord;FileName: string;
                      BasicSupport:integer): integer;
var
  Lins:TStringList;
  arquivo: TextFile;
  I,LastId:integer;
  s_Ln:String;
  tmp:TInputData;
  SupportBh:integer;
  Dist:Double;
begin
   REsult:=0;
   Lins:=TStringList.Create ;
   AssignFile(arquivo,FileName);//frmAnalise.dialogAbrir.FileName);
   Reset(arquivo);
   while not Eof(arquivo) do  begin
    Readln(arquivo,s_Ln);
    Lins.Add(s_Ln);
  end;

  CloseFile(arquivo);
  SupportBh:=-1;

   for I := 0 to Lins.Count -1 do  begin
      if ReadClass.CloseThread then  break;

      ReadClass.Processing:= i/  Lins.Count *100;
       // 分析这一行的数据
      tmp:=AnalySisData(Lins[i]) ;

      // 说明该分析数据无意义
      if tmp.DataCount <1 then  continue;
      // 判断 支架编号
      if SupportBh <> tmp.support  then begin
         Supportbh:=tmp.support;
         LastTime:=self.GetLastTime(Supportbh);
         DisPoseCycleDataS.BasicJindao.ItemIndex:=0;
      end;
      // 如果数据库存储的时间大于该时间 继续进行
      if LastTime >= tmp.GenerateTime  then  continue;

       //  把这一行的数据追加到 类中
      LastId:=Add_Anal_DataS(tmp);
       // 判断基本支架数目是否加载
      if BasicSupport >0 then begin // 不是 基本进刀判断状态
        if Anal_DataNumber=1  then
           if (DisPoseCycleDataS.BasicJindao.StartTime > tmp.GenerateTime  ) or
              (DisPoseCycleDataS.BasicJindao.StartTime <0 ) then   begin
              DisPoseCycleDataS.BasicJindao.StartTime :=tmp.GenerateTime ;
              DisPoseCycleDataS.MakeJinDaoBasic(BasicSupport);
           end;
        DisPoseCycleDataS.BasicJindao.BasciState :=false;
        //找到当前时刻的数值
        if Anal_DataNumber >1 then
           SelectDataRelySameTime(Anal_DataNumber-1,SupportBh);
      end else begin // 是第一个基本进刀判断状态
        DisPoseCycleDataS.BasicJindao.BasciState :=true;
      end;


      // 深入分析这一行的数据
      if self.MoveSuppFlag then  begin
          {有移架标记}
          DeepAnalyCycle(tmp,LastId-1,true);
      end else begin
          {没有移架标记}
          DeepAnalyCycle(tmp,LastId-1,false);
      end;

   end;
   // 把数组的数据保存到数据文件中
   SaveInputDataToFile(StrToInt(WorkFace_id),SupportBh);
   Result:=Lins.Count;
end;


function TMakeRuleClass.MakeString: String;
var
  StrOut:string;
  i:Integer;
begin
   StrOut:='R^';
   if Ruleid< 1 then   begin
      Result:='';
      exit;
   end;
   StrOut:=StrOut+IntTostr(Ruleid) +','   +  RuleName   + ',' +
           FileSuffix +',' + LineSplitTag +',' + SupProRec.TagStr  +',' +
           IntTostr(SupProRec.UpperCase)+','+ DTProRec.TagStr +',' +
           IntTostr(DTProRec.UpperCase) +','  +   DataTimeStr +',' ;
   if MoveSuppFlag then  begin
      StrOut:=StrOut+'1'+',' ;
   end else begin
      StrOut:=StrOut+'0'+',' ;

   end;
   StrOut:=StrOut + IntToStr(MoveProRec.UpperCase) + ',' +
            MoveSupp_Equal+','+ MoveProRec.TagStr+',' +IntTostr(MoveSupp_Value)+',' +
            IntTostr(MuleData_MAX_AGV)+';';
   for I := 0 to Basic_DataNumber-1 do  begin
     StrOut:=StrOut + IntToStr(BasicDataS[i].DataBh)+','  +
             BasicDataS[i].DataName+','+
             GetEnumName(TypeInfo(TSupportDataType),ord( BasicDataS[i].DataType )) +','  +
             BasicDataS[i].TagStr+','+IntTostr(BasicDataS[i].UpperCase )+ ',' +
             BasicDataS[i].DataUnit+';'
   end;

   Result:= StrOut;

end;

function TMakeRuleClass.ReturnMin_AGV_Vlaue(id: integer; D1,
  D2: Double): Double;
  { 0 最大值  1 最小值 2  平均值}
begin
    if id=0 then  begin
        if D1>D2 then  Result:=D1 else Result:=D2;

    end else if id=1  then  begin
        if D1>D2 then  Result:=D2 else Result:=D1;
    end else if id =2 then  begin
        Result:=(D1+D2)/2;
    end;

end;

function TMakeRuleClass.ReturnMoveSupportState(Equal: string; C0,
  C1: Integer): Boolean;
begin
   Result:=False;
   if Equal ='=' then begin
      if C1=C0 then  Result:=true;

   end else if Equal= '>' then  begin
      if C1>C0 then  Result:=true;

   end else if Equal ='<' then  begin
       if C1<C0 then  Result:=true;
   end;

end;

function TMakeRuleClass.Return_Pro_Flag(Flag:string;id:Integer;U_L:Boolean): String;
{
  U_L true  返回大写  false 返回小写
  Falg 需要处理的字符串
  id  是否区分大写写

}
begin
   if id=2 then
        Result :=LowerCase(Flag);
   if id=1 then  Result :=Uppercase(Flag);
   if id=0 then
       if U_L then  Result :=Uppercase(Flag)
       else Result :=LowerCase(Flag);

end;


function TMakeRuleClass.SaveInputDataToFile(WorkFace_id, SupportBh: integer ): Boolean;
var
  fileName,textString:Ansistring;
  DirName:Ansistring;
  hFile,logFile:integer;
  Dll_Path:AnsiString;
  i:integer;
  PrevData:TInputData;
  RaiseOrDrop,tmB:integer;
  BreakData:Boolean;
begin
   Dll_Path:=Public_Basic.Get_MyModulePath;
   DirName:=DLL_path+'\InputData\WorkDace_'+IntTostr(WorkFace_id)+'\';
    if not DirectoryExists(DirName) then begin
       ForceDirectories(DirName);
    end;
   fileName:=IntToStr(SupportBh) +'.Out';
   fileName:=DirName+fileName;
   if not(FileExists(fileName)) then begin
       hFile:=FileCreate(fileName,fmOutput);
       FileClose(hFile);
   end;
   logFile:=FileOpen(filename,fmOpenwrite or fmShareDenyWrite);
   FileSeek(logfile,0,2);
   RaiseOrDrop:=0; TmB:=0;
    for I := 0 to Anal_DataNumber-1 do   begin
      if i> 0 then
         //数据断掉 不正常   如果大于5分钟没有数据
        if Anal_DataS[i].GenerateTime -Anal_DataS[i-1].GenerateTime > 1/24/12  then   begin
           // 前面添加一个点
           textString:=Ansistring(FormatDateTime('yyyy-mm-dd HH:NN:SS',Anal_DataS[i-1].GenerateTime)) +',' +
                     Ansistring(FormatFloat('0.00', Anal_DataS[i-1].Useddata)) +',1'+ #13 +#10 ;
           fileWrite(logFile,Pwidechar(textString)^,length(textString));

           textString:=Ansistring(FormatDateTime('yyyy-mm-dd HH:NN:SS',Anal_DataS[i-1].GenerateTime)) +',' +
                     Ansistring(FormatFloat('0.00', -1)) +',-1'+ #13 +#10 ;
           fileWrite(logFile,Pwidechar(textString)^,length(textString));
           // 后面添加一个点
           textString:=Ansistring(FormatDateTime('yyyy-mm-dd HH:NN:SS',Anal_DataS[i].GenerateTime)) +',' +
                     Ansistring(FormatFloat('0.00', -1)) +',-1'+ #13 +#10 ;
           fileWrite(logFile,Pwidechar(textString)^,length(textString));

           textString:=Ansistring(FormatDateTime('yyyy-mm-dd HH:NN:SS',Anal_DataS[i].GenerateTime)) +',' +
                      Ansistring(FormatFloat('0.00', Anal_DataS[i].Useddata)) +',1'+ #13 +#10 ;
           fileWrite(logFile,Pwidechar(textString)^,length(textString));

           PrevData:=Anal_DataS[i];
           BreakData:=True;
        end else begin
           BreakData:=False;
        end;


         if (Abs(Anal_DataS[i].Useddata-PrevData.Useddata )/PrevData.Useddata* 100)< 10 then begin
            if Anal_DataS[i].Useddata  <20 then  continue;
            if Anal_DataS[i].Useddata >= Anal_DataS[i-1].Useddata *1.01 then  begin
               tmB:=1 ;
            end  else if Anal_DataS[i].Useddata <= Anal_DataS[i-1].Useddata *0.99 then  begin
               tmB:=-1 ;
            end else begin
               tmB:=0;
            end;
            if RaiseOrDrop = tmB then  continue;
         end else if Anal_DataS[i].Useddata> PrevData.Useddata then begin
             tmB:=1;
         end else begin
             tmB:=-1;
         end;

      RaiseOrDrop:=TmB;
      if i>0 then   begin
          {如果保存的数据间隔大于1分钟，并且数据没有中断5 分钟，首先补上前面一个点的数据}
          if (Anal_DataS[i].GenerateTime -PrevData.GenerateTime > 1/24/60) and (not BreakData )  then   begin
             textString:=Ansistring(FormatDateTime('yyyy-mm-dd HH:NN:SS',Anal_DataS[i-1].GenerateTime)) +',' +
                     Ansistring(FormatFloat('0.00', Anal_DataS[i-1].Useddata))+ ',1'+#13 +#10 ;
            PrevData:=Anal_DataS[i-1];
            fileWrite(logFile,Pwidechar(textString)^,length(textString));
          end;
      end;
      PrevData:=Anal_DataS[i];
      textString:=Ansistring(FormatDateTime('yyyy-mm-dd HH:NN:SS',PrevData.GenerateTime)) +',' +
               Ansistring(FormatFloat('0.00', PrevData.Useddata))+ ',1'+ #13 +#10 ;
      fileWrite(logFile,Pwidechar(textString)^,length(textString));
   end;

   fileclose(logfile);

end;

function TMakeRuleClass.SelectDataRelySameTime(Cuur_id,Curr_sup: integer): Boolean;
var
  i:integer;
begin
 Result:=False;
  DisPoseCycleDataS.BasicJindao.CurrSupport :=Curr_sup;
  if Cuur_id =0 then begin  // 查看第一个位置
    for I := DisPoseCycleDataS.BasicJindao.ItemIndex to DisPoseCycleDataS.BasicJindao.Count -1 do
        if DisPoseCycleDataS.BasicJindao.ArrayBasicJinDao[i].ShotTime >=Anal_DataS[0].GenerateTime then begin
           DisPoseCycleDataS.BasicJindao.ItemIndex:=i;
           DisPoseCycleDataS.BasicJindao.CurrDataValue:=Anal_DataS[0].Useddata;
           break;
        end;
  end else begin
     if (DisPoseCycleDataS.BasicJindao.Count >0) and(Cuur_id >1) then
     if (DisPoseCycleDataS.BasicJindao.ArrayBasicJinDao[DisPoseCycleDataS.BasicJindao.ItemIndex].ShotTime >=Anal_DataS[Cuur_id-1].GenerateTime ) and
        (DisPoseCycleDataS.BasicJindao.ArrayBasicJinDao[DisPoseCycleDataS.BasicJindao.ItemIndex].ShotTime <=Anal_DataS[Cuur_id].GenerateTime )  then begin
            DisPoseCycleDataS.BasicJindao.CurrDataValue:=Anal_DataS[Cuur_id].Useddata;
            if DisPoseCycleDataS.BasicJindao.ItemIndex<DisPoseCycleDataS.BasicJindao.Count then
               inc(DisPoseCycleDataS.BasicJindao.ItemIndex);
      end;
  end;
 Result:=true;
end;

procedure TMakeRuleClass.SetUsed_WorkFaceId(Value: string);
begin
    WorkFace_id:=Value;
    DisPoseCycleDataS.Set_WorkFaceId(Value);
end;

{ TDisposeData }



function TDisposeCycleData.Cal_Variance(var tpCal: TFirstData):Boolean;
{
  计算数据的标准差与均值
  }
var
 i:integer;
 AGV_Data,Variance:Double;
 ArryCount,tm_Dif,Fiv_Min_Count:Integer;
 ProDate:TdateTime;
begin
     Variance:=0; AGV_Data:=0;
     Result:=False;
     if Phase_Ed_id-  Phase_St_id < 5 then  exit;
     ArryCount:=0;
     ProDate:=tmp_Use_InputData[Phase_St_id].GenerateTime;
     AGV_Data:=tmp_Use_InputData[Phase_St_id].Useddata;
       // 计算数据频度
     Data_Frequency.InitArrayChild ;
     Data_Frequency.AddOneData(tmp_Use_InputData[Phase_St_id].Useddata,1);

     for I := Phase_St_id+1 to Phase_Ed_id do  begin
        tm_Dif:=self.ReturnTwoDateTimeDiff(ProDate,tmp_Use_InputData[i].GenerateTime) ;
        if (tm_Dif>0)  then  begin
            AGV_Data:=AGV_Data + tmp_Use_InputData[i].Useddata*tm_Dif;
            ArryCount:=ArryCount+tm_Dif;
            Data_Frequency.AddOneData(tmp_Use_InputData[i].Useddata,tm_Dif);
        end;
        ProDate:=tmp_Use_InputData[i].GenerateTime;

     end;

     if ArryCount>0 then
         AGV_Data:=AGV_Data/ArryCount ;

     for I := Phase_St_id to Phase_Ed_id do
         Variance:=Variance+sqr(tmp_Use_InputData[i].Useddata-AGV_Data);
     Variance:=Variance/(Phase_Ed_id-Phase_St_id +1);

     //把数值返回
     tpCal.dAvgValue :=AGV_Data;
     tpCal.dTotalGradient:=sqrt(Variance);

     Result:=true;
end;

function TDisposeCycleData.ChangeSupportDataTypeToInteger(
  Value: string): Integer;
begin
   Result:=GetEnumValue(TypeInfo(TSupportDataType),Value);
end;

function TDisposeCycleData.ChangeSuppotDataTypeToString(
  Value: TSupportDataType): String;
begin
    Result:= GetEnumName(TypeInfo(TSupportDataType),ord(Value ));
end;

function TDisposeCycleData.ChangeSuppotDataTypeToString(Value: Integer): String;
begin
   Result:= GetEnumName(TypeInfo(TSupportDataType),ord(Value ));
end;

procedure TDisposeCycleData.ClearFirstData(var tm: TFirstData);
begin
   tm.isRecord :=False;
   tm.dMaxValuetime :=-1;
   tm.dMaxValue :=0;
   tm.dMinValue :=1000;
   tm.dAvgValue :=0;
   tm.dFirstValue :=0;
   tm.dFirstValueTime :=-1;
   tm.dMinValuetime :=-1;
   tm.dPointNumber :=0;
   tm.dDiffPercent :=0;
   tm.dMovesuppport :=false;
   tm.dInterVal :=0;
   tm.dTotalGradient :=0;
   tm.dStartPressure :=0;
   tm.dMoveEndTime :=-1;
   tm.dMoveStartTime :=-1;
   tm.dZhuYeTimes :=0;
   tm.dzhuyeEndTime :=-1;
   tm.dzhuYeValue :=0;
   tm.dZhuyeHuZhuanTimes :=0;
   tm.dZhuYeHuzhuanGradient :=0;
   tm.dBeforeLastValue :=0;
   tm.dBeforeLastValueTime :=-1;
   tm.dbeforeLastMaxValue :=0;
   tm.dBeforeLastMaxValueTime :=-1;
   tm.dbeforeLastTimes :=0;
   tm.dStartTime :=-1;


end;

constructor TDisposeCycleData.Create(ADOConn:TMySqlConnection);
begin
    InitBasicV;
    MyDataConnect:=ADOConn;
    WorkFace_id:='-1';

    MyDataSet:=TMyDataSet.Create(nil);
    MyDataSet.MySqlConnection := ADOConn;
    MyCommand:=TMyCommand.Create(nil);
    MyCommand.MySqlConnection :=ADOConn;
    BasicJindao:=TBasicJinDao.Create;
    Data_Frequency:=TDataFrequency.Create;
end;

destructor TDisposeCycleData.Destroy;
begin
  FreeAndNil(MyDataSet);
  FreeAndNil(MyCommand);

  if Assigned(BasicJindao) then
         FreeANDnIL(BasicJindao);
  if Assigned(Data_Frequency) then
         FreeANDnIL(Data_Frequency);
  inherited;
end;

function TDisposeCycleData.FillProCycle(var tm: TFirstData): Boolean;
begin

end;

function TDisposeCycleData.GetAGVValue( Stid, Enid: integer;
                 Var tmp:TFirstData): Double;
var
  i,j,A_Count:integer;
  AGV_Value:Double;
begin
     AGV_Value :=0; A_Count:=0;
     for I := Stid to Enid do
        for j := 0 to tmp_Use_InputData[i].DataCount -1 do  begin
            AGV_Value:= AGV_Value+ tmp_Use_InputData[i].Useddata;
            inc(A_Count);
        end;

     if A_Count>0  then  begin
           Result:=AGV_Value/A_Count  ;
           tmp.dAvgValue:= AGV_Value/A_Count;
     end   else  begin
           Result:=AGV_Value;
           tmp.dAvgValue:= AGV_Value;
     end;

end;

function TDisposeCycleData.GetFGzmEndSupNumber(WorkFace_id: String): Integer;
var
 sql:string;
begin
   Result:=200;
   sql:='select * from cqcsb where cqID='+WorkFace_id;
   MyDataSet.Close ;
   try
       MyDataSet.CommandText :=sql;
       MyDataSet.Open ;
       if MyDataSet.RecordCount >0 then   begin
          Result:=MyDataSet.FieldByName('SupEndNumber').AsInteger;
       end;

   finally
      MyDataSet.Close;
   end;

end;

function TDisposeCycleData.GetJinDaoBasicSupport: String;
begin
   Result:= IntTostr(MyWokFace_Info.JinDao_Support);
end;

function TDisposeCycleData.GetLastTime(SupportBh: Integer): TdateTime;
var
  sql:string;
begin
   Result:=-1;

   try
      MyDataSet.Close ;
      sql:=' select Max( endtime) as DT from  D_'+WorkFace_id+'_SupportMoveInfo ' +
           ' where Supportbh = ' +IntTostr(Supportbh) + ' and MoveState  >0 ' ;
      MyDataSet.CommandText :=sql;
      if MyDataSet.Open   then
         Result:= MyDataSet.FieldByName('DT').AsDateTime ;

   finally
      MyDataSet.Close ;
   end;

end;

function TDisposeCycleData.GetMaxValue(Stid, EnId: integer;
                        Var tmp:TFirstData): Double;
var
  i,j:integer;
  Max_Value:Double;
  Max_dt:TdateTime;
begin
     Max_Value :=0;
     for I := Stid to Enid do
        for j := 0 to tmp_Use_InputData[i].DataCount -1 do
          if tmp_Use_InputData[i].InputDataS[j].DataType = BasicData.DataType then
              if tmp_Use_InputData[i].Useddata >  Max_Value then  begin
                  Max_Value:= tmp_Use_InputData[i].Useddata;
                  Max_dt:=tmp_Use_InputData[i].GenerateTime;
              end;
     if tmp.dMaxValue  < Max_Value then begin
         tmp.dMaxValue := Max_Value;
         tmp.dMaxValuetime:=Max_dt;
     end;
     Result:=Max_Value;

end;

function TDisposeCycleData.GetMaxValueFromUsedData(Stid, EnId: integer;
  var tmp: TFirstData): Double;
var
  i,j:integer;
  Max_Value:Double;
  Max_dt:TdateTime;
begin
     Max_Value :=0;
     for I := Stid to Enid do
         if tmp_Use_InputData[i].Useddata >  Max_Value then  begin
             Max_Value:= tmp_Use_InputData[i].Useddata;
             Max_dt:=tmp_Use_InputData[i].GenerateTime;
         end;
     if tmp.dMaxValue  < Max_Value then begin
         tmp.dMaxValue := Max_Value;
         tmp.dMaxValuetime:=Max_dt;
     end;
     Result:=Max_Value;
end;

function TDisposeCycleData.GetMinValue( Stid, Enid: integer;
                          Var tmp:TFirstData): Double;
var
  i,j:integer;
  Min_Value:Double;
  Min_dt:TDateTime;
begin
     Min_Value :=10000;
     for I := Stid to Enid do
        for j := 0 to tmp_Use_InputData[i].DataCount -1 do
              if tmp_Use_InputData[i].Useddata <  Min_Value then  begin
                  Min_Value:= tmp_Use_InputData[i].Useddata;
                  Min_dt:=tmp_Use_InputData[i].GenerateTime;
              end;
     if  tmp.dMinValue > Min_Value then begin
        tmp.dMinValue := Min_Value ;
        tmp.dMinValuetime:=Min_dt;
     end;
     Result:=Min_Value;
end;

function TDisposeCycleData.GetMinValueFromUsedData(Stid, EnId: integer;
  var tmp: TFirstData): Double;
var
  i,j:integer;
  Min_Value:Double;
  Min_dt:TDateTime;
begin
     Min_Value :=10000;
     for I := Stid to Enid do
         if tmp_Use_InputData[i].Useddata <  Min_Value then  begin
            Min_Value:= tmp_Use_InputData[i].Useddata;
            Min_dt:=tmp_Use_InputData[i].GenerateTime;
            tmp.dMinValuetime:=Min_dt;
         end;
     if  tmp.dMinValue > Min_Value then begin
        tmp.dMinValue := Min_Value ;
        tmp.dMinValuetime:=Min_dt;
     end;
     Result:=Min_Value;

end;

function TDisposeCycleData.GetMultDataType(id: Integer): string;
begin
    if id=0 then  begin
      Result:='Max_Value';
    end else if id=1 then  begin
      Result:='Min_Value';

    end else begin
      Result:='AGV_Value';
    end;

end;

function TDisposeCycleData.Guide_DeepAnaly(Curr_id:integer;isExsitMoveSupport:Boolean): Boolean;
{
     isExsitMoveSupport  表示数据中是否存在 移架表示信息
                         true  存在  False  不存在
    }
var
  Resu:Integer;
begin
    Result:=False;
    if Phase_St_id<0 then begin
       Phase_St_id:= Curr_id;
       SupportBh:=tmp_Use_InputData[Phase_St_id].support ;
    end;

    if Min_ST_id <0 then
       Min_ST_id:=Curr_id;
    // 如果支架编号不一致 不作为 判定的依据
    if SupportBh <> tmp_Use_InputData[Curr_id].support then   exit;
    Phase_Ed_id:= Curr_id;
    Min_ED_id:= Curr_id;


    if isExsitMoveSupport then   begin
        if tmp_Use_InputData[Curr_id].MoveSupportTag then begin
           {// 如果找到移架标志信息}
           //查找初撑力与末阻力
           if not SelectCClAndMzl(tmp_Cal)  then exit;
           // 计算数据标准方差
           if not Cal_Variance(tmp_Cal)  then exit;
           // 标注其他数据 并保存数据
           Tag_MoveSupport;
        end else begin
           {现在还没有找到移架标志信息}
           exit;
        end;
    end else begin
       { 数据中没有移架标志信息的处理方式
       }
      Resu:= NoExsitMoveSupportInfor(Curr_id);
       if Resu =1 then begin
           //查找初撑力与末阻力
           if not SelectCClAndMzl(tmp_Cal)  then exit;
           // 计算数据标准方差
           if not Cal_Variance(tmp_Cal)  then exit;
           // 标注其他数据 并保存数据
           Tag_MoveSupport;
       end else if Resu=0 then  begin
          if Curr_id >1 then  begin
             tmp_Use_InputData[Curr_id].MoveSupportTag:=  tmp_Use_InputData[Curr_id-1].MoveSupportTag ;
          end else begin
             if tmp_Use_InputData[Curr_id].Useddata <15  then
                tmp_Use_InputData[Curr_id].MoveSupportTag:=true;
          end;
       end;

    end;

   Result:=true;
end;

procedure TDisposeCycleData.InitBasicV;
begin
    Supportbh:=-1;
    Phase_St_id:=-1;
    Phase_Ed_id:=-1;
    Min_ST_id:=-1;
    Min_ED_id:=-1;
    ClearFirstData(tmp_Cal);
end;

function TDisposeCycleData.ReadWorkFaceInforMation: Boolean;
begin
   Result:=splitFootStepParameters ;
end;

function TDisposeCycleData.ReadWorkFaceJinDaoInformation(WorkFace_id: String):string;
var
 sql:string;
begin
   Result:='';
   sql:='select * from cqcsb where cqID='+WorkFace_id;
   MyDataSet.Close ;
   try
       MyDataSet.CommandText :=sql;
       MyDataSet.Open ;
       if MyDataSet.RecordCount >0 then   begin
          Result:=MyDataSet.FieldByName('Memo1').AsString;
       end;

   finally
      MyDataSet.Close;
   end;
end;

function TDisposeCycleData.Judge_MoveSupport(Currid: integer;
    var tmp: TFirstData): Boolean;
var
  i,K:integer;
  Diffence:double;
  Line_TrunS:integer;// 曲线转换次数
  RaiseOrDrop:Boolean;
  Raise_Count,Drop_Count:integer; //曲线上升次数与 下降次数
  isFinded_CCl,isFind_BeforeMove,IsFind_Mzl:Boolean;
  StbleCount:integer; //曲线平稳次数
begin
   Result:=False;
   K:=0; Line_TrunS:=0;
   Raise_Count:=0;Drop_Count:=0; RaiseOrDrop:=False;
   isFinded_CCl:=False;isFind_BeforeMove:=False;IsFind_Mzl:=False;
   StbleCount:=0;
    for k := 0 Downto 29 do   begin
        i:=Currid-k;
        if i-i < Phase_St_id  then   break;
        if tmp_Use_InputData[i].Useddata<10 then   continue;

        Diffence:=(tmp_Use_InputData[i].Useddata-tmp_Use_InputData[i-1].Useddata )/
                       tmp_Use_InputData[i].Useddata *100;
        // 判断第一个点，如果当前是下降的曲线 继续向后寻找
        if Diffence < 1 then begin
            exit;
        end else begin
            RaiseOrDrop:=true; //曲线在上升
            inc(Raise_Count);
            //把该点作为初撑力
            tmp.dStartPressure:=tmp_Use_InputData[i].Useddata;
            tmp.dzhuyeEndTime :=tmp_Use_InputData[i].GenerateTime;
            continue;
        end;
        // 如果 前一个在上升 ，当前的数值小于 0 证明曲线在下降
        if  (Diffence < -1 ) and (RaiseOrDrop) and (not isFinded_CCl ) then begin
            RaiseOrDrop:=false ;
            inC(Line_TrunS) ;
            StbleCount:=0;
            inc(Drop_Count);
            //该处有可能是 初撑力 ,也可能是 支架泄压的最小值
            if Raise_Count >=3 then  begin  // 我要找三次平稳后的数据
                if tmp.dMinValuetime <  tmp_Use_InputData[i].GenerateTime then   begin
                    tmp.dStartPressure:=tmp_Use_InputData[i].Useddata;
                    tmp.dzhuyeEndTime :=tmp_Use_InputData[i].GenerateTime;
                    isFinded_CCl:=true;
                end else begin
                    isFinded_CCl:=true;
                end;                
            end else begin
               exit;
            end; 

           continue;
        end;
        // 曲线已经翻转一次。目前曲线在下降，即将转为上升 证明 该处是 注液结束点或者 是
        // 末阻力（液压支架移架之前的点）
        if (Line_TrunS >1 ) and ( not RaiseOrDrop) and (Diffence  > 0) and (isFinded_CCl) then  begin
            RaiseOrDrop:=true;
            inC(Line_TrunS) ;
            StbleCount:=0;
            // 如果此处是最大值的点 证明该处是 液压支架移架前的点
            if abs(tmp.dMaxValue-tmp_Use_InputData[i].Useddata)/tmp.dMaxValue *100 <1 then   begin
               tmp.dbeforeLastMaxValue:=tmp_Use_InputData[i].Useddata;
               tmp.dBeforeLastMaxValueTime:=tmp_Use_InputData[i].GenerateTime;
               isFind_BeforeMove:=True;
            end else begin
               if tmp.dMinValuetime < tmp_Use_InputData[i].GenerateTime  then  begin
                  {如果最小值在 该拐点的前面 证明 该处是 初撑力}
                  tmp.dStartPressure:=tmp_Use_InputData[i].Useddata;
                  tmp.dzhuyeEndTime :=tmp_Use_InputData[i].GenerateTime;
               end else begin
                  tmp.dbeforeLastMaxValue:=tmp_Use_InputData[i].Useddata;
                  tmp.dBeforeLastMaxValueTime:=tmp_Use_InputData[i].GenerateTime;
                  isFind_BeforeMove:=True;
               end;

            end;
           continue;
        end;
        // 满足退出条件之一
        // 曲线在上升期 出现了 BeforeMove, 目前出现压力平稳期
        if (Line_TrunS >0) and (ABS(Diffence) <= 1) and (RaiseOrDrop )  and (isFind_BeforeMove )then  begin
            inc(StbleCount);
            if StbleCount >= 3 then  begin
                tmp.dBeforeLastValue:=tmp_Use_InputData[i].Useddata;
                tmp.dBeforeLastValueTime:=tmp_Use_InputData[i].GenerateTime;
                IsFind_Mzl:=true;  break;
            end;
        end;
        // 满足退出条件之二
        // 曲线在 下降期，一致没有出现压力的明显翻转，没有找到 BeforeMove
        if (Line_TrunS >0) and (ABS(Diffence) <=1) and (not RaiseOrDrop )  and ( not isFind_BeforeMove )then  begin
            inc(StbleCount);
            if StbleCount >=5 then  begin
                tmp.dBeforeLastValue:=tmp_Use_InputData[i].Useddata;
                tmp.dBeforeLastValueTime:=tmp_Use_InputData[i].GenerateTime;
                IsFind_Mzl:=true;  break;
            end;
        end;

    end;

    if (isFinded_CCl) and (IsFind_Mzl) then
        Result:=true;

end;

function TDisposeCycleData.MakeJinDaoBasic(Support: integer): Boolean;
Var
  Sql:string;
  jinDao_Basic:TJinDaoRecord;
  FDataSet:TMyDataSet;
  Strdt:string;
begin
   Result:=False;
   FDataSet:=TMyDataSet.Create(nil);
   FDataSet.MySqlConnection:=self.MyDataConnect;
   Strdt:=Public_Basic.ReturnDateTimeString(MainDataModule.DataType ,BasicJindao.StartTime);
   //
   BasicJindao.BasicSupport :=Support;
   BasicJindao.ClearArray ;
   //
   Sql:=' select * from  D_'+WorkFace_id+'_SupportMoveInfo ' +
        ' where supportbh =' + IntTostr(Support) + ' and  EndTime >= ' + Strdt ;
   try
      FDataSet.Close ;
      FDataSet.CommandText :=sql;
      if FDataSet.Open  then
      while not FDataSet.Eof  do  begin
         if MyWokFace_Info.JinDao_Time=0 then  begin // 末阻力
            jinDao_Basic.ShotTime := FDataSet.FieldByName('BefortMovetime').AsDateTime;
         end else if  MyWokFace_Info.JinDao_Time=1 then begin // 初撑力
            jinDao_Basic.ShotTime := FDataSet.FieldByName('ZhuYeEndTime').AsDateTime;
         end else begin // 最大值
            jinDao_Basic.ShotTime := FDataSet.FieldByName('MaxValueTime').AsDateTime;
         end;
         BasicJindao.Add(jinDao_Basic);
         FDataSet.Next ;
      end;
      Result:=true;
   finally
     FDataSet.Close ;
     FreeAndNil(FDataSet);
   end;

end;

function TDisposeCycleData.NoExsitMoveSupportInfor(Curr_id:integer): integer;
var
  i:Integer;
  Max_Data,Min_Data,diffience:double;
begin
    Result:=0;
    if Curr_id >0  then  begin
        tmp_Use_InputData[Curr_id].MoveSupportTag:=tmp_Use_InputData[Curr_id-1].MoveSupportTag
    end else begin
        tmp_Use_InputData[Curr_id].MoveSupportTag:= False;
    end;


     //如果只有只一个数 无法判断
    if Min_ST_id = Min_ED_id then  exit;
    // 如果当前值 很小 退出
    if Curr_id <1 then  exit;

    // 把时间限定在五分钟之内
    while (tmp_Use_InputData[Min_Ed_id].GenerateTime - tmp_Use_InputData[Min_ST_id].GenerateTime > 1/24/12  ) do begin
        if Min_ST_id >=Min_ED_id then   break;
        inc(Min_ST_id);
    end;

    Max_Data:=GetMaxValueFromUsedData(Min_ST_id,Min_ED_id,tmp_Cal);
    Min_Data:=GetMinValueFromUsedData(Min_ST_id,Min_ED_id,tmp_Cal);

    // 计算数据分散数值
    if Max_Data >0  then  begin
       diffience:=(Max_Data-Min_Data)/Max_Data*100;
    end else begin
       exit;
    end;
   
    {考虑到时定时采集数字，所以把判断 移架标志的底线定的低一点}
    if Abs(diffience)  > 50 then  begin
       diffience:=(tmp_Use_InputData[Curr_id].Useddata -tmp_Use_InputData[Curr_id-1].Useddata)/
                  tmp_Use_InputData[Curr_id-1].Useddata *100;
       if diffience < -20 then  begin
          // 如果最大值的时间 在后面   不符合移架要求
          if tmp_Cal.dMaxValuetime > tmp_Cal.dMinValuetime then  exit;
          if tmp_Cal.dMaxValue < 20 then  exit;

          tmp_Use_InputData[Curr_id].MoveSupportTag:=true;
          Result:=1;
       end else  if (diffience  > 20)   then  begin
          tmp_Use_InputData[Curr_id].MoveSupportTag:=False;
          Result:=2;
       end;
    end;



//       if Judge_MoveSupport(curr_id,tmp_Cal) then begin
//          Result:=true;
//       end;

end;

function TDisposeCycleData.ReturnTwoDateTimeDiff(D1, D2: TdateTime): Integer;
var
  D_Value:Integer;
  D_Diff:Double;
begin
    D_Diff:=D2-D1;
    //if D_Diff >1/24 then  D_Diff:=-1;
    D_Value:=Round(D_Diff*24*60*60);
    if D_Value >0 then Result:=D_Value else Result:=0;

end;

function TDisposeCycleData.SaveSupportMoveData(table_b: string;
  supportbh: integer; ValueType: string; GeTime: Tdatetime;
  dp: TFirstData): Boolean;
var
  sql:string;
  {
    用 AGVData 字段 保存数据的平均值
       SupportStartPress 初撑力
       ZhuYeEndTime 初撑力形成时间
       BeforeMoveValue 末阻力
       BeforeMoveMaxValue 移架的 异动 最大值
       zhuyeReturnGrad 注意 回转的梯度

  }
begin
   sql:='insert into D_'+table_b+'_SupportMoveInfo (generatetime,Valuetype,supportbh, Starttime,EndTime, startValue,EndValue, ' +
            ' Max_Value,Min_Value,Max_Valuetime,Min_valueTime, AGVDAta ,SupportStartPress,ZhuYeEndTime, ' +
            ' BeforeMoveValue,BeforeMoveMaxValue ,BefortMovetime,BeforeMoveMaxTime,zhuyeReturnGrad,DataVarience,SameTimeValue, '+
            ' MoveState,Memo1,Process ) Values ( ' +

             ''''+ FormatDateTime( 'yyyy-mm-dd hh:nn:ss',GeTime)+''',''' + ValueType +''',' +  //GenerateTime ,Valuetype
             IntToStr(supportbh)+','''+FormatDateTime( 'yyyy-mm-dd hh:nn:ss',dp.dStartTime)+ ''',' +  // supportbh,Starttime
             ''''+ FormatDateTime( 'yyyy-mm-dd hh:nn:ss',dp.dEndTime)+''',' +   //  EndTime
             FormatFloat('0.00',dp.dStartValue) +',' +FormatFloat('0.00',dp.dEndValue) +',' + // startValue,EndValue,'
             FormatFloat('0.00',dp.dMaxValue) +',' +FormatFloat('0.00',dp.dMinValue) +',' + // Max_Value,Min_Value,'
             ''''+ FormatDateTime( 'yyyy-mm-dd hh:nn:ss',dp.dMaxValuetime)+''',' +   //  Max_Valuetime,
             ''''+ FormatDateTime( 'yyyy-mm-dd hh:nn:ss',dp.dMinValuetime)+''',' + //  Min_valueTime,
             FormatFloat('0.00',dp.dAvgValue) +',' + // AGVDAta 平均值
             FormatFloat('0.00',dp.dStartPressure) +',' + // SupportStartPress
             ''''+ FormatDateTime( 'yyyy-mm-dd hh:nn:ss',dp.dZhuYeEndTime)+''','  +  // ZhuYeEndTime
             FormatFloat('0.00',dp.dBeforeLastValue) +',' +FormatFloat('0.00',dp.dbeforeLastMaxValue) +',' + // BeforeMoveValue,BeforeMoveMaxValue
             ''''+ FormatDateTime( 'yyyy-mm-dd hh:nn:ss',dp.dBeforeLastValueTime)+''',' +   //  BefortMovetime,
             ''''+ FormatDateTime( 'yyyy-mm-dd hh:nn:ss',dp.dBeforeLastMaxValueTime)+''',' + //  BeforeMoveMaxTime,
             FormatFloat('0.00',dp.dZhuYeHuzhuanGradient) +',' + // zhuyeReturnGrad，
             FormatFloat('0.00',dp.dTotalGradient) +',' + // DataVarience
             FormatFloat('0.00',BasicJindao.CurrDataValue) +',' +  //   SameTimeValue
             IntToStr(dp.dSupportState)  + ',''' +// MoveState
             Data_Frequency.MakeString  +''''+ // Memo1
             ',0)';


   MyCommand.CommandText:=sql;
   MyCommand.Execute;

end;

function TDisposeCycleData.SaveWorkFaceInforMation: Boolean;
var
  StrValue:String;
  i:integer;
  StringGroupColor:string;
begin
   StrValue:='';
   if Public_Basic.StrToInt_lu(WorkFace_id) <1 then exit;

      StrValue:=IntToStr(MyWokFace_Info.Oneday_daoshu) +',';

      StrValue:=StrValue+IntToStr(MyWokFace_Info.TwoDao_IntervalTime) +',';
      StrValue:=StrValue+FormatFloat('0.000',MyWokFace_Info.OneDao_step) +',';

      StrValue:=StrValue+IntToStr(MyWokFace_Info.ManulInput_Interval_support)+',';

      StrValue:=StrValue+IntToStr(MyWokFace_Info.JinDao_Basic)+',';
      StrValue:=StrValue+IntToStr(MyWokFace_Info.JinDao_Support)+',';
      StrValue:=StrValue+IntToStr(MyWokFace_Info.JinDao_Time);


    StringGroupColor:='';
    if  length(Trim(StringGroupColor)) >0 then    begin
        StrValue:=StrValue+'&'+StringGroupColor;
    end;

    SaveWorkFaceJinDaoInformation(WorkFace_id,StrValue);


end;

function TDisposeCycleData.SaveWorkFaceJinDaoInformation(
  WorkFace_id,StrValue: String): Boolean;
var
  sql:string;
begin
    Result:=false;
    if length(Trim(strValue))> 198 then  exit;

    sql:=' update cqcsb  set Memo1 =''' +strValue  + '''' +
          ' where cqid='  +WorkFace_id  ;
   try
    MyCommand.CommandText:=sql;
    MyCommand.Execute ;

   finally
      Result:=true;
   end;

end;

function TDisposeCycleData.SelectCClAndMzl(var tpCal: TFirstData): Boolean;
{
  通过 数据分析 已经明确找到了移架信息
  目前 可以明确的是 本次循环的数据从 Phase_St_id 到  Phase_Ed_id
  该 函数的目的 是找到 初撑力 末阻力 以及移架前异常变动的数据
}
var
   i:integer;
   Top_Data:double;
   top_diff:Double;
   MaxData,MinData:Double;
   Top_Time,bottom_Time:Tdatetime;
   stdleCount:integer;
   AGv_Count,tm_id:integer;
   AGVData:double;
begin
    Result:=False;
    stdleCount:=0;
    if Phase_Ed_id <2 then   exit;
     // 查找压力回转
    MaxData:=tmp_Use_InputData[Phase_St_id].Useddata ;
    stdleCount:=0;  Top_Data:=0;

    tpCal.dMoveStartTime:=tmp_Use_InputData[Phase_St_id].GenerateTime ;
     for I := Phase_St_id  to Phase_Ed_id  do   begin
         if (not tmp_Use_InputData[i].MoveSupportTag) and (not tpcal.isRecord) then begin //找到液压支架开始工作的时刻
            //计算移架过程中的最小值
            MinData:=GetMinValueFromUsedData(Phase_St_id,i-1,tmp_Cal) ;
            tpcal.isRecord :=true;
            tpcal.dStartTime :=tmp_Use_InputData[i].GenerateTime ;
            tpcal.dStartValue:= tmp_Use_InputData[i].Useddata;
            tpcal.dStartPressure :=tmp_Use_InputData[i].Useddata;
            tpCal.dzhuyeEndTime:=tmp_Use_InputData[i].GenerateTime ;
            Phase_St_id:= i;
            Top_Data:= tmp_Use_InputData[i].Useddata;
         end else begin
            continue;
         end;

         top_diff:=  (tmp_Use_InputData[i].Useddata-Top_Data)/Top_Data *100;

         if (top_diff> 0) and (stdleCount=0) then   begin
            MaxData:= tmp_Use_InputData[i].Useddata;
            Top_Data:= MaxData;
            stdleCount:=0;
         end else  if (top_diff <0) then   begin
            Top_Data:= tmp_Use_InputData[i].Useddata;
            tpCal.dZhuYeHuzhuanGradient:=(MaxData-Top_Data)/Top_Data *100;
            inc(stdleCount);
         end else if (top_diff > 0) and (stdleCount >0 ) then   begin
            break;
         end;
     end;
    // 证明没有找到有效数据
    if not tpcal.isRecord then  exit;
    //如果数据太少 退出不计算
    if Phase_Ed_id-Phase_St_id < 2 then   exit;
    // 查找初撑力
     for I := Phase_St_id +1  to Phase_Ed_id  do   begin
        if (tmp_Use_InputData[i].Useddata>tpcal.dStartPressure  ) and
           (tmp_Use_InputData[i].GenerateTime - tpcal.dStartTime < 1/24/30 ) and
           (tmp_Use_InputData[i].Useddata  > tmp_Use_InputData[i-1].Useddata) and
           ((tmp_Use_InputData[i].Useddata -tmp_Use_InputData[i-1].Useddata)/tmp_Use_InputData[i-1].Useddata > 0.1 ) then
           tpcal.dStartPressure :=tmp_Use_InputData[i].Useddata;
       //
     end;

    Top_Data:=tmp_Use_InputData[Phase_Ed_id-1].Useddata ;
    if Top_Data <=0 then  exit;
    Top_Time:=tmp_Use_InputData[Phase_Ed_id-1].GenerateTime;
    Bottom_time:= Top_Time-1/24/12;
    AGVData:=Top_Data;
    AGv_Count:=0;
    //付初值
    tpCal.dbeforeLastMaxValue := Top_Data;
    tpCal.dBeforeLastMaxValueTime:=Top_Time ;
    tpcal.dEndTime :=Top_Time;
    tpCal.dEndValue :=Top_Data;

    //计算最大值
    MaxData:=GetMaxValueFromUsedData(Phase_St_id,Phase_Ed_id,tmp_Cal) ;

   for I := Phase_Ed_id-2  downto Phase_St_id  do   begin
       if tmp_Use_InputData[i].GenerateTime <= Bottom_time then  begin
          tpCal.dBeforeLastValue := tmp_Use_InputData[i].Useddata;
          tpCal.dBeforeLastValueTime:=tmp_Use_InputData[i].GenerateTime ;
          break;
       end;
       top_diff:=  (tmp_Use_InputData[i].Useddata-Top_Data)/Top_Data *100;

       if top_diff> 1 then   begin
          {如果数据在攀升 记录该数据}
          Top_Data:= tmp_Use_InputData[i].Useddata;
          if tmp_Use_InputData[i].Useddata >tpCal.dbeforeLastMaxValue then begin
             tpCal.dbeforeLastMaxValue := tmp_Use_InputData[i].Useddata;
             tpCal.dBeforeLastMaxValueTime:=tmp_Use_InputData[i].GenerateTime ;
          end;

          if stdleCount=0 then begin
             Bottom_time:= tmp_Use_InputData[i].GenerateTime-1/24/12;
             AGVData:=tmp_Use_InputData[i].Useddata;
             AGv_Count:=0;
          end;

          if stdleCount >0 then
              tpCal.dBeforeLastValueTime:=tmp_Use_InputData[i].GenerateTime ;
       end else begin
          {对数据求平均值}
          inc(stdleCount);
          tm_id:=self.ReturnTwoDateTimeDiff(tmp_Use_InputData[i].GenerateTime,tmp_Use_InputData[i+1].GenerateTime);
          if tm_id <0 then   continue;
          AGVData:=AGVData+tmp_Use_InputData[i].Useddata* tm_id;
          AGv_Count:=AGv_Count+tm_id;
          if tmp_Use_InputData[i].GenerateTime<Bottom_time then   break;

       end;
   end;


    if AGv_Count >0  then   begin
       tpCal.dBeforeLastValue := AGVData/AGv_Count;
    end else begin
       tpCal.dBeforeLastValue := AGVData;
    end;
    //
    if tpCal.dBeforeLastValueTime < 10000 then  begin
       tpCal.dBeforeLastValueTime:=Bottom_time+1/24/24;
    end;


   Result:=true;
end;

procedure TDisposeCycleData.SetInputDataArrayValue(tm: TArrayInputData);
begin
   tmp_Use_InputData:=tm;
end;

procedure TDisposeCycleData.Set_WorkFaceId(Value: string);
begin
   WorkFace_id:=Value;
end;

function TDisposeCycleData.splitFootStepParameters: Boolean;
var
   s_temp,S2:Str_DT_array;
   C1,C2:integer;
   FootStepParameters:string;
begin
   Result:=False;
   FootStepParameters:=ReadWorkFaceJinDaoInformation(WorkFace_id);
 //  if FootStepParameters='' then  exit;
   s_temp:=Public_Basic.split(FootStepParameters,'&',C1);
         S2:=Public_Basic.split(s_temp[0],',',C2);
         if C2>7  then  begin
             MyWokFace_Info.Oneday_daoshu:=Public_Basic.StrToInt_lu(S2[0]) ;
             MyWokFace_Info.TwoDao_IntervalTime:=Public_Basic.StrToInt_lu(S2[1]) ;
             MyWokFace_Info.OneDao_step:=Public_Basic.StrToDouble_Lu(S2[2]) ;
             MyWokFace_Info.ManulInput_Interval_support:=Public_Basic.StrToInt_lu(S2[3]) ;
             MyWokFace_Info.JinDao_Basic:=Public_Basic.StrToInt_lu(S2[4]) ;
             MyWokFace_Info.JinDao_Support:=Public_Basic.StrToInt_lu(S2[5]) ;
             MyWokFace_Info.JinDao_Time:=Public_Basic.StrToInt_lu(S2[6]) ;
             MyWokFace_Info.Jindao_DataType:=Public_Basic.StrToInt_lu(S2[7]) ;
         end else begin
             MyWokFace_Info.Oneday_daoshu:=10;
             MyWokFace_Info.TwoDao_IntervalTime:=90 ;
             MyWokFace_Info.OneDao_step:=0.865 ;
             MyWokFace_Info.ManulInput_Interval_support:=5 ;
             MyWokFace_Info.JinDao_Basic:=1 ;
             MyWokFace_Info.JinDao_Support:=100 ;
             MyWokFace_Info.JinDao_Time:=0 ;
             MyWokFace_Info.Jindao_DataType:=1;
         end;

         if C1>1 then  begin
            MyWokFace_Info.ColorString:=s_temp[1];
         end else begin
            MyWokFace_Info.ColorString:='';
         end;

    Result:=true;

end;

function TDisposeCycleData.Tag_MoveSupport: Boolean;
var
  i,j:integer;
  LastEndtime:TdateTime;
begin
    //
    tmp_Cal.dSupportState:=1;
    LastEndtime:=self.GetLastTime(tmp_Use_InputData[Phase_St_id].support);
    if LastEndtime >10000 then
        if tmp_Cal.dStartTime-LastEndtime > 1/24/12 then  begin
           tmp_Cal.dStartTime:=LastEndtime+1/24/60;
        end;

   // 判断瞬时数据
   if BasicJindao.BasciState then  // 如果是 判定进刀的支架
     if MyWokFace_Info.JinDao_Time=0 then  begin // 末阻力
        BasicJindao.CurrDataValue :=tmp_Cal.dBeforeLastValue;
     end else if  MyWokFace_Info.JinDao_Time=1 then begin // 初撑力
        BasicJindao.CurrDataValue :=tmp_Cal.dStartPressure;
     end else begin // 最大值
        BasicJindao.CurrDataValue :=tmp_Cal.dMaxValue;
     end;
  // 把数据保存到数据库
    SaveSupportMoveData(WorkFace_id,tmp_Use_InputData[Phase_St_id].support,
                       GetMultDataType(tmp_Use_InputData[Phase_St_id].UsedDataType),
                       now(),tmp_Cal);
   // 把 中间计算变量 清空 等待下一次计算
    InitBasicV;
    Result:=true;

end;

{ TBasicJinDao }

procedure TBasicJinDao.Add(JDR: TJinDaoRecord);
begin
   inc(Count);
   setlength(ArrayBasicJinDao,Count);
   ArrayBasicJinDao[Count-1]:=JDR;
end;

procedure TBasicJinDao.ClearArray;
begin
   setlength(ArrayBasicJinDao,0);
   Count:=0;
end;

constructor TBasicJinDao.Create;
begin
   ItemIndex:=0;
   Count:=0;
end;

destructor TBasicJinDao.Destroy;
begin
  ClearArray;
  inherited;
end;

{ TDataFrequency }

procedure TDataFrequency.AddChild(Data:double;Frequency:integer);
var
  i:integer;
begin
    if MyChildCount < 1 then  begin
       Inc(MyChildCount);
        setlength(MyChild,MyChildCount);
        MyChild[0].BottomLine :=0;
        MyChild[0].TopLine :=StartLine ;
        MyChild[0].Count :=Frequency;
    end;

    while True do   begin
       if MyChild[MyChildCount-1].TopLine  < Data  then  begin
          Inc(MyChildCount);
          setlength(MyChild,MyChildCount);
          MyChild[MyChildCount-1].BottomLine :=StartLine +(MyChildCount-2)*  Interval;
          MyChild[MyChildCount-1].TopLine :=StartLine +(MyChildCount-1)*  Interval;
          MyChild[MyChildCount-1].Count :=0;
       end else begin
           MyChild[MyChildCount-1].Count :=MyChild[MyChildCount-1].Count+ Frequency;
           break;
       end;
    end;
end;

procedure TDataFrequency.AddNextClassToSelf(Next: TDataFrequency);
var
   i,j:integer;
begin
   TotalCount :=TotalCount+Next.TotalCount ;
   TopLine:=max(topLine,next.TopLine );
   for I := MyChildCount  to Next.MyChildCount -1 do
       AddChild(Next.MyChild[i].BottomLine+Interval /2   ,0);
   for I := 0 to MyChildCount-1 do
       if i< Next.MyChildCount then begin
           MyChild[i].Count := MyChild[i].Count + trunc(Next.TotalCount * Next.MyChild[i].Percent / 100);
           MyChild[i].Percent:= MyChild[i].Count/  TotalCount* 100;
       end;



end;

procedure TDataFrequency.AddOneData(Data: double;Frequency:integer);
var
 i:integer;
begin
    if Data > TopLine then  begin
       if MyChild[MyChildCount-1].TopLine  <= Data then  AddChild(Data,Frequency)
         else MyChild[MyChildCount-1].Count:=MyChild[MyChildCount-1].Count+Frequency;

       TopLine:=Data;
    end else begin
       for I := 0 to MyChildCount-1 do
          if (Data >= MyChild[i].BottomLine ) and
             ( Data < MyChild[i].TopLine ) then begin
                MyChild[i].Count:=MyChild[i].Count+Frequency;
                break;
             end;

    end;
    TotalCount:=TotalCount+Frequency;

end;

procedure TDataFrequency.ClearChild;
begin
   MyChildCount:=0;
   Setlength(MyChild,0);
end;

constructor TDataFrequency.Create;
begin
   InitArrayChild;
end;

destructor TDataFrequency.Destroy;
begin
  ClearChild;
  inherited;
end;

function TDataFrequency.FillDataFromDataBase(Gzmbh,Sup_st,Sup_end: integer; Str_time,
  En_Time: TDateTime): Boolean;
  {
     if   Sup_st =-1 工作面全部支架
          Sup_end= -1 具体某一个支架
         Sup_st >0 ,Sup_end >0  某个区间的支架

  }
var
 str_st,Str_ed:string;
 Sql:string;
 Sub_DF:TDataFrequency;
begin
   str_st:=public_Basic.ReturnDateTimeString(MainDataModule.DataType ,Str_time);
   Str_ed:=public_Basic.ReturnDateTimeString(MainDataModule.DataType ,En_Time);
   Sub_DF:= TDataFrequency.Create ;
   MainDataModule.MyDataSet.Close ;
   InitArrayChild ;
   if Sup_st <=0 then  begin //工作面全部支架
      Sql:=' select Memo1 from  D_'+IntToStr(Gzmbh)+'_SupportMoveInfo ' +
        ' where   startTime >= ' + Str_st  +  ' and  endTime <= ' + Str_ed  +
        '  order by endtime ';
   end else if Sup_end <=0 then  begin //工作面全部支架
      Sql:=' select Memo1 from  D_'+IntToStr(Gzmbh)+'_SupportMoveInfo ' +
        ' where supportbh =' + IntTostr(Sup_st) + ' and  startTime >= ' + Str_st  +
        ' and  endTime <= ' + Str_ed  +
        '  order by endtime ';
   end else  begin
      Sql:=' select Memo1 from  D_'+IntToStr(Gzmbh)+'_SupportMoveInfo ' +
        ' where supportbh >= ' + IntTostr(Sup_st) + ' and supportbh <= ' + IntTostr(Sup_end)  +
        ' and  startTime >= ' + Str_st  +
        ' and  endTime <= ' + Str_ed  +
        ' order by endtime ';
   end;
  try
     MainDataModule.MyDataSet.CommandText :=Sql;
     if MainDataModule.MyDataSet.Open  then  begin
       while not MainDataModule.MyDataSet.Eof  do  begin
          Sub_DF.InitArrayChild;
          Sub_DF.SplitString(MainDataModule.MyDataSet.FieldByName('Memo1').AsString  );
          AddNextClassToSelf(Sub_DF);
          MainDataModule.MyDataSet.Next ;
       end;
     end;
  finally
     MainDataModule.MyDataSet.Close ;
     FreeandNil(Sub_DF);
     Result:=true;
  end;

end;

procedure TDataFrequency.InitArrayChild;
begin
   ClearChild;
   StartLine:=5;
   Interval:=5;
   TopLine:=5;
   ClearChild;
   TotalCount:=0;
   AddChild(0,1);
end;

function TDataFrequency.MakeString: String;
var
  I:integer;
  Tmp_Str:string;
begin
  Result:='';
  Tmp_Str:='';
  if TotalCount <1 then   exit;

  Tmp_Str:=FormatFloat('0',self.StartLine)+',' + FormatFloat('0',self.Interval)  +',' +
           FormatFloat('0',self.TopLine)+',' +IntTostr(self.MyChildCount)+',' +  IntTostr(self.TotalCount)  +';';
  for I := 0 to MyChildCount-1 do   begin
    MyChild[i].Percent := MyChild[i].Count/TotalCount *100;
    Tmp_Str:=Tmp_Str+ FormatFloat('0.0',MyChild[i].Percent)+',' ;
  end;
  Result:=Tmp_Str;
end;

function TDataFrequency.ReturnEddirctCount: Integer;
begin
    Result:=TotalCount-ReturnNotEddirctCount;
end;

function TDataFrequency.ReturnEffiectBl: double;
begin
    Result:=100-ReturnNotEffiectBl;
end;

function TDataFrequency.ReturnNotEddirctCount: integer;
begin
    if high(MyChild) >1 then  begin
       Result:= MyChild[0].Count+ MyChild[1].Count;
    end else begin
       Result:=0;
    end;

end;

function TDataFrequency.ReturnNotEffiectBl: double;
begin
   if high(MyChild) >1 then  begin
       Result:= MyChild[0].Percent+ MyChild[1].Percent;
    end else begin
       Result:=0;
    end;

end;

procedure TDataFrequency.SplitString(Value: string);
var
   s_temp,S2:Str_DT_array;
   i,C1,C2:integer;
   ChlidCount:integer;
begin
   if Value='' then    exit;
   s_temp:=Public_Basic.split(Value,';',C1);
   if C1<2 then   exit;
   S2:=Public_Basic.split(s_temp[0],',',C2);
       StartLine:=Public_Basic.StrToDouble_Lu(S2[0]);
       Interval:= Public_Basic.StrToDouble_Lu(S2[1]);
       TopLine:= Public_Basic.StrToDouble_Lu(S2[2]);
       ChlidCount:=Public_Basic.StrToInt_lu(S2[3]) ;
       TotalCount:= Public_Basic.StrToInt_lu(S2[4]) ;

   S2:=Public_Basic.split(s_temp[1],',',C2);

   ClearChild ;

   for I := 0 to ChlidCount-1 do  begin
       if i>=C2 then  exit;
       if i=0 then begin  AddChild(0,1);
       end else     AddChild(MyChild[MyChildCount-1].TopLine + Interval/2 ,1);
       MyChild[MyChildCount-1].Percent := Public_Basic.StrToDouble_Lu(S2[i]);
       MyChild[MyChildCount-1].Count:=Round(TotalCount* MyChild[MyChildCount-1].Percent/100) ;
   end;
end;

end.
