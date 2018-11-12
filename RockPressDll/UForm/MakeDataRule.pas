unit MakeDataRule;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,StrUtils,
  Vcl.ComCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList, Vcl.Grids,
  UMakeRuleClass,UMainDataModule, Vcl.Menus

  ;

type
  TForm_MakeRule = class(TForm)
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    AddButton: TToolButton;
    EditButton: TToolButton;
    SaveButton: TToolButton;
    DeleteButton: TToolButton;
    ExitButton: TToolButton;
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    ListBox1: TListBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Edit_Rule_name: TEdit;
    Label2: TLabel;
    CB_FileSuffix: TComboBox;
    Label3: TLabel;
    CB_Split_Flag: TComboBox;
    Label4: TLabel;
    Edit_Sup_Flag: TEdit;
    Label5: TLabel;
    Edit_Time_Flag: TEdit;
    RG_Sup_Upper: TRadioGroup;
    RG_Time_Upper: TRadioGroup;
    Label6: TLabel;
    Edit_DT_String: TEdit;
    Memo1: TMemo;
    Label7: TLabel;
    CB_DataType: TComboBox;
    CB_Data_Unit: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Edit_Data_Flag: TEdit;
    RG_Data_Upper: TRadioGroup;
    StringGrid1: TStringGrid;
    But_AddData: TButton;
    But_DelData: TButton;
    StatusBar1: TStatusBar;
    GroupBox3: TGroupBox;
    GroupBox5: TGroupBox;
    Memo_Source: TMemo;
    PopMemu_Memo: TPopupMenu;
    GroupBox6: TGroupBox;
    Memo_Result: TMemo;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    ImageList2: TImageList;
    Button1: TButton;
    RG_MoveSupp: TRadioGroup;
    GB_MoveSup: TGroupBox;
    Label11: TLabel;
    Edit_MoveSup_ProFlag: TEdit;
    RG_MoveSup_Upper: TRadioGroup;
    Label12: TLabel;
    CB_Equal: TComboBox;
    Edit_MoveSuP_Value: TEdit;
    Label13: TLabel;
    CB_Mult_Max_AGV: TComboBox;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure But_AddDataClick(Sender: TObject);
    procedure But_DelDataClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure Edit_Rule_nameClick(Sender: TObject);
    procedure CB_FileSuffixClick(Sender: TObject);
    procedure CB_Split_FlagClick(Sender: TObject);
    procedure CB_Data_UnitClick(Sender: TObject);
    procedure Edit_Data_FlagClick(Sender: TObject);
    procedure Edit_Sup_FlagClick(Sender: TObject);
    procedure Edit_Time_FlagClick(Sender: TObject);
    procedure Edit_DT_StringClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure N2Click(Sender: TObject);
    procedure Memo_SourceMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure RG_MoveSuppClick(Sender: TObject);
    procedure Edit_MoveSup_ProFlagClick(Sender: TObject);
    procedure Edit_MoveSuP_ValueClick(Sender: TObject);
    procedure Memo_SourceClick(Sender: TObject);
  private
    { Private declarations }
     SaveLx:String;
     Selected_Ruleid:integer;
     SelectedStringRow:Integer;
     MyDataSet:TMYDataSet;
     MyCommand:TMyCommand;

     MyRule:TMakeRuleClass;
     procedure ClearEdit;
     procedure GetInputEdit;
     function  CheckInputEdit:Boolean;
     procedure AddDataType;
     //----------------------
     procedure InitDataTypeStrinGrid;
     function SaveIntoDataBase(Sav:String) :Boolean;
     function  SelectMaxId:Integer;
     procedure OptionTip(Str:String);
     procedure FillListBox(ListB:TListBox) ;
     function  FillMyRuleData(id:Integer;Rule:TMakeRuleClass):Boolean;
     function  FillSelectEditData(Rule:TMakeRuleClass):Boolean;
     procedure SelectComboBoxText(CB:TComboBox;Str:String);
     //
     procedure DispMemoCopySource(Px,Py:Integer);//显示Memo控制快捷菜单
     procedure CopyToPhaseIntoMemoSource;

  public
    { Public declarations }
  end;

