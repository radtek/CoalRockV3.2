unit uWorkSupWeightUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls,ComObj, Vcl.StdCtrls,
  Vcl.AppEvnts;

type
  TFormSupWeight = class(TForm)
    ToolBar1: TToolBar;
    EtractDataFromData: TToolButton;
    UpdataAutoData: TToolButton;
    SaveDataIntoData: TToolButton;
    DeleteButton: TToolButton;
    ExitButton: TToolButton;
    ImageList1: TImageList;
    Panel_OpenWindows: TPanel;
    StatusBar1: TStatusBar;
    Panel_Result: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel_RG_Sup: TPanel;
    Image_RG: TImage;
    Panel_RG_Work: TPanel;
    Panel_GzmInfo: TPanel;
    ToolButton1: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EtractDataFromDataClick(Sender: TObject);
    procedure SaveDataIntoDataClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure UpdataAutoDataClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure ToolButton1Click(Sender: TObject);
  private
    { Private declarations }
    UpdataState:Boolean;
    MyStringGrid:TStringGrid;
    RG_Work:Array of TRadioGroup;
    RG_Sup: array of TRadioGroup;
    procedure CreatePublic;
    procedure InitPanel_RG_Sup;
    procedure InitPanel_RG_Work;
    procedure InitStringGrod;
    procedure FillStringGrid;
    function  GetSupportWigthRows:integer;
    function  GetSupportWigthCols:integer;
    procedure SetRowHead;
    procedure SetColHead;
    procedure loadexcel(inrows, incols:integer; fileName:String);{ Private declarations }
    procedure SaveDataIntoClass;
    procedure OptionTip(Str: String);
    procedure DataClassDisptoStringGrid;
    //
    procedure OpenInputDataWindows;
    procedure DispComprehensiveEvaluationResult;
    // DispComprehe
    procedure ADjustPanel_RG_Sup;
    procedure ADjustPanel_RG_Work;
    procedure Rad_Sup_Click(Sender: TObject);
    procedure Rad_Work_Click(Sender: TObject);

  public
    { Public declarations }
  end;

var
  FormSupWeight: TFormSupWeight;
  function ShowSupportWeight(AHandle:THandle;ACaption:string;Wid,Hi:integer):integer;stdcall;
  function Show_DCE_Result(AHandle:THandle;ACaption:string;Wid,Hi:integer):integer;stdcall;
implementation

{$R *.dfm}

uses SupportWeightClass, Lu_Public_BasicModual, MainCallUnit, UMainDataModule;

{ TForm2 }
function ShowSupportWeight(AHandle:THandle;ACaption:string;Wid,Hi:integer):integer;stdcall;

begin
    if Assigned(FormSupWeight) then   FreeAndNil(FormSupWeight);
    FormSupWeight:=TFormSupWeight.Create(nil);
    try
       with FormSupWeight do begin
            Caption:=ACaption;
            WindowState:= wsNormal;
            ParentWindow:=Ahandle;
            if Hi >Height then
              Top :=Round((Hi-Height)/3)
            else   Top :=0;
            if Wid> Width then
                Left:=Round((Wid-Width)/2)
            else  Left:=0;
            //---------------
             OpenInputDataWindows;
            Show;
       end;
        Result:=1;//����ֵ
    except
          FreeAndNil(FormSupWeight);
     end;
end;
 function Show_DCE_Result(AHandle:THandle;ACaption:string;Wid,Hi:integer):integer;stdcall;
begin
    Application.Handle := AHandle;
    if Assigned(FormSupWeight) then   FreeAndNil(FormSupWeight);
    FormSupWeight:=TFormSupWeight.Create(nil);
    try
       with FormSupWeight  do  begin
            Caption:=ACaption;
            WindowState:= wsMaximized;
            ParentWindow:=Ahandle;
            if Hi >Height then
              Top :=Round((Hi-Height)/3)
            else   Top :=0;
            if Wid> Width then
                Left:=Round((Wid-Width)/2)
            else  Left:=0;
            //---------------
            DispComprehensiveEvaluationResult;

            Show;
       end;
        Result:=1;//����ֵ
    except
         FreeAndNil(FormSupWeight);
     end;
