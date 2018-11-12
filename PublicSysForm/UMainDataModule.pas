unit UMainDataModule;

interface

uses
  Winapi.Windows,System.SysUtils, System.Classes,uLuDataAdo,
  Vcl.StdCtrls,Vcl.ComCtrls, Vcl.Graphics,System.StrUtils,SQLiteTable3
  ,uLuSqliteDealWith;

type

  pDataBase =^TUsedDataBase;
  TUsedDataBase=packed record
    Ip  :String;
    UserName: string;
    Port: String;
    Password:string;
    DataBaseName:String;
    DataType:string;
    DataBaseString:String;
  end;
  pUsedMkInfo= ^TMkInfo;
  TMkInfo= packed record
    MeiKuang_id:string;
    MeiKuang_Name:string;
    workFace_id:string ;
    WorkFace_Name:String;
    Drill_id:string;
    Drill_Name:String;
  end;
  {2018 ���Զ��� �̳� ԭ�� MySQLDataSet ������Ķ��� }
    { TODO : Ϊ���ݿ������춨���� }
  TMysqlConnection = class(TMyConnection)

  end;
  TMyDataSet =Class(TDataSet)

  End;
  TMyCommand = Class(TCommand)

  End;
  { �̳������}

  TDataModule1 = class
//    procedure DataModuleDestroy(Sender: TObject);
//    procedure DataModuleCreate(Sender: TObject);

  private
    { Private declarations }
      Version:String; // {ϵͳ�汾��}
      SQLiteName:string ;//
      EXDataType:string;//�ⲿ���ݿ�����
       //ȫ�����ݿ����
      inUserName,inUserID:String; // �û������� ���
      Admin_Bool:Boolean; // �û��Ƿ��� ����Ա
      PublicDataBase:pDataBase; //���� ���ݼ�¼��
      inMainPath:String;  //��Ҫ·��
      SQLSERVER_CurrentLocation:String;
      PublicUsedMkInfo : pUsedMkInfo;

    function MySQLTableisExsit(TableName: String): Boolean;
    function RichTextSaveToFileName(RD:TStrings;FileType,FileTail:string;
                        Gzmid,bh:integer;st,ed:tdateTime):String;
    function RichTextSaveToDB(RD:TStrings;FileType:string;
                        Gzmid,bh:integer;st,ed:tdateTime):String;
    function ReadRichTextFromFile(RD:TStrings;FileType,FileTail:string;
                        Gzmid,bh:integer;st,ed:tdateTime):Boolean;
    function ReadRichTextFromDB(RD:TStrings;FileType:string;
                        Gzmid,bh:integer;st,ed:tdateTime):Boolean;
    function DeleteRichFromFile(RD:TStrings;FileType,FileTail:string;
                        Gzmid,bh:integer;st,ed:tdateTime):Boolean;
    function DeleteRichFromDB(FileType,FileTail:string;
                        Gzmid,bh:integer):Boolean;
    function ReturnFileName(FileType,FileTail:string; st,ed:tdateTime;
                             Gzmid,bh:integer):string;
   protected
       procedure SetDataType(Value:string);
         function GetMainPath:String;
       procedure SetMainPath(Value:string);
         function GetDataType:String;
       procedure SetUserName(Value:String);
         function GetUserName:string;
       procedure SetUserId(Value:string);
         function GetUserID:String;
       procedure SetAdmin_Bool(Value:Boolean);
         function GetAdmin_Bool:Boolean;
         function GetCoal_id:String;
       procedure SetCoal_id(Value:string);
          function GetCoal_Name:String;
       procedure SetCoal_Name(Value:string);
          function GetWorkface_id:String;
       procedure SetWorkFace_id(Value:string);
          function GetDrill_id:String;
       procedure SetDrill_id(Value:string);
          function GetWorkFace_Name:String;
       procedure SetWorkFace_Name(Value:string);
          function GetDrill_Name:String;
       procedure SetDrill_Name(Value:string);
       procedure SetDataBaseName(Value:string);
          function GetDataBaseName:string;
  public
        MyDataSet:TMyDataSet;
        MyCommand:TMyCommand;
          //���
        EXDataIP,ExUser,EXPassword,Port:String;
        Connected:Boolean; //�ж����ݿ������Ƿ�ɹ�
     // �ⲿ���ݿ�����
        ExConn: TMySqlConnection;

        //SQL���ݿ�����
        Maindb: TSQLiteDatabase;
        MainDBpath: string;
        UseFormName:string;  // Mc Form use
        MySqliteDataBase:TSqliteADOData;//�Լ���sqlite ��

        Connstring:string;
        // �����뷽��
        { Public declarations }
        property DataType:String read GetDataType write SetDataType;
        {ExUserName  ExUserID  ExAdminBool }
        property ExUserName:String read GetUserName write SetUserName;
        property ExUserID:String read GetUserID write SetUserID;
        property ExAdminBool:Boolean read GetAdmin_Bool write SetAdmin_bool;

        property Coal_id:String read GetCoal_id write SetCoal_id;
        property Coal_Name:String read GetCoal_Name write SetCoal_Name;
        property WorkFace_id:String read GetWorkFace_id write SetWorkFace_id;
        property Drill_id:String read GetDrill_id write SetDrill_id;
        property WorkFace_Name:String read GetWorkFace_Name write SetWorkFAce_Name;
        property Drill_Name:String read GetDrill_Name write SetDrill_Name;
        property DataBaseName:String read GetDataBaseName write SetDataBaseName;
        property ExMainPath:String  read GetMainPath write SetMainPath;

        procedure SaveDataInotRecord(Ip,UserName,Password,Port,DataBase:String );

        function ReadDataTypeFromFile:String;
        procedure WriteDataTypeIntoFile(Value:string);
        function TestDataBaseParameter( Dtype:string): WordBool;  safecall;
        function SelectIsExsitDataBase(Dtype:string) :Boolean;
        // �������ݿ���������
        function CreateDataBase(Dtype:string):Boolean;
        function SetSystemSnapDataBase(DataType,DataBaseName,AddressIp:String;
                 iSnapData:Boolean;iSnapPort:String):Boolean;
        //�������ݱ���������
        function CreateTable(TableFlag,Dtype,gzmbh,supbh:string):Boolean;
        function GetPublicRecordInfo(var DataType,Ip,Port,User,Password,DataBase:string):Boolean;
            {�û��ⲿ�������ݿ�}
        function  ConnectSystemDataBase:Boolean;
        procedure SavePublicUsedMkInfoIntoFile;
        function  ReadPublicUsedMkInfoFromFile:Boolean;
        procedure ClearPublicUsedMkInfo;

        function initsqliteData:Boolean;  // ��ʼ��sqllit ���ݿ�
        procedure SetSqliteName(Value:string);
        function SetLinkDatabase(MinPath,DName: string):Boolean; // connected sqlite
        procedure SetExDataType(Value:string);
        function SetExDBaseInfo(sIP,sUser,sPass:string):Boolean;
        function GetExDataType:String;
        procedure SetMySqlPort(Value:string);
        function isExsitMySql(DataBaseName:string):Boolean;
        function isExsitSQlServer(DataBaseName:string):Boolean;
        function isExsitAccess(Path,DataBaseName:string):Boolean;
        //�������ݿ�
        function TestMySql(uDType:string):Boolean;
        function TestServer(uDType:string):Boolean;
        function Create_DataBase_Body(uDType,IP,User,Pass,Path:string):Boolean;
        function ConnectedData(uDType,Name:string):Boolean;
        function GetSqlServerLocalPath:string;

        //�������ݱ�
        function CreateMySqlTable(xl,gzmName,bh:string):Boolean; //xl=1 ���������������xl=2 �������빤�����������   xl=3 �������ŵ����ݱ�
        function CreateServerTable(xl,gzmName,bh:string):Boolean; //xl=1 ���������������xl=2 �������빤�����������  xl=3 �������ŵ����ݱ�
        function CreateAccessTable(xl,gzmName,bh:string):Boolean;
        function AccessTableisExsit(tableNme:string):Boolean;
        function SqlServerTableisExsitThenDrop(TableName:String):Boolean;
        function MYSqlTableisExsitThenDrop(TableName:String):Boolean;
        function AssceeTableisExsitThenDrop(TableName:String):Boolean;
        function DropIsExsitTable(TableName:String):Boolean;
         //�ж����ݱ��Ĵ���
        function IsExsitTableName(TableName:string):Boolean;
        //ת�ַ���
        function RichTextSaveToDataBase(RD:TStrings;FileType,FileTail:string;
                                   WorkFace,BM:integer;st,ed:TdateTime):Boolean;
        function ReadRichTextFromDataBase(RD:TStrings;FileType,FileTail:string;
                                   WorkFace,BM:integer;st,ed:TdateTime):Boolean;
        function DeleteRichTextFile(RD:TStrings;FileType,FileTail:string;
                                   WorkFace,BM:integer;st,ed:TdateTime):Boolean;
        // ���һ�ȡ�����ļ�
         function SelectRockPressDataNumber(DataType,Gzmid: integer): Boolean;

        //�����ݿ��ȡUnicode�����ı��룬���룺
        function DecodeUtf8Str(const S:UTF8String): WideString; var lenSrc,lenDst  : Integer;

        procedure InsertProcessLog(GTime:Tdatetime;ProcessType,gzmName:string;Supbh,DNumber:integer;
                  Etime:string;Succeed:Boolean;safteyIn:integer;Safteybh:integer);
        //
         function MySQlFillComBox(MySQlDataSet:TMyDataSet ;Combo: TComboBox; sql, str1, str2,str3: AnsiString):WordBool;stdcall;

      //========
         procedure CreateClass;
         procedure FreeCalss;
         constructor Create(Sender: TObject);
         destructor Destroy;override;
  end;

