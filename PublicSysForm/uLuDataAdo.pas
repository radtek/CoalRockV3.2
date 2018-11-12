//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//<<      文件名：LuleiDataAdo.pas                          <<
//<<      卢国志使用的个人Delphi文件                            <<
//<<      该文件主要是作为访问MySql使用使用的                     <<
//<<      该文件需要libmysql.dll 与 Mysql_win32.inc一起使用
//<<      创建日期：2018.1.10                                   <<
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

unit uLuDataAdo;

interface
 uses  winapi.windows,System.Types, System.SysUtils, System.Classes,mysql,
       System.StrUtils,Data.Win.ADODB, Data.DB,
       Data.DBXDataSnap, Data.DBXCommon,
       IPPeerClient, Datasnap.DBClient, Datasnap.DSConnect, Data.SqlExpr
       ;

type
 Largeint = Int64;
 EDatabaseError = class(Exception);
 TValueBuffer = TArray<Byte>;

 TMyDataSnap = class(TComponent)
    SQLConnection1: TSQLConnection;
    DSProviderConnection1: TDSProviderConnection;
    MySqlClientDataSet1: TClientDataSet;
    MSSQLClientDataSet1: TClientDataSet;

 public
    connected:Boolean;
    function setConnected(AddressIP,Port:string):Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
 end;

 TmyConnection = class(TComponent)
  private
      Host          : string;
      Port          : Integer;
      User          : string;
      Pwd           : string;
      TimeOut       : Integer;
      AutoConn      : Boolean;
      isDataSnap    : Boolean;
      iSnapPort      : String;
      MYSqL_Connected    : Boolean;
      SQLServer_Connect  :Boolean;
      Bool_Begintrans    :Boolean;
      TableNameList       :TStringlist;
      DataBaseIndex : integer; {0 MySql数据库  1 MSSQL数据库}
      ConnectString : WideString;
      ADOConnection: TADOConnection;
  protected
    function GetConnected: Boolean;
    procedure SetConnected(Value: Boolean);
    procedure SetConnectString(Value:WideString);
    function  GetSnapPort:string;
    procedure SetSnapPort(iport:String);
    function  GetIsSnapData:Boolean;
    procedure SetIsSnapData(Value:Boolean);
  public
    FMySQL              : PMYSQL;
    ConnectedDataBase   : string;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { 写数据库的超时时间,读数据库的超时时间,连接数据库的超时时间,是否自动连接}
    procedure SetConnectProperty(InsertOutTime,SelectOutTime,ConnectedOutTime:integer;AutoConn:Boolean);
    function Open(iHost,iPort,iUser,iPwd,iDataBaseName:string):Boolean;
    function OpenAgin :Boolean;
    procedure Close;
    [Default(False)]
    property ServerConnected: Boolean read GetConnected write SetConnected default False;
    property ConnectStr :Widestring Write SetConnectString ;
    property SnapPort   :String read GetSnapPort write SetSnapPort ;
    property ThreeSnap   :Boolean read GetIsSnapData write SetIsSnapData ;

    function BeginTrans: Boolean;
    procedure CommitTrans;
    procedure RollbackTrans;
    procedure SetDataBaseType(Value:String);
    procedure SetHostIp(Value:string);
    // 查找等级的数据表
    function InsertTableName(Name:String):Boolean;
    function DeleteTableName(Name:string):Boolean;
    function isExistTableName(Name:string):Boolean;
    procedure ClearTableName;
  end;

 TMyField =class(TComponent)
    private
        iRowIndex            :integer;
        iFieldIndex          :integer;
        RowsCount            :integer;
        FSetting             :TFormatSettings;
        DataBaseIndex        :Boolean; //FALSE 为MYSQL  true 为其他数据库

        function GetAsBoolean: Boolean;
        function GetAsDateTime: TDateTime;
        function GetAsFloat: Double;
        function GetAsInteger: Longint;
        function GetAsString: string;
        function GetRowIndex:integer;
        procedure SetRowIndex(value:integer);
        function GetFieldIndex:integer;
        procedure SetFieldIndex(value:integer);
        function GetRecordCount:Integer;
        procedure SetRecordCount(Value:integer);
        procedure SetDataBaseIndex(Value:Boolean);
    public
        MySQL_Row               : PMYSQL_ROW;
        ADOField                : TField;
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;

        property AsBoolean: Boolean read GetAsBoolean ;
        property AsDateTime: TDateTime read GetAsDateTime ;
        property AsFloat: Double read GetAsFloat ;
        property AsInteger: Longint read GetAsInteger ;
        property AsString: string read GetAsString;
        property RowIndex:integer read GetRowIndex write SetRowIndex;
        property FieldIndex:integer read GetFieldIndex write SetFieldIndex;
        property RecordCount:integer read GetRecordCount write SetRecordCount;

 end;

 TDataSet =Class(TComponent)
   private
      MySQL_Res           : PMYSQL_RES;
      MySQL_Field         : PMYSQL_FIELD;

      Sql                 :string;
      RowIndex            :integer;
      FieldIndex          :integer;
      NumFields           :integer;
      NumRows             :integer;
      RecordNumbers       :integer;
      innField            :TMyField;
      ADODataSet1         :TADODataSet;
      innMySqlConnection  :TmyConnection ;
      innSnapClient        :TMyDataSnap;
      ImageTable,ImageField:String;
      ImageReadBool         :Boolean;
      function GetSql:string;
      function GetEof:Boolean;
      function GetBof:Boolean;
      function GetRecordCount:integer;
      function GetRecordNo:integer;
      function GetNumFields:integer;
      procedure SetSql(innsql:string);
      function GetConnect:TmyConnection;
      procedure setConnect(inConn:TmyConnection);

   public

      property CommandText:String read GetSql write SetSql;
      property Eof:Boolean  read GetEof;
      property BOF:Boolean  read GetBoF;
      property RecordCount:Integer  read GetRecordCount;
      property RecNo:integer read GetRecordNo;
      property FieldsCount:integer read GetNumFields;
      property MySqlConnection:TmyConnection read GetConnect write setConnect;


      function  Open:Boolean;
      function  MYSqlOpen:Boolean;
      function  Close:Boolean;
      procedure First;
      procedure Last;
      procedure PrevRco;
      Procedure Next;
      function  FieldByName(const FieldName: string): TMyField;
      function  MySqlFieldByName(const FieldName: string):TMyField;

      function  SetFieldImageName(iTableName,iImageFiled:string):Boolean;

      function  SaveImageIntoTable(idName,FileldName,ImageFileName,AddrMemo:string;idValue:integer;Fs:TFileStream):Boolean;
      function  SaveImageIntoSnap(idName,FileldName,ImageFileName,AddrMemo:string;idValue:integer;Fs:TFileStream):Boolean;
      function  SaveImageIntoNotSnap(idName,FileldName,ImageFileName,AddrMemo:string;idValue:integer;Fs:TFileStream):Boolean;
      function  ReadImageFromTAble(idName,FileldName:string;idValue:integer;
                                   Fs:TMemoryStream;var ImageFileName:string):Boolean;
      function  ReadImageFromNotSnap(idName,FileldName:string;idValue:integer;
                                   Fs:TMemoryStream;var ImageFileName:string):Boolean;
      function  ReadImageFromisSnap(idName,FileldName:string;idValue:integer;
                                   Fs:TMemoryStream;var ImageFileName:string):Boolean;

      // 读写文件
      function  SaveFileIntoDataBase(FileType:string;WorkFace,Bm:integer;FileName:string):Boolean;
      function  SaveFrilIntoSnap(FileType:string;WorkFace,Bm:integer;FileName:string):Boolean;
      function  SaveFrilIntoNotSnap(FileType:string;WorkFace,Bm:integer;FileName:string):Boolean;

      function  ReadFileFromDataBase(FileType:string;WorkFace,Bm:integer;FileName:string):Boolean;
      function  ReadFileFromBaseNotSnap(FileType:string;WorkFace,Bm:integer;FileName:string):Boolean;
      function  ReadFileFromBaseSnap(FileType:string;WorkFace,Bm:integer;FileName:string):Boolean;

      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

 End;

