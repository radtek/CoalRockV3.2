unit UFormEditPressData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,Vcl.StdCtrls ,
  UMainDataModule,uDrawGraphClass, Vcl.Buttons, Vcl.CheckLst ,System.TypInfo,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart,
  VCLTee.TeeSurfa, Vcl.Menus, System.ImageList, Vcl.ImgList, Vcl.ToolWin,
  Vcl.Grids,Vcl.Clipbrd, VCLTee.TeeLegendPalette, VCLTee.TeePieTool,
  VCLTee.TeeTriSurface, VCLTee.TeePoin3, VCLTee.TeeTools, VCLTee.TeeDragPoint,
  VCLTee.Series,VCLTee.TeeMapSeries, Vcl.ExtDlgs,
  UMakeRuleClass ,Lu_Public_BasicModual
  ;

 type

  TEdit_PressDataForm = class(TForm)
    StatusBar1: TStatusBar;
    Main_PageControl: TPageControl;
    ImageList1: TImageList;
    Pop_Rock_Paste: TMenuItem;
    Pop_Rock_DeleteOne: TMenuItem;
    N10: TMenuItem;
    Pop_Rock_Save: TMenuItem;
    N12: TMenuItem;
    Pop_Rock_Refresh: TMenuItem;
    N14: TMenuItem;
    Pop_Rock_DeletaAll: TMenuItem;
    N5: TMenuItem;
    Pop_Rock_Input_Memo: TMenuItem;
    Pop_Rock_Disp_Memo: TMenuItem;
    N7: TMenuItem;
    N11: TMenuItem;
    Pop_Rock_Disp_50: TMenuItem;
    Pop_Rock_Disp_300: TMenuItem;
    Pop_Rock_Disp_All: TMenuItem;
    Panel_ProcessBar: TPanel;
    FirstPGBar: TProgressBar;
    SecondPGBar: TProgressBar;
    Pop_Rock_Auto: TMenuItem;
    PopupMenu_RockData: TPopupMenu;
    Pop_Rock_SaveExcel: TMenuItem;
    PageControl4: TPageControl;
    TabSheet11: TTabSheet;
    RockDataGrid: TStringGrid;
    RockDataRightGrid: TStringGrid;
    ScrollBar1: TScrollBar;
    RG_Rock_DataType: TRadioGroup;
    RockDataGrid_Edit: TStringGrid;
    ToolBar1: TToolBar;
    AddButton: TToolButton;
    EditButton: TToolButton;
    SaveButton: TToolButton;
    ToolButton1: TToolButton;
    ExitButton: TToolButton;
    N1: TMenuItem;
    Pop_Rock_DeletaQAll: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure FormResize(Sender: TObject);
    procedure RG_Yun_MainClick(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure FootageGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Button7Click(Sender: TObject);

    procedure Edit_SupportNumberKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_interVal_supportKeyPress(Sender: TObject; var Key: Char);

    procedure RockDataGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure RockDataRightGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure RockDataGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure RockDataGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ScrollBar1Change(Sender: TObject);
    procedure Pop_Rock_PasteClick(Sender: TObject);
    procedure Pop_Rock_Input_MemoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Pop_Rock_Disp_MemoClick(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure Pop_Rock_SaveClick(Sender: TObject);
    procedure Pop_Rock_Disp_50Click(Sender: TObject);
    procedure Pop_Rock_Disp_300Click(Sender: TObject);
    procedure Pop_Rock_Disp_AllClick(Sender: TObject);
    procedure Pop_Rock_DeletaAllClick(Sender: TObject);
    procedure Pop_Rock_RefreshClick(Sender: TObject);
    procedure Pop_Rock_DeleteOneClick(Sender: TObject);
    procedure Main_PageControlDrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
    procedure PageControl4DrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);

    procedure ContourPop_ChangUnitClick(Sender: TObject);
    procedure Edit_StartPtKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_EndPtKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_Sup_ConKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_Foot_ConKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_Min_PtKeyPress(Sender: TObject; var Key: Char);
    procedure TreeView1Collapsed(Sender: TObject; Node: TTreeNode);
    procedure TreeView1Expanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);

    procedure Edit_AxisKeyPress(Sender: TObject; var Key: Char);
    procedure EndEditKeyPress(Sender: TObject; var Key: Char);

    procedure Edit_StartDaoKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_EndDaoKeyPress(Sender: TObject; var Key: Char);

    procedure ChartPageControlDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);


    procedure Pop_Rock_AutoClick(Sender: TObject);
    procedure RG_Rock_DataTypeClick(Sender: TObject);
    procedure Pop_Rock_SaveExcelClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure Pop_Rock_DeletaQAllClick(Sender: TObject);

  private
    { Private declarations     }
     FootStringGrid_SelectCol,FootStringGrid_SelectRow:integer;
     RockStringGrid_SelectCol,RockStringGrid_SelectRow:integer;
     DataPress_Unit_Flag:integer; // 1为MPa  2为Bar
     SelectRockDataRecordNumber:String;// 查询记录 的数量
     Mouse_x,Mouse_y:integer;
     MySqlDataSet1:TMyDataSet;
     MySqlDataSet2:TMyDataSet;
     MyCommand1:TMyCommand;
     DrawGzm:TDrawGrap;
     s_MinName,S_WorkFaceName:string;
     StringGroupColor:String;
     CurrentChart:String;
     SaveBmpPath:String; //图片文件保存的路径
     BasicJinDao:TBasicJinDao;
     //
     MapSeries:TMapSeries;
     TreeView_Stepid,TreeView_APolid:integer;
     Kyfx_StringMeregExcel:Rec_StringToExcel_Array;

    procedure RefreshForm; //刷新整个界面的数据
    function  InitDateTimeFootage :Boolean;  //在工作面编号确定的情况下进行的初始化
    procedure OptionTip(index:integer;Str:String);
    procedure AutoLoadcomboBox(MkName,WkName:string);
   //-----------------------
    function  GetDataClass:Boolean;    //获取数据选择结果
    function  GetTimeAndFootage:Boolean; // 获取开始时间与进尺的 选择结果
    procedure RefreshMemoInfo(Memo:TMemo);  // 刷新消息窗口
    procedure RefreshInputData; //对录入条件进行更新

    procedure RefreshRockPressStringGrid(Flag:string);

    function  GetBatInputDataMaxGenTime(Support:integer):TDateTime;
    Procedure FillBasicJinDao(B_JinDao:TBasicJinDao;Support:integer);
    //---------------------------


    procedure InitRockDataGrid;// 初始化矿压数据录入表
    procedure InsertMeregCellToArray(Col1,Row1,Col2,Row2:integer;var Arry:Rec_StringToExcel_Array);
    procedure initInputRockPressData ;//初始化矿山压力录入数据

    function  ZoomRect(mRect: TRect; mZoom: Integer): TRect;// 绘制表格线
    //--------------------------

    procedure DispRockDataPopMumu(px,py,Col,Row:integer); //显示矿压数据快捷菜单

    //---------------------------------

    procedure MoveStringGridRecord(StrGrid:TstringGrid;FRow,MRow:integer); //移动一条记录的数据

    procedure CopyDataToStringGridFromPaste(StrGrid:TstringGrid;Col,Row,ColNumber:integer);  // 拷贝数据进入StringGrid

    //---------------------------
    procedure ChangePressDataUnit(Flag:integer);  // 更改数据单位
    function  SetAnalysisSenstive(Index:integer):Boolean;//通过选择灵敏度来改变判定数值


    procedure SplitWorkFaceMemo1Text;
    function DelDirAll(aDir: string): Boolean;


  public
     EXCaption:String; // 外部传过来的标题
    { Public declarations }
     procedure Return_CallEditRockPressMemo(DTS:String);
     // 外部一键调用
     procedure InitForm;      //初始化界面部分功能
     procedure UpdateBatInputData(Flag:integer); // 对导入的数据进行处理
  end;

