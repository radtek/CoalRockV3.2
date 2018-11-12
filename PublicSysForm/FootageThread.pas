unit FootageThread;

interface
uses
    Classes,uDisPoseData, GzmClass,MySQLDataSet,SysUtils,StopWatch,uDataModule,math,DateUtils,
    SyncObjs,windows, Winapi.ActiveX;

type
  PAPStroke =^TStrokeData;
  TStrokeData=packed record
     StartTime:Tdatetime;
     EndTime:TdateTime;
     supportbh:integer;
     Min_data:integer;
     Max_data:Integer;
     Now_time:TdateTime;
     Now_data:integer;
     MoveState:integer;
  end;
  PAPFootRec =^TFoot;
  TFoot= packed record
      Number:integer;
      SecondTableid:integer;
      EndTime:TdateTime;
  end;

   TFootAgeThread=class(TThread)
   private

      FDisPose:TDisposeData;
      FuGzm:TGzm;
      FAdoconn:TMySqlConnection;
      FAdoDataSet1:TMyDataSet;
      FAdoDataSet2:TMyDataSet;

      FAdoCommand:TMyCommand;
      DisposeType:String;
      FSetting:TFormatSettings;  //���ڸ�ʽת��

      dstroke:PAPStroke;
      dFdd:PAPFootRec;
      dFddList:TList;

        //Flag:integer д����  1 Ϊ ���ⲿ¼����ߣ�2 �Զ��������     3 �޶������
     function InputFootage(uGBh:string;tDay: Tdatetime; DownDayFootage,
                    SumDownFootage, UpperDayFootage, SumUpperFootage: double;Flag:integer):Boolean;

     function uAppointFootage(Fgzm,FSupbh:string):Boolean;//�������  �ѽ��߷ֵ�specondDP ��
      {�����������,��Ҫ����Footage���ݱ����б�ע����}
     function uselectTopFootAge(Fgzm,FSupbh:string;FootFlag:integer;
                               Var StTime,EdTime:TdateTime):Boolean;
     {�Զ��������,��realTimeFootage �е����ݲ��뵽footage ���ݱ���}
     function AutoCaluSupportStep(gzmid:integer):Boolean;
     {��������ǧ�ﶥ���ݲ������Ľ������}
     function AutoCaluSupportStep_Pair(gzmid:integer):Boolean;
     {�յ�¼����ߺ�,��ԭ��ͨ������ǧ�ﶥ�ϲ��Ľ��߽����޶�}
     function AdjustFootage(gzmid:integer):Boolean;
     function SelectDataTime(InputTime:TdateTime; var StartTime,EndTime:TdateTime):Boolean;
     //=============================================
     { ���� �� ͨ������ǧ�ﶥ ͳ�ƽ�������  �ĺ���}
     function SelectStrokeData(Fgzm,FSupbh:string):Boolean; {��������}
      {�������ʱ������Сʱ�亯��}
     function Select_StrokeMaxtime(Fgzm,FSupbh:string;Var Min_Time,Max_Time:TdateTime):Boolean;
     { �ж��� ��ǰʱ�� �ƶ�Һѹ֧�ܵĺ���}
     function JudgeStrokeData(Fgzm,FSupbh:string; Min_Time,Max_Time:TdateTime):boolean;
      { ��ʼ����¼��ĺ���}
     procedure initStrokeRecord(dp:PAPStroke);
      { ����������ɾ�����ݺ���}
     function SaveStrokeDataIntoRealFootage(Fgzm:string;DST:PAPStroke):Boolean;
   protected
     procedure Execute ;override;

   public
      destructor  Destroy; override;
      constructor  Create(uObjusers:TDisposeData;BaseType:string);

  end;

implementation

{ TThridhread }


{ TFootAgeThread }

function TFootAgeThread.AdjustFootage(gzmid: integer): Boolean;
var
  StTime,EdTime,T1,T2:Tdatetime;
  sql,Sql2:string;
  FsumUpperFootage,FsumDownFootAge: double;
  PSDF,PSUF,SDF,SUF:double;
  MultDF,MultUF,AGVDF,AGVUF:double;
  TempDF,TempUF:double;
  FdayFootAge,FsumDayFootage:double;
  OneFootAgeid,Twofootageid,tCout:integer;