end;

procedure TFormSupWeight.EtractDataFromDataClick(Sender: TObject);
begin
    t_SupWeigth.ExtractDataFromDataBase;
     DataClassDisptoStringGrid;
end;

procedure TFormSupWeight.ADjustPanel_RG_Sup;
var
  TopBlank,LeftBlank:integer;

  width1,height1:integer;
  i,j:integer;
begin
  TopBlank:=trunc(Panel_RG_Sup.Height/30);
  LeftBlank:=trunc(Panel_RG_Sup.Width/40);
  Width1:=trunc(Panel_RG_Sup.Width/40*35/4);
  height1:=trunc(Panel_RG_Sup.Height/30*20/9);

   for I := 0 to 3 do   begin
      RG_Sup[i].Width:= Width1;
      RG_Sup[i].Height :=trunc(height1*2);
      j:= i mod 4;
      RG_Sup[i].Left:=LeftBlank+j*(Width1+LeftBlank);
      RG_Sup[i].top :=TopBlank;
      RG_Sup[i].Columns :=1;
   end;
   for I := 4 to 10 do  begin
      RG_Sup[i].Width:= trunc(Width1*2+LeftBlank);
      RG_Sup[i].Height :=height1;
      RG_Sup[i].Left:=LeftBlank;
      j:=(i-4) ;
      RG_Sup[i].top := RG_Sup[3].Top+ RG_Sup[3].Height +
                         TopBlank+(height1+TopBlank)*j ;
      RG_Sup[i].Columns :=2;
   end;
 //
  Image_Rg.Top:=RG_Sup[4].Top;
  Image_Rg.Left:=RG_Sup[4].Left+RG_Sup[4].Width+LeftBlank;
  Image_Rg.Width:=RG_Sup[4].Width;
  Image_Rg.Height:=RG_Sup[4].Height*7 + LeftBlank*4;

end;

procedure TFormSupWeight.ADjustPanel_RG_Work;
var
  TopBlank,LeftBlank:integer;
  width1,height1:integer;
  i,j:integer;
begin
  TopBlank:=trunc(Panel_RG_Sup.Height/40);
  LeftBlank:=trunc(Panel_RG_Sup.Width/30);
  Width1:=trunc(Panel_RG_Sup.Width/30*28);
  height1:=trunc(Panel_RG_Sup.Height/16);

   for I := 0 to 7 do   begin
      RG_Work[i].Width:= Width1;
      if RG_Work[i].Items.Count <5 then  begin
         RG_Work[i].Height :=trunc(height1);
         RG_Work[i].Columns :=1;
      end else if RG_Work[i].Items.Count <9  then begin
         RG_Work[i].Height :=trunc(height1*1.6);
         RG_Work[i].Columns :=2;
      end else begin
         RG_Work[i].Height :=trunc(height1*2.4);
         RG_Work[i].Columns :=3;
      end;
      if i=0 then
         RG_Work[i].top :=TopBlank
      else
         RG_Work[i].top :=TopBlank+RG_Work[i-1].Top+RG_Work[i-1].Height;

      RG_Work[i].Left:=LeftBlank;

      RG_Work[i].Columns :=4;
   end;

end;

procedure TFormSupWeight.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
var
  i: Integer;
  ctr: TWinControl;
begin
  if Msg.message = WM_LBUTTONDOWN then
  begin
    for i := 0 to ControlCount - 1 do
    begin
      if ctr is TWinControl then ctr := Controls[i] as TWinControl;
      if (ctr.ClassNameIs('TRadioGroup')) and (ctr.Handle = Msg.hwnd) then
        ShowMessage('�����' + ctr.Name);
    end;
  end;