function CreateFootage_Data(AHandle:THandle;ACaption:string;Wid,Hi,Flag:integer):THandle;stdcall;

var
 Edit_PressDataForm: TEdit_PressDataForm;

implementation

{$R *.dfm}

uses  PStope_GzmGuidClass,
  UEditFootageDateTime, UEditRockDataMemo;
function CreateFootage_Data(AHandle:THandle;ACaption:string;Wid,Hi,Flag:integer):THandle;stdcall;
{Flag 1 进尺维护  Flag 2 矿压数据维护  3 矿压数据分析}
begin
        if Assigned(Edit_PressDataForm) then  FreeAndNil(Edit_PressDataForm);
        Application.Handle :=AHandle;
        Edit_PressDataForm:=TEdit_PressDataForm.Create(Application);

         try
           with Edit_PressDataForm do begin
               EXCaption:=ACaption;
               WindowState:= wsMaximized;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

               Show;
               SetFocus;
               Result:=Edit_PressDataForm.Handle ;//函数值
          end ;
        except
           FreeAndNil(Edit_PressDataForm);
        end;


end;

{ TForm1 }

procedure TEdit_PressDataForm.AddButtonClick(Sender: TObject);
begin
     Pop_Rock_Auto.Click;
end;

procedure TEdit_PressDataForm.AutoLoadcomboBox(MkName, WkName: string);
var
   s_temp:Str_DT_array;
   i,C1:integer;
begin
   if length(trim(WkName))=0 then  exit;
   if not DrawGzm.SelectMineAndWorkFaceBh(MkName, WkName) then   exit;
   //判断与工作面相关的数据表是否创建，如果没有创建，再此创建
   if not MainDataModule.IsExsitTableName('D_'+inttostr(DrawGzm.FGzm.Gzmbh)+'_BasicData') then begin
       MainDataModule.CreateTable('2',MainDataModule.DataType,inttostr(DrawGzm.FGzm.Gzmbh),'') ;
   end;
end;


procedure TEdit_PressDataForm.BitBtn5Click(Sender: TObject);
begin
     RefreshInputData;
end;




procedure TEdit_PressDataForm.Button7Click(Sender: TObject);
begin
   SplitWorkFaceMemo1Text;
end;




procedure TEdit_PressDataForm.MoveStringGridRecord(StrGrid: TstringGrid; FRow,
  MRow: integer);
var
   i:integer;
begin
    for I := 0 to StrGrid.ColCount -1 do
        StrGrid.Cells[i,MRow]:= StrGrid.Cells[i,FRow];

end;

procedure TEdit_PressDataForm.N7Click(Sender: TObject);
begin
  if DataPress_Unit_Flag=1 then  begin
     DataPress_Unit_Flag:=2;
  end else if DataPress_Unit_Flag=2 then   begin
     DataPress_Unit_Flag:=1;
  end;

    ChangePressDataUnit(DataPress_Unit_Flag);
end;

procedure TEdit_PressDataForm.UpdateBatInputData(Flag:integer);
{
   Flag  0 1
   涉及到是否删除数据的问题
}
var
  i,Sup:integer;
  sql1,sql2,Strdt:String;
  MaxTime:TdateTime;
  JinDao,SupportBh:integer;
  Data0,Data1,Data2,Data3,Data4:double;
begin

   //打开 进度条
   DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,true,100,100);
   DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
   Sup:= DrawGzm.FGzm.RockPressAnalysis.ManulInput_Interval_support;
   // 把没有process =0 的数据删除
   if Flag=1  then    begin
     DrawGzm.FGzm.DeleteRockPressData(0,0,3);
   end;

   // 填充 进刀类
   FillBasicJinDao(BasicJinDao,DrawGzm.FGzm.RockPressAnalysis.JinDao_Support);
   while Sup<=DrawGzm.FGzm.SupEndNumber  do  begin
      DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
      Data0:=0;
     
      for I := 0 to BasicJinDao.Count-1 do   begin
         if (i>1) and (Data0<1) then  break;
         DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,0,20);
         Strdt:=Public_Basic.ReturnDateTimeString(MainDataModule.DataType ,BasicJinDao.ArrayBasicJinDao[i].ShotTime);
         Sql1:=' select * from  D_'+IntToStr(DrawGzm.FGzm.Gzmbh)+'_SupportMoveInfo ' +
               ' where supportbh >=' + IntTostr(Sup) + ' and supportbh < '+IntTostr(Sup+DrawGzm.FGzm.RockPressAnalysis.ManulInput_Interval_support)  +
               ' and  EndTime >= ' + Strdt + ' and StartTime <= ' +Strdt;
         MySqlDataSet1.Close ;
         MySqlDataSet1.CommandText :=sql1;
         try
         if MySqlDataSet1.Open  then
           if MySqlDataSet1.RecordCount >0 then   begin
              MySqlDataSet1.First ;
              Data0:=MySqlDataSet1.FieldByName('Max_Value').AsFloat;
              Data1:=MySqlDataSet1.FieldByName('AGVData').AsFloat;
              Data2:=MySqlDataSet1.FieldByName('BeforeMoveValue').AsFloat;
              Data3:=MySqlDataSet1.FieldByName('SameTimeValue').AsFloat;
              Data4:=MySqlDataSet1.FieldByName('SupportStartPress').AsFloat;
           end;
         finally
            if Data0>0 then
              DrawGzm.FGzm.SaveMultPressDataToDAteBase(
                                          FormatdateTime('yyyy-mm-dd HH:NN:SS',BasicJinDao.ArrayBasicJinDao[i].ShotTime) ,
                                          BasicJinDao.ArrayBasicJinDao[i].Daoshu,
                                          Sup,
                                          Data0,Data1,Data2,Data3,Data4,0,''
                                          ) ;
            MySqlDataSet1.Close ;
         end;


      end;

      Sup:=Sup+DrawGzm.FGzm.RockPressAnalysis.ManulInput_Interval_support;
   end;
   // 关闭进度条
   DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,false,0,0);