begin
    Result:=false;
    //
    EdTime:=1;
    sql:=' select * from D_'+IntTostr(gzmid)+'_FootAge where processage=1 order by footday ' ;
    FAdoDataSet1.Close ;
    FAdoDataSet1.CommandText:=sql;
  if FAdoDataSet1.Open then begin
    FAdoDataSet1.First ;
    while not FAdoDataSet1.Eof do begin
        if FDisPose.AppointFootageStop  then  break;
        OneFootAgeid:=FAdoDataSet1.FieldByName('id').AsInteger;
        EdTime:=FAdoDataSet1.FieldByName('Footday').AsDateTime;
        FsumUpperFootage:=FAdoDataSet1.FieldByName('SumUpperFootage').AsFloat;
        FsumDownFootAge:=FAdoDataSet1.FieldByName('SumDownFootage').AsFloat;
         // ���⴦��  ����ǧ�ﶥ������
         FAdoDataSet2.Close ;
         Sql2:= ' select count(id) as Sid from D_'+  IntTostr(gzmid)+'_FootAge where processage=2  and ' +
                ' footday >= '''+ FormatDatetime('yyyy-mm-dd hh:nn:ss',EdTime) +  ''' ' ;
         FAdoDataSet2.CommandText:=sql2;
         if FAdoDataSet2.Open then
           if FAdoDataSet2.FieldByName('sid').AsInteger <1 then  break;
            //
         FAdoDataSet2.Close ;
           //�ҵ��Ѿ�У������ ��������¼
          Sql2:= ' select SumDownfootage ,SumUpperfootage from D_'+
              IntTostr(gzmid)+'_FootAge where processage=3  and ' +
              ' footday <= '''+ FormatDatetime('yyyy-mm-dd hh:nn:ss',EdTime) +
               ''' order by footday desc limit 1 ' ;
          FAdoDataSet2.CommandText:=sql2;

         if  FAdoDataSet2.Open then begin
           FAdoDataSet2.First;
            if FAdoDataSet2.RecordCount>0 then  begin
                  PSDF:= FAdoDataSet2.FieldByName('Sumdownfootage' ).AsFloat;
                  PSUF:= FAdoDataSet2.FieldByName('SumUpperfootage' ).AsFloat;
            end else begin
                  PSDF:= 0;
                  PSUF:= 0;
            end;
         end;
          FAdoDataSet2.Close ;
          //
          MultDF:=FsumDownFootAge-PSDF;
          MultUF:=FsumUpperFootage-PSUF;
          // ͳ�ƽ�Ҫ������ ����ǧ�ﶥ ����
          Sql2:= ' select sum(downfootage) as SDF,sum(upperfootage) as SUF,Count(id) as Sid from D_'+
              IntTostr(gzmid)+'_FootAge where processage=2  and ' +
              ' footday <= '''+ FormatDatetime('yyyy-mm-dd hh:nn:ss',EdTime) +
              ''' order by footday ' ;
          FAdoDataSet2.CommandText:=sql2;

          if FAdoDataSet2.Open then begin
             SDF:=FAdoDataSet2.FieldByName('SDF').AsFloat ;
             SUF:=FAdoDataSet2.FieldByName('SUF').AsFloat ;
          end;
         // tCout:=uAdoDataSet2.FieldByName('Sid').Asinteger ;
          FAdoDataSet2.Close ;
         //
           if SDF>0 then   AGVDF:=MultDF/SDF  else  AGVDF:=0;
           if SUF>0 then   AGVUF:=MultUF/SUF else  AGVUF:=0;
         //  �������ݼ�¼
          FAdoCommand.MysqlConnection.BeginTrans;
           if (AGVDF >0 ) or  (AGVUF>0 ) then  begin                      //
                    Sql2:= ' select id,downfootage,upperfootage from D_'+
                           IntTostr(gzmid)+'_FootAge where processage=2  and ' +
                           ' footday <= '''+ FormatDatetime('yyyy-mm-dd hh:nn:ss',EdTime) +
                            ''' order by footday ' ;
                    FAdoDataSet2.CommandText:=sql2;
              if FAdoDataSet2.Open then begin
                    TempDF:=PSDF;TempUF:=PSUF;
                    while not  FAdoDataSet2.Eof do  begin
                        Twofootageid:=FAdoDataSet2.FieldByName('id').AsInteger ;
                        TempDF:= TempDF+AGVDF*FAdoDataSet2.FieldByName('downfootage').AsFloat ;
                        TempUF:=TempUF+ AGVUF*FAdoDataSet2.FieldByName('Upperfootage').AsFloat ;
                        FAdoCommand.CommandText :=' update D_'+ IntTostr(gzmid)+'_FootAge  set downfootage =' +
                               FormatFloat('0.00',AGVDF*FAdoDataSet2.FieldByName('downfootage').AsFloat) + ',SumDownFootage =' +
                               FormatFloat('0.00',TempDF) +', UpperFootAge= '  +
                               FormatFloat('0.00',AGVUF*FAdoDataSet2.FieldByName('Upperfootage').AsFloat) +', SumUpperFootage =' +
                               FormatFloat('0.00',TempUF) + ',processage=3  where id = ' +intToStr(Twofootageid);
                        FAdoCommand.Execute ;
                        FAdoDataSet2.Next;
                    end;    //end while   uAdoDataSet2.eof

              end;
              FAdoDataSet2.Close ;
           end;
           //   ���´�����¼
           FAdoCommand.CommandText :=' update D_'+ IntTostr(gzmid)+'_FootAge  set processage=-1 '+
                                     ' where id = ' +intToStr(Onefootageid);
           FAdoCommand.Execute ;
           FAdoCommand.MysqlConnection.CommitTrans;
           //��һ����¼
        FAdoDataSet1.Next ;
    end; //end while  uAdoDataSet1.Eof
  end;
   FAdoDataSet1.Close ;
   Result:=true;
end;

function TFootAgeThread.AutoCaluSupportStep(gzmid: integer ): Boolean;
var
  StartSupid,EndSupid: array [0..3] of integer;
  AGVFootage: array [0..3] of double;
  StartToEndSupNumber:integer;
  inputTime,StartTime,EndTime:TdateTime;
  i:integer;
  StartsupNo,EndSupNo:integer;
begin
    Result:=false;
    //�������ݿ�����С�����֧�ܱ��
   FADODataSet2.Close;
   FADODataSet2.CommandText :=' select min(supportbh) as stbhNo,max(supportbh) as EndbhNo from D_'+
                              IntToStr(gzmid)+'_RealTimeFootage' +
                              ' where process=0 ';
   if FADODataSet2.Open then begin
       StartsupNo:=FADODataSet2.FieldByName('stbhNo').AsInteger;
       EndSupNo:=FADODataSet2.FieldByName('EndbhNo').AsInteger;
   end;
   FADODataSet2.Close;
  if (EndSupNo =0)  or (StartsupNo>=EndSupNo) then    exit;


     //���䲻ͬ����֧�ܱ�� ���� ����ֳ���������, ����֧���źŷ���Ĳ�ͬ���зֱ�ͳ��
    if EndSupNo-StartsupNo+1 >60  then  StartToEndSupNumber:=20
           else    StartToEndSupNumber:= round((EndSupNo-StartsupNo) /3);
    if FuGzm.SupNumberDirection=0 then   begin
       StartSupid[0]:=StartsupNo;
       EndSupid[0]:=StartsupNo+StartToEndSupNumber;
       StartSupid[1]:=EndSupNo-StartToEndSupNumber;
       EndSupid[1]:=EndSupNo;
    end else begin
       StartSupid[0]:=EndSupNo-StartToEndSupNumber;
       EndSupid[0]:=EndSupNo;
       StartSupid[1]:=StartsupNo;
       EndSupid[1]:=StartsupNo+StartToEndSupNumber;
    end;

    //������ʽѭ��

    while True do  begin
        if   FDisPose.AppointFootageStop then break;    // ��һ���˳�ѭ���ķ�ʽ
         FADODataSet2.Close;
         FADODataSet2.CommandText :=' select min(Generatetime) as st from D_'+IntToStr(gzmid)+'_RealTimeFootage' +
                                    ' where process=0 ';

         if FADODataSet2.Open then
            inputTime:= FADODataSet2.FieldByName('st').AsDateTime;
         FADODataSet2.Close;
         //��ȡ��ʼʱ�������ʱ��ڵ�
         SelectDataTime(inputTime,StartTime,EndTime);
        //�������û�м�¼��֤���ý׶�û�н������������
         FADODataSet2.Close;
         FADODataSet2.CommandText :=' select count(id) as Td  from D_'+IntToStr(gzmid)+'_RealTimeFootage' +
                                    ' where process=0  and Generatetime > '''+
                                    FormatDateTime('yyyy-mm-dd hh:nn:ss',EndTime)  +'''';
         if FADODataSet2.Open then
             if FADODataSet2.FieldByName('Td').AsInteger < 10 then   begin
                 FADODataSet2.Close;break;     // ��2���˳�ѭ���ķ�ʽ
             end;
         FADODataSet2.Close;
        //
        for I := 0 to 1 do  begin
            FADODataSet2.Close;
            FADODataSet2.CommandText :=' select Sum(RealFootage)  SumT  from D_'+IntToStr(gzmid)+'_RealTimeFootage' +
                       ' where process=0  and Generatetime >= '''+  FormatDateTime('yyyy-mm-dd hh:nn:ss',StartTime)  +'''' +
                       '  and  Generatetime < '''+  FormatDateTime('yyyy-mm-dd hh:nn:ss',EndTime)  +'''' +
                       '  and  supportbh>= '+IntTostr(StartSupid[i] ) +' and supportbh <= ' +
                       IntTostr(EndSupid[i] ) ;
             if FADODataSet2.Open then
                 if FADODataSet2.FieldByName('SumT').AsFloat >=1 then   begin
                    AGVFootage[i]:= FADODataSet2.FieldByName('SumT').AsFloat/(EndSupid[i]-StartSupid[i]+1) /1000;
                 end else begin
                    AGVFootage[i]:=0;
                 end;
        end;

         if  InputFootage( IntToSTr(gzmid),EndTime,AGVFootage[0],0,AGVFootage[1],0,2)  then begin
               FAdoCommand.CommandText:=' update   D_'+IntToStr(gzmid)+'_RealTimeFootage set process=1 ' +
               ' where Generatetime >= '''+  FormatDateTime('yyyy-mm-dd hh:nn:ss',StartTime)  +'''' +
               '  and  Generatetime < '''+  FormatDateTime('yyyy-mm-dd hh:nn:ss',EndTime)  +'''';
               FAdoCommand.Execute ;
         end;



        FADODataSet2.Close;

    end; //end while

    Result:=true;

end;

function TFootAgeThread.AutoCaluSupportStep_Pair(gzmid: integer): Boolean;
var
  StartToEndSupNumber,HalfNumber:integer;
  inputTime,StartTime,EndTime:TdateTime;
  i,LegalNumber:integer;
  StartsupNo,EndSupNo:integer;
  LeftSumData,LeftAVGData,RightSumData,RightAVGData:double;
  SupporbhStep:double;
  MaxTime:TdateTime;
begin
    Result:=false;
    //�������ݿ�����С�����֧�ܱ��
     FADODataSet2.Close;
     FADODataSet2.CommandText :=' select min(supportbh) as stbhNo,max(supportbh) as EndbhNo,min(Generatetime) as st,' +
                                ' max(Generatetime) as Mt from D_'+IntToStr(gzmid)+'_RealTimeFootage' +
                                ' where process=0 ';
     if FADODataSet2.Open then  begin
         if FADODataSet2.RecordCount >0 then  begin
            inputTime:= FADODataSet2.FieldByName('st').AsDateTime;
            StartsupNo:=FADODataSet2.FieldByName('stbhNo').AsInteger;
            EndSupNo:=FADODataSet2.FieldByName('EndbhNo').AsInteger;
            maxTime:=FADODataSet2.FieldByName('Mt').AsDateTime;
         end else begin
             exit;
         end;
     end else begin
        exit;
     end;
     FADODataSet2.Close;
    if (EndSupNo =0)  or (EndSupNo-StartsupNo <(FuGzm.SupEndUsedNumber-FuGzm.SupStartNumber)/2)  then    exit;
    //��˳�۵Ľ����ۼ�
    while (inputTime < maxTime-1) do  begin
            if   FDisPose.AppointFootageStop then break;    // ��һ���˳�ѭ���ķ�ʽ
            HalfNumber:=Round( (EndSupNo-StartsupNo+1)/2);
            LegalNumber:=0; LeftSumData:=0; LeftAVGData:=0;
           //��ȡ��ʼʱ�������ʱ��ڵ�
            SelectDataTime(inputTime,StartTime,EndTime);
            for I := StartsupNo to EndSupNo do   begin
                if   FDisPose.AppointFootageStop then break;    // ��һ���˳�ѭ���ķ�ʽ
                 //�������û�м�¼��֤���ý׶�û�н������������
                 FADODataSet2.Close;
                 FADODataSet2.CommandText :=' select count(id) as Td  from D_'+IntToStr(gzmid)+'_RealTimeFootage' +
                                            ' where process=0  and supportbh= '+ IntTostr(i)+' and Generatetime > '''+
                                            FormatDateTime('yyyy-mm-dd hh:nn:ss',EndTime)  +'''';
                 if FADODataSet2.Open then
                    if FADODataSet2.FieldByName('Td').AsInteger < 1 then   continue;
                 FADODataSet2.Close;
                 FADODataSet2.CommandText :=' select Sum(RealFootage)  SumT  from D_'+IntToStr(gzmid)+'_RealTimeFootage' +
                               ' where process=0  and Generatetime >= '''+  FormatDateTime('yyyy-mm-dd hh:nn:ss',StartTime)  +'''' +
                               '  and  Generatetime < '''+  FormatDateTime('yyyy-mm-dd hh:nn:ss',EndTime)  +'''' +
                               '  and  supportbh = '+IntTostr(i );
                 if FADODataSet2.Open then
                    SupporbhStep:=FADODataSet2.FieldByName('SumT').AsFloat;
                 FADODataSet2.Close;
                 if (SupporbhStep> 6000) or (SupporbhStep <=0 ) then   continue;     //������һСʱһ��

                 if LegalNumber=0 then LeftAVGData:= SupporbhStep;
                 if SupporbhStep < LeftAVGData*3 then  begin //�ѳ����쳣������ɾ��
                    // ��ʼ����
                     LegalNumber:=LegalNumber+1;
                     LeftSumData:= LeftSumData+SupporbhStep;
                     LeftAVGData:=LeftSumData/LegalNumber;
                 end;

                 if LegalNumber>= halfNumber/4 then  break;

            end;
              if LegalNumber>0  then  LeftAVGData:=LeftSumData/LegalNumber/1000
                else LeftAVGData:=0;

            //��˳�۵Ľ����ۼ�
             LegalNumber:=0; RightSumData:=0; RightAVGData:=0;
            for I := EndsupNo downto StartSupNo do   begin
                if   FDisPose.AppointFootageStop then break;    // ��һ���˳�ѭ���ķ�ʽ

                //�������û�м�¼��֤���ý׶�û�н������������
                 FADODataSet2.Close;
                 FADODataSet2.CommandText :=' select count(id) as Td  from D_'+IntToStr(gzmid)+'_RealTimeFootage' +
                                            ' where process=0  and supportbh= '+ IntTostr(i)+' and Generatetime > '''+
                                            FormatDateTime('yyyy-mm-dd hh:nn:ss',EndTime)  +'''';
                 if FADODataSet2.Open then
                    if FADODataSet2.FieldByName('Td').AsInteger < 1 then   continue;
                 FADODataSet2.Close;
                 FADODataSet2.CommandText :=' select Sum(RealFootage)  SumT  from D_'+IntToStr(gzmid)+'_RealTimeFootage' +
                               ' where process=0  and Generatetime >= '''+  FormatDateTime('yyyy-mm-dd hh:nn:ss',StartTime)  +'''' +
                               '  and  Generatetime < '''+  FormatDateTime('yyyy-mm-dd hh:nn:ss',EndTime)  +'''' +
                               '  and  supportbh = '+IntTostr(i );
                 if  FADODataSet2.Open then
                    SupporbhStep:=FADODataSet2.FieldByName('SumT').AsFloat;
                 FADODataSet2.Close;
                 if (SupporbhStep> 6000) or (SupporbhStep <=0 ) then   continue;     //������һСʱһ��
                 if LegalNumber=0 then RightAVGData:= SupporbhStep;
                 if SupporbhStep < RightAVGData*3 then  begin  //�ѳ����쳣������ɾ��
                    // ��ʼ����
                     LegalNumber:=LegalNumber+1;
                     RightSumData:= RightSumData+SupporbhStep;
                     RightAVGData:=RightSumData/LegalNumber;
                 end;
                 if LegalNumber>= halfNumber/4 then  break;
            end;
             if LegalNumber>0  then     RightAVGData:=RightSumData/LegalNumber/1000
                else  RightAVGData:=0;
            

           if (LeftAVGData>0)  or (RightAVGData>0) then   begin
                if  InputFootage( IntToSTr(gzmid),EndTime,LeftAVGData,0,RightAVGData,0,2)  then begin
                   FAdoCommand.CommandText:=' update   D_'+IntToStr(gzmid)+'_RealTimeFootage set process=1 ' +
                   ' where Generatetime >= '''+  FormatDateTime('yyyy-mm-dd hh:nn:ss',StartTime)  +'''' +
                   '  and  Generatetime < '''+  FormatDateTime('yyyy-mm-dd hh:nn:ss',EndTime)  +'''';
                   FAdoCommand.Execute ;
                end;
           end else begin
                 FAdoCommand.CommandText:=' update   D_'+IntToStr(gzmid)+'_RealTimeFootage set process=1 ' +
                   ' where Generatetime >= '''+  FormatDateTime('yyyy-mm-dd hh:nn:ss',StartTime)  +'''' +
                   '  and  Generatetime < '''+  FormatDateTime('yyyy-mm-dd hh:nn:ss',EndTime)  +'''';
                 FAdoCommand.Execute ;
           end;
        inputTime:=inputTime+1/24*4;
    end; //end while
    Result:=true;

end;

constructor TFootAgeThread.Create(uObjusers: TDisposeData; BaseType: string);
var
  v1,v2,v3,v4:integer;
begin
     Inherited  Create(true) ; //�̳� ������ ������ ֻ�з���Resum������
     CoInitialize(Nil);
     FreeOnTerminate := True;

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

     FuGzm:=TGzm.Create(FAdoconn) ;
     DisposeType:=BaseType;

     //
     //���ڸ�ʽת��
       FSetting.ShortDateFormat:='yyyy-mm-ss' ;
       FSetting.DateSeparator :='-';
       FSetting.ShortTimeFormat :='hh:nn:ss';
       FSetting.TimeSeparator :=':';
       FSetting.DecimalSeparator :='.';
       //
     dFddList:=Tlist.Create;
     new(dStroke);
end;

destructor TFootAgeThread.Destroy;
var
  i:integer;
begin

      freeandNil(FuGzm);
      freeandNil(FAdoDataSet1);
      freeandNil(FAdoDataSet2);
      freeandNil(FAdoCommand);
      freeandNil(FAdoconn);
      //
      for I := 0 to dFddList.Count - 1 do
         if Assigned(dFddList[i]) then  Dispose(PFDD(dFddList[i]));
      freeandNil(dFddList);
      //
      if Assigned(dStroke) then Dispose(dStroke);
       CoUninitialize;
       inherited Destroy;
end;

procedure TFootAgeThread.Execute;
var
  i,t:integer;
  GzmList:TStringlist;
  FGzmid:integer;
begin
  inherited;
   {ToDO:������־�ļ�}
 try
  FAdoCommand.CommandText:=' delete  from processlog where generatetime <='''+
       FormatDatetime('yyyy-mm-dd hh:nn:ss',now-2) +'''' ;
  FAdoCommand.Execute ;

  //
  GzmList:=TStringlist.Create ;
  FAdoDataSet1.Close ;
  FAdoDataSet1.CommandText:='select cqid from cqcsb where qyzt=1';
  if FAdoDataSet1.Open then
       while not FAdoDataSet1.Eof  do  begin
          GzmList.Add(Trim(IntToStr(FAdoDataSet1.FieldByName('cqid').AsInteger)));
          FAdoDataSet1.Next ;
       end; //end while not DataSetGzm.Eof
   FAdoDataSet1.Close ;

   //
   for t := 0 to GzmList.Count - 1 do  begin
        if FDisPose.AppointFootageStop   then   break;
        FGzmid:=StrToInt(GzmList[t]);
        if DisposeType='CountFootage' then  begin
          { �ò��ּ�������� ��һ�δ�����ǰ��.��Ҫ�Ƕ� �Ƽ���Ϣ���ж� 201711}
          if not FuGzm.InputGzmData(FGzmid)  then break;
          for i :=FuGzm.SupStartNumber to FuGzm.SupEndUsedNumber do  begin
                 if FDisPose.AppointFootageStop   then   break;
                  SelectStrokeData(IntTostr(FGzmid),IntToStr(i)) ;
          end;
            // AutoCaluSupportStep(FGzmid); //�Զ����� ͨ��ǧ�ﶥ �ۼƺ������
          AutoCaluSupportStep_Pair(FGzmid);
          AdjustFootage(FGzmid); // ͨ���ֶ�¼��Ľ���,������� �ۼƵ�ǧ�ﶥ����

        end else if DisposeType='AppointFootage' then begin
              if not FuGzm.InputGzmData(FGzmid)  then break;
              if not FuGzm.FillDataType_SupportType(FGzmid) then  break;
                 { �ò��ִ��� ��Ҫ ����֧������ǧ�ﶥ ͳ����ɺ�,���� �� ���ø��߳�ʱ,
                   ���˲����е�һ���߳����е��ж�.
                 }
                 AutoCaluSupportStep_Pair(FGzmid);
                 AdjustFootage(FGzmid); // ͨ���ֶ�¼��Ľ���,������� �ۼƵ�ǧ�ﶥ����
              for i :=FuGzm.SupStartNumber to FuGzm.SupEndUsedNumber do  begin
                 if FDisPose.AppointFootageStop   then   break;
                  uAppointFootage(IntTostr(FGzmid),IntToStr(i)) ;
              end;
        end;
   end;
 finally
     FreeAndNil(GzmList) ;
 end;
end;

procedure TFootAgeThread.initStrokeRecord(dp: PAPStroke);
begin
    dp.StartTime:=-1;
    dp.EndTime :=-1;
    dp.supportbh :=0;
    dp.Min_data :=100000;
    dp.Max_data :=0;
    dp.Now_time:=-1;
    dp.Now_data:=0;
    dp.MoveState:=0;

end;

function TFootAgeThread.InputFootage(uGBh: string; tDay: Tdatetime;
  DownDayFootage, SumDownFootage, UpperDayFootage, SumUpperFootage: double;
  Flag: integer): Boolean;
Var
   CSql:String;
   DownS,UpperS:double;
begin
    if DownDayFootage<0 then   DownDayFootage:=0.0;
    if SumDownFootage<0 then   SumDownFootage:=0.0;
    if UpperDayFootage<0 then  UpperDayFootage:=0.0;
    if SumUpperFootage<0 then  SumUpperFootage:=0.0;



    Result:=false;
    DownS:=0;UpperS:=0;
     CSql:='select * from D_'+uGBh+'_Footage where footday <= '''
             + FormatDateTime( 'yyyy-mm-dd hh:nn',tDay)  +'''  order by footday desc limit 1';
     FAdoDataSet1.Close ;
     FAdoDataSet1.CommandText :=Csql;

     if FAdoDataSet1.Open  then
         if FAdoDataSet1.RecordCount >0 then  begin
            DownS:=FAdoDataSet1.FieldByName('SumDownFootage').AsFloat ;
            UpperS:=FAdoDataSet1.FieldByName('SumUpperFootage').AsFloat ;
         end;
      FAdoDataSet1.Close ;
      if DownS<0 then  DownS:=0;   if UpperS<0 then  UpperS:=0;


     // insert
     if SumDownFootage<=0 then   SumDownFootage:= DownS+DownDayFootage;
     if SumUpperFootage<=0 then   SumUpperFootage:= UpperS+UpperDayFootage;
     if (not isNaN(DownDayFootage) ) and (not  isNaN(SumDownFootage) ) and
        (not isNaN(SumUpperFootage))  and  (not isNaN(UpperDayFootage))  then begin
         CSql:='insert into d_'+uGBh+'_footage ( footday,downfootage,sumdownfootage,upperfootage, '+
               'sumupperfootage,processage) values (' +
               ''''+ FormatDateTime( 'yyyy-mm-dd hh:nn',tDay)+''','+
               FormatFloat('0.00',DownDayFootage)+','+ FormatFloat('0.00',SumDownFootage)+','+
               FormatFloat('0.00',UpperDayFootage)+','+ FormatFloat('0.00',SumUpperFootage) +
               ', '+IntToStr(Flag)+')';
          FAdoCommand.CommandText:=Csql;
          FAdoCommand.Execute  ;
        end;

     Result:=true;