TCommand = Class(TComponent)
   private
      MySQL_Res           : PMYSQL_RES;
      sqlText             :String;
      ADOCommand1         : TADOCommand;
      innMySqlConnection  :TmyConnection ;
      innSnapClient        :TMyDataSnap;
      function GetSql:string;
      procedure SetSql(innsql:string);
      function SelectTableName:String;
      function GetConnect:TmyConnection;
      procedure setConnect(inConn:TmyConnection);

   public

      function Execute:Boolean; overload;
      function Execute(UserName:string):Boolean;Overload;
      function MySQLExecute:Boolean;
      property CommandText:String read GetSql write SetSql;
      procedure MyCriticalSection(Sql:String);
      property MySqlConnection:TmyConnection read GetConnect write setConnect;

      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
End;

var
    FsyncSQL:Trtlcriticalsection; // 定义一个异构化空间 ,用于其他函数调用
    MySQLTableNameList       :TStringlist;  // 为MYSQl数据库 独占使用的字符数组

implementation

{ TMySqlConnection }

uses Lu_Public_BasicModual;



function TmyConnection.BeginTrans: Boolean;
var
  t:integer;
  SQl:PAnsiChar;
begin
 if DataBaseIndex >0  then   begin   //不是MySQL数据库
    try
      AdoConnection.BeginTrans;
    finally
      Result:=True;
    end;
 end else  begin  // 如果是MYSQL 数据库
     CommitTrans; //如果有没有提交的事务,代替提交
     Bool_Begintrans:=false;
     Sql:= PAnsiChar(AnsiString('SET AUTOCOMMIT =1'));
     t:=mysql_real_query(&FMySQL,Sql,Length(sql));
     if t<>0 then   begin
         Result:=false;  exit;
     end;
     Sql:=  PAnsiChar(AnsiString('Begin;'));
     t:=mysql_real_query(&FMySQL,Sql,Length(sql));
     if t<>0 then   begin
         Result:=false;  exit;
     end;
     Result:=True;
     Bool_Begintrans:=true;
 end;
end;



procedure TmyConnection.ClearTableName;
begin
   EnterCriticalSection(FSYNCsql);
   try
     MySQLTableNameList.Clear ;
     //TableNameList.Clear ;
   finally
     leavecriticalsection(FSYNCsql);
   end;
end;

procedure TmyConnection.Close;
begin
 if DataBaseIndex >0  then   begin   //不是MySQL数据库
    try
       AdoConnection.Close;
    finally
       ServerConnected:= False ;
    end;
 end else  begin
//    mysql_close(FMySQL);
//    Connected:=false;
 end;
end;

procedure TmyConnection.CommitTrans;
var
  t:integer;
  SQl:PAnsiChar;
begin
   if DataBaseIndex >0  then   begin   //不是MySQL数据库
    AdoConnection.CommitTrans ;
 end else  begin  // 如果是MYSQL 数据库
     if Bool_Begintrans then  begin //提交事务
         Sql:=  PAnsiChar(AnsiString('COMMIT;'));
         t:=mysql_real_query(&FMySQL,Sql,Length(sql));
         Bool_Begintrans:=false;
        //恢复立即提交
//          Sql:= PAnsiChar(AnsiString('SET AUTOCOMMIT =1'));
//          t:=mysql_real_query(&FMySQL,Sql,Length(sql));
     end;
 end;
end;

constructor TmyConnection.Create(AOwner: TComponent);
begin
  inherited;
    {64 位系统需要的}
     libmysql_fast_load(nil);
     MYSqL_Connected:=False;
     FMySQL := mysql_init(nil);
     if FMySQL = nil then
        raise Exception.CreateFmt('mysql_init failed.[%s]', [mysql_error(FMySQL)]);
     TableNameList:=TStringlist.Create ;
     ADOConnection:=TADOConnection.Create(nil);
     ADOConnection.LoginPrompt:=false;
     DataBaseIndex:=0;
     isDataSnap:=False; //默认是 两层数据链接方式
end;

function TmyConnection.DeleteTableName(Name: string): Boolean;
var
  i:integer;
begin
   Result:=false;
   i:=-1;
   EnterCriticalSection(FSYNCsql);
   try
     i:=MySQLTableNameList.IndexOf(Name);
    // i:=TableNameList.IndexOf(Name);
     if i>=0 then  begin
        MySQLTableNameList.Delete(i);
       // TableNameList.Delete(i);
        Result:=true;
     end;
   finally
     leavecriticalsection(FSYNCsql);
   end;

end;

destructor TmyConnection.Destroy;
begin
  if (FMySQL <> nil) then
  begin
    mysql_close(FMySQL);
    FMySQL := nil
  end;
  TableNameList.Free ;
  FreeAndNil(ADOConnection);
  inherited;
end;

function TmyConnection.GetConnected: Boolean;
begin
     Result:=SQLServer_Connect;
end;

function TmyConnection.GetIsSnapData: Boolean;
begin
    Result:=isDataSnap;
end;

function TmyConnection.GetSnapPort: string;
begin
    Result:=iSnapPort;
end;

function TmyConnection.InsertTableName(Name: String): Boolean;
begin
     MySQLTableNameList.Add(Name);
     //TableNameList.Add(Name);
     Result:=true;
end;

function TmyConnection.isExistTableName(Name: string): Boolean;
var
  i:integer;
begin
   Result:=False;
   i:=-1;
   EnterCriticalSection(FSYNCsql);
   try
      i:= MySQLTableNameList.IndexOf(Name) ;
     // i:= TableNameList.IndexOf(Name) ;
      if i>=0 then   Result:=true;
   finally
     leavecriticalsection(FSYNCsql);
   end;
end;

function TmyConnection.Open(iHost,iPort,iUser,iPwd,iDataBaseName: string): Boolean;
var
  uHost,uUser,uPwd,DB: PAnsiChar;
  uPort:integer;
begin
   Result:=False;
   uHost:=PAnsiChar(AnsiString(iHost));
   uUser:=PAnsiChar(AnsiString(iUser));
   uPwd:=PAnsiChar(AnsiString(ipwd));
   uPort:=StrToint(AnsiString(iPort));
   DB:= PAnsiChar(AnsiString(iDataBaseName));
   //
 if iDataBaseName ='' then  DB:='';
   {如果不是MYSQL数据库}
 if DataBaseIndex >0  then   begin   //不是MySQL数据库
    AdoConnection.ConnectionString:=ConnectString;
    try
       AdoConnection.Open;
       if AdoConnection.Connected then  begin
         Result:=True;
       end;
    finally
       ServerConnected:= AdoConnection.Connected ;
       Host:= iHost;
    end;
 end else  begin  // 如果是MYSQL 数据库
   //设置参数
   SetConnectProperty(1000,1000,1000,true);
   if ( MYSqL_Connected ) and (iDataBaseName = ConnectedDataBase ) then   begin
        Result:=true;
   end else if ( MYSqL_Connected ) and (iDataBaseName <> ConnectedDataBase ) then   begin
       if mysql_select_db(FMySQL,DB) = 0 then begin
         MYSqL_Connected:=true;
         Result:=True;
       end else begin
         MYSqL_Connected:=false ;
       end;
   end else if( not MYSqL_Connected )  then  begin
       if mysql_real_connect(FMySQL, uHost, uUser, upwd, DB, uPort, nil, 0) <> nil then begin
         MYSqL_Connected:=true;
         Result:=True;
       end else begin
         MYSqL_Connected:=false;
       end;
   end;
 end;
 // 给变量 赋值
 ConnectedDataBase:=iDataBaseName;
 Host:=iHost;
 User:=iUser;
 Pwd:= iPwd;
 if iPort<>'' then
   Port:=public_Basic.StrToInt_lu(iPort);

end;

function TmyConnection.OpenAgin :Boolean;
Var
  SPort:string;
