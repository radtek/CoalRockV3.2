unit UncoalName;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, ComCtrls, ToolWin, ExtCtrls, OleCtrls,
  Grids, System.ImageList,UMainDataModule, Vcl.ExtDlgs;

type
  TZkCoalName = class(TForm)
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
    Label1: TLabel;
    Label2: TLabel;
    Edit_MeiKuang: TEdit;
    JItuanCombo: TComboBox;
    StatusBar1: TStatusBar;
    Label3: TLabel;
    Edit_JItuan: TEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    StringGrid1: TStringGrid;
    Panel3: TPanel;
    Label4: TLabel;
    Edit1: TEdit;
    OpenFileButton: TButton;
    Image1: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    Panel4: TPanel;
    SaveFileButton: TButton;
    Button1: TButton;
    Label5: TLabel;
    Memoadd: TMemo;
    procedure ExitButtonClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure Edit_MeiKuangClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure JItuanComboChange(Sender: TObject);
    procedure JItuanComboClick(Sender: TObject);
    procedure Edit_JItuanClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure OpenFileButtonClick(Sender: TObject);
    procedure SaveFileButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure MemoaddClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    { Private declarations }
    FAdoDataSet1:TMyDataSet;
    FAdoCommand:TMyCommand;
    JT_Name,Mk_Name:AnsiString;   //选中的NO,KName,JName
    Save_Lx:string; //
    i_Kuang_id,i_JiTuan_id:integer; // 选中的NO
    KArow,Kcol :integer;//stringgrid 选中的行与列
    sFileName,sExtName:String;
    procedure SetCellHead; //设置Cell表头
    procedure FillCell(id:integer); //填充表格
    function SelectJituanid(Name:String):integer;//返回集团的编号
    procedure OptionTip(Str:String);
    procedure RefreshEditEnabled(Value:Boolean);
    procedure SetEditValue(KName,JName:string);
    function ReadImageFormDataBase(Image:Timage;id:integer):string;
    function SaveFileIntoDAtaBase(sFileName:string;id:integer):Boolean;
    function ReadImageFromDataBAse(sFileName:string;id:integer):Boolean;
    function SetMapInfomation(Value:Boolean):Boolean;
  public
    { Public declarations }
  end;

 function CreatecoalName_inn(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;stdcall;

 var
   innCoalName:TZkCoalName ;


implementation

{$R *.dfm}

uses uWinFrameClass,  Lu_Public_BasicModual,pngimage,Jpeg, DataService,
  UGuidMap;


//内部初始化工作面函数
function CreatecoalName_inn(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;stdcall;

begin
       if Assigned(innCoalName) then  FreeAndNil(innCoalName);
       Application.Handle:=AHandle;
       innCoalName:=TZkCoalName.Create(Application);
        try
           with innCoalName do begin
               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

                Show;
                SetFocus;
                Result:=innCoalName.Handle ;//函数值
          end ;
        except
           FreeAndNil(innCoalName);
        end;
end;

procedure TZkCoalName.FormActivate(Sender: TObject);
begin
     MainDataModule.MySQlFillComBox(FAdoDataSet1,JituanCombo,'select * from jituanName order by id','id','DwName','');
     self.FillCell(0) ;
     PubLic_Basic.InitStatusBar (self.StatusBar1);
     AddButton.Click ;
end;

procedure TZkCoalName.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    {关闭窗体，还得需要发出Close命令}

   if Assigned(Form_MapMain) then  FreeAndNil(Form_MapMain);

   if Assigned(innCoalName) then  FreeAndNil(innCoalName);


end;

procedure TZkCoalName.FormCreate(Sender: TObject);
begin
     FAdoDataSet1:=TMyDataSet.Create(nil);

     FAdoCommand:=TMyCommand.Create(nil);
     FAdoDataSet1.MySqlConnection:=MainDataModule.ExConn;

     FAdoCommand.MySqlConnection:=MainDataModule.ExConn;

     self.FillCell(0) ;
    

end;

procedure TZkCoalName.FormDestroy(Sender: TObject);
begin
   {只有发出Free 主类的命令时， 才调用Destory}
   FreeAndNil(FAdoDataSet1);
   FreeAndNil( FAdoCommand);
end;

procedure TZkCoalName.JItuanComboChange(Sender: TObject);
 var
   s_temp:Str_DT_array;
   C1:integer;
begin
   s_temp:=Public_Basic.split(jituanCombo.Text,'_',C1);
   if C1>1 then  begin
     i_JiTuan_id:=strToInt(s_temp[0]);
     Edit_Jituan.Text := s_temp[1];
     FillCell(i_JiTuan_id) ;
   end else begin
     i_JiTuan_id:=-1;
     FillCell(0) ;
   end;

end;

procedure TZkCoalName.JItuanComboClick(Sender: TObject);
begin
    JItuanCombo.SetFocus;
end;

procedure TZkCoalName.MemoaddClick(Sender: TObject);
begin
    Memoadd.SetFocus;
end;

procedure TZkCoalName.OptionTip(Str: String);
begin
    self.StatusBar1.Panels[0].Text :=str;
end;

procedure TZkCoalName.PageControl1Change(Sender: TObject);
begin
    // 控制页面显示
  if PageControl1.ActivePage=TabSheet2 then begin
    if Public_Basic.ReadDisplayWholeScreen>0 then
       SetMapInfomation( true ) else SetMapInfomation( False );
  end;
end;

function TZkCoalName.ReadImageFormDataBase(Image: Timage; id: integer): string;
begin

end;

function TZkCoalName.ReadImageFromDataBAse(sFileName: string;
  id: integer): Boolean;
begin

end;

procedure TZkCoalName.RefreshEditEnabled(Value: Boolean);
begin
   Edit_Jituan.Enabled:=Value;
   Edit_MeiKuang.Enabled:=Value;
end;

procedure TZkCoalName.AddButtonClick(Sender: TObject);
begin
    RefreshEditEnabled(true);
    Edit_MeiKuang.Text :='';

    i_Kuang_id:=0;i_Jituan_id:=0;

    //控制按钮
    self.SaveButton.Enabled :=true;
    self.EditButton.Enabled :=false;
    Save_Lx:='insert';
    OptionTip('正在进行【添加】操作!');
    self.JItuanCombo.ItemIndex:=0;
    Edit_MeiKuang.SetFocus;
end;

procedure TZkCoalName.OpenFileButtonClick(Sender: TObject);
var
   Png:TPngObject;
   jpg: TJPEGImage;
   FileHandle:integer;
begin
    self.OpenPictureDialog1.Execute() ;

    FileHandle := FileOpen(openpicturedialog1.FileName, 0);
    if GetFileSize(FileHandle, nil) >3*1000*1000 then begin
       messagebox(self.Handle,'文件大于3M,请压缩后再来！','系统提示',MB_ICONINFORMATION+mb_ok);
       FileClose(FileHandle);
       exit;
    end;
    FileClose(FileHandle);

    Edit1.Text := OpenPictureDialog1.FileName;
    sFileName:=ExtractFileName(OpenPictureDialog1.FileName);
    sExtName:=UpperCase(ExtractFileExt(openpicturedialog1.FileName ));


   if sExtName='.PNG' then begin
      Png:=TPngObject.Create;
      png.LoadFromFile(Edit1.Text);
      Image1.Picture.Bitmap.Assign(PNG);
      Png.Free ;
   end else if sExtName='.BMP' then begin
      Image1.Picture.LoadFromFile(Edit1.Text);
   end else if sExtName='.JPG' then begin
      jpg := TJPEGImage.Create;
      jpg.LoadFromFile(Edit1.Text);
      Image1.Picture.Bitmap.Assign(jpg); // 因为 img 控件是基于bmp的
      jpg.Free;
   end else begin
      exit;
   end;

   SaveFileButton.Enabled :=true;
   Memoadd.Text :='';
end;

procedure TZkCoalName.SaveFileButtonClick(Sender: TObject);
var
  Pic_Path:String;
begin
   if  (i_Kuang_id>0) and (Edit1.Text<>'')  then
     if(SaveFileIntoDAtaBase(Edit1.Text,i_Kuang_id)) then begin
          OptionTip('数据存储成功');
         SaveFileButton.Enabled :=false;
         if MainDataModule.DataType='ACCESS'  then  begin
            Pic_Path:=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\CoalBmp_'+IntToStr(i_Kuang_id)+'.JPG';
            if  FileExists(Pic_Path)  then   DeleteFile(Pic_Path);
            Image1.Picture.SaveToFile(Pic_Path);
         end else begin
            Pic_Path:=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\DataBase_'+IntToStr(i_Kuang_id)+'.JPG';
            if  FileExists(Pic_Path)  then   DeleteFile(Pic_Path) ;
         end;
         public_Basic.WriteUpdateCoalBmp(true);
     end else begin
         messagebox(self.Handle,'数据存储失败！','系统提示',MB_ICONINFORMATION+mb_ok);
     end;


end;

function TZkCoalName.SaveFileIntoDAtaBase(sFileName: string;
  id: integer): Boolean;
var
   Fs:TFileStream;
   sql,ExtName:string;
begin
   Result:=true;
   try
      ExtName:=UpperCase(Extractfileext(sFileName));
      FS := TFileStream.Create(sFileName,fmOpenRead);
      FAdoDataSet1.SetFieldImageName('KuangJingXinXiBiao','MemoBMP');
      Result:= FAdoDataSet1.SaveImageIntoTable('id','ImageFileName', ExtName,Memoadd.Text,id,FS) ;
      FS.Free ;
   except
      Result:=False;
   end;

end;

procedure TZkCoalName.Button1Click(Sender: TObject);
var
  My_DataService:TDataService;
  Pic_Path:string;
begin
   Image1.Picture.Bitmap:=nil;
   try
    if not Assigned(My_DataService) then
       if MainDataModule.DataType = 'ACCESS'  then  begin
            Pic_Path:=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\CoalBmp_'+IntToStr(i_Kuang_id)+'.JPG';
            Image1.Picture.LoadFromFile(Pic_Path);
       end else begin
            MY_DataService:=TDataService.Create ;
            {tableName, Imagefield,FileField,  idName: string; idValue: integer; var BMap: TBitMap}
            MY_DataService.GetImageFromDataBase('KuangJingXinXiBiao','MemoBMP','ImageFileName','id',i_Kuang_id,Image1.Picture.Bitmap);
       end;
   finally
     // FreeAndNil(My_DataService);
   end;

end;

procedure TZkCoalName.DeleteButtonClick(Sender: TObject);
 Var
   t_s:String;
   t_sql:String;
   t_sql1:String;
begin
    if i_Kuang_id<1 then  exit;
    t_s:='你确定要删除'+jituanCombo.text+','+Edit_MeiKuang.text+'的数据么?';
    if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;
    //
    t_sql:='select * from zkb where Kid='+inttostr(i_Kuang_id);
    FAdoDataSet1.Close;
    FAdoDataSet1.CommandText:=t_sql;
    FAdoDataSet1.Open;
    if FAdoDataSet1.RecordCount>0 then     begin
        messagebox(self.Handle,'此矿井下有钻孔信息，请勿删除！','系统提示',mb_iconerror+mb_ok);
        exit;
    end;
    t_sql:='select * from cqcsb where Kid='+inttostr(i_Kuang_id);
    FAdoDataSet1.Close;
    FAdoDataSet1.CommandText:=t_sql;
    FAdoDataSet1.Open;
    if FAdoDataSet1.RecordCount>0 then  begin
      messagebox(self.Handle,'此矿井下有工作面信息,请勿删除！','系统提示',mb_iconerror+mb_ok);
      exit;
    end;
   // start delete
      t_sql1:='delete from  KuangJingXinXiBiao  where id ='+IntToStr(i_Kuang_id);
      FAdoCommand.CommandText :=t_sql1;
      FAdoCommand.Execute(MainDataModule.ExUserName)  ;
      FAdoDataSet1.Close ;
      FAdoDataSet1.CommandText:='select jituanid from  KuangJingXinXiBiao ' +
          '  where jituanid= ' +intToStr(i_JiTuan_id);
      FAdoDataSet1.Open;
      if FAdoDataSet1.RecordCount<1 then begin
          t_sql1:='delete from  jituanName  where id ='+IntToStr(i_JiTuan_id);
          FAdoCommand.CommandText :=t_sql1;
          FAdoCommand.Execute ;
      end;
      FAdoDataSet1.Close ;
     //填充Cell
    MainDataModule.MySQlFillComBox(FAdoDataSet1,JituanCombo,'select * from jituanName order by id','id','DwName','');
    self.FillCell(0) ;
    //控制按钮
    self.DeleteButton.Enabled :=false;
    self.AddButton.Enabled :=true;
    // 控制录入框
    // self.T_KName.Text :='';
     Edit_MeiKuang.Text :='';

    //提示信息
    OptionTip('数据删除成功');
    i_Kuang_id :=0;
end;

procedure TZkCoalName.EditButtonClick(Sender: TObject);
begin
  //控制按钮
     EditButton.Enabled :=false;
     SaveButton.Enabled :=true;
     AddButton.Enabled:=false;
   //控制录入框
    self.RefreshEditEnabled(true) ;
    //Edit_Jituan.Enabled:=FALSE;
    Save_Lx:='update'; //
    OptionTip('正在进行【修改】操作!');
    Edit_MeiKuang.SetFocus;
end;

procedure TZkCoalName.ExitButtonClick(Sender: TObject);
begin
  self.Close ;
end;
procedure TZkCoalName.SaveButtonClick(Sender: TObject);
 var
  t_sql:String;
  t_sql1:String;
  id_temp:integer;
begin
    if length(trim(Edit_MeiKuang.Text ))<1 then   exit;
    Jt_Name:= trim(Edit_JItuan.Text );
    if length(Jt_Name)<1 then   exit;


    id_temp:=self.SelectJituanid(Jt_Name);
    if id_temp>0 then  i_JiTuan_id:= id_temp;

    if i_JiTuan_id <=0 then  begin
       t_sql1:='insert into JituanName(DwName) values ( '
                 + ''''+Jt_Name +''')';
        FAdoCommand.CommandText :=t_sql1;
        FAdoCommand.Execute(MainDataModule.ExUserName) ;
        i_JiTuan_id:=self.SelectJituanid(Jt_Name);
    end else begin
        t_sql1:='update JituanName set DwName='''+Jt_Name+''''
                + ' where id = '+ IntToStr(i_JiTuan_id);
        FAdoCommand.CommandText :=t_sql1;
        FAdoCommand.Execute ;
        t_sql1:='update KuangJingXinXiBiao  set JituanName ='''+
                  Jt_Name+''' where jituanID = '+IntToStr(i_JiTuan_id);
        FAdoCommand.CommandText :=t_sql1;
        FAdoCommand.Execute ;
    end;

    if Save_Lx='insert' then   begin
        t_sql1:='insert into KuangJingXinXiBiao(MeiKuangMing,JituanName,jituanID,mapxbz) values('
                 + ''''+Edit_MeiKuang.Text +''','''+Jt_Name+''','+InttoStr(i_JiTuan_id)+',0)';
        FAdoCommand.CommandText :=t_sql1;
        FAdoCommand.Execute(MainDataModule.ExUserName) ;
    end else if Save_Lx='update' then begin
          if i_Kuang_id <1 then  exit;
          t_sql1:='update KuangJingXinXiBiao  set MeiKuangMing ='''+
                  Edit_MeiKuang.Text+''', mapxbz=0   where id = '+IntToStr(i_Kuang_id);
          FAdoCommand.CommandText :=t_sql1;
          FAdoCommand.Execute(MainDataModule.ExUserName) ;
    end;

    //填充Cell
    MainDataModule.MySQlFillComBox(FAdoDataSet1,JituanCombo,'select * from jituanName order by id','id','DwName','');

    self.FillCell(0) ;
    //控制按钮
    self.SaveButton.Enabled :=false;
    self.AddButton.Enabled :=true;
    // 控制录入框

     self.RefreshEditEnabled(False) ;
     Edit_MeiKuang.Text :='';
    //提示信息
     OptionTip('数据存储成功!');

     i_Kuang_id :=0;
     Save_Lx:=''; //
end;

function TZkCoalName.SelectJituanid(Name: String): integer;
var
  id:integer;
begin
      id:=-1;
      FAdoDataSet1.Close();
      FAdoDataSet1.CommandText:='select  j.id as Jid from jituanName as j' +
             ' where DwName=''' +Name +'''' ;
      FAdoDataSet1.Open;
      if FAdoDataSet1.RecordCount>0 then
        id:=FAdoDataSet1.FieldByName('jid').AsInteger;

     FAdoDataSet1.Close();
     Result:=id;
end;

procedure TZkCoalName.SetCellHead;
var
   i:integer;
begin
      // 清空单元格
      for i := 1 to  StringGrid1.RowCount - 1 do
          StringGrid1.Rows[i].Clear ;
     self.StringGrid1.ColCount :=4;
     self.StringGrid1.RowCount :=6;
     self.StringGrid1.Cells [0,0]:='序号';
     self.StringGrid1.Cells [1,0]:='编号';
     self.StringGrid1.Cells [2,0]:='集团名';
     self.StringGrid1.Cells [3,0]:='煤矿名';

     self.StringGrid1.ColWidths[0]:=100;
     self.StringGrid1.ColWidths[1]:=100;
     self.StringGrid1.ColWidths[2]:=150;
     self.StringGrid1.ColWidths[3]:=150;


 end;

 procedure TZkCoalName.SetEditValue(KName, JName: string);
begin
   Edit_MeiKuang.Text :=JName;
   Edit_Jituan.Text :=KName;
end;

function TZkCoalName.SetMapInfomation(Value:Boolean): Boolean;
begin
   if Value then  begin
      PageControl1.Pages[1].TabVisible:=true;
      PageControl1.Pages[2].TabVisible:=true;
      if not Assigned(Form_MapMain) then
         CreateMapFrom(TabSheet2.Handle,'地图标注',TabSheet2.Width,TabSheet2.Height,0);

   end else begin
      PageControl1.Pages[1].TabVisible:=False;
      PageControl1.Pages[2].TabVisible:=False;
   end;



end;

procedure TZkCoalName.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
   s_temp:Str_DT_array;
   C1,i:integer;
begin
     if (ARow=0) or (kArow=ARow) then   exit;
     KARow:=AROW;
     Edit_Jituan.Text :=Trim(StringGrid1.Cells[2,ARow]);
     Edit_MeiKuang.Text :=Trim(StringGrid1.Cells[3,ARow]);
     if (length(Trim(StringGrid1.Cells[1,ARow]))>0) and (ARow>0) then
         i_Kuang_id:=StrToInt(Trim(StringGrid1.Cells[1,ARow]));
     if (length(Trim(StringGrid1.Cells[4,ARow]))>0) and (ARow>0) then
         i_Jituan_id:=StrToInt(Trim(StringGrid1.Cells[4,ARow]));
     //控制按钮
     self.EditButton.Enabled :=true;
     self.DeleteButton.Enabled :=true;
end;

procedure TZkCoalName.Edit_MeiKuangClick(Sender: TObject);
begin
    Edit_MeiKuang.SetFocus;
end;

procedure TZkCoalName.Edit_JItuanClick(Sender: TObject);
begin
   Edit_Jituan.SetFocus;
end;

procedure TZkCoalName.FillCell(id:integer); //填充表格
  var
    t_col,t_row,i:integer;
 begin
       SetCellHead;

      //
       FAdoDataSet1.Close();
       if id=0 then   begin
           FAdoDataSet1.CommandText:='select a.id as Kid, a.MeiKuangMing as kName,b.DwName as JName,a.jituanid as Jid  '+
              'from KuangJingXinXiBiao  as a,jituanname  as b where a.jituanid=b.id order by a.id';
       end else begin
           FAdoDataSet1.CommandText:='select a.id as Kid, a.MeiKuangMing as kName,b.DwName as JName,a.jituanid as Jid  ' +
             ' from KuangJingXinXiBiao as a,jituanname as b  where a.jituanid=b.id and b.id=' +intTostr(id) +' order by a.id' ;
       end;
       FAdoDataSet1.Open;
       t_col:=1;t_row:=1;

       StringGrid1.RowCount:=FAdoDataSet1.RecordCount+3;
       while not FAdoDataSet1.Eof  do   begin
             self.StringGrid1.Cells [0,t_row]:= inttostr(t_row);
             self.StringGrid1.Cells [1,t_row]:=FAdoDataSet1.FieldByName('kid').AsString ;   //编号
             self.StringGrid1.Cells [2,t_row]:=FAdoDataSet1.FieldByName('Jname').AsString; // 集团名
             self.StringGrid1.Cells [3,t_row]:=FAdoDataSet1.FieldByName('KName').AsString; // 矿名
             self.StringGrid1.Cells [4,t_row]:=FAdoDataSet1.FieldByName('jid').AsString; // 矿名

             t_row:=t_row+1;
             FAdoDataSet1.Next ;
         end;
         FAdoDataSet1.Close ;
   end;



end.
