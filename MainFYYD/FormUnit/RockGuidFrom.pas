unit RockGuidFrom;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Grids, Vcl.Menus, System.ImageList, Vcl.ImgList, Vcl.Buttons;

type
  TMyLabel =Class(TLabel)
   private
     FKeyid:integer;
     FLayerCount:integer;
     FSortid:integer;
     FLineHeigth:integer;
     FTop,FLeft,FWidth,FHeigth:integer;
     NodeCount:integer;
     Nodes:Array of TMyLabel;

     function GetKeyid:integer;
     procedure SetKeyid(Value:integer);
     function GetLayers:integer;
     procedure SetLayers(Value:integer);
     function GetSortid:integer;
     procedure SetSortid(Value:integer);
     function GetLineHeigth:integer;
     procedure SetLineHeigth(Value:integer);
     function GetSTop:integer;
     procedure SetSTop(Value:integer);
     function GetSLeft:integer;
     procedure SetSLeft(Value:integer);
     function GetEWidth:integer;
     procedure SetEWidth(Value:integer);
     function GetEHeigth:integer;
     procedure SetEHeigth(Value:integer);
     procedure OpenContourForm(Handl:Thandle;Vis:boolean);// ��ConTourForm

  public
      EXPaintid:integer;
      parentClass: TMyLabel;
      ShowMotherPanel:TPanel;
      RijiMemo:TMemo;
      ChlidDisplay:Boolean;
      procedure SetVisible(Value:Boolean);
      function  AddOneNode(caption:string;hg_BS,Kid:integer):TMyLabel;
      procedure ClearItems;
      procedure SetPosition;
      procedure DrawLine(NextLabel:TMyLabel;LineWidth:integer;LineColor:TColor);
      procedure MYLabelOnClick(Sender: TObject);
      procedure DispLayChlidNode(Value:Boolean);
      procedure OpenChildFrom(ClickId:integer);
      procedure OpenSecondChlidForm(ClickId:integer;P_W,P_H:integer);
      procedure OpenThirdChlidForm(ClickId:integer;P_W,P_H:integer);

      procedure WriteRizhi(Value:string);


      constructor Create(AOwner:TComponent);override;
      destructor Destroy;override;
   published
    property Keyid: Integer read GetKeyid write SetKeyid;
    property Layers:integer read GetLayers write SetLayers;
    property Sortid:integer read GetSortid write SetSortid;
    property LineHeigth:integer read GetLineHeigth write SetLineHeigth;
    property NextTop:integer read GetSTop write SetSTop;
    property NextLeft:integer read GetSLeft write SetSLeft;
    property NextWidth:integer read GetEWidth write SetEWidth;
    property NextHeigth:integer read GetEHeigth write SetEHeigth;
  End;
  
  TMyFlowChart =Class
   private
      parentPanel:TPanel;
      parentWidth,ParentHeigth:integer;
      LeftBlank,RightBlank:integer;
      VerticalWidth, VerticalHeigth:integer;
      HorizontalWidth,HorizontalHeigth:integer;
      VerticalCount:integer;
      FlowRoot:TMyLabel;

      //

      procedure CreatFirstNodes(Node:TMyLabel);
      procedure CreatSecondNode(Node:TMyLabel;Sortid:integer);
      procedure CreateThreeNode(Node:TMyLabel;Sortid:integer);
  public
    EXPaintid:integer;
    ShowMotherPanel:TPanel;
    RijiMemo:TMemo;
    procedure CreateRootNode;
    constructor Create(AOwner:TPanel);
    destructor Destroy;override;
  End;


  TRockGuid = class(TForm)
    LeftPanel: TPanel;
    Gzm_GroupBox: TGroupBox;
    Splitter1: TSplitter;
    ZK_GroupBox: TGroupBox;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    MainPanel: TPanel;
    SelectTime1: TTimer;
    WorkFaceSG: TStringGrid;
    ImageList1: TImageList;
    Pop_LeftGzm: TPopupMenu;
    N4: TMenuItem;
    Pop_Left_Change_Gzm: TMenuItem;
    N9: TMenuItem;
    Pop_LeftAdd_Gzm: TMenuItem;
    N6: TMenuItem;
    Pop_left_AddZk: TMenuItem;
    N12: TMenuItem;
    Pop_left_ZkYc: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ZkYCSG: TStringGrid;
    Zk_Image: TImage;
    TopPanel: TPanel;
    GroupBox3: TGroupBox;
    Splitter2: TSplitter;
    MemoRizhi: TMemo;
    RightPanel: TPanel;
    Image1: TImage;
    procedure SelectTime1Timer(Sender: TObject);
    procedure WorkFaceSGMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Pop_Left_Change_GzmClick(Sender: TObject);
    procedure Pop_LeftAdd_GzmClick(Sender: TObject);
    procedure Pop_left_AddZkClick(Sender: TObject);
    procedure Pop_left_ZkYcClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Zk_ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ZkYCSGMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure MemoRizhiClick(Sender: TObject);
  private
    { Private declarations }
     ControlState:Integer;//���� ״̬��¼
     MyFlowChart:TMyFlowChart ;
     procedure MakeWindowsSingle(Single:integer); // ����ҳ����ʾ��ʽ
     procedure DisplayWorkFaceAndZkInformation; // ��ʾ����빤���������Ϣ

       // pop
     procedure DispleftPanel(Px,py:Integer); // ��ʾ ѡ�еĿ�ݷ�ʽ

  public
    { Public declarations }
  end;

 function CreateRockGuidForm(AHandle:THandle;ACaption:string;Wid,Hi,Single:integer):THandle;stdcall;