begin
   Result:=true;

   if port>0 then  sPort:='' else sPort:=IntTostr(port);

   if (not ServerConnected ) and (DataBaseIndex>0 )then  begin

        ADOConnection.Close ;
        ADOConnection.ConnectionString :=ConnectString;
        ADOConnection.Open;
        Result:=ADOConnection.Connected;

   end ;
  if not MySql_Connected then
    if (trim(Host)<> '') and (sPort <>'') and (trim(User)<>'') and
          (trim(Pwd)<> '') and (trim(ConnectedDataBase) <> '') then   begin
            if not Open(Host,sPort,User,Pwd,ConnectedDataBase) then
                  Result:=false;
    end else begin
         Result:=false;
    end;



end;

procedure TmyConnection.RollbackTrans;
var
  t:integer;
  SQl:PAnsiChar;
begin
 if DataBaseIndex >0  then   begin   //不是MySQL数据库
      AdoConnection.RollbackTrans ;

 end else  begin  // 如果是MYSQL 数据库
     if Bool_Begintrans then  begin //回滚事务
        Sql:=  PAnsiChar(AnsiString('ROLLBACK;'));
        t:=mysql_real_query(&FMySQL,Sql,Length(sql));
        Bool_Begintrans:=false;
        //恢复立即提交
//        Sql:= PAnsiChar(AnsiString('SET AUTOCOMMIT =1'));
//        t:=mysql_real_query(&FMySQL,Sql,Length(sql));
     end;
 end;

end;

procedure TmyConnection.SetConnected(Value: Boolean);
begin
    SQLServer_Connect:=Value;
end;

procedure TmyConnection.SetConnectProperty(InsertOutTime, SelectOutTime,
  ConnectedOutTime: integer;AutoConn:Boolean);
var
 write_TimeOut,Read_TimeOut,Connect_TimeOut:PAnsiChar;
begin
    write_TimeOut:=PAnsiChar(intToStr(InsertOutTime));
    Read_TimeOut:= PAnsiChar(intToStr(SelectOutTime));
    Connect_TimeOut:=PAnsiChar(intToStr(ConnectedOutTime));
    // Timeout
  // 写数据库(Update Delete Insert Replace)超时等待时间
  if mysql_options(FMySQL, MYSQL_OPT_WRITE_TIMEOUT, @write_TimeOut) <> 0 then
    raise Exception.CreateFmt('mysql set write timeout error.[%s]', [mysql_error(FMySQL)]);
  // 查询数据库(Select)超时时间
  if mysql_options(FMySQL, MYSQL_OPT_READ_TIMEOUT, @Read_TimeOut) <> 0 then
    raise Exception.CreateFmt('mysql set read timeout error.[%s]', [mysql_error(FMySQL)]);
  // 连接超时时间
  if mysql_options(FMySQL, MYSQL_OPT_CONNECT_TIMEOUT, @Connect_TimeOut) <> 0 then
    raise Exception.CreateFmt('mysql set connect timeout error.[%s]', [mysql_error(FMySQL)]);
  //AutoConnect
 // AutoConn := True;
  if mysql_options(FMySQL, MYSQL_OPT_RECONNECT, @AutoConn) <> 0 then
     raise Exception.CreateFmt('mysql set auto connect error.[%s]', [mysql_error(FMySQL)]);

end;

procedure TmyConnection.SetConnectString(Value: WideString);
begin
    ConnectString:=Value;
end;

procedure TmyConnection.SetDataBaseType(Value: String);
begin
    if (UpperCase(Value)='MYSQL') or  (UpperCase(Value)='MY SQL') then  begin
       DataBaseIndex:=0;
    end else if (UpperCase(Value)= 'SQLSERVER') or(UpperCase(Value)= 'SQL SERVER') then begin
       DataBaseIndex:=1;
    end else if  (UpperCase(Value)= 'ACCESS') then begin
       DataBaseIndex:=2;
    end;
end;

procedure TmyConnection.SetHostIp(Value: string);
begin
    Host:=Value;
end;

procedure TmyConnection.SetIsSnapData(Value: Boolean);
begin
     isDataSnap:=Value;
end;

procedure TmyConnection.SetSnapPort(iport: String);
begin
   iSnapPort:=iPort;
end;

{ TField }



constructor TMyField.Create(AOwner: TComponent);
begin
  inherited;
    //日期格式转换
       FSetting.ShortDateFormat:='yyyy-mm-ss' ;
       FSetting.DateSeparator :='-';
       FSetting.ShortTimeFormat :='hh:nn:ss';
       FSetting.TimeSeparator :=':';
       FSetting.DecimalSeparator :='.';
    DataBaseIndex:=False;
end;

destructor TMyField.Destroy;
begin

  inherited;
end;





function TMyField.GetAsBoolean: Boolean;
var
  intS:Integer;
begin
 if DataBaseIndex then   begin //不是MYSQL数据库
    Result:=ADOField.AsBoolean;
 end else begin
    if RowsCount=0  then begin
      Result:=false;
      exit;
    end;
    intS:=StrToInt(StrPas(MySQL_Row^[iFieldIndex]));
    if intS=1 then
       Result:=true
    else
       Result:=false;
 end;
end;

function TMyField.GetAsDateTime: TDateTime;
var
  iStr:string;
begin
 if  DataBaseIndex then   begin //不是MYSQL数据库
    Result:=ADOField.AsDateTime;
 end else begin
    if RowsCount=0  then begin
      Result:=1;
      exit;
    end;

   iStr:=string(StrPas(MySQL_Row^[iFieldIndex]));
   if trim(iStr)=''  then  Result:=1
    else    Result:=StrToDateTime(iStr,FSetting);
 end;
end;

function TMyField.GetAsFloat: Double;
var
   iStr:String;
begin
if  DataBaseIndex then   begin //不是MYSQL数据库
    Result:=ADOField.AsFloat;
 end else begin

    if RowsCount=0  then begin
      Result:=0;
      exit;
    end;

   iStr:=StrPas(MySQL_Row^[iFieldIndex]);
   if Trim(iStr)='' then   Result:=0
    else   Result:=StrTofloat(iStr);
 end;
end;

function TMyField.GetAsInteger: Longint;
var
   iStr:String;
begin
  if DataBaseIndex then   begin //不是MYSQL数据库
    Result:=ADOField.AsInteger;
 end else begin
    if RowsCount=0  then begin
      Result:=0;
      exit;
    end;

   iStr:=StrPas(MySQL_Row^[iFieldIndex]);
   if Trim(iStr)='' then   Result:=0
    else    Result:=StrToInt(iStr);
 end;
end;



function TMyField.GetAsString: string;
begin
 if DataBaseIndex then   begin //不是MYSQL数据库
    Result:=ADOField.AsString;
 end else begin
     if RowsCount=0  then begin
      Result:='';
      exit;
    end;
    Result:=string(StrPas(MySQL_Row^[iFieldIndex]));
 end;
end;



function TMyField.GetFieldIndex: integer;
begin
 if DataBaseIndex then   begin //是MYSQL数据库
     Result:=iFieldIndex;
 end;


end;

function TMyField.GetRecordCount: Integer;
begin
 if DataBaseIndex then   begin //是MYSQL数据库
     Result:=RowsCount;
 end;

end;

function TMyField.GetRowIndex: integer;
begin
 if DataBaseIndex then   begin //不是MYSQL数据库
    Result:=ADOField.Index;
 end else begin
    Result:=iRowIndex;
 end;
end;

procedure TMyField.SetDataBaseIndex(Value: Boolean);
begin
   DataBaseIndex:=Value;
end;

procedure TMyField.SetFieldIndex(value: integer);
begin
 if not DataBaseIndex then   begin //是MYSQL数据库
    iFieldIndex:=Value;
 end;

end;

procedure TMyField.SetRecordCount(Value: integer);
begin
 if not DataBaseIndex then   begin //是MYSQL数据库
     RowsCount:=Value;
 end;

end;

procedure TMyField.SetRowIndex(value: integer);
begin
 if not DataBaseIndex then   begin //是MYSQL数据库
     iRowIndex:=Value;
 end;

end;

{ TMyDataSet }