end;

procedure TFormSupWeight.CreatePublic;

begin
    Panel_GzmInfo.Caption :=MainDataModule.Coal_Name+'ú��'+MainDataModule.WorkFace_Name+
                  '�������濪�ɼ���������֧�ܽṹ��ר�ҽ����嵥 ' ;
    MyStringGrid:=TStringGrid.Create(nil) ;
    InitStringGrod;
    FillStringGrid;
    //��ʼ��Һѹ֧�ܽṹ��
    InitPanel_RG_Sup;
    //��ʼ�����ɼ��������ж�
    InitPanel_RG_Work;
    UpdataState:=false;
end;

procedure TFormSupWeight.DataClassDisptoStringGrid;
var
  i:integer;
  Row,Col:Integer;
begin
    for i := 0 to t_SupWeigth.Data_Value_Count-1 do   begin
        Row:=t_SupWeigth.Data_Value[i].RowNumber;
        Col:=t_SupWeigth.Data_Value[i].ColNumber;
        MyStringGrid.Cells[Col,Row]:= FormatFloat('0.00',t_SupWeigth.Data_Value[i].value);
    end;

end;

procedure TFormSupWeight.DeleteButtonClick(Sender: TObject);
begin
    // ��Ҫ�����ڴӱ���xls�е������ݣ�����ʹ��
    OptionTip('������ȡ���ݣ����ĵȴ���');
    self.loadexcel(self.GetSupportWigthRows,self.GetSupportWigthCols,'d:\123.xls');
end;

procedure TFormSupWeight.DispComprehensiveEvaluationResult;
begin
    Panel_Result.Visible :=true;
    Panel_Result.Align :=alClient;
    Panel_OpenWindows.Visible :=False;

    self.UpdataAutoData.Enabled :=true;
    Self.EtractDataFromData.Enabled :=False;
    self.SaveDataIntoData.Enabled :=False;

end;

procedure TFormSupWeight.UpdataAutoDataClick(Sender: TObject);
var
 i,j:integer;
begin
 for I := 0 to 10 do begin
    if RG_Sup[i].ItemIndex =0 then
      t_SupWeigth.SupportInfo.Child_Second[i].Selected :=t_SupWeigth.SupportInfo.Child_Second[i].Firstid
      else  t_SupWeigth.SupportInfo.Child_Second[i].Selected :=t_SupWeigth.SupportInfo.Child_Second[i].Secondid;
 end;
 for I := 0 to 7 do begin
     t_SupWeigth.WorkFaceInfo.Child_Second[i].Selected :=RG_Work[i].ItemIndex;
 end;

 UpdataState:=false;
 OptionTip('����޸ĳɹ���');
end;

procedure TFormSupWeight.ExitButtonClick(Sender: TObject);
begin
   Close;
end;

procedure TFormSupWeight.FillStringGrid;
begin
    SetRowHead;
    SetColHead;
end;

procedure TFormSupWeight.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  t_s:widestring;
begin
   t_s:='�����иĶ�����ȷ�ϱ����޸Ľ��ô��';
   if Self.UpdataState then
     if Application.MessageBox(Pwidechar(t_s),'��ʾ',MB_OKCANCEL+MB_ICONQUESTION) =1 then
         self.UpdataAutoData.Click ;
   if Assigned(FormSupWeight) then   FreeAndNil(FormSupWeight);
end;

procedure TFormSupWeight.FormCreate(Sender: TObject);
var
  i:integer;
begin
    CreatePublic;
end;

procedure TFormSupWeight.FormDestroy(Sender: TObject);
var
  i:integer;
begin
    if assigned(MyStringGrid) then  FreeAndNil(MyStringGrid);
    for I := 0 to 10 do
      if Assigned( RG_Sup[i])  then freeAndNil(RG_Sup[i]);

end;