var
  RockGuid: TRockGuid;
  EXKeyWord:Integer;
implementation

{$R *.dfm}

uses MainForm, FormMonitor, Lu_Public_BasicModual;
//--------------------
function CreateRockGuidForm(AHandle:THandle;ACaption:string;Wid,Hi,Single:integer):THandle;stdcall;
{

  Single 0 ����ҳ��  1 ȫ��ҳ��
}
begin
        if Assigned(RockGuid) then  FreeAndNil(RockGuid);
        Application.Handle :=AHandle;
        RockGuid:=TRockGuid.Create(Application);

         try
           with RockGuid do begin
               Caption:=ACaption;
               ParentWindow:=Ahandle;
               MakeWindowsSingle(Single);
               Result:=RockGuid.Handle ;//����ֵ
          end ;
        except
           FreeAndNil(RockGuid);
        end;

end;

//---------------------

{ TRockGuid }

procedure TRockGuid.DisplayWorkFaceAndZkInformation;
begin
   // �ļ��аѵ�ǰ�������������Ϣ����
   MainCForm.RefreshUsedInformation ;
   // �ѿ�ѹ��������и���
   MainCForm.CallPStope.SetReCallPStope(true);
   // ��д TopPanel����
   TopPanel.Caption :='��ǰģ����ǡ�'+MainCForm.pUser.Coal_Name+'��ú�󡪡���'+MainCForm.pUser.WorkFace_Name+'��' +
                       '������';
   MainCForm.CallPStope.GetWorkFaceInfo(WorkFaceSG);
   MainCForm.CallPStope.GetZkYcInfo(ZkYCSG);
   Zk_Image.Align :=alClient;
   Zk_Image.Height :=TabSheet1.Height;
   MainCForm.CallPStope.GetYcZKT(Zk_Image);
end;

procedure TRockGuid.DispleftPanel(Px, py: Integer);
begin
    Pop_LeftGzm.Popup(px,py);
end;

procedure TRockGuid.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
      MainCForm.UserWin.CloseActiveForm('all') ;
      MainCForm.Call_RockPress.CloseActiveForm('All');
      MainCForm.CallPStope.CloseActiveForm('All');

      if Assigned(RockGuid) then  FreeAndNil(RockGuid);
end;

procedure TRockGuid.FormCreate(Sender: TObject);
begin
   EXKeyWord:=0;
end;

procedure TRockGuid.FormDestroy(Sender: TObject);
begin
   if Assigned(MyFlowChart) then  FreeAndNil(MyFlowChart);

end;

procedure TRockGuid.FormResize(Sender: TObject);
begin
   Image1.Height :=RightPanel.Height ;
   Zk_Image.Align:=alclient;
   Image1.Refresh ;
   Zk_Image.Refresh;
end;

procedure TRockGuid.FormShow(Sender: TObject);
begin
   MyFlowChart:=TMyFlowChart.Create(RightPanel);
   MyFlowChart.EXPaintid  :=Integer(Image1);
   MyFlowChart.ShowMotherPanel :=MainPanel;
   MyFlowChart.RijiMemo:=MemoRizhi;
   Image1.Canvas.Brush.Color :=clBtnFace;

   Gzm_GroupBox.Height :=trunc(Height/5 *2);
   DisplayWorkFaceAndZkInformation;
   MyFlowChart.CreateRootNode  ;
