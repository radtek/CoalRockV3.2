unit UForm_StepResult;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids,
  Vcl.StdCtrls, System.ImageList, Vcl.ImgList, Vcl.Menus,
  uDrawGraphClass , Lu_Public_BasicModual,COMobj

  ;

type

  // ����һ���߳�
  TOpenExcelThread = class; //��Ϊ��ǰ����
  TOnAccumulated = procedure(Sender: TOpenExcelThread) of object;
  // �������ǰ������Sender ��Ҫ����� TObject
  // ���¼������У�Ҫ���� Sender ����Ҫǿ��ת��
  TOpenExcelThread = class(TThread)
  protected
    procedure Execute; override;
    function StringGridToExcel_MegerCell(Disp:Boolean;atitle: string; Astringgrid: Tstringgrid;
                               Afontsize: integer;arry:Rec_StringToExcel_Array;Path:string):String;stdcall;
  public
     ipathName:string;
     in_StringMeregExcel:Rec_StringToExcel_Array;
     iCaption:string;
     iStrGrid:TStringGrid;

     OnAccumulated: TOnAccumulated;

  end;

  TForm_StepResult = class(TForm)
    ToolBar2: TToolBar;
    But_DispPhase: TToolButton;
    But_DispWhole: TToolButton;
    But_SaveTxt: TToolButton;
    But_SaveExcel: TToolButton;
    ExitButton: TToolButton;
    ImageList1: TImageList;
    PageControl_Result: TPageControl;
    Tab_Excel: TTabSheet;
    Tab_Txt: TTabSheet;
    Memo_Result: TMemo;
    SG_Result: TStringGrid;
    StatusBar1: TStatusBar;
    PopMenu_Result: TPopupMenu;
    ResultPop_Print_Phase: TMenuItem;
    ResultPop_Print_whole: TMenuItem;
    N22: TMenuItem;
    ResultPop_SaveTxt: TMenuItem;
    N19: TMenuItem;
    ResultPop_SaveExcel: TMenuItem;
    N21: TMenuItem;
    SaveDialog1: TSaveDialog;
    Pop_Close: TMenuItem;
    procedure Memo_ResultClick(Sender: TObject);
    procedure Memo_ResultMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SG_ResultMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ResultPop_Print_PhaseClick(Sender: TObject);
    procedure ResultPop_Print_wholeClick(Sender: TObject);
    procedure ResultPop_SaveTxtClick(Sender: TObject);
    procedure Pop_CloseClick(Sender: TObject);
    procedure ResultPop_SaveExcelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PageControl_ResultDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure ExitButtonClick(Sender: TObject);
    procedure PageControl_ResultChange(Sender: TObject);
    procedure But_DispPhaseClick(Sender: TObject);
    procedure But_DispWholeClick(Sender: TObject);
    procedure But_SaveTxtClick(Sender: TObject);
    procedure But_SaveExcelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FUsedStep:TOldSteps;
    FUseDrawClass:TDrawGrap;
    Kyfx_StringMeregExcel:Rec_StringToExcel_Array;
    OutExCel:integer; // 0 �����˳�  1 ��ش� 2���� ����  3 ����˹ر�

    procedure InitKyfxResultStringGrid(GString:TStringGrid);// ��ʼ����ѹ��ʾ�������
    procedure InsertMeregCellToArray(Col1,Row1,Col2,Row2:integer;var Arry:Rec_StringToExcel_Array);
    procedure DispResultPop(Px,Py:integer;TP:String);// ��ʾResult ���ƵĹ�����
    procedure MakeWindowsSingle(Single:integer); // ����ҳ����ʾ��ʽ
    function  PrintResultIntoMemo(Memo:Tmemo):Boolean;
    function  PrintResultIntoExcel(GString:TStringGRid):Boolean;
     // ���ƿ�ѹ�������
    function SaveResultIntoFile(Memo1:TMemo;FileName:String):Boolean;
    //
    procedure SetUseStep(Value:TOldSteps);
    function  GetUseStep:TOldSteps;
    function  GetDrawClass: TDrawGrap;
    procedure setDRawClass(Value:TDrawGrap);
    procedure OnAccumulated(Sender:TOpenExcelThread);
    procedure OptionTip(Str:String);

  public
    { Public declarations }
      property UseOldStep:TOldSteps  read GetUseStep write SetUseStep;
      property DrawClass:TDrawGrap  read GetDrawClass write setDRawClass;

      procedure InitForm(iDrawG:TDrawGrap);
      procedure SetThreadStop;
      function GetExitFlag:integer;
  end;