end;




procedure TEdit_PressDataForm.ChangePressDataUnit(Flag: integer);
var
  i,j:integer;
  TemValue:Double;
  UnittName:string;
begin
  if Flag=1 then   begin
     UnittName :='当前数据单位为 MPa' ;
     DrawGzm.ColorValue.UnitType :=1;
     DataPress_Unit_Flag:=1;

  end else begin
     UnittName :='当前数据单位为 Bar' ;
     DrawGzm.ColorValue.UnitType:=2;
     DataPress_Unit_Flag:=2;

  end;

  for I := 4 to RockDataGrid.ColCount-1 do  begin
      for j := 2 to RockDataGrid.RowCount -1 do  begin
         TemValue:=Public_Basic.StrToDouble_Lu(RockDataGrid.Cells[i,j]);
         if TemValue>0 then   begin
            if DataPress_Unit_Flag=1 then  begin
               RockDataGrid.Cells[i,j]:=FormatFloat('0.00',TemValue/10) ;
            end else begin
               RockDataGrid.Cells[i,j]:=FormatFloat('0.00',TemValue*10) ;
            end;
         end else begin
             RockDataGrid.Cells[i,j]:='';
         end;
      end;
  end;

   Caption:=EXCaption+'【'+ UnittName+'】';
end;

procedure TEdit_PressDataForm.ChartPageControlDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
   if Active then
    begin
        Control.Canvas.Brush.Color := ClHighLight;
        Control.Canvas.Font.Color := clWhite;
    end;
    Control.Canvas.FillRect(Rect);

end;







procedure TEdit_PressDataForm.ContourPop_ChangUnitClick(Sender: TObject);
begin
  if DataPress_Unit_Flag=1 then  begin
     DataPress_Unit_Flag:=2;
  end else if DataPress_Unit_Flag=2 then   begin
     DataPress_Unit_Flag:=1;
  end;

    ChangePressDataUnit(DataPress_Unit_Flag);
end;

procedure TEdit_PressDataForm.CopyDataToStringGridFromPaste(StrGrid: TstringGrid; Col,
  Row, ColNumber: integer);
var
  arr: array[0..99999] of Char;
  i,j,inColNumber:Integer;
  s_temp:Str_DT_array;
  C1,ColS:integer;
  List1:TStringList;
