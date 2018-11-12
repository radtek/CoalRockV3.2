unit SupportWeightClass;

interface
uses
  Winapi.Windows,System.SysUtils, System.Classes,
  Vcl.StdCtrls,SQLiteTable3,Vcl.ComCtrls, Vcl.Graphics,System.StrUtils;

type
    // 液压支架结构选型的类
   TData_Vaule=Class
      workfaceInfoid:integer;
      supportInfoid:integer;
      RowNumber:integer;
      ColNumber:integer;
      value:double;
   End;

   TData_Type=Class (TData_Vaule)
      id:integer;
      Name:string;
      BianMa:string;
      Number:integer;
      AGV_Value:double;

   End;

   TKCJSTJ_Second=Class(TData_Type)
       Child_Third:Array of TData_Type;
       Child_count:integer;
       selected:integer;
       procedure SetChildCount(Value:integer);
       procedure FillBasicData;
       constructor Create;
       destructor Destroy;
   End;

   TKCJSTJ_First=Class(TData_Type)
       Child_Second:Array of TKCJSTJ_Second;
       Child_count:integer;

       procedure SetChildCount(Value:integer);
       procedure FillBasicData;
       constructor Create;
       destructor Destroy;
   End;

   TSupport_Second= Class(TData_Type)
       Child_Third:array of TData_Type;
       Child_Count:integer;
       Firstid,Secondid:integer;
       Selected:integer;
       procedure SetChildCount(Value:integer);
       procedure FillBasicData;
       procedure SelectFisrtAndSecondData;

       constructor Create;
       destructor Destroy;
   End;

   TSupport_First=Class(TData_Type)
     Child_Second:array of TSupport_Second;
     Used_Workface_Class:TKCJSTJ_First;
     Child_count:integer;

      procedure SetChildCount(Value:integer);
      procedure FillBasicData;
      procedure CalcuteAGV_Value;

      constructor Create;
      destructor Destroy;

   End;



   TSupportWeight=Class
         SupportInfo:TSupport_First;
         WorkFaceInfo:TKCJSTJ_First;
         Data_Value:array of TData_Vaule;
         coefficient_Value:array of TData_Vaule;
         Data_Value_Count:Integer;
         coefficient_Count:integer;

      private

         procedure SetDataValueCount(Value:integer);  //给专家打分的类组赋值
         procedure ExtractFormExData;     //   从外部数据库 抽取专家打分数据
         procedure ExtractFromSqlite;       // 从本地数据库抽取专家打分数据
         function  ExDatawithoutData:Boolean; // 判断外部数据库是否有专家打分数据
         procedure AddCoefficientValue(Wid,Sid:integer;Value:double);// 给系数类组 赋值函数
         procedure ClearClass_Data_ValueClass;  // 清专家打分数据类组到的数值

         function SelectData_Value(Wid,Sid:integer):double; // 寻找专家打分类组 制定下标的数值
         function SelectCoeff_Value(Wid,Sid:integer):double; // 寻找系数类组制定下标的数值
         procedure SaveValueIntoExData;  //保存数据到 外部数据库
         procedure SaveValueSqlite;//保存数据到sqlite 外部数据库

      public
         //
          procedure AddDataValue(Wid,Sid,Row,Col:integer;Value:double);
          procedure SaveDataIntoDataBase;  //把专家打分的数据保存到数据库
          procedure FillCoeFFicientData;  //填充地质条件系数
          procedure Set_KCJSCS_String(value:AnsiString);//把PStope传过来的字符串进拆分
          procedure MakeCoeffWithAVGVAlue;  //制作地质系数与 结构件得数所有数据
          procedure ExtractDataFromDataBase; // 从数据库中抽取数据
          procedure FillSupportWeight;  // 填充支架主演参数列表
          procedure WithoutOptionMakeResult(KCJSTJ:String);//在没有操作的情况下，制作数据
          procedure EXtractComprehensiveEvaluationData; //提取综合评价后的数值 只提取排序第一 与第二的数值

      constructor Create;
      destructor Destroy;
   End;


   TWorkFace_Subject=Class(TKCJSTJ_First)
      Data_Count:integer;
      DataClass:array of String ;
      procedure SetDataClassVaule(Value:Integer);
      procedure FillWorkFaceBasicInfo;
      procedure WithoutOptionMakeResult(KCJSTJ:String);//在没有操作的情况下，制作数据
      procedure Set_KCJSCS_String(value:AnsiString);//把PStope传过来的字符串进拆分
      function  GetMaxSecondCount:integer;
      Procedure FillSubjiectDataRecord;
      constructor Create;
      destructor Destroy;
   End;