function TDataSet.Close: Boolean;
begin
   if MySqlConnection.isDataSnap then begin //如果是三层数据
     if MySqlConnection.DataBaseIndex >0  then   begin   //MSSQL 数据库
        innSnapClient.MSSQLClientDataSet1.Close ;
     end else begin      //MYSQL 数据库
        innSnapClient.MySqlClientDataSet1.Close ;
     end;
   end else begin   // 如果是两层数据
       if MySqlConnection.DataBaseIndex >0  then   begin   //不是MySQL数据库
          AdoDataSet1.Close;
       end else begin
         if MySQL_Res <> nil then    begin
            mysql_free_result(MySQL_Res);
            MySQL_Res := nil;
         end;
       end;
   end;
end;

constructor TDataSet.Create(AOwner: TComponent);
begin
  inherited;
   innField:=TMyField.Create(nil);
   ADODataSet1:=TADODataSet.Create(nil);
   innSnapClient:=TMyDataSnap.Create(nil);
end;

destructor TDataSet.Destroy;
begin
  Close;
  FreeAndNil(innField);
  FreeAndNil(ADODataSet1);
  FreeAndNil(innSnapClient);
  inherited;
end;

function TDataSet.FieldByName(const FieldName: string): TMyField;
begin
   if MySqlConnection.isDataSnap then begin //如果是三层数据
       if MySqlConnection.DataBaseIndex >0  then   begin   //MSSQL 数据库
          innField.DataBaseIndex :=true;
          innField.ADOField:=innSnapClient.MSSQLClientDataSet1.FieldByName(FieldName);
          Result:= innField;
       end else begin      //MYSQL 数据库
          innField.DataBaseIndex :=true;
          innField.ADOField:=innSnapClient.MySqlClientDataSet1.FieldByName(FieldName);
          Result:= innField;
       end;
   end else begin   // 如果是两层数据
       if MySqlConnection.DataBaseIndex >0  then   begin   //不是MySQL数据库
          innField.DataBaseIndex :=true;
          innField.ADOField:=AdoDataSet1.FieldByName(FieldName);
          Result:= innField;
       end else begin   // 如果是MYSQl数据库
          innField.DataBaseIndex:=false;
          Result:=self.MySqlFieldByName(FieldName) ;
       end;
   end;
end;

procedure TDataSet.First;
begin
  if MySqlConnection.isDataSnap then begin //如果是三层数据
     if MySqlConnection.DataBaseIndex >0  then   begin   //MSSQL 数据库
        innSnapClient.MSSQLClientDataSet1.First ;
     end else begin      //MYSQL 数据库
        innSnapClient.MySqlClientDataSet1.First;
     end;
   end else begin   // 如果是两层数据
     if MySqlConnection.DataBaseIndex >0  then   begin   //不是MySQL数据库
        AdoDataSet1.First; ;
     end else begin
        RowIndex :=0;
     end;
   end;
end;

function TDataSet.GetBof: Boolean;
begin
 if MySqlConnection.isDataSnap then begin //如果是三层数据
     if MySqlConnection.DataBaseIndex >0  then   begin   //MSSQL 数据库
        Result:=innSnapClient.MSSQLClientDataSet1.Bof ;
     end else begin      //MYSQL 数据库
        Result:=innSnapClient.MySqlClientDataSet1.Bof ;
     end;
   end else begin   // 如果是两层数据
       if MySqlConnection.DataBaseIndex >0  then   begin   //不是MySQL数据库
          Result:=AdoDataSet1.Bof ;
       end else begin
          if RowIndex = 0 then
            Result:=true
          else
            Result:=false;
       end;
   end;
end;

function TDataSet.GetConnect: TmyConnection;
begin
   Result:=innMySqlConnection;
end;

function TDataSet.GetEof: Boolean;
begin
   if MySqlConnection.isDataSnap then begin //如果是三层数据
     if MySqlConnection.DataBaseIndex >0  then   begin   //MSSQL 数据库
        Result:=innSnapClient.MSSQLClientDataSet1.eof ;
     end else begin      //MYSQL 数据库
        Result:=innSnapClient.MySqlClientDataSet1.Eof ;
     end;
   end else begin   // 如果是两层数据
     if MySqlConnection.DataBaseIndex >0  then   begin   //不是MySQL数据库
        Result:=AdoDataSet1.Eof ;
     end else begin
        if RowIndex = NumRows then
          Result:=true
        else
          Result:=false;
     end;
   end;

end;

function TDataSet.GetNumFields: integer;
begin
   if MySqlConnection.isDataSnap then begin //如果是三层数据
     if MySqlConnection.DataBaseIndex >0  then   begin   //MSSQL 数据库
        Result:=innSnapClient.MSSQLClientDataSet1.Fields.Count ;
     end else begin      //MYSQL 数据库
        Result:=innSnapClient.MySqlClientDataSet1.Fields.Count ;
     end;
   end else begin   // 如果是两层数据
     if MySqlConnection.DataBaseIndex >0  then   begin   //不是MySQL数据库
        Result:=AdoDataSet1.Fields.Count ;
     end else begin
       try
         Result:= self.NumFields;
       except
         on e:exception do begin
            Public_Basic.MY_WriteLog('GetRecordCount:'+e.Message,'[TMyDataSet]');
         end;

       end;
     end;
   end;
end;

function TDataSet.GetRecordCount: integer;
begin
   if MySqlConnection.isDataSnap then begin //如果是三层数据
     if MySqlConnection.DataBaseIndex >0  then   begin   //MSSQL 数据库
        Result:=innSnapClient.MSSQLClientDataSet1.RecordCount ;
     end else begin      //MYSQL 数据库
        Result:=innSnapClient.MySqlClientDataSet1.RecordCount ;
     end;
   end else begin   // 如果是两层数据
     if MySqlConnection.DataBaseIndex >0  then   begin   //不是MySQL数据库
        Result:=AdoDataSet1.RecordCount ;
     end else begin
       try
         Result:= NumRows;
       except
         on e:exception do begin
            Public_Basic.MY_WriteLog('GetRecordCount:'+e.Message,'[TMyDataSet]');
         end;

       end;
     end;
   end;
end;

function TDataSet.GetRecordNo: integer;
begin
  if MySqlConnection.isDataSnap then begin //如果是三层数据
     if MySqlConnection.DataBaseIndex >0  then   begin   //MSSQL 数据库
        Result:=innSnapClient.MSSQLClientDataSet1.RecNo ;
     end else begin      //MYSQL 数据库
        Result:=innSnapClient.MySqlClientDataSet1.RecNo ;
     end;
   end else begin   // 如果是两层数据
       if MySqlConnection.DataBaseIndex >0  then   begin   //不是MySQL数据库
          Result:=AdoDataSet1.RecNo ;
       end else begin
         try
           Result:= RowIndex+1;
         except
           on e:exception do begin
              Public_Basic.MY_WriteLog('GetRecordCount:'+e.Message,'[TMyDataSet]');
           end;
         end;
       end;
   end;

end;

function TDataSet.GetSql: string;
begin
    Result:=sql;
end;

procedure TDataSet.Last;
begin
  if MySqlConnection.isDataSnap then begin //如果是三层数据
       if MySqlConnection.DataBaseIndex >0  then   begin   //MSSQL 数据库
          innSnapClient.MSSQLClientDataSet1.Last  ;
       end else begin      //MYSQL 数据库
          innSnapClient.MySqlClientDataSet1.Last;
       end;
   end else begin   // 如果是两层数据
       if MySqlConnection.DataBaseIndex >0  then   begin   //不是MySQL数据库
          AdoDataSet1.Last; ;
       end else begin
          RowIndex :=NumRows-1;
       end;
   end;
end;

function TDataSet.MySqlFieldByName(const FieldName: string): TMyField;
var
  i:integer;
begin
  if MySQL_Res <> nil  then    begin
    NumFields := mysql_num_fields(MySQL_Res);
    for i := 0 to NumFields - 1 do     begin
      MySQL_Field := mysql_fetch_field_direct(MySQL_Res, i);
      if MySQL_Field <> nil  then       begin
        if UpperCase(string(mysql_field_name(MySQL_Field))) = UpperCase(FieldName) then
        begin
          FieldIndex := i;
          Break;
        end;
      end;
    end;
    if i= NumFields then begin
      Public_Basic.MY_WriteLog('Eorr:No Find '+FieldName+' Fields_' +Sql ,'[TMyDataSet]');
    end;

    if RowIndex <= NumRows - 1 then
      mysql_data_seek(MySQL_Res, RowIndex);
  end;

  innField.MySQL_Row:= mysql_fetch_row(MySQL_Res);
  innField.SetRowIndex(RowIndex);
  innField.SetFieldIndex(FieldIndex);
  innField.SetRecordCount(NumRows);
  Result:= innField;

  //edtResult.Text := string(StrPas(MySQL_Row^[FieldIndex]));
