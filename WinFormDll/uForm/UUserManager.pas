unit UUserManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin,
  System.ImageList, Vcl.ImgList, UMainDataModule, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids;

type
   
  TFormUserManager = class(TForm)
    ImageList1: TImageList;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    AddButton: TToolButton;
    EditButton: TToolButton;
    DeleteButton: TToolButton;
    ExitButton: TToolButton;
    ImageList2: TImageList;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    Qibutton: TToolButton;
    ChangUserType: TToolButton;
    GroupBox1: TGroupBox;
    UserTreeView: TTreeView;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    Label1: TLabel;
    GroupBox3: TGroupBox;
    StringGrid_Login: TStringGrid;
    Splitter1: TSplitter;
    DeleteAllRecord: TToolButton;
    DeleteOneRecord: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure UserTreeViewClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure QibuttonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure ChangUserTypeClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure StringGrid_LoginSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure DeleteOneRecordClick(Sender: TObject);
    procedure DeleteAllRecordClick(Sender: TObject);
  private
    { Private declarations }
     User_id,User_Name:string;
     LoginRecord_id,DeleteString:string;
     MySqlDataSet1:TMyDataSet;
     MYSQLCommand:TMyCommand;
     procedure OptionTip(Str:String);
     procedure MainTreeView(TreeView: TTreeView);
     procedure UserView(TreeView: TTreeView;XNode: TTreeNode;DataType:String);
     procedure RefreshCaptionLable(s_id:string);
     procedure GetRootNodes(RNode:TTreeNode;InImageIndex:Integer);//得到所有根节点
     procedure SetButEnabled(Value:Boolean);
     procedure SetCellHead;
     procedure FillStringGrid(UserName:String);
  public
    { Public declarations }
  end;

var
  FormUserManager: TFormUserManager;
function CreateUserManager(AHandle:THandle;ACaption:string;Wid,Hi:integer):integer;stdcall;
implementation

{$R *.dfm}

uses uWinFrameClass,  Lu_Public_BasicModual;
//内部初始化工作面函数
function CreateUserManager(AHandle:THandle;ACaption:string;Wid,Hi:integer):integer;stdcall;

begin
        if Assigned(FormUserManager) then  FreeAndNil(FormUserManager);

        FormUserManager:=TFormUserManager.Create(nil);
        try
           with FormUserManager do begin
               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

               Show;
               SetFocus;
               Result:=1;//函数值
          end ;
        except
           FreeAndNil(FormUserManager);
        end;
end;
procedure TFormUserManager.AddButtonClick(Sender: TObject);
var
 sql:string;
 t_s:WideString;
begin
   if  User_id='' then exit;
    t_s:='你确定要把【'+User_Name+'】用户停用么?';
    if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

   sql:='update UserInfo set Used=0 where id='+User_id;
   try
     MySqlCommand.CommandText :=sql;
     MySqlCommand.Execute(MainDataModule.ExUserName) ;
   finally
     MainTreeView(UserTreeView);
   end;

   RefreshCaptionLable(User_id);
   OptionTip('用户停用成功!');

end;

procedure TFormUserManager.ChangUserTypeClick(Sender: TObject);
var
 sql:string;
 t_s:WideString;
 UserType:String;
begin
   if  User_id='' then exit;
   if ChangUserType.Caption='管理员' then  begin
       t_s:='你确定要把【'+User_Name+'】升级为管理员么?';
       UserType:='1';
   end else begin
       t_s:='你确定要把【'+User_Name+'】降级为一般用户么?';
       UserType:='2';
   end;

   if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

   sql:='update UserInfo set User_Type= '+UserType+' where id='+User_id;
   try
     MySqlCommand.CommandText :=sql;
     MySqlCommand.Execute(MainDataModule.ExUserName) ;
   finally
     MainTreeView(UserTreeView);
   end;

    RefreshCaptionLable(User_id);
    OptionTip('用户权限更改成功!');
end;

procedure TFormUserManager.DeleteAllRecordClick(Sender: TObject);
var
 sql:string;
 t_s:WideString;
