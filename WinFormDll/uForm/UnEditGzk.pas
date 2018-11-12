unit UnEditGzk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, ComCtrls, ToolWin, ExtCtrls, OleCtrls,StrUtils,
  Grids,ADODB, DB,SQLiteTable3,SQLite3, System.ImageList,
  PStope_GzmGuidClass ,UMainDataModule,UnTxMc;

type
  TZkGzmForm = class(TForm)
    Splitter1: TSplitter;
    ImageList1: TImageList;
    Panel1: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    EditCqName: TEdit;
    Label2: TLabel;
    ComboMcId: TComboBox;
    Label5: TLabel;
    EditMcHd: TEdit;
    Label6: TLabel;
    EditzKcgd: TEdit;
    Label7: TLabel;
    ComboCmFa: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    AddButton: TToolButton;
    EditButton: TToolButton;
    SaveButton: TToolButton;
    DeleteButton: TToolButton;
    ExitButton: TToolButton;
    Label15: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    Label12: TLabel;
    EditGc: TEdit;
    EditZxc: TEdit;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label36: TLabel;
    LablMK: TLabel;
    Editqj2: TEdit;
    Editqj1: TEdit;
    EditQxc: TEdit;
    ComboMKy: TComboBox;
    Combozhqk: TComboBox;
    ComboZJType: TComboBox;
    ComboYxFx: TComboBox;
    ComboJYhd: TComboBox;
    EditSpeed: TEdit;
    ComboDzgz: TComboBox;
    Label17: TLabel;
    EditSh1: TEdit;
    Label18: TLabel;
    Label11: TLabel;
    Editsh2: TEdit;
    Label19: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    ComboBottomWater: TComboBox;
    ComboTopWater: TComboBox;
    ComboWs: TComboBox;
    ComboHdzh: TComboBox;
    ComboKsyl: TComboBox;
    ComboStress: TComboBox;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    StringGrid1: TStringGrid;
    FcRadioButton: TRadioGroup;
    Label46: TLabel;
    Label47: TLabel;
    EditJueJin: TEdit;
    Label48: TLabel;
    Button1: TButton;
    Label4: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    ComboSupNumberDirection: TComboBox;
    SupStartNumber: TEdit;
    SupEndNumber: TEdit;
    cboQyzt: TComboBox;
    Label53: TLabel;
    CkCkq: TButton;
    CkDc: TButton;
    CkMz: TButton;
    CreatTable: TButton;
    btnBf: TButton;
    btnHf: TButton;
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    ComboKName: TComboBox;
    StatusBar1: TStatusBar;
    Label45: TLabel;
    JITuanCombo: TComboBox;
    But_EditFileName: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure ComboKNameChange(Sender: TObject);
    procedure ComboZkChange(Sender: TObject);
    procedure EditMcHdKeyPress(Sender: TObject; var Key: Char);
    procedure EditzKcgdKeyPress(Sender: TObject; var Key: Char);
    procedure EditSh1KeyPress(Sender: TObject; var Key: Char);
    procedure EditZxcKeyPress(Sender: TObject; var Key: Char);
    procedure EditGcKeyPress(Sender: TObject; var Key: Char);
    procedure Editsh2KeyPress(Sender: TObject; var Key: Char);
    procedure Editqj1KeyPress(Sender: TObject; var Key: Char);
    procedure Editqj2KeyPress(Sender: TObject; var Key: Char);
    procedure EditSpeedKeyPress(Sender: TObject; var Key: Char);
    procedure EditUPMzKeyPress(Sender: TObject; var Key: Char);
    procedure EditDownMzKeyPress(Sender: TObject; var Key: Char);
    procedure CombozhqkChange(Sender: TObject);
    procedure ComboCmFaChange(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FcRadioButtonClick(Sender: TObject);
    procedure EditJueJinKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);

    procedure EditSh1MouseEnter(Sender: TObject);

    procedure SupStartNumberKeyPress(Sender: TObject; var Key: Char);
    procedure SupEndNumberKeyPress(Sender: TObject; var Key: Char);
    procedure EditQxcKeyPress(Sender: TObject; var Key: Char);
    procedure CkCkqClick(Sender: TObject);
    procedure CkDcClick(Sender: TObject);
    procedure CkMzClick(Sender: TObject);
    procedure CreatTableClick(Sender: TObject);
    procedure btnBfClick(Sender: TObject);
    procedure btnHfClick(Sender: TObject);
    procedure EditCqNameClick(Sender: TObject);
    procedure SupEndNumberChange(Sender: TObject);
    procedure SupEndNumberClick(Sender: TObject);
    procedure SupStartNumberClick(Sender: TObject);
    procedure EditGcClick(Sender: TObject);
    procedure EditJueJinClick(Sender: TObject);
    procedure EditZxcClick(Sender: TObject);
    procedure EditQxcClick(Sender: TObject);
    procedure Editqj1Click(Sender: TObject);
    procedure Editqj2Click(Sender: TObject);
    procedure EditSpeedClick(Sender: TObject);
    procedure Editsh2Click(Sender: TObject);
    procedure EditSh1Click(Sender: TObject);
    procedure EditzKcgdClick(Sender: TObject);
    procedure EditMcHdClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure JITuanComboChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure ComboMcIdClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure But_EditFileNameClick(Sender: TObject);
  private
    { Private declarations } 
    FinGzm:TGzm;
    i_Kid,i_Jituan:Integer;   //矿ID，//集团工公司编号
    Save_Lx:string; //
    KARow:integer;
    gzmqyzt:Integer ;
    //2017 edit
    MySqlDataSet1:TMyDataSet;
    MySqlDataSet2:TMyDataSet;
    MyCommand1:TMyCommand;
    kczt,kccd:Integer;// 开采状态 与 开采的进尺

    //
    procedure SetCellHead; //设置Cell表头
    procedure FillCell(id:Integer); //填充表格
    procedure IniForm;  //初始化窗体
    procedure ClearEdit;   //清空编辑框
    function  CheckInputEdit:wordbool; //检查录入格式是否合格
    procedure SetEnable(ISCanEnable:bool);
    procedure CboCsh(ISCom:bool);//combox初始化的时候选择第一项，true初始化调用为空，false为添加或修改使用，填充第一项
    procedure OptionTip(Str:String);
    procedure SaveSupportInfo(SupportName:String);
  public
    KuangJingBianHao:string;
    ExHandle:THandle;
    EX_width,Ex_Height:integer;
    procedure Fill_MCBh_Combo;  //2016-6-14
  end;

 function CreateGzm_inn(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;stdcall;

var
  innGzmForm: TZkGzmForm;

implementation

uses math,IniFiles,FileCtrl , uWinFrameClass, UnCkq, UnDc,
  UnMz,  Lu_Public_BasicModual, uLuSqliteDealWith, UFormEditWordFile;

{$R *.dfm}
//内部初始化工作面函数
function CreateGzm_inn(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;stdcall;
   begin
        if Assigned(innGzmForm) then  FreeAndNil(innGzmForm);
        Application.Handle :=AHandle;
        innGzmForm:=TZkGzmForm.Create(nil);
        try
           with innGzmForm do begin
               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;
               //
               ExHandle:= AHandle;
               EX_width:=wid;
               Ex_Height:=hi;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

                Show;
                SetFocus;
                Result:=innGzmForm.Handle;//函数值
          end ;
        except
          FreeAndNil(innGzmForm);
        end;
end;


procedure TZkGzmForm.IniForm ;  // 初始化窗体
var
   t:TDateTime;
begin
     //从本地数据库读取
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboCmFa,'select zdid,Text from zdname  where zdname=''cmfa'' order by zdid','zdid','Text',''); //采煤方法
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboMKy,'select zdid,Text from zdname  where zdname=''mtyd'' order by zdid','zdid','Text',''); //煤体硬度
     MainDataModule.MySqliteDataBase.SqliteComboList(Combozhqk ,'select zdid,Text from zdname  where zdname=''zhqk'' order by zdid','zdid','Text',''); //支护情况
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboYxFx ,'select zdid,Text from zdname  where zdname=''YxFX'' order by zdid','zdid','Text',''); //  仰斜俯斜
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboJYhd  ,'select zdid,Text from zdname  where zdname=''JYHD'' order by zdid','zdid','Text',''); // 基岩厚度
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboDzgz  ,'select zdid,Text from zdname  where zdname=''DCGZ'' order by zdid','zdid','Text',''); // 地质构造
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboWs  ,'select zdid,Text from zdname  where zdname=''WSFC'' order by zdid','zdid','Text',''); //  瓦斯
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboTopWater  ,'select zdid,Text from zdname  where zdname=''TopWater'' order by zdid','zdid','Text',''); //  顶板水
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboBottomWater  ,'select zdid,Text from zdname  where zdname=''BottomWater'' order by zdid','zdid','Text',''); //  底板水
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboStress  ,'select zdid,Text from zdname  where zdname=''HeoStress'' order by zdid','zdid','Text',''); //  底板水
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboKsyl  ,'select zdid,Text from zdname  where zdname=''Kyxx'' order by zdid','zdid','Text',''); //  矿压显现
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboHdzh   ,'select zdid,Text from zdname  where zdname=''HangDaoSup'' order by zdid','zdid','Text',''); // 巷道支护
     //从录入数据库读取液压支架
     MainDataModule.MySQlFillComBox(MySqlDataSet2,ComboZJType  ,'select xh,id from zjxhb  order by id', 'xh','',''); //  支架型号
     MainDataModule.MySQlFillComBox(MySqlDataSet2,JiTuanCombo,'select * from JItuanName order by id','id','DwName','');
     ComboZJType.Items.Add('   ');
     ComboZJType.ItemIndex :=ComboZJType.Items.Count -1;

     ClearEdit;
     SetEnable(false);

end;

procedure TZkGzmForm.JITuanComboChange(Sender: TObject);
 var
   s_temp:Str_DT_array;
   C1:integer;
begin

   s_temp:=Public_Basic.split(self.JituanCombo.Text,'_',C1);
   if s_temp[0]='' then exit;

     i_Jituan:=strToInt(s_temp[0]);
     MainDataModule.MySQlFillComBox(MySqlDataSet2,ComboKName,'select * from KuangJingXinXiBiao  where Jituanid=' +
                      IntToStr(i_Jituan)+' order by id ','id','MeiKuangMing','');

     ComboKName.Enabled :=true;
      FillCell(0);