end;

procedure TRockGuid.MakeWindowsSingle(Single: integer);
begin
   if Single=0 then  begin
       BorderStyle:=BsSizeable;
       StatusBar1.Visible :=true;
       WindowState:= wsNormal;
   end else if Single=1 then  begin
       BorderStyle:=BsSizeable;
       StatusBar1.Visible :=False;
       WindowState:=wsMaximized;
   end;
   Show;
end;

procedure TRockGuid.MemoRizhiClick(Sender: TObject);
begin
   MemoRizhi.SetFocus;
end;

procedure TRockGuid.Pop_LeftAdd_GzmClick(Sender: TObject);
begin
    MainCForm.UserWin.CreateWorkFace(MainPanel.Handle,
                  '��ú��������Ϣά������',MainPanel.Width ,MainPanel.Height);
   SelectTime1.Enabled :=true;
   ControlState:=1;
end;

procedure TRockGuid.Pop_left_AddZkClick(Sender: TObject);
begin
   MainCForm.UserWin.CreateZkBasic(MainPanel.Handle,
                  '�����Ϣά������',MainPanel.Width ,MainPanel.Height);
   SelectTime1.Enabled :=true;
   ControlState:=1;
end;

procedure TRockGuid.Pop_Left_Change_GzmClick(Sender: TObject);
begin
    MainCForm.UserWin.CreateSelectedWorkFaceINFo(MainPanel.Handle,
             '������ѧģ�ͽ��й�����ѡ��',MainPanel.Width ,MainPanel.Height,0);
    SelectTime1.Enabled :=true;
    ControlState:=0;
end;

procedure TRockGuid.Pop_left_ZkYcClick(Sender: TObject);
begin
   MainCForm.UserWin.CreateZkDetail(MainPanel.Handle,
                  '�����Ϣά������',MainPanel.Width ,MainPanel.Height);
   SelectTime1.Enabled :=true;
   ControlState:=1;
end;

procedure TRockGuid.SelectTime1Timer(Sender: TObject);
{
  �Դ򿪵Ľ�����м���
}
begin
    //���ڹ�������Ϣά��
    if MainCForm.UserWin.GetWinFormIsExsit('WORKFACEINFO') then   exit;
    //������׻�����Ϣά��
    if MainCForm.UserWin.GetWinFormIsExsit('ZKBASIC') then   exit;
    //���������ϸ��Ϣά��
    if MainCForm.UserWin.GetWinFormIsExsit('DRILLDETAILINFO') then   exit;
    //���ڹ��������ѡ�����
    if MainCForm.UserWin.GetWinFormIsExsit('CALLMECHANICALMODEL') then   exit;
    if ControlState=1 then begin //֤������� ���°�ť
        MainCForm.UserWin.CreateSelectedWorkFaceINFo(MainPanel.Handle,
             '������ѧģ�ͽ��й�����ѡ��',MainPanel.Width ,MainPanel.Height,0);
        ControlState:=0;
        exit;
    end;
    if not MainCForm.UserWin.GetWinFormIsExsit('CALLMECHANICALMODEL')  then begin
       DisplayWorkFaceAndZkInformation;
       SelectTime1.Enabled :=False;
    end;


end;

procedure TRockGuid.Splitter1CanResize(Sender: TObject; var NewSize: Integer;
  var Accept: Boolean);
begin
     Zk_Image.Align :=alClient;
     DisplayWorkFaceAndZkInformation;
end;

procedure TRockGuid.WorkFaceSGMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pt:Tpoint;
begin
   if Button=mbRight then begin
      pt:= WorkFaceSG.ClientToScreen(Point(0,0));
      DispLeftPanel(pt.X+x,pt.Y +y);
   end;

end;

procedure TRockGuid.ZkYCSGMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pt:Tpoint;
begin
   if Button=mbRight then begin
      pt:= ZkYCSG.ClientToScreen(Point(0,0));
      DispLeftPanel(pt.X+x,pt.Y +y);
   end;


end;

procedure TRockGuid.Zk_ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pt:Tpoint;
begin
   if Button=mbRight then begin
      pt:= Zk_Image.ClientToScreen(Point(0,0));
      DispLeftPanel(pt.X+x,pt.Y +y);
   end;

end;

{ TMyLabel }

