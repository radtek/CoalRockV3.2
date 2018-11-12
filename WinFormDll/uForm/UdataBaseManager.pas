unit UdataBaseManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ToolWin, Vcl.ComCtrls,UMainDataModule,PStope_GzmGuidClass,System.IniFiles, UMakeRuleClass;

type
  TBackUpDataBase = Class(TDataModule1)

     private
         FGzm:TGzm;
         TempDataSet:TMyDataSet;

      // DataToTxtFile
       function CoalNameMakeString(var Text:String;Pb:TProgressBar):Boolean;
       function WorkFaceMakeString(kstr:string;kid:integer):string;
       function DrillMakeString(kstr:string;kid:integer):String;
       function SupportMakeString:String;
       function UserInfoMakeString:String;
       function DataRuleMakeString:Boolean;
      //FileToDataBase
       procedure SplitCoalString(coalStr:String;Pb:TProgressBar);
       procedure SplitUserInfoString(UserStr:String);
       procedure SplitSupportString(SupStr:String);
       procedure SplitRuleTableString(RuleStr:string);
       function  SelectCoalid(CoalStr:string):integer;
         {批钻孔的字符串}
       function  SaveDrillIntoData(kid:integer;ZkStr:string;Pb:TProgressBar):integer;
         {批工作面的字符串}
       function  SaveWorkFaceIntoData(kid:integer;GzmStr:string;Pb:TProgressBar):integer;
         {批工作面绑定钻孔的字符串}
       function  SaveGzmAndZkIntoData(kid:integer;BDStr:string;Pb:TProgressBar):integer;
         {提取数据规则的类}
       function  FillMyRuleData(id:Integer;Rule:TMakeRuleClass):Boolean;
       function  SelectRuleTableMaxId:Integer;
       function  SaveIntoDataBase(Rule:TMakeRuleClass):Boolean;

     public
      inFileName:string;
      function MakeFirstDataToStr(FileName:string;PB:TProgressBar):Boolean;
      function CreatesaveFile(FileName:string):Boolean;
      function AppendTextIntoFile(StrText:Ansistring):Boolean;
      function SaveStringToText(FileName,Text:string):Boolean;
      function LinkDataBase(DataType:String):Boolean;

      function DataFromFileIntoBase(FileName:string;PB:TProgressBar):Boolean;

      constructor Create;
      destructor Destroy;override;
  End;


  TFormDataManager = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    StatusBar1: TStatusBar;
    Panel2: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    IPEdit: TEdit;
    UserEdit: TEdit;
    PassEdit: TEdit;
    ComboBox2: TComboBox;
    But_TestisExsitDataBase: TButton;
    But_CreatDataBase: TButton;
    ComboBox3: TComboBox;
    But_LinkNet: TButton;
    But_CreateTable: TButton;
    But_SaveDataType: TBitBtn;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    CB_FromData: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    CB_ToData: TComboBox;
    But_FromData: TButton;
    But_ToData: TButton;
    But_Start: TButton;
    DataBar: TProgressBar;
    But_FillTestData: TButton;
    procedure But_CreatDataBaseClick(Sender: TObject);
    procedure But_CreateTableClick(Sender: TObject);
    procedure But_LinkNetClick(Sender: TObject);
    procedure But_SaveDataTypeClick(Sender: TObject);
    procedure But_TestisExsitDataBaseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ComboBox2Change(Sender: TObject);
    procedure IPEditClick(Sender: TObject);
    procedure UserEditClick(Sender: TObject);
    procedure PassEditClick(Sender: TObject);
    procedure ComboBox3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CB_FromDataChange(Sender: TObject);
    procedure CB_ToDataChange(Sender: TObject);
    procedure But_StartClick(Sender: TObject);
    procedure But_FromDataClick(Sender: TObject);
    procedure But_ToDataClick(Sender: TObject);
    procedure But_FillTestDataClick(Sender: TObject);
  private
    { Private declarations }
    FromData:TBackUpDataBase;
    IntoData:TBackUpDataBase;
    FromDataType,ToDAtaType:string;
    procedure  ReadInfoFromFile; // 读取数据库配置文件
    procedure  SetButtonEnabled(Value:Boolean);
    procedure  SelectCombox2(DataType:String);
    procedure OptionTip(Str:String);
  public
    { Public declarations }
  end;

var
  FormDataManager: TFormDataManager;
function CreateDataBase_Manager(AHandle:THandle;ACaption:string;Wid,Hi,Config:integer):THandle;stdcall;
implementation

{$R *.dfm}

uses  Lu_Public_BasicModual, RockPressBasicClass,StrUtils;
//内部初始化工作面函数
function CreateDataBase_Manager(AHandle:THandle;ACaption:string;Wid,Hi,Config:integer):THandle;stdcall;
begin
        Result:=0;//函数值
        if Assigned(FormDataManager) then  FreeAndNil(FormDataManager);
        Application.Handle :=AHandle;
        FormDataManager:=TFormDataManager.Create(nil);
        try
             with FormDataManager do begin
               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;
               if Config=1 then pageControl1.ActivePage:=TabSheet1
                else    pageControl1.ActivePage:=TabSheet2;

               Show;
               SetFocus;
               Result:=FormDataManager.Handle;//函数值
          end ;
        except
            FreeAndNil(FormDataManager);
        end;
end;

procedure TFormDataManager.But_CreatDataBaseClick(Sender: TObject);
var
  WStr:WideString;