var
    MainDataModule: TDataModule1;
   
implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Lu_Public_BasicModual;


{$R *.dfm}

{ TDataModule1 }

function TDataModule1.AccessTableisExsit(tableNme: string): Boolean;
var
 sql:string;
 MyAdoData:TMyDAtaSet;
begin
  try
     Result:=false;
     MyAdoData:=TMyDataSet.Create(nil);
     MyAdoData.MySqlConnection :=Exconn;
     sql:= 'SELECT MSysObjects.Name FROM MSysObjects WHERE Name= '''+tableNme+''' ';
     MyAdoData.CommandText :=sql;
     if MyAdoData.Open  then
        if MyAdoData.RecordCount >0 then  result:=true ;
     MyAdoData.Close ;
  finally
    FreeAndNil(MyAdoData) ;
  end;

end;

function TDataModule1.AssceeTableisExsitThenDrop(TableName: String): Boolean;
var
 ExCommand1:TMYCommand ;
begin
    Result:=false;
    ExCommand1:=TMyCommand.Create(nil);
    ExCommand1.MySqlConnection :=ExConn;

    try
          if self.AccessTableisExsit(TableName)  then   begin

              ExCommand1.CommandText:=' DROP TABLE '+TableName ;
              ExCommand1.Execute ;
          end;
    finally
       Result:=true;
       FreeAndNil(ExCommand1);
    end;

end;

procedure TDataModule1.ClearPublicUsedMkInfo;
begin
    PublicUsedMkInfo.MeiKuang_id :='0';
    PublicUsedMkInfo.MeiKuang_Name:='';
    PublicUsedMkInfo.workFace_id:='0';
    PublicUsedMkInfo.WorkFace_Name:='';
    PublicUsedMkInfo.Drill_id:='0';
    PublicUsedMkInfo.Drill_Name:='';
end;


function TDataModule1.ConnectedData(uDType, Name: string): Boolean;
var
   sConn:string;
begin
      if Port='' then  Port:='3307';

      if EXConn.ServerConnected then  EXConn.Close ;
      uDtype:=UpperCase(uDtype);
      Result:=false; Connected:=false;
      //�����SnapData
  if (EXConn.ThreeSnap) and ( uDtype<>'ACCESS')  then  begin
      Result:=true; Connected:=true;
  end  else begin  // �����������ݽṹ  ���� ��ACCESS
      if (uDtype= 'SQLSERVER') or(uDtype= 'SQL SERVER') then  begin
          EXConn.SetDataBaseType(uDtype);
          sConn    := 'Provider=SQLOLEDB.1;Persist Security Info=True;Connect   Timeout=30 '
                    + ';Data Source='+ExDataIP
                    + ';Initial Catalog='+Name
                    + ';User ID =' +ExUser
                    + ';Password='+ ExPassword
                    + ';Packet Size='+InttoStr(4096)   //һ��Integerֵ��һ����4096
                    + ';';
      end else if (uDtype= 'MYSQL') or (uDtype= 'MY SQL') then  begin
           EXConn.SetDataBaseType('MYSQL');
           sConn   :='DRIVER={MySQL ODBC 3.51 Driver}'
                    + ';SERVER='+ExDataIP
                    + ';PORT='+Port
                    + ';DATABASE='+Name
                    + ';USER='+ExUser
                    + ';PASSWORD='+ExPassword
                    + ';OPTION=3'
                    + ';' ;
      end else if (uDtype= 'ACCESS') then  begin
           EXConn.SetDataBaseType('ACCESS');
           EXConn.ThreeSnap:=False;
           sConn   :='Provider=Microsoft.Jet.OLEDB.4.0'
                    + ';User ID=Admin'
                    + ';Password='
                    + ';Data Source='+inMainPath+'Data\'+DataBaseName+'.mdb'
                    + ';Mode=Share Deny None '
                    + ';Extended Properties = ""'
                    + ';';
      end;


      try
        Connstring:=sConn;
        EXConn.ConnectStr:= sConn;
        if  EXConn.Open(ExDataIP,port,ExUser,ExPassword,Name) then  begin
            Result:=true; Connected:=true;
        end;

      except
         Result:=False; Connected:=False;
      end;

  end;
end;

function TDataModule1.ConnectSystemDataBase: Boolean;
var
  IP,UserName,Password,Port,DataBase:String;
  snapIp,SnapPort:String;
  snapData,RetResult:Boolean;
begin
   Result:=False;
   DataType:=ReadDataTypeFromFile;
   if DataType ='' then  exit;
   Public_Basic.ReadMySqlDataBase(DataType,Ip,UserName,
                   Password,Port,DataBase);
   SaveDataInotRecord(Ip,UserName,Password, Port,DataBase);

   snapData:=Public_Basic.ReadSnapData(snapIp,SnapPort);
   if snapData then   begin
      RetResult:=MainDataModule.SetSystemSnapDataBase(DataType,DataBase,snapIp,true,SnapPort);
      if not RetResult then
         RetResult:=MainDataModule.SetSystemSnapDataBase(DataType,DataBase,Ip,False,'0');
   end else begin
      RetResult:=MainDataModule.SetSystemSnapDataBase(DataType,DataBase,Ip,False,'0');
   end;
   Result:= RetResult;


end;

function TDataModule1.CreateDataBase(Dtype: string): Boolean;
var
 Inn_Dtype:String;
begin
    Result:=False;
    Inn_Dtype:=UpperCase(Dtype);
    DataBaseName:=PublicDataBase.DataBaseName;
    if (Inn_Dtype= 'SQLSERVER') or(Inn_Dtype= 'SQL SERVER') then  begin
         if Create_DataBase_Body(Inn_Dtype,PublicDataBase.Ip,PublicDataBase.UserName,
                                         PublicDataBase.Password ,SQLSERVER_CurrentLocation) then begin
            Public_Basic.WriteMYSQLDataBase(Inn_Dtype,PublicDataBase.Ip,PublicDataBase.UserName,
                                         PublicDataBase.Password,'1433',PublicDataBase.DataBaseName) ;
            Result:=true;
         end;
     end else if (Inn_Dtype= 'MYSQL') or (Inn_Dtype= 'MY SQL') then  begin
         if Create_DataBase_Body(Inn_Dtype,PublicDataBase.Ip,PublicDataBase.UserName,
                                         PublicDataBase.Password ,'') then begin
            Public_Basic.WriteMYSQLDataBase(Inn_Dtype,PublicDataBase.Ip,PublicDataBase.UserName,
                                         PublicDataBase.Password,PublicDataBase.Port,PublicDataBase.DataBaseName) ;
            Result:=true;
         end;
     end else if (Inn_Dtype= 'ACCESS') then  begin
        if Create_DataBase_Body(Inn_Dtype,PublicDataBase.Ip,PublicDataBase.UserName,
                                         PublicDataBase.Password ,ExMainPath) then begin
            Public_Basic.WriteMYSQLDataBase(Inn_Dtype,PublicDataBase.Ip,PublicDataBase.UserName,
                                         PublicDataBase.Password,'',PublicDataBase.DataBaseName) ;
            Result:=true;
         end;
     end;

end;



function TDataModule1.CreateTable(TableFlag,Dtype,gzmbh,supbh: string): Boolean;
var
 Inn_Dtype:String;
begin
    Result:=False;
    Inn_Dtype:=UpperCase(Dtype);
    DataBaseName:=PublicDataBase.DataBaseName;
     if (Inn_Dtype= 'SQLSERVER') or(Inn_Dtype= 'SQL SERVER') then  begin
         //�������������ӵ� �½������ݿ���
         ConnectedData('SqlServer',PublicDataBase.DataBaseName);
         if  CreateServerTable(TableFlag,gzmbh,supbh)  then  Result:=true;

     end else if (Inn_Dtype= 'MYSQL') or (Inn_Dtype= 'MY SQL') then  begin
          //�������������ӵ� �½������ݿ���
            ConnectedData('MySql',PublicDataBase.DataBaseName);
            if CreateMySqlTable(TableFlag,gzmbh,supbh)  then  Result:=true;
     end  else if (Inn_Dtype= 'ACCESS')  then  begin
          //�������������ӵ� �½������ݿ���
           ConnectedData('ACCESS',PublicDataBase.DataBaseName);
          if CreateAccessTable(TableFlag,gzmbh,supbh)  then  Result:=true;
     end;
end;

function TDataModule1.Create_DataBase_Body(uDType, IP, User, Pass,
  Path: string): Boolean;
var
  sql:string;
  ExCommand1:TMYCommand ;
  SFile,TFile:wideString;
begin
    Result:=false;
    ExCommand1:=TMyCommand.Create(nil);
    ExCommand1.MySqlConnection :=ExConn;
      try
        if (uDtype= 'SQLSERVER') or(uDtype= 'SQL SERVER') then  begin
              ConnectedData(uDType,'master');
              sql:='if exists(select * from sysdatabases where name='''+DataBaseName +''') drop database '+DataBaseName;
              ExCommand1.CommandText:=sql;
              ExCommand1.Execute ;


              sql:= 'if not exists(select * from sysdatabases where name='''+DataBaseName +''')'
                   + ' create database '+ DataBaseName
                   +' on (  name=''' +DataBaseName+'_Data'','  // -- �������ļ����߼�����
                   +' filename= '''+path+DataBaseName +'_data.mdf'','  // -- �������ļ�����������
                   +' size=10,FileGrowth=15%)'
                   +' log on (name='''+DataBaseName+'_log'','
                   +' filename= '''+path+DataBaseName +'_log.ldf'','  // -- �������ļ�����������
                   +' size=10,FileGrowth=15%)';
               ExCommand1.CommandText:=sql;
               ExCommand1.Execute ;

        end else if (uDtype= 'MYSQL') or (uDtype= 'MYSQL') then  begin
            ConnectedData(uDType,'mysql');
            sql:='drop database  if exists  '+DataBaseName ;
               ExCommand1.CommandText:=sql;
               ExCommand1.Execute ;

             sql:=' Create database  '+DataBaseName   ;
               ExCommand1.CommandText:=sql;
               ExCommand1.Execute ;

        end else  if (uDtype= 'ACCESS')  then  begin
             TFile:=DataBaseName +'.mdb';
             TFile:=Path+'Data\'+TFile;
             if FileExists(TFile) then
                 deleteFile( TFile);
             //ǿ���ؽ�
             SFile:='RockPress.mdb';
             SFile:= Path+''+SFile;
             CopyFile(PWideChar(SFile),PwideChar(TFile),True);
        end;
      finally
         Result:=true;
         ExCommand1.Free;
      end;