end;

procedure TZkGzmForm.OptionTip(Str: String);
begin
    self.StatusBar1.Panels[0].Text :=str;
end;

procedure TZkGzmForm.Fill_MCBh_Combo;
var
    s_temp:Str_DT_array;
   C1:integer;
   C1LS:integer;
begin
    s_temp:=Public_Basic.split(self.ComboKName.Text,'_',C1);
    if s_temp[0]='' then exit;
    i_kid:=strToInt(s_temp[0]);

     MainDataModule.MySQlFillComBox(MySqlDataSet2,ComboMcId ,'select ID,MeiCengMing from MeiCeng where KuangJingBianHao='+
          s_temp[0],'ID','MeiCengMing','' );
  self.ComboMcId.Items.Add('0_无');
  self.ComboMcId.ItemIndex := ComboMcId.Items.Count-1;

end;

procedure TZkGzmForm.CkCkqClick(Sender: TObject);
var
  StrOut:String;
begin
  StrOut:='【'+EditCqName.Text +'】增加采空区录入界面'  ;
  CreateUnCkq_inn(Handle,StrOut,FinGzm.Gzmbh);


end;

procedure TZkGzmForm.CkDcClick(Sender: TObject);
var
  StrOut:String;
begin
  StrOut:='【'+EditCqName.Text +'】增加断层录入界面'  ;
  CreateUnDc_inn(Handle,StrOut,FinGzm.Gzmbh );

end;

procedure TZkGzmForm.CkMzClick(Sender: TObject);
var
  StrOut:String;
begin
  StrOut:='【'+EditCqName.Text +'】增加 煤柱录入界面'  ;
  CreateUnMz_inn(Handle,StrOut,FinGzm.Gzmbh );

end;

procedure  TZkGzmForm.ClearEdit ;  //  清空编辑框
begin
      //clear 录入框
       self.EditCqName.Text :=''; // 清空采区名称
       self.ComboMcId.Items.Clear ;// 煤层编号
       self.EditzKcgd.Text :='';//   开采高度
       self.EditMcHd.Text :='';// 煤层均厚
       self.EditSh1.Text :='';//    上边界采深
       self.Editsh2.Text :='';//      下边界采深
       self.EditGc.Text :='';//     平均采深
       self.EditZxc.Text:='';//    走向长度
       self.EditQxc.Text :='';//   倾向长度
       self.Editqj2.Text :='';//    走向倾角
       self.Editqj1.Text :='';//    倾向倾角
       self.EditSpeed.Text :='';//      推进速度
     
       self.EditJueJin.Text:='';//  掘进 累计进尺
       self.SupStartNumber.Text:='';// 开始支架编号  2016-6-3
       self.SupEndNumber.Text:='';//终止支架编号     2016-6-3

     //clear InputGzm对象
       FinGzm.S_Name:='';//     1 :  采区名称
       FinGzm.S_mc_name:='';//  2 :  煤层名称
       FinGzm.S_Agv_mch:=0;//       3 :  煤层均厚
       FinGzm.S_Cg_h:=0;//      4 :  开采高度
       FinGzm.S_cmfs :='0';//       5:   采煤方法
       FinGzm.S_Sh_UP :=0;//   6:    上边界采深
       FinGzm.S_Sh_Down:=0;//  7:     下边界采深
       FinGzm.S_mcsd_h :=0;//  8:    平均采深
       FinGzm.S_Sx_zx:=0; // 9:      走向长
       FinGzm.S_L_qx :=0;// 10:       倾向长
       FinGzm.S_SX_qj :=0;//11:        走向倾角
       FinGzm.S_qj :=0;// 12:      倾向倾角
       FinGzm.S_DayStep_speed:=0;//13:       推进速度
       FinGzm.CK_Upkc:=0;  //           上边界  开采情况 1 已采 0 未采
       FinGzm.CK_UpMz:=0;// 14:    上边界煤柱
       FinGzm.CK_downkc:=0;   //           上边界  开采情况 1 已采 0 未采
       FinGzm.CK_downmz :=0;// 15：  下边界煤柱

       FinGzm.KuangJingId :=0;  // 17:矿区编号

       FinGzm.S_f_PS:=0;  // 18:煤体硬度
       FinGzm.Dz_HangDaoSup  :=0;  // 19:支护情况

       FinGzm.SupportName :='';  // 20:支架型号
       FinGzm.Dz_yxfx  :=0;  // 21:仰斜倾斜

       FinGzm.Dz_JYHD :=0;  // 22: 基岩厚度
       FinGzm.Dz_DCGZ :=0;  // 23:地质构造

       FinGzm.Dz_WSFC  :=0;  // 24: 瓦斯赋存
       FinGzm.Dz_TopWater  :=0;  // 25:顶板水源

       FinGzm.Dz_BottomWater  :=0;  // 26:  底板水源
       FinGzm.Dz_HeoStress  :=0;  // 27:水平应力

       FinGzm.Dz_Kyxx :=0;  // 28:矿压显现
       FinGzm.Dz_HangDaoSup  :=0;  // 29: 巷道支护

       self.ComboKName.ItemIndex:=-1;
       self.ComboMcId.ItemIndex:=-1;


//     self.ComboZk.ItemIndex:=-1;


        SupStartNumber.Text :='';// 支架开始编号
        SupEndNumber.Text :='';  //支架终止编号
       // ComboSupNumberDirection.ItemIndex :=-1; //支架型号方向
      //  cboQyzt.ItemIndex := -1; //工作面状态

       ComboCmFa.ItemIndex :=2; //一次采全高
       ComboMKy.ItemIndex :=2;//P 1.5-2
       Combozhqk.ItemIndex:=1;//液压支架
       ComboYxFx.ItemIndex :=0;// 水平推进
       ComboJYhd.ItemIndex:=1;// 一般基岩
       ComboDzgz.ItemIndex:=0;//地质构造较少
       ComboWs.ItemIndex:=0;  //瓦斯浓度较低
       ComboTopWater.ItemIndex:=0;   //顶板无水
       ComboBottomWater.ItemIndex:=0; //底板无水
       ComboStress.ItemIndex:=0; //水平应力小于垂直应力
       ComboKsyl.ItemIndex:=1;//有矿压显现
       ComboHdzh.ItemIndex:=1;//简单锚网支护

       ComboMcId.ItemIndex := 0; //煤层编号
       ComboZJType.ItemIndex := 0; //支架型号
       ComboSupNumberDirection.ItemIndex := 0;   //轨道方向
       cboQyzt.ItemIndex := 0; //工作状态

end;

procedure TZkGzmForm.SetEnable(ISCanEnable: LongBool);
begin
     ComboKName.Enabled:= ISCanEnable;
     EditCqName.Enabled:=ISCanEnable;
     EditMcHd.Enabled:= ISCanEnable;
     EditzKcgd.Enabled:= ISCanEnable;
     ComboCmFa.Enabled:= ISCanEnable;
     EditSh1.Enabled:= ISCanEnable;
     Editsh2.Enabled:= ISCanEnable;
     EditGc.Enabled:= ISCanEnable;
     EditZxc.Enabled:= ISCanEnable;
     EditQxc.Enabled:= ISCanEnable;
     EditJueJin.Enabled:=ISCanEnable;
     Editqj1.Enabled:= ISCanEnable;
     Editqj2.Enabled:= ISCanEnable;
     ComboMKy.Enabled:= ISCanEnable;
     Combozhqk.Enabled:= ISCanEnable;
     EditSpeed.Enabled:= ISCanEnable;
     SupStartNumber.Enabled:= ISCanEnable;
     SupEndNumber.Enabled:= ISCanEnable;
     ComboSupNumberDirection.Enabled:= ISCanEnable;
     cboQyzt.Enabled:= ISCanEnable;
     //
     ComboCmFa.Enabled:= ISCanEnable; //一次采全高
     ComboMKy.Enabled:= ISCanEnable;//P 1.5-2
     Combozhqk.Enabled:= ISCanEnable;//液压支架
     ComboYxFx.Enabled:= ISCanEnable;// 水平推进
     ComboJYhd.Enabled:= ISCanEnable;// 一般基岩
     ComboDzgz.Enabled:= ISCanEnable;//地质构造较少
     ComboWs.Enabled:= ISCanEnable;  //瓦斯浓度较低
     ComboTopWater.Enabled:= ISCanEnable;   //顶板无水
     ComboBottomWater.Enabled:= ISCanEnable; //底板无水
     ComboStress.Enabled:= ISCanEnable; //水平应力小于垂直应力
     ComboKsyl.Enabled:= ISCanEnable;//有矿压显现
     ComboHdzh.Enabled:= ISCanEnable;//简单锚网支护

     ComboMcId.Enabled:= ISCanEnable; //煤层编号
     ComboZJType.Enabled:= ISCanEnable; //支架型号


end;



procedure TZkGzmForm.btnBfClick(Sender: TObject);
var
   t_sql,sql:string;
   lsz,lsz1,lsz2:string;
   sltb1,sltb2: TSQLIteTable;
   lsz3:integer;
   wStr:string;
   i:integer;
   Path:string;