var
   t_SupWeigth:TSupportWeight;
   t_SupSubject:TWorkFace_Subject;

implementation



{ TSupportWeight }

uses UMainDataModule, Lu_Public_BasicModual;

procedure TSupportWeight.AddCoefficientValue(Wid, Sid: integer; Value: double);
begin
    coefficient_Count:=coefficient_Count+1;
    setlength(coefficient_Value,coefficient_Count);
       coefficient_Value[coefficient_Count-1]:=TData_Vaule.Create;
       coefficient_Value[coefficient_Count-1].workfaceInfoid :=wid;
       coefficient_Value[coefficient_Count-1].supportInfoid :=sid;
       coefficient_Value[coefficient_Count-1].value :=Value;

end;

procedure TSupportWeight.AddDataValue(Wid,Sid,Row,Col: integer; Value: double);
begin
    Data_Value_Count:=Data_Value_Count+1;
    setlength(Data_Value,Data_Value_Count);
       Data_Value[Data_Value_Count-1]:=TData_Vaule.Create;
       Data_Value[Data_Value_Count-1].workfaceInfoid :=wid;
       Data_Value[Data_Value_Count-1].supportInfoid :=sid;
       Data_Value[Data_Value_Count-1].value :=Value;
       Data_Value[Data_Value_Count-1].RowNumber:=Row;
       Data_Value[Data_Value_Count-1].ColNumber:=Col;
end;

procedure TSupportWeight.ClearClass_Data_ValueClass;
var
  i:integer;
begin
   for I := 0 to self.Data_Value_Count-1 do
       FreeAndNil(Data_Value[i]);
   Data_Value_Count:=0;
end;

constructor TSupportWeight.Create;
begin
    if not assigned(SupportInfo) then
       SupportInfo:=TSupport_First.Create;
    if not assigned(WorkFaceInfo) then
       WorkFaceInfo:=TKCJSTJ_First.Create;
    coefficient_Count:=0;
    Data_Value_Count:=0;
end;

destructor TSupportWeight.Destroy;
   var
  i:integer;
begin
    if assigned(SupportInfo) then
       FreeandNil(SupportInfo);
    if assigned(WorkFaceInfo) then
       FreeandNil(WorkFaceInfo);
    for I := 0 to Data_Value_Count-1 do
       if Assigned(Data_Value[i]) then
          FreeandNil(Data_Value[i]);
    for I := 0 to coefficient_Count-1 do
      if Assigned(coefficient_Value[i]) then
         FreeandNil(coefficient_Value[i]);
end;

function TSupportWeight.ExDatawithoutData: Boolean;
var
  sql:string;
  MyDataSet:TMYDataSet;
  i:integer;
begin
    MyDataSet:=TMYDataSet.Create(nil);
    MyDataSet.MySqlConnection :=MainDataModule.ExConn ;

   try
    MyDataSet.Close ;
    sql:='select count(id)  as CN from  SupWeight_Value ';
    MyDataSet.CommandText :=sql;
    if (MyDataSet.Open) and (MyDataSet.RecordCount >100) then
        Result:=true
    else Result:=False;
   finally
      MyDataSet.Close ;
      FreeAndNil(MyDataSet);
   end;

