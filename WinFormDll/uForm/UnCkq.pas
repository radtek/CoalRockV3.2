unit UnCkq;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, StdCtrls, Grids, ExtCtrls, ComCtrls, ToolWin,StrUtils,
  System.ImageList,
  UMainDataModule;

type
  TCqk = class(TForm)
    Splitter1: TSplitter;
    Label12: TLabel;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    AddButton: TToolButton;
    EditButton: TToolButton;
    SaveButton: TToolButton;
    DeleteButton: TToolButton;
    ExitButton: TToolButton;
    Panel2: TPanel;
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label11: TLabel;
    Label15: TLabel;
    Label22: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    EditCkqcd: TEdit;
    EditYjaqjl: TEdit;
    EditCkqName: TEdit;
    CboWzfs: TComboBox;
    EditCkqkd: TEdit;
    EditCkqkcgd: TEdit;
    EditDis_left: TEdit;
    EditDis_right: TEdit;
    EditDis_front: TEdit;
    EditDis_behind: TEdit;
    EditDis_top: TEdit;
    EditDis_bottom: TEdit;
    ImageList1: TImageList;
    Label24: TLabel;
    DateTimePicker1: TDateTimePicker;
    StatusBar1: TStatusBar;
    procedure AddButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ExitButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure EditCkqkdKeyPress(Sender: TObject; var Key: Char);
    procedure CboWzfsChange(Sender: TObject);
    procedure EditCkqNameClick(Sender: TObject);
    procedure EditCkqkdClick(Sender: TObject);
    procedure EditCkqcdClick(Sender: TObject);
    procedure EditCkqkcgdClick(Sender: TObject);
    procedure CboWzfsClick(Sender: TObject);
    procedure DateTimePicker1Click(Sender: TObject);
    procedure EditYjaqjlClick(Sender: TObject);
    procedure EditDis_leftClick(Sender: TObject);
    procedure EditDis_rightClick(Sender: TObject);
    procedure EditDis_topClick(Sender: TObject);
    procedure EditDis_frontClick(Sender: TObject);
    procedure EditDis_behindClick(Sender: TObject);
    procedure EditDis_bottomClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
     MySqlDataSet1:TMyDataSet;
     MyCommand1:TMyCommand;
     i_Zid:integer; // 选中的NO
     KARow:integer;
    function checkInputEdit:wordbool; //检查录入格式是否合格
    procedure ClearEdit;   //清空编辑框
    procedure FillCell; //填充表格
    procedure SetCellHead; //设置Cell表头
    procedure SetEnable(ISCanEnable:bool);
    procedure LeftOrRightEnanle(ISCanEnable:bool);
    procedure OptionTip(Str:String);
  public
    { Public declarations }
  end;

  function CreateUnCkq_inn(AHandle:THandle;ACaption:string;Exid:integer):integer;stdcall;

var
  EXUsedCqk: TCqk;
  Save_Lx:string;
  cqid:integer;

implementation
uses math, uWinFrameClass,  Lu_Public_BasicModual;
{$R *.dfm}
//内部初始化工作面函数
function CreateUnCkq_inn(AHandle:THandle;ACaption:string;Exid:integer):integer;stdcall;
begin
        Result:=0;//函数值
        EXUsedCqk:=TCqk.Create(nil);
        try
            EXUsedCqk.Caption:=ACaption;
            EXUsedCqk.WindowState:= wsNormal;
            EXUsedCqk.ParentWindow:=Ahandle;
            EXUsedCqk.Top:=60;
            EXUsedCqk.Left:=120;
            cqid:=Exid;
            EXUsedCqk.Show;

            Result:=1;//函数值
        except
            FreeAndNil(EXUsedCqk);
        end;
end;
{ TCqk }