end;

function TDataSet.MYSqlOpen: Boolean;
var
  Query : string;
begin
  Result:=false;
  Query := sql;
  if not MySqlConnection.OpenAgin  then exit;
 try
  if mysql_real_query(MySqlConnection.FMySQL, PAnsiChar(AnsiString(Query)), Length(AnsiString(Query))) = 0 then  begin
     MySQL_Res := mysql_store_result(MySqlConnection.FMySQL);
     NumRows := mysql_num_rows(MySQL_Res);
     RowIndex:=0;
     Result:=true;
  end else begin
     NumRows:=0;RowIndex:=0;
  end;
  except
     on e:exception do begin
        Public_Basic.MY_WriteLog('OpenEorr:'+e.Message,'[TMyDataSet]');
     end;
   end;
end;

procedure TDataSet.Next;
begin
 if MySqlConnection.isDataSnap then begin //如果是三层数据
       if MySqlConnection.DataBaseIndex >0  then   begin   //MSSQL 数据库
          innSnapClient.MSSQLClientDataSet1.Next;
       end else begin      //MYSQL 数据库
          innSnapClient.MySqlClientDataSet1.Next;
       end;
   end else begin   // 如果是两层数据
       if MySqlConnection.DataBaseIndex >0  then   begin   //不是MySQL数据库
          AdoDataSet1.Next; ;
       end else begin
          if RowIndex <NumRows then
             RowIndex:=RowIndex+1;
       end;
   end;

end;

function TDataSet.Open: Boolean;
begin
   if (MySqlConnection.isDataSnap) and (MySqlConnection.Host<>'') then  begin //如果是三层数据
      if not innSnapClient.connected then
        if innSnapClient.setConnected(MySqlConnection.Host, MySqlConnection.SnapPort) then  begin
           MySqlConnection.isDataSnap:=true;
           innSnapClient.connected:=true;
        end else begin
           MySqlConnection.isDataSnap:=FAlse;
           innSnapClient.connected:=true;
        end;
   end else begin
        MySqlConnection.isDataSnap:=FAlse;
        innSnapClient.connected:=true;
   end;

 if MySqlConnection.isDataSnap then begin //如果是三层数据
     if MySqlConnection.DataBaseIndex >0  then   begin   //MSSQL 数据库
        innSnapClient.MSSQLClientDataSet1.CommandText :=sql;
        try
          innSnapClient.MSSQLClientDataSet1.Open ;
          Result:=True;
        except
          Result:=False ;
        end;
     end else begin      //MYSQL 数据库
        innSnapClient.MySqlClientDataSet1.CommandText :=sql;
        try
          innSnapClient.MySqlClientDataSet1.Open ;
          Result:=True;
        except
          Result:=False;
        end;
     end;
 end else begin   // 如果是两层数据
    if MySqlConnection.DataBaseIndex >0  then   begin   //不是MySQL数据库
        AdoDataSet1.Connection:=MySqlConnection.ADOConnection;
        AdoDataSet1.CommandText:=sql;
        try
            AdoDataSet1.Open;
             Result:=True;
        except
             Result:=False
        end;
    end else begin
        Result:=MYSqlOpen;
    end;
 end;

end;

procedure TDataSet.PrevRco;
begin
   if MySqlConnection.isDataSnap then begin //如果是三层数据
       if MySqlConnection.DataBaseIndex >0  then   begin   //MSSQL 数据库
          innSnapClient.MSSQLClientDataSet1.Prior;
       end else begin      //MYSQL 数据库
          innSnapClient.MySqlClientDataSet1.Prior;
       end;
   end else begin   // 如果是两层数据
       if MySqlConnection.DataBaseIndex >0  then   begin   //不是MySQL数据库
          if AdoDataSet1.RecNo>0 then
             AdoDataSet1.Prior ;
       end else begin
           if RowIndex >0 then
             RowIndex:=RowIndex-1;
       end;
   end;
end;

function TDataSet.ReadFileFromBaseNotSnap(FileType: string; WorkFace,
  Bm: integer;FileName:string):Boolean;
var
  innC:TADOConnection;
  AdoCQuery:TAdoQuery;
  sConn,sql:String;
  Stream:TMemoryStream;
