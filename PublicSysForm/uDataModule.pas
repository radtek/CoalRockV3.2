unit uDataModule;

interface

uses
  Windows, SysUtils, Classes, Messages, Forms, StdCtrls, ExtCtrls,
  ComCtrls ,math,MySQLDataSet,COMobj,SQLiteTable3,ActiveX,Dialogs,StrUtils;

type


  TMyDataModule =class (TObject)
  private
    //变量

        SQLiteName:string ;//
        EXDataType:string;//外部数据库类型
         //全局数据库表名
        MYSQLDataBaseName:String;
   
  protected
        function getpath :string;
        procedure SetDataBaseName(Value:string);
        function GetDataBaseName:string;
  public
      //组件
        EXDataIP,ExUser,EXPassword,Port:String;
        Connected:Boolean; //判断数据库连接是否成功
     // 外部数据库连接
        ExConn: TMySqlConnection;
//        ExCommand1: TMyCommand;
//        ExCommand2: TMyCommand;
//
//        ExDataSet1: TMyDataSet;
//        ExDataSet2: TMyDataSet;
      //  EXQuery:TADOQuery;
      //  ExADOQuery1:TADOQuery;
        //SQL数据库连接
        Maindb: TSQLiteDatabase;
        MainDBpath: string;
        UseFormName,i_kid:string;  // Mc Form use
        MainPath:string;
        Connstring:string;
        StatUsBarRightStr:String;

        // 函数与方法
        constructor Create;
        destructor Destroy; override;
        function initsqliteData:Boolean;  // 初始化sqllit 数据库
        function SetLinkDatabase(MinPath,DName: string):Boolean; // connected sqlite
        procedure SetExDataType(Value:string);
        function SetExDBaseInfo(sIP,sUser,sPass:string):Boolean;
        function GetExDataType:String;
        procedure SetMySqlPort(Value:string);
        function isExsitMySql(DataBaseName:string):Boolean;
        //创建数据库
        function TestMySql(uDType:string):Boolean;
        function TestServer(uDType:string):Boolean;
        function CreateDatabase(uDType,IP,User,Pass,Path:string):Boolean;
        function ConnectedData(uDType,Name:string):Boolean;
        //创建数据表
        function CreateMySqlTable(xl,gzmName,bh:string):Boolean; //xl=1 代表插入基本表，xl=2 代表插入工作面的再生表   xl=3 插入带编号的数据表
        function CreateServerTable(xl,gzmName,bh:string):Boolean; //xl=1 代表插入基本表，xl=2 代表插入工作面的再生表  xl=3 插入带编号的数据表

        //转字符串
        //从数据库读取Unicode的中文编码，解码：
        function DecodeUtf8Str(const S:UTF8String): WideString; var lenSrc,lenDst  : Integer;

        //判断数据表的存在
        function JudgeTableIsExists(TableName:string):boolean;
        procedure InsertProcessLog(GTime:Tdatetime;ProcessType,gzmName:string;Supbh,DNumber:integer;
                  Etime:string;Succeed:Boolean;safteyIn:integer;Safteybh:integer);
        //
        function SplitString(const source, ch: string): TStringList;    //2016-5-30   截取字符串
        procedure ComboList(Combo:TComboBox;sql,str1,str2,str3:AnsiString);//2016-5-31 sqllite读取数据
        // 界面控制函数
        procedure InitStatusBar(StatusBar: TStatusBar);
        property DataBaseName:String read GetDataBaseName write SetDataBaseName;

  end;

implementation



{ TMyDataModule }



procedure TMyDataModule.ComboList(Combo: TComboBox; sql, str1, str2,
  str3: AnsiString);
var
     t_s1,t_s2,t_s3,S_tmp:AnsiString;
     sltb1,sltb2: TSQLIteTable;
     CTsql,wStr:string;
     TableName:string;
begin
    Combo.Clear ;

     sltb1:= Maindb.GetTable(UTF8Encode(sql));
     while not sltb1.eof do
       begin
           s_tmp:='';
           if str1<>'' then
             begin
               t_s1:=Trim(utf8decode(sltb1.FieldByName[str1]));
               s_tmp:=t_s1;

             end;
           if str2<>'' then
            begin
               t_s2:=Trim(utf8decode(sltb1.FieldByName[str2]));

               s_tmp:=s_tmp+'_'+t_s2;
            end;
           if str3<>'' then
             begin
               t_s3:=Trim(utf8decode(sltb1.FieldByName[str3])) ;

               s_tmp:=s_tmp+'_'+t_s3;

             end;

           combo.Items.Add(s_tmp);
           sltb1.Next ;
       end;
    sltb1.Free ;
       if combo.Items.Count >0 then
           combo.ItemIndex :=0;