function CreateStepResult(AHandle:THandle;ACaption:string;Wid,Hi,Single:integer):THandle;stdcall;

var
  Form_StepResult: TForm_StepResult;
  Pub_Exit:Boolean;
implementation

{$R *.dfm}


function CreateStepResult(AHandle:THandle;ACaption:string;Wid,Hi,Single:integer):THandle;stdcall;
{

  Single 0 ����ҳ��  1 ȫ��ҳ��
}
begin
    if Assigned(Form_StepResult) then  begin
       Form_StepResult.Visible :=True;
    end else begin
        Application.Handle :=AHandle;
        Form_StepResult:=TForm_StepResult.Create(Application);

         try
           with Form_StepResult do begin
               Caption:=ACaption;

               ParentWindow:=Ahandle;
               MakeWindowsSingle(Single);

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

               Show;
               Result:=Form_StepResult.Handle ;//����ֵ
          end ;
        except
           FreeAndNil(Form_StepResult);
        end;
    end;

end;


//=============================================
{ TForm_StepResult }

procedure TForm_StepResult.But_DispPhaseClick(Sender: TObject);
begin
   ResultPop_Print_Phase.Click ;
end;

procedure TForm_StepResult.But_DispWholeClick(Sender: TObject);
begin
   ResultPop_Print_whole.Click;
end;

procedure TForm_StepResult.But_SaveExcelClick(Sender: TObject);
begin
   ResultPop_SaveExcel.Click ;
end;

procedure TForm_StepResult.But_SaveTxtClick(Sender: TObject);
begin
   ResultPop_SaveTxt.Click ;
end;

procedure TForm_StepResult.DispResultPop(Px, Py: integer; TP: String);
begin
    ResultPop_SaveTxt.Enabled :=false;
    ResultPop_SaveExcel.Enabled :=false;
   // ResultPop_OpenLefttool.Enabled :=false;
   // ResultPop_OpenRightTool.Enabled :=false;
   ResultPop_Print_Phase.Enabled :=false;
   ResultPop_Print_whole.Enabled :=false;
    if TP='Memo' then  begin
       ResultPop_SaveTxt.Enabled :=true;
       ResultPop_Print_Phase.Enabled :=true;
       ResultPop_Print_whole.Enabled :=true;
    end else begin
       ResultPop_SaveExcel.Enabled :=true;
    end;
    PopMenu_Result.Popup(px,py);
end;

procedure TForm_StepResult.ExitButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TForm_StepResult.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
   pic_Path:string;
   pt1,pt2:TPoint;
begin
   Pic_Path  :=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\OneCoal'+'_9_1.BMP';
 try
   if OutExCel>=2  then  begin
      OutExCel:=3;
      Visible :=False;
      CanClose:=False;
   end else begin
      pt1:=ClientToScreen(self.BoundsRect.TopLeft) ;
      pt2:=ClientToScreen(self.BoundsRect.BottomRight) ;
      Public_Basic.ScreenSnap(pt1,pt2,Pic_Path);

      if Assigned(Form_StepResult) then  FreeAndNil(Form_StepResult);
   end;
 finally

 end;
end;

procedure TForm_StepResult.FormCreate(Sender: TObject);
begin
   OutExCel:=0;
   Pub_Exit:=False;
end;

procedure TForm_StepResult.FormShow(Sender: TObject);
begin
  PageControl_Result.Align :=alClient;
  PubLic_Basic.InitStatusBar(self.StatusBar1);
end;

function TForm_StepResult.GetDrawClass: TDrawGrap;
begin
   Result:=FUseDrawClass;
end;

function TForm_StepResult.GetExitFlag: integer;
begin
   Result:=OutExCel;
end;

function TForm_StepResult.GetUseStep: TOldSteps;
begin
    Result:=FUsedStep;
end;