function TMyLabel.AddOneNode(caption: string; hg_BS,Kid: integer): TMyLabel;
{
  hg_BS : ͼ�θ߶ȵı���
  Kid���ⲿΨһ��ʾ
}
begin
   inc(NodeCount);
   setlength(Nodes,NodeCount);
      Nodes[NodeCount-1]:= TMyLabel.Create(nil);
      Nodes[NodeCount-1].Parent:=Parent;
      Nodes[NodeCount-1].Caption :=Caption;
      Nodes[NodeCount-1].Keyid :=Kid;
      Nodes[NodeCount-1].Top :=NextTop;
      Nodes[NodeCount-1].Layers := Layers+1;
      Nodes[NodeCount-1].Width :=Nextwidth;
      Nodes[NodeCount-1].Height :=NextHeigth*hg_BS;
      Nodes[NodeCount-1].LineHeigth:= LineHeigth;
      Nodes[NodeCount-1].Left :=Nextleft+(NodeCount-1)*2* Nextwidth;
      //
      Nodes[NodeCount-1].NextTop:=NextTop+NextHeigth*hg_BS+ LineHeigth;
      Nodes[NodeCount-1].NextLeft:=Nextleft;
      Nodes[NodeCount-1].NextWidth:= Nextwidth;
      Nodes[NodeCount-1].NextHeigth:= NextHeigth;
      //
      Nodes[NodeCount-1].OnClick :=Nodes[NodeCount-1].MYLabelOnClick;
      Nodes[NodeCount-1].EXPaintid := EXPaintid;
      Nodes[NodeCount-1].ShowMotherPanel := ShowMotherPanel;
      Nodes[NodeCount-1].RijiMemo := RijiMemo;
      Nodes[NodeCount-1].parentClass :=self;
   Result:= Nodes[NodeCount-1];
end;

procedure TMyLabel.ClearItems;
var
  i:integer;
begin
    for I := NodeCount-1 Downto 0 do
       if Assigned(Nodes[i]) then  FreeAndNil(Nodes[i]);

    setlength(Nodes,0);
    NodeCount:=0;

end;

constructor TMyLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Transparent :=False;
  Color :=clHighlight;
  Font.Color :=Clwhite;
  WordWrap:=true;
  Visible:=False;
  AutoSize:=False;
  Font.Size :=12;
  Font.Style:=[fsBold];
  ChlidDisplay:=False;
end;

destructor TMyLabel.Destroy;
begin
  ClearItems;
  inherited;
end;

procedure TMyLabel.DispLayChlidNode(Value: Boolean);
var
  i:integer;
  SStr:String;
begin
   if Value then  begin
      SStr:='   ---�ù��������С�'+IntTostr(NodeCount)+'����ܣ��ֱ�Ϊ��' ;
      for I := 0 to NodeCount-1 do begin
          SStr:=SStr+'('+IntTostr(i+1)+') '+ Nodes[i].Caption + '   ' ;
          DrawLine(Nodes[i],2,ClBlack);
          Nodes[i].Color :=clHighlight;
          Nodes[i].SetVisible(true);
          ChlidDisplay:=true;
      end;
      WriteRizhi(SStr);
   end else begin
      for I := 0 to NodeCount-1 do begin
          DrawLine(Nodes[i],2,clWhite);
          Nodes[i].SetVisible(False);
      end;
      ChlidDisplay:=False;
   end;

end;

procedure TMyLabel.DrawLine(NextLabel: TMyLabel;LineWidth:integer;LineColor:TColor);
var
   tt:string;
   Point1,Point2,Point3,Point4,Point5: TPoint;
   ArrowPoint1,ArrowPoint2,ArrowPoint3:TPoint;
   PCanvas:TCanvas;
 begin
     PCanvas:=TImage(EXPaintid).Canvas;
     PCanvas.Pen.Width :=LineWidth;
     PCanvas.Pen.Color:= LineColor;


     Point1.X:=Left+Width div 2;
     Point1.Y:=Top+ Height;
     Point2.X:=  Point1.X;
     Point2.Y:=  Point1.Y+ LineHeigth div 2;
     Point3.X:=  NextLabel.Left + NextLabel.Width div 2;
     Point3.Y:=  Point2.Y  ;

     Point4.X:=  Point3.X;
     Point4.Y:=NextLabel.Top;

     PCanvas.MoveTo(Point1.X,Point1.Y);
     PCanvas.LineTo(Point2.X,Point2.Y);
     PCanvas.LineTo(Point3.X,Point3.Y);
     PCanvas.LineTo(Point4.X,Point4.Y);
       //�����Ҫ����ͷ
     ArrowPoint2:=Point4;
     ArrowPoint1.X:=ArrowPoint2.X-4;
     ArrowPoint1.Y:=ArrowPoint2.Y-4;
     ArrowPoint3.X:=ArrowPoint2.X+4;
     ArrowPoint3.Y:=ArrowPoint1.Y;
        PCanvas.MoveTo(ArrowPoint1.X,ArrowPoint1.Y);
        PCanvas.LineTo(ArrowPoint2.X,ArrowPoint2.Y);
        PCanvas.LineTo(ArrowPoint3.X,ArrowPoint3.Y);
     TPaintBox(EXPaintid).Refresh;