begin

   REsult:=False;
   innC:=TADOConnection.Create(nil) ;
   innC.LoginPrompt:=false;
   AdoCQuery:=TAdoQuery.Create(nil);
   try
      if (MySqlConnection.DataBaseIndex=1) then  begin
          sConn    := 'Provider=SQLOLEDB.1;Persist Security Info=True;Connect   Timeout=30 '
                    + ';Data Source='+MySqlConnection.Host
                    + ';Initial Catalog='+MySqlConnection.ConnectedDataBase
                    + ';User ID =' +MySqlConnection.User
                    + ';Password='+ MySqlConnection.Pwd
                    + ';Packet Size='+InttoStr(4096)   //一个Integer值，一般是4096
                    + ';';
      end else if (MySqlConnection.DataBaseIndex=0)  then  begin
          sConn   :='DRIVER={MySQL ODBC 3.51 Driver}'
                    + ';SERVER='+MySqlConnection.Host
                    + ';PORT='+intToStr(MySqlConnection.Port)
                    + ';DATABASE='+MySqlConnection.ConnectedDataBase
                    + ';USER='+MySqlConnection.User
                    + ';PASSWORD='+MySqlConnection.Pwd
                    + ';OPTION=3'
                    + ';' ;
      end ;
      innC.ConnectionString:=sConn;
      innC.Open ;
      if innC.Connected then  begin
         Stream:=TMemoryStream.Create ;
         AdoCQuery.Connection :=innC;
         AdoCQuery.Close ;
         sql:=  ' select  *  from FileDataBase where FileType ='''+ FileType+'''  and WorkFaceid='  +
                IntToStr(WorkFace) + ' and  Num_bh = ' + IntToStr(BM) ;
          AdoCQuery.SQL.Add(sql) ;
          AdoCQuery.Open ;
          if AdoCQuery.RecordCount>0  then begin
              TBlobField(AdoCQuery.FieldByName('FileBody')).SaveToStream(Stream);
          end;
          AdoCQuery.Close ;
          if Stream.Size >100 then  begin
             Stream.SaveToFile(FileName);
             Result:=True;
          end;
         Stream.Free ;
      end;
   finally
      FreeAndnil(innC);
      FreeAndNil(AdoCQuery);
   end;

end;

function TDataSet.ReadFileFromBaseSnap(FileType: string; WorkFace,
  Bm: integer;FileName:string):Boolean;
var
   ClientData:TClientDataSet;
   sql:string;
   Stream:TMemoryStream;
begin
  Result:=False;
   { 表名不一致或者 ImageReadBool 为加}
  if not ImageReadBool then    exit;
   { 不是三层 退出}
  if  (not MySqlConnection.ThreeSnap) then  exit;
   { Access 退出}
  if (MySqlConnection.DataBaseIndex=2) then  exit;

   if MySqlConnection.DataBaseIndex >0  then   begin   //MSSQL 数据库
      ClientData:=innSnapClient.MSSQLClientDataSet1 ;
   end else begin      //MYSQL 数据库
      ClientData:=innSnapClient.MySqlClientDataSet1 ;
   end;
   // 链接数据源
   if not innSnapClient.connected then
        if not innSnapClient.setConnected(MySqlConnection.Host, MySqlConnection.SnapPort) then
         exit;
   Stream:=TMemoryStream.Create ;
   try
   //
      sql:=  ' select  *  from FileDataBase where FileType ='''+ FileType+'''  and WorkFaceid='  +
            IntToStr(WorkFace) + ' and  Num_bh = ' + IntToStr(BM) ;
      ClientData.Close ;
      ClientData.CommandText := sql;
      ClientData.Open ;


      TBlobField(ClientData.FieldByName(ImageField)).SaveToStream(Stream);
      Stream.SaveToFile(FileName);
      Result:=True;
   finally
      Stream.Free ;
   end;


end;

function TDataSet.ReadFileFromDataBase(FileType: string; WorkFace,
  Bm: integer;FileName:string):Boolean;
begin
   Result:=False;
  { Access 退出}
  if (MySqlConnection.DataBaseIndex=2) then  exit;
   { 不是三层 退出}
  if  ( MySqlConnection.ThreeSnap) then  begin
     Result:=ReadFileFromBaseSnap(FileType,WorkFace,Bm,FileName);
  end else begin
     Result:=ReadFileFromBaseNotSnap(FileType,WorkFace,Bm,FileName);
  end;
end;

function TDataSet.ReadImageFromisSnap(idName, FileldName: string;
  idValue: integer; Fs: TMemoryStream; var ImageFileName: string): Boolean;
var
   ClientData:TClientDataSet;
   sql:string;
   Stream:TMemoryStream;
begin
  Result:=False;
   { 表名不一致或者 ImageReadBool 为加}
  if not ImageReadBool then    exit;
   { 不是三层 退出}
  if  (not MySqlConnection.ThreeSnap) then  exit;
   { Access 退出}
  if (MySqlConnection.DataBaseIndex=2) then  exit;

   if MySqlConnection.DataBaseIndex >0  then   begin   //MSSQL 数据库
      ClientData:=innSnapClient.MSSQLClientDataSet1 ;
   end else begin      //MYSQL 数据库
      ClientData:=innSnapClient.MySqlClientDataSet1 ;
   end;
   // 链接数据源
   if not innSnapClient.connected then
        if not innSnapClient.setConnected(MySqlConnection.Host, MySqlConnection.SnapPort) then
         exit;

   //
   sql:='select * from ' + ImageTable + ' where ' +idName + '=' + IntTostr(idValue);
   ClientData.Close ;
   ClientData.CommandText := sql;
   ClientData.Open ;

   Stream:=TMemoryStream.Create ;
   TBlobField(ClientData.FieldByName(ImageField)).SaveToStream(Stream);
   ImageFileName:=ClientData.FieldByName(FileldName).AsString;
   ClientData.Close ;
   if Stream.Size >100 then  begin
       FS.LoadFromStream(Stream);
       Result:=True;
   end;
   Stream.Free ;

end;

function TDataSet.ReadImageFromNotSnap(idName, FileldName: string;
  idValue: integer; Fs: TMemoryStream; var ImageFileName: string): Boolean;
var
  innC:TADOConnection;
  AdoCQuery:TAdoQuery;
  sConn,sql:String;
  Stream:TMemoryStream;
begin

   REsult:=False;
   innC:=TADOConnection.Create(nil) ;
   innC.LoginPrompt:=false;
   AdoCQuery:=TAdoQuery.Create(nil);
   try
      if (MySqlConnection.DataBaseIndex=1) then  begin
          sConn    := 'Provider=SQLOLEDB.1;Persist Security Info=True;Connect   Timeout=30 '
                    + ';Data Source='+MySqlConnection.Host
                    + ';Initial Catalog='+MySqlConnection.ConnectedDataBase
                    + ';User ID =' +MySqlConnection.User
                    + ';Password='+ MySqlConnection.Pwd
                    + ';Packet Size='+InttoStr(4096)   //一个Integer值，一般是4096
                    + ';';
      end else if (MySqlConnection.DataBaseIndex=0)  then  begin
          sConn   :='DRIVER={MySQL ODBC 3.51 Driver}'
                    + ';SERVER='+MySqlConnection.Host
                    + ';PORT='+intToStr(MySqlConnection.Port)
                    + ';DATABASE='+MySqlConnection.ConnectedDataBase
                    + ';USER='+MySqlConnection.User
                    + ';PASSWORD='+MySqlConnection.Pwd
                    + ';OPTION=3'
                    + ';' ;
      end ;
      innC.ConnectionString:=sConn;
      innC.Open ;
      if innC.Connected then  begin
         AdoCQuery.Connection :=innC;
         AdoCQuery.Close ;
          sql:='select * from ' + ImageTable + ' where ' +idName + '=' + IntTostr(idValue);
          AdoCQuery.SQL.Add(sql) ;
          AdoCQuery.Open ;
          Stream:=TMemoryStream.Create ;
          TBlobField(AdoCQuery.FieldByName(ImageField)).SaveToStream(Stream);
          ImageFileName:=AdoCQuery.FieldByName(FileldName).AsString;
          AdoCQuery.Close ;
          if Stream.Size >100 then  begin
             FS.LoadFromStream(Stream);
             Result:=True;
          end;
         Stream.Free ;
      end;
   finally
      FreeAndnil(innC);
      FreeAndNil(AdoCQuery);
   end;
end;

function TDataSet.ReadImageFromTAble(idName,FileldName:string;idValue:integer;
                                    Fs:TMemoryStream;var ImageFileName:string): Boolean;
begin
  Result:=False;
   { 表名不一致或者 ImageReadBool 为加}
  if not ImageReadBool then    exit;

   { Access 退出}
  if (MySqlConnection.DataBaseIndex=2) then  exit;
   { 不是三层 退出}
  if  ( MySqlConnection.ThreeSnap) then  begin
     Result:=ReadImageFromisSnap(idName,FileldName,idValue,FS,ImageFileName);
  end else begin
     Result:=ReadImageFromNotSnap(idName,FileldName,idValue,FS,ImageFileName);
  end;
end;

function TDataSet.SaveFileIntoDataBase(FileType: string; WorkFace, Bm: integer;
  FileName: string): Boolean;
begin
   Result:=False;
    { Access 退出}
  if (MySqlConnection.DataBaseIndex=2) then  begin   //如果是ACCESS
     exit;
  end;

   { 不是三层 退出}

    if  ( MySqlConnection.ThreeSnap) then  begin
       Result:=SaveFrilIntoSnap(FileType,WorkFace,Bm,FileName);
    end else begin
       Result:=SaveFrilIntoNotSnap(FileType,WorkFace,Bm,FileName);
    end;
end;

function TDataSet.SaveFrilIntoNotSnap(FileType: string; WorkFace, Bm: integer;
  FileName: string): Boolean;
var
  innC:TADOConnection;
  AdoCQuery:TAdoQuery;
  sConn,sql:String;
  Stream:TFileStream;
begin

   REsult:=False;
   innC:=TADOConnection.Create(nil) ;
   innC.LoginPrompt:=false;
   AdoCQuery:=TAdoQuery.Create(nil);
   try
      if (MySqlConnection.DataBaseIndex=1) then  begin
          sConn    := 'Provider=SQLOLEDB.1;Persist Security Info=True;Connect   Timeout=30 '
                    + ';Data Source='+MySqlConnection.Host
                    + ';Initial Catalog='+MySqlConnection.ConnectedDataBase
                    + ';User ID =' +MySqlConnection.User
                    + ';Password='+ MySqlConnection.Pwd
                    + ';Packet Size='+InttoStr(4096)   //一个Integer值，一般是4096
                    + ';';
      end else if (MySqlConnection.DataBaseIndex=0)  then  begin
          sConn   :='DRIVER={MySQL ODBC 3.51 Driver}'
                    + ';SERVER='+MySqlConnection.Host
                    + ';PORT='+intToStr(MySqlConnection.Port)
                    + ';DATABASE='+MySqlConnection.ConnectedDataBase
                    + ';USER='+MySqlConnection.User
                    + ';PASSWORD='+MySqlConnection.Pwd
                    + ';OPTION=3'
                    + ';' ;
      end ;
      innC.ConnectionString:=sConn;
      innC.Open ;
      if innC.Connected then  begin
         AdoCQuery.Connection :=innC;
         AdoCQuery.Close ;
         AdoCQuery.SQL.Clear ;
         sql:='insert into FileDataBase (FileType,WorkFaceid,Num_bh,starttime,EndTime,FileBody) values  (:s0,:s1,:s2,:s3,:s4,:s5)';
         AdoCQuery.SQL.Add(sql);
         AdoCQuery.Parameters.ParamByName('s0').Value:=FileType;
         AdoCQuery.Parameters.ParamByName('s1').Value:=intTostr(WorkFace);
         AdoCQuery.Parameters.ParamByName('s2').Value:=intTostr(Bm);
         AdoCQuery.Parameters.ParamByName('s3').Value:=-1;
         AdoCQuery.Parameters.ParamByName('s4').Value:=-1;
         Stream:=TFileStream.Create(FileName,fmOpenRead);
         Stream.Seek(0, 0);
         AdoCQuery.Parameters.ParamByName('s5').LoadFromStream(stream,ftBlob);
         AdoCQuery.ExecSQL ;
         stream.Free;
         Result:=true;
      end;
   finally
      FreeAndnil(innC);
      FreeAndNil(AdoCQuery);
   end;


end;

function TDataSet.SaveFrilIntoSnap(FileType: string; WorkFace, Bm: integer;
  FileName: string): Boolean;
var
   ClientData:TClientDataSet;
   sql:string;
   stream:TFileStream;
begin
  Result:=False;
   { 表名不一致或者 ImageReadBool 为加}
  if not ImageReadBool  then    exit;
   { 不是三层 退出}
  if  (not MySqlConnection.ThreeSnap) then  exit;
   { Access 退出}
  if (MySqlConnection.DataBaseIndex=2) then  exit;

   if MySqlConnection.DataBaseIndex >0  then   begin   //MSSQL 数据库
      ClientData:=innSnapClient.MSSQLClientDataSet1 ;
   end else begin      //MYSQL 数据库
      ClientData:=innSnapClient.MySqlClientDataSet1 ;
   end;
   //
   sql:='insert into FileDataBase (FileType,WorkFaceid,Num_bh,starttime,EndTime,FileBody) values  (:s0,:s1,:s2,:s3,:s4,:s5)';
   ClientData.Close ;
   ClientData.CommandText:=sql;

   ClientData.Params.ParamByName('s0').Value:=FileType;
   ClientData.Params.ParamByName('s1').Value:=intTostr(WorkFace);
   ClientData.Params.ParamByName('s2').Value:=intTostr(Bm);
   ClientData.Params.ParamByName('s3').Value:=-1;
   ClientData.Params.ParamByName('s4').Value:=-1;
   Stream:=TFileStream.Create(FileName,fmOpenRead);
   Stream.Seek(0, 0);
   ClientData.Params.ParamByName('s5').LoadFromStream(stream,ftBlob);
   stream.Free;
   ClientData.Execute;
   Result:=True;

end;

function TDataSet.SaveImageIntoNotSnap(idName, FileldName, ImageFileName,
  AddrMemo: string; idValue: integer; Fs: TFileStream): Boolean;
var
  innC:TADOConnection;
  AdoCQuery:TAdoQuery;
  sConn,sql:String;
  Stream:TMemoryStream;
begin

   REsult:=False;
   innC:=TADOConnection.Create(nil) ;
   innC.LoginPrompt:=false;
   AdoCQuery:=TAdoQuery.Create(nil);
   try
      if (MySqlConnection.DataBaseIndex=1) then  begin
          sConn    := 'Provider=SQLOLEDB.1;Persist Security Info=True;Connect   Timeout=30 '
                    + ';Data Source='+MySqlConnection.Host
                    + ';Initial Catalog='+MySqlConnection.ConnectedDataBase
                    + ';User ID =' +MySqlConnection.User
                    + ';Password='+ MySqlConnection.Pwd
                    + ';Packet Size='+InttoStr(4096)   //一个Integer值，一般是4096
                    + ';';
      end else if (MySqlConnection.DataBaseIndex=0)  then  begin
          sConn   :='DRIVER={MySQL ODBC 3.51 Driver}'
                    + ';SERVER='+MySqlConnection.Host
                    + ';PORT='+intToStr(MySqlConnection.Port)
                    + ';DATABASE='+MySqlConnection.ConnectedDataBase
                    + ';USER='+MySqlConnection.User
                    + ';PASSWORD='+MySqlConnection.Pwd
                    + ';OPTION=3'
                    + ';' ;
      end ;
      innC.ConnectionString:=sConn;
      innC.Open ;
      if innC.Connected then  begin
         AdoCQuery.Connection :=innC;
         AdoCQuery.Close ;
          sql:='update ' + ImageTable + '  set ' +ImageField + '=(:Faces) '  +
               ' ,  ' +FileldName + '= ''' + ImageFileName +''', Memo1= ''' + AddrMemo+''' ' +
               '   where ' +idName + '=' + IntTostr(idValue);
          AdoCQuery.SQL.Add(sql) ;
          stream:=TMemoryStream.Create ;
          stream.LoadFromStream(Fs);
          AdoCQuery.Parameters.ParamByName('Faces').LoadFromStream(stream,ftBlob);
          AdoCQuery.ExecSQL ;
          stream.Free;
          Result:=true;
      end;
   finally
      FreeAndnil(innC);
      FreeAndNil(AdoCQuery);
   end;

end;

function TDataSet.SaveImageIntoSnap(idName, FileldName, ImageFileName,
  AddrMemo: string; idValue: integer; Fs: TFileStream): Boolean;
var
   ClientData:TClientDataSet;
   sql:string;
   stream:TMemoryStream;
begin
  Result:=False;
   { 表名不一致或者 ImageReadBool 为加}
  if not ImageReadBool  then    exit;
   { 不是三层 退出}
  if  (not MySqlConnection.ThreeSnap) then  exit;
   { Access 退出}
  if (MySqlConnection.DataBaseIndex=2) then  exit;

   if MySqlConnection.DataBaseIndex >0  then   begin   //MSSQL 数据库
      ClientData:=innSnapClient.MSSQLClientDataSet1 ;
   end else begin      //MYSQL 数据库
      ClientData:=innSnapClient.MySqlClientDataSet1 ;
   end;
   //
   sql:='update ' + ImageTable + '  set ' +ImageField + '=(:Faces) '  +
         ' ,  ' +FileldName + '= ''' + ImageFileName +''', Memo1= ''' + AddrMemo+''' ' +
         '   where ' +idName + '=' + IntTostr(idValue);
   ClientData.Close ;
   ClientData.CommandText:=sql;
   stream:=TMemoryStream.Create ;
   stream.LoadFromStream(Fs);
   ClientData.Params.ParamByName('Faces').LoadFromStream(stream,ftBlob);
   stream.Free;
   ClientData.Execute;
   Result:=True;

end;

function TDataSet.SaveImageIntoTable(idName,FileldName,ImageFileName,AddrMemo: string; idValue: integer;
  Fs: TFileStream): Boolean;
var
   ClientData:TClientDataSet;
   sql:string;
   stream:TMemoryStream;
begin
  Result:=False;
   { 表名不一致或者 ImageReadBool 为加}
  if not ImageReadBool  then    exit;
   { Access 退出}
  if (MySqlConnection.DataBaseIndex=2) then  begin   //如果是ACCESS
     exit;
  end;

   { 不是三层 退出}

    if  ( MySqlConnection.ThreeSnap) then  begin
       Result:=SaveImageIntoSnap(idName,FileldName,ImageFileName,AddrMemo,idValue,Fs);
    end else begin
       Result:=SaveImageIntoNotSnap(idName,FileldName,ImageFileName,AddrMemo,idValue,Fs);
    end;



end;

procedure TDataSet.setConnect(inConn: TmyConnection);
begin
    innMySqlConnection:=inConn;

end;

function TDataSet.SetFieldImageName(iTableName, iImageFiled: string): Boolean;
begin
    ImageTable:=iTableName;
    ImageField:=iImageFiled;
    ImageReadBool:=True;
end;

procedure TDataSet.SetSql(innsql:string);
begin
  Sql:=innSql;
end;

{ TMyCommand }

constructor TCommand.Create(AOwner: TComponent);
begin
  ADOCommand1:=TADOCommand.Create(nil) ;
  innSnapClient:=TMyDataSnap.Create(nil);
  inherited;
end;

destructor TCommand.Destroy;
begin
  FreeAndNil(ADOCommand1);
  FreeAndNil(innSnapClient);
  inherited;
end;

function TCommand.Execute(UserName: string): Boolean;
var
  tempStr,Sql1:String;
begin
   tempStr:=Getsql;
   if Execute then begin
      Result:=True;
      Sql1:='insert into UserLoginlog (UserName,TextValue,Generatetime)  values ( ' +
            '''' + UserName+''','''+LeftStr(tempStr,15) +''','''  +
            FormatDateTime('YYYY-MM-DD HH:NN:SS',Now()) +''')';
