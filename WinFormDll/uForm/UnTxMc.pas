unit UnTxMc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ImgList, ComCtrls, ToolWin, ExtCtrls, System.ImageList,
  UMainDataModule;

type
  TTxMcForm = class(TForm)
    CoolBar1: TCoolBar;
    StringGrid1: TStringGrid;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    Addbtn: TToolButton;
    savebtn: TToolButton;
    deletebtn: TToolButton;
    exitbtn: TToolButton;
    Panel1: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Edit1: TEdit;
    StatusBar1: TStatusBar;
    Edit_MeiKuang: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure AddbtnClick(Sender: TObject);
    procedure savebtnClick(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure exitbtnClick(Sender: TObject);
    procedure deletebtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
   // procedure AddButtonClick(Sender: TObject);
  private
    { Private declarations }
    KARow:integer;
    MySqlDataSet1:TMyDataSet;
    MyCommand1:TMyCommand;
    MeiKuangName:String;
    MeiKuangid:integer;
    Save_lx:String;
    procedure InitSGrid;
    procedure FillGrid(S_id:String);
    procedure OptionTip(Str:String);
  public
    { Public declarations }
    mcId:integer;

  end;


var
  ExMcForm: TTxMcForm;
function CreateFormMC(AHandle:THandle;ACaption,KName:string;Mkid:Integer):integer;stdcall;

implementation
uses  UnEditGzk, UnDetail,  Lu_Public_BasicModual;

{$R *.dfm}

//内部初始化工作面函数
function CreateFormMC(AHandle:THandle;ACaption,KName:string;Mkid:Integer):integer;stdcall;
begin
       Result:=0;//函数值
       ExMcForm:=TTxMcForm.Create(nil);
        try
            ExMcForm.Caption:=ACaption;
            ExMcForm.WindowState:= wsNormal;
            ExMcForm.ParentWindow:=Ahandle;
            ExMcForm.Top:=70;
            ExMcForm.Left :=120;
            ExMcForm.MeiKuangName:=KName;
            ExMcForm.MeiKuangid:=Mkid ;
            ExMcForm.Show;

            Result:=1;//函数值
        except
            FreeAndNil(ExMcForm);
        end;
end;

procedure TTxMcForm.FillGrid(S_id: String);
var
   sqlStr:string;
   n:integer;
begin
    InitSGrid();
    sqlStr:='select m.KuangJingBianHao,k.MeiKuangMing,m.MeiCengMing,m.ID from Meiceng as m,KuangJingXinXiBiao as k '+
            ' where m.KuangJingBianHao=k.id and m.KuangJingBianHao='+S_id;
    MySqlDataSet1.Close;
    MySqlDataSet1.CommandText:=sqlStr;
    MySqlDataSet1.Open;
     n:=1;
    self.StringGrid1.RowCount:=MySqlDataSet1.RecordCount+3;
    while not MySqlDataSet1.Eof do
    begin
      self.StringGrid1.Cells[0,n]:=inttostr(n);
      self.StringGrid1.Cells[1,n]:=  MySqlDataSet1.FieldByName('KuangJingBianHao').AsString+'_'+
                    MySqlDataSet1.FieldByName('MeiKuangMing').AsString;

      self.StringGrid1.cells[2,n]:= MySqlDataSet1.FieldByName('MeiCengMing').AsString;
      self.StringGrid1.cells[3,n]:= MySqlDataSet1.FieldByName('ID').AsString;
      n:=n+1;

      MySqlDataSet1.Next;
    end;
    MySqlDataSet1.Close;
end;

procedure TTxMcForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    if  MainDataModule.UseFormName ='Gzm' then begin
        if Assigned(innGzmForm) then innGzmForm.Fill_MCBh_Combo;
    end else if MainDataModule.UseFormName='ZkDetail'  then begin
        if assigned(ZkDetail_inn) then ZkDetail_inn.Fill_McBH_Combo;
    end;

   if Assigned( ExMcForm) then  FreeAndNil(ExMcForm);

end;

procedure TTxMcForm.FormCreate(Sender: TObject);

begin
   //
    MySqlDataSet1:=TMyDataSet.Create(nil);
    MySqlDataSet1.MySqlConnection :=MainDataModule.ExConn;

    MyCommand1:=TMyCommand.Create (nil);
    MyCommand1.MySqlConnection :=MainDataModule.ExConn;     //
    savebtn.Enabled:=false;
    deletebtn.Enabled:=false;
    Edit1.Enabled:=false;
end;

procedure TTxMcForm.FormDestroy(Sender: TObject);
begin
    FreeAndNil(MySqlDataSet1);
    FreeAndNil(MyCommand1);
end;

procedure TTxMcForm.FormShow(Sender: TObject);
begin
  Edit_MeiKuang.Text :=MeiKuangName;
  FillGrid(IntToStr(Meikuangid));
  PubLic_Basic.InitStatusBar(self.StatusBar1);
end;

procedure TTxMcForm.InitSGrid;
var
  i:integer;
begin
     for i := 1 to  StringGrid1.RowCount - 1 do
          StringGrid1.Rows[i].Clear ;

     self.StringGrid1.ColCount:=4;
     self.StringGrid1.Cells[0,0]:='编号';
     self.StringGrid1.Cells[1,0]:='矿井';
     self.StringGrid1.ColWidths[1]:=200;
     self.StringGrid1.Cells[2,0]:='煤层';
     self.StringGrid1.Cells[3,0]:='主键';
     self.StringGrid1.ColWidths[3]:=0;

end;

procedure TTxMcForm.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  str:String;

begin
     if (ARow=0) or (kArow=ARow) then   exit;
         KARow:=AROW;

     if length(Trim(StringGrid1.Cells[1,ARow]))>0 then  begin
          mcId:=StrToInt(Trim(StringGrid1.Cells[3,ARow]));    // 煤层编号
       end else begin
          exit;
       end;
       tag:=1;
      savebtn.Enabled:=false;
      deletebtn.Enabled:=true;
end;

procedure TTxMcForm.AddbtnClick(Sender: TObject);
begin
    Save_lx:='insert';
    Edit1.Text :='';
    Edit1.Enabled:=true;
    savebtn.Enabled:=true;
    OptionTip('正在进行【添加】操作!');
end;

procedure TTxMcForm.savebtnClick(Sender: TObject);
var
IMcSql:String;
begin
      if (Trim(Edit1.Text)='') or (Meikuangid<1)  then begin
          messagebox(Handle,'数据不能为空 ','系统提示',mb_iconerror+mb_ok);
         exit
      end;

    IMcSql:='insert into MeiCeng (KuangJingBianHao,MeiCengMing) values ('+
           IntToStr(Meikuangid)+','''+self.Edit1.Text+''')';
    MyCommand1.CommandText:=IMcSql;
    MyCommand1.Execute;

    FillGrid(IntToStr(Meikuangid));
       OptionTip('数据保存成功!');

     savebtn.Enabled:=false;
     deletebtn.Enabled:=false;
     Edit1.Text:='';

   Edit1.Enabled:=false;
end;

procedure TTxMcForm.deletebtnClick(Sender: TObject);
var
sqlStr:string;
begin
    sqlStr:='select * from zkycb where mcId='+inttostr(mcId);
    MySqlDataSet1.Close;
    MySqlDataSet1.CommandText:=sqlStr;
    MySqlDataSet1.Open;
    if MySqlDataSet1.RecordCount>0 then
    begin
      messagebox(self.Handle,'此煤层使用中,请勿删除 ','系统提示',mb_iconerror+mb_ok);

      exit;
    end;
    sqlStr:='select * from cqcsb where mcId='+inttostr(mcId);
    MySqlDataSet1.Close;
    MySqlDataSet1.CommandText:=sqlStr;
    MySqlDataSet1.Open;
    if MySqlDataSet1.RecordCount>0 then
    begin
       messagebox(self.Handle,'此煤层使用中,请勿删除 ','系统提示',mb_iconerror+mb_ok);
       exit;
    end;
    sqlStr:='delete from  meiceng where ID='+inttostr(mcId);
   try
    MyCommand1.CommandText:=sqlStr;
    MyCommand1.Execute;
   except
     exit;
   end;
    OptionTip('数据删除成功!');
    FillGrid(IntToStr(Meikuangid));
    Edit1.Enabled:=false;
end;

procedure TTxMcForm.Edit1Click(Sender: TObject);
begin
   Edit1.SetFocus;
end;

procedure TTxMcForm.exitbtnClick(Sender: TObject);
begin
    self.Close ;
end;


procedure TTxMcForm.OptionTip(Str: String);
begin
     self.StatusBar1.Panels[0].Text :=str;
end;

end.