begin
//    //主要目的是生成文件夹
//       if not SelectDirectory('请选择数据存储目录', '',Path)  then
//          exit;
//       if trim(path) ='' then  exit;
//
//    wStr:='确定进行数据备份吗？请确认数据库中相关备份表存在！';
//
//    if MessageBox(0, Pchar(wstr),'提示',MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDNO then exit;
//    try
//    sql:='SELECT * from CreateTable where CreatLeg in (2,3) and used = 1';
//    sltb1:= uMyDataModule.Maindb.GetTable(sql);
//    while not sltb1.Eof do
//    begin
//        lsz2:=sltb1.FieldByName['CreateTableName'];
//        lsz3:=strtoint(sltb1.FieldByName['CreatLeg']);
//        if lsz3 = 2 then begin
//           lsz1:='d_'+inttostr(FinGzm.cq_id)+'_'+lsz2+'';
//           lsz:=Path+'\'+lsz1+'.txt';
//
//           if FileExists(Lsz) then  DeleteFile(lsz);
//
//           t_sql:='select * from '+lsz1+' into outfile '''+lsz+'''';
//           t_sql:=StringReplace(t_sql, '\', '/', [rfReplaceAll]);
//
//           uMyDataModule.ExCommand1.CommandText :=t_sql;
//           uMyDataModule.ExCommand1.Execute ;
//
//            t_sql:='DROP TABLE '+lsz1+'';
//            uMyDataModule.ExCommand1.CommandText :=t_sql;
//            uMyDataModule.ExCommand1.Execute ;
//
//        end else if lsz3 = 3 then begin
//           for I := FinGzm.SupStartNumber to   FinGzm.SupEndNumber  do  begin
//                 lsz1:='d_'+inttostr(FinGzm.cq_id)+'_'+IntTostr(i)+'_'+lsz2;
//                 lsz:=Path+'\'+lsz1+'.txt';
//
//                 if FileExists(Lsz) then  DeleteFile(lsz);
//
//                 t_sql:='select * from '+lsz1+' into outfile '''+lsz+'''';
//                 t_sql:=StringReplace(t_sql, '\', '/', [rfReplaceAll]);
//
//                 uMyDataModule.ExCommand1.CommandText :=t_sql;
//                 uMyDataModule.ExCommand1.Execute ;
//
//                 t_sql:='DROP TABLE '+lsz1+'';
//                 uMyDataModule.ExCommand1.CommandText :=t_sql;
//                 uMyDataModule.ExCommand1.Execute ;
//           end;
//
//
//        end;
//         sltb1.Next;
//      end;
//      showmessage('数据备份到'''+Path+''' 目录下成功！');
//    except
//       showmessage('数据备份失败！');
//       exit;
//    end;
//
//    t_sql:='update  cqcsb  set qyzt =2 where cqid='+IntToStr(FinGzm.cq_id)+'';
//    uMyDataModule.ExCommand1.CommandText :=t_sql;
//    uMyDataModule.ExCommand1.Execute ;
//    CreatTable.Enabled:=false; //2016-7-5
//    btnBf.Enabled:=false;//2016-7-5
//    btnHf.Enabled:=true;//2016-7-5
//    cboQyzt.ItemIndex:=2;
//    self.FillCell(i_kid) ;
end;

procedure TZkGzmForm.btnHfClick(Sender: TObject);
var
   t_sql,sql:string;
   lsz,lsz1,lsz2:string;
   sltb1,sltb2: TSQLIteTable;
   lsz3,i:integer;
   wStr,path:string;
begin

//      if not SelectDirectory('请选择恢复数据存储的目录', '',Path)  then
//          exit;
//       if trim(path) ='' then  exit;
//
//     wStr:='确定进行数据恢复吗？请确认恢复数据文件存在！';
//     if MessageBox(0, Pchar(wstr),'提示',MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDNO then exit;
//
//     try
//     uMyDataModule.CreateMySqlTable('2',inttostr(FinGzm.cq_id),'');
//     sql:='SELECT * from CreateTable where CreatLeg in (2,3) and used = 1';
//     sltb1:= uMyDataModule.Maindb.GetTable(sql);
//     while not sltb1.Eof do
//     begin
//        lsz2:=sltb1.FieldByName['CreateTableName'];
//        lsz3:=strtoint(sltb1.FieldByName['CreatLeg']);
//        if lsz3 = 2 then begin
//           lsz1:='d_'+inttostr(FinGzm.cq_id)+'_'+lsz2+'';
//           lsz:=Path+'\'+lsz1+'.txt';
//
//           if  FileExists(Lsz) then  begin
//                 t_sql:='load data infile '''+lsz+''' into table '+lsz1+' CHARACTER SET utf8;';
//                 uMyDataModule.ExCommand1.CommandText :=t_sql;
//                 t_sql:=StringReplace(t_sql, '\', '/', [rfReplaceAll]);
//                 uMyDataModule.ExCommand1.Execute ;
//                 DeleteFile(lsz);
//            end;
//
//        end else if lsz3 = 3 then begin
//           for I := FinGzm.SupStartNumber to   FinGzm.SupEndNumber  do  begin
//                 uMyDataModule.CreateMySqlTable('3',inttostr(FinGzm.cq_id),IntToStr(i));
//                 lsz1:='d_'+inttostr(FinGzm.cq_id)+'_'+IntTostr(i)+'_'+lsz2;
//                 lsz:=Path+'\'+lsz1+'.txt';
//
//                 if  FileExists(Lsz) then  begin
//                      t_sql:='load data infile '''+lsz+''' into table '+lsz1+' CHARACTER SET utf8;';
//                     uMyDataModule.ExCommand1.CommandText :=t_sql;
//                     t_sql:=StringReplace(t_sql, '\', '/', [rfReplaceAll]);
//                     uMyDataModule.ExCommand1.Execute ;
//                     DeleteFile(lsz);
//                 end;
//           end;
//
//
//        end;
//
//         sltb1.Next;
//    end;
//        showmessage('数据恢复成功！');
//    except
//         showmessage('数据恢复失败！');
//         exit;
//    end;
//
//    t_sql:='update  cqcsb  set qyzt = 1 where cqid='+IntToStr(FinGzm.cq_id)+'';
//    uMyDataModule.ExCommand1.CommandText :=t_sql;
//    uMyDataModule.ExCommand1.Execute ;
//
//    CreatTable.Enabled:=false; //2016-7-5
//    btnBf.Enabled:=true;//2016-7-5
//    btnHf.Enabled:=false;//2016-7-5
//    cboQyzt.ItemIndex:=1;
//    self.FillCell(i_kid) ;
end;

procedure TZkGzmForm.Button1Click(Sender: TObject);
var
  SDisp:String;
begin
    MainDataModule.UseFormName :='Gzm';
    SDisp:='【'+ComboKName.Text+'】增添新的煤层';
    CreateFormMC(Handle,SDisp,Self.ComboKName.Text,i_kid);
end;






procedure TZkGzmForm.But_EditFileNameClick(Sender: TObject);
begin
 {
   ExHandle:= AHandle;
               EX_width:=wid;
               Ex_Height:=hi;
 }
  CreateWorkFaceFileName(ExHandle,'矿压报告地质表格补录界面',EX_width,Ex_Height);
  FormFileEdit.SetWorkFaceInfo(FinGzm.Gzmbh,FinGzm.S_Name) ;

end;

procedure TZkGzmForm.CboCsh(ISCom: bool);
begin
   if ISCom = true then begin
      ComboMcId.ItemIndex := -1;
      ComboCmFa.ItemIndex := -1;
      ComboMKy.ItemIndex := -1;
      Combozhqk.ItemIndex := -1;
      ComboZJType.ItemIndex := -1;
      ComboYxFx.ItemIndex := -1;
      ComboJYhd.ItemIndex := -1;
      ComboDzgz.ItemIndex := -1;
      ComboWs.ItemIndex := -1;
      ComboTopWater.ItemIndex := -1;
      ComboBottomWater.ItemIndex := -1;
      ComboStress.ItemIndex := -1;
      ComboKsyl.ItemIndex := -1;
      ComboHdzh.ItemIndex := -1;
      ComboSupNumberDirection.ItemIndex := -1;
      cboQyzt.ItemIndex := -1;
   end;
   if ISCom = false then  begin
      ComboMcId.ItemIndex := 0;
      ComboCmFa.ItemIndex := 0;
      ComboMKy.ItemIndex := 0;
      Combozhqk.ItemIndex := 0;
      ComboZJType.ItemIndex := 0;
      ComboYxFx.ItemIndex := 0;
      ComboJYhd.ItemIndex := 0;
      ComboDzgz.ItemIndex := 0;
      ComboWs.ItemIndex := 0;
      ComboTopWater.ItemIndex := 0;
      ComboBottomWater.ItemIndex := 0;
      ComboStress.ItemIndex := 0;
      ComboKsyl.ItemIndex := 0;
      ComboHdzh.ItemIndex := 0;
      ComboSupNumberDirection.ItemIndex := 0;
      cboQyzt.ItemIndex := 0;
   end;


end;

function TZkGzmForm.checkInputEdit:wordbool; //检查录入格式是否合格
var
  s_temp:Str_DT_array;
  C1:integer;
 begin
     Result:=false;
