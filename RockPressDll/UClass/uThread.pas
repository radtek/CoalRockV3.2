unit uThread;

interface
uses
     windows,Classes,uDisposeData,PStope_GzmGuidClass,SysUtils,UMainDataModule,System.TypInfo,SyncObjs;
type
 PAPStroke =^TStrokeData;
  TStrokeData=packed record
     FirstTime:TdateTime;
     maxTime:Tdatetime;
     MinTime:TdateTime;
     supportbh:integer;
     Min_data:integer;
     Max_data:Integer;
     Now_time:TdateTime;
     Now_data:integer;
     MoveState:integer;
     DisposeRecorder:integer;
  end;
  PFDD = ^TFirstData;
  TFirstData =packed record
     isRecord :Boolean;   //  �Ƿ�������
     dTimeD:Tdatetime;   //   ���ݲ���ʱ��
     dMaxValuetime:TdateTime;  //  ������ݲ���ʱ��
     dMinValuetime:TdateTime;   //  ��С���ݲ���ʱ��
     dMaxValue:double;      //  �������ֵ
     dMinValue:double;     //   ������Сֵ
     dAvgValue:double;     //   ����ƽ��ֵ

     dFirstValue:double;      //��һ����¼
     dFirstValueTime:tdatetime;//��һ����¼��ʱ��
     dFrequency:integer;    //  �����ظ�����
     dPointNumber:double;   //  �����ܵ���
     dDiffPercent:double;    // ���ݲ�����
     dMovesuppport:Boolean;  // �Ƿ��Ƽܱ��
     dInterVal:integer;    //    ����ʱ����
     dTotalGradient:double; // �������ݶ�
     dSupportState:integer; //Һѹ֧�ܵ�״̬
     dStartPressure:double;//Һѹ֧�ܵĳ�����

     dMoveEndTime:TdateTime;// Һѹ֧���Ƽܽ���ʱ��
     dMoveStartTime:TdateTime;// Һѹ֧���Ƽܿ�ʼʱ��

     dZhuYeGradient:double;//עҺ�ݶ�
     dZhuYeTimes:integer; //עҺ������ʱ��
     dzhuyeEndTime:TdateTime;//עҺ��ɵ�ʱ��
     dzhuYeValue:double;//עҺ���ʱѹ��
     dZhuyeHuZhuanTimes:integer;//עҺ��ת ��ʱ��
     dZhuYeHuzhuanGradient:double; // ���ݵ�һ���ݶ� Ҳ����עҺ���ʱ�Ļ�ת�ݶ�

     dBeforeLastValue:double;     //  �춯ǰ���һ����¼
     dBeforeLastValueTime:Tdatetime;// �춯ǰ���һ����¼��ʱ��
     dbeforeLastGradient:double;  // �춯���ݶ� Ҳ��Һѹ֧��������֧��Ӱ����ݶ�
     dbeforeLastMaxValue:double; //�춯��������ֵ
     dbeforeLastTimes:integer;// �춯������ʱ��
  end;

  TFirstDisPoseThread=class(TThread)
   private
      FToNumber:Integer;
      FGzmbh:String;
      FSupbh:integer;
      succeed:Boolean;
      FDataTimeintVal:double;
      EspTime:String;
      FDisPose:TDisposeData;

      FADOConnect:TMySQLConnection;
      FDataSet1:TMyDataSet;
      FDataSet21:TMyDataSet;
      FDataSet31:TMyDataSet;
      FCommand:TMyCommand;
      TotalProcessNumber:integer;
      DataBaseType:String;
      //
      IsUesedFields,isUsedTsupportName: array [0..3] of string; //���õ��ֶ�����
      IsUesedFieldCount:integer; //  ���õ��ֶ���Ŀ
      dCircleRec:PFDD;
      dFddList:TList;
      dFd:PFDD;
      dstroke:PAPStroke;
      PressData_LowLine,Stroke_LowLine:Double;
      ChangeDataTypeTime:Tdatetime;
      //
     function SelectOneRecord(Sql, Fieldtime, FieldValue,FieldBh: string;
             var Gtime: Tdatetime; var Mvalue: double;Var BBh:integer): Boolean;

     function DisPoseMinutedata(uGBh:String;Supbh:integer;Starttime,EndTime:Tdatetime):boolean;
     function Minute_Supplemental_record(uGBh:String;Supbh:integer;inSql:String;
              Starttime,EndTime:Tdatetime;Var Last_Time:TdateTime):Boolean;
     function Minute_Last_record(uGBh:String;Supbh:integer;inSql:String;Starttime,EndTime:Tdatetime;
               var Last_Time:TdateTime):Boolean;
     function MinUte_Over_SupprortPercentPress(uGBh:String;Supbh,FieldId:integer;Starttime:Tdatetime;
               var Frequency,MoveSupport:integer;Var EndTime:TdateTime ):Boolean;
     function SelecMax_LastValue(Sql:String;dp:PFDD):Boolean;
     function DisPoseSupportData(uGBh:String;zhiJiaBh:integer;Var TotalN :integer):boolean;
     procedure InsertSql( sql:string);
     function Edit_Processrecord(uGBh:String;Supbh:integer;FieldName:string;setTime:TdateTime):Boolean;
     //
     function JudgeTableIsExists(TableName:string):boolean;
     function SetNextChangDataTypeTime(Gzmid:integer;EndTime:TdateTime):TDatetime;
     function FillUesedDataTypeField(Gzmid:integer;EndTime:TdateTime):Tdatetime;
     procedure Inn_setSupportType(First, Second, Third, Fouth: Integer);
     procedure SelectSupportMoveRecorder(sql:string;dp:PFDD;dList:TList);
     function JudgeSupportMoveState(dp:PFDD;dFList:TList):Integer; //�ж�֧�ܵ��ƶ�״̬
     procedure SaveSupportMoveData(table_b:string;supportbh:integer;ValueType:string;GeTime:Tdatetime;dp:PFDD);
     procedure InidCircleRec(dp: PFDD);
     function SelectSupportMoveState(table_b:string;Supportbh:integer;Start_Time,End_Time:TdateTime):Integer;
       //=============================================

     { ���� �� ͨ������ǧ�ﶥ ͳ�ƽ�������  �ĺ���}
     function SelectStrokeData(Fgzm,FSupbh:string):Boolean; {��������}
      {�������ʱ������Сʱ�亯��}
     function Select_StrokeMaxtime(Fgzm,FSupbh:string;Var Min_Time,Max_Time:TdateTime):Boolean;
     { �ж��� ��ǰʱ�� �ƶ�Һѹ֧�ܵĺ���}
     function JudgeStrokeData(Fgzm,FSupbh:string; var Min_Time,Max_Time:TdateTime):boolean;
      { ��ʼ����¼��ĺ���}
     procedure initStrokeRecord(dp:PAPStroke);
      { ����������ɾ�����ݺ���}
     function SaveStrokeDataIntoRealFootage(Fgzm:string;DST:PAPStroke):Boolean;


   protected
      procedure Execute ;override;
      function DataFirstdisPose(uGBh:String;Var sumN:integer;var elapsedtime :string):Boolean;

   public
      destructor Destroy; override;
      constructor  Create(uObjusers:TDisposeData;Gzmbh,BaseType:string;supbh:integer);

   end;


implementation
uses ActiveX,Vcl.Dialogs, Lu_Public_BasicModual;


{ TFirstDisPoseData }

constructor TFirstDisPoseThread.Create( uObjusers:TDisposeData;Gzmbh,BaseType:string;supbh:integer);
begin
   Inherited  Create(true) ;
   CoInitialize(Nil);
   FreeOnTerminate := True;

   FDisPose:=uObjusers;
   DataBaseType:=BaseType;
   FGzmbh:=gzmbh;
   FSupbh:=supbh;
   FADOConnect:=TMySqlConnection.Create(nil);
   FADOConnect.Open(uObjusers.FinDataModule.EXDataIP,uObjusers.FinDataModule.Port,uObjusers.FinDataModule.ExUser,
                    uObjusers.FinDataModule.EXPassword,uObjusers.FinDataModule.DataBaseName);

   FDataSet1:=TMyDataSet.Create(nil);
   FDataSet21:=TMyDataSet.Create(nil);
   FDataSet31:=TMyDataSet.Create(nil);
   FCommand:=TMyCommand.Create(nil);
   FDataSet1.MySqlConnection:=FADOConnect;
   FDataSet21.MySqlConnection:=FADOConnect;
   FDataSet31.MySqlConnection:=FADOConnect;
   FCommand.MySqlConnection:=FADOConnect;

   FDataTimeintVal:=FDisPose.DataIniTimeInterval*MinutesD;
   PressData_LowLine:=FDisPose.PressDataLowLine;
   Stroke_LowLine:=FDisPose.strokeData_LowLine;
   //init Tlist
   dFddList:=Tlist.Create;
   //init dPriorRec
   new(dCircleRec);
   new(dStroke);
     // ������������ʱ��
    IsUesedFieldCount:=0;// ������ݿ�������ֵ����֤����
    TotalProcessNumber:=0; //������ʼ