end;


function TDataModule1.DecodeUtf8Str(const S: UTF8String): WideString;
var
    lenSrc,lenDst  : Integer;
begin
      lenSrc  := Length(S);
      if(lenSrc=0)then Exit;
      lenDst  := MultiByteToWideChar(CP_UTF8, 0, Pointer(S),lenSrc, nil, 0);
      SetLength(Result, lenDst);
      MultiByteToWideChar(CP_UTF8, 0, Pointer(S),lenSrc, Pointer(Result), lenDst);
end;

function TDataModule1.DeleteRichFromDB(FileType, FileTail: string; Gzmid,
  bh: integer): Boolean;
var
  Sql1,sql2,sql3:string;
  filePath:string;
begin
   Result:=False;

        Sql1:=' select  count(id) as SN from FileDataBase where FileType ='''+ FileType+'''  and WorkFaceid='  +
          IntToStr(Gzmid) + ' and Num_bh = ' + intToStr(bh) ;

        sql3:=' delete from FileDataBase where FileType ='''+ FileType+'''  and WorkFaceid='  +
          IntToStr(Gzmid) + ' and Num_bh = ' + intToStr(bh) ;


   try
      MyDataSet.Close ;
      MyDataSet.CommandText :=sql1;
      MyDataSet.Open ;
      if MyDataSet.FieldByName('SN').AsInteger>0 then  begin
         Mycommand.CommandText :=Sql3;
         Mycommand.Execute ;
      end;
      MyDataSet.Close ;

   finally
     Result:=true;
   end;
end;

function TDataModule1.DeleteRichFromFile(RD:TStrings;FileType,FileTail:string;
                        Gzmid,bh:integer;st,ed:tdateTime): Boolean;
var
  fileName,textString:Ansistring;
  DirName:Ansistring;
  Dll_Path:AnsiString;

begin
   Result:=False;
   Dll_Path:=Public_Basic.Get_MyModulePath;
   DirName:=DLL_path+'\InputData\WorkDace_'+IntTostr(Gzmid)+'\';
    fileName:=FileType+'_'+IntToStr(bh) + '.' +FileTail;
    fileName:=DirName+fileName;

   if  FileExists(fileName) then
     if    DeleteFile(fileName)  then
           Result:=True;

end;

function TDataModule1.DeleteRichTextFile(RD: TStrings; FileType,
  FileTail: string; WorkFace, BM: integer; st, ed: TdateTime): Boolean;
begin
    if  Uppercase(DataType)='ACCESS'  then   begin
        Result:=DeleteRichFromFile(RD,Filetype,FileTail,WorkFace,Bm,st,ed);
    end else begin
        {δ���}
        Result:=DeleteRichFromDB(FileType,FileTail,WorkFace,BM);
    end;
end;

destructor TDataModule1.Destroy;
begin
  FreeCalss;
  inherited;
end;

function TDataModule1.DropIsExsitTable(TableName: String): Boolean;
begin
   Result:=False;
   if Uppercase(DataType)='MYSQqL' then  begin
       Result:=MYSqlTableisExsitThenDrop(TableName);
   end else if Uppercase(DataType)='SQLSERVER' then  begin
       Result:=SqlServerTableisExsitThenDrop(TableName);
   end else if Uppercase(DataType)='ACCESS' then  begin
       Result:=AssceeTableisExsitThenDrop(TableName);
   end;

end;

procedure TDataModule1.FreeCalss;
begin
     if not Assigned(Maindb) then FreeAndNil(Maindb) ;
     if not Assigned(ExConn) then FreeAndNil(ExConn);
     if not Assigned(MyDataSet) then FreeAndNil(MyDataSet);
     if not Assigned(MyCommand) then FreeAndNil(MyCommand);
     if not Assigned(MySqliteDataBase) then FreeAndNil( MySqliteDataBase );

     Dispose(PublicDataBase) ;
     DisPose(PublicUsedMkInfo);

     inherited Destroy;
end;

function TDataModule1.GetAdmin_Bool: Boolean;
begin
   Result:=Admin_Bool;
end;


function TDataModule1.GetCoal_id: String;
begin
    Result:=PublicUsedMkInfo.MeiKuang_id;
end;

function TDataModule1.GetCoal_Name: String;
begin
   Result:=PublicUsedMkInfo.MeiKuang_Name;
end;

function TDataModule1.GetDataBaseName: string;
begin
   Result:=PublicDataBase.DataBaseName;
end;

function TDataModule1.GetDataType: String;
begin
   Result:=PublicDataBase.DataType;
end;

function TDataModule1.GetDrill_id: String;
begin
  Result:=PublicUsedMkInfo.Drill_id;
end;

function TDataModule1.GetDrill_Name: String;
begin
   Result:=PublicUsedMkInfo.Drill_Name;
end;

function TDataModule1.GetExDataType: String;
begin
   Result:=ExDataType;
end;

function TDataModule1.GetMainPath: String;
begin
   Result:=inMainPath;
end;


function TDataModule1.GetPublicRecordInfo(var DataType,Ip,Port,User,
             Password,DataBase:string): Boolean;
begin
   Result:=False;
   if (PublicDataBase.DataType<>'') and (PublicDataBase.DataBaseName<>'')   then  begin
      DataType:=PublicDataBase.DataType;
      Ip:=PublicDataBase.Ip;
      Port:=PublicDataBase.Port;
      User:=PublicDataBase.UserName;
      Password:=PublicDataBase.Password;
      DataBase:=PublicDataBase.DataBaseName;
      Result:=true;
   end;

end;



function TDataModule1.GetSqlServerLocalPath: string;
var
  sql,sOut:string;
  ExDataSet1:TMyDataSet;
  i:integer;
begin
    Result:='';
    ExDataSet1:=TMYDataSet.Create(nil);
    ExDataSet1.MySqlConnection :=ExConn;
    sql:=' select database_id,name,physical_name AS CurrentLocation,state_desc,size from sys.master_files '+
          ' where database_id=db_id(N''master'')';
    ExDataSet1.Close ;
     try
          ExDataSet1.CommandText :=sql;
          if ExDataSet1.Open  then   begin
             sOut:= ExDataSet1.FieldByName('CurrentLocation').AsString;
          end;
     finally
        ExDataSet1.Close ;
        ExDataSet1.Free;
     end;
    if sOut<>'' then   begin
       i:=Pos('\',ReverseString(sOut));
       sOut:=Copy(sOut,1,Length(sOut)-i+1);
       Result:=sOut;
    end;

end;

function TDataModule1.GetUserID: String;
begin
   Result:=inUserID;
end;

function TDataModule1.GetUserName: string;
begin
    Result:=inUserName;
end;

function TDataModule1.GetWorkface_id: String;
begin
    Result:=PublicUsedMkInfo.workFace_id
end;

function TDataModule1.GetWorkFace_Name: String;
begin
    Result:=PublicUsedMkInfo.WorkFace_Name;
end;

function TDataModule1.initsqliteData: Boolean;
begin
    //�ж����ݿ��ļ�
   Result:=true;
    if SqliteName='' then  SqliteName := 'RockPressure.db';
    if not SetLinkDatabase(inMainPath,SqliteName) then  begin
       Result:=false;
    end;
end;



procedure TDataModule1.InsertProcessLog(GTime: Tdatetime; ProcessType,
  gzmName: string; Supbh, DNumber: integer; Etime: string; Succeed: Boolean;
  safteyIn, Safteybh: integer);
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

function TDataModule1.isExsitAccess(Path, DataBaseName: string): Boolean;
var
  fileName,DirName :Ansistring;
  hFile:integer;
begin
    DirName:=path+'Data\';
    if not DirectoryExists(DirName) then begin
       ForceDirectories(DirName);
    end;
   fileName:=Ansistring(DataBaseName) +'.mdb';
   fileName:=DirName+fileName;
   if (FileExists(fileName)) then  Result:=true
      else   Result:=False;


end;

function TDataModule1.isExsitMySql(DataBaseName: string): Boolean;
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

function TDataModule1.isExsitSQlServer(DataBaseName: string): Boolean;
var
  sql,StrData:string;
  ExDataSet1:TMyDataSet;
begin
    Result:=False;
    ExDataSet1:=TMYDataSet.Create(nil);
    ExDataSet1.MySqlConnection :=ExConn;
    sql:='select name From master.dbo.sysdatabases';
     ExDataSet1.Close ;
     try
          ExDataSet1.CommandText :=sql;
          if ExDataSet1.Open  then
           while not ExDataSet1.Eof do    begin
              if Uppercase(ExDataSet1.FieldByName('Name').AsString )<>'MASTER' then
              if Uppercase(ExDataSet1.FieldByName('Name').AsString )<>'TEMPDB' then
                  if Uppercase(ExDataSet1.FieldByName('Name').AsString )<>'MODEL' then
                     if Uppercase(ExDataSet1.FieldByName('Name').AsString )<>'MSDB' then
                        if Uppercase(ExDataSet1.FieldByName('Name').AsString )=Uppercase(DataBaseName) then begin
                           Result:=true;
                           break;
                        end;
              ExDataSet1.Next;

           end;

     finally
          ExDataSet1.Close ;
          FreeAndNil(ExDataSet1);
     end;

end;

function TDataModule1.IsExsitTableName( TableName: string): Boolean;
var
   ExDataSet1:TMyDataSet;
   FalOrTrue:Boolean;
   sql:string;
begin
   Result:=False;
   ExDataSet1:=TMYDataSet.Create(nil);
   ExDataSet1.MySqlConnection :=ExConn;
   try
       if Uppercase(DataType)='MYSQL' then  begin
            ExDataSet1.Close ;
            sql:='SELECT  TABLE_NAME FROM INFORMATION_SCHEMA.TABLES  where TABLE_NAME ='''+ TableName +'''';
            ExDataSet1. CommandText:= sql;
            ExDataSet1.Open ;
            if ExDataSet1.Open  then
              if ExDataSet1.RecordCount >0 then  result:=true ;
            ExDataSet1.Close ;
       end else if Uppercase(DataType)='SQLSERVER' then  begin
           ExDataSet1.Close ;
           sql:='select * from sysobjects where name ='''+TableName+'''';
           ExDataSet1. CommandText:= sql;
            ExDataSet1.Open ;
            if ExDataSet1.Open  then
              if ExDataSet1.RecordCount >0 then  result:=true ;
            ExDataSet1.Close ;
       end else if Uppercase(DataType)='ACCESS' then  begin
           ExDataSet1.Close ;
           sql:= 'SELECT MSysObjects.Name FROM MSysObjects WHERE Name= '''+TableName+''' ';
           ExDataSet1.CommandText :=sql;
           if ExDataSet1.Open  then
              if ExDataSet1.RecordCount >0 then  result:=true ;
           ExDataSet1.Close ;
       end;
   finally
      FreeAndNil(ExDataSet1);
   end;
end;



function TDataModule1.MySQlFillComBox(MySQlDataSet: TMyDataSet;
  Combo: TComboBox; sql, str1, str2, str3: AnsiString): WordBool;
var
    t_s1,t_s2,t_s3,S_tmp,s:ansistring;

begin
     MySQlDataSet.Close;
     Combo.Clear ;
     s_tmp:='0_All';
     combo.Items.Add(s_tmp);
     MySQlDataSet.CommandText:=sql;
     if MySQlDataSet.Open  then
       while not MySQlDataSet.eof do
       begin
           s_tmp:='';
          if str1<>'' then   begin
               t_s1:=Trim(MySQlDataSet.FieldByName(str1).AsString) ;
               s_tmp:=t_s1;
             end;

          if str2<>'' then  begin
               t_s2:=Trim(MySQlDataSet.FieldByName(str2).AsString) ;
               s_tmp:=s_tmp+'_'+t_s2;
           end;

           if str3<>'' then   begin
                t_s3:=Trim(MySQlDataSet.FieldByName(str3).AsString) ;
                s_tmp:=s_tmp+'_'+t_s3;

           end;
           combo.Items.Add(s_tmp);
           MySQlDataSet.Next ;
       end;
   MySQlDataSet.Close ;

       if combo.Items.Count >0 then
          combo.ItemIndex :=0;

end;



function TDataModule1.MySQLTableisExsit(TableName: String): Boolean;
begin

end;

function TDataModule1.MYSqlTableisExsitThenDrop(TableName: String): Boolean;
var
 ExCommand1:TMYCommand ;
begin
    Result:=false;
    ExCommand1:=TMyCommand.Create(nil);
    ExCommand1.MySqlConnection :=ExConn;

  try
      ExCommand1.CommandText:='drop table  if  exists '+ TableName;
      ExCommand1.Execute ;
  finally
      Result:=true;
      FreeAndNil(ExCommand1);
  end;

end;

function TDataModule1.ReadDataTypeFromFile: String;
var
  sOut:String;
begin
  Result:='Access';
  if  Public_Basic.ReadDataBaseType(sOut) then
      Result:=Trim(sOut);
end;

function TDataModule1.ReadPublicUsedMkInfoFromFile: Boolean;
begin
   Result:= Public_Basic.ReadUsedMeiKuangInfo('UsedCoalInfo',PublicUsedMkInfo.MeiKuang_id,
            PublicUsedMkInfo.MeiKuang_Name, PublicUsedMkInfo.workFace_id ,PublicUsedMkInfo.WorkFace_Name,
            PublicUsedMkInfo.Drill_id,PublicUsedMkInfo.Drill_Name );
  WorkFace_Name:=PublicUsedMkInfo.WorkFace_Name;
  Drill_Name:= PublicUsedMkInfo.Drill_Name;
  Coal_Name:=PublicUsedMkInfo.MeiKuang_Name ;
end;




function TDataModule1.ReadRichTextFromDataBase(RD:TStrings;FileType,FileTail: string; WorkFace,
  BM: integer; st, ed: TdateTime): Boolean;
var
 FieName:string;
begin
    if  Uppercase(DataType)='ACCESS'  then   begin
        Result:=ReadRichTextFromFile(RD,Filetype,FileTail,WorkFace,Bm,st,ed);
    end else begin
        //Result:=ReadRichTextFromDB(RD,Filetype,WorkFace,Bm,st,ed);
        FieName:=ReturnFileName('ReadFromDB', 'rtf',-1,-1,WorkFace, bm);
        MyDataSet.ReadFileFromDataBase(FileType,WorkFace, BM,FieName);
         if  FileExists(FieName) then
             RD.LoadFromFile(FieName);
         Result:=true;
    end;
end;

function TDataModule1.ReadRichTextFromDB(RD: TStrings; FileType: string; Gzmid,
  bh: integer; st, ed: tdateTime): Boolean;
var
  Sql1:string;
begin
   Result:=False;
   if st >10000 then   begin
        Sql1:=' select  FileBody SN from FileDataBase where FileType ='''+ FileType+'''  and WorkFaceid='  +
          IntToStr(Gzmid) + ' and Num_bh = ' + intToStr(bh) + ' and starttime >= '''+
          ForMatDatetime('yyyy-mm-dd hh:NN:ss',st) + ''' and EndTime <= '''   +
          ForMatDatetime('yyyy-mm-dd hh:NN:ss',ed) + ''''  ;

   end else begin
        Sql1:=' select  FileBody as SN from FileDataBase where FileType ='''+ FileType+'''  and WorkFaceid='  +
          IntToStr(Gzmid) + ' and Num_bh = ' + intToStr(bh) ;
   end;

    try
      MyDataSet.Close ;
      MyDataSet.CommandText :=sql1;
      MyDataSet.Open ;
      if MyDataSet.RecordCount >0  then  begin
         RD.Text := MyDataSet.FieldByName('SN').AsString;
      end;
      MyDataSet.Close ;

   finally
     Result:=true;
   end;


end;

function TDataModule1.ReadRichTextFromFile(RD: TStrings; FileType,
  FileTail: string; Gzmid, bh: integer; st, ed: tdateTime): Boolean;
var
  fileName,textString:Ansistring;
  DirName:Ansistring;
  Dll_Path:AnsiString;

begin
   Result:=False;
   Dll_Path:=Public_Basic.Get_MyModulePath;
   DirName:=DLL_path+'\InputData\WorkDace_'+IntTostr(Gzmid)+'\';
    if not DirectoryExists(DirName) then begin
       ForceDirectories(DirName);
    end;
    if ( st> 10000 ) then  begin
       fileName:=FileType+'_'+IntToStr(bh) + '_' +
              FormatdateTime('yyyymmdd-hh:nn:ss',st) +'_' +
              FormatdateTime('yyyymmdd-hh:nn:ss',ed) + '.' +FileTail;
    end else  begin
       fileName:=FileType+'_'+IntToStr(bh) + '.' +FileTail;
    end;
   fileName:=DirName+fileName;

   if (FileExists(fileName)) then begin
       RD.LoadFromFile(fileName) ;
       Result:=True;
   end;



end;

function TDataModule1.ReturnFileName(FileType, FileTail: string; st,
  ed: tdateTime; Gzmid, bh: integer): string;
var
  fileName,textString:Ansistring;
  DirName:Ansistring;
  Dll_Path:AnsiString;

begin
   Result:='';
   Dll_Path:=Public_Basic.Get_MyModulePath;
   DirName:=DLL_path+'InputData\WorkDace_'+IntTostr(Gzmid)+'\';
    if not DirectoryExists(DirName) then begin
       ForceDirectories(DirName);
    end;
    if ( st> 10000 ) then  begin
       fileName:=FileType+'_'+IntToStr(bh) + '_' +
              FormatdateTime('yyyymmdd-hh:nn:ss',st) +'_' +
              FormatdateTime('yyyymmdd-hh:nn:ss',ed) + '.' +FileTail;
    end else  begin
       fileName:=FileType+'_'+IntToStr(bh) + '.' +FileTail;
    end;
   fileName:=DirName+fileName;
   Result:=FileName;

end;

function TDataModule1.RichTextSaveToDataBase(RD: TStrings; FileType,FileTail: string;
  WorkFace, BM: integer; st, ed: TdateTime): Boolean;
var
 filePath:string;
begin
    if  Uppercase(DataType)='ACCESS'  then   begin
        filePath:=RichTextSaveToFileName(RD,Filetype,FileTail,WorkFace,Bm,st,ed);
    end else begin
        RichTextSaveToDB(RD,Filetype,WorkFace,Bm,st,ed);
    end;
    Result:=true;
end;

function TDataModule1.RichTextSaveToDB(RD: TStrings; FileType: string; Gzmid,
  bh: integer; st, ed: tdateTime): string;
var
  Sql1,sql2,sql3:string;
  filePath:string;
begin
   Result:='';
   if st >10000 then   begin
        Sql1:=' select  count(id) as SN from FileDataBase where FileType ='''+ FileType+'''  and WorkFaceid='  +
          IntToStr(Gzmid) + ' and Num_bh = ' + intToStr(bh) + ' and starttime >= '''+
          ForMatDatetime('yyyy-mm-dd hh:NN:ss',st) + ''' and EndTime <= '''   +
          ForMatDatetime('yyyy-mm-dd hh:NN:ss',ed) + ''''  ;
        sql2:= ' insert into FileDataBase (FileType,WorkFaceid,Num_bh,starttime,EndTime,FileBody ) values( ' +
              '''' +FileType + ''', ' + IntToStr(Gzmid)+ ',' + intToStr(bh)+ ','''+
               ForMatDatetime('yyyy-mm-dd hh:NN:ss',st) +''',''' +
               ForMatDatetime('yyyy-mm-dd hh:NN:ss',ed)  +''',''' +
               RD.Text + ''')';
        sql3:=' delete  from FileDataBase where FileType ='''+ FileType+'''  and WorkFaceid='  +
          IntToStr(Gzmid) + ' and Num_bh = ' + intToStr(bh) + ' and starttime >= '''+
          ForMatDatetime('yyyy-mm-dd hh:NN:ss',st) + ''' and EndTime <= '''   +
          ForMatDatetime('yyyy-mm-dd hh:NN:ss',ed) + ''''  ;
   end else begin
        Sql1:=' select  count(id) as SN from FileDataBase where FileType ='''+ FileType+'''  and WorkFaceid='  +
          IntToStr(Gzmid) + ' and Num_bh = ' + intToStr(bh) ;
        sql2:= ' insert into FileDataBase (FileType,WorkFaceid,Num_bh,FileBody ) values( ' +
               '''' +FileType + ''', ' + IntToStr(Gzmid)+ ',' + intToStr(bh)+ ','''+
               RD.Text + ''')';
        sql3:=' delete from FileDataBase where FileType ='''+ FileType+'''  and WorkFaceid='  +
          IntToStr(Gzmid) + ' and Num_bh = ' + intToStr(bh) ;
   end;

   try
      MyDataSet.Close ;
      MyDataSet.CommandText :=sql1;
      MyDataSet.Open ;
      if MyDataSet.FieldByName('SN').AsInteger>0 then  begin
         Mycommand.CommandText :=Sql3;
         Mycommand.Execute ;
      end;
      MyDataSet.Close ;
      //
      filePath:=ReturnFileName('Save_Tmp', 'rtf',-1,-1,Gzmid, bh);
      RD.SaveToFile(filePath);
      MyDataSet.SaveFileIntoDataBase(FileType,Gzmid, bh,filePath);

   finally
     Result:='';
   end;
end;

function TDataModule1.RichTextSaveToFileName(RD:TStrings;FileType,FileTail: string; Gzmid,
         bh: integer; st, ed: tdateTime): String;
var
  fileName,textString:Ansistring;
  DirName:Ansistring;
  Dll_Path:AnsiString;

begin
   Result:='';
   Dll_Path:=Public_Basic.Get_MyModulePath;
   DirName:=DLL_path+'\InputData\WorkDace_'+IntTostr(Gzmid)+'\';
    if not DirectoryExists(DirName) then begin
       ForceDirectories(DirName);
    end;
    if ( st> 10000 ) then  begin
       fileName:=FileType+'_'+IntToStr(bh) + '_' +
              FormatdateTime('yyyymmdd-hh:nn:ss',st) +'_' +
              FormatdateTime('yyyymmdd-hh:nn:ss',ed) + '.' +FileTail;
    end else  begin
       fileName:=FileType+'_'+IntToStr(bh) + '.' +FileTail;
    end;
   fileName:=DirName+fileName;
   RD.SaveToFile(FileName);
   Result:=FileName;

end;

procedure TDataModule1.SaveDataInotRecord(Ip, UserName, Password, Port,
  DataBase: String);
begin
   if Port='' then
     if UpperCase(DataType)='MYSQL' then  begin
        Port:='3306' ;
     end else if UpperCase(DataType)='SQLSERVER' then  begin
        Port:='1433' ;
     end else begin
        Port:='' ;
     end;

   PublicDataBase.Ip:=IP;
   PublicDataBase.UserName :=UserName;
   PublicDataBase.Port :=port;
   PublicDataBase.Password :=Password;
   PublicDataBase.DataBaseName :=DataBase;

end;

procedure TDataModule1.SavePublicUsedMkInfoIntoFile;
begin
   Public_Basic.WriteUsedMeiKuanginfo('UsedCoalInfo',PublicUsedMkInfo.MeiKuang_id,
                PublicUsedMkInfo.MeiKuang_Name ,PublicUsedMkInfo.workFace_id ,PublicUsedMkInfo.WorkFace_Name,
                PublicUsedMkInfo.Drill_id,PublicUsedMkInfo.Drill_Name  );
end;

function TDataModule1.SelectIsExsitDataBase(Dtype: string): Boolean;
var
 Inn_Dtype:String;
begin
    Result:=False;
    Inn_Dtype:=UpperCase(Dtype);
     if (Inn_Dtype= 'SQLSERVER') or(Inn_Dtype= 'SQL SERVER') then  begin
        Result:=isExsitSQlServer(PublicDataBase.DataBaseName);
     end else if (Inn_Dtype= 'MYSQL') or (Inn_Dtype= 'MY SQL') then  begin
        Result:=isExsitMySql(PublicDataBase.DataBaseName);
     end else if (Inn_Dtype= 'ACCESS') then  begin
         SetExDataType(Inn_Dtype);
         SetExDBaseInfo(PublicDataBase.Ip,PublicDataBase.UserName,PublicDataBase.Password);
         Result:=isExsitAccess(ExMainPath,PublicDataBase.DataBaseName);
     end;


end;

function TDataModule1.SelectRockPressDataNumber(DataType,Gzmid: integer): Boolean;
var
  sql,FieldStr:String;
begin
   Result:=False;
   MyDataSet.Close ;

   if DataType< 5 then begin
      FieldStr:='MZL_Value';
   end else   begin
      FieldStr:='PressData';
   end;

   Sql:=' select Sum('+FieldStr+') as MCN from  D_'+IntToStr(Gzmid)+'_ManualInputPressData  ';

   MyDataSet.CommandText :=sql;
   try
       if MyDataSet.Open then
        if MyDataSet.FieldByName('MCN').AsFloat >100 then
           Result:=true;

   finally
       MyDataSet.Close ;
   end;


end;

procedure TDataModule1.SetAdmin_Bool(Value: Boolean);
begin
     Admin_Bool:=Value;
end;

procedure TDataModule1.SetCoal_id(Value: string);
begin
   PublicUsedMkInfo.MeiKuang_id:=Value;
end;

procedure TDataModule1.SetCoal_Name(Value: string);
var
  st:integer;
  istr:string;
begin
   st:=Pos('��',Value);
   if st >0 then  begin
      istr:=copy(value,0,st-1);
   end else  begin
      istr:=Value;
   end;
   //
   st:=Pos('ú',istr);
   if st >0 then  begin
      istr:=copy(istr,0,st-1);
   end else  begin
      istr:=istr;
   end;

      //
   st:=Pos('��',istr);
   if st >0 then  begin
      istr:=copy(istr,0,st-1);
   end else  begin
      istr:=istr;
   end;


   PublicUsedMkInfo.MeiKuang_Name:=istr;

end;

procedure TDataModule1.SetDataBaseName(Value: string);
begin
    PublicDataBase.DataBaseName :=Value;
end;

procedure TDataModule1.SetDataType(Value: string);
begin
    PublicDataBase.DataType:=value;
end;

procedure TDataModule1.SetDrill_id(Value: string);
begin
   PublicUsedMkInfo.Drill_id:=Value;
end;

procedure TDataModule1.SetDrill_Name(Value: string);
var
  st:integer;
  istr:string;
begin
   st:=Pos('���',Value);
   if st >0 then  begin
      istr:=copy(value,0,st-1);
   end else  begin
      istr:=Value;
   end;
   PublicUsedMkInfo.Drill_Name:=istr;
end;

procedure TDataModule1.SetExDataType(Value: string);
begin
   ExDataType:=Value;
   DataType:=Value;
end;

function TDataModule1.SetExDBaseInfo(sIP, sUser, sPass: string): Boolean;
begin
   EXDataIP:=sIP;
   ExUser:=sUser;
   EXPassword:=sPass;
end;

function TDataModule1.SetLinkDatabase(MinPath, DName: string): Boolean;
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

procedure TDataModule1.SetMainPath(Value: string);
begin
    inMainPath:=Value;
end;

procedure TDataModule1.SetMySqlPort(Value: string);
begin
    Port:=Value;
end;

procedure TDataModule1.SetSqliteName(Value: string);
begin
   SQLiteName:=Value;
end;


function TDataModule1.SetSystemSnapDataBase(DataType,DataBaseName,AddressIp:String;
                 iSnapData:Boolean;iSnapPort:String): Boolean;
var
   innSnapClient:TMyDataSnap;
begin
    Result:=FALSE;
    if (iSnapData) and ((DataType <> 'ACCESS')) then  begin //��������㹹��
       try
          innSnapClient:=TMyDataSnap.Create(nil);
          if innSnapClient.setConnected(AddressIp, iSnapPort) then  begin
              ExConn.SetHostIp(AddressIp);
              Exconn.ThreeSnap:=true;
              Exconn.SnapPort := iSnapPort;
              Result:=true;
          end;
       finally
          EXConn.SetDataBaseType(DataType);
          FreeAndNil(innSnapClient);
       end;
    end else begin
       Exconn.ThreeSnap:=False;
       if TestDataBaseParameter(DataType)  then
            if  SelectIsExsitDataBase(DataType) then  begin
                DataBaseName:=DataBaseName;
                if ConnectedData(DataType,DataBaseName) then
                   Result:=true;
            end;
    end;

end;

procedure TDataModule1.SetUserId(Value: string);
begin
   inUserID:=Value;
end;

procedure TDataModule1.SetUserName(Value: String);
begin
    inUserName:=Value;
end;

procedure TDataModule1.SetWorkFace_id(Value: string);
begin
    PublicUsedMkInfo.workFace_id:=Value;
end;

procedure TDataModule1.SetWorkFace_Name(Value: string);
var
  st:integer;
  istr:string;
begin
   st:=Pos('������',Value);
   if st >0 then  begin
      istr:=copy(value,0,st-1);
   end else  begin
      istr:=Value;
   end;
   PublicUsedMkInfo.WorkFace_Name:=istr;
end;



function TDataModule1.SqlServerTableisExsitThenDrop(TableName: String): Boolean;
var
 ExCommand1:TMYCommand ;
begin
    Result:=false;
    ExCommand1:=TMyCommand.Create(nil);
    ExCommand1.MySqlConnection :=ExConn;

    try
           ExCommand1.CommandText:=' IF EXISTS ( SELECT  TABLE_NAME FROM INFORMATION_SCHEMA.TABLES '+
                                   ' WHERE   TABLE_NAME ='''+TableName+''' ) DROP TABLE '+TableName ;

           ExCommand1.Execute ;
    finally
       Result:=true;
       FreeAndNil(ExCommand1);
    end;
end;

function TDataModule1.TestDataBaseParameter( Dtype:String): WordBool;
var
   uPass:Boolean;
   Inn_Dtype:String;

begin
    Inn_Dtype:=UpperCase(Dtype);
    SetExDataType(Inn_Dtype);
    SetExDBaseInfo(PublicDataBase.Ip,PublicDataBase.UserName,PublicDataBase.Password);


     if (Inn_Dtype= 'SQLSERVER') or(Inn_Dtype= 'SQL SERVER') then  begin
         SetMySqlPort('1433');
         uPass:= TestServer(Inn_Dtype) ;
         if uPass then  begin
            SQLSERVER_CurrentLocation:= GetSqlServerLocalPath;
         end;

     end else if (Inn_Dtype= 'MYSQL') or (Inn_Dtype= 'MY SQL') then  begin
         SetMySqlPort('3306');
         uPass:= TestMySql(Inn_Dtype) ;
     end else if (Inn_Dtype= 'ACCESS')    then  begin
         Exconn.ThreeSnap:=False;
         uPass:=true;
     end;


     if uPass then begin
        Result:=true;
     end else begin
        Result:=false;
     end;
end;



function TDataModule1.TestMySql(uDType: string): Boolean;
begin
 Result:=false;
     if ConnectedData(uDType,'MySql') then Result:=true;

end;

function TDataModule1.TestServer(uDType: string): Boolean;
begin
      Result:=false;
     if ConnectedData(uDType,'Master') then Result:=true;
end;

procedure TDataModule1.WriteDataTypeIntoFile(Value: string);
begin
//   Public_Baisc.WriteDataBaseType(Value);
end;

constructor TDataModule1.Create(Sender: TObject);
begin
    CreateClass;
end;

function TDataModule1.CreateAccessTable(xl, gzmName, bh: string): Boolean;
var
  sltb1,sltb2: TSQLIteTable;
  CTsql,wStr:string;
  TableName:string;
  ExCommand1:TMYCommand ;
begin
    Result:=false;
    ExCommand1:=TMyCommand.Create(nil);
    ExCommand1.MySqlConnection :=ExConn;

try
     sltb1:=Maindb.GetTable('select * from createtable where ' +
                            '  used =1 and  creatleg='+xl);
     while not sltb1.EOF  do  begin
          {Access ���ݿ� ���ܱ����ļ� ��47�ű� ���ô���}
           //if  sltb1.FieldByName['tableid']='46' then continue;

           if xl='1' then  begin
              TableName:=DecodeUtf8Str(sltb1.FieldByName['CreateTableName']) ;
           end else if  xl='2' then  begin
              TableName:='D_'+gzmname+'_'+UPPerCase(DecodeUtf8Str(sltb1.FieldByName['CreateTableName'])) ;
           end else if xl='3' then begin
              TableName:='D_'+gzmname+'_'+bh+'_'+UPPerCase(DecodeUtf8Str(sltb1.FieldByName['CreateTableName'])) ;
           end;

          if self.AccessTableisExsit(TableName)  then   begin

              ExCommand1.CommandText:=' DROP TABLE '+TableName ;
              ExCommand1.Execute ;
          end;
          CTsql:='' ;
          CTsql:=CTsql+ '  create table '+ TableName  +' ( ';

         sltb2:= Maindb.GetTable('select * from createfields '
             + ' where CreateTableid= '+sltb1.FieldByName['tableid']+ ' and fieldleg=1 ');


            while not sltb2.eof do  begin
                CTsql:=CTsql+ sltb2.FieldByName['fieldname']  +'  ';

                if  (upperCase(sltb2.FieldByName['fieldtype'])='INTEGER' )  and
                    (sltb2.FieldByName['primarykey']='1' )then  begin
                      CTsql:=CTsql+ 'Counter primary Key ' ;
                end else if upperCase(sltb2.FieldByName['fieldtype'])='VARCHAR'  then begin
                   if StrToint(sltb2.FieldByName['length']) > 200 then begin
                      CTsql:=CTsql+  '  Memo' ;
                   end else begin
                      CTsql:=CTsql+  '  '+ sltb2.FieldByName['fieldtype'] ;
                      CTsql:=CTsql+'(' +sltb2.FieldByName['length']+')';
                   end;

                end else begin
                     CTsql:=CTsql+  '  '+ sltb2.FieldByName['fieldtype'] ;
                end;

                if sltb2.FieldByName['isNull']='1' then    CTsql:=CTsql+ ' not null  ';

                CTsql:=CTsql+',';
                sltb2.Next ;
            end;
            CTsql:=LeftStr(CTsql,length(CTsql)-1);

            CTsql:=CTsql+')' ;
            sltb2.Free ;

             ExCommand1.CommandText:=CTsql;
             ExCommand1.Execute ;
        sltb1.Next ;
     end;
        sltb1.Free;

  finally
    Result:=true;
    ExCommand1.Free ;
  end;


end;

procedure TDataModule1.CreateClass;
begin
   ExConn:= TMySqlConnection.Create(nil);
   MyDataSet:=TMyDataSet.Create(nil);
   MyCommand:=TMyCommand.Create(nil);
   MyDataSet.MySqlConnection :=  ExConn;
   MyCommand.MySqlConnection :=  ExConn;

   Connected:=false;
   //
   inMainPath:=GetMainPath;
   new(PublicDataBase);
   new(PublicUsedMkInfo);
   //��ʼ��SQL���ݿ�
   SetSqliteName('CoalBasicDataBase.db');
   initsqliteData;
   if not Assigned(MySqliteDataBase) then
          MySqliteDataBase:=TSqliteADOData.Create('CoalBasicDataBase.db');

   ExUserName:='inn_Admin';
   EXUserID:='-1';

end;

function TDataModule1.CreateMySqlTable(xl, gzmName, bh: string): Boolean;
{//  ���� MYSql ���ݱ�  1 ���������������2 �������빤�����������}
var
  sltb1,sltb2: TSQLIteTable;
  CTsql,wStr,indexStr:string;
  TableName:string;
  ExCommand1:TMYCommand ;
begin
    Result:=false;
    ExCommand1:=TMyCommand.Create(nil);
    ExCommand1.MySqlConnection :=ExConn;
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
                if upperCase(sltb2.FieldByName['fieldtype'])='IMAGE' then  begin
                   CTsql:=CTsql+ sltb2.FieldByName['fieldname']
                      +'  '+ 'MediumBlob' ;
                end else begin
                   CTsql:=CTsql+ sltb2.FieldByName['fieldname']
                      +'  '+ sltb2.FieldByName['fieldtype'] ;
                end;

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

function TDataModule1.CreateServerTable(xl, gzmName, bh: string): Boolean;
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

          CTsql:=' use ' + DataBaseName  ;
          CTsql:=CTsql+ '  create table '+ TableName  +' ( ';

         sltb2:= Maindb.GetTable('select * from createfields '
             + ' where CreateTableid= '+sltb1.FieldByName['tableid']+ ' and fieldleg=1 ');


            while not sltb2.eof do  begin
                CTsql:=CTsql+ sltb2.FieldByName['fieldname']
                      +'  '+ sltb2.FieldByName['Server_fieldtype'] ;

                if  upperCase(sltb2.FieldByName['Server_fieldtype'])='VARCHAR' then
                      CTsql:=CTsql+'(' +sltb2.FieldByName['length']+')';
                if  upperCase(sltb2.FieldByName['Server_fieldtype'])='DECIMAL' then
                      CTsql:=CTsql+'(20,6)';
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
             ExCommand1.Execute ;
        sltb1.Next ;
     end;
        sltb1.Free;

  finally
    Result:=true;
    ExCommand1.Free ;
  end;

end;

// ��ʼ��
initialization  {��Ԫ��ʼ������}
  //�����ٽ���
   initializecriticalsection(FsyncSQL);
   MySQLTableNameList:=TStringlist.Create;

finalization    {��Ԫ�˳�ʱ�Ĵ���}
    //ɾ���ٽ���
    DeleteCriticalSection(FsyncSQL);
    FreeAndNil(MySQLTableNameList);


end.