procedure TCqk.AddButtonClick(Sender: TObject);
begin
  i_zid:=0;
  //控制按钮
  self.SaveButton.Enabled :=true;
  self.EditButton.Enabled :=false;

  i_zid :=0;
  Save_Lx:='add'; //保存时，操作类型，新增、修改    新增
  OptionTip('正在进行【添加】操作!');
  SetEnable(true);
  ClearEdit;

  //2016-6-14

  self.EditCkqkd.Text := '0';
  self.EditCkqcd.Text := '0';
  self.EditCkqkcgd.Text := '0';
  self.EditYjaqjl.Text := '0';
  self.CboWzfs.ItemIndex := -1;

  self.EditDis_left.Text :='0';
  self.EditDis_right.Text:='0';
  self.EditDis_front.Text:='0';
  self.EditDis_behind.Text:='0';
  self.EditDis_top.Text:='0';
  self.EditDis_bottom.Text:='0';

end;

procedure TCqk.CboWzfsChange(Sender: TObject);
begin
    LeftOrRightEnanle(false);
    if CboWzfs.ItemIndex =0 then   begin
       EditDis_left.Enabled :=true;
    end else if CboWzfs.ItemIndex =1 then   begin
       EditDis_right.Enabled :=true;
    end else if CboWzfs.ItemIndex =2 then   begin
       EditDis_front.Enabled :=true;
    end else if CboWzfs.ItemIndex =3 then   begin
       EditDis_behind.Enabled :=true;
    end else if CboWzfs.ItemIndex =4 then   begin
       EditDis_top.Enabled :=true;
    end else if CboWzfs.ItemIndex =5 then   begin
       EditDis_bottom.Enabled :=true;
    end;
end;

procedure TCqk.CboWzfsClick(Sender: TObject);
begin
    CboWzfs.SetFocus;
end;

function TCqk.checkInputEdit: wordbool;
begin
   result:=false;
    if self.EditCkqName.Text = ''  then begin
       messagebox(self.Handle,'请填写采空区名称！','系统提示',mb_iconerror+mb_ok);
       exit;
    end;

    if self.EditCkqkd.Text = '' then begin
        messagebox(self.Handle,'请填写采空区宽度！','系统提示',mb_iconerror+mb_ok);
        exit;
    end;

    if self.EditCkqcd.Text = '' then begin
        messagebox(self.Handle,'请填写采空区长度！','系统提示',mb_iconerror+mb_ok);
        exit;
    end;

    if self.EditCkqkcgd.Text = '' then begin
       messagebox(self.Handle,'请填写采空区开采高度！','系统提示',mb_iconerror+mb_ok);
       exit;
    end;

    if self.EditYjaqjl.Text = '' then begin
        messagebox(self.Handle,'请填写采空区预警安全距离！','系统提示',mb_iconerror+mb_ok);
        exit;
    end;

    if self.CboWzfs.Text = '' then begin
       messagebox(self.Handle,'请选择煤柱与开切眼的位置方式！','系统提示',mb_iconerror+mb_ok);
       exit;
    end;

   

   result:=true;
end;

procedure TCqk.ClearEdit;
begin
   self.EditCkqName.Text := '';
   self.EditCkqkd.Text := '';
   self.EditCkqcd.Text := '';
   self.EditCkqkcgd.Text := '';
   self.EditYjaqjl.Text := '';
   self.CboWzfs.ItemIndex := -1;
   self.EditDis_left.Text :='';
   self.EditDis_right.Text:='';
   self.EditDis_front.Text:='';
   self.EditDis_behind.Text:='';
   self.EditDis_top.Text:='';
   self.EditDis_bottom.Text:='';
end;

procedure TCqk.DateTimePicker1Click(Sender: TObject);
begin
    DateTimePicker1.SetFocus;
end;

procedure TCqk.DeleteButtonClick(Sender: TObject);
var
   t_s:String;
   t_sql:String;