end;

function TFirstDisPoseThread.DataFirstdisPose(uGBh: String; var SuMN:integer;
  var elapsedtime: string): Boolean;
var
  i:integer;
  lastTime,Datalasttime:Tdatetime;
  lastValue,DatalastValue:double;
  Sql1,sql2:String;
  DataBool,RecordBool:Boolean;
  MinSupbh,MaxSupBh,tempbh:integer;
  StartTime,EndTime:TdateTime;
  elapsedMilliseconds : cardinal;
  inn_count:integer;
begin
     Result:=false; FToNumber:=0;
     FDisPose.FirstProcessStop:=false;
     TotalProcessNumber:=0; //������ʼ
     if IsUesedFieldcount<1 then begin   //������õ��ֶ���ĿС��1���˳�
         exit;
     end;
       //�����������ݱ���δ���������� ����֧�ܱ�������֧�ܱ��
       if (DataBaseType= 'SQLSERVER') or(DataBaseType= 'SQL SERVER') then  begin
              Sql1:=' select top 1 * from D_'+Trim(uGbh)+'_BasicData ' +
                     ' where  FirstProcess=0 order by supportbh ';   //֧�ܱ����С
              Sql2:=' select top 1  * from D_'+Trim(uGbh)+'_BasicData ' +
                     ' where  FirstProcess=0 order by supportbh desc ';  //֧�ܱ�����

        end else if (DataBaseType= 'MYSQL') or (DataBaseType= 'MY SQL') then  begin
              Sql1:=' select * from D_'+Trim(uGbh)+'_BasicData ' +
                     ' where  FirstProcess=0 order by supportbh  limit 1';   //֧�ܱ����С
              Sql2:=' select  * from D_'+Trim(uGbh)+'_BasicData ' +
                     ' where  FirstProcess=0 order by supportbh desc limit 1';  //֧�ܱ�����
        end;

       if not SelectOneRecord(sql1,'GenerateTime','id','supportbh',DatalastTime,datalastValue,MinSupbh)  then  exit;
       if not SelectOneRecord(sql2,'GenerateTime','id','supportbh',DatalastTime,datalastValue,MaxSupbh)  then  exit;

       i:=MinSupbh;

    while True do begin 
      if FDisPose.FirstProcessStop then   break;   //ǿ����ֹѭ��

      if i>MaxSupbh then   break;

      Result:=DisPoseSupportData(uGbh,i,inn_count);
      FToNumber:=FToNumber+inn_count;
      i:=i+1;//���� ��һ��֧��
    end;
    SuMN:= FToNumber;
end;

destructor TFirstDisPoseThread.Destroy;
begin
    FreeAndNil(FDataSet1);
    FreeAndNil(FDataSet21);
    FreeAndNil(FDataSet31);
    FreeAndNil(FCommand);
    FreeAndNil(FADOConnect) ;
    dFddList.free;
    DisPose(dCircleRec); //���dPriorRec
    if Assigned(dStroke) then Dispose(dStroke);
    CoUninitialize;
    inherited Destroy;
end;

function TFirstDisPoseThread.DisPoseMinutedata(uGBh:String;Supbh: integer; Starttime,
  EndTime: Tdatetime): boolean;
var
//   j:integer;
//   selectSql,inSql,sql1,temp:String;
//   FieldS:string;
//   DiffPercent:double;
//   MoveSupport,tempbh:integer;
//   TempD,forTime,whileTime:TdateTime;
//   Max_value_time,Min_value_time:TdateTime;
//   Max_Value,Min_value:double;
//   Last_value:array [0..3] of double;
//   temp_last_V,temp_first_V:double ;     //��ͳ���������  ���һ����¼
//   temp_last_time,temp_first_time:tdateTime;//��ͳ��������� ���һ����¼��ʱ��
//   flag,ValueB:Boolean;
//   Frequency:integer;
//   temp_End_time:Tdatetime;
     forTime,temp_End_time:TdateTime;
     inSql:String;
begin
     Result:=False;
     // DiffPercent:=0.0; MoveSupport:=0;
    // flag:=true;
    forTime:=StartTime;
   try
     //--------
     if (ChangeDataTypeTime > 40000 ) and ( ChangeDataTypeTime < EndTime) then
         ChangeDataTypeTime:=FillUesedDataTypeField(StrToint(uGBh),ChangeDataTypeTime);

     if not  JudgeTableIsExists('D_'+Trim(uGBh)+'_'+IntToStr(Supbh)+'_FirstDP') then    exit;

     //--------
     inSql:='insert into D_'+Trim(uGBh)+'_'+IntToStr(Supbh)+'_FirstDP (GenerateTime,ValueType,Max_Value,'
            + ' Min_Value,Agv_Value,DiffPercent,MoveSupport,TimeInterVal,process, Frequency ,'
            + ' PointNumber,Last_value)  values ( ';
     //ʱ��ǿ������
     if (EndTime-StartTime)/FDataTimeintVal>60*FDisPose.TimeIntervalSupportData then
            forTime:= EndTime-FDataTimeintVal*60*FDisPose.TimeIntervalSupportData;
     // ִ�� ѭ������
     if not self.Minute_Supplemental_record(uGBh,Supbh,inSql,forTime,EndTime,forTime) then      exit;
     //forTime ��ʱ��ӻ���

     // �������һ����¼ �Ѿ�����
     if not self.Minute_Last_record(uGBh,Supbh,inSql,forTime,EndTime,temp_End_time) then    exit;


     //���� BasicData   FirstProcess