end;

function TMyLabel.GetEHeigth: integer;
begin
    Result:=FHeigth;
end;

function TMyLabel.GetEWidth: integer;
begin
   Result:=FWidth;
end;

function TMyLabel.GetKeyid: integer;
begin
    Result:=FKeyid;
end;

function TMyLabel.GetLayers: integer;
begin
   Result:=FLayerCount;
end;

function TMyLabel.GetLineHeigth: integer;
begin
  Result:=FLineHeigth;
end;

function TMyLabel.GetSLeft: integer;
begin
  Result:=FLeft;
end;

function TMyLabel.GetSortid: integer;
begin
   Result:=FSortid;
end;

function TMyLabel.GetSTop: integer;
begin
  Result:=FTop;
end;

procedure TMyLabel.MYLabelOnClick(Sender: TObject);
var
  i,j:integer;
begin
  // �������� ��ʾ������
  if parentClass <> nil then
      for I := 0 to parentClass.NodeCount -1 do
         if (parentClass.Nodes[i].ChlidDisplay) and (parentClass.Nodes[i].Keyid <> Keyid)     then begin
             for j := 0 to parentClass.Nodes[i].NodeCount-1  do  begin
                parentClass.Nodes[i].DrawLine(parentClass.Nodes[i].Nodes[j],2,clWhite);
                parentClass.Nodes[i].Nodes[j].SetVisible(False);
             end;
             parentClass.Nodes[i].ChlidDisplay:=False;
         end else begin
             parentClass.Nodes[i].Color :=clHighlight;
         end;
   // �򿪵�ǰ �����
   if (not ChlidDisplay) and(NodeCount >0 ) then   begin
      WriteRizhi('&  ����ˡ�'+Caption+'�����̰�ť');
      DispLayChlidNode(true);
     // ChlidDisplay:=True;
   end else if NodeCount <1 then   begin
      Color :=clFuchsia;
      WriteRizhi('&  ����ˡ�'+Caption+'�����ܰ�ť�����ڲ���--'+Caption+'--���ܽ���...');
      OpenChildFrom(Keyid);
   end;
end;

procedure TMyLabel.OpenChildFrom(ClickId: integer);
var
  P_W,P_H:integer;
begin
   P_W:=ShowMotherPanel.Width;
   P_H:=ShowMotherPanel.Height;

   OpenSecondChlidForm(ClickId, P_W,P_H);
   OpenThirdChlidForm(ClickId, P_W,P_H);

end;

procedure TMyLabel.OpenContourForm(Handl:Thandle;Vis: boolean);
begin
     if (MainCForm.Call_RockPress.GetWinFormIsExsit('CONTOUR')) and (ContourOpen) then  begin
         if Vis then  begin
             MainCForm.Call_RockPress.SetOpenFormChangeParentPanel('CONTOUR',Handl);
         end;
     end else begin
          MainCForm.Call_RockPress.CreateRockPressGraph(Handl,
                               '��ɽѹ���ۺϷ�������',Width,Height,1);
          if not Vis then
               MainCForm.Call_RockPress.CloseRockPressTool ;

           ContourOpen:=true;
     end
end;

procedure TMyLabel.OpenSecondChlidForm(ClickId: integer;P_W,P_H:integer);
var
  MinD,MaxD:integer;