procedure TFormSupWeight.FormResize(Sender: TObject);
begin
    ADjustPanel_RG_Sup;
    ADjustPanel_RG_Work
end;

procedure TFormSupWeight.FormShow(Sender: TObject);
begin
    PubLic_Basic.InitStatusBar(self.StatusBar1);
    ADjustPanel_RG_Sup;
    ADjustPanel_RG_Work
end;

function TFormSupWeight.GetSupportWigthCols: integer;
var
  Col,i,j:Integer;
begin
   Col:=5;
    for i := 0 to t_SupWeigth.SupportInfo.Child_count-1 do
        Col:= Col+t_SupWeigth.SupportInfo.Child_Second[i].Child_count;
    if Col < 6 then  Result:=6
       else   Result:=Col;
end;

function TFormSupWeight.GetSupportWigthRows: integer;
var
  Row,i,j:Integer;
begin
    Row:=5;
    for i := 0 to t_SupWeigth.WorkFaceInfo.Child_count-1 do
        Row:= Row+t_SupWeigth.WorkFaceInfo.Child_Second[i].Child_count;
    Result:=Row;
end;

procedure TFormSupWeight.InitPanel_RG_Sup;
var
  i:integer;
  firstid:integer;
begin
     //===
   Setlength(RG_Sup,11);
   for I := 0 to 10 do begin
      RG_Sup[i]:=TRadioGroup.Create(nil);
      RG_Sup[i].Parent:=Panel_RG_Sup;
      RG_Sup[i].Caption :=t_SupWeigth.SupportInfo.Child_Second[i].Name;
      firstid:=t_SupWeigth.SupportInfo.Child_Second[i].Firstid;
      RG_Sup[i].Items.Add(t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[firstid].BianMa + '����������ֵ��'+
                           FormatFloat('0.00', t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[firstid].AGV_Value)  );

      firstid:=t_SupWeigth.SupportInfo.Child_Second[i].Secondid;
      RG_Sup[i].Items.Add(t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[firstid].BianMa+  '����������ֵ��'+
                           FormatFloat('0.00', t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[firstid].AGV_Value)  );
       if t_SupWeigth.SupportInfo.Child_Second[i].Selected =t_SupWeigth.SupportInfo.Child_Second[i].Firstid then
          RG_Sup[i].ItemIndex :=0 else RG_Sup[i].ItemIndex :=1;
      RG_Sup[i].Tag :=i;
      RG_Sup[i].OnClick :=Rad_Sup_Click ;
   end;
end;

procedure TFormSupWeight.InitPanel_RG_Work;
var
  i,j:integer;
  selectedid:integer;
begin
     //===
   Setlength(RG_work,8);
   for I := 0 to 7 do begin
      RG_work[i]:=TRadioGroup.Create(nil);
      RG_work[i].Parent:=Panel_RG_work;
      RG_work[i].Caption :=t_SupWeigth.WorkFaceInfo.Child_Second[i].Name;
      for j := 0 to t_SupWeigth.WorkFaceInfo.Child_Second[i].Child_count-1 do
         RG_work[i].Items.Add (t_SupWeigth.WorkFaceInfo.Child_Second[i].Child_Third[j].Name );

      RG_work[i].ItemIndex :=t_SupWeigth.WorkFaceInfo.Child_Second[i].selected;
      RG_work[i].Tag :=i;
      RG_work[i].OnClick :=Rad_Work_Click ;
   end;

end;

procedure TFormSupWeight.InitStringGrod;
var
  i,j,k:integer;