end;

function TFootAgeThread.JudgeStrokeData(Fgzm, FSupbh: string; Min_Time,
  Max_Time: TdateTime): boolean;
var
  sql:string;
begin
   Result:=false;
   initStrokeRecord(dStroke);
   dStroke.supportbh:=StrToInt(FSupbh);
   sql:=' select * from D_'+ Fgzm+ '_StrokeData where  Process =0  and supportbh='+ FSupbh  +
          ' and GenerateTime>='''+  FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Min_Time)  +''' '+
          ' and GenerateTime<='''+  FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Max_Time)  +''' ' +
          ' order by GenerateTime';
   FADODataSet2.Close ;
   FADODataSet2.CommandText:=sql;
 if FADODataSet2.Open  then begin
   dStroke.StartTime :=FADODataSet2.FieldByName('GenerateTime').AsDateTime ;

   while not FADODataSet2.Eof  do  begin
     dStroke.Now_data:=Round(FADODataSet2.FieldByName('DataValue').AsFloat);
     dStroke.Now_time:= FADODataSet2.FieldByName('GenerateTime').AsDateTime ;

      if dStroke.Min_data >= dStroke.Now_data then  begin
         dStroke.Min_data:= dStroke.Now_data;
         dStroke.EndTime:=  dStroke.Now_time;
      end;
      if dStroke.Max_data < dStroke.Now_data then  begin
          dStroke.Max_data:= dStroke.Now_data;
          dStroke.StartTime := dStroke.Now_time;
      end;

      if dStroke.Now_data >300 then   dStroke.MoveState:=1;

      if (dStroke.MoveState >0 )  and (dStroke.Min_data < dStroke.Now_data ) and
         (dStroke.Max_data > dStroke.Now_data  ) and ( dStroke.Min_data <200) and
         (dStroke.Now_data >200) and (dStroke.EndTime > dStroke.StartTime) then   begin
           Result:=true;
           break;
         end;
     FADODataSet2.Next ;
   end;
 end;
 FADODataSet2.Close ;
end;

function TFootAgeThread.SaveStrokeDataIntoRealFootage(Fgzm: string;
  DST: PAPStroke): Boolean;
var
 sql:string;
begin
    Result:=True ;
     FAdoconn.BeginTrans ;

     Sql:=' insert into D_'+Fgzm+'_RealTimeFootage (gzmid,supportbh,Generatetime,RealFootage,Process,EditFootage,SumFootage)  ' +
     ' values ('  + FGzm +','+IntToStr(DST.supportbh )+ ',''' +  FormatDateTime( 'yyyy-mm-dd hh:nn:ss',DST.EndTime) +''',' +
     IntToStr(DST.Max_data -DST.Min_data ) +',0,0,0' + ')';
    try
      FAdoCommand.CommandText :=sql;
      FAdoCommand.Execute ;
      sql:=' delete from D_'+Fgzm+'_StrokeData where Supportbh = ' +IntToStr(DST.supportbh ) +
           ' and Generatetime <= '''+  FormatDateTime( 'yyyy-mm-dd hh:nn',DST.Now_time)+'''';
//      sql:=' update D_'+Fgzm+'_StrokeData set process=1 where Supportbh = ' +IntToStr(DST.supportbh ) +
//           ' and Generatetime < '''+  FormatDateTime( 'yyyy-mm-dd hh:nn:ss',DST.Now_time)+'''';
      FAdoCommand.CommandText :=sql;
      FAdoCommand.Execute ;
    except
      FAdoconn.RollbackTrans ;
      Result:=False;
      exit;
    end;
    FAdoconn.CommitTrans;

end;

function TFootAgeThread.SelectDataTime(InputTime: TdateTime; var StartTime,
  EndTime: TdateTime): Boolean;
var
   AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word;
   i :integer;
begin
      DecodeDateTime( InputTime, AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond) ;
      for I := 0 to 5 do   begin
            if (AHour >=i*4)  and (AHour<(i+1)*4) then  begin
             StartTime:=StrToDateTime(FormatDateTime('yyyy-mm-dd',InputTime)+' '+IntTostr(i*4)+':00:00',FSetting);
             if i=5 then  begin
                EndTime:=StrToDateTime(FormatDateTime('yyyy-mm-dd',InputTime+1)+' 00:00:00',FSetting);
             end else begin
                EndTime:=StrToDateTime(FormatDateTime('yyyy-mm-dd',InputTime)+' '+IntTostr((i+1)*4)+':00:00',FSetting);
             end;
          end;


      end;

end;
//


function TFootAgeThread.SelectStrokeData(Fgzm, FSupbh: string): Boolean;
var
 sql:string;
 Min_Time,Max_time:TdateTime;
 Flag:Boolean;
begin
    Flag:=True;
    while (Flag) and (Select_StrokeMaxtime(Fgzm, FSupbh,Min_Time,Max_time)) do  begin
         if   FDisPose.AppointFootageStop then break;
         Flag:=JudgeStrokeData(Fgzm, FSupbh,Min_Time,Max_time);
         if Flag then  begin
            // ��������
            Flag:=SaveStrokeDataIntoRealFootage(Fgzm,dStroke);
         end;

    end;
   Result:=True ;
end;

function TFootAgeThread.Select_StrokeMaxtime(Fgzm, FSupbh: string; var Min_Time,
  Max_Time: TdateTime): Boolean;
var
 sql:string;
begin
   Result:=false;
   sql:=' select min(Generatetime) as Min_T, max(GenerateTime) as Max_t from D_'+
          Fgzm+ '_StrokeData where  Process =0  and supportbh='+ FSupbh ;
   FADODataSet2.Close ;
   FADODataSet2.CommandText:=sql;
   if FADODataSet2.Open then
       if FADODataSet2.RecordCount >0  then  begin
            Min_time:= FADODataSet2.FieldByName('Min_T').AsDateTime;
            Max_Time:= FADODataSet2.FieldByName('Max_T').AsDateTime;
            if Max_Time > Min_time then    Result:=true ;
       end;
   FADODataSet2.Close ;

end;

function TFootAgeThread.uAppointFootage(Fgzm, FSupbh: string): Boolean;
var
  StTime,EdTime,T1,T2:Tdatetime;
  supbh:integer;
  sql,Sql2:string;
  FupperFootage,FdownFootage,FsumUpperFootage,FsumDownFootAge: double;
  FdayFootAge,FsumDayFootage:double;
  FootFlag,i:integer;
  temp_dFdd:PAPFootRec;
  Field_i:integer;
begin
    Result:=false;
    EdTime:=1;
    FootFlag:=3;
  try
    while uselectTopFootAge(Fgzm,Fsupbh,FootFlag,stTime,EdTime) do begin   // �ѵ���ļ�¼ ���з���
      if   FDisPose.AppointFootageStop then break;

        supbh:= StrToInt(Fsupbh);
        sql:=' select * from D_'+Fgzm+'_FootAge where  Processage >0  and '+
              ' Footday >='''+ FormatDatetime('yyyy-mm-dd hh:nn:ss',stTime) +
              ''' and Footday < '''+ FormatDatetime('yyyy-mm-dd hh:nn:ss',EdTime) +'''' ;
        FADODataSet2.Close ;
        FADODataSet2.CommandText :=sql;
     if FADODataSet2.Open then begin
        T1:=stTime;T2:=stTime;
        if FADODataSet2.RecordCount<1 then  begin
           exit;
           FADODataSet2.Close ;
        end;

           while not FADODataSet2.Eof  do  begin
              T1:=T2;
              if FADODataSet2.RecNo =FADODataSet2.RecordCount  then
                 T2:=Edtime else    T2:=FADODataSet2.FieldByName('Footday').AsDateTime;

               FupperFootage:=FADODataSet2.FieldByName('UpperFootage').AsFloat ;
               FdownFootage:= FADODataSet2.FieldByName('DownFootage').AsFloat ;
               FsumUpperFootage:= FADODataSet2.FieldByName('SumUpperFootage').AsFloat ;
               FsumDownFootAge:=  FADODataSet2.FieldByName('SumDownFootage').AsFloat ;
               FootFlag:= FADODataSet2.FieldByName('ProcessAge').Asinteger ;
               FSumUpperFootage:=FSumUpperFootage-FUpperFootAge;
               FsumDownFootAge:=FsumDownFootAge-FDownFootage;
                if FuGzm.SupNumberDirection=0 then  begin
                  FdayFootAge:=FupperFootage+(FDownFootage-FupperFootage)/(FuGzm.SupEndUsedNumber-FuGzm.SupStartNumber) *supbh;
                  FsumDayFootage:= FsumUpperFootage+(FsumDownFootage-FsumUpperFootage)/(FuGzm.SupEndUsedNumber-FuGzm.SupStartNumber) *supbh;

                end else begin
                  FdayFootAge:=FupperFootage+(FDownFootage-FupperFootage)/(FuGzm.SupEndUsedNumber-FuGzm.SupStartNumber)
                               *(FuGzm.SupEndUsedNumber-supbh);
                  FsumDayFootage:= FsumUpperFootage+(FsumDownFootage-FsumUpperFootage)/(FuGzm.SupEndUsedNumber-FuGzm.SupStartNumber)
                               *(FuGzm.SupEndUsedNumber-supbh);
                end;
                 // //�����ڴ�
                for Field_i := 0 to FuGzm.IsUesedsupFieldcount-1 do  begin
                  for I := 0 to dFddList.Count - 1 do
                    if Assigned(dFddList[i]) then  Dispose(PFDD(dFddList[i]));
                     dFDDList.Clear ;

                 sql2:='select id,Endtime,typedata from D_'+Fgzm+'_SecondDP  where Endtime > '' '+FormatDatetime('yyyy-mm-dd hh:nn:ss',T1) +
                     ''' and Endtime <= '''+ FormatDatetime('yyyy-mm-dd hh:nn:ss',T2) +''' and supportbh='+FSupbh+
                     ' and typedata= '''+FuGzm.IsUesedsupFieldName[Field_i] +''' order by Endtime' ;

                  FAdoDataSet1.Close ;
                  FAdoDataSet1.CommandText:=sql2;
                  if FAdoDataSet1.Open then
                      if FAdoDataSet1.RecordCount >=1 then  begin
                            //�ֽ���
                              FdayFootAge:=FdayFootAge/FAdoDataSet1.RecordCount ;
                              while not FAdoDataSet1.Eof do   begin
                                    new(dFDD);
                                    dFDD.Number:=FAdoDataSet1.RecNo;
                                    dFDD.EndTime :=FAdoDataSet1.FieldByName('Endtime').AsDateTime;
                                    dFDD.SecondTableid:=FAdoDataSet1.FieldByName('id').AsInteger;
                                    dFDDList.Add(dFDD);
                                    FAdoDataSet1.Next ;
                              end;  //end while  ExQuery
                              FAdoDataSet1.Close ;
                              //----
                              FADoCommand.MysqlConnection.BeginTrans ;
                              for I := 0 to dFDDList.Count -1 do  begin
                                   temp_dFdd:=PAPFootRec(dFDDList.Items[i]);
                                   FADoCommand.CommandText:=' update  D_'+Fgzm+'_SecondDP  set FootAge=' +
                                               FloatToStr(FsumDayFootage+FdayFootAge*temp_dFdd.Number ) +
                                               ',FootAgeFlag = '+ IntToStr(FootFlag) +
                                               ' where id=  '+ intToStr(temp_dFdd.SecondTableid) ;
                                   FADoCommand.Execute ;
                              end;
                              FADoCommand.MysqlConnection.CommitTrans ;
                      end else begin// end if if uAdoQuery.RecordCount >=1 then  begin
                         FAdoDataSet1.Close ;
                      end;
                end;
              FADODataSet2.Next;
            end;   //end while ExDataSet2

        end;
       FADODataSet2.Close ;
     end; //while uselectTopFootAge(Fgzm,Fsupbh,stTime)
  except
      exit;
  end;
     Result:=true;

end;

function TFootAgeThread.uselectTopFootAge(Fgzm, FSupbh: string; FootFlag:integer;
             var StTime,EdTime: TdateTime): Boolean;
var
  max_Time,DTime:TdateTime;
  sql:string;
begin
    Result:=false;
    //����footage ��ע3 ������¼ʱ��
     sql:=' select max(footday) as max_time from D_'+Fgzm+'_FootAge where  Processage =3  ';
     FADODataSet2.Close ;
     FADODataSet2.CommandText :=sql;
     if FADODataSet2.Open then
        max_Time:=FADODataSet2.FieldByName('max_time').AsDateTime;
     FADODataSet2.Close ;
     // ���� _SecondDP ���� ���ݱ��С�� 3�ļ�¼ ���� ��ע     ��ע 2 Ϊ ʹ��û��ͨ�� �޶��Ľ��߽��еļ���
     // ��ע3 Ϊ ͨ��ʹ�õĽ��߽��м���   ��ע 1 Ϊʹ��ԭʼ ¼����߽��м���  ��ע 0 Ϊû�н���
     sql:=' select max(Endtime) as edtime from D_'+Fgzm+'_SecondDP where ( footageFlag =2  ' +
          ' or  footageFlag =1 )  and supportbh='+ FSupbh ;
    FADODataSet2.Close ;
    FADODataSet2.CommandText :=sql;
    if FADODataSet2.Open then
       EdTime:=FADODataSet2.FieldByName('edtime').AsDateTime;
    FADODataSet2.Close ;
    if EdTime < max_Time then   begin   // �������ݵĸ��� ����� ������ �޶����ߵ�2 ��û�б�ע���ߵ�
       sql:=' select max(Endtime) as edtime,min(endtime) as stTime from D_'+Fgzm+'_SecondDP where footageFlag < 3' +
            '  and supportbh='+ FSupbh ;

    end else begin    // ֻ����û�б�ע���ߵ�
        sql:=' select max(Endtime) as edtime,min(endtime) as stTime from D_'+Fgzm+'_SecondDP where footageFlag  =0 ' +
            '  and supportbh='+ FSupbh ;
    end;
    FADODataSet2.CommandText :=sql;
    if FADODataSet2.Open then begin
       stTime:=FADODataSet2.FieldByName('stTime').AsDateTime;
       EdTime:=FADODataSet2.FieldByName('edtime').AsDateTime;
    end;

    if EdTime > stTime then Result:=true;

    FADODataSet2.Close ;
end;

end. // end unit