begin
    case ClickId of
        111: //  ='�ɳ��ϸ��Ҳ��˶������ƶ�';
            begin
                MainCForm.CallPStope.OpenEditPstope(ShowMotherPanel.Handle,
                        '�ϸ��Ҳ��˶����ɼ�����',P_W,P_H,4);

            end;
        112://�ɳ��ϸ��Ҳ��˶������ƶ�';
           begin

               MainCForm.CallPStope.OpenEditPstope(ShowMotherPanel.Handle,
                        '�ɳ���������������',P_W,P_H,2);

           end;

        113:   //SUPPERWEIGHT  �����濪�ɼ�����������
           begin
              if not MainCForm.CallPStope.GetWinFormIsExsit('SUPPERWEIGHT') then  begin
                 MainCForm.CallPStope.DispCalEavResult(ShowMotherPanel.Handle,'�ɳ����װ������չʾ',P_W,P_H,2);
              end;
           end;
        114://ú��Ƭ��ṹ����;
           begin
               MainCForm.CallPStope.OpenEditPstope(ShowMotherPanel.Handle,
                        'ú��Ƭ��ṹ����',P_W,P_H,3);

           end;
         {MainCForm.CallPStope.OpenFyyd(ShowMotherPanel.Handle, '�ɳ��ϸ��Ҳ��˶������ƶ�-�ۺϷ���',P_W,P_H,1);}

        121: //  ='�ɳ��ϸ��Ҳ��˶������ƶ�';
            begin
                if not MainCForm.CallPStope.GetWinFormIsExsit('FYYD') then begin
                     MainCForm.CallPStope.OpenFyyd(ShowMotherPanel.Handle, '�ɳ��ϸ��Ҳ��˶������ƶ�-�ۺϷ���',P_W,P_H,1);
                end;
            end;

       122: //
           begin
                if not MainCForm.CallPStope.GetWinFormIsExsit('DTFZ') then begin
                    MainCForm.CallPStope.OpenDTFZ(ShowMotherPanel.Handle,
                             '�ɳ��ɶ������˶�����ģ��',P_W,P_H,1);
                end;
           end;


        123: //  ='�ɳ��ϸ��Ҳ��˶������ƶ�';
            begin
                if not MainCForm.CallPStope.GetWinFormIsExsit('ZCYL') then begin
                      MainCForm.CallPStope.OpenZCYL(ShowMotherPanel.Handle,'�ɳ�֧��ѹ���ֲ���Χ��άչʾ',P_W,P_H,2);
                end;
            end;

         131:   //Һѹ֧���Ż�ѡ�����
          begin

              MainCForm.CallPStope.OpenEditPstope(ShowMotherPanel.Handle,
                        'Һѹ֧���Ż�ѡ�����',P_W,P_H,5);

          end;

        132:   //SUPPERWEIGHT  �����濪�ɼ�����������
          begin
              if not MainCForm.CallPStope.GetWinFormIsExsit('SUPPERWEIGHT') then  begin
                 MainCForm.CallPStope.DispCalEavResult(ShowMotherPanel.Handle,'Һѹ֧��ʮ��ṹ���Ż�ѡ��',P_W,P_H,3);
              end;
          end;

         141:  // '�������������ѹ����ͼ';
          begin //
               OpenContourForm(ShowMotherPanel.Handle,true);
          end;

          142:
          begin //
               OpenContourForm(ShowMotherPanel.Handle,False);
               MainCForm.Call_RockPress.OpenConTourChildForm('TONGJI',ShowMotherPanel.Handle,0,0) ;

          end;

          143: //  '��ѹ��ȷ�������';
         begin //
              MainCForm.Call_RockPress.GetMinAndMaxJinDao(MinD,MaxD);

              MainCForm.UserWin.CreateOpenWordFrom(ShowMotherPanel.Handle,
                               '�򿪿�ѹ�۲ⱨ��ҳ��',Width,Height,1);
              MainCForm.UserWin.GetMinAndMaxJinDao(MinD,MaxD);
              public_Basic.WriteMakeWordPercent(False,0);

         end;


    end;
end;

procedure TMyLabel.OpenThirdChlidForm(ClickId: integer;P_W,P_H:integer);
begin
//    case ClickId of
//
//         1211: //  ='�ɳ��ϸ��Ҳ��˶������ƶ� ������';
//            begin
//
//               MainCForm.CallPStope.OpenFyyd(ShowMotherPanel.Handle, '�ɳ��ϸ��Ҳ��˶������ƶ�-������',P_W,P_H,2);
//
//            end;
//         1212: //  ='�ɳ��ϸ��Ҳ��˶������ƶ� ���෨';
//            begin
//               MainCForm.CallPStope.OpenFyyd(ShowMotherPanel.Handle, '�ɳ��ϸ��Ҳ��˶������ƶ�-���෨',P_W,P_H,3);
//
//            end;
//         1213: //  ='�ɳ��ϸ��Ҳ��˶������ƶ� �ۺϷ���;
//            begin
//              MainCForm.CallPStope.OpenFyyd(ShowMotherPanel.Handle, '�ɳ��ϸ��Ҳ��˶������ƶ�-�ۺϷ���',P_W,P_H,1);
//            end;
//
//    end;
end;

