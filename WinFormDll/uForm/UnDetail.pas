unit UnDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, ComCtrls, ToolWin, ExtCtrls, OleCtrls,StrUtils,
  Grids, DBGrids,SQLiteTable3,SQLite3,DB,jpeg,  System.ImageList,
  UMainDataModule, Vcl.AppEvnts;

type
  TZkDetailForm = class(TForm)
    Splitter1: TSplitter;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    AddButton: TToolButton;
    EditButton: TToolButton;
    SaveButton: TToolButton;
    DeleteButton: TToolButton;
    ExitButton: TToolButton;
    ImageList1: TImageList;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    ComboKName: TComboBox;
    Label3: TLabel;
    EditYcXh: TEdit;
    Label2: TLabel;
    EditStandardName: TEdit;
    ComboStandarName: TComboBox;
    Label7: TLabel;
    Image1: TImage;
    ButtonWjfl: TButton;
    Label8: TLabel;
    Label4: TLabel;
    EditYockAvGH: TEdit;
    Label5: TLabel;
    EditFchd: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    EditYockMinH: TEdit;
    Label13: TLabel;
    EditYockMaxH: TEdit;
    Label14: TLabel;
    ComboZkName: TComboBox;
    Label15: TLabel;
    EditYockR: TEdit;
    Label16: TLabel;
    EditYockK: TEdit;
    Label17: TLabel;
    EditYockKy: TEdit;
    Label18: TLabel;
    EditYockKL: TEdit;
    Label19: TLabel;
    EditYockKJ: TEdit;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    FcRadioButton: TRadioGroup;
    HsRadioButton: TRadioGroup;
    StringGrid1: TStringGrid;
    CheckBox1: TCheckBox;
    YcBh_Zry: TEdit;
    Label6: TLabel;
    EditJianSuo: TEdit;
    Label25: TLabel;
    ComboBox_Mc: TComboBox;
    But_InPutMc: TButton;
    Label26: TLabel;
    JiTuanCombo: TComboBox;
    Shape1: TShape;
    Shape2: TShape;
    StatusBar1: TStatusBar;
    ToolButton1: TToolButton;
    ApplicationEvents1: TApplicationEvents;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure ComboKNameChange(Sender: TObject);
    procedure ComboGzmChange(Sender: TObject);
    procedure ComboZkNameChange(Sender: TObject);
    procedure EditYockMinHKeyPress(Sender: TObject; var Key: Char);
    procedure EditYockMaxHKeyPress(Sender: TObject; var Key: Char);
    procedure EditYockAvGHKeyPress(Sender: TObject; var Key: Char);
    procedure EditFchdKeyPress(Sender: TObject; var Key: Char);
    procedure EditYockRKeyPress(Sender: TObject; var Key: Char);
    procedure EditYockKKeyPress(Sender: TObject; var Key: Char);
    procedure EditYockKyKeyPress(Sender: TObject; var Key: Char);
    procedure EditYockKLKeyPress(Sender: TObject; var Key: Char);
    procedure EditYockKJKeyPress(Sender: TObject; var Key: Char);
    procedure FcRadioButtonClick(Sender: TObject);
    procedure ComboStandarNameChange(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ButtonWjflClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure YcBh_ZryKeyPress(Sender: TObject; var Key: Char);
    procedure YcBh_ZryMouseLeave(Sender: TObject);
    procedure YcBh_ZryExit(Sender: TObject);
    procedure EditYockAvGHMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditYockMinHMouseLeave(Sender: TObject);
    procedure EditYockMaxHMouseLeave(Sender: TObject);
    procedure EditJianSuoKeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditMcidKeyPress(Sender: TObject; var Key: Char);
    procedure But_InPutMcClick(Sender: TObject);
    procedure EditYcXhClick(Sender: TObject);
    procedure EditJianSuoClick(Sender: TObject);
    procedure YcBh_ZryClick(Sender: TObject);
    procedure EditStandardNameClick(Sender: TObject);
    procedure EditYockMinHClick(Sender: TObject);
    procedure EditYockMaxHClick(Sender: TObject);
    procedure EditYockAvGHClick(Sender: TObject);
    procedure EditFchdClick(Sender: TObject);
    procedure EditYockRClick(Sender: TObject);
    procedure EditYockKClick(Sender: TObject);
    procedure EditYockKyClick(Sender: TObject);
    procedure EditYockKLClick(Sender: TObject);
    procedure EditYockKJClick(Sender: TObject);
    procedure JiTuanComboChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);


  private
    { Private declarations }
    TuFileName:String;
    KARow:integer;
    MySqlDataSet1:TMyDataSet;
    MySqlDataSet2:TMyDataSet;
    MyCommand1:TMyCommand;
    Click_YesOrNO_WJfl:Boolean;
    Select_Cx:Boolean;
    procedure SetCellHead; //设置Cell表头
    procedure FillCell(id :integer;zxOrnx:Boolean); //填充表格
    procedure ClearEdit;   //清空编辑框
    function checkInputEdit:wordbool; //检查录入格式是否合格
    procedure SetEnable(ISCanEnable:bool);
    procedure OptionTip(Str: String);
    procedure SelectYockBmp(YCid:Integer);
    procedure InitYockBasic;
  public
    { Public declarations }
    Save_Lx:string; //
    Mc_id:String; //Mc_id
    i_Kid,i_Jituan:Integer;   //矿ID，采区 ID
    i_Zid,SelectYCid:integer; // 选中的NO
    Y_count:integer;//标准岩层总数，
    InputYock:array [0..17] of string;  //存放临时数据
    YanCenNo:integer;//具体岩层的层数
    StandarNameLeiBie:string;

    procedure Fill_McBH_Combo;
    
    procedure Edit_Text(s_Memo:TMemo;sql,str1,str2,str3:AnsiString);   //2016.5.27  五级分类用到
    procedure Edit_Kyjs(EditKyqd:TEdit;EditKlqd:TEdit;EditKjqd:TEdit;sql,str1:AnsiString;str2,str3,str4,str5:integer); //2016.5.27 五级分类用到

  end;
  //记录RockBasic
  type
    TYockBasic= class
       private
        Comboid:integer; //combo选择记录
        Name:String;     //     汉字名称
        TuFileName:string;       //   图例
        id:integer;      //    记录号
        szxs:double;      //  碎涨系数
        rz:double;       //   容重
        leibie:integer;//     类别
        kyqd:double;    //    抗压
        klqd:double;  //      抗拉
        kjqd:double;//        抗剪
        ZhuJian:integer;//     主键值 13-3-26-zry 增加
    end;