begin

  Clipboard.GetTextBuf(arr, Length(arr));
  List1:=TStringList.Create ;
  List1.Text:=arr;
  try
     for I := 0 to List1.Count-1 do  begin
          s_temp:=Public_Basic.split(List1.Strings[i],#9,C1);
          if ColNumber < 1   then inColNumber:=C1
              else  inColNumber:=ColNumber;

          for j := 0 to inColNumber-1 do  begin
             if Col+j>StrGrid.ColCount-1 then   break;

             StrGrid.Cells[Col+j,Row]:=s_temp[j];
             RockDataGrid_Edit.Cells[Col+j,Row]:='1';
          end;

          Row:=Row+1;
          if Row> StrGrid.RowCount -1 then break;

    end;

  finally
     FreeAndNil(List1);
  end;


end;




function TEdit_PressDataForm.DelDirAll(aDir: string): Boolean;
var
    vSearch: TSearchRec;
    vRet: integer;
    vKey: string;
begin

    if aDir[Length(aDir)] <> '\' then
        aDir := aDir + '\';
    vKey := aDir + '*.*';
    vRet := FindFirst(vKey, faanyfile, vSearch);
    while vRet = 0 do       begin
        if ((vSearch.Attr and fadirectory) = fadirectory) then       begin
            if (vSearch.Name <> '.') and (vSearch.name <> '..') then
                DelDirAll(aDir + vSearch.name);
            end
        else    begin
            if ((vSearch.Attr and fadirectory) <> fadirectory) then     begin
              {System.Sysutils.}DeleteFile(aDir + vSearch.name);
             end;
        end;
        vRet := FindNext(vSearch);
    end; //while

    {System.SysUtils.}FindClose(vSearch);
    Removedir(aDir); // 如果需要删除文件夹则添加
    result := True;

end;

procedure TEdit_PressDataForm.DispRockDataPopMumu(px, py, Col, Row: integer);
begin
     if  (Row <=1) or (Col<4)  then exit;

     if  RG_Rock_DataType.ItemIndex <5 then  begin
         Pop_Rock_Paste.Enabled :=false;
     end else begin
         Pop_Rock_Paste.Enabled :=true;
     end;

//     self.Pop_Rock_Paste.Enabled :=false;
//     self.Pop_Rock_DeleteOne .Enabled :=false;
//     //self.Pop_Rock_Save.Enabled :=false;
//     self.Pop_Rock_Refresh.Enabled :=false;
//     self.Pop_Rock_DeletaAll.Enabled :=false;
       //Pop_Rock_Input_Memo.Enabled :=False;

       Pop_Rock_Disp_Memo.Enabled :=False;
     if Trim(RockDataRightGrid.Cells[RockStringGrid_SelectCol,RockStringGrid_SelectRow]) <> '' then
              Pop_Rock_Disp_Memo.Enabled :=true;

     PopupMenu_RockData.Popup(px,py);
end;



procedure TEdit_PressDataForm.Edit_StartDaoKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9',#8]) then key:=#0  ;
end;

procedure TEdit_PressDataForm.Edit_EndDaoKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9',#8]) then key:=#0
end;



procedure TEdit_PressDataForm.EditButtonClick(Sender: TObject);
begin
   Pop_Rock_Save.Click;
end;

procedure TEdit_PressDataForm.Edit_AxisKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9',#8]) then key:=#0  ;
end;

procedure TEdit_PressDataForm.Edit_EndPtKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TEdit_PressDataForm.Edit_Foot_ConKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9',#8]) then key:=#0  ;
end;


procedure TEdit_PressDataForm.Edit_interVal_supportKeyPress(Sender: TObject;
  var Key: Char);
begin
   if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;


procedure TEdit_PressDataForm.Edit_Min_PtKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TEdit_PressDataForm.Edit_StartPtKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;



procedure TEdit_PressDataForm.Edit_SupportNumberKeyPress(Sender: TObject;
  var Key: Char);
begin
   if not (key in ['0'..'9',#8]) then key:=#0  ;
end;

procedure TEdit_PressDataForm.Edit_Sup_ConKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9',#8]) then key:=#0  ;
end;



procedure TEdit_PressDataForm.EndEditKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;



procedure TEdit_PressDataForm.ExitButtonClick(Sender: TObject);
begin
   Close;
end;

procedure TEdit_PressDataForm.FillBasicJinDao(B_JinDao: TBasicJinDao;Support:integer);
var
  sql,Strdt:string;
  MaxTime:TDateTime;
  Rd:TJinDaoRecord;
begin
   MaxTime:=GetBatInputDataMaxGenTime(Support);
   MySqlDataSet2.Close ;

   Strdt:=Public_Basic.ReturnDateTimeString(MainDataModule.DataType ,MaxTime);

   Sql:=' select * from  D_'+IntToStr(DrawGzm.FGzm.Gzmbh)+'_footage ' +
        ' where  footday > ' + Strdt +
        ' order by Daoshu  ' ;
   B_JinDao.ClearArray;
   MySqlDataSet2.CommandText :=sql;
   try
      if MySqlDataSet2.Open then
       while not MySqlDataSet2.Eof  do  begin
          Rd.ShotTime :=MySqlDataSet2.FieldByName('FootDay').AsDateTime;
          Rd.Daoshu:=MySqlDataSet2.FieldByName('DaoShu').AsInteger;
          B_JinDao.Add(RD);
          MySqlDataSet2.Next;
       end;
   finally
      MySqlDataSet2.Close ;
   end;
end;




procedure TEdit_PressDataForm.FootageGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
   FootStringGrid_SelectCol:=ACol;
   FootStringGrid_SelectRow:=ARow;
end;


procedure TEdit_PressDataForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   {关闭窗体，还得需要发出Close命令}
   if Assigned(Edit_PressDataForm) then  FreeAndNil(Edit_PressDataForm);
end;

procedure TEdit_PressDataForm.FormCreate(Sender: TObject);
begin
    MySqlDataSet1:=TMyDataSet.Create(nil);
    MySqlDataSet1.MySqlConnection :=MainDataModule.ExConn;
    MySqlDataSet2:=TMyDataSet.Create(nil);
    MySqlDataSet2.MySqlConnection :=MainDataModule.ExConn;
    MyCommand1:=TMyCommand.Create (nil);
    MyCommand1.MySqlConnection :=MainDataModule.ExConn;
    DrawGzm:=TDrawGrap.Create(MainDataModule.ExConn);
    //create


    MainDataModule.ReadPublicUsedMkInfoFromFile;
    s_MinName :=MainDataModule.Coal_Name;
    S_WorkFaceName :=MainDataModule.WorkFace_Name;


    // 矿压数据表
     SelectRockDataRecordNumber:='50';

     RockStringGrid_SelectCol:=-1;
     RockStringGrid_SelectRow:=-1;
     {手动分析数据 封闭两个页面}
    // LeftPageControl.Pages[1].TabVisible:=False;


     //默认机尾显示 时间
     DrawGzm.ConTourSeriesPar.Display_UpperFootage:=0;
     DrawGzm.ConTourSeriesPar.Display_DownFootage:=1;

     BasicJinDao:=TBasicJinDao.Create ;
end;

procedure TEdit_PressDataForm.FormDestroy(Sender: TObject);
begin
     FreeAndNil(MySqlDataSet1);
     FreeAndNil(MyCommand1);
     FreeAndNil(MySqlDataSet2);
     FreeAndNil(DrawGzm);

     FreeAndNil(MapSeries);
     FreeAndNil(BasicJinDao);

end;

procedure TEdit_PressDataForm.FormResize(Sender: TObject);
begin
    if WindowState=wsMaximized  then  begin
       StatusBar1.Visible :=False;
    end else begin
       StatusBar1.Visible :=true;
    end;

end;

procedure TEdit_PressDataForm.FormShow(Sender: TObject);
begin
   InitForm;
//   Caption:=EXCaption+'【'+ Label_DataPress_Unit.Caption+'】';
end;

function TEdit_PressDataForm.GetBatInputDataMaxGenTime(Support:integer): TDateTime;
var
  sql:String;
begin
   Result:=-1;
   MySqlDataSet2.Close ;
   Sql:=' select Max(generatetime) as MAXTime from  D_'+IntToStr(DrawGzm.FGzm.Gzmbh)+'_ManualInputPressData  '  +
        ' where supportbh = ' +IntTostr(Support) ;
   MySqlDataSet2.CommandText :=sql;
   try
       if MySqlDataSet2.Open then
        Result:= MySqlDataSet2.FieldByName('MAXTime').AsDateTime

   finally
       MySqlDataSet2.Close ;
   end;
end;



function TEdit_PressDataForm.GetDataClass: Boolean;
var
 i:integer;
 Str:string;
begin

end;





function TEdit_PressDataForm.GetTimeAndFootage: Boolean;
var
  MaxDao,MInDao:integer;
begin
    Result:=False;

end;



function TEdit_PressDataForm.InitDateTimeFootage:boolean;
var
 i:integer;
 str:string;
begin

end;


procedure TEdit_PressDataForm.InitForm;
begin


    Public_basic.InitStatusBar(StatusBar1);
    AutoLoadcomboBox(s_MinName,S_WorkFaceName);
    RefreshForm;
    DrawGZm.MapSeriesEditState :=-1;  // 默认没有加载数据
    DrawGzm.CloudClass.OldStepDisplay :=False; //云图不显示来压步距

end;

procedure TEdit_PressDataForm.initInputRockPressData;
var
   s_temp,S2:Str_DT_array;
   C1,C2:integer;
begin
   {从数据库中读取相关 Memo1 数据}
   SplitWorkFaceMemo1Text;

  //=============矿压数据表的维护
   RockDataGrid.OnMouseWheelDown  :=RockDataRightGrid.OnMouseWheelDown;
   RockDataGrid.OnMouseWheelUp :=RockDataRightGrid.OnMouseWheelUp;
   ChangePressDataUnit(2);//MPa
   {刷新工作面数据录入数据表}
   RefreshRockPressStringGrid(SelectRockDataRecordNumber);
end;


procedure TEdit_PressDataForm.InitRockDataGrid;
var
   i:integer;
   Cols:integer;
   SupperNumber,interVal_support,ColDiv:integer;
begin
    RockDataRightGrid.Align  :=alRight;
    RockDataGrid.Align :=alClient;
    RockDataRightGrid.Width:=95;

    for i := 0 to  RockDataGrid.RowCount - 1 do  begin
        RockDataGrid.Rows[i].Clear ;
        RockDataRightGrid.Rows[i].Clear;
        RockDataGrid_Edit.Rows[i].Clear;
        setlength(Kyfx_StringMeregExcel,0);
    end;
      SupperNumber:= DrawGzm.FGzm.SupEndNumber;
      interVal_support:= DrawGzm.FGzm.RockPressAnalysis.ManulInput_Interval_support;
      Cols:= SupperNumber div interVal_support;

      Cols:=Cols+4;
      RockDataGrid.ColCount :=Cols;
      RockDataGrid.RowCount :=3;
      RockDataGrid.FixedRows:=2;
      RockDataGrid.FixedCols:=4;
      // RockDataGrid_Edit
      RockDataGrid_Edit.ColCount :=Cols;
      RockDataGrid_Edit.RowCount :=3;
      RockDataGrid_Edit.FixedRows:=2;
      RockDataGrid_Edit.FixedCols:=4;
      //
      RockDataRightGrid.ColCount :=Cols;
      RockDataRightGrid.RowCount:=3;
      RockDataRightGrid.FixedRows:=2;
      RockDataRightGrid.FixedCols:=2;


      RockDataGrid.Cells [0,1]:='序号';
         RockDataGrid.ColWidths[0]:=30;
      RockDataGrid.Cells [1,0]:='  机';
      RockDataGrid.Cells [1,1]:='时间日期';
         RockDataGrid.ColWidths[1]:=120;
      RockDataGrid.Cells [2,1]:='刀数';
         RockDataGrid.ColWidths[2]:=30;
      RockDataGrid.Cells [3,0]:='头';
         InsertMeregCellToArray(1,0,3,0,Kyfx_StringMeregExcel);
      RockDataGrid.Cells [3,1]:='进尺(米)';
         RockDataGrid.ColWidths[3]:=40;

      RockDataRightGrid.Cells [0,0]:='  机';
      RockDataRightGrid.Cells [0,1]:='进尺(米)';
         RockDataRightGrid.ColWidths[0]:=40;
      RockDataRightGrid.Cells [1,0]:='  尾';
      RockDataRightGrid.Cells [1,1]:='刀数';
         RockDataRightGrid.ColWidths[1]:=40;
         RockDataRightGrid.ColWidths[2]:=60;
      // 其他表头
      ColDiv:= (Cols-4) div 8;
      RockDataGrid.Cells [4+ColDiv,0]:=' 液';
      RockDataGrid.Cells [4+2*ColDiv,0]:=' 压';
      RockDataGrid.Cells [4+3*ColDiv,0]:=' 支';
      RockDataGrid.Cells [4+4*ColDiv,0]:=' 架';
      RockDataGrid.Cells [4+5*ColDiv,0]:=' 压';
      RockDataGrid.Cells [4+6*ColDiv,0]:=' 力';
      RockDataGrid.Cells [4+7*ColDiv,0]:=' 编';
      RockDataGrid.Cells [4+8*ColDiv,0]:=' 号';
      InsertMeregCellToArray(4+ColDiv,0,4+8*ColDiv,0,Kyfx_StringMeregExcel);

      for i := 4 to Cols-1 do  begin
         RockDataGrid.Cells [i,1]:='  '+IntTostr((i-3)*interVal_support);
         RockDataGrid.ColWidths[i]:=40;
      end;


end;




procedure TEdit_PressDataForm.InsertMeregCellToArray(Col1, Row1, Col2,
  Row2: integer; var Arry: Rec_StringToExcel_Array);
var
  Count:integer;
begin
    Count:=length(Arry);
    inC(Count);
    setlength(Arry,Count);
    Arry[Count-1].FromCol :=Col1;
    Arry[Count-1].FromRow :=Row1;
    Arry[Count-1].ToCol :=Col2;
    Arry[Count-1].ToRow :=Row2;
end;

procedure TEdit_PressDataForm.OptionTip(index:integer;Str:String);
begin
   self.StatusBar1.Panels[index].Text :=str;
end;



procedure TEdit_PressDataForm.Main_PageControlDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
    if Active then
    begin
        Control.Canvas.Brush.Color := ClGreen;
        Control.Canvas.Font.Color := clWhite;
    end;
    Control.Canvas.FillRect(Rect);
    Control.Canvas.TextOut(Rect.Left + 4,Rect.Top + 4,Main_PageControl.Pages[TabIndex].Caption);
end;

procedure TEdit_PressDataForm.PageControl4DrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
    if Active then
    begin
        Control.Canvas.Brush.Color := ClHighLight;
        Control.Canvas.Font.Color := clWhite;
    end;
    Control.Canvas.FillRect(Rect);
    Control.Canvas.TextOut(Rect.Left + 4,Rect.Top + 4,PageControl4.Pages[TabIndex].Caption);
end;


procedure TEdit_PressDataForm.Pop_Rock_AutoClick(Sender: TObject);
begin
  UpdateBatInputData(1);
  RefreshRockPressStringGrid(SelectRockDataRecordNumber);
end;

procedure TEdit_PressDataForm.Pop_Rock_DeletaAllClick(Sender: TObject);
var
  t_s:string;
begin
   t_s:='你确定要删除所有提取数据么?'+#13#10+'删除后可以重新提取！';
   if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

   if DrawGzm.FGzm.Gzmbh<1 then exit ;
       DrawGzm.FGzm.DeleteRockPressData(0,0,0);
    RefreshRockPressStringGrid(SelectRockDataRecordNumber);
end;

procedure TEdit_PressDataForm.Pop_Rock_DeletaQAllClick(Sender: TObject);
var
  t_s,Strdt:string;
  Dll_Path, DirName:Ansistring;
begin
   t_s:='你确定要删除所有数据么，包括批量导入的数据?'+#13#10+ '删除后如需数据需要重新导入！';
   if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

   if DrawGzm.FGzm.Gzmbh<1 then exit ;
       // 删除提取数据表
       DrawGzm.FGzm.DeleteRockPressData(0,0,0);
       // 删除提取进出表
       Strdt:=Public_Basic.ReturnDateTimeString(MainDataModule.DataType ,0);
       DrawGzm.FGzm.DeleteAllFootageData(Strdt) ;
       // 删除导入循环表
        DrawGzm.FGzm.DeleteFromSupportMoveInfoAllData;
       //删除 导入保存文件

      Dll_Path:=Public_Basic.Get_MyModulePath;
      DirName:=DLL_path+'\InputData\WorkDace_'+IntTostr(DrawGzm.FGzm.Gzmbh);
      DelDirAll(DirName);
       //
      RefreshRockPressStringGrid(SelectRockDataRecordNumber);

end;

procedure TEdit_PressDataForm.Pop_Rock_DeleteOneClick(Sender: TObject);
var
  t_s:string;
  daoshu,Support,j:integer;
begin
   t_s:='你确定要删除当前行的数据么?';
   if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

   daoshu:=public_Basic.StrToInt_lu(RockDataGrid.Cells[2,RockStringGrid_SelectRow] );
   if (DrawGzm.FGzm.Gzmbh<1) and (Daoshu < 1) then exit ;

   for j := 4 to RockDataGrid.ColCount-1 do  begin
       Support:=public_Basic.StrToInt_lu(RockDataGrid.Cells[j,1] );
       if (daoshu>0) and (Support>0) then
       DrawGzm.FGzm.DeleteRockPressData(daoshu,Support,1);
   end;

    RefreshRockPressStringGrid(SelectRockDataRecordNumber);
end;

procedure TEdit_PressDataForm.Pop_Rock_Disp_300Click(Sender: TObject);
begin
    SelectRockDataRecordNumber:='300';
    RefreshRockPressStringGrid(SelectRockDataRecordNumber);
end;

procedure TEdit_PressDataForm.Pop_Rock_Disp_50Click(Sender: TObject);
begin
    SelectRockDataRecordNumber:='50';
     RefreshRockPressStringGrid(SelectRockDataRecordNumber);
end;

procedure TEdit_PressDataForm.Pop_Rock_Disp_AllClick(Sender: TObject);
begin
   SelectRockDataRecordNumber:='All';
   RefreshRockPressStringGrid(SelectRockDataRecordNumber);
end;

procedure TEdit_PressDataForm.Pop_Rock_Disp_MemoClick(Sender: TObject);
var
  sDT:String;
begin
   sDT:=RockDataGrid.Cells[RockStringGrid_SelectCol,RockStringGrid_SelectRow] ;
   if Trim(SDT)<> '' then begin
      CreateEditRockDataMemo(TabSheet11.Handle,
                             TabSheet11.Width,TabSheet11.Height,
                             '进刀数:'+ RockDataGrid.Cells[2,RockStringGrid_SelectRow]+  '   '  +
                             '支架编号:' + RockDataGrid.Cells[RockStringGrid_SelectCol,1] + '   '  +
                             '数据值:' + SDT ,
                             RockDataRightGrid.Cells[RockStringGrid_SelectCol,RockStringGrid_SelectRow]
                             );
   end;

end;

procedure TEdit_PressDataForm.Pop_Rock_Input_MemoClick(Sender: TObject);
var
  sDT:String;
begin
   sDT:=RockDataGrid.Cells[RockStringGrid_SelectCol,RockStringGrid_SelectRow] ;
   if Trim(SDT)<> '' then begin
      CreateEditRockDataMemo(TabSheet11.Handle,
                             TabSheet11.Width,TabSheet11.Height,
                             '进刀数:'+ RockDataGrid.Cells[2,RockStringGrid_SelectRow]+  '   '  +
                             '支架编号:' + RockDataGrid.Cells[RockStringGrid_SelectCol,1] + '   '  +
                             '数据值:' + SDT ,
                             RockDataRightGrid.Cells[RockStringGrid_SelectCol,RockStringGrid_SelectRow]
                             );
   end;
end;

procedure TEdit_PressDataForm.Pop_Rock_PasteClick(Sender: TObject);
begin
  CopyDataToStringGridFromPaste(self.RockDataGrid ,RockStringGrid_SelectCol,RockStringGrid_SelectRow,0);
end;

procedure TEdit_PressDataForm.Pop_Rock_RefreshClick(Sender: TObject);
begin
    RefreshRockPressStringGrid(SelectRockDataRecordNumber);
end;

procedure TEdit_PressDataForm.Pop_Rock_SaveClick(Sender: TObject);
var
  i,j,Daoshu,supportbh:integer;
  DataV:double;
  Memo,t_s:string;
  td:String;
begin
    DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,true,RockDataGrid.RowCount,RockDataGrid.ColCount);
    t_s:= '正在保存数据，耐心等待...';
    OptionTip(0,t_s);

    for I := 2 to RockDataGrid.RowCount -1  do  begin
       Daoshu:=Public_Basic.StrToInt_lu(Trim(RockDataGrid.Cells[2,i]));
      DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,1,0);
       if Daoshu <=0 then  break;
       for j := 4 to RockDataGrid.ColCount-1 do  begin
           supportbh:=Public_Basic.StrToInt_lu(Trim(RockDataGrid.Cells[j,1]));
           DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);
           if Supportbh<=0  then continue;
           // 把该条记录先清除
           //DrawGzm.FGzm.DeleteRockPressData(Daoshu,Supportbh,1);
           if RockDataGrid_Edit.Cells[j,i]= '1'  then  begin  // 证明被修改了
               DataV:=Public_Basic.StrToDouble_Lu(Trim(RockDataGrid.Cells[j,i]));
               if DataV <=1 then  continue;
               if DataPress_Unit_Flag =2 then //如果单位是bar
                  DataV:=DataV/10;
               if Trim(RockDataRightGrid.Cells[j,i])<> '' then  Memo:= Trim(RockDataRightGrid.Cells[j,i])
                  else Memo:='';
                td:=Trim(RockDataGrid.Cells[1,i]);
                if not DrawGzm.FGzm.UpdateRockPressDataToDataBase(DaoShu,Supportbh,RG_Rock_DataType.ItemIndex,Memo,DataV)  then
                    DrawGzm.FGzm.SaveRockPressDataToDataBase(td,DaoShu,Supportbh,RG_Rock_DataType.ItemIndex,DataV,Memo);
           end;
       end;
    end;
    // 清理数据库中以前录入比当前进刀数大的记录
    if Daoshu >0 then    begin
       DrawGzm.FGzm.DeleteRockPressData(Daoshu,0,2);
    end;
    // 把数据批量修改了 把process=0 改为 process =1
    DrawGzm.FGzm.UpdataRockPress_Process(1,'1',1) ;

    DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,False,0,0);

    t_s:= '数据存储成功！';
    Application.MessageBox(Pwidechar(t_s),'提示',MB_OK+MB_ICONQUESTION) ;
    OptionTip(0,t_s);