begin
   MainDataModule.SaveDataInotRecord(self.IPEdit.Text,
                                       self.UserEdit.Text,
                                       self.PassEdit.Text,
                                        '',
                                       self.ComboBox3.Text );

   wStr:='确定要创建新数据库么？原有数据库将会被删除！';
   if MessageBox(0, Pwidechar(wstr),'提示',MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDNO then exit;

   if MainDataModule.CreateDataBase(MainDataModule.DataType) then  begin
        wStr:='数据库创建成功！' ;
        But_CreatDataBase.Enabled :=false;
        if   MainDataModule.CreateTable('1',MainDataModule.DataType,'','') then   begin
             self.But_CreateTable.Enabled :=FALSE;
             But_SaveDataType.Enabled :=true;
             But_FillTestData.Enabled :=true;
        end;
   end else begin
        wStr:='数据库创建失败！' ;
   end;
   MessageBox(0, Pwidechar(wstr),'提示',MB_OK + MB_ICONQUESTION) ;

end;

procedure TFormDataManager.But_CreateTableClick(Sender: TObject);
var
  WStr:WideString;
begin
   MainDataModule.SaveDataInotRecord(self.IPEdit.Text,
                                       self.UserEdit.Text,
                                       self.PassEdit.Text,
                                        '',
                                       self.ComboBox3.Text );

   wStr:='确定要重新创建数据表么？原有数据表中数据将会被清空！';
   if MessageBox(0, Pwidechar(wstr),'提示',MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDNO then exit;

   if MainDataModule.CreateTable('1',MainDataModule.DataType,'','') then  begin
        wStr:='数据表创建成功！' ;
        But_CreateTable.Enabled :=false;
        But_SaveDataType.Enabled :=true;
        But_FillTestData.Enabled :=true;
   end else begin
        wStr:='数据表创建失败！' ;
   end;
   MessageBox(0, Pwidechar(wstr),'提示',MB_OK + MB_ICONQUESTION) ;

end;

procedure TFormDataManager.But_FillTestDataClick(Sender: TObject);
var
 FileName:string;

begin
    FileName:=Public_Basic.Get_MyModulePath +'TranferData.dat';
    if not FileExists(FileName) then begin
      self.OptionTip('数据存储文件丢失，请咨询技术团队！');;
      exit;
    end;
   if intoData.LinkDataBase(MainDataModule.DataType)   then begin
        DataBar.Max  :=30;
        DataBar.Position :=1;
        DataBar.Step:=1;
        if IntoData.DataFromFileIntoBase(FileName,DataBar) then begin
             DataBar.Position:=DataBar.Max ;
             OptionTip('数据转移成功！');
         end else begin
             OptionTip('数据转移失败，请仔细检查！');
         end;
   end;
end;

procedure TFormDataManager.But_FromDataClick(Sender: TObject);
begin
   if (But_FromData.Enabled)   and(But_ToData.Enabled) then
        But_Start.Enabled :=true   else  But_Start.Enabled :=False;
end;

procedure TFormDataManager.But_LinkNetClick(Sender: TObject);
var
   StrTem:string;
begin
  StrTem:=MainDataModule.DataType;
  MainDataModule.SaveDataInotRecord(self.IPEdit.Text,
                                       self.UserEdit.Text,
                                       self.PassEdit.Text,
                                       '',
                                       self.ComboBox3.Text );
    if MainDataModule.TestDataBaseParameter(StrTem)  then begin
       self.But_TestisExsitDataBase.Enabled :=true;
    end;
end;

procedure TFormDataManager.But_SaveDataTypeClick(Sender: TObject);
begin
    if UpperCase(MainDataModule.DataType)='ACCESS' then
        Public_Basic.WriteSnapData(False,'','211');


    Public_Basic.WriteDataBaseType(UpperCase(MainDataModule.DataType)) ;
    Public_Basic.WriteSnapData(false,'','');
end;

procedure TFormDataManager.But_StartClick(Sender: TObject);
begin
   DataBar.Max  :=30;
   DataBar.Position :=1;
   DataBar.Step:=1;
   if FromData.MakeFirstDataToStr('TranferData.dat',DataBar) then begin
       IntoData.DataFromFileIntoBase(FromData.inFileName ,self.DataBar);
       DataBar.Position:=DataBar.Max ;
       OptionTip('数据转移成功！');
   end else begin
       OptionTip('数据转移失败，请仔细检查！');
   end;
end;

procedure TFormDataManager.But_TestisExsitDataBaseClick(Sender: TObject);
var
  Snapip,port,SnapPort:string;
begin
   if UpperCase(MainDataModule.DataType)='MYSQL' then  begin
      Port:='3306' ;
   end else if UpperCase(MainDataModule.DataType)='SQLSERVER' then  begin
      Port:='1433' ;
   end else begin
      Port:='' ;
   end;

   MainDataModule.SaveDataInotRecord(self.IPEdit.Text,
                                       self.UserEdit.Text,
                                       self.PassEdit.Text,
                                       port,
                                       self.ComboBox3.Text );
   if  MainDataModule.SelectIsExsitDataBase(MainDataModule.DataType) then  begin
      Public_Basic.WriteMYSQLDataBase(MainDataModule.DataType,IPEdit.Text,
                                  UserEdit.Text,self.PassEdit.Text, port,ComboBox3.Text);

      OptionTip('数据库存在，可以进入程序');
      if not Public_Basic.ReadSnapData(Snapip,SnapPort) then begin
        But_CreateTable.Enabled:=true;
        But_FillTestData.Enabled :=true;
        But_CreatDataBase.Caption :='删除数据库重建！';
      end;
      But_SaveDataType.Enabled :=true;
   end;
      But_CreatDataBase.Enabled :=True;

end;

procedure TFormDataManager.But_ToDataClick(Sender: TObject);
begin
   if (But_FromData.Enabled)   and(But_ToData.Enabled) then
      But_Start.Enabled :=true  else  But_Start.Enabled :=False;
end;

procedure TFormDataManager.CB_FromDataChange(Sender: TObject);

begin
   FromDataType:='';
   if CB_FromData.ItemIndex=0 then begin
      FromDataType :='MySql';
   end else if CB_FromData.ItemIndex=1 then begin
      FromDataType:='SQLServer';
   end else begin
      FromDataType:='Access';
   end;

   if ToDataType=FromDataType then  begin
      exit;
   end;

   if FromData.LinkDataBase(FromDataType)   then
        But_FromData.Enabled :=true ;
  
end;

procedure TFormDataManager.CB_ToDataChange(Sender: TObject);
begin
   if CB_ToData.ItemIndex=0 then begin
      ToDataType :='MySql';
   end else if CB_ToData.ItemIndex=1 then begin
      ToDataType:='SQLServer';
   end else begin
      ToDataType:='Access';
   end;

   if ToDataType=FromDataType then  begin
      exit;
   end;

   if intoData.LinkDataBase(ToDataType)   then
      But_ToData.Enabled :=true ;

end;

procedure TFormDataManager.ComboBox2Change(Sender: TObject);
begin
    if ComboBox2.ItemIndex=0 then begin
      MainDataModule.DataType :='MySql';
   end else if ComboBox2.ItemIndex=1 then begin
      MainDataModule.DataType:='SQLServer';

   end else begin
      MainDataModule.DataType:='Access';

   end;
   ReadInfoFromFile;
   self.SetButtonEnabled(False);
end;

procedure TFormDataManager.ComboBox3Click(Sender: TObject);
begin
   ComboBox3.SetFocus ;
end;

procedure TFormDataManager.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if Assigned(FormDataManager) then  FreeAndNil(FormDataManager);

end;

procedure TFormDataManager.FormCreate(Sender: TObject);
begin
    if not Assigned(FromData) then
            FromData:=TBackUpDataBase.Create ;
    if not Assigned(IntoData) then
            IntoData:=TBackUpDataBase.Create;
end;

procedure TFormDataManager.FormDestroy(Sender: TObject);
begin
   if  Assigned(FromData) then  FreeAndNil(FromData);
   if  Assigned(IntoData) then  FreeAndNil(IntoData);
end;

procedure TFormDataManager.FormShow(Sender: TObject);
Var
  DataType:String;
begin
   Public_Basic.ReadDataBaseType(DataType) ;
   MainDataModule.DataType:=DataType;
   SelectCombox2(UpperCase(DataType));
   ReadInfoFromFile;
   PubLic_Basic.InitStatusBar (self.StatusBar1);
end;

procedure TFormDataManager.IPEditClick(Sender: TObject);
begin
  self.IPEdit.SetFocus ;
end;

procedure TFormDataManager.OptionTip(Str: String);
begin
   self.StatusBar1.Panels[0].Text :=str;
end;

procedure TFormDataManager.PassEditClick(Sender: TObject);
begin
   PassEdit.SetFocus;
end;

procedure TFormDataManager.ReadInfoFromFile;
var
  IP,UserName,Password,Port,DataBase:String;
begin

   Public_Basic.ReadMySqlDataBase(MainDataModule.DataType,Ip,UserName,
                   Password,Port,DataBase);

   self.IPEdit.Text :=Ip;
   self.UserEdit.Text :=UserName;
   self.PassEdit.Text:=Password;
   self.ComboBox3.Text:=DataBase;

   if (Ip='0') and (Uppercase(MainDataModule.DataType) <>'ACCESS') then  begin
       self.IPEdit.Text :='local';
       self.UserEdit.Text :='admin';
       self.PassEdit.Text:='admin';
       self.ComboBox3.Text:=DataBase;
   end  ;
   //放入数据集
   MainDataModule.SaveDataInotRecord(self.IPEdit.Text,
                                     self.UserEdit.Text,
                                     self.PassEdit.Text,
                                     port,
                                     self.ComboBox3.Text );
end;

procedure TFormDataManager.SelectCombox2(DataType: String);
begin
   if DataType='MYSQL' then  begin
      ComboBox2.ItemIndex :=0;
   end else if DataType='SQLSERVER' then  begin
      ComboBox2.ItemIndex :=1;
   end else begin
      ComboBox2.ItemIndex :=2;
   end;

end;

procedure TFormDataManager.SetButtonEnabled(Value: Boolean);
begin
     self.But_TestisExsitDataBase.Enabled :=Value;
     self.But_CreatDataBase.Enabled :=Value;
     self.But_CreateTable.Enabled :=Value;
     self.But_SaveDataType.Enabled :=value;
     But_FillTestData.Enabled :=value;
end;

procedure TFormDataManager.UserEditClick(Sender: TObject);
begin
   UserEdit.SetFocus;
end;

{ TBackUpDataBase }

function TBackUpDataBase.AppendTextIntoFile(StrText: AnsiString): Boolean;
var
  logFile:integer;
begin
   logFile:=FileOpen(inFilename,fmOpenwrite or fmShareDenyWrite);
   FileSeek(logfile,0,2);
   StrText:=StrText + #13 +#10 ;
   fileWrite(logFile,Pwidechar(StrText)^,length(StrText));
   fileclose(logfile);
end;

function TBackUpDataBase.CoalNameMakeString(var Text:String;Pb:TProgressBar):Boolean;
 var
   sql,StrText:string;
   Kid:integer;
begin
    // 查找煤矿及其相关信息

   Result:=true;
   try
     //填充用户信息
      PB.StepIt;
      AppendTextIntoFile(AnsiString(UserInfoMakeString));
      //填充支架信息
      PB.StepIt;
      AppendTextIntoFile(AnsiString(SupportMakeString));
      //填充抽取矿压数据规则 数据
      DataRuleMakeString;
      // 填充煤矿的基本信息
      sql:='select K.id as id, k.Meikuangming as KN, J.DwName as JN  from JituanName as J, '
            +' KuangJingXinxiBiao as K where  K.jituanid =J.id ';
      MyDataSet.Close ;
      MyDataSet.CommandText :=sql;
      StrText:='';
      if (MyDataSet.Open) and (MyDataSet.RecordCount >0 )  then
         while not MyDataSet.Eof do begin
            StrText:='K:'+MyDataSet.FieldByName('JN').AsString + ',';
            StrText:=StrText+MyDataSet.FieldByName('KN').AsString + ';';
            AppendTextIntoFile(AnsiString(StrText));
            Kid:=MyDataSet.FieldByName('id').AsInteger ;
             //调用钻孔信息数据
            DrillMakeString(StrText,kid);
            //调用工作面函数
            WorkFaceMakeString(StrText,kid);
            PB.StepIt;
            MyDataSet.Next ;
         end;

   except
      Result:=False;
   end;

end;

constructor TBackUpDataBase.Create;
begin
  CreateClass;
  if not Assigned(FGzm) then
     FGzm:=TGzm.Create(ExConn );
  if not Assigned(tempDataSet) then
     tempDataSet:=TMyDataSet.Create(nil);
     tempDataSet.MySqlConnection :=ExConn;
end;

function TBackUpDataBase.CreatesaveFile(FileName: string): Boolean;
var
  DirName:Ansistring;
  hFile:integer;
  Dll_Path:AnsiString;
begin
   Result:=true;
   try
       Dll_Path:=Public_Basic.Get_MyModulePath;
       DirName:=DLL_path+'Data\';
        if not DirectoryExists(DirName) then begin
           ForceDirectories(DirName);
        end;
       infileName:=DirName+fileName;
       if (FileExists(infileName)) then begin
          DeleteFile(infileName);
       end;
       hFile:=FileCreate(infileName,fmOutput);
       FileClose(hFile);
   except
      Result:=False;
   end;
end;

function TBackUpDataBase.DataFromFileIntoBase(FileName:string;PB: TProgressBar): Boolean;
var
   FileStr:tstringlist;
   i:integer;
   LineString:String;
begin
   Result:=False;
 try
   Filestr:=tstringlist.Create ;
   FileStr.LoadFromFile(FileName);
   for I := 0 to FileStr.Count-1 do   begin
      LineString:=FileStr[i];
      if Leftstr(LineString,1)='K' then begin
          PB.StepIt;
          SplitCoalString(LineString,PB);
      end else if Leftstr(LineString,1)='U' then begin
          PB.StepIt;
          SplitUserInfoString(LineString);
      end else if Leftstr(LineString,1)='S' then begin
          PB.StepIt;
          SplitSupportString(LineString);
      end else if Leftstr(LineString,1)='R' then begin
          PB.StepIt;
          SplitRuleTableString(LineString);
      end;
   end;
    Result:=true;
 finally
   FreeAndNil(Filestr);
 end;

end;

function TBackUpDataBase.DataRuleMakeString: Boolean;
var
  sql,text:string;
  id:integer;
  tmpRule:TMakeRuleClass;
begin
    Result:=False;
    sql:= 'select  * from InputRule  ' ;
    tempDataSet.CommandText :=sql;
    tmpRule:=TMakeRuleClass.Create(ExConn);
    try
    if (tempDataSet.Open) and (tempDataSet.RecordCount >0 )  then
      while not tempDataSet.Eof  do   begin
         tmpRule.ClearDataS;
         FillMyRuleData(tempDataSet.FieldByName('id').AsInteger,tmpRule);
         text:=tmpRule.MakeString ;
         if Trim(Text)<> '' then
            AppendTextIntoFile(AnsiString(text));
         tempDataSet.Next ;
       end;
    finally
      tempDataSet.Close ;
      FreeAndnil(tmpRule);
      Result:=true;
    end;

end;

destructor TBackUpDataBase.Destroy;
begin
  if  Assigned(FGzm) then   FreeAndNil(FGzm);
  if  Assigned(tempDataSet) then  FreeAndNil(tempDataSet);
  inherited;
end;

function TBackUpDataBase.DrillMakeString(kstr:string;kid: integer): String;
var
  sql:string;
  zkid:integer;
  tempzk:Tzk_bore;
begin
    sql:= 'select  zkid,zkname from zkb where  kid =' +IntToStr(kid) ;
    tempDataSet.CommandText :=sql;
    tempzk:=Tzk_bore.Create;
    try
    if (tempDataSet.Open) and (tempDataSet.RecordCount >0 )  then
       while not tempDataSet.Eof  do   begin
         zkid:=tempDataSet.FieldByName('zkid').AsInteger;
         tempzk.Zk_No := zkid;
         tempzk.Zk_name:=tempDataSet.FieldByName('zkname').AsString;
         FGzm.InputGzmYc(tempzk);
         AppendTextIntoFile(AnsiString(kstr+FGzm.GetDrillInfoToText(tempzk)));
         tempDataSet.Next ;
       end;
    finally
      tempDataSet.Close ;
      FreeAndNil(tempzk);
      Result:='';
    end;
end;

function TBackUpDataBase.FillMyRuleData(id: Integer;
  Rule: TMakeRuleClass): Boolean;
var
   Sql:string;
   tmp:TBasicDataParm;
begin
   {
        inputRule  RuleName,FileSufix,LineSplitStr,SupProFlag,SupUpper, ' +
          ' TimeProFlag,TimeUpper,TimeString )
        InputRule_DataType  Ruleid,DataType,DataBh,DataProFlag,DataUpper) values ( ';
   }

   try
       sql:='select * from  inputRule where id= ' +IntTostr(id);
        Rule.ClearDataS ;
        MyDataSet.Close ;
        MyDataSet.CommandText :=sql;
        if MyDataSet.Open  then  begin
           Rule.RuleId:=MyDataSet.FieldByName('id').AsInteger;
           Rule.RuleName :=MyDataSet.FieldByName('RuleName').AsString;
           Rule.FileSuffix :=MyDataSet.FieldByName('FileSufix').AsString;
           Rule.LineSplitTag :=MyDataSet.FieldByName('LineSplitStr').AsString;
           Rule.SupProRec.TagStr :=MyDataSet.FieldByName('SupProFlag').AsString;
           Rule.SupProRec.UpperCase :=MyDataSet.FieldByName('SupUpper').AsInteger;
           Rule.DTProRec.TagStr :=MyDataSet.FieldByName('TimeProFlag').AsString;
           Rule.DTProRec.UpperCase :=MyDataSet.FieldByName('TimeUpper').AsInteger;
           Rule.DataTimeStr :=MyDataSet.FieldByName('TimeString').AsString;
           if MyDataSet.FieldByName('MoveSupTag').AsInteger=1 then  begin
              Rule.MoveSuppFlag:=true;
              Rule.MoveProRec.UpperCase:=MyDataSet.FieldByName('MoveSuP_Upper').AsInteger;
              Rule.MoveSupp_Equal :=MyDataSet.FieldByName('MoveSup_Equal').AsString;
              Rule.MoveProRec.TagStr :=MyDataSet.FieldByName('MoveSup_ProFlag').AsString;
              Rule.MoveSupp_Value:=MyDataSet.FieldByName('MoveSup_Value').AsInteger;
           end else begin
              Rule.MoveSuppFlag:=False;
              Rule.MoveProRec.UpperCase:=0;
              Rule.MoveSupp_Equal :='';
              Rule.MoveProRec.TagStr :='';
              Rule.MoveSupp_Value:=0;
           end;
            Rule.MuleData_MAX_AGV:= MyDataSet.FieldByName('Mult_Max_AGV').AsInteger;
        end;
       MyDataSet.Close ;
       sql:='select * from  InputRule_DataType where Ruleid= ' +IntTostr(Rule.RuleId);
       MyDataSet.CommandText :=sql;
       if MyDataSet.Open  then
         while not MyDataSet.Eof  do  begin
           tmp.DataName :=MyDataSet.FieldByName('DataType').AsString;
           tmp.DataBh :=MyDataSet.FieldByName('DataBh').AsInteger ;
           tmp.DataType:=TSupportDataType(tmp.DataBh);
           tmp.TagStr :=MyDataSet.FieldByName('DataProFlag').AsString;
           tmp.UpperCase :=MyDataSet.FieldByName('DataUpper').AsInteger ;
           tmp.DataUnit:=MyDataSet.FieldByName('DataUnit').AsString;
           Rule.AddBasicDataS(tmp);
           MyDataSet.Next ;
         end;
   finally
     MyDataSet.Close ;
   end;

end;

function TBackUpDataBase.LinkDataBase(DataType:String): Boolean;
var
  IP,UserName,Password,Port,DataBase:String;
begin
   Result:=False;
   if DataType ='' then  exit;
   Public_Basic.ReadMySqlDataBase(DataType,Ip,UserName,
                   Password,Port,DataBase);
   if Ip='0' then exit;
   SaveDataInotRecord(Ip,UserName,Password, Port,DataBase);

   if TestDataBaseParameter(DataType)  then   begin
      if not SelectIsExsitDataBase(DataType) then  exit;
      if ConnectedData(DataType,DataBase) then
          Result:=true;
   end;

end;

function TBackUpDataBase.MakeFirstDataToStr(FileName:string;
         PB:TProgressBar): Boolean;
var
  textString:string;
begin
     Result:=False;
     textString:='';
     if  CreatesaveFile(FileName)  then
     if  CoalNameMakeString(textString,PB) then
         Result:=True;


end;

function TBackUpDataBase.SaveDrillIntoData(kid:integer;ZkStr: string;Pb:TProgressBar): integer;
var
   S1,S2:Str_DT_array;
   C1,C2,i,j:integer;
   zkid:integer;
   inn_D:Tzk_bore;
begin
   try
     inn_D:=Tzk_bore.Create;
     S1:=Public_Basic.split(ZkStr,'&',C1);
     if C1>2 then begin
       S2:=Public_Basic.split(S1[0],',',C2);
       if C2>2 then  begin
         inn_D.Mineid:=kid;
         inn_D.Zk_name:=S2[1];
         inn_D.Zk_Yc_Count :=Public_Basic.StrToInt_lu(S2[2]);
         Pb.StepIt ;
         setlength(inn_D.Yc_Rock,inn_D.Zk_Yc_Count) ;
         for I := 0 to inn_D.Zk_Yc_Count-1 do begin
            inn_D.Yc_Rock[i]:=TYc_Rock.Create ;
            S2:=Public_Basic.split(S1[i+1],',',C2);
            if C2>11 then  begin
              inn_D.Yc_Rock[i].Yc_No :=Public_Basic.StrToInt_lu(S2[0]);  //1
              inn_D.Yc_Rock[i].R_Name :=S2[1];  //2
              inn_D.Yc_Rock[i].R_MinH:=Public_Basic.StrToDouble_Lu(S2[2]);  //3
              inn_D.Yc_Rock[i].R_MaxH:=Public_Basic.StrToDouble_Lu(S2[3]);  //4
              inn_D.Yc_Rock[i].R_h:=Public_Basic.StrToDouble_Lu(S2[4]);  //5
              inn_D.Yc_Rock[i].R_kyqd:=Public_Basic.StrToDouble_Lu(S2[5]);  //6
              inn_D.Yc_Rock[i].R_klqd:=Public_Basic.StrToDouble_Lu(S2[6]);  //7
              inn_D.Yc_Rock[i].R_kjqd:=Public_Basic.StrToDouble_Lu(S2[7]);  //8
              inn_D.Yc_Rock[i].R_fchd:=Public_Basic.StrToDouble_Lu(S2[8]);  //9
              if Trim(S2[9])='1' then inn_D.Yc_Rock[i].R_sffc:=true          //10
                else inn_D.Yc_Rock[i].R_sffc:=False;
              inn_D.Yc_Rock[i].R_k_Rock:=Public_Basic.StrToDouble_Lu(S2[10]);  //11
              inn_D.Yc_Rock[i].R_r:=Public_Basic.StrToDouble_Lu(S2[11]);  //12
              if Trim(S2[12])='1' then begin
                 inn_D.Yc_Rock[i].M_Kc_YandN:=true;               //13
                 inn_D.Yc_Rock[i].MCId:=FGzm.SelecCoalSeamid(Trim(S2[13]),kid);  //14
              end else begin
                 inn_D.Yc_Rock[i].M_Kc_YandN:=False;              //13
                 inn_D.Yc_Rock[i].MCId  :=0; //14
              end;
              if Trim(S2[14])='1' then  inn_D.Yc_Rock[i].R_sfhsc:=true
              else inn_D.Yc_Rock[i].R_sfhsc:=false;

              inn_D.Yc_Rock[i].BMP_File :=S2[15];  //16
            end;

         end;

         if (FGzm.IsExistDrillInfo (inn_d.Zk_name ) = -1)  then  begin
             FGzm.InsertDrillFullDAta(inn_D) ;
         end else if (FGzm.IsExistDrillInfo(inn_d.Zk_name )>0)  then begin
             FGzm.UpdateDrillFullDAta(inn_D);
         end;
         Pb.StepIt ;
       end;
     end;
   finally
     for I := 0 to inn_D.Zk_Yc_Count-1 do
        if Assigned(inn_D.Yc_Rock[i]) then
            FreeAndNil(inn_D.Yc_Rock[i]);
     if Assigned(inn_D) then FreeAndNil(inn_D);
   end;

end;

function TBackUpDataBase.SaveGzmAndZkIntoData(kid:integer;
      BDStr: string;Pb:TProgressBar): integer;
var
   S1,S2:Str_DT_array;
   C1,C2,i:integer;
   Gzmid:integer;

begin
   try
       S1:=Public_Basic.split(BDStr,'&',C1);
      if C1>1 then
        FGzm.BuilledDrillNumber :=Public_Basic.StrToInt_lu(S1[0]);
        Setlength(FGzm.BuilledDrillType ,FGzm.BuilledDrillNumber);
      for i := 0 to FGzm.BuilledDrillNumber-1 do  begin
         S2:=Public_Basic.split(S1[i+1],',',C2);
         FGzm.BuilledDrillType[i]:=TWorkFaceBuillDrill.Create;
        // if (Trim(S2[0])='') and (C2<3)  then  continue;
         FGzm.BuilledDrillType[i].Gzmid :=FGzm.IsExistWorkFace(kid,s2[0]);
         FGzm.BuilledDrillType[i].zkid :=FGzm.IsExistDrillInfo(S2[1]) ;
         FGzm.BuilledDrillType[i].startdistance :=Public_Basic.StrToDouble_Lu(S2[2]);
         FGzm.BuilledDrillType[i].enddistance :=Public_Basic.StrToDouble_Lu(S2[3]);
      end;
        FGzm.InsertWorkfaceSelectDrillDataBase;
   finally

   end;


end;

function TBackUpDataBase.SaveIntoDataBase(Rule: TMakeRuleClass): Boolean;
var
 Move_Tag,Ruleid,i:integer;
 Sql,Sql2:string;
begin
  Result:=False;
  if Rule.Basic_DataNumber <1 then        exit;

  if Rule.MoveSuppFlag then  Move_Tag:=1
  else Move_Tag:=0;

  try
         sql:='insert into inputRule (RuleName,FileSufix,LineSplitStr,SupProFlag,SupUpper, ' +
              ' TimeProFlag,TimeUpper,TimeString,MoveSupTag,MoveSup_ProFlag,MoveSup_Upper, ' +
              ' Movesup_Equal,Movesup_Value,Mult_Max_AGV )  Values ( ' +
              '''' + Rule.RuleName + ''',''' +  Rule.FileSuffix + ''',' +
              '''' + Rule.LineSplitTag +''',''' + Rule.SupProRec.TagStr + ''',' +
              IntToStr(Rule.SupProRec.UpperCase) +',''' + Rule.DTProRec.TagStr + ''',' +
              IntTostr(Rule.DTProRec.UpperCase ) +',''' + Rule.DataTimeStr + ''',' +
              IntTostr(Move_Tag ) +',''' + Rule.MoveProRec.TagStr + ''',' +
              IntTostr(Rule.MoveProRec.UpperCase ) +',''' + Rule.MoveSupp_Equal + ''',' +
              IntTostr(Rule.MoveSupp_Value ) + ',' + IntTostr(Rule.MuleData_MAX_AGV  ) +
              ') ';

           MyCommand.CommandText :=sql;
           MyCommand.Execute ;
           Ruleid:=SelectRuleTableMaxId ;
           if Ruleid >0 then  begin
             Sql2:='insert into InputRule_DataType (Ruleid,DataType,DataBh,DataProFlag,DataUpper,DataUnit) values ( ';
              for I := 0 to Rule.Basic_DataNumber -1  do  begin
                  sql:=Sql2 +IntTostr(Ruleid) + ',''' + Rule.BasicDataS[i].DataName +''',' +
                       IntTostr(Rule.BasicDataS[i].DataBh) + ','''  +Rule.BasicDataS[i].TagStr + ''',' +
                       IntTostr(Rule.BasicDataS[i].UpperCase ) +','''+Rule.BasicDataS[i].DataUnit + '''' +
                        ')';
                   MyCommand.CommandText :=sql;
                   MyCommand.Execute ;
              end;
           end;

    finally
       Result:=True;
    end;

end;

function TBackUpDataBase.SaveStringToText(FileName, Text: string): Boolean;
var
  textString:Ansistring;
  DirName:Ansistring;
  File_dat: TFileStream;
  Dll_Path:AnsiString;
begin
  Result:=true;
  try
       Dll_Path:=Public_Basic.Get_MyModulePath;
       DirName:=DLL_path+'Data\';
        if not DirectoryExists(DirName) then begin
           ForceDirectories(DirName);
        end;
       FileName:= DirName+FileName;
       File_dat:=TFileStream.Create(FileName,fmCreate);

       textString:=Text + #13 +#10 ;
       File_dat.Write(Pointer(textString)^,Length(textString));
       File_dat.Free ;
  except

     Result:=False;
  end;
end;


function TBackUpDataBase.SaveWorkFaceIntoData(kid:integer;
      GZMStr: string;Pb:TProgressBar): integer;
var
   S1:Str_DT_array;
   C1:integer;
   Gzmid:integer;

begin
   try
     S1:=Public_Basic.split(GZMStr,',',C1);
     if C1>=30 then begin
        Pb.StepIt ;
        FGzm.KuangJingId :=kid;
        FGzm.S_Name :=Trim(S1[1]); //2
        FGzm.S_mc_name :=IntToStr(FGzm.SelecCoalSeamid(Trim(S1[2]),kid)); //3
        FGzm.S_Cg_h :=Public_Basic.StrToDouble_Lu(S1[3]); //4
        FGzm.S_CMFS_INteger :=Public_Basic.StrToInt_lu(S1[4]); //5
        FGzm.S_DayStep_speed  :=Public_Basic.StrToDouble_Lu(S1[5]); //6
        FGzm.S_qj :=Public_Basic.StrToDouble_Lu(S1[6]); //7
        FGzm.S_SX_qj :=Public_Basic.StrToDouble_Lu(S1[7]); //8
        FGzm.S_Sh_UP :=Public_Basic.StrToDouble_Lu(S1[8]); //9
        FGzm.S_Sh_Down :=Public_Basic.StrToDouble_Lu(S1[9]); //10
        FGzm.S_mcsd_h :=Public_Basic.StrToDouble_Lu(S1[10]); //11
        FGzm.S_L_qx  :=Public_Basic.StrToDouble_Lu(S1[11]); //12
        FGzm.S_Sx_zx :=Public_Basic.StrToDouble_Lu(S1[12]); //13
        FGzm.S_f_PS :=Public_Basic.StrToDouble_Lu(S1[13]); //14

         FGzm.Dz_yxfx  :=Public_Basic.StrToInt_lu(S1[14]); //15
         FGzm.Dz_JYHD :=Public_Basic.StrToInt_lu(S1[15]); //16
         FGzm.Dz_DCGZ :=Public_Basic.StrToInt_lu(S1[16]); //17
         FGzm.Dz_WSFC :=Public_Basic.StrToInt_lu(S1[17]); //18
         FGzm.Dz_TopWater :=Public_Basic.StrToInt_lu(S1[18]); //19
         FGzm.Dz_BottomWater :=Public_Basic.StrToInt_lu(S1[19]); //20
         FGzm.Dz_HeoStress :=Public_Basic.StrToInt_lu(S1[20]); //21
         FGzm.Dz_Kyxx :=Public_Basic.StrToInt_lu(S1[21]); //22
         FGzm.Dz_HangDaoSup :=Public_Basic.StrToInt_lu(S1[22]); //23
          //24  -27 不分解
         FGzm.S_Jc_L :=Public_Basic.StrToDouble_Lu(S1[27]); //28
         FGzm.SupStartNumber :=Public_Basic.StrToInt_lu(S1[28]); //29
         FGzm.SupEndUsedNumber :=Public_Basic.StrToInt_lu(S1[29]); //30
         FGzm.SupNumberDirection :=Public_Basic.StrToInt_lu(S1[30]); //31
         FGzm.ZjName:=S1[31];   //32
         FGzm.S_Agv_mch :=Public_Basic.StrToDouble_Lu(S1[32]); //33

         Gzmid:= FGzm.IsExistWorkFace(kid,FGzm.S_Name );
         if (Gzmid = -1)then  begin
             FGzm.InsertWorkFaceFullData(Gzmid);
         end else if (Gzmid >0 ) then begin
             FGzm.UpdateWorkFaceFullData(Gzmid);
         end;
     end;

   finally

   end;

end;

function TBackUpDataBase.SelectCoalid(CoalStr: string): integer;
var
   S1,S2:Str_DT_array;
   C1,C2,i,j:integer;
   jituanid,kid:integer;
begin
   kid:=0;
   S1:=Public_Basic.split(coalStr,',',C1);
   if C1>1 then begin
      jituanid:=FGzm.SelJituanBianhao(S1[0]);
      kid:=FGzm.SelKuangjingBianHao(s1[1],s1[0],jituanid);
   end;
   Result:=Kid;
end;

function TBackUpDataBase.SelectRuleTableMaxId: Integer;
var
  sql:string;

begin
   Result:=-1;
   try
    sql:='select MAX(id) as MD from  inputRule ';
    MyDataSet.Close ;
    MyDataSet.CommandText :=sql;
    if MyDataSet.Open  then
       Result:=MyDataSet.FieldByName('MD').AsInteger ;
   finally
     MyDataSet.Close ;
   end;

end;

procedure TBackUpDataBase.SplitCoalString(coalStr: String;Pb:TProgressBar);
var
   S1,S2:Str_DT_array;
   C1,C2,i,j:integer;
   Kid,zkid,gzmid:Integer;
begin
   S1:=Public_Basic.split(coalStr,';',C1);
   Kid:=0;
   if C1>1 then  begin
        // split kid
        S2:= Public_Basic.split(S1[0],':',C2);
        Pb.StepIt ;
        if Trim(S2[0])='K' then
          Kid:=SelectCoalid(S2[1]);
        // split 其他
        S2:= Public_Basic.split(S1[1],':',C2);
       if C2>1 then
          if Trim(S2[0])='ZK' then begin
             Pb.StepIt ;
             zkid:=SaveDrillIntoData(Kid,S2[1],Pb);
          end else if Trim(S2[0])='GZM' then begin
             Pb.StepIt ;
             gzmid:=SaveWorkFaceIntoData(Kid,S2[1],Pb);
          end else if Trim(S2[0])='WZ' then begin
              Pb.StepIt ;
              SaveGzmAndZkIntoData(Kid,S2[1],Pb);
          end;
   end;

end;



procedure TBackUpDataBase.SplitRuleTableString(RuleStr: string);
var

  tmpRule:TMakeRuleClass;
begin

    tmpRule:=TMakeRuleClass.Create(ExConn);
   try
      tmpRule.ClearDataS ;
      if tmpRule.FillSelfClassFromSring(RuleStr) then
         SaveIntoDataBase(tmpRule);
   finally
     FreeAndnil(tmpRule);
   end;

end;

procedure TBackUpDataBase.SplitSupportString(SupStr: String);
var
   S1,S2:Str_DT_array;
   C1,C2,i:integer;
   Supid,SupCount:Integer;
   inn_S:TSupportStep;

begin
  try
       S1:=Public_Basic.split(SupStr,';',C1);
       SupCount:=0;
       inn_S:=TSupportStep.Create;
       if C1>1 then   SupCount:=Public_Basic.StrToInt_lu(RightStr(s1[0],length(S1[0])-2)) ;
       for I := 0 to SupCount-1 do begin
          S2:=Public_Basic.split(S1[i+1],',',C2);
          if C2<12 then continue;
          inn_s.Zj_leixing:=S2[0];         //类型        1
          inn_s.Zj_Name :=S2[1];           //型号      2
          inn_s.Zj_zhongxinju :=Public_Basic.StrToDouble_Lu(S2[2]);  //  支架中心距   3
          inn_s.Zj_KongdingJU :=Public_Basic.StrToDouble_Lu(S2[3]);  //  控顶距    4
          inn_s.Zj_hlzyd :=Public_Basic.StrToDouble_Lu(S2[4]);  //  合力作用点    5
          inn_s.Zj_Lizhu_count :=Public_Basic.StrToint_Lu(S2[5]);  //  立柱数量        6
          inn_s.Zj_suoliang :=Public_Basic.StrToDouble_Lu(S2[6]);   //  立柱压缩量   7
          inn_s.Zj_toall_F :=Public_Basic.StrToDouble_Lu(S2[7]);   //  阻抗力      8
          inn_s.zj_toall_P :=Public_Basic.StrToDouble_Lu(S2[8]);  //  支护强度     9
          inn_s.Zj_hubang_h :=Public_Basic.StrToDouble_Lu(S2[9]);  // 互帮高度     10
          inn_s.zj_hubang_P :=Public_Basic.StrToDouble_Lu(S2[10]); //  互帮强度    11
          inn_s.Lz_Diameter :=Public_Basic.StrToDouble_Lu(S2[11]); //  立柱直径    12
          inn_s.initLoad :=Public_Basic.StrToDouble_Lu(S2[12]); //  初撑力    13
          inn_s.EndOpenLoad :=Public_Basic.StrToDouble_Lu(S2[13]); //  液压阀开启    14


           if (FGzm.isExistSupportName(inn_S.Zj_Name ) = -1) then  begin
               FGzm.InsertSupportToDataBase(inn_S);
           end else if (FGzm.isExistSupportName(inn_S.Zj_Name )>0 )then begin
               FGzm.UpdateSupportToDataBase(inn_S);
           end;
       end;

  finally
     if Assigned(inn_s) then  FreeAndNil(inn_S);

  end;

end;

procedure TBackUpDataBase.SplitUserInfoString(UserStr: String);
var
   S1,S2:Str_DT_array;
   C1,C2,i:integer;
   Userid,SupCount:Integer;
   UN,UP,UD,UT:string;
begin
  try
       S1:=Public_Basic.split(UserStr,';',C1);
       SupCount:=0;
      if C1>1 then   SupCount:=Public_Basic.StrToInt_lu(RightStr(s1[0],length(S1[0])-2)) ;
       for I := 0 to SupCount-1 do begin
          S2:=Public_Basic.split(S1[i+1],',',C2);
          if C2<4  then  continue;
            UN:=S2[0];
            UP:=S2[1];
            UD:=S2[2];
            UT:=S2[3];
            Userid:=Fgzm.isExsitUserName(UN);
            if Userid <1 then  begin
               FGzm.insertUserIntoDataBase(UN,UP,UD,UT) ;
            end else begin
               FGZm.UpdateUserInfoDataBase(Userid,UP,UD,UT);
            end;

       end;
  finally

  end;
   {

    try
    if (tempDataSet.Open) and (tempDataSet.RecordCount >0 )  then
       text:=text+IntToStr(tempDataSet.RecordCount )+';' ;
      while not tempDataSet.Eof  do   begin
         text:=text+tempDataSet.FieldByName('UserName').AsString+',';
         text:=text+tempDataSet.FieldByName('User_Password').AsString+',';
         text:=text+tempDataSet.FieldByName('used').AsString+',';
         text:=text+tempDataSet.FieldByName('User_Type').AsString+';';
         tempDataSet.Next ;
       end;
    finally
      tempDataSet.Close ;
      Result:=text;


   }



end;

function TBackUpDataBase.SupportMakeString: String;
var
  insup:TWorkFaceBuillSupport;
  sql,text,temp:string;
  Supid:integer;

begin
    sql:='select  id from zjxhb  ';
    tempDataSet.CommandText :=sql;
    insup:=TWorkFaceBuillSupport.Create;
    text:='S:';
    try
    if (tempDataSet.Open) and (tempDataSet.RecordCount >0 )  then
       text:=text+IntTostr(tempDataSet.RecordCount)+';';
       while not tempDataSet.Eof  do   begin
         Supid:=tempDataSet.FieldByName('id').AsInteger;
         insup.Supportid:=Supid;
         FGzm.InputGzmSupport(insup);
         text:=text+Fgzm.GetSupportInfoToText(insup)+';';
         tempDataSet.Next ;
       end;
    finally
      tempDataSet.Close ;
      FreeAndNil(insup);
      Result:=text;
    end;

end;

function TBackUpDataBase.UserInfoMakeString: String;
var
  sql,text:string;
  id:integer;
begin
    sql:= 'select  * from UserInfo  ' ;
    tempDataSet.CommandText :=sql;
    text:='U:';
    try
    if (tempDataSet.Open) and (tempDataSet.RecordCount >0 )  then
       text:=text+IntToStr(tempDataSet.RecordCount )+';' ;
      while not tempDataSet.Eof  do   begin
         text:=text+tempDataSet.FieldByName('UserName').AsString+',';
         text:=text+tempDataSet.FieldByName('User_Password').AsString+',';
         text:=text+tempDataSet.FieldByName('used').AsString+',';
         text:=text+tempDataSet.FieldByName('User_Type').AsString+';';
         tempDataSet.Next ;
       end;
    finally
      tempDataSet.Close ;
      Result:=text;
    end;
end;

function TBackUpDataBase.WorkFaceMakeString(kstr:string;kid: integer): string;
var
  sql,text:string;
  cqid:integer;
begin
    sql:= 'select  cqid from cqcsb where  kid =' +IntToStr(kid) ;
    tempDataSet.CommandText :=sql;
    text:='';
    try
    if (tempDataSet.Open) and (tempDataSet.RecordCount >0 )  then
       while not tempDataSet.Eof  do   begin
         cqid:=tempDataSet.FieldByName('cqid').AsInteger;
         FGzm.InputGzmData(cqid);
         AppendTextIntoFile(AnsiString(kstr+FGzm.GetWorkFaceToText));
         AppendTextIntoFile(AnsiString(kstr+FGzm.GetWorkFaceBuildZkToText(cqid)));
         tempDataSet.Next ;
       end;
    finally
      tempDataSet.Close ;
      Result:=text;
    end;
end;

end.