begin
    t_s:='你确定要删除【'+User_Name+'】操作的所有记录么?';
    if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

   sql:='delete  from UserLoginLog where UserName= ' +User_Name ;
   try
     MySqlCommand.CommandText :=sql;
     MySqlCommand.Execute(MainDataModule.ExUserName) ;
   finally
      self.FillStringGrid(User_Name);

   end;
   DeleteAllRecord.Enabled:=False;
   OptionTip('数据删除成功!');
end;

procedure TFormUserManager.DeleteButtonClick(Sender: TObject);
var
 sql:string;
 t_s:WideString;
begin
   if  User_id='' then exit;
    t_s:='你确定要删除【'+User_Name+'】用户么?';
    if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

   sql:='delete from UserInfo  where id='+User_id;
   try
     MySqlCommand.CommandText :=sql;
     MySqlCommand.Execute(MainDataModule.ExUserName) ;
   finally
     MainTreeView(UserTreeView);
   end;
     RefreshCaptionLable(User_id);
    OptionTip('数据删除成功!');
end;

procedure TFormUserManager.DeleteOneRecordClick(Sender: TObject);
var
 sql:string;
 t_s:WideString;
begin
    if  public_Basic.StrToInt_lu(LoginRecord_id)  <1 then   exit;
    t_s:='你确定要删除第【'+DeleteString+'】产生的记录么?';
    if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

   sql:='delete  from UserLoginLog where id= ' +LoginRecord_id ;
   try
     MySqlCommand.CommandText :=sql;
     MySqlCommand.Execute(MainDataModule.ExUserName) ;
   finally
      self.FillStringGrid(User_Name);
      LoginRecord_id:='0';
   end;
   DeleteOneRecord.Enabled:=False;
   OptionTip('数据删除成功!');
end;

procedure TFormUserManager.EditButtonClick(Sender: TObject);
var
 sql:string;
 t_s:WideString;
begin
   if  User_id='' then exit;
    t_s:='你确定要重置【'+User_Name+'】用户登录密码么?';
    if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

   sql:='update UserInfo set User_Password= ''123456'' where id='+User_id;
   try
     MySqlCommand.CommandText :=sql;
     MySqlCommand.Execute(MainDataModule.ExUserName) ;
   finally
     MainTreeView(UserTreeView);
   end;
    RefreshCaptionLable(User_id);
    OptionTip('密码重置成功!');
end;

procedure TFormUserManager.ExitButtonClick(Sender: TObject);
begin
    Close;
end;

procedure TFormUserManager.FillStringGrid(UserName:String);
var
 t_row:integer;
