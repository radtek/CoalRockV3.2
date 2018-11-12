unit CADImage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList, Vcl.Menus,
  ControlGraph
  ;

type
  TCADBMP = class(TForm)
    MainMenu1: TMainMenu;
    miFile: TMenuItem;
    miNew: TMenuItem;
    miOpen: TMenuItem;
    miSave: TMenuItem;
    miSaveY: TMenuItem;
    miSaveZ: TMenuItem;
    N1: TMenuItem;
    loadSL: TMenuItem;
    loadBmp: TMenuItem;
    loadJpeg: TMenuItem;
    N2: TMenuItem;
    miTransportSL: TMenuItem;
    miTransportBmp: TMenuItem;
    miTransportJpeg: TMenuItem;
    N3: TMenuItem;
    miExit: TMenuItem;
    V1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    D1: TMenuItem;
    L1: TMenuItem;
    R1: TMenuItem;
    E1: TMenuItem;
    C1: TMenuItem;
    N8: TMenuItem;
    F1: TMenuItem;
    I1: TMenuItem;
    H1: TMenuItem;
    A1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ImageList1: TImageList;
    StatusBar1: TStatusBar;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    CoolBar1: TCoolBar;
    ToolBar4: TToolBar;
    But_New: TToolButton;
    But_Open: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    But_line: TToolButton;
    But_Rect: TToolButton;
    But_Ellip: TToolButton;
    But_Circle: TToolButton;
    But_Fill: TToolButton;
    But_Move: TToolButton;
    but_Delete: TToolButton;
    But_Clear: TToolButton;
    ToolButton18: TToolButton;
    ColorBox1: TColorBox;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure But_lineClick(Sender: TObject);
    procedure But_RectClick(Sender: TObject);
    procedure But_EllipClick(Sender: TObject);
    procedure But_CircleClick(Sender: TObject);
    procedure But_FillClick(Sender: TObject);
    procedure But_MoveClick(Sender: TObject);
    procedure but_DeleteClick(Sender: TObject);
    procedure But_ClearClick(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
     MyCAD:TControlImage;
     procedure RefreshWin;
     procedure UpdateStatusBar;
  public
    { Public declarations }
  end;

var
    unCadUse: TCADBMP;
function CreateCADImage_Inn(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;
          stdcall;


implementation

{$R *.dfm}
//内部初始化函数
function CreateCADImage_Inn(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;
begin
       if Assigned(unCadUse) then  FreeAndNil(unCadUse);
        APPlication.Handle :=AHandle;
        unCadUse:=TCADBMP.Create(nil);
        try
          with unCadUse do begin
               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

                Show;
                SetFocus;
                Result:=unCadUse.Handle ;  //函数值
          end ;
        except
         FreeAndNil(unCadUse);
        end;

end;
procedure TCADBMP.But_CircleClick(Sender: TObject);
begin
    MyCAD.SetDrawCircle;
   UpdateStatusBar;
end;

procedure TCADBMP.But_ClearClick(Sender: TObject);
begin
   MyCAD.SetImageClear;
   UpdateStatusBar;
end;

procedure TCADBMP.but_DeleteClick(Sender: TObject);
begin
   MyCAD.SetImageDelete;
   UpdateStatusBar;
end;

procedure TCADBMP.But_EllipClick(Sender: TObject);
begin
    MyCAD.SetDrawEllips;
   UpdateStatusBar;
end;

procedure TCADBMP.But_FillClick(Sender: TObject);
begin
    MyCAD.SetFillImage;
   UpdateStatusBar;
end;

procedure TCADBMP.But_lineClick(Sender: TObject);
begin
   MyCAD.SetDrawLine;
   UpdateStatusBar;
end;

procedure TCADBMP.But_MoveClick(Sender: TObject);
begin
   MyCAD.SetImageMove;
   UpdateStatusBar;
end;

procedure TCADBMP.But_RectClick(Sender: TObject);
begin
   MyCAD.SetDrawRectang;
   UpdateStatusBar;
end;

procedure TCADBMP.FormClick(Sender: TObject);
begin
    self.SetFocus;
end;

procedure TCADBMP.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if assigned(unCadUse) then FreeANdNil(unCadUse);

end;

procedure TCADBMP.FormCreate(Sender: TObject);
begin
   MyCAD:=TControlImage.Create ;
   MyCAD.SetImage(Image1);
   MyCAD.SetMyColorBox(ColorBox1);
   MyCAD.InitDrawGraph;
   UpdateStatusBar; //刷新 显示
end;

procedure TCADBMP.FormDestroy(Sender: TObject);
begin
   FreeandNil(MyCAD);
end;

procedure TCADBMP.FormResize(Sender: TObject);
begin
    RefreshWin;
end;

procedure TCADBMP.Image1Click(Sender: TObject);
begin
   // Image1.Parent.SetFocus ;
end;

procedure TCADBMP.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    StatusBar1.Panels[1].Text:='坐标  ( '+intToStr(x)+' , '+intToStr(image1.Height-y)+' )';
end;

procedure TCADBMP.RefreshWin;
begin
  //  ScrollBox1.Align :=alClient;
  //  Image1.Align:=alClient;
    self.StatusBar1.Panels[0].Width :=self.Width  div 3;
    self.StatusBar1.Panels[1].Width :=self.Width  div 3;
end;

procedure TCADBMP.UpdateStatusBar;
begin
     StatusBar1.Panels[0].Text:=MyCAd.GetOutStr;
end;

end. //end unit