procedure TForm_StepResult.InitKyfxResultStringGrid(GString:TStringGrid);
var
   i:integer;
begin
    for i := 1 to  GString.RowCount - 1 do  begin
          GString.Rows[i].Clear ;
          setlength(Kyfx_StringMeregExcel,0);
    end;

      GString.ColCount :=26;
      GString.RowCount :=3;
      GString.Font.Size:=9;
      GString.FixedRows :=2;
      GString.FixedCols :=1;

      GString.Cells [0,0]:='  ��';
      GString.Cells [0,1]:='  ��';
        InsertMeregCellToArray(0,0,0,1,Kyfx_StringMeregExcel);
        GString.ColWidths[0]:=30;
      GString.Cells [1,0]:='Ԥ����ʽ';
      GString.Cells [1,1]:='';
        InsertMeregCellToArray(1,0,1,1,Kyfx_StringMeregExcel);
        GString.ColWidths[1]:=50;

      GString.Cells [2,0]:='��ѹ�׶�';
      GString.Cells [2,1]:='';
        InsertMeregCellToArray(2,0,2,1,Kyfx_StringMeregExcel);
        GString.ColWidths[2]:=70;

      GString.Cells [3,0]:='�׶�֧�ܷ�Χ';
      GString.Cells [4,0]:='(��)';
        InsertMeregCellToArray(3,0,4,0,Kyfx_StringMeregExcel);
        GString.Cells [3,1]:=' ��ʼ';
        GString.Cells [4,1]:=' ����';
        GString.ColWidths[3]:=70;
        GString.ColWidths[4]:=70;

      GString.Cells [5,0]:='Ԥ������';
      GString.Cells [5,1]:='(��)';
        InsertMeregCellToArray(5,0,5,1,Kyfx_StringMeregExcel);
        GString.ColWidths[5]:=70;

      GString.Cells [6,0]:='��ѹ������Χ';
      GString.Cells [7,0]:='��ֵ(��)';
      InsertMeregCellToArray(6,0,7,0,Kyfx_StringMeregExcel);

      GString.Cells [6,1]:='��ʼ';
      GString.Cells [7,1]:='����';
        GString.ColWidths[6]:=70;
        GString.ColWidths[7]:=70;


      GString.Cells [8,0]:='֧����ѹ';
      GString.Cells [9,0]:='��Χ(��)';
        InsertMeregCellToArray(8,0,9,0,Kyfx_StringMeregExcel);
        GString.Cells [8,1]:=' ��ʼ';
        GString.Cells [9,1]:=' ����';
        GString.ColWidths[8]:=70;
        GString.ColWidths[9]:=70;

     GString.Cells [10,0]:='��Сѹ��';
     GString.Cells [10,1]:='(MPa)';
        InsertMeregCellToArray(10,0,10,1,Kyfx_StringMeregExcel);
        GString.ColWidths[10]:=70;

     GString.Cells [11,0]:='���ѹ��';
     GString.Cells [11,1]:='(MPa)';
        InsertMeregCellToArray(11,0,11,1,Kyfx_StringMeregExcel);
        GString.ColWidths[11]:=70;

     GString.Cells [12,0]:='ƽ��ѹ��';
     GString.Cells [12,1]:='(MPa)';
        InsertMeregCellToArray(12,0,12,1,Kyfx_StringMeregExcel);
        GString.ColWidths[12]:=70;

     GString.Cells [13,0]:='ѹ��ǿ��';
     GString.Cells [13,1]:='(��ֵΪ1)';
        InsertMeregCellToArray(13,0,13,1,Kyfx_StringMeregExcel);
        GString.ColWidths[13]:=70;

     GString.Cells [14,0]:='���ǿ��';
     GString.Cells [14,1]:='(��ֵΪ1)';
        InsertMeregCellToArray(14,0,14,1,Kyfx_StringMeregExcel);
        GString.ColWidths[14]:=70;

      GString.Cells [15,0]:='�ۺ�ǿ��';
     GString.Cells [15,1]:='(��ֵΪ1)';
        InsertMeregCellToArray(15,0,15,1,Kyfx_StringMeregExcel);
        GString.ColWidths[15]:=70;


     GString.Cells [16,0]:='Ԥ����';
     GString.Cells [17,0]:='ѹ���� ';
     GString.Cells [18,0]:='(��) ';
        InsertMeregCellToArray(16,0,18,0,Kyfx_StringMeregExcel);
        GString.Cells [16,1]:=' ƽ��';
        GString.Cells [17,1]:=' ��С';
        GString.Cells [18,1]:=' ���';
        GString.ColWidths[16]:=70;
        GString.ColWidths[17]:=70;
        GString.ColWidths[18]:=70;

     GString.Cells [19,0]:='������';
     GString.Cells [20,0]:='������';
     GString.Cells [21,0]:='(��)';
        InsertMeregCellToArray(19,0,21,0,Kyfx_StringMeregExcel);
        GString.Cells [19,1]:=' ƽ��';
        GString.Cells [20,1]:=' ��С';
        GString.Cells [21,1]:=' ���';

        GString.ColWidths[19]:=70;
        GString.ColWidths[20]:=70;
        GString.ColWidths[21]:=70;

     GString.Cells [22,0]:='�ȶ��˶�����';
     GString.Cells [22,1]:='(��)';
        InsertMeregCellToArray(22,0,22,1,Kyfx_StringMeregExcel);
        GString.ColWidths[22]:=70;

     GString.Cells [23,0]:='ѹ���������Ե�֧��';
        InsertMeregCellToArray(23,0,23,1,Kyfx_StringMeregExcel);
        GString.ColWidths[23]:=200;