//        insertSql(  ' update D_'+Trim(uGBh)+'_BasicData ' +
//                      ' set FirstProcess=1  where supportbh= '+ IntToStr(Supbh) +'   and ( generateTime >= '''+
//                      FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Starttime)+ ''' and generateTime <''' +
//                      FormatDateTime( 'yyyy-mm-dd hh:nn:ss',temp_End_time) +''')'
//                 );
//       insertSql(  ' delete from D_'+Trim(uGBh)+'_BasicData ' +
//                      ' where supportbh= '+ IntToStr(Supbh) +'   and ( generateTime >= '''+
//                       FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Starttime)+ ''' and generateTime <''' +
//                       FormatDateTime( 'yyyy-mm-dd hh:nn:ss',temp_End_time) +''')'
//                 );

       Result:=true;
       TotalProcessNumber:=TotalProcessNumber+trunc((forTime-Starttime)/FDataTimeintVal)+1;
       if TotalProcessNumber > 41234567 then  TotalProcessNumber:=0;

   finally
     insertSql(  ' delete from D_'+Trim(uGBh)+'_BasicData ' +
                      ' where supportbh= '+ IntToStr(Supbh) +'   and (generateTime <''' +
                       FormatDateTime( 'yyyy-mm-dd hh:nn:ss',temp_End_time) +''')'
              );
   end;



end;

function TFirstDisPoseThread.DisPoseSupportData(uGBh: String; zhiJiaBh: integer;
  var TotalN:integer): boolean;
var
    //i:integer;
    ProcesslastTime,Datalasttime,DataFirstTime:Tdatetime;
    WhileEndTime:Tdatetime;
    lastValue,DatalastValue:double;
    Sql1,sql2,sql3:String;
    DataBool,RecordBool:Boolean;
    MinSupbh,MaxSupBh,tempbh:integer;
    EndTime:TdateTime;
    whilecount,MinNumber,tempNumber:integer;
    elapsedMilliseconds : cardinal;
begin
       //Ԥ���ַ���
    Result:=false;
    whilecount:=0; tempNumber:=0;
    try
       Sql1:=' select  MAX(GENERATETIME) AS MaxTime from D_'+Trim(uGbh)+'_BasicData ' +     //���Ҹ�֧�ܱ�ŵ�ʱ������¼
                   ' where supportbh= '+ IntToStr(ZhiJiaBh) +' and FirstProcess=0 ';
       Sql2:=' select  MIN(GENERATETIME) AS MinTime from D_'+Trim(uGbh)+'_BasicData ' +     //���Ҹ�֧�ܱ�ŵ�ʱ����С��¼
                   ' where supportbh= '+ IntToStr(ZhiJiaBh) +' and FirstProcess =0 ';
       DataBool:=SelectOneRecord(sql1,'MaxTime','','',DatalastTime,datalastValue,tempbh) ;
       // ���ݱ��޸�֧�ܼ�¼
       if not DataBool then    exit;
       SelectOneRecord(sql2,'MinTime','','',DataFirstTime,datalastValue,tempbh); //δ�������һ����¼
       DataFirstTime:=StrToDateTime(FormatDateTime( 'yyyy-mm-dd hh:nn:ss',DataFirstTime),FDisPose.FSetting);
       //������ݱ��м�¼����һ����������
       if DataFirstTime+FDataTimeintVal > DataLastTime then exit;

      //ȡ��������¼���Ѿ�����������ʱ��
       Sql3:=' select * from D_'+Trim(uGbh)+'_ProcessRecord ' +   //���Ҹ�֧�ܴ�����¼
               ' where supportbh= '+IntToStr(ZhiJiaBh);
        FDataSet1.Close ;
        FDataSet1.CommandText :=sql3;
        if FDataSet1.Open  then
          if FDataSet1.RecordCount < 1 then  begin
             WhileEndTime:=DataFirstTime;
             insertSQl('insert into D_'+Trim(uGBh)+'_Processrecord (supportbh,FirstTime,used) values ('  +
                       IntToStr(ZhiJiaBh)+', '''+ FormatDateTime( 'yyyy-mm-dd hh:nn:ss',DataFirstTime)+''','+
                       '1)');
             ProcesslastTime:=DataFirstTime;
          end else begin
             ProcesslastTime:=FDataSet1.FieldByName('FirstTime').AsDateTime;
          end;
        FDataSet1.Close ;
        WhileEndTime:=ProcesslastTime+1/24*FDisPose.OneStepDisposeTime ;
         //�����Сʱ���¼��  WhileEndTime ֮��
        while DataFirstTime > WhileEndTime do
           WhileEndTime:=WhileEndTime+1/24*FDisPose.OneStepDisposeTime ;
        // ���ʱ���޶�
        if WhileEndTime > DatalastTime then  WhileEndTime:= DatalastTime;
         //��׼������ʱ��
        ProcesslastTime:=StrToDateTime(FormatDateTime( 'yyyy-mm-dd hh:nn',ProcesslastTime)+':00',FDisPose.FSetting);
        WhileEndTime:=StrToDateTime(FormatDateTime( 'yyyy-mm-dd hh:nn',WhileEndTime)+':00',FDisPose.FSetting);
        DatalastTime:=StrToDateTime(FormatDateTime( 'yyyy-mm-dd hh:nn',DatalastTime)+':00',FDisPose.FSetting);

        while ( ProcesslastTime+FDataTimeintVal < WhileEndTime )  and   //��֤������Ч
              ( DataFirstTime+FDataTimeintVal < DataLastTime) do  begin //��֤�����������
            if FDisPose.FirstProcessStop then  break;  //�˳�ѭ��
           // record Number
              MinNumber:=TotalProcessNumber-tempNumber;
              if (FDisPose.writeProcessflag) and (MinNumber >100 )  then  begin
                insertSQl( ' insert into processlog (generatetime,DataNumber,gzmname,supportbh,minNumber, ' +
                       ' threadid,Processtype) values (''' +
                      FormatDaTeTime('yyyy-mm-dd hh:nn:ss',now())+''','+IntToStr(TotalProcessNumber)+',''' +
                      Trim(uGbh)+''','+ IntToStr(ZhiJiaBh) +','+IntToStr(MinNumber)+','+
                      IntToStr(self.Handle) +',''FirstProcess'')'  );
                tempNumber:=TotalProcessNumber ;
              end;

             if DataFirstTime<= ProcesslastTime+FDataTimeintVal  then   begin
                 Endtime:= ProcesslastTime+FDataTimeintVal;
             end else begin
                 Endtime:=StrToDateTime(FormatDateTime( 'yyyy-mm-dd hh:nn',DataFirstTime+MinutesD)+':00',FDisPose.FSetting);
             end;

            if DisPoseMinutedata(uGBh,ZhiJiaBh,ProcesslastTime,EndTime) then begin
               ProcesslastTime:=Endtime;
               Result:=true;
            end;
            SelectOneRecord(sql2,'MinTime','','',DataFirstTime,datalastValue,tempbh); //δ�������һ����¼
            DataFirstTime:=StrToDateTime(FormatDateTime( 'yyyy-mm-dd hh:nn',DataFirstTime)+':00',FDisPose.FSetting);

            whilecount:=whilecount+1;
         end ;// �ڲ�ѭ��

    except
        Result:=false;
    end;

    if whilecount >0 then    Result:=true;
       TotalN:= TotalProcessNumber;
end;

function TFirstDisPoseThread.Edit_Processrecord(uGBh: String; Supbh: integer;
  FieldName: string; setTime: TdateTime): Boolean;
begin
    //�������ݸ��¼�¼
 Result:=false;
 try
    insertSql( 'update D_'+Trim(uGBh)+'_Processrecord  set '+FieldName+' ='''
                +  FormatDateTime( 'yyyy-mm-dd hh:nn:ss',setTime)+''','
                + ' used=1'+
                '  where supportbh= '+IntToStr(Supbh)
               );
 finally
    Result:=true;
 end;
end;

procedure TFirstDisPoseThread.Execute;
var
  inn_count:integer;
begin
  inherited;
  FToNumber:=0;
  //������
  if (FDisPose.writeProcessflag) then
     insertSQl( ' insert into processlog (generatetime,gzmname,supportbh, threadid,Processtype) values (''' +
          FormatDaTeTime('yyyy-mm-dd hh:nn:ss',now())+''',''' +
          Trim(FGzmBh)+''','+ IntToStr(Fsupbh) +','+IntToStr(self.Handle)+',''FPInput'')'  );
  try
   if FGzmBh <>'' then  begin
        // ��������ǧ�ﶥ�Ľ���
        succeed:=SelectStrokeData(FGzmBh,IntToStr(Fsupbh)) ;
        //����ѹ������
        ChangeDataTypeTime:=self.SetNextChangDataTypeTime(StrToInt(FGzmBh),-1);
        ChangeDataTypeTime:=self.FillUesedDataTypeField(StrToInt(FGzmBh),ChangeDataTypeTime);
        succeed:=DisPoseSupportData(FGzmBh,Fsupbh,inn_count);
        FToNumber:=inn_count;
     if (FDisPose.writeProcessflag) and (FToNumber >0) then
           insertSQl( ' insert into processlog (generatetime,DataNumber,gzmname,supportbh, threadid,Processtype) values (''' +
                      FormatDaTeTime('yyyy-mm-dd hh:nn:ss',now())+''','+IntToStr(TotalProcessNumber)+',''' +
                      Trim(FGzmBh)+''','+ IntToStr(Fsupbh) +','+IntToStr(self.Handle)+',''FPStop'')'  );

   end;
   //��������
  finally
      insertSql( 'update D_'+Trim(FGzmBh)+'_Processrecord  set used=0  where supportbh= '+
                 IntToStr(Fsupbh)  );
  end;

end;

function TFirstDisPoseThread.FillUesedDataTypeField(Gzmid: integer;
  EndTime: TdateTime): Tdatetime;
var
  Sql:String;
  Minus:double;
  NextTime:TdateTime;
  First,Second,Third,Fouth,dataid,DataType:integer;
begin
  Minus:=1/24/60;
  First:=0;Second:=0;Third:=0;Fouth:=0;
  NextTime:=-1;
  Result:=-1;
  try
   sql:=' select *  from GzmDataType  where  cqid = ' +intToStr(Gzmid) +
        ' and StartTime >='''+FormatDateTime('yyyy-mm-dd hh:nn',EndTime-Minus) +':00''' +
        ' and StartTime <='''+FormatDateTime('yyyy-mm-dd hh:nn',EndTime+Minus*2) +':00'''+
        ' order by startTime,dataid ';
   FDataSet31.Close ;
   FDataSet31.CommandText:=sql;
   if FDataSet31.Open  then
       while not FDataSet31.Eof  do  begin
         dataid:=FDataSet31.FieldByName('dataid').AsInteger;
         DataType:=FDataSet31.FieldByName('DataType').AsInteger;
         NextTime:=FDataSet31.FieldByName('startTime').AsDateTime;
         if (dataid =1)  and (DataType>0 ) then  begin
            First:=DataType;
         end else if (dataid =2)  and (DataType>0 ) then  begin
            second:=DataType;
         end else if (dataid =3)  and (DataType>0 ) then  begin
            third:=DataType;
         end else if (dataid =4)  and (DataType>0 ) then  begin
            Fouth:=DataType;
         end;
         FDataSet31.Next ;
       end;
       if First+Second+third+Fouth >0  then   Inn_setSupportType(First,Second,Third,Fouth);

  finally
    FDataSet31.Close ;
    if NextTime < Endtime then  NextTime:=EndTime;
    Result:=self.SetNextChangDataTypeTime(Gzmid,NextTime);
  end;
end;

procedure TFirstDisPoseThread.InidCircleRec(dp: PFDD);
begin
  dp.isRecord :=false;
  dp.dTimeD :=-1;
//  dp.dMaxValuetime :=-1;
//  dp.dMinValuetime :=-1;
//  dp.dMaxValue :=0;
//  dp.dMinValue :=1000;
//  dp.dAvgValue:=0;
//  dp.dbeforeLastValue:=0;
//  dp.dFrequency:=0;
//  dp.dPointNumber:=0;
//  dp.dDiffPercent :=0;
//  dp.dMovesuppport :=false;
//  dp.dInterVal :=0;
//  dp.dTotalGradient :=0;
//  dp.dZhuYeHuzhuanGradient :=0;
//
//  dp.dbeforeLastGradient :=0;
//  dp.dbeforeLastValueTime:=-1;
//  dp.dZhuYeTimes:=0;
//  dp.dZhuyeHuZhuanTimes:=0;
//  dp.dbeforeLastTimes:=0;
//
//  dp.dzhuyeEndTime :=-1;

  dp.dSupportState:=0;
  dp.dFrequency:=1;

   dp.dbeforeLastValue:=0;
   dp.dbeforeLastMaxValue:=0;
   dp.dbeforeLasttimes:=0;
   dp.dbeforeLastGradient:=0;
   dp.dMoveStartTime:=-1;
   dp.dMoveEndTime:=-1;
   dp.dMaxValue:=0;
   dp.dMinValue:=1000;
   dp.dMaxValueTime:=-1;
   dp.dMinValueTime:=-1;
   dp.dzhuYeValue:=0;
   dp.dZhuYeEndTime:=-1;
   dp.dzhuYetimes:=0;
   dp.dZhuYeGradient:=0;
   dp.dStartPressure:=0;
   dp.dZhuYeHuZhuanTimes:=0;
   dp.dZhuyeHuZhuanGradient:=0;
   dp.dStartPressure:=0;
   dp.dSupportState:=0;




end;

procedure TFirstDisPoseThread.initStrokeRecord(dp: PAPStroke);
begin
    dp.FirstTime :=-1;
    dp.maxTime:=-1;
    dp.MinTime :=-1;
    dp.supportbh :=0;
    dp.Min_data :=100000;
    dp.Max_data :=0;
    dp.Now_time:=-1;
    dp.Now_data:=0;
    dp.MoveState:=0;
    dp.DisposeRecorder:=0;

end;

procedure TFirstDisPoseThread.Inn_setSupportType(First, Second, Third,
  Fouth: Integer);
var
      FirstValueType: TSupportDataType;  //   ��һ����������
      SecondValueType:  TSupportDataType;  //  �ڶ�����������
      ThirdValueType:  TSupportDataType;  //   ��������������
      FouthValueType:  TSupportDataType;  //   ���ĸ���������
begin

     FirstValuetype:=TSupportDataType(First);
     SecondValuetype:=TSupportDataType(Second);
     ThirdValuetype:=TSupportDataType(Third);
     FouthValuetype:=TSupportDataType(Fouth);

     IsUesedFieldCount:=0;
     if First >0  then  begin
           IsUesedFields[IsUesedFieldcount]:='FirstValue';
           isUsedTsupportName[IsUesedFieldCount]:=
               GetEnumName(TypeInfo(TSupportDataType),ord(FirstValuetype ));
           IsUesedFieldCount:=IsUesedFieldCount+1;
     end;

    if Second >0   then begin
           IsUesedFields[IsUesedFieldcount]:='SecondValue';
           isUsedTsupportName[IsUesedFieldCount]:=
             GetEnumName(TypeInfo(TSupportDataType),ord(SecondValuetype ));
           IsUesedFieldCount:=IsUesedFieldCount+1;
    end;

     if Third >0  then begin
           IsUesedFields[IsUesedFieldcount]:='thirdValue';
           isUsedTsupportName[IsUesedFieldCount]:=
             GetEnumName(TypeInfo(TSupportDataType),ord(ThirdValuetype ));
           IsUesedFieldCount:=IsUesedFieldCount+1;
     end;

     if Fouth >0  then begin
           IsUesedFields[IsUesedFieldcount]:='FouthValue';
           isUsedTsupportName[IsUesedFieldCount]:=
               GetEnumName(TypeInfo(TSupportDataType),ord(FouthValuetype ));
           IsUesedFieldCount:=IsUesedFieldCount+1;
     end;

end;

procedure TFirstDisPoseThread.InsertSql(sql: string);
var
 Res:boolean;
begin
   try
       FCommand.CommandText:=sql;
       Res:=FCommand.Execute  ;
       Res:=true;
   except
       exit;
   end;

end;

function TFirstDisPoseThread.JudgeStrokeData(Fgzm, FSupbh: string; var Min_Time,
  Max_Time: TdateTime): boolean;
var
  sql:string;
  Dirty_Data:Boolean;
begin
   Result:=false;
   Dirty_Data:=false;
   initStrokeRecord(dStroke);
   dStroke.supportbh:=StrToInt(FSupbh);
 try
   sql:=' select * from D_'+ Fgzm+ '_StrokeData where  Process =0  and supportbh='+ FSupbh  +
          ' and GenerateTime>='''+  FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Min_Time)  +''' '+
          ' and GenerateTime<='''+  FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Max_Time)  +''' ' +
          ' order by GenerateTime';
   FDataSet31.Close ;
   FDataSet31.CommandText:=sql;
   if (FDataSet31.Open) and (FDataSet31.RecordCount >0) then   begin
      dStroke.FirstTime :=FDataSet31.FieldByName('GenerateTime').AsDateTime ;
      while not FDataSet31.Eof  do  begin
         if   FDisPose.AppointFootageStop then break;

         dStroke.Now_data:=Round(FDataSet31.FieldByName('DataValue').AsFloat);
         dStroke.Now_time:= FDataSet31.FieldByName('GenerateTime').AsDateTime ;

          if dStroke.Min_data > dStroke.Now_data then  begin
             dStroke.Min_data:= dStroke.Now_data;
             dStroke.MinTime:=  dStroke.Now_time;
             dStroke.MoveState:=0;
          end;
          if dStroke.Max_data < dStroke.Now_data then  begin
              dStroke.Max_data:= dStroke.Now_data;
              dStroke.maxTime := dStroke.Now_time;
          end;

          if dStroke.Now_data >300 then   dStroke.MoveState:=1;

          if ((dStroke.MoveState >0 )  and (dStroke.Min_data < dStroke.Now_data ) and
             (dStroke.Max_data >= dStroke.Now_data  ) and ( dStroke.Min_data <200) and
             (dStroke.Now_data >200) and (dStroke.MinTime > dStroke.maxTime) ) then   begin //�����ж�
               Result:=true;
               dStroke.DisposeRecorder:=FDataSet31.RecNo;
               Min_Time:=dStroke.Now_time;
               break;
             end;

          if (   ( dStroke.Now_time-dStroke.FirstTime > 1/24*FDisPose.OneStepDisposeTime ) and
                 (  (FDataSet31.RecNo /(dStroke.Now_time-dStroke.FirstTime)*24) >1000 ) )
                  or (dStroke.Now_time-dStroke.FirstTime > 1/24*24)
                  or (FDataSet31.RecNo >5000)  then begin         // �����ݴ���
             Dirty_Data:=true;
             Min_Time:=dStroke.Now_time;
             break;
          end;
         FDataSet31.Next ;
       end;
   end;
  except
     on e:exception do begin
        public_Basic. MY_WriteLog('OpenEorr:'+e.Message,'[TMyDataSet]');
     end;
   end;

   FDataSet31.Close ;
   //��������ɾ��
   if Dirty_Data then  begin
         sql:=' delete from D_'+Fgzm+'_StrokeData where Supportbh = ' +FSupbh +
           ' and Generatetime <= '''+  FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Min_Time)+'''';
         FCommand.CommandText :=sql;
         FCommand.Execute ;
    end;

end;

function TFirstDisPoseThread.JudgeSupportMoveState(dp:PFDD;dFList:TList): Integer;
{
  dp��ѭ����¼�ṹ�壬����ʱ��ֻ�����ֵ����Сֵ
  dFList��һ��ʱ���ڵ����ݼ��ϣ�����ʱ��ֻ������ ��ʱ��
}
var
  i,TurnCount,turnToward:integer;  // turnToward =1, ����    turnToward =0, �½�
  temp_d0,temp_d1:PFDD;
  TimeDiffence,Point1_Value,Point2_value:double;
  MinPoint:integer;  // 0 ��״̬  1 �ж��� ����  2 �ж�����͵�  3  ������ עҺ��ת   4 ��ת�½�
  Point1Time,Point2Time:TDatetime;
begin
   Result:=1;
   if dFDDList.Count <1 then exit;
   TurnCount:=1; turnToward:=0;//  Ĭ�������½�
  {// 0 ��ʼ��
      1 ֧�����ټ�Ӱ�����������
      2 ֧��ѹ����������͵� ��ʾ ��״̬��ʼ�Ƽ�
      3 ��ʾҺѹ֧�ܾ����� ��͵��� עҺǹѹ���Ի�������ʱ���� ���߻�ת����ζ�ſ�����עҺֹͣ
      4 עҺֹͣ��ѹ�����߳���С���»����涥��ѹ��������ѹ�����߳��������ת�� ��־֧������ʼ

       }
   MinPoint:=0 ;
   if dp.dMaxValue=0 then   exit;      //�������Ϊ��  �����Ƽ�״̬
   dp.dDiffPercent :=(dp.dMaxValue-dp.dMinValue)/dp.dMaxValue*100;
   if dp.dDiffPercent < FDisPose.MoveSupportPercent  then exit;    //������ݲ���С �����Ƽ�״̬

   temp_d0:=PFDD(dFList.Items[0]);
   dp.dMoveStartTime:=temp_d0.dTimeD;  // �Ƽܿ�ʼʱ��

   for I := 1 to dFList.Count-1  do begin
       temp_d1:=PFDD(dFList.Items[i]);

      if (MinPoint=0) and (turnToward=1) and (temp_d1.dMaxValue  < temp_d0.dMaxValue ) then begin
        // Һѹ֧��������֧��Ӱ��
         { TODO : �ô�TimeDiffence ̫��}
         MinPoint:=1;
         if (dp.dBeforeLastValueTime <1000) then dp.dBeforeLastValueTime:= temp_d0.dTimeD;
         TimeDiffence:=(temp_d0.dTimeD-dp.dBeforeLastValueTime);
         if (TimeDiffence<=0) or(TimeDiffence>1) then TimeDiffence:=1/24/60;
         TimeDiffence:=TimeDiffence*24*60*60;
         if (TimeDiffence<1) or(TimeDiffence>720) then TimeDiffence:=1;
         dp.dbeforeLastGradient:=(temp_d0.dMaxValue-dp.dbeforeLastValue)/TimeDiffence;  //עҺ�ݶ�
         dp.dbeforeLastTimes:=Round(TimeDiffence);
         if (dp.dbeforeLastMaxValue<temp_d0.dMaxValue) then
            dp.dbeforeLastMaxValue:= temp_d0.dMaxValue;
      end;

      if temp_d1.dTimeD=dp.dMinValueTime then  begin   //��ע Һѹ��͵� ��ʼ�Ƽ�ʱ��
         MinPoint:=2;
      end;

      if (MinPoint=2) and (turnToward=1) and (temp_d1.dMaxValue  < temp_d0.dMaxValue )
          and (temp_d0.dMaxValue>dp.dMaxValue*0.5) then begin
        // Һѹ��������ߵ�  עҺǹֹͣ,ѹ����ת
         MinPoint:=3;
         Point1_value:=temp_d0.dMaxValue;
         if dp.dMinValueTime<1000 then   dp.dMinValueTime:=  temp_d0.dTimeD;
         TimeDiffence:=(temp_d0.dTimeD-dp.dMinValueTime);
         if (TimeDiffence<=0) or(TimeDiffence>1) then TimeDiffence:=1/24/60;
         TimeDiffence:=TimeDiffence*24*60*60;
         if (TimeDiffence<1) or(TimeDiffence>720) then TimeDiffence:=1;
         dp.dZhuYeGradient:=(temp_d0.dMaxValue-dp.dMinValue)/(TimeDiffence);  //עҺ�ݶ�
         dp.dZhuYeTimes:=Round(TimeDiffence);
         Point1Time:=temp_d0.dTimeD;
         dp.dZhuYeValue:=Point1_value;
         dp.dzhuyeEndTime:=Point1Time;
      end;

      if (MinPoint=3) and (turnToward=0) and (temp_d1.dMaxValue  > temp_d0.dMaxValue ) then begin
        //  עҺǹֹͣ,ѹ����ת�� ֧�����غ������Գ���
         MinPoint:=4;
         Point2_value:=temp_d0.dMaxValue;
         if Point1Time <1000 then  Point1Time:= temp_d0.dTimeD;
         TimeDiffence:=(temp_d0.dTimeD-Point1Time);
         if (TimeDiffence<=0) or(TimeDiffence>1) then TimeDiffence:=1/24/60;
         TimeDiffence:=TimeDiffence*24*60*60;
        if (TimeDiffence<1) or(TimeDiffence>720) then TimeDiffence:=1;
         dp.dZhuYeHuzhuanGradient:=(Point1_value-temp_d0.dMaxValue)/(TimeDiffence);  //עҺ�ݶ�
         dp.dZhuyeHuZhuanTimes:=Round(TimeDiffence);
         dp.dStartPressure:=Point2_value;
         dp.dMoveEndTime:=temp_d0.dTimeD; //�Ƽܽ���ʱ��
         Result:=2;
         break;
      end;

       //�ж�����״̬
       if (temp_d1.dMaxValue > temp_d0.dMaxValue ) then  begin
          if (turnToward=0 ) then  begin
             TurnCount:=TurnCount+1;  turnToward:=1;
          end;
       end else if (temp_d1.dMaxValue < temp_d0.dMaxValue ) then begin
          if (turnToward=1 ) then  begin
             TurnCount:=TurnCount+1;  turnToward:=0;
             if MinPoint=1 then  dp.dMoveStartTime:=temp_d1.dTimeD;  // �Ƽܿ�ʼʱ��

          end;
       end;

      temp_d0:=temp_d1;
   end;

   if (MinPoint=2) then begin
      Point2_value:=temp_d1.dMaxValue;
      Point2Time:=temp_d1.dTimeD;
   end else if  (MinPoint=3) then  begin
      Point2_value:=point1_Value;
      Point2Time:=Point1Time;
   end;

  if (MinPoint=2) or (MinPoint=3)  then  begin
    Point1_value:=dp.dMinValue;
    Point1Time:=dp.dMinValuetime;
    TimeDiffence:=(Point2Time-Point1Time);
    if (TimeDiffence<=0) or(TimeDiffence>1) then TimeDiffence:=1/24/60;
       TimeDiffence:=TimeDiffence*24*60*60;
    if (TimeDiffence<1) or(TimeDiffence>720) then TimeDiffence:=1;
    dp.dZhuYeHuzhuanGradient:=(Point2_value-Point1_value)/(TimeDiffence);  //עҺ�ݶ�
    dp.dZhuYeHuzhuanTimes:=Round(TimeDiffence);
    dp.dStartPressure:=Point2_value;
    dp.dMoveEndTime:=Point2Time; //�Ƽܽ���ʱ��
    Result:=2;
  end;

end;

function TFirstDisPoseThread.JudgeTableIsExists(TableName: string): boolean;
 var
   sql:string;
 begin
       Result:=false;
       if (DataBaseType= 'MYSQL') or (DataBaseType= 'MY SQL')   then  begin
           sql:='SELECT  id from  '+TableName +'  limit 1';
       end  else if (DataBaseType= 'SQLSERVER') or (DataBaseType= 'SQL SERVER')   then  begin
           sql:='Select Name from sysobjects where xtype=''u'' and name ='''+TableName +'''';
       end;
       try
          FDataSet1.Close;
          FDataSet1.CommandText :=sql;
         // if not FDataSet1.Connection.Connected then  FDataSet1.Connection.Open();
          if FDataSet1.Open then
             Result:=true  else  Result:=false;
          FDataSet1.Close;
       except
          result:=false;
          exit;
       end;



end;

function TFirstDisPoseThread.Minute_Last_record(uGBh: String; Supbh: integer;
  inSql: String; Starttime, EndTime: Tdatetime;var Last_Time:TdateTime): Boolean;
var
  Fields,SelectSql,Sql1:string;
  j,tempbh:integer;
  Max_Value,Min_Value,temp_last_V:double;
  temp_last_time:TdateTime;
  Frequency,MoveSupport:integer;
  DiffPercent:Double;
  Temp_lastTime:TdateTime;
begin
   Result:=false;
 try
    if Starttime>=EndTime-FDataTimeintVal-MinutesD/5 then  begin
         Fields:='';
          for j := 0 to IsUesedFieldcount-1 do begin
              Fields:=Fields+ ' max('+IsUesedFields[j]+') as Max'+IntToStr(j)+' ,'
                     +' min('+IsUesedFields[j]+') as MIn'+IntToStr(j)+' ,'
                     + 'AVG('+IsUesedFields[j]+') as AGV'+IntToStr(j)+' ,' ;
          end;

          selectSql:='select '+Fields+' count(id) as SuN  from D_'+Trim(uGBh)+'_BasicData where supportbh='+Inttostr(supbh) +
                    ' and ( generateTime >= '''+FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Starttime)+ '''  and  generateTime <''' +
                    FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Starttime+FDataTimeintVal) +''' ) ';

         FDataSet21.Close ;
         FDataSet21.CommandText :=selectSql;
        if  FDataSet21.Open then begin
           for j := 0 to IsUesedFieldcount-1 do  begin
             if   FDisPose.AppointFootageStop then break;
             Max_Value:= FDataSet21.FieldByName('Max'+IntToStr(j)).AsFloat;
             Min_Value:= FDataSet21.FieldByName('Min'+IntToStr(j)).AsFloat ;

              if  Max_Value >=PressData_LowLine then begin
                DiffPercent:=(Max_Value-Min_Value)/Max_Value*100;
              end  else   begin
                 DiffPercent:=0;
                 continue;
              end;

              MoveSupport:=0;
              Frequency:=1;
              // ������¼���ֵ����Сֵ����ʱ����ж�
              Temp_lastTime:=Starttime+FDataTimeintVal;
              if DiffPercent >=FDisPose.SupprortPercentPress  then  begin
                  self.MinUte_Over_SupprortPercentPress(uGBh,Supbh,j,Starttime,Frequency,MoveSupport,Temp_lastTime);
              end;

               //�������һ����¼
               Sql1:=' select generatetime,supportbh ,'+IsUesedFields[j] +' from D_'+Trim(uGBh)+'_BasicData ' +
                            ' where supportbh= '+ IntToStr(Supbh) +'   and  generatetime = ( select Max(generateTime) '+
                            ' as generatetime  from D_' +Trim(uGBh)+'_BasicData ' +
                            ' where generatetime  > '''+ FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Starttime)+ ''' and  generateTime<=''' +
                            FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Starttime+FDataTimeintVal) +'''  and FirstProcess=0  '+
                            '  and supportbh= '+ IntToStr(Supbh) +' )';

               SelectOneRecord(sql1,'generatetime',IsUesedFields[j],'supportbh',temp_last_time,temp_last_V,tempbh) ;

               if (dCircleRec.dMoveStartTime > Starttime+FDataTimeintVal ) and (Starttime+FDataTimeintVal*5 > dCircleRec.dMoveStartTime) then
                     Starttime:= Starttime+Trunc((dCircleRec.dMoveStartTime-Starttime)*24*60);

               insertsql( inSql +''''+ FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Starttime)+''',''' +    //GenerateTime
                           IsUsedTsupportName[j] +''',' +                                          // ValueType
                           FormatFloat('0.00',FDataSet21.FieldByName('Max'+IntToStr(j)).Asfloat) +',' +  // Max_Value,
                           FormatFloat('0.00',FDataSet21.FieldByName('MIn'+IntToStr(j)).Asfloat) +',' +  // Min_Value
                           FormatFloat('0.00',FDataSet21.FieldByName('AGV'+IntToStr(j)).Asfloat)+',' +   // Agv_Value
                           FloatToStr(DiffPercent) +',' +                                    // DiffPercent
                           IntToStr(MoveSupport)+',' +                                       // MoveSupport
                           IntToStr(Public_Basic.ReadIniTimeInterval)+',0,'+                     // TimeInterVal, process
                           Inttostr(Frequency)+','+                                         // Frequency
                           FormatFloat('0',FDataSet21.FieldByName('SuN').Asfloat)+',' +       // PointNumber
                           FormatFloat('0.00',temp_last_V)+              //last_value
                           ')'  );
               //���´�����¼
               Edit_Processrecord(uGBh,Supbh,'FirstTime',Temp_lastTime);

           end; //end for   IsUesedFieldcount
           Result:=true;
        end;
          FDataSet21.Close ;
    end ;
 finally
    //���ش������ʱ��
   if Temp_lastTime>Starttime+FDataTimeintVal then  Last_Time:= Temp_lastTime
       else  Last_Time:= Starttime+FDataTimeintVal;
 end;