begin
  with MyStringGrid do begin
         Parent:=Panel_OpenWindows;
         Align :=alClient ;
         RowCount :=GetSupportWigthRows;
         ColCount :=GetSupportWigthCols;
         FixedCols:=3;
         FixedRows:=4;
         Cells[round(ColCount/2),0]:=t_SupWeigth.SupportInfo.Name;
         Cells[3,2]:=t_SupWeigth.SupportInfo.Name;

         j:=length(trim(t_SupWeigth.WorkFaceInfo.Name));
         K:= Round(GetSupportWigthRows /9 );
         for I := 2 to 7 do begin
             Cells[0,5+k*(i-1)+1]:=Copy(Trim(t_SupWeigth.WorkFaceInfo.Name),(i)-1,1);
         end;
         Cells[1,3]:=t_SupWeigth.WorkFaceInfo.Name;
         ColWidths[0]:=20;
         ColWidths[1]:=80;
         ColWidths[2]:=120;

     end;

     MyStringGrid.Options:=MyStringGrid.Options +[goEditing];
end;

procedure TFormSupWeight.loadexcel(inrows, incols: integer; fileName: String);
var
   v:variant;
   i,j:integer;
begin
   with MyStringGrid do begin
         RowCount:=inrows;
         ColCount:=incols;
         v:=createoleobject('Excel.Application');//����OLE����
         try
           V.workBooks.Open(fileName);
           //for i:=1 to rowCount do
           for j:=4 to inrows do  begin
                 for i:=3 to incols do   begin
                      Cells[i,j]:=v.workbooks[1].sheets[1].cells[j,i];
                 end;
           end;
              v.workbooks[1].close;
         finally
           v.quit;
         end
   end;
end;

procedure TFormSupWeight.OpenInputDataWindows;
begin

   self.Panel_OpenWindows.Visible :=true;
   self.Panel_OpenWindows.Align :=alClient;
   self.Panel_Result.Visible :=False;
   self.UpdataAutoData.Enabled :=False;
   Self.EtractDataFromData.Enabled :=true;
   self.SaveDataIntoData.Enabled :=true;

end;

procedure TFormSupWeight.OptionTip(Str: String);
begin
    self.StatusBar1.Panels[0].Text :=str;
end;

procedure TFormSupWeight.Rad_Sup_Click(Sender: TObject);
var
 RadNumber:integer;
 selected:integer;
 bmpId:integer;
begin
   RadNumber:=TRadioGroup(Sender).Tag ;

   if RG_Sup[RadNumber].ItemIndex =0 then begin
     selected:=t_SupWeigth.SupportInfo.Child_Second[RadNumber].Firstid ;
   end else begin
     selected:=t_SupWeigth.SupportInfo.Child_Second[RadNumber].Secondid ;
   end;
   bmpId:=t_SupWeigth.SupportInfo.Child_Second[RadNumber].Child_Third[selected].id ;
   MainDataModule.MySqliteDataBase.GetBMPToSQlite(bmpId,'3',Image_RG.Picture.Bitmap );
   UpdataState:=true;
end;

procedure TFormSupWeight.Rad_Work_Click(Sender: TObject);
begin
    UpdataState:=true;
end;

procedure TFormSupWeight.SaveDataIntoDataClick(Sender: TObject);
begin
      OptionTip('���ڱ������ݣ����ĵȴ���');
   SaveDataIntoClass;
end;

procedure TFormSupWeight.SaveDataIntoClass;
var
  R_i,R_j,C_i,C_j:integer;
  Cell_Value:double;