//

     if Trim(self.EditCqName.Text)=''   then   begin   //1:判断采区编号
         messagebox(self.Handle,'请检查采区名称！','系统提示',mb_iconerror+mb_ok);
         exit;
      end else begin
         FinGzm.S_Name:=self.EditCqName.Text;
      end;
     if Trim(self.ComboMcId.Text )=''   then   begin   //2:判断煤层编号
         messagebox(self.Handle,' 请检查煤层编号！ ','系统提示',mb_iconerror+mb_ok);
         exit;
      end else begin
         s_temp:=Public_Basic.split(ComboMcId.Text,'_',C1);
         if C1>1 then  FinGzm.S_mc_name:=s_temp[0];
      end;

    if Trim(self.EditMcHd.Text )=''   then   begin   //3:判断煤层煤层厚度
         messagebox(self.Handle,'请检查煤层厚度！  ','系统提示',mb_iconerror+mb_ok);
         exit;
     end else begin
         FinGzm.S_Agv_mch:=Public_Basic.StrToDouble_lu(self.EditMcHd.Text);
     end;

     if Trim(self.EditzKcgd.Text )=''   then   begin   //4:判断开采高度
         messagebox(self.Handle,'请检查开采高度！  ','系统提示',mb_iconerror+mb_ok);
         exit;
     end else begin
         FinGzm.S_Cg_h:=Public_Basic.StrToDouble_lu(self.EditzKcgd.text);
     end;
     //判断开采高度之间的逻辑关系
      if FinGzm.S_Cg_h > FinGzm.S_Agv_mch +2 then  begin
         if Application.MessageBox(Pwidechar('你确认开采高度与煤层厚度的数值么？'), '友情提示', MB_YESNO + MB_DEFBUTTON1
                       + MB_ICONQUESTION) = IDNO then   begin
            self.EditSh1.SetFocus;
            exit;
         end;
      end;

    if Trim(self.ComboCmFa.Text )=''   then   begin   //5:判断采煤方法
         messagebox(self.Handle,'请检查采煤方法！  ','系统提示',mb_iconerror+mb_ok);
         exit;
     end else begin
        FinGzm.S_CMFS_INteger :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboCmFa.Text),1));
     end;

     if Trim(self.EditSh1.text )=''   then   begin   //6:判断上边界采深
         messagebox(self.Handle,'请检查上边界采深！','系统提示',mb_iconerror+mb_ok);
         exit;
     end else begin
         FinGzm.S_Sh_UP:=Public_Basic.StrToDouble_lu(self.Editsh1.Text);
     end;

     if Trim(self.EditSh2.text )=''   then   begin   //7:判断下边界采深
         messagebox(self.Handle,'请检查下边界采深！ ','系统提示',mb_iconerror+mb_ok);
         exit;
     end else begin
         FinGzm.S_Sh_Down:=Public_Basic.StrToDouble_lu(self.Editsh2.Text);
     end;

      if Trim(self.EditGc.text )=''   then   begin   //8:判断平均采深
         messagebox(self.Handle,'请检查平均采深！ ','系统提示',mb_iconerror+mb_ok);
         exit;
     end else begin
         FinGzm.S_mcsd_h:=Public_Basic.StrToDouble_lu(self.EditGc.Text);
     end;
        //判断采深之间的逻辑关系
      if FinGzm.S_mcsd_h < FinGzm.S_Sh_UP then  begin
         if Application.MessageBox(Pwidechar('上界采深大于平均采深？'), '友情提示', MB_YESNO + MB_DEFBUTTON1
                       + MB_ICONQUESTION) = IDNO then   begin
            self.EditSh1.SetFocus;
            exit;
         end;

      end;
      if FinGzm.S_mcsd_h > FinGzm.S_Sh_Down then  begin
         if Application.MessageBox(Pwidechar('下界采深小于平均采深？'), '友情提示', MB_YESNO + MB_DEFBUTTON1
                       + MB_ICONQUESTION) = IDNO then   begin
            self.EditSh1.SetFocus;
            exit;
         end;

      end;

     if Trim(self.EditZxc.text )=''   then   begin   //9:判断走向长
          messagebox(self.Handle,'请检查走向长！','系统提示',mb_iconerror+mb_ok);
         exit;
     end else begin
         FinGzm.S_Sx_zx :=Public_Basic.StrToDouble_lu(self.EditZxc.Text);
     end;

     if Trim(self.EditQxc.text )=''   then   begin   //10:判断倾向长
          messagebox(self.Handle,'请检查倾向长！ ','系统提示',mb_iconerror+mb_ok);
          exit;
     end else begin
         FinGzm.S_L_qx:=Public_Basic.StrToDouble_lu(self.EditQxc.Text);
     end;

     if FinGzm.S_Sx_zx < FinGzm.S_L_qx then  begin
         if Application.MessageBox(Pwidechar('你确认工作面走向与倾向数据么？'), '友情提示', MB_YESNO + MB_DEFBUTTON1
                       + MB_ICONQUESTION) = IDNO then   begin
            self.EditSh1.SetFocus;
            exit;
         end;

     end;

     if Trim(self.Editqj2.text )=''   then   begin   //11:判断走向倾角
          messagebox(self.Handle,'请检查走向倾角！ ','系统提示',mb_iconerror+mb_ok);
          exit;
     end else begin
         FinGzm.S_SX_qj  :=Public_Basic.StrToDouble_lu(self.Editqj2.Text);
     end;

     if FinGzm.S_SX_qj > 45  then  begin
         if Application.MessageBox(Pwidechar('你确认工作面走向倾角么？'), '友情提示', MB_YESNO + MB_DEFBUTTON1
                       + MB_ICONQUESTION) = IDNO then   begin
            self.EditSh1.SetFocus;
            exit;
         end;

     end;


     if Trim(self.Editqj1 .text )=''   then   begin   //12:判断倾向倾角
          messagebox(self.Handle,'请检查倾向倾角！ ','系统提示',mb_iconerror+mb_ok);
          exit;
     end else begin
         FinGzm.S_qj:=Public_Basic.StrToDouble_lu(self.Editqj1.text);
     end;

     if FinGzm.S_SX_qj > 30  then  begin
         if Application.MessageBox(Pwidechar('你确认工作面倾向倾角么？'), '友情提示', MB_YESNO + MB_DEFBUTTON1
                       + MB_ICONQUESTION) = IDNO then   begin
            self.EditSh1.SetFocus;
            exit;
         end;

     end;


     if Trim(self.EditSpeed.text )=''   then   begin   //13:判断推进速度
          messagebox(self.Handle,' 请检查推进速度！','系统提示',mb_iconerror+mb_ok);
          exit;
     end else begin
         FinGzm.S_DayStep_speed:=Public_Basic.StrToDouble_lu(self.EditSpeed.text);
     end;

      if FinGzm.S_DayStep_speed > 30  then  begin
         if Application.MessageBox(Pwidechar('你确认工作面每天的推进速度么？'), '友情提示', MB_YESNO + MB_DEFBUTTON1
                       + MB_ICONQUESTION) = IDNO then   begin
            self.EditSh1.SetFocus;
            exit;
         end;

     end;


     FinGzm.KuangJingId :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboKName.Text),1));  // 17:矿区编号

     FinGzm.S_Mtyd :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboMKy.text),1));  // 18:煤体硬度
     FinGzm.DZ_Zhqk :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.Combozhqk.Text),1));  // 19:支护情况

         if FinGzm.DZ_Zhqk=1 then begin
               FinGzm.SupportName :='单体支架';
         end else begin
               FinGzm.SupportName :=Trim(self.ComboZJType.text);  // 20:支架型号
         end;



       FinGzm.Dz_yxfx  :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboYxFx.Text),1));  // 21:仰斜倾斜

       FinGzm.Dz_JYHD :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboJYhd.Text),1));  // 22: 基岩厚度
       FinGzm.Dz_DCGZ:=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboDzgz.Text),1));  // 23:地质构造

       FinGzm.Dz_WSFC :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboWs.Text),1));  // 24: 瓦斯赋存
       FinGzm.Dz_TopWater  :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboTopWater.Text),1));  // 25:顶板水源

       FinGzm.Dz_BottomWater  :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboBottomWater.Text),1));  // 26:  底板水源
       FinGzm.Dz_HeoStress  :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboStress.Text),1));  // 27:水平应力

       FinGzm.Dz_Kyxx:=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboKsyl.Text),1));  // 28:矿压显现
       FinGzm.Dz_HangDaoSup  :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboHdzh.Text),1));  // 29: 巷道支护

    //
   if  (self.FcRadioButton.ItemIndex=0) then   begin
       kczt:=1;
       if (self.EditJueJin.Text='')  then begin
          messagebox(self.Handle,'请填入累计进尺！ ','系统提示',mb_iconerror+mb_ok);
          exit ;
       end else begin
          kccd:=Public_Basic.StrToInt_lu(EditJueJin.Text);
       end;

   end  else begin
       kczt:=0; kccd:=0;
   end;

  if Trunc(StrTofloat(trim(self.EditSh1.Text)))<100 then
      if Application.MessageBox(Pwidechar('上界采深小于100m是否确定录入？'), '提示', MB_YESNO + MB_DEFBUTTON1
                       + MB_ICONQUESTION) = IDNO then   begin
           self.EditSh1.SetFocus;
           exit;
      end else begin
          FinGzm.S_Sh_UP:= Public_Basic.StrToDouble_lu(self.EditSh1.Text);
      end;

  if Trunc(StrTofloat(trim(self.EditSh2.Text)))<100 then
           if Application.MessageBox(Pwidechar('下界采深小于100m是否确定录入？'), '提示', MB_YESNO + MB_DEFBUTTON1
                           + MB_ICONQUESTION) = IDNO then   begin
               self.EditSh2.SetFocus;
               exit;
            end else begin
               FinGzm.S_Sh_Down:= Public_Basic.StrToDouble_lu(self.EditSh2.Text);
            end;

  if Trunc(StrTofloat(trim(self.EditGc.Text)))<100 then
      if Application.MessageBox(Pwidechar('平均采深小于100m是否确定录入？'), '提示', MB_YESNO + MB_DEFBUTTON1
                      + MB_ICONQUESTION) = IDNO then  begin
           self.EditGc.SetFocus;
           exit;
      end else begin
           FinGzm.S_mcsd_h:= Public_Basic.StrToDouble_lu(self.EditGc.Text);
      end;


  if Trunc(StrTofloat(trim(self.Editzxc.Text)))<100 then
     if Application.MessageBox(Pwidechar('走向长度小于100m是否确定录入？'), '提示', MB_YESNO + MB_DEFBUTTON1
                      + MB_ICONQUESTION) = IDNO then  begin
           self.Editzxc.SetFocus;
           exit;
      end else begin
           FinGzm.S_Sx_zx:= Public_Basic.StrToDouble_lu(self.Editzxc.Text);
      end;


    //

      if self.SupStartNumber.Text=''    then  begin
         messagebox(self.Handle,'请输入支架开始编号 ！ ','系统提示',mb_iconerror+mb_ok);
         exit;
       end else begin
           FinGzm.SupStartNumber :=Public_Basic.StrToInt_lu(self.SupStartNumber.Text);  //30：开始编号
       end;

      if self.SupEndNumber.Text='' then   begin
         messagebox(self.Handle,'请输入支架终止编号 ！ ','系统提示',mb_iconerror+mb_ok);
         exit;
       end else begin
          FinGzm.SupEndNumber := Public_Basic.StrToInt_lu(self.SupEndNumber.Text);    //31;结束编号
       end;

       if self.ComboSupNumberDirection.Text='' then    begin
         messagebox(self.Handle,'请选择支架开始走向 ！ ','系统提示',mb_iconerror+mb_ok);
         exit;
       end else begin
         FinGzm.SupNumberDirection :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboSupNumberDirection.Text),1));
       end;


       if self.cboQyzt.Text='' then   begin
         messagebox(self.Handle,'请选择工作面状态 ！ ','系统提示',mb_iconerror+mb_ok);
         exit;
       end else begin
         FinGzm.used :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.cboQyzt.Text),1))-1;
       end;


     Result:=true;

 end;
procedure TZkGzmForm.FormActivate(Sender: TObject);
begin
   PubLic_Basic.InitStatusBar(self.StatusBar1);
   
end;

procedure TZkGzmForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    FinGzm.Free ;

end;

procedure TZkGzmForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if Assigned(innGzmForm) then FreeAndNil(innGzmForm);
end;