end;

function TFirstDisPoseThread.MinUte_Over_SupprortPercentPress(uGBh: String;
  Supbh,FieldId: integer; Starttime: Tdatetime;
  var Frequency,MoveSupport:integer;Var EndTime:TdateTime): Boolean;
var
  Sql1:string;
  tempbh:integer;
begin
     Result:=False;
      //�����춯֮ǰ�����ֵ�� ���һ����¼��ֵ
     SQL1:=' select id,generatetime,Last_Value,Max_Value from D_'+Trim(uGBh)+'_'+IntToStr(Supbh)+'_FirstDP '+
     ' where generateTime >= '''+  FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Starttime-FDataTimeintVal-FDataTimeintVal/4)+
     ''' and  generateTime <=''' + FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Starttime-FDataTimeintVal+FDataTimeintVal/4)+ '''  and ' +
     ' ValueType= '''+IsUsedTsupportName[FieldId]+''' ';
     InidCircleRec(dCircleRec);
     if not self.SelecMax_LastValue(SQL1,dCircleRec) then  begin
       //
     end;

     SelectOneRecord(sql1,'GenerateTime','Last_Value','id',dCircleRec.dBeforeLastValueTime,dCircleRec.dBeforeLastValue,tempbh) ;
      //����֮��������֮�ڼ�¼    ͨ�� ����Ӳ����Ƽ���Ϣ
     Sql1:='  select generateTime,supportbh ,'+IsUesedFields[FieldId] +' as iValue from D_' +Trim(uGBh)+'_BasicData ' +
       ' where generatetime  >= '''+ FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Starttime)+ ''' and  generateTime<''' +
       FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Starttime+FDataTimeintVal*5 ) +'''  and FirstProcess=0  '+
       '  and supportbh= '+ IntToStr(Supbh) ;
      {ȡ��5����֮���������ݵĲ���ʱ�������ݣ�����¼�����ֵ����Сֵ}
      SelectSupportMoveRecorder(sql1,dCircleRec, dFddList);
      {ͨ���Ժ��漸�������ݵķ������ҵ��ô��Ƽܵ� ������ ������ݶ�}
      MoveSupport:=JudgeSupportMoveState(dCircleRec, dFddList);

      if MoveSupport >1 then  begin
          if SelectSupportMoveState('D_'+Trim(uGBh),Supbh, dCircleRec.dMoveStartTime,dCircleRec.dMoveEndTime) >0 then begin
             MoveSupport:=2;
             dCircleRec.dSupportState:=2;
          end else begin
             dCircleRec.dSupportState:=1;
          end;
         { ��� �ҵ��˳����� MoveSupport =2����ȥ���� ����ǧ�ﶥ��ע������
           �������ǧ�ﶥ �����ʱ��α�ע�˼�¼���򱣴�֧���Ƽ�״̬Ϊ2�����û�� ��ע ���� �����Ƽ�״̬Ϊ1

         }
          SaveSupportMoveData('D_'+Trim(uGBh),Supbh,isUsedTsupportName[FieldId],Starttime,dCircleRec);
          EndTime:=Starttime+trunc((dCircleRec.dMoveEndTime-Starttime)*24*60+1)*FDataTimeintVal;
          Frequency:=Round((dCircleRec.dMoveEndTime-Starttime)*24*60);
          if abs(Frequency)> 5 then  Frequency:=1;

      end else begin
         Frequency:=1;
         EndTime:=StartTime+FDataTimeintVal;
      end;
     Result:=True;
end;

function TFirstDisPoseThread.Minute_Supplemental_record(uGBh: String;
  Supbh: integer; inSql: String; Starttime, EndTime: Tdatetime;Var Last_Time:TdateTime): Boolean;
var
  Frequency,j:integer ;
  WhileTime,forTime,TempD:TdateTime;
  Last_value:array [0..3] of double;
  Sql1:string;
  temp_last_V:double;
  tempbh:integer;
  flag:boolean;
begin
     Result:=False;
     ForTime:=Starttime;
     flag:=true;
    try
      if forTime+FDataTimeintVal< EndTime-MinutesD/5  then begin
          for j := 0 to IsUesedFieldcount-1 do  begin
             whileTime:=forTime; Frequency:=1;
             if   FDisPose.AppointFootageStop then break;
             SQL1:=' select id,generatetime,Last_Value from D_'+Trim(uGBh)+'_'+IntToStr(Supbh)+'_FirstDP '+
                     ' where generateTime >= '''+  FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Starttime-FDataTimeintVal-FDataTimeintVal/4)+
                     ''' and  generateTime <=''' + FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Starttime-FDataTimeintVal+FDataTimeintVal/4)+ '''  and ' +
                     ' ValueType= '''+IsUsedTsupportName[j]+''' ';

            SelectOneRecord(sql1,'GenerateTime','Last_Value','id',TempD,temp_last_V,tempbh) ;
               Last_Value[j]:=temp_last_V;
               if (Last_Value[j]=0) then begin      // ���ǰ�����һ����¼Ϊ0, ��ʱ�β���¼
                 flag:=false; whileTime:= EndTime-FDataTimeintVal ;
               end else begin
                 flag:=true;
               end;

               while flag do  begin
                  if   FDisPose.AppointFootageStop then break;
                  if whileTime>=EndTime-FDataTimeintVal-MinutesD/5  then   break;
                  if whileTime>=EndTime-2*FDataTimeintVal-MinutesD/5 then begin
                    sql1:=inSql +''''+ FormatDateTime( 'yyyy-mm-dd hh:nn:ss',whileTime)+''',''' +    //GenerateTime
                             IsUsedTsupportName[j] +''',' +                                          // ValueType
                             FormatFloat('0.00',Last_Value[j]) +',' +  // Max_Value,
                             FormatFloat('0.00',Last_Value[j]) +',' +  // Min_Value
                             FormatFloat('0.00',Last_Value[j])+',' +   // Agv_Value
                             FloatToStr(0) +',' +                                    // DiffPercent
                             IntToStr(0)+',' +                                       // MoveSupport
                             IntToStr(Public_Basic.ReadIniTimeInterval)+',0,'+          // TimeInterVal, process
                             Inttostr(Frequency)+','+                                                              // Frequency
                             FormatFloat('0',-1)+','+       // PointNumber
                             FormatFloat('0.00',Last_Value[j])+              //last_value
                              ')'  ;  //
                         insertsql(sql1 );
                  end;
                  whileTime:=whileTime+FDataTimeintVal ;
                  Frequency:=Frequency+1;
               end;  //end while
           end;  //end for j

          ForTime:=whileTime;
      end ;// end if

    finally
       Last_Time:=ForTime; //��ʱ�䷵��
       Result:=true;
    end;

   