end;

procedure TEdit_PressDataForm.Pop_Rock_SaveExcelClick(Sender: TObject);
var
  Tilte,t_s:string;
  U_N:string;
begin
   t_s:='你确定要保存为Excel吗？打开OFFice会耗费一点时间'+#13#10+'请耐心等待！';
   if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

   if self.RG_Rock_DataType.ItemIndex =0 then   begin
     Tilte:=s_MinName +'['+S_WorkFaceName+']工作面每次进刀压力数据最大值';
   end else if self.RG_Rock_DataType.ItemIndex =1 then   begin
     Tilte:=s_MinName +'['+S_WorkFaceName+']工作面每次进刀压力数据平均值';
   end else if self.RG_Rock_DataType.ItemIndex =2 then   begin
     Tilte:=s_MinName +'['+S_WorkFaceName+']工作面每次进刀压力数据初撑力';
   end else if self.RG_Rock_DataType.ItemIndex =3 then   begin
     Tilte:=s_MinName +'['+S_WorkFaceName+']工作面每次进刀压力数据末阻力';
   end else if self.RG_Rock_DataType.ItemIndex =4 then   begin
     Tilte:=s_MinName +'['+S_WorkFaceName+']工作面每次进刀压力数据同一时刻抓取值';
   end else if self.RG_Rock_DataType.ItemIndex =5 then   begin
     Tilte:=s_MinName +'['+S_WorkFaceName+']工作面每次进刀压力数据手动录入值';
   end;

   if DataPress_Unit_Flag=1 then  begin
      U_N:='【单位:MPa】' ;
   end else begin
      U_N:='【单位:Bar】' ;
   end;


   Public_Basic.StringGridToExcel_MegerCell(true,Tilte+U_N,RockDataGrid,10, Kyfx_StringMeregExcel,'');