begin
    t_s:='你确定要删除【'+self.EditCkqName.Text+'】的数据么?';
    if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

      t_sql:='delete from  Ckq_MineOutArea  where gzmid = '+inttostr(cqid)+' and id='+self.StringGrid1.Cells [1,i_Zid];

      MyCommand1.CommandText :=t_sql;
      MyCommand1.Execute(MainDataModule.ExUserName)  ;

    //填充Cell
    self.FillCell ;

    //控制按钮
    self.DeleteButton.Enabled :=false;
    self.AddButton.Enabled :=true;
    self.EditButton.Enabled:=false; //2016-6-12
    
    //提示信息
     OptionTip('数据删除成功!');

  // i_Kid :=0;
   i_zid:=0;
   ClearEdit;

end;

procedure TCqk.EditButtonClick(Sender: TObject);
begin
   self.EditButton.Enabled :=false;
   self.SaveButton.Enabled :=true;
   self.DeleteButton.Enabled :=false;//2016-6-12
   Save_Lx:='up';
   SetEnable(true);
   OptionTip('正在进行【编辑】操作!');
end;

procedure TCqk.EditCkqcdClick(Sender: TObject);
begin
   EditCkqcd.SetFocus ;
end;

procedure TCqk.EditCkqkcgdClick(Sender: TObject);
begin
    EditCkqkcgd.SetFocus ;
end;

procedure TCqk.EditCkqkdClick(Sender: TObject);
begin
   EditCkqkd.SetFocus ;
end;

procedure TCqk.EditCkqkdKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TCqk.EditCkqNameClick(Sender: TObject);
begin
   EditCkqName.SetFocus ;
end;

procedure TCqk.EditDis_behindClick(Sender: TObject);
begin
    EditDis_behind.SetFocus;
end;

procedure TCqk.EditDis_bottomClick(Sender: TObject);
begin
   EditDis_bottom.SetFocus ;
end;

procedure TCqk.EditDis_frontClick(Sender: TObject);
begin
   EditDis_front.SetFocus;
end;

procedure TCqk.EditDis_leftClick(Sender: TObject);
begin
   EditDis_left.SetFocus;
end;

procedure TCqk.EditDis_rightClick(Sender: TObject);
begin
    EditDis_right.SetFocus;
end;

procedure TCqk.EditDis_topClick(Sender: TObject);
begin
   EditDis_top.SetFocus;
end;

procedure TCqk.EditYjaqjlClick(Sender: TObject);
begin
  EditYjaqjl.SetFocus;
end;

procedure TCqk.ExitButtonClick(Sender: TObject);
begin
  self.Close ;
end;

procedure TCqk.FillCell;
var
    t_col,t_row:integer;
    kname,jname,cqname:Ansistring;
    i:integer;
    J:integer;
    OutTime:Tdatetime;
begin
       SetCellHead;
       MySqlDataSet1.Close();
       MySqlDataSet1.CommandText:='select * from Ckq_MineOutArea where gzmid = '+inttostr(cqid)+'' ;
       MySqlDataSet1.Open;
       t_col:=1;t_row:=1;

       J:=1;
       while not  MySqlDataSet1.Eof  do
         begin
               //self.StringGrid1.Cells [0,t_row]:=inttostr(J);
               self.StringGrid1.Cells [1,t_row]:= MySqlDataSet1.FieldByName('id').AsString ;   // 1 id
               self.StringGrid1.Cells [2,t_row]:= MySqlDataSet1.FieldByName('ckqName').AsString ;   // 2 名称
               self.StringGrid1.Cells [3,t_row]:= MySqlDataSet1.FieldByName('location').AsString; // 3 采空区与开切眼的位置方式
               OutTime:=MySqlDataSet1.FieldByName('Outtime').AsDateTime;
               self.StringGrid1.Cells [4,t_row]:=FormatDateTime('YYYY-mm-dd',OutTime);  // 4 开采时间
               self.StringGrid1.Cells [5,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('width').AsFloat); //5 采空区的宽度
               self.StringGrid1.Cells [6,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('length').AsFloat); // 6  采空区长度
               self.StringGrid1.Cells [7,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('heigth').AsFloat);// 7 采空区开采高度
               self.StringGrid1.Cells [8,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('safedistance').AsFloat);// 8 预警的安全距离
               self.StringGrid1.Cells [9,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('dis_left').AsFloat);// 9 左侧
               self.StringGrid1.Cells [10,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('dis_right').AsFloat);// 10 右侧
               self.StringGrid1.Cells [11,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('dis_front').AsFloat);// 11 前面
               self.StringGrid1.Cells [12,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('dis_behind').AsFloat);// 12 后面
               self.StringGrid1.Cells [13,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('dis_top').AsFloat);// 13 顶部
               self.StringGrid1.Cells [14,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('dis_bottom').AsFloat);// 14 底部

               t_row:=t_row+1;
              if t_row>self.StringGrid1.RowCount  then
                       self.StringGrid1.RowCount :=t_row;
              MySqlDataSet1.Next ;
             J:=J+1;
         end;
     MySqlDataSet1.Close();