end;

function TMyDataModule.ConnectedData(uDtype, Name: string): Boolean;
var
   sConn:string;
begin
      if Port='' then  Port:='3307';

      Result:=false; Connected:=false;
     // if ExConn.Connected then  ExConn.Close;
      if (uDtype= 'SQLSERVER') or(uDtype= 'SQL SERVER') then  begin
          sConn    := 'Provider=SQLOLEDB.1;Persist Security Info=True;Connect   Timeout=30 '
                    + ';Data Source='+ExDataIP
                    + ';Initial Catalog='+Name
                    + ';User ID =' +ExUser
                    + ';Password='+ ExPassword
                    + ';Packet Size='+InttoStr(4096)   //一个Integer值，一般是4096
                    + ';';
      end else if (uDtype= 'MYSQL') or (uDtype= 'MY SQL') then  begin
           sConn   :='DRIVER={MySQL ODBC 3.51 Driver}'
                    + ';SERVER='+ExDataIP
                    + ';PORT='+Port
                    + ';DATABASE='+Name
                    + ';USER='+ExUser
                    + ';PASSWORD='+ExPassword
                    + ';OPTION=3'
                    + ';' ;
      end;

      //   EXConn.ConnectionString:= sConn;

         Connstring:=sConn;
      try
        // ExConn.Open;
        if  EXConn.Open(ExDataIP,port,ExUser,ExPassword,Name) then  begin
            Result:=true; Connected:=true;
        end;

      except
         Result:=False; Connected:=False;
      end;
       // 2016

end;


constructor TMyDataModule.Create;
begin
  inherited;
      // CoInitialize(nil);
       ExConn:= TMySqlConnection.Create(nil);
       Connected:=false;
       //
       MainPath:=getpath;
       StatUsBarRightStr:='山东科技大学宋振骐院士团队研发 CopyRight (2016-2020)';
end;


function TMyDataModule.CreateDatabase(uDType, IP, User, Pass,
  Path: string): Boolean;
var
  sql:string;
  WStr:ansiString;
  ExCommand1:TMYCommand ;
begin
    Result:=false;
    ExCommand1:=TMyCommand.Create(nil);
    ExCommand1.MySqlConnection :=ExConn;
   // wStr:='确定要创建新数据库么？老数据库中数据将完全被覆盖！'+#13#13+'建议备份后再进行创建！';
   // if MessageBox(0, Pchar(wstr),'提示',MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDNO then exit;
   // click Yes  continue
      try
        if (uDtype= 'SQLSERVER') or(uDtype= 'SQL SERVER') then  begin
              ConnectedData(uDType,'master');
              sql:='if exists(select * from sysdatabases where name='''+MYSQLDataBaseName +''') drop database '+MYSQLDataBaseName;
              ExCommand1.CommandText:=sql;
              ExCommand1.Execute ;


              sql:= 'if not exists(select * from sysdatabases where name='''+MYSQLDataBaseName +''')'
                   + ' create database '+ MYSQLDataBaseName
                   +' on (  name=''' +MYSQLDataBaseName+'_Data'','  // -- 主数据文件的逻辑名称
                   +' filename= '''+path+MYSQLDataBaseName +'_data.mdf'','  // -- 主数据文件的物理名称
                   +' size=10,FileGrowth=15%)'
                   +' log on (name='''+MYSQLDataBaseName+'_log'','
                   +' filename= '''+path+MYSQLDataBaseName +'_log.ldf'','  // -- 主数据文件的物理名称
                   +' size=10,FileGrowth=15%)';
               ExCommand1.CommandText:=sql;
               ExCommand1.Execute ;

        end else if (uDtype= 'MYSQL') or (uDtype= 'MYSQL') then  begin
            ConnectedData(uDType,'mysql');
            sql:='drop database  if exists  '+MYSQLDataBaseName ;
               ExCommand1.CommandText:=sql;
               ExCommand1.Execute ;

             sql:=' Create database  '+MYSQLDataBaseName   ;
               ExCommand1.CommandText:=sql;
               ExCommand1.Execute ;

        end;
      finally
         Result:=true;
         ExCommand1.Free;
      end;
end;

//  创建 MYSql 数据表  1 代表插入基本表，2 代表插入工作面的再生表
function TMyDataModule.CreateMySQlTable(xl,gzmName,bh:string): Boolean;
var
  sltb1,sltb2: TSQLIteTable;
  CTsql,wStr,indexStr:string;
  TableName:string;
  ExCommand1:TMYCommand ;