procedure TMyLabel.SetEHeigth(Value: integer);
begin
   FHeigth:=Value;
end;

procedure TMyLabel.SetEWidth(Value: integer);
begin
  FWidth:=Value;
end;

procedure TMyLabel.SetKeyid(Value: integer);
begin
   FKeyid:=Value;
end;

procedure TMyLabel.SetLayers(Value: integer);
begin
  FLayerCount:=Value;
end;

procedure TMyLabel.SetLineHeigth(Value: integer);
begin
   FLineHeigth:=Value;
end;

procedure TMyLabel.SetPosition;
begin

end;

procedure TMyLabel.SetSLeft(Value: integer);
begin
   FLeft:=Value;
end;

procedure TMyLabel.SetSortid(Value: integer);
begin
  FSortid:=Value;
end;

procedure TMyLabel.SetSTop(Value: integer);
begin
   FTop:=Value;
end;

procedure TMyLabel.SetVisible(Value: Boolean);
begin
   Visible:=Value;
   if not Value then  begin
      DispLayChlidNode(False);
   end;
end;

procedure TMyLabel.WriteRizhi(Value: string);
var
  TStr:string;
begin
   TStr:=FormatDateTime('hh:MM:SS ZZZ',now());
   RijiMemo.Lines.Add(Value +'(Time:'+ TStr+')') ;
end;

{ TMyFlowChart }

constructor TMyFlowChart.Create(AOwner:TPanel);
begin
   parentPanel:=AOwner;
   parentWidth:=parentPanel.Width ;
   ParentHeigth:=parentPanel.Height;
   LeftBlank:= parentWidth div 10;
   RightBlank:=parentWidth div 10;
   VerticalCount:=10;
   VerticalHeigth:= ParentHeigth div 20;
   VerticalWidth:= (parentWidth-LeftBlank- RightBlank) div 7;
   HorizontalWidth:= parentWidth-LeftBlank- RightBlank;
   HorizontalHeigth:= VerticalHeigth div 2;
end;



procedure TMyFlowChart.CreateRootNode;
var
  Welcome:string;
begin
   Welcome:='&  ��ӭʹ��"�ɳ������˶�����ѹʵ�����ƽ̨"��' +
        'ƽ̨���������Ŀ�ɽ��ѧ���Ҳ����ר��������Ժʿ����Ϊ��������������Ժʿ�쵼�ļ����ŶӸ��ݶ�����о���'+
        '����ѧģ���ÿ��ӻ�����ʽչʾ������ͨ����Ϣ�����봫ͳ�ɿ���Ľ�ϣ������������ƽ�滯��' +
        '�û�ɬ��ʽͼ�λ����÷������Ƶ����ӻ��������Ѳɿ�֪ʶ����Ϊ���ø����һ�߲ɿ����ߴ�ģ��ʹ��' +
        '�����Ӧ�á�ʵ��ѹ���������ۡ������մ�Դ�ϵͳ�۵ĽǶ������ɽѹ���ľ��裬�Դ�������������ѧ˼��� '+
        '��ʵ��ѹ���������ۡ����뵽�ճ�ú��ȫ����֮�С�';

   //--------------
   FlowRoot:=TMyLabel.Create(nil);
   FlowRoot.Parent:=parentPanel;
   FlowRoot.Caption :='  �� ѹ �� �� �� �� ͼ';
   FlowRoot.Keyid :=-1;
   FlowRoot.Color :=clHighlight;
   FlowRoot.Layers:=1;
   FlowRoot.Width:=  HorizontalWidth;
   FlowRoot.Height:=  HorizontalHeigth;
   FlowRoot.Top := (VerticalHeigth div 2);
   FlowRoot.Font.Size :=10;
   FlowRoot.Font.Style:=[fsBold];
   FlowRoot.Font.Color :=Clwhite;
   FlowRoot.Left := LeftBlank;
   FlowRoot.NextTop:=VerticalHeigth*3;
   FlowRoot.NextLeft:=LeftBlank;
   FlowRoot.NextWidth :=VerticalWidth;
   FlowRoot.NextHeigth := VerticalHeigth;
   FlowRoot.LineHeigth:=VerticalHeigth;
   FlowRoot.EXPaintid :=EXPaintid;
   FlowRoot.parentClass:=Nil;
   FlowRoot.ShowMotherPanel:= ShowMotherPanel;
   FlowRoot.RijiMemo := RijiMemo;
   // ��ʾ����
   RijiMemo.Clear ;
   RijiMemo.Lines.Add(Welcome +'(ϵͳ����:'+ FormatDateTime('YYYY-MM-DD',now())+')');
   FlowRoot.SetVisible(true);
   // ������һ��
   CreatFirstNodes(FlowRoot);
   // ��������
   FlowRoot.DispLayChlidNode(true);
  // FlowRoot.ChlidDisplay:=True;