procedure TZkGzmForm.FormCreate(Sender: TObject);
begin
    MySqlDataSet1:=TMyDataSet.Create(nil);
    MySqlDataSet1.MySqlConnection :=MainDataModule.ExConn;
    MySqlDataSet2:=TMyDataSet.Create(nil);
    MySqlDataSet2.MySqlConnection :=MainDataModule.ExConn;
    MyCommand1:=TMyCommand.Create (nil);
    MyCommand1.MySqlConnection :=MainDataModule.ExConn;

    FinGzm:=TGzm.Create(MainDataModule.ExConn);

    ClearEdit ;
    SetCellHead;
    SetEnable(false);
    ComboCmFa.Enabled :=TRUE;
    self.ComboKName.Enabled:=true;

    self.CkCkq.Enabled:=false;//2016-6-12
    self.CkDc.Enabled:=false;//2016-6-12
    self.CkMz.Enabled:=false;//2016-6-12

    CreatTable.Enabled:=false; //2016-7-4
    btnBf.Enabled:=false;//2016-7-4
    btnHf.Enabled:=false;//2016-7-4
end;
procedure TZkGzmForm.FormDestroy(Sender: TObject);
begin
    FreeAndNil(MySqlDataSet1);
    FreeAndNil(MySqlDataSet2);
    FreeAndNil(MyCommand1);
    if Assigned(FinGzm) then FreeAndNil(FinGzm);

    //
    if Assigned(EXUsedCqk) then  FreeAndNil(EXUsedCqk);
    if Assigned(ExUsedMz) then  FreeAndNil(ExUsedMz);
    if Assigned(ExUsedDc) then  FreeAndNil(ExUsedDc);
end;

procedure TZkGzmForm.FormShow(Sender: TObject);
begin
  IniForm ;
  FillCell(0);
end;

procedure TZkGzmForm.AddButtonClick(Sender: TObject);
begin

    self.EditCqName.Enabled:=true;
    SetEnable(true);
    FinGzm.Gzmbh :=0;

    //控制按钮
    self.SaveButton.Enabled :=true;
    self.EditButton.Enabled :=false;

    Save_Lx:='Insert';
    self.ClearEdit;


    self.CkCkq.Enabled:=false; //2016-6-12
    self.CkDc.Enabled:=false;//2016-6-12
    self.CkMz.Enabled:=false;//2016-6-12
   // self.ComboZJType.Enabled:=true;//2016-6-15
    cboQyzt.Enabled :=false;   //2016-6-28
    CreatTable.Enabled:=false; //2016-7-4
    btnBf.Enabled:=false;//2016-7-4
    btnHf.Enabled:=false;//2016-7-4
    But_EditFileName.Enabled :=False;

    OptionTip('正在进行【添加】操作!');
end;

procedure TZkGzmForm.ComboCmFaChange(Sender: TObject);
begin
   if (self.ComboCmFa.ItemIndex=0 )or (self.ComboCmFa.ItemIndex=1 )then  begin
      self.Combozhqk.ItemIndex:=0;
   end else begin
      self.Combozhqk.ItemIndex:=1;
   end;

end;

procedure TZkGzmForm.ComboKNameChange(Sender: TObject);
var
   s_temp:Str_DT_array;
  C1:integer;
  C1LS:integer;
begin
    s_temp:=Public_Basic.split(self.ComboKName.Text,'_',C1);
    if s_temp[0]='' then exit;
    i_kid:=strToInt(s_temp[0]);
       ComboMcId.Items.Clear;

    Fill_MCBh_Combo;
    FillCell(i_kid) ;
end;




procedure TZkGzmForm.ComboMcIdClick(Sender: TObject);
begin
    ComboMcId.SetFocus;
end;

procedure TZkGzmForm.CombozhqkChange(Sender: TObject);
begin
    if Public_Basic.StrToInt_lu(LeftStr(Trim(self.Combozhqk.Text),1)) =1 then  begin
       self.ComboZJType.Enabled:=false;
    end else begin
       self.ComboZJType.Enabled:=true;
    end;   
end;

procedure TZkGzmForm.ComboZkChange(Sender: TObject);
var
  C1LS:integer;
  mcId:string;
  mcName:string;
  str_sql:String;
begin



end;

procedure TZkGzmForm.CreatTableClick(Sender: TObject);
var
  t_sql,wStr:String;
  TableName:String;
  FalOrTrue:boolean;
  i:integer;