begin
    for R_i := 0 to t_SupWeigth.WorkFaceInfo.Child_count-1 do
       for R_j := 0 to t_SupWeigth.WorkFaceInfo.Child_Second[R_i].Child_count-1 do
          for C_i := 0 to t_SupWeigth.SupportInfo.Child_count-1 do
            for C_j := 0 to t_SupWeigth.SupportInfo.Child_Second[C_i].Child_Count-1 do  begin
               Cell_Value:=  public_Basic.StrTodouble_lu(
                           MyStringGrid.Cells[t_SupWeigth.SupportInfo.Child_Second[C_i].Child_Third[C_j].ColNumber,
                                              t_SupWeigth.WorkFaceInfo.Child_Second[R_i].Child_Third[R_j].RowNumber]
                            );

               if Cell_Value >0 then
                       t_SupWeigth.AddDataValue(
                          t_SupWeigth.WorkFaceInfo.Child_Second[R_i].Child_Third[R_j].id,
                          t_SupWeigth.SupportInfo.Child_Second[C_i].Child_Third[C_j].id,
                          t_SupWeigth.WorkFaceInfo.Child_Second[R_i].Child_Third[R_j].RowNumber,
                          t_SupWeigth.SupportInfo.Child_Second[C_i].Child_Third[C_j].ColNumber,
                          Cell_Value);


            end;

    t_SupWeigth.SaveDataIntoDataBase ;

    OptionTip('�������ݳɹ������ĵȴ���');
end;

procedure TFormSupWeight.SetColHead;
var
  i,j:integer;
  Cols:Integer;
begin
    Cols:=3;
//    MyStringGrid.LockPaint;

    for I := 0 to t_SupWeigth.SupportInfo.Child_count-1   do  begin
        MyStringGrid.Cells[Cols,1]:=t_SupWeigth.SupportInfo.Child_Second[i].Name;
        for j := 0 to t_SupWeigth.SupportInfo.Child_Second[i].Child_count-1 do   begin
               MyStringGrid.Cells[Cols,2]:=t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[j].BianMa;
               MyStringGrid.Cells[Cols,3]:=t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[j].Name;
               t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[j].ColNumber :=Cols;
               Cols:=Cols+1;
        end;

    end;
end;

procedure TFormSupWeight.SetRowHead;
var
  i,j:integer;
  Rows:Integer;
begin
    Rows:=4;


    for I := 0 to t_SupWeigth.WorkFaceInfo.Child_count-1   do  begin
        MyStringGrid.Cells[1,Rows]:=t_SupWeigth.WorkFaceInfo.Child_Second[i].Name;
        for j := 0 to t_SupWeigth.WorkFaceInfo.Child_Second[i].Child_count-1 do   begin
               MyStringGrid.Cells[2,Rows]:=t_SupWeigth.WorkFaceInfo.Child_Second[i].Child_Third[j].Name;
               t_SupWeigth.WorkFaceInfo.Child_Second[i].Child_Third[j].RowNumber:= Rows;
               Rows:=Rows+1;
        end;

    end;
end;

procedure TFormSupWeight.ToolButton1Click(Sender: TObject);
var
 i,j:integer;
 Firstid,Secondid:integer;
 Get_Kcjscs:AnsiString;
begin
//
   // ��Ҫ�ǲ����ۺϼ������ݵ���ȷ�ԣ�����ʹ��
    Get_Kcjscs:=strpas(Main_CallPStope.UsePStope.Get_kcjstj('1.0'));
    t_SupWeigth.WithoutOptionMakeResult(Get_Kcjscs);
    self.SetRowHead ;
    self.SetColHead ;
    for i := 0 to t_SupWeigth.SupportInfo.Child_count-1 do
         for j:=0 to t_SupWeigth.SupportInfo.Child_Second[i].Child_Count -1 do
            MyStringGrid.Cells[t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[j].ColNumber ,
               5]:= FormatFloat('0.00',t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[j].AGV_Value);

//   //��ӡ�����
    for i := 0 to t_SupWeigth.SupportInfo.Child_count-1 do begin
        Firstid:= t_SupWeigth.SupportInfo.Child_Second[i].Firstid;
        Secondid:=t_SupWeigth.SupportInfo.Child_Second[i].Secondid;
        MyStringGrid.Cells[t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[Firstid].ColNumber ,6]:=
          FormatFloat('0.00',t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[Firstid].AGV_Value);
        MyStringGrid.Cells[t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[Secondid].ColNumber ,7]:=
          FormatFloat('0.00',t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[Secondid].AGV_Value);
    end;

end;

end.