end;

function TEdit_PressDataForm.ZoomRect(mRect: TRect; mZoom: Integer): TRect;
begin
  Result.Left := mRect.Left - mZoom;
  Result.Right := mRect.Right + mZoom;
  Result.Top := mRect.Top;// - mZoom;
  Result.Bottom := mRect.Bottom- mZoom;
end;



procedure TEdit_PressDataForm.RefreshForm;
begin
     {初始化时间进尺选择的控件数据 }
    InitDateTimeFootage ;
    {初始化采煤工左面进尺录入与 矿压数据手动录入}
    initInputRockPressData ;

    {处理ContourChart 云图 颜色定制表格  }
   // DisPoseContourGroupColor
end;

procedure TEdit_PressDataForm.RefreshInputData;
begin
     GetTimeAndFootage;
     GetDataClass;
end;

procedure TEdit_PressDataForm.RefreshMemoInfo(Memo:TMemo);
begin
     Memo.Clear ;
     Memo.Lines.Add('选择数据类型:'+DrawGzm.GraphClass.DataName);
     Memo.Lines.Add('已经选择:'+DrawGzm.GraphClass.SupportList);
end;



procedure TEdit_PressDataForm.RefreshRockPressStringGrid(Flag: string);
var
  MaxDaoshu:Integer;
