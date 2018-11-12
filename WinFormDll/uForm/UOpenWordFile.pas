unit UOpenWordFile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, Vcl.ExtCtrls,Winapi.ShellAPI,
  Vcl.StdCtrls, System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin;

type
  TFromOpenFile = class(TForm)
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    AddButton: TToolButton;
    DeleteButton: TToolButton;
    ExitButton: TToolButton;
    ImageList1: TImageList;
    ListBox1: TListBox;
    Splitter1: TSplitter;
    WebBrowser1: TWebBrowser;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
  private
    { Private declarations }
    ShowScreen:integer;
    workfaceBh,DirName:string;
    procedure SelectFile(GzmbH:string;List:TListBox);
    procedure SetFromWidthAndHeigth(flag:integer);
    procedure FromSaveToBmp(pic_path:string);
    function OpenWordFile(pic_path:string):Boolean;
  public
    { Public declarations }
     ExMinDao,ExMaxDao:integer;
     procedure OptionTip(index:integer;Str:String);
  end;

var
  FromOpenFile: TFromOpenFile;
  function CreateOpenWord(AHandle:THandle;ACaption:string;Wid,Hi,Flag:integer):integer;stdcall;

implementation

{$R *.dfm}

uses Lu_Public_BasicModual, UMainDataModule;
//-------------------------------
function CreateOpenWord(AHandle:THandle;ACaption:string;Wid,Hi,Flag:integer):integer;stdcall;
begin
     if Assigned(FromOpenFile) then  FreeAndNil(FromOpenFile);

       FromOpenFile:=TFromOpenFile.Create(nil);
        try
          with FromOpenFile do begin
               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

                Show;
                SetFromWidthAndHeigth(Flag);
                SetFocus;
                Result:=1;//函数值
          end ;
        except
           FreeAndNil(FromOpenFile);
        end;
end;



//------------------------

procedure TFromOpenFile.AddButtonClick(Sender: TObject);
begin
   ShellExecute(0, 'Open', 'ReportWord.exe',
                   PChar(IntTostr(ExMinDao)+'_'+IntTostr(ExMaxDao)),'', SW_SHOW);
end;

procedure TFromOpenFile.DeleteButtonClick(Sender: TObject);
var
  t_File:string;
begin
    if ListBox1.ItemIndex>=0 then begin
      t_File:=DirName+''+ListBox1.Items[ListBox1.ItemIndex];
      if  FileExists(t_File) then
         SetFileAttributes(PChar(t_File),FILE_ATTRIBUTE_ARCHIVE);
         DeleteFile(t_File);
         SelectFile(workFaceBh,ListBox1);
         DeleteButton.Enabled :=False;
         WebBrowser1.Navigate('');
          OptionTip(1,'文件删除成功！');

    end;
end;

procedure TFromOpenFile.ExitButtonClick(Sender: TObject);
begin
    CLose;
end;

procedure TFromOpenFile.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
 var

  pic_Path:string;

begin
     Pic_Path  :=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\OneCoal'+'_10_1.BMP';
     FromSaveToBmp(Pic_Path);
   {关闭窗体，还得需要发出Close命令}
    if Assigned(FromOpenFile) then  FreeAndNil(FromOpenFile);


end;

procedure TFromOpenFile.FormCreate(Sender: TObject);
begin
   WebBrowser1.Align :=alClient;
   MainDataModule.ReadPublicUsedMkInfoFromFile;
   workFaceBh:=MainDataModule.WorkFace_id;
   // 加载 Word文档
   SelectFile(workFaceBh,ListBox1);
    ExMinDao:=0;
    ExMaxDao:=0;
end;

procedure TFromOpenFile.FormShow(Sender: TObject);
var
  State:Boolean;
  Percent:integer;
begin
   Public_basic.InitStatusBar(StatusBar1);
   //读取 word文档制作
   State:=public_Basic.ReadMakeWordPercent(Percent) ;
   if State then    begin
      addButton.Enabled :=False;
   end else begin
      addButton.Enabled :=true;
   end;
end;

procedure TFromOpenFile.FromSaveToBmp(pic_path: string);
var
    BitRect: TRect;
    Bitmap: TBitmap;
    FScreenCanvas: TCanvas;
begin
      Bitmap := TBitmap.Create;
   try
      Bitmap.SetSize(Self.ClientWidth, Self.ClientHeight);
      BitRect.Left := 0;
      BitRect.Top := 0;
      BitRect.Right := BitRect.Left + Bitmap.Width;
      BitRect.Bottom := BitRect.Top + Bitmap.Height;
      FScreenCanvas := TCanvas.Create;
      FScreenCanvas.Handle := Self.Canvas.Handle;
      Bitmap.Canvas.Lock;
      Bitmap.Canvas.CopyRect(BitRect, FScreenCanvas, Self.ClientRect);
      Bitmap.Canvas.Unlock;
      Bitmap.SaveToFile(pic_path);
   finally
     Bitmap.Free;
   end;

end;

procedure TFromOpenFile.ListBox1DblClick(Sender: TObject);
begin
   if ListBox1.ItemIndex>=0 then  begin
      OpenWordFile(DirName+''+ListBox1.Items[ListBox1.ItemIndex]);
      DeleteButton.Enabled :=true;
   end;
   if DirName<>''  then
      OptionTip(1,'请到'+DirName + '查找文件');

end;

function TFromOpenFile.OpenWordFile(pic_path: string): Boolean;
begin
    Webbrowser1.navigate('about:blank');
    Webbrowser1.Silent:=true;
     if  FileExists(pic_path) then
         Webbrowser1.navigate(pic_path);
end;

procedure TFromOpenFile.OptionTip(index: integer; Str: String);
begin
   StatusBar1.Panels[index].Text :=str;
end;

procedure TFromOpenFile.SelectFile(GzmbH: string; List: TListBox);
var
  SearchRec: TSearchRec;
  found: integer;
  Dll_Path:AnsiString;
  s1,stemp:Str_DT_array;
  C1:integer;
begin
   Dll_Path:=Public_Basic.Get_MyModulePath;
   DirName:=DLL_path+'SaveBmp\KYJG\';

  found := FindFirst(DirName + '\' + '*.mht', faAnyFile, SearchRec);
  List.Clear ;
  while found = 0 do   begin
    if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') and
      (SearchRec.Attr <> faDirectory) then  begin
        s1:=Public_Basic.split(SearchRec.Name,'.',C1);
        if C1>=1 then  begin
          stemp:=Public_Basic.split(S1[0],'_',C1);
          if C1>=1 then
            if Uppercase(stemp[0])=Uppercase('Report') then
               if  (stemp[1]= GzmbH )   then
               List.Items.Add(SearchRec.Name);
            //DirName+'\'+SearchRec.Name

        end;
      end;

      found := FindNext(SearchRec);
  end;

  FindClose(SearchRec);

end;

procedure TFromOpenFile.SetFromWidthAndHeigth(flag: integer);
begin
   if Flag=1  then  begin
       WindowState:= wsNormal;
       ShowScreen:=1;
       Show;
   end else begin
       ShowScreen:=0;
       WindowState:= wsMaximized;
       Show;
   end;
end;

end.