end;

procedure TCqk.FormActivate(Sender: TObject);
begin
   //  self.FillCell ;
end;

procedure TCqk.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Action := caFree;
end;

procedure TCqk.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   
    if Assigned(EXUsedCqk) then  FreeAndNil(EXUsedCqk);
end;

procedure TCqk.FormCreate(Sender: TObject);
begin
   //
    MySqlDataSet1:=TMyDataSet.Create(nil);
    MySqlDataSet1.MySqlConnection :=MainDataModule.ExConn;

    MyCommand1:=TMyCommand.Create (nil);
    MyCommand1.MySqlConnection :=MainDataModule.ExConn;
   //

  SetEnable(false);

  self.DeleteButton.Enabled :=false;//2016-6-12
  self.EditButton.Enabled :=false;//2016-6-12
  self.SaveButton.Enabled :=false;//2016-6-12

   self.ClearEdit; //2016-6-13
   self.DateTimePicker1.Date :=now();

end;

procedure TCqk.FormDestroy(Sender: TObject);
begin
    FreeAndNil(MySqlDataSet1);
    FreeAndNil(MyCommand1);
end;

procedure TCqk.FormShow(Sender: TObject);
begin
    PubLic_Basic.InitStatusBar(self.StatusBar1);
    self.FillCell ;
end;

procedure TCqk.LeftOrRightEnanle(ISCanEnable:bool);
begin
   self.EditDis_left.Enabled :=ISCanEnable;
   self.EditDis_right.Enabled:=ISCanEnable;
   self.EditDis_front.Enabled:=ISCanEnable;
   self.EditDis_behind.Enabled:=ISCanEnable;
   self.EditDis_top.Enabled:=ISCanEnable;
   self.EditDis_bottom.Enabled:=ISCanEnable;
end;

procedure TCqk.OptionTip(Str: String);
begin
   StatusBar1.Panels[0].Text :=str;
end;

procedure TCqk.SaveButtonClick(Sender: TObject);
var
  t_sql:String;
  C1:integer;