end;

procedure TForm_StepResult.InsertMeregCellToArray(Col1, Row1, Col2,
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

procedure TForm_StepResult.MakeWindowsSingle(Single: integer);
begin
    if Single=0 then  begin
        WindowState:= wsMaximized;
        OutExCel:=0;
     end else if Single=1 then begin
        WindowState:= wsNormal;
        OutExCel:=1;
     end;
     Show;
end;

procedure TForm_StepResult.Memo_ResultClick(Sender: TObject);
begin
    Memo_Result.SetFocus;
end;

procedure TForm_StepResult.Memo_ResultMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt:Tpoint;
begin
   if Button=mbRight then begin
      pt:= self.Memo_Result.ClientToScreen(Point(0,0));
      DispResultPop (pt.X+x,pt.Y +y,'Memo');
   end;
end;

procedure TForm_StepResult.OnAccumulated(Sender: TOpenExcelThread);
begin
   OptionTip('Excel�������');

   if OutExCel=3 then  begin
      OutExCel:=0;
      Close;
   end else if OutExCel=2 then  begin
      OutExCel:=0;
   end;

end;

procedure TForm_StepResult.OptionTip(Str: String);
begin
   StatusBar1.Panels[0].Text :=str;
end;

procedure TForm_StepResult.PageControl_ResultChange(Sender: TObject);
begin
     if PageControl_Result.ActivePageIndex =0 then   begin
        self.But_DispPhase.Enabled :=true;
        self.But_DispWhole.Enabled :=true;
        self.But_SaveTxt.Enabled :=true;
        self.But_SaveExcel.Enabled :=False;
     end else begin
        self.But_DispPhase.Enabled :=False;
        self.But_DispWhole.Enabled :=False;
        self.But_SaveTxt.Enabled :=False;
        self.But_SaveExcel.Enabled :=true;
     end;

end;

procedure TForm_StepResult.PageControl_ResultDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
   if Active then
    begin
        Control.Canvas.Brush.Color := ClHighLight;
        Control.Canvas.Font.Color := clWhite;
    end;
    Control.Canvas.FillRect(Rect);
    Control.Canvas.TextOut(Rect.Left + 4,Rect.Top + 4,PageControl_Result.Pages[TabIndex].Caption)
end;

procedure TForm_StepResult.Pop_CloseClick(Sender: TObject);
begin
   Close;
end;

function TForm_StepResult.PrintResultIntoExcel(GString: TStringGRid): Boolean;
var
 str:string;
 S1,S2:Str_DT_array;
 C1,C2,i:integer;
begin
   InitKyfxResultStringGrid(GString);
   // ��ӡ���ݽ�StringGrid
   Str:=UseOldStep.PrintStepsIntoStringGrid(GString,DrawClass.FGzm );
   S1:=Public_Basic.split(str,';',c1);
   for I := 0 to C1-1 do begin
      S2:=public_Basic.split(s1[i],',',C2);
      if C2>=4  then
        InsertMeregCellToArray(public_Basic.StrToInt_lu(S2[0]),  public_Basic.StrToInt_lu(S2[1]),
                              public_Basic.StrToInt_lu(S2[2]), public_Basic.StrToInt_lu(S2[3]),
                              Kyfx_StringMeregExcel);
   end;

end;

function TForm_StepResult.PrintResultIntoMemo(Memo: Tmemo): Boolean;
begin

    //�Բ����з��� ������ѹ����ķ���
   if DrawClass.CloudClass.PrintDispPhaseVisual then  begin

       Result:=UseOldStep.PrintOldStepResult(Memo, DrawClass.FGzm ,
                         DrawClass.CloudClass.RecallMidDaoSaveStep,
                         DrawClass.CloudClass.PrintOutDaoStepInto,
                         DrawClass.DataTimeAndFootAge.Graph_MinDao,
                         DrawClass.DataTimeAndFootAge.Graph_MaxDao
                         );
   end else begin
      Result:=UseOldStep.PrintOldStepResult(Memo, DrawClass.FGzm ,
                         DrawClass.CloudClass.RecallMidDaoSaveStep,
                         DrawClass.CloudClass.PrintOutDaoStepInto,
                         DrawClass.DataTimeAndFootAge.Graph_MinDao,
                         DrawClass.DataTimeAndFootAge.Graph_MaxDao
                         );
   end;

end;

procedure TForm_StepResult.InitForm(iDrawG: TDrawGrap);
begin
    // ���ư�ť
     self.But_DispPhase.Enabled :=False;
    self.But_DispWhole.Enabled :=False;
    self.But_SaveTxt.Enabled :=False;
    self.But_SaveExcel.Enabled :=true;
    self.PageControl_Result.ActivePageIndex :=1;


    DrawClass:=iDrawG;
    UseOldStep:=iDrawG.Auto_Judge_OldStep;

    // ��ӡ ��ʼ
    PrintResultIntoMemo(Memo_Result) ;
    PrintResultIntoExcel(SG_Result);
end;

procedure TForm_StepResult.ResultPop_Print_PhaseClick(Sender: TObject);
begin
   DrawClass.CloudClass.PrintDispPhaseVisual:=false;
    if  DrawClass.Auto_Judge_OldStep.isCalComeStep  then  begin
            // ��ӡ ��ʼ
        PrintResultIntoMemo(Memo_Result) ;
        PrintResultIntoExcel(SG_Result);
   end;
end;

procedure TForm_StepResult.ResultPop_Print_wholeClick(Sender: TObject);
begin
   DrawClass.CloudClass.PrintDispPhaseVisual:=true;
    if  DrawClass.Auto_Judge_OldStep.isCalComeStep  then  begin
            // ��ӡ ��ʼ
        PrintResultIntoMemo(Memo_Result) ;
        PrintResultIntoExcel(SG_Result);
   end;
end;

procedure TForm_StepResult.ResultPop_SaveExcelClick(Sender: TObject);
var
  Tilte,t_s:string;
  thd:TOpenExcelThread;
begin
    t_s:='��ȷ��Ҫ����ΪExcel�𣿴�OFFice��ķ�һ��ʱ��'+#13#10+'�����ĵȴ���';
   if Application.MessageBox(Pwidechar(t_s),'��ʾ',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;
   Tilte:='��'+DrawClass.FGzm.S_Name+  '���������ѹʵʱ�������';
   Tilte:=Tilte+'(��������ʱ�䷶Χ:'+FormatDateTime('YYYY-MM-DD HH:SS:NN',DrawClass.DataTimeAndFootAge.StartTime )
                  + ' - '    +  FormatDateTime('YYYY-MM-DD HH:SS:NN',DrawClass.DataTimeAndFootAge.EndTime ) +   ')';

   OptionTip('���ڱ����ļ������ĵȴ�');
   OutExCel:=2; // ϵͳ���ڽ��е���
   // �˴�Ϊ���߳�ʱ�ա�
   thd:=TOpenExcelThread.Create(true);
   thd.OnAccumulated:=Self.OnAccumulated; // Self ָ�� FrmMain.
   thd.iCaption :=Tilte;
   thd.iStrGrid:=SG_Result;
   thd.in_StringMeregExcel:=Kyfx_StringMeregExcel;
   thd.ipathName:=Public_Basic.Get_MyModulePath+'saveBmp\KYJG\Result_'+IntToStr(DrawClass.FGzm.Gzmbh)+'.xls';
   thd.Start; //�����߳�,���߳�ʱ����ִ�� Execute �еĴ��롣
   //  start �������ز�ִ����һ������ DoSomeThing;
   //  ��ʱ�����������߳���ͬʱִ�С�
   //  1.���߳�,Ҳ���Ǵ˴����е�ʱ���롣
   //  2.�����߳�,Ҳ���� Execute �еĴ��룬��Щ�����ʱ�����ڶ��߳�ʱ�ա�
   //  �����������̲߳�����ִ�У��ʴ˴� DoSomeThing ���Ͽ���ִ�С�
   //  ����Ҳ�������
   //Public_Basic.StringGridtoExcel('��ѹ�������',SG_Result,10 );
end;

procedure TForm_StepResult.ResultPop_SaveTxtClick(Sender: TObject);
begin
       SaveDialog1.Filter :='���ı��ļ�(*.txt)|*.txt';
       SaveDialog1.Title :='*.txt';
       if SaveDialog1.Execute =true then  begin
          if ExtractFileExt(SaveDialog1.FileName) <> '.txt' then
                 SaveDialog1.FileName := ChangeFileExt(SaveDialog1.FileName,'.txt');
          SaveResultIntoFile(self.Memo_Result,SaveDialog1.FileName);
       end;
end;

function TForm_StepResult.SaveResultIntoFile(Memo1: TMemo;
  FileName: String): Boolean;
begin
    Memo1.Lines.SaveToFile(FileName);
end;

procedure TForm_StepResult.setDRawClass(Value: TDrawGrap);
begin
   FUseDrawClass:=Value;
end;

procedure TForm_StepResult.SetThreadStop;
begin
   Pub_Exit:=True;
   OutExCel:=0;
end;

procedure TForm_StepResult.SetUseStep(Value: TOldSteps);
begin
   FUsedStep:=Value;
end;

procedure TForm_StepResult.SG_ResultMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt:Tpoint;
begin
   if Button=mbRight then begin
      pt:= SG_Result.ClientToScreen(Point(0,0));
      DispResultPop (pt.X+x,pt.Y +y,'StringGrid');
   end;


end;

{ TOpenExcelThread }



procedure TOpenExcelThread.Execute;
begin
  inherited;
     StringGridToExcel_MegerCell(false,iCaption,iStrGrid,10, in_StringMeregExcel,ipathName);
     if Assigned(OnAccumulated) then
       OnAccumulated(self);
end;

function TOpenExcelThread.StringGridToExcel_MegerCell(Disp: Boolean;
  atitle: string; Astringgrid: Tstringgrid; Afontsize: integer;
  arry: Rec_StringToExcel_Array; Path: string): String;
var
     xlapp, xlsheet: variant;
     row, CCC, nnn, jjj: integer;
     s_out,Meger_Str:String;
     i,t,k:integer;
begin
  try
    xlapp := createoleobject('excel.application');
  except
    s_out:='not found excel in your system, so can not create file!';
    exit;
  end;
  try
    ccc := Astringgrid.ColCount;

    xlapp.workbooks.add; //�����¹�����
    xlapp.visible := false;
    xlsheet := xlapp.activesheet;
    xlapp.activewindow.windowstate := 2;
    //�ϲ����ⵥԪ��
    xlapp.range[xlsheet.cells[1, 1], xlsheet.cells[1, ccc]].MERGE;
    xlsheet.cells[1, 1].value := Atitle; //ҳͷ��һ�У�
    xlsheet.cells[1, 1].HorizontalAlignment := -4108;
    xlsheet.cells[1, 1].font.size := Afontsize+4;
    // �ϲ�������Ԫ��
     for I := 0 to High(arry) do  begin
         if Pub_Exit then exit;
         xlapp.range[
                     xlsheet.cells[arry[i].FromRow+2,arry[i].FromCol+1 ],
                     xlsheet.cells[arry[i].ToRow+2,arry[i].ToCol+1 ]
                     ].MERGE;
         // ���䷽ʽ
        xlsheet.cells[arry[i].FromRow+2,arry[i].FromCol+1].HorizontalAlignment := -4108;
        Meger_Str:='';
        for t := arry[i].FromCol to arry[i].ToCol do
          for k := arry[i].FromRow to arry[i].ToRow do  begin
              if Pub_Exit then exit;

              Meger_Str:= Meger_Str+ Astringgrid.Cells[t,k] ;
          end;

        xlsheet.cells[arry[i].FromRow+2,arry[i].FromCol+1].value := Meger_Str; //ҳͷ��һ�У�
     end;
    //

    row := 2;
    for jjj := 0 to Astringgrid.RowCount - 1 do
    begin
      for nnn := 1 to ccc do  begin
         if Pub_Exit then exit;
         if trim(xlsheet.cells[row, nnn])='' then
            xlsheet.cells[row, nnn] := trim(Astringgrid.Cells[nnn - 1, row - 2]);
            xlsheet.cells[row, nnn].HorizontalAlignment := -4108;
      end;
      xlsheet.rows[row].RowHeight := 18;
      inc(row);
    end;

     if Disp then  xlapp.visible := true;
        //��ʽ����

    xlapp.range[xlsheet.cells[row, 1], xlsheet.cells[row, 13]].WrapText := True;
    xlapp.range[xlsheet.cells[row, 1], xlsheet.cells[row, 13]].HorizontalAlignment := -4108;

    xlsheet.pagesetup.headerMargin := 1 / 0.035; //ҳü�����˱߾�1cm
    xlsheet.pagesetup.footerMargin := 0.6 / 0.035; //ҳ�ŵ��׶˱߾�1cm
    xlsheet.pagesetup.topMargin := 1 / 0.035; //���߾�1cm
    XLSHEET.pagesetup.bottomMargin := 1.3 / 0.035; //�ױ߾�1cm
    xlsheet.pagesetup.leftMargin := 0.5 / 0.035; //��߾�1cm
    xlsheet.pagesetup.rightMargin := 0.5 / 0.035; //�ұ߾�1cm
  //  xlsheet.pagesetup.leftfooter := '�Ʊ�: ' + Puboptername;
    xlsheet.pagesetup.centerfooter := ''; //ҳ��
    xlsheet.pagesetup.rightfooter := '��&Pҳ/��&Nҳ';
    xlsheet.pagesetup.leftHeader := '';
    xlsheet.pagesetup.orientation := 1; //����
    xlsheet.pagesetup.printtitlerows := '$1:$1';
    xlsheet.rows[1].font.name := '����'; //���õ�һ����������
    xlsheet.rows[1].font.bold := true;
    xlsheet.rows[1].font.size := 16;
    xlsheet.rows[1].RowHeight := 28;

    for nnn := 1 to ccc do
    begin
      if Pub_Exit then exit;
      xlsheet.columns[nnn].columnwidth := Astringgrid.ColWidths[nnn - 1] * 0.1188;
    end;

    for nnn := 1 to 4 do begin
      if Pub_Exit then exit;
      xlapp.range[xlsheet.cells[2, 1], xlsheet.cells[row - 1, CCC]].borders[nnn].linestyle := 1;
      xlapp.range[xlsheet.cells[2, 1], xlsheet.cells[row - 1, CCC]].borders[nnn].weight := 1;
    end;

    xlapp.range[xlsheet.cells[2, 1], xlsheet.cells[row - 1, CCC]].font.size := Afontsize;
    xlapp.range[xlsheet.cells[2, 1], xlsheet.cells[row - 1, ccc]].WrapText := True;

    //if (not Disp) and (Path <>'')  then   xlapp.workbooks(1).SaveAs(Path);

    varclear(xlsheet);
    varclear(xlapp);


  except
    on E: Exception do
    begin
      xlapp.quit;
      s_out:='Eorr';
    end;
  end;

end;

end.