begin
    Result:=false;
    ExCommand1:=TMyCommand.Create(nil);
    ExCommand1.MySqlConnection :=ExConn;
   // wStr:='确定要创建新数据表么？老数据表中数据将完全被覆盖！'+#13#13+'建议备份后再进行创建！';
    //if xl <>'3' then
   //     if MessageBox(0, Pchar(wstr),'提示',MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDNO then exit;
    // click Yes  continue
     ExCommand1.MySqlConnection.BeginTrans;
  try
     sltb1:=Maindb.GetTable('select * from createtable where ' +
                            '  used =1 and  creatleg='+xl+' order by tableid ');
     while not sltb1.EOF  do  begin
          //
           if xl='1' then  begin
              TableName:=UPPerCase(DecodeUtf8Str(sltb1.FieldByName['CreateTableName'])) ;
           end else if  xl='2' then  begin
              TableName:='D_'+gzmname+'_'+UPPerCase(DecodeUtf8Str(sltb1.FieldByName['CreateTableName'])) ;
           end else if xl='3' then begin
              TableName:='D_'+gzmname+'_'+bh+'_'+UPPerCase(DecodeUtf8Str(sltb1.FieldByName['CreateTableName'])) ;
           end;

         ExCommand1.CommandText:='drop table  if  exists '+ TableName;
         ExCommand1.Execute ;
         CTsql:='create table '+ TableName  +' ( ';

         sltb2:= Maindb.GetTable('select * from createfields '
             + ' where CreateTableid= '+sltb1.FieldByName['tableid']+ ' and fieldleg=1  order by id ');

        // if EXDataType='' then
         indexStr:='';
           
            while not sltb2.eof do  begin
                CTsql:=CTsql+ sltb2.FieldByName['fieldname']
                      +'  '+ sltb2.FieldByName['fieldtype'] ;

                if  upperCase(sltb2.FieldByName['fieldtype'])='VARCHAR' then
                      CTsql:=CTsql+'(' +sltb2.FieldByName['length']+')';
                if sltb2.FieldByName['isNull']='1' then    CTsql:=CTsql+ ' not null  ';
                if sltb2.FieldByName['primarykey']='1' then CTsql:=CTsql+ ' primary key Auto_increment ';
                if sltb2.FieldByName['indexStr']='1' then indexStr:=indexStr+ ' index ('+sltb2.FieldByName['fieldname']+') ,';
                CTsql:=CTsql+',';
                sltb2.Next ;
            end;
            CTsql:=CTsql+indexStr;
            CTsql:=LeftStr(CTsql,length(CTsql)-1);  
            CTsql:=CTsql+')' ;
            sltb2.Free ;

            CTsql:=CTsql+' CHARACTER SET utf8 COLLATE utf8_general_ci   ';
            ExCommand1.CommandText:=CTsql;
            ExCommand1.Execute ;
        sltb1.Next ;
     end;
        sltb1.Free;
  except
      ExCommand1.MySqlConnection.RollbackTrans;
      exit;
  end;
      ExCommand1.MySqlConnection.CommitTrans;
      ExCommand1.Free;
      Result:=true;
end;

//创建 Server 数据表  1 代表插入基本表，2 代表插入工作面的再生表
function TMyDataModule.CreateServerTable(xl,gzmName,bh:string): Boolean;
var
  sltb1,sltb2: TSQLIteTable;
  CTsql,wStr:string;
  TableName:string;
  SprimaryKey:string;
  ExCommand1:TMYCommand ;