begin
  if self.checkInputEdit =false then exit;
  begin
    if Save_Lx ='add' then   begin   //是增加操作
      t_sql:='insert into Ckq_MineOutArea (ckqName,location,Outtime,width,length,heigth,dis_left,dis_right,dis_front, '+
             'dis_behind,dis_top,dis_bottom,safedistance,gzmid) values('+
              ''''+self.EditCkqName.Text+ ''','''+self.CboWzfs.Text+''','''+
              FormatDateTime('yyyy-mm-dd hh:nn:ss',DateTimePicker1.DateTime)+''','+
              self.EditCkqkd.Text+','+self.EditCkqcd.Text+','+
              self.EditCkqkcgd.Text+','+self.EditDis_left.Text+','+
              self.EditDis_right.Text+','+self.EditDis_front.Text+','+
              self.EditDis_behind.Text+','+self.EditDis_top.Text+','+
              self.EditDis_bottom.Text+','+self.EditYjaqjl.Text+','+inttostr(cqid)+')';
    end else if Save_Lx='up' then   //是修改操作
    begin
      t_sql:='update Ckq_MineOutArea set'+
              ' ckqName='''+self.EditCkqName.Text+''',location='''+self.CboWzfs.Text+''','+
              ' Outtime='''+FormatDateTime('yyyy-mm-dd hh:nn:ss',DateTimePicker1.DateTime)+
              ''',width='+self.EditCkqkd.Text+',length='+self.EditCkqcd.Text+
              ',heigth='+self.EditCkqkcgd.Text+',dis_left='+self.EditDis_left.Text+
              ',dis_right='+self.EditDis_right.Text+',dis_front='+self.EditDis_front.Text+
              ',dis_behind='+self.EditDis_behind.Text+',dis_top='+self.EditDis_top.Text+',dis_bottom='+self.EditDis_bottom.Text+
              ',safedistance='+self.EditYjaqjl.Text+' where gzmid = '+inttostr(cqid)+' and id='+self.StringGrid1.Cells [1,i_Zid];
    end;
  end;
   try
      MyCommand1.CommandText :=t_sql;
      MyCommand1.Execute(MainDataModule.ExUserName)  ;
   except
      exit;
   end;
     //  memo1.Text :=t_sql;
    //填充Cell
    self.FillCell ;

    //控制按钮
    self.SaveButton.Enabled :=false;
    self.AddButton.Enabled :=true;
    self.DeleteButton.Enabled :=false;//2016-6-12
    self.EditButton.Enabled:=false;//2016-6-13
    
    //提示信息
     OptionTip('数据存储成功!');
     SetEnable(false);

     i_zid :=0;
     Save_Lx:=''; // 保存时，操作类型，新增、修改 复位
     ClearEdit;
end;

procedure TCqk.SetCellHead;
var
  i:integer;
begin

     for i := 1 to  StringGrid1.RowCount - 1 do
          StringGrid1.Rows[i].Clear ;

     self.StringGrid1.ColCount:=15;
     self.StringGrid1.RowCount :=4;
     self.StringGrid1.Cells [1,0]:='编号';
     self.StringGrid1.Cells [2,0]:='采空区名称';
     self.StringGrid1.Cells [3,0]:='采空区与开切眼位置方式';
     self.StringGrid1.Cells [4,0]:='开采时间';
     self.StringGrid1.Cells [5,0]:='采空区宽度';
     self.StringGrid1.Cells [6,0]:='采空区长度';
     self.StringGrid1.Cells [7,0]:='采空区开采高度';
     self.StringGrid1.Cells [8,0]:='预警的安全距离';
     self.StringGrid1.Cells [9,0]:='距离工作面左侧';
     self.StringGrid1.Cells [10,0]:='距离工作面右侧';
     self.StringGrid1.Cells [11,0]:='距离工作面前面';
     self.StringGrid1.Cells [12,0]:='距离工作面后面';
     self.StringGrid1.Cells [13,0]:='距离工作面顶部';
     self.StringGrid1.Cells [14,0]:='距离工作面底部';

     
     self.StringGrid1.ColWidths[0]:=10;
     self.StringGrid1.ColWidths[1]:=30;
     self.StringGrid1.ColWidths[2]:=80;
     self.StringGrid1.ColWidths[3]:=50;
     self.StringGrid1.ColWidths[4]:=80;
     self.StringGrid1.ColWidths[5]:=80;
     self.StringGrid1.ColWidths[6]:=90;
     self.StringGrid1.ColWidths[7]:=80;
     self.StringGrid1.ColWidths[8]:=80;
     self.StringGrid1.ColWidths[9]:=80;
     self.StringGrid1.ColWidths[10]:=80;
     self.StringGrid1.ColWidths[11]:=80;
     self.StringGrid1.ColWidths[12]:=80;
     self.StringGrid1.ColWidths[13]:=80;
     self.StringGrid1.ColWidths[14]:=80;
end;

procedure TCqk.SetEnable(ISCanEnable: bool);
begin
   self.EditCkqName.Enabled := ISCanEnable;
   self.EditCkqkd.Enabled := ISCanEnable;
   self.EditCkqcd.Enabled := ISCanEnable;
   self.EditCkqkcgd.Enabled := ISCanEnable;
   self.EditYjaqjl.Enabled := ISCanEnable;
   self.CboWzfs.Enabled := ISCanEnable;

   self.EditDis_left.Enabled :=ISCanEnable;
   self.EditDis_right.Enabled:=ISCanEnable;
   self.EditDis_front.Enabled:=ISCanEnable;
   self.EditDis_behind.Enabled:=ISCanEnable;
   self.EditDis_top.Enabled:=ISCanEnable;
   self.EditDis_bottom.Enabled:=ISCanEnable;
end;

procedure TCqk.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  s_temp:Str_DT_array;
  C1,i:integer;
  lsz:string;
   FSetting : TFormatSettings;  //日期格式转换
begin
//   if (ARow=0) or (kArow=ARow) then   exit;
//         KARow:=AROW;

   //日期格式转换
       FSetting.ShortDateFormat:='yyyy-mm-ss' ;
       FSetting.DateSeparator :='-';
       FSetting.ShortTimeFormat :='hh:nn:ss';
       FSetting.TimeSeparator :=':';
       FSetting.DecimalSeparator :='.';


  i_Zid:=ARow;

  self.EditCkqName.Text:= StringGrid1.Cells[2,i_Zid];   // 2 采空区名称
  self.CboWzfs.ItemIndex:=CboWzfs.Items.IndexOf(trim(self.StringGrid1.Cells [3,i_Zid]));  // 3 采空区与开切眼的位置方式
  if length(trim(StringGrid1.Cells [4,i_Zid]))>1  then
     self.DateTimePicker1.Date :=StrToDateTime(self.StringGrid1.Cells [4,i_Zid],FSetting);


  self.EditCkqkd.Text:=self.StringGrid1.Cells [5,i_Zid]; // 4 采空区宽度

  if EditCkqkd.Text='' then  begin
     EditCkqkd.Text:='0';
  end;

  self.EditCkqcd.Text:=self.StringGrid1.Cells [6,i_Zid]; // 5 采空区长度
  if EditCkqcd.Text = '' then begin
     EditCkqcd.Text:='0';
  end;

  self.EditCkqkcgd.Text:=self.StringGrid1.Cells [7,i_Zid]; // 6 采空区开采高度
  if EditCkqkcgd.Text = '' then begin
     EditCkqkcgd.Text:='0';
  end;

  self.EditYjaqjl.Text:=self.StringGrid1.Cells [8,i_Zid]; // 7 预警的安全距离
  if EditYjaqjl.Text= '' then begin
     EditYjaqjl.Text:='0';
  end;

  self.EditDis_left.Text:=self.StringGrid1.Cells [9,i_Zid]; // 8 左侧
  if EditDis_left.Text = '' then begin
    EditDis_left.Text:='0';
  end;

  self.EditDis_right.Text:=self.StringGrid1.Cells [10,i_Zid]; // 9 右侧
  if EditDis_right.Text = '' then begin
     EditDis_right.Text:= '0';
  end;

  self.EditDis_front.Text:=self.StringGrid1.Cells [11,i_Zid]; // 10 前面
  if EditDis_front.Text = '' then begin
     EditDis_front.Text:= '0';
  end;

  self.EditDis_behind.Text:=self.StringGrid1.Cells [12,i_Zid];  // 11 后面
  if EditDis_behind.Text = '' then begin
     EditDis_behind.Text:= '0';
  end;

  self.EditDis_top.Text:=self.StringGrid1.Cells [13,i_Zid];  // 12 顶部
  if EditDis_top.Text = '' then begin
     EditDis_top.Text:='0';
  end;


  self.EditDis_bottom.Text:=self.StringGrid1.Cells [14,i_Zid];  // 13 底部
  if EditDis_bottom.Text = '' then begin
     EditDis_bottom.Text:='0';
  end;

  //控制按钮
  self.EditButton.Enabled :=true;
  self.DeleteButton.Enabled :=true;
end;

end.