begin
    SetCellHead;

    MySqlDataSet1.Close;
    MySqlDataSet1.CommandText:= 'SELECT * from UserLoginLog where UserName ='''+UserName+'''' ;
    MySqlDataSet1.Open;
    t_row:=1;
    while not MySqlDataSet1.Eof  do  begin
       StringGrid_Login.Cells [0,t_row]:=IntToStr(t_row);
       StringGrid_Login.Cells [1,t_row]:=
            FormatDateTime('yyyy-mm-dd hh:nn:ss ',MySqlDataSet1.FieldByName('Generatetime').AsDateTime);
       StringGrid_Login.Cells [2,t_row]:=MySqlDataSet1.FieldByName('TextValue').AsString;
       StringGrid_Login.Cells [3,t_row]:=MySqlDataSet1.FieldByName('id').AsString;

       t_row:=t_row+1;
       if t_row>self.StringGrid_Login.RowCount  then    self.StringGrid_Login.RowCount :=t_row;
       MySqlDataSet1.Next ;
    end ;
     MySqlDataSet1.Close ;

end;

procedure TFormUserManager.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    if  Assigned(FormUserManager) then  FreeAndNil(FormUserManager);


end;

procedure TFormUserManager.FormCreate(Sender: TObject);
begin
     MySqlDataSet1:=TMyDataSet.Create(nil);

     MYSQLCommand:=TMyCommand.Create(nil);
     MySqlDataSet1.MySqlConnection:=MainDataModule.ExConn;
     MYSQLCommand.MySqlConnection:=MainDataModule.ExConn;
     LoginRecord_id:='0';
end;

procedure TFormUserManager.FormDestroy(Sender: TObject);
begin
     FreeAndNil(MySqlDataSet1);
     FreeAndNil(MYSQLCommand);
end;

procedure TFormUserManager.FormResize(Sender: TObject);
begin
 self.StringGrid_Login.ColWidths[2]:=StringGrid_Login.Width-300;
end;

procedure TFormUserManager.FormShow(Sender: TObject);
begin
   PubLic_Basic.InitStatusBar(self.StatusBar1);
   MainTreeView(UserTreeView);
   SetButEnabled(False);
   SetCellHead;
end;

procedure TFormUserManager.GetRootNodes(RNode: TTreeNode;
  InImageIndex: Integer);
var
   vNode:TTreeNode;
begin
  vNode:=RNode.getFirstChild;
  While vNode<>nil do
  begin
    if PMyRec(vNode.Data)^.DName='1' then    vNode.ImageIndex:=InImageIndex
       else   vNode.ImageIndex:=3;
    vNode:=vNode.GetNextChild(vNode);

  end;
end;

procedure TFormUserManager.MainTreeView(TreeView: TTreeView);
var
  strcon: String;
  RecData: PMyRec;
  xNode,xNodeJing:TTreeNode;
  i:Integer;
begin
        //树图初始化
    TreeView.Items.Clear;

    New(RecData);
    RecData^.BName:='-1';
    RecData^.DName:='ROOT';
    RecData^.XHeight:='1';
    xNode:=TreeView.Items.AddObject(nil,'管理员',RecData);
    Xnode.ImageIndex:=0;
    Xnode.Expanded;
    UserView(TreeView,xNode,'1');

    //-------------------
    New(RecData);
    RecData^.BName:='-1';
    RecData^.DName:='ROOT';
    RecData^.XHeight:='2';
    xNode:=TreeView.Items.AddObject(nil,'一般用户',RecData);
    Xnode.ImageIndex:=0;

    UserView(TreeView,xNode,'2');
    Xnode.Expanded;


end;

procedure TFormUserManager.OptionTip(Str: String);
begin
   self.StatusBar1.Panels[0].Text :=str;
end;

procedure TFormUserManager.QibuttonClick(Sender: TObject);
var
 sql:string;
 t_s:WideString;
begin
   if  User_id='' then exit;
    t_s:='你确定要把【'+User_Name+'】用户启用么?';
    if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

   sql:='update UserInfo set Used=1 where id='+User_id;
   try
     MySqlCommand.CommandText :=sql;
     MySqlCommand.Execute(MainDataModule.ExUserName) ;
   finally
     MainTreeView(UserTreeView);
   end;
     RefreshCaptionLable(User_id);
     OptionTip('用户启用成功!');
end;

procedure TFormUserManager.RefreshCaptionLable(s_id: string);
begin
    Memo1.Clear ;
    MySqlDataSet1.Close;
    MySqlDataSet1.CommandText:= 'SELECT * from UserINFo where id ='+s_id ;
    MySqlDataSet1.Open;
     if   (MySqlDataSet1.Open) and (MySqlDataSet1.RecordCount >0)  then begin
         Memo1.Lines.Add('');
         Memo1.Lines.Add('用户编码：【'+MySqlDataSet1 .FieldByName('id').AsString +'】');
         Memo1.Lines.Add('');
         Memo1.Lines.Add('用户称呼：【'+MySqlDataSet1 .FieldByName('UserName').AsString +'】');
         User_Name:= MySqlDataSet1 .FieldByName('UserName').AsString;
         Memo1.Lines.Add('');
         if MySqlDataSet1 .FieldByName('User_Type').AsInteger =1 then   begin
            Memo1.Lines.Add('用户身份：【管理员】');
            ChangUserType.Caption:='一般用户';
         end else begin
            Memo1.Lines.Add('用户身份：【一般用户】');
            ChangUserType.Caption:='管理员';
         end;
         Memo1.Lines.Add('');
         if MySqlDataSet1 .FieldByName('Used').AsInteger =1  then  begin
            Memo1.Lines.Add('用户状态：【正常使用】');
         end else begin
            Memo1.Lines.Add('用户状态：【停止使用】');
         end;
     end ;
     MySqlDataSet1.Close ;
     SetButEnabled(true);
end;

procedure TFormUserManager.SetButEnabled(Value: Boolean);
begin
    AddButton.Enabled :=Value;
    EditButton.Enabled :=Value;
    QiButton.Enabled :=Value;
    DeleteButton.Enabled :=Value;
    ChangUserType.Enabled:=Value;
    DeleteOneRecord.Enabled :=value;
    DeleteAllRecord.Enabled :=Value;
end;

procedure TFormUserManager.SetCellHead;
var
   i:integer;
begin
      // 清空单元格
      for i := 1 to  StringGrid_Login.RowCount - 1 do
          StringGrid_Login.Rows[i].Clear ;
     StringGrid_Login.Canvas.Font.Size :=8;
     StringGrid_Login.ColCount :=4;
     StringGrid_Login.RowCount :=6;
     StringGrid_Login.Cells [0,0]:='序号';
     StringGrid_Login.Cells [1,0]:='操作时间';
     StringGrid_Login.Cells [2,0]:='操作命令';
     StringGrid_Login.ColWidths[0]:=60;
     StringGrid_Login.ColWidths[1]:=200;
     StringGrid_Login.ColWidths[2]:=StringGrid_Login.Width-300;
     StringGrid_Login.ColWidths[3]:=-1;
end;

procedure TFormUserManager.StringGrid_LoginSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin

      if length(Trim(StringGrid_Login.Cells[3,ARow]))>0 then
            LoginRecord_id:= Trim(StringGrid_Login.Cells[3,ARow]);// 提取记录号
      if length(Trim(StringGrid_Login.Cells[1,ARow]))>0 then
            DeleteString:= Trim(StringGrid_Login.Cells[1,ARow]);// 提取时间
      DeleteOneRecord.Enabled :=true;
      DeleteAllRecord.Enabled :=true;
end;

procedure TFormUserManager.UserTreeViewClick(Sender: TObject);
var
  NodeSelected: TTreeNode;
begin
if (UserTreeView.Selected = nil) or (PMyRec(UserTreeView.Selected.Data)^.DName = 'ROOT')   then  begin
     Exit;
   end;

    NodeSelected:=UserTreeView.Selected;

    if (NodeSelected=nil) then        exit;

    if PMyRec(NodeSelected.Data)^.BName='-2' then begin

          User_id:= PMyRec(NodeSelected.Data)^.XHeight;
          GetRootNodes(NodeSelected.Parent,2);
          UserTreeView.Selected.SelectedIndex:=5;
          UserTreeView.Selected.ImageIndex:= UserTreeView.Selected.SelectedIndex;
          User_Name:=UserTreeView.Selected.Text ;
          self.FillStringGrid(User_Name);
          RefreshCaptionLable(User_id);
    end;

end;

procedure TFormUserManager.UserView(TreeView: TTreeView; XNode: TTreeNode;
  DataType: String);
var
   RecData: PMyRec;
   XNodeChild:TTreeNode;
begin
    MySqlDataSet1.Close;
    MySqlDataSet1.CommandText:= 'SELECT id,UserName,Used from UserINFo' +
       ' where User_Type ='+DataType +'   order by id';
    MySqlDataSet1.Open;
      while not MySqlDataSet1.Eof do begin
           New(RecData);
           RecData^.BName:='-2';
           RecData^.DName:=MySqlDataSet1.FieldByName('Used').AsString;
           RecData^.XHeight:=Trim(MySqlDataSet1.FieldByName('id').AsString);
           XNodeChild:=TreeView.Items.AddChildObject(xNode,Trim(MySqlDataSet1.FieldByName('UserName').AsString),RecData);
           if RecData^.DName='1' then     XNodeChild.ImageIndex:=2
              else  XNodeChild.ImageIndex:=3;
           if RecData^.XHeight=User_id then
              XNode.Selected :=true;

        MySqlDataSet1.Next ;
     end ;
     MySqlDataSet1.Close ;
end;

end.