end;



procedure TMyFlowChart.CreateThreeNode(Node: TMyLabel; Sortid: integer);
var
  temp: TMyLabel;
   Hi_BS:integer;
begin
   if Sortid=121 then  begin   // �ϸ��Ҳ�ṹ����
     Hi_BS:=4;
     temp:=Node.AddOneNode('������ȷ�����ҽṹ',Hi_BS,1211);

     temp:=Node.AddOneNode('���෨ȷ�����ҽṹ',Hi_BS,1212);

     temp:=Node.AddOneNode('�����㷨�ۺϿ��ǽṹ',Hi_BS,1213);



   
   end;


end;

procedure TMyFlowChart.CreatFirstNodes(Node:TMyLabel);
var
  temp: TMyLabel;
begin
   temp:=Node.AddOneNode('��ѧģ�ͷ���',3,10);
     CreatSecondNode(temp,1);
   temp:=Node.AddOneNode('�ɶ�ģ�����',3,20);
     CreatSecondNode(temp,2);
     temp.DispLayChlidNode(true);
   temp:=Node.AddOneNode('��ȫ�������',3,30);
     CreatSecondNode(temp,3);
   temp:=Node.AddOneNode('��������ھ�',3,40);
     CreatSecondNode(temp,4);
end;

procedure TMyFlowChart.CreatSecondNode(Node: TMyLabel; Sortid: integer);
var
  temp: TMyLabel;
  Hi_BS:integer;
begin
   if Sortid=1 then  begin   // ��ѧģ�ͷ���
     Hi_BS:=4;
     temp:=Node.AddOneNode('�����˶����ɷ���',Hi_BS,111);

     temp:=Node.AddOneNode('֧��ѹ���ֲ�����',Hi_BS,112);

     temp:=Node.AddOneNode('�����涥�װ����',Hi_BS,113);

     temp:=Node.AddOneNode('ú��Ƭ����ѧ����',Hi_BS,114);


   end else if Sortid=2 then  begin   // ��ѧģ�ͷ���
     Hi_BS:=4;
     temp:=Node.AddOneNode('�����˶����ӻ�',Hi_BS,121);

     temp:=Node.AddOneNode('�ϸ��Ҳ�ɶ�����',Hi_BS,122);

     temp:=Node.AddOneNode('֧��ѹ����άչʾ',Hi_BS,123);


   end else if Sortid=3 then  begin   // ��ѧģ�ͷ���
     Hi_BS:=5;
     temp:=Node.AddOneNode('Һѹ֧�ܲ����Ż����',Hi_BS,131);

     temp:=Node.AddOneNode('Һѹ֧����Ҫ�ṹ���Ż�',Hi_BS,132);

     temp:=Node.AddOneNode('���֧����ȫ�������',Hi_BS,133);

     temp:=Node.AddOneNode('�ر����ݰ�ȫ�������',Hi_BS,134);
   end else if Sortid=4 then  begin   // ��ѧģ�ͷ���
     Hi_BS:=5;
     temp:=Node.AddOneNode('ʵ�����ݿ�ѹ�������ܷ���',Hi_BS,141);

     temp:=Node.AddOneNode('����ͳ��ѧ�Ŀ�ѹ���ݷ���',Hi_BS,142);

     temp:=Node.AddOneNode('�Զ���ѹ��ȷ�������',Hi_BS,143);
   end;


end;

destructor TMyFlowChart.Destroy;
begin
  if Assigned(FlowRoot) then   FreeAndNil(FlowRoot);


  inherited;
end;



end.