var
  Form_MakeRule: TForm_MakeRule;

function CreateMakeRule_inn(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;stdcall;

implementation

{$R *.dfm}

uses Lu_Public_BasicModual,Vcl.Clipbrd, PStope_GzmGuidClass;


function CreateMakeRule_inn(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;stdcall;

begin
       if Assigned(Form_MakeRule) then  FreeAndNil(Form_MakeRule);
       Application.Handle:=AHandle;
       Form_MakeRule:=TForm_MakeRule.Create(Application);
        try
           with Form_MakeRule do begin
               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

                Show;
                SetFocus;
                Result:=Form_MakeRule.Handle ;//函数值
          end ;
        except
           FreeAndNil(Form_MakeRule);
        end;
end;

procedure TForm_MakeRule.AddButtonClick(Sender: TObject);
begin
     ClearEdit;
     SaveLx:='Insert';
     SaveButton.Enabled :=true;
     GroupBox2.Enabled :=true;
end;

procedure TForm_MakeRule.AddDataType;
var
  tmp:TBasicDataParm;
begin
   tmp.DataName :=self.CB_DataType.Text;
   tmp.DataBh:=self.CB_DataType.ItemIndex +1;
   if CB_DataType.ItemIndex=5   then  begin
      tmp.DataType:=TSupportDataType(9);
   end else begin
      tmp.DataType:=TSupportDataType(CB_DataType.ItemIndex +1);
   end;

   tmp.TagStr :=self.Edit_Data_Flag.Text ;
   tmp.UpperCase :=self.RG_Data_Upper.ItemIndex ;
   tmp.DataUnit :=Self.CB_Data_Unit.Text ;
   MyRule.AddBasicDataS(tmp);
end;

procedure TForm_MakeRule.Button1Click(Sender: TObject);
var
  i,j:integer;
  s_tmp:string;
  tmp: TInputData;
begin
   for I := 0 to  self.Memo_Source.Lines.Count -1 do  begin
      tmp:=MyRule.AnalySisData(Memo_Source.Lines[i] ) ;
      if tmp.DataCount >0 then
          MyRule.Add_Anal_DataS(tmp);
   end;

  //分解后 组合成一个完整的字符串在 Memo 中显示
     
   for I := 0 to MyRule.Anal_DataNumber -1 do begin
       s_tmp:='';
       s_tmp:= MyRule.SupProRec.TagStr + ' ' ;
       s_tmp:=s_tmp + intTostr(MyRule.Anal_DataS[i].support ) + ' ';

       if MyRule.MoveSuppFlag  then   begin
           s_tmp:=s_tmp+ MyRule.MoveProRec.TagStr + ' ' ;
           if MyRule.Anal_DataS[i].MoveSupportTag then       s_tmp:=s_tmp + 'true' + ' '
              else s_tmp:=s_tmp + 'False' + ' '  ;
       end;


       s_tmp:=s_tmp + MyRule.DTProRec.TagStr  + ' ';
       s_tmp:=s_tmp + FormatDateTime('YYYY-MM-DD/HH:NN:SS', MyRule.Anal_DataS[i].GenerateTime) + ' ';
       for j := 0 to MyRule.Anal_DataS[i].DataCount-1 do  begin
          s_tmp:=s_tmp + MyRule.Anal_DataS[i].InputDataS[j].TagStr  + ' ';
          s_tmp:=s_tmp + FormatFloat('0.00',MyRule.Anal_DataS[i].InputDataS[j].Data )+ ' ';
       end;

       //
       s_tmp:=s_tmp + 'U '+ FormatFloat('0.00',MyRule.Anal_DataS[i].Useddata ) ;
       self.Memo_Result.Lines.Add(s_tmp)  ;
   end;
end;

procedure TForm_MakeRule.But_AddDataClick(Sender: TObject);
begin
   if Trim(Edit_Data_Flag.Text)='' then  begin
      messagebox(self.Handle,'请标记数据的前导字符!','系统提示',mb_iconerror+mb_ok);
      exit;
   end;

   AddDataType;
   InitDataTypeStrinGrid;
   MyRule.FillDataToStrGrid(Self.StringGrid1);
   self.Edit_Data_Flag.Text :='';
end;

procedure TForm_MakeRule.But_DelDataClick(Sender: TObject);
begin
   if (SelectedStringRow >0 ) and (trim(StringGrid1.Cells[0,SelectedStringRow] )<> '') then  begin
      MyRule.DeleteBasicDataS(SelectedStringRow-1);
      InitDataTypeStrinGrid;
      MyRule.FillDataToStrGrid(StringGrid1);
   end;

end;

procedure TForm_MakeRule.CB_Data_UnitClick(Sender: TObject);
begin
    CB_Data_Unit.SetFocus;
end;

procedure TForm_MakeRule.CB_FileSuffixClick(Sender: TObject);
begin
  CB_FileSuffix.SetFocus ;
end;

procedure TForm_MakeRule.CB_Split_FlagClick(Sender: TObject);
begin
   CB_Split_Flag.SetFocus;
end;

function TForm_MakeRule.CheckInputEdit: Boolean;
begin
   Result:=False;
   if Trim(self.Edit_Rule_name.Text)= '' then  begin
      messagebox(self.Handle,'请填写规则的名称!','系统提示',mb_iconerror+mb_ok);
      exit;
   end;

   if Trim(self.Edit_Sup_Flag.Text)= '' then  begin
      messagebox(self.Handle,'请标记支架的前导字符!','系统提示',mb_iconerror+mb_ok);
      exit;
   end;

   if Trim(self.Edit_Time_Flag.Text)= '' then  begin
      messagebox(self.Handle,'请标记时间的前导字符!','系统提示',mb_iconerror+mb_ok);
      exit;
   end;

   if Trim(self.Edit_DT_String.Text)= '' then  begin
      messagebox(self.Handle,'请录入时间格式!','系统提示',mb_iconerror+mb_ok);
      exit;
   end;
   Result:=true;
end;

procedure TForm_MakeRule.ClearEdit;
begin
     self.Edit_Rule_name.Text :='';
     self.Edit_Sup_Flag.text:='';
     self.Edit_Time_Flag.Text:='';
     self.Edit_DT_String.Text :='';
     self.Edit_Data_Flag.Text :='';
     self.CB_Split_Flag.ItemIndex :=0;
     self.CB_Data_Unit.ItemIndex :=0;
     self.CB_FileSuffix.ItemIndex :=1;
     self.RG_Sup_Upper.ItemIndex :=0;
     self.RG_Time_Upper.ItemIndex:=0;
     self.RG_Data_Upper.ItemIndex :=0;
     self.RG_MoveSupp.ItemIndex :=0;
     Edit_MoveSuP_Value.Text :='';
     self.Edit_MoveSup_ProFlag.Text:='';
     MyRule.ClearDataS ;
     // 清理SringGrid1
     InitDataTypeStrinGrid;

end;

procedure TForm_MakeRule.CopyToPhaseIntoMemoSource;
var
  arr: array[0..99999] of Char;
begin

  Clipboard.GetTextBuf(arr, Length(arr));
  self.Memo_Source.Text :=Arr;
end;

procedure TForm_MakeRule.DeleteButtonClick(Sender: TObject);
var
  sql:string;
  t_s:string;
begin

    if Selected_Ruleid <=0 then  exit;

    t_s:='你确定要删除【'+Edit_Rule_name.Text+'】的数据么?';
    if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;


     sql:='delete from inputRule  where id= '+IntTostr(Selected_Ruleid) ;
     MyCommand.CommandText :=sql;
     MyCommand.Execute ;
           // 清除数据
     Sql:='delete from InputRule_DataType  where   Ruleid =' +IntTostr(Selected_Ruleid) ;
     MyCommand.CommandText :=sql;
     MyCommand.Execute ;

      //刷新ListBox
     FillListBox(ListBox1);

     OptionTip('数据删除成功!');
     DeleteButton.Enabled :=false;
end;

procedure TForm_MakeRule.DispMemoCopySource(Px, Py: Integer);
begin
      PopMemu_Memo.Popup(px,py);
end;

procedure TForm_MakeRule.EditButtonClick(Sender: TObject);
begin
    SaveLx:='Update';
    SaveButton.Enabled :=true;
end;

procedure TForm_MakeRule.Edit_Data_FlagClick(Sender: TObject);
begin
    Edit_Data_Flag.SetFocus;
end;

procedure TForm_MakeRule.Edit_DT_StringClick(Sender: TObject);
begin
   Edit_DT_String.SetFocus;
end;

procedure TForm_MakeRule.Edit_MoveSup_ProFlagClick(Sender: TObject);
begin
  Edit_MoveSup_ProFlag.SetFocus;
end;

procedure TForm_MakeRule.Edit_MoveSuP_ValueClick(Sender: TObject);
begin
   Edit_MoveSuP_Value.SetFocus;
end;

procedure TForm_MakeRule.Edit_Rule_nameClick(Sender: TObject);
begin
   Edit_Rule_name.SetFocus;
end;

procedure TForm_MakeRule.Edit_Sup_FlagClick(Sender: TObject);
begin
   Edit_Sup_Flag.SetFocus;
end;

procedure TForm_MakeRule.Edit_Time_FlagClick(Sender: TObject);
begin
  Edit_Time_Flag.SetFocus;
end;

procedure TForm_MakeRule.ExitButtonClick(Sender: TObject);
begin
   Close;
end;

procedure TForm_MakeRule.FillListBox(ListB: TListBox);
var
  Sql:String;
begin
  ListB.Clear ;
  try
       sql:='select id,RuleName  from  inputRule ';
        MyDataSet.Close ;
        MyDataSet.CommandText :=sql;
        if MyDataSet.Open  then
        while not MyDataSet.Eof  do  begin
           ListB.Items.Add(MyDataSet.FieldByName('id').AsString + '_' +
                           MyDataSet.FieldByName('RuleName').AsString );
           MyDataSet.Next ;
        end;
   finally
     MyDataSet.Close ;
   end;

end;

function TForm_MakeRule.FillMyRuleData(id: Integer;
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

function TForm_MakeRule.FillSelectEditData(Rule: TMakeRuleClass): Boolean;
var
  i:integer;
begin
    Edit_Rule_name.Text :=Rule.RuleName ;
    SelectComboBoxText(CB_FileSuffix,Rule.FileSuffix);
    SelectComboBoxText(self.CB_Split_Flag,Rule.LineSplitTag);

    self.Edit_Sup_Flag.Text :=Rule.SupProRec.TagStr;
    Self.RG_Sup_Upper.ItemIndex:=Rule.SupProRec.UpperCase;

    self.Edit_Time_Flag.Text :=Rule.DTProRec.TagStr;
    Self.RG_Time_Upper.ItemIndex:=Rule.DTProRec.UpperCase;
    self.Edit_DT_String.Text:=Rule.DataTimeStr;

    if Rule.MoveSuppFlag  then  begin
        self.RG_MoveSupp.ItemIndex := 0  ;
        self.Edit_MoveSup_ProFlag.Text :=Rule.MoveProRec.TagStr ;
        self.Edit_MoveSuP_Value.Text :=IntToStr(Rule.MoveSupp_Value );
        self.RG_MoveSup_Upper.ItemIndex :=Rule.MoveProRec.UpperCase ;
        SelectComboBoxText(self.CB_Equal ,Rule.MoveSupp_Equal);
    end else  begin
        self.RG_MoveSupp.ItemIndex := 1;
        self.GB_MoveSup.Enabled :=False;
        self.Edit_MoveSup_ProFlag.Text :='';
        self.Edit_MoveSuP_Value.Text :='';
        self.RG_MoveSup_Upper.ItemIndex :=0;
    end;
    self.CB_Mult_Max_AGV.ItemIndex :=Rule.MuleData_MAX_AGV;
    //更新stringGrid1
    InitDataTypeStrinGrid;
    MyRule.FillDataToStrGrid(Self.StringGrid1);


end;

procedure TForm_MakeRule.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
      {关闭窗体，还得需要发出Close命令}
   if Assigned(Form_MakeRule) then  FreeAndNil(Form_MakeRule);
end;

procedure TForm_MakeRule.FormCreate(Sender: TObject);
begin
   if not Assigned(MyRule) then
      MyRule:=TMakeRuleClass.Create(MainDataModule.ExConn) ;
   SelectedStringRow:=0;
   MyDataSet:=TMYDataSet.Create(nil);
   MyCommand:=TMyCommand.Create(nil);
   MyDataSet.MySqlConnection :=MainDataModule.ExConn;
   MyCommand.MySqlConnection :=MainDataModule.ExConn;
   //
   Selected_Ruleid:=-1;
   TabSheet2.Enabled :=false;
end;

procedure TForm_MakeRule.FormDestroy(Sender: TObject);
begin
    if Assigned(MyRule) then  FreeAndNil(MyRule);
    FreeAndNil(MyDataSet);
    FreeAndNil(MyCommand);
end;

procedure TForm_MakeRule.FormShow(Sender: TObject);
begin
   Public_Basic.InitStatusBar(self.StatusBar1 );
   ClearEdit;
   FillListBox(ListBox1);
end;

procedure TForm_MakeRule.GetInputEdit;
begin
    MyRule.RuleName:=self.Edit_Rule_name.Text ;
    MyRule.FileSuffix:=self.CB_FileSuffix.Text ;
    MyRule.LineSplitTag:=self.CB_Split_Flag.Text;
    MyRule.SupProRec.TagStr :=Self.Edit_Sup_Flag.Text;
    MyRule.SupProRec.UpperCase:=self.RG_Sup_Upper.ItemIndex;

    MyRule.DTProRec.TagStr:=self.Edit_Time_Flag.Text;
    MyRule.DTProRec.UpperCase:=self.RG_Time_Upper.ItemIndex;
    MyRule.DataTimeStr:=self.Edit_DT_String.Text;

    if RG_MoveSupp.ItemIndex =0 then  begin
       MYRule.MoveSuppFlag:=true;
       MYRule.MoveProRec.UpperCase:=self.RG_MoveSup_Upper.ItemIndex ;
       MYRule.MoveSupp_Equal :=self.CB_Equal.Text ;
       MYRule.MoveProRec.TagStr :=self.Edit_MoveSup_ProFlag.Text ;
       MYRule.MoveSupp_Value:=public_Basic.StrToInt_lu(Edit_MoveSuP_Value.Text) ;
    end else begin
       MYRule.MoveSuppFlag:=False;
       MYRule.MoveProRec.UpperCase:=0 ;
       MYRule.MoveSupp_Equal :=self.CB_Equal.Text ;
       MYRule.MoveProRec.TagStr :='' ;
       MYRule.MoveSupp_Value:=0 ;
    end;

    MyRule.MuleData_MAX_AGV:=self.CB_Mult_Max_AGV.ItemIndex ;
end;

procedure TForm_MakeRule.InitDataTypeStrinGrid;
var
   i:integer;
begin

    for i := 0 to  StringGrid1.RowCount - 1 do begin
          StringGrid1.Rows[i].Clear ;
          StringGrid1.RowHeights[i]:=18;
    end;
      StringGrid1.ColCount :=6;
      StringGrid1.RowCount :=3;
      StringGrid1.Font.Size:=8;
      StringGrid1.FixedRows :=1;

      StringGrid1.Cells [0,0]:='序号';
          StringGrid1.ColWidths[0]:=30;
      StringGrid1.Cells [1,0]:='数据名称';
          StringGrid1.ColWidths[1]:=60;
      StringGrid1.Cells [2,0]:='前导标识';
          StringGrid1.ColWidths[2]:=60;
      StringGrid1.Cells [3,0]:='数据单位';
          StringGrid1.ColWidths[3]:=60;
      StringGrid1.Cells [4,0]:='大小写';
          StringGrid1.ColWidths[4]:=60;
end;

procedure TForm_MakeRule.ListBox1Click(Sender: TObject);
var
  LinStr:String;
begin
   if listBox1.itemindex <0 then    exit;

    LinStr:= ListBox1.items[listBox1.itemindex];
    Selected_Ruleid:=public_Basic.StrToInt_lu(LeftStr(LinStr,pos('_',LinStr)-1));
    if Selected_Ruleid >0  then   begin
        FillMyRuleData(Selected_Ruleid,MyRule);
        FillSelectEditData(MyRule);
         TabSheet2.Enabled :=true;
    end;
    self.DeleteButton.Enabled :=True;
    self.EditButton.Enabled :=true;
    GroupBox2.Enabled :=true;
end;

procedure TForm_MakeRule.Memo_SourceClick(Sender: TObject);
begin
   Memo_Source.SetFocus;
end;

procedure TForm_MakeRule.Memo_SourceMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 pt:TPoint;

begin

   if Button=mbRight then  begin
      pt:= self.Memo_Source.ClientToScreen(Point(0,0));
      DispMemoCopySource(pt.X +x,Pt.y+y);
   end;

end;

procedure TForm_MakeRule.N2Click(Sender: TObject);
begin
   self.Memo_Source.Clear ;
end;

procedure TForm_MakeRule.N4Click(Sender: TObject);
begin
    CopyToPhaseIntoMemoSource;
end;

procedure TForm_MakeRule.OptionTip(Str: String);
begin
  StatusBar1.Panels[0].Text :=str;
end;

procedure TForm_MakeRule.RG_MoveSuppClick(Sender: TObject);
begin
   if self.RG_MoveSupp.ItemIndex =0 then  begin
       self.GB_MoveSup.Enabled :=true;

   end else begin
      self.GB_MoveSup.Enabled :=False;
   end;
end;

procedure TForm_MakeRule.SaveButtonClick(Sender: TObject);
begin
   if SaveIntoDataBase(Savelx) then begin
       //刷新ListBox
       FillListBox(ListBox1);
       //
       SaveButton.Enabled :=false;
   end;
end;

function TForm_MakeRule.SaveIntoDataBase(Sav:String):Boolean;
var
  sql,Sql2:string;
  Ruleid,i:integer;
  Move_Tag:Integer;
begin
   Result:=False;
   if not self.CheckInputEdit then   exit;
   GetInputEdit;

   if MyRule.Basic_DataNumber <1 then  begin
      messagebox(self.Handle,'请填充数据规则!','系统提示',mb_iconerror+mb_ok);
      exit;
   end;
   if MyRule.MoveSuppFlag then  Move_Tag:=1
      else Move_Tag:=0;


   if Sav='Insert' then  begin

       try
         sql:='insert into inputRule (RuleName,FileSufix,LineSplitStr,SupProFlag,SupUpper, ' +
              ' TimeProFlag,TimeUpper,TimeString,MoveSupTag,MoveSup_ProFlag,MoveSup_Upper, ' +
              ' Movesup_Equal,Movesup_Value,Mult_Max_AGV )  Values ( ' +
              '''' + MyRule.RuleName + ''',''' +  MyRule.FileSuffix + ''',' +
              '''' + MyRule.LineSplitTag +''',''' + MyRule.SupProRec.TagStr + ''',' +
              IntToStr(MyRule.SupProRec.UpperCase) +',''' + MyRule.DTProRec.TagStr + ''',' +
              IntTostr(MyRule.DTProRec.UpperCase ) +',''' + MyRule.DataTimeStr + ''',' +
              IntTostr(Move_Tag ) +',''' + MyRule.MoveProRec.TagStr + ''',' +
              IntTostr(MyRule.MoveProRec.UpperCase ) +',''' + MyRule.MoveSupp_Equal + ''',' +
              IntTostr(MyRule.MoveSupp_Value ) + ',' + IntTostr(MyRule.MuleData_MAX_AGV  ) +
              ') ';

           MyCommand.CommandText :=sql;
           MyCommand.Execute ;
           Ruleid:=self.SelectMaxId ;
           if Ruleid >0 then  begin
             Sql2:='insert into InputRule_DataType (Ruleid,DataType,DataBh,DataProFlag,DataUpper,DataUnit) values ( ';
              for I := 0 to MyRule.Basic_DataNumber -1  do  begin
                  sql:=Sql2 +IntTostr(Ruleid) + ',''' + MyRule.BasicDataS[i].DataName +''',' +
                       IntTostr(MyRule.BasicDataS[i].DataBh) + ','''  +MyRule.BasicDataS[i].TagStr + ''',' +
                       IntTostr(MyRule.BasicDataS[i].UpperCase ) +','''+MyRule.BasicDataS[i].DataUnit + '''' +
                        ')';
                   MyCommand.CommandText :=sql;
                   MyCommand.Execute ;
              end;
           end;

       finally
          OptionTip('数据保存成功!');
       end;
   end else if Sav='Update' then begin
       try
         if Selected_Ruleid <=0 then  exit;
         sql:='Update inputRule set RuleName =  ''' + MyRule.RuleName + ''', ' +
             ' FileSufix =  ''' + MyRule.FileSuffix +''', ' +
             ' LineSplitStr= ''' + MyRule.LineSplitTag + ''', ' +
             ' SupProFlag= '''+  MyRule.SupProRec.TagStr + ''','  +
             ' SupUpper =' + IntToStr(MyRule.SupProRec.UpperCase) +', ' +
             ' TimeProFlag= '''+  MyRule.DTProRec.TagStr + ''','  +
             ' TimeUpper =' + IntToStr(MyRule.DTProRec.UpperCase) +', ' +
             ' TimeString =''' + MyRule.DataTimeStr  +''', ' +
             ' MoveSupTag = ' +  IntTostr(Move_Tag ) +', '+
             ' MoveSup_ProFlag = ''' + MyRule.MoveProRec.TagStr + ''',' +
             ' MoveSup_Upper = ' +  IntTostr(MyRule.MoveProRec.UpperCase ) +', '+
             ' Movesup_Equal = ''' + MyRule.MoveSupp_Equal + ''',' +
             ' Movesup_Value = ' + IntTostr(MyRule.MoveSupp_Value ) +  ',' +
             ' Mult_Max_AGV = ' + IntTostr(MyRule.MuleData_MAX_AGV ) +
             ' where id= '+IntTostr(Selected_Ruleid) ;

           
           MyCommand.CommandText :=sql;
           MyCommand.Execute ;
           // 清除数据
           Sql2:='delete from InputRule_DataType  where   Ruleid =' +IntTostr(Selected_Ruleid) ;
           MyCommand.CommandText :=sql2;
           MyCommand.Execute ;

             Sql2:='insert into InputRule_DataType (Ruleid,DataType,DataBh,DataProFlag,DataUpper,DataUnit) values ( ';
              for I := 0 to MyRule.Basic_DataNumber -1  do  begin
                  sql:=Sql2 +IntTostr(Selected_Ruleid) + ',''' + MyRule.BasicDataS[i].DataName +''',' +
                       IntTostr(MyRule.BasicDataS[i].DataBh) + ','''  +MyRule.BasicDataS[i].TagStr + ''',' +
                       IntTostr(MyRule.BasicDataS[i].UpperCase ) +','''+MyRule.BasicDataS[i].DataUnit + '''' +
                        ')';
                   MyCommand.CommandText :=sql;
                   MyCommand.Execute ;
              end;


       finally
          OptionTip('数据编辑成功!');
       end;
   end;
   Result:=true;
end;

procedure TForm_MakeRule.SelectComboBoxText(CB: TComboBox; Str: String);
var
  i:integer;
  Selected:Boolean;
begin
    Selected:=False;
    for I := 0 to CB.Items.Count -1 do
        if cb.Items.Strings[i]=str then  begin
           cb.ItemIndex :=i;
           Selected :=true;
           break;
        end;

    if not Selected then begin
       cb.Items.Add(str);
       cb.ItemIndex := CB.Items.Count -1;
    end;

end;

function TForm_MakeRule.SelectMaxId: Integer;
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

procedure TForm_MakeRule.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
   SelectedStringRow:= ARow;
end;


end.    // end unit