end;

function TFirstDisPoseThread.SaveStrokeDataIntoRealFootage(Fgzm: string;
  DST: PAPStroke): Boolean;
var
 sql:string;
begin
    Result:=True ;
     FADOConnect.BeginTrans ;

     Sql:=' insert into D_'+Fgzm+'_RealTimeFootage (gzmid,supportbh,Generatetime,RealFootage,Process,EditFootage,SumFootage)  ' +
     ' values ('  + FGzm +','+IntToStr(DST.supportbh )+ ',''' +  FormatDateTime( 'yyyy-mm-dd hh:nn:ss',DST.MinTime) +''',' +
     IntToStr(DST.Max_data -DST.Min_data ) +',0,0,0' + ')';
    try
      FCommand.CommandText :=sql;
      FCommand.Execute ;
      sql:=' delete from D_'+Fgzm+'_StrokeData where Supportbh = ' +IntToStr(DST.supportbh ) +
           ' and Generatetime <= '''+  FormatDateTime( 'yyyy-mm-dd hh:nn:ss',DST.Now_time)+'''';
//      sql:=' update D_'+Fgzm+'_StrokeData set process=1 where Supportbh = ' +IntToStr(DST.supportbh ) +
//           ' and Generatetime <= '''+  FormatDateTime( 'yyyy-mm-dd hh:nn:ss',DST.Now_time)+'''';
      FCommand.CommandText :=sql;
      FCommand.Execute ;
    except
      FADOConnect.RollbackTrans ;
      Result:=False;
      exit;
    end;
    FADOConnect.CommitTrans;
end;

procedure TFirstDisPoseThread.SaveSupportMoveData(table_b:string;supportbh:integer;
                 ValueType:string;GeTime:Tdatetime;dp:PFDD);
var
  sql:string;
begin
   sql:='insert into '+table_b+'_SupportMoveInfo (generatetime,Valuetype,supportbh,BeforeMovevalue,BeforemoveMaxValue,BeforeMovetimes,' +
             ' BeforeMoveGrad,Starttime,EndTime,Max_Value,Min_Value,Max_Valuetime,Min_valueTime,zhuYeEndValue,ZhuYeEndTime,zhuYetimes, '+
             ' zhuYeGrad,zhuYeReturnValue,ZhuYeReturnTimes,zhuYeReturnGrad,SupportStartPress,moveState) values ( ' +
             ''''+ FormatDateTime( 'yyyy-mm-dd hh:nn:ss',GeTime)+''',''' + ValueType +''',' +  //GenerateTime ,Valuetype
             IntToStr(supportbh)+','+FormatFloat('0.00',dp.dBeforeLastValue)+ ',' +  // supportbh,BeforeMovevalue
             FormatFloat('0.00',dp.dbeforeLastMaxValue) +',' +IntTostr(dp.dbeforeLasttimes) +',' + // BeforemoveMaxValue,BeforeMovetimes,'
             FormatFloat('0.00',dp.dbeforeLastGradient) +',' + // BeforeMoveGrad
             ''''+ FormatDateTime( 'yyyy-mm-dd hh:nn:ss',dp.dMoveStartTime)+''',' +   //  Starttime,
             ''''+ FormatDateTime( 'yyyy-mm-dd hh:nn:ss',dp.dMoveEndTime)+''',' + //  EndTime,
             FormatFloat('0.00',dp.dMaxValue) +',' +FormatFloat('0.00',dp.dMinValue) +',' + // MaxValue,MinValue
             ''''+ FormatDateTime( 'yyyy-mm-dd hh:nn:ss',dp.dMaxValueTime)+''',' +   //  Max_Valuetime,
             ''''+ FormatDateTime( 'yyyy-mm-dd hh:nn:ss',dp.dMinValueTime)+''',' + //  Min_valueTime,
             FormatFloat('0.00',dp.dzhuYeValue) +','''+ FormatDateTime( 'yyyy-mm-dd hh:nn:ss',dp.dZhuYeEndTime)+''',' +  // zhuYeEndValue,ZhuYeEndTime
             IntTostr(dp.dzhuYetimes) +',' +FormatFloat('0.00',dp.dZhuYeGradient) +',' + // zhuYetimes,zhuYeGrad
             FormatFloat('0.00',dp.dStartPressure) +',' +IntTostr(dp.dZhuYeHuZhuanTimes) +',' + // zhuYeReturnValue, ZhuYeReturnTimes,
             FormatFloat('0.00',dp.dZhuyeHuZhuanGradient) +',' +FormatFloat('0.00',dp.dStartPressure) +','+  //  zhuYeReturnGrad,SupportStartPress
             IntToStr(dp.dSupportState) + //
             ')';
   FCommand.CommandText:=sql;
   FCommand.Execute;

end;

function TFirstDisPoseThread.SelecMax_LastValue(Sql:String; dp: PFDD): Boolean;
begin
     Result:=false;
     FDataSet1.Close ;
 try
     FDataSet1.CommandText :=sql;
     if FDataSet1.Open then
         if FDataSet1.RecordCount >0    then  begin
            dp.dBeforeLastValue:=FDataSet1.FieldByName('Last_Value').AsFloat;
            dp.dbeforeLastMaxValue:=FDataSet1.FieldByName('MAX_Value').AsFloat;
            dp.dBeforeLastValueTime:=FDataSet1.FieldByName('generatetime').AsDateTime;
            Result:=True;
         end;
 finally
   FDataSet1.Close ;
 end;

end;

function TFirstDisPoseThread.SelectOneRecord(Sql, Fieldtime, FieldValue,
  FieldBh: string; var Gtime: Tdatetime; var Mvalue: double;var BBh: integer): Boolean;
begin
     Result:=false;
     Gtime:=-1;
     Mvalue:=0;
     FDataSet1.Close ;
     FDataSet1.CommandText :=sql;
     if FDataSet1.Open then
         if FDataSet1.RecordCount >0    then  begin
            Gtime:= FDataSet1.FieldByName(fieldtime).AsDateTime;
            if FieldValue<>''  then   MValue:= FDataSet1.FieldByName(fieldValue).AsFloat
              else   MValue:=0;
            if FieldBh<>'' then    BBh:=FDataSet1.FieldByName(FieldBh).AsInteger
               else BBh:=0;
            Result:=True;
         end;
      FDataSet1.Close ;

end;


function TFirstDisPoseThread.SelectStrokeData(Fgzm, FSupbh: string): Boolean;
var
 sql:string;
 Min_Time,Max_time,StepTime:TdateTime;
 Flag,Flag_end:Boolean;
 TotalCount:Integer;
begin
   Result:=True ;
   Flag:=true;Flag_end:=true;
   TotalCount:=0;
   if not  Select_StrokeMaxtime(Fgzm, FSupbh,Min_Time,Max_time) then exit;
   StepTime:=Min_Time+1/24*FDisPose.OneStepDisposeTime;
   if StepTime > Max_time then  StepTime:= Max_time;

     while (Min_Time < StepTime) and  ( Flag_end ) and
           ( StepTime <=Max_time ) do  begin
         if   FDisPose.AppointFootageStop then break;

         if JudgeStrokeData(Fgzm, FSupbh,Min_Time,stepTime) then  begin
             TotalCount:=TotalCount+dStroke.DisposeRecorder;
             SaveStrokeDataIntoRealFootage(Fgzm,dStroke);
             Flag:=false;
             //wtite processlog
              if (FDisPose.writeProcessflag) and (TotalCount > 100 )  then  begin
                insertSQl( ' insert into processlog (generatetime,DataNumber,gzmname,supportbh,minNumber, ' +
                       ' threadid,Processtype) values (''' +
                      FormatDaTeTime('yyyy-mm-dd hh:nn:ss',now())+''','+IntToStr(TotalCount)+',''' +
                      Trim(Fgzm)+''','+ Trim(FSupbh) +','+IntToStr(TotalCount mod 100)+','+
                      IntToStr(self.Handle) +',''StrokeData'')'  );
                TotalCount:=TotalCount mod 1000 ;
              end;
         end else begin
            if ( flag) and(StepTime <=Max_time) then begin
                StepTime:=StepTime+1/24*FDisPose.OneStepDisposeTime;
            end else if not Flag then  begin
                Flag_end:=false;
            end;

         end;

    end;
end;

procedure TFirstDisPoseThread.SelectSupportMoveRecorder(sql: string;dp:PFDD;dList:TList);
var
  I:integer;
begin
      for I := 0 to dList.Count - 1 do
       if Assigned(dList[i]) then  Dispose(PFDD(dList[i]));
      dList.Clear ;
     //-----
 try
    FDataSet1.Close ;
    FDataSet1.CommandText :=sql;
    if FDataSet1.Open then begin
        FDataSet1.First;
        while not FDataSet1.Eof  do  begin
           new(dFD);
           dFD.dTimeD:=FDataSet1.FieldByName('GenerateTime').AsDateTime;
           dFD.dMaxValue:=FDataSet1.FieldByName('iValue').AsFloat;
           if dFD.dMaxValue > dp. dMaxValue then begin
              dp.dMaxValue:=dFD.dMaxValue;
              dp.dMaxValuetime:=dFD.dTimeD;
           end;
          if dFD.dMaxValue < dp. dMinValue then begin
              dp.dMinValue:=dFD.dMaxValue;
              dp.dMinValuetime:=dFD.dTimeD;
           end;
           dList.Add(dFD);       //
           FDataSet1.Next;
        end;
    end;
//      dp.dLastValue:= dFD.dMaxValue;
//      dp.dLastValuetime:=dFD.dTimeD;
 finally
    FDataSet1.Close ;
 end;
end;

function TFirstDisPoseThread.SelectSupportMoveState(table_b: string;
  Supportbh: integer; Start_Time, End_Time: TdateTime): Integer;
Var
  Sql:string;
begin
    Sql:='select count(id) as Sun  from ' +table_b+'_RealTimeFootage' +
         ' where  Generatetime >= '''+  FormatDateTime('yyyy-mm-dd hh:nn:ss',Start_Time)  +'''' +
         '  and  Generatetime <= '''+  FormatDateTime('yyyy-mm-dd hh:nn:ss',End_Time)  +'''' +
         '  and  supportbh= '+IntTostr(Supportbh ) ;
    FDataSet1.Close ;
    FDataSet1.CommandText:=Sql;
    FDataSet1.Open;
    if FDataSet1.FieldByName('Sun').AsInteger >0 then
       Result:=2     else  Result:=0;

    FDataSet1.Close ;
end;

function TFirstDisPoseThread.Select_StrokeMaxtime(Fgzm, FSupbh: string;
  var Min_Time, Max_Time: TdateTime): Boolean;
var
 sql:string;
begin
   Result:=false;
   sql:=' select min(Generatetime) as Min_T, max(GenerateTime) as Max_t from D_'+
          Fgzm+ '_StrokeData where  Process =0  and supportbh='+ FSupbh ;
   FDataSet31.Close ;
   FDataSet31.CommandText:=sql;
   if FDataSet31.Open  then
       if FDataSet31.RecordCount >0  then  begin
            Min_time:= FDataSet31.FieldByName('Min_T').AsDateTime;
            Max_Time:= FDataSet31.FieldByName('Max_T').AsDateTime;
            if Max_Time > Min_time then    Result:=true ;
       end;
   FDataSet31.Close ;
end;

function TFirstDisPoseThread.SetNextChangDataTypeTime(Gzmid: integer;
  EndTime: TdateTime): Tdatetime;
var
  Sql:String;
  Max_T:TdateTime;
begin
   Result:=-1;
  try
   sql:=' select startTime as Max_t from GzmDataType  where  cqid = ' +intToStr(Gzmid) +
        ' and startTime >''' +FormatDateTime('yyyy-mm-dd hh:nn:ss',EndTime) +'''' +
        ' order by startTime  limit 1 ';
   FDataSet31.Close ;
   FDataSet31.CommandText:=sql;
   if FDataSet31.Open  then
       if FDataSet31.RecordCount >0  then  begin
          Max_T:= FDataSet31.FieldByName('Max_T').AsDateTime;
          if Max_T > 0 then
             Result:=Max_T;
       end;
  finally
    FDataSet31.Close ;
  end;
end;

end.