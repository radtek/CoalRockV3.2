unit UFormEditWordFile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Menus,UMainDataModule, System.ImageList, Vcl.ImgList;

type
  TFormFileEdit = class(TForm)
    Panel1: TPanel;
    RichEdit1: TRichEdit;
    Title_Panel: TPanel;
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    GroupBox2: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    Pop_RichEdit: TPopupMenu;
    Pop_clear: TMenuItem;
    N2: TMenuItem;
    Pop_paste: TMenuItem;
    N4: TMenuItem;
    Pop_Save: TMenuItem;
    ImageList1: TImageList;
    N6: TMenuItem;
    Pop_Delete: TMenuItem;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure RichEdit1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Pop_clearClick(Sender: TObject);
    procedure Pop_pasteClick(Sender: TObject);
    procedure Pop_SaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ListBox1Click(Sender: TObject);
    procedure Pop_DeleteClick(Sender: TObject);

  private
    { Private declarations }
    FileType:String;
    WorkFaceId:integer;
    workFaceName:String;
    FileNumber:integer;
    RDButton : Array [0..5] of TRadioButton;
    procedure InitForm;
    procedure  RedioBoxClick(Sender:TObject);
    procedure DispRichEditPop(Px,Py:Integer);//显示RichEdit 控制的工具栏
    procedure OptionTip(Str:String);
    procedure ReadDataFromDataBase(List:TListbox);
    procedure ReadDataFromFileName(List:TListbox);
    function  RetrunFileTypeName(Value:integer):String;
    function  Searchfile(List:TListBox;path,FileTail: string): Boolean;
    procedure setRadioButtonSelected(Value:integer);
    procedure RichEditLineSpacing( //设置编辑框的行距
              mRichEdit: TRichEdit; //Rich编辑框
              mLineSpacingRule: Byte //行距 0~2
              );
  public

    { Public declarations }
    procedure SetWorkFaceInfo(id:integer;WName:string);
    procedure ReadFileNameFillListBox;
  end;

  function CreateWorkFaceFileName(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;stdcall;

var
  FormFileEdit: TFormFileEdit;

implementation

{$R *.dfm}

uses Lu_Public_BasicModual,RichEdit;

function CreateWorkFaceFileName(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;stdcall;
 begin
        if Assigned(FormFileEdit) then  FreeAndNil(FormFileEdit);
        Application.Handle :=AHandle;
        FormFileEdit:=TFormFileEdit.Create(nil);
        try
           with FormFileEdit do begin
               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

                Show;
                SetFocus;
                Result:=FormFileEdit.Handle;//函数值
          end ;
        except
          FreeAndNil(FormFileEdit);
        end;

end;

{ TForm2 }

procedure TFormFileEdit.DispRichEditPop(Px, Py: Integer);
begin
    Pop_RichEdit.Popup(px,py);
end;

procedure TFormFileEdit.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if Assigned(FormFileEdit) then
         FreeAndNil(FormFileEdit);
end;

procedure TFormFileEdit.FormCreate(Sender: TObject);
begin
      WorkFaceId:=0;
      FileNumber:=0;
end;

procedure TFormFileEdit.FormShow(Sender: TObject);
begin
   PubLic_Basic.InitStatusBar(self.StatusBar1);
   initForm;
end;

procedure TFormFileEdit.InitForm;
var
  i:integer;
begin
    FileType:='GZMBASIC';
    RDButton[0]:= RadioButton1;    RDButton[1]:= RadioButton2;RDButton[2]:= RadioButton3;
    RDButton[3]:= RadioButton4;    RDButton[4]:= RadioButton5;RDButton[5]:= RadioButton6;

    for I := 0 to 5 do
       RDButton[i].OnClick :=RedioBoxClick;

    RichEdit1.Clear ;
    MainDataModule.ReadPublicUsedMkInfoFromFile;
    SetWorkFaceInfo(public_Basic.StrToInt_lu( MainDataModule.WorkFace_id) ,MainDataModule.WorkFace_Name);

end;



procedure TFormFileEdit.ListBox1Click(Sender: TObject);
var
  s_temp:Str_DT_array;
  C1:integer;
  sql:string;
begin
   s_temp:=Public_Basic.split(listBox1.items[listBox1.itemindex],'_',C1);
   if s_temp[0]='' then exit;
   FileNumber:=Public_Basic.StrToInt_lu(s_temp[0]) ;
   setRadioButtonSelected(FileNumber);

    MainDataModule.ReadRichTextFromDataBase(RichEdit1.Lines,fileType,'rtf',workfaceid,FileNumber,-1,-1);
end;

procedure TFormFileEdit.OptionTip(Str: String);
begin
   self.StatusBar1.Panels[0].Text :=str;
end;

procedure TFormFileEdit.Pop_clearClick(Sender: TObject);
begin
    RichEdit1.Clear ;
end;

procedure TFormFileEdit.Pop_DeleteClick(Sender: TObject);
var
 OutStr:string;
begin
  OutStr:='你确认要删除【'+RetrunFileTypeName(FileNumber)+'】资料吗？';
  if (WorkFaceId>0) and (FileNumber>0) then
    if Application.MessageBox(pchar(OutStr), '提示', MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDYES then
         if  MainDataModule.DeleteRichTextFile(RichEdit1.Lines,Filetype,'rtf',WorkFaceId,FileNumber,-1,-1)  then   begin
          OptionTip('数据删除成功！');
          ReadFileNameFillListBox;
          Richedit1.Clear ;
        end;
end;

procedure TFormFileEdit.Pop_pasteClick(Sender: TObject);
begin
   Richedit1.PasteFromClipboard;
end;

procedure TFormFileEdit.Pop_SaveClick(Sender: TObject);
var
 OutStr:string;
begin
  OutStr:='你确认是对【'+RetrunFileTypeName(FileNumber)+'】进行资料补录吗？';
  if FileNumber=101 then  begin
     RichEdit1.SelectAll ;
     RichEditLineSpacing(RichEdit1,0);
     RichEdit1.SelAttributes.Size :=9;
  end else begin
     RichEdit1.SelectAll ;
     RichEditLineSpacing(RichEdit1,1);
     RichEdit1.SelAttributes.Size :=12;
  end;

  if (WorkFaceId>0) and (FileNumber>0) then
    if Application.MessageBox(pchar(OutStr), '提示', MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDYES then
         if  MainDataModule.RichTextSaveToDataBase(RichEdit1.Lines,Filetype,'rtf',WorkFaceId,FileNumber,-1,-1)  then   begin
          OptionTip('数据保存成功！');
          ReadFileNameFillListBox;
        end;
end;

procedure TFormFileEdit.ReadDataFromDataBase(List: TListbox);
var
  Mydataet:TMyDataSet;
  itag:integer;
  sql,temp:string;
begin
   Mydataet:=TMyDataSet.Create(nil);
   Mydataet.MySqlConnection :=MainDataModule.ExConn;
   List.Clear ;
   try
      Mydataet.Close ;
       Sql:=' select  Num_bh  from FileDataBase where FileType ='''+ FileType+'''  and WorkFaceid='  +
          IntToStr(WorkFaceId)  ;
      Mydataet.CommandText :=sql;
      Mydataet.Open ;
      while not Mydataet.Eof  do   begin
        itag:=Mydataet.FieldByName('Num_bh').AsInteger;
        List.Items.Add(IntTostr(itag)+'_'+ RetrunFileTypeName(itag));
        Mydataet.Next ;
      end;
   finally
      Mydataet.Close ;
      FreeAndNil(Mydataet);
   end;

end;

procedure TFormFileEdit.ReadDataFromFileName(List: TListbox);
var
  fileName,textString:Ansistring;
  DirName:Ansistring;
  Dll_Path:AnsiString;

begin
   Dll_Path:=Public_Basic.Get_MyModulePath;
   DirName:=DLL_path+'\InputData\WorkDace_'+IntTostr(WorkFaceId);
   Searchfile(List,DirName,'rtf' );
end;

procedure TFormFileEdit.ReadFileNameFillListBox;
begin
    if  Uppercase(MainDataModule.DataType)='ACCESS'  then   begin
        ReadDataFromFileName(ListBox1);
    end else begin
        ReadDataFromDataBase(ListBox1);
    end;
end;



Procedure TFormFileEdit.RedioBoxClick(Sender: TObject);
begin
    FileNumber:= (sender as TRadioButton).Tag;
    RichEdit1.Clear;
end;

function TFormFileEdit.RetrunFileTypeName(Value: integer): String;
begin
    if value=101 then  begin
      Result:='工作面概述与地质说明书（表格）';
    end  else if value=102 then  begin
      Result:='顶底板岩层岩性组合结构分析';
    end else if value=103 then  begin
      Result:='地质结构说明';
    end else if value=201 then  begin
      Result:='正常支护方式';
    end else if value=202 then  begin
      Result:='特殊支护方式';
    end else if value=203 then  begin
      Result:='确定支护强度';
    end  else begin
      Result:='';
    end;



end;

procedure TFormFileEdit.RichEdit1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
 var
  pt:Tpoint;

begin

   if Button=mbRight then begin
      pt:= RichEdit1.ClientToScreen(Point(0,0));
      DispRichEditPop(pt.X+x,pt.Y +y);

   end;

end;

procedure TFormFileEdit.RichEditLineSpacing(mRichEdit: TRichEdit;
  mLineSpacingRule: Byte);
var
  vParaFormat2: ParaFormat2;
begin
  if not Assigned(mRichEdit) then Exit;
  FillChar(vParaFormat2, SizeOf(vParaFormat2), 0);
  vParaFormat2.cbSize := SizeOf(ParaFormat2);
  vParaFormat2.dwMask := PFM_LINESPACING;
  vParaFormat2.bLineSpacingRule := mLineSpacingRule;
  vParaFormat2.dyLineSpacing := Ord(True);
  mRichEdit.Perform(EM_SETPARAFORMAT, 0, Longint(@vParaFormat2));
end;

function TFormFileEdit.Searchfile(List:TListBox;path,FileTail: string): Boolean;
var
  SearchRec: TSearchRec;
  found: integer;
  fileName:string;
  s_temp,s2:Str_DT_array;
  C1,filebh:integer;
begin

  Result := False;
  List.Clear ;
  found := FindFirst(path + '\' + '*.'+FileTail, faAnyFile, SearchRec);
  while found = 0 do   begin
    if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') and
      (SearchRec.Attr <> faDirectory) then  begin
       fileName:=ExtractFileName(SearchRec.Name) ;
       s_temp:=Public_Basic.split(fileName,'_',C1);
       if UpperCase(S_Temp[0])=FileType  then begin
           s2:=Public_Basic.split(s_temp[1],'.',C1);
           filebh:= Public_Basic.StrToInt_lu(s2[0]);
           if filebh >100  then
            List.Items.Add(intToStr(filebh)+'_'+RetrunFileTypeName(filebh)) ;
       end;
      end;
      found := FindNext(SearchRec);
      Result:=True;
  end;
  FindClose(SearchRec);

end;

procedure TFormFileEdit.setRadioButtonSelected(Value: integer);
var
  i:integer;
 begin
     for I := 0 to 5 do
        if  RDButton[i].Tag =value then  begin
            RDButton[i].Checked :=true;
        end else  begin
            RDButton[i].Checked :=False;
        end;

end;

procedure TFormFileEdit.SetWorkFaceInfo(id: integer; WName: string);
begin
    WorkFaceId:=id;
    workFaceName:= WName;
    Title_Panel.Caption :='现在正在对【'+workFaceName+'】相关资料进行补录'  ;
    ReadFileNameFillListBox;
end;

end.