begin
  InitRockDataGrid;
  if DrawGzm.FGzm.Gzmbh<1 then exit ;

  MaxDaoshu:=DrawGzm.FGzm.ReturnRockPressDataMaxDaoshu;
   if Flag='50' then  begin
      DrawGzm.FGzm.ReadFootageDataToRockDataGrid(RockDataGrid ,RockDataRightGrid,RockDataGrid_Edit,
                        MaxDaoshu-50) ;
      DrawGzm.FGzm.ReadRockPressDataToStrGrid(RockDataGrid,RockDataRightGrid,RockDataGrid_Edit,
                        MaxDaoshu-50,DataPress_Unit_Flag,RG_Rock_DataType.ItemIndex);
   end else if Flag='300' then  begin
      DrawGzm.FGzm.ReadFootageDataToRockDataGrid(RockDataGrid ,RockDataRightGrid,RockDataGrid_Edit,
                        MaxDaoshu-300) ;
      DrawGzm.FGzm.ReadRockPressDataToStrGrid(RockDataGrid,RockDataRightGrid,RockDataGrid_Edit,
                        MaxDaoshu-300,DataPress_Unit_Flag,RG_Rock_DataType.ItemIndex);
   end else if Flag='All' then  begin
      DrawGzm.FGzm.ReadFootageDataToRockDataGrid(RockDataGrid ,RockDataRightGrid,RockDataGrid_Edit,
                        0) ;
      DrawGzm.FGzm.ReadRockPressDataToStrGrid(RockDataGrid,RockDataRightGrid,RockDataGrid_Edit,
                        0,DataPress_Unit_Flag,RG_Rock_DataType.ItemIndex);
   end;

   self.ScrollBar1.Max:=RockDataGrid.RowCount;