end;

procedure TSupportWeight.EXtractComprehensiveEvaluationData;
var
  i,j:integer;
begin
    for I := 0 to self.SupportInfo.Child_count -1 do
         supportInfo.Child_Second[i].SelectFisrtAndSecondData ;
end;

procedure TSupportWeight.ExtractDataFromDataBase;
begin
    if ExDatawithoutData then  begin
       ExtractFormExData;
    end else begin
       ExtractFromSqlite;
    end;
end;

procedure TSupportWeight.ExtractFormExData;
var
  sql:string;
  MyDataSet:TMYDataSet;
  i:integer;
begin
    MyDataSet:=TMYDataSet.Create(nil);
    MyDataSet.MySqlConnection :=MainDataModule.ExConn ;

    ClearClass_Data_ValueClass;
   try
    MyDataSet.Close ;
    sql:='select * from  SupWeight_Value ';
    MyDataSet.CommandText :=sql;
    if not (MyDataSet.Open) then exit;

      SetDataValueCount(MyDataSet.RecordCount);
    i:=0;                             {workfaceid,supportid,sub_Value}
    while  MyDataSet.Eof do begin
         Data_Value[i].workfaceInfoid := MyDataSet.FieldByName('workfaceid').AsInteger;
         Data_Value[i].supportInfoid := MyDataSet.FieldByName('supportid').AsInteger;
         Data_Value[i].RowNumber := MyDataSet.FieldByName('RowNumber').AsInteger;
         Data_Value[i].ColNumber  := MyDataSet.FieldByName('ColNumber').AsInteger;
         Data_Value[i].value := MyDataSet.FieldByName('sub_Value').AsFloat;
         MyDataSet.Next ;
         i:=i+1;
    end;
   finally
      MyDataSet.Close ;
      FreeAndNil(MyDataSet);
   end;

end;

procedure TSupportWeight.ExtractFromSqlite;
var
   sltb1: TSQLIteTable;
   sql:string;
   i:integer;
begin

    ClearClass_Data_ValueClass;
    try
        sql:='select * from  SupWeight_Value ';
        sltb1:=MainDataModule.MySqliteDataBase.Maindb.GetTable(sql);
        self.SetDataValueCount(sltb1.RowCount);
        i:=0;
        while not sltb1.EOF   do  begin
               Data_Value[i].workfaceInfoid := StrToint(sltb1.FieldByName['workfaceid']);
               Data_Value[i].supportInfoid :=StrToint(sltb1.FieldByName['supportid']);
               Data_Value[i].RowNumber := StrToint(sltb1.FieldByName['RowNumber']); //MyDataSet.FieldByName('RowNumber').AsInteger;
               Data_Value[i].ColNumber  := StrToint(sltb1.FieldByName['ColNumber']);//MyDataSet.FieldByName('ColNumber').AsInteger;
               Data_Value[i].value := StrToFloat(sltb1.FieldByName['sub_Value']);

               sltb1.Next ;
               i:=i+1;
        end;
   finally
      sltb1.Free;
   end;

end;

procedure TSupportWeight.FillCoeFFicientData;
var
   sltb1: TSQLIteTable;
   sql:string;
begin
    sql:= ' SELECT * from Supweight_coefficient  order by id';

    try
       sltb1:=MainDataModule.MySqliteDataBase.Maindb.GetTable(sql);
       while not sltb1.EOF   do  begin
            AddCoefficientValue(StrToint(sltb1.FieldByName['workfaceid']),
                                     StrToint(sltb1.FieldByName['sup_struct_id']),
                                     StrToFloat(sltb1.FieldByName['weight_Value']));

            sltb1.Next ;
       end;
    finally
      sltb1.Free;
    end;
    // 填充各自信息
end;

procedure TSupportWeight.FillSupportWeight;
var
   sltb1: TSQLIteTable;
   sql:string;