//       Sql1:='insert into UserLoginlog (UserName,TextValue,Generatetime)  values ( ' +
//            '''' + UserName+''', ?,'''  +
//            FormatDateTime('YYYY-MM-DD HH:NN:SS',Now()) +''')';

      SetSql(Sql1);
      Execute;
   end else begin
      Result:=False;
   end;

end;

procedure TCommand.MYCriticalSection(Sql: String);
begin
    EnterCriticalSection(FSYNCsql);
     try
       CommandText:=Sql;
       Execute;
     finally
       leavecriticalsection(FSYNCsql);
     end;
end;

function TCommand.MySQLExecute: Boolean;
var
  TableName:string;
  icount:integer;
begin
   Result:=false;
   try
      if not MySqlConnection.OpenAgin then exit;

       TableName:= SelectTableName;
      if TableName = 'other' then  begin
         if mysql_real_query(MySqlConnection.FMySQL, PAnsiChar(AnsiString(SQLText)), Length(AnsiString(SQLText)))  =0 then begin
                  //当执行的SQL语句返回结果集时，一定要释放结果集
                    MySQL_Res := mysql_store_result(MySqlConnection.FMySQL);
                    if MySQL_Res <> nil then   begin
                      mysql_free_result(MySQL_Res);
                      MySQL_Res := nil;
                      Result:=true;
                    end;
        end;

      end else if TableName <> 'nill' then  begin
         icount:=0;
         while (MySqlConnection.isExistTableName(TableName)) do  begin
            sleep(100);
            icount:=icount+1;
            if(icount> 10*60*10) then  MySqlConnection.ClearTableName;
         end;
         try
            MySqlConnection.InsertTableName(TableName);
             if mysql_real_query(MySqlConnection.FMySQL, PAnsiChar(AnsiString(SQLText)), Length(AnsiString(SQLText)))  =0 then begin
                //当执行的SQL语句返回结果集时，一定要释放结果集
                  MySQL_Res := mysql_store_result(MySqlConnection.FMySQL);
                  if MySQL_Res <> nil then   begin
                    mysql_free_result(MySQL_Res);
                    MySQL_Res := nil;
                  end;
                 Result:=true;
             end;
         finally
            MySqlConnection.DeleteTableName(TableName);
         end;
      end;

   except
     on e:exception do begin
        Public_Basic.MY_WriteLog('Sum_Eorr:'+SQLText+e.Message,'[TMyCommand]');
     end;

   end;