end;
procedure TEdit_PressDataForm.Return_CallEditRockPressMemo(DTS: String);
begin
  self.RockDataRightGrid.Cells[ RockStringGrid_SelectCol,RockStringGrid_SelectRow]:=DTS;
end;


procedure TEdit_PressDataForm.RG_Rock_DataTypeClick(Sender: TObject);
begin
   RefreshRockPressStringGrid(SelectRockDataRecordNumber);
end;


procedure TEdit_PressDataForm.RG_Yun_MainClick(Sender: TObject);
begin

//    LoadDataBtn.Enabled :=true;

 // UpdateImageBtn.Enabled:=False;
end;

procedure TEdit_PressDataForm.RockDataGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  iRect:TRect;
begin
     with RockDataGrid do  begin
          if ((ACol >=0) and (ACol<=3) ) or (ARow=0) or (ARow=1) then       begin
            iRect:=ZoomRect(Rect, 1);
            if ARow=0 then  begin
                Canvas.Font.Color   :=   clBlue; //字体颜色为红的
                Canvas.Brush.color:=clYellow; //背景为 美元绿色
            end else begin
                Canvas.Font.Color   :=   clBlack; //字体颜色为红的
                Canvas.Brush.color:=clMoneyGreen; //背景为 美元绿色
            end;

            Canvas.FillRect(iRect);
            Canvas.TextOut(Rect.Left+2,Rect.Top+2,Cells[ACol,ARow]);
         end;

         if (Trim(RockDataRightGrid.Cells[ACol,ARow])<>'' ) and (ACol>3)  then begin
            iRect:=ZoomRect(Rect, 1);
                Canvas.Font.Color   :=   clBlack; //字体颜色为红的
                Canvas.Brush.color:=clFuchsia; //背景为 美元绿色
            Canvas.FillRect(iRect);
            Canvas.TextOut(Rect.Left+2,Rect.Top+2,Cells[ACol,ARow]);
         end;


      end;
end;

procedure TEdit_PressDataForm.RockDataGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 pt:TPoint;
 col, row: Longint;
begin
   RockDataGrid.MouseToCell(X, Y, col, row);

   if Button=mbRight then  begin
      pt:= RockDataGrid.ClientToScreen(Point(0,0));
      Mouse_x:=pt.X+x;
      Mouse_y:=Pt.Y+y;
      RockStringGrid_SelectCol :=col;
      RockStringGrid_SelectRow := row;
      DispRockDataPopMumu(Mouse_x,Mouse_y,RockStringGrid_SelectCol,RockStringGrid_SelectRow);

   end else if Button = mbLeft then  begin
       if row <> RockStringGrid_SelectRow then  begin
          RockStringGrid_SelectRow := row;
          RockDataGrid.Repaint;
       end;
       RockDataGrid_edit.Cells[col,Row]:='1';
   end;



end;

procedure TEdit_PressDataForm.RockDataGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
   RockStringGrid_SelectCol:=ACol;
   RockStringGrid_SelectRow:=ARow;
   RockDataRightGrid.Row:= ARow;
end;

procedure TEdit_PressDataForm.RockDataRightGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  iRect:TRect;
begin
     with RockDataRightGrid do  begin
          if ((ACol >=0) and (ACol<=1) ) or (ARow=0) or (ARow=1) then       begin
            iRect:=ZoomRect(Rect, 1);
             if ARow=0 then  begin
                Canvas.Font.Color   :=   clBlue; //字体颜色为红的
                Canvas.Brush.color:=clYellow; //背景为 美元绿色
            end else begin
                Canvas.Font.Color   :=   clBlack; //字体颜色为红的
                Canvas.Brush.color:=clMoneyGreen; //背景为 美元绿色
            end;
            Canvas.FillRect(iRect);
            Canvas.TextOut(Rect.Left+2,Rect.Top+2,Cells[ACol,ARow]);
         end;

//          if (State = []) and (FootStringGrid_SelectRow = ARow) then  begin
//             Canvas.Brush.Color := clSkyBlue;
//             Canvas.FillRect(Rect);
//             Canvas.TextOut(Rect.left , Rect.top, Cells[ACol, ARow]);
//          end;
      end;

end;

procedure TEdit_PressDataForm.SaveButtonClick(Sender: TObject);
begin
    Pop_Rock_Refresh.Click;
end;

procedure TEdit_PressDataForm.ScrollBar1Change(Sender: TObject);
begin
   if ScrollBar1.Position>=2 then  begin
     RockDataGrid.TopRow :=ScrollBar1.Position ;
     RockDataRightGrid.TopRow :=ScrollBar1.Position ;
   end;
end;

function TEdit_PressDataForm.SetAnalysisSenstive(Index: integer): Boolean;
var
  kk:integer;
begin

end;





procedure TEdit_PressDataForm.SplitWorkFaceMemo1Text;
begin
   if DrawGzm.FGzm.Gzmbh <1 then exit;
   // 进尺表的维护
   DrawGzm.FGzm.InputGzmData(DrawGzm.FGzm.Gzmbh);
   if not DrawGzm.FGzm.splitFootStepParameters then begin
       DrawGzm.FGzm.RockPressAnalysis.Oneday_daoshu:=10;
       DrawGzm.FGzm.RockPressAnalysis.TwoDao_IntervalTime:=90;
       DrawGzm.FGzm.RockPressAnalysis.OneDao_step:=0.865;
       DrawGzm.FGzm.RockPressAnalysis.ManulInput_Interval_support:=5;
       if DrawGzm.FGzm.SupEndNumber < 1 then
          DrawGzm.FGzm.SupEndNumber:=200;
       DrawGzm.FGzm.RockPressAnalysis.JinDao_Basic:=1;
       DrawGzm.FGzm.RockPressAnalysis.JinDao_Support:=100;
       DrawGzm.FGzm.RockPressAnalysis.JinDao_Time:=0;
   end;
   StringGroupColor:='';
  
end;





procedure TEdit_PressDataForm.ToolButton1Click(Sender: TObject);
begin
  Pop_Rock_SaveExcel.Click;
end;

procedure TEdit_PressDataForm.TreeView1Collapsed(Sender: TObject; Node: TTreeNode);
begin
   Node.ImageIndex:=0;
   Node.SelectedIndex:=0;
end;

procedure TEdit_PressDataForm.TreeView1Expanding(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
begin
     Node.ImageIndex:=1;
    Node.SelectedIndex:=1;
end;



end.  //end Unit