begin
    sql:= ' SELECT * from Supportweight where DataType = '''+LowerCase('start')+''' order by Number';

    try
       sltb1:=MainDataModule.MySqliteDataBase.Maindb.GetTable(sql);
       while not sltb1.EOF   do  begin

           if StrToint(sltb1.FieldByName['Number'])=2 then  begin
              SupportInfo.Name:= Utf8Decode(sltb1.FieldByName['CaptionName']);
              SupportInfo.id :=StrToint(sltb1.FieldByName['id']);
              SupportInfo.BianMa :=Utf8Decode(sltb1.FieldByName['TypeName']) ;
              SupportInfo.Number:=2;
              SupportInfo.FillBasicData ;
           end else  if StrToint(sltb1.FieldByName['Number'])=1 then  begin
              WorkFaceInfo.Name:= Utf8Decode(sltb1.FieldByName['CaptionName']);
              WorkFaceInfo.id :=StrToint(sltb1.FieldByName['id']);
              WorkFaceInfo.BianMa :=Utf8Decode(sltb1.FieldByName['TypeName']) ;
              WorkFaceInfo.Number:=2;
              workFaceInfo.FillBasicData ;
           end;
           sltb1.Next ;
       end;
    finally
      sltb1.Free;
    end;
    // 填充各自信息

end;

procedure TSupportWeight.MakeCoeffWithAVGVAlue;
var
  i,j,w:integer;
  Selected_W,Selected_S:Integer;
  Cof,D_Value:double;
begin
//    //创建基本使用类

    Cof:=0;D_Value:=0;
    for i := 0 to SupportInfo.Child_count-1 do    // 遍历第一级结构件
        for w := 0 to WorkFaceInfo.Child_count-1 do  begin
           Cof:=self.SelectCoeff_Value(WorkFaceInfo.Child_Second[w].id ,SupportInfo.Child_Second[i].id );
           for j := 0 to SupportInfo.Child_Second[i].Child_Count-1 do  begin //遍历第二级结构件
              Selected_S:= SupportInfo.Child_Second[i].Child_Third[j].id;
              Selected_W:=WorkFaceInfo.Child_Second[w].selected;
                 D_Value:=SelectData_Value(WorkFaceInfo.Child_Second[w].Child_Third[Selected_W].id ,
                                      SupportInfo.Child_Second[i].Child_Third[j].id );
                 SupportInfo.Child_Second[i].Child_Third[j].AGV_Value:=SupportInfo.Child_Second[i].Child_Third[j].AGV_Value+
                                      Cof * D_Value;
           end;
        end;

end;

procedure TSupportWeight.SaveDataIntoDataBase;
begin
    SaveValueIntoExData ;
    SaveValueSqlite
end;

procedure TSupportWeight.SaveValueIntoExData;
var
  sql:string;
  AdoCommand:TMYCommand;
  i:integer;
begin
    AdoCommand:=TMYCommand.Create(nil);
    AdoCommand.MySqlConnection :=MainDataModule.ExConn ;
    AdoCommand.MySqlConnection.BeginTrans;
   try
    sql:='delete from  SupWeight_Value ';
    AdoCommand.CommandText :=sql;
    AdoCommand.Execute;

    for I := 0 to self.Data_Value_Count-1 do begin
       sql:='insert into SupWeight_Value (workfaceid,supportid,RowNumber,ColNUmber,sub_Value) values (' +
            IntToStr(Data_Value[i].workfaceInfoid ) +','+IntToStr(Data_Value[i].supportInfoid) + ','+
            IntToStr(Data_Value[i].RowNumber)+','+IntToStr(Data_Value[i].ColNumber)+
            ',''' + FormatFloat('0.00',Data_Value[i].value) +''')';
       AdoCommand.CommandText :=sql;
       AdoCommand.Execute;
    end;

   finally
      AdoCommand.MySqlConnection.CommitTrans;
      FreeAndNil(AdoCommand);
   end;

end;

procedure TSupportWeight.SaveValueSqlite;
var
  sql:string;
  i:integer;
begin

   try
        sql:='delete from  SupWeight_Value ';
        MainDataModule.MySqliteDataBase.Maindb.ExecSQL(sql);

        for I := 0 to self.Data_Value_Count-1 do begin
           sql:='insert into SupWeight_Value (workfaceid,supportid,RowNumber,ColNUmber,sub_Value) values (' +
                IntToStr(Data_Value[i].workfaceInfoid ) +','+IntToStr(Data_Value[i].supportInfoid) + ','+
                IntToStr(Data_Value[i].RowNumber)+','+IntToStr(Data_Value[i].ColNumber)+
                ',''' + FormatFloat('0.00',Data_Value[i].value) +''')';
           MainDataModule.MySqliteDataBase.Maindb.ExecSQL(sql);
        end;

   finally

   end;


end;

function TSupportWeight.SelectCoeff_Value(Wid, Sid: integer): double;
var
 i:integer;
 Value:double;
begin
    Value:=0;
    for I := 0 to  self.coefficient_Count-1 do
        if (coefficient_Value[i].workfaceInfoid = Wid ) and
           (coefficient_Value[i].supportInfoid =Sid )then begin
            Value:= coefficient_Value[i].value;
            break;
           end;
    REsult:=Value;

end;

function TSupportWeight.SelectData_Value(Wid, Sid: integer): double;
var
  i:integer;
  Value:double;
begin
      Value:=0;
      for i := 0 to self.Data_Value_Count-1 do
        if (Data_Value[i].workfaceInfoid =Wid) and
               (Data_Value[i].supportInfoid =Sid) then  begin
             Value:= Data_Value[i].value ;
             break;;
          end;
      Result:=Value;

end;

procedure TSupportWeight.SetDataValueCount(Value: integer);
var
  i:integer;
begin
    Data_Value_Count:=Value;
    setlength(Data_Value,Value);
    for I := 0 to Value-1 do
       Data_Value[i]:=TData_Vaule.Create;
end;

procedure TSupportWeight.Set_KCJSCS_String(value: AnsiString);
var
   st:Str_DT_array;
   C1:integer;
   i,bM:integer;
begin
    st:=Public_Basic.split(value,',',C1);
    for I := 0 to C1-1 do
      if i< WorkFaceInfo.Child_count then
          if Public_Basic.StrToInt_lu(st[i])>0 then
             WorkFaceInfo.Child_Second[i].Selected:=Public_Basic.StrToInt_lu(st[i])-1;
end;

procedure TSupportWeight.WithoutOptionMakeResult(KCJSTJ:String);
begin
    //第一步 填充地质条件与 液压支架结构参数
    //如若 测试需要把这不封上，主要原因是通过SetRowHead等
    //为stringGrid赋值的行与列会被重写， 导致无法打印
     FillSupportWeight ; //填 参数数据
    //第二步 填充 专家制定的地质条件与结构件 相关系数表
     FillCoeFFicientData;//填系数数据
    // 第三步 拆分从PStope 传过来的 地质开采条件
    Set_KCJSCS_String(KCJSTJ);
    //第四部 从数据库提取 专家对不同结构件 与地质开采条件的组合数据
    ExtractDataFromDataBase;
    // 第五步 对 制定开采技术条件下 对专家打分 进行综合评判
    MakeCoeffWithAVGVAlue;
    // 第六步 从宗华评判结果中把 排名第一 与第二的结构件 找出来
    EXtractComprehensiveEvaluationData;
end;

{ TSupport_First }

procedure TSupport_First.CalcuteAGV_Value;
var
 i:integer;
begin
    for I := 0 to self.Child_count-1 do   begin

    end;

end;

constructor TSupport_First.Create;
begin

end;

destructor TSupport_First.Destroy;
var
  i:integer;
begin
    for I := 0 to Child_count-1 do
       if Assigned(Child_Second[i]) then
          FreeandNil(Child_Second[i]);

    if Assigned(Used_Workface_Class) then
          FreeAndNil(Used_Workface_Class);
end;

procedure TSupport_First.FillBasicData;
var
   sltb1: TSQLIteTable;
   sql:string;
   i:integer;
begin
    sql:= ' SELECT * from Supportweight where DataType = '''+LowerCase(BianMa)+''' order by Number';

    try
       sltb1:=MainDataModule.MySqliteDataBase.Maindb.GetTable(sql);
       if sltb1.RowCount <1 then   exit;
          SetChildCount(sltb1.RowCount);
       i:=0;
       while not sltb1.EOF   do  begin
           Child_Second[i].id:=StrToint(sltb1.FieldByName['id']); ;
           Child_Second[i].Name :=Utf8Decode(sltb1.FieldByName['CaptionName']);
           Child_Second[i].BianMa:= Utf8Decode(sltb1.FieldByName['TypeName']) ;
           Child_Second[i].Number:=StrToint(sltb1.FieldByName['Number']);
           Child_Second[i].FillBasicData ;
           i:=i+1;
           sltb1.Next ;
       end;
    finally
      sltb1.Free;
    end;
end;

procedure TSupport_First.SetChildCount(Value: integer);
var
  i:integer;
begin
    Child_count:=Value;
    setlength(Child_Second,Value);
    for I := 0 to Child_count-1 do
      Child_Second[i]:=TSupport_Second.Create ;

end;

{ TSupport_Two }


constructor TSupport_Second.Create;
begin

end;

destructor TSupport_Second.Destroy;
var
  i:integer;
begin
    for I := 0 to Child_count-1 do
       if Assigned(Child_Third[i]) then
          FreeandNil(Child_Third[i]);

end;

procedure TSupport_Second.FillBasicData;
var
   sltb1: TSQLIteTable;
   sql:string;
   i:integer;
begin
    sql:= ' SELECT * from Supportweight where DataType = '''+LowerCase(BianMa)+''' order by Number';

    try
       sltb1:=MainDataModule.MySqliteDataBase.Maindb.GetTable(sql);
       if sltb1.RowCount <1  then exit;

       SetChildCount(sltb1.RowCount);
       i:=0;
       while not sltb1.EOF   do  begin
           Child_Third[i].id:=StrToint(sltb1.FieldByName['id']);
           if Child_Third[i].id=0 then
              sql:='2' ;
           Child_Third[i].Name :=Utf8Decode(sltb1.FieldByName['CaptionName']);
           Child_Third[i].BianMa:= Utf8Decode(sltb1.FieldByName['TypeName']) ;
           Child_Third[i].Number:=StrToint(sltb1.FieldByName['Number']);
           i:=I+1;
           sltb1.Next ;
       end;
    finally
      sltb1.Free;
    end;
end;

procedure TSupport_Second.SelectFisrtAndSecondData;
var
  i:integer;
begin
    Firstid:=0;
    for I := 1 to Child_Count-1 do
        if Child_Third[i].AGV_Value >Child_Third[Firstid].AGV_Value   then
           Firstid:=i;
    Secondid:=-1;
    for I := 0 to Child_Count-1 do  begin
        if i=Firstid then continue;
        if Secondid=-1 then Secondid:=i;
        if  (Child_Third[i].AGV_Value >Child_Third[secondid].AGV_Value)  then
           Secondid:=i;
    end;
    Selected:= Firstid;
end;

procedure TSupport_Second.SetChildCount(Value: integer);
var
 i:integer;
begin
      Child_count:=Value;
      setlength(Child_Third,Value);
      for I := 0 to Child_count-1 do
      Child_Third[i]:=TData_Type.Create ;
end;

{ TKCJSTJ_Class }

constructor TKCJSTJ_First.Create;
begin

end;

destructor TKCJSTJ_First.Destroy;
var
  i:integer;
begin
    for I := 0 to Child_count-1 do
       if Assigned(Child_Second[i]) then
          FreeandNil(Child_Second[i]);

end;

procedure TKCJSTJ_First.FillBasicData;
var
   sltb1: TSQLIteTable;
   sql:string;
   i:integer;
begin
    sql:= ' SELECT * from Supportweight where DataType = '''+LowerCase(BianMa)+''' order by Number';

    try
       sltb1:=MainDataModule.MySqliteDataBase.Maindb.GetTable(sql);
       if sltb1.RowCount <1  then exit;
          SetChildCount(sltb1.RowCount);
       i:=0;
       while not sltb1.EOF   do  begin
           Child_Second[i].id:=StrToint(sltb1.FieldByName['id']); ;
           Child_Second[i].Name :=Utf8Decode(sltb1.FieldByName['CaptionName']);
           Child_Second[i].BianMa:= Utf8Decode(sltb1.FieldByName['TypeName']) ;
           Child_Second[i].Number:=StrToint(sltb1.FieldByName['Number']);
           Child_Second[i].FillBasicData ;
           i:=i+1;
           sltb1.Next ;
       end;
    finally
      sltb1.Free;
    end;
    // 填充各自信息
end;

procedure TKCJSTJ_First.SetChildCount(Value: integer);
var
  i:integer;
begin
     Child_count:=Value;
     setlength(Child_Second,Value);
     for I := 0 to Child_count-1 do
      Child_Second[i]:=TKCJSTJ_Second.Create ;
end;
{ TKCJSTJ_two }

constructor TKCJSTJ_Second.Create;
begin

end;

destructor TKCJSTJ_Second.Destroy;
var
  i:integer;
begin
    for I := 0 to Child_count-1 do
       if Assigned(Child_Third[i]) then
          FreeandNil(Child_Third[i]);
end;

procedure TKCJSTJ_Second.FillBasicData;
var
   sltb1: TSQLIteTable;
   sql:string;
   i:integer;
begin
    sql:= ' SELECT * from Supportweight where DataType = '''+LowerCase(BianMa)+''' order by Number';

    try
       sltb1:=MainDataModule.MySqliteDataBase.Maindb.GetTable(sql);
       if sltb1.RowCount <1 then   exit;
          SetChildCount(sltb1.RowCount);
       i:=0;
       while not sltb1.EOF   do  begin
           Child_Third[i].id:=StrToint(sltb1.FieldByName['id']); ;
           Child_Third[i].Name :=Utf8Decode(sltb1.FieldByName['CaptionName']);
           Child_Third[i].BianMa:= Utf8Decode(sltb1.FieldByName['TypeName']) ;
           Child_Third[i].Number:=StrToint(sltb1.FieldByName['Number']);
           i:=i+1;
           sltb1.Next ;
       end;
    finally
      sltb1.Free;
    end;

end;

procedure TKCJSTJ_Second.SetChildCount(Value: integer);
var
 i:integer;
begin
      Child_count:=Value;
      setlength(Child_Third,Value);
      for I := 0 to Child_count-1 do
      Child_Third[i]:=TData_Type.Create ;
end;

{ TData_Type }



{ TWorkFace_Subject }

constructor TWorkFace_Subject.Create;
begin

end;

destructor TWorkFace_Subject.Destroy;

begin



end;

procedure TWorkFace_Subject.FillSubjiectDataRecord;
var
  sql,sql2:string;
  i:integer;
begin
   MainDataModule.MyDataSet.Close ;
   sql:=' select id,subjectText from SupSubjectData where id in (select SubJ_id  from SupportSubIndex where  ' ;
   sql2:='';
   for I := 0 to self.Child_count-1 do  begin
      if i=0 then  begin
         sql2:= '(Firstid =' +intToStr(i) + ' and  Secondid= ' +intToSTr(Child_Second[i].selected) + ') or ' ;
      end else if i=Child_count-1 then   begin
         sql2:=sql2+ ' (Firstid =' +intToStr(i) + ' and  Secondid= ' +intToSTr(Child_Second[i].selected) + ')';
      end else begin
         sql2:=sql2+ ' (Firstid =' +intToStr(i) + ' and  Secondid= ' +intToSTr(Child_Second[i].selected) + ') or ';
      end;
   end;
   MainDataModule.MyDataSet.CommandText :=sql+sql2+ ')';
  try
   if (MainDataModule.MyDataSet.Open) and (MainDataModule.MyDataSet.RecordCount >0)  then  begin
      self.SetDataClassVaule(MainDataModule.MyDataSet.RecordCount) ;
      i:=0;
      while not MainDataModule.MyDataSet.Eof  do  begin
         self.DataClass[i]:=MainDataModule.MyDataSet.FieldByName('subjectText').AsString;
         i:=i+1;
         MainDataModule.MyDataSet.Next ;
      end;
   end;
  finally
    MainDataModule.MyDataSet.Close ;
  end;

end;

procedure TWorkFace_Subject.FillWorkFaceBasicInfo;
var
   sltb1: TSQLIteTable;
   sql:string;
begin
    sql:= ' SELECT * from Supportweight where DataType = '''+LowerCase('start')+''' ' +
          ' and Number=1';

    try
       sltb1:=MainDataModule.MySqliteDataBase.Maindb.GetTable(sql);
       if  sltb1.RowCount>0 then  begin
          Name:= Utf8Decode(sltb1.FieldByName['CaptionName']);
          id :=StrToint(sltb1.FieldByName['id']);
          BianMa :=Utf8Decode(sltb1.FieldByName['TypeName']) ;
          Number:=2;
          FillBasicData ;
       end;
    finally
      sltb1.Free;
    end;
    // 填充各自信息

end;

function TWorkFace_Subject.GetMaxSecondCount: integer;
var
 i,MaXCount:integer;
begin
   MaXCount:=0;
   for I := 0 to self.Child_count-1 do
      if self.Child_Second[i].Child_count> MaXCount then
         MaXCount:=Child_Second[i].Child_count;
   Result:= MaXCount;

end;

procedure TWorkFace_Subject.SetDataClassVaule(Value:Integer);
var
 i:integer;
begin
      Data_Count:=Value;
      setlength(DataClass,Value);

end;

procedure TWorkFace_Subject.Set_KCJSCS_String(value: AnsiString);
var
   st:Str_DT_array;
   C1:integer;
   i,bM:integer;
begin
    st:=Public_Basic.split(value,',',C1);
    for I := 0 to C1-1 do
      if i< Child_count then
          if Public_Basic.StrToInt_lu(st[i])>0 then
            Child_Second[i].Selected:=Public_Basic.StrToInt_lu(st[i])-1;
end;

procedure TWorkFace_Subject.WithoutOptionMakeResult(KCJSTJ: String);
begin
    //第一步 填充地质条件与 液压支架结构参数
    //如若 测试需要把这不封上，主要原因是通过SetRowHead等
    //为stringGrid赋值的行与列会被重写， 导致无法打印
    self.FillWorkFaceBasicInfo ; //填 参数数据
//    // 第二步 拆分从PStope 传过来的 地质开采条件
    Set_KCJSCS_String(KCJSTJ);
    //第三步 把拆分的结果涉及到的建议放到类里面
    FillSubjiectDataRecord;
//     FillCoeFFicientData;//填系数数据
//    //第四部 从数据库提取 专家对不同结构件 与地质开采条件的组合数据
//    ExtractDataFromDataBase;
//    // 第五步 对 制定开采技术条件下 对专家打分 进行综合评判
//    MakeCoeffWithAVGVAlue;
//    // 第六步 从宗华评判结果中把 排名第一 与第二的结构件 找出来
//    EXtractComprehensiveEvaluationData;
end;

{ TSubject }


end.