begin
      //  查找数据库是否存在数据表
        FalOrTrue:=False;
        MySqlDataSet1.Close ;
        MySqlDataSet1. CommandText:='SELECT  TABLE_NAME FROM INFORMATION_SCHEMA.TABLES ';
        MySqlDataSet1.Open ;
       while not MySqlDataSet1.eof    do  begin
          TableName:=MySqlDataSet1.FieldByName('TABLE_NAME').AsString;
          if UpperCase(Trim(TableName))=UpperCase('D_'+inttostr(FinGzm.Gzmbh)+'_BasicData') then  begin
             FalOrTrue:=true;
             break;
          end;
          MySqlDataSet1.Next ;
       end;
       MySqlDataSet1.Close ;
        if FalOrTrue then  begin
           wStr:='工作面的数据表已经存在！需要重复创建么？';
           if MessageBox(0, Pwidechar(wstr),'提示',MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDNO then exit;
        end;

       if MainDataModule.CreateMySqlTable('2',inttostr(FinGzm.Gzmbh),'') then begin
                messagebox(self.Handle,'相关数据表创建成功！','系统提示',mb_iconerror+mb_ok);
       end else begin
                messagebox(self.Handle,'相关数据表创建失败！','系统提示',mb_iconerror+mb_ok);
                exit;
       end;

         for I := FinGzm.SupStartNumber to FinGzm.SupEndNumber do
           if (MainDataModule.GetExDataType= 'SQLSERVER') or(MainDataModule.GetExDataType= 'SQL SERVER') then  begin
               MainDataModule.CreateSerVerTable('3',inttostr(FinGzm.Gzmbh),intToStr(i));
           end else if (MainDataModule.GetExDataType= 'MYSQL') or (MainDataModule.GetExDataType= 'MY SQL') then  begin
               MainDataModule.CreateMySqlTable('3',inttostr(FinGzm.Gzmbh),intToStr(i));
           end;


      t_sql:='update  cqcsb  set qyzt =1 where cqid='+IntToStr(FinGzm.Gzmbh)+'';
      MyCommand1.CommandText :=t_sql;
      MyCommand1.Execute ;

      CreatTable.Enabled:=false; //2016-7-5
      btnBf.Enabled:=true;//2016-7-5
      btnHf.Enabled:=false;//2016-7-5
      cboQyzt.ItemIndex:=1;
      self.FillCell(i_kid) ;
end;

procedure TZkGzmForm.DeleteButtonClick(Sender: TObject);
 Var
   t_s:String;
   t_sql,t_sql1:String;

   sql:string;
   lsz,lsz1,lsz2:string;
   sltb1,sltb2: TSQLIteTable;
   lsz3:integer;

begin
    t_s:='你确定要删除【'+self.EditCqName.Text+'】的数据么?';
    if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;
    if FinGzm.Gzmbh  <1 then  exit;
    MyCommand1.MySqlConnection.BeginTrans ;
  try
    try
      t_sql:='delete from  cqcsb  where cqid='+IntToStr(FinGzm.Gzmbh);
      MyCommand1.CommandText :=t_sql;
      MyCommand1.Execute(MainDataModule.ExUserName)  ;

      t_sql1:= 'delete from ckq_mineoutarea where gzmid = '+inttostr(FinGzm.Gzmbh)+'';
      MyCommand1.CommandText :=t_sql1;
      MyCommand1.Execute ;

      t_sql1:= 'delete from dc_fault where gzmid = '+inttostr(FinGzm.Gzmbh)+'';
      MyCommand1.CommandText :=t_sql1;
      MyCommand1.Execute ;

      t_sql1:= 'delete from mz_coalpillar where gzmid = '+inttostr(FinGzm.Gzmbh)+'';
      MyCommand1.CommandText :=t_sql1;
      MyCommand1.Execute ;
      //
       sql:='SELECT * from CreateTable where CreatLeg in (2,3) and used = 1';
       sltb1:= MainDataModule.Maindb.GetTable(sql);
        while not sltb1.Eof do    begin
            lsz2:=sltb1.FieldByName['CreateTableName'];
            lsz3:=strtoint(sltb1.FieldByName['CreatLeg']);
            if lsz3 = 2 then begin
               lsz:='c:/basicdata/d_'+inttostr(FinGzm.Gzmbh)+'_'+lsz2+'.txt';
               lsz1:='d_'+inttostr(FinGzm.Gzmbh)+'_'+lsz2+'';
            end else begin
               lsz:='c:/basicdata/d_'+inttostr(FinGzm.Gzmbh)+'_'+lsz2+'.txt';
               lsz1:='d_'+inttostr(FinGzm.Gzmbh)+'_'+lsz2+'';
            end;

            if  DeleteFile(lsz) = false then begin
                MainDataModule.DropIsExsitTable(lsz1) ;

            end;
            sltb1.Next;
        end;
    finally
      MyCommand1.MySqlConnection.CommitTrans;
      OptionTip('数据删除成功!');
    end;
  except
       MyCommand1.MySqlConnection.RollbackTrans ;
       OptionTip('数据操作有误!');
       exit;
  end;
      //////////////


    //填充Cell
    self.FillCell(i_kid) ;
    //控制按钮
    self.DeleteButton.Enabled :=false;
    self.AddButton.Enabled :=true;
    self.EditButton.Enabled:=false;//2016-6-15
    self.SaveButton.Enabled:=false;//2016-6-15
    // 控制录入框
    self.EditCqName.Text:='';
    self.EditCqName.Enabled:=false;
    FinGzm.Gzmbh:=0;

   

end;

procedure TZkGzmForm.EditButtonClick(Sender: TObject);
begin
   //控制按钮
   self.EditButton.Enabled :=false;
   self.SaveButton.Enabled :=true;
   self.AddButton.Enabled:=false;
   SetEnable(true);
   //控制录入框     
   Save_Lx:='Update'; //  保存时，操作类型，新增、修改   修改
    OptionTip('正在进行【修改】操作!');
end;

procedure TZkGzmForm.EditCqNameClick(Sender: TObject);
begin
    EditCqName.SetFocus;
end;

procedure TZkGzmForm.EditDownMzKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.EditGcClick(Sender: TObject);
begin
       EditGc.SetFocus ;
end;

procedure TZkGzmForm.EditGcKeyPress(Sender: TObject; var Key: Char);
begin
      if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.EditJueJinClick(Sender: TObject);
begin
      EditJueJin.SetFocus ;
end;

procedure TZkGzmForm.EditJueJinKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9','.',#8]) then begin
    key:=#0;
    exit;
  end else begin
    if Public_Basic.StrtoDouble_lu(self.EditJueJin.Text+key) >
             Public_Basic.StrtoDouble_lu(self.EditZxc.Text) then   begin
      messagebox(self.Handle,'累计进尺大于推进长度！','系统提示',mb_iconerror+mb_ok);
      key:=#0;
      exit;
    end;
  end;

end;

procedure TZkGzmForm.EditMcHdClick(Sender: TObject);
begin
     EditMcHd.SetFocus;
end;

procedure TZkGzmForm.EditMcHdKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.Editqj1Click(Sender: TObject);
begin
    Editqj1.SetFocus;
end;

procedure TZkGzmForm.Editqj1KeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.Editqj2Click(Sender: TObject);
begin
       Editqj2.SetFocus;
end;

procedure TZkGzmForm.Editqj2KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.EditQxcClick(Sender: TObject);
begin
    EditQxc.SetFocus;
end;

procedure TZkGzmForm.EditQxcKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.EditSh1Click(Sender: TObject);
begin
      EditSh1.SetFocus ;
end;

procedure TZkGzmForm.EditSh1KeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9','.',#8]) then key:=#0 
end;

procedure TZkGzmForm.EditSh1MouseEnter(Sender: TObject);
begin
//
end;

procedure TZkGzmForm.Editsh2Click(Sender: TObject);
begin
         Editsh2.SetFocus ;
end;

procedure TZkGzmForm.Editsh2KeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.EditSpeedClick(Sender: TObject);
begin
        EditSpeed.SetFocus;
end;

procedure TZkGzmForm.EditSpeedKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.EditUPMzKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.EditzKcgdClick(Sender: TObject);
begin
    EditZkcgd.SetFocus ;
end;

procedure TZkGzmForm.EditzKcgdKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.EditZxcClick(Sender: TObject);
begin
          EditZxc.SetFocus ;
end;

procedure TZkGzmForm.EditZxcKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9','.',#8]) then key:=#0
end;



procedure TZkGzmForm.ExitButtonClick(Sender: TObject);
begin
  self.Close ;

end;
procedure TZkGzmForm.SaveButtonClick(Sender: TObject);
 var
  t_sql:String;
  Sfkc:string;//是否开采
  TempGzmid:integer;
  lsz,lsz1,lsz2:string;

begin
   //录入数据检查
   if self.checkInputEdit=false  then   exit;

   if Save_Lx='Insert'  then   begin
      t_sql:='insert into cqcsb (kid,cqname,mcid,sh1,sh2,gc,zxc,qxc,zxqj,qxqj,mch,kch,cmfa,mtyd,speed,yxfx,zjxh,dcgz,jyhd,zhqk,wsfc,' +
              ' topwater,bottomwater,heostress,kyxx,hangdaosup,kuangjingbianhao,' +
              ' kczt,kccd,SupStartNumber,SupEndNumber,SupNumberDirection,qyzt)' +
              ' values ('+IntToStr(FinGzm.KuangJingId)+ ',''' + FinGzm.S_Name+ ''',' +
               FinGzm.S_mc_name+ ','+FloatToStr(FinGzm.S_Sh_UP)+ ','+FloatToStr(FinGzm.S_Sh_Down )+
              ','+FloatToStr(FinGzm.S_mcsd_h )+ ','+ FloatToStr(FinGzm.S_Sx_zx )+ ','+FloatToStr(FinGzm.S_L_qx )+
              ','+FloatToStr(FinGzm.S_SX_qj )+ ','+ FloatToStr(FinGzm.S_qj )+ ','+FloatToStr(FinGzm.S_Agv_mch  )+
              ','+FloatToStr(FinGzm.S_Cg_h  )+ ','+ IntToStr(FinGzm.S_CMFS_Integer )+','+IntToStr(FinGzm.S_Mtyd   )+
              ','+FloatToStr(FinGzm.S_DayStep_speed )+ ','+ IntToStr(FinGzm.Dz_yxfx  )+ ','''+FinGzm.SupportName +''','+
                  IntToStr(FinGzm.Dz_DCGZ)+ ','+ IntToStr(FinGzm.Dz_JYHD)+ ','+IntToStr(FinGzm.DZ_Zhqk)+
              ','+IntToStr(FinGzm.Dz_WSFC)+ ','+ IntToStr(FinGzm.Dz_TopWater)+ ','+IntToStr(FinGzm.Dz_BottomWater)+
              ','+IntToStr(FinGzm.Dz_HeoStress)+ ','+ IntToStr(FinGzm.Dz_Kyxx)+ ','+IntToStr(FinGzm.Dz_HangDaoSup)+
              ','+inttoStr(i_kid)+','+intToStr(kczt)+','+IntToStr(kccd) +',' + IntToStr(FinGzm.SupStartNumber)+','+
              IntToStr(FinGzm.SupEndNumber)+','+IntToStr(FinGzm.SupNumberDirection)+','+IntToStr(FinGzm.used)+')';
   end else if Save_Lx='Update' then    begin
       t_sql:='update  cqcsb  set kid = '+IntToStr(FinGzm.KuangJingId)+ ',cqname=''' + FinGzm.S_Name+
             ''',mcid=' +  FinGzm.S_mc_name+ ', sh1=' + FloatToStr(FinGzm.S_Sh_UP)+
             ',sh2='+FloatToStr(FinGzm.S_Sh_Down )+ ', gc=' +FloatToStr(FinGzm.S_mcsd_h )+
             ',zxc='+FloatToStr(FinGzm.S_Sx_zx )+ ',qxc='+ FloatToStr(FinGzm.S_L_qx )+
             ',zxqj='+FloatToStr(FinGzm.S_SX_qj )+',qxqj=' + FloatToStr(FinGzm.S_qj )+
             ',mch=' +FloatToStr(FinGzm.S_Agv_mch  )+',kch='+ FloatToStr(FinGzm.S_Cg_h  )+
             ',cmfa='+ IntToStr(FinGzm.S_CMFS_Integer)+',mtyd='+IntToStr(FinGzm.S_Mtyd   )+
             ',speed='+ FloatToStr(FinGzm.S_DayStep_speed )+',yxfx='+IntToStr(FinGzm.Dz_yxfx   )+
             ',zjxh='''+ FinGzm.SupportName+''',dcgz='+IntToStr(FinGzm.Dz_DCGZ )+
             ',jyhd='+ IntToStr(FinGzm.Dz_JYHD  )+',zhqk='+IntToStr(FinGzm.DZ_Zhqk    )+
             ',wsfc='+ IntToStr(FinGzm.Dz_WSFC)+',topwater='+IntToStr(FinGzm.Dz_TopWater )+
             ',bottomwater='+ IntToStr(FinGzm.Dz_BottomWater )+',heostress='+IntToStr(FinGzm.Dz_HeoStress)+
             ',kyxx='+ IntToStr(FinGzm.Dz_Kyxx  )+',hangdaosup='+IntToStr(FinGzm.Dz_HangDaoSup )+
             ',kczt='+inttostr(kczt)+',kccd='+IntToStr(kccd)+',SupStartNumber = '+IntToStr(FinGzm.SupStartNumber)+' '
            +',SupEndNumber = '+IntToStr(FinGzm.SupEndNumber)+',SupNumberDirection = '+IntToStr(FinGzm.SupNumberDirection)+
            ' where cqid='+IntToStr(FinGzm.Gzmbh);
   end ;

   try
      MyCommand1.CommandText :=t_sql;
      MyCommand1.Execute(MainDataModule.ExUserName)  ;
      //
      SaveSupportInfo(FinGzm.SupportName);

   except
      OptionTip('请仔细检查数据!');
      exit;
   end;
    SetEnable(false);
    self.FillCell(i_kid) ;
    //控制按钮
    self.SaveButton.Enabled :=false;
    self.AddButton.Enabled :=true;
    self.EditCqName.Enabled:=false;
    self.DeleteButton.Enabled:=false;
    //提示信息
     OptionTip('数据存储成功!');

     FinGzm.Gzmbh  :=0;
     Save_Lx:=''; //

     CreatTable.Enabled:=false; //2016-7-5
     btnBf.Enabled:=false;//2016-7-5
     btnHf.Enabled:=false;//2016-7-5


end;

procedure TZkGzmForm.SaveSupportInfo(SupportName: String);

begin
     try
        FinGzm.BuilledSupportNumber:=1;

        Setlength(FinGzm.BuilledSupportType,1);
        FinGzm.BuilledSupportType[0]:=TWorkFaceBuillSupport.Create;
        FinGzm.BuilledSupportType[0].Supportid:=FinGzm.isExistSupportName (SupportName);
        if FinGzm.BuilledSupportType[0].Supportid< 0 then  exit;
        FinGzm.BuilledSupportType[0].startsupportNo := FinGzm.SupStartNumber ;
        FinGzm.BuilledSupportType[0].endsupportNo :=FinGzm.SupEndNumber;

      FinGzm.InsertWorkfaceSelectSupportDataBase(FinGzm.Gzmbh );
     finally
        FreeAndNil(FinGzm.BuilledSupportType[0]);
        FinGzm.BuilledSupportNumber:=1;
     end;

end;

procedure TZkGzmForm.SetCellHead;
 var
   i,j :integer;
 begin
     for i := 1 to  StringGrid1.RowCount - 1 do
          StringGrid1.Rows[i].Clear ;
    //字体 字号
     StringGrid1.Canvas.Font.Size :=8;

     self.StringGrid1.ColCount :=40;
     self.StringGrid1.RowCount :=20;
     self.StringGrid1.Cells [1,0]:='工作面编号';
     self.StringGrid1.Cells [2,0]:='矿区编号';
     self.StringGrid1.Cells [3,0]:='工作面名';
     self.StringGrid1.Cells [4,0]:='煤层编号';
     self.StringGrid1.Cells [5,0]:='上界深度';
     self.StringGrid1.Cells [6,0]:='下界深度';
     self.StringGrid1.Cells [7,0]:='平均深度';
     self.StringGrid1.Cells [8,0]:='走向长度';
     self.StringGrid1.Cells [9,0]:='倾向长度';
     self.StringGrid1.Cells [10,0]:='走向倾角';

     self.StringGrid1.Cells [11,0]:='倾向倾角';
     self.StringGrid1.Cells [12,0]:='煤层均厚';
     self.StringGrid1.Cells [13,0]:='开采高度';
     self.StringGrid1.Cells [14,0]:='采煤方法';
     self.StringGrid1.Cells [15,0]:='煤体硬度';
     self.StringGrid1.Cells [16,0]:='推进速度';
     self.StringGrid1.Cells [17,0]:='仰斜俯些';
     self.StringGrid1.Cells [18,0]:='支架型号';
     self.StringGrid1.Cells [19,0]:='构造情况';
     self.StringGrid1.Cells [20,0]:='基岩厚度';

     self.StringGrid1.Cells [21,0]:='支护情况';
     self.StringGrid1.Cells [22,0]:='瓦斯赋存';
     self.StringGrid1.Cells [23,0]:='顶板水源';
     self.StringGrid1.Cells [24,0]:='底板水源';
     self.StringGrid1.Cells [25,0]:='水平应力';
     self.StringGrid1.Cells [26,0]:='矿压显现';
     self.StringGrid1.Cells [27,0]:='巷道支护';
     self.StringGrid1.Cells [28,0]:='上边界煤柱';
     self.StringGrid1.Cells [29,0]:='上边界采空';
     self.StringGrid1.Cells [30,0]:='下边界煤柱';
     self.StringGrid1.Cells [31,0]:='下边界采空';
     self.StringGrid1.Cells [32,0]:='开采状态';
     self.StringGrid1.Cells [33,0]:='开采长度';

     self.StringGrid1.Cells [34,0]:='支架开始编号';
     self.StringGrid1.Cells [35,0]:='支架结束编号';
     self.StringGrid1.Cells [36,0]:='支架走向';
     self.StringGrid1.Cells [37,0]:='工作面状态';
     self.StringGrid1.Cells [38,0]:='集团公司编号';


      self.StringGrid1.ColWidths[0]:=10;
      for I := 1 to StringGrid1.ColCount-1 do
         self.StringGrid1.ColWidths[i]:=60;

       self.StringGrid1.ColWidths[3]:=80;

 end;

procedure TZkGzmForm.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;  var CanSelect: Boolean);
 var
   s_temp:Str_DT_array;
   C1,i:integer;

   s_tempZRY:Str_DT_array;
   C1ZRY:integer;
   CqID,zkid:string;
   J:string;
   MeiCengID:Integer;
   MeiCengName:String;

begin
      if (ARow=0) or (kArow=ARow) then   exit;

       KARow:=AROW;
       ClearEdit;

      //根据鼠标位置改变录入
       if length(Trim(StringGrid1.Cells[1,ARow]))>0 then  begin
          FinGzm.Gzmbh:=StrToInt(Trim(StringGrid1.Cells[1,ARow]));    //c1 采区编号
       end else begin
          exit;
       end;


       //控制JiTuancombo
     for I := 0 to self.JiTuanCombo.Items.Count -1  do
        begin
              s_temp:=Public_Basic.split(self.JiTuanCombo.Items.Strings[i] ,'_',C1);
              if C1>1 then
                  if s_temp[0]=Trim(Trim(StringGrid1.Cells[38,ARow])) then    begin
                      self.JiTuanCombo.ItemIndex :=i;
                      break;
                  end;

        end;


     MainDataModule.MySQlFillComBox(MySqlDataSet2,ComboKName,'select * from KuangJingXinXiBiao  order by id ','id','MeiKuangMing','');


     //控制combokname
     for I := 0 to self.ComboKName.Items.Count -1  do
        begin
              s_temp:=Public_Basic.split(self.ComboKName.Items.Strings[i] ,'_',C1);
              if C1>1 then
               if s_temp[0]=Trim(Trim(StringGrid1.Cells[2,ARow])) then   begin
                   self.ComboKName.ItemIndex :=i;
                   i_kid:=strToInt(s_temp[0]);
                   break;
               end;
        end;



      if length(Trim(StringGrid1.Cells[3,ARow]))>0 then
             EditCqName.Text := Trim(StringGrid1.Cells[3,ARow]);// c3:    采区名称
      if length(Trim(StringGrid1.Cells[5,ARow]))>0 then
             EditSh1.Text :=Trim(StringGrid1.Cells[5,ARow]);//c5:      上边界采深
      if length(Trim(StringGrid1.Cells[6,ARow]))>0 then
             EditSh2.Text :=Trim(StringGrid1.Cells[6,ARow]);//c6:      下边界采深
      if length(Trim(StringGrid1.Cells[7,ARow]))>0 then
             EditGc .Text :=Trim(StringGrid1.Cells[7,ARow]);//c7:   平均深度
      if length(Trim(StringGrid1.Cells[8,ARow]))>0 then
             EditZxc.Text :=Trim(StringGrid1.Cells[8,ARow]);//c8:   走向长度
      if length(Trim(StringGrid1.Cells[9,ARow]))>0 then
             EditQxc.Text :=Trim(StringGrid1.Cells[9,ARow]);//c9:   倾向长度
      if trim(StringGrid1.Cells [10,ARow])<>'' then
             Editqj2.Text :=Trim(StringGrid1.Cells[10,ARow]);//c10:  走向倾角

      if length(Trim(StringGrid1.Cells[11,ARow]))>0 then
            Editqj1.Text :=Trim(StringGrid1.Cells[11,ARow]);//c11:  倾向倾角
      if length(Trim(StringGrid1.Cells[12,ARow]))>0 then
            EditMcHd.Text :=Trim(StringGrid1.Cells[12,ARow]);//c12:  煤层均厚
      if length(Trim(StringGrid1.Cells[13,ARow]))>0 then
            EditzKcgd.Text :=Trim(StringGrid1.Cells[13,ARow]);//c13:  开采高度
      if length(Trim(StringGrid1.Cells[14,ARow]))>0 then
            ComboCmFa.ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[14,ARow]))-1;//c14:  采煤方法
      if length(Trim(StringGrid1.Cells[15,ARow]))>0 then
            ComboMKy.ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[15,ARow]))-1;//c15:  煤体硬度
      if length(Trim(StringGrid1.Cells[16,ARow]))>0 then
            EditSpeed.Text :=Trim(StringGrid1.Cells[16,ARow]);//c16: 推进速度
      if length(Trim(StringGrid1.Cells[17,ARow]))>0 then
            ComboYxFx.ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[17,ARow]))-1;//c17:     仰斜俯些

      if length(Trim(StringGrid1.Cells[18,ARow]))>0 then                   //C18支架型号
            ComboZJType.ItemIndex := ComboZJType.Items.IndexOf(trim(StringGrid1.Cells[18,ARow]));
      if length(Trim(StringGrid1.Cells[19,ARow]))>0 then
            ComboDzgz.ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[19,ARow]))-1;//c19:   构造情况
      if length(Trim(StringGrid1.Cells[20,ARow]))>0 then
            ComboJYhd .ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[20,ARow]))-1;//c20:   基岩厚度
      if length(Trim(StringGrid1.Cells[21,ARow]))>0 then  begin
            Combozhqk .ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[21,ARow]))-1;//c21:  支护情况
            if Combozhqk .ItemIndex >0 then begin
                ComboZJType.Enabled :=true;
            end else begin
                ComboZJType.Enabled :=false;
            end;

      end;

      if length(Trim(StringGrid1.Cells[22,ARow]))>0 then
            ComboWs .ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[22,ARow]))-1;//c22:   瓦斯赋存
      if length(Trim(StringGrid1.Cells[23,ARow]))>0 then
            ComboTopWater .ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[23,ARow]))-1;//c23:  顶板水源
      if length(Trim(StringGrid1.Cells[24,ARow]))>0 then
            ComboBottomWater .ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[24,ARow]))-1;//c24:   底板水源
      if length(Trim(StringGrid1.Cells[25,ARow]))>0 then
            ComboStress .ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[25,ARow]))-1;//c25: 水平应力
      if length(Trim(StringGrid1.Cells[26,ARow]))>0 then
            ComboKsyl .ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[26,ARow]))-1;//c26:    矿压显现
      if length(Trim(StringGrid1.Cells[27,ARow]))>0 then
            ComboHdzh .ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[27,ARow]))-1;//c27:    巷道支护
       if Trim(StringGrid1.Cells[32,ARow])='1' then  begin
          self.FcRadioButton.ItemIndex:=0;
          self.EditJueJin.Enabled:=true;
          self.EditJueJin.Text:= Trim(StringGrid1.Cells[33,ARow]);
       end else begin
         self.FcRadioButton.ItemIndex:=1;
           self.EditJueJin.Enabled:=false;
          self.EditJueJin.Text:= '';
       end;
        if length(Trim(StringGrid1.Cells[34,ARow]))>0 then
           SupStartNumber.Text :=Trim(StringGrid1.Cells[34,ARow]);//c34:  支架开始
        if length(Trim(StringGrid1.Cells[35,ARow]))>0 then
           SupEndNumber.Text :=Trim(StringGrid1.Cells[35,ARow]);//c35:    支架结束
        if length(Trim(StringGrid1.Cells[36,ARow]))>0 then
            ComBoSupNumberDirection.ItemIndex := StrToInt(Trim(StringGrid1.Cells[36,ARow]))-1;//c36:    支架走向
        if length(Trim(StringGrid1.Cells[37,ARow]))>0 then  begin
            cboQyzt.ItemIndex :=StrToInt(Trim(StringGrid1.Cells[37,ARow]));//c37:    工作面状态  2016-6-6
            gzmqyzt:=StrToInt(Trim(StringGrid1.Cells[37,ARow]));//2017-7-2
        end;
        // 填充inttostr(FinGzm.cq_id)
        if  length(Trim(SupStartNumber.text))>0  then
             FinGzm.SupStartNumber :=StrToInt(SupStartNumber.text) ;
        if  length(Trim(SupEndNumber.text))>0  then
             FinGzm.SupEndNumber:= StrToInt(SupEndNumber.Text);
        {TODO：2018年封存  还没有开启此项功能 }
//        if gzmqyzt = 0 then begin
//            CreatTable.Enabled:=true;
//            btnBf.Enabled:=false;
//            btnHf.Enabled:=false;
//        end else if gzmqyzt = 1 then begin
//            CreatTable.Enabled:=false;
//            btnBf.Enabled:=true;
//            btnHf.Enabled:=false;
//        end else if gzmqyzt = 2 then  begin
//            CreatTable.Enabled:=false;
//            btnBf.Enabled:=false;
//            btnHf.Enabled:=true;
//        end;
       //////


     //控制按钮
     self.EditButton.Enabled :=true;
     self.DeleteButton.Enabled :=true;

      Fill_MCBh_Combo;

       s_temp:=Public_Basic.split(self.ComboKName.Text,'_',C1);//  c2:矿区编号
       if s_temp[0]='' then exit;
         i_kid:=strToInt(s_temp[0]);

        if trim(StringGrid1.Cells [1,ARow])<>'' then
        begin
           CqID:=StringGrid1.Cells [1,ARow];  //:采区编号
        end;

         MySqlDataSet1.close;
         MySqlDataSet1.CommandText:='select zkID from zkb where cqID='+(CqID);
         MySqlDataSet1.Open;
         while not MySqlDataSet1.Eof do
         begin
             zkId:=MySqlDataSet1.FieldByName('zkID').AsString;
             MySqlDataSet1.Next;
         end;
         //  给采区的几个变量赋值
          FinGzm.S_Name:=EditCqName.Text;
          FinGzm.Gzmbh:=public_Basic.StrToInt_lu(cqid);
          But_EditFileName.Enabled :=true;

       // 填充煤层编号

         for I := 0 to self.ComboMcId.Items.Count -1  do
          begin
              s_temp:=Public_Basic.split(self.ComboMcId.Items.Strings[i] ,'_',C1);
              if C1>1 then
                if s_temp[0]=Trim(Trim(StringGrid1.Cells[4,ARow])) then    begin
                   self.ComboMcId.ItemIndex :=i;
                   break;
                end;
           end;


           self.CkCkq.Enabled:=true;//2016-6-12
           self.CkDc.Enabled:=true;//2016-6-12
           self.CkMz.Enabled:=true;//2016-6-12

end;


procedure TZkGzmForm.SupEndNumberChange(Sender: TObject);
begin
   SupEndNumber.SetFocus ;
end;

procedure TZkGzmForm.SupEndNumberClick(Sender: TObject);
begin
        SupEndNumber.SetFocus ;
end;

procedure TZkGzmForm.SupEndNumberKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.SupStartNumberClick(Sender: TObject);
begin
         SupStartNumber.SetFocus;
end;

procedure TZkGzmForm.SupStartNumberKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9','.',#8]) then key:=#0
end;



procedure TZkGzmForm.FcRadioButtonClick(Sender: TObject);
begin
  if self.FcRadioButton.ItemIndex =0 then begin
      self.EditJueJin.Enabled :=true;
      kczt:=1;//已开采
    end else begin
      self.EditJueJin.Text:='';
      self.EditJueJin.Enabled :=false;
      kczt:=0;//未开采
    end;
end;

procedure TZkGzmForm.FillCell(id:Integer); //填充表格
var
    t_col,t_row,i,a:integer;
    kname,jname,cqname:Ansistring;
    SQL:string;
begin
       SetCellHead;
     
      //
       if id=0 then   begin
         SQL:='select * from cqcsb ';
       end else begin
         SQL:='select * from cqcsb where kID='+inttostr(id);
       end;

       MySqlDataSet1.Close();
       MySqlDataSet1.CommandText:=Sql;
       MySqlDataSet1.Open;
       t_col:=1;t_row:=1;
       while not MySqlDataSet1.Eof  do     begin
               self.StringGrid1.Cells [1,t_row]:=MySqlDataSet1.FieldByName('cqid').AsString ;    // c1:采取编号
               self.StringGrid1.Cells [2,t_row]:=MySqlDataSet1.FieldByName('kid').AsString;  //  c2:矿区编号
               self.StringGrid1.Cells [3,t_row]:=MySqlDataSet1.FieldByName('cqname').AsString;     // c3: 采区名称
               self.StringGrid1.Cells [4,t_row]:=MySqlDataSet1.FieldByName('mcid').AsString;    //c4:  煤层编号
               self.StringGrid1.Cells [5,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('sh1').AsFloat);    // c5: 上界深度   // c5: 上界深度
//
               self.StringGrid1.Cells [6,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('sh2').AsFloat);//MainCForm.ADODataSet1.FieldByName('sh2').AsString ;    //c6: 下界深度'
               self.StringGrid1.Cells [7,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('gc').AsFloat);//MainCForm.ADODataSet1.FieldByName('gc').AsString ;  //  c7: 平均深度
               self.StringGrid1.Cells [8,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('zxc').AsFloat);//MainCForm.ADODataSet1.FieldByName('zxc').AsString;     // c8:走向长度
               self.StringGrid1.Cells [9,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('qxc').AsFloat);//MainCForm.ADODataSet1.FieldByName('qxc').AsString;    // c9:倾向长度
               self.StringGrid1.Cells [10,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('zxqj').AsFloat);//MainCForm.ADODataSet1.FieldByName('zxqj').AsString;    // c10: 走向倾角

               self.StringGrid1.Cells [11,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('qxqj').AsFloat);//MainCForm.ADODataSet1.FieldByName('qxqj').AsString ;    // c11:  倾向倾角
               self.StringGrid1.Cells [12,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('mch').AsFloat);//MainCForm.ADODataSet1.FieldByName('mch').AsString;  //  c12: 煤层均厚
               self.StringGrid1.Cells [13,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('kch').AsFloat);//MainCForm.ADODataSet1.FieldByName('kch').AsString;     // c13:开采高度
               self.StringGrid1.Cells [14,t_row]:=MySqlDataSet1.FieldByName('cmfa').AsString;  //  c14: 采煤方法
               self.StringGrid1.Cells [15,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('mtyd').AsFloat);//MainCForm.ADODataSet1.FieldByName('mtyd').AsString;    //  c15: 煤体硬度

               self.StringGrid1.Cells [16,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('speed').AsFloat);//MainCForm.ADODataSet1.FieldByName('speed').AsString ;    //c16: '推进速度
               self.StringGrid1.Cells [17,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('yxfx').AsFloat);//MainCForm.ADODataSet1.FieldByName('yxfx').AsString ;  //   c17:  仰斜俯些
               self.StringGrid1.Cells [18,t_row]:=MySqlDataSet1.FieldByName('zjxh').Asstring;     //  c18: 支架型号
               self.StringGrid1.Cells [19,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('dcgz').AsFloat);//MainCForm.ADODataSet1.FieldByName('dcgz').AsString;    // c19:  构造情况
               self.StringGrid1.Cells [20,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('jyhd').AsFloat);//MainCForm.ADODataSet1.FieldByName('jyhd').AsString;    // c20: 基岩厚度

               self.StringGrid1.Cells [21,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('zhqk').AsFloat);//MainCForm.ADODataSet1.FieldByName('zhqk').AsString ;    // c21:支护情况
               self.StringGrid1.Cells [22,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('wsfc').AsFloat);//MainCForm.ADODataSet1.FieldByName('wsfc').AsString ;  // c22:  瓦斯赋存
               self.StringGrid1.Cells [23,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('topwater').AsFloat);//MainCForm.ADODataSet1.FieldByName('topwater').AsString;     // c23:顶板水源
               self.StringGrid1.Cells [24,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('bottomwater').AsFloat);//MainCForm.ADODataSet1.FieldByName('bottomwater').AsString;    // c24:    底板水源
               self.StringGrid1.Cells [25,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('heostress').AsFloat);//MainCForm.ADODataSet1.FieldByName('heostress').AsString;    //  c25:   水平应力

               self.StringGrid1.Cells [26,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('kyxx').AsFloat);//MainCForm.ADODataSet1.FieldByName('kyxx').AsString ;    // c26: 矿压显现
               self.StringGrid1.Cells [27,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('hangdaosup').AsFloat);//MainCForm.ADODataSet1.FieldByName('hangdaosup').AsString ;  // c27:     巷道支护
               self.StringGrid1.Cells [28,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('upmz').AsFloat);//MainCForm.ADODataSet1.FieldByName('upmz').AsString;     // c28:  上边界煤柱
               self.StringGrid1.Cells [29,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('upkc').AsFloat);//MainCForm.ADODataSet1.FieldByName('upkc').AsString;    //   c29: 上边界采空
               self.StringGrid1.Cells [30,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('downmz').AsFloat);//MainCForm.ADODataSet1.FieldByName('downmz').AsString;    //  c30:   下边界煤柱

               self.StringGrid1.Cells [31,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('downkc').AsFloat);//MainCForm.ADODataSet1.FieldByName('downkc').AsString;    //  c31:   下边界采空

               self.StringGrid1.Cells [32,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('kczt').AsFloat);//MainCForm.ADODataSet1.FieldByName('downkc').AsString;    //  c31:   下边界采空
               self.StringGrid1.Cells [33,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('kccd').AsFloat);//MainCForm.ADODataSet1.FieldByName('downkc').AsString;    //  c31:   下边界采空


               self.StringGrid1.Cells [34,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('SupStartNumber').AsFloat);  //  c34:   支架开始
               self.StringGrid1.Cells [35,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('SupEndNumber').AsFloat);  //35支架结束
               self.StringGrid1.Cells [36,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('SupNumberDirection').AsFloat);  //走向
               self.StringGrid1.Cells [37,t_row]:=MySqlDataSet1.FieldByName('qyzt').AsString;  //工作组面状态
               MySqlDataSet2.Close ;
               MySqlDataSet2.CommandText :='select * from kuangjingxinxibiao where  id =' +self.StringGrid1.Cells [2,t_row];
               MySqlDataSet2.Open ;
               if MySqlDataSet2.RecordCount >0 then  begin
                   self.StringGrid1.Cells [38,t_row]:=MySqlDataSet2.FieldByName('JituanId').AsString;  //  集团公司编号
               end else begin
                   self.StringGrid1.Cells [38,t_row]:='0';
               end;
               MySqlDataSet2.Close ;

               t_row:=t_row+1;

              if t_row>self.StringGrid1.RowCount  then    self.StringGrid1.RowCount :=t_row;

             MySqlDataSet1.Next ;
         end;
         MySqlDataSet1.Close;
   end;

end.