end;

function TCommand.Execute: Boolean;
begin
  if (MySqlConnection.isDataSnap) and (MySqlConnection.Host<>'') then  begin //如果是三层数据
      if not innSnapClient.connected then
        if innSnapClient.setConnected(MySqlConnection.Host, MySqlConnection.SnapPort) then  begin
           MySqlConnection.isDataSnap:=true;
           innSnapClient.connected:=true;
        end else begin
           MySqlConnection.isDataSnap:=FAlse;
           innSnapClient.connected:=true;
        end;
   end else begin
        MySqlConnection.isDataSnap:=FAlse;
        innSnapClient.connected:=true;
   end;


if MySqlConnection.isDataSnap then begin //如果是三层数据
     if MySqlConnection.DataBaseIndex >0  then   begin   //MSSQL 数据库
        innSnapClient.MSSQLClientDataSet1.CommandText :=sqlText;
        try
          innSnapClient.MSSQLClientDataSet1.Execute ;
          Result:=True;
        except
          Result:=False ;
        end;
     end else begin      //MYSQL 数据库
        innSnapClient.MySqlClientDataSet1.CommandText :=sqlText;
        try
          innSnapClient.MySqlClientDataSet1.Execute ;
          Result:=True;
        except
          Result:=False;
        end;
     end;
 end else begin   // 如果是两层数据
       if MySqlConnection.DataBaseIndex >0  then   begin   //不是MySQL数据库
           ADOCommand1.Connection:=MySqlConnection.ADOConnection;
           ADOCommand1.CommandText:=sqlText;
         try
           ADOCommand1.Execute;
         finally
           Result:=true;
         end;
       end else begin
          Result:=MySqlExecute;
       end;
 end;
end;

function TCommand.GetConnect: TmyConnection;
begin
    Result:=innMySqlConnection;
end;

function TCommand.GetSql: string;
begin
    Result:=sqlText;
end;

function TCommand.SelectTableName: String;
Var
  St,Command_S:AnsiString;
  Name:String;
  i,j:integer;
begin
   St:=AnsiLowerCase(Trim(leftstr(sqlText,100)));
   if length(st) <1 then begin
       Result:='nill';  exit;
   end;
   Command_S:=AnsiLowerCase(leftStr(st,6));
   St:=trim(Rightstr(st,length(st)-6));
   if Command_S='insert' then  begin
      i:=pos(' ',st);
      j:=pos('(',st);
      Name:=midstr(st,i,j-i);
   end else if Command_S='update' then  begin
      j:=pos('set',st);
      Name:=midstr(st,1,j-1);
   end else if Command_S='delete' then  begin
      i:=pos(' ',st);
      j:=pos('where',st);
      if j= 0 then   j:=length(st);
      Name:=midstr(st,i,j-i);
   end else begin
      Name:='other';
   end;

   Result:=Trim(Name);

end;

procedure TCommand.setConnect(inConn: TmyConnection);
begin
  innMySqlConnection:=inConn;

end;

procedure TCommand.SetSql(innsql: string);
begin
    sqlText:=innsql;
end;





{ TDataSnap }


{ TDataSnap }

function TMyDataSnap.setConnected(AddressIP, Port: string): Boolean;
begin
  Result:=true;
  SQLConnection1.Close ;
  SQLConnection1.DriverName:='DataSnap';
  SQLConnection1.LoginPrompt:=False;
  SQLConnection1.Params.Values['HostName']:=AddressIP ;
  SQLConnection1.Params.Values['Port']:=Port ;
  try
    SQLConnection1.Connected:=true;
  except
    Result:=False;
  end;
  //
 DSProviderConnection1.ServerClassName:='TServerMethods1';
 DSProviderConnection1.SQLConnection:= SQLConnection1;
 //
 MySqlClientDataSet1.RemoteServer:= DSProviderConnection1;
 MySqlClientDataSet1.ProviderName:='MySqQueryProv1';
 //
 MSSQLClientDataSet1.RemoteServer:= DSProviderConnection1;
 MSSQLClientDataSet1.ProviderName:='MSSQLDataSetProvider1';
end;

constructor TMyDataSnap.Create(AOwner: TComponent);
begin
  inherited;
  if not Assigned(SQLConnection1) then
        SQLConnection1:=TSQLConnection.Create(self);
  if not Assigned(DSProviderConnection1) then
        DSProviderConnection1:=TDSProviderConnection.Create(self);
  if not Assigned(MySqlClientDataSet1) then
        MySqlClientDataSet1:=TClientDataSet.Create(self);
  if not Assigned(MSSQLClientDataSet1) then
        MSSQLClientDataSet1:=TClientDataSet.Create(self);

  connected:=False;
end;

destructor TMyDataSnap.Destroy;
begin
  FreeAndNil(SQLConnection1);
  FreeAndNil(DSProviderConnection1);
  FreeAndNil(MySqlClientDataSet1);
  FreeAndNil(MSSQLClientDataSet1);

  inherited;
end;

end.