begin
    Result:=false;
    ExCommand1:=TMyCommand.Create(nil);
    ExCommand1.MySqlConnection :=ExConn;
    wStr:='确定要创建新数据表么？老数据表中数据将完全被覆盖！'+#13#13+'建议备份后再进行创建！';
    if xl <>'3' then
        if MessageBox(0, Pchar(wstr),'提示',MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDNO then exit;
    // click Yes  continue

try
     SprimaryKey:='';
     sltb1:=Maindb.GetTable('select * from createtable where ' +
                            '  used =1 and  creatleg='+xl);
     while not sltb1.EOF  do  begin
          //
           if xl='1' then  begin
              TableName:=DecodeUtf8Str(sltb1.FieldByName['CreateTableName']) ;
           end else if  xl='2' then  begin
              TableName:='D_'+gzmname+'_'+UPPerCase(DecodeUtf8Str(sltb1.FieldByName['CreateTableName'])) ;
           end else if xl='3' then begin
              TableName:='D_'+gzmname+'_'+bh+'_'+UPPerCase(DecodeUtf8Str(sltb1.FieldByName['CreateTableName'])) ;
           end;

          // WHERE   TABLE_NAME = '[table_name]') DROP TABLE  [table_name]
           ExCommand1.CommandText:=' IF EXISTS ( SELECT  TABLE_NAME FROM INFORMATION_SCHEMA.TABLES '+
                                   ' WHERE   TABLE_NAME ='''+TableName+''' ) DROP TABLE '+TableName ;
           //ShowMessage(ExCommand1.CommandText);
           ExCommand1.Execute ;

          CTsql:='create table '+ TableName  +' ( ';

         sltb2:= Maindb.GetTable('select * from createfields '
             + ' where CreateTableid= '+sltb1.FieldByName['tableid']+ ' and fieldleg=1 ');


            while not sltb2.eof do  begin
                CTsql:=CTsql+ sltb2.FieldByName['fieldname']
                      +'  '+ sltb2.FieldByName['fieldtype'] ;

                if  upperCase(sltb2.FieldByName['fieldtype'])='VARCHAR' then
                      CTsql:=CTsql+'(' +sltb2.FieldByName['length']+')';
                if sltb2.FieldByName['isNull']='1' then    CTsql:=CTsql+ ' not null  ';
                if sltb2.FieldByName['primarykey']='1' then  begin
                    CTsql:=CTsql+ ' IDENTITY (1,1) ';
                    SprimaryKey:= ' primary Key ('  +sltb2.FieldByName['fieldname']+')';
                end;


                CTsql:=CTsql+',';
                sltb2.Next ;
            end;
            CTsql:=LeftStr(CTsql,length(CTsql)-1);
            if SprimaryKey <>'' then CTsql :=CTsql+ SprimaryKey;

            CTsql:=CTsql+')' ;
            sltb2.Free ;

             ExCommand1.CommandText:=CTsql;
             //ShowMessage(CTsql);
             ExCommand1.Execute ;
        sltb1.Next ;
     end;
        sltb1.Free;

  finally
    Result:=true;
    ExCommand1.Free ;
  end;
end;


function TMyDataModule.DecodeUtf8Str(const S: UTF8String): WideString;
var
    lenSrc,lenDst  : Integer;
begin
      lenSrc  := Length(S);
      if(lenSrc=0)then Exit;
      lenDst  := MultiByteToWideChar(CP_UTF8, 0, Pointer(S),lenSrc, nil, 0);
      SetLength(Result, lenDst);
      MultiByteToWideChar(CP_UTF8, 0, Pointer(S),lenSrc, Pointer(Result), lenDst);
end;

destructor TMyDataModule.Destroy;
begin

     FreeAndNil(Maindb) ;
//     FreeAndNil(ExCommand1);
//     FreeAndNil(ExCommand2);
//     FreeAndNil(ExDataSet1);
//     FreeAndNil(ExDataSet2);
     FreeAndNil(ExConn);
     FreeAndNil(ExConn);
    // CoUninitialize;
     inherited Destroy;
end;

function TMyDataModule.GetDataBaseName: string;
begin
   Result:=MYSQLDataBaseName;
end;

function TMyDataModule.GetExDataType: String;
begin
      Result:=ExDataType;
end;

function TMyDataModule.getpath: string;
var
   ModuleName,dllpath:WideString;
   i:integer;
begin
          SetLength(ModuleName, 255);
          GetModuleFileName(HInstance, PChar(ModuleName), Length(ModuleName));
          dllPath:=Trim(PChar(ModuleName)) ;
          i:=Pos('\',ReverseString(dllPath));

          dllPath:=Copy(dllPath,1,Length(dllPath)-i+1);
          Result:=dllPath;
end;

// end function

function TMyDataModule.initsqliteData: Boolean;
begin
       //判断数据库文件
         Result:=true;
          if SqliteName='' then  SqliteName := 'RockPressure.db';
          if not SetLinkDatabase(MainPath,SqliteName) then  begin
             Result:=false;
          end;
end;



procedure TMyDataModule.InitStatusBar(StatusBar: TStatusBar);
var
  S_left:integer;
begin
    S_left:=Round(StatusBar.Width/3);

    StatusBar.Panels[0].Width := S_left;
    StatusBar.Panels[1].Width := round(S_left*3/5);
   // StatusBar.Panels[2].Width := S_left;
    StatusBar.Panels[0].Alignment :=taLeftJustify;
    StatusBar.Panels[2].Alignment :=taRightJustify;

    StatusBar.Panels[2].Text:=  StatUsBarRightStr  ;
end;

procedure TMyDataModule.InsertProcessLog(GTime: Tdatetime; ProcessType,GzmName: string;
  Supbh,DNumber: integer; Etime: string; Succeed:Boolean;safteyIn, Safteybh: integer);
var
   sql:string;
   Suc:string;
   Excommand1:TMyCommand;
begin
       Excommand1:=TMYCommand.Create(nil);
       Excommand1.MySqlConnection :=self.ExConn;
     try
       if Succeed then suc:='1' else suc:='0';

       sql:='insert into processlog (generatetime,Processtype,GzmName,supportbh,datanumber,elapsedtime,succeed,safetyinfo,safetybh )' +
            ' values ('''+ FormatDateTime( 'yyyy-mm-dd hh:nn:ss',GTime)+''',''' +
            ProcessType+ ''','''+GzmName+''',' + IntToStr(Supbh)+',' +
            IntToStr(DNumber) +',' +Etime +','+Suc+',' +
            intTostr(safteyIn )+','+ intToStr(Safteybh) +')' ;
       Excommand1.CommandText :=sql;
       ExCommand1.Execute ;
     finally
       Excommand1.Free ;
     end;
end;



function TMyDataModule.isExsitMySql(DataBaseName: string): Boolean;
var
  sql:string;
  ExDataSet1:TMyDataSet;
begin
    Result:=False;
    ExDataSet1:=TMYDataSet.Create(nil);
    ExDataSet1.MySqlConnection :=ExConn;
     sql:='select *  from information_schema.schemata where schema_name='''+DataBaseName+'''';
     ExDataSet1.Close ;
     try
          ExDataSet1.CommandText :=sql;
          if ExDataSet1.Open  then
            if ExDataSet1.RecordCount >0 then
                 Result:=true;

     finally
          ExDataSet1.Close ;
          ExDataSet1.Free ;
     end;
end;

function TMyDataModule.JudgeTableIsExists(TableName: string): boolean;
 var
   sql:string;
begin
//       if (ExDatatype= 'MYSQL') or (ExDatatype= 'MY SQL')   then  begin
//           sql:='SELECT  id from  '+TableName +'  limit 1';
//       end  else if (ExDatatype= 'SQLSERVER') or (ExDatatype= 'SQL SERVER')   then  begin
//           sql:='Select Name from sysobjects where xtype=''u'' and name ='''+TableName +'''';
//       end;
//       try
//          ExDataSet2.Close;
//          ExDataSet2.CommandText :=sql;
//          ExDataSet2.Open ;
//          if ExDataSet2.RecordCount>0 then   Result:=true
//           else  Result:=false;
//           ExDataSet2.Close;
//       except
//          result:=false;
//          ExDataSet2.Close;
//          exit;
//       end;

      Result:=true;
end;



procedure TMyDataModule.SetDataBaseName(Value: string);
begin
     MYSQLDataBaseName:=Value;
end;

procedure TMyDataModule.SetExDataType(Value: string);
begin
     ExDataType:=Value;
end;

function TMyDataModule.SetExDBaseInfo(sIP, sUser, sPass: string): Boolean;
begin
     EXDataIP:=sIP;
     ExUser:=sUser;
     EXPassword:=sPass;
end;

function TMyDataModule.SetLinkDatabase(MinPath,DName: string): Boolean;
var
   i:integer;
   dPath:String;
begin
         Result:=true;
         i:=pos('.', DName);
         if i>0  then begin
               MainDBPath :=MinPath +DName;
         end else begin
               MainDBPath :=MinPath +DName+ '.db';
         end;
        // ShowMessage(MainDBPath);
         if not FileExists(MainDBPath) then begin
                Result:=false;
                exit;
          end;
        Maindb := TSQLiteDatabase.Create(MainDBPath);

end;


procedure TMyDataModule.SetMySqlPort(Value: string);
begin
    Port:=Value;
end;

function TMyDataModule.SplitString(const source, ch: string): TStringList;
var
  temp, t2: string;
  i: integer;
begin
  result := TStringList.Create;
  temp := source;
  i := pos(ch, source);
  while i <> 0 do
  begin
    t2 := copy(temp, 0, i - 1);
    if (t2 <> '') then
      result.Add(t2);
    delete(temp, 1, i - 1 + Length(ch));
    i := pos(ch, temp);
  end;
  result.Add(temp);
end;

function TMyDataModule.TestMySql(uDType: string): Boolean;
begin
     Result:=false;
     if ConnectedData(uDType,'MySql') then Result:=true;

end;

function TMyDataModule.TestServer(uDType: string): Boolean;
begin
      Result:=false;
     if ConnectedData(uDType,'Master') then Result:=true;
end;

//


/////////////////
// 创建Ini配置对象


end.  // end unit