function CreateDrillDetail_inn(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;
          stdcall;

var
   ZkDetail_inn: TZkDetailForm;
   YockBasic:array of TYockBasic;


implementation


uses UnEditGzk,
     UnTxMc,
     UnWjfl_Zry, uWinFrameClass,  Lu_Public_BasicModual, HanzhiExtractPy;

{$R *.dfm}

 //内部初始化钻孔 函数
function CreateDrillDetail_inn (AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;
      stdcall;
begin
        if Assigned(ZkDetail_inn) then  FreeAndNil(ZkDetail_inn);
        APPlication.Handle :=AHandle;
        ZkDetail_inn:=TZkDetailForm.Create(nil);
        try
          with ZkDetail_inn do begin
               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

                Show;
                SetFocus;
                Result:=ZkDetail_inn.Handle ;  //函数值
          end ;
        except
         FreeAndNil(ZkDetail_inn);
        end;
end;



procedure TZkDetailForm.SetEnable(ISCanEnable: LongBool);
begin
  if ISCanEnable=false then begin
//    ComboKName.Enabled:=false;
//    ComboZkName.Enabled:=false;
    EditYcXh.Enabled:=false;
    ComboStandarName.enabled:=false;
    EditJianSuo.Enabled:=false;
    YcBh_Zry.Enabled:=false;
    CheckBox1.Enabled:=false;
    ButtonWjfl.Enabled:=false;
    EditStandardName.Enabled:=false;
    EditYockMinH.Enabled:=false;
    EditYockMaxH.Enabled:=false;
    EditYockAvGH.Enabled:=false;
    FcRadioButton.Enabled:=false;
    EditFchd.Enabled:=false;
    HsRadioButton.Enabled:=false;
    ComboBox_Mc.Enabled:=false;
    EditYockR.Enabled:=false;
    EditYockK.Enabled:=false;
    EditYockKy.Enabled:=false;
    EditYockKL.Enabled:=false;
    EditYockKJ.Enabled:=false;
  end else begin
//    ComboKName.Enabled:=true;
//    ComboZkName.Enabled:=true;
//    EditYcXh.Enabled:=true;
    ComboStandarName.enabled:=true;
    EditJianSuo.Enabled:=true;
//    YcBh_Zry.Enabled:=true;
    CheckBox1.Enabled:=true;
    ButtonWjfl.Enabled:=true;
//    EditStandardName.Enabled:=true;
    EditYockMinH.Enabled:=true;
    EditYockMaxH.Enabled:=true;
    EditYockAvGH.Enabled:=true;
    FcRadioButton.Enabled:=true;
    if FcRadioButton.ItemIndex=0 then begin
      self.EditFchd.Enabled:=false;
    end else begin
      self.EditFchd.Enabled:=true;
    end;
    HsRadioButton.Enabled:=true;
    ComboBox_Mc.Enabled:=true;
    EditYockR.Enabled:=true;
    EditYockK.Enabled:=true;
    EditYockKy.Enabled:=true;
    EditYockKL.Enabled:=true;
    EditYockKJ.Enabled:=true;
    
    ComboKName.SetFocus;
  end;
end;

procedure  TZkDetailForm.ClearEdit;
var
 i:integer;
begin
//  self.EditYcXh.Text:=''; //      岩层序号
  self.EditStandardName.Text :='';//   标准岩层名称
  self.EditYockMinH.text:='';//       最小岩层厚度
  self.EditYockMaxH.Text :='';//      最大岩层厚度
  self.EditYockAvGH.text:='';//      岩层平均厚度

  self.EditFchd.Text :='';//     分层厚度
  self.EditYockR.Text :='';//      容重
  self.EditYockKy.Text:='';//      抗压强度
  self.EditYockK.Text :='';//      碎涨系数
  self.EditYockKL.Text:='';//       抗拉强度
  self.EditYockKJ.Text :='';//     抗剪强度
//  self.ComboBox1.Text:='';//        煤层编号

  FcRadioButton.Enabled:=true;
  HsRadioButton.Enabled:=true;
  self.FcRadioButton.ItemIndex :=0;//    是否分层
  self.HsRadioButton.ItemIndex :=0;   //       是否含水 不含
  self.ComboStandarName.ItemIndex:=-1;//
  self.YcBh_Zry.Text:='';//
  ComboBox_Mc.ItemIndex:=0;

  EditJianSuo.Text:='';
  CheckBox1.Checked:=false;
  Image1.Picture:=nil;
  TuFileName:=''; //图例文件清空
  Mc_id:='';
  SelectYCid:=-1;
  //录入变量情况
  for I := 0 to 16 do
     InputYock[i]:='';
         
  // 控制分层的录入
   self.EditFchd.Enabled :=false;
end;
//五级分类定参数 -zry

procedure TZkDetailForm.But_InPutMcClick(Sender: TObject);
var
   SDisp:String;
begin
    MainDataModule.UseFormName :='ZkDetail';
    SDisp:='【'+ComboKName.Text+'】钻孔增添新的煤层';
    CreateFormMC(Handle,SDisp,ComboKName.Text,i_Kid);
end;

procedure TZkDetailForm.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
begin
     if (StringGrid1.Focused) And (Msg.message=WM_MOUSEWHEEL) then
      begin
            if Msg.wParam>0 then
            SendMessage(StringGrid1.Handle,  WM_KEYDOWN,  VK_UP,  0)
      else
            SendMessage(StringGrid1.Handle,  WM_KEYDOWN,  VK_DOWN,  0);
            Handled  :=  True;
      end;
end;

procedure TZkDetailForm.ButtonWjflClick(Sender: TObject);
begin
  if self.ComboStandarName.ItemIndex =-1  then
  begin
    messagebox(self.Handle,'请选择“标准名称”','系统提示',mb_iconerror+mb_ok);
    exit;
  end;
   // 调用岩层五级分类界面
   CreateRock_WjFL(Handle ,'岩层主要力学参数五级分类');

end;

procedure TZkDetailForm.CheckBox1Click(Sender: TObject);
begin
  if self.CheckBox1.Checked then
  begin
    YcBh_Zry.Enabled:=true;
    YcBh_Zry.SetFocus;
  end else begin
    YcBh_Zry.Enabled:=false;
  end;
end;

function TZkDetailForm.checkInputEdit :wordbool;
var
  s_temp:Str_DT_array;
  C1:integer;
begin
  Result:=false;
  
  if ComboZkName.ItemIndex=-1 then
  begin
     messagebox(self.Handle,'请选择钻孔名称！ ','系统提示',mb_iconerror+mb_ok);
     exit;
  end;

  if ComboStandarName.ItemIndex=-1 then
  begin
     messagebox(self.Handle,'请选择标准名称！ ','系统提示',mb_iconerror+mb_ok);
     exit;
  end;
  
    if ComboBox_Mc.Text='' then
    begin
       messagebox(self.Handle,'请选择煤层！ ','系统提示',mb_iconerror+mb_ok);
       exit;
    end else begin
       s_temp:=Public_Basic.split(ComboBox_Mc.Text,'_',C1);
       if C1>1 then   Mc_id:=s_temp[0] ;
    end;
  if self.CheckBox1.Checked then
  begin
    if YcBh_Zry.Text='' then
    begin
       messagebox(self.Handle,'请输入指定岩层编号！ ','系统提示',mb_iconerror+mb_ok);
       exit;
    end;
  end;
  if trim(EditYockMinH.Text)='' then
  begin
     messagebox(self.Handle,'请输入岩层最小厚度！ ','系统提示',mb_iconerror+mb_ok);
     exit;
  end;
  if trim(EditYockMaxH.Text)='' then
  begin
    messagebox(self.Handle,'请输入岩层最大厚度！','系统提示',mb_iconerror+mb_ok);
    exit;
  end;
  if trim(EditYockMinH.Text)='' then
  begin
    EditYockMinH.Text:='0';
  end;
  if trim(EditYockMaxH.Text)='' then
  begin
    EditYockMaxH.Text:='0';
  end;
  if trim(EditYockAvGH.Text)='' then
  begin
     messagebox(self.Handle,'请输入岩层均厚！','系统提示',mb_iconerror+mb_ok);
     exit;
  end;
  if FcRadioButton.ItemIndex=1 then
  begin
    if trim(EditFchd.Text)='' then
    begin
       messagebox(self.Handle,'请输入分层米数！','系统提示',mb_iconerror+mb_ok);
       exit;
    end;
  end;

  if trim(EditYockR.Text)='' then
  begin
    messagebox(self.Handle,'请输入岩层容重！','系统提示',mb_iconerror+mb_ok);
    exit;
  end;
  if trim(EditYockK.Text)='' then
  begin
     messagebox(self.Handle,'请输入岩石碎涨！','系统提示',mb_iconerror+mb_ok);
     exit;
  end;
  if trim(EditYockKy.Text)='' then
  begin
     messagebox(self.Handle,'请输入岩石抗压强度！','系统提示',mb_iconerror+mb_ok);
     exit;
  end;
  if trim(EditYockKL.Text)='' then
  begin
     messagebox(self.Handle,'请输入岩石抗拉强度！','系统提示',mb_iconerror+mb_ok);
     exit;
  end;
  if trim(EditYockKJ.Text)='' then
  begin
    messagebox(self.Handle,'请输入岩石抗剪强度！','系统提示',mb_iconerror+mb_ok);
    exit;
  end;


  // 汉语拼音
  if TuFileName='' then
     TuFileName:=HZToPY(Trim(ComboStandarName.Text));
  Result:=true;
end;

procedure TZkDetailForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//   Action := caFree;
//   ZkDetail_inn :=nil;

end;

procedure TZkDetailForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   
    if  Assigned(ZkDetail_inn) then  FreeAndNil(ZkDetail_inn);
end;

procedure TZkDetailForm.FormCreate(Sender: TObject);

begin
    MySqlDataSet1:=TMyDataSet.Create(nil);
    MySqlDataSet1.MySqlConnection :=MainDataModule.ExConn;

    MySqlDataSet2:=TMyDataSet.Create(nil);
    MySqlDataSet2.MySqlConnection :=MainDataModule.ExConn;

    MyCommand1:=TMyCommand.Create (nil);
    MyCommand1.MySqlConnection :=MainDataModule.ExConn;
    //

    But_InPutMC.Enabled:=false;
    Select_Cx:=true;
    InitYockBasic;

end;

procedure TZkDetailForm.FormDestroy(Sender: TObject);
begin
    FreeAndNil(MySqlDataSet1);
    FreeAndNil(MySqlDataSet2);
    FreeAndNil(MyCommand1);
end;

procedure TZkDetailForm.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
   StringGrid1.SetFocus  ;
end;

procedure TZkDetailForm.FormShow(Sender: TObject);
begin
    self.FillCell(0,Select_Cx) ;
    PubLic_Basic.InitStatusBar(self.StatusBar1);
    MainDataModule.MySQlFillComBox( MySqlDataSet2,JituanCombo,'select * from jituanName order by id','id','DwName','');
    MainDataModule.MySQlFillComBox(MySqlDataSet2,ComboKName,'select * from KuangJingXinXiBiao '+
                            ' order by id','id','MeiKuangMing','');
    ClearEdit;
    SetEnable(false);
end;

procedure TZkDetailForm.InitYockBasic;
var sltb1,sltb2: TSQLIteTable;
    sql:string;
    s1,s2,s3,s4,s5,s6,s7,s8,s9:string;
begin
    //初始化Yockasic数组

  Y_count:=1;
  self.ComboZkName.Items.Clear ;
  sql := 'select * from BasicYock order by py';
  sltb1:=MainDataModule.Maindb.GetTable(sql);
  while not sltb1.eof do    begin
      SetLength(YockBasic,Y_count);
      YockBasic[Y_count-1]:=TYockBasic.Create  ;
      YockBasic[Y_count-1].id :=Y_count-1;

      YockBasic[Y_count-1].Name :=utf8decode(sltb1.FieldByName['gfmc']);
      YockBasic[Y_count-1].TuFileName  :=utf8decode(sltb1.FieldByName['tuli']);
      s1:= utf8decode(sltb1.FieldByName['leibie']);
      YockBasic[Y_count-1].leibie := strtoint(s1);
      s2:= utf8decode(sltb1.FieldByName['szxs']);
      YockBasic[Y_count-1].szxs  :=strtofloat(s2);
      s3:= utf8decode(sltb1.FieldByName['rz']);
      YockBasic[Y_count-1].rz   := strtofloat(s3);
      s4:= utf8decode(sltb1.FieldByName['kyqd']);
      YockBasic[Y_count-1].kyqd  := strtofloat(s4);
      s5:=utf8decode(sltb1.FieldByName['klqd']);
      YockBasic[Y_count-1].klqd  := strtofloat(s5);
      s6:=utf8decode(sltb1.FieldByName['kjqd']);
      YockBasic[Y_count-1].kjqd  := strtofloat(s6);
      s7:= utf8decode(sltb1.FieldByName['id']);
      YockBasic[Y_count-1].ZhuJian:=strtoint(s7);
      self.ComboStandarName.Items.Add(YockBasic[Y_count-1].Name ) ;
      Y_count:=Y_count+1;
      sltb1.Next;
    end;

end;

procedure TZkDetailForm.JiTuanComboChange(Sender: TObject);
var
   s_temp:Str_DT_array;
   C1:integer;

begin
    s_temp:=Public_Basic.split(JiTuanCombo.Text,'_',C1);
    if s_temp[0]='' then exit;
       i_Jituan:=strToInt(s_temp[0]);

    MainDataModule.MySQlFillComBox(MySqlDataSet2,ComboKName,'select * from KuangJingXinXiBiao  where jituanid = '+s_temp[0] +
                            ' order by id','id','MeiKuangMing','');
    self.ComboKName.ItemIndex:=-1;
end;

procedure TZkDetailForm.OptionTip(Str: String);
begin
   self.StatusBar1.Panels[0].Text :=str;
end;

procedure TZkDetailForm.Fill_McBH_Combo;
var
   s_temp:Str_DT_array;
   C1:integer;
begin
  s_temp:=Public_Basic.split(self.ComboKName.Text,'_',C1);
  if s_temp[0]='' then exit;
  i_kid:=strToInt(s_temp[0]);
  self.ComboBox_Mc.Items.Add('');

  MainDataModule.MySQlFillComBox(MySqlDataSet2,ComboBox_Mc ,'select ID,MeiCengMing from MeiCeng where KuangJingBianHao='+
          s_temp[0],'ID','MeiCengMing','' );
  self.ComboBox_Mc.Items.Add('0_无');
  self.ComboBox_Mc.ItemIndex := ComboBox_Mc.Items.Count-1;

end;

procedure TZkDetailForm.AddButtonClick(Sender: TObject);
var s_temp:Str_DT_array;
    C1:integer;
begin
  if self.YanCenNo>1 then begin
    self.EditYcXh.Text:=IntToStr(self.YanCenNo);
  end;
  i_zid:=0;
  //控制按钮
  self.SaveButton.Enabled :=true;
  self.EditButton.Enabled :=false;
  self.ComboKName.Enabled :=true;
    
  Save_Lx:='Insert'; // 保存时，操作类型，新增、修改    新增
  ClearEdit;
  SetEnable(true);
  self.EditJianSuo.SetFocus;
  OptionTip('正在进行【添加】操作!');
end;

procedure TZkDetailForm.ComboGzmChange(Sender: TObject);
var
   s_temp:Str_DT_array;
   C1:integer;

begin

end;

procedure TZkDetailForm.ComboKNameChange(Sender: TObject);
 var
   s_temp:Str_DT_array;
   C1:integer;

begin
    s_temp:=Public_Basic.split(self.ComboKName.Text,'_',C1);
    if s_temp[0]='' then exit;
     i_kid:=strToInt(s_temp[0]);

     //加载ComboBoxKzName
     self.ComboZkName.Items.Clear;
     self.ComboZkName.Items.Add('');
     MySqlDataSet1.close;
     MySqlDataSet1.CommandText:='select zkid,zkname from zkb where kid= ' +IntToStr(i_kid);

     MySqlDataSet1.Open ;
     while not MySqlDataSet1.eof do
       begin
           ComboZkName.Items.Add(MySqlDataSet1.FieldByName('zkid').AsString+'_'+
                         MySqlDataSet1.FieldByName('zkname').AsString);

          MySqlDataSet1.Next ;
       end;
    MySqlDataSet1.Close ;
    if ComboZkName.Items.Count >1 then
       ComboZkName.ItemIndex :=0;
    //更新煤层编号
    Fill_MCBh_Combo;
end;

procedure TZkDetailForm.ComboStandarNameChange(Sender: TObject);
begin
    SelectYockBmp(ComboStandarName.ItemIndex);
    self.ButtonWjfl.Click ;
end;

procedure TZkDetailForm.ComboZkNameChange(Sender: TObject);
var
   s_temp:Str_DT_array;
   C1:integer;
begin
   s_temp:=Public_Basic.split(ComboZkName.Text,'_',C1);
   self.YanCenNo:=1;
     if C1>1 then  begin
        FillCell(strToInt(s_temp[0]),Select_Cx);
     end else begin
        FillCell(0,Select_Cx);
     end;

     self.EditYcXh.Text:=IntToStr(self.YanCenNo);
end;

procedure TZkDetailForm.DeleteButtonClick(Sender: TObject);
 Var
   t_s:String;
   t_sql:String;
   s_temp:Str_DT_array;
    C1:integer;
begin
     s_temp:=Public_Basic.split(self.ComboZkName.Text,'_',C1);
     if s_temp[0]='' then exit;
     if not self.checkInputEdit then exit;

//**************

  t_s:='你确定要删除【'+self.EditStandardName.Text+'】的数据么?';
  if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;
  if i_Zid<1 then exit;
 try
     t_sql:='delete from  zkycb  where ycid='+StringGrid1.Cells[17,i_zid];
     MYCommand1.CommandText :=t_sql;
     MYCommand1.Execute(MainDataModule.ExUserName)  ;
 except
     exit;
 end;
  self.FillCell(0,Select_Cx) ;
  OptionTip('正在进行【添加】操作!');
  i_Zid:=0;
  i_Kid :=0;
  Save_Lx:=''; //
  ClearEdit;
  SetEnable(false);
end;
procedure TZkDetailForm.EditJianSuoClick(Sender: TObject);
begin
    EditJianSuo.SetFocus
end;

procedure TZkDetailForm.EditJianSuoKeyPress(Sender: TObject; var Key: Char);
var
  Sout:String;
begin
  if not(key in['A'..'Z','a'..'z',#8,' ',#13]) then begin
      key:=#0;  exit;
  end;
   if MainDataModule.MySqliteDataBase.selectBasicYockYP(EditJianSuo.Text+key,Sout)  then begin
       ComboStandarName.ItemIndex:=ComboStandarName.Items.IndexOf(Sout);
       self.SelectYockBmp(ComboStandarName.ItemIndex);
   end;


end;

procedure TZkDetailForm.EditMcidKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkDetailForm.EditStandardNameClick(Sender: TObject);
begin
    EditStandardName.SetFocus;
end;

procedure TZkDetailForm.EditButtonClick(Sender: TObject);
 var
   s_temp:Str_DT_array;
   C1:integer;
begin              
  self.SetEnable(true);
  self.ButtonWjfl.Enabled:=false;
  Save_Lx:='Update'; //
   //控制按钮
    self.SaveButton.Enabled :=true;
    self.EditButton.Enabled :=false;
  OptionTip('正在进行【修改】操作!');
end;

procedure TZkDetailForm.EditFchdClick(Sender: TObject);
begin
    EditFchd.SetFocus;
end;

procedure TZkDetailForm.EditFchdKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkDetailForm.EditYcXhClick(Sender: TObject);
begin
   EditYcXh.SetFocus;
end;

procedure TZkDetailForm.EditYockAvGHClick(Sender: TObject);
begin
    EditYockAvGH.SetFocus;
end;

procedure TZkDetailForm.EditYockAvGHKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkDetailForm.EditYockAvGHMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (trim(self.EditYockMinH.Text)<>'') and (trim(self.EditYockMaxH.Text)<>'')
     and (trim(EditYockAvGH.Text)='')  then begin
      EditYockAvGH.Text:=floattostr(((strtofloat(trim(self.EditYockMinH.Text)))+(strtofloat(trim(self.EditYockMaxH.Text))))/2);
  end;
end;

procedure TZkDetailForm.EditYockKClick(Sender: TObject);
begin
    EditYockK.SetFocus;
end;

procedure TZkDetailForm.EditYockKJClick(Sender: TObject);
begin
    EditYockKJ.SetFocus;
end;

procedure TZkDetailForm.EditYockKJKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkDetailForm.EditYockKKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkDetailForm.EditYockKLClick(Sender: TObject);
begin
   EditYockKL.SetFocus;
end;

procedure TZkDetailForm.EditYockKLKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkDetailForm.EditYockKyClick(Sender: TObject);
begin
   EditYockKy.SetFocus;
end;

procedure TZkDetailForm.EditYockKyKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkDetailForm.EditYockMaxHClick(Sender: TObject);
begin
     EditYockMaxH.SetFocus;
end;

procedure TZkDetailForm.EditYockMaxHKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkDetailForm.EditYockMaxHMouseLeave(Sender: TObject);
begin
 if (trim(self.EditYockMinH.Text)='') then
     EditYockMinH.Text:= EditYockMaxH.Text;
end;

procedure TZkDetailForm.EditYockMinHClick(Sender: TObject);
begin
       EditYockMinH.SetFocus;
end;

procedure TZkDetailForm.EditYockMinHKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9','.',#8]) then
    key:=#0
end;

procedure TZkDetailForm.EditYockMinHMouseLeave(Sender: TObject);
begin
;
end;

procedure TZkDetailForm.EditYockRClick(Sender: TObject);
begin
    EditYockR.SetFocus;
end;

procedure TZkDetailForm.EditYockRKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;



procedure TZkDetailForm.Edit_Kyjs(EditKyqd, EditKlqd, EditKjqd: TEdit; sql,
  str1: AnsiString; str2, str3, str4, str5: integer);

var
  Value_Ky:Double;  //计算差值的具体值， a*1+b*2+c*3+d*4
  EditKyqd_Value,EditKjqd_Value:Double;    //抗压强度、抗拉强度、抗剪强度
  KyqdNum1,KyqdNum2:double;
  KjqdNum1,KjqdNum2:double;
  tag,val,aa,bb,cc,dd,ee:string;
  kyMin,kyMax,klMin,klMax,kjMin,kjMax:double;
  avgValue,a,b,c,d,e:single;
  sltb1,sltb2: TSQLIteTable;

begin
//  Value_Ky:=-1;   //默认值为-1 ，相当于减去1
  Value_Ky:=0;
  EditKyqd.Clear;
  EditKlqd.Clear;
  EditKjqd.Clear;
  EditKyqd_Value:=0;
  EditKjqd_Value:=0;

    sql:= 'select value from sedqenecoff where name=''C1''';
    sltb1:=MainDataModule.Maindb.GetTable(sql);
    while  not sltb1.eof do
    begin
      Value_Ky:=Value_Ky+(strtofloat(utf8decode(sltb1.FieldByName[str1])))*str2;
      sltb1.Next;
    end;


    sql:= 'select value from sedqenecoff where name=''C2''';
    sltb1:=MainDataModule.Maindb.GetTable(sql);
    while  not sltb1.eof do
    begin
      Value_Ky:=Value_Ky+(strtofloat(utf8decode(sltb1.FieldByName[str1])))*str3;
      sltb1.Next;
    end;

    sql:='select value from sedqenecoff where name=''C3''';
    sltb1:=MainDataModule.Maindb.GetTable(sql);
    while  not sltb1.eof do
    begin
      Value_Ky:=Value_Ky+(strtofloat(utf8decode(sltb1.FieldByName[str1])))*str4;
      sltb1.Next;
    end;



    sql:='select value from sedqenecoff where name=''C4''';
    sltb1:=MainDataModule.Maindb.GetTable(sql);
     while  not sltb1.eof do
    begin
      Value_Ky:=Value_Ky+(strtofloat(utf8decode(sltb1.FieldByName[str1])))*str5;
      sltb1.Next;
    end;


    sql:='select grad,keyno,vale from rockname where leibie='+StandarNameLeiBie+
         ' and (grad='''+inttostr(trunc(Value_Ky))+''' or grad='''+inttostr(trunc(Value_Ky)+1)+''')';
    sltb1:=MainDataModule.Maindb.GetTable(sql);

    while not sltb1.eof do    begin

        tag:=RightStr(utf8decode(sltb1.FieldByName['keyno']),1);
        if tag='1' then
        begin
            if (strtoint(utf8decode(sltb1.FieldByName['grad']))) =trunc(Value_Ky) then
            begin
              kyMin:= strtofloat(utf8decode(sltb1.FieldByName['vale']));
            end;
            if (strtoint(utf8decode(sltb1.FieldByName['grad'])))=(trunc(Value_Ky)+1) then
            begin
              kyMax:= strtofloat(utf8decode(sltb1.FieldByName['vale']));
            end;
        end;
        if tag='2' then
        begin
            if (strtoint(utf8decode(sltb1.FieldByName['grad'])))=trunc(Value_Ky) then
            begin
              klMin:= strtofloat(utf8decode(sltb1.FieldByName['vale']));
            end;
            if (strtoint(utf8decode(sltb1.FieldByName['grad'])))=(trunc(Value_Ky)+1) then
            begin
              klMax:= strtofloat(utf8decode(sltb1.FieldByName['vale']));
            end;
        end;
        if tag='3' then
        begin
            if (strtoint(utf8decode(sltb1.FieldByName['grad'])))=trunc(Value_Ky) then
            begin
              kjMin:= strtofloat(utf8decode(sltb1.FieldByName['vale']));
            end;
            if (strtoint(utf8decode(sltb1.FieldByName['grad'])))=(trunc(Value_Ky)+1) then
            begin
              kjMax:= strtofloat(utf8decode(sltb1.FieldByName['vale']));
            end;
        end;
        sltb1.Next;
    end;
    val:=FormatFloat('.##',Value_Ky);
    a:= strtofloat(val);
    c:=a*10;
    b:=trunc(c) mod (trunc(Value_Ky)*10);
    avgValue:= strtofloat('0.'+floattostr(b));
    EditKyqd.Text:=FormatFloat('.##',(kyMin+(kyMax-kyMin)*avgValue));
    EditKjqd.Text:=FormatFloat('.##',(kjMin+(kjMax-kjMin)*avgValue));
    EditKlqd.Text:=FormatFloat('.##',(klMin+(klMax-klMin)*avgValue));

end;

procedure TZkDetailForm.Edit_Text(s_Memo:TMemo; sql, str1, str2,
  str3: AnsiString);
  var sltb1,sltb2: TSQLIteTable;
begin

   sltb1:= MainDataModule.Maindb.GetTable(sql);
   if sltb1.RowCount>0  then
      s_Memo.Text:=utf8decode(sltb1.FieldByName[str1]);


end;

procedure TZkDetailForm.ExitButtonClick(Sender: TObject);
begin
   self.Close ;

end;
procedure TZkDetailForm.SaveButtonClick(Sender: TObject);
 var
   t_sql:String;
   s_temp:Str_DT_array;
   C1,Sffc,i,Insert_bh:integer;
   fchd,ycid:string;
   selected:Boolean;
begin
//*************
  s_temp:=Public_Basic.split(self.ComboZkName.Text,'_',C1);
  if s_temp[0]='' then  begin
     messagebox(self.Handle,'请选择录入钻孔!','系统提示',mb_iconerror+mb_ok);
     exit;
  end;


  if checkInputEdit=false then exit;
    if FcRadioButton.ItemIndex=0 then  begin
     sffc:=0;
     fchd:='0';
  end else begin
     sffc:=1;
     fchd:=EditFchd.Text;
  end;

  if Public_Basic.StrTodouble_lu(Self.EditYockAvGH.Text) < Public_Basic.StrToDouble_lu(fchd) then  begin
     messagebox(self.Handle,'分层厚度大于岩层的平均厚度!','系统提示',mb_iconerror+mb_ok);
     exit;
  end;


  if CheckBox1.Checked then begin
      if length(trim(YcBh_Zry.Text)) <1 then    begin
        messagebox(self.Handle,'请录入插入岩层的序号!','系统提示',mb_iconerror+mb_ok);
        exit;
      end;
      Insert_bh:=Public_Basic.StrToInt_lu(YcBh_Zry.Text) ;
      selected:=false;
      for i := 0 to 3 do begin
        MYSQLDataSet1.Close ;
        if Insert_bh-i <1 then  break;
        t_sql:='select * from zkycb where yczkid ='+IntTostr(Insert_bh-i)+' and kid='+
              Public_Basic.split(self.ComboKName.Text,'_',C1)[0]+' and zkID='+s_temp[0]+'' ;
        MYSQLDataSet1.CommandText:=t_sql;
        if (MYSQLDataSet1.Open ) and (MYSQLDataSet1.RecordCount < 1)   then begin
           YcBh_Zry.Text:= IntTostr(Insert_bh-i);
           selected:=true;
           break;
         end;
      end;
      if not Selected then
         for i := 1 to 3 do begin
              MYSQLDataSet1.Close ;
              t_sql:='select * from zkycb where yczkid ='+IntTostr(Insert_bh+i)+' and kid='+
                    Public_Basic.split(self.ComboKName.Text,'_',C1)[0]+' and zkID='+s_temp[0]+'' ;
              MYSQLDataSet1.CommandText:=t_sql;
              if (MYSQLDataSet1.Open ) and (MYSQLDataSet1.RecordCount < 1)   then begin
                 YcBh_Zry.Text:= IntTostr(Insert_bh+i);
                 selected:=true;
                 break;
               end;
         end;

      if not selected then begin
          messagebox(self.Handle,'系统查找多次都没有找到合适岩层编号，请优化一下录入!','系统提示',mb_iconerror+mb_ok);
          exit;
      end else begin
        ycid:= YcBh_Zry.Text
      end;

  end else begin
     ycid:= EditYcXh.Text ;
  end;


  if Save_Lx ='Insert' then   begin   //是增加操作
    // insert
    t_sql:='insert into zkycb (yczkID,ysmc,hd,sffc,fchd,sfhsc,mcid,szxs,rz,klqd,kyqd,zkid,yzid,' +
              ' minhd,maxhd,zdcbh,kjqd,kid,BmpFile) values('+
              ycid+','''+self.EditStandardName.Text+''','+self.EditYockAvGH.Text+','+    //  yczkID,ysmc,hd
              inttostr(sffc)+','+fchd+','+inttostr(self.HsRadioButton.ItemIndex)+  //sffc,fchd,sfhsc
              ','+Mc_id+','+ //mcid,
              self.EditYockK.Text+','+self.EditYockR.Text+','+self.EditYockKL.Text+','+self.EditYockKy.Text+','+  //szxs,rz,klqd,kyqd
              Public_Basic.split(self.ComboZkName.Text,'_',C1)[0]+','+FormatFloat('.##',YockBasic[self.ComboStandarName.ItemIndex].ZhuJian)+ //zkid,yzid
              ','+self.EditYockMinH.Text+','+self.EditYockMaxH.Text+ ','''+        //minhd,maxhd
              '1'+''','+self.EditYockKJ.Text+','+Public_Basic.split(self.ComboKName.Text,'_',C1)[0]+  //zdcbh,kjqd,kid
              ','''+TuFileName+''')';

  end else if Save_Lx='Update' then  begin  //是修改操作
     if SelectYCid <1 then  exit;
     t_sql:='update zkycb set yczkID='+ycid+',ysmc='''+self.EditStandardName.Text+''',' +
               ' hd='+ self.EditYockAvGH.Text+',sffc='+inttostr(sffc)+',fchd='+fchd+ ',' +
               ' sfhsc='+inttostr(self.HsRadioButton.ItemIndex)+',mcid='+Mc_id+ ','+
               ' szxs='+self.EditYockK.Text+',rz='+self.EditYockR.Text+ ',klqd='+self.EditYockKL.Text+
               ',kyqd='+self.EditYockKy.Text+ ',zkid='+Public_Basic.split(self.ComboZkName.Text,'_',C1)[0]+
               ',yzid='+FormatFloat('.##',YockBasic[self.ComboStandarName.ItemIndex].ZhuJian)+
               ',minhd='+self.EditYockMinH.Text+',maxhd='+self.EditYockMaxH.Text+
               ',zdcbh='''+'-1'+''',kjqd='+self.EditYockKJ.Text+
               ',kid='+Public_Basic.split(self.ComboKName.Text,'_',C1)[0]+' ' +
               ',BmpFile= '''+TuFileName+'''  where ycid='+intToStr(SelectYCid);
  end;

 try
  MYCommand1.CommandText :=t_sql;
  MYCommand1.Execute(MainDataModule.ExUserName)  ;
 except
  exit;
 end;

  OptionTip('数据存储成功!');
  self.FillCell(StrToInt(s_temp[0]),Select_Cx) ;  //填充Cell
  i_zid :=0;
  self.SaveButton.Enabled:=false;
  Save_Lx:=''; //
  ClearEdit;
  SetEnable(false);
end;

procedure TZkDetailForm.SelectYockBmp(YCid: Integer);
begin
    TuFileName :=YockBasic[YCid].TuFileName;
    MainDataModule.MySqliteDataBase.GetBMPToSQlite(TuFileName+'.bmp','1',Image1.Picture.Bitmap);
    EditStandardName.Text:=YockBasic[self.ComboStandarName.ItemIndex].Name;
    EditYockR.text:=FormatFloat('.##',YockBasic[self.ComboStandarName.ItemIndex].rz);
    EditYockK.Text:=FormatFloat('.##',YockBasic[self.ComboStandarName.ItemIndex].szxs) ;
    StandarNameLeiBie:=FormatFloat('.##',YockBasic[self.ComboStandarName.ItemIndex].leibie) ;
    if StandarNameLeiBie='' then StandarNameLeiBie:='7';
    if EditStandardName.Text='煤' then  begin
       But_InputMc.Enabled :=true;
    end else begin
       But_InputMc.Enabled :=False;
    end;

    ButtonWjfl.Enabled:=true;
end;

procedure TZkDetailForm.SetCellHead;
 var
   i:integer;
 begin
    for i := 1 to  StringGrid1.RowCount - 1 do
          StringGrid1.Rows[i].Clear ;
      self.StringGrid1.ColCount :=19;
      self.StringGrid1.RowCount :=2;
      self.StringGrid1.Cells [0,0]:='序号';
      self.StringGrid1.Cells [1,0]:='钻孔编号';
      self.StringGrid1.Cells [2,0]:='岩层序号';
      self.StringGrid1.Cells [3,0]:='岩层名称';
      self.StringGrid1.Cells [4,0]:='岩层最小厚度';
      self.StringGrid1.Cells [5,0]:='岩层最大厚度';
      self.StringGrid1.Cells [6,0]:='岩层平均厚度';
      self.StringGrid1.Cells [7,0]:='是否分层';
      self.StringGrid1.Cells [8,0]:='分层厚度';
      self.StringGrid1.Cells [9,0]:='是否含水';
      self.StringGrid1.Cells [10,0]:='可采煤层标记';

      self.StringGrid1.Cells [11,0]:='容重';
      self.StringGrid1.Cells [12,0]:='抗压强度';
      self.StringGrid1.Cells [13,0]:='抗拉强度';
      self.StringGrid1.Cells [14,0]:='抗剪强度';
      self.StringGrid1.Cells [15,0]:='碎涨系数';
      self.StringGrid1.Cells [16,0]:='KID';

      self.StringGrid1.ColWidths[0]:=20;
      for I := 1 to StringGrid1.ColCount-1 do begin
        self.StringGrid1.ColWidths[i]:=80;
       end;
      self.StringGrid1.ColWidths[16]:=0;
      self.StringGrid1.ColWidths[17]:=0;

 end;

procedure TZkDetailForm.StringGrid1MouseDown(Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  i_Zid:=-1;
end;

procedure TZkDetailForm.StringGrid1SelectCell(Sender: TObject; ACol,  ARow: Integer; var CanSelect: Boolean);
var
   s_temp:Str_DT_array;
   C1:integer;

   I:integer;
   s_tempZRY:Str_DT_array;
   C1ZRY:integer;
   ZKID:string;
   J:string;
   mcid:Integer;

    s_temp2:Str_DT_array;
   C2:integer;
begin

  if i_Zid=0 then exit;
  if i_Zid=ARow then exit;
   
  ClearEdit;
  SetEnable(false);
  i_Zid:=ARow;

  self.EditYcXh.Text:=StringGrid1.Cells[2,ARow]; //      岩层序号
  self.EditStandardName.Text :=StringGrid1.Cells [3,ARow];//   标准岩层名称

  self.ComboStandarName.ItemIndex:=self.ComboStandarName.Items.IndexOf(StringGrid1.Cells [3,ARow]);//   标准岩层名称
  SelectYCid:=Public_Basic.StrToInt_lu(StringGrid1.Cells [17,ARow]);
  if trim(StringGrid1.Cells [16,ARow])<>'' then begin
    ZKID:=StringGrid1.Cells [16,ARow];  //16:矿井编号
    for I := 0 to ComboKName.Items.Count-1 do begin
      s_tempZRY:=Public_Basic.split(ComboKName.Items.Strings[i],'_',C1ZRY);
      J:=s_tempZRY[0];
      if ZKID=J then
      begin
        self.ComboKName.ItemIndex:=i;
      end;
    end;
  end;

     But_InPutMC.Enabled:=true;

    s_temp:=Public_Basic.split(self.ComboKName.Text,'_',C1);
    if s_temp[0]='' then exit;
     i_kid:=strToInt(s_temp[0]);
     //加载ComboBoxKzName
     self.ComboZkName.Items.Clear;
     self.ComboZkName.Items.Add('');
     MYSQLDataSet2.close;
     MYSQLDataSet2.CommandText:='select zkid,zkname from zkb where kid= ' +IntToStr(i_kid);
     MYSQLDataSet2.Open ;
     while not MYSQLDataSet2.eof do
       begin
           self.ComboZkName.Items.Add(MYSQLDataSet2.FieldByName('zkid').AsString+'_'+
                       MYSQLDataSet2.FieldByName('zkname').AsString);
           self.ComboBox_Mc.Items.Add('0_无');
           MYSQLDataSet2.Next ;
       end;
    MYSQLDataSet2.Close ;
    if ComboZkName.Items.Count >1 then
       ComboZkName.ItemIndex :=0;
  if trim(StringGrid1.Cells [1,ARow])<>'' then begin
    ZKID:=StringGrid1.Cells [1,ARow];  //1:钻孔编号
    for I := 0 to ComboZkName.Items.Count-1 do begin
      s_tempZRY:=Public_Basic.split(ComboZkName.Items.Strings[i],'_',C1ZRY);
      J:=s_tempZRY[0];
      if ZKID=J then begin
        self.ComboZkName.ItemIndex:=i;
      end;
    end;
  end;

  self.EditYockMinH.text:=StringGrid1.Cells [4,ARow];//       最小岩层厚度
  self.EditYockMaxH.Text :=StringGrid1.Cells [5,ARow];//      最大岩层厚度
  self.EditYockAvGH.text:=StringGrid1.Cells [6,ARow];//      岩层平均厚度

  self.EditFchd.Text :=StringGrid1.Cells [8,ARow];//     分层厚度
  self.EditYockR.Text :=StringGrid1.Cells [11,ARow];//      容重
  self.EditYockKy.Text:=StringGrid1.Cells [12,ARow];//      抗压强度
  self.EditYockK.Text :=StringGrid1.Cells [15,ARow];//      碎涨系数
  self.EditYockKL.Text:=StringGrid1.Cells [13,ARow];//       抗拉强度
  self.EditYockKJ.Text :=StringGrid1.Cells [14,ARow];//     抗剪强度


  Fill_MCBh_Combo;

  if trim(StringGrid1.Cells [7,ARow])<>'' then begin
    FcRadioButton.ItemIndex:=strtoint(StringGrid1.Cells [7,ARow]);
  end;
  if trim(StringGrid1.Cells [9,ARow])<>'' then begin
    HsRadioButton.ItemIndex:=strtoint(StringGrid1.Cells [9,ARow]);
  end;
         for I := 0 to self.ComboBox_Mc.Items.Count -1  do
          begin
              s_temp:=Public_Basic.split(self.ComboBox_Mc.Items.Strings[i] ,'_',C1);
              if Trim(Trim(StringGrid1.Cells[10,ARow])) ='' then
              begin
                   mcid:=0;
              end else
              begin
                   mcid:= strtoint(Trim(Trim(StringGrid1.Cells[10,ARow]))) ;
              end;
                if s_temp[0]=inttostr(mcid) then
                  begin
                   self.ComboBox_Mc.ItemIndex :=i;
//                   ComboMcId.OnChange(nil);
                   break;
                  end else begin
                    self.ComboBox_Mc.ItemIndex :=self.ComboBox_Mc.Items.Count+1;
                  end;
           end;

   //图片
    MainDataModule.MySqliteDataBase.GetBMPToSQlite(HZToPY(Trim(ComboStandarName.Text))+'.Bmp'
              ,'1',Image1.Picture.Bitmap) ;

     //控制按钮
     self.EditButton.Enabled :=true;
     self.DeleteButton.Enabled :=true;
end;
procedure TZkDetailForm.ToolButton1Click(Sender: TObject);
 var
   s_temp:Str_DT_array;
   C1:integer ;
begin
   if Select_Cx then begin
      ToolButton1.Caption :='正序';
      Select_Cx:=false;
   end else begin
      ToolButton1.Caption :='逆序';
      Select_Cx:=true;
   end;

   s_temp:=Public_Basic.split(ComboZkName.Text,'_',C1);
   if C1>1 then  begin
      FillCell(strToInt(s_temp[0]),Select_Cx);
   end else begin
      FillCell(0,Select_Cx);
   end;
end;

//岩层序号指定插入
procedure TZkDetailForm.YcBh_ZryClick(Sender: TObject);
begin
    YcBh_Zry.SetFocus;
end;

procedure TZkDetailForm.YcBh_ZryExit(Sender: TObject);
begin
  self.EditYcXh.Text:=self.YcBh_Zry.Text;
end;
//岩层序号指定插入
procedure TZkDetailForm.YcBh_ZryKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkDetailForm.YcBh_ZryMouseLeave(Sender: TObject);
begin
//  showmessage('鼠标离开！');
end;

procedure TZkDetailForm.FcRadioButtonClick(Sender: TObject);
begin
   if self.FcRadioButton.ItemIndex =0 then begin
     self.EditFchd.Enabled :=false;
     EditFchd.Text:='';
   end else begin
     self.EditFchd.Enabled :=true;
     EditFchd.SetFocus;
   end;
end;

procedure TZkDetailForm.FillCell(id :integer;zxOrnx:Boolean); //填充表格
  var
    t_col,t_row,i:integer;
    sql:string;
    TotalHeigth:Double;
begin
       SetCellHead;

       MYSQLDataSet1.Close();
       if id=0 then  begin
          sql:='select * from zkycb order by ycid';
       end else begin
          sql:='select * from zkycb where zkId =' +IntToStr(id) +' order by yczkid';
       end;

       if not zxOrnx then
          sql:=sql+' desc';

       MYSQLDataSet1.CommandText:=sql;
       MYSQLDataSet1.Open;
       MYSQLDataSet1.First ;
       t_col:=1;t_row:=1;TotalHeigth:=0;
       while not MYSQLDataSet1.Eof  do   begin
           self.StringGrid1.Cells [0,t_row]:=inttostr(t_row);
           self.StringGrid1.Cells [1,t_row]:=MYSQLDataSet1.FieldByName('zkid').AsString ;   //1:钻孔编号
           self.StringGrid1.Cells [2,t_row]:=MYSQLDataSet1.FieldByName('Yczkid').AsString ; // 2：岩石序号
           self.StringGrid1.Cells [3,t_row]:=MYSQLDataSet1.FieldByName('ysmc').AsString ;   //3：岩石名称
           self.StringGrid1.Cells [4,t_row]:=FormatFloat('.##',MYSQLDataSet1.FieldByName('minhd').AsFloat ); // 4：岩石最小厚度
           self.StringGrid1.Cells [5,t_row]:=FormatFloat('.##',MYSQLDataSet1.FieldByName('maxhd').AsFloat );   //5:岩层最大厚度
           self.StringGrid1.Cells [6,t_row]:=FormatFloat('.##',MYSQLDataSet1.FieldByName('hd').AsFloat );   //6:岩层平均厚度
           self.StringGrid1.Cells [7,t_row]:=MYSQLDataSet1.FieldByName('sffc').AsString ; // 7：是否分层
           self.StringGrid1.Cells [8,t_row]:=FormatFloat('.##',MYSQLDataSet1.FieldByName('fchd').AsFloat );   //8:分层厚度
           self.StringGrid1.Cells [9,t_row]:=MYSQLDataSet1.FieldByName('sfhsc').AsString ; // 9：是否含水
           self.StringGrid1.Cells [10,t_row]:=MYSQLDataSet1.FieldByName('mcid').AsString ;   //10:煤层标记
           self.StringGrid1.Cells [11,t_row]:=FormatFloat('.##',MYSQLDataSet1.FieldByName('rz').AsFloat );   //11:岩石容重
           self.StringGrid1.Cells [12,t_row]:=FormatFloat('.##',MYSQLDataSet1.FieldByName('kyqd').AsFloat ); // 12：岩石抗压
           self.StringGrid1.Cells [13,t_row]:=FormatFloat('.##',MYSQLDataSet1.FieldByName('klqd').AsFloat );   //13:岩石抗拉
           self.StringGrid1.Cells [14,t_row]:=FormatFloat('.##',MYSQLDataSet1.FieldByName('kjqd').AsFloat ); // 14：岩石抗剪
           self.StringGrid1.Cells [15,t_row]:=FormatFloat('.##',MYSQLDataSet1.FieldByName('szxs').AsFloat );   //15:碎涨系数
           self.StringGrid1.Cells [16,t_row]:=MYSQLDataSet1.FieldByName('KID').AsString ;   //16:矿井编号
           self.StringGrid1.Cells [17,t_row]:=MYSQLDataSet1.FieldByName('ycid').AsString ;   //17:主键值
           t_row:=t_row+1;
           if t_row>self.StringGrid1.RowCount  then    self.StringGrid1.RowCount :=t_row;
           TotalHeigth:=TotalHeigth+MYSQLDataSet1.FieldByName('hd').AsFloat;
           MYSQLDataSet1.Next ;
       end;

       if zxOrnx then  begin
           MYSQLDataSet1.Last;
           YanCenNo:= MYSQLDataSet1.FieldByName('yczkid').AsInteger +4;
       end else begin
           MYSQLDataSet1.First ;
           YanCenNo:= MYSQLDataSet1.FieldByName('yczkid').AsInteger +4;
       end;
       MYSQLDataSet1.Close ;
       i_Zid:=0;
       StatusBar1.Panels[1].Text:='累计高度【'+FormatFloat('.##',TotalHeigth) +'】米';
end;

end.


